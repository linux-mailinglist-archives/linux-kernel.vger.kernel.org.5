Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A030D770387
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjHDOu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjHDOuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:50:23 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071B549C7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1691160622; x=1722696622;
  h=from:to:cc:subject:references:date:message-id:
   mime-version;
  bh=AYMpbnj0XgY3+I8gCis285x1Nv3cNPuWZ467V0VPTmU=;
  b=lsdAD0vzkzXXfeur4HVxwDyJP9kUmE/zcEIfLxW1ADCLM9E/AKiNHEFi
   +wtGg00DnxOLzheOSZ8UtMmP5k8rde0VKqMK+d5NO0cVBNrrBHYXn/Taj
   rOTxQV+/u91ryAUAeBqL+epEiuvg4PAKRK++Hm4D2+ZWsicdzOnqK/7Kt
   g=;
X-IronPort-AV: E=Sophos;i="6.01,255,1684800000"; 
   d="scan'208";a="343643443"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-0ec33b60.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 14:50:19 +0000
Received: from EX19MTAUEA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-0ec33b60.us-west-2.amazon.com (Postfix) with ESMTPS id 86D34A0B74;
        Fri,  4 Aug 2023 14:50:17 +0000 (UTC)
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 4 Aug 2023 14:50:17 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Fri, 4 Aug 2023 14:50:17 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id E9B6420CD4; Fri,  4 Aug 2023 16:50:16 +0200 (CEST)
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
        <mafs0tttn7vs3.fsf_-_@amazon.de>
        <ZMQYURrKPqIyTkG7@kbusch-mbp.dhcp.thefacebook.com>
Date:   Fri, 4 Aug 2023 16:50:16 +0200
Message-ID: <mafs0350y7tg7.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28 2023, Keith Busch wrote:

> On Fri, Jul 28, 2023 at 08:09:32PM +0200, Pratyush Yadav wrote:
>>
>> I am guessing you are looking at irq_create_affinity_masks(). Yeah, It
>> does not take into account the NUMA information. In fact, even if it
>> did, the NUMA node associated with the IRQ is NUMA_NO_NODE
>> (/proc/$irq/node == -1).
>>
>> I did some more digging over the week to figure out what is going on. It
>> seems like the kernel _does_ in fact allow all CPUs in the affinity. I
>> added some prints in set_affinity_irq() in
>> drivers/xen/events/events_base.c (since that is the irqchip for the
>> interrupt). I see it being called with mask: ffffffff,ffffffff.
>>
>> But I later see the function being called again with a different mask:
>> 00000000,00008000. The stack trace shows the call is coming from
>> ksys_write(). The process doing the write is irqbalance.
>>
>> So I think your earlier statement was incorrect. irqbalance does in fact
>> balance these interrupts and it probably looks at the NUMA information
>> of the device to make that decision. My original reasoning holds and
>> irqbalance is the one picking the affinity.
>>
>> With this explanation, do you think the patch is good to go?
>
> irqbalance still writes to the /proc/<irq>/smp_affinity to change it,
> right? That's just getting I/O errors on my machines because it fails
> irq_can_set_affinity_usr() for nvme's kernel managed interrupts (except
> the first vector, but that one is not used for I/O). Is there another
> path irqbalance is using that's somehow getting past the appropriate
> checks? Or perhaps is your xen irq_chip somehow bypassing the managed
> irq property?

I picked the interrupt "nvme4q26" as example. The call stack is (printed
via WARN_ON(1)):

    ? __warn+0x7d/0x140
    ? set_affinity_irq+0xf0/0x220
    ? report_bug+0xf8/0x1e0
    ? handle_bug+0x44/0x80
    ? exc_invalid_op+0x13/0x60
    ? asm_exc_invalid_op+0x16/0x20
    ? set_affinity_irq+0xf0/0x220
    ? set_affinity_irq+0xf0/0x220
    irq_do_set_affinity+0x135/0x1e0
    irq_set_affinity_locked+0x186/0x1f0
    __irq_set_affinity+0x41/0x70
    write_irq_affinity.isra.8+0xf6/0x120
    proc_reg_write+0x59/0x80
    vfs_write+0xc7/0x3c0
    ? __do_sys_newfstat+0x35/0x60
    ? __fget_light+0xcb/0x120
    ksys_write+0xa5/0xe0
    do_syscall_64+0x42/0x90
    entry_SYSCALL_64_after_hwframe+0x63/0xcd

The check you mention is in write_irq_affinity(). I added some prints
there and it turns out that __irqd_can_set_affinity() returns true and
irqd_affinity_is_managed() is false.

I did some more digging and it turns out that the masks are called by
irq_create_affinity_masks() which sets is_managed to the IRQ affinity
descriptors.

This is then passed down to __msi_domain_alloc_locked(). On a non-Xen
system you would end up calling __msi_domain_alloc_irqs() next since
ops->domain_alloc_irqs() is only implemented by Xen. This function finds
the masks created earlier and passes them down to
__irq_domain_alloc_irqs(). This then eventually lands in alloc_descs()
which checks is_managed and sets IRQD_AFFINITY_MANAGED.

On Xen though, xen_msi_domain_alloc_irqs() is called. This eventually
lands in xen_allocate_irqs_dynamic() which calls irq_alloc_descs(). This
macro calls __irq_alloc_descs() with affinity set to NULL. This leads to
us losing the is_managed flag and the affinities created by
irq_create_affinity_masks() via group_cpus_evenly().

As a result of this, MSI IRQs on Xen can never be managed by the kernel.
They are marked as userspace manageable and irqbalance can set their
affinity. Applying the (hacky) patch below fixes this problem and lets
the kernel manage the affinities.

------ 8< ------
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index c7715f8bd4522..15f36e34e28b4 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -743,9 +743,10 @@ static void xen_irq_init(unsigned irq)
 	list_add_tail(&info->list, &xen_irq_list_head);
 }
 
-static int __must_check xen_allocate_irqs_dynamic(int nvec)
+static int __must_check xen_allocate_irqs_dynamic(int nvec,
+						  struct irq_affinity_desc *affd)
 {
-	int i, irq = irq_alloc_descs(-1, 0, nvec, -1);
+	int i, irq = __irq_alloc_descs(-1, 0, nvec, -1, THIS_MODULE, affd);
 
 	if (irq >= 0) {
 		for (i = 0; i < nvec; i++)
@@ -758,7 +759,7 @@ static int __must_check xen_allocate_irqs_dynamic(int nvec)
 static inline int __must_check xen_allocate_irq_dynamic(void)
 {
 
-	return xen_allocate_irqs_dynamic(1);
+	return xen_allocate_irqs_dynamic(1, NULL);
 }
 
 static int __must_check xen_allocate_irq_gsi(unsigned gsi)
@@ -1108,7 +1109,7 @@ int xen_bind_pirq_msi_to_irq(struct pci_dev *dev, struct msi_desc *msidesc,
 
 	mutex_lock(&irq_mapping_update_lock);
 
-	irq = xen_allocate_irqs_dynamic(nvec);
+	irq = xen_allocate_irqs_dynamic(nvec, msidesc->affinity);
 	if (irq < 0)
 		goto out;
------ >8 ------ 

With this patch, I get the below affinities:

    $   for i in $(cat /proc/interrupts | grep nvme0 | sed "s/^ *//g" | cut -d":" -f 1); do \
    >     cat /proc/irq/$i/{smp,effective}_affinity_list; \
    >   done
    8
    8
    16-17,48,65,67,69

    18-19,50,71,73,75

    20,52,77,79

    21,53,81,83

    22,54,85,87

    23,55,89,91

    24,56,93,95

    25,57,97,99

    26,58,101,103

    27,59,105,107

    28,60,109,111

    29,61,113,115

    30,62,117,119

    31,63,121,123

    49,51,125,127

    0,32,64,66

    1,33,68,70

    2,34,72,74

    3,35,76,78

    4,36,80,82

    5,37,84,86

    6,38,88,90

    7,39,92,94

    8,40,96,98

    9,41,100,102

    10,42,104,106

    11,43,108,110

    12,44,112,114

    13,45,116,118

    14,46,120,122

    15,47,124,126

The blank lines are because effective_smp_affinity is blank for all but the first interrupt.

The problem is, even with this I still get the same performance
difference when running on Node 1 vs Node 0. I am not sure why. Any
pointers?

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



