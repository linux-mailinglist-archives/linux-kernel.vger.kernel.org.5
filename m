Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C4B7689F9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 04:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjGaC0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 22:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGaC0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:26:13 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841D019C
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:26:12 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8b4749013so32053105ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690770372; x=1691375172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+5+YDtWOqzo4ntCd+ygrleNLdsHAxAxplxj1dQXMQFU=;
        b=hdJPCLFD6ReyKmnF/ug9HWb5kg1E28UUAXXmv8egdv9xxQkThiVfhuSHBKmF7GcLJD
         lhpwd2oUOws2qM2/rEbDiRyFv1IucwhwfzTIt4/O/SKIWXY9mQYhw99Q0h2PsOnEAWU4
         hFZTS8t2EorHlPm3R+hQ1pPRGYQdl1+11bA0mTG0HyVq7mUAgFCyvyjQncueSRbQyduw
         hwC5rj21ZjjZKYNu/aSYwhMGHzxNos8+BBmczhTwhqCcoXxelfG9vkziu5n4rag4hO0R
         ndzen1kWIQCX3T7uJid61z356RElByaco+/nuR/bD61S6nE/+6GWbazNeTOZvYYIO0Ok
         tcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690770372; x=1691375172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5+YDtWOqzo4ntCd+ygrleNLdsHAxAxplxj1dQXMQFU=;
        b=keAwdvoxhBqIOdf+UYksZAitIyewOl/f1glhiBWTRy9+tJKruKoYc1vjpUWXPVV1WA
         rfSjf5TwxxGDq/njWpyOC4y9e5UTmk1RKrtTY6a3sxMbAu643IDt/5PMVrQLkOQRwhTp
         AxG/mqEjBr3kGoWLbxoyLOsw4zrh/UjBQETz44KSjjiOC1GgmBIJAdwbs7XV5FxAoDiG
         1jHFKcp7VwNb+ExV5njGWoxHMsA4qs8CTodRXT4ixeQqQ3YLnj9mlAw8rE3rVzUdJphF
         7LR8kSSSr9KMoZuPO8xH1iktjlzfivyswEcWo1Hns4TRNB6/YomcAGnpp2zKvzqxfdAx
         LD9Q==
X-Gm-Message-State: ABy/qLZP0H5Zvypocl5vj4vIbfpc0AzBPlSfipOpBHXkrN8aEe7tDq/Z
        3XfMmSmyCCXn+P5QuT+3B/eA+dBF+LAcZ8uF
X-Google-Smtp-Source: APBJJlF+vu+opgQ1dCnvS8yu4mP20sj7AQijKvtoK4+KiXtKJ9FGp/UBhR3wdrI/NYwby8rzAkp0Og==
X-Received: by 2002:a17:902:ea0d:b0:1b8:6cac:ffe8 with SMTP id s13-20020a170902ea0d00b001b86cacffe8mr9713516plg.51.1690770371714;
        Sun, 30 Jul 2023 19:26:11 -0700 (PDT)
Received: from rajgad.hsd1.ca.comcast.net ([2601:204:df00:9cd0:f50b:8f24:acc4:e5c])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b001b03842ab78sm7233993pll.89.2023.07.30.19.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 19:26:11 -0700 (PDT)
From:   Atul Raut <rauji.raut@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] ipc:msg: Replace zero-length arrays with DECLARE_FLEX_ARRAY() helper
Date:   Sun, 30 Jul 2023 19:25:57 -0700
Message-Id: <20230731022557.25598-1-rauji.raut@gmail.com>
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

Replacing zero-length arrays with C99 flexible-array members
because they are deprecated.
Use the new DECLARE_FLEX_ARRAY() auxiliary macro instead of defining
a zero-length array.

This fixes warnings such as:
./ipc/msg.c:981:6-11: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Atul Raut <rauji.raut@gmail.com>
---
 ipc/msg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index fd08b3cb36d7..300c126faf2d 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -978,7 +978,7 @@ SYSCALL_DEFINE4(msgsnd, int, msqid, struct msgbuf __user *, msgp, size_t, msgsz,
 
 struct compat_msgbuf {
 	compat_long_t mtype;
-	char mtext[1];
+	DECLARE_FLEX_ARRAY(char, mtext);
 };
 
 long compat_ksys_msgsnd(int msqid, compat_uptr_t msgp,
-- 
2.34.1

