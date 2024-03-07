Return-Path: <linux-kernel+bounces-96198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A6287586D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E74B1C21CAE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164C843AA1;
	Thu,  7 Mar 2024 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGAsX7yy"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7834E1C3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843511; cv=none; b=A3PZrSRIM226Zz6y1eqxvmpsjGROhK2alck0nQhdOxOFPgc4toh9PhKG3G7VcbAiTGHuar1QWtvaaSPAnPJz/+oJeRmvi3tekwgxzZohDSzADckzNBRiJ7fmrAjpqtVjlgHIcjTh/jFPDAXR8QpAX/E9rBtsNfW51Nsp1fTuIIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843511; c=relaxed/simple;
	bh=B6jTRt15Ay+YE96kV68Fuqz0cpG6G9QiBhLFa45Ajbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oB0W1UwlkU7cFrOSKFn9ZhG7TbFr/BOJCm5v73n63F3HqiRit6H7Dd6xV0MvEF/q3iexEtTcxbm7NmcbJ2DEusRquD+RVs1U4TVUA3xyJkROZkFxiTNRQUkgv6eCBFMsQLN6nNHJwxIQPhiAt7rEgdHWQlKGBzo0gqsYv+358wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lGAsX7yy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60802b0afd2so12653567b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 12:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709843509; x=1710448309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bl6KQ7zqxCRRy7mV9HLzLwrJU3k8ZyxTlFOkk6jrrGQ=;
        b=lGAsX7yyzp8GG46dHNbIoSl1UQJaMPStyehKmcIMhjeiFWZNqxXAu7QxTKXfXd0aRs
         D8VE+CKwxw4YlTPQDPsH8odw5m23/wqXZJHo7CsltotDZ8vgxoqcDRdjQWH2c6ijV+dk
         /G9MkKYeHCwgfOply9CR5GsMmNBJeC5A9UM8zCkPmbwdBBGZpaKyaoD8F0wQEj6OojZD
         FdRqFQI5Glz7yTGjKVWuUAzUyjBc3eqjvMQMha6SgCc3mNsDrH9hpsHqc+j2IvDRueE1
         mW02UcKmZd2DStffYEGZ91wGx94mDpnWrflx5UP8kiVJcd3hxeVA4h4Pg+i2rpnMcDkv
         7Ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709843509; x=1710448309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bl6KQ7zqxCRRy7mV9HLzLwrJU3k8ZyxTlFOkk6jrrGQ=;
        b=U6d/zPdNPJpbgjy7gtT6hfs03tFPxAV+SufhmEHiXA6svZvEuz5Iq9cpCyZElxzWzs
         zJ6ysWjRbIxF8fM2rbqsPLEOgSAtPH2FxSKJfN1uHwqZhR+yWsrG3ZSPEJGFgzo54XpM
         7peIDDyxNS4BhPG7jaVPX7MTj9uKeAzX+tiyWH8U37ppcwdX+qlDWrlSh9+nW5i6IOoD
         rKoixajV2uIDfcQUlRFftnPMuSZrfLt/vnX97Uu5haIMVWKh1pN+ggHZ3x7S1DkkqQ/y
         KWdDQPvttIQb2brT8dvcinoirW6VUwP9hMEohMt8tRgVbwCRUHaI7FoXWbxnlJIrrDrQ
         RVxw==
X-Forwarded-Encrypted: i=1; AJvYcCUqazw+gETiPl2iYSV9+85aKUIp7FeOAPHFqRnH3+qhP7k301RJwHu+0MF9TAMly502rAWN7oIQxnltNMFKq0ebXamalsvqZ6pPYHRU
X-Gm-Message-State: AOJu0YxziZ44HmKgZlT0Jzvkj0RvChszYtCyzBNSSdh0Hy1+DSWQ1UbX
	oXvYN/CBdatiMIvQrJCAKUjSaYLtJLE7xoX665JsdBqMi9kT58JV8aGcXRWImyCd9g8qDpmRWRP
	1s+x3ZXUG/EIZeVcY+g==
X-Google-Smtp-Source: AGHT+IGHuymlA+pETPYDpM827l6AntNqqm0ilI/Ekq0Va7MaZBSZ/dPUBtoF7j7vk4QZnMUlAPO+AStYZ4MjiftR
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a0d:df0f:0:b0:607:8f65:5433 with SMTP
 id i15-20020a0ddf0f000000b006078f655433mr545462ywe.4.1709843508926; Thu, 07
 Mar 2024 12:31:48 -0800 (PST)
Date: Thu, 7 Mar 2024 20:31:46 +0000
In-Reply-To: <updn6j7jcqdru73vwt3fvxlx4t73rjrlk7h6i6js3lizeueoov@tz7fyrd3a4yi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-2-yosryahmed@google.com> <updn6j7jcqdru73vwt3fvxlx4t73rjrlk7h6i6js3lizeueoov@tz7fyrd3a4yi>
Message-ID: <ZeokMhiB2MhTlIXP@google.com>
Subject: Re: [RFC PATCH 1/3] x86/mm: fix LAM cr3 mask inconsistency during
 context switch
From: Yosry Ahmed <yosryahmed@google.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 07, 2024 at 07:22:36PM +0200, Kirill A. Shutemov wrote:
> On Thu, Mar 07, 2024 at 01:39:14PM +0000, Yosry Ahmed wrote:
> > In switch_mm_irqs_off(), we read the 'mm->context.lam_cr3_mask' into
> > 'new_lam', which is later passed to load_new_mm_cr3(). However, there is
> > a call to set_tlbstate_lam_mode() in between which will read
> > 'mm->context.lam_cr3_mask' again and set 'cpu_tlbstate.lam' accordingly.
> > If we race with another thread updating 'mm->context.lam_cr3_mask', the
> > value in 'cpu_tlbstate.lam' could end up being different from CR3.
> 
> What other thread? LAM can only be enabled when the process has single
> thread. And cannot be disabled. See MM_CONTEXT_LOCK_LAM.

Right, but a kthread may run with that single-threaded process's mm
IIUC. I think this can happen via kthread_use_mm() or if we context
switch directly from the user process to the kthread (context_switch()
doesn't seem to update the mm in this case).

> 
> > While we are at it, remove the misguiding comment that states that
> > 'new_lam' may not match tlbstate_lam_cr3_mask() if a race occurs.
> 
> The comment is indeed misguiding, but for different reason. It is leftover
> from the earlier version of LAM patchset.

