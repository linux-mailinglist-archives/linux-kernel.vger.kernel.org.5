Return-Path: <linux-kernel+bounces-157926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 059578B18BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861711F24C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECBE10A16;
	Thu, 25 Apr 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk0Kd28s"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C0D101D4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714010431; cv=none; b=MvdQCemSqTuEQ3UBfXEuLyfxtI3aJB1JeeD4k1Y6DsmaqqtvpiyC8TJBOzaXMyo1f/tgpPeJBePkrxEvUdr6yKxtdV6WrUQ1pnPjY/oIUd2lLIEzeELTzLvpYBYbYheQ3RIOkc3+YkpyE06j/d79j+fvzUF6Jb23g8yL2fIvm1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714010431; c=relaxed/simple;
	bh=u2ACMwnzEzXhDYZsafzJwTREA+87ZRtPcXNjed9WdZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mdm9wnDBk92wOLx4H8jJPd/QwAqagtvQ4T5yMBiOI0dsw89SxMQOKlEQ+bYNVm7n7URAaRDp5HgD78QmJkFhRZGLrr5q06oCbTIjhAO7jNJveDOHq51Z/1WVGXURLC211xTj7x5u2hEEJvvxNmp71LUzhWVCJehibF/V3oGnlXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jk0Kd28s; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3f17c6491so3940355ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 19:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714010430; x=1714615230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2G0+Wm78u1m1Y1Ar32t4xbeUy1ixUQlMtqNrn414qck=;
        b=jk0Kd28sdrGp8YqmnWEgM6GTqJyIdhQWF9NvcYQBbd4PQWzh8myQgpQsH49txXvi5F
         uSMqKGbBX40QNiAFIuiQzCf5VbC3nziUmuvSY46m6GcrdeOB/g9tqhohebR99Ni0vO2n
         AoWo2P9ZAjVN2TDvT8bFcfRpMNCV32KdfjYz6oHUxM1CwrESPfqaJs+GLMpRbYw/6Wx4
         JeB1TpNdcLk2droVImq6c4gN1ygb1DIkvVroti/dYhWcRELvq9TlynCJ6RAqFzd6TwA0
         4G9+cjn+6JbwLf4AWsh1anFVx4gvWxUwdlzYT+zh6ALbUsxvoG+E/gry4U9cKg4HAFP+
         SB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714010430; x=1714615230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2G0+Wm78u1m1Y1Ar32t4xbeUy1ixUQlMtqNrn414qck=;
        b=cuxGBEKY0vYr5YXBR2eCZ67DCBXC4j1bd23LpRgixYbaVpL6ZBQMXWGWvinB9Sqtf9
         vmznm6aaZN1z0NWQpGYaTmTrxgvvvSElXin1DhmlCuJo9Kg1vNvDUBQUerUsU/PoucND
         azp8siBIOyexo2b9Mjl8Y6R5ZweiQWFUybc6xC9c5kxH3fuIdDCW5AtL5LUFzkIKSRt2
         aIlopLVxdOkWZW6G77v1Ck8drZkT9CkTYosArU1trdbUNQnESpD1d0GUf0GI8WfVKkjQ
         8AC3jAE84vYUarBj72tLb4wk9JCgd74WH0Kzg3YX+qj/hoTqs/+zOeSCH21XoDeM+4Ee
         riLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPj5D5Bz4Ad8I136CJrSJJO4/C0XIvHwQD9+SQLNKuOmNakSV1iWVceRiuBz9sTbOQ9HjcAzwJ7vbfi991z7lsEwP9ocTku/WlJx+w
X-Gm-Message-State: AOJu0YwAPLIQGzhLWoWoVkeMDy3e5jeTEfETe31hqLHWR4DrOAWRffK/
	KAs2+8/bh13IqaQ6xaTgZPBbWZgL9NcfvYy9blo+Xo0KQfK/Ag1p
X-Google-Smtp-Source: AGHT+IFwSyw5l00ZnoQha04nf7et1J/NW5XLQWQzotuk3bq3stn0qxI0YJS7POJE1/QStRkjEqy3Ig==
X-Received: by 2002:a17:903:22c5:b0:1e5:5c49:ad4b with SMTP id y5-20020a17090322c500b001e55c49ad4bmr5841309plg.38.1714010429480;
        Wed, 24 Apr 2024 19:00:29 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e28c-ffb4-2cc3-282e-c13e-4090.emome-ip6.hinet.net. [2001:b400:e28c:ffb4:2cc3:282e:c13e:4090])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902d34500b001dd578121d4sm12576907plk.204.2024.04.24.19.00.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Apr 2024 19:00:29 -0700 (PDT)
From: Eric Lin <ericlinsechs@gmail.com>
To: 
Cc: Eric Lin <ericlinsechs@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ilog2: improve ilog2 for constant arguments
Date: Thu, 25 Apr 2024 09:59:28 +0800
Message-ID: <20240425015936.41844-1-ericlinsechs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2f78788b55ba ("ilog2: improve ilog2 for constant arguments")
used __builtin_clzll builtin to avoid generating a lot of code
which interferes badly with GCC inlining heuristics.

Cc: Jakub Jelinek <jakub@redhat.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eric Lin <ericlinsechs@gmail.com>
---
 tools/include/linux/log2.h | 78 ++++----------------------------------
 1 file changed, 8 insertions(+), 70 deletions(-)

diff --git a/tools/include/linux/log2.h b/tools/include/linux/log2.h
index e20a67d538b8..6180e8f879c4 100644
--- a/tools/include/linux/log2.h
+++ b/tools/include/linux/log2.h
@@ -68,76 +68,14 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
  *
  * selects the appropriately-sized optimised version depending on sizeof(n)
  */
-#define ilog2(n)				\
-(						\
-	__builtin_constant_p(n) ? (		\
-		(n) < 2 ? 0 :			\
-		(n) & (1ULL << 63) ? 63 :	\
-		(n) & (1ULL << 62) ? 62 :	\
-		(n) & (1ULL << 61) ? 61 :	\
-		(n) & (1ULL << 60) ? 60 :	\
-		(n) & (1ULL << 59) ? 59 :	\
-		(n) & (1ULL << 58) ? 58 :	\
-		(n) & (1ULL << 57) ? 57 :	\
-		(n) & (1ULL << 56) ? 56 :	\
-		(n) & (1ULL << 55) ? 55 :	\
-		(n) & (1ULL << 54) ? 54 :	\
-		(n) & (1ULL << 53) ? 53 :	\
-		(n) & (1ULL << 52) ? 52 :	\
-		(n) & (1ULL << 51) ? 51 :	\
-		(n) & (1ULL << 50) ? 50 :	\
-		(n) & (1ULL << 49) ? 49 :	\
-		(n) & (1ULL << 48) ? 48 :	\
-		(n) & (1ULL << 47) ? 47 :	\
-		(n) & (1ULL << 46) ? 46 :	\
-		(n) & (1ULL << 45) ? 45 :	\
-		(n) & (1ULL << 44) ? 44 :	\
-		(n) & (1ULL << 43) ? 43 :	\
-		(n) & (1ULL << 42) ? 42 :	\
-		(n) & (1ULL << 41) ? 41 :	\
-		(n) & (1ULL << 40) ? 40 :	\
-		(n) & (1ULL << 39) ? 39 :	\
-		(n) & (1ULL << 38) ? 38 :	\
-		(n) & (1ULL << 37) ? 37 :	\
-		(n) & (1ULL << 36) ? 36 :	\
-		(n) & (1ULL << 35) ? 35 :	\
-		(n) & (1ULL << 34) ? 34 :	\
-		(n) & (1ULL << 33) ? 33 :	\
-		(n) & (1ULL << 32) ? 32 :	\
-		(n) & (1ULL << 31) ? 31 :	\
-		(n) & (1ULL << 30) ? 30 :	\
-		(n) & (1ULL << 29) ? 29 :	\
-		(n) & (1ULL << 28) ? 28 :	\
-		(n) & (1ULL << 27) ? 27 :	\
-		(n) & (1ULL << 26) ? 26 :	\
-		(n) & (1ULL << 25) ? 25 :	\
-		(n) & (1ULL << 24) ? 24 :	\
-		(n) & (1ULL << 23) ? 23 :	\
-		(n) & (1ULL << 22) ? 22 :	\
-		(n) & (1ULL << 21) ? 21 :	\
-		(n) & (1ULL << 20) ? 20 :	\
-		(n) & (1ULL << 19) ? 19 :	\
-		(n) & (1ULL << 18) ? 18 :	\
-		(n) & (1ULL << 17) ? 17 :	\
-		(n) & (1ULL << 16) ? 16 :	\
-		(n) & (1ULL << 15) ? 15 :	\
-		(n) & (1ULL << 14) ? 14 :	\
-		(n) & (1ULL << 13) ? 13 :	\
-		(n) & (1ULL << 12) ? 12 :	\
-		(n) & (1ULL << 11) ? 11 :	\
-		(n) & (1ULL << 10) ? 10 :	\
-		(n) & (1ULL <<  9) ?  9 :	\
-		(n) & (1ULL <<  8) ?  8 :	\
-		(n) & (1ULL <<  7) ?  7 :	\
-		(n) & (1ULL <<  6) ?  6 :	\
-		(n) & (1ULL <<  5) ?  5 :	\
-		(n) & (1ULL <<  4) ?  4 :	\
-		(n) & (1ULL <<  3) ?  3 :	\
-		(n) & (1ULL <<  2) ?  2 :	\
-		1 ) :				\
-	(sizeof(n) <= 4) ?			\
-	__ilog2_u32(n) :			\
-	__ilog2_u64(n)				\
+#define ilog2(n) \
+( \
+	__builtin_constant_p(n) ?	\
+	((n) < 2 ? 0 :			\
+	 63 - __builtin_clzll(n)) :	\
+	(sizeof(n) <= 4) ?		\
+	__ilog2_u32(n) :		\
+	__ilog2_u64(n)			\
  )
 
 /**
-- 
2.43.0


