Return-Path: <linux-kernel+bounces-112194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFCF8876C9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CAA71C212B6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 02:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F1033F6;
	Sat, 23 Mar 2024 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D51Kwxbx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C60F10F1;
	Sat, 23 Mar 2024 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711162747; cv=none; b=ShsmTCsfIxOvZYrLOH7uAAQFwsva9jmEA3sp8eZDxD2dkl5ThLMzth0NuuER4BiYISLYRma55SLMbsUMfBSJwkmS0Sc7FQ3SjexaiPbUrajaoCIbUUkF9MJ2vE9OQd4ed7ZsLjQAC1mhmD0qmaV5E1ukBRDBQhQlcgwM1YXfzXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711162747; c=relaxed/simple;
	bh=PM5nJFRDqlMt0stkr83Pd4pF6Hmt+v56xfP6Bj06vZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sox/dbGEA/vbMTJKqKWjHuokKpy7XgV/N3y+au9Mx/6ARqOvQJUF3musOOQZcPs6KhFHmUxghx0K3TYjrto2uUz0dZg5cbq1uwta1D44TDJNBYxRUsF5+ea+yETaKlAmpHhBYgPsVgaqufOT0Jmx+5uTl+5lkdgYmUPYm/f+OTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D51Kwxbx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711162745; x=1742698745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PM5nJFRDqlMt0stkr83Pd4pF6Hmt+v56xfP6Bj06vZY=;
  b=D51KwxbxzXvoxun+QEF0uJwP/6XcTGZaS0HAK83fz2VpH3qGVBwZNnNC
   UtjS8sebqM6VQj1NFckQnnS4+/ymTb27PiPkzFxEqfwbDPLUunERgxfUI
   Kf+Sq1cJcm0IjSHC4A13MnrCEAmWUEAPzAXetBwl8f40RXVWizZiL0jTq
   cwrey1nYNYvly0oJjj5ErUFL3CvraHknHG/TOT/olghPdmYIO+a6eAuc7
   M8UU9yySZjcfGzaJB/YoGor+NyJKSJprVrZv8xH2QAN44EjwmuCTTQ6BI
   CPbL1HIPsl5kCASS2XgYNal+hVYLwVwBbnCIdzrZqTzJfYIU1vDd9zQve
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="28705476"
X-IronPort-AV: E=Sophos;i="6.07,148,1708416000"; 
   d="scan'208";a="28705476"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 19:59:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,148,1708416000"; 
   d="scan'208";a="19783746"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.88.188])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 19:59:03 -0700
Date: Fri, 22 Mar 2024 19:59:02 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: sudipm.mukherjee@gmail.com, dan.carpenter@linaro.org,
	teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v3] staging: sm750fb: Replace comparisons with NULL and 0
Message-ID: <Zf5FdsiaVPQ6iz2r@aschofie-mobl2>
References: <2024032208-blunt-ferocity-22f4@gregkh>
 <20240322151633.16485-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322151633.16485-1-chandrapratap3519@gmail.com>

On Fri, Mar 22, 2024 at 08:46:33PM +0530, Chandra Pratap wrote:
> Replace '(opt != NULL)' with '(opt)' and '(*opt != 0)'
> with '(*opt != '\0')' to adhere to the coding standards.
> 
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
> 
> Please ignore the other v3 patch I sent, I forgot to write
> the change log in that patch. Apologies for any incovenienece
> caused.

Hi Chandra,

No need to apologize, but you do need to send a v4. Any change
in the patch is a new rev - even if that change is to the
changelog. Maintainers are using automated tooling to grab
the latest revisions and two patches with the same version 
number will be disregarded. 

Please send a v4 with:

Changes in v4:
  - Include the changelog.

While you're at it, reverse the order of this changelog.
Put most recent revisions first - ie 4,3,2 order.

Also, post the patch as a new message, not a reply to prior
patches.

Thanks,
Alison


> 
> Changes in v2:
>   - Update the commit message to reflect the changes better
>   - Replace (*opt) with (*opt != '\0')
> 
> Changes in v3:
>   - Remove unncessary spacing
> 
>  drivers/staging/sm750fb/sm750.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 04c1b32a22c5..c4b944f82fb9 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -926,7 +926,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
>  		goto NO_PARAM;
>  	}
>  
> -	while ((opt = strsep(&src, ":")) != NULL && *opt != 0) {
> +	while ((opt = strsep(&src, ":")) && *opt != '\0') {
>  		dev_info(&sm750_dev->pdev->dev, "opt=%s\n", opt);
>  		dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
>  
> @@ -1147,7 +1147,7 @@ static int __init lynxfb_setup(char *options)
>  	 * strsep() updates @options to pointer after the first found token
>  	 * it also returns the pointer ahead the token.
>  	 */
> -	while ((opt = strsep(&options, ":")) != NULL) {
> +	while ((opt = strsep(&options, ":"))) {
>  		/* options that mean for any lynx chips are configured here */
>  		if (!strncmp(opt, "noaccel", strlen("noaccel"))) {
>  			g_noaccel = 1;
> -- 
> 2.34.1
> 
> 

