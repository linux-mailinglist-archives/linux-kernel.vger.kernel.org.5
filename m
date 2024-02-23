Return-Path: <linux-kernel+bounces-78663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2B58616C2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C39285560
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5D784FA8;
	Fri, 23 Feb 2024 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TogWZUI0"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F119083CDB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704194; cv=none; b=D8FGnhPHg6lTwTZsUbUStuMJXRdMmcFBRt0FwVSiOTMZmcTLjfGOSs6iJBu+FeyGoRIDWAggy9CYlPpaKURV13pegplecMoT6woFELB63C8hnljfDdVPzzaM8h9YUEKU7e0wTLVWTASlH26T7GWpyTRrOIYH3XV+ZBBmcqDzTCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704194; c=relaxed/simple;
	bh=3SeLWcYUKeU9rPZeeJNsKyqBdzNTdQ2O7RMHxZVW+oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxNFmoNHutLVDhK08Q0Lj+jRxoZio2aKoWP/DSnLUjvfLKSzSmVeLE/rUGpzNwjdMA9LdG/UOJwxOnW4KM5zsaoLnibBJlU2s2QrAVyavvTk3wff2K6Ta61MMkHWacdjTrpxfYKFk9hnaw6x+w75BQwzGhSRBhzuU+MgNwkmB/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TogWZUI0; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <34da1e7b-029e-410b-8735-a10d6d267e2b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708704179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tb9I/0qh7vMUqYAYoxjxdAutOIV+p0jI9vJ6W+U4erw=;
	b=TogWZUI0oEVaZQT+5hJt4/5Z+Uvh0T8pp0mv8YuC3+nhhnS9zqvSrDqpVjOAjHLXC0/9vG
	21xGvA3RafhmU5ezX2MG3vTYSQrPBpUqeeVAS3M21PRWond/F9+huf42Ez0/ldVaEzZz4+
	+sbLjbDXZp87QUaDew7CzA7htNyK8BM=
Date: Fri, 23 Feb 2024 11:02:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND2 PATCH net v4 2/2] soc: fsl: qbman: Use raw spinlock for
 cgr_lock
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Roy Pledge
 <roy.pledge@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Li Yang <leoyang.li@nxp.com>, Scott Wood <oss@buserror.net>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Camelia Groza <camelia.groza@nxp.com>,
 Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240222170749.2607485-1-sean.anderson@linux.dev>
 <20240222170749.2607485-2-sean.anderson@linux.dev>
 <53b401d7-934c-4937-ab83-6732af47668d@csgroup.eu>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <53b401d7-934c-4937-ab83-6732af47668d@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/23/24 00:38, Christophe Leroy wrote:
> Le 22/02/2024 à 18:07, Sean Anderson a écrit :
>> [Vous ne recevez pas souvent de courriers de sean.anderson@linux.dev. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>> 
>> cgr_lock may be locked with interrupts already disabled by
>> smp_call_function_single. As such, we must use a raw spinlock to avoid
>> problems on PREEMPT_RT kernels. Although this bug has existed for a
>> while, it was not apparent until commit ef2a8d5478b9 ("net: dpaa: Adjust
>> queue depth on rate change") which invokes smp_call_function_single via
>> qman_update_cgr_safe every time a link goes up or down.
> 
> Why a raw spinlock to avoid problems on PREEMPT_RT, can you elaborate ?

smp_call_function always runs its callback in hard IRQ context, even on
PREEMPT_RT, where spinlocks can sleep. So we need to use raw spinlocks
to ensure we aren't waiting on a sleeping task. See the first bug report
for more discussion.

In the longer term it would be better to switch to some other
abstraction.

--Sean

> If the problem is that interrupts are already disabled, shouldn't you 
> just change the spin_lock_irq() by spin_lock_irqsave() ?
>
> Christophe
> 
> 
>> 
>> Fixes: 96f413f47677 ("soc/fsl/qbman: fix issue in qman_delete_cgr_safe()")
>> CC: stable@vger.kernel.org
>> Reported-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> Closes: https://lore.kernel.org/all/20230323153935.nofnjucqjqnz34ej@skbuf/
>> Reported-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>> Closes: https://lore.kernel.org/linux-arm-kernel/87wmsyvclu.fsf@pengutronix.de/
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> Reviewed-by: Camelia Groza <camelia.groza@nxp.com>
>> Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> 
>> ---
>> 
>> Changes in v4:
>> - Add a note about how raw spinlocks aren't quite right
>> 
>> Changes in v3:
>> - Change blamed commit to something more appropriate
>> 
>>   drivers/soc/fsl/qbman/qman.c | 25 ++++++++++++++-----------
>>   1 file changed, 14 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
>> index 1bf1f1ea67f0..7e9074519ad2 100644
>> --- a/drivers/soc/fsl/qbman/qman.c
>> +++ b/drivers/soc/fsl/qbman/qman.c
>> @@ -991,7 +991,7 @@ struct qman_portal {
>>          /* linked-list of CSCN handlers. */
>>          struct list_head cgr_cbs;
>>          /* list lock */
>> -       spinlock_t cgr_lock;
>> +       raw_spinlock_t cgr_lock;
>>          struct work_struct congestion_work;
>>          struct work_struct mr_work;
>>          char irqname[MAX_IRQNAME];
>> @@ -1281,7 +1281,7 @@ static int qman_create_portal(struct qman_portal *portal,
>>                  /* if the given mask is NULL, assume all CGRs can be seen */
>>                  qman_cgrs_fill(&portal->cgrs[0]);
>>          INIT_LIST_HEAD(&portal->cgr_cbs);
>> -       spin_lock_init(&portal->cgr_lock);
>> +       raw_spin_lock_init(&portal->cgr_lock);
>>          INIT_WORK(&portal->congestion_work, qm_congestion_task);
>>          INIT_WORK(&portal->mr_work, qm_mr_process_task);
>>          portal->bits = 0;
>> @@ -1456,11 +1456,14 @@ static void qm_congestion_task(struct work_struct *work)
>>          union qm_mc_result *mcr;
>>          struct qman_cgr *cgr;
>> 
>> -       spin_lock_irq(&p->cgr_lock);
>> +       /*
>> +        * FIXME: QM_MCR_TIMEOUT is 10ms, which is too long for a raw spinlock!
>> +        */
>> +       raw_spin_lock_irq(&p->cgr_lock);
>>          qm_mc_start(&p->p);
>>          qm_mc_commit(&p->p, QM_MCC_VERB_QUERYCONGESTION);
>>          if (!qm_mc_result_timeout(&p->p, &mcr)) {
>> -               spin_unlock_irq(&p->cgr_lock);
>> +               raw_spin_unlock_irq(&p->cgr_lock);
>>                  dev_crit(p->config->dev, "QUERYCONGESTION timeout\n");
>>                  qman_p_irqsource_add(p, QM_PIRQ_CSCI);
>>                  return;
>> @@ -1476,7 +1479,7 @@ static void qm_congestion_task(struct work_struct *work)
>>          list_for_each_entry(cgr, &p->cgr_cbs, node)
>>                  if (cgr->cb && qman_cgrs_get(&c, cgr->cgrid))
>>                          cgr->cb(p, cgr, qman_cgrs_get(&rr, cgr->cgrid));
>> -       spin_unlock_irq(&p->cgr_lock);
>> +       raw_spin_unlock_irq(&p->cgr_lock);
>>          qman_p_irqsource_add(p, QM_PIRQ_CSCI);
>>   }
>> 
>> @@ -2440,7 +2443,7 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
>>          preempt_enable();
>> 
>>          cgr->chan = p->config->channel;
>> -       spin_lock_irq(&p->cgr_lock);
>> +       raw_spin_lock_irq(&p->cgr_lock);
>> 
>>          if (opts) {
>>                  struct qm_mcc_initcgr local_opts = *opts;
>> @@ -2477,7 +2480,7 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
>>              qman_cgrs_get(&p->cgrs[1], cgr->cgrid))
>>                  cgr->cb(p, cgr, 1);
>>   out:
>> -       spin_unlock_irq(&p->cgr_lock);
>> +       raw_spin_unlock_irq(&p->cgr_lock);
>>          put_affine_portal();
>>          return ret;
>>   }
>> @@ -2512,7 +2515,7 @@ int qman_delete_cgr(struct qman_cgr *cgr)
>>                  return -EINVAL;
>> 
>>          memset(&local_opts, 0, sizeof(struct qm_mcc_initcgr));
>> -       spin_lock_irqsave(&p->cgr_lock, irqflags);
>> +       raw_spin_lock_irqsave(&p->cgr_lock, irqflags);
>>          list_del(&cgr->node);
>>          /*
>>           * If there are no other CGR objects for this CGRID in the list,
>> @@ -2537,7 +2540,7 @@ int qman_delete_cgr(struct qman_cgr *cgr)
>>                  /* add back to the list */
>>                  list_add(&cgr->node, &p->cgr_cbs);
>>   release_lock:
>> -       spin_unlock_irqrestore(&p->cgr_lock, irqflags);
>> +       raw_spin_unlock_irqrestore(&p->cgr_lock, irqflags);
>>          put_affine_portal();
>>          return ret;
>>   }
>> @@ -2577,9 +2580,9 @@ static int qman_update_cgr(struct qman_cgr *cgr, struct qm_mcc_initcgr *opts)
>>          if (!p)
>>                  return -EINVAL;
>> 
>> -       spin_lock_irqsave(&p->cgr_lock, irqflags);
>> +       raw_spin_lock_irqsave(&p->cgr_lock, irqflags);
>>          ret = qm_modify_cgr(cgr, 0, opts);
>> -       spin_unlock_irqrestore(&p->cgr_lock, irqflags);
>> +       raw_spin_unlock_irqrestore(&p->cgr_lock, irqflags);
>>          put_affine_portal();
>>          return ret;
>>   }
>> --
>> 2.35.1.1320.gc452695387.dirty
>> 

