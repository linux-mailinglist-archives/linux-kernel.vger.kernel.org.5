Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BBE7E4FDB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 06:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjKHFMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 00:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKHFML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 00:12:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A217B1A2;
        Tue,  7 Nov 2023 21:12:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B04AC433C8;
        Wed,  8 Nov 2023 05:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699420329;
        bh=K+zY1vd1AzBR15/wm5/FSyF+NoBWbzgaQbhnrvCfoLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z3o2DN0FT6oReDKlnXQHft1tS9hlS2i6wraxS3Ci/99sPljKNxq34lz0+OSVDqLVk
         wSDFq2YvuzZWCVfh61kXWeuK3eC72BVjJxTelEF9zZrwh7+RJGk+zU1jM2P8uKrXHm
         qgNvoivRkZbcPg0SKuh32B6ayrIRPY6wQfW1fMfGdFtIa3Upo9HiAeMUDF4Zupshfw
         REvGWYC22S5V9pGRs3zlYgwATd06FEaR4gdu/zgOfIBlTz7FRtLtAX3DBG9/79VbCg
         QiVrFvTBORa75F38YpfzjfDpu8wHPRjcU7SWzMHOlISFPKNZS2f3OGl8+4WUOq+6+2
         y7pwNGdhtJ2Wg==
Date:   Wed, 8 Nov 2023 10:41:56 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <cang@qti.qualcomm.com>
Cc:     quic_cang@quicinc.com, bvanassche@acm.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 0/7] Enable HS-G5 support on SM8550
Message-ID: <20231108051156.GB3296@thinkpad>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 08:46:06PM -0800, Can Guo wrote:
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
> 

You are sending the patches from QTI email and that's not supposed to happen I
believe.

- Mani

> v1 -> v2:
> 1. Removed 2 changes which were exposing power info in sysfs
> 2. Removed 1 change which was moving data structs to phy-qcom-qmp-ufs.h
> 3. Added one new change (the 1st one) to clean up usage of ufs_dev_params based on comments from Mani
> 4. Adjusted the logic of UFS device version detection according to comments from Mani:
> 	4.1 For HW version < 0x5, go through dual init
>  	4.2 For HW version >= 0x5
> 		a. If UFS device version is populated, one init is required
> 		b. If UFS device version is not populated, go through dual init
> 
> Bao D. Nguyen (1):
>   scsi: ufs: ufs-qcom: Add support for UFS device version detection
> 
> Can Guo (6):
>   scsi: ufs: host: Rename structure ufs_dev_params to ufs_host_params
>   scsi: ufs: ufs-qcom: Setup host power mode during init
>   scsi: ufs: ufs-qcom: Allow the first init start with the maximum
>     supported gear
>   scsi: ufs: ufs-qcom: Limit HS-G5 Rate-A to hosts with HW version 5
>   scsi: ufs: ufs-qcom: Set initial PHY gear to max HS gear for HW ver 5
>     and newer
>   phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed Gear 5 support for
>     SM8550
> 
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |   2 +
>  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h |   2 +
>  .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |  12 +++
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 112 ++++++++++++++++++---
>  drivers/ufs/host/ufs-exynos.c                      |   7 +-
>  drivers/ufs/host/ufs-hisi.c                        |  11 +-
>  drivers/ufs/host/ufs-mediatek.c                    |  12 +--
>  drivers/ufs/host/ufs-qcom.c                        |  78 ++++++++++----
>  drivers/ufs/host/ufs-qcom.h                        |   3 +
>  drivers/ufs/host/ufshcd-pltfrm.c                   |  49 +++++----
>  drivers/ufs/host/ufshcd-pltfrm.h                   |  10 +-
>  11 files changed, 217 insertions(+), 81 deletions(-)
> 
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
