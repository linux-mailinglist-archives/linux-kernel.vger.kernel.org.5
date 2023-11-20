Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871857F144A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjKTNWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjKTNVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:21:53 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3001D6A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 05:21:37 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40790b0a224so14376945e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 05:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700486496; x=1701091296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFfJP54/xc7BHA8KKJGYnGca16T3qiUmmV3jKwTKBQY=;
        b=NdESP99IGCUYwnMudb8ziVws9edff90f4SR+4gN7YxJdAJvxG12sC5thHKsLDiN8mN
         8Qi0sAnHt7ev3dhLRTYxBy88W1SldgfgfXMFsWB4a+vKWGB28mmaVUTfrKcTd43s4qE5
         AVnch1gPxI3DfFHDTnqrwIKT4aJqFX5sjmTLCxqVbH+apQmV3j739B1Wjb8fqPN9RDVT
         J82DdVBB/RXXp/Df/OR4/MDSh27c2HF9dgljTZoek2Nca7/SX69XoS21ZjUbJshQJRCc
         dr8pyCskMG/wNVVrKnRrPbT0XRpDPPdQqLv8ZOoOaigfw0IEVIAcTKiE2j8sEfvLOWOa
         K91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700486496; x=1701091296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFfJP54/xc7BHA8KKJGYnGca16T3qiUmmV3jKwTKBQY=;
        b=VtfZyU8PxfJqonClCI8xUdiE5QGCpsoscDv+iGeBVDVC/5C/aK9X/V92pupR6TEEZZ
         8wUPB37vGvlvWCTQnxxCBx2NPXDHheVuy7EPNoOhVxavcqJk5l8gQz/c9hNv4dtHMUEJ
         +IIReSfrYjvAOfFgj3AkNW3Y4/JvCVzYbrhP1dzAHy+tWHGc5ODJ3wbTt294zK0UuzYm
         EOrGUeDuksEPtIc6cqS0i0784/cj9lXzzFzOKDUrsbunHW0iGDmlJayxgYtkuj0v9WYK
         fN8+woN9X7JLakPcA3aCOlPLhKyihsDdECoV+EY7mfKOeBQ5OFKdKosVOPTTzJzwRSDI
         EBKQ==
X-Gm-Message-State: AOJu0YwmjO7d0O2440uL/mAFa9XzVd6v+z1VJLU2A6xnoeb0k/84QwZP
        TriKNAXAYM3Br6isAIAi70Q8Br/Wmy/4oKf4reU=
X-Google-Smtp-Source: AGHT+IEJNSSeruxg02NwqJzhB0OwZASyBXitkOUoyOM4mvHRqWQBf9cqK10RmvbSC3vq1f+NKZVwyA==
X-Received: by 2002:a05:600c:474b:b0:408:575e:f24f with SMTP id w11-20020a05600c474b00b00408575ef24fmr5640653wmo.28.1700486496200;
        Mon, 20 Nov 2023 05:21:36 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c590:a7ce:883:eba3])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c0b5200b004065e235417sm17329192wmr.21.2023.11.20.05.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:21:35 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v5 12/12] arm64: defconfig: enable SHM Bridge support for the TZ memory allocator
Date:   Mon, 20 Nov 2023 14:21:18 +0100
Message-Id: <20231120132118.30473-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231120132118.30473-1-brgl@bgdev.pl>
References: <20231120132118.30473-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable SHM Bridge support in the Qualcomm TrustZone allocator by default
as even on architectures that don't support it, we automatically fall
back to the default behavior.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b60aa1f89343..5380e78087a7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -255,6 +255,7 @@ CONFIG_INTEL_STRATIX10_RSU=m
 CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_IMX_SCU=y
 CONFIG_IMX_SCU_PD=y
+CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y
 CONFIG_GNSS=m
 CONFIG_GNSS_MTK_SERIAL=m
 CONFIG_MTD=y
-- 
2.40.1

