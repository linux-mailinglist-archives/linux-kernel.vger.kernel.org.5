Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4790977D991
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 07:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241800AbjHPE5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 00:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241813AbjHPE5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 00:57:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299A52690
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 21:57:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58cb845f2f2so2809717b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 21:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692161827; x=1692766627;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lmF5oy9desuzUwBbJQTmPeTiITiMll+wB/uHgXnLzDU=;
        b=qw7vTgpbCgxlCj6A4mQNY3xBj1vXeJxzZG9DhlqIJP5inl98axZXu4gyhx05OmS77l
         9OZJqfTvki2zWbENFG+hnTvVBYZvj3X2AwrAnmD3eBWzr4qEEeONrirqAdF6gABC6afn
         w9P2YPYKDGCie49DBcQ9kb1px4U3s/M2hZuc8evHOLJd5xiTIBlTc5V0AZwoZHnOAat9
         Lli24ZiFyr5JknzwrfjNfcVJswrb8Xthxg0/G6lCiyNL58pbq2MWDo2nqcRTNPf/8JRs
         JmkJvFexEdmWYXPmgij/ilwsVaZBf22uFm7o3LiLxuv1WVqCs4Eo47CbIfynXDtQIPYb
         Nlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692161827; x=1692766627;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lmF5oy9desuzUwBbJQTmPeTiITiMll+wB/uHgXnLzDU=;
        b=FvLzubL3cw/lvuPQ1h13Pn2lvfJ8UxzKfPWS7BwTykXfJa2RxifU1a77+9SXZ+Iu7s
         Mq0A0C2tWk6ia7BxKS60W19IK43uh8FrRD9YJi89xSEFTvY4nquAtogd3ay+QYdb9kwY
         IHPXD9V6VOVCmESmZmfBEu6npkU62lQ2G2N1T65v0wYjg3EMBIzr/Jr0B/ParPB2VHvk
         Y7PCICBpi1uVcciu0dNFO0CSULYZhPqTSZjCmBHLC7JrzLiJUEoq6j0bDQqDZ0oCK8vY
         f8uiXPlz3d8Sg+ihdet8aogb8EEE3Khh41q4/PAu2Mwm6eyeOKJW3XsGGR1/fgaFfN0o
         8GbA==
X-Gm-Message-State: AOJu0YwvbvE9KTS/owJH99fBMEqhqfVSiWx+DdKzQmyS74MbgHp+vkP2
        jy+ylt/lxyNTRcXrnf2fqozu2LaipaG0yaU=
X-Google-Smtp-Source: AGHT+IF91msezRjSMtY5wo8qq7i8mdUD1/jh18zkKE+M9MrYxQ3HHC1U3ga01pFm86AiGrM4CMCfRl5OVjJhG3Y=
X-Received: from pceballos.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:128c])
 (user=pceballos job=sendgmr) by 2002:a81:af15:0:b0:58c:b5a4:8e1c with SMTP id
 n21-20020a81af15000000b0058cb5a48e1cmr6443ywh.3.1692161827421; Tue, 15 Aug
 2023 21:57:07 -0700 (PDT)
Date:   Wed, 16 Aug 2023 04:56:54 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816045654.833973-1-pceballos@google.com>
Subject: [PATCH v3] drm/i915/display/lspcon: Increase LSPCON mode settle timeout
From:   Pablo Ceballos <pceballos@google.com>
To:     Ankit K Nautiyal <ankit.k.nautiyal@intel.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=" 
        <ville.syrjala@linux.intel.com>,
        Pablo Ceballos <pceballos@google.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to eliminate all cases of "*ERROR* LSPCON mode hasn't settled",
followed by link training errors. Intel engineers recommended increasing
this timeout and that does resolve the issue.

On some CometLake-based device designs the Parade PS175 takes more than
400ms to settle in PCON mode. 100 reboot trials on one device resulted
in a median settle time of 440ms and a maximum of 444ms. Even after
increasing the timeout to 500ms, 2% of devices still had this error. So
this increases the timeout to 800ms.

Signed-off-by: Pablo Ceballos <pceballos@google.com>
---

V2: Added more details in the commit message
V3: Only apply the increased timeout if the vendor is Parade

drivers/gpu/drm/i915/display/intel_lspcon.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_lspcon.c b/drivers/gpu/drm/i915/display/intel_lspcon.c
index bb3b5355a0d9..b07eab84cc63 100644
--- a/drivers/gpu/drm/i915/display/intel_lspcon.c
+++ b/drivers/gpu/drm/i915/display/intel_lspcon.c
@@ -153,6 +153,24 @@ static enum drm_lspcon_mode lspcon_get_current_mode(struct intel_lspcon *lspcon)
 	return current_mode;
 }
 
+static u32 lspcon_get_mode_settle_timeout(struct intel_lspcon *lspcon)
+{
+	u32 timeout_ms = 400;
+
+	/*
+	 * On some CometLake-based device designs the Parade PS175 takes more
+	 * than 400ms to settle in PCON mode. 100 reboot trials on one device
+	 * resulted in a median settle time of 440ms and a maximum of 444ms.
+	 * Even after increasing the timeout to 500ms, 2% of devices still had
+	 * this error. So this sets the timeout to 800ms.
+	 */
+	if (lspcon->vendor == LSPCON_VENDOR_PARADE)
+		timeout_ms = 800;
+
+	return timeout_ms;
+}
+
+
 static enum drm_lspcon_mode lspcon_wait_mode(struct intel_lspcon *lspcon,
 					     enum drm_lspcon_mode mode)
 {
@@ -167,7 +185,8 @@ static enum drm_lspcon_mode lspcon_wait_mode(struct intel_lspcon *lspcon,
 	drm_dbg_kms(&i915->drm, "Waiting for LSPCON mode %s to settle\n",
 		    lspcon_mode_name(mode));
 
-	wait_for((current_mode = lspcon_get_current_mode(lspcon)) == mode, 400);
+	wait_for((current_mode = lspcon_get_current_mode(lspcon)) == mode,
+		 lspcon_get_mode_settle_timeout(lspcon));
 	if (current_mode != mode)
 		drm_err(&i915->drm, "LSPCON mode hasn't settled\n");
 
-- 
2.39.2

