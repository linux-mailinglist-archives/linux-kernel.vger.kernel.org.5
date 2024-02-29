Return-Path: <linux-kernel+bounces-86656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854D386C877
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A4228D124
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CCE7CF29;
	Thu, 29 Feb 2024 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="VYvhkL3J"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D527C6E0;
	Thu, 29 Feb 2024 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207430; cv=none; b=CoPbrbqNli2wzEPj19qbgf9f+/mqdhAHZH8/yjiA5crVzmQ4Qi+cumQAEqERUlHZ72kj2PYPpaRziUzN9QGCPWIjfJ7R8BKNRjZib+ieOx9IqgUN8nT/ayJvXfPZES4U0t9usgH4rag0Nyq6/v+C16mNeex2XbNzImEJWrRLAgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207430; c=relaxed/simple;
	bh=zHKJm2WVW+WwAV3mRJSQSc+kSvfzIHhT6BG2uC42T5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SGhU2XlwOtQJQYVMQF6HZCBxFFG7aqzwNvM30esWkup7/eG7FdPWNleX27A8DqDcBGefS4YLhUg8HzsM+s2W1ah/e5sUWwG5H/pwGu0IJJVzXJeRH0eNKdpIzG1CS/5is81xESSjV++gSw/WnReswl0dQJPuR5/Re0cd8lamT8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=VYvhkL3J; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709207421;
	bh=x+0nc01xdaOOxQkjy8kCF42KJK2qMmYg+0do84sBsXw=;
	h=From:To:Cc:Subject:Date:From;
	b=VYvhkL3Jm56fK/CvMOyFKfZ4D7k+7hWiGHJDfESphFJbtmEsfd/lq+SchAFZqiSfP
	 mr9ITa9qsfgb+zJb9wwe11KEmDNVIgns83xTRcsq51+zRsqDQVkHNpHwhoakybK6pv
	 vKBDq1vvGgbEhW+LX8s2DypL5VC5z6ORY9liNzoclC+ycGKZjhVoPpORAfOyzwF3Wo
	 O/Lz4LN/KI9qyHov8qUiv6CO+vrgBCGg7u5EVYGMGX0t5tByIxcvLNVmbeB7R58fW5
	 tc/vMwBl1IofFs9Q9P2iVtYaszlahQNfPZ9tt1dh6TvLSyPGR+dLTX2RHjS1esUsNs
	 eOpLFeZsjnPVQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TlqKR62hgz4wbh;
	Thu, 29 Feb 2024 22:50:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	deller@gmx.de
Cc: <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>,
	tzimmermann@suse.de
Subject: [PATCH] fbdev/mb862xxfb: Fix defined but not used error
Date: Thu, 29 Feb 2024 22:50:10 +1100
Message-ID: <20240229115010.748435-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

socrates_gc_mode is defined at the top-level but then only used inside
an #ifdef CONFIG_FB_MB862XX_LIME, leading to an error with some configs:

  drivers/video/fbdev/mb862xx/mb862xxfbdrv.c:36:31: error: ‘socrates_gc_mode’ defined but not used
     36 | static struct mb862xx_gc_mode socrates_gc_mode = {

Fix it by moving socrates_gc_mode inside that ifdef, immediately prior
to the only function where it's used.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
index 7c402e9fd7a9..baec312d7b33 100644
--- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
@@ -32,15 +32,6 @@
 #define CARMINE_MEM_SIZE	0x8000000
 #define DRV_NAME		"mb862xxfb"
 
-#if defined(CONFIG_SOCRATES)
-static struct mb862xx_gc_mode socrates_gc_mode = {
-	/* Mode for Prime View PM070WL4 TFT LCD Panel */
-	{ "800x480", 45, 800, 480, 40000, 86, 42, 33, 10, 128, 2, 0, 0, 0 },
-	/* 16 bits/pixel, 16MB, 133MHz, SDRAM memory mode value */
-	16, 0x1000000, GC_CCF_COT_133, 0x4157ba63
-};
-#endif
-
 /* Helpers */
 static inline int h_total(struct fb_var_screeninfo *var)
 {
@@ -666,6 +657,15 @@ static int mb862xx_gdc_init(struct mb862xxfb_par *par)
 	return 0;
 }
 
+#if defined(CONFIG_SOCRATES)
+static struct mb862xx_gc_mode socrates_gc_mode = {
+	/* Mode for Prime View PM070WL4 TFT LCD Panel */
+	{ "800x480", 45, 800, 480, 40000, 86, 42, 33, 10, 128, 2, 0, 0, 0 },
+	/* 16 bits/pixel, 16MB, 133MHz, SDRAM memory mode value */
+	16, 0x1000000, GC_CCF_COT_133, 0x4157ba63
+};
+#endif
+
 static int of_platform_mb862xx_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
-- 
2.43.2


