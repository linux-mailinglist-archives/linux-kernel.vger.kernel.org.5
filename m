Return-Path: <linux-kernel+bounces-61077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382FA850CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE880B237F0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8CFEADF;
	Mon, 12 Feb 2024 02:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bMMscS28"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6279F9
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707706535; cv=none; b=ghHA7AroQGwIUH+dM7Wfoo6cz17lLu14SSLCfxFeOLiC7R87FH2emmDESYBqDE82vgs42XWNP7oKgZzVb9J8vjqvh3AZ4YWzybCICrOtgAs4+C38PKYoGyQCEYFXYDGzFG5UIC0LzXPg7s2QVxNczMipTCefB+Qfz7PJ63pu+z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707706535; c=relaxed/simple;
	bh=hGoXyhdOZzkX3SM1U+B5MT4w/IBhEMz7O05oyr3ELpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFFVCM787g95Bx04rYcZtAW2AqFGe7NyZj50t65eiintkls+FnrZiGYijjzmM0TjwJDrMwFabOU7sM+XG3yshhS97n5De/mbCo7xeH3zJI6aZmm6pI0mQQm8QKijPKkEZwPL2dhMfpBUXPxGrHWxmXhGLwTIBF2zsJQV/kJXB3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bMMscS28; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d7354ba334so23827625ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 18:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707706533; x=1708311333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyWEpJBZa6N5gG6vKnxq0FYgwkGh/wmTGuSHlmGCra0=;
        b=bMMscS28ybqZed+IqfZ7jZKNX0g7EIzEqtxxZFAj+qIfU9LC35OF1R9gUFycjHUOBi
         Ju+NPeFKADCulqAAQp5fwII+5c+FmRPjb5lkm45/rDPAIomSj+T+11VsozZhWK3PBygP
         uXct7LhbF/2J+VGPmUClSiqqoLIwIFpwzkOwLIMQVsjZ6Yd9EDHMSaWtbTpduftCsFPO
         grpqZPJqDhZoXhgmbWl8O4q1rozy76l5bGQvAldBRWNkOPyNxMavAgeTvhajZQeC/ei8
         +8rVSLow/+NZ0qPrMDzkQY4EdbI9dHw1WZuSfW1pyk6YlkTG/9EK/LZrUkkYkKtt4UdU
         Exbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707706533; x=1708311333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyWEpJBZa6N5gG6vKnxq0FYgwkGh/wmTGuSHlmGCra0=;
        b=q21cMQrtuvJQdwEhaSnJEfmMSo5SEjpVyKJn8Q2zi1PGw3THqAXOOjSgoqGFCYbhva
         IhviF6U1KfLYqJjpKB7NfB4YQk7VP0XjCqJ/jHxXCYofsY1tnYN8+4dUWfkFT8SQe5uq
         L1sg+3aBVQCzxOnYj5C/RwX+ugfOQJlBlvtPc1+HfuumIoT4rT6CBYFlLYREwyHWAG97
         QiVSKwb5tjN9g57yq1Zq2Qt09OYeKE0vYLwcglBqX1xV4FCp1t6PkcXrV2t2ErQCPhPo
         UkSbdyaCQMWLsWV0k070MpcWy8+CrAOfSEXKx5pr2Gpc62sxT4OChyfJe+iU0nEnGOxJ
         rLpA==
X-Forwarded-Encrypted: i=1; AJvYcCUUiVyzJ0gjNEi71wXykTvC/K0asAdQVgHF/SYjLArUZcdb69uy0GoIPkIAeEHCxgFd6/tNkZnJzrZgSWyh6p5IsqbuNBAIPFKGoQbf
X-Gm-Message-State: AOJu0Yz/0mQyU9WjZl7wdt4fWx5ih/lU9x6Pwgm7viL9o19BooaopzWw
	EtGoD+LytUfxxwiY3b+NU4imn+9T5yCGDFMOLhubKd0JyxMMQYKHnlDX1IC15Es=
X-Google-Smtp-Source: AGHT+IEQGBabtshtJRnBy7QMR0LnKtEJkjk8oI+Ecfk7Bk5If+Yz2qKW8FH3n5DdlZVHIUwqXKsG3w==
X-Received: by 2002:a17:902:e543:b0:1da:2a91:8c08 with SMTP id n3-20020a170902e54300b001da2a918c08mr2970896plf.3.1707706533677;
        Sun, 11 Feb 2024 18:55:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUuWR7ifv90QrNgp9OEt3yI6Kuwl8TrHbiwLrMId33GgFSjH88KNG50sMejjWgECWoCB1ug+/IqU9OjHkK5Vn/juEDCGgYKNrlq73OyQmooS6Cdg7mXmU3LW3vffu4GbXxiPKCchb2+
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id lb3-20020a170902fa4300b001d9af77893esm4906443plb.58.2024.02.11.18.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 18:55:33 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 3/7] riscv: kprobes: Use patch_text_nosync() for insn slots
Date: Sun, 11 Feb 2024 18:55:14 -0800
Message-ID: <20240212025529.1971876-4-samuel.holland@sifive.com>
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

These instructions are not yet visible to the rest of the system,
so there is no need to do the whole stop_machine() dance.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/kernel/probes/kprobes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 2f08c14a933d..cbf8197072bf 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -28,9 +28,9 @@ static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 
 	p->ainsn.api.restore = (unsigned long)p->addr + offset;
 
-	patch_text(p->ainsn.api.insn, &p->opcode, 1);
-	patch_text((void *)((unsigned long)(p->ainsn.api.insn) + offset),
-		   &insn, 1);
+	patch_text_nosync(p->ainsn.api.insn, &p->opcode, 1);
+	patch_text_nosync(p->ainsn.api.insn + offset,
+			  &insn, 1);
 }
 
 static void __kprobes arch_prepare_simulate(struct kprobe *p)
-- 
2.43.0


