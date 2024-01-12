Return-Path: <linux-kernel+bounces-24706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA0182C119
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14BF1C22589
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954406D1BD;
	Fri, 12 Jan 2024 13:48:37 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3AA6D1AB;
	Fri, 12 Jan 2024 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (ip5f5af452.dynamic.kabel-deutschland.de [95.90.244.82])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 375FE61E5FE03;
	Fri, 12 Jan 2024 14:46:43 +0100 (CET)
Message-ID: <2a58fed3-1fa9-47eb-b475-3f7c3b291376@molgen.mpg.de>
Date: Fri, 12 Jan 2024 14:46:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2] igb: Fix string truncation warnings
 in igb_set_fw_version
To: Kunwu Chan <chentao@kylinos.cn>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Kunwu Chan <kunwu.chan@hotmail.com>,
 przemyslaw.kitszel@intel.com, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 jacob.e.keller@intel.com
References: <20240112025853.123048-1-chentao@kylinos.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240112025853.123048-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kunwu,


Thank you for your patch. I have some minor nits.

Am 12.01.24 um 03:58 schrieb Kunwu Chan:
> 'commit 1978d3ead82c ("intel: fix string truncation warnings")'

Please don’t enclose it in '': Commit 1978d3ead82c ("intel: fix string 
truncation warnings")

> fix '-Wformat-truncation=' warnings in igb_main.c by using kasprintf.

fix*es*

> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.

Maybe paste one warning message.

> Fix this warning by using a larger space for adapter->fw_version,
> and then fall back and continue to use snprintf.
> 
> Fixes: 1978d3ead82c ("intel: fix string truncation warnings")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>


Kind regards,

Paul Menzel


> ---
> v2: Fall back to use snprintf and a larger space,as suggested by
> https://lore.kernel.org/all/20231212132637.1b0fb8aa@kernel.org/
> ---
>   drivers/net/ethernet/intel/igb/igb.h      |  2 +-
>   drivers/net/ethernet/intel/igb/igb_main.c | 35 ++++++++++++-----------
>   2 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index a2b759531cb7..3c2dc7bdebb5 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -637,7 +637,7 @@ struct igb_adapter {
>   		struct timespec64 period;
>   	} perout[IGB_N_PEROUT];
>   
> -	char fw_version[32];
> +	char fw_version[48];
>   #ifdef CONFIG_IGB_HWMON
>   	struct hwmon_buff *igb_hwmon_buff;
>   	bool ets;
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index b2295caa2f0a..ce762d77d2c1 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -3069,7 +3069,6 @@ void igb_set_fw_version(struct igb_adapter *adapter)
>   {
>   	struct e1000_hw *hw = &adapter->hw;
>   	struct e1000_fw_version fw;
> -	char *lbuf;
>   
>   	igb_get_fw_version(hw, &fw);
>   
> @@ -3077,34 +3076,36 @@ void igb_set_fw_version(struct igb_adapter *adapter)
>   	case e1000_i210:
>   	case e1000_i211:
>   		if (!(igb_get_flash_presence_i210(hw))) {
> -			lbuf = kasprintf(GFP_KERNEL, "%2d.%2d-%d",
> -					 fw.invm_major, fw.invm_minor,
> -					 fw.invm_img_type);
> +			snprintf(adapter->fw_version,
> +				 sizeof(adapter->fw_version),
> +				 "%2d.%2d-%d",
> +				 fw.invm_major, fw.invm_minor,
> +				 fw.invm_img_type);
>   			break;
>   		}
>   		fallthrough;
>   	default:
>   		/* if option rom is valid, display its version too */
>   		if (fw.or_valid) {
> -			lbuf = kasprintf(GFP_KERNEL, "%d.%d, 0x%08x, %d.%d.%d",
> -					 fw.eep_major, fw.eep_minor,
> -					 fw.etrack_id, fw.or_major, fw.or_build,
> -					 fw.or_patch);
> +			snprintf(adapter->fw_version,
> +				 sizeof(adapter->fw_version),
> +				 "%d.%d, 0x%08x, %d.%d.%d",
> +				 fw.eep_major, fw.eep_minor, fw.etrack_id,
> +				 fw.or_major, fw.or_build, fw.or_patch);
>   		/* no option rom */
>   		} else if (fw.etrack_id != 0X0000) {
> -			lbuf = kasprintf(GFP_KERNEL, "%d.%d, 0x%08x",
> -					 fw.eep_major, fw.eep_minor,
> -					 fw.etrack_id);
> +			snprintf(adapter->fw_version,
> +				 sizeof(adapter->fw_version),
> +				 "%d.%d, 0x%08x",
> +				 fw.eep_major, fw.eep_minor, fw.etrack_id);
>   		} else {
> -			lbuf = kasprintf(GFP_KERNEL, "%d.%d.%d", fw.eep_major,
> -					 fw.eep_minor, fw.eep_build);
> +			snprintf(adapter->fw_version,
> +				 sizeof(adapter->fw_version),
> +				 "%d.%d.%d",
> +				 fw.eep_major, fw.eep_minor, fw.eep_build);
>   		}
>   		break;
>   	}
> -
> -	/* the truncate happens here if it doesn't fit */
> -	strscpy(adapter->fw_version, lbuf, sizeof(adapter->fw_version));
> -	kfree(lbuf);
>   }
>   
>   /**

