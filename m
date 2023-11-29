Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F177FE14F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjK2UsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjK2UsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:48:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884ACD67
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701290891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IgK9SVKODvB48bATs/GY8yc91KWuPlynI97GGsWOuZo=;
        b=DkkebFhdHgzw1IhtizdPzuJjw4dBzpG/kcmDiEAdi4WYYTg/R7DZYxt6uqMlD8QHvOTdZR
        CHR0/jioLWiHZDtUhj6Y1Yxmx7spi4GSxwuvBV3x6vcRYyL3oBE683erjnZPQTBf6W/40F
        JKK7bQ1yzrbRPZrSA64fWFfJR0YfQk4=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-yf3tD62uOHuW_ONrudphjQ-1; Wed, 29 Nov 2023 15:48:10 -0500
X-MC-Unique: yf3tD62uOHuW_ONrudphjQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5ca61d84dc3so4036547b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:48:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701290889; x=1701895689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgK9SVKODvB48bATs/GY8yc91KWuPlynI97GGsWOuZo=;
        b=QFEUBjZIBYHKe7ghb120a8Z4F73ezSCUhjBwo+s4E3V6dBe1pMRJN32muXxQh1AUEc
         p8iJcRr4hN0YwrVUnPM9fM+yA1W/Di0F2mo6zC3WGt7Entscdag/hyEi8GS3xyeDjJZi
         VKk/jEt9g7ge0iFdUdihlOWK7+t/Zgpe49Nh/Ob0Lul2qtTPSSTSPeMMiEC8cJhCvVBt
         e1jIvdfdU3EzV/aGoe9ET2a94vwvwxmE0DQaJuOXtAopmnC5vGjXTh/L098drlhSHZ7X
         pmzA1xMB8AhtwbB9xSv7dXuHMW9Dh2dC4Vt/2wwm5uxUD3pulQfRZIBey0Qh856a59l4
         P7gg==
X-Gm-Message-State: AOJu0YzisMMjpAP4YWrZT2X0Ck/rD/ZQEynMB5j4nM68PYOLecyqJ2Yi
        vWssn0ImGe2XGhI/OCwqTzwsKQcbyAeOzeAIkUaf3qOQOyVSMIdxC5fHn2V4J3ZsBitcHToo8SD
        k3cHaSToaUBWFZgFcI9zCcVDU
X-Received: by 2002:a05:690c:3145:b0:5d0:bd82:a87d with SMTP id fc5-20020a05690c314500b005d0bd82a87dmr9985297ywb.9.1701290889557;
        Wed, 29 Nov 2023 12:48:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnJ3Gqey62Zd2lyl5c2NqI9b6c5SGjVB3aYgy6NvYWJzN7gTHxO7Ubp0FYkzvfEQ+0pZ4bFg==
X-Received: by 2002:a05:690c:3145:b0:5d0:bd82:a87d with SMTP id fc5-20020a05690c314500b005d0bd82a87dmr9985278ywb.9.1701290889271;
        Wed, 29 Nov 2023 12:48:09 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id kc9-20020a056214410900b0067a15610d3csm5588607qvb.72.2023.11.29.12.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:48:08 -0800 (PST)
Date:   Wed, 29 Nov 2023 14:48:06 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, mani@kernel.org, adrian.hunter@intel.com,
        cmd4@qualcomm.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 02/10] scsi: ufs: ufs-qcom: No need to set hs_rate
 after ufshcd_init_host_param()
Message-ID: <y26a4ciloi6bcmil2hfmsezjeaomjm56ukzdlbm5fxlwpj3rr5@3rs7b5mkehpx>
References: <1701246516-11626-1-git-send-email-quic_cang@quicinc.com>
 <1701246516-11626-3-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701246516-11626-3-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 12:28:27AM -0800, Can Guo wrote:
> In ufs_qcom_pwr_change_notify(), host_params.hs_rate has been set to
> PA_HS_MODE_B by ufshcd_init_host_param(), hence remove the duplicated line
> of work. Meanwhile, removed the macro UFS_QCOM_LIMIT_HS_RATE as it is only
> used here.
> 
> Reviewed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/ufs/host/ufs-qcom.c | 1 -
>  drivers/ufs/host/ufs-qcom.h | 2 --
>  2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 197c5a5..c21ff2c 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -909,7 +909,6 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>  	switch (status) {
>  	case PRE_CHANGE:
>  		ufshcd_init_host_params(&host_params);
> -		host_params.hs_rate = UFS_QCOM_LIMIT_HS_RATE;
>  
>  		/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
>  		host_params.hs_tx_gear = host_params.hs_rx_gear = ufs_qcom_get_hs_gear(hba);
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 9950a00..82cd143 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -27,8 +27,6 @@
>  #define SLOW 1
>  #define FAST 2
>  
> -#define UFS_QCOM_LIMIT_HS_RATE		PA_HS_MODE_B
> -
>  /* QCOM UFS host controller vendor specific registers */
>  enum {
>  	REG_UFS_SYS1CLK_1US                 = 0xC0,
> -- 
> 2.7.4
> 
> 

