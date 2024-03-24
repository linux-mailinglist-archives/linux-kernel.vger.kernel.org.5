Return-Path: <linux-kernel+bounces-116294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750F38896B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2120BB2FFE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E31F3CDFE4;
	Mon, 25 Mar 2024 03:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAixVkCe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E400B28ECD6;
	Sun, 24 Mar 2024 23:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324173; cv=none; b=KbTenzeg64/eiX+L8UTO5VT28SbaSj5Y3cwoXA9/Hp1VxM6NgfwrhAG81M/Jib/KduSz/6oo8E4i0tWjXzryxs8kMnC/z0ekGAPTJoB6NkU6MabnTIYncxTodHXn1ewMDLZwmeqBZIEcxMS/hBCmPJXV3Dl0HTvSbRAjAqthoWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324173; c=relaxed/simple;
	bh=B3AEFgsF6eEwX1vG9pSxc1+bF7vd44baeJOC8d+07Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1Xt9bAJ96vAcwCN78WfQ1fzFWIswgb8nQQEDkTEv2kMM3nSLrXWi7MANfD0kqoj8vJ91QFzuiHx1/xZ+zvU5YZybQlcL7lPOdRCktNv7W92lp0b1b6YxbG/j2ZRRhm63OxdrbQV2vPgnh4sMMojPwSUIbxGQBmgDOabWLYNISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAixVkCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E5DC43390;
	Sun, 24 Mar 2024 23:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324171;
	bh=B3AEFgsF6eEwX1vG9pSxc1+bF7vd44baeJOC8d+07Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAixVkCeQl2VExY3b2hJoLmE8jBYhiKogd6/lE3/fCtVt+ajoP5yLQTpcApMi/uFT
	 X5d4C8y4lOnX19rtx5Z8lqx+U9HDuVNMUK3YmhWb7tjwZGnDLo5ay3LznGR/CTgzXm
	 4mZ7fa5DozIVj2a3VF9xZyXvCyWLOFf1ab2gchpjsIo2HoBVE2ZpHBvzJWNuYJ/PfZ
	 MVBrYJSzR5Sv6TgOuPQO7+jBROfQBrvfRbb2ghqJVS3FOQ4JJj4YGCE2Yc502ImGvL
	 0/GhnRn518VO5VnZv1FLxwcVWyhFjjTjUuO3m1zpY2mKUlc/DYrNtyp7uezVQ7klCj
	 jrphjkt2UWLMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 164/183] kconfig: fix infinite loop when expanding a macro at the end of file
Date: Sun, 24 Mar 2024 19:46:17 -0400
Message-ID: <20240324234638.1355609-165-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
 scripts/kconfig/lexer.l | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index 6354c905b006f..3bf90d01c39f9 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -305,8 +305,11 @@ static char *expand_token(const char *in, size_t n)
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


