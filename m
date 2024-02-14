Return-Path: <linux-kernel+bounces-65436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC114854CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A461B24BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BB35CDD1;
	Wed, 14 Feb 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pq/wuvah"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8552D5A4E1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924961; cv=none; b=PmBSUo2jql6ry39xPMc1Bn/wnQ1hHw8x68T0arj3lyzfj1ZGVythLLcbETzWX9FJdv/m6QJPU6onjcvnA2zT1Jt2y+qMhXtzKVNvOC8uI4cWViFGaEmKINp1NxVG8uM2gY3xl69JcpNRRwFg/GC8j3bXNeO3gxcvYHnZSFHr6yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924961; c=relaxed/simple;
	bh=1gmLICY6cDXg+Ka/QqauVuAr4yd4plrFZsbMBLjzbnI=;
	h=Subject:Date:Message-ID:MIME-Version:Cc:From:To; b=BV1deRK6PQusTOQkzP18rUXcpGna2WAZqcfC0Kfe2HPJjsaCcZWZ+3hBNL1xLIrfEVTCvd6jFnwAGXQRQaqXpsZ607bkdfmWcb8W9H/KysxGVEc3xXjiQas7C+zuw8ALFyDXP3XoEIJ5ya3DR1RPIqAELsqRpsq4dGhfYe3nOj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pq/wuvah; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e0a4c6c2adso2226670b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 07:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707924959; x=1708529759; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=rsMZabPqQdOyGUzvRmcq12qy26eK1NK8IC3lX9TP0EM=;
        b=pq/wuvahjd8AOz9Gc9wozSoDZAk24MbPabeObkjDmcTV5HXnyK2mDuNY6wU4sJoPIn
         wm+VJJ04kJg4Vvl+vt1A0SPkRvqvIgFCQGUJph0QkJTV4ttQkxF6yXyCvZpI1kC2IlY/
         B+PsEtYP4gKYZB/y4CqhgUBZzpWGsDJWmqgJ9hYbplDTFZ/Z75XfUvL4IFE5GDDLL5wq
         c3A5ru2Qj0LSqVD9DXo6mDm8A3n0/oMAh76QVi8aUomKP9ciE5TQpu7v8nOnXyF5m2bI
         4RJW1RJRT4I64aQrA+Jr/SS4K+sLUIuCfa4QuLuBxET2D0YBjaWZtr9iXm8js7WKOxzr
         F2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924959; x=1708529759;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rsMZabPqQdOyGUzvRmcq12qy26eK1NK8IC3lX9TP0EM=;
        b=S4RMJnk8mvflo30ftk1tVSSyI6UZUsLnlTPKMswuTv3YJzmMOlQVJS7RdG7UliqTXk
         i/uavOx2Bv9oodJPWzE2OnZLSPTXoHtrnmzmaIWrgURbCk7c4gYnscwL/r81QjZ6ToLh
         QHKIa7WwLTyCMYYDmbEwYYgjfHLIVhX7iKGfXBt9h1xyE3zV81lxhRIZy8GOYH3AAvCh
         jzK/UMBrV3eOt2a/+1NWVpn5AUIUcud2M1Gbrp6IlkvtcE8yXclauoD/FsvA6eSAgJWe
         n+rOxoxbYjjjbfCx/Sm1NGarOae0G+ousz4PljY1RNGSP7bu9uX8PfyzeF4cvXI2oQOH
         RUPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOcidR/Z5XuBj86EhCPpukpYH3VibKlpxOQw/dg9isD/o7z88+5EaPbMj2brNxSettveufuZMcnVR0TIWB/CW/Ch4EE1bS+ehIveQE
X-Gm-Message-State: AOJu0Yx7wZS9s8nBTIDo3CL/+MG/qEtknr/EzqDp9mbCHG3Ygj0S1U+Y
	c7w7kpFGJtgUj37tpERsG54k0W3jN6Cb0/zXvgA4zZYC+x48MXCMLcG1+NWTQLw=
X-Google-Smtp-Source: AGHT+IGCj5QYYGRsrk8Q2pygd+6XJjwy1KOMVBJGfPsVyi6BD67Qztrw9Lzw2Qr0q8IX8o3HWd0//A==
X-Received: by 2002:aa7:8b8e:0:b0:6e0:5281:e0d1 with SMTP id r14-20020aa78b8e000000b006e05281e0d1mr2385582pfd.1.1707924958554;
        Wed, 14 Feb 2024 07:35:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVi2q1qLmAsiIATfz24ig+iFdorSpWUIiVssALGUs9LyD/SA8Svg+RLskFF9Q3UBkfSIXUaqNAHSMROGt6rGhEjBIg8i400pd+JHT7D7ZPZig5ML1gXfZtiDwZSLuOr2IkB5OzqIQu5QHPMiC38TLbMz70t7m9sw126jWAF0Pi8QHsfIZT0cwIeMyzRoPB2O2IuROzwxS/cNdZ4lsd+3Snpc4Q2rdGzDCIMbRaCrt/hh6J393hnZIhkBWLUHHl8xpwy/bHH5iorENgQzCDaVoJKIAmtPkCrSkGDdd2JoKia20r/7sCfPQDtw3KMONjAkn80c8+y8aeq+1rCcVgx+jld/U14DkTxaAae39nF
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id h28-20020a056a00001c00b006dbe4452741sm9508749pfk.72.2024.02.14.07.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:35:57 -0800 (PST)
Subject: [PATCH] tty: hvc: Don't enable the RISC-V SBI console by default
Date: Wed, 14 Feb 2024 07:34:30 -0800
Message-ID: <20240214153429.16484-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
  Palmer Dabbelt <palmer@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, ajones@ventanamicro.com,
  apatel@ventanamicro.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
  linux-serial@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>
From: Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org

From: Palmer Dabbelt <palmer@rivosinc.com>

The new SBI console has the same problem as the old one: there's only
one shared backing hardware and no synchronization, so the two drivers
end up stepping on each other.  This was the same issue the old SBI-0.1
console drivers had, but that was disabled by default when SBI-0.1 was.

So just mark the new driver as nonportable.

Reported-by: Emil Renner Berthing <kernel@esmil.dk>
Fixes: 88ead68e764c ("tty: Add SBI debug console support to HVC SBI driver")
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 drivers/tty/hvc/Kconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 6e05c5c7bca1..c2a4e88b328f 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -108,13 +108,15 @@ config HVC_DCC_SERIALIZE_SMP
 
 config HVC_RISCV_SBI
 	bool "RISC-V SBI console support"
-	depends on RISCV_SBI
+	depends on RISCV_SBI && NONPORTABLE
 	select HVC_DRIVER
 	help
 	  This enables support for console output via RISC-V SBI calls, which
-	  is normally used only during boot to output printk.
+	  is normally used only during boot to output printk.  This driver
+	  conflicts with real console drivers and should not be enabled on
+	  systems that directly access the console.
 
-	  If you don't know what do to here, say Y.
+	  If you don't know what do to here, say N.
 
 config HVCS
 	tristate "IBM Hypervisor Virtual Console Server support"
-- 
2.43.0


