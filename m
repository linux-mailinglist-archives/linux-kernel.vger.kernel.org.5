Return-Path: <linux-kernel+bounces-124990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 016A3891F94
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FC9BB3638F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB4716DA22;
	Fri, 29 Mar 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoOTRZCh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643E116DA30;
	Fri, 29 Mar 2024 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716577; cv=none; b=rO4huqE3nKVylPy6fhbRubTU8YDUk40gEIOM2LMah4QSxF4rZYVO+CYqvkA1poIreINe099BoDOyuiXtml7OLP5aT6asKtXggHC1xEwVs+JCSOqoRSuzwFcpzeBOsf4QNrEAeEtnmtkqaLBVUQq/usgikCYa22JlEUocBPvQ/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716577; c=relaxed/simple;
	bh=z3XiLMh0cK+G0ZnTWiXCzpuT2OM6i7XU0zkUIoZQdhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3QSpu/KcBNrL5okByBdt+mD5GXpUW3tmqyVW3c39T1NbD9AlszNiGxzBgvGKU7Jy0ys8cQwptodBq9x1X5OgrMnDyBwVpsTKFyujmDzEqNCnObOkCVT+rMcnCnpWybh1mB2CK+gpHP8jpzkeXkmGKKqRn2op8Ua2KRjWIlWt/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoOTRZCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4BCC43399;
	Fri, 29 Mar 2024 12:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716576;
	bh=z3XiLMh0cK+G0ZnTWiXCzpuT2OM6i7XU0zkUIoZQdhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GoOTRZChAdreNmHiizKZyOZri12b9vAPbCUemkp0cZ/AZjZH9RKZP+gb6YJ3Jyl39
	 UnLFQRirzYXrV24gFJ+Ge7Ixx38Ag6HrrUSQ9EoIKUBF0JR81W8kpQd0cIHEuKZNQ4
	 aMOPYqeFKoExRu2FnmhhNo36Odjih1Af+j+TdZb78OCqXXMoAUvwYb6hhpzcw6eRme
	 GjV/w+4XO0A5hAaV0QXEYf10d5djjG67KH45+lQcKvP80bkBur8uaL01yCaPz94tmZ
	 IO626ivFvLf4438I3PxCKsHijzWDyEcGB191qxMPv98anpEjFCt6wQgxPsIpnGaPhA
	 RdhLWOGMomhow==
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
	deller@gmx.de,
	sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 19/31] sparc: vdso: Disable UBSAN instrumentation
Date: Fri, 29 Mar 2024 08:48:36 -0400
Message-ID: <20240329124903.3093161-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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


