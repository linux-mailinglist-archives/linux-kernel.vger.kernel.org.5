Return-Path: <linux-kernel+bounces-22834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8A982A3AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE68C1C23013
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CE54F881;
	Wed, 10 Jan 2024 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i3azVk9c"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFAF4EB5C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28beb1d946fso4002256a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704923763; x=1705528563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UE7RP3C8HDn4Er6YTFEjRqxJbAFevtcwVndsQRkg/dE=;
        b=i3azVk9cSHxfHW6ECV7E12/ODJfYM5VfPsxKj6m1G35dY21rKzqgKsxIuULk4LR9ct
         TPLhU7/paPWPnQUnqBahmrXZHgj8JBACC1TFJ6fNL5W8DIIvmO1cBe/HqMEH1nQ43Hjp
         /gjcGIOFt7bTvGWDxxUiIUajJWo5tHeGU/hMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704923763; x=1705528563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UE7RP3C8HDn4Er6YTFEjRqxJbAFevtcwVndsQRkg/dE=;
        b=hEC7yMz7d0fdvCrxKFwbCJbmhmpM0Z8HyHTFdO2nZ62+6Ocry0xUGqbwE08it0a1Xk
         gR4Xm5MljMjR0Vsx69M1neVSSGK/lChT+X6wrOl8DItViZkFe+MJk/k6p5jOPAETJXju
         66Jfd+2rcwVyGZxEb19zMLjKlELtEyp6PCQrtRoQ3j0qVnjDCuq9cZ/j4L61e1YEUDX0
         kaBy4o/vgturLSgtdG2U6QxDGIJ0YqmSu8x9Ashq1RwWzVtF3wd10qa+3CkfXKPK0f3i
         akUUOgWM6a5JrKuRp6J3WXixkFnjaL4TO/lYIdGso1sNpT79gzzJfYQntK3zgWURsgO5
         O2sw==
X-Gm-Message-State: AOJu0YwSghJa2X/Hfz7HqQYlzRAY7XUELUVSznhj8cn61qglZeZDrMUK
	Tpbk0OGpmMF7NwYGi29BC5Gcm/6R+m+W
X-Google-Smtp-Source: AGHT+IGYDsmjlb74Cpw9MqShCp6RonR7fAVt63wWNrXhkFCn8e843x/Is+JTRvCJ6x/Cv0FCiw0qMw==
X-Received: by 2002:a17:90b:3b45:b0:28d:bd27:f81 with SMTP id ot5-20020a17090b3b4500b0028dbd270f81mr160165pjb.15.1704923763489;
        Wed, 10 Jan 2024 13:56:03 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db8500b001d4c955cc00sm4110254pld.271.2024.01.10.13.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 13:56:03 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Russell King <linux@armlinux.org.uk>
Cc: Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Keith Packard <keithpac@amazon.com>,
	Haibo Li <haibo.li@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ARM: unwind: Add missing "Call trace:" line
Date: Wed, 10 Jan 2024 13:56:01 -0800
Message-Id: <20240110215554.work.460-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3019; i=keescook@chromium.org;
 h=from:subject:message-id; bh=shusvn//qeczStLMEc4sOO3Q/yQ3K0G/IIulu4uAdzA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlnxJwth4D06xus0FK0kAp+T77TiWufHO4SgKAy
 dJYl30Wr8OJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZZ8ScAAKCRCJcvTf3G3A
 JjrZD/4hW/WVt5AVfKfP4x0ScGVIRwPLgBKrVNfked86KBRVaRSICfogjYkyIRX1W+681EpReWH
 B2d1ZTmHFYjzzA9YMF906bRhHKr6zoS69ugb/7DOGEEJCSxD6nsKIH5w0Nb5ck+/Ag5xqeJuPCj
 85POkwuIdHGy6VNfWCAVbryKykOG7WA/V5NPflHF9oL58DJ0MZpTrbW+tBg6iAf3S8j2pTkDl5T
 ssYyhGyXmjQl9BYjxW48wyyWnJPR6Sx0C7gn+8sOYP1ThWKFXyjRjXWNXgHyRqzZNEtXkrhg3tz
 KNbJ+sHzhzQrXjhZ2njjUOyMy+wT8qiVa8c8jCdMdvwUmE2Jtv9SBQBTp8vj4v0WSEnBn6+S0rB
 SqG8mwRUDAWnPZkH2YnFORrlS35nrB9GLzf1FeyRhZQrKpwH5fhcjjSwvxydgN/5f0oGm36BCWE
 v5p2GOtW88Rwee0uUQNZXfCqeG/VV5c/FFTs6IN3ZKYItQBnPsGaz1DC0nU81Wa1ceHuX/0M39r
 y/KoacAvpy34gGL/W6NDEsvh/a/ODUqM95bczY6vWFtfYSOJhgcUplcda1PWYsOkAGoNdfGNzx8
 iR11aMQHMPizouz/uoSJltVLJn7D8EnuJga5y1ftxoCD5MCGNWD4RTPHXyKTfL98t7qixHmT1Ag
 ci35/YR Vk8TZhIg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Every other architecture in Linux includes the line "Call trace:" before
backtraces. In some cases ARM would print "Backtrace:", but this was
only via 1 specific call path, and wasn't included in CPU Oops nor things
like KASAN, UBSAN, etc that called dump_stack(). Regularize this line
so CI systems and other things (like LKDTM) that depend on parsing
"Call trace:" out of dmesg will see it for ARM.

Before this patch:

	UBSAN: array-index-out-of-bounds in ../drivers/misc/lkdtm/bugs.c:376:16
	index 8 is out of range for type 'char [8]'
	CPU: 0 PID: 1402 Comm: cat Not tainted 6.7.0-rc2 #1
	Hardware name: Generic DT based system
	 dump_backtrace from show_stack+0x20/0x24
	 r7:00000042 r6:00000000 r5:60070013 r4:80cf5d7c
	 show_stack from dump_stack_lvl+0x88/0x98
	 dump_stack_lvl from dump_stack+0x18/0x1c
	 r7:00000042 r6:00000008 r5:00000008 r4:80fab118
	 dump_stack from ubsan_epilogue+0x10/0x3c
	 ubsan_epilogue from __ubsan_handle_out_of_bounds+0x80/0x84
	...

After this patch:

	UBSAN: array-index-out-of-bounds in ../drivers/misc/lkdtm/bugs.c:376:16
	index 8 is out of range for type 'char [8]'
	CPU: 0 PID: 1402 Comm: cat Not tainted 6.7.0-rc2 #1
	Hardware name: Generic DT based system
	Call trace:
	 dump_backtrace from show_stack+0x20/0x24
	 r7:00000042 r6:00000000 r5:60070013 r4:80cf5d7c
	 show_stack from dump_stack_lvl+0x88/0x98
	 dump_stack_lvl from dump_stack+0x18/0x1c
	 r7:00000042 r6:00000008 r5:00000008 r4:80fab118
	 dump_stack from ubsan_epilogue+0x10/0x3c
	 ubsan_epilogue from __ubsan_handle_out_of_bounds+0x80/0x84
	...

Reported-by: Mark Brown <broonie@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Keith Packard <keithpac@amazon.com>
Cc: Haibo Li <haibo.li@mediatek.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/kernel/traps.c  | 2 +-
 arch/arm/kernel/unwind.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 3bad79db5d6e..72c82a4d63ac 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -220,7 +220,7 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 	unsigned int fp, mode;
 	int ok = 1;
 
-	printk("%sBacktrace: ", loglvl);
+	printk("%sCall trace: ", loglvl);
 
 	if (!tsk)
 		tsk = current;
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 9d2192156087..f60547dadc93 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -524,6 +524,8 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 {
 	struct stackframe frame;
 
+	printk("%sCall trace: ", loglvl);
+
 	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
 
 	if (!tsk)
-- 
2.34.1


