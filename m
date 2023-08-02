Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73A676D122
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjHBPMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjHBPMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:12:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCF5E210D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:12:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99811113E;
        Wed,  2 Aug 2023 08:12:50 -0700 (PDT)
Received: from [10.57.77.90] (unknown [10.57.77.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECCFC3F5A1;
        Wed,  2 Aug 2023 08:12:05 -0700 (PDT)
Message-ID: <7c7b8c39-b412-a120-368c-ba4ab2cc2a15@arm.com>
Date:   Wed, 2 Aug 2023 16:12:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] mm: add functions folio_in_range() and
 folio_within_vma()
To:     "Yin, Fengwei" <fengwei.yin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        yuzhao@google.com, willy@infradead.org, david@redhat.com,
        shy828301@gmail.com, hughd@google.com
References: <20230728070929.2487065-1-fengwei.yin@intel.com>
 <20230728070929.2487065-2-fengwei.yin@intel.com>
 <55c9e3f7-099d-6f57-32da-1f318a9688a0@arm.com>
 <9bba9369-e3f5-53da-bf8f-8ab887d3c3ae@arm.com>
 <a6ff77ba-18f7-f3ed-3f9a-00f04edccdb3@intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <a6ff77ba-18f7-f3ed-3f9a-00f04edccdb3@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I also wonder if you should change the name of folio_within_vma() to something
>> like folio_test_cont_in_vma() to disambiguate from the case where the folio may
>> be fully mapped with a discontiguity (although perhaps that's not possible
>> because a mremap would result in distinct vmas... would a new mmap in the hole
>> cause a merge of all 3?).
> I don't think it's possible as mremap reuse original pgoff of VMA to new VMA. I suppose
> it will prevent VMA merging. But I didn't check detail.

pgoff is not relevant for anon though, right?

FWIW, I wrote a test to check if merging is performed. Interestingly, v5.4 (on x86) *does* merge the VMAs in this case, but v6.5-rc3 (on arm64) *does not* merge the VMAs in this case.

I think you should assume it might be possible in some cases.


#define _GNU_SOURCE
#include <stdlib.h>
#include <stdio.h>
#include <sys/mman.h>
#include <unistd.h>

int main(int argc, char **argv)
{
	size_t pgsize = getpagesize();
	char *memarea;
	char *memlow;
	char *memmid;
	char *memhigh;
	int ret = 0;

	// Get a free vm area big enough for 5 pages.
	memarea = mmap(NULL, pgsize * 5,
			PROT_NONE,
			MAP_PRIVATE | MAP_ANONYMOUS,
			-1, 0);
	if (memarea == MAP_FAILED) {
		perror("mmap 1");
		exit(1);
	}

	// Map 2 pages one page into allocated area.
	memlow = mmap(memarea + pgsize, pgsize * 2,
			PROT_READ | PROT_WRITE,
			MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS,
			-1, 0);
	if (memlow == MAP_FAILED) {
		perror("mmap 2");
		exit(1);
	}

	// Move the second allocated page one page higher.
	memhigh = mremap(memarea + pgsize * 2, pgsize, pgsize,
			MREMAP_FIXED | MREMAP_MAYMOVE,
			memarea + pgsize * 3);
	if (memhigh == MAP_FAILED) {
		perror("mremap");
		exit(1);
	}

	// We should now have:
	// | page 0 | page 1 | page 2 | page 3 | page 4 |
	// | NONE   | vma 1  | empty  | vma 2  | NONE   |
	printf("Check for 2 vmas with hole: pid=%d, memarea=%p, memlow=%p, memhigh=%p\n",
		getpid(), memarea, memlow, memhigh);
	getchar();

	// Now map a page in the empty space.
	memmid = mmap(memarea + pgsize * 2, pgsize,
			PROT_READ | PROT_WRITE,
			MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS,
			-1, 0);
	if (memmid == MAP_FAILED) {
		perror("mmap 2");
		exit(1);
	}

	// We should now have:
	// | page 0 | page 1 | page 2 | page 3 | page 4 |
	// | NONE   |          vma 1           | NONE   |
	printf("Check for single merged vma: pid=%d, memarea=%p, memlow=%p, memmid=%p, memhigh=%p\n",
		getpid(), memarea, memlow, memmid, memhigh);
	getchar();

	return ret;
}



Output on v5.4:

Check for 2 vmas with hole: pid=171038, memarea=0x7fe6c34d9000, memlow=0x7fe6c34da000, memhigh=0x7fe6c34dc000
Check for single merged vma: pid=171038, memarea=0x7fe6c34d9000, memlow=0x7fe6c34da000, memmid=0x7fe6c34db000, memhigh=0x7fe6c34dc000

And maps output at the 2 check points:

(base) ryarob01@e125769:/data_nvme0n1/ryarob01/granule_perf$ cat /proc/171038/maps
55e55c258000-55e55c259000 r--p 00000000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
55e55c259000-55e55c25a000 r-xp 00001000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
55e55c25a000-55e55c25b000 r--p 00002000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
55e55c25b000-55e55c25c000 r--p 00002000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
55e55c25c000-55e55c25d000 rw-p 00003000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
55e55c403000-55e55c424000 rw-p 00000000 00:00 0                          [heap]
7fe6c32d2000-7fe6c32f4000 r--p 00000000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
7fe6c32f4000-7fe6c346c000 r-xp 00022000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
7fe6c346c000-7fe6c34ba000 r--p 0019a000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
7fe6c34ba000-7fe6c34be000 r--p 001e7000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
7fe6c34be000-7fe6c34c0000 rw-p 001eb000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
7fe6c34c0000-7fe6c34c6000 rw-p 00000000 00:00 0 
7fe6c34d9000-7fe6c34da000 ---p 00000000 00:00 0 
7fe6c34da000-7fe6c34db000 rw-p 00000000 00:00 0 
7fe6c34dc000-7fe6c34dd000 rw-p 00000000 00:00 0 
7fe6c34dd000-7fe6c34de000 ---p 00000000 00:00 0 
7fe6c34de000-7fe6c34df000 r--p 00000000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
7fe6c34df000-7fe6c3502000 r-xp 00001000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
7fe6c3502000-7fe6c350a000 r--p 00024000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
7fe6c350b000-7fe6c350c000 r--p 0002c000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
7fe6c350c000-7fe6c350d000 rw-p 0002d000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
7fe6c350d000-7fe6c350e000 rw-p 00000000 00:00 0 
7fff39a11000-7fff39a32000 rw-p 00000000 00:00 0                          [stack]
7fff39a83000-7fff39a86000 r--p 00000000 00:00 0                          [vvar]
7fff39a86000-7fff39a87000 r-xp 00000000 00:00 0                          [vdso]
ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]
(base) ryarob01@e125769:/data_nvme0n1/ryarob01/granule_perf$ cat /proc/171038/maps
55e55c258000-55e55c259000 r--p 00000000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
55e55c259000-55e55c25a000 r-xp 00001000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
55e55c25a000-55e55c25b000 r--p 00002000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
55e55c25b000-55e55c25c000 r--p 00002000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
55e55c25c000-55e55c25d000 rw-p 00003000 fd:00 5297466                    /data_nvme0n1/ryarob01/granule_perf/merge
55e55c403000-55e55c424000 rw-p 00000000 00:00 0                          [heap]
7fe6c32d2000-7fe6c32f4000 r--p 00000000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
7fe6c32f4000-7fe6c346c000 r-xp 00022000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
7fe6c346c000-7fe6c34ba000 r--p 0019a000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
7fe6c34ba000-7fe6c34be000 r--p 001e7000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
7fe6c34be000-7fe6c34c0000 rw-p 001eb000 fd:02 9573653                    /lib/x86_64-linux-gnu/libc-2.31.so
7fe6c34c0000-7fe6c34c6000 rw-p 00000000 00:00 0 
7fe6c34d9000-7fe6c34da000 ---p 00000000 00:00 0 
7fe6c34da000-7fe6c34dd000 rw-p 00000000 00:00 0 
7fe6c34dd000-7fe6c34de000 ---p 00000000 00:00 0 
7fe6c34de000-7fe6c34df000 r--p 00000000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
7fe6c34df000-7fe6c3502000 r-xp 00001000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
7fe6c3502000-7fe6c350a000 r--p 00024000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
7fe6c350b000-7fe6c350c000 r--p 0002c000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
7fe6c350c000-7fe6c350d000 rw-p 0002d000 fd:02 9573649                    /lib/x86_64-linux-gnu/ld-2.31.so
7fe6c350d000-7fe6c350e000 rw-p 00000000 00:00 0 
7fff39a11000-7fff39a32000 rw-p 00000000 00:00 0                          [stack]
7fff39a83000-7fff39a86000 r--p 00000000 00:00 0                          [vvar]
7fff39a86000-7fff39a87000 r-xp 00000000 00:00 0                          [vdso]
ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]


Output on v6.5-rc3:

Check for 2 vmas with hole: pid=3181, memarea=0xfffff7ff2000, memlow=0xfffff7ff3000, memhigh=0xfffff7ff5000
Check for single merged vma: pid=3181, memarea=0xfffff7ff2000, memlow=0xfffff7ff3000, memmid=0xfffff7ff4000, memhigh=0xfffff7ff5000

And maps output at the 2 check points:

ubuntu@ubuntuvm:~/linux$ cat /proc/3181/maps 
aaaaaaaa0000-aaaaaaaa1000 r-xp 00000000 fe:02 8199010                    /home/ubuntu/merge
aaaaaaab0000-aaaaaaab1000 r--p 00000000 fe:02 8199010                    /home/ubuntu/merge
aaaaaaab1000-aaaaaaab2000 rw-p 00001000 fe:02 8199010                    /home/ubuntu/merge
aaaaaaab2000-aaaaaaad3000 rw-p 00000000 00:00 0                          [heap]
fffff7e00000-fffff7f89000 r-xp 00000000 fe:02 41410085                   /usr/lib/aarch64-linux-gnu/libc.so.6
fffff7f89000-fffff7f98000 ---p 00189000 fe:02 41410085                   /usr/lib/aarch64-linux-gnu/libc.so.6
fffff7f98000-fffff7f9c000 r--p 00188000 fe:02 41410085                   /usr/lib/aarch64-linux-gnu/libc.so.6
fffff7f9c000-fffff7f9e000 rw-p 0018c000 fe:02 41410085                   /usr/lib/aarch64-linux-gnu/libc.so.6
fffff7f9e000-fffff7faa000 rw-p 00000000 00:00 0 
fffff7fc2000-fffff7fed000 r-xp 00000000 fe:02 41316494                   /usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
fffff7ff2000-fffff7ff3000 ---p 00000000 00:00 0 
fffff7ff3000-fffff7ff4000 rw-p 00000000 00:00 0 
fffff7ff5000-fffff7ff6000 rw-p 00000000 00:00 0 
fffff7ff6000-fffff7ff7000 ---p 00000000 00:00 0 
fffff7ff7000-fffff7ff9000 rw-p 00000000 00:00 0 
fffff7ff9000-fffff7ffb000 r--p 00000000 00:00 0                          [vvar]
fffff7ffb000-fffff7ffc000 r-xp 00000000 00:00 0                          [vdso]
fffff7ffc000-fffff7ffe000 r--p 0002a000 fe:02 41316494                   /usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
fffff7ffe000-fffff8000000 rw-p 0002c000 fe:02 41316494                   /usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
fffffffdf000-1000000000000 rw-p 00000000 00:00 0                         [stack]
ubuntu@ubuntuvm:~/linux$ cat /proc/3181/maps 
aaaaaaaa0000-aaaaaaaa1000 r-xp 00000000 fe:02 8199010                    /home/ubuntu/merge
aaaaaaab0000-aaaaaaab1000 r--p 00000000 fe:02 8199010                    /home/ubuntu/merge
aaaaaaab1000-aaaaaaab2000 rw-p 00001000 fe:02 8199010                    /home/ubuntu/merge
aaaaaaab2000-aaaaaaad3000 rw-p 00000000 00:00 0                          [heap]
fffff7e00000-fffff7f89000 r-xp 00000000 fe:02 41410085                   /usr/lib/aarch64-linux-gnu/libc.so.6
fffff7f89000-fffff7f98000 ---p 00189000 fe:02 41410085                   /usr/lib/aarch64-linux-gnu/libc.so.6
fffff7f98000-fffff7f9c000 r--p 00188000 fe:02 41410085                   /usr/lib/aarch64-linux-gnu/libc.so.6
fffff7f9c000-fffff7f9e000 rw-p 0018c000 fe:02 41410085                   /usr/lib/aarch64-linux-gnu/libc.so.6
fffff7f9e000-fffff7faa000 rw-p 00000000 00:00 0 
fffff7fc2000-fffff7fed000 r-xp 00000000 fe:02 41316494                   /usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
fffff7ff2000-fffff7ff3000 ---p 00000000 00:00 0 
fffff7ff3000-fffff7ff4000 rw-p 00000000 00:00 0 
fffff7ff4000-fffff7ff5000 rw-p 00000000 00:00 0 
fffff7ff5000-fffff7ff6000 rw-p 00000000 00:00 0 
fffff7ff6000-fffff7ff7000 ---p 00000000 00:00 0 
fffff7ff7000-fffff7ff9000 rw-p 00000000 00:00 0 
fffff7ff9000-fffff7ffb000 r--p 00000000 00:00 0                          [vvar]
fffff7ffb000-fffff7ffc000 r-xp 00000000 00:00 0                          [vdso]
fffff7ffc000-fffff7ffe000 r--p 0002a000 fe:02 41316494                   /usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
fffff7ffe000-fffff8000000 rw-p 0002c000 fe:02 41316494                   /usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
fffffffdf000-1000000000000 rw-p 00000000 00:00 0                         [stack]
