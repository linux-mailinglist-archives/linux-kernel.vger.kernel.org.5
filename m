Return-Path: <linux-kernel+bounces-124957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 383F4892067
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C870B298C1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4491A7F61;
	Fri, 29 Mar 2024 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi9M8JnT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241F51A9CFB;
	Fri, 29 Mar 2024 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716508; cv=none; b=RsUrPFyDRPbBVq+uikQjAvTMEcYThiWGDSrhzBRrVVB2klO6HQPqTk+k8ffNoXnH1Mu/oEUBR3RqxWRLXzteHvv/4Qv3kjdhBJlL+g4WopuDhZmJQtjPRnI811EuYQi7mldYRTo9SJqs/blWc3lm/6FtPhMdOD1Ya3q5povAMyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716508; c=relaxed/simple;
	bh=z3XiLMh0cK+G0ZnTWiXCzpuT2OM6i7XU0zkUIoZQdhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V32fFl2X9ibKZqtvJLiAL6uIdT1VBfrLucf/1Ppa+b6VNbZHyE94MwcjWLrNdghulsJO4wwr+cu3hGfp4WxTiSmgOHzYPaxeUicV4mfp2QjsahHYsRQ3lAyDmxeaeNqZ8yBUrQQtVpQamdH2BotRQdRtKuKx+IN58ccBP9Y0UXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi9M8JnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805CFC433F1;
	Fri, 29 Mar 2024 12:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716507;
	bh=z3XiLMh0cK+G0ZnTWiXCzpuT2OM6i7XU0zkUIoZQdhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mi9M8JnTczFjd+ZjXzLparALKEpnaNz2E/qsIHk/Wyf0qHS6CGgH44dTgYQr3XGbR
	 K4WqCkNJ362bvHvDya/HonRHzQZxUSp7YqrjNjpEcRQfwevqM/TMPU9g0PDtNjZCFT
	 evUP2dTdbPumamhtiGdDnpC0GuDcpiwoDiFklsuxBWD1TeVJg3zzu7Q2lflzhpQ74B
	 XFeQh+OnTc7DSG72h9SH0XLqBS6S4bvopH2ShgUnEVAKlB/QrFYnN03hmSt8q2dF/l
	 FnpAo5RleiIHVqwwP4v9WtB78G0/XeqOMzHLFcAofylxwoCLTwRcu9Jck7CyxE2fKa
	 P1opWPu6py7FQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	andreas@gaisler.com,
	masahiroy@kernel.org,
	svens@linux.ibm.com,
	nicolas@fjasle.eu,
	sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 21/34] sparc: vdso: Disable UBSAN instrumentation
Date: Fri, 29 Mar 2024 08:47:22 -0400
Message-ID: <20240329124750.3092394-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124750.3092394-1-sashal@kernel.org>
References: <20240329124750.3092394-1-sashal@kernel.org>
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


