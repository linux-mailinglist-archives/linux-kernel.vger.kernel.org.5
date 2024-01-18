Return-Path: <linux-kernel+bounces-30093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB1283190B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40241F2158B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FED24B2C;
	Thu, 18 Jan 2024 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jNEBfz3V"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADC624A0B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705580597; cv=none; b=GUKX9V/fSdY0CfteFxJhmS4FHpu7WD676NoHeKX0N3K0IDQ7JGUcTeeCqKJ5U6VdQrd0AtfpEVmv6yqj+V9wPEBJf6FBEFPdGRO2xHAz9SGWDg3rtTQtHpGywEgVyz+GUXdpcNupiPLG1itqfrAGdl2wKt5piivgxVF89yWowZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705580597; c=relaxed/simple;
	bh=7AuSwgYsRLtQPaH9Hm2+jqJ8wMg7c1ufpWu5H7xj9V0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=kqp4dTpXz2OrBA/RcU1stlEMOZUkoJtiK/VaNLw/HkGxzUvV/cRqblovd7i64yKOu5ruPoIqtTE46JdlQ6Ige2v3CD3WaROyYEh30yYUHRgUCT8vxOHCx8wDTrmaee6QGW/QXEr60oy2EuCtHTIeglf/kWOYVVRtMMlyQDuSi6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jNEBfz3V; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4670af5bd56so3151093137.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 04:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705580595; x=1706185395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7AuSwgYsRLtQPaH9Hm2+jqJ8wMg7c1ufpWu5H7xj9V0=;
        b=jNEBfz3VVtf9Ib1HR0nMSPL2odriwx9jDgDGt8ZDxzMMd50wZktvo29XHgboXyE67i
         JHDpRwRLs7+0tC+UEe7TaNFxNjyGB5h/OhjpX0SRvca/0DHyQJL10Lw7wsF5fhlH+GhA
         Noql4aTvTuJBmGofhFb8dOm9UDtM7U0T+TxHtMHrdSCe/yNOyfGxkbkFu+ttbPvqc6Na
         Y6yqVmrs7qA/7Yb1Kocp1MMtR3Bs+6eQlFy8WWy5Gveg25qs68+k0fwI+zRdrOyvsg+1
         qyXjqBzTAtOdfQv6i5iw9at855BIpkrBMgeiLeffONxoHCvVdjhH7uRdKDyJc+8WI9dU
         Gm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705580595; x=1706185395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7AuSwgYsRLtQPaH9Hm2+jqJ8wMg7c1ufpWu5H7xj9V0=;
        b=fWafn1CoONHw4yoMKh/AcP9XinQzIk8mv/mUK60o7dmclHrDXvardBVo/vIkcR0WFd
         IUxQwkawFZKdgTKTvuEMDI+RGfHqLhzU78lC7Vhh1mA0yV1N5O7XzvqVlJ3Rwh4CgGbm
         gLp5x8iCJpS0hyk8z4CWGEAepvOkQJCa3JwROteFRW+1Ighc6m/U1FY8bNMLjc6FVpVX
         ckXTLpcrBLQOpz2RdlMxZBrIw0iQAGPg+XQo/mheNUMzscq62iLw1IncWgW5h45FWYMt
         roOtCe8GxiFWWY7ttboGVMVvA9yiPAe0ThKvPnwEj0cbePD1d/L355j6e7hDG9Zga4aN
         HY3w==
X-Gm-Message-State: AOJu0YwTQpiT9bun5xgDdzoCVF1nfqTNIcjFQCnK/2HIoC6M256SZdK0
	7xdBsX520rnfcnmoMR9vcLuTFUWcxgXx6pOjKTwu2auXkYLftSG3Qdt4E3GEXmbtVCeo78mNKjU
	eHXiezjQzOk88Dgp5V/gKKVdf7U5B4e6F0qkD
X-Google-Smtp-Source: AGHT+IGSDeGuG8MW8B2XQ4Yb1Ndl68XMUmwU4DTwgvGAiW37PlrxPO0ZzqGwx8mdK4RZluZnibirrFQohgLudpytwH0=
X-Received: by 2002:a05:6102:3165:b0:467:b086:3ec3 with SMTP id
 l5-20020a056102316500b00467b0863ec3mr597178vsm.25.1705580595173; Thu, 18 Jan
 2024 04:23:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118110022.2538350-1-elver@google.com> <CANpmjNPx0j-x_SDu777gaV1oOFuPmHV3xFfru56UzBXHnZhYLg@mail.gmail.com>
 <cd742d1d-70a3-586b-4bf5-fcfc94c75b4a@quicinc.com>
In-Reply-To: <cd742d1d-70a3-586b-4bf5-fcfc94c75b4a@quicinc.com>
From: Marco Elver <elver@google.com>
Date: Thu, 18 Jan 2024 13:22:37 +0100
Message-ID: <CANpmjNNZ6vV7DJ+SBGcSnV6qzkmH_J=WrofrfaAeidvSG2nHbQ@mail.gmail.com>
Subject: Re: [PATCH] mm, kmsan: fix infinite recursion due to RCU critical section
To: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzbot+93a9e8a3dea8d6085e12@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jan 2024 at 12:28, Charan Teja Kalla
<quic_charante@quicinc.com> wrote:
>
> May I ask if KMSAN also instruments the access to the memory managed as
> ZONE_DEVICE. You know this is not the RAM and also these pages will
> never be onlined thus also not be available in buddy.
>
> Reason for the ask is that this patch is introduced because of a race
> between pfn walker ends up in pfn of zone device memory.
>
> If KMSAN never instruments this, does it look good to you to have the
> KMSAN version of pfn_valid(), as being suggested by Alexander in the
> other mail.

It would be nice to avoid duplicating functions - both options have downsides:
1. Shared pfn_valid(): it might break for KMSAN again in future if new
recursion is introduced.
2. KMSAN-version of pfn_valid(): it might break if pfn_valid() changes
in future.

I suspect #1 is less likely.

What is your main concern by switching to rcu_read_lock_sched()?

