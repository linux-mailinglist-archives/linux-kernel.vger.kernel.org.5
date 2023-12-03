Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA1E8022BA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjLCL0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjLCL03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:26:29 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2715AB6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:26:35 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c9f85eff28so8055061fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 03:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701602793; x=1702207593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmhXK4vL3E4nWjMPFEArxq3v2irEKwOONy77m2lg+qc=;
        b=oZgW4vzaIJ0QYKVsk1WfWjTsQL9R8/q1vUBt9nxk1ttQgC4b0632m5wQDiydbv5IZj
         Fr9J7DB5H7k84wr/F6qwof9hexO2hjMZiBY228kx58uHPgBxbBYGCS89yQ6gvBst3MWm
         L8lnVsm68+K7GbLIpKQEZkEi6GiSIEI3Tk8n6Q9p47KuorQguX2d+hzHMFcDyS++pNJZ
         Cm+oZHtmjUyTJ6GDrLk+fCe+A2kNB0s86DHO6ZRohsWJskkyk9xjLMAtBBRjlBXzMm7E
         oxSW6KuMdA8n6xlqe9KtPk1R/iFpBlbbq8qu0oYKoH7QL6/U88STCcMr5pgb1R0rnoHp
         rK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701602793; x=1702207593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmhXK4vL3E4nWjMPFEArxq3v2irEKwOONy77m2lg+qc=;
        b=LjFVhAbwzSY2G6RrdexDg64Fw9FuNY/lX17fpoYgeROzpA0azfx5gLV3tNssxxOmwV
         uJQHjjOag3XOYwgAnHH/f/WzeQCv7rjKmHYRslWb5Wa4TimCaM/XvDiLHPpPBFDPk+dH
         Gxv8JXYE1NngrU5zjSxydoMFKRGkjN8tdTIZHj3xlpWu4uEkTdhEf7+OKMn9GUOI4yQB
         gXJoC2WhQnAJkSM9xIFwFuSzl7cts2q4WqgjV3Wm9eNNN6WDDWgECDJnfLiHv/E8rTpO
         XEbVhEkH2gFiOq6IzbhDojo99z3k8cJyWncHH7QJTndtvK5nnnSHJaa43nPusvrxwST/
         dW2Q==
X-Gm-Message-State: AOJu0YyVoLtEb1cwdUbsEtqSariPVlslrBGqI6SYEBtVnsRLpMOXhxtJ
        aNJRq75eeojfMjAx1CVn/hm1kw==
X-Google-Smtp-Source: AGHT+IHlLYyyC21TH0FtIj5NM4vWDxanSGH9w8egAW9vnCLxMxgkRyfvr22YsKy9g8OxxxGBM7H5hA==
X-Received: by 2002:ac2:4244:0:b0:50b:e4a7:93c with SMTP id m4-20020ac24244000000b0050be4a7093cmr913587lfl.11.1701602793049;
        Sun, 03 Dec 2023 03:26:33 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id b9-20020ac25629000000b0050bf01760a1sm241224lff.295.2023.12.03.03.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 03:26:32 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/a6xx: add QMP dependency
Date:   Sun,  3 Dec 2023 14:26:17 +0300
Message-Id: <170160265547.1305159.16031924969779572625.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016200415.791090-1-arnd@kernel.org>
References: <20231016200415.791090-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Oct 2023 22:04:03 +0200, Arnd Bergmann wrote:
> When QMP is in a loadable module, the A6xx GPU driver fails to link
> as built-in:
> 
> x86_64-linux-ld: drivers/gpu/drm/msm/adreno/a6xx_gmu.o: in function `a6xx_gmu_resume':
> a6xx_gmu.c:(.text+0xd62): undefined reference to `qmp_send'
> 
> Add the usual dependency that still allows compiling without QMP but
> otherwise avoids the broken combination of options.
> 
> [...]

Applied, thanks!

[1/1] drm/msm/a6xx: add QMP dependency
      https://gitlab.freedesktop.org/lumag/msm/-/commit/96ab215b2d5e

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
