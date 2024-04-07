Return-Path: <linux-kernel+bounces-134378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF0189B0D8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3FB281D51
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D66D2BB18;
	Sun,  7 Apr 2024 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MGNEoUd7"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F5E25619
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712493588; cv=none; b=p4Mz7+kBcTMZVt2wiVclcpl3XOPtIIrvNxKov/u743fF/rLWyRj5kAPNkjvFEusRDn1XDRViuOfqMc1AfVoUu2ZOlvInt5GDDZWq6+A05l21IbiazNExS01yhE96PyVY+z1MEqbsZkf7GO2B+aF/KN4crQs8HN+rc43y6aUbplQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712493588; c=relaxed/simple;
	bh=Q9cI46jHROpXEcEx+2Kb3vH9QS/DAv0M67aNROrNxCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=imWrfaADu8cE43g9zkARpwab5nIs35DNswKBsnnB4vWGmXtC2SY7HgzdHFxSf9wt4hYbtqCRnXv9Yc4vK7jT+iYKJphNRm+1GSuaLsyu0yp6OAJfjoaxvFdbNteXVuklwGYvsRpCQ+6qb7kE/hUv1yj85xJFvWcDhsxlfnuJFKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MGNEoUd7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e424bd30fbso167675ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 05:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712493585; x=1713098385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6IuRa8hdLZMnRGRnTZb4QaetvYCU2DguTsJIRtmhQg=;
        b=MGNEoUd7wNQDPVp5PA2Pn3TxDvL/hksOL9qAdgLRvXbJaRBC7+Fkej2f29JGKIdySw
         XMzv7GHVyIOoxfWEEdtolEpVZTHwg5vnxKudk1o28uJeVq+2SpqOJO4wDIrrRFmrXcHW
         hn+1BeCbaNsII6cHzcNdzIwe1otkvD114KWxPCRL/0nHvwsxi1BCADd2eGdX2wBNP9AQ
         ewyyIcRlbYdRO+jq5fgzniydao9eFacprXZaZYyKjfVEJdWvix9UdIIPZV+Z+xp2etdu
         9x/8FeYkKXKATbm31EvbgHl8m13QCc3uAkkZJew9fc2FakpZPv6zAH2dDMxgZfaUj6lK
         ZmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712493585; x=1713098385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6IuRa8hdLZMnRGRnTZb4QaetvYCU2DguTsJIRtmhQg=;
        b=B1TmnBFwrk/EjxKN7X7q/GjAdurUfxhxzn3icRaFphY6kTsuvIXs8Pu/H+KTFpc+vx
         Meo6cXjWZNRsXMGUFg0m6qHfnnwmhQTCkt+2P8M/MY/j/5O3IrqnD//KKEPtg/qHJKk9
         dMA4lytsYwi0vsKApnMMr/DQhoFwN6niT6ucUghgYzu/3ocZFPl28KSRz2ql/io2JSHE
         5iwWPqbIGogDPDwV3GCmL5tugJmpc2egPUh3p3mV+CVt/wHsYJeMBjYXgDfUvVNPw4Oq
         pSZ9MPJE8spbWsfIGIcsfVUe+vjppH7gRBhSeASIYf5f2ySHMVhJwdf5EZxjwtYeO30A
         qViw==
X-Forwarded-Encrypted: i=1; AJvYcCWuC5N5uuw078jEFPOlUzZSR86gwXp+SyqQd9ykRsPQ7/AELC1V5O4u6epr9Zr7kYBWU+HY3gWVUldhKBy2E/SLMt+g0CpFp+vNmKtR
X-Gm-Message-State: AOJu0YwcL60hiUlcra/hB7nAgEu3YGZAaw0TIwtutrB+pdDLFEhssspF
	8x5qdpcZEOvhpXdXxNRiXXomNFIb+4jkMwOrBQoRhgy/MCWIrTyJ2AwCYERF018=
X-Google-Smtp-Source: AGHT+IES+scM9i8kf42aC/wFRIZyb6jz0P0Ddi4JaOD3Ny9vmXFhRZbHDQ5wSOLAP8Vf/nUtTo7nbA==
X-Received: by 2002:a17:902:6f08:b0:1e2:ac0e:b0c9 with SMTP id w8-20020a1709026f0800b001e2ac0eb0c9mr6349701plk.24.1712493584797;
        Sun, 07 Apr 2024 05:39:44 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902784700b001dd578121d4sm4933210pln.204.2024.04.07.05.39.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Apr 2024 05:39:44 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH 2/2] RISC-V: Select ACPI PPTT drivers
Date: Sun,  7 Apr 2024 20:38:29 +0800
Message-Id: <20240407123829.36474-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240407123829.36474-1-cuiyunhui@bytedance.com>
References: <20240407123829.36474-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RSIC-V currently does not have a set of registers similar to ARM64
that describe cache-related attributes. In order to make RISC-V
cacheinfo normally supported by ACPI, through the optimization of
pptt.c, RISC-V can build cacheinfo through the ACPI PPTT table.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8f10a2fb5f86..cc516c12cb92 100644
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


