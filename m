Return-Path: <linux-kernel+bounces-50051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA2F8473B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7DB1F27022
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4738A1474A4;
	Fri,  2 Feb 2024 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAhdO6qU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F9179A5;
	Fri,  2 Feb 2024 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889235; cv=none; b=sm7JQWjw4usPDb07hdhAgWzWpvGwFB6h4Xy5UetiqJKlS9UYABmn7w6xd7r1Bt5mgGh+Kde6lSBqPkcWwfBuJLsR79FV+NPfD3Ya9xDDf7+7TY4JEMPSFBXr6HI94cTkcoqcrf0OsEEscENIJIcYYFZJP8Co5GkxSPHx7c8F4+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889235; c=relaxed/simple;
	bh=6osE97Z/z7Gxj8LhqCXUtj2ISkcMALTMSddp/DORlGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsT1AVRgAKSc3kGFEiGd8We6xgA0hqv0Gibh5goM0AxnGMp4jg+dMWuipsljKEHybcq6L6WZISMBiE/ozrN3VqJrsILIHeWVn5ta/ONoAB6yMU8I3ecdltrOvBH46j+GC5xW2Wli68nOcabe08GkNKaLKcTcWuZ3m3L09sHdoyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAhdO6qU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DA1C433F1;
	Fri,  2 Feb 2024 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889234;
	bh=6osE97Z/z7Gxj8LhqCXUtj2ISkcMALTMSddp/DORlGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAhdO6qU7hLC6/QErPRe5GWcBngQlTYqestPgbXwlhvqi8JwjWnFCpRicyQLVyU7j
	 yvU2Z2Ty7TRTzopTOUyy1cffcelgQM26ZZ29UR9/fvmY8/sVUXp+NJcAgnW5pKY1dn
	 CUp+EHJ53lYZX7Ut3KMHftuoCTf6xIriz6Nl4NdF24POCP/0Tvg+zF3Cl5xs144JIg
	 mFh83P1kKmjEzayOt2SOA5Iqz/zR2uS0kobXw90p1UOT8PhsVEsDEw4fwau39Hsk/q
	 HdcKyEhWLWHPDZ5lCv0Kv0DVdnx2RhL7MRo6MQ5u2V/1YUr4LZW6uNmedeFxgKwzq6
	 ajtbuX0d1AZYA==
Date: Fri, 2 Feb 2024 09:53:52 -0600
From: Rob Herring <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: David Dai <davidai@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Quentin Perret <qperret@google.com>,
	Masami Hiramatsu <mhiramat@google.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pavan Kondeti <quic_pkondeti@quicinc.com>,
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>,
	kernel-team@android.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: cpufreq: add virtual cpufreq device
Message-ID: <20240202155352.GA37864-robh@kernel.org>
References: <20240127004321.1902477-1-davidai@google.com>
 <20240127004321.1902477-2-davidai@google.com>
 <20240131170608.GA1441369-robh@kernel.org>
 <CAGETcx8S0oS67oMZsPKk6_MGAtygoHEf_LN1gbcNDEBqRJ4PPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx8S0oS67oMZsPKk6_MGAtygoHEf_LN1gbcNDEBqRJ4PPg@mail.gmail.com>

On Wed, Jan 31, 2024 at 10:23:03AM -0800, Saravana Kannan wrote:
> On Wed, Jan 31, 2024 at 9:06 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Jan 26, 2024 at 04:43:15PM -0800, David Dai wrote:
> > > Adding bindings to represent a virtual cpufreq device.
> > >
> > > Virtual machines may expose MMIO regions for a virtual cpufreq device
> > > for guests to read frequency information or to request frequency
> > > selection. The virtual cpufreq device has an individual controller for
> > > each frequency domain. Performance points for a given domain can be
> > > normalized across all domains for ease of allowing for virtual machines
> > > to migrate between hosts.
> > >
> > > Co-developed-by: Saravana Kannan <saravanak@google.com>
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > Signed-off-by: David Dai <davidai@google.com>
> > > ---
> > >  .../cpufreq/qemu,cpufreq-virtual.yaml         | 110 ++++++++++++++++++
> >
> > > +    const: qemu,virtual-cpufreq
> >
> > Well, the filename almost matches the compatible.
> >
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +    description:
> > > +      Address and size of region containing frequency controls for each of the
> > > +      frequency domains. Regions for each frequency domain is placed
> > > +      contiguously and contain registers for controlling DVFS(Dynamic Frequency
> > > +      and Voltage) characteristics. The size of the region is proportional to
> > > +      total number of frequency domains. This device also needs the CPUs to
> > > +      list their OPPs using operating-points-v2 tables. The OPP tables for the
> > > +      CPUs should use normalized "frequency" values where the OPP with the
> > > +      highest performance among all the vCPUs is listed as 1024 KHz. The rest
> > > +      of the frequencies of all the vCPUs should be normalized based on their
> > > +      performance relative to that 1024 KHz OPP. This makes it much easier to
> > > +      migrate the VM across systems which might have different physical CPU
> > > +      OPPs.
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    // This example shows a two CPU configuration with a frequency domain
> > > +    // for each CPU showing normalized performance points.
> > > +    cpus {
> > > +      #address-cells = <1>;
> > > +      #size-cells = <0>;
> > > +
> > > +      cpu@0 {
> > > +        compatible = "arm,armv8";
> > > +        device_type = "cpu";
> > > +        reg = <0x0>;
> > > +        operating-points-v2 = <&opp_table0>;
> > > +      };
> > > +
> > > +      cpu@1 {
> > > +        compatible = "arm,armv8";
> > > +        device_type = "cpu";
> > > +        reg = <0x0>;
> > > +        operating-points-v2 = <&opp_table1>;
> > > +      };
> > > +    };
> > > +
> > > +    opp_table0: opp-table-0 {
> > > +      compatible = "operating-points-v2";
> > > +
> > > +      opp64000 { opp-hz = /bits/ 64 <64000>; };
> >
> > opp-64000 is the preferred form.
> >
> > > +      opp128000 { opp-hz = /bits/ 64 <128000>; };
> > > +      opp192000 { opp-hz = /bits/ 64 <192000>; };
> > > +      opp256000 { opp-hz = /bits/ 64 <256000>; };
> > > +      opp320000 { opp-hz = /bits/ 64 <320000>; };
> > > +      opp384000 { opp-hz = /bits/ 64 <384000>; };
> > > +      opp425000 { opp-hz = /bits/ 64 <425000>; };
> > > +    };
> > > +
> > > +    opp_table1: opp-table-1 {
> > > +      compatible = "operating-points-v2";
> > > +
> > > +      opp64000 { opp-hz = /bits/ 64 <64000>; };
> > > +      opp128000 { opp-hz = /bits/ 64 <128000>; };
> > > +      opp192000 { opp-hz = /bits/ 64 <192000>; };
> > > +      opp256000 { opp-hz = /bits/ 64 <256000>; };
> > > +      opp320000 { opp-hz = /bits/ 64 <320000>; };
> > > +      opp384000 { opp-hz = /bits/ 64 <384000>; };
> > > +      opp448000 { opp-hz = /bits/ 64 <448000>; };
> > > +      opp512000 { opp-hz = /bits/ 64 <512000>; };
> > > +      opp576000 { opp-hz = /bits/ 64 <576000>; };
> > > +      opp640000 { opp-hz = /bits/ 64 <640000>; };
> > > +      opp704000 { opp-hz = /bits/ 64 <704000>; };
> > > +      opp768000 { opp-hz = /bits/ 64 <768000>; };
> > > +      opp832000 { opp-hz = /bits/ 64 <832000>; };
> > > +      opp896000 { opp-hz = /bits/ 64 <896000>; };
> > > +      opp960000 { opp-hz = /bits/ 64 <960000>; };
> > > +      opp1024000 { opp-hz = /bits/ 64 <1024000>; };
> > > +
> > > +    };
> >
> > I don't recall your prior versions having an OPP table. Maybe it was
> > incomplete. You are designing the "h/w" interface. Why don't you make it
> > discoverable or implicit (fixed for the h/w)?
> 
> We also need the OPP tables to indicate which CPUs are part of the
> same cluster, etc. Don't want to invent a new "protocol" and just use
> existing DT bindings.

Topology binding is for that.

What about when x86 and other ACPI systems need to do this too? You 
define a discoverable interface, then it works regardless of firmware. 
KVM, Virtio, VFIO, etc. are all their own protocols.

> > Do you really need it if the frequency is normalized?
> 
> Yeah, we can have little and big CPUs and want to emulate different
> performance levels. So while the Fmax on big is 1024, we still want to
> be able to say little is 425. So we definitely need frequency tables.

You need per CPU Fmax, sure. But all the frequencies? I don't follow why 
you don't just have a max available capacity and then request the 
desired capacity. Then the host maps that to an underlying OPP. Why have 
an intermediate set of fake frequencies?

As these are normalized, I guess you are normalizing for capacity as 
well? Or you are using "capacity-dmips-mhz"? 

I'm also lost how this would work when you migrate and the underlying 
CPU changes. The DT is fixed.

> > Also, we have "opp-level" for opaque values that aren't Hz.
> 
> Still want to keep it Hz to be compatible with arch_freq_scale and
> when virtualized CPU perf counters are available.

Seems like no one would want "opp-level" then. Shrug.

Anyway, if Viresh and Marc are fine with all this, I'll shut up.

Rob

