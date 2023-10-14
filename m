Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1E27C9499
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 14:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjJNM2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 08:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjJNM2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 08:28:14 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC373A2;
        Sat, 14 Oct 2023 05:28:10 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E53A40007;
        Sat, 14 Oct 2023 12:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697286488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a9XWZXpgg0IYDBQKWd/5ZFV4pkk41cAYnPsgXLOB+Kk=;
        b=VcycMUnRVyvTNE7CsMfA/w4Vvbxn172rSLlrFfFG43MKlBLvPbbwTijP6ec6OCaPqZHIKL
        syOAL92KFdVrsWVJGnZ5dtdjJ/xejoOCSPU+aKEiqPJ6tLsTwTQZw9+MkLXNz41RUgEuuS
        79xJxyI9svEpKDDGURHl9+ljI6fDzO7ydhmDBsCLy34NBCPIeL5ZlVMfmkYjb0avaL9Sms
        tRzgaIyGOh/wGmIZ6Jc/Uvwn5pL4E0EKYDHtdhnQ5j4jz0QZYG87tXQGfMXambkdi1I3sf
        X7hbLjp1gzB/137koSGquWqCWW8C1bGCeLg6l/O95gxJbRIPWoDNnBMNzCMGiA==
Date:   Sat, 14 Oct 2023 14:28:03 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     wangweidong.a@awinic.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, shumingf@realtek.com,
        rf@opensource.cirrus.com, arnd@arndb.de, 13916275206@139.com,
        ryans.lee@analog.com, linus.walleij@linaro.org,
        ckeepax@opensource.cirrus.com, fido_max@inbox.ru,
        sebastian.reichel@collabora.com, colin.i.king@gmail.com,
        liweilei@awinic.com, trix@redhat.com, dan.carpenter@linaro.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 2/3] ASoC: codecs: Add code for bin parsing
 compatible with aw88399
Message-ID: <20231014142803.43f2aa9b@bootlin.com>
In-Reply-To: <20231013104220.279953-3-wangweidong.a@awinic.com>
References: <20231013104220.279953-1-wangweidong.a@awinic.com>
        <20231013104220.279953-3-wangweidong.a@awinic.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weidong,

On Fri, 13 Oct 2023 18:42:19 +0800
wangweidong.a@awinic.com wrote:

> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> Add aw88399 compatible code to the aw88395_lib.c file
> so that it can parse aw88399's bin file.
> 
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
> ---
>  sound/soc/codecs/aw88395/aw88395_lib.c | 3 +++
>  sound/soc/codecs/aw88395/aw88395_reg.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/sound/soc/codecs/aw88395/aw88395_lib.c b/sound/soc/codecs/aw88395/aw88395_lib.c
> index 87dd0ccade4c..692ad9fa65a6 100644
> --- a/sound/soc/codecs/aw88395/aw88395_lib.c
> +++ b/sound/soc/codecs/aw88395/aw88395_lib.c
> @@ -702,6 +702,7 @@ static int aw_dev_load_cfg_by_hdr(struct aw_device *aw_dev,
>  	}
>  
>  	switch (aw_dev->chip_id) {
> +	case AW88399_CHIP_ID:

Just a nitpick here.
You can use the same 'switch case' order as for the other 'switch cases' below.
I mean
   case AW88395_CHIP_ID:
   case AW88399_CHIP_ID:

With that done:
Reviewed-by: Herve Codina <herve.codina@bootlin.com>

>  	case AW88395_CHIP_ID:
>  		ret = aw88395_dev_cfg_get_valid_prof(aw_dev, *all_prof_info);
>  		if (ret < 0)
> @@ -791,6 +792,7 @@ static int aw_get_dev_scene_count_v1(struct aw_device *aw_dev, struct aw_contain
>  
>  	switch (aw_dev->chip_id) {
>  	case AW88395_CHIP_ID:
> +	case AW88399_CHIP_ID:
>  		for (i = 0; i < cfg_hdr->ddt_num; ++i) {
>  			if ((cfg_dde[i].data_type == ACF_SEC_TYPE_MULTIPLE_BIN) &&
>  			    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
> @@ -832,6 +834,7 @@ static int aw_get_default_scene_count_v1(struct aw_device *aw_dev,
>  
>  	switch (aw_dev->chip_id) {
>  	case AW88395_CHIP_ID:
> +	case AW88399_CHIP_ID:
>  		for (i = 0; i < cfg_hdr->ddt_num; ++i) {
>  			if ((cfg_dde[i].data_type == ACF_SEC_TYPE_MULTIPLE_BIN) &&
>  			    (aw_dev->chip_id == cfg_dde[i].chip_id) &&

[...]


Best regards,
Hervé
