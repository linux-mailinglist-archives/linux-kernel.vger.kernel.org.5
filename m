Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D802C7E29D7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjKFQeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjKFQeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:34:22 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09D3D6E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:34:17 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4083740f92dso34558275e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 08:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699288456; x=1699893256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EYBJJYxHXVaOXLuyYlpmiXxJZu+X3NV/t/jP52p7aiE=;
        b=mJ9e5nA0X3ousQ64ov5vssgR4TsFK3Lgz/N/L1yuFC9i0lHZhqeU7YlnulRLBRRRKZ
         dHHlLsfnJN4CA+maCEesmanvN+lHPhJrZjAOEcXovYo4oWS69j8dyoAC27c9ynGmWRE4
         8je83tWKhFFXWBRTx74kNBvSJ/OlF7x44tLfESNUxOZL6p9sDXyYce0FxL5412AwPO7N
         PGVjgafBqKTX8uEY2TYE3jlep+QvWaa0PwiHUuGNgtEhnC3OhSJiDck2oezPVV9rYRK4
         k+myDNJhiamtgQpEHhIUmMHKpp9nRNnadwcaPGzgZPeRCL11NbLE7uCxmooJEPsf6T8C
         uZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699288456; x=1699893256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYBJJYxHXVaOXLuyYlpmiXxJZu+X3NV/t/jP52p7aiE=;
        b=sIgjh+ZN8JZzBwyppv4bSbMoNlwSceCrvDkUhMZg2bf9eN/8C9gVH6S6O0xawLYKcA
         pIVRWs8u1TK8yRPIt9o+H3RnWUaaip6WLmPocHmsUV41/9+tOyN7aAaihh12MAkAiwH7
         x7tXgmP0lCof73A0K44v1+ow9Xb4eAxPJbnniv4l5Z5BrXGVhL16Qnkl87CHMgQctiCc
         cfc4VrmfIVSR9GOLC5co2lUxkgui0ljLJN2Z+/wUelvUNOnYJMGJfpqDXtI9LQt1YKPi
         6IoEvuDsltUsN9X4LtDt7QHek2oTJo+b4QzF8JsPNLr2J7Mx+QCViKTLcPYtyYUNfjzf
         pyaA==
X-Gm-Message-State: AOJu0Yxe7X/wMMvutB5TMK0xWpyRAPOfKwQAxuG96d6SOD0JOOo/vMBJ
        NMnf1mRf8FYq+Ma1RuIIMwl3/5bRrD4gGw==
X-Google-Smtp-Source: AGHT+IHKCrAYZb510xlJ6ClM4DiNSV+FC7hIQRklgVvys3wCFZG3gIf/SAn4hLpauYPEUn+PzzJC6A==
X-Received: by 2002:a05:600c:4f06:b0:409:5bd2:aa08 with SMTP id l6-20020a05600c4f0600b004095bd2aa08mr211372wmq.11.1699288455761;
        Mon, 06 Nov 2023 08:34:15 -0800 (PST)
Received: from localhost.localdomain ([154.72.160.59])
        by smtp.gmail.com with ESMTPSA id fj12-20020a05600c0c8c00b004094c5d92bdsm13171581wmb.31.2023.11.06.08.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 08:34:14 -0800 (PST)
From:   Brandon Cheo Fusi <fusibrandon13@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: [PATCH] regmap: add regmap_update_bits variant to autoshift mask
Date:   Mon,  6 Nov 2023 17:34:06 +0100
Message-Id: <20231106163406.33952-1-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is both trivial and very handy in cases where the mask contains a single
contiguous group (GENMASK(hi, lo)), so users don't have to always adjust val.

Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
---
 include/linux/regmap.h | 69 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index c9182a477..373f00f30 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1241,12 +1241,28 @@ static inline int regmap_update_bits(struct regmap *map, unsigned int reg,
 	return regmap_update_bits_base(map, reg, mask, val, NULL, false, false);
 }
 
+static inline int regmap_update_bits_autoshift_val(struct regmap *map, unsigned int reg,
+				     unsigned int mask, unsigned int val)
+{
+	val <<= (ffs(mask) - 1);
+
+	return regmap_update_bits_base(map, reg, mask, val, NULL, false, false);
+}
+
 static inline int regmap_update_bits_async(struct regmap *map, unsigned int reg,
 					   unsigned int mask, unsigned int val)
 {
 	return regmap_update_bits_base(map, reg, mask, val, NULL, true, false);
 }
 
+static inline int regmap_update_bits_autoshift_val_async(struct regmap *map,
+					   unsigned int reg, unsigned int mask, unsigned int val)
+{
+	val <<= (ffs(mask) - 1);
+
+	return regmap_update_bits_base(map, reg, mask, val, NULL, true, false);
+}
+
 static inline int regmap_update_bits_check(struct regmap *map, unsigned int reg,
 					   unsigned int mask, unsigned int val,
 					   bool *change)
@@ -1255,6 +1271,16 @@ static inline int regmap_update_bits_check(struct regmap *map, unsigned int reg,
 				       change, false, false);
 }
 
+static inline int regmap_update_bits_autoshift_val_check(struct regmap *map,
+					   unsigned int reg, unsigned int mask, unsigned int val,
+					   bool *change)
+{
+	val <<= (ffs(mask) - 1);
+
+	return regmap_update_bits_base(map, reg, mask, val,
+				       change, false, false);
+}
+
 static inline int
 regmap_update_bits_check_async(struct regmap *map, unsigned int reg,
 			       unsigned int mask, unsigned int val,
@@ -1264,6 +1290,17 @@ regmap_update_bits_check_async(struct regmap *map, unsigned int reg,
 				       change, true, false);
 }
 
+static inline int
+regmap_update_bits_autoshift_val_check_async(struct regmap *map,
+				   unsigned int reg, unsigned int mask, unsigned int val,
+			       bool *change)
+{
+	val <<= (ffs(mask) - 1);
+
+	return regmap_update_bits_base(map, reg, mask, val,
+				       change, true, false);
+}
+
 static inline int regmap_write_bits(struct regmap *map, unsigned int reg,
 				    unsigned int mask, unsigned int val)
 {
@@ -1808,6 +1845,13 @@ static inline int regmap_update_bits(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
+static inline int regmap_update_bits_autoshift_val(struct regmap *map,
+					 unsigned int reg, unsigned int mask, unsigned int val)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_update_bits_async(struct regmap *map, unsigned int reg,
 					   unsigned int mask, unsigned int val)
 {
@@ -1815,6 +1859,14 @@ static inline int regmap_update_bits_async(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
+static inline int regmap_update_bits_autoshift_val_async(struct regmap *map,
+					   unsigned int reg, unsigned int mask, unsigned int val)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
+
 static inline int regmap_update_bits_check(struct regmap *map, unsigned int reg,
 					   unsigned int mask, unsigned int val,
 					   bool *change)
@@ -1823,6 +1875,14 @@ static inline int regmap_update_bits_check(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
+static inline int regmap_update_bits_autoshift_val_check(struct regmap *map,
+					   unsigned int reg, unsigned int mask, unsigned int val,
+					   bool *change)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int
 regmap_update_bits_check_async(struct regmap *map, unsigned int reg,
 			       unsigned int mask, unsigned int val,
@@ -1832,6 +1892,15 @@ regmap_update_bits_check_async(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
+static inline int
+regmap_update_bits_autoshift_val_check_async(struct regmap *map,
+				   unsigned int reg, unsigned int mask, unsigned int val,
+			       bool *change)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_write_bits(struct regmap *map, unsigned int reg,
 				    unsigned int mask, unsigned int val)
 {
-- 
2.30.2

