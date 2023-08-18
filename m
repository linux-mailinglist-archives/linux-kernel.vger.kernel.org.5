Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3E4781066
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378647AbjHRQbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378665AbjHRQar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:30:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37323AAE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692376245; x=1723912245;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uI4dyA7C7/lXsadRB/ksiSuy+Lsb2LY07mjFSl/VibQ=;
  b=VX7+UaomKR4mfRDa0+qdKxA+UxO+D14RLMWQkhn9puGmWVWFMYLxvLJ4
   ElnISpJwgt4kD/UYrxsfwgQA7VngU+VHcOksYnvJU7KChHtjQSipU5O7X
   4FE2b39l5pQDINhSYKAYEjCNv3fhqA8EEwQFKw6umtTWSdvuiRczfGrJo
   PNAdx9U9TOeO+pQ4FJs2mnlpslbBntnEPl2+gDwJxPgrB2xctr5bpBQNv
   wkEi0S0VhfqVLLkvhFxMCzKEl5Tw4OK2Ddm1LL6chnQFF2y78Moq8qBbr
   uljMwsBxLvR/XWEXHxEoLaInTF7zVo4l33B82qt2n07aE3LU0mlrYlks9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="370597984"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="370597984"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 09:30:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="728648155"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="728648155"
Received: from enewberr-mobl.amr.corp.intel.com (HELO [10.212.37.100]) ([10.212.37.100])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 09:30:43 -0700
Message-ID: <9f910785-e856-1539-e3e4-c9817af5fe67@linux.intel.com>
Date:   Fri, 18 Aug 2023 11:30:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] ALSA: hda/tas2781: Add tas2781 HDA driver
Content-Language: en-US
To:     Shenghao Ding <shenghao-ding@ti.com>, tiwai@suse.de
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        kevin-lu@ti.com, 13916275206@139.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
        mengdong.lin@intel.com, baojun.xu@ti.com,
        thomas.gfeller@q-drop.com, peeyush@ti.com, navada@ti.com,
        broonie@kernel.org, gentuser@gmail.com
References: <20230818085558.1431-1-shenghao-ding@ti.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230818085558.1431-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code doesn't look too bad but needs a bit more work. There are quite
a few error handling issues, pm_runtime needs to be revisited and
ACPI/EFI as well.

> +enum calib_data {

tas2781_calib_data?

> +	R0_VAL = 0,
> +	INV_R0,
> +	R0LOW,
> +	POWER,
> +	TLIM,
> +	CALIB_MAX
> +};
> +
> +static int tas2781_get_i2c_res(struct acpi_resource *ares, void *data)
> +{
> +	struct tasdevice_priv *tas_priv = data;
> +	struct acpi_resource_i2c_serialbus *sb;
> +
> +	if (i2c_acpi_get_i2c_resource(ares, &sb)) {
> +		if (tas_priv->ndev < TASDEVICE_MAX_CHANNELS &&
> +			sb->slave_address != TAS2781_GLOBAL_ADDR) {
> +			tas_priv->tasdevice[tas_priv->ndev].dev_addr =
> +				(unsigned int)sb->slave_address;
> +			tas_priv->ndev++;
> +		}
> +	}
> +	return 1;
> +}
> +
> +static int tas2781_read_acpi(struct tasdevice_priv *p, const char *hid)
> +{
> +	struct acpi_device *adev;
> +	struct device *physdev;
> +	LIST_HEAD(resources);
> +	const char *sub;
> +	int ret;
> +
> +	adev = acpi_dev_get_first_match_dev(hid, NULL, -1);
> +	if (!adev) {
> +		dev_err(p->dev,
> +			"Failed to find an ACPI device for %s\n", hid);
> +		return -ENODEV;
> +	}

[1] need to take care of a resource leak here

> +	ret = acpi_dev_get_resources(adev, &resources, tas2781_get_i2c_res, p);
> +	if (ret < 0)
> +		goto err;

you return without doing acpi_dev_put(adev), and you are also doing a
put_device(physdev) which is not initialized yet.

NAK, this needs to be reworked since a simple...


> +
> +	acpi_dev_free_resource_list(&resources);
> +	strscpy(p->dev_name, hid, sizeof(p->dev_name));
> +	physdev = get_device(acpi_get_first_physical_node(adev));
> +	acpi_dev_put(adev);

... move ong those last two lines to [1]

> +
> +	/* No side-effect to the playback even if subsystem_id is NULL*/
> +	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
> +	if (IS_ERR(sub))
> +		sub = NULL;
> +
> +	p->acpi_subsystem_id = sub;
> +
> +	put_device(physdev);
> +
> +	return 0;
> +
> +err:
> +	dev_err(p->dev, "read acpi error, ret: %d\n", ret);
> +	put_device(physdev);
> +
> +	return ret;
> +}
> +
> +static void tas2781_hda_playback_hook(struct device *dev, int action)
> +{
> +	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
> +
> +	dev_dbg(tas_priv->dev, "%s: action = %d\n", __func__, action);
> +	switch (action) {
> +	case HDA_GEN_PCM_ACT_OPEN:
> +		pm_runtime_get_sync(dev);

test if this actually works?

> +		mutex_lock(&tas_priv->codec_lock);
> +		tasdevice_tuning_switch(tas_priv, 0);
> +		mutex_unlock(&tas_priv->codec_lock);
> +		break;
> +	case HDA_GEN_PCM_ACT_CLOSE:
> +		mutex_lock(&tas_priv->codec_lock);
> +		tasdevice_tuning_switch(tas_priv, 1);
> +		mutex_unlock(&tas_priv->codec_lock);

how useful is this codec_lock, is the 'action' not protected at a higher
level?

> +
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_autosuspend(dev);
> +		break;
> +	default:
> +		dev_dbg(tas_priv->dev, "Playback action not supported: %d\n",
> +			action);
> +		break;
> +	}
> +}

> +static int tasdevice_hda_clamp(int val, int max)
> +{
> +	if (val > max)
> +		val = max;
> +
> +	if (val < 0)
> +		val = 0;
> +	return val;
> +}

I've seen that macro in the TAS2783 code as well, that sounds like a
good helper function to share?

> +
> +static int tasdevice_set_profile_id(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
> +	int nr_profile = ucontrol->value.integer.value[0];
> +	int max = tas_priv->rcabin.ncfgs - 1;
> +	int val, ret = 0;
> +
> +	val = tasdevice_hda_clamp(nr_profile, max);
> +
> +	if (tas_priv->rcabin.profile_cfg_id != nr_profile) {
> +		tas_priv->rcabin.profile_cfg_id = nr_profile;
> +		ret = 1;

return 1;
> +	}
> +
> +	return ret;

return 0;

you don't really need a variable here. same comment for other usages.


> +static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
> +{
> +	static const unsigned char page_array[CALIB_MAX] = {
> +		0x17, 0x18, 0x18, 0x0d, 0x18
> +	};
> +	static const unsigned char rgno_array[CALIB_MAX] = {
> +		0x74, 0x0c, 0x14, 0x3c, 0x7c
> +	};
> +	unsigned char *data;
> +	int i, j, rc;
> +
> +	for (i = 0; i < tas_priv->ndev; i++) {
> +		data = tas_priv->cali_data.data +
> +			i * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
> +		for (j = 0; j < CALIB_MAX; j++) {
> +			rc = tasdevice_dev_bulk_write(tas_priv, i,
> +				TASDEVICE_REG(0, page_array[j], rgno_array[j]),
> +				&(data[4 * j]), 4);
> +			if (rc < 0)
> +				dev_err(tas_priv->dev,
> +					"chn %d calib %d bulk_wr err = %d\n",
> +					i, j, rc);

do you want to keep going or just stop on the first error?

> +		}
> +	}
> +}
> +
> +/* Update the calibrate data, including speaker impedance, f0, etc, into algo.
> + * Calibrate data is done by manufacturer in the factory. These data are used
> + * by Algo for calucating the speaker temperature, speaker membrance excursion

typos, use a spell checker.

calculation
membrane

> + * and f0 in real time during playback.
> + */
> +static int tas2781_save_calibration(struct tasdevice_priv *tas_priv)
> +{
> +	efi_guid_t efi_guid = EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d,
> +		0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3);

I've seen an EFI use for SoundWire TAS2783, is this the same thing?
It looks very very similar except that this one checks the BUFFER_TOO_SMALL.

If yes, can this be a helper function? If this is the same sort of
calibration we should not have duplicated code really, it's easier to
maintain if there's one set of helpers shared between TI drivers.

> +	static efi_char16_t efi_name[] = L"CALI_DATA";
> +	struct tm *tm = &tas_priv->tm;
> +	unsigned int attr, crc;
> +	unsigned int *tmp_val;
> +	efi_status_t status;
> +
> +	/* Lenovo devices */
> +	if (tas_priv->catlog_id == LENOVO)
> +		efi_guid = EFI_GUID(0x1f52d2a1, 0xbb3a, 0x457d, 0xbc, 0x09,
> +			0x43, 0xa3, 0xf4, 0x31, 0x0a, 0x92);
> +
> +	tas_priv->cali_data.total_sz = 0;
> +	/* Get real size of UEFI variable */
> +	status = efi.get_variable(efi_name, &efi_guid, &attr,
> +		&tas_priv->cali_data.total_sz, tas_priv->cali_data.data);
> +	if (status == EFI_BUFFER_TOO_SMALL) {
> +		/* Allocate data buffer of data_size bytes */
> +		tas_priv->cali_data.data = devm_kzalloc(tas_priv->dev,
> +			tas_priv->cali_data.total_sz, GFP_KERNEL);
> +		if (!tas_priv->cali_data.data)
> +			return -ENOMEM;
> +		/* Get variable contents into buffer */
> +		status = efi.get_variable(efi_name, &efi_guid, &attr,
> +			&tas_priv->cali_data.total_sz,
> +			tas_priv->cali_data.data);
> +		if (status != EFI_SUCCESS)
> +			return -EINVAL;
> +	}
> +
> +	tmp_val = (unsigned int *)tas_priv->cali_data.data;
> +
> +	crc = crc32(~0, tas_priv->cali_data.data, 84) ^ ~0;
> +	dev_dbg(tas_priv->dev, "cali crc 0x%08x PK tmp_val 0x%08x\n",
> +		crc, tmp_val[21]);
> +
> +	if (crc == tmp_val[21]) {
> +		time64_to_tm(tmp_val[20], 0, tm);
> +		dev_dbg(tas_priv->dev, "%4ld-%2d-%2d, %2d:%2d:%2d\n",
> +			tm->tm_year, tm->tm_mon, tm->tm_mday,
> +			tm->tm_hour, tm->tm_min, tm->tm_sec);
> +		tas2781_apply_calib(tas_priv);
> +	} else
> +		tas_priv->cali_data.total_sz = 0;
> +
> +	return 0;
> +}
> +
> +static void tasdev_fw_ready(const struct firmware *fmw, void *context)
> +{
> +	struct tasdevice_priv *tas_priv = context;
> +	struct hda_codec *codec = tas_priv->codec;
> +	int i, ret;
> +
> +	pm_runtime_get_sync(tas_priv->dev);

test that it worked?

> +	mutex_lock(&tas_priv->codec_lock);

...

> +static int tas2781_hda_bind(struct device *dev, struct device *master,
> +	void *master_data)
> +{
> +	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
> +	struct hda_component *comps = master_data;
> +	struct hda_codec *codec;
> +	unsigned int subid;
> +	int ret;
> +
> +	if (!comps || tas_priv->index < 0 ||
> +		tas_priv->index >= HDA_MAX_COMPONENTS)
> +		return -EINVAL;
> +
> +	comps = &comps[tas_priv->index];
> +	if (comps->dev)
> +		return -EBUSY;
> +
> +	codec = comps->codec;
> +	subid = codec->core.subsystem_id >> 16;
> +
> +	switch (subid) {
> +	case 0x17aa:

magic number should be a define somewhere...

> +		tas_priv->catlog_id = LENOVO;
> +		break;
> +	default:
> +		tas_priv->catlog_id = OTHERS;
> +		break;
> +	}
> +
> +	pm_runtime_get_sync(dev);

test that it worked?

> +
> +	comps->dev = dev;
> +
> +	strscpy(comps->name, dev_name(dev), sizeof(comps->name));
> +
> +	ret = tascodec_init(tas_priv, codec, tasdev_fw_ready);
> +	if (ret)
> +		return ret;

need to do a put_autosuspend below, this is leaking a refcount.

> +
> +	comps->playback_hook = tas2781_hda_playback_hook;
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return 0;
> +}
> +
> +static void tas2781_hda_unbind(struct device *dev,
> +	struct device *master, void *master_data)
> +{
> +	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
> +	struct hda_component *comps = master_data;
> +
> +	if (comps[tas_priv->index].dev == dev)
> +		memset(&comps[tas_priv->index], 0, sizeof(*comps));
> +
> +	tasdevice_config_info_remove(tas_priv);
> +	tasdevice_dsp_remove(tas_priv);
> +
> +	tas_priv->fw_state = TASDEVICE_DSP_FW_PENDING;
> +}
> +
> +static const struct component_ops tas2781_hda_comp_ops = {
> +	.bind = tas2781_hda_bind,
> +	.unbind = tas2781_hda_unbind,
> +};
> +
> +static void tas2781_hda_remove(struct device *dev)
> +{
> +	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
> +
> +	pm_runtime_get_sync(tas_priv->dev);
> +	pm_runtime_disable(tas_priv->dev);

I don't think this sequence makes any sense.

> +	component_del(tas_priv->dev, &tas2781_hda_comp_ops);
> +
> +	pm_runtime_put_noidle(tas_priv->dev);
> +
> +	tasdevice_remove(tas_priv);
> +}
> +
> +static int tas2781_hda_i2c_probe(struct i2c_client *clt)
> +{
> +	struct tasdevice_priv *tas_priv;
> +	const char *device_name;
> +	int ret;
> +
> +	if (strstr(dev_name(&clt->dev), "TIAS2781"))
> +		device_name = "TIAS2781";
> +	else
> +		return -ENODEV;
> +
> +	tas_priv = tasdevice_kzalloc(clt);
> +	if (!tas_priv)
> +		return -ENOMEM;
> +
> +	tas_priv->irq_info.irq = clt->irq;
> +	ret = tas2781_read_acpi(tas_priv, device_name);
> +	if (ret)
> +		return dev_err_probe(tas_priv->dev, ret,
> +			"Platform not supported\n");
> +
> +	ret = tasdevice_init(tas_priv);
> +	if (ret)
> +		goto err;
> +
> +	pm_runtime_set_autosuspend_delay(tas_priv->dev, 3000);
> +	pm_runtime_use_autosuspend(tas_priv->dev);
> +	pm_runtime_mark_last_busy(tas_priv->dev);
> +	pm_runtime_set_active(tas_priv->dev);
> +	pm_runtime_get_noresume(tas_priv->dev);

this ..

> +	pm_runtime_enable(tas_priv->dev);
> +
> +	pm_runtime_put_autosuspend(tas_priv->dev);

and this should be removed IMHO. it makes no sense to me.

> +
> +	ret = component_add(tas_priv->dev, &tas2781_hda_comp_ops);
> +	if (ret) {
> +		dev_err(tas_priv->dev, "Register component failed: %d\n", ret);
> +		pm_runtime_disable(tas_priv->dev);
> +		goto err;
> +	}
> +
> +	tas2781_reset(tas_priv);
> +err:
> +	if (ret)
> +		tas2781_hda_remove(&clt->dev);
> +	return ret;
> +}
> +
> +static void tas2781_hda_i2c_remove(struct i2c_client *clt)
> +{
> +	tas2781_hda_remove(&clt->dev);

so for symmetry that's where pm_runtime needs to be disabled.


> +static int tas2781_system_suspend(struct device *dev)
> +{
> +	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
> +	int ret;
> +
> +	dev_dbg(tas_priv->dev, "System Suspend\n");
> +
> +	ret = pm_runtime_force_suspend(dev);
> +	if (ret)
> +		return ret;

that's usually the other way around, for system suspend you either want
the device to be pm_runtime active, or if it's already suspended do nothing.

This is very odd to me.

> +
> +	/* Shutdown chip before system suspend */
> +	regcache_cache_only(tas_priv->regmap, false);
> +	tasdevice_tuning_switch(tas_priv, 1);
> +	regcache_cache_only(tas_priv->regmap, true);
> +	regcache_mark_dirty(tas_priv->regmap);
> +
> +	/*
> +	 * Reset GPIO may be shared, so cannot reset here.
> +	 * However beyond this point, amps may be powered down.
> +	 */
> +	return 0;
> +}
> +
> +static int tas2781_system_resume(struct device *dev)
> +{
> +	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
> +	unsigned long calib_data_sz =
> +		tas_priv->ndev * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
> +	int i, ret;
> +
> +	dev_dbg(tas_priv->dev, "System Resume\n");
> +
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret)
> +		return ret;

that's also not quite right IMHO, this doesn't follow the recommended
sequences for power management.

> +
> +	mutex_lock(&tas_priv->codec_lock);
> +
> +	for (i = 0; i < tas_priv->ndev; i++) {
> +		tas_priv->tasdevice[i].cur_book = -1;
> +		tas_priv->tasdevice[i].cur_prog = -1;
> +		tas_priv->tasdevice[i].cur_conf = -1;
> +	}
> +	tas2781_reset(tas_priv);
> +	tasdevice_prmg_load(tas_priv, tas_priv->cur_prog);
> +
> +	/* If calibrated data occurs error, dsp will still work with default
> +	 * calibrated data inside algo.
> +	 */
> +	if (tas_priv->cali_data.total_sz > calib_data_sz)
> +		tas2781_apply_calib(tas_priv);
> +	mutex_unlock(&tas_priv->codec_lock);
> +
> +	return 0;
> +}

> +MODULE_IMPORT_NS(SND_SOC_TAS2781_FMWLIB);
