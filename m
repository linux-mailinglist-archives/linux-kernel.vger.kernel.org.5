Return-Path: <linux-kernel+bounces-114215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E01488892B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DC80B260F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41D025119E;
	Sun, 24 Mar 2024 23:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2MP/LPb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0616D1E965D;
	Sun, 24 Mar 2024 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321555; cv=none; b=lfDIBt8uIHATt/A+hn5WHpOyr0AFJhmtCfT+NLs/o2F4v1WaKCuwife3KYfjPX4TjC7ZrIG6mqlOWVMimBjDJ2UlznK0jIpGSO/zbyCizoApPfz0n9y2ymhepPitjeE2ALdNzRf+gGfZlJZZUp0mtBCgSfxBKi2GyC7kU9A8dcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321555; c=relaxed/simple;
	bh=CWRgix+uDvTPQLyz3Skw1HxUUQ9clC+hsv2lUdDt+KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaKClxmQbCblHwy0OxlmJxoOGvCVuc4YiAlrg7MbaoaU40rLKAC8ez+RQDfJTpP/s3SeffBH4PgTUNjelciWFlCdrWZtmviX8hO3tSS2utCObrAB6Vhig91is/SHtWBf01PbXUYoNkxltOEaLhI83naRYctxHMXjWI734G6Mtb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2MP/LPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F82C43394;
	Sun, 24 Mar 2024 23:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321554;
	bh=CWRgix+uDvTPQLyz3Skw1HxUUQ9clC+hsv2lUdDt+KI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G2MP/LPbNx5WJSANoKGJAYdLphh1S1aXDzVZXv7kZpql9C8737IxvmPeOUzalNNTU
	 Di8wdp1iUwA087ap9vU2gmNnCUi607CZ7B3syRzk+v2nwXj8wyG2UfIZo1eUXK9n+D
	 1XasxBg6XxfdTEr/io8CWQpJD8BDK0vxdhOVfnMUGw8Z/zBXo4khOTtxh8nP2s+8EH
	 bigW6BSY6c2CWvUlHqttnlN2qJd0p3iRFOC+6LrnsFq4Lz0dtcE1twD0m3rYvaqpl/
	 Vm9cSrirB/Pa94Bw/xtefQ4jT5RfX4CIholry+gxPnmW+VxkIyPKPiCC/mCvvg3Hui
	 Hnaxr/gA/ABsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 283/638] x86, relocs: Ignore relocations in .notes section
Date: Sun, 24 Mar 2024 18:55:20 -0400
Message-ID: <20240324230116.1348576-284-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


