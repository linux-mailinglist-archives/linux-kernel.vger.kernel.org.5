Return-Path: <linux-kernel+bounces-114422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C57888AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4615B2463C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2306B155748;
	Sun, 24 Mar 2024 23:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0G62LF6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D0E21C170;
	Sun, 24 Mar 2024 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321837; cv=none; b=nlrJuxoOd+ThWIDB7l49PIrFcGhTzUFNy/FXCQYfMJTpEusUvBHiYCOzp8XJpxljQobqKX1DIX7eftPv7dk+B3Xk0SXEWCiQj+ChzI95I5w6hUTy1S8r5vxSUloUk7McIrRV3LsYHnAVhBAntfm4ethaeA57Aabg725mwUF4N5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321837; c=relaxed/simple;
	bh=vYDrj65XbguCNZEvMXtOEcXUTXcfMV3g0dkmYc1mhQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMIwv6lCZwNH/xxPh3zW649u4qf+cz1Z+V1dEzXrz/tdX7A2ZOMOE6gi4zCZMhygZ9r48KUep44dOKvPtxsGPPn5N60ccj2gcTKPy1VvQIkj8222YX5FGLJG3Jh5tIIuHKgOmOCVvsEfmnbe2AIEs4DpNYtaKCehz9eofJV5TGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0G62LF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11F9C43390;
	Sun, 24 Mar 2024 23:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321836;
	bh=vYDrj65XbguCNZEvMXtOEcXUTXcfMV3g0dkmYc1mhQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N0G62LF6vLTMzIeSEip98CUT3j7ZczYbqyOzt8d9sj2mxmOQSHLoetth8myTW6ZVK
	 wyqXSw2augLwRoHwFNpPVAfWAHcLAsaPko8vdMVXzFM/GbIDJIHKaCcaTKuBOwbkRw
	 2bHt9E/WtLz388PVFuujZ3TfrS/gBSRUXQhP8nW4WvbKbInH3XTHp8uh9bev6orxxi
	 /usjzyIRksWvPFiJ8KMno70wj+8hqY2ZcUO70I75QA9k5DZXbTUpyPEinnjWVXsup/
	 g1cxhZwFOHo7ySz/iVAHK8Ce2e0ziNrOc8PttBkzm18Uzcs8eLshVMRAqSUFZ8gZY4
	 wH3UR+lfutTLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 565/638] kconfig: fix infinite loop when expanding a macro at the end of file
Date: Sun, 24 Mar 2024 19:00:02 -0400
Message-ID: <20240324230116.1348576-566-sashal@kernel.org>
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


