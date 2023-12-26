Return-Path: <linux-kernel+bounces-11191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6387081E2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2CD1F21EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEAB653;
	Tue, 26 Dec 2023 00:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RdofeJaZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A6E366;
	Tue, 26 Dec 2023 00:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703549005; x=1735085005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=myF8xXPr0C6ZrGTFUZoPF4DkzDahLHZ50SatvHrH8kk=;
  b=RdofeJaZk19HjUiikn3kBcOCAdDL1mCrGpDQZquec0EDjzefN/oWB8fd
   Y2pHVkqdCt4uO/S0RKrp06zhuwAlV8mh+draGvBPlgDK+ei92NCVgTfQH
   wMAONuXrAY98xTaskQ04PM2aMHCBuDb98rMr1JXqtJqvnHLbs8o1ky5li
   gO1s+i5i1TA7nw2wcVt5qKI/0a0QUGzuomd1vkIfU/mH6npu5vUidJlND
   ytIt6rSWDr6TZCobqbLrCeup8Zrp2Pczk11d9FK7rzBwWSiLAZAx48ESz
   J2qtDyMvtw5FocdU0kHADu5gwmuDu2vCdOnUlhvQuDhPJOH8eZqcWjZ6L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="482485081"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="482485081"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 16:03:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="848288689"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="848288689"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 25 Dec 2023 16:03:22 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHuum-000Dnf-02;
	Tue, 26 Dec 2023 00:03:20 +0000
Date: Tue, 26 Dec 2023 08:03:07 +0800
From: kernel test robot <lkp@intel.com>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: oe-kbuild-all@lists.linux.dev, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hdsp: fix some memleaks in snd_hdsp_hwdep_ioctl
Message-ID: <202312260721.mfXz0imt-lkp@intel.com>
References: <20231224082533.3540468-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231224082533.3540468-1-alexious@zju.edu.cn>

Hi Zhipeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on tiwai-sound/for-linus linus/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhipeng-Lu/ALSA-hdsp-fix-some-memleaks-in-snd_hdsp_hwdep_ioctl/20231225-155210
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20231224082533.3540468-1-alexious%40zju.edu.cn
patch subject: [PATCH] ALSA: hdsp: fix some memleaks in snd_hdsp_hwdep_ioctl
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231226/202312260721.mfXz0imt-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312260721.mfXz0imt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312260721.mfXz0imt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/pci/rme9652/hdsp.c: In function 'snd_hdsp_hwdep_ioctl':
>> sound/pci/rme9652/hdsp.c:4917:1: warning: label 'err' defined but not used [-Wunused-label]
    4917 | err:
         | ^~~


vim +/err +4917 sound/pci/rme9652/hdsp.c

  4727	
  4728	static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigned int cmd, unsigned long arg)
  4729	{
  4730		struct hdsp *hdsp = hw->private_data;
  4731		void __user *argp = (void __user *)arg;
  4732		int err;
  4733	
  4734		switch (cmd) {
  4735		case SNDRV_HDSP_IOCTL_GET_PEAK_RMS: {
  4736			struct hdsp_peak_rms __user *peak_rms = (struct hdsp_peak_rms __user *)arg;
  4737	
  4738			err = hdsp_check_for_iobox(hdsp);
  4739			if (err < 0)
  4740				return err;
  4741	
  4742			err = hdsp_check_for_firmware(hdsp, 1);
  4743			if (err < 0)
  4744				return err;
  4745	
  4746			if (!(hdsp->state & HDSP_FirmwareLoaded)) {
  4747				dev_err(hdsp->card->dev,
  4748					"firmware needs to be uploaded to the card.\n");
  4749				return -EINVAL;
  4750			}
  4751	
  4752			switch (hdsp->io_type) {
  4753			case H9652:
  4754				return hdsp_9652_get_peak(hdsp, peak_rms);
  4755			case H9632:
  4756				return hdsp_9632_get_peak(hdsp, peak_rms);
  4757			default:
  4758				return hdsp_get_peak(hdsp, peak_rms);
  4759			}
  4760		}
  4761		case SNDRV_HDSP_IOCTL_GET_CONFIG_INFO: {
  4762			struct hdsp_config_info info;
  4763			unsigned long flags;
  4764			int i;
  4765	
  4766			err = hdsp_check_for_iobox(hdsp);
  4767			if (err < 0)
  4768				return err;
  4769	
  4770			err = hdsp_check_for_firmware(hdsp, 1);
  4771			if (err < 0)
  4772				return err;
  4773	
  4774			memset(&info, 0, sizeof(info));
  4775			spin_lock_irqsave(&hdsp->lock, flags);
  4776			info.pref_sync_ref = (unsigned char)hdsp_pref_sync_ref(hdsp);
  4777			info.wordclock_sync_check = (unsigned char)hdsp_wc_sync_check(hdsp);
  4778			if (hdsp->io_type != H9632)
  4779			    info.adatsync_sync_check = (unsigned char)hdsp_adatsync_sync_check(hdsp);
  4780			info.spdif_sync_check = (unsigned char)hdsp_spdif_sync_check(hdsp);
  4781			for (i = 0; i < ((hdsp->io_type != Multiface && hdsp->io_type != RPM && hdsp->io_type != H9632) ? 3 : 1); ++i)
  4782				info.adat_sync_check[i] = (unsigned char)hdsp_adat_sync_check(hdsp, i);
  4783			info.spdif_in = (unsigned char)hdsp_spdif_in(hdsp);
  4784			info.spdif_out = (unsigned char)hdsp_toggle_setting(hdsp,
  4785					HDSP_SPDIFOpticalOut);
  4786			info.spdif_professional = (unsigned char)
  4787				hdsp_toggle_setting(hdsp, HDSP_SPDIFProfessional);
  4788			info.spdif_emphasis = (unsigned char)
  4789				hdsp_toggle_setting(hdsp, HDSP_SPDIFEmphasis);
  4790			info.spdif_nonaudio = (unsigned char)
  4791				hdsp_toggle_setting(hdsp, HDSP_SPDIFNonAudio);
  4792			info.spdif_sample_rate = hdsp_spdif_sample_rate(hdsp);
  4793			info.system_sample_rate = hdsp->system_sample_rate;
  4794			info.autosync_sample_rate = hdsp_external_sample_rate(hdsp);
  4795			info.system_clock_mode = (unsigned char)hdsp_system_clock_mode(hdsp);
  4796			info.clock_source = (unsigned char)hdsp_clock_source(hdsp);
  4797			info.autosync_ref = (unsigned char)hdsp_autosync_ref(hdsp);
  4798			info.line_out = (unsigned char)
  4799				hdsp_toggle_setting(hdsp, HDSP_LineOut);
  4800			if (hdsp->io_type == H9632) {
  4801				info.da_gain = (unsigned char)hdsp_da_gain(hdsp);
  4802				info.ad_gain = (unsigned char)hdsp_ad_gain(hdsp);
  4803				info.phone_gain = (unsigned char)hdsp_phone_gain(hdsp);
  4804				info.xlr_breakout_cable =
  4805					(unsigned char)hdsp_toggle_setting(hdsp,
  4806						HDSP_XLRBreakoutCable);
  4807	
  4808			} else if (hdsp->io_type == RPM) {
  4809				info.da_gain = (unsigned char) hdsp_rpm_input12(hdsp);
  4810				info.ad_gain = (unsigned char) hdsp_rpm_input34(hdsp);
  4811			}
  4812			if (hdsp->io_type == H9632 || hdsp->io_type == H9652)
  4813				info.analog_extension_board =
  4814					(unsigned char)hdsp_toggle_setting(hdsp,
  4815						    HDSP_AnalogExtensionBoard);
  4816			spin_unlock_irqrestore(&hdsp->lock, flags);
  4817			if (copy_to_user(argp, &info, sizeof(info)))
  4818				return -EFAULT;
  4819			break;
  4820		}
  4821		case SNDRV_HDSP_IOCTL_GET_9632_AEB: {
  4822			struct hdsp_9632_aeb h9632_aeb;
  4823	
  4824			if (hdsp->io_type != H9632) return -EINVAL;
  4825			h9632_aeb.aebi = hdsp->ss_in_channels - H9632_SS_CHANNELS;
  4826			h9632_aeb.aebo = hdsp->ss_out_channels - H9632_SS_CHANNELS;
  4827			if (copy_to_user(argp, &h9632_aeb, sizeof(h9632_aeb)))
  4828				return -EFAULT;
  4829			break;
  4830		}
  4831		case SNDRV_HDSP_IOCTL_GET_VERSION: {
  4832			struct hdsp_version hdsp_version;
  4833			int err;
  4834	
  4835			if (hdsp->io_type == H9652 || hdsp->io_type == H9632) return -EINVAL;
  4836			if (hdsp->io_type == Undefined) {
  4837				err = hdsp_get_iobox_version(hdsp);
  4838				if (err < 0)
  4839					return err;
  4840			}
  4841			memset(&hdsp_version, 0, sizeof(hdsp_version));
  4842			hdsp_version.io_type = hdsp->io_type;
  4843			hdsp_version.firmware_rev = hdsp->firmware_rev;
  4844			if (copy_to_user(argp, &hdsp_version, sizeof(hdsp_version)))
  4845				return -EFAULT;
  4846			break;
  4847		}
  4848		case SNDRV_HDSP_IOCTL_UPLOAD_FIRMWARE: {
  4849			struct hdsp_firmware firmware;
  4850			u32 __user *firmware_data;
  4851			int err;
  4852	
  4853			if (hdsp->io_type == H9652 || hdsp->io_type == H9632) return -EINVAL;
  4854			/* SNDRV_HDSP_IOCTL_GET_VERSION must have been called */
  4855			if (hdsp->io_type == Undefined) return -EINVAL;
  4856	
  4857			if (hdsp->state & (HDSP_FirmwareCached | HDSP_FirmwareLoaded))
  4858				return -EBUSY;
  4859	
  4860			dev_info(hdsp->card->dev,
  4861				 "initializing firmware upload\n");
  4862			if (copy_from_user(&firmware, argp, sizeof(firmware)))
  4863				return -EFAULT;
  4864			firmware_data = (u32 __user *)firmware.firmware_data;
  4865	
  4866			if (hdsp_check_for_iobox (hdsp))
  4867				return -EIO;
  4868	
  4869			if (!hdsp->fw_uploaded) {
  4870				hdsp->fw_uploaded = vmalloc(HDSP_FIRMWARE_SIZE);
  4871				if (!hdsp->fw_uploaded)
  4872					return -ENOMEM;
  4873			}
  4874	
  4875			if (copy_from_user(hdsp->fw_uploaded, firmware_data,
  4876					   HDSP_FIRMWARE_SIZE)) {
  4877				err = -EFAULT;
  4878				goto free_fw_uploaded;
  4879			}
  4880	
  4881			hdsp->state |= HDSP_FirmwareCached;
  4882	
  4883			err = snd_hdsp_load_firmware_from_cache(hdsp);
  4884			if (err < 0)
  4885				goto free_fw_uploaded;
  4886	
  4887			if (!(hdsp->state & HDSP_InitializationComplete)) {
  4888				err = snd_hdsp_enable_io(hdsp);
  4889				if (err < 0)
  4890					goto free_fw_uploaded;
  4891	
  4892				snd_hdsp_initialize_channels(hdsp);
  4893				snd_hdsp_initialize_midi_flush(hdsp);
  4894	
  4895				err = snd_hdsp_create_alsa_devices(hdsp->card, hdsp);
  4896				if (err < 0) {
  4897					dev_err(hdsp->card->dev,
  4898						"error creating alsa devices\n");
  4899					goto free_fw_uploaded;
  4900				}
  4901			}
  4902			break;
  4903		}
  4904		case SNDRV_HDSP_IOCTL_GET_MIXER: {
  4905			struct hdsp_mixer __user *mixer = (struct hdsp_mixer __user *)argp;
  4906			if (copy_to_user(mixer->matrix, hdsp->mixer_matrix, sizeof(unsigned short)*HDSP_MATRIX_MIXER_SIZE))
  4907				return -EFAULT;
  4908			break;
  4909		}
  4910		default:
  4911			return -EINVAL;
  4912		}
  4913		return 0;
  4914	free_fw_uploaded:
  4915		vfree(hdsp->fw_uploaded);
  4916		hdsp->fw_uploaded = NULL;
> 4917	err:
  4918		return err;
  4919	}
  4920	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

