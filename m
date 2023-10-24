Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087C67D596C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344045AbjJXRIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344033AbjJXRIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:08:18 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7353122;
        Tue, 24 Oct 2023 10:08:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ca74e77aecso41802515ad.1;
        Tue, 24 Oct 2023 10:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698167295; x=1698772095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1FF1gJxqcl+lR8fc3NGAGh6ZriqzXwUPpSOpQVAdLg=;
        b=YuxwB8AvVZeETtAGWTPIy8+BbN/dYm06tfgsRXaNJa+iS2X32SG8KXFXNOAFLzjm3+
         9Uhq7X4Dfz4uT2n3f3Icr7UJFZXUbVbYA26RhXy+OvaJtqaxvx5Sj+BraTs2QeVNR01Q
         yw3kBH6bWgndouKY2yYIb0D92y+P4jBOpPecv4qeIdLIW3E9YdxXNBY1XSSIP1rF3srz
         +fcJt6JRiLsJ6Krd9OphB8rXlm/dzitp5845X6GKQ33hojVHuMCbCCT91bXsKA5szhFj
         lloiYW6Rn8ZMWm+AG4fIPL7re0c7i9m+TjG5KeuqwoRG6AYTtlEGKTXE7Z//elkOhHIf
         m/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698167295; x=1698772095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1FF1gJxqcl+lR8fc3NGAGh6ZriqzXwUPpSOpQVAdLg=;
        b=RBRuhitQnpyPZv41dgSPofA4mV1da18w7aMhuKTu+8HxcrMOMNa/giHZB5ohRabX1i
         /JAGTtfsfNOY17MtqTUquv1HLVmQvKAsWleGEnUplm2WCkiXOcTCg1SamM/5Ot3xK9pM
         1pPtBfSw90tf4N3OI+GVRQuBm1RHbSGLRd8/LCqRd8zVA3eC/mUYMoeuw3Q6fnOdmVs6
         VkntxVtvwFwVVYC5tU5J2gMMJYB6/OC4kuQYu45btD2JwiQd75z3QOL2ZML5JM3sUE24
         c2n07P1GKsz+7bbCYiKk4PQxg7N2dy5GJK3ipvVIioRJce5G2wlYHFLeVi/TK4CehGwO
         u52g==
X-Gm-Message-State: AOJu0YwaVcpuLdmeqZpy4Xl7uoqzvCrJYpEWCO5Xg1uSTr8B6ydoFUI2
        f1fJpqHl0663pr7pddtRDkYUudkH3Tk=
X-Google-Smtp-Source: AGHT+IFrYw8dsyIm3wa76gPXIlJD6mCKZud3nLXbi2Pkdu07NBSpFOpwpLw8r87FtVPVDzGmLLxbPg==
X-Received: by 2002:a17:90a:db82:b0:27d:2ce9:d6d5 with SMTP id h2-20020a17090adb8200b0027d2ce9d6d5mr16990053pjv.12.1698167295057;
        Tue, 24 Oct 2023 10:08:15 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id ha8-20020a17090af3c800b0026f919ff9a1sm9041271pjb.10.2023.10.24.10.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 10:08:14 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/msm/gem: Demote allocations to __GFP_NOWARN
Date:   Tue, 24 Oct 2023 10:08:05 -0700
Message-ID: <20231024170806.194563-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024170806.194563-1-robdclark@gmail.com>
References: <20231024170806.194563-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

For allocations with userspace controlled size, we should not warn on
allocation failure.  Fixes KASAN splat:

   WARNING: CPU: 6 PID: 29557 at mm/page_alloc.c:5398 __alloc_pages+0x160c/0x2204
   Modules linked in: bridge stp llc hci_vhci tun veth xt_cgroup uinput xt_MASQUERADE rfcomm ip6table_nat fuse 8021q r8153_ecm cdc_ether usbnet r8152 mii venus_enc venus_dec uvcvideo algif_hash algif_skcipher af_alg qcom_spmi_adc_tm5 qcom_spmi_adc5 qcom_vadc_common qcom_spmi_temp_alarm cros_ec_typec typec hci_uart btqca qcom_stats snd_soc_sc7180 venus_core ath10k_snoc ath10k_core ath coresight_tmc coresight_replicator coresight_etm4x coresight_funnel snd_soc_lpass_sc7180 mac80211 coresight bluetooth ecdh_generic ecc cfg80211 cros_ec_sensorhub lzo_rle lzo_compress zram joydev
   CPU: 6 PID: 29557 Comm: syz-executor Not tainted 5.15.110-lockdep-19320-g89d010b0a9df #1 45bdd400697a78353f2927c116615abba810e5dd
   Hardware name: Google Kingoftown (DT)
   pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
   pc : __alloc_pages+0x160c/0x2204
   lr : __alloc_pages+0x58/0x2204
   sp : ffffffc0214176c0
   x29: ffffffc0214178a0 x28: ffffff801f7b4000 x27: 0000000000000000
   x26: ffffff808a4fa000 x25: 1ffffff011290781 x24: ffffff808a59c000
   x23: 0000000000000010 x22: ffffffc0080e6980 x21: 0000000000000010
   x20: 0000000000000000 x19: 00000000080001f8 x18: 0000000000000000
   x17: 0000000000000000 x16: 0000000000000000 x15: 0000000020000500
   x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000001
   x11: 0000000000000000 x10: 1ffffff804282f06 x9 : 0000000000000000
   x8 : ffffffc021417848 x7 : 0000000000000000 x6 : ffffffc0082ac788
   x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000010
   x2 : 0000000000000008 x1 : 0000000000000000 x0 : ffffffc021417830
   Call trace:
   __alloc_pages+0x160c/0x2204
   kmalloc_order+0x50/0xf4
   kmalloc_order_trace+0x38/0x18c
   __kmalloc+0x300/0x45c
   msm_ioctl_gem_submit+0x284/0x5988
   drm_ioctl_kernel+0x270/0x418
   drm_ioctl+0x5e0/0xbf8
   __arm64_sys_ioctl+0x154/0x1d0
   invoke_syscall+0x98/0x278
   el0_svc_common+0x214/0x274
   do_el0_svc+0x9c/0x19c
   el0_svc+0x5c/0xc0
   el0t_64_sync_handler+0x78/0x108
   el0t_64_sync+0x1a4/0x1a8

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 9f16af761bf0..6d8ec1337e8b 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -43,7 +43,7 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
 	if (sz > SIZE_MAX)
 		return ERR_PTR(-ENOMEM);
 
-	submit = kzalloc(sz, GFP_KERNEL);
+	submit = kzalloc(sz, GFP_KERNEL | __GFP_NOWARN);
 	if (!submit)
 		return ERR_PTR(-ENOMEM);
 
@@ -234,7 +234,7 @@ static int submit_lookup_cmds(struct msm_gem_submit *submit,
 			ret = -ENOMEM;
 			goto out;
 		}
-		submit->cmd[i].relocs = kmalloc(sz, GFP_KERNEL);
+		submit->cmd[i].relocs = kmalloc(sz, GFP_KERNEL | __GFP_NOWARN);
 		if (!submit->cmd[i].relocs) {
 			ret = -ENOMEM;
 			goto out;
-- 
2.41.0

