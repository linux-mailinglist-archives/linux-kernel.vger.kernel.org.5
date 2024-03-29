Return-Path: <linux-kernel+bounces-124859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368C3891D30
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D1E282525
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B911E1C5AD9;
	Fri, 29 Mar 2024 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnCRjY37"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FFA14A4EB;
	Fri, 29 Mar 2024 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716305; cv=none; b=fBusHmmV2b2USAlfescOyMnJf9GXaBG9jNwZHBHSqAuxYdbYep3B1G25emvRnOs4q3Y7aWokvmIXhUfeOzWHzg5zmP/GCG/6U/lukRHbIOMXAdC+fIgj3jITcWhM/fYgFc3OuxdRfyYshHWPhbzPm0Ftq2sml2P1ME1rdDqX7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716305; c=relaxed/simple;
	bh=9/XAL1SYI5dLknafqQdBszisijdv3UzkDC/FsG7+PU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezsQI6QtwQbLUNAubygTVyNXA2nqjx7mtw9Sf3vKyBgcguwrCB8IaMZQ7kiDnOUjvvoiuxR1xc0Vif8maNyQcwuHieXlGqHFpDeQjTEVSZcxrStEjeaK9yqEU0nyzt8e8+p19fY3DkIgJVv+gyKSVfpiRfMmn3PWuNLwCNVk0e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnCRjY37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8934BC433C7;
	Fri, 29 Mar 2024 12:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716304;
	bh=9/XAL1SYI5dLknafqQdBszisijdv3UzkDC/FsG7+PU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RnCRjY37wvBC+aoWBeRzDNSWzYBeEBHH923F5ebj1kYzHgqWfYLlKMt2Fd+xUro1G
	 uPdjRd5zhHafW9ZqOoha7cWFlvbpcnuTjYW6wWslwyCGTKCIigSmx4hOdAofltO40g
	 IBy/6KSCG0zVeR97LeE953jSsH66xaIqXm6eQBJbQezvcxnYf+3ULhPNCO1+IJS8Vf
	 fXWg1sRBalPFVbqoN+5kbT6DjW/+F1P/eOg/D3MWY+AaJIOIRWS5Mhhhuq+FQSaVTi
	 iiA3DQUVomg+frRz08/AK8X9bhZqGkHpMap6gDq2abx2xVUXLO70dHiYjFPsZruywR
	 Y/ITB4uYJ7EFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	andreas@gaisler.com,
	masahiroy@kernel.org,
	deller@gmx.de,
	rmk+kernel@armlinux.org.uk,
	guoren@kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 50/75] sparc: vdso: Disable UBSAN instrumentation
Date: Fri, 29 Mar 2024 08:42:31 -0400
Message-ID: <20240329124330.3089520-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index 77d7b9032158c..cb046b9d1eddc 100644
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


