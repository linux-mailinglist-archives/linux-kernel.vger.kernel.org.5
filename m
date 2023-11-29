Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEA17FD96F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjK2OcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjK2OcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:32:11 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D54DD;
        Wed, 29 Nov 2023 06:32:17 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-6cddc148285so301638b3a.2;
        Wed, 29 Nov 2023 06:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701268337; x=1701873137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YZXuNEt8EzwdILEA0pIWBrLgHEq+yqwXRZX9rymE92s=;
        b=axg1o6gJdO5RSbip9ZzzmZvO/RtJyOidtFjsJHFn9dqyeQQusrRIwzfv949sG7reim
         Asos7FLW2R23kKYM8KX3pzSqLYIAPs6HOt/tn23Q1u6mUOeDvIeWeLrjhforGcfbWoet
         2TUoS0kcpIjUb41bwJrklhyDer/uermRLClavQ4Q6zBdEg7U3EB1uFkkmV+Ht9D+QQTE
         u7nQ0VOSmTQfujZk+9t2q+lQqnHy0aFtup/KrAHRtkk785LEc+ARHPBejTCb2YImnYo3
         l2AR0g22YV+GTk2HCb5gHrOCytIqDwSVjR4x7HhLyAbxr3fTGzvnssHAa4FEIGiuTnVq
         lAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701268337; x=1701873137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZXuNEt8EzwdILEA0pIWBrLgHEq+yqwXRZX9rymE92s=;
        b=Ykm0p0tTjT83OaRjspwWckswFkF5v3FGCrgo/V54cEdu3KnfAoZV6pJqlW3eOSq7Dh
         LALpoiWgmgeibeZgADuAB4RkI9uofqOVByaZW/yoB+0iPZV2Fb1ciuuYvLqBrZUgGuGt
         Ar5oKOEXBgs7E/7Yyt1vvmNsRRbGlSlbMRgc8DPnO932637SRDb8aLIMfljDeRzhP4dj
         jukmtWTZ2IZdrp5a0FUfNgKOpENwvb7aI+tkaSBFJpip1eywkHWgcOu99yl/zBLwptJ1
         6FuCT23765cTM/30mDYprdy+qY/eZohq3pmcVWXz9kZ9+i2a+3s5M3cCPAVbDGnzMblu
         gwtQ==
X-Gm-Message-State: AOJu0YxnGq5jXiawCEqn74btnCwfDnD/xgCxH10tVQOOJJmruQt3qj7z
        RgjOks3j/TtXDULDv3Be9G+c9TYH4nrXM/3l/sE=
X-Google-Smtp-Source: AGHT+IFnlQjUW0F3T4SUaA+4PC0v/R7FdZScvVhDaiJUWb6qnszmnKFevlpeCWB80mzM2uUg3aciXg==
X-Received: by 2002:a05:6a00:1512:b0:6cb:e3c5:7cb3 with SMTP id q18-20020a056a00151200b006cbe3c57cb3mr26633617pfu.16.1701268337411;
        Wed, 29 Nov 2023 06:32:17 -0800 (PST)
Received: from localhost ([20.205.105.33])
        by smtp.gmail.com with ESMTPSA id i23-20020aa787d7000000b006cb4b7ffe2bsm10666551pfo.195.2023.11.29.06.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:32:17 -0800 (PST)
From:   Jiang Yihe <jiangyihe042@gmail.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Yihe <jiangyihe042@gmail.com>
Subject: [PATCH] intel_idle: add Cometlake support
Date:   Wed, 29 Nov 2023 22:31:32 +0800
Message-ID: <20231129143132.32155-1-jiangyihe042@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the Cometlake C-State is supported, support for Cometlake should
be added to intel_idle. Just use Kabylake C-State table for Cometlake
because they share the same table in intel_cstate.

Signed-off-by: Jiang Yihe <jiangyihe042@gmail.com>
---
 drivers/idle/intel_idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index dcda0afec..f83f78037 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1418,6 +1418,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&idle_cpu_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&idle_cpu_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&idle_cpu_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&idle_cpu_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&idle_cpu_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&idle_cpu_skx),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&idle_cpu_icx),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&idle_cpu_icx),
-- 
2.43.0

