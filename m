Return-Path: <linux-kernel+bounces-58589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0699984E895
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357691C26DEF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9635D2E62B;
	Thu,  8 Feb 2024 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OONu5wRx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB52F25619;
	Thu,  8 Feb 2024 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418344; cv=none; b=F3WTUs4WIStB2V4GPjf1Xb1pkk3IYy3AjHiel3/XIZ8Z4pYMoZ+n2Ulh+W6wTtowrBim55JTKERVMAE5YBcswCJpwJbDXh7cIgjmftt2pSjIjz5ff8hHfrsx/Ylj0aezg5q7qlz2U3l99GnedULFgoLnX0dz8e/CGs1m2Aa/qaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418344; c=relaxed/simple;
	bh=ayyF27niELzt3hHf6FLsjG9AyRpa5VJUFGx2PqXaS0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRdsz7mp1iqjEIWA2wDYpPx+U8b/3xI4j1QWfAiSgPeQDhediU9gnQ4/wk2v6F/KHUn+As9LAlukJEYWyWOMsOZYSI3f9SsH84RccDtiQXlGnpEnKjkqIslyqVkQKtAGR3dAWIkHwLShLPFuXSiShbaUgorcm6zcMBSoxERHsXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OONu5wRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2ACAC433F1;
	Thu,  8 Feb 2024 18:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707418344;
	bh=ayyF27niELzt3hHf6FLsjG9AyRpa5VJUFGx2PqXaS0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OONu5wRxr6mAhe7TuLRR4y4hxM3B3EIbId7kHHNSEdO5iqMM12SsBfXBG9DjBB8TG
	 rU6v0kLn9fTdnQkUnc3kaiG+ck0xwrgGkjyIIJmI0MSinint+yuWsr408xTLNoPAnD
	 P7fKkC+RePoe+NPNrOyJl55aH4DngfGGH5EJhQEY=
Date: Thu, 8 Feb 2024 18:52:21 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	"open list:BROADCOM GENET ETHERNET DRIVER" <bcm-kernel-feedback-list@broadcom.com>,
	"open list:BROADCOM GENET ETHERNET DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH stable 5.4] net: bcmgenet: Fix EEE implementation
Message-ID: <2024020842-blaspheme-immortal-49dd@gregkh>
References: <20240208182041.3228898-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208182041.3228898-1-florian.fainelli@broadcom.com>

On Thu, Feb 08, 2024 at 10:20:40AM -0800, Florian Fainelli wrote:
> commit a9f31047baca57d47440c879cf259b86f900260c upstream
> 
> We had a number of short comings:
> 
> - EEE must be re-evaluated whenever the state machine detects a link
>   change as wight be switching from a link partner with EEE
>   enabled/disabled
> 
> - tx_lpi_enabled controls whether EEE should be enabled/disabled for the
>   transmit path, which applies to the TBUF block
> 
> - We do not need to forcibly enable EEE upon system resume, as the PHY
>   state machine will trigger a link event that will do that, too
> 
> Fixes: 6ef398ea60d9 ("net: bcmgenet: add EEE support")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Link: https://lore.kernel.org/r/20230606214348.2408018-1-florian.fainelli@broadcom.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Change-Id: I9e9d9d9e10817c7fcf3d9cde2389a1f6fe42a2ba

"Change-Id:"?  Ick, gerrit, so sorry :(

Please remove these.

thanks,

greg k-h

