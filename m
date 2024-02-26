Return-Path: <linux-kernel+bounces-82100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87B5867F46
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCAA71C2B1D0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC62012CD8E;
	Mon, 26 Feb 2024 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrWE+BqM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04A412CD89;
	Mon, 26 Feb 2024 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969820; cv=none; b=hsO8kcFBJR/BOzduLCkfvFCwq/5FfTxYksoe9PvyZ4ZpDbzpaaBXjs3lu5xYohUOLVWzwoQ6hiNFbQVOpHGuUT72RvU4L7uez4tF65wbQ84NA4m8sYnBGjn38cyMzgZovvOnOTDGJqGKhfrSWRtMbQvR5iThIFa3yK4oaWBbmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969820; c=relaxed/simple;
	bh=wY2eLkbtrhoomfozFUN93o5I4XSg/SMH19NuVLImBjc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9PQmZ/eibsEfCbnyg2jNDqxWN3LFhTILVZe1ljmJ8cRytAW3u/L+2kBt3icsLFU4vfIgCYI/4lqJdG7M28n5TbzwVe07PPoW9tq9WqwyLGxKfTGo3dam8MvYgsnxsCMz07oAElml7JNEJJMmEP3O4t31t1RBM94LTrFIenFMWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrWE+BqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA65C433C7;
	Mon, 26 Feb 2024 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708969820;
	bh=wY2eLkbtrhoomfozFUN93o5I4XSg/SMH19NuVLImBjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JrWE+BqMwGZNC4w1lMhLU4ShuB+9L3d7gDQQpmjx+a9G6EPVNUYywvAxtqs87dSjw
	 Uc73NXFmd8bWTr9d6qflo2KOQPsY7PD/sIGMNIKamVB5K3eeT2Dn51hMP9ss4rtLOZ
	 d/uDi8O82CArbWJilAx2GRCB7ZS7BXX9L68rDR9uaGoHK7DpFpRw+hV4D6KQyQhT42
	 j5hvXl35jKCdZkXbSwSe3kn6Q3PvJb0Co4KLMfYpTXnYmD7A8ysgJ9MSG3mZrgGUlH
	 XwShGjMX6ixa/g0JHZpSGX2hl6Vuc1JATYafC2bF7bIK4ZICwSHpVz86LDfgmEnHNV
	 I7F4oDekSsiCg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1ref7J-006yqU-KF;
	Mon, 26 Feb 2024 17:50:17 +0000
Date: Mon, 26 Feb 2024 17:50:17 +0000
Message-ID: <86bk832jza.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	suzuki.poulose@arm.com,
	acme@kernel.org,
	oliver.upton@linux.dev,
	broonie@kernel.org,
	James Morse <james.morse@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Miguel Luis <miguel.luis@oracle.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Walbran <qwandor@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Jing Zhang <jingzhangos@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 7/8] arm64: KVM: Write TRFCR value on guest switch with nVHE
In-Reply-To: <20240226113044.228403-8-james.clark@arm.com>
References: <20240226113044.228403-1-james.clark@arm.com>
	<20240226113044.228403-8-james.clark@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: james.clark@arm.com, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, suzuki.poulose@arm.com, acme@kernel.org, oliver.upton@linux.dev, broonie@kernel.org, james.morse@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, mike.leach@linaro.org, alexander.shishkin@linux.intel.com, anshuman.khandual@arm.com, miguel.luis@oracle.com, joey.gouly@arm.com, ardb@kernel.org, javierm@redhat.com, mark.rutland@arm.com, arnd@arndb.de, qwandor@google.com, vdonnefort@google.com, ryan.roberts@arm.com, tabba@google.com, jingzhangos@google.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 26 Feb 2024 11:30:35 +0000,
James Clark <james.clark@arm.com> wrote:
>=20
> The guest value for TRFCR requested by the Coresight driver is saved in
> kvm_guest_trfcr. On guest switch this value needs to be written to
> the register. Currently TRFCR is only modified when we want to disable
> trace completely in guests due to an issue with TRBE. Expand the
> __debug_save_trace() function to always write to the register if a
> different value for guests is required, but also keep the existing TRBE
> disable behavior if that's required.
>=20
> In pKVM, the kvm_guest_trfcr can't be read and the host isn't trusted,
> so always disable trace.
>=20
> __debug_restore_trace() now has to restore unconditionally, because even
> a value of 0 needs to be written to overwrite whatever was set for the
> guest.
>=20
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/debug-sr.c | 53 +++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 22 deletions(-)
>=20
> diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe=
/debug-sr.c
> index 4558c02eb352..3adac2e01908 100644
> --- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
> +++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
> @@ -51,30 +51,39 @@ static void __debug_restore_spe(u64 pmscr_el1)
>  	write_sysreg_s(pmscr_el1, SYS_PMSCR_EL1);
>  }
> =20
> -static void __debug_save_trace(u64 *trfcr_el1)
> +static void __debug_save_trace(struct kvm_vcpu *vcpu)
>  {
> -	*trfcr_el1 =3D 0;
> -
> -	/* Check if the TRBE is enabled */
> -	if (!(read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_EL1_E))
> -		return;
> -	/*
> -	 * Prohibit trace generation while we are in guest.
> -	 * Since access to TRFCR_EL1 is trapped, the guest can't
> -	 * modify the filtering set by the host.
> -	 */
> -	*trfcr_el1 =3D read_sysreg_s(SYS_TRFCR_EL1);
> -	write_sysreg_s(0, SYS_TRFCR_EL1);
> -	isb();
> -	/* Drain the trace buffer to memory */
> -	tsb_csync();
> +	u64 host_trfcr_el1 =3D read_sysreg_s(SYS_TRFCR_EL1);
> +	u64 guest_trfcr_el1;
> +
> +	vcpu->arch.host_debug_state.trfcr_el1 =3D host_trfcr_el1;

Huh, this madness has to stop. See patch below. The short story is
that we have to stop shoving host state in vcpus. This is gross, and a
stupid waste of memory.

> +
> +	/* Check if the TRBE buffer or pKVM is enabled */
> +	if (is_protected_kvm_enabled() ||
> +	    (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE) &&
> +	     read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_EL1_E)) {
> +		/*
> +		 * Prohibit trace generation while we are in guest. Since access
> +		 * to TRFCR_EL1 is trapped, the guest can't modify the filtering
> +		 * set by the host.
> +		 */
> +		write_sysreg_s(0, SYS_TRFCR_EL1);
> +		isb();
> +		/* Drain the trace buffer to memory */
> +		tsb_csync();
> +	} else {
> +		/*
> +		 * Tracing is allowed, apply the filters provided by the
> +		 * Coresight driver.
> +		 */
> +		guest_trfcr_el1 =3D kvm_guest_trfcr[vcpu->cpu];
> +		if (host_trfcr_el1 !=3D guest_trfcr_el1)
> +			write_sysreg_s(guest_trfcr_el1, SYS_TRFCR_EL1);

So we have 3 pieces of storage for TRFCR_EL1:

- the system register itself
- the copy in host_debug_state, which is only used transiently
- another version in kvm_guest_trfcr, provided by Coresight

Why do we need to save anything if nothing was enabled, which is *all
the time*? I'm sorry to break it to you, but nobody uses these
features.  So I'd like them to have zero cost when not in use.

> +	}
>  }
>
>  static void __debug_restore_trace(u64 trfcr_el1)
>  {
> -	if (!trfcr_el1)
> -		return;
> -
>  	/* Restore trace filter controls */
>  	write_sysreg_s(trfcr_el1, SYS_TRFCR_EL1);
>  }
> @@ -85,8 +94,8 @@ void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vc=
pu)
>  	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
>  		__debug_save_spe(&vcpu->arch.host_debug_state.pmscr_el1);
>  	/* Disable and flush Self-Hosted Trace generation */
> -	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
> -		__debug_save_trace(&vcpu->arch.host_debug_state.trfcr_el1);
> +	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))
> +		__debug_save_trace(vcpu);

The more I read this code, the less I understand why we need these
flags. DEBUG_STATE_SAVE_TRFCR really means "I support TRF". But we
already have that information in the ID registers, and we could cache
it on a per-physical CPU basis instead of per-vcpu. Hell, on an
homogeneous system, this could even be a static key. Do we even have
systems out there where only half the CPUs support TRF?

Then we check whether TRBE is enabled. But if it isn't, we randomly
write whatever is in kvm_guest_trfcr[]? Why would we do that? Surely
there is something there that should say "yup, tracing" or not (such
as the enable bits), which would avoid hitting the sysreg pointlessly?

I really think that this logic should be:

- strictly based on ID registers or even better, static keys
- result in close to 0 system register access when not in use
- avoid storing state that doesn't need to be stored

Thanks,

      M.

=46rom a3e98d8428d854209f0e97aa38d1bee347c503f2 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Mon, 26 Feb 2024 15:58:46 +0000
Subject: [PATCH] KVM: arm64: Exclude host_debug_data from vcpu_arch

Keeping host_debug_state on a per-vcpu basis is completely
pointless. The lifetime of this data is only that of the inner
run-loop, which means it is never accessed outside of the core
EL2 code.

Move the structure into kvm_host_data, and save over 500 bytes
per vcpu.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h         | 31 +++++++++++++----------
 arch/arm64/kvm/hyp/include/hyp/debug-sr.h |  4 +--
 arch/arm64/kvm/hyp/nvhe/debug-sr.c        |  8 +++---
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm=
_host.h
index addf79ba8fa0..599de77a232f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -601,6 +601,19 @@ struct kvm_cpu_context {
=20
 struct kvm_host_data {
 	struct kvm_cpu_context host_ctxt;
+
+	/*
+	 * host_debug_state contains the host registers which are
+	 * saved and restored during world switches.
+	 */
+	 struct {
+		/* {Break,watch}point registers */
+		struct kvm_guest_debug_arch regs;
+		/* Statistical profiling extension */
+		u64 pmscr_el1;
+		/* Self-hosted trace */
+		u64 trfcr_el1;
+	} host_debug_state;
 };
=20
 struct kvm_host_psci_config {
@@ -695,11 +708,10 @@ struct kvm_vcpu_arch {
 	 * We maintain more than a single set of debug registers to support
 	 * debugging the guest from the host and to maintain separate host and
 	 * guest state during world switches. vcpu_debug_state are the debug
-	 * registers of the vcpu as the guest sees them.  host_debug_state are
-	 * the host registers which are saved and restored during
-	 * world switches. external_debug_state contains the debug
-	 * values we want to debug the guest. This is set via the
-	 * KVM_SET_GUEST_DEBUG ioctl.
+	 * registers of the vcpu as the guest sees them.
+	 *
+	 * external_debug_state contains the debug values we want to debug the
+	 * guest. This is set via the KVM_SET_GUEST_DEBUG ioctl.
 	 *
 	 * debug_ptr points to the set of debug registers that should be loaded
 	 * onto the hardware when running the guest.
@@ -711,15 +723,6 @@ struct kvm_vcpu_arch {
 	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
 	struct task_struct *parent_task;
=20
-	struct {
-		/* {Break,watch}point registers */
-		struct kvm_guest_debug_arch regs;
-		/* Statistical profiling extension */
-		u64 pmscr_el1;
-		/* Self-hosted trace */
-		u64 trfcr_el1;
-	} host_debug_state;
-
 	/* VGIC state */
 	struct vgic_cpu vgic_cpu;
 	struct arch_timer_cpu timer_cpu;
diff --git a/arch/arm64/kvm/hyp/include/hyp/debug-sr.h b/arch/arm64/kvm/hyp=
/include/hyp/debug-sr.h
index 961bbef104a6..d2a40eb82f15 100644
--- a/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
@@ -137,7 +137,7 @@ static inline void __debug_switch_to_guest_common(struc=
t kvm_vcpu *vcpu)
=20
 	host_ctxt =3D &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	guest_ctxt =3D &vcpu->arch.ctxt;
-	host_dbg =3D &vcpu->arch.host_debug_state.regs;
+	host_dbg =3D &this_cpu_ptr(&kvm_host_data)->host_debug_state.regs;
 	guest_dbg =3D kern_hyp_va(vcpu->arch.debug_ptr);
=20
 	__debug_save_state(host_dbg, host_ctxt);
@@ -156,7 +156,7 @@ static inline void __debug_switch_to_host_common(struct=
 kvm_vcpu *vcpu)
=20
 	host_ctxt =3D &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	guest_ctxt =3D &vcpu->arch.ctxt;
-	host_dbg =3D &vcpu->arch.host_debug_state.regs;
+	host_dbg =3D &this_cpu_ptr(&kvm_host_data)->host_debug_state.regs;
 	guest_dbg =3D kern_hyp_va(vcpu->arch.debug_ptr);
=20
 	__debug_save_state(guest_dbg, guest_ctxt);
diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/d=
ebug-sr.c
index 4558c02eb352..8103f8c695b4 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -83,10 +83,10 @@ void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vc=
pu)
 {
 	/* Disable and flush SPE data generation */
 	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
-		__debug_save_spe(&vcpu->arch.host_debug_state.pmscr_el1);
+		__debug_save_spe(&this_cpu_ptr(&kvm_host_data)->host_debug_state.pmscr_e=
l1);
 	/* Disable and flush Self-Hosted Trace generation */
 	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
-		__debug_save_trace(&vcpu->arch.host_debug_state.trfcr_el1);
+		__debug_save_trace(&this_cpu_ptr(&kvm_host_data)->host_debug_state.trfcr=
_el1);
 }
=20
 void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
@@ -97,9 +97,9 @@ void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
 void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 {
 	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
-		__debug_restore_spe(vcpu->arch.host_debug_state.pmscr_el1);
+		__debug_restore_spe(this_cpu_ptr(&kvm_host_data)->host_debug_state.pmscr=
_el1);
 	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
-		__debug_restore_trace(vcpu->arch.host_debug_state.trfcr_el1);
+		__debug_restore_trace(this_cpu_ptr(&kvm_host_data)->host_debug_state.trf=
cr_el1);
 }
=20
 void __debug_switch_to_host(struct kvm_vcpu *vcpu)
--=20
2.39.2


--=20
Without deviation from the norm, progress is not possible.

