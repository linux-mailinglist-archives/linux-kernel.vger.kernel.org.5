Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2D979FFDE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbjINJVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjINJVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:21:45 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CB0CF3;
        Thu, 14 Sep 2023 02:21:41 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38E74PZe017688;
        Thu, 14 Sep 2023 04:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=oxw8UGoxWAKPeFR
        YH8/soFo0chAZTNm45vShNklDO6U=; b=RcGMDv8Qt9qEv5EQp4eHjYbr1rtU6JG
        OK+5VijZki3iu1ileEtmxCOUay/kr3nB+TE4+2FXSrZ++Al22uaxwk6Ha/NFaGVo
        CBxjTAEeNUZmEeko5k0/auAE5XRd6f6uEXRfRNy8pZrB6GGvu1eERB513M34m+42
        FFErqwQfVzTGxMsxRztzOe8VLLNlu4/9h+2aIXoDbd95oC82RTIvE6axQ1CRrN73
        xX2IlmX7nQnms64EJoR+Il6nGTnm8iqs/8f7yMDCkkU9F/8Ut5YT/oITqDSRi1zE
        SyD8YBssvPUsFoh6XVu9FPAVn9zj1bP8JRgVYg+Z4RhcC9gV9qV5FPQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t2y7shvxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 04:21:09 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 14 Sep
 2023 10:21:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Thu, 14 Sep 2023 10:21:07 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D24C43563;
        Thu, 14 Sep 2023 09:21:07 +0000 (UTC)
Date:   Thu, 14 Sep 2023 09:21:07 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     John Watts <contact@jookia.org>
CC:     <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: wm8782: Handle maximum audio rate at runtime
Message-ID: <20230914092107.GR103419@ediswmail.ad.cirrus.com>
References: <20230913171552.92252-1-contact@jookia.org>
 <20230913171552.92252-2-contact@jookia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230913171552.92252-2-contact@jookia.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: T3VcIRVcK4-DQjHEfsYVgIDZjWmiGY1K
X-Proofpoint-ORIG-GUID: T3VcIRVcK4-DQjHEfsYVgIDZjWmiGY1K
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 03:15:50AM +1000, John Watts wrote:
> The wm8782 supports up to 192kHz audio when pins are set correctly.
> Instead of hardcoding which rates are supported enable them all
> then refer to a max_rate variable at runtime.
> 
> Signed-off-by: John Watts <contact@jookia.org>
> ---
> +static int wm8782_dai_hw_params(struct snd_pcm_substream *component,
> +			    struct snd_pcm_hw_params *params,
> +			    struct snd_soc_dai *dai)
> +{
> +	struct wm8782_priv *priv =
> +		snd_soc_component_get_drvdata(dai->component);
> +
> +	if (params_rate(params) > priv->max_rate)
> +		return -EINVAL;
> +
> +	return 0;
> +}

We should be setting this as a constraint in startup, rather
than returning an error in hw_params. That will let user-space
know the supported rates and allow it to resample if necessary.

Thanks,
Charles
