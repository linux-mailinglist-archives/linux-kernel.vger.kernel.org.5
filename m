Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C7180B4D7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 15:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjLIOPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 09:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLIOPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 09:15:12 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE4910E6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 06:15:19 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ce76f0748fso2088268b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 06:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702131318; x=1702736118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dOqfTtQ7ulCx2hj31UovM4Dg0r3q4oUpbgRbtAdcj1A=;
        b=TZwV+7h1mfOyMA/bfmKRVLiMrfIRwD/xd4vsdJKvCoqDHnpSMIxsrC2PnUgjgwPrbc
         koax3n9bkZ13o0jSgmxWorZzYXI7x4lQi0VZch7ISjntL/Hta4VTeTzav/CUgkyVO5Af
         7VIe1jiNxrLjrWSaQ1mf6O+vafX5f+wH0aJIvH/2hftcSUuCqxbSd7xMr8hUrULMXQ1X
         ShGtNZ4OldFLh9qXwwgPLCjrlIgcGAWTjcjo51zE/CHUgd3nxV/1ROyCsC6Xluot8K9z
         elo0jBcPFfdYwV+FH/m138UF7ntnjbgMgVJ0IvFEh7G6pbfeqPRgZnt/hs3rxNVxIu2Z
         h/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702131318; x=1702736118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOqfTtQ7ulCx2hj31UovM4Dg0r3q4oUpbgRbtAdcj1A=;
        b=dszqdCDemZxztYAsluXWQgDwa/+/xpodsWHhf245a7HKLhxm59Ht0xNB+786l4d/hZ
         wHKvQrbQKEfXERM4C8KZtMMmhiGbfZBI/ZHI7TFOXOrb8nTarSuyD0mEXHMUapLWl9A2
         ZEFN15oDiR6vlDhYT9kPARF+6Z6J56Q0KBDV+mucKzCFxQbSZxelKPTg9opxzzw70a2u
         NVNkxrOL8DgFGFhPCcEwMzKJX/6p5zheOaqf8HHMi/pa9DsqkdBnghYpImydIR7KJWGe
         VsAYWK0xjiL8nRYi2oCkv4hFwlj4GdNd35fxsJXrwIO3NR2jFgtyqFeGocl+B0lafYHf
         kccQ==
X-Gm-Message-State: AOJu0YyyPWx8IAhR1UmmKaS6TFzT+NGpUOk5/cRmWCQpT2/IKNx8gMbZ
        7oXXpSZ9/8n+UWozeaXlsJ6qXHuWl34=
X-Google-Smtp-Source: AGHT+IFSIBAclxcKznD5lC6fo4FRkGt5j4oI2WgZx0nii29/9XNjOwtW2hpoPiTe0YBtM1yrS9E1uw==
X-Received: by 2002:a05:6a20:7fa6:b0:18f:dde5:7211 with SMTP id d38-20020a056a207fa600b0018fdde57211mr861786pzj.7.1702131318201;
        Sat, 09 Dec 2023 06:15:18 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id m2-20020a635802000000b005b6c1972c99sm3281644pgb.7.2023.12.09.06.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 06:15:17 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] crash_core: Fix the check for whether crashkernel is from high memory
Date:   Sat,  9 Dec 2023 22:14:38 +0800
Message-ID: <20231209141438.77233-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
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

If crash_base is equal to CRASH_ADDR_LOW_MAX, it also indicates that
the crashkernel memory is allocated from high memory. However, the
current check only considers the case where crash_base is greater than
CRASH_ADDR_LOW_MAX. Fix it.

This patch also includes some minor cleanups.

Fixes: 0ab97169aa05 ("crash_core: add generic function to do reservation")
Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/crash_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index efe87d501c8c..d4313b53837e 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -199,7 +199,7 @@ static __initdata char *suffix_tbl[] = {
  * It returns 0 on success and -EINVAL on failure.
  */
 static int __init parse_crashkernel_suffix(char *cmdline,
-					   unsigned long long	*crash_size,
+					   unsigned long long *crash_size,
 					   const char *suffix)
 {
 	char *cur = cmdline;
@@ -268,9 +268,9 @@ static int __init __parse_crashkernel(char *cmdline,
 			     unsigned long long *crash_base,
 			     const char *suffix)
 {
-	char	*first_colon, *first_space;
-	char	*ck_cmdline;
-	char	*name = "crashkernel=";
+	char *first_colon, *first_space;
+	char *ck_cmdline;
+	char *name = "crashkernel=";
 
 	BUG_ON(!crash_size || !crash_base);
 	*crash_size = 0;
@@ -440,7 +440,7 @@ void __init reserve_crashkernel_generic(char *cmdline,
 		return;
 	}
 
-	if ((crash_base > CRASH_ADDR_LOW_MAX) &&
+	if ((crash_base >= CRASH_ADDR_LOW_MAX) &&
 	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
 		memblock_phys_free(crash_base, crash_size);
 		return;
-- 
2.43.0

