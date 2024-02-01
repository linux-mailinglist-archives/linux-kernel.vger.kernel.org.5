Return-Path: <linux-kernel+bounces-47949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CBC845510
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E1B1C25017
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C497F15B111;
	Thu,  1 Feb 2024 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Htb66U/C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3F71586E6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782699; cv=none; b=s3z6dV9sJF3+h1nhQBXqhGr5GeTzYVG5KRwX+SSezATgoddBjrvDZtd5c2jsTOHCRF49cktt5+rCbQnpE54ref09nE6HUF50uVVS2DOVCG2BQ6tmeg6GzZ1rs5DgpKfTksD/0SxbOrNG8oKH3l9nMo1dzo/KCDwYnn+WCA61F20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782699; c=relaxed/simple;
	bh=1HfJGHNVvdEAyf53JhA/TQKpIP4/ve8BmZVTF6bOHEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jlt9EY1mHHH/mI+yp4OVExe3zJ9OJxWwrhP9maA1ZISX7KbPthh9arcmNAhQ3J5AAYg61VEEfZ4tY7QI1d+AE/57R3FV0oTkQgp+7gL5E0YAVo5DGnolOGEtna+wc/hQViH2mA8uEP6UKWlK9eLQxothrx7i82KQ6Kp+DzUlWHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Htb66U/C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706782696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jDy8qMMA55AKgVosxl6RqKwoMWR5lT1S9B1uXJ8N2Ak=;
	b=Htb66U/CNi/9t/cOwl7H0LEtE7BznmBzT6PNWZMqvWI02k7vQYOVAy24rW0DeyzYbpijyN
	0qidgSuipXcQXGrlr39x4xdAJysenvM26cz/bAST1fE8jFm/o6/F/fEkuNk+5ckScWnldQ
	byxBtI46+lLeHXpsudmnlNP1wPtQI88=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-koDl_EePPiGb-b59jBeY3w-1; Thu, 01 Feb 2024 05:18:15 -0500
X-MC-Unique: koDl_EePPiGb-b59jBeY3w-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5101e826a3dso605343e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 02:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706782693; x=1707387493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDy8qMMA55AKgVosxl6RqKwoMWR5lT1S9B1uXJ8N2Ak=;
        b=BsTOPoNg16J0kGel6dpXP45JVVTzTInsnhLM3AFB5wuurHda1XRRLKGv++olyidgMr
         vwmHMbYKIdgvXFl+CW2Os2ogiZMMCBWptdo6QmLxnY1HWy7+AuQxu01Ph98K1nnM1fPI
         7wnRfoc6J9Ffjv76tqcILG8wQf/KoUdjOap+dLcL6XL+37x5m0are7BqKpFrANzKfn1i
         o+ocWPxuqcQyszYUtrSjKdjBpL/KmOJEqspCI+FD+dEcN0VbjLKUiCdVZKRkE+9DIii7
         nmOYOuEks07wkZcZeuAXECmgFxdX5IIliMUAj/nAmPoXC8KuLNyV+li7LBlznIJ7ge0t
         w7QQ==
X-Gm-Message-State: AOJu0Yz/STWVe7jeabDb9AazXiNhZ2cTKWn+xh3LHwTGbuCkCsDiAuzT
	4jJM6hig1TY8CG0mewf9hrDTjxaVCO3dvYO6PI/vQ+2LQAbwk7WKpE7VEG6ufADgfoBlyno40lI
	fMAD71S/YbjXupLCcay36NpeA8Q/yZcSnfJVYf9WDwZJ9FfkZL8xfYyUIaVavLw==
X-Received: by 2002:a19:f812:0:b0:511:f07:b2cc with SMTP id a18-20020a19f812000000b005110f07b2ccmr1550076lff.32.1706782693565;
        Thu, 01 Feb 2024 02:18:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZrxIcf+hc9jhz/xRsVxgHlk+RuzEuI5h5BsEGolVmmKFKeL4GQLXufYo2AOftMfryVQQLYw==
X-Received: by 2002:a19:f812:0:b0:511:f07:b2cc with SMTP id a18-20020a19f812000000b005110f07b2ccmr1550063lff.32.1706782693194;
        Thu, 01 Feb 2024 02:18:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUYSmzKmKnqhmEl97dijC6M6XUtw28yKvZV1GTuAr/q+0yxl+rcCl66T8QXENFpdmfe/B/IGodwDTGWQTRnqdOfscJAimHLISJWkg9PYXTHbOHoWL9AP5iig5x9POH7K2YuJwgrC4lgKm+10oNsAhTAYHriughV3kqGONTCaXm7Z1YvBontJhKlk0ADsUg=
Received: from localhost.localdomain ([151.29.75.172])
        by smtp.gmail.com with ESMTPSA id bh23-20020a05600c3d1700b0040d5a9d6b68sm3966505wmb.6.2024.02.01.02.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 02:18:12 -0800 (PST)
Date: Thu, 1 Feb 2024 11:18:10 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>
Subject: Re: [RFC PATCH 0/3] workqueue: Enable unbound cpumask update on
 ordered workqueues
Message-ID: <Zbtv4v2KCKshnCL2@localhost.localdomain>
References: <20240130183336.511948-1-longman@redhat.com>
 <ZbpElS5sQV_o9NG1@localhost.localdomain>
 <89927d84-279a-492e-83d3-6d3e20b722f7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89927d84-279a-492e-83d3-6d3e20b722f7@redhat.com>

On 31/01/24 10:31, Waiman Long wrote:
> 
> On 1/31/24 08:01, Juri Lelli wrote:
> > Hi Waiman,
> > 
> > Thanks for working on this!
> > 
> > On 30/01/24 13:33, Waiman Long wrote:
> > > Ordered workqueues does not currently follow changes made to the
> > > global unbound cpumask because per-pool workqueue changes may break
> > > the ordering guarantee. IOW, a work function in an ordered workqueue
> > > may run on a cpuset isolated CPU.
> > > 
> > > This series enables ordered workqueues to follow changes made to the
> > > global unbound cpumask by temporaily saving the work items in an
> > > internal queue until the old pwq has been properly flushed and to be
> > > freed. At that point, those work items, if present, are queued back to
> > > the new pwq to be executed.
> > I took it for a quick first spin (on top of wq/for-6.9) and this is what
> > I'm seeing.
> > 
> > Let's take edac-poller ordered wq, as the behavior seems to be the same
> > for the rest.
> > 
> > Initially we have (using wq_dump.py)
> > 
> > wq_unbound_cpumask=0xffffffff 000000ff
> > ...
> > pool[80] ref= 44 nice=  0 idle/workers=  2/  2 cpus=0xffffffff 000000ff pod_cpus=0xffffffff 000000ff
> > ...
> > edac-poller                      ordered    80 80 80 80 80 80 80 80 ...
> > ...
> > edac-poller                      0xffffffff 000000ff    345 0xffffffff 000000ff
> > 
> > after I
> > 
> > # echo 3 >/sys/devices/virtual/workqueue/cpumask
> > 
> > I get
> > 
> > wq_unbound_cpumask=00000003
> > ...
> > pool[86] ref= 44 nice=  0 idle/workers=  2/  2 cpus=00000003 pod_cpus=00000003
> > ...
> > edac-poller                      ordered    86 86 86 86 86 86 86 86 86 86 ...
> > ...
> > edac-poller                      0xffffffff 000000ff    345 0xffffffff 000000ff
> > 
> > So, IIUC, the pool and wq -> pool settings are updated correctly, but
> > the wq.unbound_cpus (and its associated rescure affinity) are left
> > untouched. Is this expected or are we maybe still missing an additional
> > step?
> 
> Isn't this what the 4th patch of your RFC workqueue patch series does?
> 
> https://lore.kernel.org/lkml/20240116161929.232885-5-juri.lelli@redhat.com/
> 
> The focus of this series is to make sure that we can update the pool cpumask
> of ordered workqueue to follow changes in global unbound workqueue cpumask.
> So I haven't touched anything related to rescuer at all.

My patch only uses the wq->unbound_attrs->cpumask to change the
associated rescuer cpumask, but I don't think your series modifies the
former?

Thanks,
Juri


