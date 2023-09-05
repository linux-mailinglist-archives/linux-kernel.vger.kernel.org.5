Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC30792EA4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242139AbjIETRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242172AbjIETRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:17:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381FD194
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 12:16:44 -0700 (PDT)
Received: from [192.168.1.90] (unknown [81.18.92.207])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B246866071F8;
        Tue,  5 Sep 2023 20:15:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693941350;
        bh=1KbKUPXG/G2Ebjt5z5wrFNajgBmUipSNJpzYBN+VQds=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Hml/1wnL4PtSAqvy0A46oLOoGvX9TCHnhQHwJMiP/oshaaCdZNdK2Rm2zqW3UdMM5
         iD3BP5vJrgNDINETNpXzi0eGD5vJApts3/7J8tJ+El6ZVkt7Zd8MY1w9S4CsIWQ9gn
         q2V5eCsR9hR+k+cI6tiHJw3ZWW8IdML0ljS+VT2ww3pMJn4oNb73+prSvNEp5vAn8H
         cwB/f/uw2ZdIz0yedX1RNhdIu5Sjk4v4hTdhNjgu49FiHbCJwE3xTcFeI7OHfT3WHu
         DstzttEVG3+QLUL0L3VLFgG53joSceQKXEJAomX3g7F2tAKiMZphfZUoMJx1xNpEis
         8x8/xndNmQ/aw==
Message-ID: <953eb242-4d52-4cdc-8f7d-71af003778c5@collabora.com>
Date:   Tue, 5 Sep 2023 22:15:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] ASoC: cs35l41: Use devm_pm_runtime_enable()
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
 <20230902210621.1184693-10-cristian.ciocaltea@collabora.com>
 <20230905094535.GK103419@ediswmail.ad.cirrus.com>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20230905094535.GK103419@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 12:45, Charles Keepax wrote:
> On Sun, Sep 03, 2023 at 12:06:21AM +0300, Cristian Ciocaltea wrote:
>> Simplify runtime PM during probe by converting pm_runtime_enable() to
>> the managed version.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>> @@ -1376,7 +1379,6 @@ void cs35l41_remove(struct cs35l41_private *cs35l41)
>>  	cancel_work_sync(&cs35l41->mdsync_up_work);
>>  
>>  	pm_runtime_get_sync(cs35l41->dev);
>> -	pm_runtime_disable(cs35l41->dev);
>>  
>>  	regmap_write(cs35l41->regmap, CS35L41_IRQ1_MASK1, 0xFFFFFFFF);
>>  	if (cs35l41->hw_cfg.bst_type == CS35L41_SHD_BOOST_PASS ||
> 
> Are we sure this is safe? The remove handler appears to be
> written to disable pm_runtime at the start presumably to stop the
> resume/suspend handler running during the remove callback.
> Whereas after this change the pm_runtime isn't disabled until
> after the remove callback has run. Does this open a window were
> we could get an erroneous pm_runtime suspend after the
> pm_runtime_put_noidle?

I've just made a test adding a 6s sleep before returning from the remove 
handler: 

[14444.894316] cs35l41 spi-VLV1776:00: Runtime resume
[14444.894469] cs35l41 spi-VLV1776:00: sleep 6s before return of cs35l41_remove()
[14448.338994] cs35l41 spi-VLV1776:00: Runtime suspend
[14451.079649] cs35l41 spi-VLV1776:00: return from cs35l41_remove()
[14451.080129] cs35l41 spi-VLV1776:00: Runtime resume
[14451.080165] cs35l41 spi-VLV1776:00: ASoC: Unregistered DAI 'cs35l41-pcm'
[14451.080181] cs35l41 spi-VLV1776:00: Runtime suspend
[14451.813639] acp5x_i2s_playcap acp5x_i2s_playcap.0: ASoC: Unregistered DAI 'acp5x_i2s_playcap.0'

As expected, suspend triggered, but a resume was issued later, before DAI
got unregistered.

I didn't notice any issues while repeating the test several times, hence 
I wonder what would be the reason to prevent getting suspend/resume events 
at this point?

Thanks,
Cristian
