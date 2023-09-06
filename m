Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC25794191
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243051AbjIFQiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjIFQiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:38:13 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782BF10F7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 09:38:05 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 386EKPQD028600;
        Wed, 6 Sep 2023 11:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=Atc7lVm5+/UL8Hp
        opPWqch9yCPj8m1pY5oNSjJu5VSE=; b=gKv4coBn2ObW6k159xKHYvEN1sjVmYp
        XfSg4byrcrlzWula7d8e3LqKivlg9xAtIlpX1wbT9E6k123DCdny0XLQL9IAkI2W
        BMW/3IuCTUOtAmNouINulWD9goiX2YkdTITqojCLyF4Da2NKqs8+XzUgmJBvW70p
        1v7PuNm6RTgG4LhhF3AYjJ9FABr+P6ssiKKDkB0PGKlTqlbbUpMx3FGiUux71GPN
        BU5hthFqpFNsS4iSnBE/JjKRQwEEvA3a3U3a55dQfNNMAKL0UeiX/+xHRz1dXVhz
        sQAHcZvw6jQWn1ErYVR4p80F1yj5cGKRKL0tV31rk68AJLp3Ab6TPmg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sv2ex5eee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 11:37:27 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 6 Sep
 2023 17:37:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Wed, 6 Sep 2023 17:37:25 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1553411AC;
        Wed,  6 Sep 2023 16:37:25 +0000 (UTC)
Date:   Wed, 6 Sep 2023 16:37:25 +0000
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
Message-ID: <20230906163725.GN103419@ediswmail.ad.cirrus.com>
References: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
 <20230902210621.1184693-10-cristian.ciocaltea@collabora.com>
 <20230905094535.GK103419@ediswmail.ad.cirrus.com>
 <953eb242-4d52-4cdc-8f7d-71af003778c5@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <953eb242-4d52-4cdc-8f7d-71af003778c5@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: 0CVpzE3oxNXbAvQuFrb5e9M92i5H-BPn
X-Proofpoint-GUID: 0CVpzE3oxNXbAvQuFrb5e9M92i5H-BPn
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 10:15:46PM +0300, Cristian Ciocaltea wrote:
> On 9/5/23 12:45, Charles Keepax wrote:
> > On Sun, Sep 03, 2023 at 12:06:21AM +0300, Cristian Ciocaltea wrote:
> >> Simplify runtime PM during probe by converting pm_runtime_enable() to
> >> the managed version.
> >>
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >> ---
> >> @@ -1376,7 +1379,6 @@ void cs35l41_remove(struct cs35l41_private *cs35l41)
> >>  	cancel_work_sync(&cs35l41->mdsync_up_work);
> >>  
> >>  	pm_runtime_get_sync(cs35l41->dev);
> >> -	pm_runtime_disable(cs35l41->dev);
> >>  
> >>  	regmap_write(cs35l41->regmap, CS35L41_IRQ1_MASK1, 0xFFFFFFFF);
> >>  	if (cs35l41->hw_cfg.bst_type == CS35L41_SHD_BOOST_PASS ||
> > 
> > Are we sure this is safe? The remove handler appears to be
> > written to disable pm_runtime at the start presumably to stop the
> > resume/suspend handler running during the remove callback.
> > Whereas after this change the pm_runtime isn't disabled until
> > after the remove callback has run. Does this open a window were
> > we could get an erroneous pm_runtime suspend after the
> > pm_runtime_put_noidle?
> 
> I've just made a test adding a 6s sleep before returning from the remove 
> handler: 
> 
> [14444.894316] cs35l41 spi-VLV1776:00: Runtime resume
> [14444.894469] cs35l41 spi-VLV1776:00: sleep 6s before return of cs35l41_remove()
> [14448.338994] cs35l41 spi-VLV1776:00: Runtime suspend
> [14451.079649] cs35l41 spi-VLV1776:00: return from cs35l41_remove()
> [14451.080129] cs35l41 spi-VLV1776:00: Runtime resume
> [14451.080165] cs35l41 spi-VLV1776:00: ASoC: Unregistered DAI 'cs35l41-pcm'
> [14451.080181] cs35l41 spi-VLV1776:00: Runtime suspend
> [14451.813639] acp5x_i2s_playcap acp5x_i2s_playcap.0: ASoC: Unregistered DAI 'acp5x_i2s_playcap.0'
> 
> As expected, suspend triggered, but a resume was issued later, before DAI
> got unregistered.
> 
> I didn't notice any issues while repeating the test several times, hence 
> I wonder what would be the reason to prevent getting suspend/resume events 
> at this point?

The enter/exit hibernate code might run, which at the very
least might result in a bunch of unexpected and failing bus
traffic. Having a bit of a poke through the code, I guess the
most dangerous thing would if you actually got as far as an
extra runtime resume. This might cause cs35l41_init_boost
to run which would undo the work done by the call to
cs35l41_safe_reset in remove, which could leave the boost in a
dangerous state when we enable reset/power down the supplies,
which I think was not considered good. But its just likely
simpler/cleaner if we don't have to think about all the
possible implications of such things by just not allowing
it to happen.

Thanks,
Charles
