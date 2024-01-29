Return-Path: <linux-kernel+bounces-42867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043A58407F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978F21F21D58
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA9165BC7;
	Mon, 29 Jan 2024 14:15:46 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A820D65BA7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537746; cv=none; b=pq5DRz2rjN3jJQbJIVtGb55oIK/k/qoNVQ4WCsJRja+DTT2rBe8SklvSa/ymrBrjBDE+TJORCUylPkna54BylaeJO+cW9n3KKr7ptjDyyuhlGOoPeVJWgBpCShBTQxmVYGisjEr5f5LSBw77Txkhgtz4mQQUaMBHIeSZPQ7wPu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537746; c=relaxed/simple;
	bh=t2kPYJ7pezKsYGsHLmpMN2up6sNljv6a0crp2CwK1j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ny/Cha+7dUvuLSLt0ZY79w8O6gX9FQxl7vWdMKfpUH/aj0hxUxSqunVDnnq1s5JSbP7tG9nEVUjjmh4BOfy6d7xTu099Wv26Mqgh8MYksuFxH3/hW2VPR06leWWEjicw4wToeUmMtXC/s9KJiOqqLY2CdHjqFozXoJ35t+uwAO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from localhost.localdomain
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Mon, 29 Jan 2024 14:15:35 +0000
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org,
	Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH 2/4] tools/nolibc: Fix strlcat() return code and size usage
Date: Mon, 29 Jan 2024 15:15:14 +0100
Message-ID: <20240129141516.198636-3-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
References: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return code should always be strlen(src) + strlen(dst), but dst is
considered shorter if size is less than strlen(dst).

While we are there, make sure to copy at most size-1 bytes and
null-terminate the dst buffer.

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
---
 tools/include/nolibc/string.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index ed15c22b1b2a..b2149e1342a8 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -187,23 +187,23 @@ char *strndup(const char *str, size_t maxlen)
 static __attribute__((unused))
 size_t strlcat(char *dst, const char *src, size_t size)
 {
-	size_t len;
 	char c;
+	size_t len = strlen(dst);
+	size_t ret = strlen(src) + (size < len? size: len);
 
-	for (len = 0; dst[len];	len++)
-		;
-
-	for (;;) {
+	for (;len < size;) {
 		c = *src;
-		if (len < size)
+		if (len < size - 1)
 			dst[len] = c;
+		if (len == size - 1)
+			dst[len] = '\0';
 		if (!c)
 			break;
 		len++;
 		src++;
 	}
 
-	return len;
+	return ret;
 }
 
 static __attribute__((unused))
-- 
2.43.0


