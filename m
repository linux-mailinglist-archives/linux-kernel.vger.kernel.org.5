Return-Path: <linux-kernel+bounces-164984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B6C8B85E0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44A41C2220A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D094E1CB;
	Wed,  1 May 2024 07:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF71u6YT"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC524DA1F
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 07:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714547822; cv=none; b=MQ6EKy/WEs50LWzrbwh2ey6fVhBmiEE+MshXQHHnmHZcz7qmzC9FG5GIkhCT2N1G/RseYOQfhbPQMdeKTWD0HaeNAEAwhpIMc0Dyx8XGCO5rAMaOB9WwPgH6yxLQ97T3Fq2UOmAehc+pTeCNSTW2yB2raLxa12SbuXSOAKF1qZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714547822; c=relaxed/simple;
	bh=dQiDbGzFQhvzO2BiRKhTFzDLJjd0wQo11WrQqMn7DNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jZ05x0uWrDgbMVCLZPiRXa3RcsirZOhCu8YZL6xW0MJZ+XE+ThOuQ2tF6NOb95H03hIDM79igLUzPbT+1x74hbNyWOK0uUozVs32x6KAv/hF07x6jByE5CRVhKRNRL/JlUNs0N/s0axdkMdCJFtY+cyJSJ76T5kxx4hFArFXD3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF71u6YT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a2cced7482so1709975a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 00:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714547820; x=1715152620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iY6sp9ljp7T3vkUfo6tvm0cE9jMbRaDd7ciNPeCLxpA=;
        b=WF71u6YTVMLGWep5JpWuJuh5SgQYKcPpz/bscxu0XSkp6mXH1f+nRCPPVJAXLdaAOw
         S0LRjfDGFHG+bb9c7nmzsDLobXSk1pzP5WgWCl7GRQUldGb0ISRwf1qizMt5s8W8l13x
         4ZjNe/5IuLpqdsQM4XI1mFB/AV9GBCqODmYRn36Us2Lf9xpRElYIdpWJmkHKx83AavVb
         eYHEcy/8ltfyQ4KJDo3xas6kBgPDr/S+zymk9LILIxV2trYc2TOTdLnVWSPByKknmEOL
         6o3lBn+qwWUWu1X8i/1eJnjIPIIJXwM43FiuoGt0YecL4713QjB/1B5lEXjFUaWevwbu
         AvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714547820; x=1715152620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iY6sp9ljp7T3vkUfo6tvm0cE9jMbRaDd7ciNPeCLxpA=;
        b=TFQo2oOT88Gfg9PbdahO0upCmr7OL3xNG6PYvBeQ5L4gNIxWQC9qlLv2KGFclel+6K
         vuJxudcehVrQRti1a0wdprBSKABGYwFOPnLyJwFCDPQ5rDaTV9MzsMQ7cHBX7BJwUutn
         nKIKTvaFCN7UaTo0TEGzyHffumOHjdk9wDmyQTas0Qy3rkLQWzeWnVjDnV8dF2hRujRH
         J/tqdqwxCUml94qZ+a5y+vLUR5yGoyKrQFiT4rRYBhRGT1fGahmdRl313mFVrzJQEjP4
         +zim/5Gay+0j2EgrH7+dDUmX+1zG8xjxyK0aunYC9yq+J7nF5PEzIaTiVvQ8kkpljyEp
         ITHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoQfG4niuvg9UaKyBaHdWBiJWmRxIoJ2GfQLPcwSIGegjQ1aJpvGlUwQnbFuQ5lyzt6Zo1WaRifb6b8cRrRJqrJmEPKNcvNK79GB5u
X-Gm-Message-State: AOJu0YyCjHwgmkQOhOUjw9pMRln0m2pY9sRavKO48/6YyqBQlS46wbFH
	civnGDH2kGje/gsNTTpP3PkeUm3Jbqb+eZc1Ej4lOuFjWzKGA5XYkNKr+p/V
X-Google-Smtp-Source: AGHT+IFik85TYd9H0b7dKGKorXpJfQAjhS9OxjH/VgZwKlQzrg02RMyrLmzhJc7kbTJ81Egq2fOq9w==
X-Received: by 2002:a17:902:f546:b0:1dd:da28:e5ca with SMTP id h6-20020a170902f54600b001ddda28e5camr1772480plf.0.1714547819693;
        Wed, 01 May 2024 00:16:59 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id kk14-20020a170903070e00b001e560db091asm23523013plb.72.2024.05.01.00.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 00:16:59 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk,
	n26122115@gs.ncku.edu.tw,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 2/2] bitops: Optimize fns() for improved performance
Date: Wed,  1 May 2024 15:16:47 +0800
Message-Id: <20240501071647.10228-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071647.10228-1-visitorckw@gmail.com>
References: <20240501071647.10228-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current fns() repeatedly uses __ffs() to find the index of the
least significant bit and then clears the corresponding bit using
__clear_bit(). The method for clearing the least significant bit can be
optimized by using word &= word - 1 instead.

Typically, the execution time of one __ffs() plus one __clear_bit() is
longer than that of a bitwise AND operation and a subtraction. To
improve performance, the loop for clearing the least significant bit
has been replaced with word &= word - 1, followed by a single __ffs()
operation to obtain the answer. This change reduces the number of
__ffs() iterations from n to just one, enhancing overall performance.

This modification significantly accelerates the fns() function in the
test_bitops benchmark, improving its speed by approximately 439 times.
Additionally, it enhances the performance of find_nth_bit() in the
find_bit benchmark by approximately 26%.

Before:
test_bitops: fns:          5876762553 ns, 64000000 iterations
find_nth_bit:                  4254313 ns,  16525 iterations

After:
test_bitops: fns:            13388431 ns, 64000000 iterations
find_nth_bit:                  3362863 ns,  16501 iterations

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---

Changes in v3:
- Add the fns() benchmark result from lib/test_bitops.c to the commit
  message.
- Modify the commit message to display only the total gross instead of
  each n values in the benchmark result.

 include/linux/bitops.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e067fe..57ecef354f47 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -254,16 +254,10 @@ static inline unsigned long __ffs64(u64 word)
  */
 static inline unsigned long fns(unsigned long word, unsigned int n)
 {
-	unsigned int bit;
+	while (word && n--)
+		word &= word - 1;
 
-	while (word) {
-		bit = __ffs(word);
-		if (n-- == 0)
-			return bit;
-		__clear_bit(bit, &word);
-	}
-
-	return BITS_PER_LONG;
+	return word ? __ffs(word) : BITS_PER_LONG;
 }
 
 /**
-- 
2.34.1


