Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27C17D770B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjJYVsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJYVsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:48:08 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5141A3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1698270481;
        bh=OBn+A/l8SxiCM8pYkWDBMu9Vbe4Ej9dhbMErkCapgFw=;
        h=From:To:Cc:Subject:Date:From;
        b=evucBCtLcRhgzcOxhGkDUg2KZQigvdnMoGnGLRA/lXtNB4Px44KjpH5/wqK5t1qqV
         i9JRbGmj477Ws9acTCjwBCYgagzV7aBI2kzStfkPEd1nOKzmu0xGS+ZEOusZYPnB5r
         YTZPX7e7rR9hVpuSBKtp6vRaJj3wfxa+NuMKrC90QtmGgrva78UQ1iDkh6ffg192us
         ndevKMtGwXpayEe4dxW4t979pijO7qNTa9yFyME8JQ3Ki77VMkdd54cionaDaALXC2
         Bb2P8rXFuV8cOlntv3A/PP3ZF4DS1uulwZfCPoYbU1rdCYMDUYdr7yKE2TZvzz/MCy
         RHrjScjSh95jw==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:582e:ab84:d98b:7516])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SG2bj2Hg9z1ZC5;
        Wed, 25 Oct 2023 17:48:01 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] Fix: rseq uapi: Adapt header includes to follow glibc header changes
Date:   Wed, 25 Oct 2023 17:48:11 -0400
Message-Id: <20231025214811.2066376-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With "recent" glibc headers, using <sys/types.h> with __GNU_SOURCE fails
to have __u32 and others types needed by the rseq.h uapi header file.
Include ctype.h and asm/types.h to fix this. Add a __KERNEL__ #ifdef to
select the kernel vs userspace header includes.

Also, remove the now unneeded asm/byteorder.h include, since it also
causes its own build issues with "recent" glibc headers.

I'm cautiously using the term "recent" glibc here because I don't know
exactly in which glibc versions those changes happened. Steven
reproduced this issue with glibc 2.37 on Debian.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/uapi/linux/rseq.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index c233aae5eac9..0f9cd8211ff0 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -10,8 +10,12 @@
  * Copyright (c) 2015-2018 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
-#include <linux/types.h>
-#include <asm/byteorder.h>
+#ifdef __KERNEL__
+# include <linux/types.h>
+#else
+# include <ctype.h>
+# include <asm/types.h>
+#endif
 
 enum rseq_cpu_id_state {
 	RSEQ_CPU_ID_UNINITIALIZED		= -1,
-- 
2.39.2

