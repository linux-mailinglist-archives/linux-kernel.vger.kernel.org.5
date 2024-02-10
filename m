Return-Path: <linux-kernel+bounces-60503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA5D8505CD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5931F256B7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20265D479;
	Sat, 10 Feb 2024 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAIQiMT/"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E19D29CEF;
	Sat, 10 Feb 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707587731; cv=none; b=SdqCpwEBLHGlBPiFzPjl7YkRgU+5vquVYOLn/YDQKrDx7bW1GrXJ9xIkhOTaSn119rkmpJtlwKs2FNFLZN+LiWQocQe4iyVXKgfvPlWq1cFn22bkWGbUhSIulYNxGVjMegttd/wChLfsBNudYywVoKRhE+SZWY+FcFW1waUkG5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707587731; c=relaxed/simple;
	bh=Bdz5cBVJUC+BoiWAi2wyV+PheJklqxfClV/aLVhKcIU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TjpqJUnUcw0QAxLkfabfi/NFNYj5P9wCDL9ZpF37/P4PBCmlVvEadd2CJe6zgQyQ4iZWHBoDW8X6bXGPtM5xjn+paWVJZf5s29mSvKR5WKZKWxoBiUhMOD4zSFoqRayrZW1/jdy4nxEjAIRWXtgBV8UtCbNyuV4OSEvulqwPr8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAIQiMT/; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso1773364a12.0;
        Sat, 10 Feb 2024 09:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707587729; x=1708192529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=svbCPZo7tOHG4+PT9kYnFXadgA834LlYEiJR96UmKIA=;
        b=FAIQiMT/OSo1V8mRy5ENruRwTRgx2tY130zDrYyZwy0rKiTDoiQWmxpEzJLm0fUmyV
         pz6Nqf21vIOzr2bYenvgBvxKv0bBKzdsFKE8E240QPNMfmvFHHg0kBCVvjEDsj84FPSL
         vS9Rgt76fakTgEl8i1pQILSwuMuhn9zf+HDNygmX397SGgG69eDjw7KB0ApF4kBXIvxw
         U9wb+dtw47xZUu93bGZsUnaSqrkXSDtkw0ENd3TnmUHYzzKi6P+XCDSOACpZF5SPRC1e
         AQMpUVeijiu5Y3Mb019LBLcZDAobWKr4vKNySj7yFFlKjavRLAhzCd73EuSm+kcWWl3M
         T7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707587729; x=1708192529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svbCPZo7tOHG4+PT9kYnFXadgA834LlYEiJR96UmKIA=;
        b=MtBn7jnX8hp8sc+EEwa8s+0bs13pujlvnjJSNGFZkkGYk5jTAwvcpPoRkmGeqs6y0z
         JzRhB/uBpOmnqGbAybh/xVVEIqjNOQi5cQemGy+Dsyi15scXDM4YSy6/ENzvcccyndaJ
         3QWqrou+aImpedfXFJj06MfscE4twbSdwBXkhQhp1PhDZt9AjLCV9IpRjoBPoQABWOyg
         ALZ6SSZL7lFEBZO+WgrvQ1Bl4K1XMFWqXkkNlDwzE6wnAaDIFyaj0IJoBmGoj9yfS5rB
         4HrhxEWojMKtSngVzDhtMriWj/gzYgMgHp1h+IUaGDpRS1mXyetyen083Twzv6TIWSez
         Txpg==
X-Gm-Message-State: AOJu0Yw1yGYHxDcVYQ6BxQDpZ0nxKwsXUuugbaO2yL+kBS9wTtfpCpTS
	schn0w4//TbTTL4TBZ7JBN3GqfSU1CHmZfoogWlrvvVYV3IWupAU
X-Google-Smtp-Source: AGHT+IGOgKogGS+72H/tO4L0bUKEGeSdeZ8x5ZX/vqW88S6JcGL8VoxCmbh5kzI9d+eRZHQt2vKosA==
X-Received: by 2002:a17:902:ea08:b0:1da:192f:3ecc with SMTP id s8-20020a170902ea0800b001da192f3eccmr3936618plg.53.1707587729287;
        Sat, 10 Feb 2024 09:55:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUplzNKbOA5YE/tibcz+NMRb/+pffFJWjBYivN/jMuYDtRtkrtOoRJQwzZ46xNC7EcC7A1Jpx5wGoiXk6w60Tc7U2/9P7XHvXNk1dcJLffN2cQTvTxwBWqGkbnxl2oF3JGCdto7M+H2H+YZXRyXz8OEsJBg5F6mVQ3MYPX9QMCcaQXpSAVYX6Dfn0nWe9pocFFslRMf2FhaJplLJp4mJ+VexSOPLaZ26uVw
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001d964f86846sm1888044plc.161.2024.02.10.09.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 09:55:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Helge Deller <deller@gmx.de>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH] parisc: Fix ip_fast_csum
Date: Sat, 10 Feb 2024 09:55:26 -0800
Message-Id: <20240210175526.3710522-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IP checksum unit tests report the following error when run on hppa/hppa64.

    # test_ip_fast_csum: ASSERTION FAILED at lib/checksum_kunit.c:463
    Expected ( u64)csum_result == ( u64)expected, but
        ( u64)csum_result == 33754 (0x83da)
        ( u64)expected == 10946 (0x2ac2)
    not ok 4 test_ip_fast_csum

0x83da is the expected result if the IP header length is 20 bytes. 0x2ac2
is the expected result if the IP header length is 24 bytes. The test fails
with an IP header length of 24 bytes. It appears that ip_fast_csum()
always returns the checksum for a 20-byte header, no matter how long
the header actually is.

Code analysis shows a suspicious assembler sequence in ip_fast_csum().

 "      addc            %0, %3, %0\n"
 "1:    ldws,ma         4(%1), %3\n"
 "      addib,<         0, %2, 1b\n"	<---

While my understanding of HPPA assembler is limited, it does not seem
to make much sense to subtract 0 from a register and to expect the result
to ever be negative. Subtracting 1 from the length parameter makes more
sense. On top of that, the operation should be repeated if and only if
the result is still > 0, so change the suspicious instruction to
 "      addib,>         -1, %2, 1b\n"

The IP checksum unit test passes after this change.

Cc: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Prerequisite for this patch is
https://lore.kernel.org/lkml/20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com/

No idea how that was not detected before. Maybe I am missing something.

Note that test_csum_ipv6_magic still fails on 32-bit parisc systems
after this patch has been applied. That is a different problem.

 arch/parisc/include/asm/checksum.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index 3c43baca7b39..f705e5dd1074 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -40,7 +40,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 "	addc		%0, %5, %0\n"
 "	addc		%0, %3, %0\n"
 "1:	ldws,ma		4(%1), %3\n"
-"	addib,<		0, %2, 1b\n"
+"	addib,>		-1, %2, 1b\n"
 "	addc		%0, %3, %0\n"
 "\n"
 "	extru		%0, 31, 16, %4\n"
-- 
2.39.2


