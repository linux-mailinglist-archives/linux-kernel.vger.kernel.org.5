Return-Path: <linux-kernel+bounces-60194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A27A85013F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9ADA1F25BF9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5C81FC4;
	Sat, 10 Feb 2024 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpLCews0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191863C
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707525625; cv=none; b=eET0oXrNoRuEB4LEJsPU4apvNfBa+sHAwmaWuaVKTZpgez6ahE4TYbopNmiIIxQFEVTAUYYLHvswZRNQFFRYLczaWO3WvQfnfH3Bl0J5acssSh2QdcfUJP691zDm1gG0N+mlQ3RoxxztTAI4KWbRp26LGmepp0g3qrJp/whl93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707525625; c=relaxed/simple;
	bh=5syzx8RLtEKq1WR+V5bCcAXMnurxWrIxY/oBoEBhY+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRy23d10Ji4p6NM0as7wxj+cjEWm9NqiP3V/hBCQwlJs7oR14MaDQwW+PAf2GNyi92/ZgpbFHpj0Ipghv29xg3/h6M4c1zlrGi/Ibu3yLqfuC89zQgheclV7kBsf+6R0VhpvEInp4UDvddMlzQz0+ILkrMv+UIUHtHwSSYkRA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpLCews0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E051CC433C7;
	Sat, 10 Feb 2024 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707525624;
	bh=5syzx8RLtEKq1WR+V5bCcAXMnurxWrIxY/oBoEBhY+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpLCews0odo2VUA8tkQn1eGbhU5a8X2uS/p2DifGXBFhwwgvmX/05jHlQmD1fSCKw
	 k/6navcbUfZwkK7oHFhOOnyE9By/f3lXQypVvlfYQLzV1rGoKCtDjlShmUSqEi90kT
	 7aYFbjtm+RgdTP3MZAM1AZ5Bh3C5A2hwD56Gh8+SGb2xkzpOBOOi+9ERKEuWI/930G
	 N0a5MgsT2TCQjGgOxVNqRlcwlETdhoTUNIvRt7Hr0hCbAYi2sQtrILf1PVXu0bNvxl
	 rCH4CHPLjyD95biQoCbFHrrUqYLHuj7H5TJ9mR3Z7f7PkeA5X60Tpv+zHl85fKF2Qm
	 Z07BNkTqlDTug==
Date: Fri, 9 Feb 2024 16:40:22 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
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
Message-ID: <20240210004022.aff2dnr6dzwq5gkq@treble>
References: <20240208-retbleed-auto-stuff-v1-1-6f12e513868f@linux.intel.com>
 <20240209185625.hca6lts6dv4cd3fu@treble>
 <20240209203346.gwbfyx3huiaozg4s@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240209203346.gwbfyx3huiaozg4s@desk>

On Fri, Feb 09, 2024 at 12:33:46PM -0800, Pawan Gupta wrote:
> On Fri, Feb 09, 2024 at 10:56:25AM -0800, Josh Poimboeuf wrote:
> > On Thu, Feb 08, 2024 at 05:12:15PM -0800, Pawan Gupta wrote:
> > > +			   spectre_v2_enabled == SPECTRE_V2_RETPOLINE) {
> > > +			if (IS_ENABLED(CONFIG_CALL_DEPTH_TRACKING))
> > > +				retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
> > > +			else
> > > +				pr_err("WARNING: Retpoline enabled, but kernel not compiled with CALL_DEPTH_TRACKING.\n");
> > 
> > If retbleed is vulnerable then the sysfs file should show that.
> 
> It does shows vulnerable, retbleed_mitigation is not set to
> RETBLEED_MITIGATION_STUFF for CONFIG_CALL_DEPTH_TRACKING=n.

Ah right, in that case retbleed_mitigation still has its initialized
value of RETBLEED_MITIGATION_NONE.

> > Also, I think this pr_err() is redundant with RETBLEED_INTEL_MSG and can
> > be removed.
> 
> IMO, they both serve a different purpose, RETBLEED_INTEL_MSG is a
> generic warning, and the message with !CONFIG_CALL_DEPTH_TRACKING hints
> a corrective action.
> 
> If you look at "case RETBLEED_CMD_STUFF" it also prints a separate warning for
> !CONFIG_CALL_DEPTH_TRACKING:

Yep, makes sense.

-- 
Josh

