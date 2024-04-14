Return-Path: <linux-kernel+bounces-143949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1BA8A3FFC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 05:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3C72823FD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 03:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BC91758F;
	Sun, 14 Apr 2024 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gx4hC6tT"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AEB1BF35
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 02:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713063592; cv=none; b=TunG/4y5bSnOgJpSLLA5XfF1fRfRbKEB9zwVUJIpaL3b96azUlVo06Db59SVn0BVVA6JoKadeTB2Jr9EAFMijT82RmabE1fnlXA47r6GLwIBVd3gRwjyL0pdvr9REVImdPqvJp6UWtgbxXbaaWuJyO8Ncnjyg6tlXFp/Hizjn3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713063592; c=relaxed/simple;
	bh=74/j8ENughgKXArfiTJjMj2qv/FhTXWLGElJJX5xuq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s6MCk2y7ca5mcGzuW3KrEdDXHIfoU7+MS12vDGO3gdn39lZ/EkypprQ38UKjOLxcez839IL0M9WTsLu4oFxjMagJBJKksKYV3NK/E9lfWbM/wtPJ8PMqPq8C0DFhRd8WBDyA+F7qspYhJ8tYLmUVVSlG8j0PGsJbPzJ7J13bxAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gx4hC6tT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso1793216b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 19:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713063590; x=1713668390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hheiXqV+1wPbN2r8XTJ5OPePJHFHtIdLdr/kVMTR0TE=;
        b=gx4hC6tT3bhKRz1xEPhKSViTnx1nOQB21g5NfvSI2EQm3xDR7vm9pD8ydWsACFS9gn
         XnEQ//Y/uct6CskUejHsQMjsynCG6QewjfnK/hvaVB7UOrcYjKca5NEDuwX+OhVnKF6G
         v5U8RrrMxs6bJzkTD5ryfKu5l1AkZRRZFlsN1p9y7f8btWqaZFvsksPOt5OQXVbNoVUm
         cKIoA7yZIclUu4jP2+MEHeABg9XjPLtyExml98suZJvbX7PXr/sPlY078cPqSpNB4ocN
         sUQJhO98zQJmkjMDVeJRW0W5jI2q5yN7sz0uOri1biHtPsek/CUwhfjsbIii2zFndTo0
         2U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713063590; x=1713668390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hheiXqV+1wPbN2r8XTJ5OPePJHFHtIdLdr/kVMTR0TE=;
        b=bn3i8sgm/CRyqXd0XMy2yyf4NXInSYkUlhVji24O/X1zYwRhnKGGFiTWBWSSGHVlxK
         e2DSsjpKDU7yZLCBpWlYN/vGIJOYw47xKXeUFxGGyK/CQtGuhd5DBOnL4GpT6pd/ZOVS
         HExiaH4e+OyuzUMas52+OOwQ0j3EiBIXCB5YWAFPFwfdkNmwkqE+1PwiUddELw6gJjD+
         UA0b/COg0iN0E/7Jm13zw8+0Fh6bPN+IhBCBgbvancrj5d+4Weavr3ch0fFRChakAs5w
         ooRTD5cQdRfFzoELPa8f5+fc03aMD2iVj2YcKnDV7AWR6jrGVXIDSE51l6DrGQh5GS6H
         rx/A==
X-Forwarded-Encrypted: i=1; AJvYcCVNamceHlOhBTFbCP/hUXU+6IYH2cvdIM/Jpyyp8wN0y0ZXX4A5u5OD1pnWXMkdTGwaSD4jbICcC45uQ3A6rUz0cnMC9J0ir+rJAIvF
X-Gm-Message-State: AOJu0YxKAVXVRJFRsPMzvzk2Y28iLj+YuioclbR0ACe702LQyNWUUFwo
	zfLW5CvLjUUAjeD4NbzpyuaKM9eLO8Dbn+sIRGAlpj6Qc2NKZKARLFxNeWKOOEg=
X-Google-Smtp-Source: AGHT+IES5ARbziOtU0omIM62ldJV61HnJflISF54CoCezeAWh0dUBTsAEufgLAJHedaFd0waldCY0w==
X-Received: by 2002:a17:90a:d306:b0:2a2:8065:899f with SMTP id p6-20020a17090ad30600b002a28065899fmr4798578pju.41.1713063589971;
        Sat, 13 Apr 2024 19:59:49 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id cx15-20020a17090afd8f00b002a219f8079fsm4799913pjb.33.2024.04.13.19.59.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 13 Apr 2024 19:59:49 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	bhelgaas@google.com,
	james.morse@arm.com,
	jhugo@codeaurora.org,
	jeremy.linton@arm.com,
	john.garry@huawei.com,
	Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com,
	sudeep.holla@arm.com,
	tiantao6@huawei.com
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v2 3/3] RISC-V: Select ACPI PPTT drivers
Date: Sun, 14 Apr 2024 10:58:26 +0800
Message-Id: <20240414025826.64025-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240414025826.64025-1-cuiyunhui@bytedance.com>
References: <20240414025826.64025-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After adding ACPI support to populate_cache_leaves(), RISC-V can build
cacheinfo through the ACPI PPTT table, thus enabling the ACPI_PPTT
configuration.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6d64888134ba..5d73fcaf9136 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -14,6 +14,7 @@ config RISCV
 	def_bool y
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select ACPI_PPTT if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
-- 
2.20.1


