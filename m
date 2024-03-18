Return-Path: <linux-kernel+bounces-106251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6137A87EB6A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18CC31F24D33
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76B54EB3B;
	Mon, 18 Mar 2024 14:51:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BAC4E1DF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710773463; cv=none; b=HFjZjt9CQnHkgZZJmKG2ddoCjfQeaGnlRJvB3RFWvSerLXI9MeDOnJ0+GXcdko6RaDtQ1rQiiOAksqXufZdi9SLGheMaMExcP0mmAYTESyp+QghVnsL9dMPhnlG/QvbJojhtof7lLqxmqZiF+73siVqWo95WrmsZs+c5ivobBD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710773463; c=relaxed/simple;
	bh=ijgWv+hkt7MPS/3r6Fl7OChFfUER0e/KI95LrtFDwa4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B3RYAUj74yE2WFnnUw6rAkPE/JZzPl3rtPtbDDRM3m/psJlxhcl8ePFatsyPTMEdEvd0QpKCwwirycWcwBM/WhiSAnyDd8agAE/OyRO0PKnKe0czBVmakTxUhrQZpjMZmvj+G6Q4xDhUPOjtUD69JWNiaZORbdHEz0paURiclFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rmEK7-0004ix-UT; Mon, 18 Mar 2024 15:50:47 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rmEK6-00766i-DA; Mon, 18 Mar 2024 15:50:46 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rmEK6-000COV-16;
	Mon, 18 Mar 2024 15:50:46 +0100
Message-ID: <0faf621bd00847dc8f5776504faf0b223e8ae35c.camel@pengutronix.de>
Subject: Re: [PATCH 2/6] media: chips-media: wave5: support reset lines
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Ivan Bornyakov <brnkv.i1@gmail.com>, Nas Chung
 <nas.chung@chipsnmedia.com>,  Jackson Lee <jackson.lee@chipsnmedia.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Date: Mon, 18 Mar 2024 15:50:46 +0100
In-Reply-To: <20240318144225.30835-3-brnkv.i1@gmail.com>
References: <20240318144225.30835-1-brnkv.i1@gmail.com>
	 <20240318144225.30835-3-brnkv.i1@gmail.com>
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

Hi Ivan,

On Mo, 2024-03-18 at 17:42 +0300, Ivan Bornyakov wrote:
> Add initial support for optional reset lines. For now, simply deassert
> resets on driver probe and assert them back on driver remove.
>=20
> Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
> ---
>  .../media/platform/chips-media/wave5/wave5-vpu.c    | 13 +++++++++++++
>  .../media/platform/chips-media/wave5/wave5-vpuapi.h |  1 +
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drive=
rs/media/platform/chips-media/wave5/wave5-vpu.c
> index 1b3df5b04249..f3ecadefd37a 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> @@ -10,6 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/firmware.h>
>  #include <linux/interrupt.h>
> +#include <linux/reset.h>
>  #include "wave5-vpu.h"
>  #include "wave5-regdefine.h"
>  #include "wave5-vpuconfig.h"
> @@ -151,6 +152,17 @@ static int wave5_vpu_probe(struct platform_device *p=
dev)
>  	dev_set_drvdata(&pdev->dev, dev);
>  	dev->dev =3D &pdev->dev;
> =20
> +	dev->resets =3D devm_reset_control_array_get_optional_exclusive(&pdev->=
dev);
> +	if (IS_ERR(dev->resets)) {
> +		return dev_err_probe(&pdev->dev, PTR_ERR(dev->resets),
> +				     "Failed to get reset control\n");
> +	} else {
> +		ret =3D reset_control_deassert(dev->resets);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "Failed to deassert resets\n");

This doesn't have to be in an else block, the error path above returns.

> +	}
> +
>  	ret =3D devm_clk_bulk_get_all(&pdev->dev, &dev->clks);

I'd expect the reset control to be asserted in the error path.


regards
Philipp

