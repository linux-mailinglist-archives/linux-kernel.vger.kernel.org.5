Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF55675166E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 04:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjGMCqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 22:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjGMCqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 22:46:53 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2AEC2;
        Wed, 12 Jul 2023 19:46:52 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qJmLp-0005gV-2Y;
        Thu, 13 Jul 2023 02:46:42 +0000
Date:   Thu, 13 Jul 2023 03:46:30 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] wifi: mt76: split get_of_eeprom in subfunction
Message-ID: <ZK9lhgH_sNmX3hWb@makrotopia.org>
References: <20230708182936.24469-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230708182936.24469-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 08:29:35PM +0200, Christian Marangi wrote:
> In preparation for NVMEM support, split get_of_eeprom() in subfunction
> to tidy the code and facilitate the addition of alternative method to
> get eeprom data. No behaviour change intended.
> 
> While at it also drop OF ifdef checks as OF have stubs and calling
> of_get_property would result in the same error returned.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Tested-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  drivers/net/wireless/mediatek/mt76/eeprom.c | 51 ++++++++++++++-------
>  1 file changed, 35 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
> index dce851d42e08..c3a762074be8 100644
> --- a/drivers/net/wireless/mediatek/mt76/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
> @@ -9,31 +9,35 @@
>  #include <linux/etherdevice.h>
>  #include "mt76.h"
>  
> -int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
> +static int mt76_get_of_eeprom_data(struct mt76_dev *dev, void *eep, int len)
>  {
> -#if defined(CONFIG_OF) && defined(CONFIG_MTD)
>  	struct device_node *np = dev->dev->of_node;
> -	struct mtd_info *mtd;
> -	const __be32 *list;
>  	const void *data;
> -	const char *part;
> -	phandle phandle;
>  	int size;
> -	size_t retlen;
> -	int ret;
>  
> -	if (!np)
> +	data = of_get_property(np, "mediatek,eeprom-data", &size);
> +	if (!data)
>  		return -ENOENT;
>  
> -	data = of_get_property(np, "mediatek,eeprom-data", &size);
> -	if (data) {
> -		if (size > len)
> -			return -EINVAL;
> +	if (size > len)
> +		return -EINVAL;
>  
> -		memcpy(eep, data, size);
> +	memcpy(eep, data, size);
>  
> -		return 0;
> -	}
> +	return 0;
> +}
> +
> +static int mt76_get_of_epprom_from_mtd(struct mt76_dev *dev, void *eep, int offset, int len)
> +{
> +#ifdef CONFIG_MTD
> +	struct device_node *np = dev->dev->of_node;
> +	struct mtd_info *mtd;
> +	const __be32 *list;
> +	const char *part;
> +	phandle phandle;
> +	size_t retlen;
> +	int size;
> +	int ret;
>  
>  	list = of_get_property(np, "mediatek,mtd-eeprom", &size);
>  	if (!list)
> @@ -100,6 +104,21 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
>  	return -ENOENT;
>  #endif
>  }
> +
> +int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
> +{
> +	struct device_node *np = dev->dev->of_node;
> +	int ret;
> +
> +	if (!np)
> +		return -ENOENT;
> +
> +	ret = mt76_get_of_eeprom_data(dev, eep, len);
> +	if (!ret)
> +		return 0;
> +
> +	return mt76_get_of_epprom_from_mtd(dev, eep, offset, len);
> +}
>  EXPORT_SYMBOL_GPL(mt76_get_of_eeprom);
>  
>  void
> -- 
> 2.40.1
> 
> 
