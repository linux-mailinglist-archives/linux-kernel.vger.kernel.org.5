Return-Path: <linux-kernel+bounces-124648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0B5891AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079FA1C26201
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23559161B58;
	Fri, 29 Mar 2024 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7r35N7V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67A1649DD;
	Fri, 29 Mar 2024 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715625; cv=none; b=Nalj5PyHUNsaB+A+44hIV5AgIUOPULUpW2wieFeaTgDX9C8i3d1J5gqjoxXUV2OZXOcTnvjKFOPGLDnb377BhN+ums0xjvjNIvepaWmpZC/vMq4NlksCxHdHPoRLLJfoIxlsAVJzIr9RCYO2t8WKwt9WKHHIdv+NSUvTV/vL7Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715625; c=relaxed/simple;
	bh=z3XiLMh0cK+G0ZnTWiXCzpuT2OM6i7XU0zkUIoZQdhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpIHa0aB3nkzxF9RCp+hCzc/oHrDE7g9imz+DYYLm169HSMqxnZynRltHrtyeDwx+MIDip5/DhaUl+7/azd9/MQFPzl8CA69IKjoPGaUph03ntlfjcbUUn47PZH2hONzgz8HawUac5+zea038taGVDR/oQiDjCl9FbqrMv+4UnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7r35N7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D86C433C7;
	Fri, 29 Mar 2024 12:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715624;
	bh=z3XiLMh0cK+G0ZnTWiXCzpuT2OM6i7XU0zkUIoZQdhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7r35N7V0OTvmvfHzlmdCa3141ryDTzS/BUzRWY1pcCSkPmPnlbTOziESx3EHrkvf
	 oSe9LKHfaLKRRfki6xhOkgHxvDUdlBhSoAEb66kIcKiCHAdI9f8cQDxqz37H+jTgMH
	 r5HuzJqzvtFjKsJUZnEbbf7DBGfLDUDlnQVck14Ns7PrGhUxG4TWnnDOUChlK27t0/
	 G6YH0YWfl5bZod67oqEcIKEso35Na4ysCJ7zo7cn6z/vpiF6ngLTx3cFGdCYsCrTeZ
	 v0VYUWYzNsZTX+8QqgBaeX4K58XCskyz8RpcHr5gON2Vcjamag+QMA8FowfKkEcsfv
	 HPZSq3o8ERMPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	andreas@gaisler.com,
	masahiroy@kernel.org,
	catalin.marinas@arm.com,
	rmk+kernel@armlinux.org.uk,
	svens@linux.ibm.com,
	sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 14/20] sparc: vdso: Disable UBSAN instrumentation
Date: Fri, 29 Mar 2024 08:33:02 -0400
Message-ID: <20240329123316.3085691-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123316.3085691-1-sashal@kernel.org>
References: <20240329123316.3085691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit d4be85d068b4418c341f79b654399f7f0891069a ]

The UBSAN instrumentation cannot work in the vDSO since it is executing
in userspace, so disable it in the Makefile. Fixes the build failures
such as:

arch/sparc/vdso/vclock_gettime.c:217: undefined reference to `__ubsan_handle_shift_out_of_bounds'

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://lore.kernel.org/all/20240224073617.GA2959352@ravnborg.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index c5e1545bc5cf9..d0f6487d1e790 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -2,6 +2,7 @@
 #
 # Building vDSO images for sparc.
 #
+UBSAN_SANITIZE := n
 
 VDSO64-$(CONFIG_SPARC64)	:= y
 VDSOCOMPAT-$(CONFIG_COMPAT)	:= y
-- 
2.43.0


