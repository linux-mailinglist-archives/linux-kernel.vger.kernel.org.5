Return-Path: <linux-kernel+bounces-60525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC633850615
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 20:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922AA2854C9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 19:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5075F567;
	Sat, 10 Feb 2024 19:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7ZBwBTJ"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422047F4B;
	Sat, 10 Feb 2024 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707592561; cv=none; b=HlEC5DQ2dnT5HjUTdZhDOAuzUOcIhfVJNU2C01snYOX40p5evWmZZxX9MUhbNWe9Pg4tIeMRRan09l2r3OfFaJ/uV3lKE9FuSALhK4MrIViBHNVK+JKbGC4IPeuW38N6jzN7EP+KRqQoWJzLZ3MYpfAj52jjlwIGzCvNDrXEYKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707592561; c=relaxed/simple;
	bh=Hr5DTQhtEG2V6i/LKdZdekYO9OCFKxEe88RuI3FrWM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YE1TlR7U63dn71kv8+Q3qATu6wfZAF1Xa/UlkOhSpVVLaVVjV/xgXKf5RxSOuPDffqlPKcB7F48skukqv0wG9BB+PN8Gioj9N/xu3qS9dy8o96QYlPVBHhtcqGdEfMThH4X9so0smdEkMHDCx9z+paVfTHWvvCEtkxAL12GoY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7ZBwBTJ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so1354126a12.0;
        Sat, 10 Feb 2024 11:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707592559; x=1708197359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iDfKAj0v5RzuASeBKsae1qL39Hr/NnC2ebGMASs/ORc=;
        b=K7ZBwBTJWWtjzFT8fs4UzYj+i8pQ7PNQmUouoWHk1RetiHXePzdlumSBOe+qgK6wSR
         okdbMvMWhtZ2a5zK6yZ2wIgs7z/tmoZUNfTSFnRlHCkJwFW6maYbfefbzl2i35v19vM2
         lVj6qnjRD6oCQPATIFRC2UNSGXUMKS1t9oi+/l2BPPgsWJegm7TwtBAaVHMsMg9oUKLN
         W8uppTYU20TWnh9ACfw9JqA+EOzqlO9NKouD8czAHfaGa1o321D4ZZQx05y8Ut7ux+0A
         xEph7s4WYz5ZXHryjl5yxitOF+DZo5D/S41pJzXYJmCGjEfy9G9sw3vs9Zsk1FrXYxS+
         GhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707592559; x=1708197359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDfKAj0v5RzuASeBKsae1qL39Hr/NnC2ebGMASs/ORc=;
        b=fHW/lqPtu4q2qDth6zVrZS16SgIpd/oUDHWrB8t9dxY4vok/kJcshWVX2g4gM1LVym
         /nRqq4pM8IJOv+BYd9cemUl683GN7I3LCEsOdIPmg52NtdklNZOw9hgLV8w0tRORZXrY
         wc/fRYblhZMfCmgXxONc4e7Jv4KTsgovT7A6hiRaFm6Qoz1MOF7xjran6oojfpMsg8p8
         XmEVe9leSMuR2VEAuiisNsaxttlBWl3Z3FBDinFlld6eGflxcfeYmIHZOSV1aeNIoBPK
         P3+Wx/Z7EF5sMGv4Pu7Igh2hk+Tnn5LmEpfDqoQXJKZ0bGxHiWBH0XvYd+jewHSAcUTi
         LLzg==
X-Forwarded-Encrypted: i=1; AJvYcCUdOPTKCpeFlaF+UjvWuc4PPbZceWNG9dlh+8eOmaZQH93avvG9EmQlF1Sa+2pwYtU1clkBRcF2gOk3Uit/JK6wONPmRua5mvBnjiwYAJ5viK4VSz7sspla2PhTWni6cT6SI7W8q1Ji6UJM
X-Gm-Message-State: AOJu0Yz6m1NjK77J+h/gx2oC+tjYSY6HiZyww4Zd2b+ZVgnWp1Q0vLAe
	rcGvxnYfSasEug4rh4HxYOz3qCRNrHunLzGu+QXuaSFO33i0JzB/
X-Google-Smtp-Source: AGHT+IFHCpdFR4msNmnbe4MRvNnQxnKmqk2SPXDSv6CJ03t/t44HNRdalPXSmLcgwHjC8N3kOsOi+Q==
X-Received: by 2002:a05:6a21:3a87:b0:19c:b3e7:fe39 with SMTP id zv7-20020a056a213a8700b0019cb3e7fe39mr2763910pzb.0.1707592559228;
        Sat, 10 Feb 2024 11:15:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUv1J/tvaE9WVliotr3VdvYKbFbvYl/n8c4814V1Lhe/W/AyK4sHsO0liPejvruKUFjIfyOMWXmzvC8b1gN29T7jwTakKtE8F40KxOMlAnPSNdSgVHoo/PFxY9ds1KR0ie0WeVytxJL/u1RZ/R2HNlCyQDaW3zfcdCpV7LWU1JMBWa0fZ8ErLKwxkde4V/iNVRHDq0dy5j6bQOj1XfyRIKXTStf5/fZy9sX
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kx8-20020a17090b228800b00296f4f643d5sm3948962pjb.25.2024.02.10.11.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 11:15:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Helge Deller <deller@gmx.de>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH] parisc: Fix csum_ipv6_magic on 32-bit systems
Date: Sat, 10 Feb 2024 11:15:56 -0800
Message-Id: <20240210191556.3761064-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calculating the IPv6 checksum on 32-bit systems missed overflows when
adding the proto+len fields into the checksum. This results in the
following unit test failure.

    # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:506
    Expected ( u64)csum_result == ( u64)expected, but
        ( u64)csum_result == 46722 (0xb682)
        ( u64)expected == 46721 (0xb681)
    not ok 5 test_csum_ipv6_magic

This is probably rarely seen in the real world because proto+len are
usually small values which will rarely result in overflows when calculating
the checksum. However, the unit test code uses large values for the length
field, causing the test to fail.

Fix the problem by adding the missing carry into the final checksum.

Cc: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/parisc/include/asm/checksum.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index f705e5dd1074..e619e67440db 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -163,7 +163,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 "	ldw,ma		4(%2), %7\n"	/* 4th daddr */
 "	addc		%6, %0, %0\n"
 "	addc		%7, %0, %0\n"
-"	addc		%3, %0, %0\n"	/* fold in proto+len, catch carry */
+"	addc		%3, %0, %0\n"	/* fold in proto+len */
+"	addc		0, %0, %0\n"	/* add carry */
 
 #endif
 	: "=r" (sum), "=r" (saddr), "=r" (daddr), "=r" (len),
-- 
2.39.2


