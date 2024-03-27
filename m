Return-Path: <linux-kernel+bounces-121604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6D788EABF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8941F2391E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510671327FF;
	Wed, 27 Mar 2024 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Bl9KrRRE"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DFA131BC8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555528; cv=none; b=bct0kPLXuEPW+iXZo+yAUXQOnqTuAlzgj9vFtHP/yRIUHjroJgUk3NS0dpOJqCDMEp0hk0JJDgUF1w7dTlbVgQXvW1UhxiP7AjwBlJ8NlrJ2k+hQ4yX+wwXy1RQQMAjt1dYjndMawHpJWIhzjIEuSQFYJky5hQ57jJcVewOqGHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555528; c=relaxed/simple;
	bh=kMyE2qfY2RjUoUPj35JPV4OFISD0zpAHsEoL+e/lyNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzkeg7M9KjuFRelDE5BevpmvZLdLLdWHQKXom3O6SJMbFLmjVAxhGgyPg85Nw1yovfqshp2cZS+GmwLy/qmvKoraoFaeacJAk/LO9VoS9YIL5mr0J1UeaNVFvoPJQnpBmebAP2j4bZW/tSj8+SiDytICybjdMh/2Xb1szWGieR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Bl9KrRRE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dddbe47ac1so7327845ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711555526; x=1712160326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/A8S6GwPVeRQh4mUyUZHiHi/w/+o4RQ1PPE/E2MAhE=;
        b=Bl9KrRREn8UPdOIYObq3a3vzzg1bW5T5GLanhacs/4bcFsP4dN3/Tzst0UdtnMC8sA
         bQm7bf+F323PDBdjAl0QPyr9iYO7X4tHIx5qQgGB40FeAna8OGeKuU5ZfZsjqFEuQrn8
         qm2taHbhuLuyo4Kg8Uc2TPSBCvdokWfgMdFmPtUVk7zm/cAhCNP+ci26XWoyEP5kZ1CB
         8fDaRFyH1M1SSegzIVTSgpk2V0FiQr0nyPhkpLU2CLA5iaVlG1m08R21FGp4yKfUfKDU
         ne4pIPWDZxtfE8iiV48FopT8M+a0f3UqtHCIFEJokPV1vjumrofTUCBDVzzF0MHJz/9t
         xkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555526; x=1712160326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/A8S6GwPVeRQh4mUyUZHiHi/w/+o4RQ1PPE/E2MAhE=;
        b=DMGLWzLZlG9NKgx95SnVXwnMet5qpiq5dIOO0+IPRrTxHGto/q1XYCoxtV64SkN9Dv
         94nf8j2MURA2KXXgnkbNM9ZJI9p8H6dpJhYrCG38jzGDYuNIEpBjJqtDqDqVY6LemTBb
         rnxmKunRnCxxkOB5MSDDTZ3mOUfWDWRprfOcR/imJzevKXo9JexIxukaEky3Rpxxum+0
         utcBnHMo8C91eKtqJW95CqtAJzsRGEoDMCNb3WQMyt1vAiC3MXpxRXd9zuzsHx+vZ4Dd
         94TLF+o3UpsGkRC3eh/+Lqe/S5cZicREoaHHouLBtamuJbyyNmdAxpG86n4A4aP8fFTz
         8rHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4aVFeuQwdc5CqGvKlkjw1HyMXUdY/u/BQJJYwhZ5wnk9Eg081hnmGbLuUjBJXSTVh23vc1Krl9znVeEg/EaoNi/c7Ufhdy0k8/CEJ
X-Gm-Message-State: AOJu0YyqzzqQL3GlWN3G8zhQ+y8wG4Moz3IAOE9tZgqtrKUlqRWdBHQT
	UUHUPPSoMa5lbEmhSzHODj4znXxjYUZRZr60DpXF+nY24FCVR23V47dFv5f0UdM=
X-Google-Smtp-Source: AGHT+IH/cUxMi1ZJe1xxd7wZiLZTo1eYwqccL1pn+6fDaFGtQ6Q1+BMpEoTMKbn4C0h/HXhupBeb4Q==
X-Received: by 2002:a17:902:cf02:b0:1e0:e8b5:3225 with SMTP id i2-20020a170902cf0200b001e0e8b53225mr41189plg.12.1711555526538;
        Wed, 27 Mar 2024 09:05:26 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bf4-20020a170902b90400b001e14807f9cesm1718226plb.125.2024.03.27.09.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:05:26 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 3/7] riscv: kprobes: Use patch_text_nosync() for insn slots
Date: Wed, 27 Mar 2024 09:04:42 -0700
Message-ID: <20240327160520.791322-4-samuel.holland@sifive.com>
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

These instructions are not yet visible to the rest of the system,
so there is no need to do the whole stop_machine() dance.

Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Remove unnecessary line wrapping

 arch/riscv/kernel/probes/kprobes.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 2f08c14a933d..fecbbcf40ac3 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -28,9 +28,8 @@ static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 
 	p->ainsn.api.restore = (unsigned long)p->addr + offset;
 
-	patch_text(p->ainsn.api.insn, &p->opcode, 1);
-	patch_text((void *)((unsigned long)(p->ainsn.api.insn) + offset),
-		   &insn, 1);
+	patch_text_nosync(p->ainsn.api.insn, &p->opcode, 1);
+	patch_text_nosync(p->ainsn.api.insn + offset, &insn, 1);
 }
 
 static void __kprobes arch_prepare_simulate(struct kprobe *p)
-- 
2.43.1


