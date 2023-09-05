Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1FC792BF5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349026AbjIEREh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354126AbjIEJqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:46:08 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4791AD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 02:46:04 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3856L0ej015029;
        Tue, 5 Sep 2023 04:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=R1PXGn/5wGrB3Y7
        MxvWTug+xiW8/98V2SY3ME2SCowg=; b=qbID/8r+ndv/7kvkjrQTTUay/Ti0zeT
        CDh/JRWSNkCdGhk2Qh3CIA3aW5Vrrf5ece1hlUKCvSaYFNtGvJ+1OEQPaWXfrfTh
        vTX5QJefj2qbTZ8SDISnWQR7pjrI7nqJUIIbl2Vaj6vxpUgzT90N3wODK9PmPrzF
        0K5AM9q7j/h88SZRZF+CnDbbpbcZ8sooigQnG9rSqLS0tZCWtf1nY2uKF5PD5rh0
        ajjNZqB48CjfJ7Y1c9UBuAJR3ZnD+74T1NKNnInxZnN4BIHB/8K8eCKkvMx1oOmd
        a+yCvXgzSHyxC8qylT3s83iFI9b19zMNx50BsttBY7WaY9eLJxSyiKw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sv2ex3bun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 04:45:38 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 5 Sep
 2023 10:45:35 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Tue, 5 Sep 2023 10:45:35 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5C1D911AA;
        Tue,  5 Sep 2023 09:45:35 +0000 (UTC)
Date:   Tue, 5 Sep 2023 09:45:35 +0000
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
Subject: Re: [PATCH 9/9] ASoC: cs35l41: Use devm_pm_runtime_enable()
Message-ID: <20230905094535.GK103419@ediswmail.ad.cirrus.com>
References: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
 <20230902210621.1184693-10-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230902210621.1184693-10-cristian.ciocaltea@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: f05LQqp9LadCj4InE97tI91FBtGyZO61
X-Proofpoint-GUID: f05LQqp9LadCj4InE97tI91FBtGyZO61
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 12:06:21AM +0300, Cristian Ciocaltea wrote:
> Simplify runtime PM during probe by converting pm_runtime_enable() to
> the managed version.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
> @@ -1376,7 +1379,6 @@ void cs35l41_remove(struct cs35l41_private *cs35l41)
>  	cancel_work_sync(&cs35l41->mdsync_up_work);
>  
>  	pm_runtime_get_sync(cs35l41->dev);
> -	pm_runtime_disable(cs35l41->dev);
>  
>  	regmap_write(cs35l41->regmap, CS35L41_IRQ1_MASK1, 0xFFFFFFFF);
>  	if (cs35l41->hw_cfg.bst_type == CS35L41_SHD_BOOST_PASS ||

Are we sure this is safe? The remove handler appears to be
written to disable pm_runtime at the start presumably to stop the
resume/suspend handler running during the remove callback.
Whereas after this change the pm_runtime isn't disabled until
after the remove callback has run. Does this open a window were
we could get an erroneous pm_runtime suspend after the
pm_runtime_put_noidle?

Thanks,
Charles
