Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CDB7A6279
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjISMRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjISMRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:17:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3337CD9;
        Tue, 19 Sep 2023 05:16:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173C5C433C9;
        Tue, 19 Sep 2023 12:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695125792;
        bh=Lc5xs7WnAK+N37XS6wUjcU4LxvvMUYqTgysilfrXRco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mfrqp5VAS4erPq6YdeOlcSTUN2s/B4vowHUx1e+xbzkvJg1O2PqYUiLp6hkEUmsUU
         AJtgUEShsAIsdQQZ+z3HDLJxJLCqtdBVLggbR8664cL8+d4QzNJZiB6BEPdzQlD7wz
         xbR4/5Qy4JyN2FQbaiA81WsHT8VgqK75UxfPBZ7vsfg45Z7PM1/UqPTd1WbpPoRah/
         Vt5GHXw1ZvXb65BVpl/r1RiYsvjKzgz6rs+rOOXhZhXUOtvUbRHFLS0HTStdyGLjCL
         7dU0PUHS2JENFjIsT5dn0g0oJMfBR+KJ+hGTTOl7CsT46datquwwxQjTC3PCZU6Isz
         Kta5glU8vtFUA==
Date:   Tue, 19 Sep 2023 14:16:27 +0200
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Arthur Simchaev <arthur.simchaev@wdc.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] scsi: ufs: ufs-sysfs: Expose UFS power info
Message-ID: <20230919121627.GE4732@thinkpad>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-6-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1694411968-14413-6-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 10:59:26PM -0700, Can Guo wrote:
> Having UFS power info available in sysfs makes it easier to tell the state
> of the link during runtime considering we have a bounch of power saving
> features and various combinations for backward compatiblity.
> 

Please move the sysfs patches to a separate series.

- Mani

> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
>  drivers/ufs/core/ufs-sysfs.c | 71 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
> index c959064..53af490 100644
> --- a/drivers/ufs/core/ufs-sysfs.c
> +++ b/drivers/ufs/core/ufs-sysfs.c
> @@ -628,6 +628,76 @@ static const struct attribute_group ufs_sysfs_monitor_group = {
>  	.attrs = ufs_sysfs_monitor_attrs,
>  };
>  
> +static ssize_t gear_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%u\n", hba->pwr_info.gear_rx);
> +}
> +
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
> +	return sysfs_emit(buf, "%u\n", hba->pwr_info.pwr_rx);
> +}
> +
> +static ssize_t rate_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%u\n", hba->pwr_info.hs_rate);
> +}
> +
> +static ssize_t dev_pm_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", hba->curr_dev_pwr_mode);
> +}
> +
> +static ssize_t link_state_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", hba->uic_link_state);
> +}
> +
> +static DEVICE_ATTR_RO(gear);
> +static DEVICE_ATTR_RO(lane);
> +static DEVICE_ATTR_RO(mode);
> +static DEVICE_ATTR_RO(rate);
> +static DEVICE_ATTR_RO(dev_pm);
> +static DEVICE_ATTR_RO(link_state);
> +
> +static struct attribute *ufs_power_info_attrs[] = {
> +	&dev_attr_gear.attr,
> +	&dev_attr_lane.attr,
> +	&dev_attr_mode.attr,
> +	&dev_attr_rate.attr,
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
> @@ -1233,6 +1303,7 @@ static const struct attribute_group *ufs_sysfs_groups[] = {
>  	&ufs_sysfs_default_group,
>  	&ufs_sysfs_capabilities_group,
>  	&ufs_sysfs_monitor_group,
> +	&ufs_sysfs_power_info_group,
>  	&ufs_sysfs_device_descriptor_group,
>  	&ufs_sysfs_interconnect_descriptor_group,
>  	&ufs_sysfs_geometry_descriptor_group,
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
