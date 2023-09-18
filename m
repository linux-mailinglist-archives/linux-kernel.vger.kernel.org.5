Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCCF7A53BD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjIRUQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRUQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:16:15 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30008118
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:16:08 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id iKf5q22uye2oZiKf6qefCq; Mon, 18 Sep 2023 22:16:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695068165;
        bh=oteOYinY96sYKpsCTLEZtYYk6TSB+1fIxVTYQrzuetw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=hx0DZRp+EEAKHbCyNJBXIo5Ca/0HssLB1W4kgdMbsv/90SpK9vEKQDB4MkxOOyx8U
         k9pyYZhmdsjqCFZjBeWp9g4H0of0PpEXLzfDS7gbBWCqAqi2dXQmUZ9dAVDHbAs/Sd
         82PPGqycSqDvJQmQR5Ag22Ag/TtoXVDGBgTdaeorgtCVRj6GB5HokNvwe832XxurHR
         8Z+7YqwhCezGcdbF1czmQKQ1h8L+eFiq0UVdBGMGaeFva3/DcaJtTbq1x2/wC2ldQI
         BJB4BXqE6GMXSljT+jFdLw9GJ8m26cJxDldDHyZtA6Hvs6s764bSjcXk/UmKSx4rtD
         C7Rp/E74y/0Ng==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 18 Sep 2023 22:16:05 +0200
X-ME-IP: 86.243.2.178
Message-ID: <aefe3865-dcd1-54c8-d9d6-446af31c73d3@wanadoo.fr>
Date:   Mon, 18 Sep 2023 22:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/3] soc: mediatek: mtk-socinfo: Add driver for getting
 chip information
Content-Language: fr
To:     william-tw.lin@mediatek.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, khilman@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org
References: <20230915152607.18116-1-william-tw.lin@mediatek.com>
 <20230915152607.18116-3-william-tw.lin@mediatek.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230915152607.18116-3-william-tw.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 15/09/2023 à 17:26, William-tw Lin a écrit :
> Add driver for socinfo retrieval. This patch includes the following:
> 1. mtk-socinfo driver for chip info retrieval
> 2. Related changes to Makefile and Kconfig
> 
> Signed-off-by: William-tw Lin <william-tw.lin-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---

...

> +static int mtk_socinfo_create_socinfo_node(struct mtk_socinfo *mtk_socinfop)
> +{
> +	struct soc_device_attribute *attrs;
> +	static char machine[30] = {0};
> +
> +	attrs = devm_kzalloc(mtk_socinfop->dev, sizeof(*attrs), GFP_KERNEL);
> +	if (!attrs)
> +		return -ENOMEM;
> +
> +	snprintf(machine, 30, "%s (%s)", mtk_socinfop->socinfo_data->marketing_name,

sizeof(machine) instead of 30?

> +		mtk_socinfop->socinfo_data->soc_name);
> +	attrs->family = soc_manufacturer;
> +	attrs->machine = machine;
> +
> +	soc_dev = soc_device_register(attrs);
> +	if (IS_ERR(soc_dev))
> +		return PTR_ERR(soc_dev);
> +
> +	dev_info(mtk_socinfop->dev, "%s SoC detected.\n", attrs->machine);
> +	return 0;
> +}
> +
> +static int mtk_socinfo_get_socinfo_data(struct mtk_socinfo *mtk_socinfop)
> +{
> +	unsigned int i = 0, j = 0;

No need to init.

> +	unsigned int num_cell_data = 0;
> +	u32 *cell_datap[MAX_CELLS] = { NULL };
> +	size_t efuse_bytes;
> +	struct nvmem_cell *cell;
> +	bool match_socinfo = true;

No need to init.

> +	int match_socinfo_index = -1;
> +
> +	for (i = 0; i < MAX_CELLS; i++) {
> +		cell = nvmem_cell_get(mtk_socinfop->dev, cell_names[i]);
> +		if (IS_ERR_OR_NULL(cell))

I don't think that testing for NULL is needed.

> +			break;
> +		cell_datap[i] = (u32 *)nvmem_cell_read(cell, &efuse_bytes);
> +		nvmem_cell_put(cell);
> +		num_cell_data++;
> +	}
> +
> +	if (!num_cell_data)
> +		return -ENOENT;
> +
> +	for (i = 0; i < ARRAY_SIZE(socinfo_data_table); i++) {
> +		match_socinfo = true;
> +		for (j = 0; j < num_cell_data; j++) {
> +			if (*(cell_datap[j]) != socinfo_data_table[i].cell_data[j])
> +				match_socinfo = false;

I think that a "break" could be added.

> +		}
> +		if (num_cell_data > 0 && match_socinfo) {

This test can be simplified, becasue 'num_cell_data' can't be <= 0. It 
is an unsigned int, and we return -ENOENT if it is zero.

> +			mtk_socinfop->socinfo_data = &(socinfo_data_table[i]);
> +			match_socinfo_index = i;
> +			break;
> +		}
> +	}
> +
> +	return match_socinfo_index >= 0 ? match_socinfo_index : -ENOENT;
> +}
> +
> +static const struct of_device_id mtk_socinfo_id_table[] = {
> +	{ .compatible = "mediatek,socinfo" },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, mtk_socinfo_id_table);
> +
> +static int mtk_socinfo_probe(struct platform_device *pdev)
> +{
> +	struct mtk_socinfo *mtk_socinfop;
> +	int ret = 0;

No need to init.

> +
> +	mtk_socinfop = devm_kzalloc(&pdev->dev, sizeof(*mtk_socinfop), GFP_KERNEL);
> +	if (!mtk_socinfop)
> +		return -ENOMEM;
> +
> +	mtk_socinfop->dev = &pdev->dev;
> +
> +	ret = mtk_socinfo_get_socinfo_data(mtk_socinfop);
> +	if (ret < 0)
> +		return dev_err_probe(mtk_socinfop->dev, ret, "Failed to get socinfo data\n");
> +
> +	ret = mtk_socinfo_create_socinfo_node(mtk_socinfop);
> +	if (ret != 0)
> +		return dev_err_probe(mtk_socinfop->dev, -EINVAL, "Failed to create socinfo node\n");

Why not propagating 'ret'?

CJ

> +
> +	return 0;
> +}

...

