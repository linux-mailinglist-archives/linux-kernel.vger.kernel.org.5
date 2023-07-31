Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94C9769A73
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjGaPJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjGaPJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:09:31 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C161119BB
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:09:21 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36VDp2Qn022362;
        Mon, 31 Jul 2023 10:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=Sgj8HRPTlGuwo3T
        29LBXapIwqz/RNdE/KoELg/AckWM=; b=p//P01Wve+x7MDXRKwrlVP+x3O5ZtpM
        Cm3/dGEzFUVzG0gOPhIMRfxii7DsQB83EG5PNMuYreV2UCq7KgbPoP2vurk7NGXd
        vWGq8KzIieYK1aLEPh7FteUtCD10FT6bxA+zU91UemvWerdxVZZvCuBqe5JJPbce
        UJYmr2zx/5ESE43n4XXX6E4Be9Kb0dxQzmnFgAUs9o6AxCiMqS/Pwc8z+TsWEYJ0
        +S8myoiDcXyVet1RsPkpmLNVC6u75GJ2PUWF1OHEPke04OlnccIEt9pM+m2qvBRa
        bLmx8ijIwiqu+oDJa3O/L4LWTTc0aXkIN7X38hNsFt4oFvdPEeAq3NA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3s5gk1sbtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 10:08:42 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 16:08:40 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Mon, 31 Jul 2023 16:08:40 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 81B1045D;
        Mon, 31 Jul 2023 15:08:40 +0000 (UTC)
Date:   Mon, 31 Jul 2023 15:08:40 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ASoC: wm8960: Make automatic the default clocking
 mode
Message-ID: <20230731150840.GO103419@ediswmail.ad.cirrus.com>
References: <20230731-asoc-wm8960-clk-v1-0-69f9ffa2b10a@kernel.org>
 <20230731-asoc-wm8960-clk-v1-2-69f9ffa2b10a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230731-asoc-wm8960-clk-v1-2-69f9ffa2b10a@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: jqdVLszwbwFFuOD7Q_qAbKMDhDYEhfA4
X-Proofpoint-ORIG-GUID: jqdVLszwbwFFuOD7Q_qAbKMDhDYEhfA4
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 11:47:03AM +0100, Mark Brown wrote:
> The wm8960 driver supports an automatic clocking mode which will use the
> MCLK directly where possible and fall back to the PLL if there is no
> suitable configuration directly using the MCLK.  Clock 0 will be used by
> the generic cards when configuring things, currently this is a MCLK only
> mode but using AUTO mode would be more functional.  Since the driver
> still prefers to use MCLK directly where possible there should be no
> negative impact on systems which are able to use MCLK directly.
> 
> As far as I can see nothing is using the system clock as part of the
> ABI, the only reference I can see to a mode in a machine driver is the
> Freescale i.MX card which uses the automatic mode with an explicit in
> kernel call using the constant so will be unaffected.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
