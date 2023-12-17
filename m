Return-Path: <linux-kernel+bounces-2514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AE9815E4E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 10:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1502AB220E7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 09:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AF35668;
	Sun, 17 Dec 2023 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="D/WZjZHR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292453C16
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id En1qrv0j2VbkuEn1rrXCqJ; Sun, 17 Dec 2023 10:01:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702803706;
	bh=63aio74ELKT1uUEAVdiZLSilXdr/14V0hT/e6WkdVcc=;
	h=From:To:Cc:Subject:Date;
	b=D/WZjZHR/ZFs86Xjnq0fLW7hnkiyAtRJPcFacZxIwfpGg2NoABPXaTG4pWCsgrUje
	 MS0p3aGJ8V8gxSLGVuHlUdt2XGSq1KlbWMguUDocFBGSe5ozu2LUQ7sP/5Nhl7Us/U
	 njMX7qO7w/9lEpRmz/NkfT/vXTTRPqfb4TkYq2ThLour4plxm9lClz3JrTLzs49ET/
	 OFSR2XrfpSYriR5JP00PBvxRetv3eFzoaoKVdOCKkcJmYXKMnvUNYZwPEv+DAevSDs
	 yPUKLnX+9m++Qw669t0I8jFpWaFH5UlN5Brt7i6yYNOZAiq7NQ3ALzoLIyqCVwz/Ru
	 4dMbgmVx7t98w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 Dec 2023 10:01:46 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] x86/callthunks: Fix some potential string truncation in callthunks_debugfs_init()
Date: Sun, 17 Dec 2023 10:01:41 +0100
Message-Id: <8c2b24df3c077e55b2a4d91a7ffd08fa48e28d0a.1702803679.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When compiled with W=1, we get:
  arch/x86/kernel/callthunks.c: In function ‘callthunks_debugfs_init’:
  arch/x86/kernel/callthunks.c:394:35: error: ‘%lu’ directive writing between 1 and 10 bytes into a region of size 7 [-Werror=format-overflow=]
    394 |                 sprintf(name, "cpu%lu", cpu);
        |                                   ^~~
  arch/x86/kernel/callthunks.c:394:31: note: directive argument in the range [0, 4294967294]
    394 |                 sprintf(name, "cpu%lu", cpu);
        |                               ^~~~~~~~
  arch/x86/kernel/callthunks.c:394:17: note: ‘sprintf’ output between 5 and 14 bytes into a destination of size 10
    394 |                 sprintf(name, "cpu%lu", cpu);
        |

So, give some more space to 'name' to silence the warning. (and fix the
issue should a lucky one have a config with so many CPU!)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/x86/kernel/callthunks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index cf7e5be1b844..26182a7d12b3 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -388,7 +388,7 @@ static int __init callthunks_debugfs_init(void)
 	dir = debugfs_create_dir("callthunks", NULL);
 	for_each_possible_cpu(cpu) {
 		void *arg = (void *)cpu;
-		char name [10];
+		char name[14];
 
 		sprintf(name, "cpu%lu", cpu);
 		debugfs_create_file(name, 0644, dir, arg, &dfs_ops);
-- 
2.34.1


