Return-Path: <linux-kernel+bounces-120078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EE488D147
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE34CB227F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBA913E059;
	Tue, 26 Mar 2024 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmbfHnWP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B451313D8B2;
	Tue, 26 Mar 2024 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492783; cv=none; b=qYuqV3xWW3HXGh34Nfm04xZaUGTPJdTls2k/x81fGWzdVUeHUvfO6aBpsl7Ryo9KF5wwUWQSs82ubWCW4dsY5NFv/OVjOSiilOIfSv9qFyu2E40XZ+GvatMfp6+nhlu0W3gLzcttyqdsQTRiznac/Y1ZHiNTTW88tB8vA+Hpecw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492783; c=relaxed/simple;
	bh=F1tdxK6zhURX1XJa26Hj4NTFjwVssRlwDIPa82U+7Bs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GXu9h8AZaPMalcE7gbRiN5vT29EMNfItd/n0SZrTrFq1q0D8822jtBIG7jibmmNVQRhD/uelmHQV25OWMIguVC7iqW1npZk4aQxCLUtfu5wfyg8lq1LUSvMhCWxTDhhYdBMnMWaeJW9D7+ru/IrDWIrNPSIHeNvZeBo2cfFdd9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmbfHnWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7F5C433C7;
	Tue, 26 Mar 2024 22:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711492783;
	bh=F1tdxK6zhURX1XJa26Hj4NTFjwVssRlwDIPa82U+7Bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tmbfHnWPYV61Wv5iJoz7qdwrUEHhqEB2TZlr+P4RRDVAYgR6Nr/hl2wuXKgNBL69l
	 T7Xxg4TYS4ANY2Ynz3yB2yl8CwY+YBN811GkOiH+8PnxmYpSj4YxykOrWs2v0PBxhH
	 KbDjYSxvhYF/hxF5hmZ/9vbIUKqV6GZlnmxDMeLWYHBeQaFo5zhuV4ufReW5oXHLRs
	 iSRCp7D4mUt9ukgZ4RHoZoQiHmTokGfajcZaKawN5oJ8Pq9+A56JIheUGJDhLLSAGR
	 xlMuJniJZpuZvgowiLjFneTAqJ7NlJVshD7RJjwSUGPuUfKKYOvyKZ/IwC6whf469l
	 MijLyYiwgnU5Q==
From: Arnd Bergmann <arnd@kernel.org>
To: llvm@lists.linux.dev,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Simon Horman <horms@kernel.org>,
	Konstantin Khorenko <khorenko@virtuozzo.com>,
	Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] qed: avoid truncating work queue length
Date: Tue, 26 Mar 2024 23:38:02 +0100
Message-Id: <20240326223825.4084412-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326223825.4084412-1-arnd@kernel.org>
References: <20240326223825.4084412-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang complains that the temporary string for the name passed into
alloc_workqueue() is too short for its contents:

drivers/net/ethernet/qlogic/qed/qed_main.c:1218:3: error: 'snprintf' will always be truncated; specified size is 16, but format string expands to at least 18 [-Werror,-Wformat-truncation]

There is no need for a temporary buffer, and the actual name of a workqueue
is 32 bytes (WQ_NAME_LEN), so just use the interface as intended to avoid
the truncation.

Fixes: 59ccf86fe69a ("qed: Add driver infrastucture for handling mfw requests.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/qlogic/qed/qed_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index c278f8893042..8159b4c315b5 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -1206,7 +1206,6 @@ static void qed_slowpath_task(struct work_struct *work)
 static int qed_slowpath_wq_start(struct qed_dev *cdev)
 {
 	struct qed_hwfn *hwfn;
-	char name[NAME_SIZE];
 	int i;
 
 	if (IS_VF(cdev))
@@ -1215,11 +1214,11 @@ static int qed_slowpath_wq_start(struct qed_dev *cdev)
 	for_each_hwfn(cdev, i) {
 		hwfn = &cdev->hwfns[i];
 
-		snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
-			 cdev->pdev->bus->number,
-			 PCI_SLOT(cdev->pdev->devfn), hwfn->abs_pf_id);
+		hwfn->slowpath_wq = alloc_workqueue("slowpath-%02x:%02x.%02x",
+					 0, 0, cdev->pdev->bus->number,
+					 PCI_SLOT(cdev->pdev->devfn),
+					 hwfn->abs_pf_id);
 
-		hwfn->slowpath_wq = alloc_workqueue(name, 0, 0);
 		if (!hwfn->slowpath_wq) {
 			DP_NOTICE(hwfn, "Cannot create slowpath workqueue\n");
 			return -ENOMEM;
-- 
2.39.2


