Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C82780F46F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376346AbjLLRVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbjLLRVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:21:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BDB9F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:21:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F012AC433C8;
        Tue, 12 Dec 2023 17:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702401706;
        bh=ycMr8MM5ftWs8zYQIf6QMOdO2N+q3aTQBI93SqgK/d0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sg+6t1As+Ksr5VxeJvEvdiiiTLI1ak5JqD++Q2iMDZhhJLoBe1W/aSYz28Gxk5nUb
         Q63YaHJgpn9vV3Ovd5HDucifW5ZpcFeCZqFISTOq/qNPgXU7M9foPkwnHDHocOkGug
         N/Wo2v9HwGNyPSUzVURcAQwHk3ntFaJYh3Z4YGXbPNcfEFh9/8bzSSSZk2yMvrr42E
         /vZMFkE6O1qirpjyUiTFA8USm3zON92CUHKPwd3h6xNeNWVA6TjZ0+PdRGzF/gMdWe
         GwD0OCZ1iQdFkdX9FWk4RZLVKua3a3qTqFLmd1VPRl8jvGInPacmSZGcuNa5HSjdbz
         Qbi+vYX9fiv4A==
From:   Will Deacon <will@kernel.org>
To:     Rob Clark <robdclark@gmail.com>, iommu@lists.linux-foundation.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Johan Hovold <johan@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org, freedreno@lists.freedesktop.org,
        Danila Tikhonov <danila@jiaxyga.com>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Add missing GMU entry to match table
Date:   Tue, 12 Dec 2023 17:21:00 +0000
Message-Id: <170238423845.3097390.5149753894021729752.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231210180655.75542-1-robdclark@gmail.com>
References: <20231210180655.75542-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2023 10:06:53 -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> In some cases the firmware expects cbndx 1 to be assigned to the GMU,
> so we also want the default domain for the GMU to be an identy domain.
> This way it does not get a context bank assigned.  Without this, both
> of_dma_configure() and drm/msm's iommu_domain_attach() will trigger
> allocating and configuring a context bank.  So GMU ends up attached to
> both cbndx 1 and later cbndx 2.  This arrangement seemingly confounds
> and surprises the firmware if the GPU later triggers a translation
> fault, resulting (on sc8280xp / lenovo x13s, at least) in the SMMU
> getting wedged and the GPU stuck without memory access.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-qcom: Add missing GMU entry to match table
      https://git.kernel.org/will/c/afc95681c306

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
