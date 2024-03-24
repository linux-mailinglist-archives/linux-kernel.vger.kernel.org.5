Return-Path: <linux-kernel+bounces-113514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5098884EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8651F21A87
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5041913D8BD;
	Sun, 24 Mar 2024 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqncHtaa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8572B46B91;
	Sun, 24 Mar 2024 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320315; cv=none; b=NbGR9V/Bg54zNUuQhyJbcZwvx6qpFRDsHFuH2+lFD4Is2CSDFh2z/SYVyOPwkRsUcbT3UGKxDpkPw2XPf3Mnb6YUXcnWKc3s+JthBeGI0DI8yjP1Tm4HeolU8oY1ikU5Qrsx9aROy33NXqezy0/H4rsTQ/yKMgqXC3E4I2MGJ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320315; c=relaxed/simple;
	bh=vYDrj65XbguCNZEvMXtOEcXUTXcfMV3g0dkmYc1mhQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/N69EPnYKtmb0G17DRGB0q7H7q8ChDUAz8+63gWBq2SeonbB8dg++c4in4OvtTQnzLVuIuFtkbS2TU1pMjSejLvOIcDaxNiUx5F8LCty2V+AMiXdqcfXgtMhQ2JqHBkMRHxUSaqvsVc66SgD2Xq8R7PCoNPaeKI9IhTdO/pwwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqncHtaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6BBC43390;
	Sun, 24 Mar 2024 22:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320315;
	bh=vYDrj65XbguCNZEvMXtOEcXUTXcfMV3g0dkmYc1mhQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DqncHtaaKgzS/qZuZ99RJ2YvwUm7XRG3bdTYNCYmKXkIOHa7rAm89mfJYtdrlTNvk
	 I79BCpLb3v3uIV877tjm4iH/OlfMIdjqlmXm3kP/iAtmlQ8wLljaNGwwVNvMG0yr5I
	 S8alxp2NlAVOPgKfYI3Vsu88RC6hNQ65JEpg0CbPgIqJn59W27l+tBZVA5P5df5rcW
	 sdNpC5yCosaOkonh/WDJvf3WXrNE/43tmmdR74FwGzdEORWX6bDcCFLIeDYAm2H3oU
	 76SHyro3zqaM/qayUV1bcceLoiAHj8sedz1sSaeHSDL7rpQU+N983qDJPkh12F3dyK
	 g6caQwTQV2dUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 623/715] kconfig: fix infinite loop when expanding a macro at the end of file
Date: Sun, 24 Mar 2024 18:33:22 -0400
Message-ID: <20240324223455.1342824-624-sashal@kernel.org>
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
index cc386e4436834..2c2b3e6f248ca 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -302,8 +302,11 @@ static char *expand_token(const char *in, size_t n)
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


