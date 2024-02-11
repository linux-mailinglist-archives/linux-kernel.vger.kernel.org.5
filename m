Return-Path: <linux-kernel+bounces-60866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4750850A58
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2953EB2150C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52F15C5F4;
	Sun, 11 Feb 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXE/ixzo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090F11DFEF;
	Sun, 11 Feb 2024 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707669383; cv=none; b=ZGYbhZgOm85jHg6ndafWWKu3NHzk1ye1bFuYW+MYxbOwJCmuszXuMgaqycaymIgmv5kFsamDKp+jZSRasHV+aXTAEQkyH6VxFf5IDPHcrt7w7URIZqBv0kStfu2EYto/O5gnlqaQAvLo7DLbk3g1LLt/3LCYhkj/2JVm7bluC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707669383; c=relaxed/simple;
	bh=BVT7c5MMwoanGGQVtjw+M5JfeoluaC7HDWDxAzZAEyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgpNv2R3YOhfp6lZbdXYwNr8CssqAMj2g0SNjzfGF6nQA3qTF5kgc67FQ1wO3kkFWaFGBax2vDHVrGEzZKHGTY1WJkY/MU++HAZMA9E3J6o+D0XxGcmmP0AjoW6MocfGMBHgHU1/Ze0KLA9lkBBuamiVaBr+oXhnGKlSfVQ7uGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXE/ixzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E63DC433C7;
	Sun, 11 Feb 2024 16:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707669382;
	bh=BVT7c5MMwoanGGQVtjw+M5JfeoluaC7HDWDxAzZAEyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GXE/ixzolu0k8wKk/Vk6a7Fel7WWw+xxHDcbCPywbSyyo83tTRz477KXJUWMxpXvf
	 Tr1MXoK+sD403mAy4u2WLgduc5yUbSq8mXGAZ41zGRqxZlklydfPn2uirTjb+A38cv
	 4kxcPMlLJ1dGLJxIa2DAPO3EmgFPIH4m9QZ4ZV/JqOGEc8MY4SMxuwl66j6r7DLiE4
	 PODM2fF5Rfh2eDLFzzxVxsV6EwDQslfZxBRq3+kY+e8GuWHKr4qd3ccjm2g+mjIALS
	 pMFPyjIkh/eo+Ylq6zScv089vlj50F4L/BZg2Nh6IIqO46IqsbixZ0qFymqZSmNbrG
	 AZwBVKL2aUKEw==
Date: Sun, 11 Feb 2024 11:36:20 -0500
From: Sasha Levin <sashal@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	"open list:BROADCOM GENET ETHERNET DRIVER" <bcm-kernel-feedback-list@broadcom.com>,
	"open list:BROADCOM GENET ETHERNET DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH stable 5.15 v2] net: bcmgenet: Fix EEE implementation
Message-ID: <Zcj3hF6uywZcTPX4@sashalap>
References: <20240208190605.3341379-1-florian.fainelli@broadcom.com>
 <20240208190605.3341379-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240208190605.3341379-2-florian.fainelli@broadcom.com>

On Thu, Feb 08, 2024 at 11:06:05AM -0800, Florian Fainelli wrote:
>[ Upstream commit a9f31047baca57d47440c879cf259b86f900260c ]
>
>We had a number of short comings:
>
>- EEE must be re-evaluated whenever the state machine detects a link
>  change as wight be switching from a link partner with EEE
>  enabled/disabled
>
>- tx_lpi_enabled controls whether EEE should be enabled/disabled for the
>  transmit path, which applies to the TBUF block
>
>- We do not need to forcibly enable EEE upon system resume, as the PHY
>  state machine will trigger a link event that will do that, too
>
>Fixes: 6ef398ea60d9 ("net: bcmgenet: add EEE support")
>Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>Link: https://lore.kernel.org/r/20230606214348.2408018-1-florian.fainelli@broadcom.com
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>Signed-off-by: Sasha Levin <sashal@kernel.org>
>Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

It doesn't look like this one applies to 5.15...

-- 
Thanks,
Sasha

