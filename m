Return-Path: <linux-kernel+bounces-121360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA90688E6B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E5F2C95BD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469681386DF;
	Wed, 27 Mar 2024 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+b05JUj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E9A127B5F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545810; cv=none; b=hpB1m+s8yfREsPmC9eYj8qxqZ952JZ+WyJ/uuxnpzPTFpfiOMiO8leN99rVeoGo5XGGHhj1PczgNCAcsPYCujHcD92lxnUENtvhjanqm3XmEKGzQ/ge5+lIx3jSms75xCvJJXu+g5/By9EWOmRgWELR3lj9iPnyYJWHRsFYO1B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545810; c=relaxed/simple;
	bh=U7abAYA8MCl0AIbIYaTfhg3/P08q63VTWwI22U1GpRo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lU99OqbN0bLmmaY7A2in8p3ALNbM8eZX2d66Smmr7rLNFR/363OKIYAn6BbQNsmS3f7edNpLtc/vFOYGavFASp/CpOYt6Zui2rUK5D8/NvITNUU+20fXjgQhvWd/mVEPyfT/+BEGM2YCxy2+Z/PaQPj0YQ32Q0+TtrIF1gdS3zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+b05JUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6AAC43394;
	Wed, 27 Mar 2024 13:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711545810;
	bh=U7abAYA8MCl0AIbIYaTfhg3/P08q63VTWwI22U1GpRo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Z+b05JUje7LfkVLWp2X/on6sDdqTF4W2g/f4omGVP4ZosDCiI3xVXCdCEClOLvID7
	 KLVVoNUWBnDIhjDIHxZtuIj2ZOjUOz1tElMOQIu1VuSt5Ky6nWuDbVGthZHXHmsxrE
	 eqtaKq1V2ABFMCS/OfnPQOPMp2IpfLPX0NFOJWSZ+yn/9kPaW6UZYyDE3s3WdXVyfE
	 FEKeg0OIodQL7NKr3+KwJbOduoWiciKPsUfDCuADvVppCjAz2l7KWel9y5Plpfa2yq
	 wjsxnN9rtfXsrAXII+73GJ9Ja0NLXgCHTuYyESt4y5wT2wFbB5M8TAGiuIaWU2/HL4
	 i/kiwtdft8dAA==
Message-ID: <fb1d34b54d00fce340c1c7e20e6d8590293f3513.camel@kernel.org>
Subject: Re: [PATCH 4/4] kprobes: Remove core dependency on modules
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, 
 anil.s.keshavamurthy@intel.com, aou@eecs.berkeley.edu, bp@alien8.de, 
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, davem@davemloft.net, 
 gor@linux.ibm.com, hca@linux.ibm.com, jcalvinowens@gmail.com, 
 linux-arm-kernel@lists.infradead.org, mingo@redhat.com, mpe@ellerman.id.au,
  naveen.n.rao@linux.ibm.com, palmer@dabbelt.com, paul.walmsley@sifive.com, 
 tglx@linutronix.de, will@kernel.org
Date: Wed, 27 Mar 2024 15:23:24 +0200
In-Reply-To: <20240327090155.873f1ed32700dbdb75f8eada@kernel.org>
References: <20240326163624.3253157-1-mark.rutland@arm.com>
	 <20240326163624.3253157-5-mark.rutland@arm.com>
	 <D03UMKC71414.2D6NN1BIWD5TZ@kernel.org>
	 <ZgMICo-dZJgVklc4@FVFF77S0Q05N.cambridge.arm.com>
	 <20240327090155.873f1ed32700dbdb75f8eada@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-27 at 09:01 +0900, Masami Hiramatsu wrote:
> On Tue, 26 Mar 2024 17:38:18 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
>=20
> > On Tue, Mar 26, 2024 at 07:13:51PM +0200, Jarkko Sakkinen wrote:
> > > On Tue Mar 26, 2024 at 6:36 PM EET, Mark Rutland wrote:
> >=20
> > > > +#ifdef CONFIG_MODULES
> > > > =C2=A0	/* Check if 'p' is probing a module. */
> > > > =C2=A0	*probed_mod =3D __module_text_address((unsigned long) p-
> > > > >addr);
> > > > =C2=A0	if (*probed_mod) {
> > > > @@ -1605,6 +1606,8 @@ static int
> > > > check_kprobe_address_safe(struct kprobe *p,
> > > > =C2=A0			ret =3D -ENOENT;
> > > > =C2=A0		}
> > > > =C2=A0	}
> > > > +#endif
> > >=20
> > > This can be scoped a bit more (see v7 of my patch set).
> >=20
> > > > +#ifdef CONFIG_MODULES
> > > > =C2=A0static nokprobe_inline bool trace_kprobe_module_exist(struct
> > > > trace_kprobe *tk)
> > > > =C2=A0{
> > > > =C2=A0	char *p;
> > > > @@ -129,6 +130,9 @@ static nokprobe_inline bool
> > > > trace_kprobe_module_exist(struct trace_kprobe *tk)
> > > > =C2=A0
> > > > =C2=A0	return ret;
> > > > =C2=A0}
> > > > +#else
> > > > +#define trace_kprobe_module_exist(tk) false /* aka a module
> > > > never exists */
> > > > +#endif /* CONFIG_MODULES */
> > > > =C2=A0
> > > > =C2=A0static bool trace_kprobe_is_busy(struct dyn_event *ev)
> > > > =C2=A0{
> > > > @@ -670,6 +674,7 @@ static int register_trace_kprobe(struct
> > > > trace_kprobe *tk)
> > > > =C2=A0	return ret;
> > > > =C2=A0}
> > > > =C2=A0
> > > > +#ifdef CONFIG_MODULES
> > > > =C2=A0/* Module notifier call back, checking event on the module */
> > > > =C2=A0static int trace_kprobe_module_callback(struct notifier_block
> > > > *nb,
> > > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long val, v=
oid
> > > > *data)
> > > > @@ -699,6 +704,9 @@ static int
> > > > trace_kprobe_module_callback(struct notifier_block *nb,
> > > > =C2=A0
> > > > =C2=A0	return NOTIFY_DONE;
> > > > =C2=A0}
> > > > +#else
> > > > +#define trace_kprobe_module_callback (NULL)
> > > > +#endif /* CONFIG_MODULES */
> > >=20
> > > The last two CONFIG_MODULES sections could be combined. This was
> > > also in
> > > v7.
> >=20
> > > Other than lgtm.
> >=20
> > Great! I've folded your v7 changes in, and pushed that out to:
> >=20
> > =C2=A0
> > https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=
=3Dkprobes/without-modules
> >=20
> > I'll hold off sending that out to the list until other folk have
> > had a chance
> > to comment.
>=20
> Yeah, the updated one looks good to me too.
>=20
> Thanks!

Yeah, I'm also planning to test this with x86 instrumenting sgx_* calls
as I need to test the cgroups support for it so can help with the
coverage both RISC-V and x86 (as I find a good time slot).

BR, Jarkko

