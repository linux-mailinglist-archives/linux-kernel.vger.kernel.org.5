Return-Path: <linux-kernel+bounces-36099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9E0839B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87081285BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048384E1CD;
	Tue, 23 Jan 2024 21:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GNrGcZk8"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261524F203
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047091; cv=none; b=htNfVACjFCovBw/gCr3C8JU0Qv1x/MsO8tDwN4wsaWJ3HaoOVzEa3WfVGOuN+hcDjhwXl0QZEfLaZOoENqkmYR5fznGiOUpoROIZhtxuiPKgrXZ7+N1cTKjAyJoiUdBodITW8umGEdtwbe2Hb4JTXTzFrTqWoPNYm2sx/D82PdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047091; c=relaxed/simple;
	bh=MrOdGziCOK1xarR6/oqOYc3VBHKFUS4gtSlwl86rzuY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Eae6hflxSXoBn1mKLB+Fml3NpLeilkX077U1J7jDqKfbrCVsWg9irk0AGXWAs6WfeXkGDzR8+UaicSGo+ByU9bwfBbRs71uULZvOG1rYpjpRQADNUQaf8CANq4VcHERkiL1U6QBJFLq8Zrq85gNZAgFsOyUhPrZciZJTbYm7JVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GNrGcZk8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d76943baafso13938055ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706047087; x=1706651887; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7GwzcyJ1Buk4/W7IcnRs365SoffyuJd8o2s5U+vJoSE=;
        b=GNrGcZk8u40xL5xAIiL7o4u64L2SMZ2ppqTmQSA/ANCs+rRzEMfhz8CXbgD6lgzQ/Q
         SYBQdWlhcUV+zWJlYe/FeVSWldL7vFEOB35Ro0+hfd+ZRjTuwIcxJ7EkahmoDB14Op56
         6E6Yfig0B8O1Xnqv7lE2ZQ5VUdQtKxyGi3tTylct68tIBGESBX6VgR6lwr+dFvhixBNo
         X73nI8QNy5JQRG+Q6uDWc+NykjtlvQu3PzwE6rEilXbesc3yfDocbpYIFQ+v1IHtsFNv
         b1j2Bnbx9mrfDzgBJgeNpgnTKGbWZDNjNpLCzBZt7ogi9lOZhAGdZmUaKEu3E2eITPie
         3WQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047087; x=1706651887;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GwzcyJ1Buk4/W7IcnRs365SoffyuJd8o2s5U+vJoSE=;
        b=CYtQ+ebczzTjHomBWs3cR5kYJjxxcVhyVa048dnk8JjkVgUlt92cKi+l5NKd2kShiM
         J3bTU50fJxUu2ttfkUuBOjBvUz0EDjrC+eG3qfQQLHHBGZFHYnsPdoF8mQUjGisogXzE
         pZ7tkqW+PrVfwvA/iZi6MIMGSdOBcj6wpYAmUByf0tyM3c89iVEcGOOOy+KEKMXkmD68
         k6YiUjlsbTL2nUnWD0BwpPz/EBdt3iAImp56AWCLLtL38n2+WQ+Qq+2H9c0itkrS71TC
         Yeaui8swVH/pUwbgYauByAQB/RRwEUh3MALEF4/u7mUxnd5AkLnIl2hl1qzErWT/fP2D
         waKg==
X-Gm-Message-State: AOJu0YzB8uc56ykedoUS0LIZ7Vv0Pfesn6GDD1FUfPxJahYZvEA16n2V
	/sPPOXooOxT8KtKbfB60puMxkQlRcPHfj98O6Vs8TcHwdYGJfoj4J+fSNmpDZm4=
X-Google-Smtp-Source: AGHT+IHquh5Y8gmj1gsBkK2jEO/1TTkyEy7mponjA460CvsMZLzuZ7HLB2G7d0zdN5kMQZsKAFet1w==
X-Received: by 2002:a17:902:ced2:b0:1d7:6da2:89d9 with SMTP id d18-20020a170902ced200b001d76da289d9mr1587697plg.136.1706047087125;
        Tue, 23 Jan 2024 13:58:07 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ju22-20020a170903429600b001d755b10448sm3661429plb.199.2024.01.23.13.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:58:06 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2 0/2] lib: checksum: Fix issues with checksum tests
Date: Tue, 23 Jan 2024 13:58:04 -0800
Message-Id: <20240123-fix_sparse_errors_checksum_tests-v2-0-b306b6ce7da5@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGw2sGUC/5WNQQ6CMBBFr0JmbQ0tBKsr72FIA+0gEyMlM9hoC
 He3cgOX7yf/vRUEmVDgUqzAmEgoThnMoQA/dtMdFYXMYEpTl1qf1UBvJ3PHgg6ZI4vzI/qHvJ5
 uQVlEmaa3TV/V4WRryJqZMX/2xK3NPJIskT97Menf+oc8aaWVCVUYbBNsTlyZUhSa/NHHJ7Tbt
 n0BIH6KNdMAAAA=
To: Guenter Roeck <linux@roeck-us.net>, 
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706047086; l=815;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=MrOdGziCOK1xarR6/oqOYc3VBHKFUS4gtSlwl86rzuY=;
 b=vqwgNWbeQSBIhDibFxyrxsgoW1CPAJRf0LlRrKPrvZiyx51fdAwmzkuKxGjDu4aTV9NZfeo+H
 Zh3FlxWfkCTCXNmMTLK3DIhOCATjPTqLZEbgm4vgBwNMe0BJwhXc/MR
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The ip_fast_csum and csum_ipv6_magic tests did not have the data
types properly casted, and improperly misaligned data.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v2:
- Add additional patch to fix alignment issues
- Link to v1: https://lore.kernel.org/r/20240119-fix_sparse_errors_checksum_tests-v1-1-2d3df86d8d78@rivosinc.com

---
Charlie Jenkins (2):
      lib: checksum: Fix type casting in checksum kunits
      lib: checksum: Use aligned accesses for ip_fast_csum and csum_ipv6_magic tests

 lib/checksum_kunit.c | 460 +++++++++++++++++++++++----------------------------
 1 file changed, 203 insertions(+), 257 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240119-fix_sparse_errors_checksum_tests-26b86b34d784
-- 
- Charlie


