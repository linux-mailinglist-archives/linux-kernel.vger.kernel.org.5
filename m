Return-Path: <linux-kernel+bounces-124915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F2D891DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B698285F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83DF2BF31B;
	Fri, 29 Mar 2024 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXUP7S9k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39022D376F;
	Fri, 29 Mar 2024 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716424; cv=none; b=qDWLrRp/nda+NN4zrvMKEELvEeiQZTunKmTDPvMPFz9GbSFWTltKXsinFXg+rcY6g30Q8DURL6ZDKsckVfduF8H6ODMMuopzBfrEPvAIMCPVFSXLkilhVlgbijhDIm0rO2exi8tRpLQir00tXu2hv7xf0Hvac9foUpji+kOAL7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716424; c=relaxed/simple;
	bh=9/XAL1SYI5dLknafqQdBszisijdv3UzkDC/FsG7+PU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2tcuQWsNmwLDEMMyVeBvG7E2ROlJiANoDZR86a2BLur7fA9/ZhpinsDyO7sASHi6/X8NUb6xnfkZRNotqsPkOSbU+O04vRSnpQxtFmrBP2VjV/pQV7VO+0KuGxm4AQKgZCvW0x9BGAMEiUJMpnTBAvFIVSEAu0Ni62mNiJoOq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXUP7S9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936ABC433F1;
	Fri, 29 Mar 2024 12:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716423;
	bh=9/XAL1SYI5dLknafqQdBszisijdv3UzkDC/FsG7+PU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXUP7S9kzHQXEUH2YVU8SUsL9dg0/R2q0BavNO7YZV9sqpZXJY5B486HJ15HO5xhp
	 Gft2lhQ1EblLgoQfWh50AEIp6YFpkAnWFlC6P3ztn6fYkFTMuwHH0B1Gs4jpW44DaP
	 N1vZ4shN5CQwNZfX/74KAuWe3aL+S31FJhkWT65SpzGD/BmHEIcZuiSXUgIkb2o5Ok
	 nvKRLza5pRHF0p2tEkRe6oAcOXnYwm8d9Rz/GW/0YdWl9+JJfgPc5ZuguVfceuKf2h
	 ppxAoh6zr3u7XMi9S9o6mQsWwZJIAlgMiRZiOgTMuC+zkz+ey1C3NhxdkfWKmUpzQF
	 X2tlZXO4q0RTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	andreas@gaisler.com,
	masahiroy@kernel.org,
	nicolas@fjasle.eu,
	rmk+kernel@armlinux.org.uk,
	sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 31/52] sparc: vdso: Disable UBSAN instrumentation
Date: Fri, 29 Mar 2024 08:45:25 -0400
Message-ID: <20240329124605.3091273-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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


