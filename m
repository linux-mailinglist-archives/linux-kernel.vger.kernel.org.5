Return-Path: <linux-kernel+bounces-20632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCD38282B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5A41F24481
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B8129CF1;
	Tue,  9 Jan 2024 09:08:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893ED35887
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rN85E-0007cY-31; Tue, 09 Jan 2024 10:07:40 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rN859-001R7l-RJ; Tue, 09 Jan 2024 10:07:35 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rN859-0002H7-2R;
	Tue, 09 Jan 2024 10:07:35 +0100
Message-ID: <fc30ce4736d43e367108c3651fec6f3b9a4d7852.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] gpu: drm: bridge: cadence: Add a driver and
 platform ops for StarFive JH7110 SoC
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Shengyang Chen <shengyang.chen@starfivetech.com>, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com,  maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de,  airlied@gmail.com,
 daniel@ffwll.ch, robh+dt@kernel.org,  krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org,  tomi.valkeinen@ideasonboard.com, r-ravikumar@ti.com,
 aford173@gmail.com,  rdunlap@infradead.org, u.kleine-koenig@pengutronix.de,
 bbrezillon@kernel.org,  changhuang.liang@starfivetech.com,
 keith.zhao@starfivetech.com,  jack.zhu@starfivetech.com,
 linux-kernel@vger.kernel.org
Date: Tue, 09 Jan 2024 10:07:35 +0100
In-Reply-To: <20240109072516.24328-3-shengyang.chen@starfivetech.com>
References: <20240109072516.24328-1-shengyang.chen@starfivetech.com>
	 <20240109072516.24328-3-shengyang.chen@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Di, 2024-01-09 at 15:25 +0800, Shengyang Chen wrote:
> +static int cdns_dsi_get_reset(struct device *dev, struct cdns_dsi *dsi)
> +{
> +	dsi->dpi_rst =3D devm_reset_control_get(dev, "dpi");
> +	if (IS_ERR(dsi->dpi_rst))
> +		return PTR_ERR(dsi->dpi_rst);

Please use devm_reset_control_get_exclusive() directly.

Also, consider using devm_reset_control_bulk_get_exclusive() instead,
to control "dpi"/"apb"/"txesc" resets together - if the hardware can
handle deasserting in reversed order.

> +
> +	dsi->apb_rst =3D devm_reset_control_get(dev, "apb");
> +	if (IS_ERR(dsi->apb_rst))
> +		return PTR_ERR(dsi->apb_rst);
> +
> +	dsi->txesc_rst =3D devm_reset_control_get(dev, "txesc");
> +	if (IS_ERR(dsi->txesc_rst))
> +		return PTR_ERR(dsi->txesc_rst);
> +
> +	dsi->txbytehs_rst =3D devm_reset_control_get(dev, "txbytehs");
> +	if (IS_ERR(dsi->txbytehs_rst))
> +		return PTR_ERR(dsi->txbytehs_rst);
> +
> +	return 0;
> +}

regards
Philipp

