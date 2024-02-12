Return-Path: <linux-kernel+bounces-61078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D598F850CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98274288934
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E013F9F5;
	Mon, 12 Feb 2024 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Q7u+4E6n"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6D48C1D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707706536; cv=none; b=K3T7nGeGFkfUHlnDEKVHNEPyF1CPGXNDpNAbkHD+Hz+Vk4sFcGgweln2PkiUWu6bWOJSIBADoDUxvC96lF3KmJp5u4reFu3jne654nMw8aeKSUAgQVTODB8XLRJyN41TfpontE3PnTxGlQrQND1WECEbh8v9c/5zCEufswY84OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707706536; c=relaxed/simple;
	bh=FfLB9kZNEE0mzUFK+6fXY29r9iKKYgvLMRPENpobDoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxu1rN8gQBjmRQ0TOyc7o/83TmMGorQPdfBIU1/T04oUjtpwfzRHOSU50jy397BCoie4iP+JPX1hbGzJSVoeNhhEY2vDwF4+yMdO3uX8PbAFXG1con6vh1UHYVdfNyKtttr0suJookR2aMLCmu+H3AHZYeeYkTVYrsAmrnoqOoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Q7u+4E6n; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d944e8f367so18143685ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 18:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707706534; x=1708311334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lt2Zw8ci3FBMgsxbvxJ1Pjg/pitk5ttZsMbyNXtz18=;
        b=Q7u+4E6nEn57xSQ+jMaSfTXNIAVVT0XnUvDBRjdVYgxj0LIJBffye3IRLZGCBGtB8/
         Mw4pq5OZaT4df8C0IaaV0JH0KEdNf93I8u6O2dAIMCgJEsdugdkx4I6uOcZTtiEKLKpX
         jd7tDJ2eZI3M75NZghyXG3MTBW2vXXfXaWKYu12767MNsCJreS3fV3ag583Q5z4tLCJc
         PurLBSewSqSwS9lc+jHgJQfe4an8NF1wzfdv2e+XS+/2BLzOHT3NEHnoWvs7RtcACH1g
         AcSI+B9G3lQNievwnhnM4VSAC256pZE65P9o1p4ZMkF1fFsfX8VDL34TlJMBLrabjKDN
         Ympg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707706534; x=1708311334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lt2Zw8ci3FBMgsxbvxJ1Pjg/pitk5ttZsMbyNXtz18=;
        b=aAnlAw5/n2aAMjnk0rP70BwHG0HLFGusagzCs5VKJfwfOGONAm9RCfwDHviV4n3Hk6
         w4ab9LJbwrXav01G/6qHH5whb+g/zf3siylps8NlYsN6m7+WVQ9+qy7ePmNHUymj2o5E
         pJIdcYJ1uJ0D/Q5L5hckRxBaAzrR+L3xSSgzyFvZF5m8doIau0z64kVAKeZz0g63G33n
         Ovny1bYRHfnHQKyBS8YrWNDfrE4A64r4FfJHaTZxcw7YnkgxfeLkOG9oXrd5P9IZ1g35
         W/h84d240C/Joh/d7Tm5rfE/qwpMBy+os3L49YwaMqbXMjPCki09H464GrKAor1eh8Ou
         QE8A==
X-Gm-Message-State: AOJu0YwscDd3YKVV7EiO/MqSa2YaDG4c/DXd/8eqTQCMR61Aob+iUIo4
	rR8NKVjiVAglm3kAiyceipk1YxghAHTfKxQ4OZP/jNVkSXUOp6HQ2YdFBVpNmEc=
X-Google-Smtp-Source: AGHT+IHmG+CIpQJOL1eOAU1mMo3rp+EDyWfC1D+PpAxX+YwHAEt1nNZRP5QwPUg9G/1IMuX30R9ESQ==
X-Received: by 2002:a17:902:c412:b0:1da:2bd6:a450 with SMTP id k18-20020a170902c41200b001da2bd6a450mr2170203plk.32.1707706534554;
        Sun, 11 Feb 2024 18:55:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFMcthFL4l/bTCJyUVKIFRBG6Uzr3J1H/8KTDyjhZF+VEX0+59ZHlo17zAIHsqjff6iEJHbL5ZnLE1y5qPIbZtcNiH5g1S2cNMGOkIIb1/slKb0HWnZF9jNLbDe4rF1SmjOZQImKvG
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id lb3-20020a170902fa4300b001d9af77893esm4906443plb.58.2024.02.11.18.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 18:55:34 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 4/7] riscv: Simplify text patching loops
Date: Sun, 11 Feb 2024 18:55:15 -0800
Message-ID: <20240212025529.1971876-5-samuel.holland@sifive.com>
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

This reduces the number of variables and makes the code easier to parse.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/kernel/patch.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index bccd9ed04a05..7f030b46eae5 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -155,7 +155,6 @@ NOKPROBE_SYMBOL(__patch_insn_write);
 
 static int patch_insn_set(void *addr, u8 c, size_t len)
 {
-	size_t patched = 0;
 	size_t size;
 	int ret = 0;
 
@@ -163,11 +162,12 @@ static int patch_insn_set(void *addr, u8 c, size_t len)
 	 * __patch_insn_set() can only work on 2 pages at a time so call it in a
 	 * loop with len <= 2 * PAGE_SIZE.
 	 */
-	while (patched < len && !ret) {
-		size = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr + patched), len - patched);
-		ret = __patch_insn_set(addr + patched, c, size);
+	while (len && !ret) {
+		size = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr), len);
+		ret = __patch_insn_set(addr, c, size);
 
-		patched += size;
+		addr += size;
+		len -= size;
 	}
 
 	return ret;
@@ -190,7 +190,6 @@ NOKPROBE_SYMBOL(patch_text_set_nosync);
 
 int patch_insn_write(void *addr, const void *insn, size_t len)
 {
-	size_t patched = 0;
 	size_t size;
 	int ret = 0;
 
@@ -198,11 +197,13 @@ int patch_insn_write(void *addr, const void *insn, size_t len)
 	 * Copy the instructions to the destination address, two pages at a time
 	 * because __patch_insn_write() can only handle len <= 2 * PAGE_SIZE.
 	 */
-	while (patched < len && !ret) {
-		size = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr + patched), len - patched);
-		ret = __patch_insn_write(addr + patched, insn + patched, size);
+	while (len && !ret) {
+		size = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr), len);
+		ret = __patch_insn_write(addr, insn, size);
 
-		patched += size;
+		addr += size;
+		insn += size;
+		len -= size;
 	}
 
 	return ret;
-- 
2.43.0


