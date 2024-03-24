Return-Path: <linux-kernel+bounces-116124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037A6889971
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34FF31C326E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2983A98C3;
	Mon, 25 Mar 2024 03:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goxU7WUm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A617A387;
	Sun, 24 Mar 2024 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323657; cv=none; b=Ar9TDigdg/Gp40/A4/RlDX1XMl/wuEaKXHJgCfMrqz+bCA05b1xUR/+Uk1kWx7S58oGs8Epx5bLY0jYVH6ahn/ADfkho9G8Y1Wpn9XzyKkWO0G2WLz2LxZ0i221KvLzZ7GWdBDedq8BOr0s6Or6mMhuZkl4KhYaL7YFODoK2KxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323657; c=relaxed/simple;
	bh=h4lItqMeOzYnNgZPMXZ1qCGx/yc3jP4yGmrQlDOCSYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rn6cGF/EkGtwQMi8qYvtSNF4CMkqFs3M+3hAwSnPsCD7Rzgc7fhN4bm6eKyMbgep4Z1zNeJZ9ncLuxGoU0mS387Kfj6Pu1sH3mu9mYBDHSVCdqxb5RDgqjKKK6xHXG+ifcD8NQ4O1RhxlGIA7zj13JB+rZ2TVmVW3G3UNPLORxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goxU7WUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAC1C433F1;
	Sun, 24 Mar 2024 23:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323656;
	bh=h4lItqMeOzYnNgZPMXZ1qCGx/yc3jP4yGmrQlDOCSYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=goxU7WUmE17Xr0I9m+si5NqF0ckHae5ATLZocolopuZz7YzcHlkB+rUZXY6ICTlKu
	 0I5octrrZQIK5h9xe65x/41R/GTG49CekkGVf3NggzOsWR3vQg1uaiLaE3ONA1O/Hl
	 v73Jit3D2KHgFCteslR54FY8e8y6ceVLQjLB6HZUyezild/uDEu7lcpSy2eSleAlg+
	 p9o+VPuoQmolSEGGNeMFI5VcBe/pxhSPytQI5Tl4mhj2dIiDD4AVFzBSyoRZuXpIUs
	 TRAB6FpBjXzjN5rgHGUjN4kqIG7Kj6Am1F8tRivx1Y1nbedkts6k0y/3/keH7NSZJa
	 r7xZghNk40K8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
	Omar Sandoval <osandov@osandov.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 028/238] x86/paravirt: Fix build due to __text_gen_insn() backport
Date: Sun, 24 Mar 2024 19:36:56 -0400
Message-ID: <20240324234027.1354210-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

The Link tag has all the details but basically due to missing upstream
commits, the header which contains __text_gen_insn() is not in the
includes in paravirt.c, leading to:

  arch/x86/kernel/paravirt.c: In function 'paravirt_patch_call':
  arch/x86/kernel/paravirt.c:65:9: error: implicit declaration of function '__text_gen_insn' \
  [-Werror=implicit-function-declaration]
   65 |         __text_gen_insn(insn_buff, CALL_INSN_OPCODE,
      |         ^~~~~~~~~~~~~~~

Add the missing include.

Reported-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/ZeYXvd1-rVkPGvvW@telecaster
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/paravirt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 5bea8d93883a2..f0e4ad8595ca7 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -31,6 +31,7 @@
 #include <asm/special_insns.h>
 #include <asm/tlb.h>
 #include <asm/io_bitmap.h>
+#include <asm/text-patching.h>
 
 /*
  * nop stub, which must not clobber anything *including the stack* to
-- 
2.43.0


