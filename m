Return-Path: <linux-kernel+bounces-51579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE76848CC4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4FAFB20C9E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5681F1B81E;
	Sun,  4 Feb 2024 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hg47hjLn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C02A1B805;
	Sun,  4 Feb 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707042184; cv=none; b=YYVUHbPYzYtnzwly+8ys1GeQLVjBuObpzbwAIW0vXzuL6l2J9UBPH7zNv36QAfc9K6doNrnjv8jmYc4qJzzgoNsrS0RcII6Zh1jS4t0+8+jJqaqr3IT7rTtcvAAhapsx4FzJQFHxOZXv5cUhufSHiph5LXrzd524O520IPx3wAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707042184; c=relaxed/simple;
	bh=0zCWK6HdQBfmh3+SGF+GwJXgFP8dMvoTrINLfE+0WAs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plMlJLJepWMVyff4cGoqgzevoWyNTBXcefFMYSNsiYjuavVb/Zxr+1FRLlIxLZFYEmhZLon8p63DY/cmciR9YG05fQIjNzrYpnpieYif2+tQ+QnSCejHxsL1yuUtK3Lxa+8LAFj5MuCdW4z+X725lDgzKME9d34sJamTAKw5r88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hg47hjLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C1BC43399;
	Sun,  4 Feb 2024 10:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707042183;
	bh=0zCWK6HdQBfmh3+SGF+GwJXgFP8dMvoTrINLfE+0WAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hg47hjLnfaorhta56RniaOneYtEmHv7UKURF5pSmBzgj0lfdkBPbqOaxQvf9isVaN
	 g2xWLsTMe0GSWatfM0BJmKINm5415AMkgVC/QqANVLnKI/Uik1+bmGvPI6xWEoKgYN
	 QYihBwPdYJEFuWdzwRNQfCwfWZhqarqOulAO5tLZFLFjS13fWRDct2Qx95RVJAqqpB
	 nvuqrzttae6Z/O/IWi/uiV1fdeLq9BGGce6a+0L4ChwbWTt68OEsnRCdKb0NUzhHPR
	 RyQ1h9Pk+WUCqJe5uphaCuGpOqIXthnsWCpBcqewzpJuDQwRDHwHmcOCC+f27Dwoa1
	 iYZlD71jsESFw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rWZeO-0009UD-UD;
	Sun, 04 Feb 2024 10:23:01 +0000
Date: Sun, 04 Feb 2024 10:23:00 +0000
Message-ID: <86a5og7cl7.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>,
	David Dai <davidai@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Quentin Perret <qperret@google.com>,
	Masami Hiramatsu <mhiramat@google.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pavan Kondeti <quic_pkondeti@quicinc.com>,
	Gupta Pankaj <pankaj.gupta@amd.com>,
	Mel Gorman <mgorman@suse.de>,
	kernel-team@android.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: cpufreq: add virtual cpufreq device
In-Reply-To: <20240202155352.GA37864-robh@kernel.org>
References: <20240127004321.1902477-1-davidai@google.com>
	<20240127004321.1902477-2-davidai@google.com>
	<20240131170608.GA1441369-robh@kernel.org>
	<CAGETcx8S0oS67oMZsPKk6_MGAtygoHEf_LN1gbcNDEBqRJ4PPg@mail.gmail.com>
	<20240202155352.GA37864-robh@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: robh@kernel.org, saravanak@google.com, davidai@google.com, rafael@kernel.org, viresh.kumar@linaro.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, sudeep.holla@arm.com, qperret@google.com, mhiramat@google.com, will@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, oliver.upton@linux.dev, dietmar.eggemann@arm.com, quic_pkondeti@quicinc.com, pankaj.gupta@amd.com, mgorman@suse.de, kernel-team@android.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Fri, 02 Feb 2024 15:53:52 +0000,
Rob Herring <robh@kernel.org> wrote:
>=20
> On Wed, Jan 31, 2024 at 10:23:03AM -0800, Saravana Kannan wrote:
> > On Wed, Jan 31, 2024 at 9:06=E2=80=AFAM Rob Herring <robh@kernel.org> w=
rote:
> > >
> > > On Fri, Jan 26, 2024 at 04:43:15PM -0800, David Dai wrote:
> > > > Adding bindings to represent a virtual cpufreq device.
> > > >
> > > > Virtual machines may expose MMIO regions for a virtual cpufreq devi=
ce
> > > > for guests to read frequency information or to request frequency
> > > > selection. The virtual cpufreq device has an individual controller =
for
> > > > each frequency domain. Performance points for a given domain can be
> > > > normalized across all domains for ease of allowing for virtual mach=
ines
> > > > to migrate between hosts.
> > > >
> > > > Co-developed-by: Saravana Kannan <saravanak@google.com>
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > Signed-off-by: David Dai <davidai@google.com>
> > > > ---
> > > >  .../cpufreq/qemu,cpufreq-virtual.yaml         | 110 ++++++++++++++=
++++
> > >
> > > > +    const: qemu,virtual-cpufreq
> > >
> > > Well, the filename almost matches the compatible.
> > >
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +    description:
> > > > +      Address and size of region containing frequency controls for=
 each of the
> > > > +      frequency domains. Regions for each frequency domain is plac=
ed
> > > > +      contiguously and contain registers for controlling DVFS(Dyna=
mic Frequency
> > > > +      and Voltage) characteristics. The size of the region is prop=
ortional to
> > > > +      total number of frequency domains. This device also needs th=
e CPUs to
> > > > +      list their OPPs using operating-points-v2 tables. The OPP ta=
bles for the
> > > > +      CPUs should use normalized "frequency" values where the OPP =
with the
> > > > +      highest performance among all the vCPUs is listed as 1024 KH=
z. The rest
> > > > +      of the frequencies of all the vCPUs should be normalized bas=
ed on their
> > > > +      performance relative to that 1024 KHz OPP. This makes it muc=
h easier to
> > > > +      migrate the VM across systems which might have different phy=
sical CPU
> > > > +      OPPs.
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    // This example shows a two CPU configuration with a frequency=
 domain
> > > > +    // for each CPU showing normalized performance points.
> > > > +    cpus {
> > > > +      #address-cells =3D <1>;
> > > > +      #size-cells =3D <0>;
> > > > +
> > > > +      cpu@0 {
> > > > +        compatible =3D "arm,armv8";
> > > > +        device_type =3D "cpu";
> > > > +        reg =3D <0x0>;
> > > > +        operating-points-v2 =3D <&opp_table0>;
> > > > +      };
> > > > +
> > > > +      cpu@1 {
> > > > +        compatible =3D "arm,armv8";
> > > > +        device_type =3D "cpu";
> > > > +        reg =3D <0x0>;
> > > > +        operating-points-v2 =3D <&opp_table1>;
> > > > +      };
> > > > +    };
> > > > +
> > > > +    opp_table0: opp-table-0 {
> > > > +      compatible =3D "operating-points-v2";
> > > > +
> > > > +      opp64000 { opp-hz =3D /bits/ 64 <64000>; };
> > >
> > > opp-64000 is the preferred form.
> > >
> > > > +      opp128000 { opp-hz =3D /bits/ 64 <128000>; };
> > > > +      opp192000 { opp-hz =3D /bits/ 64 <192000>; };
> > > > +      opp256000 { opp-hz =3D /bits/ 64 <256000>; };
> > > > +      opp320000 { opp-hz =3D /bits/ 64 <320000>; };
> > > > +      opp384000 { opp-hz =3D /bits/ 64 <384000>; };
> > > > +      opp425000 { opp-hz =3D /bits/ 64 <425000>; };
> > > > +    };
> > > > +
> > > > +    opp_table1: opp-table-1 {
> > > > +      compatible =3D "operating-points-v2";
> > > > +
> > > > +      opp64000 { opp-hz =3D /bits/ 64 <64000>; };
> > > > +      opp128000 { opp-hz =3D /bits/ 64 <128000>; };
> > > > +      opp192000 { opp-hz =3D /bits/ 64 <192000>; };
> > > > +      opp256000 { opp-hz =3D /bits/ 64 <256000>; };
> > > > +      opp320000 { opp-hz =3D /bits/ 64 <320000>; };
> > > > +      opp384000 { opp-hz =3D /bits/ 64 <384000>; };
> > > > +      opp448000 { opp-hz =3D /bits/ 64 <448000>; };
> > > > +      opp512000 { opp-hz =3D /bits/ 64 <512000>; };
> > > > +      opp576000 { opp-hz =3D /bits/ 64 <576000>; };
> > > > +      opp640000 { opp-hz =3D /bits/ 64 <640000>; };
> > > > +      opp704000 { opp-hz =3D /bits/ 64 <704000>; };
> > > > +      opp768000 { opp-hz =3D /bits/ 64 <768000>; };
> > > > +      opp832000 { opp-hz =3D /bits/ 64 <832000>; };
> > > > +      opp896000 { opp-hz =3D /bits/ 64 <896000>; };
> > > > +      opp960000 { opp-hz =3D /bits/ 64 <960000>; };
> > > > +      opp1024000 { opp-hz =3D /bits/ 64 <1024000>; };
> > > > +
> > > > +    };
> > >
> > > I don't recall your prior versions having an OPP table. Maybe it was
> > > incomplete. You are designing the "h/w" interface. Why don't you make=
 it
> > > discoverable or implicit (fixed for the h/w)?
> >=20
> > We also need the OPP tables to indicate which CPUs are part of the
> > same cluster, etc. Don't want to invent a new "protocol" and just use
> > existing DT bindings.
>=20
> Topology binding is for that.
>=20
> What about when x86 and other ACPI systems need to do this too? You=20
> define a discoverable interface, then it works regardless of firmware.=20
> KVM, Virtio, VFIO, etc. are all their own protocols.

Describing the emulated HW in ACPI would seem appropriate to me. We
are talking about the guest here, so whether this is KVM or not is not
relevant. If this was actually using any soft of data transfer, using
virtio would have been acceptable. But given how simple this is,
piggybacking on virtio is hardly appropriate.

>=20
> > > Do you really need it if the frequency is normalized?
> >=20
> > Yeah, we can have little and big CPUs and want to emulate different
> > performance levels. So while the Fmax on big is 1024, we still want to
> > be able to say little is 425. So we definitely need frequency tables.
>=20
> You need per CPU Fmax, sure. But all the frequencies? I don't follow why =

> you don't just have a max available capacity and then request the=20
> desired capacity. Then the host maps that to an underlying OPP. Why have =

> an intermediate set of fake frequencies?
>=20
> As these are normalized, I guess you are normalizing for capacity as=20
> well? Or you are using "capacity-dmips-mhz"?=20
>=20
> I'm also lost how this would work when you migrate and the underlying=20
> CPU changes. The DT is fixed.
>=20
> > > Also, we have "opp-level" for opaque values that aren't Hz.
> >=20
> > Still want to keep it Hz to be compatible with arch_freq_scale and
> > when virtualized CPU perf counters are available.
>=20
> Seems like no one would want "opp-level" then. Shrug.
>=20
> Anyway, if Viresh and Marc are fine with all this, I'll shut up.

Well, I've said it before, and I'll say it again: the use of
*frequencies* makes no sense. It is a lie (it doesn't describe any
hardware, physical nor virtual), and doesn't reflect the way the
emulated cpufreq controller behaves either (since it scales everything
back to what the host can potentially do)

The closest abstraction we have to this is the unit-less capacity. And
*that* reflects the way the emulated cpufreq controller works while
avoiding lying to the guest about some arbitrary frequency.

In practice, this changes nothing to either the code or the behaviour.
But it changes the binding.

	M.

--=20
Without deviation from the norm, progress is not possible.

