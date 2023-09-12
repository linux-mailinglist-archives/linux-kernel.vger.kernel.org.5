Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA5E79C47B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbjILEDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbjILEDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:03:52 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FC6C1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:03:26 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5774750a6efso1709308a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694491406; x=1695096206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dO4+cEGxPiCeV2CVbiM9wjlADcga89b0P0sDkFy2dTQ=;
        b=TQbn0rx7Rp4DAhMqtEM4qk6Qkp4asj84T8+DPmNyabG0BvryPQNqVDhxZsuto1z64x
         d4LUHS+mhZuYApBP/9Rbyua6HTLyzcS62LeGd5pOto+3kTuXdQj5Oo2zfM8VlGIaR2nd
         3WmLctPvWutJFIHdCBTGOEDq/4SSDTZuvMMqzY/qK1FFu50zpQ2CCqh4RiEO+TMY2D+7
         U5W84SnbhqcO8H2x0y/LeK/ZnEPXjwEWKie3dNMa62CPFS9DmZlm2+y83ZUv1Tgb/3Wa
         B3EFoXf1ct03KxQTe9XEGumXaOlBhC7SMrPGufK3ROQ+7lfSlS8qVFLiQ6k0TDPAW6cp
         rUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694491406; x=1695096206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dO4+cEGxPiCeV2CVbiM9wjlADcga89b0P0sDkFy2dTQ=;
        b=s0okIfLYHvQlPGbUf+4attm6MQ+8zOBywFiYpNDZ2+Da4jmfk8/MVs5SRSSLSF7t/9
         o6Yuh4lCCmJ608I465sXDwkzvwt5HIp4YGcGu+lmvIR+hMwkhSu+F/a6+VCjwS2D71S1
         cAlDvLKSPF5ikPW4ZqIFY/Hg6ts682S60UkcqyOG28WXZvc64I2WVWAMoJCyoMWG3Kdi
         XZjMojRxKGrHzktddM5o8J2jdizl9yutPPkHnz0TX+5N85qHDia3DNAntjfwte+hdA8u
         zjTNgB44mVcrdegod7b19cHXkqp4Q3I53GgGXeo9n5DZ6bXar6mOmGQNV+GbMNfew2dD
         2hGg==
X-Gm-Message-State: AOJu0YwovJKOm+z6stVagXhYdxVcfsRuKu1JIWPYbhKaKRKJmD39VReR
        bMJNhMnvSGDFzgk9msitYGZIVg==
X-Google-Smtp-Source: AGHT+IEFDkF6RPRQQ7zVm28Lzgk5f6Cw4eASyqgaEr2khKODHnvIU9NlvDHMwwCWZZgQB4i0g2YtsQ==
X-Received: by 2002:a17:90a:630b:b0:26d:41ac:33f2 with SMTP id e11-20020a17090a630b00b0026d41ac33f2mr9397853pjj.32.1694491406077;
        Mon, 11 Sep 2023 21:03:26 -0700 (PDT)
Received: from PF2LML5M-SMJ.bytedance.net ([203.208.189.6])
        by smtp.gmail.com with ESMTPSA id i5-20020a17090a974500b00256799877ffsm6384232pjw.47.2023.09.11.21.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:03:25 -0700 (PDT)
From:   "guojinhui.liam" <guojinhui.liam@bytedance.com>
To:     will@kernel.org, mark.rutland@arm.com
Cc:     lizefan.x@bytedance.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "guojinhui.liam" <guojinhui.liam@bytedance.com>
Subject: [PATCH] perf/arm-cmn: Fix CMN_DTM_UNIT_INFO offset in CMN700
Date:   Tue, 12 Sep 2023 12:03:09 +0800
Message-Id: <20230912040309.1789-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The por_dtm_unit_info's offest is 0x0960 in CMN700 according to
the CMN700 spec.

CMN700 spec link:
https://developer.arm.com/documentation/102308/0302/?lang=en
por_dtm_unit_info can be found in section [4.3.13.10 por_dtm_unit_info].

Signed-off-by: guojinhui.liam <guojinhui.liam@bytedance.com>
---
 drivers/perf/arm-cmn.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 913dc04b3a40..6f3fafee0ac9 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -113,6 +113,7 @@
 #define CMN_DTM_PMEVCNTSR		0x240
 
 #define CMN_DTM_UNIT_INFO		0x0910
+#define CMN700_DTM_UNIT_INFO		0x0960
 
 #define CMN_DTM_NUM_COUNTERS		4
 /* Want more local counters? Why not replicate the whole DTM! Ugh... */
@@ -2247,6 +2248,8 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 
 		if (cmn->part == PART_CMN600)
 			xp->dtc = 0xf;
+		else if (cmn->part == PART_CMN700)
+			xp->dtc = 1 << readl_relaxed(xp_region + CMN700_DTM_UNIT_INFO);
 		else
 			xp->dtc = 1 << readl_relaxed(xp_region + CMN_DTM_UNIT_INFO);
 
-- 
2.20.1

