Return-Path: <linux-kernel+bounces-62613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F228523A4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79DEE1F22D96
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE7855E71;
	Tue, 13 Feb 2024 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLK7uGDz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C855E4D;
	Tue, 13 Feb 2024 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783588; cv=none; b=oGCgk8FyFfkgQG3+p3YEBf9d97UQOvn53O4W20RPMkjFDtMex04xjxcca2MJ02E/5TtGDK2nhtJk6Si3zPYydVuglZiBwncJzkgOm88CxTfiHOESJGN9827QwR0d8fwQs/OOeyHfvaBKZQtkmW+7F6FAY0Ry3nd85YR3np6z8nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783588; c=relaxed/simple;
	bh=9PvseMVXZBtb/cwZqzTiH66r08HVA91dkLfACeiIZu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vjys16Wnke6zA93Uh2ptq38Maj1nkXDZ/fQ8Py7OjPrmvsl9yfkKc7bdq3+q47lkSZepKn/mr5n47BpB1yP6qVq4EvcFk635baE7WXxpbbzxOimP1rCS2aK3MApvAAJshfHQr7LxdQWY52WyIV9OeruQFLRyu1SdI6hH+6avm/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLK7uGDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E9BC43390;
	Tue, 13 Feb 2024 00:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783588;
	bh=9PvseMVXZBtb/cwZqzTiH66r08HVA91dkLfACeiIZu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TLK7uGDzQHV33+jP9uo3eeoHEXTbXb71kibUA3QBHdxiv+oMF/w0L4rGSFpSMM+3i
	 3HMe1k2V+gpm65dOY52JOi8iuwkIkH94ObMxSplIirprQhSP363MWmTlh21KufHqlM
	 Pro+UHbHbYecS8c1ibMjBqni3B3AVzzwMoz2NZpMGDb2GsbADpDOLafN13bwgEH7k5
	 5Z6U0SVczMEmWmLOn646G02Q+9IYX3NGCnTVEChBoGPG3+iwSttfswWATIehV+a5O5
	 A0jQufN+Ok3EEURtrrW0Ci7ENfxQd6ioELJPK8S6vrWQtd7jozW5GP2Eu3P2vRcID7
	 +L2Gt9HU5ejTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <lkp@intel.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Fangrui Song <maskray@google.com>,
	loongarch@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	git@xen0n.name,
	deller@gmx.de,
	svens@linux.ibm.com,
	chenfeiyang@loongson.cn,
	zhangqing@loongson.cn
Subject: [PATCH AUTOSEL 6.7 42/58] LoongArch: vDSO: Disable UBSAN instrumentation
Date: Mon, 12 Feb 2024 19:17:48 -0500
Message-ID: <20240213001837.668862-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit cca5efe77a6a2d02b3da4960f799fa233e460ab1 ]

The vDSO executes in userspace, so the kernel's UBSAN should not
instrument it. Solves these kind of build errors:

  loongarch64-linux-ld: arch/loongarch/vdso/vgettimeofday.o: in function `vdso_shift_ns':
  lib/vdso/gettimeofday.c:23:(.text+0x3f8): undefined reference to `__ubsan_handle_shift_out_of_bounds'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401310530.lZHCj1Zl-lkp@intel.com/
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Fangrui Song <maskray@google.com>
Cc: loongarch@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index c74c9921304f..f597cd08a96b 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -2,6 +2,7 @@
 # Objects to go into the VDSO.
 
 KASAN_SANITIZE := n
+UBSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 
 # Include the generic Makefile to check the built vdso.
-- 
2.43.0


