Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C2480D2FA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344183AbjLKQ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjLKQ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:56:24 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE015BD;
        Mon, 11 Dec 2023 08:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702313787;
        bh=UHAxHzAWe0eE9J7rlsFTxRyXjBw3RyM2beztcNyE+3c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hSYJ5ZSPxzWA44W5gp0fsrbvrrNBIrJqXspIX9zOlsBa5GKckBgSEJUpO/pXFz2aD
         363GKKi9JqB47wQWxgLoww5HWt6SxUWicPTWkn5etUbpAyrrpH8qtszNMwIeLPavAF
         iftr4LxTcBj+PBuJwOQ+JWWAgc22EYxsRw3Q5UvjJKjM4Q6K2xOtFU2L3GccaBs2WJ
         4tz7ALc5GVsblCJx9MUhQmR3YHRYM6hCBf2jY1qSfMMg2H2qr/6DPmbnEWp9BecpuD
         2E16GQZpBx34vqKimStyFGao3NhLnXgP7Tv1GEQDONJ0u3DzH/D9gzD8xTNf1RJNK7
         7rTF+ZnCaT8Xw==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6BE7F3781443;
        Mon, 11 Dec 2023 16:56:26 +0000 (UTC)
Message-ID: <07d71c9b-45e0-4d51-9449-68d40a46449e@collabora.com>
Date:   Mon, 11 Dec 2023 18:56:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] ASoC: amd: acp: Add missing error handling in
 sof-mach
Content-Language: en-US
To:     Emil Velikov <emil.velikov@collabora.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marian Postevca <posteuca@mutex.one>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
References: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
 <20231209205351.880797-4-cristian.ciocaltea@collabora.com>
 <ZXcPRc8xGKt4euth@arch-x395>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <ZXcPRc8xGKt4euth@arch-x395>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 15:31, Emil Velikov wrote:
> On 2023/12/09, Cristian Ciocaltea wrote:
>> Handle potential acp_sofdsp_dai_links_create() errors in ACP SOF machine
>> driver's probe function.  Additionally, switch to dev_err_probe().
>>
>> Fixes: 9f84940f5004 ("ASoC: amd: acp: Add SOF audio support on Chrome board")
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  sound/soc/amd/acp/acp-sof-mach.c | 14 ++++++--------
>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
>> index 1d313fcb5f2d..6f0ca23638af 100644
>> --- a/sound/soc/amd/acp/acp-sof-mach.c
>> +++ b/sound/soc/amd/acp/acp-sof-mach.c
>> @@ -112,16 +112,14 @@ static int acp_sof_probe(struct platform_device *pdev)
>>  	if (dmi_id && dmi_id->driver_data)
>>  		acp_card_drvdata->tdm_mode = dmi_id->driver_data;
>>  
>> -	acp_sofdsp_dai_links_create(card);
>> +	ret = acp_sofdsp_dai_links_create(card);
>> +	if (ret)
>> +		return dev_err_probe(&pdev->dev, ret, "Failed to create DAI links\n");
>>  
>>  	ret = devm_snd_soc_register_card(&pdev->dev, card);
>> -	if (ret) {
>> -		dev_err(&pdev->dev,
>> -				"devm_snd_soc_register_card(%s) failed: %d\n",
>> -				card->name, ret);
>> -		return ret;
>> -	}
>> -
>> +	if (ret)
> 
> Do we need to undo acp_sofdsp_dai_links_create() in here? If not, please
> add a trivial note in the commit message.

No need to undo, will update the commit as suggested.

> With that the series is:
> Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

Thanks for reviewing,
Cristian

> HTH o/
> -Emil
