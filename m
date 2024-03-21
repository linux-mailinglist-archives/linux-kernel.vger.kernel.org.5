Return-Path: <linux-kernel+bounces-110688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB17886275
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD1C1C21926
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06442136650;
	Thu, 21 Mar 2024 21:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzCpdDkm"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E090F134CC8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711055935; cv=none; b=a5HTZ6crD56q9nYNgWfJpa9WjGE/m8cWHFzWO2RmAt1/JsFbhnrAw2anMjib+tf02y9PcPMMo7+8/NLcDvTv4jCZKcaw7sRJwtBmvA5GDoyTEAaj8RNmKiIp5gdETMPTB4muVa3pGnSdNup6f8Hw71VxucUmYfmamMcWvViqWM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711055935; c=relaxed/simple;
	bh=CYkv0TCyFL7OBmpy0U15hldM8fnkJttzHPnQdaHZlOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAVbmhYAW5uy2HF5Os58Qx1Nus3c65MD/9FBoWcYA9tLOL7hQwUn4TIz1hRGLfyApuR9B/s6S5fRBnoFEWjJdaYbCXRM9WGeTlxIZdBfy7L1BhHi0T1q0vIjYpth0UOVqp0bdruDtUaaxC2uZjL2PIfSlhjOiFhNf7s7ZW4Qq1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzCpdDkm; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c3ae8fa863so662084b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711055932; x=1711660732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raksvTX6hatlvAyAefZzTCWGZczeDpaAiGLw02+PuGQ=;
        b=lzCpdDkmdTjHh4GvCv+u/YLFCE05fDDDE7/Q5a68+4HMxQiWtPcNgfmMONue9idD5w
         YvmNdW38CAgENB72lYLzW7+mft+nEuluEM00GDBKbFBhL5ePWO3dH8KuhGL7AkVI5Wv6
         5kZVFRYwDcXNBBjv4Mpej1BhVgiPbkNE7SAV27dSYZQn6tvwKPdRkzm1OGjEch9n3dET
         wPuUv0EEt+3yhqR3SRnaH3wLPlMuFkE1PrsUahxzm/wJjDGD6JUdKv9MqLWA1RFc4//5
         dBQNh7zgrcwNIvZFYKBIzS6DHdSu4MX8FQJGrEP9AG/b+zkeR8yYWzyfsG2KpX/qkDly
         xcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711055932; x=1711660732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raksvTX6hatlvAyAefZzTCWGZczeDpaAiGLw02+PuGQ=;
        b=Nh0F+cEoUx1rfd0k2X4f0kM+9F4AMy9oI4K+ZgOb5XlBGlrHD5a/8Y5LT1lvgXkCvF
         Xr5Jls5DnOplfDZMlHD55tF8aqzFUJsbj0lJxRwlp3bHRlLpx9TDCgXSTjCKndjIHf0a
         FP+pzH3Ge/hXUAz8FrITh577E8U1OJj9Cai3Cu5W695mBU78+HytoBbEChFfjGoE1jEF
         cB1Ax3DbZqnE2Da2AEao09Xr60dz33uN2sur2WroJBQRRJshh7RHGa9LbwHBFSKHxwYc
         VjFKA06Fo1eD3OgL+myfzPL982civ5crvftFaYEtrzCWs1avLoceIKtSqm+Ts04usR9a
         OpyQ==
X-Gm-Message-State: AOJu0Yx6s7NIKKWUxFPSG2FjlMSSvV08J5CtkKxwY1s37f1pn7gXMJoZ
	phcgKrMO9s2J2ja9dMNovC2a0sjhzMuTu0I1iSWyW8vWCbdIaNl5snVZs/M=
X-Google-Smtp-Source: AGHT+IEkJeupmSX2IYC77RmdChsdUGYZ4PRRMalm3JIoEs0IWX6DMzDTzGh/XUScjutl5xcdad7zXw==
X-Received: by 2002:a05:6808:1289:b0:3c1:f573:b68c with SMTP id a9-20020a056808128900b003c1f573b68cmr645701oiw.30.1711055932083;
        Thu, 21 Mar 2024 14:18:52 -0700 (PDT)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id gs7-20020a056214226700b006961cdc3f7csm304903qvb.85.2024.03.21.14.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 14:18:51 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 1/2] x86/syscall/compat: Remove unused macro __SYSCALL_ia32_NR
Date: Thu, 21 Mar 2024 17:18:46 -0400
Message-ID: <20240321211847.132473-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321211847.132473-1-brgerst@gmail.com>
References: <20240321211847.132473-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/ia32_unistd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/ia32_unistd.h b/arch/x86/include/asm/ia32_unistd.h
index aa065c94ccf5..7bcb82951c11 100644
--- a/arch/x86/include/asm/ia32_unistd.h
+++ b/arch/x86/include/asm/ia32_unistd.h
@@ -6,7 +6,6 @@
  * This file contains the system call numbers of the ia32 compat ABI,
  * this is for the kernel only.
  */
-#define __SYSCALL_ia32_NR(x) (x)
 #include <asm/unistd_32_ia32.h>
 
 #endif /* _ASM_X86_IA32_UNISTD_H */
-- 
2.44.0


