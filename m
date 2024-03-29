Return-Path: <linux-kernel+bounces-124672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E0F891B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B297AB224FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCBC16FF36;
	Fri, 29 Mar 2024 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8dhTjE3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29EB16F918;
	Fri, 29 Mar 2024 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715667; cv=none; b=ITUbw3GLnYfjt22NZhsAqHdAwfRYFXSvMgrYX/5SNOJHsFXuc/qEDtjPiE59Vpi2Pg8dN6UrcB/iP1Q9jVRNEbHZoHQ+bk/QrnsXtzf4nkEVEM8QimLriv7FAV1rQuRQNnurGXY0o1CtEwz1YlJdU6n43SHNROtCp/JjeHo7Qlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715667; c=relaxed/simple;
	bh=z3XiLMh0cK+G0ZnTWiXCzpuT2OM6i7XU0zkUIoZQdhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeV8Ja3dQH1glaR8BdAiD76edKVidyMxKeDWrnEHgqn8l8rYjQWuwBGQz/6DSDOKUD9SfzhzEfscA8cLqB0Gj33Z7cLDm498Gn+wTvMITne801AtIoniz6eteCiwn59xwing7d7MPf1PwfRO7Gf3XOcTLV8PQoOwRmA7e7H/Vtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8dhTjE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07478C433C7;
	Fri, 29 Mar 2024 12:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715667;
	bh=z3XiLMh0cK+G0ZnTWiXCzpuT2OM6i7XU0zkUIoZQdhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F8dhTjE3PbiAd+OmOt9wtpvePBEek+dsgnK7IJX6YuBVqUpFsGI/n1ig3YmaI4hDO
	 EMqhjJL7Gv3M7B2RtAJLX63RpGxpctbFW0Cre6FN9RDjHKlj4+rYjRsNOjvSHvsodq
	 9AsJoniN5VUIs2Nh/T/F6x70Qsq7McQ1oxoo7QhCWJ6Bb4Eq9RJqQs2Vy3Mqqex3qU
	 TWjAtBlDmFVx1nc3ULBEHmxFVi3rRjgsHiZrUEYNlToPi5pbzZ1aRiK4LmPJfDw+JS
	 XswuNfzdOiNh2dudgVLLD/vqbcfZqNFZtphvINaoG//Tz70sflYp9qK7bhYGR9H8oE
	 j7mgq4pagi6yQ==
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
	rmk+kernel@armlinux.org.uk,
	sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 11/17] sparc: vdso: Disable UBSAN instrumentation
Date: Fri, 29 Mar 2024 08:33:50 -0400
Message-ID: <20240329123405.3086155-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123405.3086155-1-sashal@kernel.org>
References: <20240329123405.3086155-1-sashal@kernel.org>
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


