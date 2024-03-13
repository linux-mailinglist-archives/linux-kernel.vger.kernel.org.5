Return-Path: <linux-kernel+bounces-101985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A16087AD56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3145728232F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784711487C0;
	Wed, 13 Mar 2024 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UO2OIWqY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434C14830A;
	Wed, 13 Mar 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348196; cv=none; b=dKv4K81XLt/l0nsSgRT6Ysl/tgTIS37VoDtiPYKYic0HBoIxNOrQz5Uc8HNhmclYk4hqy648O+JiJt7fztOX1meWTVuggvfOpLUhafsM0zJ7Ftr+MpG7VXW+ka/RTYmHosJPYPbAVeoiBRbhX361PnQwfveyMV3RP31A+QpKNdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348196; c=relaxed/simple;
	bh=/JqcOwDy3vmYnzIP4SeFWDetGnNlE3xy9azSvyjg9+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGqlalbaRZQu/2sVYB2hbCTP+bmO8pfYeCBqs95mvOndQh1413urBJruYRk8VSCdWfb3a3dSlF6VRRC1lzX4JBKxpTGxiTLcoMwgIYuUYL/ujyxWxhCBqHZPahDW2foGdh+z53E9wIi7gcRnOtah7V9oa7HOVyC2kBrJmkGyk24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UO2OIWqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B3AC433A6;
	Wed, 13 Mar 2024 16:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348196;
	bh=/JqcOwDy3vmYnzIP4SeFWDetGnNlE3xy9azSvyjg9+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UO2OIWqYhmUR/xxgQC5tcJMBHttExJx/+osOFHTWiveWmdc2DO937j2ga4pu/Cmec
	 RAtbH5kO1uDx9a3qUEdWwKxX1MVyYBxkFpMKYj7RUPgqYVz9NozMleGRghvZOtyFZ/
	 qGcCvPyjCBngqJbazmzs0j7WjE8PpdpS+HzHEZNLsuMPowG/AeIYrEkhQYULqUvEQ1
	 XI/YYFOqqW0flAcYa3TWopBgKHGdKdVCKyOMSu4WIWRxjA61gFJ3dr1+x2AqBdUzIp
	 FQbGz83wvRMgu2/3o9zMcu2aF6XSAYqqSzNy8gtC0T8kXRdK2gj+RONTrAEbeBdnAN
	 WvHkmIkweG8dQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 45/76] modpost: Add '.ltext' and '.ltext.*' to TEXT_SECTIONS
Date: Wed, 13 Mar 2024 12:41:52 -0400
Message-ID: <20240313164223.615640-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit 397586506c3da005b9333ce5947ad01e8018a3be ]

After the linked LLVM change, building ARCH=um defconfig results in a
segmentation fault in modpost. Prior to commit a23e7584ecf3 ("modpost:
unify 'sym' and 'to' in default_mismatch_handler()"), there was a
warning:

  WARNING: modpost: vmlinux.o(__ex_table+0x88): Section mismatch in reference to the .ltext:(unknown)
  WARNING: modpost: The relocation at __ex_table+0x88 references
  section ".ltext" which is not in the list of
  authorized sections.  If you're adding a new section
  and/or if this reference is valid, add ".ltext" to the
  list of authorized sections to jump to on fault.
  This can be achieved by adding ".ltext" to
  OTHER_TEXT_SECTIONS in scripts/mod/modpost.c.

The linked LLVM change moves global objects to the '.ltext' (and
'.ltext.*' with '-ffunction-sections') sections with '-mcmodel=large',
which ARCH=um uses. These sections should be handled just as '.text'
and '.text.*' are, so add them to TEXT_SECTIONS.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/1981
Link: https://github.com/llvm/llvm-project/commit/4bf8a688956a759b7b6b8d94f42d25c13c7af130
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/mod/modpost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 43bacdee5cc5d..201ac1bf5030d 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -937,7 +937,8 @@ static void check_section(const char *modname, struct elf_info *elf,
 
 #define DATA_SECTIONS ".data", ".data.rel"
 #define TEXT_SECTIONS ".text", ".text.*", ".sched.text", \
-		".kprobes.text", ".cpuidle.text", ".noinstr.text"
+		".kprobes.text", ".cpuidle.text", ".noinstr.text", \
+		".ltext", ".ltext.*"
 #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
 		".fixup", ".entry.text", ".exception.text", \
 		".coldtext", ".softirqentry.text"
-- 
2.43.0


