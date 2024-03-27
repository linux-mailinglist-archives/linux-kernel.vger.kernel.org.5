Return-Path: <linux-kernel+bounces-121607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D284388EAC4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881B01F3171C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C456146016;
	Wed, 27 Mar 2024 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gr8GI7Uo"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBCB137907
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555532; cv=none; b=Z0ha+ZRhQXrNrHXyB8GtrZugBmYnYefv8Doiviq9TFn0NptwjDHRTuK2sj3Z4vCTHdUse6BRUlY492EZTMv7CiZz0MDumiKbXcUZEq/dsOh/codUy9Bi1ZcZnMUUGe7cbiua2dn6Z2pEWRPqx8j44rSM/ejzfKoFRa1xaZOtyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555532; c=relaxed/simple;
	bh=vl4qO9v5O5u/rqOA308hFsVWnPwODsir1st6pltlE7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zmk8xebOQ0srFPyIPbTtSORL/NtGSlgjVgJqCFUty8Kvwc97DsSVLttZbKq5XidPKtZLv3bzXVfJt9/GFrYDe0WXJfaXVs9vp7DI+2KZN2Le8I2Hi7319OJ7qUWZOTkRJWGcgQrde0un8Y6Sw5p8aF8Pv3WURVNWvuK6Q4lzR80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gr8GI7Uo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1df01161b39so56943175ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711555530; x=1712160330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Kov3PdEwmxTDPnCfMLEhtVN8PjsiHGUhl+QZHrnJpM=;
        b=gr8GI7Uob3kH3JMEbNyw4J5Q8VP9rKqluc1BEsH4DKz/jnsqf3C2QtHnyX9u3E804k
         6H4LHP/8mq+nt+7Bof7eqdfczXjPbQaIE+tcccxzj3ek973WKqNpAq2Afpn8H2tH3zz3
         Wn0Dtf7QLFbP4BXDQt5NeIVpQlnLqNSLPlOIo87BZOgT+d4Ct0A4O9AflVF3cqsr5k8y
         z7fxLUfkp26QoVIMW0lx/pVv0iYXsqAvCKG+m+wuEh2VFGBtjveKxmh8qTwIj/0mQXes
         RPwU5tQnp9CEtmcxv7pcFRk9pSzaTQoBNSJX4lCzFvoMR8XGZFckWarVf9qjfLvUOQ2I
         8uLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555530; x=1712160330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Kov3PdEwmxTDPnCfMLEhtVN8PjsiHGUhl+QZHrnJpM=;
        b=C7w+wkkZOB8KidR4a5X0x6a/D8nLEuieidCL3FF7TcpWJ6GMT8MQQFKmkSfpspHmrV
         M2fi0LDQTz/3ITtotnidCZRi0rMBafrs7MTh0Qa9fjybr2PDmzhiWOt/qlw5EQe1WYxv
         QV9bnqsompZcuLhqyTtnqmn9qTARF/a2Ei9iN9mJoCzTmbR8uKztlzIlGI7mQRDSorUA
         aZFMmZzjd1loO2nR9vPijLoc1yvtp11nNpgujzei6LkYMIUZHemB3in2LekmDrSg5pL+
         hPmDdy2PObojP+157enmzAfPLFZambEP8w6mzq0aEW0N0KuuiLKtqfw9GwFuIjyt2+FG
         xYOw==
X-Forwarded-Encrypted: i=1; AJvYcCWNicICmvVaHSMsBOGVNl0I0vw5znnLv7toywlbOPs5jJgg0hidb3hfeerHXL7OZONtZmS52OoYI7TsWAsMHSyfWoanNn+ycgHRy27B
X-Gm-Message-State: AOJu0YzN6BuKMwZHWJDvvsO0ViYtffwOTwrqD/YPjNwefr/XbPoL3wOo
	D5TVqBBDlnK7YNBjhdE7Y+7twL610vBe07QCCS5CX7cmOYZkuDtyGI0yRMkU78I=
X-Google-Smtp-Source: AGHT+IE/3RrmK8SccBkrnois/GdB5+EKW8GlWLws9exiXDtK106qyPALy+gzO7adzUXL5RZSyOOPLw==
X-Received: by 2002:a17:903:2b04:b0:1dc:ce6e:bf06 with SMTP id mc4-20020a1709032b0400b001dcce6ebf06mr184008plb.0.1711555530628;
        Wed, 27 Mar 2024 09:05:30 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bf4-20020a170902b90400b001e14807f9cesm1718226plb.125.2024.03.27.09.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:05:30 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 6/7] riscv: Use offset_in_page() in text patching functions
Date: Wed, 27 Mar 2024 09:04:45 -0700
Message-ID: <20240327160520.791322-7-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327160520.791322-1-samuel.holland@sifive.com>
References: <20240327160520.791322-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a bit easier to parse than the equivalent bit manipulation.

Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/kernel/patch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 243e1573410b..cfcb9926e722 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -54,7 +54,7 @@ static __always_inline void *patch_map(void *addr, const unsigned int fixmap)
 	BUG_ON(!page);
 
 	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
-					 (uintaddr & ~PAGE_MASK));
+					 offset_in_page(addr));
 }
 
 static void patch_unmap(int fixmap)
@@ -65,8 +65,8 @@ NOKPROBE_SYMBOL(patch_unmap);
 
 static int __patch_insn_set(void *addr, u8 c, size_t len)
 {
+	bool across_pages = (offset_in_page(addr) + len) > PAGE_SIZE;
 	void *waddr = addr;
-	bool across_pages = (((uintptr_t)addr & ~PAGE_MASK) + len) > PAGE_SIZE;
 
 	/*
 	 * Only two pages can be mapped at a time for writing.
@@ -98,8 +98,8 @@ NOKPROBE_SYMBOL(__patch_insn_set);
 
 static int __patch_insn_write(void *addr, const void *insn, size_t len)
 {
+	bool across_pages = (offset_in_page(addr) + len) > PAGE_SIZE;
 	void *waddr = addr;
-	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
 	int ret;
 
 	/*
-- 
2.43.1


