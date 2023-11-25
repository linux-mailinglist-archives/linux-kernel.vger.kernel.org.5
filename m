Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910697F8AE0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjKYMw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjKYMwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:52:54 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC742D3;
        Sat, 25 Nov 2023 04:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1700916776;
        bh=iUFGOwiGkTIEhre+odhGn4/1WdiJ+qVq49adTV3gQHM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=fztyoxz+RxX7MwxRfaVFrpt8zAzdiGOJNQQaZ2liuOTEhZJSPtgzPDAwdy8d+nduu
         6HIpQDcLALScEvSo3TB44K9Cg07c0e+d5EKM4CrbFZS+z4cX07Vb3ZYhQbCW8bF+IK
         CuVl6bAJigVYO1bVG73ZQ0PsCKDHyk2/sxUnLMcc=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sat, 25 Nov 2023 13:52:50 +0100
Subject: [PATCH RFC 1/7] sysctl: add helper sysctl_run_handler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231125-const-sysctl-v1-1-5e881b0e0290@weissschuh.net>
References: <20231125-const-sysctl-v1-0-5e881b0e0290@weissschuh.net>
In-Reply-To: <20231125-const-sysctl-v1-0-5e881b0e0290@weissschuh.net>
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Granados <j.granados@samsung.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700916776; l=1484;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=iUFGOwiGkTIEhre+odhGn4/1WdiJ+qVq49adTV3gQHM=;
 b=Cv+9BCerGMTP/2lwcmiBVc/6/kwT01UgiJ38sgxdeBN+8Ofpm5XgsYBpLeAWweL5YsfOi/XO9
 t1IRt8PjV7dBp1eb61hCnnM6/2qS3I9vKlVDUuz7KXnyXahSMJE7Xs2
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A future patch will introduce a second handler function.
To make the code future-proof add the sysctl_run_handler function that
automatically can call the correct handler function.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/proc_sysctl.c  | 2 +-
 include/linux/sysctl.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 8064ea76f80b..1bb0aa2ff501 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -597,7 +597,7 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 		goto out_free_buf;
 
 	/* careful: calling conventions are nasty here */
-	error = table->proc_handler(table, write, kbuf, &count, &iocb->ki_pos);
+	error = sysctl_run_handler(table, write, kbuf, &count, &iocb->ki_pos);
 	if (error)
 		goto out_free_buf;
 
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 61b40ea81f4d..604aaaa1fce2 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -298,4 +298,10 @@ static inline bool sysctl_is_alias(char *param)
 int sysctl_max_threads(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
+static inline int sysctl_run_handler(struct ctl_table *ctl, int write,
+				     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	return ctl->proc_handler(ctl, write, buffer, lenp, ppos);
+}
+
 #endif /* _LINUX_SYSCTL_H */

-- 
2.43.0

