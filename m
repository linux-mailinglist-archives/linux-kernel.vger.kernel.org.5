Return-Path: <linux-kernel+bounces-64414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6069F853E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4D5293C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17498629F1;
	Tue, 13 Feb 2024 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="YX/tgL5l"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB7626CD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861785; cv=none; b=h+6eaHJN4MPzAqasbfYf2zYBp+qy+aWW9qhK6Ar104qMlLL2miBi7Axt85Y/1QzSA4r6+yB2QJFZ0dxjmHYJT+C1/yu2eVwbbCwzykqaCDibjXXsxmweU7aHJs9t2Wep3Pu2RIuoExEXZBxj2F7xOxd0G14ry4LiLQbr58rBtnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861785; c=relaxed/simple;
	bh=hpce4kBYHxjPck6QzyV4av0S8wG/q4mb39UZeFb/XX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiyR0FrojhOY/VAricbQsnlcfPbOrKElpwSvnjlppHn5ZqnCe45S0GUivQWsvN4xDJOxQ9m6c117nIL5ENt5qNYUGHVpgNm8716zezhDldTqxYNXHK6WuXzTeJCMSDIEpMMA2w39DZL4iJavPBEgtP7CLb7v7Dt5wGlJxFwomPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=YX/tgL5l; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=vQkmh2vsmn/J5N6MTBGNu3z1ML3BmhRPZQnF3hlOJK8=; b=YX/tgL
	5lBgJPY5mdMuLXoO63/NGZ37Juv2wLBIefaQQn5QDEBirDYbGJK9CxEz6Xqb+U44
	BWtLABjp32jfNL0F5X/5+G6QjvsV06Eb2gN2vJeethhw85FxHu9+x0Zt+lUt+hvq
	uz73krUF/tM2Y14jT2BC85Euf1H+XQlbXubcIz3vJQkB5dSrFlZe8/P0ly7nyJa/
	0nz6akXlyWmr23xeqGjUMa4pR1A1B1HKzZDtDdkM6HRmhd6woNGm7+Rn/nBFARH1
	tL949dnqGXF1xrx7LjZ9dai8GrL0F/s/UmHthpxcGAC7RvJKYDjuVm2PxOPPL4MG
	vBcrrtr6u6eNesTg==
Received: (qmail 1211785 invoked from network); 13 Feb 2024 23:02:52 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Feb 2024 23:02:52 +0100
X-UD-Smtp-Session: l3s3148p1@g45CjkoRyt8ujnsZ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] mfd: tmio: Remove obsolete io accessors
Date: Tue, 13 Feb 2024 23:02:21 +0100
Message-ID: <20240213220221.2380-10-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213220221.2380-8-wsa+renesas@sang-engineering.com>
References: <20240213220221.2380-8-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 568494db6809 ("mtd: remove tmio_nand driver") and commit
aceae7848624 ("fbdev: remove tmiofb driver"), these accessors have no
users anymore. Remove them.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Lee Jones <lee@kernel.org>
---
 include/linux/mfd/tmio.h | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index bc53323293a3..4223315d2b2a 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -10,31 +10,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
-#define tmio_ioread8(addr) readb(addr)
-#define tmio_ioread16(addr) readw(addr)
-#define tmio_ioread16_rep(r, b, l) readsw(r, b, l)
-#define tmio_ioread32(addr) \
-	(((u32)readw((addr))) | (((u32)readw((addr) + 2)) << 16))
-
-#define tmio_iowrite8(val, addr) writeb((val), (addr))
-#define tmio_iowrite16(val, addr) writew((val), (addr))
-#define tmio_iowrite16_rep(r, b, l) writesw(r, b, l)
-#define tmio_iowrite32(val, addr) \
-	do { \
-		writew((val),       (addr)); \
-		writew((val) >> 16, (addr) + 2); \
-	} while (0)
-
-#define sd_config_write8(base, shift, reg, val) \
-	tmio_iowrite8((val), (base) + ((reg) << (shift)))
-#define sd_config_write16(base, shift, reg, val) \
-	tmio_iowrite16((val), (base) + ((reg) << (shift)))
-#define sd_config_write32(base, shift, reg, val) \
-	do { \
-		tmio_iowrite16((val), (base) + ((reg) << (shift)));   \
-		tmio_iowrite16((val) >> 16, (base) + ((reg + 2) << (shift))); \
-	} while (0)
-
 /* tmio MMC platform flags */
 /*
  * Some controllers can support a 2-byte block size when the bus width
-- 
2.43.0


