Return-Path: <linux-kernel+bounces-13731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF490820BC3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 16:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC7B1F213A3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666738F6A;
	Sun, 31 Dec 2023 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="amBL++QD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC7779D4
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28bd623c631so6766408a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 07:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704036477; x=1704641277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iifngznp+ertIjgLYKgYyodchJA69bCk2AsJZ4z1PYM=;
        b=amBL++QDsc+EE5EFmrVMy/WSKZtIGyKBE02sIoMt/Jr+ZrP1A33/zVgpdnEDnLGMfg
         YHaV0WGyrqWOZOZT2ukv9Rnn3faVBaDwm+wVOngbsk5tx/9qlD8c7wYa6n/mDxsngQrq
         GcdfjpONGDDy9EkTOVk1SqjRIQ4gIvWN1MVedVnQF/lNeqc4pMTR33KvNLhFyjfRg/Gn
         X46Nyj8QwgWMss84zYz24HFrsQbNBPwGBncTRDUzL4xf9AbzsEMWberEUI9yezmOFh04
         ZfT850gB2pK/NeNqtMO0sck0A9MCJb2Gi3J6VuJPJwSGrUOden8f/MkoeTAy8amjHXOM
         TyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704036477; x=1704641277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iifngznp+ertIjgLYKgYyodchJA69bCk2AsJZ4z1PYM=;
        b=HUq/Daf6dABrSh5mYNKNVAyo8jk+b628cXqe/1LqejAA4QTRIXBZJOITJtYOgxxW5s
         bubM9yO3fv5ZM0AJGfWjshPHPciIh9adlJJMe8fjTZyrYQtWNmj8Bj95nkeHlEq2dQW7
         n8EViKlHlIkm48yK3F0beDptVN7BOZhSEyqHrKn8tp+i4qWtvWPOOqJ0Mtrg1/IqurDY
         f2nbjAau5yOB9+yMtyYqIm0coxwSD1neJo0O5i8xfOOJ5YiKIw/TSlNA+RCfoDtC8Teq
         LM+X7smBqGeK9hJBiz1f8amNvkQC3lObxkmHQ/hikylAsPlhrSZEJiNx9QtU5q3ZHq0B
         Jcjw==
X-Gm-Message-State: AOJu0YwQTBuLd/owGnPoiuEazDp8iSfcL95uEfcLXJadV1FYxobq4zEX
	3GCc3xide51ZWJ8YZeEzdwS0aPMMuxyvPQ==
X-Google-Smtp-Source: AGHT+IG2X++FLxOhI7SgAVayiogOLWmlW/65gGZuJtaqh9iKO1jYHAKqb8XHTGyS7hCPlNtJAE2iRw==
X-Received: by 2002:a17:902:684f:b0:1d0:6ffe:9f5 with SMTP id f15-20020a170902684f00b001d06ffe09f5mr5478381pln.83.1704036476827;
        Sun, 31 Dec 2023 07:27:56 -0800 (PST)
Received: from localhost.localdomain ([49.216.222.63])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902e54400b001cc3c521affsm18624430plf.300.2023.12.31.07.27.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Dec 2023 07:27:56 -0800 (PST)
From: Jerry Shih <jerry.shih@sifive.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	conor.dooley@microchip.com,
	ebiggers@kernel.org,
	ardb@kernel.org
Cc: heiko@sntech.de,
	phoebe.chen@sifive.com,
	hongrong.hsu@sifive.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v4 01/11] RISC-V: add helper function to read the vector VLEN
Date: Sun, 31 Dec 2023 23:27:33 +0800
Message-Id: <20231231152743.6304-2-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231231152743.6304-1-jerry.shih@sifive.com>
References: <20231231152743.6304-1-jerry.shih@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

VLEN describes the length of each vector register and some instructions
need specific minimal VLENs to work correctly.

The vector code already includes a variable riscv_v_vsize that contains
the value of "32 vector registers with vlenb length" that gets filled
during boot. vlenb is the value contained in the CSR_VLENB register and
the value represents "VLEN / 8".

So add riscv_vector_vlen() to return the actual VLEN value for in-kernel
users when they need to check the available VLEN.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
 arch/riscv/include/asm/vector.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index d69844906d51..b04ee0a50315 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -294,4 +294,15 @@ static inline bool riscv_v_vstate_ctrl_user_allowed(void) { return false; }
 
 #endif /* CONFIG_RISCV_ISA_V */
 
+/*
+ * Return the implementation's vlen value.
+ *
+ * riscv_v_vsize contains the value of "32 vector registers with vlenb length"
+ * so rebuild the vlen value in bits from it.
+ */
+static inline int riscv_vector_vlen(void)
+{
+	return riscv_v_vsize / 32 * 8;
+}
+
 #endif /* ! __ASM_RISCV_VECTOR_H */
-- 
2.28.0


