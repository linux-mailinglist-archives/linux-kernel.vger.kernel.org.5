Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF6376C5FA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjHBG6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjHBG62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:58:28 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81069E71
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:58:26 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RG2pn40wPz1GDGG;
        Wed,  2 Aug 2023 14:57:21 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 14:58:23 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next] efs: fix -Wunused-const-variable= warning
Date:   Wed, 2 Aug 2023 14:57:53 +0800
Message-ID: <20230802065753.217179-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1, the following warning occurs.

In file included from fs/efs/super.c:18:0:
fs/efs/efs.h:22:19: warning: ‘cprt’ defined but not used [-Wunused-const-variable=]
 static const char cprt[] = "EFS: "EFS_VERSION" - (c) 1999 Al Smith
<Al.Smith@aeschi.ch.eu.org>";
                   ^~~~
The header file is included in many C files, there are many
similar errors which are not included here. We add __maybe_unsed
to remove it.

Fixes: 45254b4fb2ae ("efs: move headers out of include/linux/")
Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 fs/efs/efs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/efs/efs.h b/fs/efs/efs.h
index 13a4d9622633..8202be1b2ade 100644
--- a/fs/efs/efs.h
+++ b/fs/efs/efs.h
@@ -19,7 +19,8 @@
 
 #define EFS_VERSION "1.0a"
 
-static const char cprt[] = "EFS: "EFS_VERSION" - (c) 1999 Al Smith <Al.Smith@aeschi.ch.eu.org>";
+static const char __maybe_unused cprt[] =
+	"EFS: "EFS_VERSION" - (c) 1999 Al Smith <Al.Smith@aeschi.ch.eu.org>";
 
 
 /* 1 block is 512 bytes */
-- 
2.17.1

