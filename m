Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B21C80450F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344101AbjLECiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343967AbjLECiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:38:03 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A31CA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:38:10 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5caf86963ecso72675467b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 18:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701743889; x=1702348689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5EkC8tBFkc/bGatstNbW1R85aDFjsej7pU03fOLuo0o=;
        b=YqFHc9Mjdi7mYPsWapFDKWQAk70FTbT7wnLxLJlLeOWG78PIkdEtVoK6/ZO3hsFJGK
         Ds6heHaxh2i0+TS2EXOn0VBrgcrAQ8me9HXK3+Nuw0LCsm1rApYSFLBIIG4fdYi8mwR1
         h09iFDXnEofrZEg65alXxmzk82cmHzub0QJfu7k56f/JrmiD0uzqdXU20ykn0SWRT0sc
         YeSHvmSuYVkUs16RcQOUYEv0swN2kQYGNlxTDP7tKZ6B6gxNWeBh7cBBv047Rv8IloHm
         5Ul0wDRHX65s1jWXV6Q3QlxMzz/gWPZ39oBy5q6vwo4PRPzuv/TCRgseIOkmU3KQkbDv
         qwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701743889; x=1702348689;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5EkC8tBFkc/bGatstNbW1R85aDFjsej7pU03fOLuo0o=;
        b=U1N/aRmmsw+tXUoz3a0o7O6EroAOhCiehPnx7fTm1EbCtzs0ggw6BxXHwkTw1IpVch
         b0zY2C+oknwaKgdbRmgwTEh3GMt0BuF0rm+XC5wj9eAx40c0sYpT1OsBs/L2foEuD9hf
         kjorN0JCQU+u1uZ29373EPafWWMPuOPZHsN+QTgagpKkfgp2jpxQ7KZA/Alhng4nRYtr
         lNe0Pdo0AeLnqfDNf2nKN0A3kflfmIe5kFMTdP6oBX1cqhl5UwdyRqih0FXxqqjhxDq7
         ciDMJvsBHuqQI6lvDnSUEEbJEFrNS+wD06U/YZ/burz9qOumodO10U1ahVv5JWfyoXw7
         T38A==
X-Gm-Message-State: AOJu0YzGWg3bfuKcDdhr6nS5/T+xpGGhT/BnOfymCFbUcsG+SM55MDgG
        X9DyF6AD7lC6VyPXMUxQuerb+N2yAPo=
X-Google-Smtp-Source: AGHT+IH66c/DcXoUES/OjQFHfKfa4wp28KTZsImTGDG6MYhRnIRLKo451oU0sYuWQc272uiv+NUawl/qMJw=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:5074:e7bb:c7b:6a8a])
 (user=drosen job=sendgmr) by 2002:a05:690c:2509:b0:5d8:5d2c:121d with SMTP id
 dt9-20020a05690c250900b005d85d2c121dmr102229ywb.7.1701743889565; Mon, 04 Dec
 2023 18:38:09 -0800 (PST)
Date:   Mon,  4 Dec 2023 18:38:01 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231205023801.3669458-1-drosen@google.com>
Subject: [PATCH v3] f2fs: Restrict max filesize for 16K f2fs
From:   Daniel Rosenberg <drosen@google.com>
To:     linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Blocks are tracked by u32, so the max permitted filesize is
(U32_MAX + 1) * BLOCK_SIZE. Additionally, in order to support crypto
data unit sizes of 4K with a 16K block with IV_INO_LBLK_{32,64}, we must
further restrict max filesize to (U32_MAX + 1) * 4096. This does not
affect 4K blocksize f2fs as the natural limit for files are well below
that.

Fixes: d7e9a9037de2 ("f2fs: Support Block Size == Page Size")
Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 033af907c3b1..5dfbc6b4c0ac 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3364,6 +3364,14 @@ loff_t max_file_blocks(struct inode *inode)
 	leaf_count *= NIDS_PER_BLOCK;
 	result += leaf_count;
 
+	/*
+	 * For compatibility with FSCRYPT_POLICY_FLAG_IV_INO_LBLK_{64,32} with
+	 * a 4K crypto data unit, we must restrict the max filesize to what can
+	 * fit within U32_MAX + 1 data units.
+	 */
+
+	result = min(result, (((loff_t)U32_MAX + 1) * 4096) >> F2FS_BLKSIZE_BITS);
+
 	return result;
 }
 

base-commit: d346fa09abff46988de9267b67b6900d9913d5a2
-- 
2.43.0.rc2.451.g8631bc7472-goog

