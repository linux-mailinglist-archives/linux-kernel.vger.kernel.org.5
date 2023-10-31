Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2557DCD12
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344286AbjJaMfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344269AbjJaMfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:35:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C8698;
        Tue, 31 Oct 2023 05:35:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35809C433C7;
        Tue, 31 Oct 2023 12:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698755706;
        bh=CBUVROw+HLBHDa2ZlqHiNrVzZsfNM0kP05CgmKncJNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AawslDTlAr3FVetIK2w1+5xf8zUrdTnBOlL5+1k/IGBS0bTro3bVAGBSSlELDglx1
         MzW5gd1lJdVTCr2CFhMBnoLi+qlqpDMHjNH/Uw0MXNsbo2J4kaXoSFBf7O56G0AtpP
         Z1A2poUGNtoXPPpP+hnExpbxDc4agt5tYzLk/ahJHhlBuzcKZBNzxQ/fggTLsbZ8if
         pPVC/Ftf7XIwmrYroSoWXie3J7cF0Urzz9GOzQuvZYHlv0bSDSjbR/bpsghU0TczDx
         EI7yuvYUiIZxyRo2u7HDFaxbyfNsuJmVE3PRQIMSSUG97cNVE+jDLQYcFlvOtNwvF8
         frJLmHTbZetJw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qxny2-00067y-1C;
        Tue, 31 Oct 2023 13:35:34 +0100
Date:   Tue, 31 Oct 2023 13:35:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH] drm/msm/dpu: Add missing safe_lut_tbl in sc8280xp catalog
Message-ID: <ZUD0lhStirf8IN8-@hovoldconsulting.com>
References: <20231030-sc8280xp-dpu-safe-lut-v1-1-6d485d7b428f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030-sc8280xp-dpu-safe-lut-v1-1-6d485d7b428f@quicinc.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 04:23:20PM -0700, Bjorn Andersson wrote:
> During USB transfers on the SC8280XP __arm_smmu_tlb_sync() is seen to
> typically take 1-2ms to complete. As expected this results in poor
> performance, something that has been mitigated by proposing running the
> iommu in non-strict mode (boot with iommu.strict=0).
> 
> This turns out to be related to the SAFE logic, and programming the QOS
> SAFE values in the DPU (per suggestion from Rob and Doug) reduces the
> TLB sync time to below 10us, which means significant less time spent
> with interrupts disabled and a significant boost in throughput.

I ran some tests with a gigabit ethernet adapter to get an idea of how
this performs in comparison to using lazy iommu mode ("non-strict"):

		6.6	6.6-lazy	6.6-dpu		6.6-dpu-lazy
iperf3 recv	114	941		941		941		MBit/s
iperf3 send	124	891		703		940		MBit/s

scp recv	14.6	110		110		111		MB/s
scp send	12.5	98.9		91.5		110		MB/s

This patch in itself indeed improves things quite a bit, but there is
still some performance that can be gained by using lazy iommu mode.

Notably, lazy mode with this patch applied appears to saturate the link
in both directions.

Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan
