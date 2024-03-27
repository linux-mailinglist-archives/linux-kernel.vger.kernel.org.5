Return-Path: <linux-kernel+bounces-121603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8756588EABE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9111C23211
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C97132492;
	Wed, 27 Mar 2024 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Fr9t+Afm"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC22131BBE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555528; cv=none; b=Wh3vuoo7SWyqvv9HGcye9ZufThwnx6gS0vRu995xkI6alE92Mf+lxye24jzXabm9lXvRkpZb//+jVE4DSSnkPKK572hXci7igG4/DuUi3Gzp8BMUfcNGOnpVb8V8KBCR/RXxCVTXQ62Cf6zxqKGVzmgjgsxKkEzrQ8zWa/AjLKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555528; c=relaxed/simple;
	bh=nUhuCGNSiNI8gPbLKFAtjEYWXvNX2ZVdrT7VP/q7XhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+2QKxEa0/VOcbU2Oy+j8fhS3Y/A08mGxOcrTXOiZHLjQPBQh1TrRXZbuky3u7KzgYE2J7ATYcuWSnxDH+7FqZOH6GkW0A3DgHvYDus/2yq7tioHitndYwHc/Bj2RypBUrMV2hbXyJq2AxVFXcrww5LmCnPI72oX9HFOkpi7HP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Fr9t+Afm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e0bfc42783so28555ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711555526; x=1712160326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Xc93+JfN2S4FIXbabsoTVMgsbTEMk8Oy5ZNwdIewJ8=;
        b=Fr9t+AfmlG6Q/cPuLHlr/H6B5R/g3BFftQxabip1LAY0W4+cYdyQo4lbTNlMFeXbE+
         fKQnctiDya+iqeWcfnjxf3pI2X9PFPJzf0YUhvmRJxOOyrMp3DKHRqPVMXb+z3TgzyQF
         EDkY8MpA1qpDUZ1EMmx6tNMMIwxSsoqgkDtHYEHRSmBYSz0yxIEGO8WNduUyWEPNBWgs
         FFRTzFhF6No7WLnebq7zLmeBLxUUQOAitfMZCoWAKQCxRQPgwqDm+ndlrHGGv1nqgXT6
         bB7CSg+zPVcwG95hdfOmMTnsrxSgxSFHIW6bHwcCj6dW18sUdFC3kRayCnUhTdT2KV0M
         y7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555526; x=1712160326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Xc93+JfN2S4FIXbabsoTVMgsbTEMk8Oy5ZNwdIewJ8=;
        b=DG3/V/oUxjd3+GC0nmn9o5hjYga3lIRO+pjKVmfUcKFA3VP/EZ2KSDKLoDNqLw+5WV
         WFk9sh90FwLfwhr8Zp9UkeugOHOLEUvpfA5B5wF5QtGiykNMPOvy57K5dYEiN0lLq1sk
         3lTcc0QrqVSxNObrtvCp6cFgRvwU36abZyd62X1P2xk41jRtrbKt2lU0Nk255+++Z/8v
         lCx4jGjEgr5IjEN135hN2Qeg9LsqH7+qCGuoGsgwBGYv0gdhLHWRP2V5MhBEZzeUNB6S
         m58XYSIOvlCFXq3rDHTKbtgvK1ovP90w4Y9MMRCW6LOtWIxj3Brg65GKfYJ3mQ3oqK3N
         1iUw==
X-Forwarded-Encrypted: i=1; AJvYcCVzowEZjEMgE5noTKp86puT/1QF07mh4+r1dcZrRNukHRVQ6W39jqt9DRr0mIB0xiJ8qsJztoOYwR0prlanWJxMCrIqUQqvHhHKv0MY
X-Gm-Message-State: AOJu0Yy0A5MB63TdnYX6/e/yU71dW+BwoB6TI9WYJFe/gIxotXEqSCl8
	RRE6x0FNNPpsqIGH5zVJdjIWE7cIQm5j5QAkVk1ciKBPLpHbKhzcG2O51x58SvA=
X-Google-Smtp-Source: AGHT+IG5UtEW/LihmnxDCmHBZwJ44J0/v8NsXjFKi7Yo3FMGF74v7Eh2hJ1dT0cL1L3h19a1fVN3hQ==
X-Received: by 2002:a17:903:287:b0:1e0:c580:4972 with SMTP id j7-20020a170903028700b001e0c5804972mr102612plr.33.1711555525198;
        Wed, 27 Mar 2024 09:05:25 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bf4-20020a170902b90400b001e14807f9cesm1718226plb.125.2024.03.27.09.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:05:24 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 2/7] riscv: jump_label: Simplify assembly syntax
Date: Wed, 27 Mar 2024 09:04:41 -0700
Message-ID: <20240327160520.791322-3-samuel.holland@sifive.com>
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

The idiomatic way to write "jal zero" is "j".

Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/include/asm/jump_label.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/jump_label.h b/arch/riscv/include/asm/jump_label.h
index 6290b26f4a14..1c768d02bd0c 100644
--- a/arch/riscv/include/asm/jump_label.h
+++ b/arch/riscv/include/asm/jump_label.h
@@ -46,7 +46,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key * const ke
 		"	.option push				\n\t"
 		"	.option norelax				\n\t"
 		"	.option norvc				\n\t"
-		"1:	jal		zero, %l[label]		\n\t"
+		"1:	j		%l[label]		\n\t"
 		"	.option pop				\n\t"
 		"	.pushsection	__jump_table, \"aw\"	\n\t"
 		"	.align		" RISCV_LGPTR "		\n\t"
-- 
2.43.1


