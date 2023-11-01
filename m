Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1C67DDA3B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376996AbjKAA0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 20:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376938AbjKAA0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 20:26:33 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBDCED;
        Tue, 31 Oct 2023 17:26:30 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7a996357550so218629239f.2;
        Tue, 31 Oct 2023 17:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698798389; x=1699403189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hQ8DAFT4FsmbzhSx1IDeWkXEPOHVXkBPwwDIEI4NyY=;
        b=RAiTdEZRWuKPWDpKS1I0KD31E2joPN+XVWYgtEZcAPGgeEPZJf9Ihs/o2akeu9R9m3
         nwwgq2J4V/tsd52sQopoCQoSbl3YGbSn6MLm/ew+DcLzjjUapyUvZeLGNB2MjmlQmDkA
         LihmX9gYd7rIsg4oMR++aH90UKKQL+NH5DZyHprrPPjK4qJEe41aXQ6Rdrqi/mTYMAKD
         zbUAo/d4fqz8A/RxRGFytZGTuAF+KH3rv7vbhPiK99h9r1cPEruWnu+gfaJMH+BcbCiU
         NMbDPEfU5Xm0uP/QnTgEurdgi12y5G44cnF5GgmPWP1montv/pibFCqF1yiugNOoB21j
         sOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698798389; x=1699403189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hQ8DAFT4FsmbzhSx1IDeWkXEPOHVXkBPwwDIEI4NyY=;
        b=QcJFvjI90DsRJd6+inwlPYruZfU6LFji0nHP6hqPbZZ6pFJbGdigyc9sfCiS2MMB4o
         yG3n4lbFXiTrJY+YCHEsyKJK33pDWf4az4YaKP47MSUKUCirSQFGSWIiqMjfcUiV8M72
         Ltt68xH9mKa1ALyTbFBmOBR1hNi3cJe+hgyvS0ISNmBnSQHDdZ+YlfqVLbRtQgQKa862
         kt5RgJ4mzivtALTJ83x8LtvEK/VO1JY3iBZ72CkCEWdLj+xsAA+Q4UquWid8li7S+OxZ
         Z9xtyUijd/eoGK6iVYN260h5bdsO36iw41VCSyEZ5wIkNUAnw9bVlsy8iG5vCt8HhaQq
         gCqg==
X-Gm-Message-State: AOJu0YzB0WvaJpoMEAURuOJmvAsRMRd2Tr2PiVqN6+EZHiYl6XK7C0Wy
        CALPBvNmXdcE42rFQM6RATrqRFGPBaNZuw==
X-Google-Smtp-Source: AGHT+IGoZwyTejPyF/x61C7aax02IFGm+vpxScGEI8nVTy/6kxoXvVD473P14nJ/WTMgthR5yZu5hA==
X-Received: by 2002:a05:6e02:12c6:b0:351:22a2:bbe7 with SMTP id i6-20020a056e0212c600b0035122a2bbe7mr18224917ilm.0.1698798389568;
        Tue, 31 Oct 2023 17:26:29 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t1-20020a92c901000000b00357cc8df1d5sm141701ilp.68.2023.10.31.17.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 17:26:29 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     lb@semihalf.com, linux@rasmusvillemoes.dk, joe@perches.com,
        mcgrof@kernel.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, linux-doc@vger.kernel.org,
        quic_saipraka@quicinc.com, will@kernel.org,
        catalin.marinas@arm.com, quic_psodagud@quicinc.com, maz@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com
Subject: [PATCH v7d 09/23] dyndbg: silence debugs with no-change updates
Date:   Tue, 31 Oct 2023 18:25:55 -0600
Message-ID: <20231101002609.3533731-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101002609.3533731-1-jim.cromie@gmail.com>
References: <20231101002609.3533731-1-jim.cromie@gmail.com>
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

check for actual changes before announcing them, declutter logs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b0e11f6bfaa2..b07aab422604 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -591,7 +591,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	return nfound;
 }
 
-/* apply a new bitmap to the sys-knob's current bit-state */
+/* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 				     unsigned long *new_bits, unsigned long *old_bits,
 				     const char *query_modname)
@@ -602,8 +602,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
-		  query_modname ?: "");
+	if (*new_bits != *old_bits)
+		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
 		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
@@ -618,8 +619,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
-	v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
-		  query_modname ?: "");
+	if (*new_bits != *old_bits)
+		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	return matches;
 }
-- 
2.41.0

