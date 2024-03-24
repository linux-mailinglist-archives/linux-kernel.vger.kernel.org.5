Return-Path: <linux-kernel+bounces-115256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C4D889376
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C0B29888E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2AB3165E9;
	Mon, 25 Mar 2024 01:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4CmaObg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CEB22F4ED;
	Sun, 24 Mar 2024 23:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324371; cv=none; b=J21CZLaG0fb4kXK1SfYu0u1rEC+JslDoIS0NC5IfO4KANoV1UOV/zTdx24CIIWuc3Sq/bP9CraSyRovXpByvNtzrVmJc5rSt/p5i/EQWweZa8hE+9AfxrdD2goZBbC2q7nlzeY5A0/lSK4teRNF4QuImfp+STGVfagUfXa1jLug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324371; c=relaxed/simple;
	bh=QUGCoymRcEaCqGNz+5TWFFGBLJK+0XjjHAOkdaWp5gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fb+ooUT2+b/jy8wU6du1YqDYup9vtChISfNokG+x3Uh2QhZg/PQtbdl1UH7ECyWKgdFIsk1mXAM88+bwCC784be1/UtDWcIqDPlDkQwraz4/7wm8oJXa781SxYujalukvjMyY+VPkmNz9vG+8YDv7oHvjfFqcX1yanvLR+qzU8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4CmaObg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A42C43390;
	Sun, 24 Mar 2024 23:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324370;
	bh=QUGCoymRcEaCqGNz+5TWFFGBLJK+0XjjHAOkdaWp5gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a4CmaObgl2LSyn4hfglew4zgo4rnyfsgPUul/JezWfIsUecEMnpvLWsgzTYFkcxTW
	 hf59F3MwrpfYzCwkwOkZXBEO5XKALIokvTwIdeP07L8yxzg0Yt5rlFm3KQJBzFox1L
	 7+AJQBg1c87nzdzzGd3P3b0W+cwcP2fFQAnBPeqSY1ytK4s7xU7FVIO/Dz1dQlW3YR
	 UMco5XzAn2UHMQpX8kDvSlRj7N0NMnphKG6pSaAByqY2Ixe27j2DVwjp3NgwCp/b12
	 72GiQHgO9xUGRYoCMk/Sw4+BNixghDwiTw+WDuWjhRh3RlEL5v/eNCI/h+ZkR9++wE
	 +A2oyDVsQHwkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 137/148] kconfig: fix infinite loop when expanding a macro at the end of file
Date: Sun, 24 Mar 2024 19:50:01 -0400
Message-ID: <20240324235012.1356413-138-sashal@kernel.org>
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

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit af8bbce92044dc58e4cc039ab94ee5d470a621f5 ]

A macro placed at the end of a file with no newline causes an infinite
loop.

[Test Kconfig]
  $(info,hello)
  \ No newline at end of file

I realized that flex-provided input() returns 0 instead of EOF when it
reaches the end of a file.

Fixes: 104daea149c4 ("kconfig: reference environment variables directly and remove 'option env='")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kconfig/zconf.l | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index c2f577d719647..2a47ce9b219a0 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -292,8 +292,11 @@ static char *expand_token(const char *in, size_t n)
 	new_string();
 	append_string(in, n);
 
-	/* get the whole line because we do not know the end of token. */
-	while ((c = input()) != EOF) {
+	/*
+	 * get the whole line because we do not know the end of token.
+	 * input() returns 0 (not EOF!) when it reachs the end of file.
+	 */
+	while ((c = input()) != 0) {
 		if (c == '\n') {
 			unput(c);
 			break;
-- 
2.43.0


