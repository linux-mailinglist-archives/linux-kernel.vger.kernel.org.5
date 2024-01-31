Return-Path: <linux-kernel+bounces-46868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D451E84459F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0550A1C22C40
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0348712CD97;
	Wed, 31 Jan 2024 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNCksp1F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C6B13667A;
	Wed, 31 Jan 2024 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720771; cv=none; b=N2TcAPzIDLiV1cVnQyr84iP0BWkuUvLobclmf0zHSe2M00XdOveg+sd1U0ZtXAgKvfS9BakTZfGqLq9Y3iI3gec2i0liL++2oTdrz9ObBHa9K4oulSAFgtzU/8aXI6YGjVt3Zh0fHx/Dtane6VZax2NCu8BwEku+zdkllPBJeEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720771; c=relaxed/simple;
	bh=ZjcrxFg1hnrta7ciPG5Og/joULJ3zKe+MVtOVuq+pr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=filCBuK8VTWp2gVFqST7/FjUlG++g0Q1aW30KNrq8b+ZfBUvd4jq4D5yII3ad0B5QMAfi3o02toIPxpqkUbDMZhitsy8CYhkGeuyVG/GEjOGquWQgxtdcznawwn8U8j4LM0tyLcpcqIaeEsiZq+/jayhr26+JbZ8CH8uTy87ReA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNCksp1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BF2C43390;
	Wed, 31 Jan 2024 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706720770;
	bh=ZjcrxFg1hnrta7ciPG5Og/joULJ3zKe+MVtOVuq+pr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZNCksp1FIgikfdABTYW84TgA6P1C5iULu4a2VZR6q1vG58VseZCVQRDBSZdQCMX/f
	 7lswsqJ6MVMVjbfO8cUE7qboO46EryZAZmMUdeBfuIaYdSTM4xu1Yxbe5/BBbpAVkR
	 KN57QNbxEHDNonDBY7HvskRdFB10FSXwFg1A/F1e4oMNHD2xcSQqC5ug2D0qr4XZl1
	 uVj54Kypmt2lXNZMLRsW9Q1r2/7SU2fEqfX5jt+exTkbw75x5MrtGXEXFx2STsaZGo
	 WAq+8TAHSrUXbSXpHtt0ixzofwCx7aJma/Bl24kITOxcpqUf7N4hYBKmsP9UdDIfFc
	 +meoq6tuBNS3A==
Date: Wed, 31 Jan 2024 11:06:08 -0600
From: Rob Herring <robh@kernel.org>
To: David Dai <davidai@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Saravana Kannan <saravanak@google.com>,
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
Message-ID: <20240131170608.GA1441369-robh@kernel.org>
References: <20240127004321.1902477-1-davidai@google.com>
 <20240127004321.1902477-2-davidai@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127004321.1902477-2-davidai@google.com>

On Fri, Jan 26, 2024 at 04:43:15PM -0800, David Dai wrote:
> Adding bindings to represent a virtual cpufreq device.
> 
> Virtual machines may expose MMIO regions for a virtual cpufreq device
> for guests to read frequency information or to request frequency
> selection. The virtual cpufreq device has an individual controller for
> each frequency domain. Performance points for a given domain can be
> normalized across all domains for ease of allowing for virtual machines
> to migrate between hosts.
> 
> Co-developed-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: David Dai <davidai@google.com>
> ---
>  .../cpufreq/qemu,cpufreq-virtual.yaml         | 110 ++++++++++++++++++

> +    const: qemu,virtual-cpufreq

Well, the filename almost matches the compatible.

> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      Address and size of region containing frequency controls for each of the
> +      frequency domains. Regions for each frequency domain is placed
> +      contiguously and contain registers for controlling DVFS(Dynamic Frequency
> +      and Voltage) characteristics. The size of the region is proportional to
> +      total number of frequency domains. This device also needs the CPUs to
> +      list their OPPs using operating-points-v2 tables. The OPP tables for the
> +      CPUs should use normalized "frequency" values where the OPP with the
> +      highest performance among all the vCPUs is listed as 1024 KHz. The rest
> +      of the frequencies of all the vCPUs should be normalized based on their
> +      performance relative to that 1024 KHz OPP. This makes it much easier to
> +      migrate the VM across systems which might have different physical CPU
> +      OPPs.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    // This example shows a two CPU configuration with a frequency domain
> +    // for each CPU showing normalized performance points.
> +    cpus {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      cpu@0 {
> +        compatible = "arm,armv8";
> +        device_type = "cpu";
> +        reg = <0x0>;
> +        operating-points-v2 = <&opp_table0>;
> +      };
> +
> +      cpu@1 {
> +        compatible = "arm,armv8";
> +        device_type = "cpu";
> +        reg = <0x0>;
> +        operating-points-v2 = <&opp_table1>;
> +      };
> +    };
> +
> +    opp_table0: opp-table-0 {
> +      compatible = "operating-points-v2";
> +
> +      opp64000 { opp-hz = /bits/ 64 <64000>; };

opp-64000 is the preferred form.

> +      opp128000 { opp-hz = /bits/ 64 <128000>; };
> +      opp192000 { opp-hz = /bits/ 64 <192000>; };
> +      opp256000 { opp-hz = /bits/ 64 <256000>; };
> +      opp320000 { opp-hz = /bits/ 64 <320000>; };
> +      opp384000 { opp-hz = /bits/ 64 <384000>; };
> +      opp425000 { opp-hz = /bits/ 64 <425000>; };
> +    };
> +
> +    opp_table1: opp-table-1 {
> +      compatible = "operating-points-v2";
> +
> +      opp64000 { opp-hz = /bits/ 64 <64000>; };
> +      opp128000 { opp-hz = /bits/ 64 <128000>; };
> +      opp192000 { opp-hz = /bits/ 64 <192000>; };
> +      opp256000 { opp-hz = /bits/ 64 <256000>; };
> +      opp320000 { opp-hz = /bits/ 64 <320000>; };
> +      opp384000 { opp-hz = /bits/ 64 <384000>; };
> +      opp448000 { opp-hz = /bits/ 64 <448000>; };
> +      opp512000 { opp-hz = /bits/ 64 <512000>; };
> +      opp576000 { opp-hz = /bits/ 64 <576000>; };
> +      opp640000 { opp-hz = /bits/ 64 <640000>; };
> +      opp704000 { opp-hz = /bits/ 64 <704000>; };
> +      opp768000 { opp-hz = /bits/ 64 <768000>; };
> +      opp832000 { opp-hz = /bits/ 64 <832000>; };
> +      opp896000 { opp-hz = /bits/ 64 <896000>; };
> +      opp960000 { opp-hz = /bits/ 64 <960000>; };
> +      opp1024000 { opp-hz = /bits/ 64 <1024000>; };
> +
> +    };

I don't recall your prior versions having an OPP table. Maybe it was 
incomplete. You are designing the "h/w" interface. Why don't you make it 
discoverable or implicit (fixed for the h/w)? Do you really need it if 
the frequency is normalized?

Also, we have "opp-level" for opaque values that aren't Hz.

Rob

