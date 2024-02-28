Return-Path: <linux-kernel+bounces-84581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E701586A899
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246FD1C21E74
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7729525566;
	Wed, 28 Feb 2024 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="b2ciu2vv"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6940023774
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709103368; cv=none; b=N9UUvRfSIsrAUMfy6SWrtlbS1gu3/utCHgrqXZY0YDDhyXg35cq8yEYK1Z3jSyIyzJOnzhBFSzQhrUS7agxovo7bHtDmtR1XQG4zYItcC1mueW/Pj+ta5CXmlXzztGkjzudOtHSmsJEWv+21+f5dhYVHXqk4daC3SsiaEYeZG80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709103368; c=relaxed/simple;
	bh=bs5XYVcCzho+feAUo6s75ciZiH7nmPW++UTpE+FfRb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eo8ir/nP5mMSp8+RAK1AfTxjQWLwUSUG0nuXOvojz6sx2hC3GepsAfUH4dLCVRJgayh/kO4ZB/xxYKUPyE7oQDPHSckTVtEwWyo57Qt5xaRzLDY1/JsYMABJsBkMfQy0lzoNfx1XvXL/ttvJMSIsVJfrgi92zmTiR6puyaYl5nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=b2ciu2vv; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c1b38ee443so367111b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709103365; x=1709708165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJgAIcTGryvmtjsnjR7QyAZRnNOgxphdJs6wyGDboLY=;
        b=b2ciu2vv8Q2NBZXmajJ97fbJt1gVAumNpIuOcAU5p7NCRJ76IZnL/+1bnYcsSe7621
         E9jKTglTB3fZE1NI40rglhfRWXmoYsOTR263MH4Q/zJd5uRoWQLNCE85q3RWvDo7fXwZ
         +3xeEdzFTX+s99BlP32WYA97dFiXVetDrlTiFlDWSxtO9IL3YEpXnb0p26KndpwGHGL+
         4avcG6iPJHLtv8lC5bapa5xkG8Mxsx0FRybEFZcodVV0vo9fbK0orkBiUyfQbFtT1Om8
         UTgyO+LZwD3M1QiaPkKK8XV7E3Ww2Vri4R6h4O5P3NuBCal0lZzciLIhTXxSszbNyJY3
         D/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709103365; x=1709708165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJgAIcTGryvmtjsnjR7QyAZRnNOgxphdJs6wyGDboLY=;
        b=dvbi/fD+tyjIZMCCKkbso/1jRFZmdI8vT+BZOzhY8l+b4BVDjFMBJTMoPA+Y76hDtu
         cD8kXNsDBtG+2nROXpU/UAftHTBVCar2pkpx12PeHqZS/jVgrNjGpRvWOOQ21K0zhXhb
         dnst7STy1sWTcM3CklIn4IBhPQpxEGr/ufgC1xxZHg47nPuzt76OKFeEQq8qdIo4fgpq
         TPaytxxg0bbZLawk/YZjUD0/scA1e7iXtDi1+bt9lOs6RiIcQphuDQ2CwvdSmHMaaiV3
         HaxnCC6q9B2Rl61fG5XkWsoHi3U2IHc2qyI9sKy+hXow9MpiGiNjdrtxOHddg7m5zuEp
         gY/w==
X-Forwarded-Encrypted: i=1; AJvYcCWf0cQOxg1xj+HzOW1lplAdZTUUDTvt5uE4YL3hItfoEvTsnW3GIGxUZOSXCDzN32v9dVPGJ8k3T6f+zAoQv6a10C9OSJvVMKDr5H3q
X-Gm-Message-State: AOJu0YzLRKqiuDLAXHwPCxjstgj/ifzq2byOWzImm5CccGLCjDIWxtmW
	4aGIhVEVhUd8ABGiV02AtuOnewaIFFwBvoBmK5y6wYabIXttFJdTOl0Lm91e0/Pa7ECRjI7Dd6/
	8
X-Google-Smtp-Source: AGHT+IGGx/vnvLhHJPPq3FzMaf0ciOqylHEHVZRNqVVM/N13/blIW1fdU1Wt/S2raD6d/d9mTPu+ag==
X-Received: by 2002:a05:6808:ec1:b0:3c0:4477:deab with SMTP id q1-20020a0568080ec100b003c04477deabmr4903802oiv.51.1709103365507;
        Tue, 27 Feb 2024 22:56:05 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e12-20020a62aa0c000000b006e5590729aasm1010112pff.89.2024.02.27.22.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 22:56:05 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Stefan O'Rear <sorear@fastmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	stable@vger.kernel.org
Subject: [PATCH -fixes v4 3/3] riscv: Save/restore envcfg CSR during CPU suspend
Date: Tue, 27 Feb 2024 22:55:35 -0800
Message-ID: <20240228065559.3434837-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240228065559.3434837-1-samuel.holland@sifive.com>
References: <20240228065559.3434837-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of the [ms]envcfg CSR is lost when entering a nonretentive
idle state, so the CSR must be rewritten when resuming the CPU.

Cc: <stable@vger.kernel.org> # v6.7+
Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v4:
 - Check for Xlinuxenvcfg instead of Zicboz

Changes in v3:
 - Check for Zicboz instead of the privileged ISA version

Changes in v2:
 - Check for privileged ISA v1.12 instead of the specific CSR
 - Use riscv_has_extension_likely() instead of new ALTERNATIVE()s

 arch/riscv/include/asm/suspend.h | 1 +
 arch/riscv/kernel/suspend.c      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
index 02f87867389a..491296a335d0 100644
--- a/arch/riscv/include/asm/suspend.h
+++ b/arch/riscv/include/asm/suspend.h
@@ -14,6 +14,7 @@ struct suspend_context {
 	struct pt_regs regs;
 	/* Saved and restored by high-level functions */
 	unsigned long scratch;
+	unsigned long envcfg;
 	unsigned long tvec;
 	unsigned long ie;
 #ifdef CONFIG_MMU
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index 239509367e42..299795341e8a 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -15,6 +15,8 @@
 void suspend_save_csrs(struct suspend_context *context)
 {
 	context->scratch = csr_read(CSR_SCRATCH);
+	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
+		context->envcfg = csr_read(CSR_ENVCFG);
 	context->tvec = csr_read(CSR_TVEC);
 	context->ie = csr_read(CSR_IE);
 
@@ -36,6 +38,8 @@ void suspend_save_csrs(struct suspend_context *context)
 void suspend_restore_csrs(struct suspend_context *context)
 {
 	csr_write(CSR_SCRATCH, context->scratch);
+	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
+		csr_write(CSR_ENVCFG, context->envcfg);
 	csr_write(CSR_TVEC, context->tvec);
 	csr_write(CSR_IE, context->ie);
 
-- 
2.43.1


