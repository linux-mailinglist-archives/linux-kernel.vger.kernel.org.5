Return-Path: <linux-kernel+bounces-113170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C39E0888204
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9B128842E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD00175540;
	Sun, 24 Mar 2024 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2eTgha1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DF3174EF9;
	Sun, 24 Mar 2024 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319972; cv=none; b=NgL4D/4hEUqBSvEF8bduFIIz3kQluCOMHxunFpiIb4nMaeWrKh/0Wx3N/w2JNxXKAKV1Zorgr5qqZaAo/6dHKu9kLSLoUg6RNC08CDkZyHd+5m/EkrT0PA+vRJp2DuaIlmCIcKEAP121NcnQHd76IOIuykI3WHx+BtTjvw9nlb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319972; c=relaxed/simple;
	bh=sgMet8Ys7vXbgoPCUJNEgcAJoQloFmo0UIL3Zyz8JnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fczVpc9c/Bh4g3eZDMx03TpexsoTjEvUgUrY3Zm37xTydb3huVPILdiMR7HXqUmOQYKeM+2iiKZGMHq1t1OD+ncvi6nI0gF/f+RXZae3TzVMjZez21kP7Bh4MBGfnKWyRKdNHOnUlimogGzL76lpQDsJo5AiLEPANgMagAdppHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2eTgha1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CD3C43394;
	Sun, 24 Mar 2024 22:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319972;
	bh=sgMet8Ys7vXbgoPCUJNEgcAJoQloFmo0UIL3Zyz8JnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I2eTgha1CeQNvzO6CVDujF+yXB9dVo+eK1Uug8ewZEaZEVEGlR5o5Aw6bzBV3qhz3
	 DxJkOysOT+Nn2OCu33VC3wTt/AQCQ8UQJNh2ooPc5a59JITdZhhAa8mUPMShI6s8E7
	 fsY3Q0MN+0rM9jQBDNZ9UVGMh7kNnDWSAzlAxFHoWaiR5ECnd5+TZ2YlQ1FW/7LzBp
	 NUke9sbrOSNVUTBS6LxsythoK9eYHtVRHDTskxg7fvf/4IIOgpxpYIRHhokKjks55h
	 kvJBsesIEJw40PkzTBfAN/8DhkoV72sMFCWzAEGF5n+ImjeF0sM3CpLtaWjBI1Y62k
	 +R9tVXiqdoFHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 279/715] x86, relocs: Ignore relocations in .notes section
Date: Sun, 24 Mar 2024 18:27:38 -0400
Message-ID: <20240324223455.1342824-280-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index a3bae2b24626b..b029fb81ebeee 100644
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


