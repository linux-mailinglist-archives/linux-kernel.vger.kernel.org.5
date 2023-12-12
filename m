Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E26380F728
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377308AbjLLTs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377286AbjLLTsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:48:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B68A6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:48:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E92EC433C7;
        Tue, 12 Dec 2023 19:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702410507;
        bh=KLuaGh8EwddqX7r2J8YW9fbCxq8vkVUE+TA3xcNvnkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zp604m9ftO6CMnttej87Sh6VqLpo04BjspyTqtAXT+YNv+UIX/RoNfTg/V8Y4/+v7
         7pXqEGOTc5Y6XxCRWrKt+/e3xzZGonBbtqWSI+WT0SWjfaWW2ZMItPC1+QK7sec6wv
         ij4Ozs5y4003odbvfBk1OpZbHUCDdHbapSaOe1TsKjrYpY0nfNqeDQ0dcJskywxToH
         jq83xtlZhvR3wpX4cTV0/8CsLQdBB7OZ37T0Su6s1GlBmDPBUibW7/EMVvdHNPt5Sx
         EQM2SVuASgPb4Vdu0AdQUPE4ZP/4x8RCpZC7vkdjuv108qv1TQtoo2Be1g9CKCsZMt
         2zScFDV0Pw8AA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] selftests/damon/_damon_sysfs: implement updat_schemes_tried_bytes command
Date:   Tue, 12 Dec 2023 19:48:08 +0000
Message-Id: <20231212194810.54457-4-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212194810.54457-1-sj@kernel.org>
References: <20231212194810.54457-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement update_schemes_tried_bytes command of DAMON sysfs interface in
_damon_sysfs.py.  It is not only making the update, but also read the
updated value from the sysfs interface and store it in the Kdamond
python objects so that the user of the module can easily get the value.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 6b99f87a5f1e..e98cf4b6a4b7 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -76,6 +76,7 @@ class Damos:
     # todo: Support quotas, watermarks, stats, tried_regions
     idx = None
     context = None
+    tried_bytes = None
 
     def __init__(self, action='stat', access_pattern=DamosAccessPattern()):
         self.action = action
@@ -284,6 +285,19 @@ class Kdamond:
         err = write_file(os.path.join(self.sysfs_dir(), 'state'), 'on')
         return err
 
+    def update_schemes_tried_bytes(self):
+        err = write_file(os.path.join(self.sysfs_dir(), 'state'),
+                'update_schemes_tried_bytes')
+        if err != None:
+            return err
+        for context in self.contexts:
+            for scheme in context.schemes:
+                content, err = read_file(os.path.join(scheme.sysfs_dir(),
+                    'tried_regions', 'total_bytes'))
+                if err != None:
+                    return err
+                scheme.tried_bytes = int(content)
+
 class Kdamonds:
     kdamonds = []
 
-- 
2.34.1

