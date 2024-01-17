Return-Path: <linux-kernel+bounces-29002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEB1830692
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8391C2196E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B229B1EB36;
	Wed, 17 Jan 2024 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amq5iLZg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE3D1EB25
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496781; cv=none; b=Xp8EOt6VggiQG0q3aka/ZOL4O8a27JetbiXmTbb1jDv09LkVNidlG1zlXzrFRnHZyJlCMv+tQAYOmeAaTivHbdSp1DQHGQ0Zi9qv3Qnxn6SNhAI6nXCOVq9mUpVhNyzwQfuj4QLqX86W5OTANRIRua09eUO0ekbnA3dDKYwnXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496781; c=relaxed/simple;
	bh=KUk5+ghGU1Dz8moEKZE0YTPzqZIlcAHT48h0wD3N06o=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JPKdDQU2Q4x9ZiX0pFN8Vaityt8OANS93H+Gwg0C7F4cAdK0L7U5nTTBFEKeDNn6jY9Pa5f0WLZfrZPODbWNZi3/FiQ6knsLRp/1VNo9AxSNZoYXWLnCT+zxyyt4mwySFtH/gF6mlOAVmeZlMeIDN285QItwSj0Xi8uHYnXwye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=amq5iLZg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705496778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiRAkIYwyF6dllf/mwQhoMSqFIs1r4sZIk6Sk9RII6w=;
	b=amq5iLZgk2kClDMmT8iErTtxxQ2RSMh3OWzXssW1QU284/FV2BVmclXHTaeMJBL+z6KR1L
	BRNJdMiYh3Z4ZE96ZOyAzb6B4juiU31U70LBUlSgu7xAVV0ht8CqJGRnH2+4GWqPD+6dPq
	z/xYyzoYuDW1/xaT/90gO7xszEOVCjs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-EfOO17UzMeOBPQQa0guscg-1; Wed, 17 Jan 2024 08:06:15 -0500
X-MC-Unique: EfOO17UzMeOBPQQa0guscg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78374422f12so60614485a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 05:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705496773; x=1706101573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiRAkIYwyF6dllf/mwQhoMSqFIs1r4sZIk6Sk9RII6w=;
        b=MZWAtF64QT9xjEZTZjxv4JbY/zA92FpZqrr28wbUhzSFqh35dw9MRpfnaPNkH16ntu
         HxuGeqphwsBGQ72TldOlJZdTkdoWYKk3cwL97zoZnv8h+FY/VGBmxA2QoT5w0v0qwLR9
         rJNWd4+npVkHFQv5MQB1NWqbPiZTPF3oMyLipflUb5l6z6rmSGL8GJQ3p+jAEkcrFug5
         JxWleCezj2PFBMhoaNcBiN+7fjlZJ2PsyHvp6M2ldGOSV7WaDzJMNx8WKy5uW1kS+zhe
         nszNvIlZS3KVCcZv169EN3vLrMtnENj7sxkELicskjG+Y0fZ+/+d3hTqGtm2kwmGcVCS
         zcDg==
X-Gm-Message-State: AOJu0YySCtQARPWa5B9Fp1o4xrSgzTO9LJeZ3reM5eULvZGC1kDw9jIG
	7ksy17x27I+ySFkTQUriE6Zxpj7bRs/RpfEDuPjmtcUePxpVNCebBT84+H+HvJcX9/X/1pZuX2G
	8H7cZ5NLpWLyGvKzvOPCkCD2YT0pgjd28
X-Received: by 2002:a05:620a:24d1:b0:783:5186:a4c1 with SMTP id m17-20020a05620a24d100b007835186a4c1mr8877052qkn.64.1705496773330;
        Wed, 17 Jan 2024 05:06:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECWy0fJTxzZUnQCSSIxrbIo9n8C1Lzg7gEFz/eieTQLB+KIyQAL1/f9qlc3IZ84pbdghTylw==
X-Received: by 2002:a05:620a:24d1:b0:783:5186:a4c1 with SMTP id m17-20020a05620a24d100b007835186a4c1mr8877041qkn.64.1705496773030;
        Wed, 17 Jan 2024 05:06:13 -0800 (PST)
Received: from localhost.localdomain ([151.29.130.8])
        by smtp.gmail.com with ESMTPSA id f14-20020a37ad0e000000b00781b8f4c89asm4470563qkm.43.2024.01.17.05.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 05:06:12 -0800 (PST)
Date: Wed, 17 Jan 2024 14:06:08 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] kernel/workqueue: Distinguish between general
 unbound and WQ_SYSFS cpumask changes
Message-ID: <ZafQwMw8ZKztunMU@localhost.localdomain>
References: <20240116161929.232885-1-juri.lelli@redhat.com>
 <20240116161929.232885-4-juri.lelli@redhat.com>
 <ZabRlEklmuqwFPj-@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZabRlEklmuqwFPj-@slm.duckdns.org>

On 16/01/24 08:57, Tejun Heo wrote:
> Hello, Juri.
> 
> On Tue, Jan 16, 2024 at 05:19:28PM +0100, Juri Lelli wrote:
> > Both general unbound cpumask and per-wq (WQ_SYSFS) cpumask changes end
> > up calling apply_wqattrs_prepare for preparing for the change, but this
> > doesn't work well for general unbound cpumask changes as current
> > implementation won't be looking at the new unbound_cpumask.
> > 
> > Fix the prepare phase for general unbound cpumask changes by checking
> > which type of attributes (general vs. WQ_SYSFS) are actually changing.
> > 
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > ---
> >  kernel/workqueue.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 3a1d5a67bd66a..2ef6573909070 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -4359,7 +4359,17 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
> >  	 * it even if we don't use it immediately.
> >  	 */
> >  	copy_workqueue_attrs(new_attrs, attrs);
> > -	wqattrs_actualize_cpumask(new_attrs, unbound_cpumask);
> > +
> > +	/*
> > +	 * Is the user changing the general unbound_cpumask or is this a
> > +	 * WQ_SYSFS cpumask change?
> > +	 */
> > +	if (attrs == wq->unbound_attrs)
> > +		cpumask_copy(new_attrs->cpumask, unbound_cpumask);
> > +	else
> > +		wqattrs_actualize_cpumask(new_attrs, unbound_cpumask);
> > +
> > +	cpumask_and(new_attrs->cpumask, new_attrs->cpumask, cpu_possible_mask);
> 
> This looks rather hacky. Can you elaborate how the current code misbehaves
> with an example?

I was trying to address the fact that ordered unbound workqueues didn't
seem to reflect unbound_cpumask changes, e.g.

wq_unbound_cpumask=00000003

edac-poller              ordered,E  0xffffffff 000000ff      kworker/R-edac-            351 0xffffffff 000000ff

vs. 

edac-poller              ordered,E  00000003                 kworker/R-edac-            349 00000003

with the patch applied. But honestly, I'm now also not convinced what
I'm proposing is correct, so I'll need to think more about it.

Can you please confirm though that ordered unbound workqueues are not
"special" for some reason and we would like them to follow
unbound_cpumask changes as normal ubound workqueues?

Thanks,
Juri


