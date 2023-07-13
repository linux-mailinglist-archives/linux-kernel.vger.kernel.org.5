Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5D2751671
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 04:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjGMCrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 22:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjGMCra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 22:47:30 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD36F10EC;
        Wed, 12 Jul 2023 19:47:29 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qJmMS-0005h4-3D;
        Thu, 13 Jul 2023 02:47:22 +0000
Date:   Thu, 13 Jul 2023 03:47:08 +0100
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
Subject: Re: [PATCH 2/2] wifi: mt76: add support for providing eeprom in
 nvmem cells
Message-ID: <ZK9lrJMD8mqHdWrH@makrotopia.org>
References: <20230708182936.24469-1-ansuelsmth@gmail.com>
 <20230708182936.24469-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230708182936.24469-2-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 08:29:36PM +0200, Christian Marangi wrote:
> Add support for providing eeprom in nvmem cells by adding nvmem cell as
> an alternative source for mt76_get_of_eeprom().
> 
> Nvmem cells will follow standard nvmem cell definition and needs to be
> called 'eeprom' to be correctly identified.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Tested-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  drivers/net/wireless/mediatek/mt76/eeprom.c | 38 ++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
> index c3a762074be8..36564930aef1 100644
> --- a/drivers/net/wireless/mediatek/mt76/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
> @@ -6,6 +6,7 @@
>  #include <linux/of_net.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/etherdevice.h>
>  #include "mt76.h"
>  
> @@ -105,6 +106,37 @@ static int mt76_get_of_epprom_from_mtd(struct mt76_dev *dev, void *eep, int offs
>  #endif
>  }
>  
> +static int mt76_get_of_epprom_from_nvmem(struct mt76_dev *dev, void *eep, int len)
> +{
> +	struct device_node *np = dev->dev->of_node;
> +	struct nvmem_cell *cell;
> +	const void *data;
> +	size_t retlen;
> +	int ret = 0;
> +
> +	cell = of_nvmem_cell_get(np, "eeprom");
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	data = nvmem_cell_read(cell, &retlen);
> +	nvmem_cell_put(cell);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	if (retlen < len) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	memcpy(eep, data, len);
> +
> +exit:
> +	kfree(data);
> +
> +	return ret;
> +}
> +
>  int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
>  {
>  	struct device_node *np = dev->dev->of_node;
> @@ -117,7 +149,11 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
>  	if (!ret)
>  		return 0;
>  
> -	return mt76_get_of_epprom_from_mtd(dev, eep, offset, len);
> +	ret = mt76_get_of_epprom_from_mtd(dev, eep, offset, len);
> +	if (!ret)
> +		return 0;
> +
> +	return mt76_get_of_epprom_from_nvmem(dev, eep, len);
>  }
>  EXPORT_SYMBOL_GPL(mt76_get_of_eeprom);
>  
> -- 
> 2.40.1
> 
> 
