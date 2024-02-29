Return-Path: <linux-kernel+bounces-86678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C0E86C8E9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0253FB23313
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626167D07E;
	Thu, 29 Feb 2024 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pWnOgRrL"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680377D069
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208723; cv=none; b=eiCiKYyZ8DIymTu7cD2tokM38e6XxfLVw9fVRSqMRfaHBJgfrUaQzODHCwvqs7sm7DYb5VfWo/o8joCJWt3gLchOKMHHMekpwv7UCc/Bax/QNNPce8+pErLfzqiYThqkRGdLmDAX8A8jtH7scmh2JSZjw1ybj8aD2FXzVTKJRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208723; c=relaxed/simple;
	bh=wwTa8WVdddwZqs8n44/5Bmw0bz7f3NhpD4br/pjBNu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U74/slF3wM8xlbaO6b2EgU4DiWO34lKwYEdSHb3WqOIWaidfRzera0+mGOH3VgDex2Yaf1EpoKs2CBwP3CGA6JxCILDPSvBDwKDCRqoWTVKZF14+AQV+r5+cpH/Q82y2EsVvzcjCjXF3K9+D5jcVCAollWygu//MtFxOFxsGhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pWnOgRrL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412c2352f74so999985e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709208720; x=1709813520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQF1yLtoiSlCctJ+RE39C/7ki1uh9viRU9s1V0y1lKc=;
        b=pWnOgRrLbMWA9ko9HU34VPW6aMd/8vT8w+wdzQXeepHpUGGBFrtqQolfeQBwe/Ttxs
         RzG92+sZnhZSz3QjnnwFx1d2TI3t8BdbqKEcfouxzZc36KB6YwYwCIEm2y6f+7YDymM5
         zTsi+WspyHjyIvOqEIp+roAsd7jph/MvSuSKQbS8DTZ9JmjsXGks4s0kXOzNz8tMSzgg
         IPe4dFQ9flX3z5B0IfGNNU3COUBU561mdL/ezluibOTD6xlScof8YJrvKGTyBkKhL7GO
         BEji15qNB+TnIIrU325WWfZcfX/yTa3f6iVH4pEJ94Wuk3NEsQ2Vw8xa769KZxtUk/Jw
         dfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709208720; x=1709813520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQF1yLtoiSlCctJ+RE39C/7ki1uh9viRU9s1V0y1lKc=;
        b=NAVyvx6EGsYkqMK64ctZZAx/F0HY4iNnXMxV5iesxo584ScVUrG7zUzGFggQkhOwVl
         DYKG9/ZiN5fC+nFH0Uf7p+YB+BAq2rhIjfuxKGqW65ME0uik+hXLvE+mgGuOar+AoQfX
         rrrIYhmFUlbVr2xHhR973oTRcf0Wk5RWjnSHCLZc/A9YWGac9QrylKTwmwoEtu771Zkf
         jd8fKbrjdgPAZanZu/FR3L4HiTiR1a5mjPoH3eDtW3ikm3W8su+fFFbASuHWyYiQXUjF
         xF0Ta4oH5n6r+9QQ1iMPkKUa/RuEfgJOgUpDa2yP0ozIIuZ/NQMAEzeBTOdndCQT4FnH
         cP5g==
X-Forwarded-Encrypted: i=1; AJvYcCXN4u5p6nknFL9ZxGKyOYLQYqNL581qzbHDiTnt6lN3+i1uF5reivUSVGXxMt0DmFyjQaHx6Ryz1kXpf1EFUllsSwNSznd+uyt/qEDI
X-Gm-Message-State: AOJu0Yz5mmnv2TZPYr0ymny4vjUSFDUKGhOnlxA+WuRbw5EkY3pYezPV
	83ENzPAVPKgW7s0odKQbjZOuRlhXiuNDEYe7/7srfmRAoxQEokGT6ptXsYa0+sk=
X-Google-Smtp-Source: AGHT+IHfRGAEIEth4r9z2kyk2vnllBD0U8y+Yoxb/4kYE6ynYOIB5eFJyLQx9/3aYLh47mInURi5ig==
X-Received: by 2002:a05:600c:4ecd:b0:412:bca4:f23d with SMTP id g13-20020a05600c4ecd00b00412bca4f23dmr1340384wmq.29.1709208719846;
        Thu, 29 Feb 2024 04:11:59 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b00412b643b5a3sm1922750wms.11.2024.02.29.04.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 04:11:59 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <andrea@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v3 1/2] riscv: Remove superfluous smp_mb()
Date: Thu, 29 Feb 2024 13:10:55 +0100
Message-Id: <20240229121056.203419-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229121056.203419-1-alexghiti@rivosinc.com>
References: <20240229121056.203419-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This memory barrier is not needed and not documented so simply remove
it.

Suggested-by: Andrea Parri <andrea@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
---
 arch/riscv/kernel/patch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 37e87fdcf6a0..0b5c16dfe3f4 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -239,7 +239,6 @@ static int patch_text_cb(void *data)
 	} else {
 		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
 			cpu_relax();
-		smp_mb();
 	}
 
 	return ret;
-- 
2.39.2


