Return-Path: <linux-kernel+bounces-77713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487E886095A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D231F258BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1186FD310;
	Fri, 23 Feb 2024 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apDnzXIZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CEAC2C4;
	Fri, 23 Feb 2024 03:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658750; cv=none; b=lIvBZ6/RM379Qu8TCe7cJnbnBhVuRWMWujLL8XeG7YOTIlexSr8+hbLd/oZLNid/ePIKXZQg/d0WvZXQQcjXXMJVy4WxzvueWG57LD4iiBNb6awu9fxYff1x2okLxVUhic50C0NmzZCs+6NzSM5GXL3k+XoWgcLBrkRy9z3cpJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658750; c=relaxed/simple;
	bh=01pAmEZPrVE/mN+21C6E5KceZu5TkFsxE7fPYMyk7NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjgBemZ1qdtKWJEpnIm6RHaRfq/zf98TBAensetXX8093IQyU09c0Dk8HhORwfy5jiKpZ/mwZ34pTcZIiNVnAmDBMkFaI4nTLQJa6VqZs9oacncnMTxYgSwX9eAdZ6tlIASKqyn4xlpEL+1OUQmOMMdc0z1e/gFE36AO/rz6vAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apDnzXIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192F2C433C7;
	Fri, 23 Feb 2024 03:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708658749;
	bh=01pAmEZPrVE/mN+21C6E5KceZu5TkFsxE7fPYMyk7NQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=apDnzXIZc6bm1rrH2Q3WZ0w/IlnAVCb1gjhZ3jy7lkYIlyCvBWwrp66MLggDA2efQ
	 bnGxZfG6CVP1yx4981jqWLEyF0M/OBKMZgl8urDL4q+1Uu5EqenYlouyVQMj1jBujc
	 ZLzj7MhbL3QdAJc+PywD7Bap4hICK45nBpbD5RiGyzWZacbzvT4aKr+bN/sTyz8Nki
	 stgJCA3UWcX7MJhhM5sxFcTRdjBNq1p+PGtlXBzoBuaW3Q6hglQEdHKAVpkkUtT5wN
	 2Xvk2OCmd2mokD4rrpkuYICmlT+2EZ0xlKxqAPw+LfLXF6yP6b1QJ7rDTxG2E9R0Ze
	 uv+5w0vSTFNXQ==
Date: Thu, 22 Feb 2024 19:25:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Wei Fang <wei.fang@nxp.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Russell King <rmk+kernel@armlinux.org.uk>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH net-next v5 4/8] net: phy: Keep track of EEE
 configuration
Message-ID: <20240222192548.2e9a501e@kernel.org>
In-Reply-To: <20240221062107.778661-5-o.rempel@pengutronix.de>
References: <20240221062107.778661-1-o.rempel@pengutronix.de>
	<20240221062107.778661-5-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 07:21:03 +0100 Oleksij Rempel wrote:
> @@ -595,6 +596,7 @@ struct macsec_ops;
>   * @advertising_eee: Currently advertised EEE linkmodes
>   * @eee_enabled: Flag indicating whether the EEE feature is enabled
>   * @enable_tx_lpi: When True, MAC should transmit LPI to PHY
> + * eee_cfg: User configuration of EEE

missing @ in front of the name here

>   * @lp_advertising: Current link partner advertised linkmodes
>   * @host_interfaces: PHY interface modes supported by host
>   * @eee_broken_modes: Energy efficient ethernet modes which should be prohibited
> @@ -715,6 +717,7 @@ struct phy_device {
>  	/* Energy efficient ethernet modes which should be prohibited */
>  	u32 eee_broken_modes;
>  	bool enable_tx_lpi;
> +	struct eee_config eee_cfg;
-- 
pw-bot: cr

