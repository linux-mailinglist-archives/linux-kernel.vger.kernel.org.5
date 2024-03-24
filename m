Return-Path: <linux-kernel+bounces-115911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C3F8894D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784731F30755
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9E7389193;
	Mon, 25 Mar 2024 03:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ujx3ucZw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500F41487D3;
	Sun, 24 Mar 2024 23:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322111; cv=none; b=QXB7y0/JtTHbeBSVtxHCvwtQIgrIsUf0x7PnBlxyYxPbXLYxHpoy17JrdkZMSw8Fy2uo7v9MG/DVv5f7cavgeK4uM86UJ+qETCXZuTJTCs4RWrDWYW587+wFOGILAD5QgRbubfxgeOkV+dVzbDP8wq+bmAErTyM3szoz2kuSWcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322111; c=relaxed/simple;
	bh=LtomxvTbkuJMqcMhjCYFUcOFgg5TJNgDVGGS6PHtBKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icZvDnd9h2fNCC3UCTq8iibAX6F4QMZDQFt6qDCeOOCfTFe0RJR3trhpH4lZqb2v1TaWZKZ7r+u9cz39NvrIyW01FmPw4lcct6VahReHuNcQfBNVx/3lx4KZ6M+SXFSuysWqdnJZUn44weyIUkY1oENVJZWbV9RZuEAFHCafxS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ujx3ucZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F63C433F1;
	Sun, 24 Mar 2024 23:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322110;
	bh=LtomxvTbkuJMqcMhjCYFUcOFgg5TJNgDVGGS6PHtBKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ujx3ucZwzOEx8xv6u+dLc7ZBkFJaWP2Osu1juxgSj/LRwGRMVsiLB4XONU2an9ANx
	 2dFakzvttHbNzZg84Qy2LQp/Q24JZu0VT18hASHbV7uNPP0NzCK9yuIJn/OJS0NLce
	 6t96TloiuCgwZlMqHA27HnfQqUPWl9udKKrPBWUZINaz8srNmoIXkoQyK3uJxwxUWO
	 lzcVMiajFyoWr6wIbnmtLS4EpoPtoR5BL2HDSTlWwCSSf+k0AcrGZe1976vNaP5+wk
	 ET5RgzU1btRIOFDWxBA8bL8UXAr19TsfZ0IdU7+vnoXgY42HxHbFwzICfnqxhn5A/1
	 KPN1boKmjgm9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 185/451] x86, relocs: Ignore relocations in .notes section
Date: Sun, 24 Mar 2024 19:07:41 -0400
Message-ID: <20240324231207.1351418-186-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit aaa8736370db1a78f0e8434344a484f9fd20be3b ]

When building with CONFIG_XEN_PV=y, .text symbols are emitted into
the .notes section so that Xen can find the "startup_xen" entry point.
This information is used prior to booting the kernel, so relocations
are not useful. In fact, performing relocations against the .notes
section means that the KASLR base is exposed since /sys/kernel/notes
is world-readable.

To avoid leaking the KASLR base without breaking unprivileged tools that
are expecting to read /sys/kernel/notes, skip performing relocations in
the .notes section. The values readable in .notes are then identical to
those found in System.map.

Reported-by: Guixiong Wei <guixiongwei@gmail.com>
Closes: https://lore.kernel.org/all/20240218073501.54555-1-guixiongwei@gmail.com/
Fixes: 5ead97c84fa7 ("xen: Core Xen implementation")
Fixes: da1a679cde9b ("Add /sys/kernel/notes")
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/tools/relocs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 2925074b9a588..9a5b101c45023 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -653,6 +653,14 @@ static void print_absolute_relocs(void)
 		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC)) {
 			continue;
 		}
+		/*
+		 * Do not perform relocations in .notes section; any
+		 * values there are meant for pre-boot consumption (e.g.
+		 * startup_xen).
+		 */
+		if (sec_applies->shdr.sh_type == SHT_NOTE) {
+			continue;
+		}
 		sh_symtab  = sec_symtab->symtab;
 		sym_strtab = sec_symtab->link->strtab;
 		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Rel); j++) {
-- 
2.43.0


