Return-Path: <linux-kernel+bounces-150331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 247C18A9D73
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C5D1F227FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95750168AE3;
	Thu, 18 Apr 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sTSH1fOz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2304165FCD;
	Thu, 18 Apr 2024 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451538; cv=none; b=P7/3B5i90PvuYUFd9gKU5lokecP7Jk034RY9lP+dMGWRP2e+vVGLp4W0VRjtURxxLF32Z7ECPlm/CyW/Uw2Zqi7MSY2vWAsmx4MhXqA1rw+U3F40SrnZbRDNMvP/JW89QcXxUEkIWU6nufS6GUl60EfUNDwwfXeDFX+ZORvdON4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451538; c=relaxed/simple;
	bh=nLbs8RL8++XhN2PB5brXy3kO4RizEvkxsXHyjVpr6sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryHNxpNVGtV4c74+zgvKDoHfRytpYhvc41/5vggNo4mrS+D9YV/xCEvpT6DltItSNwAAhCfIV3qhltSnWLTmYMWkSTKzaFc1H3UW730OlNJF2jXQ9uxRHmE0Mq2IeJXx/4ilM5lYR5fRp2q32XJdJRQ4TWLWRWhNOK5rwkFiKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sTSH1fOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469D4C113CC;
	Thu, 18 Apr 2024 14:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713451538;
	bh=nLbs8RL8++XhN2PB5brXy3kO4RizEvkxsXHyjVpr6sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sTSH1fOzGJ9UwFNYbWTkl1irr91yM3CjrwnlgH6gzP6HCmpkW+MfcYrbfU7wtWGs9
	 1fnL9FlfOnCUp9G1HZkvV6thGNpDLag0NHNHiuqitVwLLQcEjvb4cPCRdmEIjIDhYp
	 qdnArZywaCMR7NwnKNEy1APq5RbVdhf8nOmohKow=
Date: Thu, 18 Apr 2024 16:45:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "ZiEnWBbvmWwKqytK@ediswmail9.ad.cirrus.com" <ZiEnWBbvmWwKqytK@ediswmail9.ad.cirrus.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	"sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
	"david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
	"james.schulman@cirrus.com" <james.schulman@cirrus.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
	"rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] ALSA: hda/realtek: Fix internal speakers for
 Legion Y9000X 2022 IAH7
Message-ID: <2024041810-juice-overfull-5222@gregkh>
References: <TYCP286MB25357A4599E935F26A8AAB24C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
 <TYCP286MB25359B61BB685A4B3110BB44C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
 <ZiEnWBbvmWwKqytK@ediswmail9.ad.cirrus.com>
 <1883258.tdWV9SEqCh@qlaptoparch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1883258.tdWV9SEqCh@qlaptoparch>

On Thu, Apr 18, 2024 at 02:19:04PM +0000, Qi Qi wrote:
> > I would wait for Stefan to review the content before respinning
> > but you need to use your real name for the Signed-off-by line as
> > per Documentation/process/submitting-patches.rst, it's a legal
> > thing.
> 
> Thanks for the reminder.
> 
> My real name is Junhao Pei. 
> My PGP fingerprint is 7DA8815C10FCDAB8C6D11C4BDC72A2519E77D6CF.
> 
> I claim that I own the copyright of these patches, and agree to license them 
> under GPL v2.0 or later.

You still need to resend the patch with that information, don't make
anyone have to "hand edit" your patch :(

thanks,

greg k-h

