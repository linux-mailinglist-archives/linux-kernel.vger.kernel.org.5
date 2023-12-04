Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D09A80303E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343854AbjLDK11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjLDK1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:27:12 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E783C19A7;
        Mon,  4 Dec 2023 02:26:40 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B47AB9p012871;
        Mon, 4 Dec 2023 04:26:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=MWxd0WTAwrscNnhEQCrZd6njkP2aEL1Jt25iaLlk6w4=; b=
        BBdFZVx/XLpYND+OUE6C6LOfJkw6WBkjxXO3gy4XhP0ED6icYl3PY75eisqHTG79
        tu87K174eBMbpkem+coRy/sBXXoGUE/OX/rro/urTsFdTGHGDZ24ePEn4vAGerah
        Skjv3w0yGhAtUbMoQA9qzYuzrPpqRiXpr3Pa1bVX3Z4SldhVyvGjFZ9n3Os7pVWF
        n6zTorS3pxgK6ifCWdSWjiDLw/DIYgN0UBbaP+NwNOBzLfYIv0UlsvC9rFPKrwnq
        cUP6DmWFQjQse2wkwALI2FMgHgxUvNgIVQjfdApO4VAyPQWtnHj58h9maZrCA+J7
        ioU64E7jujMpGkFyM9oVdA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ur2v21p6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 04:26:04 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Dec
 2023 10:26:02 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Mon, 4 Dec 2023 10:26:02 +0000
Received: from [198.90.251.82] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.82])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A130311AB;
        Mon,  4 Dec 2023 10:26:01 +0000 (UTC)
Message-ID: <a69e24fe-a4e6-4ae0-b27b-4d5c1f18e78a@opensource.cirrus.com>
Date:   Mon, 4 Dec 2023 10:26:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: wm_adsp: fix memleak in wm_adsp_buffer_populate
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Simon Trimmer" <simont@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231204074158.12026-1-dinghao.liu@zju.edu.cn>
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20231204074158.12026-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iWMaWOrUBYmgEdpWdNOv5_NyVd5Xbu4g
X-Proofpoint-GUID: iWMaWOrUBYmgEdpWdNOv5_NyVd5Xbu4g
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 07:41, Dinghao Liu wrote:
> When wm_adsp_buffer_read() fails, we should free buf->regions.
> Otherwise, the callers of wm_adsp_buffer_populate() will
> directly free buf on failure, which makes buf->regions a leaked
> memory.
> 
> Fixes: a792af69b08f ("ASoC: wm_adsp: Refactor compress stream initialisation")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>   sound/soc/codecs/wm_adsp.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
> index 236b12b69ae5..c01e31175015 100644
> --- a/sound/soc/codecs/wm_adsp.c
> +++ b/sound/soc/codecs/wm_adsp.c
> @@ -1451,12 +1451,12 @@ static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
>   		ret = wm_adsp_buffer_read(buf, caps->region_defs[i].base_offset,
>   					  &region->base_addr);
>   		if (ret < 0)
> -			return ret;
> +			goto err;
>   
>   		ret = wm_adsp_buffer_read(buf, caps->region_defs[i].size_offset,
>   					  &offset);
>   		if (ret < 0)
> -			return ret;
> +			goto err;
>   
>   		region->cumulative_size = offset;
>   
> @@ -1467,6 +1467,10 @@ static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
>   	}
>   
>   	return 0;
> +
> +err:
> +	kfree(buf->regions);
> +	return ret;
>   }
>   
>   static void wm_adsp_buffer_clear(struct wm_adsp_compr_buf *buf)

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
