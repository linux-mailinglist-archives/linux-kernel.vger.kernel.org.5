Return-Path: <linux-kernel+bounces-36309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5EA839F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662A128CCA1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3B0469D;
	Wed, 24 Jan 2024 02:33:26 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325D17D2;
	Wed, 24 Jan 2024 02:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063605; cv=none; b=Cz/vpHR8IwOKgaGhpa+HzcdCcCLQ0BOYVy9yx/xvRTQv+8/IS340YyRUIzBCJjsZEgxQbp6RRcDQ8hSJpgLiM7xu242UoLiDKnoW7a/2eUFqr847YP3k6Az3Y6nyb1Y5jnLPT4pSXzwY5Y5aiG8eTKhHgd3ysNc2mRAAD9J/ie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063605; c=relaxed/simple;
	bh=Ag4z4OsYP+97hG1MIP2IUr0FcWfaENxt6PYc5zeDSz4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L/C1Wsp4znKJCzgv2BxsmG8hdZP2NYnxTSUBQ9FaKcK8p6ujXC3Z4ivP2KR00UTp3q3zjjdTHTRO0WXyBeSYOzmX1Y/Uu5WIBcF1WTcfyYYRZiu94ey4DDBxFgilfUOihFrfggiWfqC+t0ri4otC/CxWX4twBxOkBNULvt7JBFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 40O2VFcs080566;
	Wed, 24 Jan 2024 10:31:27 +0800 (GMT-8)
	(envelope-from hu.yadi@h3c.com)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (unknown [10.62.14.11])
	by mail.maildlp.com (Postfix) with ESMTP id 6B21C2004C48;
	Wed, 24 Jan 2024 10:36:06 +0800 (CST)
Received: from localhost.localdomain (10.99.206.12) by
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Wed, 24 Jan 2024 10:31:28 +0800
From: Hu Yadi <hu.yadi@h3c.com>
To: <jmorris@namei.org>, <serge@hallyn.com>, <shuah@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <mic@digikod.net>,
        <amir73il@gmail.com>, <brauner@kernel.org>, <avagin@google.com>
CC: <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <514118380@qq.com>,
        <konstantin.meskhidze@huawei.com>, "Hu.Yadi"
	<hu.yadi@h3c.com>
Subject: [PATCH] selftests/landlock:Fix fs_test build issues with old libc
Date: Wed, 24 Jan 2024 10:29:08 +0800
Message-ID: <20240124022908.42100-1-hu.yadi@h3c.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 40O2VFcs080566

From: "Hu.Yadi" <hu.yadi@h3c.com>

Fixes: 04f9070e99a4 ("selftests/landlock: Add tests for pseudo filesystems")

one issues comes up while building selftest/landlock on my side
(gcc 7.3/glibc-2.28/kernel-4.19)

gcc -Wall -O2 -isystem   fs_test.c -lcap -o selftests/landlock/fs_test
fs_test.c:4575:9: error: initializer element is not constant
  .mnt = mnt_tmp,
         ^~~~~~~

Signed-off-by: Hu.Yadi <hu.yadi@h3c.com>
Suggested-by: Jiao <jiaoxupo@h3c.com>
Reviewed-by: Berlin <berlin@h3c.com>
---
 tools/testing/selftests/landlock/fs_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 18e1f86a6234..1f2584b4dfce 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -40,6 +40,7 @@ int renameat2(int olddirfd, const char *oldpath, int newdirfd,

 #define TMP_DIR "tmp"
 #define BINARY_PATH "./true"
+#define MNT_TMP_DATA "size=4m,mode=700"

 /* Paths (sibling number and depth) */
 static const char dir_s1d1[] = TMP_DIR "/s1d1";
@@ -4572,7 +4573,10 @@ FIXTURE_VARIANT(layout3_fs)
 /* clang-format off */
 FIXTURE_VARIANT_ADD(layout3_fs, tmpfs) {
 	/* clang-format on */
-	.mnt = mnt_tmp,
+	.mnt = {
+		.type = "tmpfs",
+		.data = MNT_TMP_DATA,
+	},
 	.file_path = file1_s1d1,
 };

--
2.23.0


