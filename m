Return-Path: <linux-kernel+bounces-121608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7AA88EAC5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721372A5C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73820146595;
	Wed, 27 Mar 2024 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="G9/7BIXL"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E021145B17
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555533; cv=none; b=gD5dmM4qS2/1TEIgFpJfrRZ9zsM6UyjAbhFQM2RxLhgFOkP6jNpWU41GrkYbAFDTz658hHi6FHIU/HcN3RaIh5tTiRIH2uQKloHy4MjSKTv4r0WlITdbnH7FJOWYO6jKD7ANLEiGDjkrIrp4YbiEONQFCCMuJsfPGFEEYI1651g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555533; c=relaxed/simple;
	bh=WGczTXzBuFo89DltnnNjNAEWyViw0TD0N06kRz7Rv6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fn+ThMSrmC5e+LQQL78sFxzIaDkjv6UmJvsq6fRnfioKFDXz6GXAZ1fgGGmulx81iN0STo4XfstFk+L3l2xs2WAdt0pYNWex9IapH3GU6WdhEiF0TrM/oF6cjxWjg5e/uBI1EK9+h/yxUXuWPUiLVU4zTN3n6TqsxVEKB3MTdRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=G9/7BIXL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e0189323b4so54072135ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711555532; x=1712160332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTir40frdJeiV9LGmiUfO8UY8kCkwqA6MXq/cDxcl6E=;
        b=G9/7BIXLMqxoyF54WYlCSiyyPLwjkaS44JUzhwo8nb6AgeIrL/fk5/54izSa0WIz/6
         dj+y1r6sI1j/L7axOkxF7nlTDwnIuzmIKpbW3qxd8YkSBhgBtXfrmrI1/m59Ghxcmqpa
         ph2Juxo/04NAIjvwJm9s4VShyYeVdxlns04n45z09o6uRwH+P8JPn9j2c+bcP3LZFg+z
         PQWGZSeiNd3Pj1mh089ARSZi4niKGVc6Ykc+o9pA4Z4bDWorRs3WVW/SGSlVRHB8g/a9
         yjfTsCYzvP/cUGPR+9ts95Ld4I9fjuxvAhXUbk8v/yRpPco0aO7Q2C9Sg6QGDUq8wA2f
         CJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555532; x=1712160332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTir40frdJeiV9LGmiUfO8UY8kCkwqA6MXq/cDxcl6E=;
        b=ezyPeh+7VDtK7YbyDiYYaUELmlykbq+H9fdwOs0qtQifRpYYRIobNCxWxM/us9EAK3
         BAXhaOjqSj1WOgSMp34JGSxm3UvbhPKM0zWCgfQQImw91r+u4/13KXiouINRLep9Djea
         070DEX/+KWWTZSGnJlE6QTtAo7aM0kF6mCj8tV83yK7EADqflA0X4FX9NVmED9Byix/N
         a0IkkaJDVkJ4WpqPsCKX0LRzfw4WAJcftdiqQ9IG2Oavt2vc5X9QEC6psIlbpDw8Msnm
         g0x0Zlns3SNVzsIBqY2nNXm3Buo4TpQCwW4gtH5huXriXL8BPBxNhmBVcIDxaGJXnPVb
         xdog==
X-Forwarded-Encrypted: i=1; AJvYcCXEws0zb2ZROo72GRutZxM3nxDGCDsUHUXkVzh96Hm56kEHc1TACQSSvFVy8IBjd4eNrVJrxTH3xMQl2SgLL/9BSDNKXczGs9CP9zZq
X-Gm-Message-State: AOJu0YzIYsnbDUMFnMYgNajVW/heYr1/18vAbPfHmD1lY9sjHZcF7jn5
	ur0RpHRmfPwv7fqKwkxJrWgMIlk1PrXvtTgJ3EhJNJQcFsMCCRH8thVXfkehiSHj5z91B/GbMhh
	8
X-Google-Smtp-Source: AGHT+IFccFF2oFHmlsLnwpVDYsHbnzwo+hSZtspn9JVTNBPSJFrTpSFKN5a3C18e5F8g5GCAcVJVZQ==
X-Received: by 2002:a17:902:cecb:b0:1e0:b1af:9b with SMTP id d11-20020a170902cecb00b001e0b1af009bmr86571plg.43.1711555531737;
        Wed, 27 Mar 2024 09:05:31 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bf4-20020a170902b90400b001e14807f9cesm1718226plb.125.2024.03.27.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:05:31 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 7/7] riscv: Remove extra variable in patch_text_nosync()
Date: Wed, 27 Mar 2024 09:04:46 -0700
Message-ID: <20240327160520.791322-8-samuel.holland@sifive.com>
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

This cast is superfluous, and is incorrect anyway if compressed
instructions may be present.

Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/kernel/patch.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index cfcb9926e722..9b8d633f6536 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -178,13 +178,11 @@ NOKPROBE_SYMBOL(patch_insn_set);
 
 int patch_text_set_nosync(void *addr, u8 c, size_t len)
 {
-	u32 *tp = addr;
 	int ret;
 
-	ret = patch_insn_set(tp, c, len);
-
+	ret = patch_insn_set(addr, c, len);
 	if (!ret)
-		flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
+		flush_icache_range((uintptr_t)addr, (uintptr_t)addr + len);
 
 	return ret;
 }
@@ -216,13 +214,11 @@ NOKPROBE_SYMBOL(patch_insn_write);
 
 int patch_text_nosync(void *addr, const void *insns, size_t len)
 {
-	u32 *tp = addr;
 	int ret;
 
-	ret = patch_insn_write(tp, insns, len);
-
+	ret = patch_insn_write(addr, insns, len);
 	if (!ret)
-		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
+		flush_icache_range((uintptr_t)addr, (uintptr_t)addr + len);
 
 	return ret;
 }
-- 
2.43.1


