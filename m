Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BB27A7A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjITLlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjITLlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:41:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E2AB0;
        Wed, 20 Sep 2023 04:41:44 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so5346975e9.1;
        Wed, 20 Sep 2023 04:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695210103; x=1695814903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l0bjyLQzALz+mGal4nDqDnLTgwXZ5k5mNvC8JvxOXaE=;
        b=mkf9b3++aDixWc4+JaTzappLB5euszM4hX9QpR/4FaHm3/EWRU6uPdRj6ByItAGDgi
         KTSAxPNpNeBV+wtflvHEmsAWFUoFdFBtEFnxefxOzF8YpdMtFIKRs7CfXjF9ZKTe+I2s
         W5iWqOfmoBy1dLgEhW79HM7/umxlpZ4Pkff6rib+i0JdRajIaQVgGwTa3aJc9BQldPmk
         LlWpnHt+f4+5aUYqxx4fQiz8gDv/fzda0bIDVcxWBK5wtdbXVe5Hr7xpgvxsFlgtqY8y
         I2s5EV9lApprh20NgyUhLXkqtpQJpatZVgHDP1+oN8cwhR+XH7ee8F04qcZOosRpXUGH
         bCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695210103; x=1695814903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0bjyLQzALz+mGal4nDqDnLTgwXZ5k5mNvC8JvxOXaE=;
        b=J/0/puEbnGgYBTjKQhE9kQmgrBBKAHX4qTMlbsNGzU7flYnul9t42q3Cc5tYWa2YQ/
         1tQzJB3sUlk/kR5hhTJ3I43S3bwKDCQYUyESpz+ZogHB8ligRhneZM7fnaNzLpnmVNtW
         qGzKsN3Txd/Cd4b5Wbs5vV+QcYJbAmx346APq3paHAuR7Mv+USkwhv6F0JvU37tXVMac
         k2Ec1Xdm2U2o/KPOuKo1z2dFBxSemM6VdpW5GPKS8EhQR+waeKzYfDWdVlgFL6EJZS7P
         Fzs7Jb41ssI2aQ3LQYU/zopLprj8Sd6NI8qKztWQgUdVsE4EAHSBa+7ttx1jl6zX+F3B
         yTEg==
X-Gm-Message-State: AOJu0YyD085ewO9Fk3L1WELBJblzO23kl8VxgG+2yRd9yh7VY5kA8+TF
        JfJ3XK5aD2jZt1VoFB9zVro=
X-Google-Smtp-Source: AGHT+IHHfNcZhS4i3ItXzPzHqebwjb4GlO5M7Tpuh6NDxMuETe7SdV0JlOz/Yg42mxnyccxI0D+lhQ==
X-Received: by 2002:a05:600c:3b20:b0:405:251f:8455 with SMTP id m32-20020a05600c3b2000b00405251f8455mr850185wms.7.1695210102787;
        Wed, 20 Sep 2023 04:41:42 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c379000b00401e32b25adsm1752642wmr.4.2023.09.20.04.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 04:41:42 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] x86/unwind/orc: remove redundant initialization of pointer mid
Date:   Wed, 20 Sep 2023 12:41:41 +0100
Message-Id: <20230920114141.118919-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer mid is being initialized with a value that is never read,
it is being re-assigned and used inside a for-loop. Remove the
redundant initialization. Cleans up clang scan build warning:

arch/x86/kernel/unwind_orc.c:88:7: warning: Value stored to 'mid'
during its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/x86/kernel/unwind_orc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 7e574cf3bf8a..d00c28aaa5be 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -85,7 +85,7 @@ static struct orc_entry *__orc_find(int *ip_table, struct orc_entry *u_table,
 {
 	int *first = ip_table;
 	int *last = ip_table + num_entries - 1;
-	int *mid = first, *found = first;
+	int *mid, *found = first;
 
 	if (!num_entries)
 		return NULL;
-- 
2.39.2

