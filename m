Return-Path: <linux-kernel+bounces-48966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA02C8463E2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3BC28DED0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D93746436;
	Thu,  1 Feb 2024 22:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cdFfD+qH"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754A645BF8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706828011; cv=none; b=iF/mvkmGAr7hpx2uz8wHsZULbmc/DF0eRXWH/8IWaUL8urHkO0Scci5nhl8VuzC1WKvWPM/d+r61u8LqAxk5rimsB3Szkjfd6yzsVMTDezJEsxuxURmTBUNuDBgceH+yJ6l7UfQkZGpTFtzQqFEa/xVzpYzNm02o0HQmmFHD5b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706828011; c=relaxed/simple;
	bh=MsM3iHzWW1lvvTKaiDAx7eegwD+bvgWrNvYbozPoTfs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kRmdcT63klRNGBsp5rsj9VfHddT2laW9F8KKN4gY1dYdeaeEdOkjN7eOs4C0RFKlvoNIMC6IJgCYwqXp1zK52NzTIK+4/PM8aIGwNV5hMbJHB6a1hTvAX6gavgdSwtoxCVibRp14GTqWhjkA6VeyP773p6r49Mfak3h30y3fulU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cdFfD+qH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-29034f18db9so1361232a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 14:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706828010; x=1707432810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdsLyW1t2c69oWmYeGedtu7rqMejpHMDN0n+lTcucg4=;
        b=cdFfD+qH0lCwKhY8JhHM02LvTppRtW1b7QuAPj4Ja7nIIU1T1hH4sUGJqDsbcfx7VT
         gbBon7wkrJvbQJxbl/Pgn1BF7z/jO6IFhHtAj1CTYyP/FSmkIlYHtO6oKT8ZwlnyJPPU
         zPVsT7VV2GSxD3krX7Ssdkc9nxIdM643twTCZu1z2KWRYxPT+pNDo/qMXly4b53GBKHJ
         sO+Cms7PtxAOdMRtRt/j/X9Nf7R8y5mBmx1XFDYGmYeC1FlZibMhecF/KRbCd5fXVyfq
         vQgJr3XzN1f5fABkUXfqIokTflf2p2qk/vQxEJlecNTzTdU46iD2tLIZau9FyN25dHxx
         o8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706828010; x=1707432810;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tdsLyW1t2c69oWmYeGedtu7rqMejpHMDN0n+lTcucg4=;
        b=avCGGnpnVdTuYSoPxh3kzIcP1ZytHT7v1sdYClQQEmyij5edLNae2KwcQCx9CG6a2n
         lwbwRaGnJG2/v87x2Nr4UtN3RhUyW61YseaR1cCJxkvb4sDjHEcK5khyxvKIt4a40wZ0
         lV4/7gDX7TB2mdhSyS1OTXfNGtUuZ6rj/JgemNLB6/vawIMs1oERnRac5kA03cAzm0vL
         MRSHKk7kIkqW0uokCN+x6uOtSPjZz2q194vlLp0IveNQhRXfxc/MoizJATi0doMtOBKy
         aM/kh3ArwMGFON7Wa4/zrhnJBywm3DRqos0RceGjBs9+obto1QB8i5YKNhLuvHVYgL3L
         JmAg==
X-Gm-Message-State: AOJu0YzIRXwTxWx8qkIEWVBJ1ywWzRk6dsCSLe53/2Md01GC7inidLuo
	EWly0PXahe5vlHkk9vVEhPEUq15cpJiAmDedhDP+ay1VyIY/F2YXiq20kqI0kUly0L2yLBDY2h0
	S7g==
X-Google-Smtp-Source: AGHT+IFzKLXRakT4/3cZBO2WYECQlA5xLRyQCFSho8cTDhlCFkp+WrD5HswQ2tTu5vYw6N1BoaImKWI1TVU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3943:b0:296:3a3a:c053 with SMTP id
 oe3-20020a17090b394300b002963a3ac053mr28647pjb.6.1706828009713; Thu, 01 Feb
 2024 14:53:29 -0800 (PST)
Date: Thu, 1 Feb 2024 14:53:28 -0800
In-Reply-To: <CAL715WJ_VT2E5bjgvC89Dk0j1Mft9PcGtEBkkAxkKMF0=+Uimw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123221220.3911317-1-mizhang@google.com> <ZbpqoU49k44xR4zB@google.com>
 <368248d0-d379-23c8-dedf-af7e1e8d23c7@oracle.com> <CAL715WJDesggP0S0M0SWX2QaFfjBNdqD1j1tDU10Qxk6h7O0pA@mail.gmail.com>
 <ZbvUyaEypRmb2s73@google.com> <ZbvjKtsVjpuQmKE2@google.com>
 <ZbvyrvvZM-Tocza2@google.com> <CAL715WJ_VT2E5bjgvC89Dk0j1Mft9PcGtEBkkAxkKMF0=+Uimw@mail.gmail.com>
Message-ID: <Zbwg6LlRrkq8jk9Q@google.com>
Subject: Re: [PATCH] KVM: x86/pmu: Fix type length error when reading pmu->fixed_ctr_ctrl
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024, Mingwei Zhang wrote:
> On Thu, Feb 1, 2024 at 11:36=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Thu, Feb 01, 2024, Mingwei Zhang wrote:
> > > On Thu, Feb 01, 2024, Sean Christopherson wrote:
> > > > On Wed, Jan 31, 2024, Mingwei Zhang wrote:
> > > > > > The PMC is still active while the VM side handle_pmi_common() i=
s not going to handle it?
> > > > >
> > > > > hmm, so the new value is '0', but the old value is non-zero, KVM =
is
> > > > > supposed to zero out (stop) the fix counter), but it skips it. Th=
is
> > > > > leads to the counter continuously increasing until it overflows, =
but
> > > > > guest PMU thought it had disabled it. That's why you got this war=
ning?
> > > >
> > > > No, that can't happen, and KVM would have a massive bug if that wer=
e the case.
> > > > The truncation can _only_ cause bits to disappear, it can't magical=
ly make bits
> > > > appear, i.e. the _only_ way this can cause a problem is for KVM to =
incorrectly
> > > > think a PMC is being disabled.
> > >
> > > The reason why the bug does not happen is because there is global
> > > control. So disabling a counter will be effectively done in the globa=
l
> > > disable part, ie., when guest PMU writes to MSR 0x38f.
> >
> >
> > > > fixed PMC is disabled. KVM will pause the counter in reprogram_coun=
ter(), and
> > > > then leave the perf event paused counter as pmc_event_is_allowed() =
will return
> > > > %false due to the PMC being locally disabled.
> > > >
> > > > But in this case, _if_ the counter is actually enabled, KVM will si=
mply reprogram
> > > > the PMC.  Reprogramming is unnecessary and wasteful, but it's not b=
roken.
> > >
> > > no, if the counter is actually enabled, but then it is assigned to
> > > old_fixed_ctr_ctrl, the value is truncated. When control goes to the
> > > check at the time of disabling the counter, KVM thinks it is disabled=
,
> > > since the value is already truncated to 0. So KVM will skip by saying
> > > "oh, the counter is already disabled, why reprogram? No need!".
> >
> > Ooh, I had them backwards.  KVM can miss 1=3D>0, but not 0=3D>1.  I'll =
apply this
> > for 6.8; does this changelog work for you?
> >
> >   Use a u64 instead of a u8 when taking a snapshot of pmu->fixed_ctr_ct=
rl
> >   when reprogramming fixed counters, as truncating the value results in=
 KVM
> >   thinking all fixed counters, except counter 0, are already disabled. =
 As
> >   a result, if the guest disables a fixed counter, KVM will get a false
> >   negative and fail to reprogram/disable emulation of the counter, whic=
h can
> >   leads to spurious PMIs in the guest.
>=20
> That works for me. Maybe scoping that to the guest VMs with PerfMon v1 en=
abled?

No, because from a purely architectural perspective, the bug isn't limited =
to
VMs without PERF_GLOBAL_CTRL.  Linux may always clear the associated enable=
 bit
in PERF_GLOBAL_CTRL, but that's not a hard requirement, a guest could choos=
e to
always leave bits set in PERF_GLOBAL_CTRL and instead use IA32_FIXED_CTR_CT=
RL to
toggle PMCs on and off.

  Each enable bit in MSR_PERF_GLOBAL_CTRL is AND=E2=80=99ed with the enable=
 bits for all
  privilege levels in the respective IA32_PERFEVTSELx or IA32_FIXED_CTR_CTR=
L MSRs
  to start/stop the counting of respective counters. Counting is enabled if=
 the
  AND=E2=80=99ed results is true; counting is disabled when the result is f=
alse.

I'm not saying that such guests are likely to show up in the wild, but I do=
n't
want to make any assumptions about what the guest does or does not do when =
it
comes to making statements about the impact of bugs.

