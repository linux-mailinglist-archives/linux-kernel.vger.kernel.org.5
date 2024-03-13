Return-Path: <linux-kernel+bounces-101984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E559C87AD54
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A219A28153C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D1A148304;
	Wed, 13 Mar 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pl0wegWJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986E71482F2;
	Wed, 13 Mar 2024 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348195; cv=none; b=ibC9rNL2VwMQ8Y5XF3bKQFsjjUzk203ck6LI0UoBxbhxlV7LYJ0Uv78E+8XFtpx1Vkpa5Pfnfz90ibH0eXHnclbNOdmV0bwKKEFV5wkcLub+E/G1DET55prgGGtnm8m8pb0vWk1lPnHigQfeS796lM7Th2ecExa4e9Y/tT4PSmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348195; c=relaxed/simple;
	bh=5SDctwHu9DHMh2gBhoRuCV0/5gTefGQIPVLdm95wCeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVEAMpqq5FMw2nra7OcD3WAPM7o88jlw6ZzPcAcIRb+baQcfFx1vT1K6OVm9i+XPC0OjnsMrvIt5iqRzosESF/n7HX2QnGmR9vFmfK2aryo9jx9wcY/0PizVrNfwTXckimsMuJY3b8+E5XW7/5cyZWKn0zS0MaAF8h9t36CgaoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pl0wegWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C067C43399;
	Wed, 13 Mar 2024 16:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348195;
	bh=5SDctwHu9DHMh2gBhoRuCV0/5gTefGQIPVLdm95wCeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pl0wegWJGhM9R5yMgcfGsKU8FfD1w4HNXugbNBKOTtYVNI+h+zHEOC5tz8bgnbgjz
	 He0Tc9LRsFTeLstCvBFzMXbD9okTnrzNI/JtR5RUgb6+uox77oT2f8bvVR009ze0rV
	 Q8DyGZf+JnNo7MPjIHSD2DE1XXjk/yfqSIjsD22lcKksYv+T9/egtwnRXIOI5RQCKW
	 R4jPTzW8b6gIvcu/iDJJrQ2rJBzoybSFW9mN8mpuIQFRGtoq85FKAOLKdVqiraLKWc
	 FWNNfQg6hb9KBDyAXKQ2hN3HJwPwGi537Sppi9Smm2w7XQpz2SeL2I4PCT8h+KFfhu
	 hXMSzQ2ksYusg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 44/76] modpost: Include '.text.*' in TEXT_SECTIONS
Date: Wed, 13 Mar 2024 12:41:51 -0400
Message-ID: <20240313164223.615640-45-sashal@kernel.org>
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

[ Upstream commit 19331e84c3873256537d446afec1f6c507f8c4ef ]

Commit 6c730bfc894f ("modpost: handle -ffunction-sections") added
".text.*" to the OTHER_TEXT_SECTIONS macro to fix certain section
mismatch warnings. Unfortunately, this makes it impossible for modpost
to warn about section mismatches with LTO, which implies
'-ffunction-sections', as all functions are put in their own
'.text.<func_name>' sections, which may still reference functions in
sections they are not supposed to, such as __init.

Fix this by moving ".text.*" into TEXT_SECTIONS, so that configurations
with '-ffunction-sections' will see warnings about mismatched sections.

Link: https://lore.kernel.org/Y39kI3MOtVI5BAnV@google.com/
Reported-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-and-tested-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Stable-dep-of: 397586506c3d ("modpost: Add '.ltext' and '.ltext.*' to TEXT_SECTIONS")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/mod/modpost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index c6e655e0ed988..43bacdee5cc5d 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -936,10 +936,10 @@ static void check_section(const char *modname, struct elf_info *elf,
 #define ALL_EXIT_SECTIONS EXIT_SECTIONS, ALL_XXXEXIT_SECTIONS
 
 #define DATA_SECTIONS ".data", ".data.rel"
-#define TEXT_SECTIONS ".text", ".text.unlikely", ".sched.text", \
+#define TEXT_SECTIONS ".text", ".text.*", ".sched.text", \
 		".kprobes.text", ".cpuidle.text", ".noinstr.text"
 #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
-		".fixup", ".entry.text", ".exception.text", ".text.*", \
+		".fixup", ".entry.text", ".exception.text", \
 		".coldtext", ".softirqentry.text"
 
 #define INIT_SECTIONS      ".init.*"
-- 
2.43.0


