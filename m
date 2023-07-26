Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B09763FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjGZTcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGZTcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:32:39 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55795E4F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1690399958; x=1721935958;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=PdsSRu7tlZBA3gNrHuPdzW7N3hmmobQp+k8jhBUmFHA=;
  b=OXynlwMLFT78B4BOVvI3Ilrp8Io9k8UJReLOGgz+K6PjmSWneq+2dNGX
   ywFp2RnSyEoBKyayumzc/Wyeom9aDOFVTf2lf5GVMsck+H6lGbLzX2r4k
   HqPJtLwR4RdR4wNKTneSH7LR69p6xRBnCQGV+WEqkdYLWefbcB1AIRmy5
   4=;
X-IronPort-AV: E=Sophos;i="6.01,232,1684800000"; 
   d="scan'208";a="228901664"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 19:32:35 +0000
Received: from EX19MTAUEC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com (Postfix) with ESMTPS id 2DFAA46E5E;
        Wed, 26 Jul 2023 19:32:34 +0000 (UTC)
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 19:32:33 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Wed, 26 Jul 2023 19:32:33 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id 3672C20E1D; Wed, 26 Jul 2023 21:32:33 +0200 (CEST)
From:   Pratyush Yadav <ptyadav@amazon.de>
To:     Keith Busch <kbusch@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "Jens Axboe" <axboe@kernel.dk>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
References: <20230725110622.129361-1-ptyadav@amazon.de>
        <ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com>
        <50a125da-95c8-3b9b-543a-016c165c745d@grimberg.me>
        <20230726131408.GA15909@lst.de> <mafs0cz0e8zc6.fsf_-_@amazon.de>
        <ZMFHEK95WGwtYbid@kbusch-mbp.dhcp.thefacebook.com>
Date:   Wed, 26 Jul 2023 21:32:33 +0200
In-Reply-To: <ZMFHEK95WGwtYbid@kbusch-mbp.dhcp.thefacebook.com> (Keith Busch's
        message of "Wed, 26 Jul 2023 10:17:20 -0600")
Message-ID: <mafs08rb28o4u.fsf_-_@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26 2023, Keith Busch wrote:

> On Wed, Jul 26, 2023 at 05:30:33PM +0200, Pratyush Yadav wrote:
>> On Wed, Jul 26 2023, Christoph Hellwig wrote:
>> > On Wed, Jul 26, 2023 at 10:58:36AM +0300, Sagi Grimberg wrote:
>> >>>> For example, AWS EC2's i3.16xlarge instance does not expose NUMA
>> >>>> information for the NVMe devices. This means all NVMe devices have
>> >>>> NUMA_NO_NODE by default. Without this patch, random 4k read performance
>> >>>> measured via fio on CPUs from node 1 (around 165k IOPS) is almost 50%
>> >>>> less than CPUs from node 0 (around 315k IOPS). With this patch, CPUs on
>> >>>> both nodes get similar performance (around 315k IOPS).
>> >>>
>> >>> irqbalance doesn't work with this driver though: the interrupts are
>> >>> managed by the kernel. Is there some other reason to explain the perf
>> >>> difference?
>>
>> Hmm, I did not know that. I have not gone and looked at the code but I
>> think the same reasoning should hold, just with s/irqbalance/kernel. If
>> the kernel IRQ balancer sees the device is on node 0, it would deliver
>> its interrupts to CPUs on node 0.
>>
>> In my tests I can see that the interrupts for NVME queues are sent only
>> to CPUs from node 0 without this patch. With this patch CPUs from both
>> nodes get the interrupts.
>
> Could you send the output of:
>
>   numactl --hardware

$ numactl --hardware
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
node 0 size: 245847 MB
node 0 free: 245211 MB
node 1 cpus: 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
node 1 size: 245932 MB
node 1 free: 245328 MB
node distances:
node   0   1
  0:  10  21
  1:  21  10

>
> and then with and without your patch:
>
>   for i in $(cat /proc/interrupts | grep nvme0 | sed "s/^ *//g" | cut -d":" -f 1); do \
>     cat /proc/irq/$i/{smp,effective}_affinity_list; \
>   done

Without my patch:

    $   for i in $(cat /proc/interrupts | grep nvme0 | sed "s/^ *//g" | cut -d":" -f 1); do \
    >     cat /proc/irq/$i/{smp,effective}_affinity_list; \
    >   done
    40
    40
    33
    33
    44
    44
    9
    9
    32
    32
    2
    2
    6
    6
    11
    11
    1
    1
    35
    35
    39
    39
    13
    13
    42
    42
    46
    46
    41
    41
    46
    46
    15
    15
    5
    5
    43
    43
    0
    0
    14
    14
    8
    8
    12
    12
    7
    7
    10
    10
    47
    47
    38
    38
    36
    36
    3
    3
    34
    34
    45
    45
    5
    5

With my patch:

    $   for i in $(cat /proc/interrupts | grep nvme0 | sed "s/^ *//g" | cut -d":" -f 1); do \
    >     cat /proc/irq/$i/{smp,effective}_affinity_list; \
    >   done
    9
    9
    15
    15
    5
    5
    23
    23
    38
    38
    52
    52
    21
    21
    36
    36
    13
    13
    56
    56
    44
    44
    42
    42
    31
    31
    48
    48
    5
    5
    3
    3
    1
    1
    11
    11
    28
    28
    18
    18
    34
    34
    29
    29
    58
    58
    46
    46
    54
    54
    59
    59
    32
    32
    7
    7
    56
    56
    62
    62
    49
    49
    57
    57

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



