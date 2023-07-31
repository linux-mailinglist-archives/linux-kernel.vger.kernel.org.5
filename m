Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B769768A12
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 04:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjGaCik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 22:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjGaCii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:38:38 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00F210CE;
        Sun, 30 Jul 2023 19:38:33 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686ea67195dso2822521b3a.2;
        Sun, 30 Jul 2023 19:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690771113; x=1691375913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ARxiCoB+DCxySI06TbQe/1opBfLGlEbdA/arcMTzmFU=;
        b=BJasjRvNE8e3dDMzzRpr096BocEe6ocP5JxoG8E2Ze96sbnYIW0VA01TIeTAOGgRKE
         zkpTvoa+aJq8PLiygj/lU6RRVKOtck73spYRPtZ8D5pk21RIVRmgXMr9TDJ2ucg06hro
         8hYV6Jj9+bl00VgGkXhFD91lNdeAgTU6Y3MM7jpoNUxj0ERr58GVn/rG7Hv0dHKi85Vu
         khaNw3CTX9WwTHM3EHJ/gTXPL0u3npFeE5BqSakcbtVtw0Eh1NA0wDgHCmSmO9aseeSx
         9oQ1JLpTDoODCtJBexwlkzR+517eatnjpGI/LyvAjAuyNC09I9lgNMe6lu2CjdVPhsxH
         5Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690771113; x=1691375913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ARxiCoB+DCxySI06TbQe/1opBfLGlEbdA/arcMTzmFU=;
        b=j8RPqW26SJVlzrwyVBMf+MwYYzRklqA/LO1qDBQe49iHMmAF56g7xR42mZ8lbzGlRD
         30/kGQ+ogdfKry2fT/N27bhTsdlbHqjH7lDYV1mHW5RM0A7RbrechZo4vLFSK+HvppYX
         AuK9EhyHMeJKBEO+5JiujQaZQipQgrSHbY54af0UA50v2LkX6sDaAyMpYWY60lgAIGGz
         zT7Hlxf0Q1RlAeXMbN0ieuVgOkFMrvA8b18RFUUaPJGV8Bn6WH7tsot/Wx80EnMwVEt9
         Vx560jVli2pwnZV3D2D1enlp6vMp67+tyrjW1xPjGF7qlX0QyZiC3NBhQ2alLVIyVNCh
         TWPw==
X-Gm-Message-State: ABy/qLbNPiKJq14bl+2Kk7QyDY6B+yISPO2uva+GKJrxfSO00Un3cjM5
        9rBgg6zYFHzv8KJkIb1iKg8=
X-Google-Smtp-Source: APBJJlHRPRHHkKwKoOs5V9VHQLWmC3z/V04kEImJhE9suNHr3LMJnF2jA8vaJQ2VfqXFI4NTMfIn2g==
X-Received: by 2002:a05:6a00:170a:b0:672:264c:e8cf with SMTP id h10-20020a056a00170a00b00672264ce8cfmr9547837pfc.7.1690771113025;
        Sun, 30 Jul 2023 19:38:33 -0700 (PDT)
Received: from rajgad.hsd1.ca.comcast.net ([2601:204:df00:9cd0:f50b:8f24:acc4:e5c])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b006661562429fsm2474546pfe.97.2023.07.30.19.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 19:38:32 -0700 (PDT)
From:   Atul Raut <rauji.raut@gmail.com>
To:     jirislaby@kernel.org, mickflemm@gmail.com, mcgrof@kernel.org,
        kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] ath5k: Fix debugfs_create_dir error checking
Date:   Sun, 30 Jul 2023 19:38:20 -0700
Message-Id: <20230731023820.26571-1-rauji.raut@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The debugfs_create_dir function returns ERR_PTR
in case of error and the correct way to check an
error is 'IS_ERR' inline function.
This patch will replace the null-comparison with IS_ERR

This issue was found with the help of Coccinelle.
./drivers/net/wireless/ath/ath5k/debug.c:985:6-12: Wrong debugfs call error processing on line 985

Signed-off-by: Atul Raut <rauji.raut@gmail.com>
---
 drivers/net/wireless/ath/ath5k/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath5k/debug.c b/drivers/net/wireless/ath/ath5k/debug.c
index 4b41160e5d38..08058b3f7e22 100644
--- a/drivers/net/wireless/ath/ath5k/debug.c
+++ b/drivers/net/wireless/ath/ath5k/debug.c
@@ -982,7 +982,7 @@ ath5k_debug_init_device(struct ath5k_hw *ah)
 	ah->debug.level = ath5k_debug;
 
 	phydir = debugfs_create_dir("ath5k", ah->hw->wiphy->debugfsdir);
-	if (!phydir)
+	if (IS_ERR(phydir))
 		return;
 
 	debugfs_create_file("debug", 0600, phydir, ah, &fops_debug);
-- 
2.34.1

