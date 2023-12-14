Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054E1812F86
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444217AbjLNL5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444112AbjLNL5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:57:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27BF113;
        Thu, 14 Dec 2023 03:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702555029; x=1734091029;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EwxAgDZ2DcIp4KgA/vqROZ9HGMY7XaC0XxVc24lvUAQ=;
  b=Z301Fv0vlF1HRppWHOE6G9Gn6WfyHOmXqIoGk/z1s8a0UZd8SKC4NOGr
   9lz9368DxqiKJifwwHsySR5hJUg1JYvThvo8huA7DLxezmUOEfRoyYKoG
   byEti6HevEFzvzT2qFbG/MR17vyHwES+/x9k7FAfnG0OtBrp0pkruw8L9
   oXRv+HX7X4PIByovA9krpmYaoJiRHJvU8gEDuEZwM5w+uTWnsymrEye1S
   tuWoNSN2s9QesyY1kzSKVSWVU3wMNrQT18yXRYBixBxF0ntqrZ71cpIX2
   ioGQO2GITVyHscEpPbWbTK93/uk1E3eb3bjjNFbTXNjykOlBgtU12o9/4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="392283392"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="392283392"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 03:57:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="15826348"
Received: from eborisov-mobl2.ger.corp.intel.com (HELO [10.249.34.72]) ([10.249.34.72])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 03:57:03 -0800
Message-ID: <2c09e01b-777b-48ac-adf9-63d61e1a36fc@linux.intel.com>
Date:   Thu, 14 Dec 2023 13:57:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] ASoC: SOF: core: Skip firmware test for undefined
 fw_name
Content-Language: en-US
To:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
References: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
 <20231209205351.880797-8-cristian.ciocaltea@collabora.com>
 <6e52c5a2-24d5-422a-9a40-a0053729c98e@linux.intel.com>
 <d4cc684c-e4ad-4c73-8ce2-1091b2a733ab@amd.com>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <d4cc684c-e4ad-4c73-8ce2-1091b2a733ab@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/12/2023 12:58, Venkata Prasad Potturu wrote:
> 
> On 12/14/23 16:18, Péter Ujfalusi wrote:
> Thanks for your time Peter!
>>
>> On 09/12/2023 22:53, Cristian Ciocaltea wrote:
>>> Some SOF drivers like AMD ACP do not always rely on a single static
>>> firmware file, but may require multiple files having their names
>>> dynamically computed on probe time, e.g. based on chip name.
>> I see, AMD vangogh needs two binary files to be loaded sometimes, it
>> is not using the default name as it hints via the sof_dev_desc
>> ("sof-vangogh.ri").
>>
>> The constructed names for the two files are just using different pattern:
>> sof-%PLAT%.ri
>> vs
>> sof-%PLAT%-code.bin
>> sof-%PLAT%-data.bin
>>
>> iow, instead of the combined .ri file which includes the code and data
>> segment it has 'raw' bin files and cannot use the core for loading the
>> firmware.
>>
>> What is the reason for this? an .ri file can have two 'modules' one to
>> be written to IRAM the other to DRAM.
>> sof_ipc3_load_fw_to_dsp()
> 
> For AMD Vangogh platform devices signed firmware image is required, so
> split .ri image into code and data images.
> 
> Only Code.bin will be signed and loaded into corresponding IRAM location.

This is not different than what the Intel .ri files are made of. The
module which is to be loaded to IRAM is signed code the module which
goes to DRAM is not signed.
The loader itself is not looking into the sections of the .ri image, it
just parses the header and copies them where they belong.

if the issue is name collision then you could try to put the signed
firmware file under 'signed' folder (fw_path_postfix) of the platform
like Intel does with the community signed ones?

It would be great if somehow we can handle all of these in core, have
shared code and familiar prints among vendors, platforms..

Fwiw, I'm planning the path, filename creation to be moved to core for
the current platforms, but it implies that they do use single firmware file.
struct sof_dev_desc would only have two strings:
vendor - AMD / iMX / Intel / Mediatek
platform - tgl, vaggogh, etc

I need to adjust it based on what I have learned today about vangogh.

-- 
Péter
