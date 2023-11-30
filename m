Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BF57FE824
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 05:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344548AbjK3EG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 23:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344472AbjK3EGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 23:06:15 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F5B10D9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 20:06:21 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5cc589c0b90so5297587b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 20:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701317181; x=1701921981; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1zwuamlIV1jDg6rOlQdipklJQb9oUjXdjuftFM5av+U=;
        b=gpik/YcZQs3CpgTa0jfYPa+AGxuqwHvIUOP8WBzkQCkPg/6cCcaGT+KNAcSHTr+/Nq
         ibrEho5U2TOU1ytTLarpzjyjKla38BGAqKrrbBIFvgdjdEt2an64rBiHiLM6wDJwvnbK
         mPJrOlURVDdUSmGxOMOQccQcS1z8D8TH3LlBAE6qn4FkjYKrZRgzrvB3pkz3QRprjY0r
         Uj+azWQyiZWc2ODcgAOiTHKYnsO0j4OV0Hrfla6rWbsfM7IphlD16GoSNVqnxyCJoFN4
         Om9ogEecASouztJQIqhurSibsMtY3PHCy5cxsupxlolgiTFudVfF4wzBTJssOeFWGQXX
         fErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701317181; x=1701921981;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1zwuamlIV1jDg6rOlQdipklJQb9oUjXdjuftFM5av+U=;
        b=JPFFeDFRDEsne9njo6maFly11JumVm0uESNK1M46Nsj1b6SfAklAzbuZ43dspqNgpJ
         c9fymOtupL1y3vzMtzLvIFU6ZtDouF1u1Z94/xnSnzsqwpJnRhutukunsTc4kYLBb/Qu
         P1CY7M2d2IPkimQ4yWB4R6RWSDQ26iVlYw3hymaiGh391I1NfC2xYSgS0SLCPgXxo1tA
         +Npc3568C2AToA7aEhgy6TzXUeMdFaXrCM6bSbdtDwymCNfebr16SM9ZzQzXQHITbfr0
         P2gOz2q3B9+M9LLs2oTv4w96UPpl5rd3HTxirG0Sb+Z86tbpnuknxEQ6Hy5hEPj7sFUz
         GD0A==
X-Gm-Message-State: AOJu0YyUjXDKislbjqkj1DO31wbk/sOv3R60Lun0MKMU0avW0dN8ydH/
        5iThiWPxUATdcCnt0cDLZXkvWR+EaIrHMtDUyF+mJQ==
X-Google-Smtp-Source: AGHT+IH5VqWkIJEXkSlzehGjOyCBp+myDPhrn3B4acVuNRIw/JkoNdioljfuRcqvXowZACNims6bGNNgqho9TQqZ5ow=
X-Received: by 2002:a0d:ef47:0:b0:5a7:b481:4dd2 with SMTP id
 y68-20020a0def47000000b005a7b4814dd2mr21943989ywe.47.1701317180853; Wed, 29
 Nov 2023 20:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20231027-solid-fill-v7-0-780188bfa7b2@quicinc.com> <20231027-solid-fill-v7-7-780188bfa7b2@quicinc.com>
In-Reply-To: <20231027-solid-fill-v7-7-780188bfa7b2@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 30 Nov 2023 06:06:09 +0200
Message-ID: <CAA8EJppjVcP3YbBLG2vaZrRP2FAVfVM4WvLieLpV3z1VQ2exAA@mail.gmail.com>
Subject: Re: [PATCH RFC v7 07/10] drm/atomic: Loosen FB atomic checks
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        quic_abhinavk@quicinc.com, ppaalanen@gmail.com,
        contact@emersion.fr, laurent.pinchart@ideasonboard.com,
        sebastian.wick@redhat.com, ville.syrjala@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2023 at 01:33, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>
> Loosen the requirements for atomic and legacy commit so that, in cases
> where pixel_source != FB, the commit can still go through.
>
> This includes adding framebuffer NULL checks in other areas to account for
> FB being NULL when non-FB pixel sources are enabled.
>
> To disable a plane, the pixel_source must be NONE or the FB must be NULL
> if pixel_source == FB.
>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/drm_atomic.c        | 21 ++++++++++----------
>  drivers/gpu/drm/drm_atomic_helper.c | 39 +++++++++++++++++++++----------------
>  include/drm/drm_atomic_helper.h     |  4 ++--
>  include/drm/drm_plane.h             | 29 +++++++++++++++++++++++++++
>  4 files changed, 64 insertions(+), 29 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
