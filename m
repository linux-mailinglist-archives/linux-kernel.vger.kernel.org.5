Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFFA7825E2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbjHUI4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjHUI4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:56:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 161D5BF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:56:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 945122F4;
        Mon, 21 Aug 2023 01:56:49 -0700 (PDT)
Received: from [10.57.3.137] (unknown [10.57.3.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0C6F3F762;
        Mon, 21 Aug 2023 01:56:02 -0700 (PDT)
Message-ID: <f8c62974-eea8-f58f-cb67-9e2f13b242fd@arm.com>
Date:   Mon, 21 Aug 2023 09:55:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] iommu/iova: Make the rcache depot scale better
To:     "Srivastava, Dheeraj Kumar" <dheerajkumar.srivastava@amd.com>,
        joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, john.g.garry@oracle.com,
        zhangzekun11@huawei.com
References: <cover.1692033783.git.robin.murphy@arm.com>
 <2c3a0f6b381ae5f743c1b28bbc6eae486160f3b7.1692033783.git.robin.murphy@arm.com>
 <3689f036-5d48-0e4d-56fc-9d96823b9547@amd.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <3689f036-5d48-0e4d-56fc-9d96823b9547@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-21 09:11, Srivastava, Dheeraj Kumar wrote:
> Hello Robin,
> 
> On 8/14/2023 11:23 PM, Robin Murphy wrote:
>> The algorithm in the original paper specifies the storage of full
>> magazines in the depot as an unbounded list rather than a fixed-size
>> array. It turns out to be pretty straightforward to do this in our
>> implementation with no significant loss of efficiency. This allows
>> the depot to scale up to the working set sizes of larger systems,
>> while also potentially saving some memory on smaller ones too.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/iova.c | 65 ++++++++++++++++++++++++--------------------
>>   1 file changed, 36 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 10b964600948..d2de6fb0e9f4 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -625,10 +625,16 @@ EXPORT_SYMBOL_GPL(reserve_iova);
>>    * will be wasted.
>>    */
>>   #define IOVA_MAG_SIZE 127
>> -#define MAX_GLOBAL_MAGS 32    /* magazines per bin */
>>   struct iova_magazine {
>> -    unsigned long size;
>> +    /*
>> +     * Only full magazines are inserted into the depot, so we can avoid
>> +     * a separate list head and preserve maximum space-efficiency.
>> +     */
>> +    union {
>> +        unsigned long size;
>> +        struct iova_magazine *next;
>> +    };
>>       unsigned long pfns[IOVA_MAG_SIZE];
>>   };
>> @@ -640,8 +646,7 @@ struct iova_cpu_rcache {
>>   struct iova_rcache {
>>       spinlock_t lock;
>> -    unsigned long depot_size;
>> -    struct iova_magazine *depot[MAX_GLOBAL_MAGS];
>> +    struct iova_magazine *depot;
>>       struct iova_cpu_rcache __percpu *cpu_rcaches;
>>   };
>> @@ -717,6 +722,21 @@ static void iova_magazine_push(struct 
>> iova_magazine *mag, unsigned long pfn)
>>       mag->pfns[mag->size++] = pfn;
>>   }
>> +static struct iova_magazine *iova_depot_pop(struct iova_rcache *rcache)
>> +{
>> +    struct iova_magazine *mag = rcache->depot;
>> +
>> +    rcache->depot = mag->next;
> 
> While doing routine domain change test for a device ("unbind device from 
> driver -> change domain of the device -> bind device back to the 
> driver"), i ran into the following NULL pointer dereferencing issue.
> 
> [  599.020261] BUG: kernel NULL pointer dereference, address: 
> 0000000000000000
> [  599.020986] #PF: supervisor read access in kernel mode
> [  599.021588] #PF: error_code(0x0000) - not-present page
> [  599.022180] PGD 0 P4D 0
> [  599.022770] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  599.023365] CPU: 68 PID: 3122 Comm: avocado Not tainted 
> 6.5.0-rc6-ChngDomainIssue #16
> [  599.023970] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS 
> 2.3.6 07/06/2021
> [  599.024571] RIP: 0010:free_iova_rcaches+0x9c/0x110
> [  599.025170] Code: d1 ff 39 05 36 d2 bc 01 48 89 c3 77 b4 49 8b 7f 10 
> e8 b8 69 93 ff 49 8d 7f 20 e8 6f e4 6b ff eb 05 e8 48 ba 93 ff 49 8b 7f 
> 08 <48> 8b 07 49 89 47 08 48 c7 07 7f 00 00 00 41 83 6f 04 01 48 85 ff
> [  599.026436] RSP: 0018:ffffb78b4c9f7c68 EFLAGS: 00010296
> [  599.027075] RAX: ffffffff9fa8c100 RBX: 0000000000000080 RCX: 
> 0000000000000005
> [  599.027719] RDX: 0000000000000000 RSI: 000000007fffffff RDI: 
> 0000000000000000
> [  599.028359] RBP: ffffb78b4c9f7c98 R08: 0000000000000000 R09: 
> 0000000000000006
> [  599.028995] R10: 0000000000000000 R11: 0000000000000000 R12: 
> 0000000000000000
> [  599.029636] R13: ffff93910d9c6008 R14: ffffd78b3bde1000 R15: 
> ffff9391144ebc00
> [  599.030283] FS:  00007fa5c9e5c000(0000) GS:ffff93cf72700000(0000) 
> knlGS:0000000000000000
> [  599.030941] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  599.031588] CR2: 0000000000000000 CR3: 000000013f526006 CR4: 
> 0000000000770ee0
> [  599.032237] PKRU: 55555554
> [  599.032878] Call Trace:
> [  599.033512]  <TASK>
> [  599.034140]  ? show_regs+0x6e/0x80
> [  599.034769]  ? __die+0x29/0x70
> [  599.035393]  ? page_fault_oops+0x154/0x4a0
> [  599.036021]  ? __x86_return_thunk+0x9/0x10
> [  599.036647]  ? do_user_addr_fault+0x318/0x6b0
> [  599.037258]  ? __x86_return_thunk+0x9/0x10
> [  599.037866]  ? __slab_free+0xc7/0x320
> [  599.038472]  ? exc_page_fault+0x7d/0x190
> [  599.039074]  ? asm_exc_page_fault+0x2b/0x30
> [  599.039683]  ? free_iova_rcaches+0x9c/0x110
> [  599.040286]  ? free_iova_rcaches+0x91/0x110
> [  599.040875]  ? __x86_return_thunk+0x9/0x10
> [  599.041460]  put_iova_domain+0x32/0xa0
> [  599.042041]  iommu_put_dma_cookie+0x177/0x1b0
> [  599.042620]  iommu_domain_free+0x1f/0x50
> [  599.043194]  iommu_setup_default_domain+0x2fb/0x420
> [  599.043774]  iommu_group_store_type+0xb6/0x210
> [  599.044362]  iommu_group_attr_store+0x21/0x40
> [  599.044938]  sysfs_kf_write+0x42/0x50
> [  599.045511]  kernfs_fop_write_iter+0x143/0x1d0
> [  599.046084]  vfs_write+0x2c2/0x3f0
> [  599.046653]  ksys_write+0x6b/0xf0
> [  599.047219]  __x64_sys_write+0x1d/0x30
> [  599.047782]  do_syscall_64+0x60/0x90
> [  599.048346]  ? syscall_exit_to_user_mode+0x2a/0x50
> [  599.048911]  ? __x64_sys_lseek+0x1c/0x30
> [  599.049465]  ? __x86_return_thunk+0x9/0x10
> [  599.050013]  ? do_syscall_64+0x6d/0x90
> [  599.050562]  ? do_syscall_64+0x6d/0x90
> [  599.051098]  ? do_syscall_64+0x6d/0x90
> [  599.051625]  ? __x86_return_thunk+0x9/0x10
> [  599.052149]  ? exc_page_fault+0x8e/0x190
> [  599.052665]  entry_SYSCALL_64_after_hwframe+0x73/0xdd
> [  599.053180] RIP: 0033:0x7fa5c9d14a6f
> [  599.053670] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 19 c0 f7 
> ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 
> 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 5c c0 f7 ff 48
> [  599.054672] RSP: 002b:00007ffdeb05f540 EFLAGS: 00000293 ORIG_RAX: 
> 0000000000000001
> [  599.055182] RAX: ffffffffffffffda RBX: 0000557de3275a80 RCX: 
> 00007fa5c9d14a6f
> [  599.055692] RDX: 0000000000000003 RSI: 0000557de418ff60 RDI: 
> 0000000000000011
> [  599.056203] RBP: 0000557de39a25e0 R08: 0000000000000000 R09: 
> 0000000000000000
> [  599.056718] R10: 0000000000000000 R11: 0000000000000293 R12: 
> 0000000000000003
> [  599.057227] R13: 00007fa5c9e5bf80 R14: 0000000000000011 R15: 
> 0000557de418ff60
> [  599.057738]  </TASK>
> [  599.058227] Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack 
> ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat nft_chain_nat nf_nat 
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink bridge 
> stp llc ipmi_ssif binfmt_misc nls_iso8859_1 intel_rapl_msr 
> intel_rapl_common amd64_edac edac_mce_amd kvm_amd kvm dell_smbios dcdbas 
> rapl dell_wmi_descriptor wmi_bmof joydev input_leds ccp ptdma k10temp 
> acpi_ipmi ipmi_si acpi_power_meter mac_hid sch_fq_codel dm_multipath 
> scsi_dh_rdac ipmi_devintf scsi_dh_emc ipmi_msghandler scsi_dh_alua msr 
> ramoops reed_solomon pstore_blk pstore_zone efi_pstore ip_tables 
> x_tables autofs4 hid_generic usbhid hid btrfs blake2b_generic raid10 
> raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor 
> raid6_pq libcrc32c raid1 raid0 multipath linear mgag200 i2c_algo_bit 
> drm_shmem_helper drm_kms_helper crct10dif_pclmul crc32_pclmul 
> ghash_clmulni_intel sha512_ssse3 aesni_intel crypto_simd cryptd nvme drm 
> mpt3sas tg3 ahci nvme_core libahci xhci_pci raid_class i2c_piix4
> [  599.058423]  xhci_pci_renesas scsi_transport_sas wmi
> [  599.064210] CR2: 0000000000000000
> [  599.064841] ---[ end trace 0000000000000000 ]---
> -- 
> 
> Looking at the RIP: free_iova_rcaches+0x9c/0x110 pointed me to the above 
> line leading me to believe we are popping element from an empty stack. 
> Following hunk fixed the issue for me:

Oh dear... looks like this was a brainfart when I factored out the 
push/pop helpers to replace the original list_head-based prototype. 
Thanks for the catch!

This fix is functionally fine, but I think what I'll do for v2 is 
change those "while ((mag = iova_depot_pop(rcache)))" loops, since 
assignment-in-the-loop-condition logic tends to look a bit suspect 
anyway. Other than that, though, were you able to notice any difference 
(good or bad) in CPU load or memory consumption overall?

Thanks,
Robin.

> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 76a7d694708e..899f1c2ba62a 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -732,6 +732,9 @@ static struct iova_magazine *iova_depot_pop(struct 
> iova_rcache *rcache)
>   {
>       struct iova_magazine *mag = rcache->depot;
> 
> +    if (!mag)
> +        return NULL;
> +
>       rcache->depot = mag->next;
>       mag->size = IOVA_MAG_SIZE;
>       rcache->depot_size--;
> -- 
> 
>> +    mag->size = IOVA_MAG_SIZE;
>> +    return mag;
>> +}
>> +
> 
> -- 
> Thanks and Regards
> Dheeraj Kumar Srivastava
> 
