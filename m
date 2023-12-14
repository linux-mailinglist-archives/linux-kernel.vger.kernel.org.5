Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A19812ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444195AbjLNLlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444242AbjLNLkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:40:41 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCA610C2;
        Thu, 14 Dec 2023 03:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702554027;
        bh=pWKh0WpJyhWUe3oAtVyrdzfiymCLNQYAenxJSqJSsdM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ai3KFrXxjAf4/a6af7UpuOR7LVz1+eX4jdJ9Q0gaAnKukwifrFkm9luF4nHj10UQn
         KR7EElqUGBsjhonPD6rrnFiW22HPSQgDFM3OXct5zdOk+LAKylZrwu2OuKQn3oKJue
         IDNtuV2Xv/74Q/InqsDlfXdI0SRPAamR9Bcx/YPXsgX/hV/gdwmlHB5AUhn8iPxMDF
         iFw+dXaUb0TcyE+uoNtnLnemwKCDIm25boLB1Vlryi2a6qxksTMIHwsn/hDsXICrPs
         RCJUjUFIeja6wjAYSNidzXEx5fbU0c0xEOHbDg556fBsk75Hwq/Ken/gMiSSrBZIDG
         qMCbcYU4oEi9Q==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 306B2378147F;
        Thu, 14 Dec 2023 11:40:26 +0000 (UTC)
Message-ID: <d112d7dd-de80-4c5b-9600-039758c56352@collabora.com>
Date:   Thu, 14 Dec 2023 13:40:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] ASoC: SOF: core: Skip firmware test for undefined
 fw_name
Content-Language: en-US
To:     =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
References: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
 <20231209205351.880797-8-cristian.ciocaltea@collabora.com>
 <6e52c5a2-24d5-422a-9a40-a0053729c98e@linux.intel.com>
 <81af6357-8338-4768-a180-305516ac89e3@collabora.com>
 <40d92933-c9f0-472f-b5dc-f95b087cdb3e@linux.intel.com>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <40d92933-c9f0-472f-b5dc-f95b087cdb3e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/23 13:35, Péter Ujfalusi wrote:
> 
> 
> On 14/12/2023 13:29, Cristian Ciocaltea wrote:
>>> diff --git a/sound/soc/sof/fw-file-profile.c b/sound/soc/sof/fw-file-profile.c
>>> index 138a1ca2c4a8..7b91c9551ada 100644
>>> --- a/sound/soc/sof/fw-file-profile.c
>>> +++ b/sound/soc/sof/fw-file-profile.c
>>> @@ -89,6 +89,15 @@ static int sof_test_topology_file(struct device *dev,
>>>  	return ret;
>>>  }
>>>  
>>> +static bool sof_platform_uses_generic_loader(struct snd_sof_dev *sdev)
>>> +{
>>> +	if (sdev->pdata->desc->ops->load_firmware == snd_sof_load_firmware_raw ||
>>> +	    sdev->pdata->desc->ops->load_firmware == snd_sof_load_firmware_memcpy)
>>> +		return true;
>>> +
>>> +	return false;
>>> +}
>>
>> I would drop the conditional and simply return.
> 
> What do you mean? We need to check if the platform is using either type
> of the generic load_firmware helper (the _memcpy is calling the _raw to
> load the file).

I mean to simply replace the if statement with:

static bool sof_platform_uses_generic_loader(struct snd_sof_dev *sdev)
{
    return (sdev->pdata->desc->ops->load_firmware == snd_sof_load_firmware_raw ||
	    sdev->pdata->desc->ops->load_firmware == snd_sof_load_firmware_memcpy);
}
