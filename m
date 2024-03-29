Return-Path: <linux-kernel+bounces-124624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE7D891AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11415B2569A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FDC15E1FB;
	Fri, 29 Mar 2024 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8KlHdo9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCDA15E1ED;
	Fri, 29 Mar 2024 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715570; cv=none; b=mzakvcB2d4kf5WKwIyHzGMlHqqT9P4wLRWpQ8/ezCsWXHw1BMpANjzdXm0Uqdy8iaCvhuzPZxD2yVxhNixSj7J7zRsmov+weSgoAHodNSdlmuhGAWZrhmHbWHK1Jcfk54dDtCQPjlPGjmL/NQ2WKlvaDsVm2661ztXwcK/kqOdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715570; c=relaxed/simple;
	bh=9/XAL1SYI5dLknafqQdBszisijdv3UzkDC/FsG7+PU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxyyNis9hfYamWLJwagXFk3RdnmRXzy/mgm0eHy67YXqgyD7iXF6/waPaX0SiJA1ngo3/Z1Gt6q1t5N5OTDcq5l/y6J0dC8X9phiRpqk1y+YHk8hfI4eVZI16xfMp1HDelrF/tXxoxqInrcp6sklKS7+M46/E6H1P1A15gacGos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8KlHdo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26570C433F1;
	Fri, 29 Mar 2024 12:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715570;
	bh=9/XAL1SYI5dLknafqQdBszisijdv3UzkDC/FsG7+PU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k8KlHdo9H4oTzV6H7l0d6qTUguDYCiYUJt3VC2Ohz/eSEVmk61gcVkSlWqtMEl4Ap
	 sdbYMmoao+tyDY7Wpju4GRj7KcG8ES7G7WpsJJMby5LQphbJbZSqu2zfiwrrL0fdKC
	 zzHWpJK+oWN1uvOAq3JPmMI/SiEoxneq6Sc8Qjxq6qFqYNtWlKxT200kKr2F0qsCMq
	 l7SWbdY5n311zd0VlVJPKN2Vd/Dfq26QKYAP3exNSuOTaSHv+cJFR5Dn5H1hR0yST/
	 c/4x2YoORePPPUacDQECff7EzwY9QDkPHe9vkZS0Kt0EibX3X/cIUBBWo30OeNIdxt
	 nYlxCqIUASX7A==
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
	svens@linux.ibm.com,
	sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 21/31] sparc: vdso: Disable UBSAN instrumentation
Date: Fri, 29 Mar 2024 08:31:40 -0400
Message-ID: <20240329123207.3085013-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
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


