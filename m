Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7360078C0D1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjH2Iwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjH2Iwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:52:30 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BD8E0;
        Tue, 29 Aug 2023 01:52:27 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37T7duvW028909;
        Tue, 29 Aug 2023 03:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=tCsuP7AKJMpbFbr
        bid78TMjDeHr7H/IBH+iAMJKh65k=; b=CvIf87YrdV58Fbqzkb47X/AYBuKZfOH
        tB/s9zRImfwOiv5yx2Mv68PPJpvkj2YBog0ZyTgYAokzO3lPA+mV8KzR+xYjTWDX
        V0do/wUHMvz8puSDpboNinjCRO9FfTzpJgBriFf0RqPVaGq2BDE3cdkwiKqeIO9r
        JirJIczjlZNmDElEfeMLJmeJPaUnmDVYX+og8Ondw0s8cdMaPdHkf18B2SpVi73a
        gGNVpkkBAPyqnHNRFgQwvRMbj8143shKjhJ9m9w5/YeN2h6R8iJpd853kjTY5zyL
        +qdjlIc4ISlSGMe+wjUbWRBzFvmSexfNdMX4w7PKDEE2y68XU5SVE1A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sqdtj2qgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 03:46:59 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 29 Aug
 2023 09:46:58 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Tue, 29 Aug 2023 09:46:58 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DF72F357C;
        Tue, 29 Aug 2023 08:46:57 +0000 (UTC)
Date:   Tue, 29 Aug 2023 08:46:57 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <dan.carpenter@linaro.org>, <kernel-janitors@vger.kernel.org>,
        <error27@gmail.com>
Subject: Re: [PATCH next] ASoC: cs42l43: Fix missing error code in
 cs42l43_codec_probe()
Message-ID: <20230829084657.GO103419@ediswmail.ad.cirrus.com>
References: <20230829073635.1877367-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829073635.1877367-1-harshit.m.mogalapalli@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: lt2KSslfaEEodS0lMHqEliLgRvuY-hKQ
X-Proofpoint-GUID: lt2KSslfaEEodS0lMHqEliLgRvuY-hKQ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 12:36:35AM -0700, Harshit Mogalapalli wrote:
> When clk_get_optional() fails, the error handling code does a 'goto
> err_pm' with ret = 0, which is resturning success on a failure path.
> 
> Fix this by assigning the PTR_ERR(priv->mclk) to ret variable.
> 
> Fixes: fc918cbe874e ("ASoC: cs42l43: Add support for the cs42l43")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
