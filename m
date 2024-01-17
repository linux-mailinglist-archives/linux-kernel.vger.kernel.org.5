Return-Path: <linux-kernel+bounces-29528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EE5830FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DE61C213A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07E725620;
	Wed, 17 Jan 2024 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMZudiZg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9298F1E887;
	Wed, 17 Jan 2024 23:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532541; cv=none; b=CVLTmWl2cZhFf7UnUohxXUMBgXIxKV5kbKTq0fq8DZ0W2we50pGV5e3DnVQUCpQ8Xttt9+eusyiyq2yeGFcVe95i6PWn0aHSFiJsnZDZmLcxb8oZhhelmfnYDh0Xb6bOX32HHG4rgkPvjHfWc5wuVfIsHsr/xH6RBmtmfT9s1Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532541; c=relaxed/simple;
	bh=EEaOWIQCKiNs0G7awm38MrLvuxsW7kkHPyGIYQAExc8=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=WqCPE72F24l/3au/yo7v9fKqFxc0GgzAvwyLporcJdHhbpcAZnoadMqfX6K8vNtwqPZeuuJxF5Rwc3fyA3vTPhanOCXRI9ncvDxON8K+jsp8+3kPDs1zpxxRRAIiHdhFr5JlXHie4LgHUrloZBLWoDHve6/d9XC/t+QxNqV9aew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMZudiZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD880C433F1;
	Wed, 17 Jan 2024 23:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705532541;
	bh=EEaOWIQCKiNs0G7awm38MrLvuxsW7kkHPyGIYQAExc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMZudiZgyYEq96AWE863jZo71NKFWuy2kbxxgUA5x1m5z7jP8wjsIli5P5H3gqCKH
	 lTjrfdE56u3CayU8Admms40W1QAAFK/wVmGQm7t+BYnIF3cA6XM2Bno3No+On7DZsZ
	 kOQ/C40V+rDEhsBmbWRXuJK3wVVP/Ww3Nn0Mxw8ZVO+7UcRVbZ+NUzne4a7JQaZ9W+
	 gRoEk/MjqUJNpZoVSU/BVTQlHPInvKy5UwCn6d24Ykhdw9eqzq5ZEkGnjxx0PRSGx/
	 bhsQSI0lKIK92hIuyKp510ZbS/VLXuUiWEjX5xupsYbZAqEZ0GrrX+BLFrd+JCh8el
	 SQFJa5fjgb0AQ==
Date: Wed, 17 Jan 2024 23:02:09 +0000
From: Conor Dooley <conor@kernel.org>
To: Atish Patra <atishp@atishpatra.org>
Cc: Yu Chien Peter Lin <peterlin@andestech.com>, acme@kernel.org,
	adrian.hunter@intel.com, ajones@ventanamicro.com,
	alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
	anup@brainfault.org, aou@eecs.berkeley.edu, conor+dt@kernel.org,
	conor.dooley@microchip.com, devicetree@vger.kernel.org,
	dminus@andestech.com, evan@rivosinc.com, geert+renesas@glider.be,
	guoren@kernel.org, heiko@sntech.de, irogers@google.com,
	jernej.skrabec@gmail.com, jolsa@kernel.org, jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
	locus84@andestech.com, magnus.damm@gmail.com, mark.rutland@arm.com,
	mingo@redhat.com, n.shubin@yadro.com, namhyung@kernel.org,
	palmer@dabbelt.com, paul.walmsley@sifive.com, peterz@infradead.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org,
	robh+dt@kernel.org, samuel@sholland.org, sunilvl@ventanamicro.com,
	tglx@linutronix.de, tim609@andestech.com, uwu@icenowy.me,
	wens@csie.org, will@kernel.org, ycliang@andestech.com,
	inochiama@outlook.com, chao.wei@sophgo.com,
	unicorn_wang@outlook.com, wefu@redhat.com
Subject: Re: [PATCH v7 07/16] RISC-V: Move T-Head PMU to CPU feature
 alternative framework
Message-ID: <20240117-viewpoint-likeness-b64a622d313a@spud>
References: <20240110073917.2398826-1-peterlin@andestech.com>
 <20240110073917.2398826-8-peterlin@andestech.com>
 <CAOnJCUKY8H+pvgTWW5zkfm8O4WR-OWOKmyPTcMjUZBCC5RaLWQ@mail.gmail.com>
 <20240116-cherub-revival-5d32cc5f1fd0@spud>
 <CAOnJCU+DvoV08n5LLv-yrPOnUKNEQU9w344UBJ4Ou5-2LJwrrw@mail.gmail.com>
 <20240117-coil-iphone-47988070aa6f@spud>
 <CAOnJCUKYa7P9tgKk4c=Xsoia1bGu+ZL9KrY3hL6DNiXz+EmGug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="F8Iq+MRPdffgNb/f"
Content-Disposition: inline
In-Reply-To: <CAOnJCUKYa7P9tgKk4c=Xsoia1bGu+ZL9KrY3hL6DNiXz+EmGug@mail.gmail.com>


--F8Iq+MRPdffgNb/f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 02:32:59PM -0800, Atish Patra wrote:
> On Wed, Jan 17, 2024 at 1:17=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Wed, Jan 17, 2024 at 12:58:21AM -0800, Atish Patra wrote:
> > > On Tue, Jan 16, 2024 at 4:16=E2=80=AFPM Conor Dooley <conor@kernel.or=
g> wrote:
> > > >
> > > > On Tue, Jan 16, 2024 at 12:55:41PM -0800, Atish Patra wrote:
> > > > > On Tue, Jan 9, 2024 at 11:40=E2=80=AFPM Yu Chien Peter Lin
> > > > > <peterlin@andestech.com> wrote:
> > > > > >
> > > > > > The custom PMU extension aims to support perf event sampling pr=
ior
> > > > > > to the ratification of Sscofpmf. Instead of diverting the bits =
and
> > > > > > register reserved for future standard, a set of custom register=
s is
> > > > > > added.  Hence, we may consider it as a CPU feature rather than =
an
> > > > > > erratum.
> > > > > >
> > > > >
> > > > > I don't think we should do that. Any custom implementation that
> > > > > violates the standard RISC-V spec should
> > > > > be an errata not a feature.
> > > > > As per my understanding, a vendor can call an extension custom ISA
> > > > > extension if the same feature is not available
> > > > > in the standard ISA extensions or the mechanism is completely
> > > > > different. It must also not violate any standard spec as well.
> > > > >
> > > > > In this case, a standard sscofpmf is already available. Moreover,=
 both
> > > > > Andes and T-head extensions violate the standard
> > > > > spec by reusing local interrupt numbers (17(Thead) & 18(Andes)) w=
hich
> > > > > are clearly specified as reserved for standard local interrupts
> > > > > in the AIA specification.
> > > >
> > > > I disagree with you here. The Andes implementation predated (IIRC t=
hat
> > > > is what was said in replies to an earlier revision) the Sscofpmf
> > > > extension and certainly predates the AIA specification. I would be =
on
> > > > board with this line of thinking if someone comes along in 2030 with
> > > > "Zbb but with this one tweak" or where something flies entirely in =
the
> > > > face of the standard (like the IOCP cache stuff). The relevant sect=
ion
> > > > in the AIA spec seems to say:
> > > > | Interrupt causes that are standardized by the Privileged Architec=
ture
> > > > | have major identities in the range 0=E2=80=9315, while numbers 16=
 and higher are
> > > > | officially available for platform standards or for custom use.
> > > > | The Advanced Interrupt Architecture claims further authority over
> > > > | identity numbers in the ranges 16=E2=80=9323 and 32=E2=80=9347, l=
eaving numbers in the
> > > > | range 24=E2=80=9331 and all major identities 48 and higher still =
free for custom
> > > > | use.
> > > > I don't see how that can be problematic given the Andes implemtation
> > > > dates from before AIA was a thing. It would be silly to say that be=
cause
> > > > an optional extension later came along and took over something prev=
iously
> > > > allowed for indiscriminate custom use, that support for that custom
> > > > extension is not permitted.
> > > >
> > >
> > > AIA is not some optional extension. It defines the RISC-V interrupt
> > > architecture going forward and will be the default implementation
> > > in the future.
> >
> > I don't get you here. It is clearly optional - most (all?) existing
> > systems do not have it and certainly none did when this was designed.
>=20
> That's the current situation. I was saying AIA is not "some" optional ext=
ension
> which most implementations will ignore in the future. In the future, I
> expect most platforms will implement AIA.

In the future all platforms may, but I don't think that that is
particularly important here. The systems that we are talking about at
the moment do not have AIA. If there are AIA capable systems produced
using Andes' IP, one would hope that they implement Sscopmf (or w/e the
forgettable extension name is). :fingers_crossed:

> > The wording above from the AIA spec implies that using 16 and above used
> > to be okay for platform specifics (and I think the relevant section of
> > the priv spec was "Machine Interrupt Registers" which says the same).
>=20
> As your quote also described above, AIA spec says (which overrides the
> priv spec)
>=20
> "The Advanced Interrupt Architecture claims further authority over
> identity numbers in the ranges 16=E2=80=9323 and 32=E2=80=9347,
> leaving numbers in the range 24=E2=80=9331 and all major identities 48 and
> higher still free for custom use."
>=20
> That means any implementation can be treated as custom (as per AIA
> spec) if they choose a local interrupt
> only in between 24-31 or > 48. Now if we choose to ignore the AIA spec
> and go with the old priv spec statement to
> decide if a custom implementation violated the standard encoding
> space, that's a different argument. That means we have
> to allow any future vendor implementation that violates as well as
> long as they claim that they designed their chip before
> AIA was ratified.

I don't see what the problem with that is. It is completely unreasonable
to render custom extensions that used the resources available to them at
the time invalid for use in the kernel (unless branded as an erratum)
because later on standard extensions co-opted those resources for its
own usage.

> > New extensions coming along should not be allowed to block kernel
> > support for platform specifics that predated their use of permitted
> > "resources".
> >
> > > IMO, this will be a slippery slope if we start
> > > supporting custom implementations to override interrupt ID definitions
> > > via custom cpu features. T-head implementation works perfectly fine as
> > > an errata and I don't understand why
> > > there is a push to make it a cpu feature.
> >
> > I don't mind leaving the existing implementation (T-Head) using this,
> > but I will NAK any additions.
> >
>=20
> That would be an ideal case where we won't require any additions
> because all RISC-V vendor implementations
> comply with the spec. In reality, we may not have that luxury ;)

Where we have no other choice but to use marchid et al for detecting
issues with a vendors implementation, then I have no problem with it.
If you look at any of the threads where I have objected to the use of
them, it's been specifically for the detection of features, not for
their use in dealing with implementation issues (like the sifive sfence
issues).

> > > We should try to improve the
> > > ecosystem for future platforms rather than bending
> > > backwards to support older implementations.
> >
> > This is hardly "bending backwards".
> >
> > > I understand the push to brand this as a custom extension if current
> > > errata/alternative can't support it. But I don't think that's the case
> > > here though. Please correct me if I am wrong.
> > >
> > > > I may well be missing something here though, you clearly know these
> > > > specs better than I do, but from what I have read I disagree.
> > > >
> > > > > Please implementation Andes PMU support as an errata as well simi=
lar to T-head
> > > >
> > > > I certainly _do not_ want to see things like this detected via look=
up
> > > > tables of marchid and co in the kernel unless it is absolutely requ=
ired.
> > > > We have standard probing mechanisms for feature detection (because =
to me
> > > > this _is_ a feature) and they should be used. Additionally, we defi=
ne what
> > > > entries in the DT properties mean, and if it is convenient to put
> > > > "psuedo" extensions into the DT, then we should do so. Getting away=
 from
> > > > being tied to what RVI decrees was one of the goals of the new
> > > > properties after all, so that we could use a standard mechanism of =
DT
> > > > probing for things like this.
> > > >
> > >
> > > Yes. That's a perfectly valid mechanism for actual custom/vendor ISA =
extensions.
> > > I'm sure we'll have many of those, which will be leveraged via pseudo
> > > extensions in the DT.
> > > However, these shouldn't co-exist with standard ISA extensions in the
> > > namespace in riscv_isa_ext and/or hwprobe.
> > > The vendor-specific extensions should be defined under a
> > > vendor-specific namespace.
> > > This was another issue with this series as well. I didn't raise this
> > > topic earlier because I don't think overriding interrupt
> > > identities qualifies for a custom ISA extension
> > >
>=20
> Any thoughts on vendor specific namespace to avoid mixing standard ISA
> extensions with vendor specific ones ?

I don't really care for how it is exposed in hwprobe, you should ask
those responsible for the hwprobe interface what they think.

If you mean on the DT side, one of the stated goals of the new
properties was to put RVI's extensions and vendor extensions on a equal
footing.

Dunno if that answers your question,
Conor.

--F8Iq+MRPdffgNb/f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZahccQAKCRB4tDGHoIJi
0kv9AP9TxIdMgQSwChm7gr0th6+GD7/vtd+563x1cqsqrCmrFAEAxtcZBvLyiuvq
hPS74gvqKeANHfOVoqHlhm9QSmXPlAM=
=xsB5
-----END PGP SIGNATURE-----

--F8Iq+MRPdffgNb/f--

