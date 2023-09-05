Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6114C792FEE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbjIEU01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbjIEU00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:26:26 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C13194
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:26:16 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38560mTI022304;
        Tue, 5 Sep 2023 15:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=UpYpqMqegw67X6w319WVYKssAQtKW9ZSUZjIh1z449U=; b=
        K6SS7o33KnW4hPYRMvg43KqMZvFKpDk+IGUUz/+WJD2HQSY7elT1n/69/lUcReNz
        JuC7r4f/D0sr7/eaYStSBFgPDBB0E701MtxqNEKd3Gi/TbiAaXBmQW1sub4j35MW
        pcdj9roj/UWeE4kqh4D/p7/xUHvYDkCnFzsV0YBUGLpd4Nusi9dvmBtFUlPXBXCM
        2wyz7sn7eqLvjrUR+RXNpcv941/bkq7f+CxT/hBsaQ5GLTLRv967MHRRyWnXvMtt
        zra9JtFcyqNc35FdEOqxF3yWuUznyqelKF4GsZIeB4JOvjgo+h0YZ8jwSE3D+Wq3
        5J2McidSxrzeF2s1/Pobow==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sv2ex45g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 15:25:51 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 5 Sep
 2023 21:25:48 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 5 Sep 2023 21:25:48 +0100
Received: from [141.131.157.8] (macMW3KVPQQ2W.ad.cirrus.com [141.131.157.8])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DB49746B;
        Tue,  5 Sep 2023 20:25:46 +0000 (UTC)
Message-ID: <f3f074d4-458c-9ed8-b3a6-b6d32b8c9f77@opensource.cirrus.com>
Date:   Tue, 5 Sep 2023 15:25:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 4/9] ASoC: cs35l41: Fix broken shared boost activation
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
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
References: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
 <20230902210621.1184693-5-cristian.ciocaltea@collabora.com>
 <20230905102933.GL103419@ediswmail.ad.cirrus.com>
 <c3328c1d-07f4-ae3f-88cd-b4b767a667b2@opensource.cirrus.com>
 <1cd66d6d-6a39-41eb-8646-0a6e6f473e8d@collabora.com>
From:   "Rhodes, David" <drhodes@opensource.cirrus.com>
In-Reply-To: <1cd66d6d-6a39-41eb-8646-0a6e6f473e8d@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fbPf4wxmXlYDfcSCXGGmXTH1--H0fzrp
X-Proofpoint-GUID: fbPf4wxmXlYDfcSCXGGmXTH1--H0fzrp
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 3:05 PM, Cristian Ciocaltea wrote:
> If I got it right, we should drop all write operations on PWR_CTRL1,
> and simply set the CS35L41_SYNC_EN_MASK bit in PWR_CTRL3.

> That's a good point, it should be fixed implicitly by replacing the
> read/write operations with a single regmap_update_bits() call, which
> is protected by regmap's internal lock.
> 

Yes, my recommendation is to replace the mdsync_up_sequence and 
completion handling with a single regmap_update_bits() call to set the 
CS35L41_SYNC_EN_MASK bit in PWR_CTRL3, which occurs in response to the 
PLL Lock interrupt.

Thanks,
David
