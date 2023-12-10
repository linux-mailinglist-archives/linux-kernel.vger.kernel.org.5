Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E1080B9E9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 10:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjLJI4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 03:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjLJI4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 03:56:48 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBB2F4;
        Sun, 10 Dec 2023 00:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702198613;
        bh=lqGYKJw/kRTGAKFCWWkGxAyUhMxvNyb2tHR32sdfgus=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UKGqnFZsp4D7sbv0ZNYAin7rL7xqWgOl4fnzlVMvWnG5KwtolGVnVa8mbp08hAfkn
         YppbiKjwDu/sM+cQtxkn37Ol/68YriygnRTpPTnNVmh3MEcdejbXu7YH/n8LUyuSj/
         Vv+1Z2/Nb/KW99KaLwh3r/jGtW05jZLfWNEkBtUnBOrP6O67mB7cZ2NQi1SCJ30A58
         vZILBzmUX8HSl3MZYVGga4sVhfNf2Ehw0VIWZ9bbN1Jk+3a6F0Bm4h9aX4Vlx2QrdP
         Ux77vZuVuGCKPXVivVX/PqiMfpuHNvNfpQMTu++7kKyKqpqvCjIdfwki3XkRq8Rj14
         EegslCvxeOtHg==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id CB8193780C35;
        Sun, 10 Dec 2023 08:56:51 +0000 (UTC)
Message-ID: <4d6760c3-6931-4ab3-bda7-408801ad77e1@collabora.com>
Date:   Sun, 10 Dec 2023 10:56:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] ASoC: SOF: amd: Compute file paths on firmware load
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
 <20231209205351.880797-10-cristian.ciocaltea@collabora.com>
 <6e25398f-9a3d-4cad-a66a-ebe43a723843@amd.com>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <6e25398f-9a3d-4cad-a66a-ebe43a723843@amd.com>
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

On 12/10/23 05:50, Venkata Prasad Potturu wrote:
> 
> On 12/10/23 02:23, Cristian Ciocaltea wrote:
>> Commit 6c393ebbd74a ("ASoC: SOF: core: Implement IPC version fallback if
>> firmware files are missing") changed the order of some operations and
>> the firmware paths are not available anymore at snd_sof_probe() time.
>>
>> Precisely, fw_filename_prefix is set by sof_select_ipc_and_paths() via
>>
>>    plat_data->fw_filename_prefix = out_profile.fw_path;
>>
>> but sof_init_environment() which calls this function was moved from
>> snd_sof_device_probe() to sof_probe_continue(). Moreover,
>> snd_sof_probe() was moved from sof_probe_continue() to
>> sof_init_environment(), but before the call to
>> sof_select_ipc_and_paths().
>>
>> The problem here is that amd_sof_acp_probe() uses fw_filename_prefix to
>> compute fw_code_bin and fw_data_bin paths, and because the field is not
>> yet initialized, the paths end up containing (null):
>>
>> snd_sof_amd_vangogh 0000:04:00.5: Direct firmware load for
>> (null)/sof-vangogh-code.bin failed with error -2
>> snd_sof_amd_vangogh 0000:04:00.5: sof signed firmware code bin is missing
>> snd_sof_amd_vangogh 0000:04:00.5: error: failed to load DSP firmware -2
>> snd_sof_amd_vangogh: probe of 0000:04:00.5 failed with error -2
>>
>> Move usage of fw_filename_prefix right before request_firmware() calls
>> in acp_sof_load_signed_firmware().
>>
>> Fixes: 6c393ebbd74a ("ASoC: SOF: core: Implement IPC version fallback
>> if firmware files are missing")
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>   sound/soc/sof/amd/acp-loader.c | 32 ++++++++++++++++++++++++++------
>>   sound/soc/sof/amd/acp.c        |  7 ++-----
>>   2 files changed, 28 insertions(+), 11 deletions(-)
>>
>> diff --git a/sound/soc/sof/amd/acp-loader.c
>> b/sound/soc/sof/amd/acp-loader.c
>> index e05eb7a86dd4..d2d21478399e 100644
>> --- a/sound/soc/sof/amd/acp-loader.c
>> +++ b/sound/soc/sof/amd/acp-loader.c
>> @@ -267,29 +267,49 @@ int acp_sof_load_signed_firmware(struct
>> snd_sof_dev *sdev)
>>   {
>>       struct snd_sof_pdata *plat_data = sdev->pdata;
>>       struct acp_dev_data *adata = plat_data->hw_pdata;
>> +    const char *fw_filename;
>>       int ret;
>>   -    ret = request_firmware(&sdev->basefw.fw, adata->fw_code_bin,
>> sdev->dev);
>> +    fw_filename = kasprintf(GFP_KERNEL, "%s/%s",
>> +                plat_data->fw_filename_prefix,
>> +                adata->fw_code_bin);
> File path already saved in adata->fw_code_bin in amd_sof_acp_probe
> function.
> No need to get it again.

As already stated in the patch description, fw_filename_prefix is not
available anymore when amd_sof_acp_probe() gets invoked, and that is the
root cause of ending up with (null) in the computed file path.

Hence, the patch ensures amd_sof_acp_probe() computes the file name,
without prefix, while acp_sof_load_signed_firmware() adds the prefix.

>> +    if (!fw_filename)
>> +        return -ENOMEM;
>> +
>> +    ret = request_firmware(&sdev->basefw.fw, fw_filename, sdev->dev);
>>       if (ret < 0) {
>> +        kfree(fw_filename);
>>           dev_err(sdev->dev, "sof signed firmware code bin is
>> missing\n");
>>           return ret;
>>       } else {
>> -        dev_dbg(sdev->dev, "request_firmware %s successful\n",
>> adata->fw_code_bin);
>> +        dev_dbg(sdev->dev, "request_firmware %s successful\n",
>> fw_filename);
>>       }
>> +    kfree(fw_filename);
>> +
>>       ret = snd_sof_dsp_block_write(sdev, SOF_FW_BLK_TYPE_IRAM, 0,
>> -                      (void *)sdev->basefw.fw->data,
>> sdev->basefw.fw->size);
>> +                      (void *)sdev->basefw.fw->data,
>> +                      sdev->basefw.fw->size);
>> +
>> +    fw_filename = kasprintf(GFP_KERNEL, "%s/%s",
>> +                plat_data->fw_filename_prefix,
>> +                adata->fw_data_bin);
>> +    if (!fw_filename)
>> +        return -ENOMEM;
>>   -    ret = request_firmware(&adata->fw_dbin, adata->fw_data_bin,
>> sdev->dev);
>> +    ret = request_firmware(&adata->fw_dbin, fw_filename, sdev->dev);
>>       if (ret < 0) {
>> +        kfree(fw_filename);
>>           dev_err(sdev->dev, "sof signed firmware data bin is
>> missing\n");
>>           return ret;
>>         } else {
>> -        dev_dbg(sdev->dev, "request_firmware %s successful\n",
>> adata->fw_data_bin);
>> +        dev_dbg(sdev->dev, "request_firmware %s successful\n",
>> fw_filename);
>>       }
>> +    kfree(fw_filename);
>>         ret = snd_sof_dsp_block_write(sdev, SOF_FW_BLK_TYPE_DRAM, 0,
>> -                      (void *)adata->fw_dbin->data,
>> adata->fw_dbin->size);
>> +                      (void *)adata->fw_dbin->data,
>> +                      adata->fw_dbin->size);
>>       return ret;
>>   }
>>   EXPORT_SYMBOL_NS(acp_sof_load_signed_firmware, SND_SOC_SOF_AMD_COMMON);
>> diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
>> index 1e9840ae8938..87c5c71eac68 100644
>> --- a/sound/soc/sof/amd/acp.c
>> +++ b/sound/soc/sof/amd/acp.c
>> @@ -479,7 +479,6 @@ EXPORT_SYMBOL_NS(amd_sof_acp_resume,
>> SND_SOC_SOF_AMD_COMMON);
>>   int amd_sof_acp_probe(struct snd_sof_dev *sdev)
>>   {
>>       struct pci_dev *pci = to_pci_dev(sdev->dev);
>> -    struct snd_sof_pdata *plat_data = sdev->pdata;
>>       struct acp_dev_data *adata;
>>       const struct sof_amd_acp_desc *chip;
>>       const struct dmi_system_id *dmi_id;
>> @@ -547,8 +546,7 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
>>       dmi_id = dmi_first_match(acp_sof_quirk_table);
>>       if (dmi_id && dmi_id->driver_data) {
>>           adata->fw_code_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
>> -                            "%s/sof-%s-code.bin",
>> -                            plat_data->fw_filename_prefix,
>> +                            "sof-%s-code.bin",
>>                               chip->name);
>>           if (!adata->fw_code_bin) {
>>               ret = -ENOMEM;
>> @@ -556,8 +554,7 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
>>           }
>>             adata->fw_data_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
>> -                            "%s/sof-%s-data.bin",
>> -                            plat_data->fw_filename_prefix,
>> +                            "sof-%s-data.bin",
>>                               chip->name);
>>           if (!adata->fw_data_bin) {
>>               ret = -ENOMEM;
