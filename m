Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04B180A5E1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574037AbjLHOuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574027AbjLHOuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:50:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF11810DE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:50:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3060C433CB;
        Fri,  8 Dec 2023 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047037;
        bh=1pmf9sTr8+ZoZw2j7lZ6NJcKXhcHQQe1G5vRiL8Tqcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4f+1QP/8Uw2eLGJP/xiIl9Yw5M4uOBD5/HvkdYzrGm32Nl2Tc7WoVBZ1B0FZNS81
         S8LUGGoh6Lut3e/I5YdVDPrt/5MoipO1pM92hek30BpArqtbDIqruBHgUy8Qye45yG
         5TU5gogmqORQE0gyFmCFNZldo4qpOcIwABYtvRErqE3Xq4txdAQQgsmQVD+Vu5qNJd
         0e4J4RqvDP3yRezKX1DDdfkk9ppQhAhd9CaxsJZi+Lk5U4Xw+KqededBLOjA/gtdu9
         1JgbBb8Ds7NDMjEUf82WwtjbFqbJ+AeYWGgUvm8NifqXoQ1XWuUejK+JS3CohRMKRP
         p4mvDH1xRQQKA==
Date:   Fri, 8 Dec 2023 20:20:21 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com, thomas@t-8ch.de, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikebi@micron.com, lporzio@micron.com
Subject: Re: [PATCH v4 2/3] scsi: ufs: core: Add UFS RTC support
Message-ID: <20231208145021.GC15552@thinkpad>
References: <20231208103940.153734-1-beanhuo@iokpp.de>
 <20231208103940.153734-3-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208103940.153734-3-beanhuo@iokpp.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 11:39:39AM +0100, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> Add Real Time Clock (RTC) support for UFS device. This enhancement is crucial
> for the internal maintenance operations of the UFS device. The patch enables
> the device to handle both absolute and relative time information. Furthermore,
> it includes periodic task to update the RTC in accordance with the UFS Spec,
> ensuring the accuracy of RTC information for the device's internal processes.
> 
> RTC and qTimestamp serve distinct purposes. The RTC provides a coarse level
> of granularity with, at best, approximate single-second resolution. This makes
> the RTC well-suited for the device to determine the approximate age of programmed
> blocks after being updated by the host. On the other hand, qTimestamp offers
> nanosecond granularity and is specifically designed for synchronizing Device
> Error Log entries with corresponding host-side logs.
> 
> Given that the RTC has been a standard feature since UFS Spec 2.0, and qTimestamp
> was introduced in UFS Spec 4.0, the majority of UFS devices currently on the
> market rely on RTC. Therefore, it is advisable to continue supporting RTC in
> the Linux kernel. This ensures compatibility with the prevailing UFS device
> implementations and facilitates seamless integration with existing hardware.
> By maintaining support for RTC, we ensure broad compatibility and avoid potential
> issues arising from deviations in device specifications across different UFS
> versions.
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> Signed-off-by: Mike Bi <mikebi@micron.com>
> Signed-off-by: Luca Porzio <lporzio@micron.com>
> Acked-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/ufs/core/ufshcd.c | 84 +++++++++++++++++++++++++++++++++++++++
>  include/ufs/ufs.h         | 14 +++++++
>  include/ufs/ufshcd.h      |  4 ++
>  3 files changed, 102 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 32cfcba66d60..dedb0c08363b 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -99,6 +99,9 @@
>  /* Polling time to wait for fDeviceInit */
>  #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
>  
> +/* Default RTC update every 10 seconds */
> +#define UFS_RTC_UPDATE_INTERVAL_MS (10 * MSEC_PER_SEC)
> +
>  /* UFSHC 4.0 compliant HC support this mode. */
>  static bool use_mcq_mode = true;
>  
> @@ -684,6 +687,8 @@ static void ufshcd_device_reset(struct ufs_hba *hba)
>  			hba->dev_info.wb_enabled = false;
>  			hba->dev_info.wb_buf_flush_enabled = false;
>  		}
> +		if (hba->dev_info.rtc_type == UFS_RTC_RELATIVE)
> +			hba->dev_info.rtc_time_baseline = 0;
>  	}
>  	if (err != -EOPNOTSUPP)
>  		ufshcd_update_evt_hist(hba, UFS_EVT_DEV_RESET, err);
> @@ -8191,6 +8196,77 @@ static void ufs_fixup_device_setup(struct ufs_hba *hba)
>  	ufshcd_vops_fixup_dev_quirks(hba);
>  }
>  
> +static void ufshcd_update_rtc(struct ufs_hba *hba)
> +{
> +	int err;
> +	u32 val;
> +	struct timespec64 ts64;

Reverse Xmas order please. Here and in other functions.

> +
> +	ktime_get_real_ts64(&ts64);
> +
> +	if  (ts64.tv_sec < hba->dev_info.rtc_time_baseline) {

Double space after 'if'

> +		dev_warn(hba->dev, "%s: Current time precedes previous setting!\n", __func__);

If there is no RTC on the host, this warning will be printed for 40 years. More below...

> +		return;
> +	}

Newline

> +	/*
> +	 * Absolute RTC mode has 136-year limit as of 2010. Modify UFS Spec or choosing relative
> +	 * RTC mode for longer (beyond year 2146) time spans.

I feel like this comment is not clear enough.

Maybe something like,

"The code is bound to work for 136 years with relative mode and till year 2146
with absolute mode."

> +	 */
> +	val = ts64.tv_sec - hba->dev_info.rtc_time_baseline;
> +

This logic will work if the host has RTC. But if there is no RTC, then tv_sec
will return time elapsed since boot. The spec clearly states that host should
use absolute mode if it has RTC and relative otherwise.

Maybe you should add a logic to detect whether RTC is present or not and
override the mode in device?

> +	ufshcd_rpm_get_sync(hba);
> +	err = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_WRITE_ATTR, QUERY_ATTR_IDN_SECONDS_PASSED,
> +				0, 0, &val);
> +	ufshcd_rpm_put_sync(hba);
> +
> +	if (err)
> +		dev_err(hba->dev, "%s: Failed to update rtc %d\n", __func__, err);
> +	else if (hba->dev_info.rtc_type == UFS_RTC_RELATIVE)
> +		hba->dev_info.rtc_time_baseline = ts64.tv_sec;
> +}
> +
> +static void ufshcd_rtc_work(struct work_struct *work)
> +{
> +	struct ufs_hba *hba;
> +	bool is_busy;
> +
> +	hba = container_of(to_delayed_work(work), struct ufs_hba, ufs_rtc_update_work);
> +
> +	is_busy = ufshcd_is_ufs_dev_busy(hba);

Newline

> +	/*
> +	 * RTC updates should not interfere with normal IO requests; we should only update the RTC

No semicolon within comments please. Use full stop for sentence breaks.

> +	 * when there are no ongoing requests.
> +	 */
> +	if (!is_busy)
> +		ufshcd_update_rtc(hba);
> +
> +	if (ufshcd_is_ufs_dev_active(hba))
> +		schedule_delayed_work(&hba->ufs_rtc_update_work,
> +			msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
> +}
> +
> +static void  ufs_init_rtc(struct ufs_hba *hba, u8 *desc_buf)

Double space after void.

> +{
> +	struct ufs_dev_info *dev_info = &hba->dev_info;
> +	u16 periodic_rtc_update = get_unaligned_be16(&desc_buf[DEVICE_DESC_PARAM_FRQ_RTC]);
> +
> +	if (periodic_rtc_update & UFS_RTC_TIME_BASELINE) {
> +		dev_info->rtc_type = UFS_RTC_ABSOLUTE;

Newline

- Mani

> +		/*
> +		 * The concept of measuring time in Linux as the number of seconds elapsed since
> +		 * 00:00:00 UTC on January 1, 1970, and UFS ABS RTC is elapsed from January 1st
> +		 * 2010 00:00, here we need to adjust ABS baseline.
> +		 */
> +		dev_info->rtc_time_baseline = mktime64(2010, 1, 1, 0, 0, 0) -
> +							mktime64(1970, 1, 1, 0, 0, 0);
> +	} else {
> +		dev_info->rtc_type = UFS_RTC_RELATIVE;
> +		dev_info->rtc_time_baseline = 0;
> +	}
> +
> +	INIT_DELAYED_WORK(&hba->ufs_rtc_update_work, ufshcd_rtc_work);
> +}
> +
>  static int ufs_get_device_desc(struct ufs_hba *hba)
>  {
>  	int err;
> @@ -8243,6 +8319,8 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
>  
>  	ufshcd_temp_notif_probe(hba, desc_buf);
>  
> +	ufs_init_rtc(hba, desc_buf);
> +
>  	if (hba->ext_iid_sup)
>  		ufshcd_ext_iid_probe(hba, desc_buf);
>  
> @@ -8796,6 +8874,8 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
>  	ufshcd_force_reset_auto_bkops(hba);
>  
>  	ufshcd_set_timestamp_attr(hba);
> +	schedule_delayed_work(&hba->ufs_rtc_update_work,
> +				msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
>  
>  	/* Gear up to HS gear if supported */
>  	if (hba->max_pwr_info.is_valid) {
> @@ -9753,6 +9833,8 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  	ret = ufshcd_vops_suspend(hba, pm_op, POST_CHANGE);
>  	if (ret)
>  		goto set_link_active;
> +
> +	cancel_delayed_work_sync(&hba->ufs_rtc_update_work);
>  	goto out;
>  
>  set_link_active:
> @@ -9847,6 +9929,8 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  		if (ret)
>  			goto set_old_link_state;
>  		ufshcd_set_timestamp_attr(hba);
> +		schedule_delayed_work(&hba->ufs_rtc_update_work,
> +					msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
>  	}
>  
>  	if (ufshcd_keep_autobkops_enabled_except_suspend(hba))
> diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
> index e77ab1786856..8022d267fe8a 100644
> --- a/include/ufs/ufs.h
> +++ b/include/ufs/ufs.h
> @@ -14,6 +14,7 @@
>  #include <linux/bitops.h>
>  #include <linux/types.h>
>  #include <uapi/scsi/scsi_bsg_ufs.h>
> +#include <linux/time64.h>
>  
>  /*
>   * Using static_assert() is not allowed in UAPI header files. Hence the check
> @@ -551,6 +552,15 @@ struct ufs_vreg_info {
>  	struct ufs_vreg *vdd_hba;
>  };
>  
> +/*
> + * UFS device descriptor wPeriodicRTCUpdate bit9 defines RTC time baseline.
> + */
> +#define UFS_RTC_TIME_BASELINE BIT(9)
> +enum ufs_rtc_time {
> +	UFS_RTC_RELATIVE,
> +	UFS_RTC_ABSOLUTE
> +};
> +
>  struct ufs_dev_info {
>  	bool	f_power_on_wp_en;
>  	/* Keeps information if any of the LU is power on write protected */
> @@ -578,6 +588,10 @@ struct ufs_dev_info {
>  
>  	/* UFS EXT_IID Enable */
>  	bool	b_ext_iid_en;
> +
> +	/* UFS RTC */
> +	enum ufs_rtc_time rtc_type;
> +	time64_t rtc_time_baseline;
>  };
>  
>  /*
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index d862c8ddce03..727bdf296b34 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -912,6 +912,8 @@ enum ufshcd_mcq_opr {
>   * @mcq_base: Multi circular queue registers base address
>   * @uhq: array of supported hardware queues
>   * @dev_cmd_queue: Queue for issuing device management commands
> + * @mcq_opr: MCQ operation and runtime registers
> + * @ufs_rtc_update_work: A work for UFS RTC periodic update
>   */
>  struct ufs_hba {
>  	void __iomem *mmio_base;
> @@ -1076,6 +1078,8 @@ struct ufs_hba {
>  	struct ufs_hw_queue *uhq;
>  	struct ufs_hw_queue *dev_cmd_queue;
>  	struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
> +
> +	struct delayed_work ufs_rtc_update_work;
>  };
>  
>  /**
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
