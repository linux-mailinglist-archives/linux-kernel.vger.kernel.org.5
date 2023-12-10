Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5C480B9EA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 10:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjLJJGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 04:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjLJJGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 04:06:14 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3A3F4;
        Sun, 10 Dec 2023 01:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702199179;
        bh=uW/rENr9rJ72xW4QLUI1quOIaFyVpEXSWxkAjObZ5ok=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m5/pDMDnaVWEKRz1OFErA/xo6RQzHdNvSxZXsdF8ztBn5sPo7peugkqXDvArg4HMW
         eMREACvT8u0ocepS/u4CtnJsIqW6soMYha0EcueG1cmIxUhxOhzF1rhWKlaYQ3l9J6
         hsBGywNkoFHyjVM8hwRn20vhuy5/PUqA/N3DxDeUSXxm3Bc6MX8zTod23+QsDNDJf9
         wj0XXZjiSl5sIXDV87oX3kA/GcYk9zF+qOXEzwigLc9eeL72WZtCC86wMaThRh7nzF
         efsIHGPA5fgkBoQ1pUIVXOgymDeURskxOtfuxghvCfgHcWECS5e9E8tAXzuXX7crjb
         I1ILqmnPSg/2Q==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 27BA1378003D;
        Sun, 10 Dec 2023 09:06:18 +0000 (UTC)
Message-ID: <391d2476-8f4a-4670-a248-8d4d9c46ee09@collabora.com>
Date:   Sun, 10 Dec 2023 11:06:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] ASoC: amd: acp: Use correct DAI link ID for BT
 codec
Content-Language: en-US
To:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marian Postevca <posteuca@mutex.one>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
References: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
 <20231209205351.880797-11-cristian.ciocaltea@collabora.com>
 <8a218987-965b-4228-b1d1-f7c061d553ab@amd.com>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <8a218987-965b-4228-b1d1-f7c061d553ab@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/23 05:24, Venkata Prasad Potturu wrote:
> 
> On 12/10/23 02:23, Cristian Ciocaltea wrote:
>> Commit 671dd2ffbd8b ("ASoC: amd: acp: Add new cpu dai and dailink
>> creation for I2S BT instance") added I2S BT support in ACP common
>> machine driver, but using a wrong BT_BE_ID, i.e. 3 instead of 2:
>>
>> [ 7.799659] snd_sof_amd_vangogh 0000:04:00.5: Firmware info: version
>> 0:0:0-7863d
>> [ 7.803906] snd_sof_amd_vangogh 0000:04:00.5: Firmware: ABI 3:26:0
>> Kernel ABI 3:23:0
>> [ 7.872873] snd_sof_amd_vangogh 0000:04:00.5: Topology: ABI 3:26:0
>> Kernel ABI 3:23:0
>> [ 8.508218] sof_mach nau8821-max: ASoC: physical link acp-bt-codec (id
>> 2) not exist
>> [ 8.513468] sof_mach nau8821-max: ASoC: topology: could not load
>> header: -22
>> [ 8.518853] snd_sof_amd_vangogh 0000:04:00.5: error: tplg component
>> load failed -22
>> [ 8.524049] snd_sof_amd_vangogh 0000:04:00.5: error: failed to load
>> DSP topology -22
>> [ 8.529230] snd_sof_amd_vangogh 0000:04:00.5: ASoC: error at
>> snd_soc_component_probe on 0000:04:00.5: -22
>> [ 8.534465] sof_mach nau8821-max: ASoC: failed to instantiate card -22
>> [ 8.539820] sof_mach nau8821-max: error -EINVAL: Failed to register
>> card(sof-nau8821-max)
>> [ 8.545022] sof_mach: probe of nau8821-max failed with error -22
>>
>> Move BT_BE_ID to the correct position in the enum.
>>
>> Fixes: 671dd2ffbd8b ("ASoC: amd: acp: Add new cpu dai and dailink
>> creation for I2S BT instance")
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>   sound/soc/amd/acp/acp-mach.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
>> index a48546d8d407..0c18ccd29305 100644
>> --- a/sound/soc/amd/acp/acp-mach.h
>> +++ b/sound/soc/amd/acp/acp-mach.h
>> @@ -27,8 +27,8 @@
>>   enum be_id {
>>       HEADSET_BE_ID = 0,
>>       AMP_BE_ID,
>> -    DMIC_BE_ID,
>>       BT_BE_ID,
>> +    DMIC_BE_ID,
> This will break the other platforms as this same enum used in topology
> to create dailink.

If I understand this correctly, there is no consistency across firmware
regarding the IDs used for DAI link identification.  What would be the
suggested solution in this case?

Thanks,
Cristian

>>   };
>>     enum cpu_endpoints {
