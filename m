Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD72767443
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjG1SKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjG1SJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:09:58 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02AF44B0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1690567777; x=1722103777;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=DCfc6aNt/Gw5Zq9YfgbTzD97qgg14pj+wmTF6fu1CYc=;
  b=DxlgUk9rLHYPrZiW9sPcnZVev4MZzt+WxOJYVhDWa9+eX2tKrtJaxct0
   Hf+1/1Zp4Hb8/8vcczuS5I36PGOnY7Y8m26n9WfM+XYL2pbfIgRO8ApyH
   5uTHSL2heZ6om1hGJ+paJGcE3FJXHDc5c/pfN9dJmFIzAI/RdtHYBknao
   U=;
X-IronPort-AV: E=Sophos;i="6.01,238,1684800000"; 
   d="scan'208";a="229346354"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 18:09:35 +0000
Received: from EX19MTAUEB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com (Postfix) with ESMTPS id E6ACDA0DF2;
        Fri, 28 Jul 2023 18:09:33 +0000 (UTC)
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.108) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 18:09:33 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Fri, 28 Jul 2023 18:09:33 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id C653B20D72; Fri, 28 Jul 2023 20:09:32 +0200 (CEST)
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
        <mafs08rb28o4u.fsf_-_@amazon.de>
        <ZMGddjINDt10BSvf@kbusch-mbp.dhcp.thefacebook.com>
Date:   Fri, 28 Jul 2023 20:09:32 +0200
In-Reply-To: <ZMGddjINDt10BSvf@kbusch-mbp.dhcp.thefacebook.com> (Keith Busch's
        message of "Wed, 26 Jul 2023 16:25:58 -0600")
Message-ID: <mafs0tttn7vs3.fsf_-_@amazon.de>
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


Hi,

On Wed, Jul 26 2023, Keith Busch wrote:

> On Wed, Jul 26, 2023 at 09:32:33PM +0200, Pratyush Yadav wrote:
>> On Wed, Jul 26 2023, Keith Busch wrote:
>> > Could you send the output of:
>> >
>> >   numactl --hardware
>>
>> $ numactl --hardware
>> available: 2 nodes (0-1)
>> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
>> node 0 size: 245847 MB
>> node 0 free: 245211 MB
>> node 1 cpus: 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
>> node 1 size: 245932 MB
>> node 1 free: 245328 MB
>> node distances:
>> node   0   1
>>   0:  10  21
>>   1:  21  10
>>
>> >
>> > and then with and without your patch:
>> >
>> >   for i in $(cat /proc/interrupts | grep nvme0 | sed "s/^ *//g" | cut -d":" -f 1); do \
>> >     cat /proc/irq/$i/{smp,effective}_affinity_list; \
>> >   done
>>
>> Without my patch:
>>
>>     $   for i in $(cat /proc/interrupts | grep nvme0 | sed "s/^ *//g" | cut -d":" -f 1); do \
>>     >     cat /proc/irq/$i/{smp,effective}_affinity_list; \
>>     >   done
>
> Hm, I wonder if there's something wrong with my script. All the cpu's
> should be accounted for in the smp_affinity_list, assuming it captured
> all the vectors of the nvme device, but both examples are missing half
> the CPUs. It looks like you have 32 vectors. Does that sound right?

Yes, there are 32 vectors, from nvme0q0 to nvme0q31. Should there be one
vector for each CPU? Perhaps the device does not support that many
queues?

FWIW,

    $ sudo nvme get-feature /dev/nvme0n1 -f 7 -H
    get-feature:0x7 (Number of Queues), Current value:0x1e001e
            Number of IO Completion Queues Allocated (NCQA): 31
            Number of IO Submission Queues Allocated (NSQA): 31

>
> This does show the effective affinity is indeed always on node 0 without
> your patch. I don't see why, though: the "group_cpus_evenly()" function
> that spreads the interrupts doesn't know anything about the device the
> resource is being grouped for, so it shouldn't even take its NUMA node
> into consideration. It's just supposed to ensure all CPUs have a shared
> resource, preferring to not share across numa nodes.

I am guessing you are looking at irq_create_affinity_masks(). Yeah, It
does not take into account the NUMA information. In fact, even if it
did, the NUMA node associated with the IRQ is NUMA_NO_NODE
(/proc/$irq/node == -1).

I did some more digging over the week to figure out what is going on. It
seems like the kernel _does_ in fact allow all CPUs in the affinity. I
added some prints in set_affinity_irq() in
drivers/xen/events/events_base.c (since that is the irqchip for the
interrupt). I see it being called with mask: ffffffff,ffffffff.

But I later see the function being called again with a different mask:
00000000,00008000. The stack trace shows the call is coming from
ksys_write(). The process doing the write is irqbalance.

So I think your earlier statement was incorrect. irqbalance does in fact
balance these interrupts and it probably looks at the NUMA information
of the device to make that decision. My original reasoning holds and
irqbalance is the one picking the affinity.

With this explanation, do you think the patch is good to go?

BTW, could you please also add the below when applying? I forgot to add
it when sending the patch.

  Fixes: a4aea5623d4a5 ("NVMe: Convert to blk-mq")

>
> I'll emulate a similar CPU topology with similar nvme vector count and
> see if I can find anything suspicious. I'm a little concerned we may
> have the same problem for devices that have an associated NUMA node that
> your patch isn't addressing.
>
[...]

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



