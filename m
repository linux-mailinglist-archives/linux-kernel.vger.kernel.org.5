Return-Path: <linux-kernel+bounces-59941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D368E84FD9F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F271F249D5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CBA53A9;
	Fri,  9 Feb 2024 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HeuHg4Zj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B3F23B1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510833; cv=none; b=TaULNfRbTdWK/IWFJznDV6Ana5c5sOtuYvszGoTJ26pkm6YOhdRbTKxoWmp4rfvKC0nCAq6C9b6ThYdQIj8tZM0hcU3LPbH1N1DX5WN3iBJYW2abaw+XcQJdDuBNmah/4kersM6eD49SxV/N2RQRabPcMDa8vz3fblsrvIn8nJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510833; c=relaxed/simple;
	bh=OeOD/2EIZh5JgchlUrLRr2dYKPYP9xtvM4SwG1C2dJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNS4hr+e9sg2zYDrz2jODApCVKPbxQWOqN3QmsYn6Q3fGcRzQ4BxIe9gC9V5m1ZIQPIyDeHcE2/anxcmmVk2HU39Jt4d8pnXsdL5lDzf4NWoQO5/ilLwwZiJW1/p+O19Y+Wwd/xq4+zbQUCarPesu2OI0mMAsYi99SZHUvtkFco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HeuHg4Zj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707510832; x=1739046832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OeOD/2EIZh5JgchlUrLRr2dYKPYP9xtvM4SwG1C2dJM=;
  b=HeuHg4ZjlpNEbWIRW7De9GLY+B18eC115p6RXAYfnQmNQ2by6BqcYhQl
   kaDULGjoyrU+buoUK7Xfhf7OLMRmLhAPp3WTmkWYUWjUQwy1w/ZLjq27r
   zuj+wxBkO7tSJ2XQ2rrMWXDTlZtenhWmUgmdrQRzADAIMkxYek+tsTUVN
   7/kICmG7HOkR9VYQ5SaQ2F1FlrlOAJheXoW29Z6cwh/nVyaMtRRJGkcpI
   V5D71rsVrp2LUHkCpwo+G/JqhVaErX0+U2OSgN/G4vY0eXT9iHMT66206
   BQyDgKLQCM+3RtviCsp39FB0w77GEZNV9qWVMHXwH2YZ7zwTippjs03TC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="12226740"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="12226740"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 12:33:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="39469009"
Received: from karenaba-mobl1.amr.corp.intel.com (HELO desk) ([10.209.64.107])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 12:33:48 -0800
Date: Fri, 9 Feb 2024 12:33:46 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	antonio.gomez.iglesias@linux.intel.com,
	alyssa.milburn@linux.intel.com, andrew.cooper3@citrix.com,
	linux-kernel@vger.kernel.org,
	Alyssa Milburn <alyssa.milburn@intel.com>
Subject: Re: [PATCH] x86/bugs: Default retbleed to =stuff when retpoline is
 auto enabled
Message-ID: <20240209203346.gwbfyx3huiaozg4s@desk>
References: <20240208-retbleed-auto-stuff-v1-1-6f12e513868f@linux.intel.com>
 <20240209185625.hca6lts6dv4cd3fu@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209185625.hca6lts6dv4cd3fu@treble>

Hi Josh / Borislav,

On Fri, Feb 09, 2024 at 10:56:25AM -0800, Josh Poimboeuf wrote:
> On Thu, Feb 08, 2024 at 05:12:15PM -0800, Pawan Gupta wrote:
> > @@ -1025,10 +1041,17 @@ static void __init retbleed_select_mitigation(void)
> >  				retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
> >  			else if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY) && boot_cpu_has(X86_FEATURE_IBPB))
> >  				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
> > +		} else if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
> > +			   spectre_v2_parse_cmdline() == SPECTRE_V2_CMD_AUTO &&
> 
> spectre_v2_parse_cmdline() has side effects (printks) and shouldn't be
> called twice.
> 
> And what's the point of checking spectre_v2= anyway?  Shouldn't retbleed
> be mitigated by default, independently of whatever the user may have
> specified for Spectre v2?

@Borislav, what do you think about this approach?

> > +			   spectre_v2_enabled == SPECTRE_V2_RETPOLINE) {
> > +			if (IS_ENABLED(CONFIG_CALL_DEPTH_TRACKING))
> > +				retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
> > +			else
> > +				pr_err("WARNING: Retpoline enabled, but kernel not compiled with CALL_DEPTH_TRACKING.\n");
> 
> If retbleed is vulnerable then the sysfs file should show that.

It does shows vulnerable, retbleed_mitigation is not set to
RETBLEED_MITIGATION_STUFF for CONFIG_CALL_DEPTH_TRACKING=n.

> Also, I think this pr_err() is redundant with RETBLEED_INTEL_MSG and can
> be removed.

IMO, they both serve a different purpose, RETBLEED_INTEL_MSG is a
generic warning, and the message with !CONFIG_CALL_DEPTH_TRACKING hints
a corrective action.

If you look at "case RETBLEED_CMD_STUFF" it also prints a separate warning for
!CONFIG_CALL_DEPTH_TRACKING:

          case RETBLEED_CMD_STUFF:
                  if (IS_ENABLED(CONFIG_CALL_DEPTH_TRACKING) &&
                      spectre_v2_enabled == SPECTRE_V2_RETPOLINE) {
                          retbleed_mitigation = RETBLEED_MITIGATION_STUFF;

                  } else {
                          if (IS_ENABLED(CONFIG_CALL_DEPTH_TRACKING))
                                  pr_err("WARNING: retbleed=stuff depends on spectre_v2=retpoline\n");
                          else
                                  pr_err("WARNING: kernel not compiled with CALL_DEPTH_TRACKING.\n");

