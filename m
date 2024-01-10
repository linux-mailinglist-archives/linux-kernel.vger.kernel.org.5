Return-Path: <linux-kernel+bounces-21756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1DB8293D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E507B288D55
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A2F364B4;
	Wed, 10 Jan 2024 06:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KLWaFI7I"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1EF32C6F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704869363;
	bh=2V7QIfYR4PnohCu6ycLOFlpwiGUhQxPbkGIUTGvPz3c=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=KLWaFI7I0eIL7BjoUgeOrwO5OQlLZUw4YIaWgnIWgp+PBEoP423cjIGDth3BUd12x
	 Y8pFly0+yiBqQBtUPE0st1BH0TPoZVQTVX0GNeHZHMrxBQC2vqLUslEuawdEjKhmoh
	 fRRiDC/jAf8J1ZH1qMeo1UQDnt7lmaYJTxU+Crl3IW13oZ93dGfS4XyO3r221u43u+
	 iPv/+RuTbjiG2AHoat1DN/v62VM03eWa8WuPYuqcm+muLkf+lnBC2ZSCTeMsX5Uh2T
	 avz4HATdChp1qq5iUjPPqf52pIXHrHXGVkBuJFe5wvz/oFRvwxhYC3CbzZK5One8/v
	 6cYtFz2eQacgg==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7F6663780C35;
	Wed, 10 Jan 2024 06:49:20 +0000 (UTC)
Message-ID: <e68488e4-764e-4b25-8a47-05bf8976bd19@collabora.com>
Date: Wed, 10 Jan 2024 11:49:26 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, linmiaohe@huawei.com,
 mike.kravetz@oracle.com, naoya.horiguchi@nec.com, akpm@linux-foundation.org,
 songmuchun@bytedance.com, shy828301@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, jthoughton@google.com,
 "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v4 4/4] selftests/mm: add tests for HWPOISON hugetlbfs
 read
Content-Language: en-US
To: Jiaqi Yan <jiaqiyan@google.com>
References: <20230713001833.3778937-1-jiaqiyan@google.com>
 <20230713001833.3778937-5-jiaqiyan@google.com>
 <be3976b5-0a9c-41c6-8160-88e6c1e5d63e@collabora.com>
 <CACw3F51WvZDVCpVg9j4j8WmnmAFOsnK+FZDDoVqhgLqVwhPTCA@mail.gmail.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CACw3F51WvZDVCpVg9j4j8WmnmAFOsnK+FZDDoVqhgLqVwhPTCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/6/24 2:13 AM, Jiaqi Yan wrote:
> On Thu, Jan 4, 2024 at 10:27 PM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> Hi,
>>
>> I'm trying to convert this test to TAP as I think the failures sometimes go
>> unnoticed on CI systems if we only depend on the return value of the
>> application. I've enabled the following configurations which aren't already
>> present in tools/testing/selftests/mm/config:
>> CONFIG_MEMORY_FAILURE=y
>> CONFIG_HWPOISON_INJECT=m
>>
>> I'll send a patch to add these configs later. Right now I'm trying to
>> investigate the failure when we are trying to inject the poison page by
>> madvise(MADV_HWPOISON). I'm getting device busy every single time. The test
>> fails as it doesn't expect any business for the hugetlb memory. I'm not
>> sure if the poison handling code has issues or test isn't robust enough.
>>
>> ./hugetlb-read-hwpoison
>> Write/read chunk size=0x800
>>  ... HugeTLB read regression test...
>>  ...  ... expect to read 0x200000 bytes of data in total
>>  ...  ... actually read 0x200000 bytes of data in total
>>  ... HugeTLB read regression test...TEST_PASSED
>>  ... HugeTLB read HWPOISON test...
>> [    9.280854] Injecting memory failure for pfn 0x102f01 at process virtual
>> address 0x7f28ec101000
>> [    9.282029] Memory failure: 0x102f01: huge page still referenced by 511
>> users
>> [    9.282987] Memory failure: 0x102f01: recovery action for huge page: Failed
>>  ...  !!! MADV_HWPOISON failed: Device or resource busy
>>  ... HugeTLB read HWPOISON test...TEST_FAILED
>>
>> I'm testing on v6.7-rc8. Not sure if this was working previously or not.
> 
> Thanks for reporting this, Usama!
> 
> I am also able to repro MADV_HWPOISON failure at "501a06fe8e4c
> (akpm/mm-stable, mm-stable) zswap: memcontrol: implement zswap
> writeback disabling."
> 
> Then I checked out the earliest commit "ba91e7e5d15a (HEAD -> Base)
> selftests/mm: add tests for HWPOISON hugetlbfs read". The
> MADV_HWPOISON injection works and and the test passes:
> 
>  ... HugeTLB read HWPOISON test...
>  ...  ... expect to read 0x101000 bytes of data in total
>  ...  !!! read failed: Input/output error
>  ...  ... actually read 0x101000 bytes of data in total
>  ... HugeTLB read HWPOISON test...TEST_PASSED
>  ... HugeTLB seek then read HWPOISON test...
>  ...  ... init val=4 with offset=0x102000
>  ...  ... expect to read 0xfe000 bytes of data in total
>  ...  ... actually read 0xfe000 bytes of data in total
>  ... HugeTLB seek then read HWPOISON test...TEST_PASSED
>  ...
> 
> [ 2109.209225] Injecting memory failure for pfn 0x3190d01 at process
> virtual address 0x7f75e3101000
> [ 2109.209438] Memory failure: 0x3190d01: recovery action for huge
> page: Recovered
> ...
> 
> I think something in between broken MADV_HWPOISON on hugetlbfs, and we
> should be able to figure it out via bisection (and of course by
> reading delta commits between them, probably related to page
> refcount).
Thank you for this information.

> 
> That being said, I will be on vacation from tomorrow until the end of
> next week. So I will get back to this after next weekend. Meanwhile if
> you want to go ahead and bisect the problematic commit, that will be
> very much appreciated.
I'll try to bisect and post here if I find something.

> 
> Thanks,
> Jiaqi
> 
> 
>>
>> Regards,
>> Usama
>>
>> On 7/13/23 5:18 AM, Jiaqi Yan wrote:
>>> Add tests for the improvement made to read operation on HWPOISON
>>> hugetlb page with different read granularities. For each chunk size,
>>> three read scenarios are tested:
>>> 1. Simple regression test on read without HWPOISON.
>>> 2. Sequential read page by page should succeed until encounters the 1st
>>>    raw HWPOISON subpage.
>>> 3. After skip a raw HWPOISON subpage by lseek, read()s always succeed.
>>>
>>> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
>>> ---
>>>  tools/testing/selftests/mm/.gitignore         |   1 +
>>>  tools/testing/selftests/mm/Makefile           |   1 +
>>>  .../selftests/mm/hugetlb-read-hwpoison.c      | 322 ++++++++++++++++++
>>>  3 files changed, 324 insertions(+)
>>>  create mode 100644 tools/testing/selftests/mm/hugetlb-read-hwpoison.c
>>>
>>> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
>>> index 7e2a982383c0..cdc9ce4426b9 100644
>>> --- a/tools/testing/selftests/mm/.gitignore
>>> +++ b/tools/testing/selftests/mm/.gitignore
>>> @@ -5,6 +5,7 @@ hugepage-mremap
>>>  hugepage-shm
>>>  hugepage-vmemmap
>>>  hugetlb-madvise
>>> +hugetlb-read-hwpoison
>>>  khugepaged
>>>  map_hugetlb
>>>  map_populate
>>> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
>>> index 66d7c07dc177..b7fce9073279 100644
>>> --- a/tools/testing/selftests/mm/Makefile
>>> +++ b/tools/testing/selftests/mm/Makefile
>>> @@ -41,6 +41,7 @@ TEST_GEN_PROGS += gup_longterm
>>>  TEST_GEN_PROGS += gup_test
>>>  TEST_GEN_PROGS += hmm-tests
>>>  TEST_GEN_PROGS += hugetlb-madvise
>>> +TEST_GEN_PROGS += hugetlb-read-hwpoison
>>>  TEST_GEN_PROGS += hugepage-mmap
>>>  TEST_GEN_PROGS += hugepage-mremap
>>>  TEST_GEN_PROGS += hugepage-shm
>>> diff --git a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
>>> new file mode 100644
>>> index 000000000000..ba6cc6f9cabc
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
>>> @@ -0,0 +1,322 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +#define _GNU_SOURCE
>>> +#include <stdlib.h>
>>> +#include <stdio.h>
>>> +#include <string.h>
>>> +
>>> +#include <linux/magic.h>
>>> +#include <sys/mman.h>
>>> +#include <sys/statfs.h>
>>> +#include <errno.h>
>>> +#include <stdbool.h>
>>> +
>>> +#include "../kselftest.h"
>>> +
>>> +#define PREFIX " ... "
>>> +#define ERROR_PREFIX " !!! "
>>> +
>>> +#define MAX_WRITE_READ_CHUNK_SIZE (getpagesize() * 16)
>>> +#define MAX(a, b) (((a) > (b)) ? (a) : (b))
>>> +
>>> +enum test_status {
>>> +     TEST_PASSED = 0,
>>> +     TEST_FAILED = 1,
>>> +     TEST_SKIPPED = 2,
>>> +};
>>> +
>>> +static char *status_to_str(enum test_status status)
>>> +{
>>> +     switch (status) {
>>> +     case TEST_PASSED:
>>> +             return "TEST_PASSED";
>>> +     case TEST_FAILED:
>>> +             return "TEST_FAILED";
>>> +     case TEST_SKIPPED:
>>> +             return "TEST_SKIPPED";
>>> +     default:
>>> +             return "TEST_???";
>>> +     }
>>> +}
>>> +
>>> +static int setup_filemap(char *filemap, size_t len, size_t wr_chunk_size)
>>> +{
>>> +     char iter = 0;
>>> +
>>> +     for (size_t offset = 0; offset < len;
>>> +          offset += wr_chunk_size) {
>>> +             iter++;
>>> +             memset(filemap + offset, iter, wr_chunk_size);
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static bool verify_chunk(char *buf, size_t len, char val)
>>> +{
>>> +     size_t i;
>>> +
>>> +     for (i = 0; i < len; ++i) {
>>> +             if (buf[i] != val) {
>>> +                     printf(PREFIX ERROR_PREFIX "check fail: buf[%lu] = %u != %u\n",
>>> +                             i, buf[i], val);
>>> +                     return false;
>>> +             }
>>> +     }
>>> +
>>> +     return true;
>>> +}
>>> +
>>> +static bool seek_read_hugepage_filemap(int fd, size_t len, size_t wr_chunk_size,
>>> +                                    off_t offset, size_t expected)
>>> +{
>>> +     char buf[MAX_WRITE_READ_CHUNK_SIZE];
>>> +     ssize_t ret_count = 0;
>>> +     ssize_t total_ret_count = 0;
>>> +     char val = offset / wr_chunk_size + offset % wr_chunk_size;
>>> +
>>> +     printf(PREFIX PREFIX "init val=%u with offset=0x%lx\n", val, offset);
>>> +     printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
>>> +            expected);
>>> +     if (lseek(fd, offset, SEEK_SET) < 0) {
>>> +             perror(PREFIX ERROR_PREFIX "seek failed");
>>> +             return false;
>>> +     }
>>> +
>>> +     while (offset + total_ret_count < len) {
>>> +             ret_count = read(fd, buf, wr_chunk_size);
>>> +             if (ret_count == 0) {
>>> +                     printf(PREFIX PREFIX "read reach end of the file\n");
>>> +                     break;
>>> +             } else if (ret_count < 0) {
>>> +                     perror(PREFIX ERROR_PREFIX "read failed");
>>> +                     break;
>>> +             }
>>> +             ++val;
>>> +             if (!verify_chunk(buf, ret_count, val))
>>> +                     return false;
>>> +
>>> +             total_ret_count += ret_count;
>>> +     }
>>> +     printf(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
>>> +            total_ret_count);
>>> +
>>> +     return total_ret_count == expected;
>>> +}
>>> +
>>> +static bool read_hugepage_filemap(int fd, size_t len,
>>> +                               size_t wr_chunk_size, size_t expected)
>>> +{
>>> +     char buf[MAX_WRITE_READ_CHUNK_SIZE];
>>> +     ssize_t ret_count = 0;
>>> +     ssize_t total_ret_count = 0;
>>> +     char val = 0;
>>> +
>>> +     printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
>>> +            expected);
>>> +     while (total_ret_count < len) {
>>> +             ret_count = read(fd, buf, wr_chunk_size);
>>> +             if (ret_count == 0) {
>>> +                     printf(PREFIX PREFIX "read reach end of the file\n");
>>> +                     break;
>>> +             } else if (ret_count < 0) {
>>> +                     perror(PREFIX ERROR_PREFIX "read failed");
>>> +                     break;
>>> +             }
>>> +             ++val;
>>> +             if (!verify_chunk(buf, ret_count, val))
>>> +                     return false;
>>> +
>>> +             total_ret_count += ret_count;
>>> +     }
>>> +     printf(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
>>> +            total_ret_count);
>>> +
>>> +     return total_ret_count == expected;
>>> +}
>>> +
>>> +static enum test_status
>>> +test_hugetlb_read(int fd, size_t len, size_t wr_chunk_size)
>>> +{
>>> +     enum test_status status = TEST_SKIPPED;
>>> +     char *filemap = NULL;
>>> +
>>> +     if (ftruncate(fd, len) < 0) {
>>> +             perror(PREFIX ERROR_PREFIX "ftruncate failed");
>>> +             return status;
>>> +     }
>>> +
>>> +     filemap = mmap(NULL, len, PROT_READ | PROT_WRITE,
>>> +                    MAP_SHARED | MAP_POPULATE, fd, 0);
>>> +     if (filemap == MAP_FAILED) {
>>> +             perror(PREFIX ERROR_PREFIX "mmap for primary mapping failed");
>>> +             goto done;
>>> +     }
>>> +
>>> +     setup_filemap(filemap, len, wr_chunk_size);
>>> +     status = TEST_FAILED;
>>> +
>>> +     if (read_hugepage_filemap(fd, len, wr_chunk_size, len))
>>> +             status = TEST_PASSED;
>>> +
>>> +     munmap(filemap, len);
>>> +done:
>>> +     if (ftruncate(fd, 0) < 0) {
>>> +             perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
>>> +             status = TEST_FAILED;
>>> +     }
>>> +
>>> +     return status;
>>> +}
>>> +
>>> +static enum test_status
>>> +test_hugetlb_read_hwpoison(int fd, size_t len, size_t wr_chunk_size,
>>> +                        bool skip_hwpoison_page)
>>> +{
>>> +     enum test_status status = TEST_SKIPPED;
>>> +     char *filemap = NULL;
>>> +     char *hwp_addr = NULL;
>>> +     const unsigned long pagesize = getpagesize();
>>> +
>>> +     if (ftruncate(fd, len) < 0) {
>>> +             perror(PREFIX ERROR_PREFIX "ftruncate failed");
>>> +             return status;
>>> +     }
>>> +
>>> +     filemap = mmap(NULL, len, PROT_READ | PROT_WRITE,
>>> +                    MAP_SHARED | MAP_POPULATE, fd, 0);
>>> +     if (filemap == MAP_FAILED) {
>>> +             perror(PREFIX ERROR_PREFIX "mmap for primary mapping failed");
>>> +             goto done;
>>> +     }
>>> +
>>> +     setup_filemap(filemap, len, wr_chunk_size);
>>> +     status = TEST_FAILED;
>>> +
>>> +     /*
>>> +      * Poisoned hugetlb page layout (assume hugepagesize=2MB):
>>> +      * |<---------------------- 1MB ---------------------->|
>>> +      * |<---- healthy page ---->|<---- HWPOISON page ----->|
>>> +      * |<------------------- (1MB - 8KB) ----------------->|
>>> +      */
>>> +     hwp_addr = filemap + len / 2 + pagesize;
>>> +     if (madvise(hwp_addr, pagesize, MADV_HWPOISON) < 0) {
>>> +             perror(PREFIX ERROR_PREFIX "MADV_HWPOISON failed");
>>> +             goto unmap;
>>> +     }
>>> +
>>> +     if (!skip_hwpoison_page) {
>>> +             /*
>>> +              * Userspace should be able to read (1MB + 1 page) from
>>> +              * the beginning of the HWPOISONed hugepage.
>>> +              */
>>> +             if (read_hugepage_filemap(fd, len, wr_chunk_size,
>>> +                                       len / 2 + pagesize))
>>> +                     status = TEST_PASSED;
>>> +     } else {
>>> +             /*
>>> +              * Userspace should be able to read (1MB - 2 pages) from
>>> +              * HWPOISONed hugepage.
>>> +              */
>>> +             if (seek_read_hugepage_filemap(fd, len, wr_chunk_size,
>>> +                                            len / 2 + MAX(2 * pagesize, wr_chunk_size),
>>> +                                            len / 2 - MAX(2 * pagesize, wr_chunk_size)))
>>> +                     status = TEST_PASSED;
>>> +     }
>>> +
>>> +unmap:
>>> +     munmap(filemap, len);
>>> +done:
>>> +     if (ftruncate(fd, 0) < 0) {
>>> +             perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
>>> +             status = TEST_FAILED;
>>> +     }
>>> +
>>> +     return status;
>>> +}
>>> +
>>> +static int create_hugetlbfs_file(struct statfs *file_stat)
>>> +{
>>> +     int fd;
>>> +
>>> +     fd = memfd_create("hugetlb_tmp", MFD_HUGETLB);
>>> +     if (fd < 0) {
>>> +             perror(PREFIX ERROR_PREFIX "could not open hugetlbfs file");
>>> +             return -1;
>>> +     }
>>> +
>>> +     memset(file_stat, 0, sizeof(*file_stat));
>>> +     if (fstatfs(fd, file_stat)) {
>>> +             perror(PREFIX ERROR_PREFIX "fstatfs failed");
>>> +             goto close;
>>> +     }
>>> +     if (file_stat->f_type != HUGETLBFS_MAGIC) {
>>> +             printf(PREFIX ERROR_PREFIX "not hugetlbfs file\n");
>>> +             goto close;
>>> +     }
>>> +
>>> +     return fd;
>>> +close:
>>> +     close(fd);
>>> +     return -1;
>>> +}
>>> +
>>> +int main(void)
>>> +{
>>> +     int fd;
>>> +     struct statfs file_stat;
>>> +     enum test_status status;
>>> +     /* Test read() in different granularity. */
>>> +     size_t wr_chunk_sizes[] = {
>>> +             getpagesize() / 2, getpagesize(),
>>> +             getpagesize() * 2, getpagesize() * 4
>>> +     };
>>> +     size_t i;
>>> +
>>> +     for (i = 0; i < ARRAY_SIZE(wr_chunk_sizes); ++i) {
>>> +             printf("Write/read chunk size=0x%lx\n",
>>> +                    wr_chunk_sizes[i]);
>>> +
>>> +             fd = create_hugetlbfs_file(&file_stat);
>>> +             if (fd < 0)
>>> +                     goto create_failure;
>>> +             printf(PREFIX "HugeTLB read regression test...\n");
>>> +             status = test_hugetlb_read(fd, file_stat.f_bsize,
>>> +                                        wr_chunk_sizes[i]);
>>> +             printf(PREFIX "HugeTLB read regression test...%s\n",
>>> +                    status_to_str(status));
>>> +             close(fd);
>>> +             if (status == TEST_FAILED)
>>> +                     return -1;
>>> +
>>> +             fd = create_hugetlbfs_file(&file_stat);
>>> +             if (fd < 0)
>>> +                     goto create_failure;
>>> +             printf(PREFIX "HugeTLB read HWPOISON test...\n");
>>> +             status = test_hugetlb_read_hwpoison(fd, file_stat.f_bsize,
>>> +                                                 wr_chunk_sizes[i], false);
>>> +             printf(PREFIX "HugeTLB read HWPOISON test...%s\n",
>>> +                    status_to_str(status));
>>> +             close(fd);
>>> +             if (status == TEST_FAILED)
>>> +                     return -1;
>>> +
>>> +             fd = create_hugetlbfs_file(&file_stat);
>>> +             if (fd < 0)
>>> +                     goto create_failure;
>>> +             printf(PREFIX "HugeTLB seek then read HWPOISON test...\n");
>>> +             status = test_hugetlb_read_hwpoison(fd, file_stat.f_bsize,
>>> +                                                 wr_chunk_sizes[i], true);
>>> +             printf(PREFIX "HugeTLB seek then read HWPOISON test...%s\n",
>>> +                    status_to_str(status));
>>> +             close(fd);
>>> +             if (status == TEST_FAILED)
>>> +                     return -1;
>>> +     }
>>> +
>>> +     return 0;
>>> +
>>> +create_failure:
>>> +     printf(ERROR_PREFIX "Abort test: failed to create hugetlbfs file\n");
>>> +     return -1;
>>> +}
>>
>> --
>> BR,
>> Muhammad Usama Anjum
> 

-- 
BR,
Muhammad Usama Anjum

