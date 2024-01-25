Return-Path: <linux-kernel+bounces-39332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA0C83CED4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931551C21D48
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348E413AA50;
	Thu, 25 Jan 2024 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcXiMWJZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9703C13A272
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219245; cv=none; b=CvXCx29PfCxRgo2Dcgw3hxs/FAN9bS+KkyXvZiC6pQoF0LgfTlm4Sk7xdIzPvOx5iWoEeA7Q/NWhyuN1DoJeiMlzhl+XuZXLwJMKDPuLTTwNWVG7+vXZ1uvA+7hA3Ibj/n5NGCLx4ly4rJdk3AJ3Mm8KIhxroyino9dTyTpkshM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219245; c=relaxed/simple;
	bh=NcaE8S5NwQHT5Tq0RlWwGiOlHY6ORi1hFNchO5th4hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=DIr1Yr/NwgC+J/XyPUrHlTxICYnKSwjPuExQKPwPq9+3lDNTa+QweihaTVgsAKnqYE6LoXH2CKPxT0nX6DAXSist5f8AJDbF6WxXspV8TxDJgby78nE2iirFMGwjT52QHZrjDzSTC+qOgE4+rSc+bYgEdkv7uCQGHFFFN2kfDXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcXiMWJZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706219241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f6m+zu3oNEJHiwD8qfoMPQzECOUmp8yU0Qm9W6z7sE4=;
	b=QcXiMWJZu+AGOKu6W5kpKqtiYsQCS5z+HAq2DRQ99WAvlJLcuUtk66UTd8OQM/C+I3TWlL
	YYXNOW43HPAX8hTqweQYUVVitA5vvg4TY5ERKnKqjTNrhUr78U6FyaOxiHP4tGnIluNqeQ
	e9UUtxC0X3sccvJRgCIGTJ1RhmKis9Q=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-sDAaEQhtPkOmeEQU79Up1Q-1; Thu, 25 Jan 2024 16:47:20 -0500
X-MC-Unique: sDAaEQhtPkOmeEQU79Up1Q-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5cfda2f4716so2452475a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706219239; x=1706824039;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6m+zu3oNEJHiwD8qfoMPQzECOUmp8yU0Qm9W6z7sE4=;
        b=xQn3+8V1UpN/YHnpCf5kj57zqimGZY1cRuQ4vAQCxMxnEmfTpS7WPwMsB2FBYntvwG
         HlRAsVuT1K0QcXGe15sEc5jTBH0cdmXgzYSLb88PQueToTmlmyAaJBHUXWIeqrU7StSQ
         AVQr00zyAIl/u549wS5d4djSKQpbks+XeUV4oMtuVG/ynPWnSJe2qJ5cPnclPv/ywujI
         piIdUP9jnRxwcm6akxyZpfg7a/wQNC9KM57oNW59AzZ1tsr55AlBaI8sDPUkuyaf2jio
         GfubikiQsA3ZAzOTvo0pL7i3qQMEIn12uceY5nxNxy67quaFpNtSnqpLVAGkGjMsrdKf
         +l6g==
X-Gm-Message-State: AOJu0YzFoypPQI9QYtaWKcQOTsozg1bHPHTfOPmseHKssORyFaJ/VxJ4
	K4qQc2p4JSIKVU1vnlY9OfilhiuUFM1e83yXM5WxCE5k2IcN33excHFNCnQPyX/YYfM6fJMOB3J
	p250Ec8MOkmx89nnLaXCll+3s/sXosZgcBbsUNDGhpM0yEOdUmd79GF069tYupw==
X-Received: by 2002:a17:902:c942:b0:1d7:8cd6:63d with SMTP id i2-20020a170902c94200b001d78cd6063dmr428542pla.106.1706219238867;
        Thu, 25 Jan 2024 13:47:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWJC5YTpRbaoh14bsl5ibY91uvk6x3YL/0dEVyxqwYJypzaQhTZ2Llob8V9gb1yptW7SOgSA==
X-Received: by 2002:a17:902:c942:b0:1d7:8cd6:63d with SMTP id i2-20020a170902c94200b001d78cd6063dmr428530pla.106.1706219238486;
        Thu, 25 Jan 2024 13:47:18 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a803:96a5:ba81:becc:80f3:6a79])
        by smtp.gmail.com with ESMTPSA id mm14-20020a1709030a0e00b001d7222d8caasm10460079plb.50.2024.01.25.13.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 13:47:17 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] wq: Avoid using isolated cpus' timers on unbounded queue_delayed_work
Date: Thu, 25 Jan 2024 18:46:33 -0300
Message-ID: <ZbLWubUjuzFUKD5R@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZbKqoeC7JVcJULdI@slm.duckdns.org>
References: <20240124082938.2527697-2-leobras@redhat.com> <ZbGFce8ixJKb6umE@slm.duckdns.org> <ZbG9TjHAMJYIvwsg@LeoBras> <ZbKqoeC7JVcJULdI@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jan 25, 2024 at 08:38:25AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jan 24, 2024 at 10:45:50PM -0300, Leonardo Bras wrote:
> > That's a good suggestion, but looking at workqueue_init_early() I see that, 
> > in short:
> > wq_unbound_cpumask = 	cpu_possible_mask & 
> > 			housekeeping_cpumask(HK_TYPE_WQ) & 
> > 			housekeeping_cpumask(HK_TYPE_DOMAIN) &
> > 			wq_cmdline_cpumask
> > 
> > So wq_unbound_cpumask relates to domain and workqueue cpu isolation.
> > 
> > In our case, we are using this to choose in which cpu is the timer we want 
> > to use, so it makes sense to use timer-related cpu isolation, instead.
> 
> - In the proposed code, when cpu == WORK_CPU_UNBOUND, it's always setting
>   cpu to housekeeping_any_cpu(HK_TYPE_TIMER). This may unnecessarily move
>   the timer and task away from local CPU. Preferring the local CPU would
>   likely make sense.
> 
> - If HK_TYPE_TIMER and workqueue masks may not agree, setting dwork->cpu to
>   the one returned from HK_TYPE_TIMER is likely problematic. That would
>   force __queue_work() to use that CPU instead of picking one from
>   wq_unbound_cpumask.
> 
> > As of today, your suggestion would work the same, as the only way to enable 
> > WQ cpu isolation is to use nohz_full, which also enables TIMER cpu 
> > isolation. But since that can change in the future, for any reason, I would 
> > suggest that we stick to using the HK_TYPE_TIMER cpumask.
> > 
> > I can now notice that this can end up introducing an issue: possibly 
> > running on a workqueue on a cpu outside of a valid wq_cmdline_cpumask.
> 
> Yeap.
> 
> > I would suggest fixing this in a couple ways:
> > 1 - We introduce a new cpumask which is basically 
> >     housekeeping_cpumask(HK_TYPE_DOMAIN) & wq_cmdline_cpumask, allowing us 
> >     to keep the timer interrupt in the same cpu as the scheduled function,
> > 2- We use the resulting cpu only to pick the right timer.
> > 
> > What are your thouhts on that?
> 
> How about something like the following instead?
> 
> - If current CPU is in HK_TYPE_TIMER, pick that CPU.
> 
> - If not, pick a CPU from HK_TYPE_TIMER.
> 
> - Do add_timer_on() on the selected CPU but leave dwork->cpu as
>   WORK_CPU_UNBOUND and leave that part to __queue_work().
> 
> Thanks.

It looks like a good idea to me.

It's basicaly (2) with "keep the timer in this cpu if it's not isolated", 
which seems the right thing to do.

Thanks!
Leo


> 
> -- 
> tejun
> 


