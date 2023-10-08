Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B254C7BCEC1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 16:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344855AbjJHOBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 10:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344834AbjJHOBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 10:01:32 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D288ADB
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 07:01:29 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so46472561fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 07:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696773688; x=1697378488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFG+HbWkCL5q3sRytHz2EUARFUhHTNpTPTS/2TGCkYs=;
        b=ObzbFgTMYVwo20haAZn7lVGopTzVwLFDJFv1vJPRR5JMPA8MQIBKruM4uN1lnA+MnR
         Ekw90axVfeoLgnPiMCnUTJlTr3U1GeodkYdAS5+p61YXeUpNIxFhOi4NK9l4Gajnropk
         oum/4MtJNhlr4pjTudnxjjeQ+UhWR/nrqACzb2ZRI2FD2EpNDfxozLQJ54Qq8ojMnf19
         S+2GyT0qvPGx4wYsrcU7oigcBrfstFWU6zpuwRA9FNYuRCxoysVcB2H0BOrVo/87b2VP
         t8lhCP970G6oy7su51Gc1F993zxeYamZkYOsdgiTTpd/dEVMT2wbhIHkkQmneRE4TL4x
         +z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696773688; x=1697378488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFG+HbWkCL5q3sRytHz2EUARFUhHTNpTPTS/2TGCkYs=;
        b=Iy3Vc/mHNR+yKnsCQCcu8wMmzSFsduR2pQaFZXZz6ZZHbY+r2Z6dOpeWbm1dhWC8+J
         WxiThqPkxfucjTw8x32ViCt4djgTJPLoRDB79emCZjuz+1/BB/V2xU1vTtE3ZGlQe00X
         tdAxlabZ9ciBucMBN/gS5UzQme62XaA6H3vK1IrkCePRR5akIS9379Qkc/0hJ4pqr35a
         GscQ/pP9g6ovkKrWZKW9NQ39xC9kZjaIahVtAJodA/V+AyAI+WLpa8V/lESLScCYTT/q
         37Wai7J+j9ke0GLyQdu3mVSb74Fswx2A95TIVN0Pme94IUfdy0fyj6de25nVoguJkebP
         5rBA==
X-Gm-Message-State: AOJu0YzkZpmEE8Nw/HUD6nCa+eA3upw2atIw5qr9DI6dUo3SMZMApIMv
        /74okAi/Aq4OaelRV2qtuUVpiA==
X-Google-Smtp-Source: AGHT+IF9SR2eKmWzelixific7kPQBmMahRChh7MHMDUtBo/o+iJKla32qvo/C/wtuhmKyiBSevln/w==
X-Received: by 2002:a05:6512:31d0:b0:4ff:a04c:8a5b with SMTP id j16-20020a05651231d000b004ffa04c8a5bmr13427692lfe.47.1696773688103;
        Sun, 08 Oct 2023 07:01:28 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id q14-20020ac24a6e000000b00504211d2a73sm1080455lfp.230.2023.10.08.07.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 07:01:27 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH 0/2] drm/msm/dp: More DPCD cleanups
Date:   Sun,  8 Oct 2023 17:01:19 +0300
Message-Id: <169677306905.2570646.16231496941138431299.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230906181226.2198441-1-swboyd@chromium.org>
References: <20230906181226.2198441-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 06 Sep 2023 11:12:24 -0700, Stephen Boyd wrote:
> This is a follow-on to this series[1]. I can resend the whole pile if
> desired.
> 
> [1] https://lore.kernel.org/r/20230829184735.2841739-1-swboyd@chromium.org
> 
> Stephen Boyd (2):
>   drm/msm/dp: Inline dp_display_is_sink_count_zero()
>   drm/msm/dp: Remove error message when downstream port not connected
> 
> [...]

Applied, thanks!

[1/2] drm/msm/dp: Inline dp_display_is_sink_count_zero()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/fb48250ca919
[2/2] drm/msm/dp: Remove error message when downstream port not connected
      https://gitlab.freedesktop.org/lumag/msm/-/commit/e117fd68f973

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
