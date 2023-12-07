Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDF6807F86
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 05:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjLGETk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 23:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjLGETi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 23:19:38 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8779410D5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 20:19:41 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cf7a8ab047so3482465ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 20:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701922781; x=1702527581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lm/9/c6BaFQpl62d2BJZi22EM3P4VW96ULrHqTqOnhk=;
        b=JS/DQ2sjZ6F1U0DJHhBxif0QxYJ3esffvuoFcnZvGCL/fKJ7RRq9tyaEAZJO7xhGPt
         95pXXVxxfnMdXE/ou43esPFVgTU9LKXzB64iaTFRsr/Gjf/RRQQPybv+aLRt2YWk5204
         lpVKAP54xj/VJIDTN0bzqk6L7V7uzpFE0GBqAa9HV5KvRLz+Zu+DmD0IFKXs2OT6Ll92
         p71u6huToTGyri2Hx2SVn+lZefgZzQKEU63gT8I4qU5W1WXn890jTr3X03kNILODYkoZ
         4zBo4ywQydZ/sWfVnnw1npMksj4VxLqk0qfgsIZlyGtXj4ZS9/F3BCs1km8Ti7mRUl9Z
         ihMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701922781; x=1702527581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lm/9/c6BaFQpl62d2BJZi22EM3P4VW96ULrHqTqOnhk=;
        b=mI5C9lUQz6/bFM3xreX8nWiKmVlxOA3DeIEnS6dkBOv/KFAspjUcFBLQSjyQk2Ol7s
         Bl+Ym4+hkKmN0cW99BQCUnv4hkUnYFHdyo6ZpsB0LI2kswbjEf83jrXqbeE4wuFZxSae
         Gq9C72eYJErE/Bg7HTTJwRVIhJNogMsJPrmv2tnS+YwNgBqzyDeys8HbeG8dlVAORN19
         FnQujztgEHbIN/0Xy0ZMJP/Uz3zlGabThqsqrDyKvy1d5Qd4FvxNkJlYpH24iOP7L3tf
         JN6fh0U9rvLpw6QHYLn2MDk5UfVTWfy4ZKxP8Efi+3BTtAbpdZxv5cnWzLUPjLwZuhZ6
         6f2A==
X-Gm-Message-State: AOJu0YwXRTiJObmpHkgrYL3X7BC91CNS+8hPevc/mCckux/CxCXks0Qn
        DAz7DET97d2Au8KARjQ5mNtn0Jh1hks=
X-Google-Smtp-Source: AGHT+IGu0NjTPjIhCKqfyME52u2Ullh7SslpBHMrifTDtMlaJgI/wXzMuRyN+e6hcbpqk9bQJsNfKw==
X-Received: by 2002:a17:902:ec87:b0:1d0:bc8f:eecb with SMTP id x7-20020a170902ec8700b001d0bc8feecbmr1676361plg.74.1701922780587;
        Wed, 06 Dec 2023 20:19:40 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902724a00b001d1d1ef8be6sm256488pll.267.2023.12.06.20.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 20:19:40 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] x86/mm: Remove unnecessary logic from numa_cleanup_meminfo()
Date:   Thu,  7 Dec 2023 12:18:41 +0800
Message-ID: <20231207041841.205818-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `bi->start` field is of type u64, which can only hold values greater
than or equal to 0. Therefore, the logic `bi->start = max(bi->start, low)`
is unnecessary. Remove it.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/mm/numa.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index b29ceb19e46e..f7336077b07e 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -239,7 +239,6 @@ static void __init alloc_node_data(int nid)
  */
 int __init numa_cleanup_meminfo(struct numa_meminfo *mi)
 {
-	const u64 low = 0;
 	const u64 high = PFN_PHYS(max_pfn);
 	int i, j, k;
 
@@ -254,9 +253,6 @@ int __init numa_cleanup_meminfo(struct numa_meminfo *mi)
 			continue;
 		}
 
-		/* make sure all non-reserved blocks are inside the limits */
-		bi->start = max(bi->start, low);
-
 		/* preserve info for non-RAM areas above 'max_pfn': */
 		if (bi->end > high) {
 			numa_add_memblk_to(bi->nid, high, bi->end,
-- 
2.43.0

