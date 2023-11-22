Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FA97F4C20
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjKVQR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjKVQR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:17:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B2E1BD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700669842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HMXPB8e+kuDV4SqjXMqZbK6MZs4Kgl00oqO6JmCApQk=;
        b=JVYdOWCcqIF4fdX9pG2/mW6BIs/d22VwTp/DhTm6v664BDhsCpq50F3iyWxVNnnQV0sob5
        KAyMkqDxwuJTYzwifISQ/Axwt8vTqE5d7eAizvNGBKNPhdAM4z39QHySkiMNf2OjAlm/hp
        0TaRLvgR+Fut/Up9LN/PBIKAn239lag=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-wQoXN6HWM5i5ZdzOt2qEGw-1; Wed, 22 Nov 2023 11:17:21 -0500
X-MC-Unique: wQoXN6HWM5i5ZdzOt2qEGw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66d91b47f23so46317626d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:17:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700669841; x=1701274641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMXPB8e+kuDV4SqjXMqZbK6MZs4Kgl00oqO6JmCApQk=;
        b=HPwnYuMotvPVLXp1ens+ebwcakDz3saDegixOTUxHXdiatGNPnlKRJtzGWMdZfUnWp
         34nDLf+cHo29gD2AtTHJCc/+iSJTvTvOWk7af8Dm7czwLZy8nAEYa+3A6klXbRATR0WT
         tGSV2IVKtT8ztGn70WhGDip9pHYXqO++vawsHiwOHbjRPbuO0jsLvTBDTQAEpwWkl4ot
         RNlWGVsGzkLHOHKqRb4bLTp9vTEdlUfE+6uFHTtJG6ILzuvTP2/XFAkct4LXhdP9gq3b
         B+wPkbAGrry+DJPolUNTH1obdks0gK3ed+w/YiVm/m0mub3ySspaiueQ0QkiP32Q4Uj7
         ayUg==
X-Gm-Message-State: AOJu0YxvaH6M9s6z4pFdyey/qoAAPWl0VxMVGSoa4r4lHaJRco3n/hH7
        vcxmyh1EjM9wF+zcFlg8OHoiELzIP0uPHsyN/1Mcy+hXCCMA1QyqqcsO4KPQ3BTlClHjwpAh6LD
        HOSyhgxgBrKBTULsnDknjufyQ
X-Received: by 2002:ad4:5945:0:b0:66d:2543:b356 with SMTP id eo5-20020ad45945000000b0066d2543b356mr3121827qvb.41.1700669840860;
        Wed, 22 Nov 2023 08:17:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiiTEJavz/ZxxjHU7IIcpDPbLjOb/Jn/baHypHMXYGqWoTbb+pFB+lecSqC2nIF1esjuEc1Q==
X-Received: by 2002:ad4:5945:0:b0:66d:2543:b356 with SMTP id eo5-20020ad45945000000b0066d2543b356mr3121802qvb.41.1700669840540;
        Wed, 22 Nov 2023 08:17:20 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id p7-20020ad452c7000000b0066d20f29e5fsm5015787qvs.35.2023.11.22.08.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 08:17:20 -0800 (PST)
Date:   Wed, 22 Nov 2023 10:17:17 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 00/11] Enable HS-G5 support on SM8550
Message-ID: <gkqaea2bh3pylqmhxpld5cdtfrejzssvqejb6ti7q3ekocgiol@mfngbj5dmcfz>
References: <1700637042-11104-1-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1700637042-11104-1-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:10:31PM -0800, Can Guo wrote:
> This series enables HS-G5 support on SM8550.
> 
> This series is rebased on below changes from Mani -
> https://patchwork.kernel.org/project/linux-scsi/patch/20230908145329.154024-1-manivannan.sadhasivam@linaro.org/
> https://patchwork.kernel.org/project/linux-scsi/patch/20230908145329.154024-2-manivannan.sadhasivam@linaro.org/
> 
> This series is tested on below HW combinations -
> SM8550 MTP + UFS4.0
> SM8550 QRD + UFS3.1
> SM8450 MTP + UFS3.1 (for regression test)
> SM8350 MTP + UFS3.1 (for regression test)
> 
> Note that during reboot test on above platforms, I occasinally hit PA (PHY)
> error during the 2nd init, this is not related with this series. A fix for
> this is mentioned in below patchwork -
> 
> https://patchwork.kernel.org/project/linux-scsi/patch/1698145815-17396-1-git-send-email-quic_ziqichen@quicinc.com/
> 
> Also note that on platforms, which have two sets of UFS PHY settings are
> provided (say G4 and no-G4, G5 and no-G5). The two sets of PHY settings are
> basically programming different values to different registers, mixing the
> two sets and/or overwriting one set with another set is definitely not
> blessed by UFS PHY designers. For SM8550, this series will make sure we
> honor the rule. However, for old targets Mani and I will fix them in
> another series in future.
> 
> v2 -> v3:
> 1. Addressed comments from Andrew, Mani and Bart in patch #1
> 2. Added patch #2 as per request from Andrew and Mani
> 3. Added patch #4 to fix a common issue on old targets, it is not necessary
>    for this series, but put in this series only because it would be easier
>    to maintain and no need to rebase
> 4. Addressed comments from Dmitry and Mani in patches to phy-qcom-qmp-ufs.c
> 
> v1 -> v2:
> 1. Removed 2 changes which were exposing power info in sysfs
> 2. Removed 1 change which was moving data structs to phy-qcom-qmp-ufs.h
> 3. Added one new change (the 1st one) to clean up usage of ufs_dev_params based on comments from Mani
> 4. Adjusted the logic of UFS device version detection according to comments from Mani:
> 	4.1 For HW version < 0x5, go through dual init
>  	4.2 For HW version >= 0x5
> 		a. If UFS device version is populated, one init is required
> 		b. If UFS device version is not populated, go through dual init

The cover letter didn't include linux-arm-msm@vger.kernel.org, which
made me have to go searching for this on lore to see what had changed
in the rest of the series I received as a member of that mailing list.

Going forward please try and include that mailing list!

> 
> Bao D. Nguyen (1):
>   scsi: ufs: ufs-qcom: Add support for UFS device version detection
> 
> Can Guo (10):
>   scsi: ufs: host: Rename structure ufs_dev_params to ufs_host_params
>   scsi: ufs: ufs-qcom: No need to set hs_rate after
>     ufshcd_init_host_param()
>   scsi: ufs: ufs-qcom: Setup host power mode during init
>   scsi: ufs: ufs-qcom: Limit negotiated gear to selected PHY gear
>   scsi: ufs: ufs-qcom: Allow the first init start with the maximum
>     supported gear
>   scsi: ufs: ufs-qcom: Limit HS-G5 Rate-A to hosts with HW version 5
>   scsi: ufs: ufs-qcom: Set initial PHY gear to max HS gear for HW ver 5
>     and newer
>   phy: qualcomm: phy-qcom-qmp-ufs: Rectify SM8550 UFS HS-G4 PHY Settings
>   phy: qualcomm: phy-qcom-qmp-ufs: Use tbls_hs_max instead of tbls_hs_g4
>   phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed Gear 5 support for
>     SM8550
> 
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   2 +
>  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   2 +
>  .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |  12 ++
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 171 ++++++++++++++++-----
>  drivers/ufs/host/ufs-exynos.c                      |   7 +-
>  drivers/ufs/host/ufs-hisi.c                        |  11 +-
>  drivers/ufs/host/ufs-mediatek.c                    |  12 +-
>  drivers/ufs/host/ufs-qcom.c                        |  92 ++++++++---
>  drivers/ufs/host/ufs-qcom.h                        |   5 +-
>  drivers/ufs/host/ufshcd-pltfrm.c                   |  69 ++++-----
>  drivers/ufs/host/ufshcd-pltfrm.h                   |  10 +-
>  11 files changed, 275 insertions(+), 118 deletions(-)
> 
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

