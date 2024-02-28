Return-Path: <linux-kernel+bounces-84476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BB886A734
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6811F22B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF5C200C0;
	Wed, 28 Feb 2024 03:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QohiKP2o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318DE200A8;
	Wed, 28 Feb 2024 03:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709090859; cv=none; b=e1VtvUzfosd6d60OKhKY9/aRwP2ZhOH1EbJVMtwT7nl20QqzUWV06kiirUYmtlwDJJ19iLfJOzm+V6Un6Fy9eijfusnZiP2P4fNW7QFrbPasP/ZND2CA31G85Dd0B2ave9Cu4xzjRZkctOlNilXEbyu4nm0iyxqgstli+thTweQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709090859; c=relaxed/simple;
	bh=PxStEec/OucY88faF3IBr5N3T4pzL8MHzbg0huNkeQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LngL6Un/NwScGnLxkQExdTMNBqDp6+9IvHf3AWv9h6wZAcX5IsUXG3/vUharvCen5EzbV942EYjTK2flTR//J4YxrCsWmm4h82ul9nbfYQ1w/n3An+jlUZmJ/ExTpEMMRTz5YBC30UJNUX1JEOsegf0/nCrRPzx5fyh99soMU5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QohiKP2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E73C433F1;
	Wed, 28 Feb 2024 03:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709090859;
	bh=PxStEec/OucY88faF3IBr5N3T4pzL8MHzbg0huNkeQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QohiKP2oUlYmBY59Cy+RuyemEWPJDO5INyMmAP4cnWYa61MvqxzWbOWQ7QrkAr57U
	 sPpg2I9PAiQzmbh9Iq3kC5nizezkGjbTn2K677Ci8RM0B5MPa5LEYDpDBWRFxVnOxv
	 t7jm4Z8ZGZ+7HELUw5a+ri35666+dhnF4QEC7+ycodAEqtCR1ZpB3fnhllDmrQ6i2l
	 uHWckA9X5pRSMuh0VJVv9cbl4bC/lavkenE0SYuieyYYFuJ1NZY904mEj7XJrk4rH4
	 bOKFA5biMK++N9Y3xLJ8aq/RBcyJ3REIsDT68i7DsaVrM2ojBxaEAnBQva3sVviBmb
	 tr1pEEF3/gjYw==
Date: Tue, 27 Feb 2024 19:27:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v9 06/13] net: Add struct
 kernel_ethtool_ts_info
Message-ID: <20240227192737.5d834155@kernel.org>
In-Reply-To: <20240226-feature_ptp_netnext-v9-6-455611549f21@bootlin.com>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
	<20240226-feature_ptp_netnext-v9-6-455611549f21@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 14:39:57 +0100 Kory Maincent wrote:
> In prevision to add new UAPI for hwtstamp we will be limited to the struct
> ethtool_ts_info that is currently passed in fixed binary format through the
> ETHTOOL_GET_TS_INFO ethtool ioctl. It would be good if new kernel code
> already started operating on an extensible kernel variant of that
> structure, similar in concept to struct kernel_hwtstamp_config vs struct
> hwtstamp_config.
> 
> Since struct ethtool_ts_info is in include/uapi/linux/ethtool.h, here
> we introduce the kernel-only structure in include/linux/ethtool.h.
> The manual copy is then made in the function called by ETHTOOL_GET_TS_INFO.

This one doesn't apply.
It's going to be a pain to keep rebasing it, since its a nop AFAICT -
do you want to post it separately to get it merged quickly?
-- 
pw-bot: cr

