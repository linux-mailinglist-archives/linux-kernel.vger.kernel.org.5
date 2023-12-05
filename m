Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404238043C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343746AbjLEBLB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 20:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjLEBLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:11:00 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDC69B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 17:11:05 -0800 (PST)
Received: from [192.168.2.4] (51b68398.dsl.pool.telekom.hu [::ffff:81.182.131.152])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000071433.00000000656E78A6.00115099; Tue, 05 Dec 2023 02:11:02 +0100
Message-ID: <ba7ed44fdcfe0a3a80024f0ecdfa4e5255cc48c6.camel@irl.hu>
Subject: Re: [PATCH 1/2] ASoc: tas2563: DSP Firmware loading support
From:   Gergo Koteles <soyer@irl.hu>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Date:   Tue, 05 Dec 2023 02:11:01 +0100
In-Reply-To: <7a919eef-d9b4-4bcb-bc19-9a6868d1cc54@linux.intel.com>
References: <cover.1701733441.git.soyer@irl.hu>
         <c7d0fc477393550cc29624f33361d94ad987259f.1701733441.git.soyer@irl.hu>
         <7a919eef-d9b4-4bcb-bc19-9a6868d1cc54@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre-Louis,

Thank you for your review.

On Mon, 2023-12-04 at 18:05 -0600, Pierre-Louis Bossart wrote:

> > 
> >  sound/soc/codecs/tas2562.c                    |   2 +-
> 
> are tas2562 and tas2563 (from commit subject) the same?
> 
No, tas2563 is register compatible with tas2562.

> > 
> > +#include <linux/slab.h>
> > +#include <linux/delay.h>
> 
> nit-pick: alphabetical order?
> 
Good idea, I'll fix it and the others in the next version.

> > +
> > +#include <sound/tas2562.h>
> > +#include <sound/tas25xx-dsp.h>
> > +
> > +
> > +static void tas25xx_process_fw_delay(struct tas25xx_cmd *cmd)
> > +{
> > +	mdelay(cpu_to_be16(cmd->hdr.length));
> 
> is this the length of the header, or the duration of the delay?
> 
> Someone will get it wrong with this naming...
> 
I think this is because of the format.
If cmd_type is TAS25XX_CMD_DELAY, then hdr.length is the length of the
delay.
At least I think so, based on
https://lore.kernel.org/lkml/6d6aaed3-dac8-e1ec-436c-9b04273df2b3@ti.com/T/
https://github.com/torvalds/linux/blob/bee0e7762ad2c6025b9f5245c040fcc36ef2bde8/sound/soc/codecs/tas2781-fmwlib.c#L769

But I don't see any TAS25XX_CMD_DELAY command in the firmware I'm
using.

> > 
> > +	prog_num = cpu_to_be32(fw_data->hdr->num_programs);
> > +	config_num = cpu_to_be32(fw_data->hdr->num_configs);
> > +	dev_info(dev, "Firmware loaded: programs %d, configs %d\n",
> > +		prog_num, config_num);
> > +

For me:
release_firmware(fw) is missing from here

> > +	return fw_data;
> > +
> > +err_prog:
> > +	devm_kfree(dev, fw_data->prog_data);
> > +err_hdr:
> > +	devm_kfree(dev, fw_data->hdr);
> > +err_data:
> > +	devm_kfree(dev, fw_data);
> > +err_fw:
> > +	release_firmware(fw);
> > +
> > +	return NULL;
> > +}
> > 

Regards,

Gergo

