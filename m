Return-Path: <linux-kernel+bounces-76161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5762B85F3A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B50A1C20B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA965374FD;
	Thu, 22 Feb 2024 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkqNP/ZU"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EC43717A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592225; cv=none; b=FUP5YvjVtonQu5hdRpXNlz45Oxyae5jh9vHzYKo0a4PON08GVaXtNNLokm3Nb4lfY1yAowH8AA4XWBXVss1qb/KAfjVV2KhJidj7elBTeQ1MHNezTp6LnPDiZMhqj2X/X0AavXMM/rmRRBH9B9VCGgeKEfAJfvJ5sh8iNibeIcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592225; c=relaxed/simple;
	bh=NpZ5tS6d21LqwPxzPJUK1xMCadzZOd38Mc0CFu903+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haiSfbRMpDWaah5iFQKJ5hC3lomFtF/veipq3zYuzK8gZK2PEynx8oy1BdW3sfjzu8C7fhkfHZa3NALtaMvNiEarqUTVe7wV1cchj2hdlH3KcwywFtSxaX/kKw9F5CC6x3gtnCiWxKXfVqHQsDmmLnLpG+vLG+p47KzJO7ZNk3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkqNP/ZU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d953fa3286so52536285ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708592214; x=1709197014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xPrSdUrQ9nYY/JtS+3HexNV6OHve9zWpSolr82c610=;
        b=KkqNP/ZU6xIsgZN4vwyosUDKJ8ZbHABDVsn8jtvFXP9rCG84zzGjQ2dOyuSk2qCRnh
         Z5Hj2VC/N8IF0Cg9hD7ldLljJDX0QDMba3Rm8gycxk3APXd25L0LLMrl66ORlHA2YzPJ
         SzqTQPfB+N04KPG4J7vhB93IqWJ8RzblENo9D4DI02yMrABC+axBvQVFGis/spbSl0W3
         o0dWrOSp/h9++a5rQgUKnU+FiWxUl0RS3uFw3xIxz0P9Ddm2sUNCJ+1lqS/HFHiLnpMj
         2s7PE2aT7lWOY4zvgb15zDVvqe8Hsx/xa5J0G4w2dvOakanP/bJWZ0Hjy7DqkLgPW8wu
         aN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708592214; x=1709197014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xPrSdUrQ9nYY/JtS+3HexNV6OHve9zWpSolr82c610=;
        b=O6CLXnaxr2TaipHNhUerjox9Sin29jH0p7D1idmLXMMfdnA5cb3qZnHromlVcZZ+qL
         67Tbkl7Csog9BPnGp8nR/O0paTbNzykzPXmhkbl/7pKLaC8xW52Cn3MDfoQA7QhN6wTr
         SjpfToyJTi2dGvH5slEA5t+6GI3Ocv5PgqvVhOSqfP2nhKVPlHha3Srd8rSc3Gi0AxBL
         Yhj1nlRyrRPMc9To8IPUMsZCMohuyWxuoHkMopyfpoen3GtKy5hGSvSnIllT4atZN7w4
         5adS8GTJsSUpQZP3fWtEeAZsHLXEd0WxUFJ2BPBZkbH+rIQVY77PEYQBzYuF2e82kYw5
         5Taw==
X-Forwarded-Encrypted: i=1; AJvYcCU5eOGlcoJsiZeEXjv0tXCC9/+OML1ikGQXVBABABTV5YsQdkjIKb+iD20c+AL4+nfyEUhTTOsYBxVmBDt2uPjoBrPAL2d/fBWtUBIB
X-Gm-Message-State: AOJu0YyX737cBwl6nXMUrRF+E23c2slG27XeaC7IMqmXKdTXyovEuXwq
	F1yyHcpABfh2tozNRArpXhVTWqLslF8dKYdnJQO+sDkKFL+26BuH13ITCPHEjRU=
X-Google-Smtp-Source: AGHT+IEU38lZwMj6d9B6lZw3xBJm4KOg072bF1Iu+hvCRiykTeZnQzL49PJ/+vfG0QISNRUPQFTtnw==
X-Received: by 2002:a17:902:6502:b0:1db:65a3:e17f with SMTP id b2-20020a170902650200b001db65a3e17fmr17978911plk.6.1708592214180;
        Thu, 22 Feb 2024 00:56:54 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id k23-20020a170902761700b001db8f7501b1sm3948710pll.2.2024.02.22.00.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:56:53 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 21 Feb 2024 22:56:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHSET v2 wq/6.10] workqueue: Implement disable/enable_work()
Message-ID: <ZdcMVA_IDptAPsrW@slm.duckdns.org>
References: <20240221174333.700197-1-tj@kernel.org>
 <CAJhGHyCJS7Pb_5dwTQtcZ25yOVzxFULJEYT4o3id_3xdj32EYA@mail.gmail.com>
 <CAJhGHyB-i-1S3ToYYKtri0Zz1ERikctGQHSjr=tbkD-WXHJe8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyB-i-1S3ToYYKtri0Zz1ERikctGQHSjr=tbkD-WXHJe8g@mail.gmail.com>

Hello,

On Thu, Feb 22, 2024 at 12:59:17PM +0800, Lai Jiangshan wrote:
> I think it would be better if the tasklet developers were CCed in this patchset.

Sure.

> Intended API conversions, along with their rationale and any possible
> changes to semantics, can be included in the cover letter too.
> 
> > - tasklet_setup/init()          -> INIT_WORK()
> > - tasklet_schedule()            -> queue_work(system_bh_wq, ...)
> > - tasklet_hi_schedule()         -> queue_work(system_bh_highpri_wq, ...)
> > - tasklet_disable_nosync()      -> disable_work()
> > - tasklet_disable[_in_atomic]() -> disable_work_sync()
> > - tasklet_enable()              -> enable_work() + queue_work()
> > - tasklet_kill()                -> cancel_work_sync()
> >
> > Note that unlike tasklet_enable(), enable_work() doesn't queue the work item
> > automatically according to whether the work item was queued while disabled.
> > While the caller can track this separately, unconditionally scheduling the
> > work item after enable_work() returns %true should work for most users.
> 
> unconditionally re-scheduling the work item isn't correct to me which might
> queue a work unexpectedly.
> 
> tasklet_enable() should be changed to return true if and only if when
> the disable count reached 0 and the disabling (action and status)
> have prevented a queuing request.
> 
> To record whether the disabling prevented a queuing request, an extra bit
> in the work->data has to be employed for it.

So, I'm not sold on this argument for two reasons.

1. cancel_work() and friends have always indicated whether the work item was
   queued at the time of cancel and ignored whether someone tried to queue
   the work item while cancelation was in progress. While it is important to
   make transition from tasklet reasonably easy, it's a lot more important
   to keep the interface consistent with the rest of workqueue.

   Possible confusions in transitioning from tasklet are temporary. If we
   introduce workqueue interfaces which aren't congruent with the rest of
   workqueue, those confusiongs are going to last a lot longer.

2. Work items don't count how many times they're queued. The only thing they
   guarantee is that they will get executed at least once after the latest
   queueing, which means that the users usually have to have some type of
   state tracking - whether that's a queue of operations to perform or some
   flags tracking what needs to be done.

   It's possible to write and there likely are examples of code that depends
   on work item never executing spuriously. However, tasklets are usually
   used in the fashion of irq handlers and they almost always have something
   else tracking what needs to be done. I spot checked a dozen tasklet users
   and couldn't find anyone who doesn't. While unlikely, if there are usages
   like that, it isn't all that difficult to update them so that they don't
   break. Again, possibly a bit of conversion pain but it shouldn't be too
   much and we'd be better off this way in the long term.

Thanks.

-- 
tejun

