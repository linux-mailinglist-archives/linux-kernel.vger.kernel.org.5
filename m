Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86066767223
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjG1Qmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjG1Qmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:42:42 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AB5E2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:42:41 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7835bbeb6a0so33275739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690562561; x=1691167361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mapQj7LodZYltGHkh10jKsE+2rfFqJFkkugF8pstoFg=;
        b=a5mW98D1BzTHh5iFih+TUp7Ky3zQGTmEErih779mOBmxyohbEapKqcyDSrGispTk21
         jSoP4Uh17S731GmqrrDr/xbGQXHc1J0XtFq0HhSskJWNvzceY0d6aXiDqK9lFKTELDiK
         aO5YTfkQXivC74Siejd+JilC+/eIVGqXgzVA5tiYrcisNLEZfk94gycBdIg+2H/6wIxN
         CUNj4hAmpA2kcAugSwMEnJRZsrRiKlrAE7s21tJpbQpZ54JoyDDg19esxjVicrFHbvOz
         WSwlWkEnIUrfa8SqdB8I341LZwCNuy5X4c2uV46d4DVa4NXQfs5YbiRQXL/Hw6BBi83j
         SzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562561; x=1691167361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mapQj7LodZYltGHkh10jKsE+2rfFqJFkkugF8pstoFg=;
        b=BUPOnIjZYHQdcDTVXGTsMX64xVWv2s7IVAZq8YitVAhCrExajnZ79WY+YhgXYW86zz
         RD5W958a8T03WqB2VsXWI3zhNtP/HVM1YWU+756E+eTysCKHYJQkh+sDa6BIWTj8iTVw
         ozmEGXzkWKZofSY3HsfnTsEsHbS69RfB2pHjLPGWW3hXx8bkfZ6gXEfW8igEvFO/pTMI
         781bSUkAYmr01rR2l27O52ZxRLDTDBatRmrz1juGUZzvzuZ0Dwijh8Fr2C0mVn0DpKzF
         GraVvgH1aydC+XDVEwc6HG7kF+0KA/IhL9u6eZV0uyV68qtYlTs26oXvL/b0JvERtKvF
         bZmA==
X-Gm-Message-State: ABy/qLagmzMYH8Q889zYgLAVBVDxvumoo5EMQYE8rmJVZxgCH1Mr8NFh
        hDH7//hITmP3ltrr0tinXwQAeg==
X-Google-Smtp-Source: APBJJlHwulN5fIfCZXzZZAxXxemUWvUhC7lOoHzC71GXOUMC3OCZWx9mF3gMjTlha9ImqyjZVEUaVg==
X-Received: by 2002:a05:6602:1543:b0:780:c6bb:ad8d with SMTP id h3-20020a056602154300b00780c6bbad8dmr149421iow.0.1690562561063;
        Fri, 28 Jul 2023 09:42:41 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b2-20020a029a02000000b0042b37dda71asm1158808jal.136.2023.07.28.09.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 09:42:40 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, andres@anarazel.de, tglx@linutronix.de,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/12] futex: Extend the FUTEX2 flags
Date:   Fri, 28 Jul 2023 10:42:25 -0600
Message-Id: <20230728164235.1318118-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728164235.1318118-1-axboe@kernel.dk>
References: <20230728164235.1318118-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Add the definition for the missing but always intended extra sizes,
and add a NUMA flag for the planned numa extention.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/uapi/linux/futex.h | 7 ++++---
 kernel/futex/syscalls.c    | 9 +++++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index 0c5abb6aa8f8..0ed021acc1d9 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -46,10 +46,11 @@
 /*
  * Flags for futex2 syscalls.
  */
-			/*	0x00 */
-			/*	0x01 */
+#define FUTEX2_8		0x00
+#define FUTEX2_16		0x01
 #define FUTEX2_32		0x02
-			/*	0x04 */
+#define FUTEX2_64		0x03
+#define FUTEX2_NUMA		0x04
 			/*	0x08 */
 			/*	0x10 */
 			/*	0x20 */
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 42b6c2fac7db..cfc8001e88ea 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -183,7 +183,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
 }
 
-#define FUTEX2_MASK (FUTEX2_32 | FUTEX2_PRIVATE)
+#define FUTEX2_MASK (FUTEX2_64 | FUTEX2_PRIVATE)
 
 /**
  * futex_parse_waitv - Parse a waitv array from userspace
@@ -207,7 +207,12 @@ static int futex_parse_waitv(struct futex_vector *futexv,
 		if ((aux.flags & ~FUTEX2_MASK) || aux.__reserved)
 			return -EINVAL;
 
-		if (!(aux.flags & FUTEX2_32))
+		if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()) {
+			if ((aux.flags & FUTEX2_64) == FUTEX2_64)
+				return -EINVAL;
+		}
+
+		if ((aux.flags & FUTEX2_64) != FUTEX2_32)
 			return -EINVAL;
 
 		futexv[i].w.flags = aux.flags;
-- 
2.40.1

