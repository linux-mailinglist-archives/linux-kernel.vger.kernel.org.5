Return-Path: <linux-kernel+bounces-70560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 781FC859929
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34361281C90
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4827E7429E;
	Sun, 18 Feb 2024 19:51:39 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86EB73176
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708285898; cv=none; b=ivEvE3lZ4UFPSWFV6lNRzfstBkdGODtr77roOmJ6KP41fujFOqPYoju23pVYlgxcJediYfRh78680FLhsIDO8If8TxZtgfQzmaUQLHP9xpr++BDvKFRrLWCqPjjQS6393zYPdBirb83pjmCC+/ic1YXIWEi23XTR3zrsqMU6/FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708285898; c=relaxed/simple;
	bh=it0xpWdUNAJBa027kuEXaW7NIG4qOxDWBerpqeL8YXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1yxVmrIBp9M2ESTNr5NSQbT27V2L2LqCykpybLCYHTrXRHu4dl5lSKKhkUAGUk558LLGTr3LDLTrV9V+blqp6ciO31VIkq597N5Gb+nv+KfjkgNk7yfAM9PIE9PVe5KbBsgvoG984VErkhVvGT5pZ4pN1bpDK1uwrEwWQwDFEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from lindsay.fibertel.com.ar
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Sun, 18 Feb 2024 19:51:35 +0000
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org,
	Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH v3 3/4] tools/nolibc: Fix strlcpy() return code and size usage
Date: Sun, 18 Feb 2024 16:51:05 -0300
Message-ID: <20240218195110.1386840-4-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240218195110.1386840-1-rodrigo@sdfg.com.ar>
References: <20240218195110.1386840-1-rodrigo@sdfg.com.ar>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return code should always be strlen(src), and we should copy at most
size-1 bytes.

While we are there, make sure to null-terminate the dst buffer if we
copied something.

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
---
 tools/include/nolibc/string.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index cc51fd6b63d0..565230a4ad47 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -219,16 +219,18 @@ static __attribute__((unused))
 size_t strlcpy(char *dst, const char *src, size_t size)
 {
 	size_t len;
-	char c;
 
-	for (len = 0;;) {
-		c = src[len];
-		if (len < size)
-			dst[len] = c;
-		if (!c)
-			break;
-		len++;
+	for (len = 0; len < size; len++) {
+		dst[len] = src[len];
+		if (!dst[len])
+			return len;
 	}
+	if (size)
+		dst[size-1] = '\0';
+
+	while (src[len])
+		len++;
+
 	return len;
 }
 
-- 
2.43.0


