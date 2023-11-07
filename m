Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02957E4943
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbjKGThK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKGThI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:37:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B8610C2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 11:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699385786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f2GkHL9Asj7cZ9gDAWnYJZ3/Dq1fD/MZuGhccXlmPBI=;
        b=NhA1CGR0UFPhu8QelbylwBtUoLaNzgzLVs2WsDRcvin2oIMFGxozyyqKwzaQacxuqgKjeQ
        Vdl+In89naHiYMiIcRaXUCbN2TtsC962RpTQN4jIHdSdvG9Vf/fRb0km852jpzJ8M5omvU
        Q27HBcMUKctQrkUTMJKOArg94ljCioI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-7SpcM0G8PqqhehLd3_osnw-1; Tue, 07 Nov 2023 14:36:24 -0500
X-MC-Unique: 7SpcM0G8PqqhehLd3_osnw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66da680f422so70898186d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 11:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699385784; x=1699990584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2GkHL9Asj7cZ9gDAWnYJZ3/Dq1fD/MZuGhccXlmPBI=;
        b=AW3S74PGWcskycAyBg6r4yQp9KAla4a6lUDTkCUymeOOPP8OJ8juXVWCtjnf6f/IZ4
         DVB/dXxC7+VhpUl1JKtlDa7FB9osU7SzbbMVOa5DHsEZCQI8Re+64I7IdQ/cLb1O4Of8
         HVqL2C0pp49CaRf00WENGca/7ZPCxVnbozjY0MEU7ZtMhx6pKNUnE/38yexClHzGuNgq
         jpfTjTUu7b/O0h9SKVtrtjFyJgbAvYjAiG/S9J26EdyEit1B5DngU1hH9iVUmPN9899d
         CZ9Dx1KSKa0Up7CgisaxUECRYvaI9ML5kTX5p/2ci1lbzS7vbA5z/8Uk2efnRYtfRs/G
         9F4Q==
X-Gm-Message-State: AOJu0YzZ1rqKfu5tbXWtC8UsTA6kA9O4G+4MMYMyq5ZpDY3AB+1YPWI7
        /j3GapaYRtM6MXJ/Ii6ZodXmgq3k4MVaVK5XKYlcf0uNtJBG4OsFv/QEPr1goCDAFHl3mxQCH2X
        Y9A/7VqSBw/NlLOuMrg539kLr
X-Received: by 2002:ad4:5ecf:0:b0:675:6a83:8084 with SMTP id jm15-20020ad45ecf000000b006756a838084mr17136087qvb.14.1699385783789;
        Tue, 07 Nov 2023 11:36:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCasVvUsu1Pm+2+uqpGskpzIAz52YVkupGLyfFo54ljOeoSzf1eiTLLEVSdNTLByNhDpkAJg==
X-Received: by 2002:ad4:5ecf:0:b0:675:6a83:8084 with SMTP id jm15-20020ad45ecf000000b006756a838084mr17136067qvb.14.1699385783454;
        Tue, 07 Nov 2023 11:36:23 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id k16-20020ad44210000000b0067169e210b3sm206076qvp.70.2023.11.07.11.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 11:36:23 -0800 (PST)
Date:   Tue, 7 Nov 2023 13:36:20 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Can Guo <cang@qti.qualcomm.com>
Cc:     quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Brian Masney <bmasney@redhat.com>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-mediatek@lists.infradead.org>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] scsi: ufs: host: Rename structure ufs_dev_params
 to ufs_host_params
Message-ID: <fcovysoo6vxvqdrypfbnfyclrmifibio46rne5zhiqnmqhzd7k@5ltemasdhfxp>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
 <1699332374-9324-2-git-send-email-cang@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699332374-9324-2-git-send-email-cang@qti.qualcomm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 08:46:07PM -0800, Can Guo wrote:
> From: Can Guo <quic_cang@quicinc.com>
> 
> Structure ufs_dev_params is actually used in UFS host vendor drivers to
> declare host specific power mode parameters, like ufs_<vendor>_params or
> host_cap, which makes the code not very straightforward to read. Rename the
> structure ufs_dev_params to ufs_host_params and unify the declarations in
> all vendor drivers to host_params.
> 
> In addition, rename the two functions ufshcd_init_dev_pwr_param() and

nit: s/ufshcd_init_dev_pwr_param/ufshcd_init_pwr_dev_param/

> ufshcd_get_dev_pwr_param() which work based on the ufs_host_params to

nit: s/ufshcd_get_dev_pwr_param/ufshcd_get_pwr_dev_param/

> ufshcd_init_host_param() and ufshcd_negotiate_pwr_param() respectively to
> avoid confusions.
> 
> This change does not change any functionalities or logic.
> 
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
>  drivers/ufs/host/ufs-exynos.c    |  7 +++---
>  drivers/ufs/host/ufs-hisi.c      | 11 ++++-----
>  drivers/ufs/host/ufs-mediatek.c  | 12 ++++------
>  drivers/ufs/host/ufs-qcom.c      | 12 ++++------
>  drivers/ufs/host/ufshcd-pltfrm.c | 49 ++++++++++++++++++++--------------------
>  drivers/ufs/host/ufshcd-pltfrm.h | 10 ++++----
>  6 files changed, 47 insertions(+), 54 deletions(-)
> 

<snip>

> diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
> index da2558e..6e65b61 100644
> --- a/drivers/ufs/host/ufshcd-pltfrm.c
> +++ b/drivers/ufs/host/ufshcd-pltfrm.c
> @@ -285,17 +285,17 @@ static int ufshcd_parse_operating_points(struct ufs_hba *hba)
>  }
>  
>  /**
> - * ufshcd_get_pwr_dev_param - get finally agreed attributes for
> + * ufshcd_negotiate_pwr_param - get finally agreed attributes for
>   *                            power mode change
> - * @pltfrm_param: pointer to platform parameters
> + * @host_param: pointer to platform parameters
>   * @dev_max: pointer to device attributes
>   * @agreed_pwr: returned agreed attributes
>   *
>   * Return: 0 on success, non-zero value on failure.
>   */
> -int ufshcd_get_pwr_dev_param(const struct ufs_dev_params *pltfrm_param,
> -			     const struct ufs_pa_layer_attr *dev_max,
> -			     struct ufs_pa_layer_attr *agreed_pwr)
> +int ufshcd_negotiate_pwr_param(const struct ufs_host_params *host_param,
> +			       const struct ufs_pa_layer_attr *dev_max,
> +			       struct ufs_pa_layer_attr *agreed_pwr)
>  {
>  	int min_pltfrm_gear;

If you're going to change pltfrm -> host, maybe do so for
min_pltfrm_gear too? I think this all reads nicer with the functions
changed as is, but the consistency would be nice in my opinion.

Outside of those nits, I think this reads nicer now as well.

Acked-by: Andrew Halaney <ahalaney@redhat.com>

