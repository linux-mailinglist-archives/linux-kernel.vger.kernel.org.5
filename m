Return-Path: <linux-kernel+bounces-25652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C5682D41C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910972817DB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9E03C3B;
	Mon, 15 Jan 2024 06:11:50 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2D3D53C0E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id F261D602521A5;
	Mon, 15 Jan 2024 14:11:33 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li kunyu <kunyu@nfschina.com>
To: linux-kernel@vger.kernel.org
Cc: Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] utsname: Optimize clone_uts_ns()
Date: Mon, 15 Jan 2024 14:11:27 +0800
Message-Id: <20240115061127.30836-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Optimize the err variable assignment location so that the err variable
is manually modified when an error occurs.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 kernel/utsname.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/utsname.c b/kernel/utsname.c
index b1ac3ca870f24..f55568e00927c 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -49,15 +49,17 @@ static struct uts_namespace *clone_uts_ns(struct user_namespace *user_ns,
 	struct ucounts *ucounts;
 	int err;
 
-	err = -ENOSPC;
 	ucounts = inc_uts_namespaces(user_ns);
-	if (!ucounts)
+	if (!ucounts) {
+		err = -ENOSPC;
 		goto fail;
+	}
 
-	err = -ENOMEM;
 	ns = create_uts_ns();
-	if (!ns)
+	if (!ns) {
+		err = -ENOMEM;
 		goto fail_dec;
+	}
 
 	err = ns_alloc_inum(&ns->ns);
 	if (err)
-- 
2.18.2


