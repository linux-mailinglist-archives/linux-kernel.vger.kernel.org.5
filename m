Return-Path: <linux-kernel+bounces-65999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D26C85550E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FD7286BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2419213F013;
	Wed, 14 Feb 2024 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YuXQMNpE"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E82A612EB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707947008; cv=none; b=LOo7A13c24DHrbOr4hApNw3f+C8qT5rTAd/NDFTRCZwhOggcULsI+/KcvTYEKWqoKzUePxzsyFhzbNumZLY6w8vnl7ktwAii/UgnTfXJCJsh7nzdHy6Vp4ayCLUdfnc9cHjN64sZph27wTj1bTFyRdc24pQDE23YtmKnxi2YGfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707947008; c=relaxed/simple;
	bh=fETAbPkvrfEsBmR21k+XPHeLMsQjqc09haUR6Pd4t+Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Nna5HGQmPbWpzy6DhNBYFAKu1Ew80iokPDBa/GUuQKmg7wWxhg3W+Y6NRRqYdApuFUrkbArZjNkT77v3y1GC37rZ9aSqGLRetzkN+8vx9cjBEvP7LnhMZXZvZIr6E+XE/fDRlzCDmej8v5LlFGqS5CjUO4r3JwF6UuIjVrw+sug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YuXQMNpE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d918008b99so1634095ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707947006; x=1708551806; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C70lwr0VtiJ8GUktkZ5A7x6RZ89kFNdSD8u6eKz61yk=;
        b=YuXQMNpETOsrzyMinM7P3K2A32YZWkc2oTkfXGf8s56PWe5Jz9HX55b4dE2xFv2z3n
         axBTG7K5QfwXjd/Fdz5LPY+skrDzVhOF/jExNXVefS+rWOnLrbb04VZ2CaYtcY3VTELm
         5H/RdtRXKKqSQ8YBMini8cJ1ocEuNocZn3zyBXCMFH8NEl1JSCNtQNl0VY+DMTlCMjeM
         Y1+KbDVZdngPykiII4QVHSXhbaP4Vr0L4PQ9JRbo1SjQ9RPtpdZiYASjl7CxrQKz9rxT
         42BuvKvVPMKRjY3UXAsI4noRQfKbBMqaGlwtcX6jqBmepjRamb/vymVfSVAKvBLFZCUq
         uo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707947006; x=1708551806;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C70lwr0VtiJ8GUktkZ5A7x6RZ89kFNdSD8u6eKz61yk=;
        b=Ixe9qYr+VQxiJCXE8p7XcRPSllxK9/MaQxgCubILUY8PawBjwtladkCAouwF/AHtVt
         I+9snopLp/n/wrcqPdkhmhoKozveKJlHrCUFM7k/kofp76oN6EyKnsVugKoOwovJWdgY
         jBG8YWZ2YjNaXbqcelkYuRDRe0m8mDXJOICsPMETo3DAtyhaZui7LrUgPnp1KvZCnWFc
         w5oETbQTNmn4QwqgIUTr4hZDT0iudcobqxydR60Dm8JnRRU5QqyZ0r8LaReHhKTq3fdJ
         zdcHIz+BVRU6avunGeZR/pM7haiCEXwSv75kdxpxTFp05zBOMCIGHn4oMd1h1h5PVBxW
         bB1Q==
X-Gm-Message-State: AOJu0Yy49d1+v6PyDPlGeH94MPNE3s2LZnyZxYZ57Klk/y6gTsqgaccp
	EOmH1mLwguwukiI34vaLXOecCg8iXyWacz3Xf4CuSRLcJIxjmoLFnXm5y9D376E=
X-Google-Smtp-Source: AGHT+IFVrCTvshcYKBe8sewUC/O07jNmW+iY/hDcRJNe7D9PBGHdwo3tTotRa+JhMOs5czJBiz+viQ==
X-Received: by 2002:a17:903:4297:b0:1da:1a72:b739 with SMTP id ju23-20020a170903429700b001da1a72b739mr3442290plb.22.1707947005740;
        Wed, 14 Feb 2024 13:43:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUz0XDsKsgQo35QzlEcCQjwAzTTxszCm+xCmn+rvFAo8NEeAeOfSwYZlsF2x7JyvYjpeVZM9YoB5ljS7BXMie/HceGxB0H7jikebSt/QQbA1kw2dGmQv00hJ55SO+nHr3+o51BvL+ytWBsLDk21quIyNzpTivJeV80Q5QXoaJip0F38jAwBW01UpO/ycB/u0t4uSJ04/faTVK0ZnkgLKmL/CyJMWC20Ed/avod+TI8cSD6FRiQnlWbURHcz0rXazLvMhwcdn9PtM2Sfld2iVOdTudNoQ0X/IJq51lDSXSvZdNK+QDNXYLomJH+d+s+XSt5LUwNitAvKQKD8pJdBiECaZGCzdXvfRZY=
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902e01100b001db6739d337sm1085919plo.163.2024.02.14.13.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 13:43:25 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v8 0/2] lib: checksum: Fix issues with checksum tests
Date: Wed, 14 Feb 2024 13:41:01 -0800
Message-Id: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG0zzWUC/5XPy2rEMAwF0F8ZvK6LI/mVrvofpQQ/lI4pkwx2G
 lqG/Hud2TSULDLLK9C50o0VyokKezndWKY5lTQONdinEwtnN3wQT7FmBgKkaJqW9+m7K1eXC3W
 U85hLF84UPsvXpZuoTIWD9lZ7lNFYySpzzVR37hVv7zWfU5nG/HNvnJt1+gA+N7zhEDH2VkdbK
 15zmseShvAcxgtb/Rk2JuABE7jgHoX2OpCJTu2Y+KiJ1aSeQjB9K6E1O6bcmvKAKdc7A3gbAR2
 qsGOqjYnigKmqKaN1wiEaUrRj6j8ThDlg6tUMzrW6Pi6U3zHNxmzggGnW331Eb3stjdT/zGVZf
 gGuRot1ywIAAA==
To: Guenter Roeck <linux@roeck-us.net>, 
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 Parisc List <linux-parisc@vger.kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707947004; l=2075;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=fETAbPkvrfEsBmR21k+XPHeLMsQjqc09haUR6Pd4t+Y=;
 b=zi0wb6bzWD3zP9eg4FnO8iwLUjLi4dP2Sy1TTBC8EEuZ83j0nQs76QLDqkONnA/zoBAN63gFn
 NhS/NmvxS7zA/GNyU6osXlzADhGfPfqVKhh43MUH+dJ5W7jrFPXQ4JM
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The ip_fast_csum and csum_ipv6_magic tests did not work on all
architectures due to differences in endianness and misaligned access
support. Fix those issues by changing endianness of data and aligning
the data.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v8:
- Change ipv6_magic test case to use memcpy to avoid misalignment
- Add Guenter's tested-by to patch 1 but not patch 2 since the later has
  changed
- Link to v7: https://lore.kernel.org/r/20240212-fix_sparse_errors_checksum_tests-v7-0-bbd3b8f64746@rivosinc.com

Changes in v7:
- Incorporate feedback for test_csum_ipv6_magic from Guenter and Al
- Link to v6: https://lore.kernel.org/r/20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com

Changes in v6:
- Fix for big endian (Guenter)
- Link to v5: https://lore.kernel.org/r/20240130-fix_sparse_errors_checksum_tests-v5-0-4d8a0a337e5e@rivosinc.com

Changes in v5:
- Add Guenter's tested-by
- CC Andrew Morton
- Link to v4: https://lore.kernel.org/r/20240124-fix_sparse_errors_checksum_tests-v4-0-bc2b8d23a35c@rivosinc.com

Changes in v4:
- Pad test values with zeroes (David)
- Link to v3: https://lore.kernel.org/r/20240123-fix_sparse_errors_checksum_tests-v3-0-efecc7f94297@rivosinc.com

Changes in v3:
- Don't read memory out of bounds
- Link to v2: https://lore.kernel.org/r/20240123-fix_sparse_errors_checksum_tests-v2-0-b306b6ce7da5@rivosinc.com

Changes in v2:
- Add additional patch to fix alignment issues
- Link to v1: https://lore.kernel.org/r/20240119-fix_sparse_errors_checksum_tests-v1-1-2d3df86d8d78@rivosinc.com

---
Charlie Jenkins (2):
      lib: checksum: Fix type casting in checksum kunits
      lib: checksum: Use aligned accesses for ip_fast_csum and csum_ipv6_magic tests

 lib/checksum_kunit.c | 398 ++++++++++++++++++---------------------------------
 1 file changed, 138 insertions(+), 260 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240119-fix_sparse_errors_checksum_tests-26b86b34d784
-- 
- Charlie


