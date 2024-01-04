Return-Path: <linux-kernel+bounces-17338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A64824BEA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596A31C22259
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF01A2D610;
	Thu,  4 Jan 2024 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETsWmnpX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020022D600;
	Thu,  4 Jan 2024 23:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A670C433C8;
	Thu,  4 Jan 2024 23:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704412043;
	bh=PKIw7BcJSaypMdJBg4Njrm2KDvBf+rMCYg3A6sDiTso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ETsWmnpXUD3YDF1/knK0iVgwfDEAd+0bbjKyhZVngHgIUVmY6Sn/gKd9Ywe14MFbD
	 A4DMvgtg0jCAWwjYBsUDw3xz84vHRASIuvKF7+Nv+LTuOeBKEoPKWv05UGFrH653FH
	 bRsHNqUExinSE4AjKApcCoYe2TbFPnfhQ1lv+KKowy8iPpqrWve2vqcBl29Tt8qtlw
	 //G5vz7unSwEuIQlN7u9sdd9xCCLWPoHHYMgqsvrEoORUVomx80cViMgy41VGDkXNo
	 VPiYxkCSVxdoGRNRkt3KLIFCR4SP8nRGVmzne8NO+U2QkVACLx3IOs1hTcKqUfac+W
	 Uh3BK0vAKQjdw==
Date: Thu, 4 Jan 2024 15:47:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, andrew@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 christophe.leroy@csgroup.eu, herve.codina@bootlin.com,
 f.fainelli@gmail.com, hkallweit1@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, jesse.brandeburg@intel.com, corbet@lwn.net,
 kabel@kernel.org, piergiorgio.beruto@gmail.com, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org
Subject: Re: [PATCH net-next v5 00/13] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240104154721.192694a8@kernel.org>
In-Reply-To: <20240103153336.424dcfe3@device-28.home>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
	<170413442779.30948.3175948839165575294.git-patchwork-notify@kernel.org>
	<ZZP6FV5sXEf+xd58@shell.armlinux.org.uk>
	<20240102105125.77751812@kernel.org>
	<20240103153336.424dcfe3@device-28.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jan 2024 15:33:36 +0100 Maxime Chevallier wrote:
> I think this could help in reviewing the overall design and identifying
> any glaring issue with this.

The netlink handling looks a bit wobbly to me.
I commented best I could in the 20min I had to look at this code :(
I think it'd be best to revert, if you don't mind, because reviewing
incremental fixes will get even harder.

