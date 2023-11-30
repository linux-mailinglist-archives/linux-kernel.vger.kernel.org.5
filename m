Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7143F7FFB1E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376346AbjK3TVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376354AbjK3TVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:21:17 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B31910EF;
        Thu, 30 Nov 2023 11:21:23 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cdcef787ffso1323756b3a.0;
        Thu, 30 Nov 2023 11:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701372083; x=1701976883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FNcHli21vir5baYj9ku8MMNBlCqv0AKIpWf2Lyqz8B0=;
        b=MZVdptyqLtkcvQKLlmAGPE0/pLxv5Gnje94wA3qFn7urap5mGjj280hhluwjO+zGJF
         BPLteed1crWW7syB1ff26BJP/8fEFVIEwWmQF6ll3VOdmUqFIw9DPs26GLxq3IWHmMlZ
         9BILz4kSJpt0zrhgFuK7Oyz1SdZbKUqZP7jxqrUUyyNkrdA6IYxYEDQRVibkqe59ta+O
         N8X557gQTSRpBQIOwRR/PWG0qozzgT39ED2+vK1ASQeHixqmAvhzxIAxMWwyVNCU5Ejx
         NAUsYjH+/2cyR1jGApBFNlpWh9O6M9krQar14UMmSMJ0gONHkrsK/dw28HaxQyLdrj8y
         2niA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701372083; x=1701976883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNcHli21vir5baYj9ku8MMNBlCqv0AKIpWf2Lyqz8B0=;
        b=W57wZRDzFyYJGSS6cXVzEBy7mWWhsrPXzBav4d/2dZaPAut1Sf539H46VVZlmm6Rdw
         KxfRt4+axuosUiPEQwdyqxZzq4uq4U/49jMhnBTIlDx1yJ/2Ujk3AzGL17TSB2N9uudk
         4+k8mocLeSQFMN0eZC8cP3XZGZfLleuIMkox38SUcobOIPjVNFVVEAqwUxo51tEN3A6V
         OfTH3THFF2vy8ubrzRzONbcBRjJ9GbxTbCgMbBEO0N2Tskw6Nqql79Hn9BknJ00Ag5Oe
         9gcLFP909OGUWqEejg4R3oQ1cYsv6r12AVVJWhaBUUo5kBs/qthsFnOEAky+NT/6wV5r
         GPiw==
X-Gm-Message-State: AOJu0YwYmirVvTW27+7sM7ZoAyFRcGEEoth8xoJnzhYskr6LuFt3FA2/
        HWE/oavRppwUz6PRlW4ToHA=
X-Google-Smtp-Source: AGHT+IE2f9qp1SjvrsRN4lxzgsw0h/B5/kyMl8ci2BReCokFmvVJMt2wKJZqfjD/VXwiZhodFeQ39Q==
X-Received: by 2002:a05:6a00:21c9:b0:6cb:8ec7:ad01 with SMTP id t9-20020a056a0021c900b006cb8ec7ad01mr27603366pfj.10.1701372082809;
        Thu, 30 Nov 2023 11:21:22 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id y63-20020a62ce42000000b006c3069547bfsm1628882pfg.79.2023.11.30.11.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:21:22 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Danylo Piliaiev <dpiliaiev@igalia.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/dpu: Correct UBWC settings for sc8280xp
Date:   Thu, 30 Nov 2023 11:21:18 -0800
Message-ID: <20231130192119.32538-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

The UBWC settings need to match between the display and GPU.  When we
updated the GPU settings, we forgot to make the corresponding update on
the display side.

Reported-by: Steev Klimaszewski <steev@kali.org>
Fixes: 07e6de738aa6 ("drm/msm/a690: Fix reg values for a690")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 6865db1e3ce8..29bb38f0bb2c 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -545,7 +545,7 @@ static const struct msm_mdss_data sc8280xp_data = {
 	.ubwc_dec_version = UBWC_4_0,
 	.ubwc_swizzle = 6,
 	.ubwc_static = 1,
-	.highest_bank_bit = 2,
+	.highest_bank_bit = 3,
 	.macrotile_mode = 1,
 };
 
-- 
2.42.0

