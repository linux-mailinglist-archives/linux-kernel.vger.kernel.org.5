Return-Path: <linux-kernel+bounces-50207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979208475C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527E828CE38
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304A414D422;
	Fri,  2 Feb 2024 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IUjnD8Sb"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7F314A4F8
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893637; cv=none; b=fsMrOxuZO4SEav7G66kVlXzblm6O1urg5iOn6I+IVt0LLEflMjgm/wxvS/vPlbWhkkyohHtvZDXoY0mqRJt4hd5U6+3SWrFcXlACd6MFIFXNYly81aodyzhiFWWhj5C8njeLp57PSopu28iToPY4+pXP7/NQUygXxhTwsy3gPqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893637; c=relaxed/simple;
	bh=ZxYwtQl6gwkvn4vNBtszF0Bkjvg2DtSi0J2BX7wpt0I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fbzeyBLZ6wUdRsSMdYrFNwhESk8iIN3Cw+qa/7AOF5Qc2GX01bxNU0XWk6TBTCNMBUTvj7GNOi00sWyQG+B4CtqR1BTURZuRraNY6FFHeAUf+graQD2HWQkzMko2STRnrQ6MSqCsSagAIPnHcOkLTSHWU2lVxAjR/kptdryk02Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IUjnD8Sb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6041bb56dbfso33971017b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 09:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706893635; x=1707498435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=52hREpEdz1wY5YQcf323vOpsz5jH6pb2sFOoSjdgNLo=;
        b=IUjnD8SbUswvKgPrQdKkOr6oQcGZRuLtv1WIzQgie9KMEz2kTg7czQExQriW6rTUB5
         3kzAdeIL6KTVIy2Pu3E8tAVFjO1B8JlrYDkgiLpInp5FHo0dQRswHSOAI1dAIQFYBHz9
         6gf/Jn4K7dDzOpNnt1wfXfPtonlxXvBaBhQVqhaSXTIRYLcTopeuPkLZpKVhUneFKc2Q
         A21Nt2LtrW7gYZ5hVgXSDg6tQZWcgJblYqX4Z9iTV1D8JY7emZ1C3ARUHoFbZUvQ/r0N
         50qOFApM98meSeXwi61tFfVF8G3eb0AO5TD+qo6AnCW6wo2ZU20KxH5oS6cdocUOZb1e
         1enA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706893635; x=1707498435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52hREpEdz1wY5YQcf323vOpsz5jH6pb2sFOoSjdgNLo=;
        b=NIMdxp8lSJCnh+4ue1L2rirPSD49d3tymaoVZr3QYwN9YcivpbThhPWojbbKaSsPPw
         lMAyPoqDrB7yVN/Sei932HNmdTBg0dxLxahKihLfDPME405dqw/VZ1U/b7/LmMD16mrk
         Srh7RNqniEXPPWmpxG5qrZKcER9MNCeRX1sUivET5X3FNNlRVVPUYIpBfKeRzGdvb0Vk
         5WEy9svo4mvfHSpBquaE6ZazFj11pcQ8ZmDGzu+4gZe/C5zQ0GBpMBsEaEHNWPIU6LXz
         +S7vBlkyH6Jz94VxrW9EUV7rljJV75DD58SIx8YrkP0iygFcPM9pP5KvPAHWeqVF3t4x
         kuSQ==
X-Gm-Message-State: AOJu0YwDDgkz+03wZH9OHjGxrPqGkjAyxpk3YJSkLKghZk1ulfEnD+XW
	OLqfxhIlE4Aj2YxwHoZie5ANvKqRY2UBNXsxNka9/oYCnp70v9c72JQtHma6lEmtdCK6AggVHvj
	gIw==
X-Google-Smtp-Source: AGHT+IGW368ALVFacBMp4luOZOtgF9xdwUNWVenx3J/2DBP1Gf1M9X6P48vkhXsEFewVeUm8CzD7lSb87CA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:9805:0:b0:602:d545:a3bb with SMTP id
 p5-20020a819805000000b00602d545a3bbmr990910ywg.1.1706893634791; Fri, 02 Feb
 2024 09:07:14 -0800 (PST)
Date: Fri, 2 Feb 2024 09:07:13 -0800
In-Reply-To: <9098e8bb-cbe4-432c-98d6-ce96a4f7094f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123221220.3911317-1-mizhang@google.com> <ZbpqoU49k44xR4zB@google.com>
 <368248d0-d379-23c8-dedf-af7e1e8d23c7@oracle.com> <CAL715WJDesggP0S0M0SWX2QaFfjBNdqD1j1tDU10Qxk6h7O0pA@mail.gmail.com>
 <ZbvUyaEypRmb2s73@google.com> <ZbvjKtsVjpuQmKE2@google.com>
 <ZbvyrvvZM-Tocza2@google.com> <9098e8bb-cbe4-432c-98d6-ce96a4f7094f@linux.intel.com>
Message-ID: <Zb0hQfZX89gJOtRX@google.com>
Subject: Re: [PATCH] KVM: x86/pmu: Fix type length error when reading pmu->fixed_ctr_ctrl
From: Sean Christopherson <seanjc@google.com>
To: Xiong Y Zhang <xiong.y.zhang@linux.intel.com>
Cc: Mingwei Zhang <mizhang@google.com>, Dongli Zhang <dongli.zhang@oracle.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 02, 2024, Xiong Y Zhang wrote:
> 
> 
> On 2/2/2024 3:36 AM, Sean Christopherson wrote:
> > On Thu, Feb 01, 2024, Mingwei Zhang wrote:
> >> On Thu, Feb 01, 2024, Sean Christopherson wrote:
> >>> On Wed, Jan 31, 2024, Mingwei Zhang wrote:
> >>>>> The PMC is still active while the VM side handle_pmi_common() is not going to handle it?
> >>>>
> >>>> hmm, so the new value is '0', but the old value is non-zero, KVM is
> >>>> supposed to zero out (stop) the fix counter), but it skips it. This
> >>>> leads to the counter continuously increasing until it overflows, but
> >>>> guest PMU thought it had disabled it. That's why you got this warning?
> >>>
> >>> No, that can't happen, and KVM would have a massive bug if that were the case.
> >>> The truncation can _only_ cause bits to disappear, it can't magically make bits
> >>> appear, i.e. the _only_ way this can cause a problem is for KVM to incorrectly
> >>> think a PMC is being disabled.
> >>
> >> The reason why the bug does not happen is because there is global
> >> control. So disabling a counter will be effectively done in the global
> >> disable part, ie., when guest PMU writes to MSR 0x38f.
> > 
> > 
> >>> fixed PMC is disabled. KVM will pause the counter in reprogram_counter(), and
> >>> then leave the perf event paused counter as pmc_event_is_allowed() will return
> >>> %false due to the PMC being locally disabled.
> >>>
> >>> But in this case, _if_ the counter is actually enabled, KVM will simply reprogram
> >>> the PMC.  Reprogramming is unnecessary and wasteful, but it's not broken.
> >>
> >> no, if the counter is actually enabled, but then it is assigned to
> >> old_fixed_ctr_ctrl, the value is truncated. When control goes to the
> >> check at the time of disabling the counter, KVM thinks it is disabled,
> >> since the value is already truncated to 0. So KVM will skip by saying
> >> "oh, the counter is already disabled, why reprogram? No need!".
> > 
> > Ooh, I had them backwards.  KVM can miss 1=>0, but not 0=>1.  I'll apply this
> > for 6.8; does this changelog work for you?
> > 
> >   Use a u64 instead of a u8 when taking a snapshot of pmu->fixed_ctr_ctrl
> >   when reprogramming fixed counters, as truncating the value results in KVM
> >   thinking all fixed counters, except counter 0, 
> each counter has four bits in fixed_ctr_ctrl, here u8 could cover counter 0
> and counter 1, so "except counter 0" can be modified to "except counter 0 and
> 1" 

Ugh, math.  I'll adjust it to:

  Use a u64 instead of a u8 when taking a snapshot of pmu->fixed_ctr_ctrl
  when reprogramming fixed counters, as truncating the value results in KVM
  thinking fixed counter 2 is already disabled (the bug also affects fixed
  counters 3+, but KVM doesn't yet support those).  As a result, if the
  guest disables fixed counter 2, KVM will get a false negative and fail to
  reprogram/disable emulation of the counter, which can leads to incorrect
  counts and spurious PMIs in the guest.

Thanks!

