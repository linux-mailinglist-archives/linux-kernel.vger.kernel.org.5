Return-Path: <linux-kernel+bounces-124779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07265891C69
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6316289CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C737139D05;
	Fri, 29 Mar 2024 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOxIM4w4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD34185F25;
	Fri, 29 Mar 2024 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716129; cv=none; b=T7nchxU94RdGQx+JDQaUDwazboh9WUP10+rLc5pxDqf43No5MA4jDOPeBwC2Vnib3M3QmfkzCrtl4iogdBTGbuFAmFqR0KdsPWxceGX7ZlkjC85qEEvGqNRCSk7uY0tQMR9IMDY5peZX6wUo7Tf3k49QeOwg5CPLIw+5RTBQm4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716129; c=relaxed/simple;
	bh=pm7u5txA0GV0Bl+FO1vus0FO5NCTLgJVXhLdXtvNnx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoNqxVwygeZN51rLvwuq9qt6yVSUid643Wx6KpmgnvG4XOOIiJlR6Fbxz5ueZXZuQRopdoZbuTP/KXaJrg+zyGgNPjRsZUkqRMYj4hvmerEkkC6QlrgjhXmKfISwabDrgxlu+EYUK9BRHgH5/EQlpSj5noZ6vcGR/+mfqiZ63Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOxIM4w4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8B6C433F1;
	Fri, 29 Mar 2024 12:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716128;
	bh=pm7u5txA0GV0Bl+FO1vus0FO5NCTLgJVXhLdXtvNnx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SOxIM4w4lB+coeyEHWYX/zWNRTddwMkm1AT5nbTBjEnvpiC8bSNiEb7zYCh/MwulA
	 jN9lga5Pm06QmX0CN9eto1zWVl6qSe3AM3qZGtq79zunvCiqVh2RukJWOpJUKQKQYI
	 OSuIsSsn8GT/YW5kVZ9Zf0QiK1iSMKJEjszoLb2MDXuO4bpwUQe8wzbv49cVXtJOHM
	 jeC4Li2DyjW7Q8IleRaF9N/uqLmYdnWDnQ+STqfc2JvboA2BpP7NkvNhtStuTkb/Js
	 zGnB+t1TXVTOuqxrMXCiOsYTWONWMzTkU1sF+tISrtDScZb2zRVEVsVEYM+IniJxrt
	 lEB44FU0oMZFw==
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
	guoren@kernel.org,
	rmk+kernel@armlinux.org.uk,
	sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 69/98] sparc: vdso: Disable UBSAN instrumentation
Date: Fri, 29 Mar 2024 08:37:40 -0400
Message-ID: <20240329123919.3087149-69-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index 7f5eedf1f5e0a..e8aef2c8ae99b 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -2,6 +2,7 @@
 #
 # Building vDSO images for sparc.
 #
+UBSAN_SANITIZE := n
 
 # files to link into the vdso
 vobjs-y := vdso-note.o vclock_gettime.o
-- 
2.43.0


