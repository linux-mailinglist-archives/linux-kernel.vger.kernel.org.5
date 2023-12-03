Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362058022E6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjLCL06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbjLCL0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:26:39 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3267710E
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:26:45 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9f572c4c5so10412961fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 03:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701602803; x=1702207603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYIyCDkC/kqd/JcF0O3oBfyGO8lhYZEcVarBXABCrBw=;
        b=z3GgnW1zBXtX8GUsY3VMT/iYFhJgt5Evr++/HawDhuw647Obg68L8xyYvUqt4VxfEG
         l4ZgcWU3jej5yo4836ZuH9m1U3r7amPJ7uXrK0IhnA7Qx5Oy5uIyjuJ58KdhdgEOFkAh
         XaMRs6sT75GmhoRuCuM8bLVKCcsVBfsxuhOVgT+1inxCZnva5Wywi6+3QD+iWpHDTo/A
         wl2iGzwAwL+0Zze9hs1l8BiKe10eEhR/qMLS5AfdvSnE47fqUQeC9jtondaY6/VhS9tv
         e4Tt6IAzmbn/Lvgz/NXkX1SNvhEPylVvlD6ZELvDGb+xu91Od+fmTdE/0xP7carkSU0K
         ZNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701602803; x=1702207603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYIyCDkC/kqd/JcF0O3oBfyGO8lhYZEcVarBXABCrBw=;
        b=s4Ng6Qa0FnjrdDNMuvpOGfALIltPa1Ny37VEpvvYZnKehgpKigPVZxDB3CMz9BaTkk
         e2zRW95z0wnNfpZFC+RA7vsqv+ASrQQlg2fwS8KRpcTRbmT3K9sEbGrUJoOUYSn2xcuo
         gvo0IP5QZEO508KSShHiDc0F6HAoZbaUu0cruKnP4cN1QFj+1lCYVOeZrR2RJa1tk9/a
         1AkN7I2ZVnT4PQPuEnLP78DUF9g2Jt8lQn/IoCAcUcblSd0MOkRJBtq9oye+c/Tl5Flf
         yqe3TR52siQqCwbdAv7u2WTI0G5g1n6/AHkAc7ScBTfGduT3sdZwPto/kZw6lfS7b3ve
         fpqw==
X-Gm-Message-State: AOJu0YwM+/pvpDiOxZl7PWtzvHE/Kk46R5N+9xWKKzhjlnkMYZDMo0mn
        kRcbVSq9S44jOf9i2MEmLgG7fw==
X-Google-Smtp-Source: AGHT+IGkd+42bCTta1PfLIbw2fWVI0/Gsi2Zxy2u8tGHbjUtLnbjt5NNhDwljHVNXb84baNOjl2LcQ==
X-Received: by 2002:a05:6512:23a1:b0:50b:d764:76ef with SMTP id c33-20020a05651223a100b0050bd76476efmr3048680lfv.126.1701602803553;
        Sun, 03 Dec 2023 03:26:43 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id b9-20020ac25629000000b0050bf01760a1sm241224lff.295.2023.12.03.03.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 03:26:42 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Add missing safe_lut_tbl in sc8180x catalog
Date:   Sun,  3 Dec 2023 14:26:28 +0300
Message-Id: <170160265538.1305159.8059575871895403270.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130-sc8180x-dpu-safe-lut-v1-1-a8a6bbac36b8@quicinc.com>
References: <20231130-sc8180x-dpu-safe-lut-v1-1-a8a6bbac36b8@quicinc.com>
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


On Thu, 30 Nov 2023 16:35:01 -0800, Bjorn Andersson wrote:
> Similar to SC8280XP, the misconfigured SAFE logic causes rather
> significant delays in __arm_smmu_tlb_sync(), resulting in poor
> performance for things such as USB.
> 
> Introduce appropriate SAFE values for SC8180X to correct this.
> 
> 
> [...]

Applied, thanks!

[1/1] drm/msm/dpu: Add missing safe_lut_tbl in sc8180x catalog
      https://gitlab.freedesktop.org/lumag/msm/-/commit/7cc2621f16b6

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
