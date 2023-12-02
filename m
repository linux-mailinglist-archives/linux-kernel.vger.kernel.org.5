Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3FC8018D6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441981AbjLBASU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbjLBASM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:18:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB6CD6C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:09:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E4BC433CC;
        Sat,  2 Dec 2023 00:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701475692;
        bh=dA3cXZTPwGuBFjfk7vBFspKqwxyw85dB6htp3+62oIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uXPiW5MbtvQcnrRYD9LYG6mn7RPYtIY3MPhQVnAIMhOAdgc6mI0apmxk5JCelCtZv
         6Ef9xyeOkzma+9AS+KiXQD8I/La8iDXltv9baKzkgE40yj4y6v44bDlF1mayazsOI3
         SZFeTh4Tmcj02tZnymikNK28FWnUE/o8TbsvA9jgSaCvsqcaXZZVQW4sGpyxYe9loS
         65NI2gsSjyWNLTNdcdhF48SDc0MkwKk/ahnphuUPocqrvxadSAe2Ob54OKR3XrkyhS
         WA+RUPrD1WxoIt4tCTJQpKbfR3p09U/4BYqfCsjWEzLdX8FSzD8WCxE124eZnpBkaY
         E1BPJj/Hl8xpA==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/5] selftests/damon/_damon: implement sysfs updat_schemes_tried_bytes command
Date:   Sat,  2 Dec 2023 00:08:04 +0000
Message-Id: <20231202000806.46210-4-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202000806.46210-1-sj@kernel.org>
References: <20231202000806.46210-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement update_schemes_tried_bytes command in the test-writing-purpose
DAMON sysfs interface wrapper Python module.  It is not only making the
update, but also read the updated value from the sysfs interface and
store on the Kdamond python objects so that user of the module can get
it by reading the field of the object.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/damon/_damon.py b/tools/testing/selftests/damon/_damon.py
index 6b99f87a5f1e..e98cf4b6a4b7 100644
--- a/tools/testing/selftests/damon/_damon.py
+++ b/tools/testing/selftests/damon/_damon.py
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

