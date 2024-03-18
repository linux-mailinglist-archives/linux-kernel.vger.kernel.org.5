Return-Path: <linux-kernel+bounces-105672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A345687E265
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4A9283C18
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D711E878;
	Mon, 18 Mar 2024 03:07:30 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A441C1C10;
	Mon, 18 Mar 2024 03:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710731249; cv=none; b=U6RVpYhqsgWNDd9+YDwXEQ2wnWYcNw2dNE9xN4Ba35PNo/Y6yvOGf2R/EgK1OLrwaukAHSz6lofNSUPIuC2aPIAyw7df+YJYwO3O73lnTgwl+rwU22kv0U1tdG4uEmagFuPEGqWUHSOzO7/nPXl1qwfpYcDai2wzI6IiOQM74sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710731249; c=relaxed/simple;
	bh=nyMgqHe9WbiQXU6wIKGTzXWY3Sm2I04U8zrDAQNZVlg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uCOV/kVIT3Kpp73uL7B3L7FtczT2zVls5/Y+4dhoW9aPMwK060ZTXeMb4D6bUu6dFRy0kGzzHMV5QPrY3OrSDjMIPBw738bnCQyFQvtn65XyWuxI5M5itCDLrZLH4/zT9OHEXobQWyMXWYvEGoQaBRoouYJJG1TA7GHTVrSrSKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 4886760280B58;
	Mon, 18 Mar 2024 11:07:14 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?blk-pm:=20Remove=20unnecessary=20=E2=80=980?= =?UTF-8?q?=E2=80=99=20values=20from=20ret?=
Date: Mon, 18 Mar 2024 11:07:07 +0800
Message-Id: <20240318030707.18198-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ret is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 block/blk-pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-pm.c b/block/blk-pm.c
index 42e8420747153..c76d5a3169417 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -58,10 +58,10 @@ EXPORT_SYMBOL(blk_pm_runtime_init);
  */
 int blk_pre_runtime_suspend(struct request_queue *q)
 {
-	int ret = 0;
+	int ret;
 
 	if (!q->dev)
-		return ret;
+		return 0;
 
 	WARN_ON_ONCE(q->rpm_status != RPM_ACTIVE);
 
-- 
2.18.2


