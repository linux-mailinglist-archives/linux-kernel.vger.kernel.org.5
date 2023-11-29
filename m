Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4113B7FCE54
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 06:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjK2FfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 00:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjK2FfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 00:35:07 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177BE120
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 21:35:14 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-28555b0c7afso5718919a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 21:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701236113; x=1701840913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dIBqx2oS+xIFOoQxR3EPS6VRyKX+8khQ60y5SxvTWQ=;
        b=m1F/Bc+NpdBq8SaSJ3wz3GV43JKRlssdUI7RhF6QCt7mMjls7NDUN6kTVyFELiiEVL
         kM+pco0XdtyKaneMq4Jssq2WWtW0e+OQUaSSMKScy8hkD8ptq+wWHxo2fMxgGLLJzxgY
         MlBEzu14FnMOwHoU7r6qI4FKo5zqQE/n2ux0E69ogsBXWnN0edUMHtoB2AcXtXQvSYRF
         mmppREmdxMfpU/PjDT1VR2jgtWfGz36FrZSmUc+aRKlUEgJLnNZkGFMPVTqJ1orqyiEZ
         i9PEwXXCHpVfmwgkykHI6TCFh3pzVIRo1xsrwd2AiWczSwFOLh3Z0QN9xbzPfYv6sD4G
         r/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701236113; x=1701840913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dIBqx2oS+xIFOoQxR3EPS6VRyKX+8khQ60y5SxvTWQ=;
        b=HkQu/yulqt5QxFRKJKs+URMOW+3i/RyenO567K/8cWaHLBWk6DK4+5cYjv0HG2NScl
         RbVqLC3Zgl6CuT5syYAgwGa8LEjnK58nufLq8m0dR4mPPh5zHv/ZpSEHDnQ1Nk9t8eg3
         cSuj+0UhB/wtuZV/90PHpK2oWt34EgSKEocgoXG9KycomAOVBCrIszSby4VECvlE8jIT
         96keyTEU4g92OjXMBLp12Z+lBJ1RrCqZMICG8ddCK9zPGmgEPUf4VBKADd3iYvY9UQJZ
         k7vrarLNe+5uo68pzD7WBMD7cTRxdaIg/h5mgyovICv2Qdwy4IfRpkbQmJB1B49oeqoz
         D0Pg==
X-Gm-Message-State: AOJu0Yz5C2d9dm3ldOxawHs2Ql5vYVyXv5PtRGH/G2ZxtbThnwa1kW87
        GFmwIo5V5vPC/QbkrFQkiuHbnkXtxtCOxA==
X-Google-Smtp-Source: AGHT+IFGkS+AD6FjcjgeUjG28W7da06oZdikUTQYr6wr1Y6dcP+elvAnT1GQmRIPMuPBQ+fmh4Cvug==
X-Received: by 2002:a17:90b:1c85:b0:285:8d5c:9114 with SMTP id oo5-20020a17090b1c8500b002858d5c9114mr17821966pjb.19.1701236113315;
        Tue, 28 Nov 2023 21:35:13 -0800 (PST)
Received: from ubuntu.. ([43.132.98.44])
        by smtp.googlemail.com with ESMTPSA id gj6-20020a17090b108600b00285a2d14184sm660717pjb.0.2023.11.28.21.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 21:35:12 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        alexyonghe@tencent.com, hengqi.chen@gmail.com
Subject: [PATCH v3 1/3] seccomp: Introduce SECCOMP_LOAD_FILTER operation
Date:   Wed, 29 Nov 2023 05:34:38 +0000
Message-Id: <20231129053440.41522-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129053440.41522-1-hengqi.chen@gmail.com>
References: <20231129053440.41522-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new operation named SECCOMP_LOAD_FILTER.
It accepts a sock_fprog the same as SECCOMP_SET_MODE_FILTER
but only performs the loading process. If succeed, returns a
new fd associated with the seccomp filter. The seccomp filter
thus can be reused to attach to different processes.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 include/uapi/linux/seccomp.h |  1 +
 kernel/seccomp.c             | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index dbfc9b37fcae..ee2c83697810 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -16,6 +16,7 @@
 #define SECCOMP_SET_MODE_FILTER		1
 #define SECCOMP_GET_ACTION_AVAIL	2
 #define SECCOMP_GET_NOTIF_SIZES		3
+#define SECCOMP_LOAD_FILTER		4
 
 /* Valid flags for SECCOMP_SET_MODE_FILTER */
 #define SECCOMP_FILTER_FLAG_TSYNC		(1UL << 0)
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 255999ba9190..ef956c3d15c7 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1885,6 +1885,18 @@ static bool has_duplicate_listener(struct seccomp_filter *new_child)
 	return false;
 }
 
+static int seccomp_filter_put(struct inode *inode, struct file *file)
+{
+	struct seccomp_filter *filter = file->private_data;
+
+	__put_seccomp_filter(filter);
+	return 0;
+}
+
+static const struct file_operations seccomp_filter_fops = {
+	.release = seccomp_filter_put,
+};
+
 /**
  * seccomp_set_mode_filter: internal function for setting seccomp filter
  * @flags:  flags to change filter behavior
@@ -1996,12 +2008,29 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	seccomp_filter_free(prepared);
 	return ret;
 }
+
+static long seccomp_load_filter(const char __user *filter)
+{
+	struct seccomp_filter *sfilter;
+
+	sfilter = seccomp_prepare_user_filter(filter);
+	if (IS_ERR(sfilter))
+		return PTR_ERR(sfilter);
+
+	return anon_inode_getfd("seccomp-filter", &seccomp_filter_fops,
+				sfilter, O_CLOEXEC);
+}
 #else
 static inline long seccomp_set_mode_filter(unsigned int flags,
 					   const char __user *filter)
 {
 	return -EINVAL;
 }
+
+static inline long seccomp_load_filter(const char __user *filter)
+{
+	return -EINVAL;
+}
 #endif
 
 static long seccomp_get_action_avail(const char __user *uaction)
@@ -2063,6 +2092,11 @@ static long do_seccomp(unsigned int op, unsigned int flags,
 			return -EINVAL;
 
 		return seccomp_get_notif_sizes(uargs);
+	case SECCOMP_LOAD_FILTER:
+		if (flags != 0)
+			return -EINVAL;
+
+		return seccomp_load_filter(uargs);
 	default:
 		return -EINVAL;
 	}
-- 
2.34.1

