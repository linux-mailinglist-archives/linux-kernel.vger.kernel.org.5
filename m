Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE628773E9A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjHHQc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjHHQbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:31:41 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C986213979
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1691509909; x=1723045909;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=tGYOhA23w23vVl8dmMf4yHScgVEyNXkh/NRK2C4JAq0=;
  b=Mr6LUvoqcv/Fyk2PADFrwL+JXOcVE+Tyk37ZT/Iqii0ZGZ8JT39sgrwS
   +30eHZwIUzqtxBFNTaBmawxqDD9kKhU2YpLta8YlhQxHWjt3ijA3XPcMc
   83f7eIwsEFOCRzdTdHULpzVI6+do+XcxhJsiYkFn25vB+yACEcXF0wEd7
   w=;
X-IronPort-AV: E=Sophos;i="6.01,156,1684800000"; 
   d="scan'208";a="1147442275"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 15:51:02 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com (Postfix) with ESMTPS id 701B040BBD;
        Tue,  8 Aug 2023 15:51:02 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 8 Aug 2023 15:51:01 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 8 Aug 2023 15:51:01 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id 5C59C20D20; Tue,  8 Aug 2023 17:51:01 +0200 (CEST)
From:   Pratyush Yadav <ptyadav@amazon.de>
To:     Keith Busch <kbusch@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "Jens Axboe" <axboe@kernel.dk>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
References: <ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com>
        <50a125da-95c8-3b9b-543a-016c165c745d@grimberg.me>
        <20230726131408.GA15909@lst.de> <mafs0cz0e8zc6.fsf_-_@amazon.de>
        <ZMFHEK95WGwtYbid@kbusch-mbp.dhcp.thefacebook.com>
        <mafs08rb28o4u.fsf_-_@amazon.de>
        <ZMGddjINDt10BSvf@kbusch-mbp.dhcp.thefacebook.com>
        <mafs0tttn7vs3.fsf_-_@amazon.de>
        <ZMQYURrKPqIyTkG7@kbusch-mbp.dhcp.thefacebook.com>
        <mafs0350y7tg7.fsf@amazon.de> <ZM0XEUw0xKgzXvi+@kbusch-mbp>
Date:   Tue, 8 Aug 2023 17:51:01 +0200
In-Reply-To: <ZM0XEUw0xKgzXvi+@kbusch-mbp> (Keith Busch's message of "Fri, 4
        Aug 2023 09:19:45 -0600")
Message-ID: <mafs0y1il5y8q.fsf_-_@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04 2023, Keith Busch wrote:

> On Fri, Aug 04, 2023 at 04:50:16PM +0200, Pratyush Yadav wrote:
>> With this patch, I get the below affinities:
>
> Something still seems off without effective_affinity set. That attribute
> should always reflect one CPU from the smp_affinity_list.
>
> At least with your patch, the smp_affinity_list looks as expected: every
> CPU is accounted for, and no vector appears to share the resource among
> CPUs in different nodes.
>
>>     $   for i in $(cat /proc/interrupts | grep nvme0 | sed "s/^ *//g" | cut -d":" -f 1); do \
>>     >     cat /proc/irq/$i/{smp,effective}_affinity_list; \
>>     >   done
>>     8
>>     8
>>     16-17,48,65,67,69
>>
>>     18-19,50,71,73,75
>>
>>     20,52,77,79
>>
>>     21,53,81,83
>>
>>     22,54,85,87
>>
>>     23,55,89,91
>>
>>     24,56,93,95
>>
>>     25,57,97,99
>>
>>     26,58,101,103
>>
>>     27,59,105,107
>>
>>     28,60,109,111
>>
>>     29,61,113,115
>>
>>     30,62,117,119
>>
>>     31,63,121,123
>>
>>     49,51,125,127
>>
>>     0,32,64,66
>>
>>     1,33,68,70
>>
>>     2,34,72,74
>>
>>     3,35,76,78
>>
>>     4,36,80,82
>>
>>     5,37,84,86
>>
>>     6,38,88,90
>>
>>     7,39,92,94
>>
>>     8,40,96,98
>>
>>     9,41,100,102
>>
>>     10,42,104,106
>>
>>     11,43,108,110
>>
>>     12,44,112,114
>>
>>     13,45,116,118
>>
>>     14,46,120,122
>>
>>     15,47,124,126
>>
>> The blank lines are because effective_smp_affinity is blank for all but the first interrupt.
>>
>> The problem is, even with this I still get the same performance
>> difference when running on Node 1 vs Node 0. I am not sure why. Any
>> pointers?
>
> I suspect effective_affinity isn't getting set and interrupts are
> triggering on unexpected CPUs. If you check /proc/interrupts, can you
> confirm if the interrupts are firing on CPUs within the
> smp_affinity_list or some other CPU?

All interrupts are hitting CPU0.

I did some more digging. Xen sets the effective affinity via the
function set_affinity_irq(). But it only sets it if info->evtchn is
valid. But info->evtchn is set by startup_pirq(), which is called _after_
set_affinity_irq().

This worked before because irqbalance was coming in after all this
happened and set the affinity, causing set_affinity_irq() to be called
again. By that time startup_pirq() has been called and info->evtchn is
set.

This whole thing needs some refactoring to work properly. I wrote up a
hacky patch (on top of my previous hacky patch) that fixes it. I will
write up a proper patch when I find some more time next week.

With this, I am now seeing good performance on node 1. I am seeing
slightly slower performance on node 1 but that might be due to some
other reasons and I do not want to dive into that for now.

Thanks for your help with this :-)

BTW, do you think I should re-send the patch with updated reasoning,
since Cristoph thinks we should do this regardless of the performance
reasons [0]?

[0] https://lore.kernel.org/linux-nvme/20230726131408.GA15909@lst.de/

----- 8< -----
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index c7715f8bd4522..ed33d33a2f1c9 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -108,6 +108,7 @@ struct irq_info {
 	unsigned irq;
 	evtchn_port_t evtchn;   /* event channel */
 	unsigned short cpu;     /* cpu bound */
+	unsigned short suggested_cpu;
 	unsigned short eoi_cpu; /* EOI must happen on this cpu-1 */
 	unsigned int irq_epoch; /* If eoi_cpu valid: irq_epoch of event */
 	u64 eoi_time;           /* Time in jiffies when to EOI. */
@@ -871,6 +873,8 @@ static void mask_ack_pirq(struct irq_data *data)
 	eoi_pirq(data);
 }
 
+static int xen_rebind_evtchn_to_cpu(struct irq_info *info, unsigned int tcpu);
+
 static unsigned int __startup_pirq(unsigned int irq)
 {
 	struct evtchn_bind_pirq bind_pirq;
@@ -903,6 +907,14 @@ static unsigned int __startup_pirq(unsigned int irq)
 	info->evtchn = evtchn;
 	bind_evtchn_to_cpu(evtchn, 0, false);
 
+	if (info->suggested_cpu) {
+		int ret;
+		ret = xen_rebind_evtchn_to_cpu(info, info->suggested_cpu);
+		if (!ret)
+			irq_data_update_effective_affinity(irq_get_irq_data(irq),
+							cpumask_of(info->suggested_cpu));
+	}
+
 	rc = xen_evtchn_port_setup(evtchn);
 	if (rc)
 		goto err;
@@ -1856,12 +1872,17 @@ static unsigned int select_target_cpu(const struct cpumask *dest)
 static int set_affinity_irq(struct irq_data *data, const struct cpumask *dest,
 			    bool force)
 {
+	struct irq_info *info = info_for_irq(data->irq);
 	unsigned int tcpu = select_target_cpu(dest);
 	int ret;
 
-	ret = xen_rebind_evtchn_to_cpu(info_for_irq(data->irq), tcpu);
-	if (!ret)
+	ret = xen_rebind_evtchn_to_cpu(info, tcpu);
+	if (!ret) {
 		irq_data_update_effective_affinity(data, cpumask_of(tcpu));
+	} else {
+		if (info)
+			info->suggested_cpu = tcpu;
+	}
 
 	return ret;
 }


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



