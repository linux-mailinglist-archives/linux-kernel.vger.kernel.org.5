Return-Path: <linux-kernel+bounces-92756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DB787258F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298831F24564
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858DF168B9;
	Tue,  5 Mar 2024 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vX1bXk8p"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3F914286
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659332; cv=none; b=chqn3LHD68xD0gNsmcottHTzGjERT33bBUfwmQZDMw8ghp9V6dWedONt/lSazGrWP1sUfrVtLyOWIKktTj9m4AKUmbXR3oHH/89PIvBP1dvs5vsDdchkEUSmpKzzoJveQ0S50JSijqta/kFK92D0xNxjg+cnoQR7E+aPAqU47po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659332; c=relaxed/simple;
	bh=pwOrjfAOm0UVWurpdjRjhZSdf0C9prn8yc/6q2b8AtQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XuGuLjKUKPYgggL4mBJkRoM3wyjm5D4VNFdjwx52P9rIwEnSNzUlkSaUMwRiUs4k0HrPRr9zmTin/EAGyicCGucLuhwV52ADPN10ZqfqpNDDOHSQnwa0Aa58U9RirupmWM1XlSpSuyJqQS0q5BC812qDP4UJ1vhVRprBgkB0UdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vX1bXk8p; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b2682870so9594731276.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 09:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709659330; x=1710264130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkawy6SBW/c0hBCVzYm6ir0cPepyH+x2hY6g8C2mgqI=;
        b=vX1bXk8pxp17cyk6WY5Fs9FaXL0d6bq9s058uBlJ9pBdi+HIdrz6cacvo2Ez1Mv73H
         01PO0Dz1bX5EwAAtA5BbOUd8pWVd9NVUG94aHH9kdi/FqkpqTOQ9uMqMUoTMbkpqshuD
         VkD/tHb0Utx7HCNe6R5sryFYwH8od55igALCvGf5l5DQpEK39TDXPiKskJfR/5NfsLVe
         7xT4G3dFvQWcxhMeHjUuX/5yn4VljgUEK60NDDxvIPZ8+EhwD0U4p6sYP9XXQiXovL9f
         D/l9v99TjWLrUeVDdHjvRloEllkEb3pUkFPl2baaEiyLEXRXLQupVKNHhOqARV5CjhT/
         5pXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709659330; x=1710264130;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kkawy6SBW/c0hBCVzYm6ir0cPepyH+x2hY6g8C2mgqI=;
        b=EFS9x2OTNJOFpv6KqJB3I9WH5L7GTrV/yOnVE7jhD3agyVpaqTRIfFF1v/DCslox0F
         B+DCn6+XQdLkA8jjui5Ud+xlhAsEnXDKaH+cMk6+S5bNJWGxfuJv/ZoA24J2BvuDIZs/
         lLXMxQu4g5WKYLDDB6t6rlr+ZIXVr8+wH+oHuUnMkHpEla9e93qpXmZSHHqYqVwhnpE/
         IewY6Y3lziDzRBMMy6xaQdQU/ENzZHGn8Yw2DbiNN6sUKzOpgYJEt09Q3RinT9gxNy2N
         YQSKRs0T/OhhJHbr0C4NZl0/PTocnPMLFSxg19AClqINLt35UZoFEzdwcKV8r+2fqJM2
         s/cw==
X-Forwarded-Encrypted: i=1; AJvYcCV2iEIdXjdw83pKZJ5X2gpmqF8VrthcVbq2FsZkvF6eOvcx4MCJ30T3tR5IfHtBCMzx4uz+l6lywOrkPYjAitlYsk1pi6cAfhPUp5Uz
X-Gm-Message-State: AOJu0YxUE9VLLUxoolqiFhyOko6tZ0+MKXZesYYRTcXCMXSjz81tX5Y0
	5lJSYQkbfJEe2OD1Lp4SdNryfuDpfjzoDXNJPuWsV4RDjQVWG+kzlX+/l/kkDEdR1qMgf9XKYqq
	sfw==
X-Google-Smtp-Source: AGHT+IHjijMg6haor2+fxukpIgm7342bWGSF+cpR0joPwOd9ERBEhCSkI+psP3njmNYvnqfOP1a3u8KT1U0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:18c9:b0:dcd:5e5d:458b with SMTP id
 ck9-20020a05690218c900b00dcd5e5d458bmr3230561ybb.3.1709659329909; Tue, 05 Mar
 2024 09:22:09 -0800 (PST)
Date: Tue, 5 Mar 2024 09:22:08 -0800
In-Reply-To: <8a846ba5-d346-422e-817b-e00ab9701f19@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301075007.644152-1-sandipan.das@amd.com> <06061a28-88c0-404b-98a6-83cc6cc8c796@gmail.com>
 <cc8699be-3aae-42aa-9c70-f8b6a9728ee3@amd.com> <f5bbe9ac-ca35-4c3e-8cd7-249839fbb8b8@linux.intel.com>
 <ZeYlEGORqeTPLK2_@google.com> <8a846ba5-d346-422e-817b-e00ab9701f19@gmail.com>
Message-ID: <ZedUwKWW7PNkvUH1@google.com>
Subject: Re: [PATCH] KVM: x86/svm/pmu: Set PerfMonV2 global control bits correctly
From: Sean Christopherson <seanjc@google.com>
To: Like Xu <like.xu.linux@gmail.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	pbonzini@redhat.com, mizhang@google.com, jmattson@google.com, 
	ravi.bangoria@amd.com, nikunj.dadhania@amd.com, santosh.shukla@amd.com, 
	manali.shukla@amd.com, babu.moger@amd.com, kvm list <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024, Like Xu wrote:
> On 5/3/2024 3:46 am, Sean Christopherson wrote:
> > > > > > ---
> > > > > >   =C2=A0 arch/x86/kvm/svm/pmu.c | 1 +
> > > > > >   =C2=A0 1 file changed, 1 insertion(+)
> > > > > >=20
> > > > > > diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> > > > > > index b6a7ad4d6914..14709c564d6a 100644
> > > > > > --- a/arch/x86/kvm/svm/pmu.c
> > > > > > +++ b/arch/x86/kvm/svm/pmu.c
> > > > > > @@ -205,6 +205,7 @@ static void amd_pmu_refresh(struct kvm_vcpu=
 *vcpu)
> > > > > >   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pmu->version > 1) {
> > > > > >   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pmu->g=
lobal_ctrl_mask =3D ~((1ull << pmu->nr_arch_gp_counters) - 1);
> > > > > >   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pmu->g=
lobal_status_mask =3D pmu->global_ctrl_mask;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pmu->global_ctrl =
=3D ~pmu->global_ctrl_mask;
> > >=20
> > > It seems to be more easily understand to calculate global_ctrl firstl=
y and
> > > then derive the globol_ctrl_mask (negative logic).
> >=20
> > Hrm, I'm torn.  On one hand, awful name aside (global_ctrl_mask should =
really be
> > something like global_ctrl_rsvd_bits), the computation of the reserved =
bits should
> > come from the capabilities of the PMU, not from the RESET value.
> >=20
> > On the other hand, setting _all_ non-reserved bits will likely do the w=
rong thing
> > if AMD ever adds bits in PerfCntGlobalCtl that aren't tied to general p=
urpose
> > counters.  But, that's a future theoretical problem, so I'm inclined to=
 vote for
> > Sandipan's approach.
>=20
> I suspect that Intel hardware also has this behaviour [*] although guest
> kernels using Intel pmu version 1 are pretty much non-existent.
>=20
> [*] Table 10-1. IA-32 and Intel=C2=AE 64 Processor States Following Power=
-up,
> Reset, or INIT (Contd.)

Aha!  Nice.  To save people lookups, the table says:

  IA32_PERF_GLOBAL_CTRL:  Sets bits n-1:0 and clears the upper bits.

and=20

  Where "n" is the number of general-purpose counters available in the proc=
essor.

Which means that (a) KVM can handle this in common code and (b) we can dodg=
e the
whole reserved bits chicken-and-egg problem since global_ctrl *can't* be de=
rived
from global_ctrl_mask.

This?  (compile tested only)

---
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 5 Mar 2024 09:02:26 -0800
Subject: [PATCH] KVM: x86/pmu: Set enable bits for GP counters in
 PERF_GLOBAL_CTRL at "RESET"

Set the enable bits for general purpose counters in IA32_PERF_GLOBAL_CTRL
when refreshing the PMU to emulate the MSR's architecturally defined
post-RESET behavior.  Per Intel's SDM:

  IA32_PERF_GLOBAL_CTRL:  Sets bits n-1:0 and clears the upper bits.

and

  Where "n" is the number of general-purpose counters available in the proc=
essor.

This is a long-standing bug that was recently exposed when KVM added
supported for AMD's PerfMonV2, i.e. when KVM started exposing a vPMU with
PERF_GLOBAL_CTRL to guest software that only knew how to program v1 PMUs
(that don't support PERF_GLOBAL_CTRL).  Failure to emulate the post-RESET
behavior results in such guests unknowingly leaving all general purpose
counters globally disabled (the entire reason the post-RESET value sets
the GP counter enable bits is to maintain backwards compatibility).

The bug has likely gone unnoticed because PERF_GLOBAL_CTRL has been
supported on Intel CPUs for as long as KVM has existed, i.e. hardly anyone
is running guest software that isn't aware of PERF_GLOBAL_CTRL on Intel
PMUs.

Note, kvm_pmu_refresh() can be invoked multiple times, i.e. it's not a
"pure" RESET flow.  But it can only be called prior to the first KVM_RUN,
i.e. the guest will only ever observe the final value.

Reported-by: Reported-by: Babu Moger <babu.moger@amd.com>
Cc: Like Xu <like.xu.linux@gmail.com>
Cc: Mingwei Zhang <mizhang@google.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 87cc6c8809ad..f61ce26aeb90 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -741,6 +741,8 @@ static void kvm_pmu_reset(struct kvm_vcpu *vcpu)
  */
 void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 {
+	struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
+
 	if (KVM_BUG_ON(kvm_vcpu_has_run(vcpu), vcpu->kvm))
 		return;
=20
@@ -750,8 +752,18 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	 */
 	kvm_pmu_reset(vcpu);
=20
-	bitmap_zero(vcpu_to_pmu(vcpu)->all_valid_pmc_idx, X86_PMC_IDX_MAX);
+	bitmap_zero(pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
 	static_call(kvm_x86_pmu_refresh)(vcpu);
+
+	/*
+	 * At RESET, both Intel and AMD CPUs set all enable bits for general
+	 * purpose counters in IA32_PERF_GLOBAL_CTRL (so that software that
+	 * was written for v1 PMUs don't unknowingly leave GP counters disabled
+	 * in the global controls).  Emulate that behavior when refreshing the
+	 * PMU so that userspace doesn't need to manually set PERF_GLOBAL_CTRL.
+	 */
+	if (kvm_pmu_has_perf_global_ctrl(pmu))
+		pmu->global_ctrl =3D GENMASK_ULL(pmu->nr_arch_gp_counters - 1, 0);
 }
=20
 void kvm_pmu_init(struct kvm_vcpu *vcpu)

base-commit: 1d7ae977d219e68698fdb9bed1049dc561038aa1
--=20

