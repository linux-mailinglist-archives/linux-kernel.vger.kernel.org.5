Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81867E6C05
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjKIOFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjKIOFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:05:41 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66110B0;
        Thu,  9 Nov 2023 06:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1699538737; bh=+pIs7k9yx4Q2WH+JvxI+wRkYyPXdIJCKAaNW3XLfWkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sg+/XMxeupVvzVpRDf7TGc4hbmCyLEtdzMFRVMoOYsBS7SKP4iFp6pSh7SQdzL9BC
         qqJlFP33owZYMT2nk6sB1wjp7jdRFd4q1xrCS1ZTT1NdUpzaHH34qzbXbW+cmvgfQN
         +CIFhyYZAyYQo0HPFRp6QedYPqZWKRMPyLIkyvrE=
Date:   Thu, 9 Nov 2023 15:05:37 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, mani@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com
Subject: Re: [PATCH v1 2/2] scsi: ufs: core: Add sysfs node for UFS RTC update
Message-ID: <f1fe8b99-bf57-4243-90bb-665c3bb4e0e4@t-8ch.de>
References: <20231109125217.185462-1-beanhuo@iokpp.de>
 <20231109125217.185462-3-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109125217.185462-3-beanhuo@iokpp.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-09 13:52:17+0100, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> This patch introduces a sysfs node named 'rtc_update_ms' within the kernel, enabling users to
> adjust the RTC periodic update frequency to suit the specific requirements of the system and
> UFS. Also, this patch allows the user to disable periodic update RTC  in the UFS idle time.
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  drivers/ufs/core/ufs-sysfs.c | 31 +++++++++++++++++++++++++++++++
>  drivers/ufs/core/ufshcd.c    |  4 ++--
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
> index c95906443d5f..d42846316a86 100644
> --- a/drivers/ufs/core/ufs-sysfs.c
> +++ b/drivers/ufs/core/ufs-sysfs.c
> @@ -255,6 +255,35 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
>  	return res < 0 ? res : count;
>  }
>  
> +static ssize_t rtc_update_ms_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", hba->dev_info.rtc_update_period);
> +}
> +
> +static ssize_t rtc_update_ms_store(struct device *dev, struct device_attribute *attr,
> +			   const char *buf, size_t count)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +	unsigned int ms;
> +	bool resume_period_update;
> +
> +	if (kstrtouint(buf, 0, &ms))
> +		return -EINVAL;
> +
> +	if (!hba->dev_info.rtc_update_period && ms > 0)
> +		resume_period_update =  true;
> +	/* Minimum and maximum update frequency should be synchronized with all UFS vendors */
> +	hba->dev_info.rtc_update_period = ms;
> +
> +	if (resume_period_update)

Variable will be unitialized when if() above did not trigger.

> +		schedule_delayed_work(&hba->ufs_rtc_delayed_work,
> +						msecs_to_jiffies(hba->dev_info.rtc_update_period));

What about the other work that has already been scheduled?

> +	return count;
> +}
> +
>  static ssize_t enable_wb_buf_flush_show(struct device *dev,
>  				    struct device_attribute *attr,
>  				    char *buf)
> @@ -339,6 +368,7 @@ static DEVICE_ATTR_RW(auto_hibern8);
>  static DEVICE_ATTR_RW(wb_on);
>  static DEVICE_ATTR_RW(enable_wb_buf_flush);
>  static DEVICE_ATTR_RW(wb_flush_threshold);
> +static DEVICE_ATTR_RW(rtc_update_ms);

The whole attribute needs documentation.
>  
>  static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
>  	&dev_attr_rpm_lvl.attr,
> @@ -351,6 +381,7 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
>  	&dev_attr_wb_on.attr,
>  	&dev_attr_enable_wb_buf_flush.attr,
>  	&dev_attr_wb_flush_threshold.attr,
> +	&dev_attr_rtc_update_ms.attr,
>  	NULL
>  };
>  
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index f0e3dd3dd280..ae9b60619fd3 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8234,9 +8234,9 @@ static void ufshcd_rtc_work(struct work_struct *work)
>  
>  	ufshcd_update_rtc(hba);
>  out:
> -	if (ufshcd_is_ufs_dev_active(hba))
> +	if (ufshcd_is_ufs_dev_active(hba) && hba->dev_info.rtc_update_period)
>  		schedule_delayed_work(&hba->ufs_rtc_delayed_work,
> -							msecs_to_jiffies(UFS_RTC_UPDATE_EVERY_MS));
> +						msecs_to_jiffies(hba->dev_info.rtc_update_period));
>  	return;
>  }
>  
> -- 
> 2.34.1
> 
