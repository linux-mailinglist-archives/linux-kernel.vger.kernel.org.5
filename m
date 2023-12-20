Return-Path: <linux-kernel+bounces-6777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B80B819D64
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28E51C20F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E4420DDD;
	Wed, 20 Dec 2023 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vkBmQruw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BBD20B1C;
	Wed, 20 Dec 2023 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703069603;
	bh=0wM6NyIYfWx3GSl8Kay+3vfdMz3CT7HUYXvuXwJK47Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vkBmQruw2EZdYOqARFcL+ugM0MlOmpY0fyvpp6IOKlTDg1ArOZp4RjMs7N984koTr
	 7v02x3UYEGBX7Nbo0cLlKJtIWe5uaLpXAYwFfRkGEIXmR0jPof8U1x/RVEmgygHMWi
	 baqcjXQm5NvfACedg/Jz2EYYx3TKiGQqo4+QP6w0MhIaq6YlYWGw9lvq1rNjjp/xmU
	 xtlXkDXDw9cqg4gFOeUDv5bjBoFvW3YlHimcbGOed5k//uGcXkAvSu1zbpRajQZY2/
	 Quf3tPADJ8moAGmHd30mk451URTfCpxkhm2SCqeI1O/lLGXMCQdkSui/RzajLD3WTp
	 GRZd1txjf43uQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7A80B3781FC8;
	Wed, 20 Dec 2023 10:53:22 +0000 (UTC)
Message-ID: <508c9b5a-61d9-4e42-8faa-c6f48f453235@collabora.com>
Date: Wed, 20 Dec 2023 11:53:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] soc: mediatek: mtk-socinfo: Add driver for getting
 chip information
Content-Language: en-US
To: William-tw Lin <william-tw.lin@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20231220103901.22180-1-william-tw.lin@mediatek.com>
 <20231220103901.22180-3-william-tw.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231220103901.22180-3-william-tw.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/12/23 11:39, William-tw Lin ha scritto:
> Add driver for socinfo retrieval. This patch includes the following:
> 1. mtk-socinfo driver for chip info retrieval
> 2. Related changes to Makefile and Kconfig
> 
> Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
> ---
>   drivers/soc/mediatek/Kconfig       |   8 ++
>   drivers/soc/mediatek/Makefile      |   1 +
>   drivers/soc/mediatek/mtk-socinfo.c | 186 +++++++++++++++++++++++++++++
>   3 files changed, 195 insertions(+)
>   create mode 100644 drivers/soc/mediatek/mtk-socinfo.c
> 
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 0810b5b0c688..f34d93977ba6 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -68,4 +68,12 @@ config MTK_SVS
>   	  chip process corner, temperatures and other factors. Then DVFS
>   	  driver could apply SVS bank voltage to PMIC/Buck.
>   
> +config MTK_SOCINFO
> +	tristate "MediaTek SoC Information"
> +	default y

Add the dependency please.

	depends on NVMEM_MTK_EFUSE

> +	help
> +	  The MediaTek SoC Information (mtk-socinfo) driver provides
> +	  information about the SoC to the userspace including the
> +	  manufacturer name, marketing name and soc name.
> +
>   endmenu
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 9d3ce7878c5c..6830512848fd 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_MTK_REGULATOR_COUPLER) += mtk-regulator-coupler.o
>   obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
>   obj-$(CONFIG_MTK_MMSYS) += mtk-mutex.o
>   obj-$(CONFIG_MTK_SVS) += mtk-svs.o
> +obj-$(CONFIG_MTK_SOCINFO) += mtk-socinfo.o
> diff --git a/drivers/soc/mediatek/mtk-socinfo.c b/drivers/soc/mediatek/mtk-socinfo.c
> new file mode 100644
> index 000000000000..4a257b5c8eda
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-socinfo.c
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/device.h>
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
> +#include <linux/string.h>
> +#include <linux/sys_soc.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +
> +#define MTK_SOCINFO_ENTRY(_soc_name, _segment_name, _marketing_name, _cell_data1, _cell_data2) {\
> +	.soc_name = _soc_name,									\
> +	.segment_name = _segment_name,								\
> +	.marketing_name = _marketing_name,							\
> +	.cell_data = {_cell_data1, _cell_data2}							\
> +}
> +#define CELL_NOT_USED (0xFFFFFFFF)
> +#define MAX_CELLS (2)
> +
> +struct mtk_socinfo {
> +	struct device *dev;
> +	struct name_data *name_data;
> +	struct socinfo_data *socinfo_data;
> +	struct soc_device *soc_dev;
> +};
> +
> +struct socinfo_data {
> +	char *soc_name;
> +	char *segment_name;
> +	char *marketing_name;
> +	u32 cell_data[MAX_CELLS];
> +};
> +
> +static const char *cell_names[MAX_CELLS] = {"socinfo-data1", "socinfo-data2"};
> +
> +static struct socinfo_data socinfo_data_table[] = {
> +	MTK_SOCINFO_ENTRY("MT8173", "MT8173V/AC", "MT8173", 0x6CA20004, 0x10000000),
> +	MTK_SOCINFO_ENTRY("MT8183", "MT8183V/AZA", "Kompanio 500", 0x00010043, 0x00000840),
> +	MTK_SOCINFO_ENTRY("MT8186", "MT8186GV/AZA", "Kompanio 520", 0x81861001, CELL_NOT_USED),
> +	MTK_SOCINFO_ENTRY("MT8186T", "MT8186TV/AZA", "Kompanio 528", 0x81862001, CELL_NOT_USED),
> +	MTK_SOCINFO_ENTRY("MT8188", "MT8188GV/AZA", "Kompanio 830", 0x81880000, 0x00000010),
> +	MTK_SOCINFO_ENTRY("MT8188", "MT8188GV/HZA", "Kompanio 830", 0x81880000, 0x00000011),
> +	MTK_SOCINFO_ENTRY("MT8192", "MT8192V/AZA", "Kompanio 820", 0x00001100, 0x00040080),
> +	MTK_SOCINFO_ENTRY("MT8192T", "MT8192V/ATZA", "Kompanio 828", 0x00000100, 0x000400C0),
> +	MTK_SOCINFO_ENTRY("MT8195", "MT8195GV/EZA", "Kompanio 1200", 0x81950300, CELL_NOT_USED),
> +	MTK_SOCINFO_ENTRY("MT8195", "MT8195GV/EHZA", "Kompanio 1200", 0x81950304, CELL_NOT_USED),
> +	MTK_SOCINFO_ENTRY("MT8195", "MT8195TV/EZA", "Kompanio 1380", 0x81950400, CELL_NOT_USED),
> +	MTK_SOCINFO_ENTRY("MT8195", "MT8195TV/EHZA", "Kompanio 1380", 0x81950404, CELL_NOT_USED),
> +};
> +
> +static int mtk_socinfo_create_socinfo_node(struct mtk_socinfo *mtk_socinfop)
> +{
> +	struct soc_device_attribute *attrs;
> +	static char machine[30] = {0};
> +	static const char *soc_manufacturer = "MediaTek";
> +
> +	attrs = devm_kzalloc(mtk_socinfop->dev, sizeof(*attrs), GFP_KERNEL);
> +	if (!attrs)
> +		return -ENOMEM;
> +
> +	snprintf(machine, sizeof(machine), "%s (%s)", mtk_socinfop->socinfo_data->marketing_name,
> +		mtk_socinfop->socinfo_data->soc_name);
> +	attrs->family = soc_manufacturer;
> +	attrs->machine = machine;
> +
> +	mtk_socinfop->soc_dev = soc_device_register(attrs);
> +	if (IS_ERR(mtk_socinfop->soc_dev))
> +		return PTR_ERR(mtk_socinfop->soc_dev);
> +
> +	dev_info(mtk_socinfop->dev, "%s %s SoC detected.\n", soc_manufacturer, attrs->machine);
> +	return 0;
> +}
> +
> +static u32 mtk_socinfo_read_cell(struct device *dev, const char *name)
> +{
> +	struct nvmem_device *nvmemp;
> +	struct device_node *np = dev->of_node;
> +	u32 offset;
> +	u32 cell_val = CELL_NOT_USED;
> +
> +	nvmemp = devm_nvmem_device_get(dev, "mtk-efuse0");

Are you sure that this is supposed to be "mtk-efuse0" and not "mtk-efuse"?
Looks strange.

Everything else looks ok.

Cheers,
Angelo



