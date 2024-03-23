Return-Path: <linux-kernel+bounces-112316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 957F6887840
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A11282778
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96B31756B;
	Sat, 23 Mar 2024 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l35s4/1q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242732C80;
	Sat, 23 Mar 2024 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711194321; cv=none; b=B9O4wsH94QrBgpM7XajLVlaQVL+H0W7REGBF2whZpMMte3aEjoTa34OGLjpKj+cPrL+OzuhpYGi9e2fTmK0GKmnNm3HF1RcGuOxsWIz/MBr1FhYwyoV9vAqbZ5mPkxy4T50B2Q1j9aUSmP7VnrpGxF419VUfVnln0/CqzF8UhNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711194321; c=relaxed/simple;
	bh=17RFStLEDNlrMuDxB5LQdmbGIXnoteDvrGHTjRkVgSs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d91oxjrPFAbVMOx2TSrpU6Mz91cABgfOcVqustcdv9CmIXL45wwqbtXCEDRZV/s36lOoCmwlvaEtTVGhzM/XfVeGBFbHUPVIxYkdUi7ERrGvX6XxbgU/CHCSiwlFAwVUSqDa5OqWp3Rw7/IbGzUQKG6dPB8MJMt2uEUISOeVDrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l35s4/1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BB8C433F1;
	Sat, 23 Mar 2024 11:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711194320;
	bh=17RFStLEDNlrMuDxB5LQdmbGIXnoteDvrGHTjRkVgSs=;
	h=From:To:Cc:Subject:Date:From;
	b=l35s4/1qrR7QLMF/m1BkHeE2+6Qli6wZ5ybxop0snCYEqbIUHEI0xqZWqXiw73IsA
	 FJh6dzDt8vK3UFHwwQ1XAQgacR/hh6cSCXF7MgHlkcKvtJaOHcJ7f6cgDNqAbYYXkU
	 zx+jZLjSmB46FFHz8peSrlRFxxmdLj9SP0EMjIggY9vUbCgBgCQ8FUDaRio3e3NNR8
	 PdQeO6fwWg+p36IzeuauuVHuxljF90FrzN8wYgNxENcr2YPGDdv+zo+Q++zIMP79k8
	 PMCfy8LEVmfaZrVJCeITDuMcs27BXefJXq55pYwfgP1Xf+6thojb9I4W2k4GFcH2zF
	 XeeOsKZRoaNFQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] modpost: do not make find_tosym() return NULL
Date: Sat, 23 Mar 2024 20:45:11 +0900
Message-Id: <20240323114511.1250145-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As mentioned in commit 397586506c3d ("modpost: Add '.ltext' and
'.ltext.*' to TEXT_SECTIONS"), modpost can result in a segmentation
fault due to a NULL pointer dereference in default_mismatch_handler().

find_tosym() does not need to return the NULL pointer. It can return
the original symbol pointer if a better one is not found.

This fixes the reported segmentation fault.

Fixes: a23e7584ecf3 ("modpost: unify 'sym' and 'to' in default_mismatch_handler()")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6b37039c9e92..2f5b91da5afa 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1007,6 +1007,8 @@ static Elf_Sym *find_fromsym(struct elf_info *elf, Elf_Addr addr,
 
 static Elf_Sym *find_tosym(struct elf_info *elf, Elf_Addr addr, Elf_Sym *sym)
 {
+	Elf_Sym *new_sym;
+
 	/* If the supplied symbol has a valid name, return it */
 	if (is_valid_name(elf, sym))
 		return sym;
@@ -1015,8 +1017,9 @@ static Elf_Sym *find_tosym(struct elf_info *elf, Elf_Addr addr, Elf_Sym *sym)
 	 * Strive to find a better symbol name, but the resulting name may not
 	 * match the symbol referenced in the original code.
 	 */
-	return symsearch_find_nearest(elf, addr, get_secindex(elf, sym),
-				      true, 20);
+	new_sym = symsearch_find_nearest(elf, addr, get_secindex(elf, sym),
+					 true, 20);
+	return new_sym ? new_sym : sym;
 }
 
 static bool is_executable_section(struct elf_info *elf, unsigned int secndx)
-- 
2.40.1


