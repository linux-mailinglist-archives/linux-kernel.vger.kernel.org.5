Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3882D7BCEC5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 16:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344853AbjJHOBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 10:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344844AbjJHOBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 10:01:33 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A77B9
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 07:01:30 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso43822231fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 07:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696773689; x=1697378489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFEz00dZt8b8WAE9A9YPgyljR1B8wQKrMenQPX4nHKw=;
        b=tsUHKHhjXaLYsoyeDw2UZZfuXp9P360Rdq8ay9j82wIfglNdJXCcITrAt2mhaZk3tC
         6qI20eeUNxmFtEURTqAXnPr9cot7lo90dgdjv4HBHik8WcMqysfv0mlI5JAEd4PJHmCz
         7use8E6hXXKvTL1hBYEKHlAWpinYGdZ5YQseJxUv1H1lVr7Spl+8hw3vg7JwYd/oCsEB
         Wx9/YSPfAVKw8Gbobz1lvSkjL7jL/U5Ic0yBagnZ8EazSox5f26Refm3ghOJDVd6JeeM
         7mgatcBoTB46VudTH9rcp8Q89y2V/NsRoIq8S3RH7wRkxyy4n8IFGOdaLT8LUbXKvgQn
         DYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696773689; x=1697378489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFEz00dZt8b8WAE9A9YPgyljR1B8wQKrMenQPX4nHKw=;
        b=FuJqiYXJIjis2JxQKpTUKRLf8lSXjMNOoiPNBm6DPRG8GqDfc5MhTCjlIxSrltJdif
         yoZKmOe68rrLmpDHZbo7lNnTvCAAZ2l0yg9KaLLyKmahE6qoKvGk2lUlaHsMEuDnQO5N
         IttP/rFFMd38p0ab2SwFZYokXF7g6pBgkLqWu7JY8HJNbNr0hTamgw+WpTjYLyq5hAJy
         Nz8pHhpzTmAQqnyZgth/oNKVrK1OSSu/PvI2BP4p1bdk8NaBV1LLAVLFV+UAGlrDELqx
         7Hvrt645XsBhN9BXCevtPhZCQ17+Y/wFHz9zkgTZYRlHWiL+bkMufow1Cg7zwz4DRGzT
         A+mg==
X-Gm-Message-State: AOJu0YxIXaMxdhST6LzCuI9ZTIAQvEsNtMoBQorOvkN1/xo8n1VMXECG
        JNse9oxYbykMp/oGLEg43npGiw==
X-Google-Smtp-Source: AGHT+IFOU5uXWmhXrIYbhgEpr4JZ8+yZty98yxpFi9UjGcKnTHEbTZyEkAOOOPx1Erbruxp2wwdBBQ==
X-Received: by 2002:a05:6512:68a:b0:503:26bc:b08f with SMTP id t10-20020a056512068a00b0050326bcb08fmr13838821lfe.24.1696773688970;
        Sun, 08 Oct 2023 07:01:28 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id q14-20020ac24a6e000000b00504211d2a73sm1080455lfp.230.2023.10.08.07.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 07:01:28 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: Re: [PATCH 0/7] drm/msm/dp: Simplify DPCD related code with helpers
Date:   Sun,  8 Oct 2023 17:01:20 +0300
Message-Id: <169677306906.2570646.11717295539692431609.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829184735.2841739-1-swboyd@chromium.org>
References: <20230829184735.2841739-1-swboyd@chromium.org>
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


On Tue, 29 Aug 2023 11:47:25 -0700, Stephen Boyd wrote:
> This driver open-codes a few of the DPCD register reads when it can be
> simplified by using the helpers instead. This series reworks the MSM DP
> driver to use the DPCD helpers and removes some dead code along the way.
> There's the potential for even more code reduction around the test
> registers, but I haven't tried to do that yet.
> 
> Stephen Boyd (7):
>   drm/msm/dp: Replace open-coded drm_dp_read_dpcd_caps()
>   drm/msm/dp: Use drm_dp_read_sink_count() helper
>   drm/msm/dp: Remove dead code related to downstream cap info
>   drm/msm/dp: Remove aux_cfg_update_done and related code
>   drm/msm/dp: Simplify with drm_dp_{max_link_rate,max_lane_count}()
>   drm/msm/dp: Inline dp_link_parse_sink_count()
>   drm/msm/dp: Remove dp_display_is_ds_bridge()
> 
> [...]

Applied, thanks!

[1/7] drm/msm/dp: Replace open-coded drm_dp_read_dpcd_caps()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/f906b95755f7
[2/7] drm/msm/dp: Use drm_dp_read_sink_count() helper
      https://gitlab.freedesktop.org/lumag/msm/-/commit/284a245d8bdc
[3/7] drm/msm/dp: Remove dead code related to downstream cap info
      https://gitlab.freedesktop.org/lumag/msm/-/commit/8bddc2d12e9c
[4/7] drm/msm/dp: Remove aux_cfg_update_done and related code
      https://gitlab.freedesktop.org/lumag/msm/-/commit/62ebb19fb32d
[5/7] drm/msm/dp: Simplify with drm_dp_{max_link_rate,max_lane_count}()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/a9905b469931
[6/7] drm/msm/dp: Inline dp_link_parse_sink_count()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/d89ce4cdb7a6
[7/7] drm/msm/dp: Remove dp_display_is_ds_bridge()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/b41c5ca70684

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
