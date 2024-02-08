Return-Path: <linux-kernel+bounces-57337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BEC84D71E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C711B1F22AC2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A012E84F;
	Thu,  8 Feb 2024 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zcuTJ8H3"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D762C857
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351775; cv=none; b=tSD4K9jLccGpcCChEqTG16l4Qrr8/ePc3+57o4JADLfBnSJfyM58THhLy1zN22qUc1CljmJp1rnK0hwP1cEUp+yZG425nrwiXoIBWgVrxS2dmGw6BNV9eitKxHdzVfY3I0HL8DbDPg3mXxYv1YESbqfrdWL8uK8gocznQwsUlJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351775; c=relaxed/simple;
	bh=3a1VyrDlpdg9fZq+LBjebNs62E5K5JdZfIQyohmyq3A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h6XUuvqPcY6w2lIC8tOUXZZViA8/j/n5Ggb/3Ha0CZ++9B475ZOvdhJg9u+F+ddBr9klUyj+gqrvZ3BCOQGjy5rbDM2BQvURvB5Z6kuHtm6iNrvOnjM31dHSoaKfquDByl1zakHs9RNUotg+ivHXbMs+Xc0MDmGD/46PwZXjJp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zcuTJ8H3; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso1152684a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 16:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707351772; x=1707956572; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iGy7BRl7kPJKYeaAvt+TgLXvSAxcG9Nq9NPnIaMKfaI=;
        b=zcuTJ8H3o63n+oW9j9etHNo9MAT8JaGz+XGRxzx5loy11nYCrsX2B1uGjWeZyHteVx
         HU+B+PRZcTzlSKTOOXC53qk4S/UOjnMlBJlZvvN0BD2cDSKdLJ3b9mpkICk0cZLn+U+g
         M+AW/7sp0srXuI3ft6ZGh7LuNRfzX4lGH6A96OmRZUrWSp1mI+Q1vNJs8cDhtiRt7RMi
         O6b8hIxR+4PHbZGiYOFWtjR9Nr6++/xo4GrQYLVYEs5tK3ooBR0CFP84ObfJ44wM9fRV
         1yiUN9pCRZQybHsaIRm5DA0rjYHMgDk+hVyKvbo9G6qr4ace2VQsrhuAYFVsVTwoghmU
         k6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707351772; x=1707956572;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iGy7BRl7kPJKYeaAvt+TgLXvSAxcG9Nq9NPnIaMKfaI=;
        b=tnQTgZuGeR6r8avWofvbKfcVxQZXo16D/GSgWqPwdZvCmQpMy1/ibr/8O6m6180VNq
         RNKvkKUSaJJQeOzoz7SG7GBqV+YCVJ13tnRx98kbziMeKJuAgIG35xdAEWUmHRRUSkW5
         rfSViq1wg3D2VgIMLjRgxCCp+rjdAH5smcH07UCEyoeHWIRBiLmbbgHtBDNmOw697cDW
         jkiiu7HxuG2oEllPfSWd8AQbMqzhaijxLakWMJJlpL1Xw80Bj3cWVOtYYCRp1igvBwGy
         rYxHbpCFDCviICoYL5jyVqhm8qZq27H2TsZxtMUMdfweN34XazRjZMIIBQTkiRSq3VIy
         AjoA==
X-Gm-Message-State: AOJu0YysURsWD6TYO6TqSZuW7+d34ClC6hDylkEakV+Z0782fWJ7DykZ
	QUBma0NvRFrpqyCBPgii2H2JRgIhVusHqyMi2TqDiMwxB6aBw7N2+wECbPkDeJoZaxpPosWP0Fu
	t
X-Google-Smtp-Source: AGHT+IHjmWOtEFJJ+ITOzuyv/ljr2O0yBq1VRRHvEb1/SA1/3xR0vcZ1RSkEv7C2Opc3Jv4/UYSn6A==
X-Received: by 2002:a05:6a20:e113:b0:19e:48e7:e664 with SMTP id kr19-20020a056a20e11300b0019e48e7e664mr6974827pzb.31.1707351772103;
        Wed, 07 Feb 2024 16:22:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV11Zo3sUCJMWPgya8d1jog0P15+VyUxaj/KmMlKoiKTEMcra3+QrtE0JGKijQFjRUDII/dYJ1RALGMAg+FfF5JSZCnkYuF22JIw4wf0iaFpi2aiyy0A9P7OxKGkY4D0gxczGpySs2wEvfht5bbpyU4hCCjT1tHMWwwJJzU4l/J2wAF6S8zcEYG+WsR+R3xu7KXeUWHq1a2eNs6PA==
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id g13-20020aa79dcd000000b006e03a640007sm2272630pfq.71.2024.02.07.16.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 16:22:51 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v6 0/2] lib: checksum: Fix issues with checksum tests
Date: Wed, 07 Feb 2024 16:22:49 -0800
Message-Id: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANkexGUC/5XOQW6DMBAF0KtEXteV8djGZNV7VBEy9lCsKhB5i
 NUq4u41WaGKBVn+L83782CEKSKx8+nBEuZIcRpLMG8n5gc3fiGPoWQmhVSiqhrex5+Wbi4Rtpj
 SlKj1A/pvul/bGWkmLk1nTQcq1FaxwtwSlpvnxOel5CHSPKXf52Ku1vYFPFe84jJA6K0Jtkx8p
 JgniqN/99OVrX6WG1PCAVNywTsQpjMe6+D0jgmvmlBM7NH7um+UbOodU21NdcBU659edjZIcKD
 9jqk3JogDpi6mCtYJB1Cjxn/msix/VgL6WyMCAAA=
To: Guenter Roeck <linux@roeck-us.net>, 
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707351771; l=1496;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=3a1VyrDlpdg9fZq+LBjebNs62E5K5JdZfIQyohmyq3A=;
 b=0I9ryIC5Ga5w8HPBbIqElbjVp+XA6/fjwe70Gsazr9tqCITHUm8cwHlsBi5qQ4lTpxhVcPdbY
 5modatIdWBIDil1HWcRJdQTcat8ii7hJJ6jR2iap/A/7AfBebQqGxGp
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The ip_fast_csum and csum_ipv6_magic tests did not have the data
types properly casted, and improperly misaligned data.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
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

 lib/checksum_kunit.c | 409 +++++++++++++++++++--------------------------------
 1 file changed, 149 insertions(+), 260 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240119-fix_sparse_errors_checksum_tests-26b86b34d784
-- 
- Charlie


