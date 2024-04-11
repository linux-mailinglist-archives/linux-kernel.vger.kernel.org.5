Return-Path: <linux-kernel+bounces-141733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3578A22B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623FD287820
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C012E4D135;
	Thu, 11 Apr 2024 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBcfZ/6G"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6470C482ED
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712879842; cv=none; b=BP3cmrDYDG8u8jKGUza+eIUrSTCMbZw70QST/OhCWJmUmlnzY4SBfpcdtJBz8OMmqZXYXxxsga9l5SP3vJb+6/0hlIEDBcaROUfdJMUrGzMVCUmgrp9m2H+xdRwBqshzZwvob6kH6kWSCniAIEQVF32uF28vbFCU7grYb2GYgPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712879842; c=relaxed/simple;
	bh=QBuULRrtaRnnhZMlTYGm7HbOpsKwcgNmcTmfa5NNbhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ksl2taBKYLnS1MNZ2OBsXJJZiYKMCU2BXu4CtUUuUywGpq4T5IxyHXFDdiPHea+r9GvZjsCBdxErBY9GNtGQPGi2geepAjiZ71xf6yVeAgrlFxIyImYIqLgC4iOi5CBzcTZyAFbLYg+8Wk9TUHOp/KLrBwWo2kdtwOaTIwaAApk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nBcfZ/6G; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a52176b2cb6so37188366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712879839; x=1713484639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJmBil8hMiXltO9cI7CiQAcj05S/4ZhSQgUi9evlkRg=;
        b=nBcfZ/6GqVj1oFIKGAB5LLkuobcTZJYyuHkkDj4qZuYzcMfGVVmZPpthY8qqFpaoLL
         6M8zvRpFNQmomfGPmZylhgw0I8OVFr7fhhk05EfTPh1yOFvtHoBGY9PtuRbnE6d3VF7B
         ez41A9tqjuUr01/44yKqNlVKmCqDAwuMd0a/iKPxxS4rWinQb5YuZxHAS8DDLc2f0G/E
         CVaYqhJNptp2PL1hPxe0aLc7c0LFZqikPGLd3fZssuYctL+rViUMY+0DdPOUU6FAA+tR
         3lbweKMYZ2Wh2kTmfZQBLCQt21EBb4XUh1goIh7oWB3h+U20HhsRN23b1RW5J6Q0bWqa
         iFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712879839; x=1713484639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJmBil8hMiXltO9cI7CiQAcj05S/4ZhSQgUi9evlkRg=;
        b=HI3wbf3dnczqLtf6rptKJsSc2CLbKkfp9aJSBjlse5ry4lkpMsUN7WUwMSNR2q1jct
         BmzVijPDgkaPVyKGwcGfOid7sG3GyP03FCoBdm60XyD+HupnDqBUrvHkqfdX8AcawJpu
         Or7pAe13lgI+tH7o+Vgx5uGUpYfqhfPz5yehiigAs6u5b89HuZDkfj4igtRjZaq7wAH4
         WKuZ//4FJNiEFsPv7q2bq4AqO5eXQYckjtCCsjY9PH4JmKVn/CKUIgtkZ8nO5EoreaW2
         7pInoFxOsKB68atsp0aPtYb7B9qHdWpTRavu0/mVy8fBfxIiZSKTMJatc9ek6qDf4IDN
         Oo5A==
X-Forwarded-Encrypted: i=1; AJvYcCX3jj9R9FYzgvZz7oCJ4gFdjgLwct7/xBZadU11ze4y9ETRmGHG0hekFOMm5ep1A77nEZPeLmj9o3oaK5iLiE1wKEeLWTtiETvI5Z1+
X-Gm-Message-State: AOJu0Yz+hSB1vNZWAZkS5Dx8vo88Uqbi8ppvFUr8IBHUTfw0jSJUT20n
	RB0v0YtcaiC//MJjXwq8RJNqdlbrHNX5aRr21KnHbupBPgpejW0hGpfSdcy28PDupQsZZkNDJG9
	+d7dTN6SzgsbEfgNOYoigXtGTAc9R3JLbn33M
X-Google-Smtp-Source: AGHT+IF+X2P5TqWnhZ8FvJMZqUUFtJQMg6fg+29pF46qHVeB3vK6Vh/LpUf892lnAuaTAoZdwDB8s3Cb6IHxPXZJXUA=
X-Received: by 2002:a17:906:3110:b0:a4e:21e0:2e6e with SMTP id
 16-20020a170906311000b00a4e21e02e6emr588361ejx.5.1712879838488; Thu, 11 Apr
 2024 16:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <Zhhxg7VvBD38nymZ@google.com>
In-Reply-To: <Zhhxg7VvBD38nymZ@google.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Thu, 11 Apr 2024 16:56:41 -0700
Message-ID: <CAL715WLYN+S2Nk4OrqEuCMmyQypZt6r+WOyv1YYXfi+Moo--Mw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/41] KVM: x86/pmu: Introduce passthrough vPM
To: Sean Christopherson <seanjc@google.com>
Cc: Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com, 
	peterz@infradead.org, kan.liang@intel.com, zhenyuw@linux.intel.com, 
	dapeng1.mi@linux.intel.com, jmattson@google.com, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhiyuan.lv@intel.com, eranian@google.com, irogers@google.com, 
	samantha.alt@intel.com, like.xu.linux@gmail.com, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Thu, Apr 11, 2024 at 4:26=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Jan 26, 2024, Xiong Zhang wrote:
> > Dapeng Mi (4):
> >   x86: Introduce MSR_CORE_PERF_GLOBAL_STATUS_SET for passthrough PMU
> >   KVM: x86/pmu: Implement the save/restore of PMU state for Intel CPU
> >   KVM: x86/pmu: Introduce macro PMU_CAP_PERF_METRICS
> >   KVM: x86/pmu: Clear PERF_METRICS MSR for guest
> >
> > Kan Liang (2):
> >   perf: x86/intel: Support PERF_PMU_CAP_VPMU_PASSTHROUGH
> >   perf: Support guest enter/exit interfaces
> >
> > Mingwei Zhang (22):
> >   perf: core/x86: Forbid PMI handler when guest own PMU
> >   perf: core/x86: Plumb passthrough PMU capability from x86_pmu to
> >     x86_pmu_cap
> >   KVM: x86/pmu: Introduce enable_passthrough_pmu module parameter and
> >     propage to KVM instance
> >   KVM: x86/pmu: Plumb through passthrough PMU to vcpu for Intel CPUs
> >   KVM: x86/pmu: Add a helper to check if passthrough PMU is enabled
> >   KVM: x86/pmu: Allow RDPMC pass through
> >   KVM: x86/pmu: Create a function prototype to disable MSR interception
> >   KVM: x86/pmu: Implement pmu function for Intel CPU to disable MSR
> >     interception
> >   KVM: x86/pmu: Intercept full-width GP counter MSRs by checking with
> >     perf capabilities
> >   KVM: x86/pmu: Whitelist PMU MSRs for passthrough PMU
> >   KVM: x86/pmu: Introduce PMU operation prototypes for save/restore PMU
> >     context
> >   KVM: x86/pmu: Introduce function prototype for Intel CPU to
> >     save/restore PMU context
> >   KVM: x86/pmu: Zero out unexposed Counters/Selectors to avoid
> >     information leakage
> >   KVM: x86/pmu: Add host_perf_cap field in kvm_caps to record host PMU
> >     capability
> >   KVM: x86/pmu: Exclude existing vLBR logic from the passthrough PMU
> >   KVM: x86/pmu: Make check_pmu_event_filter() an exported function
> >   KVM: x86/pmu: Allow writing to event selector for GP counters if even=
t
> >     is allowed
> >   KVM: x86/pmu: Allow writing to fixed counter selector if counter is
> >     exposed
> >   KVM: x86/pmu: Introduce PMU helper to increment counter
> >   KVM: x86/pmu: Implement emulated counter increment for passthrough PM=
U
> >   KVM: x86/pmu: Separate passthrough PMU logic in set/get_msr() from
> >     non-passthrough vPMU
> >   KVM: nVMX: Add nested virtualization support for passthrough PMU
> >
> > Xiong Zhang (13):
> >   perf: Set exclude_guest onto nmi_watchdog
> >   perf: core/x86: Add support to register a new vector for PMI handling
> >   KVM: x86/pmu: Register PMI handler for passthrough PMU
> >   perf: x86: Add function to switch PMI handler
> >   perf/x86: Add interface to reflect virtual LVTPC_MASK bit onto HW
> >   KVM: x86/pmu: Add get virtual LVTPC_MASK bit function
> >   KVM: x86/pmu: Manage MSR interception for IA32_PERF_GLOBAL_CTRL
> >   KVM: x86/pmu: Switch IA32_PERF_GLOBAL_CTRL at VM boundary
> >   KVM: x86/pmu: Switch PMI handler at KVM context switch boundary
> >   KVM: x86/pmu: Call perf_guest_enter() at PMU context switch
> >   KVM: x86/pmu: Add support for PMU context switch at VM-exit/enter
> >   KVM: x86/pmu: Intercept EVENT_SELECT MSR
> >   KVM: x86/pmu: Intercept FIXED_CTR_CTRL MSR
>
> All done with this pass.  Looks quite good, nothing on the KVM side scare=
s me.  Nice!

yay! Thank you Sean for the review!

>
> I haven't spent much time thinking about whether or not the overall imple=
mentation
> correct/optimal, i.e. I mostly just reviewed the mechanics.  I'll make su=
re to
> spend a bit more time on that for the next RFC.

Yes, I am expecting the debate/discussion in PUCK after v2 is sent
out. There should be room for optimization as well.

>
> Please be sure to rebase to kvm-x86/next for the next RFC, there are a fe=
w patches
> that will change quite a bit.

Will do the rebase and all of the feedback will be taken and into
updates in v2. In v2, we will incorporate passthrough vPMU with AMD
support. Will do our best to get it in high quality.

Thanks.
-Mingwei

