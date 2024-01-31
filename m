Return-Path: <linux-kernel+bounces-46966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3806684470D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3E21C21739
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EC812FF7C;
	Wed, 31 Jan 2024 18:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WRCR0Nvr"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0F412DD88
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725428; cv=none; b=eXF4QBurO198wvEGOZ/PZtXXRN0TF/+x5SKBPxDCGbhS35oPP9l+Xdv65aQGbalKG1N9T97XbhHzebDXB3J67JHriE7YKCvICTNqeZMEh4xRJ+VHQcQ9ywCuJwxLqZe9WqI0XkKWJzbWfxiQRbkc3RMNidPxiaSfxe8KPa+NaeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725428; c=relaxed/simple;
	bh=4HCr47Vl9ejjJTGVqxYRuHlMCbACMsJs01W7MS7B4yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4VG2X9dfSGvVX5GrXJkGKt7K2E1FJviPrKVVJt6BvUyIfT0NFwYzwkR2P9CHcd6w4GM/hgfWBrnwPYlrglooOE9NzeqkAWirOXzUzN1s4LifFotArVwrHrZOEdH/9p/5dNNjmYbWaDr/A0+JeibkdLyG0yDumRya34jSuGjCS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WRCR0Nvr; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55f5d62d024so430a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706725424; x=1707330224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viHzef10mQ/Ow5P/nhdwkaiORLJDs/5vxR6NgT9S6MQ=;
        b=WRCR0Nvr4E4SFem8QNCrcx00+V9bOor0i69r/PruSbY0rt2Nt80CVas+q5pc77uUPX
         ttGuKn6VbgR4iLUpDR5DbZJmHHR+9myJ+WMvIbDZnFk7GRJzbLV5dXrzzjX9pHBMaabr
         gykprDCMHpxFsHpv9md5ca2IVvaDwrmwmj63zKN1HkhF2TD4L+GA9h91uTenlraQUku7
         57MLY1IgvfEJLoucdqlxA/M1fNqYPuZLc2CPg02yOFVlIS00sbO+J9f+3GbFBMf382td
         3g0io/0WkhwESio+oqPjBJkWDhSDhXXmv25DFzM+pnK6sJefXxbQ/lR8LPlm4ZssCo3A
         9tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706725424; x=1707330224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=viHzef10mQ/Ow5P/nhdwkaiORLJDs/5vxR6NgT9S6MQ=;
        b=LMOe808SdyfBvtWyf1MPy09cUEwpyVURUBXXYi0ICH2iPOnc5meeCVhc9Rv2UVH9Ly
         YeAAsyNskl2h9wKOZ53nBJR8ezsL5sVO08vBefvIfiKlu94vM0aKbhpubsyeS7ooW8pU
         WaQgc14YJ0mRqWkp5Pve4hkw2TLL3dtN0Nvl7iPqa0QiJpZ+S92GTnsdHYtbM/aARSMf
         /21Te7tC8EkmSlh57z7D4w4HhyA75GdNCkTLEM/Y01kkVqGxwSmtZ7+RGRkNC6yR5Ego
         kN12VZPcAskGupbHTLWOQAor0Hx31zZZSApP4coZ8+IPZ5viobfMI7KoKCg8EiLFFiNS
         jRdQ==
X-Gm-Message-State: AOJu0YwMYN2JSPO6tpN+jDsEnxkQWGrI1nPrarDskDd5sa9Y/8PNurQi
	3G/ydzKyj0dTp8/EgW21odUPRrZWhRMph6TGpgzvbkMYLZkSWjfqXsfVKSFQe3fVDtiokyMeMsP
	kwSyC3lZqBQ5vPidTowVKWQB8AufNgNZ9IIJE
X-Google-Smtp-Source: AGHT+IEZOW3QqAu7mnXOmcMRt5GjQ873Ib0bNlhUhCJVB0evLECVTZoQsY7Qlsm6r+daSN6IqJif/WFzAH/AHADonQ8=
X-Received: by 2002:a50:9998:0:b0:55f:9918:dadd with SMTP id
 m24-20020a509998000000b0055f9918daddmr19957edb.2.1706725423409; Wed, 31 Jan
 2024 10:23:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127004321.1902477-1-davidai@google.com> <20240127004321.1902477-2-davidai@google.com>
 <20240131170608.GA1441369-robh@kernel.org>
In-Reply-To: <20240131170608.GA1441369-robh@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 31 Jan 2024 10:23:03 -0800
Message-ID: <CAGETcx8S0oS67oMZsPKk6_MGAtygoHEf_LN1gbcNDEBqRJ4PPg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: cpufreq: add virtual cpufreq device
To: Rob Herring <robh@kernel.org>
Cc: David Dai <davidai@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Quentin Perret <qperret@google.com>, 
	Masami Hiramatsu <mhiramat@google.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Pavan Kondeti <quic_pkondeti@quicinc.com>, 
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:06=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, Jan 26, 2024 at 04:43:15PM -0800, David Dai wrote:
> > Adding bindings to represent a virtual cpufreq device.
> >
> > Virtual machines may expose MMIO regions for a virtual cpufreq device
> > for guests to read frequency information or to request frequency
> > selection. The virtual cpufreq device has an individual controller for
> > each frequency domain. Performance points for a given domain can be
> > normalized across all domains for ease of allowing for virtual machines
> > to migrate between hosts.
> >
> > Co-developed-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: David Dai <davidai@google.com>
> > ---
> >  .../cpufreq/qemu,cpufreq-virtual.yaml         | 110 ++++++++++++++++++
>
> > +    const: qemu,virtual-cpufreq
>
> Well, the filename almost matches the compatible.
>
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description:
> > +      Address and size of region containing frequency controls for eac=
h of the
> > +      frequency domains. Regions for each frequency domain is placed
> > +      contiguously and contain registers for controlling DVFS(Dynamic =
Frequency
> > +      and Voltage) characteristics. The size of the region is proporti=
onal to
> > +      total number of frequency domains. This device also needs the CP=
Us to
> > +      list their OPPs using operating-points-v2 tables. The OPP tables=
 for the
> > +      CPUs should use normalized "frequency" values where the OPP with=
 the
> > +      highest performance among all the vCPUs is listed as 1024 KHz. T=
he rest
> > +      of the frequencies of all the vCPUs should be normalized based o=
n their
> > +      performance relative to that 1024 KHz OPP. This makes it much ea=
sier to
> > +      migrate the VM across systems which might have different physica=
l CPU
> > +      OPPs.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    // This example shows a two CPU configuration with a frequency dom=
ain
> > +    // for each CPU showing normalized performance points.
> > +    cpus {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      cpu@0 {
> > +        compatible =3D "arm,armv8";
> > +        device_type =3D "cpu";
> > +        reg =3D <0x0>;
> > +        operating-points-v2 =3D <&opp_table0>;
> > +      };
> > +
> > +      cpu@1 {
> > +        compatible =3D "arm,armv8";
> > +        device_type =3D "cpu";
> > +        reg =3D <0x0>;
> > +        operating-points-v2 =3D <&opp_table1>;
> > +      };
> > +    };
> > +
> > +    opp_table0: opp-table-0 {
> > +      compatible =3D "operating-points-v2";
> > +
> > +      opp64000 { opp-hz =3D /bits/ 64 <64000>; };
>
> opp-64000 is the preferred form.
>
> > +      opp128000 { opp-hz =3D /bits/ 64 <128000>; };
> > +      opp192000 { opp-hz =3D /bits/ 64 <192000>; };
> > +      opp256000 { opp-hz =3D /bits/ 64 <256000>; };
> > +      opp320000 { opp-hz =3D /bits/ 64 <320000>; };
> > +      opp384000 { opp-hz =3D /bits/ 64 <384000>; };
> > +      opp425000 { opp-hz =3D /bits/ 64 <425000>; };
> > +    };
> > +
> > +    opp_table1: opp-table-1 {
> > +      compatible =3D "operating-points-v2";
> > +
> > +      opp64000 { opp-hz =3D /bits/ 64 <64000>; };
> > +      opp128000 { opp-hz =3D /bits/ 64 <128000>; };
> > +      opp192000 { opp-hz =3D /bits/ 64 <192000>; };
> > +      opp256000 { opp-hz =3D /bits/ 64 <256000>; };
> > +      opp320000 { opp-hz =3D /bits/ 64 <320000>; };
> > +      opp384000 { opp-hz =3D /bits/ 64 <384000>; };
> > +      opp448000 { opp-hz =3D /bits/ 64 <448000>; };
> > +      opp512000 { opp-hz =3D /bits/ 64 <512000>; };
> > +      opp576000 { opp-hz =3D /bits/ 64 <576000>; };
> > +      opp640000 { opp-hz =3D /bits/ 64 <640000>; };
> > +      opp704000 { opp-hz =3D /bits/ 64 <704000>; };
> > +      opp768000 { opp-hz =3D /bits/ 64 <768000>; };
> > +      opp832000 { opp-hz =3D /bits/ 64 <832000>; };
> > +      opp896000 { opp-hz =3D /bits/ 64 <896000>; };
> > +      opp960000 { opp-hz =3D /bits/ 64 <960000>; };
> > +      opp1024000 { opp-hz =3D /bits/ 64 <1024000>; };
> > +
> > +    };
>
> I don't recall your prior versions having an OPP table. Maybe it was
> incomplete. You are designing the "h/w" interface. Why don't you make it
> discoverable or implicit (fixed for the h/w)?

We also need the OPP tables to indicate which CPUs are part of the
same cluster, etc. Don't want to invent a new "protocol" and just use
existing DT bindings.

> Do you really need it if the frequency is normalized?

Yeah, we can have little and big CPUs and want to emulate different
performance levels. So while the Fmax on big is 1024, we still want to
be able to say little is 425. So we definitely need frequency tables.

> Also, we have "opp-level" for opaque values that aren't Hz.

Still want to keep it Hz to be compatible with arch_freq_scale and
when virtualized CPU perf counters are available.

-Saravana

