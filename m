Return-Path: <linux-kernel+bounces-34576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CE98381AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643A21C291A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FBA4C79;
	Tue, 23 Jan 2024 01:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="azrXpgIF"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87813C2D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972340; cv=none; b=hcv91yTSXjkDEy2VtqtUiEeyJO6b8ok6MtKJnX0Z3Iu70GYtLzyFoqzMSPFh8vK7FTHLjTxGgQbCYmFX5k9kVMCcRw3uOagksWlO8qJxfpTfYQL4sGJsMfQPteFULlkL0H/AAAFFlCT9nilbVlZkgw3t5n9IFjpKAIffQPFl3zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972340; c=relaxed/simple;
	bh=ZCXYUvRq5QkiujopZKa+oos+1nywJjGYg1IVAwcoHTU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I5NBWUV4nfIzg+rm24NTh1hGSJituoSHO/TxSHD23lvKY7AKpbqrhYsxsYaqEr+7VCtAe5w5LqpXt/wkvQbfyTCggQpI0x53/GRKG7dI/sDtLVBqyDE0yWs6x/GVYS20E276Z+UZA7cPuVH/Uzg7y8dZU/65jTyIIrMNhnotEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=azrXpgIF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d71e184695so13662825ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705972338; x=1706577138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4qH9Rf/zd/bFfsFZBAS2bb+VGZ3TWvzsYRdk9oqlfHE=;
        b=azrXpgIFgYmpAZoHosPXfQs6o5/SdrzwyLtUcLQGxUeLgcsnZZrRdiBvbiwfIvLEQs
         ++Y53QfJVQxjUAGAfEGaDiMrH7HeIbn/dov+75CX7DGdpRg3WhvWrDEIRx60tU1zK7rT
         +iJkRZrQK5CKqAPFk68AzoB//EiuzXhLcXRyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705972338; x=1706577138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qH9Rf/zd/bFfsFZBAS2bb+VGZ3TWvzsYRdk9oqlfHE=;
        b=Lrgoyse8Nc5OtrupdMH8E16i9GTDIsDqs2jUQOTpxUbipVZKJsC3Hw6SOF4vcr/cH/
         x58khXrWjkOdwN8YgZdlv9bsjqAm5xFeyXK1wCpQERJwt/Qx1w2jTlrTkv4qItPdM5b+
         dR16m94hByj2i6whUjiU83BbU5kZBLXDpZ0JXcM/KN+AqGj2EQioyEVUduBS4sURRbzZ
         dZH2nEpSkPF59By1OchDIEFBcyHhxHebnjcUuWlfMqvjfFWcKI6uwh2FG3iSVFrPr+P7
         U7xAyVwYjjd2IsLouze5sx+Iz4X4Ka/Daa0jl/873j5+jSBY3+Ai4dLBJm7K2BDdOLZ5
         J+cw==
X-Gm-Message-State: AOJu0YxTa6ZV7dqscKsO6oymmFbNSJIMbNU0hq9hfppz92ZBny203ctt
	po3qr33SEF8WOjxA8bCkEb1fSJK+hgkSQyA6jUnp0Xiet0kBYWX690jL07IGEw==
X-Google-Smtp-Source: AGHT+IGNrTPrac7ISZlO2e5t99w9hTwrpumEwsfIdx7bdlG3ZBChA/j7c0HGByhiNohLx2kmMirFcQ==
X-Received: by 2002:a17:902:da91:b0:1d7:4e2:592b with SMTP id j17-20020a170902da9100b001d704e2592bmr3161029plx.103.1705972338231;
        Mon, 22 Jan 2024 17:12:18 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w2-20020a170902c78200b001d71f10aa42sm5968938pla.11.2024.01.22.17.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 17:12:16 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Kees Cook <keescook@chromium.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Wang Kefeng <wangkefeng.wang@huawei.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Russell King <linux@armlinux.org.uk>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ARM: fault: Add "cut here" line for prefetch aborts
Date: Mon, 22 Jan 2024 17:12:15 -0800
Message-Id: <20240123011211.work.227-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=935; i=keescook@chromium.org;
 h=from:subject:message-id; bh=ZCXYUvRq5QkiujopZKa+oos+1nywJjGYg1IVAwcoHTU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrxJuxQakNaOdgA1fbKkrd9nBEjS8Bl0aB6r2y
 6AtqY38AQuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8SbgAKCRCJcvTf3G3A
 JnRTD/91aoq4t5Oh+w4+1avUipu20D+yzeP9E3R7zVZG/KmQyCAFUSLowG/5ggQFVkv7TN8Wit9
 ZGNlfOuX8hBK0yLB6hYBGfOoHcsh1Gn7bcwBK6V5HkupzaTohUCDm28WaRM4GPvyx+Lt0sk9A6g
 6HAcuu0GvPgX6ZpMW3G+OYfqnrXC+oDXw1JoWSZ6ByS0H3SiQBO1/3sspw9IPDLcxcce8B5/1dz
 7lZ+PhKbqJ0ZUh+DmdS4UVbOrtzf9bFsdKAMO5NthlwHeeEDPtwbDYqqqRhyfikfds/k0jrcyYw
 mj8r4Ckh93ofW3TTufuvqoiLToS0cQ4joPsbbgKTnwBLQnu/Sovm1SV+2qPeG8CSrylxToPn66c
 VJUZjaLhI+vzE8HHhwfOqOtFIAC4d2uqY0lZu/tXbS0Jf4sWTNDr9R3DVlvsJ035PhLX7Jzfzt6
 /yboV6QecaqFRqw2aPFwYL8F4LFLXCgrDrmms6oYk/+ibyVeOxxt0HAcZK1/C9pF1AAn5CBW+sD
 QZP/hxPvayNBRU2hgWSFhZCrPEm6Aa4GoXsGIqiMVQHMy1peVqURo24q89XsgK4LOQ9+HVURGJk
 WHNO5Xzhzh6evN0gwT+E+cf/LPul96AgTHVfftpVQLe/5AibJkCWT4fDM8VYAc/kgvx71nzhZEh
 ZZiuYLDe 2RO/4pw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The common pattern in arm is to emit a "8<--- cut here ---" line for
faults, but it was missing for do_PrefetchAbort(). Add it.

Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Wang Kefeng <wangkefeng.wang@huawei.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/mm/fault.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index e96fb40b9cc3..e804432e905e 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -586,6 +586,7 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
 	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
 		return;
 
+	pr_alert("8<--- cut here ---\n");
 	pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
 		inf->name, ifsr, addr);
 
-- 
2.34.1


