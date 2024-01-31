Return-Path: <linux-kernel+bounces-45763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64908435F5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615DB28A647
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA433D56E;
	Wed, 31 Jan 2024 05:17:31 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D073DB92;
	Wed, 31 Jan 2024 05:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706678251; cv=none; b=ScZI5rwhpqSq6+1bAvk12Kn1RGv8hyX92Nyzc3FkFIJATWH7WTUwhrdh7Zfzmd1WWVKNJ9SFIYWHeeA2kJG/wb2HL3W15K3za1pu4GdrQxjcyOM3Folc3kKXzPj+8BAFmI1k9UFYtl04nTzmApIfIXGuHSJoj6oNLEWWAFh8G+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706678251; c=relaxed/simple;
	bh=gxAtGaUULQtWAZGfYG0oHdCtKw5TMqoELHvZxCqaRyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArNadrt0jnv7nayYqhYZbE2uV0NY+rvwaX8q8BYeoAUoSBpbeIVM2upHBEA/73TqKxPWsMNqr8hEk5lpKQSX1q4rDlwOcchcXFpkfN7X3+cygLmfuWXBWKMuo55sCaT01gzI4q+Je5ReNmqnKKEbwCzB3hA2EdyNTtmuORJ+1HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rV2yM-0001i0-0l;
	Wed, 31 Jan 2024 05:17:18 +0000
Date: Wed, 31 Jan 2024 05:17:14 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Frank Wunderlich <linux@fw-web.de>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Amit Kucheria <amitk@kernel.org>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] thermal/drivers/mediatek: Fix control buffer enablement
 on MT7896
Message-ID: <ZbnX2vfcalNL3yRV@makrotopia.org>
References: <20230907112018.52811-1-linux@fw-web.de>
 <20230913083529.3bgjl6rvfmixgjnd@blmsp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913083529.3bgjl6rvfmixgjnd@blmsp>

Hi everyone!

On Wed, Sep 13, 2023 at 10:35:29AM +0200, Markus Schneider-Pargmann wrote:
> On Thu, Sep 07, 2023 at 01:20:18PM +0200, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> > 
> > Reading thermal sensor on mt7986 devices returns invalid temperature:
> > 
> > bpi-r3 ~ # cat /sys/class/thermal/thermal_zone0/temp
> >  -274000
> > 
> > Fix this by adding missing members in mtk_thermal_data struct which were
> > used in mtk_thermal_turn_on_buffer after commit 33140e668b10.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 33140e668b10 ("thermal/drivers/mediatek: Control buffer enablement tweaks")
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> 
> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Tested-by: Daniel Golle <daniel@makrotopia.org>

Kind ping to thermal and mediatek maintainers, please merge this patch.

https://patchwork.kernel.org/project/linux-pm/patch/20230907112018.52811-1-linux@fw-web.de/

https://patchwork.kernel.org/project/linux-mediatek/patch/20230907112018.52811-1-linux@fw-web.de/

> 
> Thanks for fixing!
> 
> Best,
> Markus
> 
> > ---
> >  drivers/thermal/mediatek/auxadc_thermal.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
> > index 843214d30bd8..967b9a1aead4 100644
> > --- a/drivers/thermal/mediatek/auxadc_thermal.c
> > +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> > @@ -690,6 +690,9 @@ static const struct mtk_thermal_data mt7986_thermal_data = {
> >  	.adcpnp = mt7986_adcpnp,
> >  	.sensor_mux_values = mt7986_mux_values,
> >  	.version = MTK_THERMAL_V3,
> > +	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
> > +	.apmixed_buffer_ctl_mask = GENMASK(31, 6) | BIT(3),
> > +	.apmixed_buffer_ctl_set = BIT(0),
> >  };
> >  
> >  static bool mtk_thermal_temp_is_valid(int temp)
> > -- 
> > 2.34.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

