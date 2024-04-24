Return-Path: <linux-kernel+bounces-157303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D539E8B0F92
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C85B2B21AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A26A161338;
	Wed, 24 Apr 2024 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="b6K8kUnE"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B224A1598EE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975732; cv=none; b=app7+TvJ2MAJ8s3755R+HaHtIdWDLp+y9KZgICsD8+cextQ1cuy2YfJxrkRLySi10ou8flDVgeUi4ZGmiMEgZDXvhAeYy6k0R3CbLpFgJ9rvnqh9WTW9VM2sd7fCygYUu4WzG4P/G/mGzhOJXdxIghFksMb96Var1MfI7ZKj9XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975732; c=relaxed/simple;
	bh=BBjNbbZnrij0HVdKgO+X2yPDVxdOBtm9/R4eVQuo8fI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MHaEJu8f1f87yOkTUL4RpGtECdB2Hjb77uSl2+AU1SHdbs5So+insYkSRNA/NsY1JToCNTafs/vVqwCQWr7o+cNyCRmHKiLQIGswf7VdKW7bWpcxpKF4astDBXdgVnS8EVlY3EEF4WHH8dHYgxvKPknNeL+vz6TM1tc6DDya9t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=b6K8kUnE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a78c2e253aso69734a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713975730; x=1714580530; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GNIeOZiS9nBIx/zhnBQ64j5+1y87GOcgImJKTHZXk3c=;
        b=b6K8kUnEcdqQGgQ6h7fKVHJtn4uwGWlMzXOZg3PLRWWFD7ZbETjUR4A8N0YzgLzA1G
         lS7FTPwIv0ziM7QfFCZlxFx5V4fWmGSmJ/6XLDnop+iGgtP//l4G3/mSl9+ib8meY9os
         eJ0esbj3PyDwIy00H/A0ryMLV+Xgg+58RZ2f5czbimH2dgCwxs1l8WlyO/Win+5UQ1/L
         dejKtZvgc9sjKehlyu2c25iik/3ui/RhQZVpIgDscbpCNjntLhCZYTOlRktt3aTjG9aH
         XW6YvWOSdYSWgHSlZQpNrzcy+rvAPQweh8chyjiFbBOy0KX7up3m9xEgnZj1nEkYOU2N
         Qyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713975730; x=1714580530;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNIeOZiS9nBIx/zhnBQ64j5+1y87GOcgImJKTHZXk3c=;
        b=JtKxSxEOdWf6ZhttLC5KhHgZgiekavplC/Qinc+Uge4vXz2y63tOk1AZu75IgjyEZm
         ITGzAth8Abcv6+LGd6qUoTAYvNes9CpFCvWJFnv4y5+pgQfNN7kMtj5DmsClEI4a1lYQ
         z0/zZDx797b2/svLivASDNngUryCBV/Lioc2LqwOZ7a+ptPu5BqLY2m8KF9jvaW6OaXm
         HNuemPnv4z1yqGshnBUFAQmi4+FRmY88y8XssOxYh/w5DgBM25rWCN3c1NQGqDAd3c1y
         SPF8sHUbxv/EssaTXYvNaxktmPeFm88OOIYC1vkJ+cZ3cqFADcKJd4AQSJIiX7qjmtAs
         DbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRzSQe4fmpzGY5DxEHZgKStu9SfucJpR84Zsh0ujcAjkQ9JRDYFM1aDKn63A3D1QyZjPYnNeZhH0xqoMTO/4wlR4yOtn9Yp2oyQaWD
X-Gm-Message-State: AOJu0YyTRECwxTEKI+UXm34EgRwi8KdltC89J+JuJ2+4gl2h21x/INwZ
	0C5kMTg5szYZ5ObVWojsJ/rSmlx4qXQrNMAw080WVS+INHYX3LCYaxfii858JM0=
X-Google-Smtp-Source: AGHT+IHGXdidgi2yVqRH2s5g5jedXlF5Xbr+JP531Jndv8iVqLWnsM7Pli5LuTsPhKZYju9fYWCceg==
X-Received: by 2002:a17:90b:1e03:b0:2ac:7a05:183c with SMTP id pg3-20020a17090b1e0300b002ac7a05183cmr2600490pjb.10.1713975729905;
        Wed, 24 Apr 2024 09:22:09 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id s8-20020a17090a1c0800b002a610ef880bsm14505760pjs.6.2024.04.24.09.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:22:08 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 0/2] riscv: Extension parsing fixes
Date: Wed, 24 Apr 2024 09:19:53 -0700
Message-Id: <20240424-cpufeature_fixes-v1-0-585e73d2226b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACkxKWYC/x3LQQqAIBRF0a3EHyeYCWJbiYiyV/1JiWYE4d6Th
 ofLfSkiMCJ11UsBN0c+j4Kmrsjt07FB8FJMSiottdLC+bRiulLAuPKDKGwzw+nF2BaGyuYD/lC
 ufsj5A80LfcFiAAAA
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Evan Green <evan@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713975728; l=1536;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=BBjNbbZnrij0HVdKgO+X2yPDVxdOBtm9/R4eVQuo8fI=;
 b=vuBH8zqF3F35tZsdXWL7gEJ0v5OT6H3bR4Qv3pePKjdqxmegKpYuAYsfgUmDUffPVsIHQhgh3
 Z+QOxdKNPlWBtMXQifiFp5CZjY+NzuRCZu7zsrPTMG9CKq9JUQzugwP
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

This series contains two minor fixes for the extension parsing in
cpufeature.c.

Some T-Head boards without vector 1.0 support report "v" in the isa
string in their DT which will cause the kernel to run vector code. The
code to blacklist "v" from these boards was doing so by using
riscv_cached_mvendorid() which has not been populated at the time of
extension parsing. This fix instead greedily reads the mvendorid CSR of
the boot hart to determine if the cpu is from T-Head.

The other fix is for an incorrect indexing bug. riscv extensions
sometimes imply other extensions. When adding these "subset" extensions
to the harware capabilities array, they need to be checked if they are
valid. The current code only checks if the extension that is including
other extensions is valid and not the subset extensions.  

These patches were previously included in:
https://lore.kernel.org/lkml/20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com/

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Charlie Jenkins (2):
      riscv: cpufeature: Fix thead vector hwcap removal
      riscv: cpufeature: Fix extension subset checking

 arch/riscv/include/asm/sbi.h   |  2 ++
 arch/riscv/kernel/cpu.c        | 40 ++++++++++++++++++++++++++++++++++++----
 arch/riscv/kernel/cpufeature.c | 14 +++++++++++---
 3 files changed, 49 insertions(+), 7 deletions(-)
---
base-commit: ed30a4a51bb196781c8058073ea720133a65596f
change-id: 20240424-cpufeature_fixes-91bec4d793e7
-- 
- Charlie


