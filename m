Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22269812D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443741AbjLNKrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443738AbjLNKrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:47:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6555A10F;
        Thu, 14 Dec 2023 02:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702550865; x=1734086865;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aec2TwbH6Tp8RgodgqRz7F5TydcQWe862+obcvNGQMY=;
  b=Ar7erZYhq2KwNC7G68Jwdm528slfH6dclO80vgIvFayAH36TycsTjRHg
   WyscVxde+A4N0RFZqsyaNXjDlSHYXd18aKsCZMkuaxCLT9DY4mukNKMMS
   NuUIc0pqxt/CXf96tt7uvPaFi3AJz9X6C0DgEQ8zT/h/XT90q1McqfPDW
   jp7eN+o5iVwnb4Am6EJGg93Z/3Bn7QcOso6eiNt4wtt6LlDImtnSP35zE
   hbucJ+cEfDhud7mjn4zkU1gM9wEFfZmaH0HrN3MivqFRJaY06Oowjr2vu
   /OgRweUBGOkZWlWk7qYB9jGkpKMpFpyIZQYZE8EyA11HAGiBZxtw0izNG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="398938996"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="398938996"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 02:47:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1021470584"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="1021470584"
Received: from eborisov-mobl2.ger.corp.intel.com (HELO [10.249.34.72]) ([10.249.34.72])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 02:47:31 -0800
Message-ID: <6e52c5a2-24d5-422a-9a40-a0053729c98e@linux.intel.com>
Date:   Thu, 14 Dec 2023 12:48:13 +0200
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
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20231209205351.880797-8-cristian.ciocaltea@collabora.com>
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



On 09/12/2023 22:53, Cristian Ciocaltea wrote:
> Some SOF drivers like AMD ACP do not always rely on a single static
> firmware file, but may require multiple files having their names
> dynamically computed on probe time, e.g. based on chip name.

I see, AMD vangogh needs two binary files to be loaded sometimes, it is not using the default name as it hints via the sof_dev_desc ("sof-vangogh.ri").

The constructed names for the two files are just using different pattern:
sof-%PLAT%.ri
vs
sof-%PLAT%-code.bin
sof-%PLAT%-data.bin

iow, instead of the combined .ri file which includes the code and data segment it has 'raw' bin files and cannot use the core for loading the firmware.

What is the reason for this? an .ri file can have two 'modules' one to be written to IRAM the other to DRAM.
sof_ipc3_load_fw_to_dsp()

> In those cases, providing an invalid default_fw_filename in their
> sof_dev_desc struct will prevent probing due to 'SOF firmware
> and/or topology file not found' error.
 
> Fix the issue by allowing drivers to omit initialization for this member
> (or alternatively provide a dynamic override via ipc_file_profile_base)
> and update sof_test_firmware_file() to verify the given profile data and
> skip firmware testing if either fw_path or fw_name is not defined.
> 
> Fixes: 6c393ebbd74a ("ASoC: SOF: core: Implement IPC version fallback if firmware files are missing")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  sound/soc/sof/fw-file-profile.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/sof/fw-file-profile.c b/sound/soc/sof/fw-file-profile.c
> index 138a1ca2c4a8..e63700234df0 100644
> --- a/sound/soc/sof/fw-file-profile.c
> +++ b/sound/soc/sof/fw-file-profile.c
> @@ -21,6 +21,9 @@ static int sof_test_firmware_file(struct device *dev,
>  	const u32 *magic;
>  	int ret;
>  
> +	if (!profile->fw_path || !profile->fw_name || !*profile->fw_name)
> +		return 0;

I would rather make the firmware file skipping based on custom loader use and print a dev_dbg() alongside:

diff --git a/sound/soc/sof/fw-file-profile.c b/sound/soc/sof/fw-file-profile.c
index 138a1ca2c4a8..7b91c9551ada 100644
--- a/sound/soc/sof/fw-file-profile.c
+++ b/sound/soc/sof/fw-file-profile.c
@@ -89,6 +89,15 @@ static int sof_test_topology_file(struct device *dev,
 	return ret;
 }
 
+static bool sof_platform_uses_generic_loader(struct snd_sof_dev *sdev)
+{
+	if (sdev->pdata->desc->ops->load_firmware == snd_sof_load_firmware_raw ||
+	    sdev->pdata->desc->ops->load_firmware == snd_sof_load_firmware_memcpy)
+		return true;
+
+	return false;
+}
+
 static int
 sof_file_profile_for_ipc_type(struct snd_sof_dev *sdev,
 			      enum sof_ipc_type ipc_type,
@@ -130,7 +139,8 @@ sof_file_profile_for_ipc_type(struct snd_sof_dev *sdev,
 	 * For default path and firmware name do a verification before
 	 * continuing further.
 	 */
-	if (base_profile->fw_path || base_profile->fw_name) {
+	if ((base_profile->fw_path || base_profile->fw_name) &&
+	    sof_platform_uses_generic_loader(sdev)) {
 		ret = sof_test_firmware_file(dev, out_profile, &ipc_type);
 		if (ret)
 			return ret;
@@ -181,7 +191,8 @@ sof_file_profile_for_ipc_type(struct snd_sof_dev *sdev,
 	out_profile->ipc_type = ipc_type;
 
 	/* Test only default firmware file */
-	if (!base_profile->fw_path && !base_profile->fw_name)
+	if ((!base_profile->fw_path && !base_profile->fw_name) &&
+	    sof_platform_uses_generic_loader(sdev))
 		ret = sof_test_firmware_file(dev, out_profile, NULL);
 
 	if (!ret)
@@ -265,7 +276,9 @@ static void sof_print_profile_info(struct snd_sof_dev *sdev,
 			 "Using fallback IPC type %d (requested type was %d)\n",
 			 profile->ipc_type, ipc_type);
 
-	dev_info(dev, "Firmware paths/files for ipc type %d:\n", profile->ipc_type);
+	/* The firmware path only valid when generic loader is used */
+	if (sof_platform_uses_generic_loader(sdev))
+		dev_info(dev, "Firmware paths/files for ipc type %d:\n", profile->ipc_type);
 
 	dev_info(dev, " Firmware file:     %s/%s\n", profile->fw_path, profile->fw_name);
 	if (profile->fw_lib_path)

> +
>  	fw_filename = kasprintf(GFP_KERNEL, "%s/%s", profile->fw_path,
>  				profile->fw_name);
>  	if (!fw_filename)

checking for custom loader allows you to drop the next patch.
I would also skip the fw path printing in case of a custom loader.

-- 
Péter
