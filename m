Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0192766796
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbjG1Iqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjG1Iqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:46:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 182C83C30
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:45:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA42E2F4;
        Fri, 28 Jul 2023 01:46:31 -0700 (PDT)
Received: from [10.57.77.173] (unknown [10.57.77.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B8B73F67D;
        Fri, 28 Jul 2023 01:45:47 -0700 (PDT)
Message-ID: <ee33c805-0b59-c779-db14-82976ca3d199@arm.com>
Date:   Fri, 28 Jul 2023 09:45:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH -V3 1/8] migrate: fix syscall move_pages() return value
 for failure
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
References: <20220817081408.513338-1-ying.huang@intel.com>
 <20220817081408.513338-2-ying.huang@intel.com>
 <01797bb1-43c1-62a1-e483-61fa67061b9c@arm.com>
 <87pm4cx2qs.fsf@nvdebian.thelocal>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87pm4cx2qs.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 01:57, Alistair Popple wrote:
> 
> Thanks Ryan.
> 
> If I'm understanding Huang's patch correctly then kernel versions
> without it would have returned a return code indicating that all pages
> were migrated (ie. none failed to migrate) even if they hadn't.
> 
> Given I would have wrote and tested the test against the old buggy
> version it's probable that this test was always failing but the failure
> was undetected.
> 
> The failure to migrate could be valid (although I'd expect at least some
> success).

Yes, when I looked, I think an initial (variable) number of iterations succeed
before failure.

 One improvement to the test would be to check that status code
> for the page as well and make sure it matches the return code. We would
> likely have caught the bug Huang fixed earlier then.
> 
> Will take a look and see if I can improve the test.

Thanks. This is not urgent from my perspective - I just wanted to point it out.
So don't feel like you need to prioritize it on my account. Although it would be
good to get to the point where all the tests pass on mainline...

> 
>  - Alistair
> 
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> On 17/08/2022 09:14, Huang Ying wrote:
>>> The return value of move_pages() syscall is incorrect when counting
>>> the remaining pages to be migrated.
>>
>> Hi Huang, Alistair,
>>
>> I've noticed that this patch from Huang has caused the mm/migration selftest (authored by Alistair) to start failing (see bisection log below).
>>
>> Of the 3 tests, migration.private_anon and migration.private_anon_thp continue to pass, but migration.shared_anon fails:
>>
>>
>>   #  RUN           migration.shared_anon ...
>>   Didn't migrate 1 pages
>>   # migration.c:167:shared_anon:Expected migrate(ptr, self->n1, self->n2) (-2) == 0 (0)
>>   # shared_anon: Test terminated by assertion
>>   #          FAIL  migration.shared_anon
>>   not ok 2 migration.shared_anon
>>
>>
>> The failure occurs due to the return code of move_pages() and this patch has changed the return code handling in the kernel, so it makes sense:
>>
>>
>> int migrate(uint64_t *ptr, int n1, int n2)
>> {
>> 	int ret, tmp;
>> 	int status = 0;
>> 	struct timespec ts1, ts2;
>>
>> 	if (clock_gettime(CLOCK_MONOTONIC, &ts1))
>> 		return -1;
>>
>> 	while (1) {
>> 		if (clock_gettime(CLOCK_MONOTONIC, &ts2))
>> 			return -1;
>>
>> 		if (ts2.tv_sec - ts1.tv_sec >= RUNTIME)
>> 			return 0;
>>
>> 		ret = move_pages(0, 1, (void **) &ptr, &n2, &status,
>> 				MPOL_MF_MOVE_ALL);
>> 		if (ret) {
>> 			if (ret > 0)
>> 				printf("Didn't migrate %d pages\n", ret); <<<< HERE
>> 			else
>> 				perror("Couldn't migrate pages");
>> 			return -2;
>> 		}
>>
>> 		tmp = n2;
>> 		n2 = n1;
>> 		n1 = tmp;
>> 	}
>>
>> 	return 0;
>> }
>>
>>
>> I haven't looked any further and am not sure what the correct fix is. I wondered if either you might be able to offer a solution?
>>
>> Thanks,
>> Ryan
>>
>>
>> git bisect start
>> # bad: [6eaae198076080886b9e7d57f4ae06fa782f90ef] Linux 6.5-rc3
>> git bisect bad 6eaae198076080886b9e7d57f4ae06fa782f90ef
>> # good: [2c85ebc57b3e1817b6ce1a6b703928e113a90442] Linux 5.10
>> git bisect good 2c85ebc57b3e1817b6ce1a6b703928e113a90442
>> # good: [d710d370c4911e83da5d2bc43d4a2c3b56bd27e7] Merge tag 's390-5.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
>> git bisect good d710d370c4911e83da5d2bc43d4a2c3b56bd27e7
>> # bad: [8715c6d3100fc7c6edddf29af4a399a1c12d028c] Merge tag 'for-6.2/dm-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm
>> git bisect bad 8715c6d3100fc7c6edddf29af4a399a1c12d028c
>> # good: [12b68040a5e468068fd7f4af1150eab8f6e96235] Merge tag 'media/v5.20-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
>> git bisect good 12b68040a5e468068fd7f4af1150eab8f6e96235
>> # good: [7e6739b9336e61fe23ca4e2c8d1fda8f19f979bf] Merge tag 'drm-next-2022-10-05' of git://anongit.freedesktop.org/drm/drm
>> git bisect good 7e6739b9336e61fe23ca4e2c8d1fda8f19f979bf
>> # bad: [524d0c68826bc1adf9d1946e540eb4f7b16699a7] Merge tag 'ceph-for-6.1-rc1' of https://github.com/ceph/ceph-client
>> git bisect bad 524d0c68826bc1adf9d1946e540eb4f7b16699a7
>> # good: [29926f1cd3535f565f200430d5b6a794543fe130] fbdev: mb862xx: Fix check of return value from irq_of_parse_and_map()
>> git bisect good 29926f1cd3535f565f200430d5b6a794543fe130
>> # good: [d4013bc4d49f6da8178a340348369bb9920225c9] Merge tag 'bitmap-6.1-rc1' of https://github.com/norov/linux
>> git bisect good d4013bc4d49f6da8178a340348369bb9920225c9
>> # bad: [ac1e8c6c95bf805c699656046aef0a05205edfbd] Merge tag '6.1-rc-smb3-client-fixes-part1' of git://git.samba.org/sfrench/cifs-2.6
>> git bisect bad ac1e8c6c95bf805c699656046aef0a05205edfbd
>> # bad: [f80be4571b19b9fd8dd1528cd2a2f123aff51f70] kmsan: add KMSAN runtime core
>> git bisect bad f80be4571b19b9fd8dd1528cd2a2f123aff51f70
>> # bad: [c4c84f06285e48f80e9843d0775ad92714ffc35a] fs/proc/task_mmu: stop using linked list and highest_vm_end
>> git bisect bad c4c84f06285e48f80e9843d0775ad92714ffc35a
>> # good: [8c004d1fc1497d9a6d92ea968bd58230af59a492] jbd2: replace ll_rw_block()
>> git bisect good 8c004d1fc1497d9a6d92ea968bd58230af59a492
>> # bad: [f76c83378851f8e70f032848c4e61203f39480e4] mm: multi-gen LRU: optimize multiple memcgs
>> git bisect bad f76c83378851f8e70f032848c4e61203f39480e4
>> # good: [36537a67d3561bfe2b3654161d6c9008fff84d43] mm, hwpoison: avoid unneeded page_mapped_in_vma() overhead in collect_procs_anon()
>> git bisect good 36537a67d3561bfe2b3654161d6c9008fff84d43
>> # bad: [5fc30916b5cda697a7eb8f1167c38c27100a793a] migrate_pages(): fix failure counting for THP subpages retrying
>> git bisect bad 5fc30916b5cda697a7eb8f1167c38c27100a793a
>> # good: [2e3468778dbe3ec389a10c21a703bb8e5be5cfbc] mm: remember young/dirty bit for page migrations
>> git bisect good 2e3468778dbe3ec389a10c21a703bb8e5be5cfbc
>> # good: [f347c9d2697fcbbb64e077f7113a3887a181b8c0] filemap: make the accounting of thrashing more consistent
>> git bisect good f347c9d2697fcbbb64e077f7113a3887a181b8c0
>> # bad: [9c62ff005fc774fb2ba14223b0d865a8aca48fb5] migrate_pages(): remove unnecessary list_safe_reset_next()
>> git bisect bad 9c62ff005fc774fb2ba14223b0d865a8aca48fb5
>> # bad: [a7504ed14f9b5e873599b2487eb95062dd0b65f8] migrate: fix syscall move_pages() return value for failure
>> git bisect bad a7504ed14f9b5e873599b2487eb95062dd0b65f8
>> # first bad commit: [a7504ed14f9b5e873599b2487eb95062dd0b65f8] migrate: fix syscall move_pages() return value for failure
> 

