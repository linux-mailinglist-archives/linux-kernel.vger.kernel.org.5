Return-Path: <linux-kernel+bounces-113759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD93888674
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE75BB225CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE681F10BB;
	Sun, 24 Mar 2024 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyX9IrP+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599461DF7BF;
	Sun, 24 Mar 2024 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320765; cv=none; b=AlHazVfMC6nmUK+Qm7GB0/SLjA00mdUlEgtFRKsoL1dGMvhWIWEHDPtrKQ6Y5fYqZkoL8wo9KTiDwzgWA7+I9cM5Hqn42zIuhPGTynSey0ogdRWkpVl9a561Vwj0aSo73MV8CH2bOqp1wQfy1bROOTsmS+DREl6nTOo4iDYs8EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320765; c=relaxed/simple;
	bh=CWRgix+uDvTPQLyz3Skw1HxUUQ9clC+hsv2lUdDt+KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5GQxePc5uMHsMDBeRIesUCMA+zg6ZJfljVqJbS4QOJDhTD1XtkNrqi4P5DNdqhG/6ewH40Zy2n1tkFg4CbmqNCkF9W++V8Bj7mwXWVBKhgJfrRqRM+QazJDVZsfopeGYfkuHAqPmCphdmzq3vwq4+LMWvbWlCZouH07I2Dj2vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyX9IrP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA9EC433C7;
	Sun, 24 Mar 2024 22:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320764;
	bh=CWRgix+uDvTPQLyz3Skw1HxUUQ9clC+hsv2lUdDt+KI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JyX9IrP+mdFNymz0hhMFi1Xamshk2knCz8qBSwi6VKwe8/qn14YeWGvVu1bub3CMH
	 SqYQ/+aEGMvWfrvHiXQYQZUF/qXE6rPBwA9E5Ie5aURSNXUdl6Xn1Tt2Equ3RkXVOe
	 22ZR72n5sy2KRYQ5xg2COlQTUS1juzW5Lc/gppInvy9bQmx22MXudnEUFXUu8g+U80
	 lkzPPU4cp7XsEv+1VOEWm0rKDN917abkGAj6VauXgGgfgN0/fNGgghYq4o6gvNN4n1
	 Mohylw8jH7fqWSyPkxEBb+BHqMlzm7eiiKTB2pxeJMbvy9ZXlzPdP6foCUf8CO9EJ6
	 WeQd5GIteEFxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 328/713] x86, relocs: Ignore relocations in .notes section
Date: Sun, 24 Mar 2024 18:40:54 -0400
Message-ID: <20240324224720.1345309-329-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index d30949e25ebd9..e7013283640f5 100644
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


