Return-Path: <linux-kernel+bounces-53027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82120849FA1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DD11C220AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96263C097;
	Mon,  5 Feb 2024 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EapCvRE0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF2940BE9;
	Mon,  5 Feb 2024 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151185; cv=none; b=fUFCeAWCmF79CLj2DqN8fOE8aVilpjTZpzQyKm69zJV5EBQlyrwlvwhbwxvwXyQY3K6GVXh2v9yiVep6tWgimndoT9Y1BOV5r8HXpik9n2T8KKnf0jfjXCnTJq9CwFBSWiB3G+kTLUWuIZyDP8Wz+ya90oSXfEdEk4ekjBAPNNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151185; c=relaxed/simple;
	bh=vbJaA4bFEq0xaB8nSdUrPFpAPgo9fDn4OpEJB7Tqa4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDHnpMlKApfXX7Yl6Y/UA5tax08D8Ols5zpYhfwIvLnUxS/BMOI2LB7yxmliMw3lGKEf/ArLO5og4AqeLg4jWK+nPX2gSO1unKHkiKW7Z8YNAQ2+Y6KQsyASvqAAXKXdTGb5q3zCrXY2DD22NvLqvPUvoCVQbzZwnnmrfKXdloI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EapCvRE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB99C433F1;
	Mon,  5 Feb 2024 16:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707151184;
	bh=vbJaA4bFEq0xaB8nSdUrPFpAPgo9fDn4OpEJB7Tqa4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EapCvRE0C693RyV4rZwsfX3jguWW+avvhqEyO4J1qIFPZdoYhrZd0riKVTrhZ5/wb
	 GtahUhLKtsq5QdBYP/1O0j8m/Ilf77Jn3M4efXo/Bmazke2Z+4eRwklBo3b72jxwsN
	 B8cvEAwSsqKla14Y751cuedoUy1dle+8e5gHURJn7VUu6Yya7cyRudQKTOyfzwv2pr
	 5gOQbUs9wgcNyNqfOQ+qj6uWRITf87TDDv87I1P5QOFu6ApzPd8EasOV2z4Wv5D8qd
	 fTqRCfY1A4SYkZ7fPLuv8nOpR6GtiGaUXWyCHfe4z2JZDMdA7JZuOGSTXaRC6WvZwW
	 TOd1b9X1jqOCA==
Date: Mon, 5 Feb 2024 16:39:41 +0000
From: Rob Herring <robh@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, David Dai <davidai@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <20240205163941.GA3474226-robh@kernel.org>
References: <20240127004321.1902477-1-davidai@google.com>
 <20240127004321.1902477-2-davidai@google.com>
 <20240131170608.GA1441369-robh@kernel.org>
 <CAGETcx8S0oS67oMZsPKk6_MGAtygoHEf_LN1gbcNDEBqRJ4PPg@mail.gmail.com>
 <20240202155352.GA37864-robh@kernel.org>
 <20240205083830.4werub5e76kudjq4@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205083830.4werub5e76kudjq4@vireshk-i7>

On Mon, Feb 05, 2024 at 02:08:30PM +0530, Viresh Kumar wrote:
> On 02-02-24, 09:53, Rob Herring wrote:
> > On Wed, Jan 31, 2024 at 10:23:03AM -0800, Saravana Kannan wrote:
> > > We also need the OPP tables to indicate which CPUs are part of the
> > > same cluster, etc. Don't want to invent a new "protocol" and just use
> > > existing DT bindings.
> > 
> > Topology binding is for that.
> 
> This one, right ?
> 
> Documentation/devicetree/bindings/dvfs/performance-domain.yaml

No, Documentation/devicetree/bindings/cpu/cpu-topology.txt (or the 
schema version of it in dtschema)

Rob


