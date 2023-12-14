Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2D3812F73
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444197AbjLNLwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572879AbjLNLvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:51:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA4E121;
        Thu, 14 Dec 2023 03:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702554715; x=1734090715;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7DIzJoA783ehSXZq5QT19MaDC2Kt/5kl2+bQRbjAKow=;
  b=UMeqVj3i7WiX7Mb5hnEaX5Stb2IwpT017ZFb5FQQ0IokmIfr9Pur1Bwz
   McE2tjIMO/U84WsJIGTEQG5pjezrM1YDgWcAHzr+i7+9cswG2S+ybycYo
   C2FSFdbQhoj27kWj6uqUn3YIBkjzG+HVlHoSzjXQwiWw11tAV62J+8h6j
   vjWIC0ec/hH0fdnHOGJY5Gkr94QEj+SE05LVhFsHe4t8Qka3Cimz5wwf0
   BUmZuz16RQKfbmjwH2FqvKfiNAStu+1s+iKgiF/BF8zUPa65YzvIY8cCS
   pNo8uz0hW2WH8fhprkzhKFsTv/zdGvT3+ZpgQQ2P667mPX//XU6Cj9yBP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="375263569"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="375263569"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 03:51:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="777874832"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="777874832"
Received: from eborisov-mobl2.ger.corp.intel.com (HELO [10.249.34.72]) ([10.249.34.72])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 03:51:49 -0800
Message-ID: <df852f40-bc4a-4071-87f8-c8cb885d68ed@linux.intel.com>
Date:   Thu, 14 Dec 2023 13:52:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] ASoC: SOF: core: Skip firmware test for undefined
 fw_name
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
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
 <d112d7dd-de80-4c5b-9600-039758c56352@collabora.com>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <d112d7dd-de80-4c5b-9600-039758c56352@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/12/2023 13:40, Cristian Ciocaltea wrote:
> On 12/14/23 13:35, Péter Ujfalusi wrote:
>>
>>
>> On 14/12/2023 13:29, Cristian Ciocaltea wrote:
>>>> diff --git a/sound/soc/sof/fw-file-profile.c b/sound/soc/sof/fw-file-profile.c
>>>> index 138a1ca2c4a8..7b91c9551ada 100644
>>>> --- a/sound/soc/sof/fw-file-profile.c
>>>> +++ b/sound/soc/sof/fw-file-profile.c
>>>> @@ -89,6 +89,15 @@ static int sof_test_topology_file(struct device *dev,
>>>>  	return ret;
>>>>  }
>>>>  
>>>> +static bool sof_platform_uses_generic_loader(struct snd_sof_dev *sdev)
>>>> +{
>>>> +	if (sdev->pdata->desc->ops->load_firmware == snd_sof_load_firmware_raw ||
>>>> +	    sdev->pdata->desc->ops->load_firmware == snd_sof_load_firmware_memcpy)
>>>> +		return true;
>>>> +
>>>> +	return false;
>>>> +}
>>>
>>> I would drop the conditional and simply return.
>>
>> What do you mean? We need to check if the platform is using either type
>> of the generic load_firmware helper (the _memcpy is calling the _raw to
>> load the file).
> 
> I mean to simply replace the if statement with:
> 
> static bool sof_platform_uses_generic_loader(struct snd_sof_dev *sdev)
> {
>     return (sdev->pdata->desc->ops->load_firmware == snd_sof_load_firmware_raw ||
> 	    sdev->pdata->desc->ops->load_firmware == snd_sof_load_firmware_memcpy);
> }

ah, OK.

-- 
Péter
