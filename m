Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E2F80778B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378387AbjLFSZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjLFSZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:25:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F53D59
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701887102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KTobgsnYUuUSJ3+JcdTWkz3Ys2jB6Jq/YKHe84U3RGg=;
        b=cXZl+/aAQazCQOD43RAsW/xrrqW4ebwIGBjocUEpGlhW3aB0NXZBgbvgk18cvkpN3888/s
        neaZX7uLaLgVyOFOAWUKLImFTHu4TZ/tzdhouNOIkgR3WqXypykMtQHjD0skq107WMxM/K
        EzjfCxopAbdkcFtYqgxlh5TtVtBVhA4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-2TgtkoZ1O6SyrZTBst8uqw-1; Wed, 06 Dec 2023 13:15:52 -0500
X-MC-Unique: 2TgtkoZ1O6SyrZTBst8uqw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-77dc7b361f8so944438885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 10:15:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701886549; x=1702491349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTobgsnYUuUSJ3+JcdTWkz3Ys2jB6Jq/YKHe84U3RGg=;
        b=wTfor8tsKyaPqUqorHPgD4n/g24G99YfYoD0VXrCyNyB+AEHJp6qqgUwZ2cNd3xjuR
         ttuyyntuuL1ZO4w9OK0bCfuKyFKwcD4UqoqX/Kv3Eml0GVCx6doSY2yBLMRoNSxsjzUj
         Yo75W/mrBPX7AQezHCLHHji+ul5T/ImA9YD6PoOfR7QwN1CfkJ9ufkuxN93p2dbEUWcV
         8qCqMmawAUedn+XXNVxq+R/fEDvmzbt6/TQeGjn/GRbmZi6E3aYeVq1cpHO7kel85quL
         PorGqn+C/FqzykI4BgRWYWm/dL7EHYKOFtx6edTIsKKCCOIVF41Uh9RsoqYk2PtfhaBP
         GMkQ==
X-Gm-Message-State: AOJu0YzTn7FCRW0v3FtXWZPW3/Qkh7RomdjioqGjYcfVnPosXMx9yG5k
        Ggtd7lomLGk0ptXgSJ6ZZFTTIxQkgW5UXC/TeVpvfVgucHs0BjN6ARZv7JT9EHdQucoRyWlXpiz
        ezUXpLPHyPgKXBJugVaXpdaxA
X-Received: by 2002:a05:622a:1c7:b0:425:4043:1daf with SMTP id t7-20020a05622a01c700b0042540431dafmr1590223qtw.130.1701886548807;
        Wed, 06 Dec 2023 10:15:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYXmE8oxD/ljT+fjjqAZa2L1Mek9Kw87+1sXy5PKCDiHvI+RdUhoxjbWV8Mvzl4SX522xqJg==
X-Received: by 2002:a05:622a:1c7:b0:425:4043:1daf with SMTP id t7-20020a05622a01c700b0042540431dafmr1590209qtw.130.1701886548556;
        Wed, 06 Dec 2023 10:15:48 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id d20-20020ac85454000000b00423dfab8fc3sm140297qtq.32.2023.12.06.10.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:15:48 -0800 (PST)
Date:   Wed, 6 Dec 2023 12:15:46 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com
Subject: Re: [PATCH 04/13] scsi: ufs: qcom: Remove superfluous variable
 assignments
Message-ID: <lpon5atd74luwzrnzh2imc3h7e7hvdn4nopi6ocw7uvzw72dgr@llure3vkleru>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
 <20231201151417.65500-5-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201151417.65500-5-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 08:44:08PM +0530, Manivannan Sadhasivam wrote:
> There are many instances where the variable assignments are not needed.
> Remove them.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/ufs/host/ufs-qcom.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 778df0a9c65e..dc93b1c5ca74 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -219,7 +219,7 @@ static int ufs_qcom_enable_lane_clks(struct ufs_qcom_host *host)
>  
>  static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
>  {
> -	int err = 0;
> +	int err;
>  	struct device *dev = host->hba->dev;
>  
>  	if (has_acpi_companion(dev))
> @@ -237,7 +237,7 @@ static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
>  static int ufs_qcom_check_hibern8(struct ufs_hba *hba)
>  {
>  	int err;
> -	u32 tx_fsm_val = 0;
> +	u32 tx_fsm_val;
>  	unsigned long timeout = jiffies + msecs_to_jiffies(HBRN8_POLL_TOUT_MS);
>  
>  	do {
> @@ -292,9 +292,9 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
>   */
>  static int ufs_qcom_host_reset(struct ufs_hba *hba)
>  {
> -	int ret = 0;
> +	int ret;
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> -	bool reenable_intr = false;
> +	bool reenable_intr;
>  
>  	if (!host->core_reset) {
>  		dev_warn(hba->dev, "%s: reset control not set\n", __func__);
> @@ -417,7 +417,7 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
>  				      enum ufs_notify_change_status status)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> -	int err = 0;
> +	int err;
>  
>  	switch (status) {
>  	case PRE_CHANGE:
> @@ -463,7 +463,7 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>  	u32 core_clk_period_in_ns;
>  	u32 tx_clk_cycles_per_us = 0;
>  	unsigned long core_clk_rate = 0;
> -	u32 core_clk_cycles_per_us = 0;
> +	u32 core_clk_cycles_per_us;
>  
>  	static u32 pwm_fr_table[][2] = {
>  		{UFS_PWM_G1, 0x1},
> @@ -1418,7 +1418,7 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
>  		bool scale_up, enum ufs_notify_change_status status)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> -	int err = 0;
> +	int err;
>  
>  	/* check the host controller state before sending hibern8 cmd */
>  	if (!ufshcd_is_hba_active(hba))
> @@ -1689,7 +1689,7 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
>  	struct platform_device *pdev = to_platform_device(hba->dev);
>  	struct ufshcd_res_info *res;
>  	struct resource *res_mem, *res_mcq;
> -	int i, ret = 0;
> +	int i, ret;
>  
>  	memcpy(hba->res, ufs_res_info, sizeof(ufs_res_info));
>  
> -- 
> 2.25.1
> 
> 

