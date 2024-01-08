Return-Path: <linux-kernel+bounces-19320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C190826B5F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6BD1C2200A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC3313ADD;
	Mon,  8 Jan 2024 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KxIykQWJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C84134AC;
	Mon,  8 Jan 2024 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704708748;
	bh=CUvDS7z0vaI7dKOLj6bDMDn82Ts3BKg1N9K5vuqjjVo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KxIykQWJv9qPHoTN685bsqx/ZvJpaW5HT8TW6IaaeOu3furkgK8e+B7jfcScu7RSA
	 EKmbZB1w5OdbHcw3FqdgvDKlVGt/6bNy5MsdggYfaxC7F6HZVnmSng1QvKSb6DetyC
	 WjPLWzFktbECWAJ63+a8AE8pCwxu9BvHzEihqqJZAbToHzCMzyyI3fyjI5UHKqeuhc
	 JjjSb+q66rQ51PdjzYsbrceEC4Z8vCdg5Z/oAsHOi95POXNHNl7cViQc2QxzkSObYu
	 4C6IG/dcUKEONXLAl5o3gaF2EAmF9xK3Yy7DpswnX19IqcoSC5barSp7J7pYath7rw
	 BHyJS4FCMYgVw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A4CDC3780625;
	Mon,  8 Jan 2024 10:12:27 +0000 (UTC)
Message-ID: <717a21bb-de39-4f7d-913c-f2a20d8b02bd@collabora.com>
Date: Mon, 8 Jan 2024 11:12:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] clk: mediatek: add infracfg reset controller for
 mt7988
Content-Language: en-US
To: Frank Wunderlich <linux@fw-web.de>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 Sam Shih <sam.shih@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20240105162056.43266-1-linux@fw-web.de>
 <20240105162056.43266-3-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240105162056.43266-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 05/01/24 17:20, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Infracfg can also operate as reset controller, add support for it.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   drivers/clk/mediatek/clk-mt7988-infracfg.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-mt7988-infracfg.c b/drivers/clk/mediatek/clk-mt7988-infracfg.c
> index 8011ef278bea..1660a45349ff 100644
> --- a/drivers/clk/mediatek/clk-mt7988-infracfg.c
> +++ b/drivers/clk/mediatek/clk-mt7988-infracfg.c
> @@ -14,6 +14,9 @@
>   #include "clk-gate.h"
>   #include "clk-mux.h"
>   #include <dt-bindings/clock/mediatek,mt7988-clk.h>
> +#include <dt-bindings/reset/mediatek,mt7988-resets.h>
> +
> +#define	INFRA_RST_SET_OFFSET	0x80
>   
>   static DEFINE_SPINLOCK(mt7988_clk_lock);
>   
> @@ -249,12 +252,29 @@ static const struct mtk_gate infra_clks[] = {
>   	GATE_INFRA3(CLK_INFRA_133M_PCIE_CK_P3, "infra_133m_pcie_ck_p3", "sysaxi_sel", 31),
>   };
>   
> +static u16 infra_rst_ofs[] = {
> +	INFRA_RST_SET_OFFSET,
> +};
> +
> +static u16 infra_idx_map[] = {
> +	[MT7988_INFRA_RST0_THERM_CTRL_SWRST] = 0 * RST_NR_PER_BANK + 9,

The MT7988A datasheet says that INFRA_RST0 bit 9 is CONN2EMI_M0_GALS_SLV_SWRST, so
this is wrong: THERM_CTRL_SWRST is in the RST1 register, bit 9.

Also, I'm sure that you really want to add the PCIe MAC reset bit as well, to be
used with the PCIe driver...

[MT7988_INFRA_RST0_PEXTP_MAC_SWRST] = 0 * RST_NR_PER_BANK + 6,
[MT7988_INFRA_RST1_THERM_CTRL_SWRST] = 1 * RST_NR_PER_BANK + 9,

Enjoy... :-)

Cheers,
Angelo


