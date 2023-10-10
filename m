Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CA77BF55C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442670AbjJJILJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442643AbjJJILE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:11:04 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A09EB0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:10:56 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 5183A1F8B8;
        Tue, 10 Oct 2023 10:10:52 +0200 (CEST)
Date:   Tue, 10 Oct 2023 10:10:50 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] drm/msm: dpu1: correctly implement SSPP & WB
 Clock Control Split
Message-ID: <dxcfxhqesrauyo5bscwwj5ejrlulsndiewwfahmnhhztj4gil5@vowdkbp5bsqj>
References: <20231009-topic-sm8550-graphics-sspp-split-clk-v1-0-806c0dee4e43@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-topic-sm8550-graphics-sspp-split-clk-v1-0-806c0dee4e43@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-09 18:36:11, Neil Armstrong wrote:
> Starting with the SM8550 platform, the SSPP & WB Clock Controls are
> no more in the MDP TOP registers, but in the SSPP & WB register space.
> 
> Add the corresponding SSPP & WB ops and use them from the vbif QoS
> and OT limit setup functions.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Neil Armstrong (5):
>       drm/msm: dpu1: create a dpu_hw_clk_force_ctrl() helper
>       drm/msm: dpu1: add setup_clk_force_ctrl() op to sspp & wb
>       drm/msm: dpu1: vbif: add dpu_vbif_setup_clk_force_ctrl() helper
>       drm/msm: dpu1: call wb & sspp clk_force_ctrl op if split clock control
>       drm/msm: dpu1: sm8550: move split clock controls to sspp entries

Fyi we're all using drm/msm/dpu: now :)

- Marijn

> 
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h | 35 +++++++++-----------
>  .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |  4 +--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  4 +++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c        |  9 +++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h        |  9 +++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c         | 23 +------------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c        | 21 ++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h        |  4 +++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c          |  9 +++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h          |  4 +++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |  9 +++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c           | 38 +++++++++++++++++-----
>  drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h           | 12 ++++---
>  13 files changed, 120 insertions(+), 61 deletions(-)
> ---
> base-commit: 9119cf579b4432b36be9d33a92f4331922067d92
> change-id: 20231009-topic-sm8550-graphics-sspp-split-clk-43c32e37b6aa
> 
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
> 
