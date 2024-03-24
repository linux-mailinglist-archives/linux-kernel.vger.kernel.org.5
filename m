Return-Path: <linux-kernel+bounces-114796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73BD889145
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFAB1F2C381
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6A124C6E1;
	Mon, 25 Mar 2024 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsphssrx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487D22779EE;
	Sun, 24 Mar 2024 23:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323419; cv=none; b=gK0eZAjWnZNQkWnV7BEGoW8k+gEr26hCuHzE2ghVQqky5AnwfqswwO86dxXQV2pRauZKfV3nR4xyvFPOuWe6bZ55M88zkF9pf5gqUPTIQ6L+6lGwScoqoi6wZyQIqm30IvtFP3iURIyWzai5KGTupxSZ6R+4cJtxzaFwaFKHPZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323419; c=relaxed/simple;
	bh=Nlb0kfRs55O1BM88q2wK77zYMHkHRNZGzQoYWnRr4Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRxKyMNu5k0TJA2wCDT9gca4X3MrXdqc0a7ktNevJ9ekaKqiaUbE80Hw68ELD9ZXJVA7LIK3MDAThWUBFWOaHUGoDmSOJQAldu3e5rZHbxDdzQRl1frNBngPQR9SVdspiQaq3KP9zTf6BWoBcC3+wx6PGrI0w4FtnXDUiDOe9qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsphssrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C80C433B1;
	Sun, 24 Mar 2024 23:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323418;
	bh=Nlb0kfRs55O1BM88q2wK77zYMHkHRNZGzQoYWnRr4Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gsphssrxQzuHqphlVURxl9LPugHU3/V57Gfr0w4RoaeaeEvUzJquoGRq1fSENC8V0
	 /bccemamnR30Rv+rIwbki0ee4NSKMyW70pfzR/4SITygskJWHaMYPE6V2WVsiBVVCP
	 w1/jNYdQmq6SzYRWSI2yjbSpzZSfR97ckP0S0hGQ+RA0CoEh/c7RekUq/yaKWQiktK
	 URGZDBdn0hYbKjNn5AjeshagtLserEEEX+WNKWX5FiXeZCgHVSvAkHJzJ13XQALx86
	 Zs2VDX7h+REMSe1NfL1bUkjZ2oMvX0sZhyBBFN364VrTHlm22x47bOuDfmMz5cOZHN
	 EtNuSuI9x7+bg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 120/317] x86, relocs: Ignore relocations in .notes section
Date: Sun, 24 Mar 2024 19:31:40 -0400
Message-ID: <20240324233458.1352854-121-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 27c82207d3878..3167228ca1746 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -599,6 +599,14 @@ static void print_absolute_relocs(void)
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


