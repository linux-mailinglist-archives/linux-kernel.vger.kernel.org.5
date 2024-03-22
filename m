Return-Path: <linux-kernel+bounces-111265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77D58869DF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B9A1C21F9E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4542D630;
	Fri, 22 Mar 2024 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvEvppby"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0913D38D;
	Fri, 22 Mar 2024 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101785; cv=none; b=hLdin+V4tjfDrZLvGtBy52Sh8+jdvynJlMfarmEC1TGYsB4EmwNQsw2w7yNeIeHZ+C+Mo2Ew8MFgpTVNv6BjErSxz2RxlwqtIpdRa0AcuwZqBGysAKtjcX/w0L2ANtfd0Uzu7dMFRhJK6mboRar7Romux2Pf4iwEsDOf3X4sWJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101785; c=relaxed/simple;
	bh=tgfiNFatiqtNr3KSDdxr5ZCL/CAMYjZ3/K/FVVDuepw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJmNzGUJv6KbdszewM31Aup8DQptHZgxth+Bo4+T2WxY+ZWeSwP5ldbyNhhcTKafDsuoTKSfUbeEh9xpJjDyH0drjJeeA5vtvLqmnyeLLK53qW3n2NIXR+R4cf4zuG9JH02LYpZrEps0qk2BY8XiYvKfrphQld2a3uUc1Cs1KOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lvEvppby; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711101784; x=1742637784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tgfiNFatiqtNr3KSDdxr5ZCL/CAMYjZ3/K/FVVDuepw=;
  b=lvEvppbyzi1Zh7p6CqQ2lKRikMaYLQnLcc5q2Z7uZZmlzzq/diafgDFa
   pvV1zshOZF3y9lNDGMiWw9wZHZUn/sWVsoNl5P3I9wtu/ueCLEvjQVoiQ
   JLMtCaXoFq0DAZwvjgy71DSPiBXV4K1Gpl73SA4Xrni8AfH5Bsb4lUGpw
   NvNJpksBn+LdBRVIoV9xihBqr1oHi+ucCdiCueNZ/slsnQ0/gzNAXVXmp
   Yub1kNAR+sQLCFIvQSgRlwK4FW6sAiGYIIObfji+ag6SF20eI9EAxksGA
   TWTW8k+Y+lKCkTgDUhLfei4RNHMgadavuWnvQT3Qj6R8zLL0xoV90m+iD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6267178"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="6267178"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 03:03:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="937066512"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="937066512"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 22 Mar 2024 03:02:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 22 Mar 2024 12:02:58 +0200
Date: Fri, 22 Mar 2024 12:02:58 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Prashant Malani <pmalani@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-usb@vger.kernel.org, Kenneth Crudup <kenny@panix.com>
Subject: Re: [PATCH 0/5] Fix various races in UCSI
Message-ID: <Zf1XUrG1UbVJWzoz@kuha.fi.intel.com>
References: <20240320073927.1641788-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320073927.1641788-1-lk@c--e.de>

On Wed, Mar 20, 2024 at 08:39:21AM +0100, Christian A. Ehrhardt wrote:
> Fix various races in UCSI code:
> - The EVENT_PENDING bit should be cleared under the PPM lock to
>   avoid spurious re-checking of the connector status.
> - The initial connector change notification during init may be
>   lost which can cause a stuck UCSI controller. Observed by me
>   and others during resume or after module reload.
> - Unsupported commands must be ACKed. This was uncovered by the
>   recent change from Jameson Thies that did sent unsupported commands.
> - The DELL quirk still isn't quite complete and I've found a more
>   elegant way to handle this. A connector change ack _is_ accepted
>   on affected systems if it is bundled with a command ack.
> - If we do two consecutive resets or the controller is already
>   reset at boog the second reset might complete early because the
>   reset complete bit is already set. ucsi_ccg.c has a work around
>   for this but it looks like an more general issue to me.
> 
> NOTE:
> As a result of these individual fixes we could think about the
> question if there are additional cases where we send some type
> of command to the PPM while the bit that indicates its completion
> is already set in CCI. And in fact there is one more case where
> this can happen: The ack command that clears the connector change
> is sent directly after the ack command for the previous command.
> It might be possible to simply ack the connector change along with
> the first command ucsi_handle_connector_change() and not at the
> end. AFAICS the connector lock should protect us from races that
> might arise out of this.

That sounds good to me.

thanks,

-- 
heikki

