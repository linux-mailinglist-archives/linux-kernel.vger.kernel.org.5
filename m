Return-Path: <linux-kernel+bounces-115195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A23B2888E84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A743BB271FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819E130B4AD;
	Mon, 25 Mar 2024 01:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yuzr3y6k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FAA184303;
	Sun, 24 Mar 2024 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324269; cv=none; b=VgqvgjH1SjPvKUyYTv7M2EnG+TxhKMf2WoTBaMGsdtpagYEhgyPSr8mA2JrAhZ4JCIBcIh4X21q1MRdV0p3cBcn6YSqV2+hceMzjIg1nCgGikrE7ABgG9BIPjk5D/pD08F4kb0sYkZ8mUVVdwtkQ5zH0P8qX3xFX8u8EZydC5tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324269; c=relaxed/simple;
	bh=FaVXkdVeySI9vjG797fmEk7rhM4ih4kJDsRRP8xVya4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqVAn6Em5U5D1lnVfUFovMdeHHflQzod6yG6/7kJzKSI+DHnsdcRZBsmLdHKq9cmGUHcB9wvp21PElKdgzGupl/UHorZhEpVrDm8eiScdE9F0PRUSgdgkHVG8LlefHSRbsvwDAG7YjQ7anAbOYrN1JOSEKv5bKmxUTTKZTQhpwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yuzr3y6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FB3C43394;
	Sun, 24 Mar 2024 23:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324268;
	bh=FaVXkdVeySI9vjG797fmEk7rhM4ih4kJDsRRP8xVya4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yuzr3y6kf1qwzmiejBDEg3k7up/VIjmcXDNGor1M6W1o1nKbFokNF5RTUArgRko0X
	 DAsIAuxl/zWbdnyr2PlbyG+JuSvKJrLA4yv8ensqJs76JcVoMGkVS/5SbFOlu2u3tj
	 jldlvdgR1BOJWuz6j3JIGUmWfftkLP8m3Bp75n+msH2b5zivNSHbhk4aRam6p8ILWY
	 QZvliqxpy9ToQeotgWz+PWQyM0MYnSNcD3ReaHEdpZQwoiMgwqpn/jUx3lEciGdv9K
	 13aAtZ1DntLl+eGz9JTP01p4cFonfd10VdVV0WJ9Xkz7hkZOZA3b7wJWwT4FH9nQfi
	 ACrLUNFvoK/hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 047/148] x86, relocs: Ignore relocations in .notes section
Date: Sun, 24 Mar 2024 19:48:31 -0400
Message-ID: <20240324235012.1356413-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index aa046d46ff8ff..c7f1d1759c855 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -579,6 +579,14 @@ static void print_absolute_relocs(void)
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


