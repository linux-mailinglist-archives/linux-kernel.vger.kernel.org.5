Return-Path: <linux-kernel+bounces-103540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A47487C0D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3339284BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D82570CDE;
	Thu, 14 Mar 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+NbZ9mQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC2673181
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432032; cv=none; b=qSLB5Azk0fJ+3VuFoRXA7/xX0EnTbklbfqjp0RDFk6xPW7TJRUsuyLtXw6oXtd2jcd0+XGNQnzh2aCq8PlzRzSsGyLgK/R8/fIIRkRMW5AwYJvKDqKK+goeh4HqFDtmKJ94kNpdWwhJciCDvO5nlc/Iwbpql9JcFU/DD4N1JdbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432032; c=relaxed/simple;
	bh=7QjiuBQBRyT+9k4iTSOFxeijm4WCgkFheISPv0kW21k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UEDfYggGD2A4kAc2DEjvmx/R5qUhpwmjP+fjfG6pX91wZMg+IvKyxJTfpUi19j4TybPPpC6RKnfE5Ds/zmf9a+umbJin1ht86bLYcJ3P9k/twusfwpCy2fFjmLqbD20emdTsMXmBxFeZpMdRJo0CZUXtb7B583LziuU6RSdNI5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+NbZ9mQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710432029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QjiuBQBRyT+9k4iTSOFxeijm4WCgkFheISPv0kW21k=;
	b=a+NbZ9mQVyrL+wm/YiPDjqALwRDIXpyXbJxPE7ubpajZv0KpjQI/1Kd8Kbf7aATjF8w8Ye
	JgbaNK4lsJ6Iogviva99mw8gLf1+qYR21jnW56CAxNIOJaLM0TXX4MRMw+b9CbjxGArWqd
	n/xY9FWOE6Eh/GdQpO/6uNhnUQprlPY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-yWhzMBIeN826XPS1AxCOQA-1; Thu, 14 Mar 2024 12:00:25 -0400
X-MC-Unique: yWhzMBIeN826XPS1AxCOQA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e40126031so5844415e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710432024; x=1711036824;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7QjiuBQBRyT+9k4iTSOFxeijm4WCgkFheISPv0kW21k=;
        b=QKdjBJBU9C0MnS1pbdh+s2sCycviypsniq9DcRcazQMilBo7gwHdIcf51cnfUP/Yin
         CnXqiUBV9+B9NhfeSk7XpBxOmLeJxZDfpGvmYb4bbaFB33oWu0c7mzzgFVOXBaQAA+6M
         zgW99Ied1wEQt6dCSD9kQvCtkeWjVU54PUKatcJafa5jcRpGfhpIQhxLPm8toFIJHgGE
         pj6NyMunDBwpFrKzUE0pdOibORwNfjnGaXEsEIt/KegDSljfFKk9J6RqwvpRuOEiuFj4
         WghNHap9MIEAqE+48Msd6IHE0AXfeCiWGCo0RsvNYGaH276jm3T6Z/7nCaZZnDz+SPII
         0Sow==
X-Forwarded-Encrypted: i=1; AJvYcCXsNwk2TXqefgpndlDNCCtpyZDw6WpMsyBGcd3H45lgbNFt/Wue8QtadKAfzNsx2MWMQC/NxHvcZ+4Iu/eyllkdAYNNbYSRLirrfox6
X-Gm-Message-State: AOJu0YwTyRbeo96RnRGC++VBTs83Jz6wlW+2VUGJFJ86Bl4yjw3rtcI6
	a/K/idN/B5kriwMpnj4se39ZBfjiLry00VkIyEfcREScz5MGM18+vQzzcW4WR6q8PNfCw8exL2z
	JgC0ovTyyARuBaLxb8teQ0OR64o64XXVQgRKyev4y+7W0ocI6i2UaHs8HWiyiAQ==
X-Received: by 2002:a05:600c:450f:b0:413:286c:4fc0 with SMTP id t15-20020a05600c450f00b00413286c4fc0mr315570wmo.34.1710432024057;
        Thu, 14 Mar 2024 09:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2tOqao4TMwOT3g3Hy6m0Z9ITRUlzMpqp4+Nsd+qQNSxpdMyyiCnfDrSmoUMHir24grTWrwQ==
X-Received: by 2002:a05:600c:450f:b0:413:286c:4fc0 with SMTP id t15-20020a05600c450f00b00413286c4fc0mr315551wmo.34.1710432023735;
        Thu, 14 Mar 2024 09:00:23 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id q13-20020a05600c46cd00b00412e5f32591sm2761945wmo.28.2024.03.14.09.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 09:00:23 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Maxim Moskalets <maximmosk4@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot
 de Oliveira <bristot@redhat.com>, linux-kernel@vger.kernel.org
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
Subject: Re: [PATCH] kernel/sched: use seq_putc instead of seq_puts
In-Reply-To: <20240303110500.15239-1-Maxim.Moskalets@kaspersky.com>
References: <20240303110500.15239-1-Maxim.Moskalets@kaspersky.com>
Date: Thu, 14 Mar 2024 17:00:22 +0100
Message-ID: <xhsmho7bgdcrt.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 03/03/24 14:05, Maxim Moskalets wrote:
> Using seq_putc for newline characters is faster and more appropriate
> than seq_puts, since only one character is passed and there is no need
> to use a more powerful and less fast function
>

Why not, but then why not do this treewide? A quick grep shows ~340 such
sites. That makes for a fairly easy coccinelle patch.


