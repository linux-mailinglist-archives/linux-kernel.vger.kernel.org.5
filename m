Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C53E7DC9CF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjJaJqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJaJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:46:11 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38BACDB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:46:06 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTPS Server V6.0(1849591:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 31 Oct 2023 17:45:35 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Tue, 31 Oct
 2023 17:45:35 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1258.27 via Frontend
 Transport; Tue, 31 Oct 2023 17:45:35 +0800
Date:   Tue, 31 Oct 2023 17:45:35 +0800
From:   ChiYuan Huang <cy_huang@richtek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Allen Lin <allen_lin@richtek.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] ASoC: codecs: rtq9128: Fix string compare in DAPM
 event callback
Message-ID: <20231031094535.GA15465@linuxcarl2.richtek.com>
References: <1697795435-5858-1-git-send-email-cy_huang@richtek.com>
 <1697795435-5858-2-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1697795435-5858-2-git-send-email-cy_huang@richtek.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 05:50:33PM +0800, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Since widget name may concatenate the component prefix. To compare the
> the name with 'strcmp' function in shared DAPM event callback will
> cause the wrong RG field control. Use 'strstr' function, instead.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  sound/soc/codecs/rtq9128.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/rtq9128.c b/sound/soc/codecs/rtq9128.c
> index 371d622c6214..8c1c3c65475e 100644
> --- a/sound/soc/codecs/rtq9128.c
> +++ b/sound/soc/codecs/rtq9128.c
> @@ -291,11 +291,11 @@ static int rtq9128_dac_power_event(struct snd_soc_dapm_widget *w, struct snd_kco
>  
>  	dev_dbg(comp->dev, "%s: %s event %d\n", __func__, w->name, event);
>  
> -	if (strcmp(w->name, "DAC1") == 0)
> +	if (strstr(w->name, "DAC1"))
>  		shift = 6;
> -	else if (strcmp(w->name, "DAC2") == 0)
> +	else if (strstr(w->name, "DAC2"))
>  		shift = 4;
> -	else if (strcmp(w->name, "DAC3") == 0)
> +	else if (strstr(w->name, "DAC3"))
>  		shift = 2;
>  	else
>  		shift = 0;
https://lore.kernel.org/lkml/20231023095428.166563-8-krzysztof.kozlowski@linaro.org/
Since the better change is applied. Please ignore this one.

Still wait the other patch(2&3)'s feedback.

Thanks.
> -- 
> 2.34.1
> 
