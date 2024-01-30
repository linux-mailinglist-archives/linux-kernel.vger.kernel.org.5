Return-Path: <linux-kernel+bounces-44876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15706842868
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61D9286910
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB8682D99;
	Tue, 30 Jan 2024 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eH+Yct7B"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E418613E;
	Tue, 30 Jan 2024 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629837; cv=none; b=tGRS1KCK0Xxcu8ijclty+DYADP31cs6oz76o2Ke/qbuZg16afAHbECXTAMxrj/jzsYqCDspZ2j4r1LJVgicfGXVFZXFZTIGD1E+IlBnWbNM+bFode8j47D7pPdmhUBb15GDYMEPBR1WPYCezPC2MocMzRqksarSJRxXAQ7HdzOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629837; c=relaxed/simple;
	bh=QvBaZsLh8DPvYcl3VO8X2y1UuYCG/UYWMaa3pZVysnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0w1ePbXAJwX+MRP0pT0shgH5b1xZW/oOX474GLWCi884VAP4wRui2AX4nr+VZYt58Nl4e2oKxBoJerIgQSOezF6qqM6nfpfIPx8ZGsbcwVA3w7khCGRfC/EKrS5OGSUtC0q/vSnHjsk/Is5dI9io4UIep72sjmtyexie1Muinw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eH+Yct7B; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d8cea8bb3bso12134065ad.2;
        Tue, 30 Jan 2024 07:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706629834; x=1707234634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XL1Fflhk+Xb40dzgpJerE8E3hGMxHAI4xcbrdBQFd/M=;
        b=eH+Yct7BzuiUCYPqw61A+ywaYaN0Z6mvbZ86gGRPWUjIV2G+hR7aAX1K7lMkvV8exh
         dcd9DxGWgEMTrchX50UZBJj/4E24i4ggGmpW6xxr0I0s+WoRwzlDtg6MLo2WVpHe8nV+
         oXG0Hz5q1zNPpD5FhN+xHsWo3Ya9Db/Y2Z8wtxhrJz4evULygQF0nMV8nzpVaH9QW585
         wrtaagWQUj6/xb8TFO0N3Fng8AYiH+KrK77JAeiZ0kCXTzbBiIcAfCJhxCOpYf2T9iOe
         u7snojzX7fgLQ7IynUqKAyK2fui1AppUHh7Z0dp2MENLbQCaMlHYFlVeftx17KxAbVi7
         GziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706629834; x=1707234634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XL1Fflhk+Xb40dzgpJerE8E3hGMxHAI4xcbrdBQFd/M=;
        b=PpM+IiRxgAd86XHK9/k9LsV4QbAi7tLphsZMyVtmJZ6nuSvxajre1k08pK4cE2tZ61
         2u0KaARhFxAVyGDrYBzcOw86pIW8LDNwi/PO8RpAVhrrMusSLvfJ3J3G70FJlflWTL31
         7UaMAZV5WesHzCw9klSVJFrDh864lz72xf6LnU60lSBjk23QiFX0fgVDB72hm+GfKHor
         1Rim0GcWHGy1C2PWfb8Jysh9bSWiOhelhojYrg2gzWIIdGhMy6mgYOe3U3LalCqU+dVo
         brOXNRI73iQfdnsgJrTAXcGnaKEmF8qpvCVz0k8fsgvLX+T27psHe0DP7+Tt+Zoko648
         Er6Q==
X-Gm-Message-State: AOJu0Yx4aTqj96zQ9H9o5SvdovYPdsAvonbOXnhtbA6vmPRFLspJfoTN
	IiXF4JayazmkLPvQQ8ZcgCtnI90nPcAM+jFDztu1ZeYatIanAyzy
X-Google-Smtp-Source: AGHT+IHIMCnEYaqIb4Pi3z0PuUNUYde12Aucu4qoHrB+Jeqg1FHSLC8058xLuEM1zdrmgWVouVt3kw==
X-Received: by 2002:a17:903:40c3:b0:1d8:d2b8:446a with SMTP id t3-20020a17090340c300b001d8d2b8446amr5082317pld.27.1706629833562;
        Tue, 30 Jan 2024 07:50:33 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902724600b001d8aadaa7easm6480425pll.96.2024.01.30.07.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 07:50:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jan 2024 05:50:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com,
	bob.liu@oracle.com, houtao1@huawei.com, peterz@infradead.org,
	mingo@kernel.org, netdev@vger.kernel.org, allen.lkml@gmail.com,
	kernel-team@meta.com, tglx@linutronix.de
Subject: Re: [PATCHSET wq/for-6.9] workqueue: Implement BH workqueue and
 convert several tasklet users
Message-ID: <ZbkayGEYJNJx3ohw@slm.duckdns.org>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130102011.rX9Qjnp1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130102011.rX9Qjnp1@linutronix.de>

Hello, Sebastian.

On Tue, Jan 30, 2024 at 11:20:11AM +0100, Sebastian Andrzej Siewior wrote:
> If one context creates multiple work item which are then moved to
> tasklet I don't see the difference vs workqueue with a bh_disable()
> around it.

The main difference is that it avoids scheduling latencies in scenarios
where softirq isn't heavily loaded.

> Looking at the USB changes, I would prefer to see it converted to
> threaded interrupts instead of using tasklet or workqueue. Both
> approaches (current tasklet, suggested workqueue) lose the original
> context where the request was created. Having threaded interrupts would
> allow to keep everything in the same "context" so you could prioritize
> according to your needs.

That's great. If threaded IRQs or even regular workqueues are suitable, that
should be fine. This conversion is just targeted at the use cases which can
benefit from executing in the softirq context.

Thanks.

-- 
tejun

