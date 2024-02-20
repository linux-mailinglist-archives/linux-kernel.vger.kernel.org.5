Return-Path: <linux-kernel+bounces-73211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835B885BF5F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392FC1F254BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469DD745D4;
	Tue, 20 Feb 2024 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xl5Xrye8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876506931F;
	Tue, 20 Feb 2024 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441255; cv=none; b=ECEzOSFuCXcbwOs4uPVq3mNrZTZip6NXDGFC8OYCs+7I0TxsHhB5Ls64T7hkM0iviOWf0FvxmUQYUbBIW4HbjUBKB1lz+xpby/gRFhpIl2Z27OJgSfvCVf4mPTw8zYSfp3+d0xvC3pZjBXJ81bEIMqHf+ul1nGomRwyzPG19dKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441255; c=relaxed/simple;
	bh=t0kh6fT7xYxfjYlEKpkM6AOETmzHo7MjScDoq365xG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noeXdjSMxKITRhZ098YvpNSUwj/1sDyYJKR8ofxbV8KAOq9/1X4Geihcp1d51yJ40qU4K3phb7NBbn3kirABxM1P19S2/WGeTw9cqG/ozkY49EqzOLmSmusX68RCOn/1FRirz1HHf4JVnYIgP0WH1f5oJwJm9qV9rf20M7ldRWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xl5Xrye8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5071AC433F1;
	Tue, 20 Feb 2024 15:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708441255;
	bh=t0kh6fT7xYxfjYlEKpkM6AOETmzHo7MjScDoq365xG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xl5Xrye8FtH7cnrdC7jAssSPoehu+/m2GxRMNDtkrhAkjT+5dEsCWjtUhaWDXmvMI
	 ruOmg+0SePgiidCxNnbMVP3k/v453nd3uTMajSeeusA/xwk2fJUgeRld0JRTX37n/Y
	 +tIB0MaarLeH+F8D17aEFyTVerbDAvvbRdxEM03VLlawukPs5MrB+iom2/dlZcpl+h
	 bpTW2KEokm1pmKvgJWPly6i5jF++JwOa9KeU6KHBge2OuemX686I90JYK6czEPyNwK
	 Dw+xr+GxacmF9F3UfLcOnTkxyrijFi6RirbNhn2SxZYj8fO7g+tD2fI+jhCeB3e56R
	 MhoOppnCs/qgA==
Date: Tue, 20 Feb 2024 15:00:50 +0000
From: Simon Horman <horms@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH net] net: phy: realtek: Fix rtl8211f_config_init() for
 RTL8211F(D)(I)-VD-CG PHY
Message-ID: <20240220150050.GO40273@kernel.org>
References: <20240220070007.968762-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220070007.968762-1-s-vadapalli@ti.com>

On Tue, Feb 20, 2024 at 12:30:07PM +0530, Siddharth Vadapalli wrote:
> Commit bb726b753f75 ("net: phy: realtek: add support for
> RTL8211F(D)(I)-VD-CG") extended support of the driver from the existing
> support for RTL8211F(D)(I)-CG PHY to the newer RTL8211F(D)(I)-VD-CG PHY.
> 
> While that commit indicated that the RTL8211F_PHYCR2 register is not
> supported by the "VD-CG" PHY model and therefore updated the corresponding
> section in rtl8211f_config_init() to be invoked conditionally, the call to
> "genphy_soft_reset()" was left as-is, when it should have also been invoked
> conditionally. This is because the call to "genphy_soft_reset()" was first
> introduced by the commit 0a4355c2b7f8 ("net: phy: realtek: add dt property
> to disable CLKOUT clock") since the RTL8211F guide indicates that a PHY
> reset should be issued after setting bits in the PHYCR2 register.
> 
> As the PHYCR2 register is not applicable to the "VD-CG" PHY model, fix the
> rtl8211f_config_init() function by invoking "genphy_soft_reset()"
> conditionally based on the presence of the "PHYCR2" register.
> 
> Fixes: bb726b753f75 ("net: phy: realtek: add support for RTL8211F(D)(I)-VD-CG")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Simon Horman <horms@kernel.org>


