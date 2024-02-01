Return-Path: <linux-kernel+bounces-48972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF050846438
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4639E1F286E5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7618146426;
	Thu,  1 Feb 2024 23:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="yqoI228t"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CD540BEB
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 23:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706828455; cv=none; b=n6berJjDrgCXWhuYuvBagMlfqxQrbwu6tWPqwBJqrxbr6myEoJ7zgrrdMlYEY6sf/x71lsTpUwTW0QHtvh2UXg412PbXkEb85ljaYX2DqdzCr2QjD37wZq3R1PUqD+O0krcxD/KTQmGnQ8dNhwmbWTU6cXyQZEtrZ4yZeGN/4cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706828455; c=relaxed/simple;
	bh=LC6eQolMDOYJUfpvfKRhpmQNCgPc04G/RvCMXN+0ptk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKE2T11zRB7xPdz+dWUtDKUCTP0JJeodZH0DQ3ga1R3kpC/72gXVwlKApz2v1Yzg/aylbmv68yop8d9NyQq1QVPP1v4lHDjeASuKAgll8UePU96EGhb0CYSvu3WaGc4TOWCLYK8mlVBCL8+WLUPXsdk5MxLagDm/aOS0C4HS5Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yqoI228t; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68c7a26a5cbso1850026d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 15:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706828453; x=1707433253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4MAuRUk3N+lF6RqEnoyrH/PDpVJ9wVvmxrJA1XBMYs=;
        b=yqoI228trD+EjZzX4+zp7P9Ep1eBL+pfN2vnFerWnGLikk2k+oGpWXnI0/h6MeIwJ9
         ryEamkk7svssM+GHgSP/zzajSDdx440QR2MBXJXXcDxMWxKkiLv3rs1XVW3rW4c1kRIx
         tGsnn7rL27HIolgOSbhpqJlTImEyorCnyhZ+W+TzAsEJVDzL/ijVBhoI9ukj3DtQCCbi
         aSKOq59m187gHd2GByOaMa16E+4xVpvquIvAk3rEAhq1+KETr0npRXA6uPJVipoUjQrd
         vKKzB3HgK6jYfE2n1RgWUreMNhJLaIGIx7vNP6dWqMaEgZfj28xCjDSBMqSN4DrC/RMp
         ZHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706828453; x=1707433253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4MAuRUk3N+lF6RqEnoyrH/PDpVJ9wVvmxrJA1XBMYs=;
        b=dqmFHAqkpjZDuaOQkmtQv3dQlcdJWMfDRPp94M8ryf3VSXsK8CuaLEHjmmeYVqfRSd
         z9gdlYW0i5xN/St58EI/vpgFB3V80zz785QWAS+QrG4Sa23ceXyrMNnn6gzYEvbG1CLL
         C1bdHW+ccEMMWiDW3NMOFL7jbPlwrpzXgIQO/Kl9yRD4AzysWRkaV6/RPquHR+ac/9vi
         kssCA8k1lHd6KZ1dOOqOW2TjRQFWxJ2eKcuOvxoK/3SxDvvrHxyEudrFrqjVYG/ju/+c
         7onN7nh/0nYdF5QmO/Mfq4MW63e0o3D0VimTX1fU5npMoHOl0+VvNfdMx2Pr6qMO4sCS
         Em4Q==
X-Gm-Message-State: AOJu0YwSC+/n4bxZ/1Kahel0KEjc8rWYlsFvECYgg5H7bM50Tg/KUzU4
	CQ+yIGihqnZbMWAMOusVW+92s52aYbYe8sf9aWzSZ8tsycIhNg5efQlVukAifoBuxgkaVLxlYQX
	jv7cu/7L+s+V6SGPG/r90aPWDISlK/N7FqLox
X-Google-Smtp-Source: AGHT+IFbiFEMu8X//bnen29Y7xKWJ92G7XX4FAMiwsCvY9gszv26VKDnW07e/HAXxWCN+v/KxZDXX0/lB1TLOk8LmrA=
X-Received: by 2002:a05:6214:5187:b0:68c:850e:12c3 with SMTP id
 kl7-20020a056214518700b0068c850e12c3mr1068199qvb.12.1706828452759; Thu, 01
 Feb 2024 15:00:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123221220.3911317-1-mizhang@google.com> <ZbpqoU49k44xR4zB@google.com>
 <368248d0-d379-23c8-dedf-af7e1e8d23c7@oracle.com> <CAL715WJDesggP0S0M0SWX2QaFfjBNdqD1j1tDU10Qxk6h7O0pA@mail.gmail.com>
 <ZbvUyaEypRmb2s73@google.com> <ZbvjKtsVjpuQmKE2@google.com>
 <ZbvyrvvZM-Tocza2@google.com> <CAL715WJ_VT2E5bjgvC89Dk0j1Mft9PcGtEBkkAxkKMF0=+Uimw@mail.gmail.com>
 <Zbwg6LlRrkq8jk9Q@google.com>
In-Reply-To: <Zbwg6LlRrkq8jk9Q@google.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Thu, 1 Feb 2024 15:00:15 -0800
Message-ID: <CAL715W+cEpGfDZG2HZ8ZBwauK1hyB4Swj9UERi_PcqqozkjBzA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/pmu: Fix type length error when reading pmu->fixed_ctr_ctrl
To: Sean Christopherson <seanjc@google.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 2:53=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, Feb 01, 2024, Mingwei Zhang wrote:
> > On Thu, Feb 1, 2024 at 11:36=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Thu, Feb 01, 2024, Mingwei Zhang wrote:
> > > > On Thu, Feb 01, 2024, Sean Christopherson wrote:
> > > > > On Wed, Jan 31, 2024, Mingwei Zhang wrote:
> > > > > > > The PMC is still active while the VM side handle_pmi_common()=
 is not going to handle it?
> > > > > >
> > > > > > hmm, so the new value is '0', but the old value is non-zero, KV=
M is
> > > > > > supposed to zero out (stop) the fix counter), but it skips it. =
This
> > > > > > leads to the counter continuously increasing until it overflows=
, but
> > > > > > guest PMU thought it had disabled it. That's why you got this w=
arning?
> > > > >
> > > > > No, that can't happen, and KVM would have a massive bug if that w=
ere the case.
> > > > > The truncation can _only_ cause bits to disappear, it can't magic=
ally make bits
> > > > > appear, i.e. the _only_ way this can cause a problem is for KVM t=
o incorrectly
> > > > > think a PMC is being disabled.
> > > >
> > > > The reason why the bug does not happen is because there is global
> > > > control. So disabling a counter will be effectively done in the glo=
bal
> > > > disable part, ie., when guest PMU writes to MSR 0x38f.
> > >
> > >
> > > > > fixed PMC is disabled. KVM will pause the counter in reprogram_co=
unter(), and
> > > > > then leave the perf event paused counter as pmc_event_is_allowed(=
) will return
> > > > > %false due to the PMC being locally disabled.
> > > > >
> > > > > But in this case, _if_ the counter is actually enabled, KVM will =
simply reprogram
> > > > > the PMC.  Reprogramming is unnecessary and wasteful, but it's not=
 broken.
> > > >
> > > > no, if the counter is actually enabled, but then it is assigned to
> > > > old_fixed_ctr_ctrl, the value is truncated. When control goes to th=
e
> > > > check at the time of disabling the counter, KVM thinks it is disabl=
ed,
> > > > since the value is already truncated to 0. So KVM will skip by sayi=
ng
> > > > "oh, the counter is already disabled, why reprogram? No need!".
> > >
> > > Ooh, I had them backwards.  KVM can miss 1=3D>0, but not 0=3D>1.  I'l=
l apply this
> > > for 6.8; does this changelog work for you?
> > >
> > >   Use a u64 instead of a u8 when taking a snapshot of pmu->fixed_ctr_=
ctrl
> > >   when reprogramming fixed counters, as truncating the value results =
in KVM
> > >   thinking all fixed counters, except counter 0, are already disabled=
  As
> > >   a result, if the guest disables a fixed counter, KVM will get a fal=
se
> > >   negative and fail to reprogram/disable emulation of the counter, wh=
ich can
> > >   leads to spurious PMIs in the guest.
> >
> > That works for me. Maybe scoping that to the guest VMs with PerfMon v1 =
enabled?
>
> No, because from a purely architectural perspective, the bug isn't limite=
d to
> VMs without PERF_GLOBAL_CTRL.  Linux may always clear the associated enab=
le bit
> in PERF_GLOBAL_CTRL, but that's not a hard requirement, a guest could cho=
ose to
> always leave bits set in PERF_GLOBAL_CTRL and instead use IA32_FIXED_CTR_=
CTRL to
> toggle PMCs on and off.
>
>   Each enable bit in MSR_PERF_GLOBAL_CTRL is AND=E2=80=99ed with the enab=
le bits for all
>   privilege levels in the respective IA32_PERFEVTSELx or IA32_FIXED_CTR_C=
TRL MSRs
>   to start/stop the counting of respective counters. Counting is enabled =
if the
>   AND=E2=80=99ed results is true; counting is disabled when the result is=
 false.
>
> I'm not saying that such guests are likely to show up in the wild, but I =
don't
> want to make any assumptions about what the guest does or does not do whe=
n it
> comes to making statements about the impact of bugs.

I agree with you. We don't know what kind of guest we are serving. It
may not be Linux, it may not even be the perf subsystem in Linux. They
could choose to do whatever style that is allowed architecturally to
start/stop/reprogram the fixed counter.

Thanks.

-Mingwei

