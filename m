Return-Path: <linux-kernel+bounces-141448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DF08A1E65
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E1528A1E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A55412C487;
	Thu, 11 Apr 2024 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSMjw9OM"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7154502B5;
	Thu, 11 Apr 2024 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858838; cv=none; b=b0XKxFScUR/UBWerJsxqXMrLCXFlSJdAWmmfyJYi0CoZ4XDTWeKLU7vicivGs8cTH+ArOgBhMre4bzYCuCEzl6v1x59lu8W2ucfWtvXL56ywriI237P9ad+RWLJ2Ll6HkmiM0Vs0FAHxAoigQI0w0fZMJsvuektOKC/pWSMa1Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858838; c=relaxed/simple;
	bh=VTwDf1eIoFfkhnb1xTaX228Fa2ijGUtozSt1/ABt9iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MO5LJU/OpXAxGY4Hr3U61KHsNpd6/KOpG3FCr+IyGz2CnOAtZ+HudareFPujZ/wVWaBWlwe+Uz89HlDOW71jgzjTODTlUkCwQ+3dNWFLU60r12M9hUMvIkyCv/HwsJRDCvMC4CZtcxJmJ3Hy6EkWeTtlo0KvdZxSCjxfn+HCSgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSMjw9OM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41650ee55ffso999755e9.0;
        Thu, 11 Apr 2024 11:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712858835; x=1713463635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVvsMWg3g1l53yb/VOtobt7muDfFc+ZRjL66sH9ZIAM=;
        b=gSMjw9OMSwPj+MazlFiWovPbbj2ZbPBGMgafT4/TAH/xTgs/FIND9uYmsNgZ0aMSVu
         1OxxjmfP1F0dbjpdIUUCzBPISuXOYlU34+SBvTjLfJkCko9+9U6NlBCXCrbuEAcCp4RT
         AOZE6Fz/VE2rNwTisjCjw1F4Kz043wNkeQRtVRxdqd9SMk0S4GBpzXqRGP8LKCyLaFXo
         cv00d0zxhpvR4ckVs0FZdzYvNL3uKD1XaHK3lyt7VXJSdoNL8JWd7rnWnIqGukdpcRmf
         cUs5qd1aBDpPAsXmay8q74jsLCNlRbSeXQYiJboWIAfZ9Eny8TRRyJYQFirIOpjcyCYW
         tgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858835; x=1713463635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVvsMWg3g1l53yb/VOtobt7muDfFc+ZRjL66sH9ZIAM=;
        b=Q8yzji8BbcG/FlA36POQRZGsFwjjbzN2PUnbg+DQ4P6YVzAZH0D5yXJdotCv3K7s+u
         MQ/3ziwBywOAecCR/fYXTJTQKs44FgI7aLZ8TZpzK8AqyqW/4ntHU/9pQxcHP9LJRnZV
         F9WbEERSv5IVldXYTRaA2snhx2IHbLioki7jHbxj8O0oZxrVAYRSCnrsPi2ekXDwS7Jj
         xTN89KgnQ+4a1fpn7r/6zcABYt3l6CHE8e4yMub3h40RYxBgLbpEl4vAup241TfcG9Ay
         IZBgtWWc3PuoITQXynwqQr84NqtfdHb5sAKI1Me5fvDpPj30a/ce51Gs7SkUCaVORwq5
         E/FA==
X-Gm-Message-State: AOJu0Yx/1MB0dmszN6PeVKaexFd37vhQRV2TygzwR5INWvejeVxah0aM
	H6rL6uoQhxUIWeC6c3NFtIe5G/siHmyVbHrfC64T38rvv+9OLkhO8ox19Q==
X-Google-Smtp-Source: AGHT+IG6CYcwC8MOg0ahDpnU5pBsLYZFcbAyp4xXvk24Xg2qWT9RZQeJUfD/q1YQYhivwdtB9dHryA==
X-Received: by 2002:a05:600c:3547:b0:416:447c:967 with SMTP id i7-20020a05600c354700b00416447c0967mr355208wmq.22.1712858834402;
        Thu, 11 Apr 2024 11:07:14 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id g13-20020a05600c4ecd00b004148d7b889asm6236802wmq.8.2024.04.11.11.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 11:07:13 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: [PATCH 3/5] openrisc: traps: Don't send signals to kernel mode threads
Date: Thu, 11 Apr 2024 19:06:30 +0100
Message-ID: <20240411180644.2023991-4-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411180644.2023991-1-shorne@gmail.com>
References: <20240411180644.2023991-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

OpenRISC exception handling sends signals to user processes on floating
point exceptions and trap instructions (for debugging) among others.
There is a bug where the trap handling logic may send signals to kernel
threads, we should not send these signals to kernel threads, if that
happens we treat it as an error.

This patch adds conditions to die if the kernel receives these
exceptions in kernel mode code.

Fixes: 27267655c531 ("openrisc: Support floating point user api")
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/traps.c | 48 ++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 88fe27e4c10c..211ddaa0c5fa 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -180,29 +180,39 @@ asmlinkage void unhandled_exception(struct pt_regs *regs, int ea, int vector)
 
 asmlinkage void do_fpe_trap(struct pt_regs *regs, unsigned long address)
 {
-	int code = FPE_FLTUNK;
-	unsigned long fpcsr = regs->fpcsr;
-
-	if (fpcsr & SPR_FPCSR_IVF)
-		code = FPE_FLTINV;
-	else if (fpcsr & SPR_FPCSR_OVF)
-		code = FPE_FLTOVF;
-	else if (fpcsr & SPR_FPCSR_UNF)
-		code = FPE_FLTUND;
-	else if (fpcsr & SPR_FPCSR_DZF)
-		code = FPE_FLTDIV;
-	else if (fpcsr & SPR_FPCSR_IXF)
-		code = FPE_FLTRES;
-
-	/* Clear all flags */
-	regs->fpcsr &= ~SPR_FPCSR_ALLF;
-
-	force_sig_fault(SIGFPE, code, (void __user *)regs->pc);
+	if (user_mode(regs)) {
+		int code = FPE_FLTUNK;
+		unsigned long fpcsr = regs->fpcsr;
+
+		if (fpcsr & SPR_FPCSR_IVF)
+			code = FPE_FLTINV;
+		else if (fpcsr & SPR_FPCSR_OVF)
+			code = FPE_FLTOVF;
+		else if (fpcsr & SPR_FPCSR_UNF)
+			code = FPE_FLTUND;
+		else if (fpcsr & SPR_FPCSR_DZF)
+			code = FPE_FLTDIV;
+		else if (fpcsr & SPR_FPCSR_IXF)
+			code = FPE_FLTRES;
+
+		/* Clear all flags */
+		regs->fpcsr &= ~SPR_FPCSR_ALLF;
+
+		force_sig_fault(SIGFPE, code, (void __user *)regs->pc);
+	} else {
+		pr_emerg("KERNEL: Illegal fpe exception 0x%.8lx\n", regs->pc);
+		die("Die:", regs, SIGFPE);
+	}
 }
 
 asmlinkage void do_trap(struct pt_regs *regs, unsigned long address)
 {
-	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc);
+	if (user_mode(regs)) {
+		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc);
+	} else {
+		pr_emerg("KERNEL: Illegal trap exception 0x%.8lx\n", regs->pc);
+		die("Die:", regs, SIGILL);
+	}
 }
 
 asmlinkage void do_unaligned_access(struct pt_regs *regs, unsigned long address)
-- 
2.44.0


