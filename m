Return-Path: <linux-kernel+bounces-34793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E6E838784
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B361C289145
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DADF50263;
	Tue, 23 Jan 2024 06:32:42 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6903611E;
	Tue, 23 Jan 2024 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991560; cv=none; b=bE1pqiFFozB5an/pcdhiPkrO3w+epYLnAtx8HyzMJv9cM3OgOc92/NYOpNagraaYd1uqiDIMg5B3RnJu3Dyg3ezIr8iamtGtEPeGh79A4AOak0g7eEGY9/Uv++GeflwkpeAga4g9qjp7fG0s83k0ApwQCmidPb3YAdBKTB9kfUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991560; c=relaxed/simple;
	bh=UB0JVtkwXrMLRZTn2mIH3m4UcL4y+gCZIzpUMshRf5g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zmx3OA8iX0w4zqORFkLw7TFyhyT9fRZc8RtdaCiUCk0uoIpiU9m4D3hV6HJjxo12IrG5KWS6MpNnlyY73NQRRXvBDbjCD9XY4hgHB4cg3Yc3TmuwkJM38P6ZUwthxeoRz9Gktf1DSyHfCoOArgbgF+HZdIjHhqXiScz1/ZLkYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 40N6TIvp065821;
	Tue, 23 Jan 2024 14:29:18 +0800 (GMT-8)
	(envelope-from hu.yadi@h3c.com)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (unknown [10.62.14.11])
	by mail.maildlp.com (Postfix) with ESMTP id 44C142004BC2;
	Tue, 23 Jan 2024 14:33:57 +0800 (CST)
Received: from localhost.localdomain (10.99.206.12) by
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Tue, 23 Jan 2024 14:29:20 +0800
From: Hu Yadi <hu.yadi@h3c.com>
To: <jmorris@namei.org>, <serge@hallyn.com>, <shuah@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <mic@digikod.net>,
        <amir73il@gmail.com>, <brauner@kernel.org>, <avagin@google.com>
CC: <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <514118380@qq.com>,
        <konstantin.meskhidze@huawei.com>, "Hu.Yadi"
	<hu.yadi@h3c.com>
Subject: [PATCH] selftests/landlock:Fix net_test build issues with old libc
Date: Tue, 23 Jan 2024 14:26:21 +0800
Message-ID: <20240123062621.25082-1-hu.yadi@h3c.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 40N6TIvp065821

From: "Hu.Yadi" <hu.yadi@h3c.com>

Fixes: a549d055a22e ("selftests/landlock: Add network tests")

one issues comes up while building selftest/landlock/net_test on my side
(gcc 7.3/glibc-2.28/kernel-4.19)

net_test.c: In function ‘set_service’:
net_test.c:91:45: warning: implicit declaration of function ‘gettid’; [-Wimplicit-function-declaration]
    "_selftests-landlock-net-tid%d-index%d", gettid(),
                                             ^~~~~~
                                             getgid
net_test.c:(.text+0x4e0): undefined reference to `gettid'

Signed-off-by: Hu Yadi <hu.yadi@h3c.com>
Suggested-by: Jiao <jiaoxupo@h3c.com>
Reviewed-by: Berlin <berlin@h3c.com>
---
 tools/testing/selftests/landlock/net_test.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 929e21c4db05..6cc1bb1a9166 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -18,9 +18,15 @@
 #include <sys/prctl.h>
 #include <sys/socket.h>
 #include <sys/un.h>
-
+#include <sys/syscall.h>
 #include "common.h"

+
+static pid_t sys_gettid(void)
+{
+	return syscall(__NR_gettid);
+}
+
 const short sock_port_start = (1 << 10);

 static const char loopback_ipv4[] = "127.0.0.1";
@@ -88,7 +94,7 @@ static int set_service(struct service_fixture *const srv,
 	case AF_UNIX:
 		srv->unix_addr.sun_family = prot.domain;
 		sprintf(srv->unix_addr.sun_path,
-			"_selftests-landlock-net-tid%d-index%d", gettid(),
+			"_selftests-landlock-net-tid%d-index%d", sys_gettid(),
 			index);
 		srv->unix_addr_len = SUN_LEN(&srv->unix_addr);
 		srv->unix_addr.sun_path[0] = '\0';
--
2.23.0


