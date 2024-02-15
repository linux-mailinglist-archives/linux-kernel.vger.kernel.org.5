Return-Path: <linux-kernel+bounces-66742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F31F18560EE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7B028DBDE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF0F85263;
	Thu, 15 Feb 2024 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zef6unym"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A810D12A142;
	Thu, 15 Feb 2024 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995244; cv=none; b=YYLG3LlfvPwHLjES6+BR/FhNE/ywGSO43oqGMO/rL79PTm+ZZLiy0TW2WzZV2PJ/fLIo78TPcGT1DzqYP/Pjxz1THv94pAjLY/wpGRgDnP2y0hp1f/LWbHhsCYi+2ULc24aiQ0LlHduIIspJNAOkoOSDrySrLgrvefh/VRvavdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995244; c=relaxed/simple;
	bh=ipndqY9nxNMul3gLMF2c2rmj5102VFlC9qbLx+KDy1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHdy9m33z4oX6GnhJFdu3pMqLDl69IBl1WYw0ZXySlaBZhAYw42RblTTQzkq3pQb2SabrCJig1N1NlzFBWLnfH5wG5aJhUGsuE0s74iZCO+jWf3NoTU/BG+MEZkUCAYlFUxubJb3KjirTEntL4JyjHICzf+1d6Id8mrnoQAGG/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zef6unym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D735C433F1;
	Thu, 15 Feb 2024 11:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707995243;
	bh=ipndqY9nxNMul3gLMF2c2rmj5102VFlC9qbLx+KDy1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zef6unymmtg2xVd8EVCwZRlYMiB9Se8NDapY1MlfKXQbufriMTfEJz6POwaKTma2L
	 whytBk4ezUboR0thm0CqCh+WMbnKKmXOp3B7YXqnZ1MduMnncazOOipB3ai5vQYXda
	 zDjzudIqwca5ct7xDSpqMkjxU0my2EYf7QxEuOUk=
Date: Thu, 15 Feb 2024 12:07:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Sing-Han Chen <singhanc@nvidia.com>,
	Haotien Hsu <haotienh@nvidia.com>,
	Utkarsh Patel <utkarsh.h.patel@intel.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Wayne Chang <waynec@nvidia.com>, WK Tsai <wtsai@nvidia.com>
Subject: Re: [PATCH CFT] usb: ucsi_ccg: Fix command completion handling
Message-ID: <2024021504-oven-worst-5c15@gregkh>
References: <20240215101024.764444-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215101024.764444-1-lk@c--e.de>

On Thu, Feb 15, 2024 at 11:10:24AM +0100, Christian A. Ehrhardt wrote:
> In case of a spurious or otherwise delayed interrupt
> it is possible that CCI still reports the previous completion.
> For this reason the UCSI spec provides different completion
> bits for normal commands and for UCSI_ACK_CC_CI.
> 
> Only complete a sync command if the correct completion bit
> is set.
> 
> This should avoid the need to clear out CCI before starting
> a command. Thus remove this code.
> 
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> Fixes: e32fd989ac1c ("usb: typec: ucsi: ccg: Move to the new API")

What does "CFT" in your subject line mean?

thanks,

greg k-h

