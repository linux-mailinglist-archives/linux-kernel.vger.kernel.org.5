Return-Path: <linux-kernel+bounces-94315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5358F873D01
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E699F1F23F18
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2CE13B794;
	Wed,  6 Mar 2024 17:11:55 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6646A13BAC6;
	Wed,  6 Mar 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709745115; cv=none; b=lvmgyf9iOGS4XLwHaNrFlw0afVKrGmLNR5nuRHBnAREg2g/J7iisZF+LFmLJKw9occWpuI6pl2YF2bFib1iYDZYUYXIoBwMVyJO/L+K8+q8X0fjQWVXuO7UA6JHh/JLhSt8Mt1YSSIOF8vUOUe/bcYx1Mnp1J0RwjM3ADuPATKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709745115; c=relaxed/simple;
	bh=PMy2Vo7jx6LV3SSY6p3haKD9pKM2+dPz+OS364W64Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e00qSxK1WmjYGZNwlGxNfEJCmV9f6OdlBVOOmtYI9zmh6ACCn8uCGcUMfro6h89Ib7bQolpfbJ/RBmvYJgbICjsqSQGlTHWA1TnLe6oUj3BHP6uF7BofkvCAePe+K75v5UOvscxbN1ZpHI9kSDMwykC/phuFrsreDgDxxTapDaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Mike Gilbert <floppym@gentoo.org>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mike Gilbert <floppym@gentoo.org>
Subject: [PATCH] sparc: move struct termio to asm/termios.h
Date: Wed,  6 Mar 2024 12:11:47 -0500
Message-ID: <20240306171149.3843481-1-floppym@gentoo.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every other arch declares struct termio in asm/termios.h, so make sparc
match them.

Resolves a build failure in the PPP software package, which includes
both bits/ioctl-types.h via sys/ioctl.h (glibc) and asm/termbits.h.

Closes: https://bugs.gentoo.org/918992
Signed-off-by: Mike Gilbert <floppym@gentoo.org>
Cc: stable@vger.kernel.org
---
 arch/sparc/include/uapi/asm/termbits.h | 10 ----------
 arch/sparc/include/uapi/asm/termios.h  |  9 +++++++++
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/termbits.h b/arch/sparc/include/uapi/asm/termbits.h
index 4321322701fc..0da2b1adc0f5 100644
--- a/arch/sparc/include/uapi/asm/termbits.h
+++ b/arch/sparc/include/uapi/asm/termbits.h
@@ -10,16 +10,6 @@ typedef unsigned int	tcflag_t;
 typedef unsigned long	tcflag_t;
 #endif
 
-#define NCC 8
-struct termio {
-	unsigned short c_iflag;		/* input mode flags */
-	unsigned short c_oflag;		/* output mode flags */
-	unsigned short c_cflag;		/* control mode flags */
-	unsigned short c_lflag;		/* local mode flags */
-	unsigned char c_line;		/* line discipline */
-	unsigned char c_cc[NCC];	/* control characters */
-};
-
 #define NCCS 17
 struct termios {
 	tcflag_t c_iflag;		/* input mode flags */
diff --git a/arch/sparc/include/uapi/asm/termios.h b/arch/sparc/include/uapi/asm/termios.h
index ee86f4093d83..cceb32260881 100644
--- a/arch/sparc/include/uapi/asm/termios.h
+++ b/arch/sparc/include/uapi/asm/termios.h
@@ -40,5 +40,14 @@ struct winsize {
 	unsigned short ws_ypixel;
 };
 
+#define NCC 8
+struct termio {
+	unsigned short c_iflag;		/* input mode flags */
+	unsigned short c_oflag;		/* output mode flags */
+	unsigned short c_cflag;		/* control mode flags */
+	unsigned short c_lflag;		/* local mode flags */
+	unsigned char c_line;		/* line discipline */
+	unsigned char c_cc[NCC];	/* control characters */
+};
 
 #endif /* _UAPI_SPARC_TERMIOS_H */
-- 
2.44.0


