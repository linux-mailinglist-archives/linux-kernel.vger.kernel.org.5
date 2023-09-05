Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B62E792D56
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241064AbjIESYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbjIESYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:24:33 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15838DA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:23:55 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 385Hxfhe000957;
        Tue, 5 Sep 2023 13:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=iPXV3ZAscVnb0Ds1dgfOlU+kQGVJRdLT8lAvk519hYs=; b=
        KeX0XNATUsyJfwsYU0fSiqUqb4LGMRxN2r5tz645PhuWzTo877rUlRShynkbh0Ez
        VW2A8wluEEkeUCDqY2f2ICxp86ueTe7/RogxGsc3htLBBSyq/zzxqr6I+2pHSmCr
        3jua70Ffk//mMxIkvUEGxi+CX5ADxCSoX8TOFlmFxbmPkvgAxTboGpisNU3fjjly
        a1HNu/77Nf9I0KUBqkhrWKNL11yLCTJvuSfJlZ+Kvdb/sI67Kh+CfwhmmGcleU1j
        rT/7UrktnXujgfWpFvbQh0UlfgcNg/B0/oscmfnoERZxxMCYGlUsItIUtrfD7nag
        6c9qnsReivplMVnhrFe/Aw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sv1fhuc00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 13:11:59 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 5 Sep
 2023 19:11:58 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 5 Sep 2023 19:11:58 +0100
Received: from [141.131.157.8] (macMW3KVPQQ2W.ad.cirrus.com [141.131.157.8])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4D85A46B;
        Tue,  5 Sep 2023 18:11:56 +0000 (UTC)
Message-ID: <c3328c1d-07f4-ae3f-88cd-b4b767a667b2@opensource.cirrus.com>
Date:   Tue, 5 Sep 2023 13:11:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 4/9] ASoC: cs35l41: Fix broken shared boost activation
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
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
From:   "Rhodes, David" <drhodes@opensource.cirrus.com>
In-Reply-To: <20230905102933.GL103419@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4U_tAPJpHDH0DMJ3PoQcp49pFmtRZ-0L
X-Proofpoint-GUID: 4U_tAPJpHDH0DMJ3PoQcp49pFmtRZ-0L
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 5:29 AM, Charles Keepax wrote:
> On Sun, Sep 03, 2023 at 12:06:16AM +0300, Cristian Ciocaltea wrote:
>> Enabling the active/passive shared boosts involves writing the MDSYNC UP
>> register sequence, which cannot be performed before receiving the PLL
>> lock signal.
>>

> 
> Thanks for looking at this apologies this was missed in the
> initial review of the patch.
> 

Thanks Cristian, I agree with the intent of your patch.
We do not expect that clocks are always available before the DAPM PMU 
event and shared boost should still be configured if they are not.

>> +int cs35l41_mdsync_up(struct regmap *regmap)
>> +{
>> +	struct reg_sequence cs35l41_mdsync_up_seq[] = {
>> +		{CS35L41_PWR_CTRL3, 0},
>> +		{CS35L41_PWR_CTRL1, 0x00000000, 3000},
>> +		{CS35L41_PWR_CTRL1, 0x00000001, 3000},
>> +	};

I don't know why PWR_CTRL1 is included in the up sequence here.
This toggles GLOBAL_EN, which will cause the PLL to unlock and lock 
again. Doing this defeats the purpose of setting SYNC_EN in a separate 
operation, which is to only do so when the amp is powered on and has 
locked the PLL. GLOBAL_EN is set by the mdsync_down_seq, so all that is 
needed when the PLL is locked is to set SYNC_EN.

> 
> Is this now safe? By pulling this out into a worker thread, it is
> no longer under the DAPM lock, which makes me worry this can race
> with the other uses of PWR_CTRL3 which could theoretically change
> state between when you read the reg and when you write it.
> 

The Class-H DAPM widget also uses the PWR_CTRL3 register.

> 
> One question I might also have would be does a worker thread make
> more sense or would it be simpler to do the mdsync power up
> directly in response to the PLL lock IRQ?
> 

I  agree with implementing this in the PLL lock IRQ.
As I described above, all that would need to be done is to set SYNC_EN 
in the PLL Lock IRQ handler.

Thanks,
David
