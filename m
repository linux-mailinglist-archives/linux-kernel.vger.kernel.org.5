Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424B97925FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241250AbjIEQJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354102AbjIEJi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:38:28 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636531A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 02:38:24 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38560m0j022304;
        Tue, 5 Sep 2023 04:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=QxF4gzNzElPv4PK
        ESKObNA4P//1R2Su7jK68xN/inrA=; b=JfQZ9pyYdeTPe52v4RVWFneYVcPJAg5
        YX7lSelLMAEE0MbsIT2FcFvs5L1pf4Ek0rSm4niyba6l7S4JjDORVJMP82leDvjc
        M6CoEPk5opVy27WsIJjZGQNLhgY6yPMtLmCg15ySHCb88Xgquy0UhG4qzkTTJTpG
        O+gqKvFDf7pYTufV0xd+C+4kU6MWG1dofQ8ZSq1NW9oZvjRVXUCuDZgskj9AFjN9
        x0tH+lcZlpQkBd2K9WS7DBURTvVLnjJqstG5vcRiYsJIm0CVKXIKSJ128nci3iNd
        piR4prJ6uFyPJHCyEedeAKyOyomO5Ph80wB5X9QOCTZdlmggNCpAAVw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sv2ex3bnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 04:38:00 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 5 Sep
 2023 10:37:58 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Tue, 5 Sep 2023 10:37:58 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9F38511AA;
        Tue,  5 Sep 2023 09:37:58 +0000 (UTC)
Date:   Tue, 5 Sep 2023 09:37:58 +0000
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
Subject: Re: [PATCH 8/9] ASoC: cs35l41: Use modern pm_ops
Message-ID: <20230905093758.GJ103419@ediswmail.ad.cirrus.com>
References: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
 <20230902210621.1184693-9-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230902210621.1184693-9-cristian.ciocaltea@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: uQ9YHoOsAzMWC_3BVmV5gYS5YeHu2u_a
X-Proofpoint-GUID: uQ9YHoOsAzMWC_3BVmV5gYS5YeHu2u_a
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 12:06:20AM +0300, Cristian Ciocaltea wrote:
> Make use of the recently introduced EXPORT_GPL_DEV_PM_OPS() macro, to
> conditionally export the runtime/system PM functions.
> 
> Replace the old SET_{RUNTIME,SYSTEM_SLEEP,NOIRQ_SYSTEM_SLEEP}_PM_OPS()
> helpers with their modern alternatives and get rid of the now
> unnecessary '__maybe_unused' annotations on all PM functions.
> 
> Additionally, use the pm_ptr() macro to fix the following errors when
> building with CONFIG_PM disabled:
> 
> ERROR: modpost: "cs35l41_pm_ops" [sound/soc/codecs/snd-soc-cs35l41-spi.ko] undefined!
> ERROR: modpost: "cs35l41_pm_ops" [sound/soc/codecs/snd-soc-cs35l41-i2c.ko] undefined!
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
