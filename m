Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219567DDC2D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345279AbjKAFMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 01:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKAFMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 01:12:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A28CDA;
        Tue, 31 Oct 2023 22:12:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B874C433C7;
        Wed,  1 Nov 2023 05:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698815540;
        bh=Cu3xmEqk3QojWrWVfDH5c7PwJRKfdHsGxanJhTrFD1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iXkK2a4Z2yqrLbNB/rqknNKdjldZY0ojf8zqGr1aVzwTfzBi+SP8jA+wZnqERoZOt
         sldkhHxSJm9cXxarMsaOQUyq0GeHMObDLd5wvXKmnKG+rlpPna7yZaXmd4S9AUa669
         cjw/5EINHKTIT/IQus8GKJpQam7/sp53Q9BtwYRXlkXinG8E2b/fmap9y9TIh9XoQO
         tOAz1ReQYqqbyFLaa1264CMFDzjwCQZHqo0clvGf3HW33AKJVtM9t5dCHxN6CQ2P1T
         jGJP9EHjYnMnSTQu4Ea6A8ua6RLDwx7NL/HgY2ROGPG6sB7+aPCi3Wt2/G4elpnxIf
         7QYmg+dY/xpBw==
Date:   Wed, 1 Nov 2023 10:42:04 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] scsi: ufs: ufs-sysfs: Expose UFS power info
Message-ID: <20231101051204.GC2897@thinkpad>
References: <1698811243-5024-1-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1698811243-5024-1-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 09:00:34PM -0700, Can Guo wrote:
> Having UFS power info available in sysfs makes it easier to tell the state
> of the link during runtime considering we have a bunch of power saving
> features and various combinations for backward compatibility.
> 
> Signed-off-by: Can Guo <quic_cang@quicinc.com>

Just a nitpick below. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
> 
> v2 -> v3:
> 1. For mode/gear/rate/dev_pm/link_status, print texts instead of numbers
> 2. Removed number<->text explanations for mode/rate/gear/dev_pm/link_status in Documentation/ABI/testing/sysfs-driver-ufs
> 
> v1 -> v2:
> 1. Incorporated comments from Bart, Nitin and Mani.
> 2. Added explanations for lane/mode/rate/gear/dev_pm/link_status in Documentation/ABI/testing/sysfs-driver-ufs
> 
> ---
>  Documentation/ABI/testing/sysfs-driver-ufs |  49 ++++++++++++
>  drivers/ufs/core/ufs-sysfs.c               | 120 +++++++++++++++++++++++++++++
>  include/ufs/unipro.h                       |   4 +-
>  3 files changed, 171 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
> index 0c7efaf..b73067b 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ufs
> +++ b/Documentation/ABI/testing/sysfs-driver-ufs
> @@ -1223,6 +1223,55 @@ Description:	This file shows the total latency (in micro seconds) of write
>  
>  		The file is read only.
>  
> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/lane
> +What:		/sys/bus/platform/devices/*.ufs/power_info/lane
> +Date:		September 2023
> +Contact:	Can Guo <quic_cang@quicinc.com>
> +Description:	This file shows how many lanes are enabled on the UFS link,
> +		i.e., an output 2 means UFS link is operating with 2 lanes.
> +
> +		The file is read only.
> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/mode
> +What:		/sys/bus/platform/devices/*.ufs/power_info/mode
> +Date:		September 2023
> +Contact:	Can Guo <quic_cang@quicinc.com>
> +Description:	This file shows the PA power mode of UFS.
> +
> +		The file is read only.
> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/rate
> +What:		/sys/bus/platform/devices/*.ufs/power_info/rate
> +Date:		September 2023
> +Contact:	Can Guo <quic_cang@quicinc.com>
> +Description:	This file shows the speed rate of UFS link.
> +
> +		The file is read only.
> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/gear
> +What:		/sys/bus/platform/devices/*.ufs/power_info/gear
> +Date:		September 2023
> +Contact:	Can Guo <quic_cang@quicinc.com>
> +Description:	This file shows the gear of UFS link.
> +
> +		The file is read only.
> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/dev_pm
> +What:		/sys/bus/platform/devices/*.ufs/power_info/dev_pm
> +Date:		September 2023
> +Contact:	Can Guo <quic_cang@quicinc.com>
> +Description:	This file shows the UFS device power mode.
> +
> +		The file is read only.
> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/power_info/link_state
> +What:		/sys/bus/platform/devices/*.ufs/power_info/link_state
> +Date:		September 2023
> +Contact:	Can Guo <quic_cang@quicinc.com>
> +Description:	This file shows the state of UFS link.
> +
> +		The file is read only.
> +
>  What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/wb_presv_us_en
>  What:		/sys/bus/platform/devices/*.ufs/device_descriptor/wb_presv_us_en
>  Date:		June 2020
> diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
> index c959064..b8b5dd1 100644
> --- a/drivers/ufs/core/ufs-sysfs.c
> +++ b/drivers/ufs/core/ufs-sysfs.c
> @@ -7,9 +7,56 @@
>  #include <asm/unaligned.h>
>  
>  #include <ufs/ufs.h>
> +#include <ufs/unipro.h>
>  #include "ufs-sysfs.h"
>  #include "ufshcd-priv.h"
>  
> +static const char *ufshcd_ufs_pa_pwr_mode_to_string(enum ufs_pa_pwr_mode mode)

I don't think it is necessary to have the ufshcd_ prefix.

> +{
> +	switch (mode) {
> +	case FAST_MODE:		return "FAST_MODE";
> +	case SLOW_MODE:		return "SLOW_MODE";
> +	case FASTAUTO_MODE:	return "FASTAUTO_MODE";
> +	case SLOWAUTO_MODE:	return "SLOWAUTO_MODE";
> +	default:		return "UNKNOWN";

I'm not a big fan of this coding style, but I don't have a strong opinion
either.

- Mani

> +	}
> +}
> +
> +static const char *ufshcd_ufs_hs_gear_rate_to_string(enum ufs_hs_gear_rate rate)
> +{
> +	switch (rate) {
> +	case PA_HS_MODE_A:	return "HS_RATE_A";
> +	case PA_HS_MODE_B:	return "HS_RATE_B";
> +	default:		return "UNKNOWN";
> +	}
> +}
> +
> +static const char *ufshcd_ufs_pwm_gear_to_string(enum ufs_pwm_gear_tag gear)
> +{
> +	switch (gear) {
> +	case UFS_PWM_G1:	return "PWM_GEAR1";
> +	case UFS_PWM_G2:	return "PWM_GEAR2";
> +	case UFS_PWM_G3:	return "PWM_GEAR3";
> +	case UFS_PWM_G4:	return "PWM_GEAR4";
> +	case UFS_PWM_G5:	return "PWM_GEAR5";
> +	case UFS_PWM_G6:	return "PWM_GEAR6";
> +	case UFS_PWM_G7:	return "PWM_GEAR7";
> +	default:		return "UNKNOWN";
> +	}
> +}
> +
> +static const char *ufshcd_ufs_hs_gear_to_string(enum ufs_hs_gear_tag gear)
> +{
> +	switch (gear) {
> +	case UFS_HS_G1:	return "HS_GEAR1";
> +	case UFS_HS_G2:	return "HS_GEAR2";
> +	case UFS_HS_G3:	return "HS_GEAR3";
> +	case UFS_HS_G4:	return "HS_GEAR4";
> +	case UFS_HS_G5:	return "HS_GEAR5";
> +	default:	return "UNKNOWN";
> +	}
> +}
> +
>  static const char *ufshcd_uic_link_state_to_string(
>  			enum uic_link_state state)
>  {
> @@ -628,6 +675,78 @@ static const struct attribute_group ufs_sysfs_monitor_group = {
>  	.attrs = ufs_sysfs_monitor_attrs,
>  };
>  
> +static ssize_t lane_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%u\n", hba->pwr_info.lane_rx);
> +}
> +
> +static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%s\n", ufshcd_ufs_pa_pwr_mode_to_string(hba->pwr_info.pwr_rx));
> +}
> +
> +static ssize_t rate_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%s\n", ufshcd_ufs_hs_gear_rate_to_string(hba->pwr_info.hs_rate));
> +}
> +
> +static ssize_t gear_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%s\n", hba->pwr_info.hs_rate ?
> +				       ufshcd_ufs_hs_gear_to_string(hba->pwr_info.gear_rx) :
> +				       ufshcd_ufs_pwm_gear_to_string(hba->pwr_info.gear_rx));
> +}
> +
> +static ssize_t dev_pm_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%s\n", ufshcd_ufs_dev_pwr_mode_to_string(hba->curr_dev_pwr_mode));
> +}
> +
> +static ssize_t link_state_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%s\n", ufshcd_uic_link_state_to_string(hba->uic_link_state));
> +}
> +
> +static DEVICE_ATTR_RO(lane);
> +static DEVICE_ATTR_RO(mode);
> +static DEVICE_ATTR_RO(rate);
> +static DEVICE_ATTR_RO(gear);
> +static DEVICE_ATTR_RO(dev_pm);
> +static DEVICE_ATTR_RO(link_state);
> +
> +static struct attribute *ufs_power_info_attrs[] = {
> +	&dev_attr_lane.attr,
> +	&dev_attr_mode.attr,
> +	&dev_attr_rate.attr,
> +	&dev_attr_gear.attr,
> +	&dev_attr_dev_pm.attr,
> +	&dev_attr_link_state.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group ufs_sysfs_power_info_group = {
> +	.name = "power_info",
> +	.attrs = ufs_power_info_attrs,
> +};
> +
>  static ssize_t ufs_sysfs_read_desc_param(struct ufs_hba *hba,
>  				  enum desc_idn desc_id,
>  				  u8 desc_index,
> @@ -1233,6 +1352,7 @@ static const struct attribute_group *ufs_sysfs_groups[] = {
>  	&ufs_sysfs_default_group,
>  	&ufs_sysfs_capabilities_group,
>  	&ufs_sysfs_monitor_group,
> +	&ufs_sysfs_power_info_group,
>  	&ufs_sysfs_device_descriptor_group,
>  	&ufs_sysfs_interconnect_descriptor_group,
>  	&ufs_sysfs_geometry_descriptor_group,
> diff --git a/include/ufs/unipro.h b/include/ufs/unipro.h
> index 256eb3a..360e124 100644
> --- a/include/ufs/unipro.h
> +++ b/include/ufs/unipro.h
> @@ -193,7 +193,7 @@
>  #define DME_LocalAFC0ReqTimeOutVal		0xD043
>  
>  /* PA power modes */
> -enum {
> +enum ufs_pa_pwr_mode {
>  	FAST_MODE	= 1,
>  	SLOW_MODE	= 2,
>  	FASTAUTO_MODE	= 4,
> @@ -205,7 +205,7 @@ enum {
>  #define PWRMODE_RX_OFFSET	4
>  
>  /* PA TX/RX Frequency Series */
> -enum {
> +enum ufs_hs_gear_rate {
>  	PA_HS_MODE_A	= 1,
>  	PA_HS_MODE_B	= 2,
>  };
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
