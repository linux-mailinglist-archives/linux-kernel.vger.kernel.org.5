Return-Path: <linux-kernel+bounces-124689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50885891B6D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A2C1C26608
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA3317334F;
	Fri, 29 Mar 2024 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVu1dyvs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1EE17333C;
	Fri, 29 Mar 2024 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715707; cv=none; b=gGiPds7/vjg69CoDA1zKUX+L90jmcl4Sbw6tOUa8lPNTEnx583PDN/16PhP/fnTk23x7y1oxSk/M6YU7RKHBUqdGfCZr93szC+CmzIBdeMDljN2wSUB3zCdBdrkbLbZiN3ME3fXrEBxwDDwNVUCQw2pX032vW/LifY4lHQeGMig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715707; c=relaxed/simple;
	bh=lRVkrFF93OgjKTOJxfW5xcxxpMm4wx7SGwA+QNECwS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZbDxWe0qhrvmcOMDQiowNEPgLbGN0hhjBux+B03uGFHcvgLHBM5zkrLa6+G5kYjQDK83Mci9EFZkBVUTrS7d06B4pl/Eok1cWEE8pMRb1im35Fj5dnvbE65iH4WDxmB6ODD3N/y5bhC+1A/BMQlJqiAFKmXi0gMM02acb4aDik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVu1dyvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02513C433B1;
	Fri, 29 Mar 2024 12:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715707;
	bh=lRVkrFF93OgjKTOJxfW5xcxxpMm4wx7SGwA+QNECwS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVu1dyvsb3T5GDJOLKlXARnTZAOWUh34XCTnpA1Iy1D+CTy92lZHmYZ9CVSd/LE2e
	 NzR+DiorzIfR1W2SaRHBpj1DL6UZXN7xQaE8/JI5sY1STsJuJCQFr3YIZMsO36pXrs
	 MBOXGuVPzvzM0t6fGGNCPfFQOzox4UpYCHgYdXfg5NOkCGLuaGaTGJFy6RVyZ2yFKr
	 hajaa7c249YoDON6wjQbxjgh8pjVnpg79b7xLEuvsyG38RfZBIfuIJbkxcPkG9PvbV
	 8F1qtX0hQdh14hmukrksZVNGKopceUUCNmc5b8+eU3JmGzx/qcNpy3xLElISCR46HP
	 9R1zjeVEfFj9Q==
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
	guoren@kernel.org,
	svens@linux.ibm.com,
	sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 10/15] sparc: vdso: Disable UBSAN instrumentation
Date: Fri, 29 Mar 2024 08:34:33 -0400
Message-ID: <20240329123445.3086536-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123445.3086536-1-sashal@kernel.org>
References: <20240329123445.3086536-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index 997ffe46e953a..5b869c2c84363 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -2,6 +2,7 @@
 #
 # Building vDSO images for sparc.
 #
+UBSAN_SANITIZE := n
 
 KBUILD_CFLAGS += $(DISABLE_LTO)
 
-- 
2.43.0


