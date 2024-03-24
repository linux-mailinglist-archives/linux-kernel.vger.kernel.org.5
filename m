Return-Path: <linux-kernel+bounces-114972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6E3888D32
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FC68B26D41
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BD01BF53B;
	Mon, 25 Mar 2024 00:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HodcedeH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE21311B1;
	Sun, 24 Mar 2024 23:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323705; cv=none; b=qb63XLbyeN6RQ2x9PiQIJpHJSUFOqzd+lerjSJ/BParhZFkm5+cXOYhXYyGIh8S/shuq7hilv5EoyJqV9YpHXF4Tz4TZX+clk+xm3XPaAoxuZeR7VKIUhwGrxpHsbD0l7rOlt2S0DYNUIlcXZruSbrt3vqDn2luRLrZ74LJCMz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323705; c=relaxed/simple;
	bh=8lg0zeAncBldALqSh3pqQu0z65I0wQjs983ZY90vK1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngR/8860hoRsLZuALjxJKdp/6pJaaE+ymxouA2+mt/4qEZ++fZSq9HQTCgQTxTUyI6YaV3StnBS7JOQ8eu2W0LB1JDWcfHTdOr09VsWdzrw7m/QouNmHm8uLqYPvhRBcafXQUInKLY5ynpNgRHlxqdODfQn0QJiDP/HXGvUMo2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HodcedeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3F8C43394;
	Sun, 24 Mar 2024 23:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323705;
	bh=8lg0zeAncBldALqSh3pqQu0z65I0wQjs983ZY90vK1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HodcedeHwNQyH/wa2c9kNUuMl6hE6XIRDbDnuS5FJBTuMT68egRFmyoh+a/UjX5IR
	 iqU4B1E8J3F5a3oJQpvCIpkD3gcf3D7VdTgjVKP2y7kXn6hXMkHCnwgTxp4vqLVXFC
	 1r1NerGfHgB7QDqQhJ28UKzUPytoOBH2fTcLztydganR/wetxnrucg1p4ul/9XzBYN
	 n9QNdlEKQZCbCspYLJVq1WfDbKE0FCaVHOB9hyUDDddfOLjVNhvx8AHsmyl1IFJymJ
	 s+fYZ3VTwcMzsn2FH7XyxTtKaEQ/ruJMvLZqziEKwqtts0d7GS9Irk9ymnjMvO2PIx
	 TKBTApW6h9V+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 078/238] x86, relocs: Ignore relocations in .notes section
Date: Sun, 24 Mar 2024 19:37:46 -0400
Message-ID: <20240324234027.1354210-79-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 1c3a1962cade6..0043fd374a62f 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -596,6 +596,14 @@ static void print_absolute_relocs(void)
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


