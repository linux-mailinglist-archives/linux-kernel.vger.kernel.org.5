Return-Path: <linux-kernel+bounces-130320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D3D8976BC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84601F27983
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A9E15E818;
	Wed,  3 Apr 2024 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHpks6eK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A8315E5D0;
	Wed,  3 Apr 2024 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164725; cv=none; b=ZaNx43+V1AO5pQ7Ggajx7lEPdHD3fMeeR6yYBr24CQSVTJz2wPsbJQkGQaLNfal/fVXwTiU/iZl14Caefb2fDIptGTFTMjvNIzwyGRooszub31qlMn0ZmvLg7dL6JgjPnUtyQRlreVAuQV/RcsKzzIyZwG+Oqu2WbS5JWi2zp1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164725; c=relaxed/simple;
	bh=ozj931v2CdUQnm+THPCb6wv5Qp89NCuTy+u1LNA37Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H01gLA5Rbpy/qI/BRuZPD92NaMxf1fW3xi3l2EpUzMqcjRF98D7mvGmTVbmuHF0+iiv7zexRlxLhWqpM7zF78RyYrK79uQCeEMuuvH/fJKW5qS/PI0bK0icsOXrDT9Fm4nt04otgZsUzb860dyg3vS0LU0dpTspwuzu5/rFgoeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHpks6eK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EBEC433F1;
	Wed,  3 Apr 2024 17:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164725;
	bh=ozj931v2CdUQnm+THPCb6wv5Qp89NCuTy+u1LNA37Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VHpks6eKsQ4abP45EzRRrlXJcfxvU9rjLdhIAVpbgsAncm3sqc03umfv4+PX3/iTO
	 iCZg4UbDu+0eecE6YNxtX+K1hMNbujS3dCRjpzt4BD2Th14AIZ2LGfXEl1NiEyOAE8
	 a818ZEwF5YpMn3VRuGgNvu3wBtQ99m6puiw9rYlWE3lraxYSlvlx3E8vSuFf9Cutpb
	 YruktMuIqEdcPtkQq7haI9H3YXOGQDSRoZk5lu1DbXLP2gGM3PI05QDAl/OKN1oRyZ
	 TSjAl4ypeKbD35z7eP8UQjbWOVwYnBxwDfnxubAy+1n1jR+NCWUYzlZVv+0FiqO4L9
	 YfTSOAhunhNCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 16/20] modpost: fix null pointer dereference
Date: Wed,  3 Apr 2024 13:17:57 -0400
Message-ID: <20240403171815.342668-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171815.342668-1-sashal@kernel.org>
References: <20240403171815.342668-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.24
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
index 5191fdbd3fa23..076f3c9e43fa5 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1153,7 +1153,9 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
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


