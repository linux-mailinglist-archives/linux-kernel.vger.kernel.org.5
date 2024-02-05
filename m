Return-Path: <linux-kernel+bounces-53815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E86C84A6E8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C69291A0C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBED5A11C;
	Mon,  5 Feb 2024 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gO2BZ96L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB965A0F9;
	Mon,  5 Feb 2024 19:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160985; cv=none; b=rC8KWc5MunjsNn0Tx/O8/xZGcEnC7OAU4DePhoelmDE04OAHx6SL/x6Hy+STDBWfBW/ShN1q/hW7xee2qnBSmoIT3btbXa2LR/CvvPfO8G5w2mWwSl7yF/jhmjEPaVqJmrF9ImJlUdvutp8ZbhdhjWRjmY/aVGMiMmI5e32WFB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160985; c=relaxed/simple;
	bh=631bnoI95/4RxTtmJPA8muY0K1qwK11eTM0Wq4Qeiqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXzyFFsT3ETLjFB69uzZlt2e5N+5eqzqPiO7/fqNSuH4l/ag71S/SyYrdvM2YGXNK0cPrAHLbUaa+Syfcll93blkO/5shTCrjT08oDbuANFUYuPtKw2oEP7r+9ZUe09F7xDP5KDHIf8vBXm796FoqDpN0iAD89IYX13TH/g8UPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gO2BZ96L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402F7C433C7;
	Mon,  5 Feb 2024 19:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707160984;
	bh=631bnoI95/4RxTtmJPA8muY0K1qwK11eTM0Wq4Qeiqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gO2BZ96L12Ko4SirbE6I+iube4OZRYzWisRTKnxXc4PMSk7O3zZe7IXUiIF1IsTLv
	 7Z1dKJffUXWX2Vy4QzfB6mnlry1P2TO/W0wpjluAPpf5Y01JhVRiW8Gd2BC94wD4Ol
	 dTARJ+2AOtehctbstCm3ujDaljymGGc/sIKFQ4GyrN0nWPxXuf4+LmOKtmMHubfw1h
	 cnr2b67n44ONH1ChKtUuLEeD2iwDoWLF9Qb/zy/kCqk7jff4M9tRAEpIaXkLpnJjTF
	 caftyFybrPV4vFLKiy9KgKXDkMTqB7QX1jyzrQ52bjnHt1NrYTDMN2jkdVgSbnSMrQ
	 Qs4CLr2BXwz5A==
Date: Mon, 5 Feb 2024 19:23:01 +0000
From: Rob Herring <robh@kernel.org>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Robert Foss <rfoss@kernel.org>,
	Liu Ying <victor.liu@nxp.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	David Airlie <airlied@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	alexander.stein@ew.tq-group.com, dri-devel@lists.freedesktop.org,
	Lucas Stach <l.stach@pengutronix.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Will Deacon <will@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
	Jonas Karlman <jonas@kwiboo.se>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
	marex@denx.de, linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-phy@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	frieder.schrempf@kontron.de
Subject: Re: [PATCH V8 09/12] dt-bindings: display: imx: add binding for
 i.MX8MP HDMI TX
Message-ID: <170716098090.168745.4661359468123158581.robh@kernel.org>
References: <20240203165307.7806-1-aford173@gmail.com>
 <20240203165307.7806-10-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203165307.7806-10-aford173@gmail.com>


On Sat, 03 Feb 2024 10:52:49 -0600, Adam Ford wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> The HDMI TX controller on the i.MX8MP SoC is a Synopsys designware IP
> core with a little bit of SoC integration around it.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> ---
> V3:  Change name and location to better idenfity as a bridge and
>      HDMI 2.0a transmitter
> 
>      Fix typos and feedback from Rob and added ports.
> ---
>  .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    | 102 ++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


