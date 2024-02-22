Return-Path: <linux-kernel+bounces-75810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BF685EF58
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3B31C22170
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06C9168AC;
	Thu, 22 Feb 2024 02:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="veJjUlJF"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4153211C82
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708570606; cv=none; b=fDQn8w4Cce2CVZ/WCNSpzfvxARecJoQPWrYf1VxJVYoCfadA28Q9uTqQZQ8Ax8hDP7mtvSLtSEh5ggPNjxTy92Nxkh2DoeaXKdxBdfHjEaGWe7zbehFx23fXXl08Ik+n0h33nybsucN1d2ttebv1jWUg6X4VBxL8JASu75b9TIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708570606; c=relaxed/simple;
	bh=cjbzk4J6RBFDSQitJ9tD7JhJ/5XIpVvg1mXNgJPsdS8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dWA3gWrvStj9DbaMo3dYf/ENH1DgRCRrXE6UL7kCxXfmzNDOFTpf6KtwNkeoL/FhjOw+EPlmn/NiylLfQ64raA1BMynxUl48NVvUdzncUByOiUJl1Zwd0xqzw0uoEtCyZoUl65yAF4tmviRZrtseV260mRsBcxMx5fqYnM/AlQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=veJjUlJF; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c132695f1bso5596663b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708570603; x=1709175403; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uN1z+8L41UbmtRlLvYsYRzP1jZi643QHg8Pfax3eEzg=;
        b=veJjUlJFVAJyM47toJAKsTrzMnVCJzgBwV4WAhHQC7TySiOglwkWMSrGE3Vs+JeEwE
         iuQ04rLFUi2XUMarX6/UQCoJqHcwI+uakqz2XG+rGkUMnZPrqY+6+4IaTDNjEVSqwhiy
         EJrwukPwE5T0wvEifYD/CNn1Xn5TFgORiwtTLiWk/MKOwkU+kcGFVMkaS6qeZ6u+TuNR
         4DfeTJpWlLpiuJ9azsC6Frpf1SM4J+bZFsGKx7pb/F6YlROjM+wHb3AsPK00f7DSCjDA
         PzetmJsOYl7FhUswPwFarUPju6oaMEkiAXbIAe+lAR9oVx4o6FS1cHUqcyPnLRJIYU/B
         bz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708570603; x=1709175403;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uN1z+8L41UbmtRlLvYsYRzP1jZi643QHg8Pfax3eEzg=;
        b=n4kqD2/Dgu+o2aErwlW8ZfgAsqgVKcO5XvV1bRZqLJupdLJAMKkpMKoDLr8f9EaaMK
         faOyF94Tue5MFb4ONGyg67V6nnVdiyEG6nP/y9M9qTHkW6dK4wEF4hzJtkuyyzjhPcFH
         X3Sg9Oyt/wO6qjkDMucJ/CeSHw2AqIyeO/klYCE2mJuB54bGnqBLKANZzgUYA2kUkwzt
         vkS8kp9ubrPYUVMlyDEPsEOQEGOapmktXn2Ms50PnMwaGtvVR5+tBbWt+pFUPWAqleiH
         zCk52o6Tr4Kes26wCBaXotZYp6yqTI3WWT+xH8n4dPyVi/0bvxqt7NAHamYy4bb62Qb3
         knwQ==
X-Gm-Message-State: AOJu0YyVGhh7gPIyvSdf0K+Px4tckH8IrStOQFkgOGAy+jCxf3g+REsQ
	0mVN4N3mRSMSsej/EjLA7jeFQ49bj6hFxVsUamlQ43atpdmsQ5LjxAVSSCPAzBk=
X-Google-Smtp-Source: AGHT+IEhMe8BvYwTDszeyAvwGN45JNsdUUaq9iWz1FcmMo2hc1xvpUL9o23e5bNyEjBUWo6RZt3ddQ==
X-Received: by 2002:a05:6808:1205:b0:3bf:e15d:a6b5 with SMTP id a5-20020a056808120500b003bfe15da6b5mr27542614oil.13.1708570603425;
        Wed, 21 Feb 2024 18:56:43 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902f28c00b001dba98889a3sm8797521plc.71.2024.02.21.18.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 18:56:42 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v9 0/2] lib: checksum: Fix issues with checksum tests
Date: Wed, 21 Feb 2024 18:55:48 -0800
Message-Id: <20240221-fix_sparse_errors_checksum_tests-v9-0-bff4d73ab9d1@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALS31mUC/5XRy2rEIBQG4FcZXNdiPN7SVd+jlODlpCNlkkHT0
 DLk3Wtm01BcOMtf8Ps9xxvJmCJm8nK6kYRrzHGeSuifTsSf7fSBNIaSCWdcsK7r6Ri/h3y1KeO
 AKc0pD/6M/jN/XYYF85IpV84oByJoI0hhrgnLnXvF23vJ55iXOf3cG9duP30AXzvaUR4gjEYFU
 ypeU1znHCf/7OcL2f2VH0wODSanjDpgyimPOlhZMeFRE4qJI3qvx17wXldMcTRFgyn2d3ruTOB
 gQfqKKQ8msAZTFlMEY5kF0CixYqo/kzPdYKrd9Nb2qgzOpKuY+mB2vMHU++wugDOjElqoimmOZ
 ss+TTGh/DpDpUH28M/ctu0XL340QB8DAAA=
To: Guenter Roeck <linux@roeck-us.net>, 
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 Parisc List <linux-parisc@vger.kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708570602; l=2263;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=cjbzk4J6RBFDSQitJ9tD7JhJ/5XIpVvg1mXNgJPsdS8=;
 b=Uf8xN3VqZLdNSas1slUX+L2YIbZvveVjojsmX2060OGD0y8b8HZjfOfNilvWrpPLcZI8+wL/k
 0ghrhw454+6Cx5V+BbMiHRsR1icwdKuMpf2zOacsihg8bNCzfZ6TJFW
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The ip_fast_csum and csum_ipv6_magic tests did not work on all
architectures due to differences in endianness and misaligned access
support. Fix those issues by changing endianness of data and aligning
the data.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v9:
- Revert back to v7, the changes to v8 were not needed
- Link to v8: https://lore.kernel.org/r/20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com

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

 lib/checksum_kunit.c | 396 ++++++++++++++++++---------------------------------
 1 file changed, 136 insertions(+), 260 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240119-fix_sparse_errors_checksum_tests-26b86b34d784
-- 
- Charlie


