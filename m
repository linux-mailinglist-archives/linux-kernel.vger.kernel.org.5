Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211EA763B15
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjGZPan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbjGZPaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:30:39 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A297F2689
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1690385439; x=1721921439;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=ZjixsS62Rr6GJQ5wm3+wcP9Mfdcz39bR8AWo/tP3EXc=;
  b=LBoHMWuxNO2mP9cuNNBTTxZj5WYW73HpBQDgo2t9UhqNFkhX9/iRPjhP
   NJH4W24ANdY6+szt1CFijJFbr7lHg4gXCh80n63Bl8yxvDs8IqoQlMGA8
   oqMn3VNfswbPKIxbrDXjVUPPaSOq0h0zt1RA928kxgYB9MjLaBl+VRWDu
   c=;
X-IronPort-AV: E=Sophos;i="6.01,232,1684800000"; 
   d="scan'208";a="341886389"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 15:30:36 +0000
Received: from EX19MTAUEB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com (Postfix) with ESMTPS id CA6DB806F9;
        Wed, 26 Jul 2023 15:30:34 +0000 (UTC)
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 15:30:33 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Wed, 26 Jul 2023 15:30:33 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id 9468420D52; Wed, 26 Jul 2023 17:30:33 +0200 (CEST)
From:   Pratyush Yadav <ptyadav@amazon.de>
To:     Christoph Hellwig <hch@lst.de>
CC:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
References: <20230725110622.129361-1-ptyadav@amazon.de>
        <ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com>
        <50a125da-95c8-3b9b-543a-016c165c745d@grimberg.me>
        <20230726131408.GA15909@lst.de>
Date:   Wed, 26 Jul 2023 17:30:33 +0200
In-Reply-To: <20230726131408.GA15909@lst.de> (Christoph Hellwig's message of
        "Wed, 26 Jul 2023 15:14:08 +0200")
Message-ID: <mafs0cz0e8zc6.fsf_-_@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26 2023, Christoph Hellwig wrote:

Hi all,

> On Wed, Jul 26, 2023 at 10:58:36AM +0300, Sagi Grimberg wrote:
>>>> For example, AWS EC2's i3.16xlarge instance does not expose NUMA
>>>> information for the NVMe devices. This means all NVMe devices have
>>>> NUMA_NO_NODE by default. Without this patch, random 4k read performance
>>>> measured via fio on CPUs from node 1 (around 165k IOPS) is almost 50%
>>>> less than CPUs from node 0 (around 315k IOPS). With this patch, CPUs on
>>>> both nodes get similar performance (around 315k IOPS).
>>>
>>> irqbalance doesn't work with this driver though: the interrupts are
>>> managed by the kernel. Is there some other reason to explain the perf
>>> difference?

Hmm, I did not know that. I have not gone and looked at the code but I
think the same reasoning should hold, just with s/irqbalance/kernel. If
the kernel IRQ balancer sees the device is on node 0, it would deliver
its interrupts to CPUs on node 0.

In my tests I can see that the interrupts for NVME queues are sent only
to CPUs from node 0 without this patch. With this patch CPUs from both
nodes get the interrupts.

>>
>> Maybe its because the numa_node goes to the tagset which allocates
>> stuff based on that numa-node ?
>
> Yeah, the only explanation I could come up with is that without this
> the allocations gets spread, and that somehow helps.  All of this
> is a little obscure, but so is the NVMe practice of setting the node id
> to first_memory_node, which no other driver does.  I'd really like to
> understand what's going on here first.  After that this patch probably
> is the right thing, I'd just like to understand why.

See above for my conjecture on why this happens.

More specifically, I discovered this when running an application pinned
to a node 1 CPU reading from an NVME device. I noticed it was performing
worse than when it was pinned to node 0.

If the process is free to move around it might not see such a large
performance difference since it could move to a node 0 CPU. But if it is
pinned to a CPU in node 1 then the interrupt will always hit a node 0
CPU and create higher latency for the reads.

I have a simple fio test that can reproduce this. Save this [1] as 
fio.txt and then run numactl --cpunodebind 1 fio ./fio.txt. You can run
it on any host with an NVME device that has no NUMA node. I have tested
this on AWS EC2's i3.16xlarge instance type.

[1]
    [global]
    ioengine=libaio
    filename=/dev/nvme0n1
    group_reporting=1
    direct=1
    verify=0
    norandommap=0
    size=10%
    time_based=1
    runtime=30
    ramp_time=0
    randrepeat=0
    log_max_value=1
    unified_rw_reporting=1
    percentile_list=50:99:99.9:99.99:99.999
    bwavgtime=10000

    [4k_randread_qd16_4w]
    stonewall
    bs=4k
    rw=randread
    iodepth=32
    numjobs=1

-- 
Regards,
Pratyush Yadav



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



