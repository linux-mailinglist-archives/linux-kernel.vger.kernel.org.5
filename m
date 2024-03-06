Return-Path: <linux-kernel+bounces-94300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79928873CC0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AAF1C2135F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AB5138489;
	Wed,  6 Mar 2024 16:58:54 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF648137921;
	Wed,  6 Mar 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744334; cv=none; b=ptBuisbqV/7qXksl4NT6JAL53bceai+wfjT+6xL80YKMlBe5tKzVtR/EMuvIgIaCJNX+YIUUmjehm2SaExzuVNJGXUUguLsAMW24hCoJibLlT2NC2Z4uLqud+Cgfuzag8JHNPCUjl+UwgeTMEnH1ywdZpsmJwkrNET5zZGl31KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744334; c=relaxed/simple;
	bh=7pWHKj0hmElwO8enpNR235mzFnRo0EL0Vrh5GHTv+t8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2J2ZXgZCMETuNXatZ19mrtlTuqKEpzkd58KneAFNtvBtPjIOfOvebYXVtswBH6oVvGbGlevdUvAy1gOt7l7DaAJSm3CDP/6NARHZpwQn4kjnPdo709PMAWBbIj3ufF3vviIs5RCXpymin7beDmjitLmGzXbxt5tjCaltbZSJnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Mike Gilbert <floppym@gentoo.org>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: 
Date: Wed,  6 Mar 2024 11:58:43 -0500
Message-ID: <20240306165848.3843339-1-floppym@gentoo.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: [PATCH] sparc: move struct termio to asm/termios.h

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


