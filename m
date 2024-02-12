Return-Path: <linux-kernel+bounces-62339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5495851EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054CC1C21C46
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AFB4BA9A;
	Mon, 12 Feb 2024 20:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="S30jdh2B"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D851EB3D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769995; cv=none; b=k55S9eT2GigGgz0chVo2YDE1moYrFD+zCPUjfVXWX+04jZfBfS/e2Y2QSfsVuPuIuhpe2m/RkgNWcNwTLdLxNMSYS4E+auwEvT9aCeoBJmMkYX8KrUAl17ZIsH4kUF9Kgi51XN+eQcJWZqobRYVyFcvrpo2JIax4xt0av4EnLJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769995; c=relaxed/simple;
	bh=AzZ2wloxj6KDQAMdXrlf4AWIKCIwq2UD/2yzxCzqXlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uisATU82ksRzXrwzlxV8ovN2gyT31skC5Xaty+jYdmQNFm+rmaXYRz/27G370LfMm7+L0oTZ9PPWXF/U0xYbvELjAt2dBYPwZXB5y+nyJN1/Pb5qoUp4AXCKAxwt0atjtY5allGMhirN1vQb4kZLudHhMK1c33pPHiHjuEUwQmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=S30jdh2B; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e096229192so2792625b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707769992; x=1708374792; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jd7l9FSzolv9UKodhUQRIn54HJ3vZVJiADf6xQSSoXk=;
        b=S30jdh2BgB5nQTVX4JbMBi2v7XNoexRwsC/Vu0drzlFAwpmA2mMzuyPj52uJKzAJqX
         fhPJf0TiVQD+c08jTXD6hww9p6mex+NEIX8yHSX2qEhoMALVW4RzFjLTTHToRzeL8b6J
         Ps3oiSKC/g8iv+AcIcIddFnlV3WT8ZAYT6XYpQ/uZDwIGd6u2/wLH44J22nH6J9iNJjZ
         QAHlnMKqTA1TMyJRvgY7bF6wQNcRDhLxoR3BXojbp0OAB8AjeeW1l/OS4Lcu6a1dd9kH
         +SXlIMTNW31iQRTPRZK4B0AmgyadkoND8DqF2p9yzIyTNrjCWZ1f5lT31k0M19KzoFHf
         /mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707769992; x=1708374792;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jd7l9FSzolv9UKodhUQRIn54HJ3vZVJiADf6xQSSoXk=;
        b=H/N2t0i8QdMEW9jHfdWeOvhLus9GIaipEH3CfQlRtOdzi4T+n7gdnmba7Bo1kBWhYX
         lDe2B/XPJY8E2DGSP+uoJHcGmMmzerxeX1zdWh+bKcBTPJ/ph9YkI6AAQV6SHX21GNho
         mRD8QeHgmXh3wfx70EEjgxaCvKWk3vRjsK8N1k4ZQ/ntfsmFmzGvriJtcyWuGapvFA1j
         yDevh24J4gAvZEMGsnXtHXlXRYwUQSb8IpbnmZlDeL3jS0xpZx7NuhAO4LCLycYlYCVI
         uKmVmbZkHjVXn7dvUFCjmFDCxoZuktIqrKQYyM5Ef41wUSrXFUURcGf0lAxHWQFamker
         xNCQ==
X-Gm-Message-State: AOJu0YwGiVi5zieBXOIcw6VNdwgvUmC1r/n1S5S58ZXMPBQGlCiKnU1l
	+C+FVJGxHadSG17aXCBm2RxJHVF4qFN8J11mKr5V7V8XbzOeRr0y84hnVJRQOvxO3cfEK0A+fxG
	q
X-Google-Smtp-Source: AGHT+IH6fHOZRolRAeV2wQXvEcZAsNCwFVGtJIadjlhkcFvdJhO4jubcEfSfurneixRmpl5dQrPcXA==
X-Received: by 2002:a05:6a20:d39a:b0:19e:9b19:96c0 with SMTP id iq26-20020a056a20d39a00b0019e9b1996c0mr10544685pzb.7.1707769992443;
        Mon, 12 Feb 2024 12:33:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0zWV+JXpELhaIcfRoduAeJRoKG1hMVNdySXTOP6VxqPVhVrZyK/HjBPjK4sH+1wkZjjownlb8i0odo00xE1qu77wTXjICD7mrOE1OXWWjkKPMvuEnbH9TIErofQs1RNeqegjOQmaVsY4rdA7r+YQSATW+dEZQ5cRkOZrPxpiyiJlvyUz1T6tB3sk3mkJPrC1WWX6DU4XwbUuUC0hOkw9jMT63Wy9Kue6ndWdufok7du8jZAk=
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o15-20020a056a001b4f00b006e09e97b803sm5552506pfv.46.2024.02.12.12.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 12:33:12 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 12 Feb 2024 12:33:04 -0800
Subject: [PATCH v7 1/2] lib: checksum: Fix type casting in checksum kunits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-fix_sparse_errors_checksum_tests-v7-1-bbd3b8f64746@rivosinc.com>
References: <20240212-fix_sparse_errors_checksum_tests-v7-0-bbd3b8f64746@rivosinc.com>
In-Reply-To: <20240212-fix_sparse_errors_checksum_tests-v7-0-bbd3b8f64746@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>, 
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707769990; l=2446;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=AzZ2wloxj6KDQAMdXrlf4AWIKCIwq2UD/2yzxCzqXlE=;
 b=TZdgr3HUZz108GlWeS6WVeDd8q4kHcwAr+emkJBzljel2b25nXDG75cnJIXUgFbGvg5qL+xPN
 /QQgpcmSnx6D4anPg16Th2dOWSKXemjtTOSBqQQ+G8EzJ89sKChN/On
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The checksum functions use the types __wsum and __sum16. These need to
be explicitly casted to, because will cause sparse errors otherwise.

Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401200106.PMTn6g56-lkp@intel.com/
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
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


