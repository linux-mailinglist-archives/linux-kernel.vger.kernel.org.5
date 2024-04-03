Return-Path: <linux-kernel+bounces-130297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2B2897686
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE1E1F2181A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12C31586C1;
	Wed,  3 Apr 2024 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbA4a0Wy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E7D15820B;
	Wed,  3 Apr 2024 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164664; cv=none; b=nEQ+7q0E6bVfbF3k2C/yq34741qrypUFGuAsYlgaxL96oGVx2qWGopC9mkxl11um4oS9M5xF8uDGKcqf+sCe9MgdpaUPUzePQoo+dagKuRjJOMH9EmuDSMqNGf/zbw4WKGV1V0nlB95g949pd6cY0RBK9EVOVwvDPe3H3jzliXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164664; c=relaxed/simple;
	bh=X/GQNzF16ELPzvTUFRJRs6R9xUeUT/gslN0Scp+bV2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuQ+HHydsh+6bVS9ZhmtoiHPCuvciPWjKG3MIOTg/PAaMUDBgtkDwY7y8oTlEFzuiVYT5IN5ctyXs1TMTlGHCfh/j4RV6xAiNWj1KKibKKkrHlFvggrGNodj6Erk7wK99heeCkGYEuxvhGtYDmI4+MFFJU6ac1YKV31FD7stit8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbA4a0Wy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D18AC433C7;
	Wed,  3 Apr 2024 17:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164664;
	bh=X/GQNzF16ELPzvTUFRJRs6R9xUeUT/gslN0Scp+bV2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbA4a0WyZ+b/VgKeA1qqWe1T1F/NDEcQMFtkgNlzJL6qdERXy5b+uChBu4sYFa247
	 FwFAvwdl5uwWSOnynApnwok9y7YF22PoRV8xMQcEsjvztLS1P3qqpCssCivyk6zW/v
	 FWnfQMBnwVCVTO+u8ckKsVmoTJ6S6iZMwtq59xlbmejlwEp7PCIMdQsOgCQJoCBtfK
	 x1T03jKjrQSNZuE8SNG90msAdDLE8Zaz8jx3WWJdsIrrOp3arFo1qgXNZOVy0L+i6q
	 KhrA2zWSZDN8JZ3QvGpCo9hxA7J6rwbPrdSmlHUCSRW5zpG6Qo90Yy6K9ffU/1rbcY
	 UZ6j4DBEEskmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 23/28] modpost: fix null pointer dereference
Date: Wed,  3 Apr 2024 13:16:25 -0400
Message-ID: <20240403171656.335224-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171656.335224-1-sashal@kernel.org>
References: <20240403171656.335224-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.3
Content-Transfer-Encoding: 8bit

From: Max Kellermann <max.kellermann@ionos.com>

[ Upstream commit 23dfd914d2bfc4c9938b0084dffd7105de231d98 ]

If the find_fromsym() call fails and returns NULL, the warn() call
will dereference this NULL pointer and cause the program to crash.

This happened when I tried to build with "test_user_copy" module.
With this fix, it prints lots of warnings like this:

 WARNING: modpost: lib/test_user_copy: section mismatch in reference: (unknown)+0x4 (section: .text.fixup) -> (unknown) (section: .init.text)

masahiroy@kernel.org:
 The issue is reproduced with ARCH=arm allnoconfig + CONFIG_MODULES=y +
 CONFIG_RUNTIME_TESTING_MENU=y + CONFIG_TEST_USER_COPY=m

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/mod/modpost.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 267b9a0a3abcd..9106fe7579466 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1050,7 +1050,9 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	sec_mismatch_count++;
 
 	warn("%s: section mismatch in reference: %s+0x%x (section: %s) -> %s (section: %s)\n",
-	     modname, fromsym, (unsigned int)(faddr - from->st_value), fromsec, tosym, tosec);
+	     modname, fromsym,
+	     (unsigned int)(faddr - (from ? from->st_value : 0)),
+	     fromsec, tosym, tosec);
 
 	if (mismatch->mismatch == EXTABLE_TO_NON_TEXT) {
 		if (match(tosec, mismatch->bad_tosec))
-- 
2.43.0


