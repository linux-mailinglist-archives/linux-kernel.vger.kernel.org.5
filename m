Return-Path: <linux-kernel+bounces-55397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31FA84BC39
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB19287C66
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927CD1427E;
	Tue,  6 Feb 2024 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B/ok9Nyl"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AFF14008;
	Tue,  6 Feb 2024 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240938; cv=none; b=aB0ozIz9oBDYwGNfZ2g44ND6wYoaktRzgPeAuegnxJdUX0RAF5mFBXWDXklP1YBsGqZzxV2Vv4xFDnZH0Jmzr7pFYJhGjlYwho54kgLFOHtlNAX8+x1GItY4KV4BWIs62gNvKQEVShCrZGfw3W+oblSSZ5lq77kmXTVIT8f4Lo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240938; c=relaxed/simple;
	bh=c6+zB2oasy90215xQjAJvik7I3wJ2fCnD0/ZqsaC35Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBHeW+0h0jDpXwxNIW+J/HV0otF7GwtiVylwLGWoCuguKpN39dxc5TKs1is6QxRtebH6rJ80re0LnM5oXGsESQtPk/KbInulIuvuvnk58o/649QgyxMEdN92v1+rJ2FDSyicU/a3Xq+UXPF51PZux9R5AaAkwLbrfI6Rdm07dNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B/ok9Nyl; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC17A240008;
	Tue,  6 Feb 2024 17:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707240934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NskMUw8VWK4NaCGngx0MZM4fDzQxDxVdx3BbVktGJfc=;
	b=B/ok9NylPwe1rQqeIsnxSECT0yVfUsElVkqgpaPW9A41QTPlSyWVOLVO6bw1nVIedjif3Q
	hrdcpir6RTSm96ESVlU24axcSToGYWe33g0bTKf60pmNONn2cyNWBUZQG/+EPy76bhD3lb
	ByX//0bCY9LSCVA3UrpwsjQoqjO27IApzhS9srGCAkKjfkuC+UtXlmDCJhEv5FvJr51CqZ
	avTfStFctYCrAhly569KEtH4ZkXJnvuv7yyjjwtME2NpcAurznL/YrByaXkUUl/U578864
	KuPide03SYGUfSwAZkOnNZf6/e7FEjp5oLtrXIzSTJudBphs1fdnktRq7cVEVA==
Date: Tue, 6 Feb 2024 18:35:28 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de,
 alexander.stein@ew.tq-group.com, frieder.schrempf@kontron.de, Lucas Stach
 <l.stach@pengutronix.de>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Conor Dooley
 <conor.dooley@microchip.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Liu Ying <victor.liu@nxp.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V8 07/12] dt-bindings: display: imx: add binding for
 i.MX8MP HDMI PVI
Message-ID: <20240206183528.5b2e587f@booty>
In-Reply-To: <20240203165307.7806-8-aford173@gmail.com>
References: <20240203165307.7806-1-aford173@gmail.com>
 <20240203165307.7806-8-aford173@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hi Adam,

On Sat,  3 Feb 2024 10:52:47 -0600
Adam Ford <aford173@gmail.com> wrote:

> From: Lucas Stach <l.stach@pengutronix.de>
> 
> Add binding for the i.MX8MP HDMI parallel video interface block.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

