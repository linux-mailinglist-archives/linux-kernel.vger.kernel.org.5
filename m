Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EF07CE78B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjJRTSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjJRTSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:18:49 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422F9114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:18:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b709048f32so3999545b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697656726; x=1698261526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YSRxwtKFFtcmGHGcUlV8tfK7rLoJNDdNW6F+5SQx19s=;
        b=SLpSsiiE6PtUP+2zYEQ+zJB5vLxDlP2/hioxa3X9uaBBN1h0bRJuvZ5BIysDhkzFg/
         bgrmjR8GAKoYRgCXLxO3vPQwk2oVICNOEtEs/HX/xzFEUUpEcAktUhixRku3M7vKqJyP
         PeApQqLpMoavgVTjBzTadEQuah4nCZo/LXSTTl4oNOE3fn/MUudTsAvKiyOf72TS/Tv6
         /c+fIqlfpjsniP4tipvktCzQ5h4UbeWGi/jbxrFJps1NYmTy5UDzmfOrIuxcs8sQ7/fA
         KtWWoRSo8VVWiJchV1uTbXJVQk6JTUi+TiSSOLwDfId5MsQVwfBDUuceJCtuALvbZNUP
         rwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697656726; x=1698261526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSRxwtKFFtcmGHGcUlV8tfK7rLoJNDdNW6F+5SQx19s=;
        b=qTo3hEi+rkXfaacdRihASFd5dT/wUtA1J7Y8MWhTMZkwy8DKxEe2K23S4vJBzJFMgu
         UXrs97nxMRa0BDYPwF7eBSi091diQn3vEsjLeNUHUptdvtTEPowTk+okHjtGOBfTo4RD
         hwWKF5dz+UkWdjjEXhbe0c0kr5+YqfrZ6xmdG8xc5LZDV5xEr2Un09Zpln9G1ZKG66SO
         A4ANkUNWxYbQTJExDtn0DEMUALFLxKHYJM5KOr+i0bK/xMmnKPKZ96gUiSylQR+NhJKd
         9/8tCJZUbiPZOFVfkNcCJEMmSu9aKcuGeiV1GuUoSla35vFLrA5MaWxTdS91j6X2wrYR
         k+SQ==
X-Gm-Message-State: AOJu0YwMc48uuMrG88GsvFhqJqCLY5eKhTZlHY4/IUbDe0NnJ0N4kgeE
        H5Yr8ZKoTNBSwHOjCxCuz1OJu2FW2Uey3qxD
X-Google-Smtp-Source: AGHT+IEuBjjA1TB9p+S3pBa+Q9PpWrpRJ2cQu7LEZU0k6LLFb0Qhf3388S7X2v5ELENyNSTR3U6Yuw==
X-Received: by 2002:a05:6a00:21c7:b0:68e:399e:70db with SMTP id t7-20020a056a0021c700b0068e399e70dbmr34377pfj.6.1697656725619;
        Wed, 18 Oct 2023 12:18:45 -0700 (PDT)
Received: from localhost.localdomain ([43.129.178.187])
        by smtp.gmail.com with ESMTPSA id x17-20020aa79411000000b00690d4464b95sm3808100pfo.16.2023.10.18.12.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 12:18:45 -0700 (PDT)
From:   Jia Rui <jindui71@gmail.com>
To:     mark@fasheh.com
Cc:     jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jia Rui <jindui71@gmail.com>
Subject: [PATCH] ocfs2: replace BUG_ON() at ocfs2_num_free_extents() with ocfs2_error()
Date:   Thu, 19 Oct 2023 03:18:11 +0800
Message-Id: <20231018191811.412458-1-jindui71@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BUG_ON() at ocfs2_num_free_extents() handles the error that
l_tree_deepth of leaf extent block just read form disk is invalid.
This error is mostly caused by file system metadata corruption on
the disk. There is no need to call BUG_ON() to handle such errors.
We can return error code, since the caller can deal with errors
from ocfs2_num_free_extents(). Also, we should make the file
system read-only to avoid the damage from expanding.

Therefore, BUG_ON() is removed and ocfs2_error() is called instead.

Signed-off-by: Jia Rui <jindui71@gmail.com>
---
 fs/ocfs2/alloc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index aef58f1395c8..d6bcf00f6843 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -967,7 +967,14 @@ int ocfs2_num_free_extents(struct ocfs2_extent_tree *et)
 		el = &eb->h_list;
 	}
 
-	BUG_ON(el->l_tree_depth != 0);
+	if (el->l_tree_depth != 0) {
+		retval = ocfs2_error(ocfs2_metadata_cache_get_super(et->et_ci),
+				"Owner %llu has leaf extent block %llu with an invalid l_tree_depth of %u\n",
+				(unsigned long long)ocfs2_metadata_cache_owner(et->et_ci),
+				(unsigned long long)last_eb_blk,
+				le16_to_cpu(el->l_tree_depth));
+		goto bail;
+	}
 
 	retval = le16_to_cpu(el->l_count) - le16_to_cpu(el->l_next_free_rec);
 bail:
-- 
2.25.1

