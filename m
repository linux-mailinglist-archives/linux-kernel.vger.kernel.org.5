Return-Path: <linux-kernel+bounces-36100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34CE839B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D231C24425
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D1B4EB25;
	Tue, 23 Jan 2024 21:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0XiTIqTj"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E224643B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047091; cv=none; b=s8J5rSpmXI3Ed0KKmmkmlj6HAZsI1prHqK/gOd6YHMqIjqNte5eMvk0jSdCMUXm9S6wm+tZgUCaK5n2v84hkynUf9VcY8NUNfp3iTdON6Kj5p/JOCdSJeME2sQcCEqzj0NOEDQAOe2MIEqaIEs49LXlGGVPW7mXSXdswTrzevSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047091; c=relaxed/simple;
	bh=vtaithEKdlnR6rNf+kxSTk35iDBBx0caxMmfVcvyUEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N/NA+PHOWONyOxoxFi2QYfhnUcyJBKqkCcPqvIfIxbMOLOReoBtgYGZ+fchkl+WYSgcPc/yra4iRHBuCzjtkfNb7tYD672b7q0VKFmE0Erpq1qaZbwEOYZQH3bjj1s/9iHKv3zZwKZ1KecD7SAJRwTRcASi7GW+N6lYGB9tix+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0XiTIqTj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d731314e67so14701865ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706047088; x=1706651888; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ynZXq3hbnTIt8pJLL68IBYX2Qlu6g0sPaImPdjw3z4=;
        b=0XiTIqTjY8LDYX0bZfZ0FX6YzZHnAsgme8BTdKH0hNUO6QDu2crBLQJuz0IUx1TX7N
         exud5TXeX4of93Yu5c5+aJSnXDgTMRP5HkTJveVquo4Zu35CJDLuAKAMZLVoZRIYpks0
         JN8pKtrVJJShrsEK1L5p/ccXcBMDEjEBCUdypneceN3IAKgw+/kH78BrrPT7xZPI+SME
         kZ4fL5daGychEQHewPUBsKqDFTxzENBpk5gqtI9kfbtTpCosg2aXzLWgZjLe9JcRhtgf
         mQf9xyb2KhCP/8bDL+5g0SW8tQK9lAWMIMH05oDx+3pqnpRfkl3tyjX9GJSvoEzymoz9
         8Myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047088; x=1706651888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ynZXq3hbnTIt8pJLL68IBYX2Qlu6g0sPaImPdjw3z4=;
        b=YP6SwqJfFAvFTaUZLfM3w93bVCFaC50bPfGY058oC3ZYx2qkX0N0LRPYXEaCUyENK2
         NaIt7ZBfrUKu6lCo1uMa0QX1hNgrGtsTHmnjjz3cenbowItFmrrqFbuom4l7LHKsGSuX
         veN34htRR+tBrp2g2ZU+Tm1qpCKsRZxXLr7T4NnZiy+yRgtoefk9sSAtk5xgbemR5vD6
         TGtQjWG+1R6V+rI4DrNUl4DpxZWVdqdHzqSTj1BOxLdG0+yGxLG2QsGrBz+R7sooFUBM
         8KTDUZG7hFWbiiFROtiyC4kWD7ZKlGyIt5LP6ahDlLzG/q3N8TXNbI0Nys1PC8mKnXOm
         Y2wg==
X-Gm-Message-State: AOJu0Yz8+Y/x/8zYkV1oo+nc0WbLAmJcz8zNT2mcj+PwlQA/gNHaLboB
	PuNcVC/11Rs1Q94TTFp6mnu+OKAoHMF3ErzOT5zOrX1kD/4Mvl1o7JoRP9quhf6Z0bpB42rEY/S
	m
X-Google-Smtp-Source: AGHT+IHDi7rfr3fbYpyzGv8QORUkG9eeCHiI2YyYD+1FKcLYCeI1Jb+a0L61wmMqkEJ/vIZZ0Y3nhQ==
X-Received: by 2002:a17:902:ce86:b0:1d7:3f26:535a with SMTP id f6-20020a170902ce8600b001d73f26535amr3701645plg.71.1706047087981;
        Tue, 23 Jan 2024 13:58:07 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ju22-20020a170903429600b001d755b10448sm3661429plb.199.2024.01.23.13.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:58:07 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 23 Jan 2024 13:58:05 -0800
Subject: [PATCH v2 1/2] lib: checksum: Fix type casting in checksum kunits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-fix_sparse_errors_checksum_tests-v2-1-b306b6ce7da5@rivosinc.com>
References: <20240123-fix_sparse_errors_checksum_tests-v2-0-b306b6ce7da5@rivosinc.com>
In-Reply-To: <20240123-fix_sparse_errors_checksum_tests-v2-0-b306b6ce7da5@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>, 
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706047086; l=2402;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=vtaithEKdlnR6rNf+kxSTk35iDBBx0caxMmfVcvyUEU=;
 b=t1uxIjq9p8s9LTH+gsbuEP1u9nLUyg+rfwEUSBAxG7YVJ3Hk5ICT/BnhaKq0yy8or3c/d4AnY
 MUAZUe2o9pRAp5I5AaCC1RSXFg49Wqjne8xGFcIn8IWGTazz3dZYWsW
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The checksum functions use the types __wsum and __sum16. These need to
be explicitly casted to.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401200106.PMTn6g56-lkp@intel.com/
---
 lib/checksum_kunit.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
index 225bb7701460..776ad3d6d5a1 100644
--- a/lib/checksum_kunit.c
+++ b/lib/checksum_kunit.c
@@ -215,7 +215,7 @@ static const u32 init_sums_no_overflow[] = {
 	0xffff0000, 0xfffffffb,
 };
 
-static const __sum16 expected_csum_ipv6_magic[] = {
+static const u16 expected_csum_ipv6_magic[] = {
 	0x18d4, 0x3085, 0x2e4b, 0xd9f4, 0xbdc8, 0x78f,	0x1034, 0x8422, 0x6fc0,
 	0xd2f6, 0xbeb5, 0x9d3,	0x7e2a, 0x312e, 0x778e, 0xc1bb, 0x7cf2, 0x9d1e,
 	0xca21, 0xf3ff, 0x7569, 0xb02e, 0xca86, 0x7e76, 0x4539, 0x45e3, 0xf28d,
@@ -241,7 +241,7 @@ static const __sum16 expected_csum_ipv6_magic[] = {
 	0x3845, 0x1014
 };
 
-static const __sum16 expected_fast_csum[] = {
+static const u16 expected_fast_csum[] = {
 	0xda83, 0x45da, 0x4f46, 0x4e4f, 0x34e,	0xe902, 0xa5e9, 0x87a5, 0x7187,
 	0x5671, 0xf556, 0x6df5, 0x816d, 0x8f81, 0xbb8f, 0xfbba, 0x5afb, 0xbe5a,
 	0xedbe, 0xabee, 0x6aac, 0xe6b,	0xea0d, 0x67ea, 0x7e68, 0x8a7e, 0x6f8a,
@@ -582,7 +582,7 @@ static void test_ip_fast_csum(struct kunit *test)
 	for (int len = IPv4_MIN_WORDS; len < IPv4_MAX_WORDS; len++) {
 		for (int index = 0; index < NUM_IP_FAST_CSUM_TESTS; index++) {
 			csum_result = ip_fast_csum(random_buf + index, len);
-			expected =
+			expected = (__force __sum16)
 				expected_fast_csum[(len - IPv4_MIN_WORDS) *
 						   NUM_IP_FAST_CSUM_TESTS +
 						   index];
@@ -614,8 +614,9 @@ static void test_csum_ipv6_magic(struct kunit *test)
 		len = *(unsigned int *)(random_buf + i + len_offset);
 		proto = *(random_buf + i + proto_offset);
 		csum = *(unsigned int *)(random_buf + i + csum_offset);
-		CHECK_EQ(expected_csum_ipv6_magic[i],
-			 csum_ipv6_magic(saddr, daddr, len, proto, csum));
+		CHECK_EQ((__force __sum16)expected_csum_ipv6_magic[i],
+			 csum_ipv6_magic(saddr, daddr, len, proto,
+					 (__force __wsum)csum));
 	}
 #endif /* !CONFIG_NET */
 }

-- 
2.43.0


