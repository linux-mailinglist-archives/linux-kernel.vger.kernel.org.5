Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC3C80C0B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjLKFbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjLKFbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:31:37 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC06D7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 21:31:43 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c26a45b2dso21583665e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 21:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702272702; x=1702877502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hfVl0zhVcrsmg6t5d7DiGBu3+0T17ial1OcP+myLVb8=;
        b=BhpzvzDnVg1dT61O231xo5wbAC/dd+BxrnVi2IjgSK8DJ7wpFWtYr48ix6OuJcFoNk
         auDwa/hlJpEbELeui/V0rrtwEJCqvEcaO4qYhFN1v6YSZf9VAL5eCyZlEk8dqPBFlXtV
         9TdWl3ibMLp2C/kJ/VvcIBrBoATEeHLfd5xtFqk5JfthOc5AhalUx5FZpl9Hdsom5Fy1
         /q74wH6iSEZRlREpgd/cVpuU0l16D9smAzaCCA1Tbzj72k58VI0iN9hI3UgARCEVoQoT
         1u22fU/UuRDhXeV7SkUu2AEoizNpA/4UOW8D5R//6NKgP+cKVttU+PW+zubG/rN9O9mp
         B8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702272702; x=1702877502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfVl0zhVcrsmg6t5d7DiGBu3+0T17ial1OcP+myLVb8=;
        b=QhwL+d33++N4g/xgI4CMGAkYYZ61D5hBL19TvdxOe9aSvIGYUPs0e+imqb/705DPLv
         q2o1Wken1wWAptO8C6X3NIInwmXkvOupmBMYhzNruZwFnkxi/epBRQhAianl46384IQU
         rnzlSL4Rmntlr+m+l7LzSxaDKYX2vYICQcyJvtzgDlZZ4Q7atlMLHmpHP66CKAVw/QOI
         Ir/6Y8lD06YP34Ru3P5QIHKYhtXaNO+ISumqUGOd7Q90RRl7AYsBwvXc5++jN8JfVDmC
         iiNvBGTQ5uFjOVFlgOO58W46lUtAvheqBDEltkhx3xoVueJpbwcVc4j9rEvBnVRgfbyo
         VSCw==
X-Gm-Message-State: AOJu0YzG43CRuL9bnEmynunFuViVb+xFcAMyPcOmwx1g9yPbQC8OSvie
        +iU1B82UP3z9LXRv0iDmpER+TDktIWs=
X-Google-Smtp-Source: AGHT+IEiQ4QgKPKV/U7Lb6+Z9COydKtpepYMIbLwN5oMu2crN6GwNUoXPrwTU7yu4C6cSnG6bcw1Hg==
X-Received: by 2002:a05:600c:3503:b0:40c:32f9:afd4 with SMTP id h3-20020a05600c350300b0040c32f9afd4mr1873235wmq.9.1702272702050;
        Sun, 10 Dec 2023 21:31:42 -0800 (PST)
Received: from eagle-5590.. ([193.160.245.66])
        by smtp.gmail.com with ESMTPSA id m8-20020adffa08000000b00333332a8d39sm7639223wrr.55.2023.12.10.21.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 21:31:41 -0800 (PST)
From:   Ronald Monthero <debug.penguin32@gmail.com>
Cc:     sjenning@redhat.com, akpm@linux-foundation.org,
        Ronald Monthero <debug.penguin32@gmail.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/zswap: Improve with alloc_workqueue() call
Date:   Mon, 11 Dec 2023 15:28:49 +1000
Message-Id: <20231211052850.3513230-1-debug.penguin32@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use alloc_workqueue() to create and set finer
work item attributes instead of create_workqueue()
which is to be deprecated.

Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
---
 mm/zswap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 74411dfdad92..64dbe3e944a2 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1620,7 +1620,8 @@ static int zswap_setup(void)
 		zswap_enabled = false;
 	}
 
-	shrink_wq = create_workqueue("zswap-shrink");
+	shrink_wq = alloc_workqueue("zswap-shrink",
+			WQ_UNBOUND|WQ_MEM_RECLAIM, 0);
 	if (!shrink_wq)
 		goto fallback_fail;
 
-- 
2.34.1

