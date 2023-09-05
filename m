Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3EB792ABA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjIEQl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354030AbjIEJTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:19:37 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97929DD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 02:19:33 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3858YFR6006187;
        Tue, 5 Sep 2023 04:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=kOfMXB5T5kAp/+Z
        hTB0EnsKb+TNVPnk4Dhyt9ZGf3ys=; b=hISa7PZhFiRgh8G136BpKiuXlk7ncLz
        BRYp2Z2rogGd8j0phgdK2a0yCiOC2OQY3f/zjD6nDE0WFhyMCmMi3+Uu7jSpQtIC
        UptygqaZusCZ80vMCOf1K8CIPYg1KJnT1PocWnwMWNHECnuVQhLnog9JRzgi2Kmn
        PVihMEnnk/I/YdkqLd3Ln863pFIz8WuVDyRT27QtA8YSQlhAjC5+8RC029J6nY41
        ZHX2O5c6RY5DABmpoSH4qGOicblXxsDCzHQ5IUeDhlJS4uS2XDwub6n3ub7bOvn2
        O8ydWjfpeWo3shQYomTGv3ONPfZ1Tj43rQ7LdEUPrhR6LqcwxjLcTnQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sv1fhtrke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 04:19:10 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 5 Sep
 2023 10:19:09 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Tue, 5 Sep 2023 10:19:09 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E24BD357D;
        Tue,  5 Sep 2023 09:19:08 +0000 (UTC)
Date:   Tue, 5 Sep 2023 09:19:08 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Stefan Binding" <sbinding@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
Subject: Re: [PATCH 1/9] ASoC: cs35l41: Handle mdsync_down reg write errors
Message-ID: <20230905091908.GD103419@ediswmail.ad.cirrus.com>
References: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
 <20230902210621.1184693-2-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230902210621.1184693-2-cristian.ciocaltea@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: V7XBfCy45kaA7Y_PFHQ6LcQNY5VKPnoM
X-Proofpoint-GUID: V7XBfCy45kaA7Y_PFHQ6LcQNY5VKPnoM
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 12:06:13AM +0300, Cristian Ciocaltea wrote:
> The return code of regmap_multi_reg_write() call related to "MDSYNC
> down" sequence is shadowed by the subsequent
> wait_for_completion_timeout() invocation, which is expected to time
> timeout in case the write operation failed.
> 
> Let cs35l41_global_enable() return the correct error code instead of
> -ETIMEDOUT.
> 
> Fixes: f5030564938b ("ALSA: cs35l41: Add shared boost feature")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  sound/soc/codecs/cs35l41-lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
> index 4ec306cd2f47..a018f1d98428 100644
> --- a/sound/soc/codecs/cs35l41-lib.c
> +++ b/sound/soc/codecs/cs35l41-lib.c
> @@ -1243,7 +1243,7 @@ int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l4
>  		cs35l41_mdsync_down_seq[2].def = pwr_ctrl1;
>  		ret = regmap_multi_reg_write(regmap, cs35l41_mdsync_down_seq,
>  					     ARRAY_SIZE(cs35l41_mdsync_down_seq));
> -		if (!enable)
> +		if (ret || !enable)
>  			break;

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
