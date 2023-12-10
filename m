Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3AB80B9EB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 10:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjLJImV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 03:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjLJImU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 03:42:20 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D4CF1;
        Sun, 10 Dec 2023 00:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702197744;
        bh=eVqRha9S4eH+hUMl2/N8MqL1Jl7s7jOhXFhWXN+Pd/8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gIjN6GglyVLxfCebB2ngOFN8TJsye6gJPvPTpKfKSBf2ps1iVnPjyPCHfJUklJneX
         LVvk7/riklO2DBq51YULf4g41rxD32RLrc5Z17UY1kRqavsIKSxA4YTtENZgKOvtSH
         L5ZyDmpJVzvq5urmBTRyS1955ekjPh9+o3vVswqx4lzHSxhBRNKd7kp+o+XeoRKQyo
         fXatyrKjJS8oTuQvprdHFFhbOvQldUIyQcPrElWPmTtRDUypQhH5paElT4YIjcNvL/
         s/y6gEDGJBp6dHsHmKIF3U+dgFJLQsxdOSXL4ba66ETsR/sU0+wxQvvkaHTiJJV+WF
         Fxfbc03Q7tPbg==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id B6D25378003D;
        Sun, 10 Dec 2023 08:42:22 +0000 (UTC)
Message-ID: <b0ac4887-6e29-47c6-a213-318b28230cf8@collabora.com>
Date:   Sun, 10 Dec 2023 10:42:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] ASoC: SOF: amd: Optimize quirk for Valve Galileo
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
 <20231209205351.880797-7-cristian.ciocaltea@collabora.com>
 <c3a3995b-8fae-495f-9701-62b095692b9c@amd.com>
Content-Language: en-US
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <c3a3995b-8fae-495f-9701-62b095692b9c@amd.com>
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

On 12/10/23 05:33, Venkata Prasad Potturu wrote:
> 
> On 12/10/23 02:23, Cristian Ciocaltea wrote:
>> Valve's Steam Deck OLED is uniquely identified by vendor and product
>> name (Galileo) DMI fields.
>>
>> Simplify the quirk by removing the unnecessary match on product family.
>>
>> Additionally, fix the related comment as it points to the old product
>> variant.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>   sound/soc/sof/amd/acp.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
>> index c6f637f29847..1e9840ae8938 100644
>> --- a/sound/soc/sof/amd/acp.c
>> +++ b/sound/soc/sof/amd/acp.c
>> @@ -28,11 +28,10 @@ MODULE_PARM_DESC(enable_fw_debug, "Enable Firmware
>> debug");
>>     const struct dmi_system_id acp_sof_quirk_table[] = {
>>       {
>> -        /* Valve Jupiter device */
>> +        /* Steam Deck OLED device */
> If any changes in SOF drivers, first need to create a PR in SOF github.

This is just an optimization for the driver, no need to change anything
on the firmware side.  The product family remains as is, but it's not
really required to match the board, i.e. the previous board was
"Jupiter", the next one will have a different product name.

>>           .matches = {
>>               DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
>>               DMI_MATCH(DMI_PRODUCT_NAME, "Galileo"),
>> -            DMI_MATCH(DMI_PRODUCT_FAMILY, "Sephiroth"),
>>           },
>>           .driver_data = (void *)SECURED_FIRMWARE,
>>       },
