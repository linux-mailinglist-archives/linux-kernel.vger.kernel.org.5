Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DF07A4218
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbjIRHRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbjIRHRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:17:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F23E3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:17:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A8199219A8;
        Mon, 18 Sep 2023 07:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695021418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BniMa9F67rYBuQFcTF2vySRhCLlWhJBYszyMvTZtxMg=;
        b=GLA9sbq4gQjnHNNACGT/VuwdHZgX7Omm+DoNSmeeB78YgvN2EqEM1s0pFioK9b6ly7KZgG
        dx+84VIOF2dShx1tnbiAC/vje1efIx621td/Ow8iZ3flOYvRnKuZkFqCkuWnFnY2TV7fr7
        oetGppGxKFwReVyvV2ys+2F+oSFmftU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695021418;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BniMa9F67rYBuQFcTF2vySRhCLlWhJBYszyMvTZtxMg=;
        b=vmeWOxbkCO0TFLAYA5t35ZqpYxb+NTPFOjy4wnPjLs47eWcacMoIrs2Uy5+S/9dxiTgoH5
        i4IrySLf0QufAEAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81A5C13480;
        Mon, 18 Sep 2023 07:16:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Et7gHmr5B2U8TwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 18 Sep 2023 07:16:58 +0000
Message-ID: <a88b7339-beab-37c6-7d32-0292b325916d@suse.cz>
Date:   Mon, 18 Sep 2023 09:16:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230914235238.GB129171@monkey> <20230915141610.GA104956@cmpxchg.org>
 <20230916195739.GB618858@monkey>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230916195739.GB618858@monkey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/23 21:57, Mike Kravetz wrote:
> On 09/15/23 10:16, Johannes Weiner wrote:
>> On Thu, Sep 14, 2023 at 04:52:38PM -0700, Mike Kravetz wrote:
>> > In next-20230913, I started hitting the following BUG.  Seems related
>> > to this series.  And, if series is reverted I do not see the BUG.
>> > 
>> > I can easily reproduce on a small 16G VM.  kernel command line contains
>> > "hugetlb_free_vmemmap=on hugetlb_cma=4G".  Then run the script,
>> > while true; do
>> >  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>> >  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/demote
>> >  echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
>> > done
>> > 
>> > For the BUG below I believe it was the first (or second) 1G page creation from
>> > CMA that triggered:  cma_alloc of 1G.
>> > 
>> > Sorry, have not looked deeper into the issue.
>> 
>> Thanks for the report, and sorry about the breakage!
>> 
>> I was scratching my head at this:
>> 
>>                         /* MIGRATE_ISOLATE page should not go to pcplists */
>>                         VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
>> 
>> because there is nothing in page isolation that prevents setting
>> MIGRATE_ISOLATE on something that's on the pcplist already. So why
>> didn't this trigger before already?
>> 
>> Then it clicked: it used to only check the *pcpmigratetype* determined
>> by free_unref_page(), which of course mustn't be MIGRATE_ISOLATE.
>> 
>> Pages that get isolated while *already* on the pcplist are fine, and
>> are handled properly:
>> 
>>                         mt = get_pcppage_migratetype(page);
>> 
>>                         /* MIGRATE_ISOLATE page should not go to pcplists */
>>                         VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
>> 
>>                         /* Pageblock could have been isolated meanwhile */
>>                         if (unlikely(isolated_pageblocks))
>>                                 mt = get_pageblock_migratetype(page);
>> 
>> So this was purely a sanity check against the pcpmigratetype cache
>> operations. With that gone, we can remove it.
> 
> With the patch below applied, a slightly different workload triggers the
> following warnings.  It seems related, and appears to go away when
> reverting the series.
> 
> [  331.595382] ------------[ cut here ]------------
> [  331.596665] page type is 5, passed migratetype is 1 (nr=512)
> [  331.598121] WARNING: CPU: 2 PID: 935 at mm/page_alloc.c:662 expand+0x1c9/0x200

Initially I thought this demonstrates the possible race I was suggesting in
reply to 6/6. But, assuming you have CONFIG_CMA, page type 5 is cma and we
are trying to get a MOVABLE page from a CMA page block, which is something
that's normally done and the pageblock stays CMA. So yeah if the warnings
are to stay, they need to handle this case. Maybe the same can happen with
HIGHATOMIC blocks?

> [  331.600549] Modules linked in: rfkill ip6table_filter ip6_tables sunrpc snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core snd_seq 9p snd_seq_device netfs 9pnet_virtio snd_pcm joydev snd_timer virtio_balloon snd soundcore 9pnet virtio_blk virtio_console virtio_net net_failover failover crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel serio_raw virtio_pci virtio virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring fuse
> [  331.609530] CPU: 2 PID: 935 Comm: bash Tainted: G        W          6.6.0-rc1-next-20230913+ #26
> [  331.611603] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
> [  331.613527] RIP: 0010:expand+0x1c9/0x200
> [  331.614492] Code: 89 ef be 07 00 00 00 c6 05 c9 b1 35 01 01 e8 de f7 ff ff 8b 4c 24 30 8b 54 24 0c 48 c7 c7 68 9f 22 82 48 89 c6 e8 97 b3 df ff <0f> 0b e9 db fe ff ff 48 c7 c6 f8 9f 22 82 48 89 df e8 41 e3 fc ff
> [  331.618540] RSP: 0018:ffffc90003c97a88 EFLAGS: 00010086
> [  331.619801] RAX: 0000000000000000 RBX: ffffea0007ff8000 RCX: 0000000000000000
> [  331.621331] RDX: 0000000000000005 RSI: ffffffff8224dce6 RDI: 00000000ffffffff
> [  331.622914] RBP: 00000000001ffe00 R08: 0000000000009ffb R09: 00000000ffffdfff
> [  331.624712] R10: 00000000ffffdfff R11: ffffffff824660c0 R12: ffff88827fffcd80
> [  331.626317] R13: 0000000000000009 R14: 0000000000000200 R15: 000000000000000a
> [  331.627810] FS:  00007f24b3932740(0000) GS:ffff888477c00000(0000) knlGS:0000000000000000
> [  331.630593] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  331.631865] CR2: 0000560a53875018 CR3: 000000017eee8003 CR4: 0000000000370ee0
> [  331.633382] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  331.634873] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  331.636324] Call Trace:
> [  331.636934]  <TASK>
> [  331.637521]  ? expand+0x1c9/0x200
> [  331.638320]  ? __warn+0x7d/0x130
> [  331.639116]  ? expand+0x1c9/0x200
> [  331.639957]  ? report_bug+0x18d/0x1c0
> [  331.640832]  ? handle_bug+0x41/0x70
> [  331.641635]  ? exc_invalid_op+0x13/0x60
> [  331.642522]  ? asm_exc_invalid_op+0x16/0x20
> [  331.643494]  ? expand+0x1c9/0x200
> [  331.644264]  ? expand+0x1c9/0x200
> [  331.645007]  rmqueue_bulk+0xf4/0x530
> [  331.645847]  get_page_from_freelist+0x3ed/0x1040
> [  331.646837]  ? prepare_alloc_pages.constprop.0+0x197/0x1b0
> [  331.647977]  __alloc_pages+0xec/0x240
> [  331.648783]  alloc_buddy_hugetlb_folio.isra.0+0x6a/0x150
> [  331.649912]  __alloc_fresh_hugetlb_folio+0x157/0x230
> [  331.650938]  alloc_pool_huge_folio+0xad/0x110
> [  331.651909]  set_max_huge_pages+0x17d/0x390
> [  331.652760]  nr_hugepages_store_common+0x91/0xf0
> [  331.653825]  kernfs_fop_write_iter+0x108/0x1f0
> [  331.654986]  vfs_write+0x207/0x400
> [  331.655925]  ksys_write+0x63/0xe0
> [  331.656832]  do_syscall_64+0x37/0x90
> [  331.657793]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  331.660398] RIP: 0033:0x7f24b3a26e87
> [  331.661342] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> [  331.665673] RSP: 002b:00007ffccd603de8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  331.667541] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f24b3a26e87
> [  331.669197] RDX: 0000000000000005 RSI: 0000560a5381bb50 RDI: 0000000000000001
> [  331.670883] RBP: 0000560a5381bb50 R08: 000000000000000a R09: 00007f24b3abe0c0
> [  331.672536] R10: 00007f24b3abdfc0 R11: 0000000000000246 R12: 0000000000000005
> [  331.674175] R13: 00007f24b3afa520 R14: 0000000000000005 R15: 00007f24b3afa720
> [  331.675841]  </TASK>
> [  331.676450] ---[ end trace 0000000000000000 ]---
> [  331.677659] ------------[ cut here ]------------
> 
> 
