Return-Path: <linux-kernel+bounces-17744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 061B48251E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9991C21AED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF96D250F9;
	Fri,  5 Jan 2024 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qkKuJGrV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A271250E9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 10:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D854C433C8;
	Fri,  5 Jan 2024 10:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704450414;
	bh=In4idDpSGy2rHfbF3CvZPnLiRDq4Xmq3P7L4d+F3SbY=;
	h=From:To:Cc:Subject:Date:From;
	b=qkKuJGrV4z7gBf+9dGxHPFRAnYA8qo8Vtg3prb4nyJOCxDP7Yd+r4qsmFscZsCIdp
	 K/29k+AQEDP7+XHHKoxxjTWTQvK7wF6d6H7dEfbO3r92QVYYmiO2/bk8mylTxR01IN
	 oEFlUh3RY1EBKrrq3mwC40ykZ7BwlF43erYsghnI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: cpu: make cpu_subsys const
Date: Fri,  5 Jan 2024 11:26:48 +0100
Message-ID: <2024010548-crane-snooze-a871@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 39
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=In4idDpSGy2rHfbF3CvZPnLiRDq4Xmq3P7L4d+F3SbY=; b=owGbwMvMwCRo6H6F97bub03G02pJDKnTb2Zc+vmgslCotcptksdygdOd1h6M3z7yJP1cIp1vX 3yoSVCsI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACbSd4FhfnnmQudLG+dtq49I Tg0r3zlL5sb2ZobZLFzWHpVvOWbtfuRSW70zs9Dq6EJ7AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move the cpu_subsys variable to be a constant structure as well, placing
it into read-only memory which can not be modified at runtime.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/cpu.c  | 2 +-
 include/linux/cpu.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 82b6a76125f5..c3c15adb7da9 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -366,7 +366,7 @@ static int cpu_uevent(const struct device *dev, struct kobj_uevent_env *env)
 }
 #endif
 
-struct bus_type cpu_subsys = {
+const struct bus_type cpu_subsys = {
 	.name = "cpu",
 	.dev_name = "cpu",
 	.match = cpu_subsys_match,
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index dcb89c987164..0b993a140946 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -128,7 +128,7 @@ static inline void cpu_maps_update_done(void)
 static inline int add_cpu(unsigned int cpu) { return 0;}
 
 #endif /* CONFIG_SMP */
-extern struct bus_type cpu_subsys;
+extern const struct bus_type cpu_subsys;
 
 extern int lockdep_is_cpus_held(void);
 
-- 
2.43.0


