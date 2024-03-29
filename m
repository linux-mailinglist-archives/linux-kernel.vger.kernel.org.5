Return-Path: <linux-kernel+bounces-124534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DA3891979
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C537E1F24F38
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3698148832;
	Fri, 29 Mar 2024 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1lJMSCW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A825148822;
	Fri, 29 Mar 2024 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715325; cv=none; b=HHzOgvu45Sv0nq+wvo4gKEm/x4cmdPzE7M5TpRObLDRqj6gwoW3e+pZxyEIGj2gRTfgqFLGO80TRAM+sNakVQUaALAGqJjQnw+SOMUh+I0UbPLpR8lXJixvRueLjIUPTMeswNoKoMS0ft1wkZb3ZbeQAi3aEhC0cAcrgLk9qXB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715325; c=relaxed/simple;
	bh=pm7u5txA0GV0Bl+FO1vus0FO5NCTLgJVXhLdXtvNnx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKL9bb3lom+vYS2Jy1IQ5aaqvLfTjeYh0l0s20liV7Ce//v5mIu/h5126h3jxsAatFfWOwxwJvEtVvzC9+ma+c+JR3mgBVEAoIj3bcxHq4xtJ4GNZesatQwl3RW1LX8Y9FtJ1awHDpRxmjqjn8cVKp80MJu0BfzLoTRWpWQt8fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1lJMSCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AACC433A6;
	Fri, 29 Mar 2024 12:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715324;
	bh=pm7u5txA0GV0Bl+FO1vus0FO5NCTLgJVXhLdXtvNnx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1lJMSCWusHePJrnjoYKox/6no4JSqCqtWywuqHPwLINrGcPmEYi6ytjPzAx/mXqC
	 ANzDhA94J0bEdCiiVLxBLT9FCxHSNUTXaVB5idFqm3IhHEjkYOmwm3xoV7H63Xf8fK
	 PUdSucCTAuuhCXyNr76xaEIHdUZ+6TPnVUVdYp68zkWDXRvuMqk0QL1JjfX7Gk2BVy
	 1K7aE8j+KQDmgTslQMzv5mCcvf7X+7Cz9kgldK3OEYX9gHDMCm/e9rqtSOFlz7rl0f
	 HJ3Onow4Q1zY7TCPU9ZI0iDJUutHDXlE+nCAI5SF4+n5vD4fDgMMPZ44glcB1Zy2mz
	 nJcCQULJbQVYw==
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
Subject: [PATCH AUTOSEL 6.8 53/68] sparc: vdso: Disable UBSAN instrumentation
Date: Fri, 29 Mar 2024 08:25:49 -0400
Message-ID: <20240329122652.3082296-53-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
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


