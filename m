Return-Path: <linux-kernel+bounces-161268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF658B49DE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0DF1F21534
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 06:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738649479;
	Sun, 28 Apr 2024 06:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DiEC0bC4"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFD779CF
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 06:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714284141; cv=none; b=HX/2gj5yHtPWq040VtlbuFMWfMggNRLpKAEts7TzI1sJ5IHxDEAtdVhhVQzj6fpUo/o01b1dufmLmtBeBEWWigojs4VGEW6zdXFywrsOtN2mGrplnx+4K2Uyr3y9phAS32YjmnuUEWAVkrjiyAv2KC3JJb7byc4Z2HcRyNyQv88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714284141; c=relaxed/simple;
	bh=v1ykSlXkUuARj6rBHWUVxaWShXC8PoWCDT7RtdU0yEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXVawdcHHpfPRtz/ihXHZGPUCMoNwJEev03tRF0zKjOD+aCuKm4AAqCeOPzIULjqnQsr3fapqxt27v36yMNsuVIEw+fuLVZ+WXaB7+w3H57jmn91Tki7Dgv6YpPJGbB6vHdPMTWfYJmCaNK5vfFqGFvakabXYh3mItiZ5yOOsFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DiEC0bC4; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5708d8beec6so4246462a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 23:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714284138; x=1714888938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgsoPFEC7W7J0TMXTM5BpT6yoz5kG4yvWQxhG7FX1K4=;
        b=DiEC0bC4td7LWl4ibWYgPZBY7+WgaxfhcDcqW6jpIivYNJ1yK9i2ZQhmyAdn4tmgwG
         fIeyNhG1ZUTuyMVBZREqc3ZnWmGrPrX1KdWtlfmuooHXR2t0harW6Zv1eHE6fz8XpC4m
         3mnEeOuOl70sQTKq98nFGc5pKXZBCnOzRlYdU6gY4ZlIKwHAOU85eh29dWnuxufL0mfm
         wf0FxgvbJYf/czoSshtvMnAPgfbFGJeTNU2ASKdhwVtH0fpx5oXNmI2sl5MWG+KUVuhd
         dpUtmgvr919jGNnkz61jRW4mm+Q86MjsnuAOgPUxyKGOANvVz1wxecX+2QXOkC5Zx17g
         TkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714284138; x=1714888938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgsoPFEC7W7J0TMXTM5BpT6yoz5kG4yvWQxhG7FX1K4=;
        b=qKkEwI20KNgoHmx9/x0L32VKVJ33s5xmpPwKRDAdpkZmddq9tZzlQxuFijOG9MWIC7
         2vG71vf377Yz+G+4or05vRyl2v64o+U0TVyckoNquqQdME1X5XUeE1WUjjN86doTdri8
         6/EdtabGAw26kgFds7jelnGiC2f4XBX+Hd+g6MDc2ejSjMUT4UmsNclOdJGFP+wJaA5x
         po1+FuwM0/J7UWcmUyAQq2tD/ixRjcq+OTm1vfd0qRJMuR65HnzORHCP5yQIo8zb6bau
         TBaYQsv6wiY54Y6AQRqnWHugmJK0EMgj6WgppkalEOaqRyQ9mfY7+wcZjcjXIEAYSo3H
         g21A==
X-Forwarded-Encrypted: i=1; AJvYcCUbB6VzFJi5sBh9rqlbzF5T6T2a1Usv75ffe+W0aJORc5nChbcuXCzF9fNTu0wliSLPozi87HlQJjiP1RcSuz1ccsShmguUAW0BUBdF
X-Gm-Message-State: AOJu0Yy9jum9S7phQfRn8CrB++9eX9pCPa4YHD0sD2aa77RCYbsdJFZp
	I7mTg2D1ZX/4IeLn+LLGoY/2ADp+y5WdVQ+gRm45oW3pghuGlQNizzEXABoc/0FesF8nkJQP8Cm
	U99PEcmDGpeF62vjRoQ5gJdkCBnL8GnCl8eGP
X-Google-Smtp-Source: AGHT+IGoXq8kgnePnz5/Du5SvupzIZeOONX/IwUCQgIn8Ix+x7KM8LRHeC9lMqZRrm3lpCHrTHYOSzRj0xV7QOJ9bos=
X-Received: by 2002:a17:906:f9d9:b0:a58:7c50:84e4 with SMTP id
 lj25-20020a170906f9d900b00a587c5084e4mr6105402ejb.2.1714284138056; Sat, 27
 Apr 2024 23:02:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL715WKh8VBJ-O50oqSnCqKPQo4Bor_aMnRZeS_TzJP3ja8-YQ@mail.gmail.com>
 <6af2da05-cb47-46f7-b129-08463bc9469b@linux.intel.com> <CAL715W+zeqKenPLP2Fm9u_BkGRKAk-mncsOxrg=EKs74qK5f1Q@mail.gmail.com>
 <42acf1fc-1603-4ac5-8a09-edae2d85963d@linux.intel.com> <ZirPGnSDUzD-iWwc@google.com>
 <77913327-2115-42b5-850a-04ef0581faa7@linux.intel.com> <CAL715WJCHJD_wcJ+r4TyWfvmk9uNT_kPy7Pt=CHkB-Sf0D4Rqw@mail.gmail.com>
 <ff4a4229-04ac-4cbf-8aea-c84ccfa96e0b@linux.intel.com> <CAL715WJKL5__8RU0xxUf0HifNVQBDRODE54O2bwOx45w67TQTQ@mail.gmail.com>
 <5f5bcbc0-e2ef-4232-a56a-fda93c6a569e@linux.intel.com> <ZiwEoZDIg8l7-uid@google.com>
 <CAL715WJ4jHmto3ci=Fz5Bwx2Y=Hiy1MoFCpcUhz-C8aPMqYskw@mail.gmail.com> <b9095b0d-72f0-4e54-8d2e-f965ddff06bb@linux.intel.com>
In-Reply-To: <b9095b0d-72f0-4e54-8d2e-f965ddff06bb@linux.intel.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Sat, 27 Apr 2024 23:01:41 -0700
Message-ID: <CAL715WKm0X9NJxq8SNGD5EJomzY4DDSiwLb1wMMgcgHqeZ64BA@mail.gmail.com>
Subject: Re: [RFC PATCH 23/41] KVM: x86/pmu: Implement the save/restore of PMU
 state for Intel CPU
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	maobibo <maobibo@loongson.cn>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com, 
	peterz@infradead.org, kan.liang@intel.com, zhenyuw@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 5:59=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 4/27/2024 11:04 AM, Mingwei Zhang wrote:
> > On Fri, Apr 26, 2024 at 12:46=E2=80=AFPM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> >> On Fri, Apr 26, 2024, Kan Liang wrote:
> >>>> Optimization 4
> >>>> allows the host side to immediately profiling this part instead of
> >>>> waiting for vcpu to reach to PMU context switch locations. Doing so
> >>>> will generate more accurate results.
> >>> If so, I think the 4 is a must to have. Otherwise, it wouldn't honer =
the
> >>> definition of the exclude_guest. Without 4, it brings some random bli=
nd
> >>> spots, right?
> >> +1, I view it as a hard requirement.  It's not an optimization, it's a=
bout
> >> accuracy and functional correctness.
> > Well. Does it have to be a _hard_ requirement? no? The irq handler
> > triggered by "perf record -a" could just inject a "state". Instead of
> > immediately preempting the guest PMU context, perf subsystem could
> > allow KVM defer the context switch when it reaches the next PMU
> > context switch location.
> >
> > This is the same as the preemption kernel logic. Do you want me to
> > stop the work immediately? Yes (if you enable preemption), or No, let
> > me finish my job and get to the scheduling point.
> >
> > Implementing this might be more difficult to debug. That's my real
> > concern. If we do not enable preemption, the PMU context switch will
> > only happen at the 2 pairs of locations. If we enable preemption, it
> > could happen at any time.
>
> IMO I don't prefer to add a switch to enable/disable the preemption. I
> think current implementation is already complicated enough and
> unnecessary to introduce an new parameter to confuse users. Furthermore,
> the switch could introduce an uncertainty and may mislead the perf user
> to read the perf stats incorrectly.  As for debug, it won't bring any
> difference as long as no host event is created.
>
That's ok. It is about opinions and brainstorming. Adding a parameter
to disable preemption is from the cloud usage perspective. The
conflict of opinions is which one you prioritize: guest PMU or the
host PMU? If you stand on the guest vPMU usage perspective, do you
want anyone on the host to shoot a profiling command and generate
turbulence? no. If you stand on the host PMU perspective and you want
to profile VMM/KVM, you definitely want accuracy and no delay at all.

Thanks.
-Mingwei
>
> >
> >> What _is_ an optimization is keeping guest state loaded while KVM is i=
n its
> >> run loop, i.e. initial mediated/passthrough PMU support could land ups=
tream with
> >> unconditional switches at entry/exit.  The performance of KVM would li=
kely be
> >> unacceptable for any production use cases, but that would give us moti=
vation to
> >> finish the job, and it doesn't result in random, hard to diagnose issu=
es for
> >> userspace.
> > That's true. I agree with that.
> >
> >>>> Do we want to preempt that? I think it depends. For regular cloud
> >>>> usage, we don't. But for any other usages where we want to prioritiz=
e
> >>>> KVM/VMM profiling over guest vPMU, it is useful.
> >>>>
> >>>> My current opinion is that optimization 4 is something nice to have.
> >>>> But we should allow people to turn it off just like we could choose =
to
> >>>> disable preempt kernel.
> >>> The exclude_guest means everything but the guest. I don't see a reaso=
n
> >>> why people want to turn it off and get some random blind spots.

