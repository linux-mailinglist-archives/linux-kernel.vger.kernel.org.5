Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A1C8087BF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379279AbjLGMas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjLGMaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:30:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E17D5C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:30:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F9FC433C8;
        Thu,  7 Dec 2023 12:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701952251;
        bh=uBGsvNf3/15p47wC7lzZSGRCb92G+RXjfng5yK2Bh9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dm3jAV4VvxsO77I5J9QfvFYsM0pigSUkWL4PSeyx8xawRiX77iFtMo/vMMlaWjJV5
         nuMZhHz+Qfm/Y7CkFSHAUvTbkFD/icwm9+MS/f023XIZZRXI9jHMGV0FjbMb8pdjAq
         X7uQec7eEBa52Np9p50Bwx7UazlM8rH4/WfEXdaFuO46lzlwggbiD7isusHfECzYdf
         c2+bdiocXB0HJzLzAQ7cC3UyDt/H2K98dhlNq17g6TXCBJz6UAoTtzyHwEjZ5ZkgSq
         rkmiP37+0tqEiP3DQTxLrvdC4gJjrI3VAMXifgT/kgFGTeIFl3aTKuulJsxtfq3qYT
         vW2K+74xR1Jkg==
Date:   Thu, 7 Dec 2023 12:30:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 15/21] KVM: arm64: Support FEAT_FPMR for guests
Message-ID: <08ae06c7-1654-4dfd-a789-b8e13c87d705@sirena.org.uk>
References: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
 <20231205-arm64-2023-dpisa-v3-15-dbcbcd867a7f@kernel.org>
 <87cyvi8kz1.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FPF7dtAOG+ogzzSV"
Content-Disposition: inline
In-Reply-To: <87cyvi8kz1.wl-maz@kernel.org>
X-Cookie: Two is company, three is an orgy.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FPF7dtAOG+ogzzSV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 07, 2023 at 08:39:46AM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> >  #define HCRX_GUEST_FLAGS \
> > -	(HCRX_EL2_SMPME | HCRX_EL2_TCR2En | \
> > +	(HCRX_EL2_SMPME | HCRX_EL2_TCR2En | HCRX_EL2_EnFPM | \

> We really should start making all of these things conditional. See
> below.

Is there an overarching theory behind how these things are intended to
work?  I agree with you that I'd have expected more conditionality here,
I was trying to fit in with the existing pattern.  It's kind of hard to
follow what the intention is, I think to some extent due to things
having evolved over time.

> > @@ -517,7 +519,6 @@ struct kvm_vcpu_arch {
> >  	enum fp_type fp_type;
> >  	unsigned int sve_max_vl;
> >  	u64 svcr;
> > -	u64 fpmr;

> Why do this change here? Why isn't done like that the first place?

It didn't seem right to add the register to struct vcpu_sysreg before it
was handled by KVM.  As referenced in the cover letter normally this
wouldn't come up because KVM doesn't rely on the host kernel for
managing register state so we add KVM support then enable the host
kernel but for FPSIMD we're reusing fpsimd_save() so we need the host
kernel support to be in place when we enable KVM.

> >  	CGT_MDCR_TDE,
> > @@ -279,6 +281,12 @@ static const struct trap_bits coarse_trap_bits[] = {
> >  		.mask		= HCR_TTLBOS,
> >  		.behaviour	= BEHAVE_FORWARD_ANY,
> >  	},
> > +	[CGT_HCRX_EnFPM] = {
> > +		.index		= HCRX_EL2,
> > +		.value		= HCRX_EL2_EnFPM,
> > +		.mask		= HCRX_EL2_EnFPM,
> > +		.behaviour	= BEHAVE_FORWARD_ANY,

> This looks wrong. HCRX_EL2.EnFPM is an enable bit.

Right, it's the wrong way round.

> > +static void *fpsimd_share_end(struct user_fpsimd_state *fpsimd)
> > +{
> > +	void *share_end = fpsimd + 1;
> > +
> > +	if (cpus_have_final_cap(ARM64_HAS_FPMR))
> > +		share_end += sizeof(u64);
> > +
> > +	return share_end;
> > +}

> This is horrible. Why can't you just have a new structure wrapping
> both user_fpsimd_state and fpmr? This is going to break in subtle
> ways, just like the SVE/SME stuff.

I agree that it's not great, the main issue was that fpsimd_state is
both already embedded in uw for hardened usercopy and very widely
referenced by exactly which struct it's in so I was taking a guess as to
what would get the least objections.  The obvious thing would be to add
FPMR to uw and share the whole thing with the hypervisor, if people
don't mind adding another field to uw I could do that?

> >  	vcpu->arch.host_fpsimd_state = kern_hyp_va(fpsimd);
> > +	if (cpus_have_final_cap(ARM64_HAS_FPMR)) {
> > +		WARN_ON_ONCE(&current->thread.fpmr + 1 != fpsimd_share_end(fpsimd));

> How can this happen?

It shouldn't, but it'd be bad if it did so I put a check in to make sure
we haven't messed up.

> > +		vcpu->arch.host_fpmr = kern_hyp_va(&current->thread.fpmr);
> > +	}

> We really need to stop piling the save/restore of stuff that isn't
> advertised to the guest.

I'm not clear what you're referencing here?  The feature is advertised
to the guest via the ID registers and in the past you've pushed back on
making things where the state is just a single register like this
optional.  Do you mean that we should be making this conditional on the
guest ID registers?  If that is the case is there a plan for how that's
supposed to work, set flags when kvm_vcpu_run_pid_change() happens for
example?

--FPF7dtAOG+ogzzSV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVxuvUACgkQJNaLcl1U
h9DsZwf/dMO5funercMGolm8oxu/rwH8RhndodNpMcUaWBpR0dwxASiyO2p9IMUH
Po/pRzhdyqIi2EI21TfSynfq0OU0YKFsDNc0ZTGZPjZkBvgeBCLw7dSwWsLw865C
oIboqH/96ZHXVmdGMtaU/dPUCNlnmn85XMRfRRIzYV1Nl9pjokOwsJ3qyQ+YxuXu
dTuX5qZXeU2UYiuRhdKXYvqy332vAmEY9E8zjCr2GBhJCyi8NIIUVTKgx2+Q8/ZF
nqpGNxpQKVfFGpQzrbQXR5TL5/92Ody9tt9n9j2vG1M8hSqrYXM0RaEFW0KG/+4a
vm0qMhLuef6WzUqjhfrEaIdaG+9Lig==
=vTs7
-----END PGP SIGNATURE-----

--FPF7dtAOG+ogzzSV--
