Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70D580433C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343670AbjLEAXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjLEAXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:23:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364FDAC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 16:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701735803; x=1733271803;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w95JQcmtzycZwBcoMZgZhon7cdRK0krIC+7XiugEAH0=;
  b=g+3Xi8pJoq8ByXznm4jpb/2byIkchFIvnr6/PkC2l3cR4eiZ9cyfNL0x
   9GRK1VvFK6EHiZkyYxDDDsXKapz5krrqA0yB6RPzZA5gngrryHKqWaoRe
   P2d7yE1wxpRlnJIItX0ZDzRT347/nRfksvs/vJq0jwDAfgCDoQUQ7EVkv
   IewoFUPpknes61tTQqkmp2RfT1un7sIeeAlQ9kE3y53IFuxDA7elwXqvu
   XOnTcITWACqmU2RZC7UPjXKv9gxGKm1gJMlpTYPniI590GdI0c7AFs9vC
   72ESAuB47QCKgeBKwAFlish1RCUd3d95TxmKVGBhMZzl9BFanWvJ7Kzc7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="691536"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="691536"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:23:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="720499134"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="720499134"
Received: from akashams-mobl.amr.corp.intel.com (HELO [10.255.231.189]) ([10.255.231.189])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:23:21 -0800
Message-ID: <7a919eef-d9b4-4bcb-bc19-9a6868d1cc54@linux.intel.com>
Date:   Mon, 4 Dec 2023 18:05:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoc: tas2563: DSP Firmware loading support
Content-Language: en-US
To:     Gergo Koteles <soyer@irl.hu>, Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Dan Murphy <dmurphy@ti.com>
References: <cover.1701733441.git.soyer@irl.hu>
 <c7d0fc477393550cc29624f33361d94ad987259f.1701733441.git.soyer@irl.hu>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <c7d0fc477393550cc29624f33361d94ad987259f.1701733441.git.soyer@irl.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Firmware loading is done dymacally and the program and configuration

dynamically

> selection is done by the user.
> 
> The binary itself contains a list of instructions for either a single
> mode write or a burst write.  The single mode write is list of register
> writes to different books and pages within the register map.
> The burst writes is a block of data that is written to a specific
> location in memory.
> 
> The firmware loader must parse and load the blocks in real time as the
> binary may contain different audio profiles.
> 
> If the DSP is not needed to do audio preocessing then the DSP program

preprocessing

> can be turned off and the device will effectively turn off the DSP.

> ---
>  {sound/soc/codecs => include/sound}/tas2562.h |   3 +
>  include/sound/tas25xx-dsp.h                   | 100 +++++++
>  sound/soc/codecs/Kconfig                      |   7 +
>  sound/soc/codecs/Makefile                     |   2 +
>  sound/soc/codecs/tas2562.c                    |   2 +-

are tas2562 and tas2563 (from commit subject) the same?

>  sound/soc/codecs/tas25xx-dsp.c                | 282 ++++++++++++++++++
>  6 files changed, 395 insertions(+), 1 deletion(-)
>  rename {sound/soc/codecs => include/sound}/tas2562.h (97%)
>  create mode 100644 include/sound/tas25xx-dsp.h
>  create mode 100644 sound/soc/codecs/tas25xx-dsp.c
> 
> diff --git a/sound/soc/codecs/tas2562.h b/include/sound/tas2562.h
> similarity index 97%
> rename from sound/soc/codecs/tas2562.h
> rename to include/sound/tas2562.h

> diff --git a/sound/soc/codecs/tas25xx-dsp.c b/sound/soc/codecs/tas25xx-dsp.c
> new file mode 100644
> index 000000000000..d5081fa01441
> --- /dev/null
> +++ b/sound/soc/codecs/tas25xx-dsp.c
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Firmware loader for the Texas Instruments TAS25XX DSP
> +// Copyright (C) 2020 Texas Instruments Inc.
> +
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/device.h>
> +#include <linux/firmware.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>

nit-pick: alphabetical order?

> +
> +#include <sound/tas2562.h>
> +#include <sound/tas25xx-dsp.h>
> +
> +
> +static void tas25xx_process_fw_delay(struct tas25xx_cmd *cmd)
> +{
> +	mdelay(cpu_to_be16(cmd->hdr.length));

is this the length of the header, or the duration of the delay?

Someone will get it wrong with this naming...

> +}
> +
> +static int tas25xx_process_fw_single(struct regmap *regmap,
> +	struct tas25xx_cmd *cmd)
> +{
> +	int ret;
> +	int num_writes = cpu_to_be16(cmd->hdr.length);
> +	struct tas25xx_cmd_reg *reg = &cmd->reg;

reverse x-mas style recommended, e.g. move 'int ret;' last

> +
> +	for (int i = 0; i < num_writes; i++, reg++) {
> +		/* Reset Page to 0 to access BOOK_CTRL */
> +		ret = regmap_write(regmap, TAS2562_PAGE_CTRL, 0);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(regmap, TAS2562_BOOK_CTRL, reg->book);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(regmap, TAS2562_REG(reg->page, reg->offset),
> +			reg->data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tas25xx_process_fw_burst(struct regmap *regmap,
> +	struct tas25xx_cmd *cmd)
> +{
> +	int ret;
> +
> +	/* Reset Page to 0 to access BOOK_CTRL */
> +	ret = regmap_write(regmap, TAS2562_PAGE_CTRL, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(regmap, TAS2562_BOOK_CTRL, cmd->reg.book);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_write(regmap, TAS2562_REG(cmd->reg.page, cmd->reg.offset), &cmd[1],
> +				cpu_to_be16(cmd->hdr.length));
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int tas25xx_process_block(struct device *dev, struct regmap *regmap,
> +	struct tas25xx_cmd *cmd, int max_block_size)
> +{
> +	int ret;
> +	int block_read;
> +
> +	const int hdr_size = sizeof(struct tas25xx_cmd_hdr);
> +	const int reg_size = sizeof(struct tas25xx_cmd_reg);
> +	const int cmd_size = sizeof(struct tas25xx_cmd);
> +
> +	switch (cpu_to_be16(cmd->hdr.cmd_type)) {
> +	case TAS25XX_CMD_SING_W:
> +		block_read = cpu_to_be16(cmd->hdr.length) * reg_size + hdr_size;
> +		break;
> +	case TAS25XX_CMD_BURST:
> +		block_read = cpu_to_be16(cmd->hdr.length) + cmd_size;
> +		break;
> +	case TAS25XX_CMD_DELAY:
> +		block_read = 4;
> +		break;
> +	default:
> +		block_read = 0;
> +	}
> +
> +	if (block_read > max_block_size) {
> +		dev_err(dev,
> +			"Corrupt firmware: block_read > max_block_size %d %d\n",
> +			block_read, max_block_size);
> +		return -EINVAL;
> +	}
> +
> +	switch (cpu_to_be16(cmd->hdr.cmd_type)) {
> +	case TAS25XX_CMD_SING_W:
> +		ret = tas25xx_process_fw_single(regmap, cmd);
> +		if (ret) {
> +			dev_err(dev, "Failed to process single write %d\n",
> +				ret);
> +			return ret;
> +		}
> +		break;
> +	case TAS25XX_CMD_BURST:
> +		ret = tas25xx_process_fw_burst(regmap, cmd);
> +		if (ret) {
> +			dev_err(dev, "Failed to process burst write %d\n", ret);
> +			return ret;
> +		}
> +		break;
> +	case TAS25XX_CMD_DELAY:
> +		tas25xx_process_fw_delay(cmd);
> +		break;
> +	default:
> +		dev_warn(dev, "Unknown cmd type %d\n",
> +			cpu_to_be16(cmd->hdr.cmd_type));
> +		break;
> +	};
> +
> +	return block_read;
> +}
> +
> +
> +int tas25xx_write_program(struct device *dev, struct regmap *regmap,
> +	struct tas25xx_fw_data *fw_data, int prog_num)
> +{
> +	int offset = 0;
> +	int length = 0;

useless init

> +	struct tas25xx_program_info *prog_info;
> +	struct tas25xx_fw_hdr *hdr = fw_data->hdr;
> +	struct tas25xx_cmd *cmd;

again reverse x-mas style would look much better

> +
> +	if (prog_num > cpu_to_be32(hdr->num_programs))
> +		return -EINVAL;
> +
> +	for (int i = 0; i < prog_num; i++)
> +		offset += cpu_to_be32(hdr->prog_size[i]);
> +
> +	prog_info = (struct tas25xx_program_info *)&fw_data->prog_data[offset];
> +	dev_info(dev, "Write program %d: %s\n", prog_num, prog_info->name);
> +
> +	int max_offset = offset + cpu_to_be32(hdr->prog_size[prog_num]);
> +	int num_subblocks = cpu_to_be32(prog_info->blk_data.num_subblocks);

It's not illegal but not consistent to declare variables in the middle
of code for no good reason.

> +	offset += sizeof(struct tas25xx_program_info);
> +
> +	for (int i = 0; i < num_subblocks; i++) {
> +		cmd = (struct tas25xx_cmd *)&fw_data->prog_data[offset];
> +		length = tas25xx_process_block(dev, regmap, cmd,
> +			max_offset - offset);
> +		if (length < 0)
> +			return length;
> +
> +		offset += length;
> +	}
> +
> +	/* Reset Book to 0 */
> +	regmap_write(regmap, TAS2562_PAGE_CTRL, 0);
> +	regmap_write(regmap, TAS2562_BOOK_CTRL, 0);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tas25xx_write_program);
> +
> +int tas25xx_write_config(struct device *dev, struct regmap *regmap,
> +	struct tas25xx_fw_data *fw_data, int config_num)
> +{
> +	int offset = 0;
> +	int length = 0;

useless init again

> +	struct tas25xx_config_info *cfg_info;
> +	struct tas25xx_fw_hdr *hdr = fw_data->hdr;
> +	struct tas25xx_cmd *cmd;
> +
> +	if (config_num > cpu_to_be32(hdr->num_configs))
> +		return -EINVAL;
> +
> +	for (int i = 0; i < config_num; i++)
> +		offset += cpu_to_be32(hdr->config_size[i]);
> +
> +	cfg_info = (struct tas25xx_config_info *)&fw_data->config_data[offset];
> +	dev_info(dev, "Write config %d: %s\n", config_num, cfg_info->name);
> +
> +	int max_offset = offset + cpu_to_be32(hdr->config_size[config_num]);
> +	int num_subblocks = cpu_to_be32(cfg_info->blk_data.num_subblocks);
> +
> +	offset += sizeof(struct tas25xx_config_info);
> +
> +	for (int i = 0; i < num_subblocks; i++) {
> +		cmd = (struct tas25xx_cmd *)&fw_data->config_data[offset];
> +		length = tas25xx_process_block(dev, regmap, cmd,
> +			max_offset - offset);
> +		if (length < 0)
> +			return length;
> +
> +		offset += length;
> +	}
> +
> +	/* Reset Book to 0 */
> +	regmap_write(regmap, TAS2562_PAGE_CTRL, 0);
> +	regmap_write(regmap, TAS2562_BOOK_CTRL, 0);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tas25xx_write_config);
> +
> +
> +struct tas25xx_fw_data *tas25xx_parse_fw(struct device *dev,
> +	const struct firmware *fw)
> +{
> +	u32 total_prog_sz = 0;
> +	u32 total_config_sz = 0;
> +	u32 prog_num = 0;
> +	u32 config_num = 0;

last two inits are useless

> +	int hdr_size = sizeof(struct tas25xx_fw_hdr);
> +	struct tas25xx_fw_data *fw_data = NULL;
> +
> +	fw_data = devm_kzalloc(dev, sizeof(struct tas25xx_fw_data), GFP_KERNEL);
> +	if (!fw_data)
> +		goto err_fw;
> +
> +	if (fw->size < hdr_size)
> +		goto err_data;
> +
> +	fw_data->hdr = devm_kzalloc(dev, hdr_size, GFP_KERNEL);
> +	if (!fw_data->hdr)
> +		goto err_data;
> +
> +	memcpy(fw_data->hdr, &fw->data[0], hdr_size);
> +
> +	for (int i = 0; i < cpu_to_be32(fw_data->hdr->num_programs); i++)
> +		total_prog_sz += cpu_to_be32(fw_data->hdr->prog_size[i]);
> +
> +	for (int i = 0; i < cpu_to_be32(fw_data->hdr->num_configs); i++)
> +		total_config_sz += cpu_to_be32(fw_data->hdr->config_size[i]);
> +
> +	if (fw->size < hdr_size + total_prog_sz + total_config_sz)
> +		goto err_hdr;
> +
> +	fw_data->prog_data = devm_kzalloc(dev, total_prog_sz, GFP_KERNEL);
> +	if (!fw_data->prog_data)
> +		goto err_hdr;
> +
> +	memcpy(fw_data->prog_data, &fw->data[hdr_size], total_prog_sz);
> +
> +	fw_data->config_data = devm_kzalloc(dev, total_config_sz, GFP_KERNEL);
> +	if (!fw_data->config_data)
> +		goto err_prog;
> +
> +	memcpy(fw_data->config_data, &fw->data[hdr_size + total_prog_sz],
> +		total_config_sz);
> +
> +	prog_num = cpu_to_be32(fw_data->hdr->num_programs);
> +	config_num = cpu_to_be32(fw_data->hdr->num_configs);
> +	dev_info(dev, "Firmware loaded: programs %d, configs %d\n",
> +		prog_num, config_num);
> +
> +	return fw_data;
> +
> +err_prog:
> +	devm_kfree(dev, fw_data->prog_data);
> +err_hdr:
> +	devm_kfree(dev, fw_data->hdr);
> +err_data:
> +	devm_kfree(dev, fw_data);
> +err_fw:
> +	release_firmware(fw);
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(tas25xx_parse_fw);
> +
> +MODULE_DESCRIPTION("TAS25xx DSP library");
> +MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
> +MODULE_LICENSE("GPL");
