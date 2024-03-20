Return-Path: <linux-kernel+bounces-109332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 006198817C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940CE1F2322F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EF58563D;
	Wed, 20 Mar 2024 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5aN2eja"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246488527E;
	Wed, 20 Mar 2024 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710962265; cv=none; b=e0f57i/ASd9w8QWiy7InUiE3YO2f4fquWB35nJ7tKXdoswFhHhZgiFISKEkB0zdXpOTuXamLIh2soVJWH1mcQfyPqpsiA8SWLR9burfpkvrOBV3iu/EDenaSO7bnUVlJFfm162fnSbisTEqyTtnoQK2uGZRpg/9GeRXWp3pTRik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710962265; c=relaxed/simple;
	bh=Azjd7wwCn4XA8bLGPMLhdiQkH8JfOmigzXwu2vsa6kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jt8OST4SW4EpajnGC+XDyy6ft4hhuRkhRp6XTdUGOgc4mWoAzZqHw2iPRa+9BhiSIUboVoPMXcf8LtSjTdp0OpHmwSUVhT7KsLCRx1Pu4c0EZW7oixOfAeS6D3HUr4zLxIUGqN0bG5A6xWa0d2q1H7tYbsTVwhascnM+GXnFZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5aN2eja; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710962263; x=1742498263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Azjd7wwCn4XA8bLGPMLhdiQkH8JfOmigzXwu2vsa6kc=;
  b=c5aN2ejaIwMNiPweUONQVa7LDG2lTeKTB/aalqD/4s+2CR52Km7EMKOG
   TzLINBCtsOUM0DLBpdez05eMSd2+wR1xI05MkhB22GHGmI81jx+P8cmct
   yXXUZqn3JD5RMvMRrCGvcv9jD5aJvRepiVBu891dG6WDahZKWGKnTggjP
   XmP3CHvmE5Dg/qaCO6rh8nP/MDeXsv3lkGGFlykEGuToTY1fJQ8pvOC6F
   VNrcWIGXVvh0MX9gwbVh0Ku9o3/CJEEf5fQYmPxS08/k86a/jL7whIAhr
   6S262tFlKVvikSI7LwoUNeAQDMObJg6+F6yXmP/YNK3+MKYr60RRP4/Sq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5760606"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="5760606"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 12:17:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="18840236"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.72.188])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 12:17:40 -0700
Date: Wed, 20 Mar 2024 12:17:38 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: TaheraFahimi <fahimitahera@gmail.com>
Cc: Marc Dietrich <marvin24@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: nvec: edit udelay comment
Message-ID: <Zfs2Ug5INYKKyiDH@aschofie-mobl2>
References: <ZfS+UaVyob+lFmmS@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfS+UaVyob+lFmmS@tahera-OptiPlex-5000>

On Fri, Mar 15, 2024 at 03:32:01PM -0600, TaheraFahimi wrote:
> Signed-off-by: TaheraFahimi <fahimitahera@gmail.com>

Missing commit log.

Commit message would be clearer like: "correct a misspelled comment"
because when you say you are editing a udelay comment, it made me
think you were clarifying something about usage of udelay.

There are plenty of patches on this list with examples of how
patches of spelling corrections are worded in both the commit
message and log. Please take a look.

Thanks,
Alison


> ---
>  drivers/staging/nvec/nvec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> index 282a664c9176..b4485b10beb8 100644
> --- a/drivers/staging/nvec/nvec.c
> +++ b/drivers/staging/nvec/nvec.c
> @@ -712,7 +712,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
>  	 * TODO: replace the udelay with a read back after each writel above
>  	 * in order to work around a hardware issue, see i2c-tegra.c
>  	 *
> -	 * Unfortunately, this change causes an intialisation issue with the
> +	 * Unfortunately, this change causes an initialisation issue with the
>  	 * touchpad, which needs to be fixed first.
>  	 */
>  	udelay(100);
> -- 
> 2.34.1
> 
> 

