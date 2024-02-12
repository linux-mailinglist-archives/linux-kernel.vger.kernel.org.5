Return-Path: <linux-kernel+bounces-61076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E9E850CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7681C220CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CFBBE7E;
	Mon, 12 Feb 2024 02:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NGBdhqY5"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C879C3
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707706534; cv=none; b=bsXpsBZbdPWFihsfADrc1pO63KjZof9wloBZgnaKnFLU9gfD8iTXboyfikPADSizyRsj1AwDCUs2trifbwmUkO1FDxdZyu2+5Pg+XujQtv6LzXXkJKf47tGvHz3wwnIAIl8hkMczhrNxImPBaPJu278obb8z7xcBRk/jXwIwp/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707706534; c=relaxed/simple;
	bh=n3r4IK6ZdfJZ49ePBivk4JOiueXOYcZlaqlhYNq/7s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6rFnLwY6AKh3OCdqRWIOzm6I5P3MAIWYs8fwS6Pf0rHii9IrElRfdufvdM7cfAe5pZI7fp4DcZ5c93R8RoUQQMiqoX8ENXq6OuY1eYUyOh+Ozv5MqPoWUh/AxLZeZJ8THz+RQvLE19BWRHo4s1DRHgmcssBKQcEX2a38hmixjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=NGBdhqY5; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-296c58a11d0so2047993a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 18:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707706533; x=1708311333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sgb+qYVoGLQC+1tIvOKXrFPvpE4GtMMkuDMIpMcBDRo=;
        b=NGBdhqY5Zm4fwJUdWKqcdylMeJGosVeVEy8p4/9cRwlgcK9iXgyaHvxbyNa+kmc1Si
         bysc8S/vp3j1DdCD2NpuJlc4zqaIHsv6FQKa6z6cAU+Tcme/uy48+dJTPI0SVJ12NKfr
         OY5GhSTJyK4+OIZRPM8VP6XUXl0uSOB+FptxpqnM5viAH6zz6SUUjOG5a0E9+3g61t1g
         AMwZr0nxZPF5lReR9gRQyne5Lk3VxR7xEc4vn5NIN4DtuiHfO+3HZ8DSRV/eMWC1Edld
         eXxJNY+BQk3GexBOcpv8CgcISfoITJLi4iIvkAiR5wToheuPiUJnByVB8sWkhVSUjrPZ
         5XSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707706533; x=1708311333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sgb+qYVoGLQC+1tIvOKXrFPvpE4GtMMkuDMIpMcBDRo=;
        b=NDdu95L/jmxdv7G8CFd3ZzRmyu9RYYRZHjUtJLszhrnFa09xhrpdED9w0KBBKmQ9IO
         zgTuFre8myjp9o+E6fLVimZHBJVbu3AkcnWJBrOHLu9NiOqYBek5nJ8nRm9PMUjDXWUn
         Zy04mgmviyzK4wXJn6J++XZ89VCDZ6/Zdwoo1P2FzXLM6FoH/Ni3rCjIfKUs2+0vdyIK
         3mGSDa/xYZpHdii740ipW/4Jwjy6q9KbrmuR8qZFFdkfXXWbzvMGeJnOdzycENDurE+B
         UTi0nu+IJC8L4ZI3H5XY4bxSL4er7ooIA0AdF+h1At05bl9TfE93UUevoxva4fcxQjNH
         GoVg==
X-Gm-Message-State: AOJu0YxasUWDTpFzd8KrhwAAvTx2853AHoRT1cDC3ECtjGjYJip40bBq
	w9N1jwEWrODOp8tLKhoKEiTxb74nB0NzWqPHXc1BjNnqAGnU/r7/LMBxiy0gIeA=
X-Google-Smtp-Source: AGHT+IG+jFJKgyCn1R8EZa/RvpPkjQLUBL0jqkCGBZDbkkg0EEuXrvaReU9MwlXMjKspZqO+X1Axwg==
X-Received: by 2002:a17:902:da87:b0:1da:2216:f1f8 with SMTP id j7-20020a170902da8700b001da2216f1f8mr6131279plx.39.1707706532745;
        Sun, 11 Feb 2024 18:55:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWltAXxT4Z5I23HaZAeyreKKr5A6zwnhZx747qv+QqQBOZ2ZZtcTpQ4qqJvcBK3aCnVPXPXY4cKY2s6M2O3dDjODm7lW2CSHWdxxVXcnzqZm36pZpUdtXgFNxzdUykLDhghcMVP9m15
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id lb3-20020a170902fa4300b001d9af77893esm4906443plb.58.2024.02.11.18.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 18:55:32 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 2/7] riscv: jump_label: Simplify assembly syntax
Date: Sun, 11 Feb 2024 18:55:13 -0800
Message-ID: <20240212025529.1971876-3-samuel.holland@sifive.com>
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

The idiomatic way to write "jal zero" is "j".

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

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
2.43.0


