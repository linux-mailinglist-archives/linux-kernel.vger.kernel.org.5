Return-Path: <linux-kernel+bounces-61080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F678850CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB361F213C7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12A8522C;
	Mon, 12 Feb 2024 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BZQ0LUb3"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79686F9FD
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707706539; cv=none; b=Z+0meDHxbuMvR3hFA9FVyRj0BaRNm6NoDjvXcfKjSffxew3cjEGwjA/sn388gpuoOxkebVqbknt7oUQKJ31MQei4LQGPBTDtqvrQZ6Zrb6TbXzEHO/bLXYWMyZs/YI1Q0Yd9tdXOaYCzMSj0WPRxqTTVGfioAgpsTQsoH2C86Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707706539; c=relaxed/simple;
	bh=IaMQ9U5EU7ibbNGTdLeyIyKmzolIE/sYWan1D8m1xQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXQtLKVGgbo5xEkWyOY6DEovJA+9hQDeTsNtipDc/EodrSLxBVphZwJT+TLQjh9JhgeeAy+pZWHW1Vl59725oLu/WBl8FaVz39T5PI1w6Pk0QQ4z+Yeu7m2D4qfVUWMKYNQ9+qffl+opkjPODAkslq7X0qEMZAi83ii2He1D/is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=BZQ0LUb3; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7838af983c1so241469385a.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 18:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707706536; x=1708311336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PK2hM2nZE9ySNRKSB/nk6SwrsE+3tTyo2UQmA0OZOPw=;
        b=BZQ0LUb3v3O9HrUfsj1ReEptXshrZriu2nmMmrdL1GfVzrMorI45Olgm2Na1EvgPPn
         pd7xwKyesShxNrH33csfgkBbWkXrPMvDmZan3ESNWq3uhraTKlyGmChE9RsB/Asv8NmD
         uqnpexoLZb+JNlN4o5VauLAC4GwAoTAOG2fA9iWISXcMRkLv0XFIB29KfxVMtdoayWS+
         sWSUQkNEXtYwUDIqhwxbr6EMS9g44AU5nLVO7h4t7QR9+I8H5T+vuuIooBwDZLgCzxgR
         Tl6AbLC7v+3VxUhyHOOZukxkgc5oQW5FRMmgczhjdveFSBE31CTD8lTdW1opTd25P5AP
         ipag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707706536; x=1708311336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PK2hM2nZE9ySNRKSB/nk6SwrsE+3tTyo2UQmA0OZOPw=;
        b=cQc+CGEgeYmb8/n9x673gMCfxP7rUB/NF80Zctux+fi3NQSBYLMLnoOtltD8iViFsI
         +xhIeVaHS/j/Ty2Oc5nqIN4p1WX4IHy9AsGvW+/4IGPDsdFlT87yZ7pYaheFTUMIQlGX
         lSdLSv3CNgeNCpu2qPvOYHjWYrqE6B4pCXfywkKk9qpqgB2jQbIliWWPWeWF3+yc6WE4
         VuShbdtl+sn4ZE5EspsOUcJsH8xb3J1k8w0h/3WtWzlssVd45oshjcX97AihnW609E1R
         k0cI6jQBr5bpEVppwu/Ic1EaFNufZowB5O0UPgj/PVvPWVpCEr8OloauHCqD1ka4VSIU
         hCEw==
X-Gm-Message-State: AOJu0Yx7NB74OhoCBCYHKc/6+AUYO8PueGZhHud/sUoulnzWeqYEH/ZG
	Q2piBe43KWIZgYHsOv/EQEO6DUnC0JqH3MyNT6pl3RiMfQ5g8tS3ek/g9uOxsvM=
X-Google-Smtp-Source: AGHT+IEJZiiN+n5FqhSyHOC/KRPz1kIg5v3LNtLiqUhxBX3/4QKShWOHHV0lSJwdo/2+wfJXwKlCGQ==
X-Received: by 2002:a05:620a:4492:b0:785:afa3:6c0b with SMTP id x18-20020a05620a449200b00785afa36c0bmr8529739qkp.52.1707706536469;
        Sun, 11 Feb 2024 18:55:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+KlvTiXx022Iyrq5kcQK+MzTTlcaxsSbYU2t+6MhI5RpPjrlocOnjYKK/WCv3H83/9SWx7WX/BFI+bbrFB0A4cr9omAmYvnt7rtoYc7xaGrWDlBZz5xD632qkgPpJq6IWM1seYeIr
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id lb3-20020a170902fa4300b001d9af77893esm4906443plb.58.2024.02.11.18.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 18:55:36 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 6/7] riscv: Use offset_in_page() in text patching functions
Date: Sun, 11 Feb 2024 18:55:17 -0800
Message-ID: <20240212025529.1971876-7-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212025529.1971876-1-samuel.holland@sifive.com>
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a bit easier to parse than the equivalent bit manipulation.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/kernel/patch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 9aa0050225c0..b0cf050738aa 100644
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
2.43.0


