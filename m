Return-Path: <linux-kernel+bounces-114910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DDB888BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE371F2836D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86962D379F;
	Mon, 25 Mar 2024 00:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZy/dW1u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D7D27DE00;
	Sun, 24 Mar 2024 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323575; cv=none; b=HjybBquQ26EzOfi9HhDrdoyGv0TZoGpB8FxkLmI1RYMunOuvFlqu6loFUYWQCILlAEc4xLuhyR7VQALr6Scjf9WKnH4Sgwf5EE0bp3qK0TisJ4y5iqf7/tEnn08zXVJfqAroMPFr58N0sKFmEFd7HX5B/LaOMLfZRIEEWIVM9lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323575; c=relaxed/simple;
	bh=0WGbgIFNty86zl6mmKVRqxpL+QHsdqQA9wez7Xo7orA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaSWsRGbJGXDeN6exJ9+JdLFhuTNfmgu+oKJIYXq5S1f0acQcpvGHuqBZB2GU2pamFCpgJvaBs0j9J7J0lq/cHnbOOn/2nNV1WcvrbZ6yYg/TDI65J/7bo+9aPrFYfdpqOJD5LpaWV7v/xvvoLBzR50zfouF5IDhvYi+nVRaSYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZy/dW1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3BFC43394;
	Sun, 24 Mar 2024 23:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323575;
	bh=0WGbgIFNty86zl6mmKVRqxpL+QHsdqQA9wez7Xo7orA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nZy/dW1uBDsQ0XPWnC7O97M/ghTB0cB78ake1oAgypi2PR9XvtDMNIgyQUjaSFoYY
	 uV+n+gl+ARMjyHez2EZns5cXpPGVsNwWBthkUPCD2MdyUTcVukRb3FK6dRPeqwb6wn
	 uxti/YwVjJcj5XQAAYvY/BvUo2OGe82p7PzRnJkkpkmXKIo3/jaJCPMwfFkTXMzhSr
	 bqANG42hHEuU20MqKE7G27JnuPrSIlEcguXANwj2uA2gz7w8wAoAaeOgBMrzAiux/i
	 qyY1IZW+wpQ7Ks5WcTiscTx2Jx0GYu+LSMDM2QRjUSY/UC+X8TKqMFV/3sCikSWrZb
	 IFG7lr+85C00A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 282/317] kconfig: fix infinite loop when expanding a macro at the end of file
Date: Sun, 24 Mar 2024 19:34:22 -0400
Message-ID: <20240324233458.1352854-283-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 312cbad2d34d4..2a76393d52b5b 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -301,8 +301,11 @@ static char *expand_token(const char *in, size_t n)
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


