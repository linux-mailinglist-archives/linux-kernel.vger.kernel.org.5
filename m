Return-Path: <linux-kernel+bounces-34434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502468378E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8342C1C27811
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27122145330;
	Tue, 23 Jan 2024 00:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/mwh8Eq"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81763C29
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968282; cv=none; b=F2VzsPbuMrIiBDccz1Dl3evojOEO1ZZgijuQv7y3cm0Ge9DcgnZj0++P1J7K2uBbNJmk/xmGrtsAy/PJmKvyyGUxReoIEajGwp1F4Cpa2lXFsKIYdPIkUXw/tjVbBvUxslIoHnBXBAG4ALidzuTEqTPrvqxzHJPQO4rWthDZ0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968282; c=relaxed/simple;
	bh=nfelir3AWSRDoyUGNYzJu1AG7aLWBoB1odWGtHONiUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THKx4sgZnQf7tIYBM8c08F3tPJtqWBfqcHoWcIhZS6q4A7ObjY4yTphaPkSuXPLbWdWfCV6IObFOSeRVd7GXt7YiFdcc/TSsDS0oT7G5oCHm8YC/F0ExUcKeqgUwtKeQ5eiFUqhO7dxehoan6pchm7X/GtT712rz10KY/bJFW+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/mwh8Eq; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705968280; x=1737504280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nfelir3AWSRDoyUGNYzJu1AG7aLWBoB1odWGtHONiUI=;
  b=h/mwh8Equh3NGPheSBcFkItHQ/HHghU9u59omF4DnaFBgbXWgg/0xf0t
   hJoWIJByHCKkAir85vSYO6wYEITML7t3sLQ/r7BiqmfSR3c6BAz9//I0q
   BjBXNKbdwvBg1uACc43GRTORKb9NYXZUcxKNud/F1v2QyeaUHUBI35EzS
   WWCVY0/Z1bTxwA0PuDVEdX2V37K2ti6zs0aPdt3uOcR7ZxwYZkG4XwDgX
   YCBMPMTSGrzkYPEMdrKiXuaCA2XVi1V07CvhR4aE8REDZbT1bwrrRG4wI
   OrFx2gkHINx4TSoTngstvZI2lhtIZ+T3/TbeYgNtpdKvISz2aV6JdDfBa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="400221489"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="400221489"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 16:04:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="1470872"
Received: from thalethi-mobl2.amr.corp.intel.com (HELO desk) ([10.209.98.31])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 16:04:39 -0800
Date: Mon, 22 Jan 2024 16:04:31 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Breno Leitao <leitao@debian.org>
Cc: mingo@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] x86/bugs: spectre_v2_user default mode depends on
 main default
Message-ID: <20240123000431.rqs5g6gjpq5uckcs@desk>
References: <20240118173213.2008115-1-leitao@debian.org>
 <20240118173213.2008115-4-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118173213.2008115-4-leitao@debian.org>

On Thu, Jan 18, 2024 at 09:32:13AM -0800, Breno Leitao wrote:
>  static enum spectre_v2_user_cmd __init
>  spectre_v2_parse_user_cmdline(void)
>  {
> +	int ret, i, mode;

mode is being returned, it is better to match its type with function's
return type "enum spectre_v2_user_cmd".

>  	char arg[20];
> -	int ret, i;
> +
> +	mode = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?
> +		SPECTRE_V2_USER_CMD_AUTO : SPECTRE_V2_USER_CMD_NONE;
>  
>  	switch (spectre_v2_cmd) {
>  	case SPECTRE_V2_CMD_NONE:
> @@ -1236,7 +1239,7 @@ spectre_v2_parse_user_cmdline(void)
>  	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
>  				  arg, sizeof(arg));
>  	if (ret < 0)
> -		return SPECTRE_V2_USER_CMD_AUTO;
> +		return mode;
>  
>  	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
>  		if (match_option(arg, ret, v2_user_options[i].option)) {
> @@ -1246,8 +1249,8 @@ spectre_v2_parse_user_cmdline(void)
>  		}
>  	}
>  
> -	pr_err("Unknown user space protection option (%s). Switching to AUTO select\n", arg);
> -	return SPECTRE_V2_USER_CMD_AUTO;
> +	pr_err("Unknown user space protection option (%s). Switching to default\n", arg);
> +	return mode;
>  }
>  
>  static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
> -- 
> 2.34.1
> 

