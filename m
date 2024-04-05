Return-Path: <linux-kernel+bounces-133186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E98489A013
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22311F241FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC9316F296;
	Fri,  5 Apr 2024 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR6dLFfK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575068BEF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328401; cv=none; b=UdJD1aoY1QPeTMqqG7aMYLO/p0Uc+zzEm6m2Zu3euKEHvBGqiph7tyoUDl1OC9rlIb1fgB8OpHLutspV7hdXXMLFkxFUrBlRg0pv6IKx8L7XUr1M3vDB/7wxBlh3sUBHxoeD0EllPLCMi9SsJF2KDmVsvDsuEEuirnDnzqgr8zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328401; c=relaxed/simple;
	bh=tu81MxJCl8lzqOKsL9mIE+wBbym3zJHuT56JK0pU1oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NP6AI9nPhe98CUBlmxKd0fAy6WEQWEmPDk/AThiRHqCJEhV3Bq+L37oSC/mC/lq2NzpcusowAat1PLX2AogTpsNqWe1oymcvvWUcS57FkFNzR4gR/7N+UVmjgl+/WwCCATt8xNj9surHrKzZCgKG2tiLAe47T1vfsQqYKJtMls0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BR6dLFfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A79C433F1;
	Fri,  5 Apr 2024 14:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712328400;
	bh=tu81MxJCl8lzqOKsL9mIE+wBbym3zJHuT56JK0pU1oo=;
	h=From:To:Cc:Subject:Date:From;
	b=BR6dLFfKiYMIXCPkDUKJAc2sBznOgm8RL0oWVlmK/kTwGjb8Y2a52Ub9JbkZn5wDL
	 XfurJ7kC2gnoitG1E6DmOh0amdjfXeQizyNzZYqtwjNqP9Bpgovym7Za0nKckUudTR
	 FBeOU3GKWEsVm8OgfXPClhyT7tv0ckWcrvd2U97ReRyLS5vppoZCGiQWGRGLTrHef6
	 0DosKPnmWQ+NJLNEriBdWN0r4RDGZ9HylJUwrbStUmrDDv0Pxsi6pl10zQM4CcRNLw
	 bq/t7JzjrJuFeqhvBr6k/Uw8hEuhtAguGPPgf6w9CYI1d5dc+XkE22ZpnP3a7fbXyk
	 tXZzvcVbGLSDQ==
From: bp@kernel.org
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH] x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk
Date: Fri,  5 Apr 2024 16:46:37 +0200
Message-ID: <20240405144637.17908-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

It is special code even if it is a dummy which is called in the !SRSO
case so annotate it like its real counterpart to address:

  vmlinux.o: warning: objtool: .export_symbol+0x2b290: data relocation to !ENDBR: srso_alias_untrain_ret+0x0

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/lib/retpoline.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 0795b3464058..e674ccf720b9 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -229,6 +229,7 @@ SYM_CODE_END(srso_return_thunk)
 /* Dummy for the alternative in CALL_UNTRAIN_RET. */
 SYM_CODE_START(srso_alias_untrain_ret)
 	ANNOTATE_UNRET_SAFE
+	ANNOTATE_NOENDBR
 	ret
 	int3
 SYM_FUNC_END(srso_alias_untrain_ret)
-- 
2.43.0


