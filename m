Return-Path: <linux-kernel+bounces-2941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 844E0816505
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17582B21EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFB76ADF;
	Mon, 18 Dec 2023 02:45:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D89263BA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3BI2iYgH059906;
	Mon, 18 Dec 2023 10:44:34 +0800 (+08)
	(envelope-from Chunyan.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4StkXG6kQ4z2PhV8G;
	Mon, 18 Dec 2023 10:38:22 +0800 (CST)
Received: from ubt.spreadtrum.com (10.0.73.88) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 18 Dec
 2023 10:44:32 +0800
From: Chunyan Zhang <chunyan.zhang@unisoc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki"
	<rafael@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Jing Xia <jing.xia@unisoc.com>,
        Jing
 Xia <jing.xia.mail@gmail.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, Ke Wang
	<ke.wang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] class: fix use-after-free in class_register()
Date: Mon, 18 Dec 2023 10:44:03 +0800
Message-ID: <20231218024403.1076134-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 3BI2iYgH059906

From: Jing Xia <jing.xia@unisoc.com>

The lock_class_key is still registered and can be found in
lock_keys_hash hlist after subsys_private is freed in error
handler path.A task who iterate over the lock_keys_hash
later may cause use-after-free.So fix that up and unregister
the lock_class_key before kfree(cp).

Signed-off-by: Jing Xia <jing.xia@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 drivers/base/class.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 7e78aee0fd6c..7b38fdf8e1d7 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -213,6 +213,7 @@ int class_register(const struct class *cls)
 	return 0;
 
 err_out:
+	lockdep_unregister_key(key);
 	kfree(cp);
 	return error;
 }
-- 
2.25.1


