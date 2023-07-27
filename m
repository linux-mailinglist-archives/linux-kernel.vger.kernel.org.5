Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3FE76529F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjG0Lit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjG0Lid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:38:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F892681
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:38:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-522294c0d5bso1049385a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690457906; x=1691062706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HKAs431Bm4xEbaSQXQ9BM/afLY0CvDY23KSbDRlnwNo=;
        b=Ypv1o8BgYjuDcZ7ushj3SbpVo+KU32Wn1eqygnl0xhiiuYEIuF+gmqHNCpssfyFTw2
         Tns7UgypDi0+5EPISF/czQcPOzPkfY9HuRsaTR6ik1l/3/LZfw7RuiQxX+cw+lOv8rf9
         nNdnJk2vWMdzApDrUVuSWPea5KWcSDsZdQ3WBUvKPO8Qf7SDCg38GktEHVJ8vhTkD12m
         zty2aRplk1k53murNiBXni6LlbqsDqZZa+++XzAOkCGrCTxcJwHNrUKRBNssrzCFCcc/
         1CnnFlKe1v5r1C/Qj8cxWc9gmAWZBOLT0+vJX4FMMhcgUgzTy9UgCA76E1fxcHobeTQ/
         qBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690457906; x=1691062706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKAs431Bm4xEbaSQXQ9BM/afLY0CvDY23KSbDRlnwNo=;
        b=dj2Ba5tDyGY/8uaV5gkJnmPnN+KK5WBlNmigVx1O1XRohge+eeOIjZlgwsdre2rkab
         m3zbh0i6diiFP4zsJuLiw/PmakZrZmST7fNkkDMPYoxef22qg/szfZTW0hla02/F/Wyn
         khKcK0v2I2Nh90wjMz2U3bH+8hkNAp6VQ2b85LdWqd2LOC//gtxtaaleol/cqY9bVKcv
         BTepG128Usga/GtHrIti+f+UrbAayIAq9SzYw3bUqngOl3of0NOHrK6/b2WmJhHBU/B1
         rHiaVkXS9G+V/Y4fQTI/fUb+2dxyJDEFtQY984uuAzuqhxsAjm9dhf/ze86QDdD6ZFkQ
         R2VQ==
X-Gm-Message-State: ABy/qLZYw/MZJQ1xG/8VkDmUHxdvxtNgmTatI9PWm4riBgskGY/YtWyJ
        F6sWg0SHm80eOpYWCOD8/vI=
X-Google-Smtp-Source: APBJJlGNYgdM1ATO7HXpFFiXg7RPLrFw7t8B2RPgdSyryAXi7EBk0RN/kbsDCbjxYlmuPVSHaleyHw==
X-Received: by 2002:aa7:d612:0:b0:521:a4bb:374f with SMTP id c18-20020aa7d612000000b00521a4bb374fmr1797881edr.5.1690457906040;
        Thu, 27 Jul 2023 04:38:26 -0700 (PDT)
Received: from f.. (cst-prg-78-36.cust.vodafone.cz. [46.135.78.36])
        by smtp.gmail.com with ESMTPSA id b26-20020aa7d49a000000b0051dfa2e30b2sm550336edr.9.2023.07.27.04.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 04:38:25 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-kernel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] file: mostly eliminate spurious relocking in __range_close
Date:   Thu, 27 Jul 2023 13:38:09 +0200
Message-Id: <20230727113809.800067-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Stock code takes a lock trip for every fd in range, but this can be
trivially avoided and real-world consumers do have plenty of already
closed cases.

Just booting Debian 12 with a debug printk shows:
(sh) min 3 max 17 closed 15 empty 0
(sh) min 19 max 63 closed 31 empty 14
(sh) min 4 max 63 closed 0 empty 60
(spawn) min 3 max 63 closed 13 empty 48
(spawn) min 3 max 63 closed 13 empty 48
(mount) min 3 max 17 closed 15 empty 0
(mount) min 19 max 63 closed 32 empty 13

and so on.

While here use more idiomatic naming.

An avoidable relock is left in place to avoid uglifying the code.
The code was not switched to bitmap traversal for the same reason.

Tested with ltp kernel/syscalls/close_range

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/file.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 35c62b54c9d6..5483c052ce93 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -693,29 +693,25 @@ static inline void __range_cloexec(struct files_struct *cur_fds,
 	spin_unlock(&cur_fds->file_lock);
 }
 
-static inline void __range_close(struct files_struct *cur_fds, unsigned int fd,
+static inline void __range_close(struct files_struct *files, unsigned int fd,
 				 unsigned int max_fd)
 {
+	struct file *file;
 	unsigned n;
 
-	rcu_read_lock();
-	n = last_fd(files_fdtable(cur_fds));
-	rcu_read_unlock();
+	spin_lock(&files->file_lock);
+	n = last_fd(files_fdtable(files));
 	max_fd = min(max_fd, n);
-
-	while (fd <= max_fd) {
-		struct file *file;
-
-		spin_lock(&cur_fds->file_lock);
-		file = pick_file(cur_fds, fd++);
-		spin_unlock(&cur_fds->file_lock);
-
-		if (file) {
-			/* found a valid file to close */
-			filp_close(file, cur_fds);
+	for (; fd <= max_fd; fd++) {
+		file = pick_file(files, fd);
+		if (file != NULL) {
+			spin_unlock(&files->file_lock);
+			filp_close(file, files);
 			cond_resched();
+			spin_lock(&files->file_lock);
 		}
 	}
+	spin_unlock(&files->file_lock);
 }
 
 /**
-- 
2.34.1

