Return-Path: <linux-kernel+bounces-25563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D89B82D2B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFE5280D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 00:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44B87E5;
	Mon, 15 Jan 2024 00:20:28 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9408622
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b690f0.dsl.pool.telekom.hu [::ffff:81.182.144.240])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000729F0.0000000065A47A40.0017185F; Mon, 15 Jan 2024 01:20:16 +0100
Message-ID: <11ee62a4d18bb6ae998b9a5f9aa888aeef2f8bf4.camel@irl.hu>
Subject: Re: [PATCH v5] ASoc: tas2783: Add tas2783 codec driver
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com,
  perex@perex.cz, pierre-louis.bossart@linux.intel.com,
  13916275206@139.com, alsa-devel@alsa-project.org,
  linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
  mengdong.lin@intel.com, yung-chuan.liao@linux.intel.com,
  baojun.xu@ti.com, kevin-lu@ti.com, peeyush@ti.com, navada@ti.com,
  tiwai@suse.de
Date: Mon, 15 Jan 2024 01:20:16 +0100
In-Reply-To: <20240113114944.1043-1-shenghao-ding@ti.com>
References: <20240113114944.1043-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Shenghao,

On Sat, 2024-01-13 at 19:49 +0800, Shenghao Ding wrote:
..

> +static const unsigned int tas2783_cali_reg[] =3D {
> +	TAS2783_CALIBRATION_RE,		/* Resistance */
> +	TAS2783_CALIBRATION_RE_LOW,	/* Low limitation of RE */
> +	TAS2783_CALIBRATION_INV_RE,	/* Reciprocal of RE */
> +	TAS2783_CALIBRATION_POW,	/* RMS Power */
> +	TAS2783_CALIBRATION_TLIMIT	/* Temperature limitation */
> +};
..
> +static void tas2783_apply_calib(struct tasdevice_priv *tas_dev,
> +	unsigned int *cali_data)
> +{
> +	struct regmap *map =3D tas_dev->regmap;
> +	u8 *reg_start;
> +	int ret;
> +
> +	if (!tas_dev->sdw_peripheral) {
> +		dev_err(tas_dev->dev, "%s, slaver doesn't exist.\n",
> +			__func__);
> +		return;
> +	}
> +	if ((tas_dev->sdw_peripheral->id.unique_id < TAS2783_ID_MIN) ||
> +		(tas_dev->sdw_peripheral->id.unique_id > TAS2783_ID_MAX)) {
> +		dev_err(tas_dev->dev, "%s, error unique_id.\n",
> +			__func__);
> +		return;
> +	}
> +
> +	reg_start =3D (u8 *)(cali_data + (tas_dev->sdw_peripheral->id.unique_id
> +		- TAS2783_ID_MIN) * sizeof(tas2783_cali_reg));
> +	for (int i =3D 0; i < ARRAY_SIZE(tas2783_cali_reg); i++) {
> +		ret =3D regmap_bulk_write(map, tas2783_cali_reg[i],
> +			reg_start + i, 4);

reg_start is u8, reg_start + i only adds i byte.
I think it should be reg_start + i * 4, because the calibration values
are unsigned ints.

> +		if (ret !=3D 0) {
> +			dev_err(tas_dev->dev, "Cali failed %x:%d\n",
> +				tas2783_cali_reg[i], ret);
> +			break;
> +		}
> +	}
> +}
> +
> +/* Update the calibrate data, including speaker impedance, f0, etc, into=
 algo.
> + * Calibrate data is done by manufacturer in the factory. These data are=
 used
> + * by Algo for calucating the speaker temperature, speaker membrance exc=
ursion
> + * and f0 in real time during playback.
> + * In case of no or valid calibrated data, dsp will still works with def=
ault
> + * calibrated data inside algo.
> + */

calibration data, Calibration data, calculating, membrane

> +static int tas2783_calibration(struct tasdevice_priv *tas_dev)
> +{
> +	efi_guid_t efi_guid =3D EFI_GUID(0x1f52d2a1, 0xbb3a, 0x457d, 0xbc,
> +			0x09, 0x43, 0xa3, 0xf4, 0x31, 0x0a, 0x92);
> +	static efi_char16_t efi_name[] =3D L"CALI_DATA";
> +	struct tm *tm =3D &tas_dev->tm;
> +	unsigned int attr =3D 0, crc;
> +	unsigned int *tmp_val;
> +	efi_status_t status;
> +
> +	tas_dev->cali_data.total_sz =3D 128;

Where does 128 come from? The tas_dev->cali_data.data is a 252 byte
buffer.

#define TAS2783_MAX_CALIDATA_SIZE	252

struct calibration_data {
	unsigned long total_sz;
	unsigned char data[TAS2783_MAX_CALIDATA_SIZE];
};


> +
> +	status =3D efi.get_variable(efi_name, &efi_guid, &attr,
> +		&tas_dev->cali_data.total_sz, tas_dev->cali_data.data);
> +	if (status =3D=3D EFI_BUFFER_TOO_SMALL) {
> +		status =3D efi.get_variable(efi_name, &efi_guid, &attr,
> +			&tas_dev->cali_data.total_sz,
> +			tas_dev->cali_data.data);

The first efi.get_variable call updates the total_sz, and the
second efi.get_variable can write more than 252 bytes. (if the efi
variable is bigger)

I don't think you can handle the EFI_BUFFER_TOO_SMALL case, if you only
want to use the fixed size buffer.



> +		dev_dbg(tas_dev->dev, "cali get %lx bytes result:%ld\n",
> +			tas_dev->cali_data.total_sz, status);
> +	}
> +	if (status !=3D 0) {
status !=3D EFI_SUCCESS
> +		/* Failed got calibration data from EFI. */
> +		dev_dbg(tas_dev->dev, "No calibration data in UEFI.");
> +		return 0;
> +	}
> +
> +	tmp_val =3D (unsigned int *)tas_dev->cali_data.data;
> +
> +	crc =3D crc32(~0, tas_dev->cali_data.data, 84) ^ ~0;
> +
> +	if (crc =3D=3D tmp_val[21]) {
> +		/* Date and time of calibration was done. */
> +		time64_to_tm(tmp_val[20], 0, tm);
> +		dev_dbg(tas_dev->dev, "%4ld-%2d-%2d, %2d:%2d:%2d\n",
> +			tm->tm_year, tm->tm_mon, tm->tm_mday,
> +			tm->tm_hour, tm->tm_min, tm->tm_sec);
> +		tas2783_apply_calib(tas_dev, tmp_val);
> +	} else {
> +		dev_dbg(tas_dev->dev, "CRC 0x%08x not match 0x%08x\n",
> +			crc, tmp_val[21]);
> +		tas_dev->cali_data.total_sz =3D 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static void tasdevice_rca_ready(const struct firmware *fmw,
> +	void *context)
> +{
> +	struct tasdevice_priv *tas_dev =3D
> +		(struct tasdevice_priv *) context;
> +	struct tas2783_firmware_node *p;
> +	struct regmap *map =3D tas_dev->regmap;
> +	unsigned char *buf =3D NULL;
> +	int offset =3D 0, img_sz;
> +	int ret, value_sdw;
> +
> +	mutex_lock(&tas_dev->codec_lock);
> +
> +	if (!fmw || !fmw->data) {
> +		/* No firmware binary, devices will work in ROM mode. */
> +		dev_err(tas_dev->dev,
> +			"Failed to read %s, no side-effect on driver\n",
> +			tas_dev->rca_binaryname);
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +	buf =3D (unsigned char *)fmw->data;
> +
> +	img_sz =3D le32_to_cpup((__le32 *)&buf[offset]);
> +	offset  +=3D sizeof(img_sz);
> +	if (img_sz !=3D fmw->size) {
> +		dev_err(tas_dev->dev, "Size not matching, %d %u",
> +			(int)fmw->size, img_sz);
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	while (offset < img_sz) {
> +		p =3D (struct tas2783_firmware_node *)(buf + offset);
> +		if (p->length > 1) {
> +			ret =3D regmap_bulk_write(map, p->download_addr,
> +			buf + offset + sizeof(unsigned int)*5, p->length);
> +		} else
> +			ret =3D regmap_write(map, p->download_addr,
> +				*(buf + offset + sizeof(unsigned int) * 5));
> +
> +		if (ret !=3D 0) {
> +			dev_dbg(tas_dev->dev, "Load FW fail: %d.\n", ret);
> +			goto out;
> +		}
> +		offset +=3D sizeof(unsigned int)*5 + p->length;
> +	}
> +	/* Select left/right channel based on unique id. */
> +	value_sdw =3D 0x1a;
> +	value_sdw +=3D ((tas_dev->sdw_peripheral->dev_num & 1) << 4);
> +	dev_dbg(tas_dev->dev, "%s dev_num =3D %u", __func__,
> +		tas_dev->sdw_peripheral->dev_num);
> +	regmap_write(map, TASDEVICE_REG(0, 0, 0x0a), value_sdw);

You can add a define for TASDEVICE_REG(0, 0, 0x0a)

> +
> +	tas2783_calibration(tas_dev);
> +
> +out:
> +	mutex_unlock(&tas_dev->codec_lock);
> +	if (fmw)
> +		release_firmware(fmw);
> +}
> +
> +static const struct snd_soc_dapm_widget tasdevice_dapm_widgets[] =3D {
> +	SND_SOC_DAPM_AIF_IN("ASI", "ASI Playback", 0, SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_AIF_OUT("ASI OUT", "ASI Capture", 0, SND_SOC_NOPM,
> +		0, 0),
> +	SND_SOC_DAPM_OUTPUT("OUT"),
> +	SND_SOC_DAPM_INPUT("DMIC")
> +};
> +
> +static const struct snd_soc_dapm_route tasdevice_audio_map[] =3D {
> +	{"OUT", NULL, "ASI"},
> +	{"ASI OUT", NULL, "DMIC"}
> +};
> +
> +static int tasdevice_set_sdw_stream(struct snd_soc_dai *dai,
> +	void *sdw_stream, int direction)
> +{
> +	snd_soc_dai_dma_data_set(dai, direction, sdw_stream);
> +
> +	return 0;
> +}
> +
> +static void tasdevice_sdw_shutdown(struct snd_pcm_substream *substream,
> +	struct snd_soc_dai *dai)
> +{
> +	snd_soc_dai_set_dma_data(dai, substream, NULL);
> +}
> +
> +static int tasdevice_sdw_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component =3D dai->component;
> +	struct tasdevice_priv *tas_priv =3D
> +		snd_soc_component_get_drvdata(component);
> +	struct sdw_stream_config stream_config =3D {0};
> +	struct sdw_port_config port_config =3D {0};
> +	struct sdw_stream_runtime *sdw_stream;
> +	int ret;
> +
> +	dev_dbg(dai->dev, "%s %s", __func__, dai->name);
> +	sdw_stream =3D snd_soc_dai_get_dma_data(dai, substream);
> +
> +	if (!sdw_stream)
> +		return -EINVAL;
> +
> +	if (!tas_priv->sdw_peripheral)
> +		return -EINVAL;
> +
> +	/* SoundWire specific configuration */
> +	snd_sdw_params_to_config(substream, params,
> +		&stream_config, &port_config);
> +
> +	/* port 1 for playback */
> +	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> +		port_config.num =3D 1;
> +	else
> +		port_config.num =3D 2;
> +
> +	ret =3D sdw_stream_add_slave(tas_priv->sdw_peripheral,
> +		&stream_config, &port_config, 1, sdw_stream);
> +	if (ret) {
> +		dev_err(dai->dev, "Unable to configure port\n");
> +		return ret;
> +	}
> +
> +	dev_dbg(dai->dev, "%s fomrat: %i rate: %i\n", __func__,

format

> +		params_format(params), params_rate(params));
> +
> +	return 0;
> +}
> +
> +static int tasdevice_sdw_pcm_hw_free(struct snd_pcm_substream *substream=
,
> +	struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component =3D dai->component;
> +	struct tasdevice_priv *tas_priv =3D
> +		snd_soc_component_get_drvdata(component);
> +	struct sdw_stream_runtime *sdw_stream =3D
> +		snd_soc_dai_get_dma_data(dai, substream);
> +
> +	if (!tas_priv->sdw_peripheral)
> +		return -EINVAL;
> +
> +	sdw_stream_remove_slave(tas_priv->sdw_peripheral, sdw_stream);
> +
> +	return 0;
> +}
> +
> +static int tasdevice_mute(struct snd_soc_dai *dai, int mute,
> +	int direction)
> +{
> +	struct snd_soc_component *component =3D dai->component;
> +	struct tasdevice_priv *tas_dev =3D
> +		snd_soc_component_get_drvdata(component);
> +	struct regmap *map =3D tas_dev->regmap;
> +	int ret;
> +
> +	dev_dbg(tas_dev->dev, "Mute or unmute %d.\n", mute);
> +
> +	if (mute) {
> +		/* Echo channel can't be shutdown while tas2783 must keep
> +		 * working state while playback is on.
> +		 */
> +		if (direction =3D=3D SNDRV_PCM_STREAM_CAPTURE
> +			&& tas_dev->pstream =3D=3D true)
> +			return 0;
> +		/* FU23 mute (0x40400108) */
> +		ret =3D regmap_write(map,
> +			SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP,
> +			TAS2783_SDCA_ENT_FU23, TAS2783_SDCA_CTL_FU_MUTE, 0),
> +			1);
> +		ret |=3D regmap_write(map, TASDEVICE_REG(0, 0, 0x02), 0x1a);
> +		tas_dev->pstream =3D false;
> +	} else {
> +		/* FU23 Unmute, 0x40400108. */
> +		ret =3D regmap_write(map,
> +			SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP,
> +			TAS2783_SDCA_ENT_FU23, TAS2783_SDCA_CTL_FU_MUTE, 0),
> +			0);
> +		ret |=3D regmap_write(map, TASDEVICE_REG(0, 0, 0x02), 0x0);
> +		if (direction =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> +			tas_dev->pstream =3D true;
> +	}
> +
> +	if (ret)
> +		dev_err(tas_dev->dev, "Mute or unmute %d failed %d.\n",
> +			mute, ret);
> +
> +	return ret;
> +}
> +
> +static const struct snd_soc_dai_ops tasdevice_dai_ops =3D {
> +	.mute_stream	=3D tasdevice_mute,
> +	.hw_params	=3D tasdevice_sdw_hw_params,
> +	.hw_free	=3D tasdevice_sdw_pcm_hw_free,
> +	.set_stream	=3D tasdevice_set_sdw_stream,
> +	.shutdown	=3D tasdevice_sdw_shutdown,
> +};
> +
> +static struct snd_soc_dai_driver tasdevice_dai_driver[] =3D {
> +	{
> +		.name =3D "tas2783-codec",
> +		.id =3D 0,
> +		.playback =3D {
> +			.stream_name	=3D "Playback",
> +			.channels_min	=3D 1,
> +			.channels_max	=3D 4,
> +			.rates		=3D TAS2783_DEVICE_RATES,
> +			.formats	=3D TAS2783_DEVICE_FORMATS,
> +		},
> +		.capture =3D {
> +			.stream_name	=3D "Capture",
> +			.channels_min	=3D 1,
> +			.channels_max	=3D 4,
> +			.rates		=3D TAS2783_DEVICE_RATES,
> +			.formats	=3D TAS2783_DEVICE_FORMATS,
> +		},
> +		.ops =3D &tasdevice_dai_ops,
> +		.symmetric_rate =3D 1,
> +	},
> +};
> +
> +static void tas2783_reset(struct tasdevice_priv *tas_dev)
> +{
> +	struct regmap *map =3D tas_dev->regmap;
> +	int ret;
> +
> +	ret =3D regmap_write(map, TAS2873_REG_SWRESET, 1);
> +	if (ret) {
> +		dev_err(tas_dev->dev, "Reset failed.\n");
> +		return;
> +	}
> +	usleep_range(1000, 1050);
> +}
> +
> +static int tasdevice_component_probe(struct snd_soc_component *component=
)
> +{
> +	struct tasdevice_priv *tas_dev =3D
> +		snd_soc_component_get_drvdata(component);
> +
> +	tas_dev->component =3D component;
> +
> +	dev_dbg(tas_dev->dev, "%s was called.\n", __func__);
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_component_driver
> +	soc_codec_driver_tasdevice =3D {
> +	.probe		=3D tasdevice_component_probe,
> +	.controls	=3D tas2783_snd_controls,
> +	.num_controls	=3D ARRAY_SIZE(tas2783_snd_controls),
> +	.dapm_widgets	=3D tasdevice_dapm_widgets,
> +	.num_dapm_widgets =3D ARRAY_SIZE(tasdevice_dapm_widgets),
> +	.dapm_routes	=3D tasdevice_audio_map,
> +	.num_dapm_routes =3D ARRAY_SIZE(tasdevice_audio_map),
> +	.idle_bias_on	=3D 1,
> +	.endianness	=3D 1,
> +};
> +
> +static int tasdevice_init(struct tasdevice_priv *tas_dev)
> +{
> +	int ret;
> +
> +	dev_set_drvdata(tas_dev->dev, tas_dev);
> +
> +	mutex_init(&tas_dev->codec_lock);
> +	ret =3D devm_snd_soc_register_component(tas_dev->dev,
> +		&soc_codec_driver_tasdevice,
> +		tasdevice_dai_driver, ARRAY_SIZE(tasdevice_dai_driver));
> +	if (ret) {
> +		dev_err(tas_dev->dev, "%s: codec register error:%d.\n",
> +			__func__, ret);

return ret?

> +	}
> +
> +	tas2783_reset(tas_dev);
> +	/* tas2783-8[9,...,f].bin was copied into /lib/firmware/ */
> +	scnprintf(tas_dev->rca_binaryname, 64, "tas2783-%01x.bin",
> +		tas_dev->sdw_peripheral->id.unique_id);
> +
> +	ret =3D request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
> +		tas_dev->rca_binaryname, tas_dev->dev, GFP_KERNEL,
> +		tas_dev, tasdevice_rca_ready);
> +	if (ret) {
> +		dev_dbg(tas_dev->dev,
> +		"%s: request_firmware %x open status: %d.\n",
> +		__func__, tas_dev->sdw_peripheral->id.unique_id, ret);
> +	}
> +
> +	/* set autosuspend parameters */
> +	pm_runtime_set_autosuspend_delay(tas_dev->dev, 3000);
> +	pm_runtime_use_autosuspend(tas_dev->dev);
> +
> +	/* make sure the device does not suspend immediately */
> +	pm_runtime_mark_last_busy(tas_dev->dev);
> +
> +	pm_runtime_enable(tas_dev->dev);
> +
> +	dev_dbg(tas_dev->dev, "%s was called for TAS2783.\n",  __func__);
> +
> +	return ret;
> +}
> +
> +static int tasdevice_read_prop(struct sdw_slave *slave)
> +{
> +	struct sdw_slave_prop *prop =3D &slave->prop;
> +	int nval;
> +	int i, j;
> +	u32 bit;
> +	unsigned long addr;
> +	struct sdw_dpn_prop *dpn;
> +
> +	prop->scp_int1_mask =3D
> +		SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
> +	prop->quirks =3D SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
> +
> +	prop->paging_support =3D true;
> +
> +	/* first we need to allocate memory for set bits in port lists */
> +	prop->source_ports =3D BIT(2); /* BITMAP: 00000100 */
> +	prop->sink_ports =3D BIT(1); /* BITMAP:  00000010 */
> +
> +	nval =3D hweight32(prop->source_ports);
> +	prop->src_dpn_prop =3D devm_kcalloc(&slave->dev, nval,
> +		sizeof(*prop->src_dpn_prop), GFP_KERNEL);
> +	if (!prop->src_dpn_prop)
> +		return -ENOMEM;
> +
> +	i =3D 0;
> +	dpn =3D prop->src_dpn_prop;
> +	addr =3D prop->source_ports;
> +	for_each_set_bit(bit, &addr, 32) {
> +		dpn[i].num =3D bit;
> +		dpn[i].type =3D SDW_DPN_FULL;
> +		dpn[i].simple_ch_prep_sm =3D true;
> +		dpn[i].ch_prep_timeout =3D 10;
> +		i++;
> +	}
> +
> +	/* do this again for sink now */
> +	nval =3D hweight32(prop->sink_ports);
> +	prop->sink_dpn_prop =3D devm_kcalloc(&slave->dev, nval,
> +		sizeof(*prop->sink_dpn_prop), GFP_KERNEL);
> +	if (!prop->sink_dpn_prop)
> +		return -ENOMEM;
> +
> +	j =3D 0;
> +	dpn =3D prop->sink_dpn_prop;
> +	addr =3D prop->sink_ports;
> +	for_each_set_bit(bit, &addr, 32) {
> +		dpn[j].num =3D bit;
> +		dpn[j].type =3D SDW_DPN_FULL;
> +		dpn[j].simple_ch_prep_sm =3D true;
> +		dpn[j].ch_prep_timeout =3D 10;
> +		j++;
> +	}
> +
> +	/* set the timeout values */
> +	prop->clk_stop_timeout =3D 20;
> +
> +	return 0;
> +}
> +
> +static int tasdevice_io_init(struct device *dev, struct sdw_slave *slave=
)
> +{
> +	struct tasdevice_priv *tas_priv =3D dev_get_drvdata(dev);
> +
> +	if (tas_priv->hw_init)
> +		return 0;
> +
> +	if (tas_priv->first_hw_init) {
> +		regcache_cache_only(tas_priv->regmap, false);
> +		regcache_cache_bypass(tas_priv->regmap, true);
> +	} else {
> +		/*
> +		 * PM runtime is only enabled when a Slave reports as Attached
> +		 */
> +
> +		/* set autosuspend parameters */
> +		pm_runtime_set_autosuspend_delay(&slave->dev, 3000);
> +		pm_runtime_use_autosuspend(&slave->dev);
> +
> +		/* update count of parent 'active' children */
> +		pm_runtime_set_active(&slave->dev);
> +
> +		/* make sure the device does not suspend immediately */
> +		pm_runtime_mark_last_busy(&slave->dev);
> +
> +		pm_runtime_enable(&slave->dev);
> +	}
> +
> +	pm_runtime_get_noresume(&slave->dev);
> +
> +	/* sw reset */
> +	regmap_write(tas_priv->regmap, 0x8001, 0x01);
> +
> +	if (tas_priv->first_hw_init) {
> +		regcache_cache_bypass(tas_priv->regmap, false);
> +		regcache_mark_dirty(tas_priv->regmap);
> +	} else
> +		tas_priv->first_hw_init =3D true;
> +	/* Mark Slave initialization complete */
> +	tas_priv->hw_init =3D true;
> +
> +	return 0;
> +}
> +
> +static int tasdevice_update_status(struct sdw_slave *slave,
> +	enum sdw_slave_status status)
> +{
> +	struct  tasdevice_priv *tas_priv =3D dev_get_drvdata(&slave->dev);
> +
> +	/* Update the status */
> +	tas_priv->status =3D status;
> +
> +	if (status =3D=3D SDW_SLAVE_UNATTACHED)
> +		tas_priv->hw_init =3D false;
> +
> +	/* Perform initialization only if slave status
> +	 * is present and hw_init flag is false
> +	 */
> +	if (tas_priv->hw_init || tas_priv->status !=3D SDW_SLAVE_ATTACHED)
> +		return 0;
> +
> +	/* perform I/O transfers required for Slave initialization */
> +	return tasdevice_io_init(&slave->dev, slave);
> +}
> +
> +/*
> + * slave_ops: callbacks for get_clock_stop_mode, clock_stop and
> + * port_prep are not defined for now
> + */
> +static const struct sdw_slave_ops tasdevice_sdw_ops =3D {
> +	.read_prop	=3D tasdevice_read_prop,
> +	.update_status	=3D tasdevice_update_status,
> +};
> +
> +static void tasdevice_remove(struct tasdevice_priv *tas_dev)
> +{
> +	mutex_destroy(&tas_dev->codec_lock);
> +}
> +
> +static int tasdevice_sdw_probe(struct sdw_slave *peripheral,
> +	const struct sdw_device_id *id)
> +{
> +	struct device *dev =3D &peripheral->dev;
> +	struct tasdevice_priv *tas_dev;
> +	int ret;
> +
> +	tas_dev =3D devm_kzalloc(dev, sizeof(*tas_dev), GFP_KERNEL);
> +	if (!tas_dev)
> +		return -ENOMEM;
> +
> +	tas_dev->dev =3D dev;
> +	tas_dev->chip_id =3D id->driver_data;
> +	tas_dev->sdw_peripheral =3D peripheral;
> +	/*
> +	 * Mark hw_init to false
> +	 * HW init will be performed when device reports present
> +	 */
> +	tas_dev->hw_init =3D false;
> +	tas_dev->first_hw_init =3D false;
> +
> +	dev_set_drvdata(dev, tas_dev);
> +
> +	tas_dev->regmap =3D devm_regmap_init_sdw(peripheral,
> +		&tasdevice_regmap);
> +	if (IS_ERR(tas_dev->regmap)) {
> +		ret =3D PTR_ERR(tas_dev->regmap);
> +		dev_err(dev, "Failed %d of devm_regmap_init_sdw.", ret);

return ret?

> +	} else
> +		ret =3D tasdevice_init(tas_dev);
> +
> +	if (ret < 0)
> +		tasdevice_remove(tas_dev);
> +
> +	return ret;
> +}
> +
> +static int tasdevice_sdw_remove(struct sdw_slave *peripheral)
> +{
> +	struct tasdevice_priv *tas_dev =3D dev_get_drvdata(&peripheral->dev);
> +
> +	if (tas_dev->first_hw_init)
> +		pm_runtime_disable(tas_dev->dev);
> +	tasdevice_remove(tas_dev);
> +
> +	return 0;
> +}
> +
> +static const struct sdw_device_id tasdevice_sdw_id[] =3D {
> +	SDW_SLAVE_ENTRY(0x0102, 0x0000, 0),
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(sdw, tasdevice_sdw_id);
> +
> +static int __maybe_unused tas2783_sdca_dev_suspend(struct device *dev)
> +{
> +	struct tasdevice_priv *tas_priv =3D dev_get_drvdata(dev);
> +
> +	if (!tas_priv->hw_init)
> +		return 0;
> +
> +	regcache_cache_only(tas_priv->regmap, true);
> +
> +	return 0;
> +}
> +
> +#define TAS2783_PROBE_TIMEOUT 5000
> +
> +static int __maybe_unused tas2783_sdca_dev_resume(struct device *dev)
> +{
> +	struct sdw_slave *slave =3D dev_to_sdw_dev(dev);
> +	struct tasdevice_priv *tas_priv =3D dev_get_drvdata(dev);
> +	unsigned long time;
> +
> +	if (!tas_priv->first_hw_init)
> +		return 0;
> +
> +	if (!slave->unattach_request)
> +		goto regmap_sync;
> +
> +	time =3D wait_for_completion_timeout(&slave->initialization_complete,
> +				msecs_to_jiffies(TAS2783_PROBE_TIMEOUT));
> +	if (!time) {
> +		dev_err(&slave->dev, "Init not complete, timed out\n");
> +		sdw_show_ping_status(slave->bus, true);
> +
> +		return -ETIMEDOUT;
> +	}
> +
> +regmap_sync:
> +	slave->unattach_request =3D 0;
> +	regcache_cache_only(tas_priv->regmap, false);
> +	regcache_sync(tas_priv->regmap);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops tas2783_sdca_pm =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(tas2783_sdca_dev_suspend,
> +		tas2783_sdca_dev_resume)
> +	SET_RUNTIME_PM_OPS(tas2783_sdca_dev_suspend,
> +		tas2783_sdca_dev_resume, NULL)
> +};
> +
> +static struct sdw_driver tasdevice_sdw_driver =3D {
> +	.driver =3D {
> +		.name =3D "slave-tas2783",
> +		.pm =3D &tas2783_sdca_pm,
> +	},
> +	.probe =3D tasdevice_sdw_probe,
> +	.remove =3D tasdevice_sdw_remove,
> +	.ops =3D &tasdevice_sdw_ops,
> +	.id_table =3D tasdevice_sdw_id,
> +};
> +
> +module_sdw_driver(tasdevice_sdw_driver);
> +
> +MODULE_AUTHOR("Baojun Xu <baojun.xu@ti.com>");
> +MODULE_AUTHOR("Shenghao Ding <shenghao-ding@ti.com>");
> +MODULE_DESCRIPTION("ASoC TAS2783 SoundWire Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/sound/soc/codecs/tas2783.h b/sound/soc/codecs/tas2783.h
> new file mode 100644
> index 000000000000..703b2c0b78a6
> --- /dev/null
> +++ b/sound/soc/codecs/tas2783.h
> @@ -0,0 +1,97 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * ALSA SoC Texas Instruments TAS2783 Audio Smart Amplifier
> + *
> + * Copyright (C) 2023 - 2024 Texas Instruments Incorporated
> + * https://www.ti.com
> + *
> + * Author: Baojun Xu <baojun.xu@ti.com>
> + *	Shenghao Ding <shenghao-ding@ti.com>
> + */
> +
> +#ifndef __TAS2783_H__
> +#define __TAS2783_H__
> +
> +#define TAS2783_DEVICE_RATES		(SNDRV_PCM_RATE_44100 | \
> +					SNDRV_PCM_RATE_48000 | \
> +					SNDRV_PCM_RATE_96000 | \
> +					SNDRV_PCM_RATE_88200)
> +
> +#define TAS2783_DEVICE_FORMATS		(SNDRV_PCM_FMTBIT_S16_LE | \
> +					SNDRV_PCM_FMTBIT_S24_LE | \
> +					SNDRV_PCM_FMTBIT_S32_LE)
> +
> +/* BOOK, PAGE Control Register */
> +#define TASDEVICE_REG(book, page, reg)	((book * 256 * 256) + 0x8000 + \
> +					(page * 128) + reg)
> +
> +/*Software Reset */
> +#define TAS2873_REG_SWRESET		TASDEVICE_REG(0x0, 0X0, 0x01)

be consistent:
TASDEVICE_REG(0x0, 0x0, 0x01)

> +
> +/* Volume control */
> +#define TAS2783_DVC_LVL			TASDEVICE_REG(0x0, 0x00, 0x1A)
0x0 for consistency

indentation is a bit weird in many lines


> +#define TAS2783_AMP_LEVEL		TASDEVICE_REG(0x0, 0x00, 0x03)
> +#define TAS2783_AMP_LEVEL_MASK		GENMASK(5, 1)
> +
> +/* Calibration data */
> +#define TAS2783_CALIBRATION_RE		TASDEVICE_REG(0x0, 0x17, 0x74)
> +#define TAS2783_CALIBRATION_RE_LOW	TASDEVICE_REG(0x0, 0x18, 0x14)
> +#define TAS2783_CALIBRATION_INV_RE	TASDEVICE_REG(0x0, 0x18, 0x0c)
> +#define TAS2783_CALIBRATION_POW		TASDEVICE_REG(0x0, 0x13, 0x70)
> +#define TAS2783_CALIBRATION_TLIMIT	TASDEVICE_REG(0x0, 0x18, 0x7c)
> +
> +/* Unique id start */
> +#define TAS2783_ID_MIN			0x08
> +/* Unique id end */
> +#define TAS2783_ID_MAX			0x0F
> +
> +/* TAS2783 SDCA Control - function number */
> +#define TAS2783_FUNC_TYPE_SMART_AMP	0x01
> +
> +/* TAS2783 SDCA entity */
> +#define TAS2783_SDCA_ENT_FU21		0x01
> +#define TAS2783_SDCA_ENT_FU23		0x02
> +
> +/* TAS2783 SDCA control */
> +#define TAS2783_SDCA_CTL_REQ_POWER_STATE	0x01
> +#define TAS2783_SDCA_CTL_FU_MUTE	0x01
> +#define TAS2783_SDCA_CTL_FU_VOLUME	0x02
> +#define TAS2783_SDCA_CTL_UDMPU_CLUSTER	0x10
> +
> +#define TAS2783_DEVICE_CHANNEL_LEFT	1
> +#define TAS2783_DEVICE_CHANNEL_RIGHT	2
> +
> +#define TAS2783_MAX_CALIDATA_SIZE	252
> +
> +struct tas2783_firmware_node {
> +	unsigned int vendor_id;
> +	unsigned int file_id;
> +	unsigned int version_id;
> +	unsigned int length;
> +	unsigned int download_addr;
> +};
> +
> +struct calibration_data {
> +	unsigned long total_sz;
> +	unsigned char data[TAS2783_MAX_CALIDATA_SIZE];
> +};
> +
> +struct tasdevice_priv {
> +	struct snd_soc_component *component;
> +	struct calibration_data cali_data;
> +	struct sdw_slave *sdw_peripheral;
> +	enum sdw_slave_status status;
> +	struct sdw_bus_params params;
> +	struct mutex codec_lock;
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct tm tm;
> +	unsigned char rca_binaryname[64];
> +	unsigned char dev_name[32];
> +	unsigned int chip_id;
> +	bool pstream;
> +	bool hw_init;
> +	bool first_hw_init;
> +};
> +
> +#endif /*__TAS2783_H__ */

Regards,
Gergo


