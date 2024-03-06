Return-Path: <linux-kernel+bounces-93585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B20873212
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3221F20ECB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA6860B87;
	Wed,  6 Mar 2024 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JXucF6vb"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E81160912
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715404; cv=none; b=GWO8+kKVdTdiPb1KW8XovTq4ocv4qOZX8cZkPIn74ID9isF8VB6Vz3kILEV6+h7M2Q7Jf580RgoEzqOMy9LuXgbNLsCfelX0ipVddIVVM04TSZDHqIqy+g/Ql0Jw/SyAm7vx4YO4436SI00kgPaAY6zYslXXf+rk0zfN4Fs/wV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715404; c=relaxed/simple;
	bh=a6eeGsVPbJ4geGSegwTUJJlLAqhxpUbQgapuYeVQNSk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rUSmWrz2v6STP8nIQ049VukY0PEwYVSjJrt2WOrq1SEgSGwFulKnZc5yLsrQ1Q2K4irX+PPtcJx3EX8wWiuMm1A+ynTW54ReNL1Hl4EgYRHtl9rzKDQNaYaFairYaAyi/VhoadN2GmDRu8kk+8/7rSYh2yjHQMSr/XsYrkxidKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JXucF6vb; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6419cd4ddso1218321b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 00:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709715403; x=1710320203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRr7LxSbEFR3x5uzGtBz3X+EqjDvEmVPS57p5cg+Ap0=;
        b=JXucF6vbVt404QQBuRHWHlD/HxH9/eQ5hH2OSoVPOjV5fZUzaCt17Fre8E3xn3rha8
         FNr3iCD330095bPlqG0Y4kUcSQJFCQnXugkhG3LK3lc+0cneJ4xiA/MIcVhWQDpQTYkM
         OnZigoRTHFv9NNMrcPwDoWUCvlS/UYfbMBA9D/ODVTCVOc9DSS2lkjKZnfXjYImhn7H9
         XdTy1/n9TbHYzmxSvp7xuW7DvFYUxxSx5Q4Rqa+d0yJjKawb5NrS86uKOjyAvuYxErJ6
         nLyNiwjXHVrvhkZ6ApFQYCPatz4Jdz+o+gPRnLaOAeGLTDuxi1xHQ9H668TpUF7/gbeM
         2IlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709715403; x=1710320203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRr7LxSbEFR3x5uzGtBz3X+EqjDvEmVPS57p5cg+Ap0=;
        b=REBhSagHQjbaWkuXj2OxQdH97eHncM2Dzpb2Te8crwu/VdL3fS8bvUUPbrrTnQfOQd
         PIaSb54vBYJ4cZi5KtzkbkVRsZXb9BOselY8I/JEwTib+UbGzp49FXvpX6PBn66eSDef
         pkVNutadoCWZ3VK7zHYPsX/twQriZEJKzKPmyUGvZrVWJZUThw7mqz8cpL7+6xX/DpE1
         2oaT5wMB/SoS0LmQVlK5d+WhYN2kj+kXi13Lu2auGGVkwMYyAs5o7cwhWNE+jKAZiVcI
         id/og/tVNSyu1xgFMWHY3QyUD28nhZF4c85Kr0O8MAju4UU6wPatF4QTtrLXCPYIoBMm
         uezQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl0UDsMFvE6Cu9SNK8aoo0AyvvltdgY1vprqyNzLGP7+aViInCvRCdR6sXn/jzarB6EaLvdAUdKMYP5Dlb5qjZ+2Mj+f/4mAWMFrOS
X-Gm-Message-State: AOJu0YzpZcLWKWtZQeTLBFL02hGKBTRHpsj8LwnIIJN1uJHybOlVSSWb
	EWHNaE2y9Bh2WmXoMb7mKP5HqLUBeVvIAe+Q1VE6mmu3HwbZSItah6yklveYnNTGTY7ZgKKCbek
	UDfs=
X-Google-Smtp-Source: AGHT+IEzhVmTzXyIgnGWoxvhwL9j1MSvK9SInEe+8cuDZjgq6TdrkmluNqbtPfM9F2D3l0tBwG18Eg==
X-Received: by 2002:a05:6a00:2354:b0:6e5:80a4:2ff2 with SMTP id j20-20020a056a00235400b006e580a42ff2mr15831466pfj.30.1709715402744;
        Wed, 06 Mar 2024 00:56:42 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id o74-20020a62cd4d000000b006e58663dd0asm10740071pfg.110.2024.03.06.00.56.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Mar 2024 00:56:42 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	cuiyunhui@bytedance.com,
	xuzhipeng.1973@bytedance.com,
	alexghiti@rivosinc.com,
	samitolvanen@google.com,
	bp@alien8.de,
	xiao.w.wang@intel.com,
	jan.kiszka@siemens.com,
	kirill.shutemov@linux.intel.com,
	nathan@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH 2/3] Revert "riscv/efistub: Tighten ELF relocation check"
Date: Wed,  6 Mar 2024 16:56:21 +0800
Message-Id: <20240306085622.87248-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240306085622.87248-1-cuiyunhui@bytedance.com>
References: <20240306085622.87248-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit d2baf8cc82c17459fca019a12348efcf86bfec29.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 475f37796779..a223bd10564b 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -143,7 +143,7 @@ STUBCOPY_RELOC-$(CONFIG_ARM64)	:= R_AARCH64_ABS
 # exist.
 STUBCOPY_FLAGS-$(CONFIG_RISCV)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
-STUBCOPY_RELOC-$(CONFIG_RISCV)	:= -E R_RISCV_HI20\|R_RISCV_$(BITS)\|R_RISCV_RELAX
+STUBCOPY_RELOC-$(CONFIG_RISCV)	:= R_RISCV_HI20
 
 # For LoongArch, keep all the symbols in .init section and make sure that no
 # absolute symbols references exist.
-- 
2.20.1


