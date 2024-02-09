Return-Path: <linux-kernel+bounces-58927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4C984EEB6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1EE1C245FC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049B563A9;
	Fri,  9 Feb 2024 01:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="h4uP91W1"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782374C9B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707443937; cv=none; b=F1g4j/bOKEbKoOu/1sA27r95OXNQ4fjGSTWjJ4wgTAlzSc0CIyaC7kR3AsgxSsL7sDdEd4oP9dwKcON8HD25MrzRz9hrc//PGf1bBq3zbl2SKNT9iJS6Fy0+QmedPHPBpKcoem8sh+dGqLZWbqwrUibhAceg7DrHL9PTeOE5PlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707443937; c=relaxed/simple;
	bh=tx1y8XIKZpKJJSnn8pZsRsa5tD0WChElb9EzS5FTCLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/tI92uNTv6PLFMwvWOyc03sSf8ucjuSqlWfWd+XNhUzgWRmEO9qe0J4IFyhfEFDV2yyoDvPTCwyCWuC98xSH9qEdRqgAZDlcpDuj7Jbjcw3wTn8zs+t1YbaQXNtltgUUQhgvNKOVhh7oa6Y5yseIN/GCXurpe76VaeB01E0E50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=h4uP91W1; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=GdRahbPRK6CXKlo5juA9L5bxxYgoIlufylxqn5g6A/o=; b=h4uP91
	W1EEyi79vNV8J69KBbbBbu36JmCGt4KuTHJX+6eKDo1A7CHTbih2zhb6/cMRKWCx
	XYcvjEr573QjqAkP4CLFedwTolmnPIauC3uKrY5NMbTFF+chw///fgT1nffeJ9Fs
	zrAV1It6ZH0YtyvwSnJdYH7o9pTDD3rjbCMI5NucMr6bjrYdDOLfn4KKbUu5Gpd8
	LbPSvhuuuQN8O6mSbowAZmUFaukHETzSrlpGZf2R0WeuqOe+3wEHoBm3phjjgLWL
	SIsHxnPPan+TEHh9GcZR2cBPiClCk7AO2kENZRkIOMBoZpIRSIor8ILkSlDZVyPV
	fBvMfKa9O27v7EdA==
Received: (qmail 2792329 invoked from network); 9 Feb 2024 02:58:45 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Feb 2024 02:58:45 +0100
X-UD-Smtp-Session: l3s3148p1@5vSoROkQhLMujnsZ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] mfd: tmio: remove obsolete io accessors
Date: Fri,  9 Feb 2024 02:58:17 +0100
Message-ID: <20240209015817.14627-10-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
References: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
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


