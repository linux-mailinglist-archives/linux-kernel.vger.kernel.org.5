Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D61769A71
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjGaPJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjGaPJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:09:13 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4509210FB
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:09:06 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36VExLDl000923;
        Mon, 31 Jul 2023 10:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=Ac1SzXAkYAowcCY
        4X6xWPtA/gmE/RcwJtVjsYvKiiSc=; b=D3xsfZG5WJSWBscvz/9yVeYL9OKA4K1
        8Rr3EZ6wjYBW0ZKBNUsiy0CmN5wsSTcVFQ2AIYkJ91n4visCi5AwdACbafocqexi
        JZ5vi8sCXQ3TjeopEnx0mIiuYpZaKfrM+jC7rwrB7aMds+XzVdEMvFhOkDGbWkFv
        niR5fX7BqB6QHBZ4odwIOI5O9uqnex5wA+L0PMC+XQXXGztJ60mxK/epHHLLScu5
        UMmDAXrmWI6Ovba+y9W7yxh4k0temm26KEjoADHwH2z5cLPiVZwEJo2hMgFcIq8+
        C25k2gfQ7gv07CJ/60Ib49yEMEIFTVzCPg3U1J8wckqFk8/DYQDqNZA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s4y6jskrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 10:08:31 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 16:08:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Mon, 31 Jul 2023 16:08:30 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0CC6445;
        Mon, 31 Jul 2023 15:08:30 +0000 (UTC)
Date:   Mon, 31 Jul 2023 15:08:30 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ASoC: wm8960: Read initial MCLK rate from clock API
Message-ID: <20230731150830.GN103419@ediswmail.ad.cirrus.com>
References: <20230731-asoc-wm8960-clk-v1-0-69f9ffa2b10a@kernel.org>
 <20230731-asoc-wm8960-clk-v1-1-69f9ffa2b10a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230731-asoc-wm8960-clk-v1-1-69f9ffa2b10a@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: OisnnALTvK6W1n0cbKjumNuL5kmGmgt-
X-Proofpoint-ORIG-GUID: OisnnALTvK6W1n0cbKjumNuL5kmGmgt-
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 11:47:02AM +0100, Mark Brown wrote:
> When we have a MCLK provided by the clock API read the rate at startup
> and store it so that there's something set before the machine driver has
> done clocking configuration (eg, if it only configures clocking based on
> sample rate).
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
