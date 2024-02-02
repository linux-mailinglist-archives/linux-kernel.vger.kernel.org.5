Return-Path: <linux-kernel+bounces-50060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F678473D3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9930FB2A840
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF871474DF;
	Fri,  2 Feb 2024 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjPyEICc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC991474D0;
	Fri,  2 Feb 2024 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889512; cv=none; b=lBBQQp/omGHFvS6vgKdMn8qM5hm1zSBvU+dP4DeaSDztsAxhX4si5Ir4xK59dHHlSj+gb8LAnKiqKoWyo2xnStuIIOpL79H5hxupDEEVJQYoRJX+aCk8uq5YKUs/wYlWyFeWoQVYKA7w2VPecykrOsJPZaMjbnuLyiBA26uN744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889512; c=relaxed/simple;
	bh=0zjrnd8HxqGEk4V/+9L30lJo6lzcn61RhZYmqtdDahY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rOEsJ0DYvyWGd+uuYSVzM6fM0Gu2IE252Uz8uITV2OizQ2IK0Cf+v3BLkSbu2DjJmL93LTv3j+9DYEM4C1cHpgQBxrwFa4r4VNn3TtATsD6ResTxD5mt/8rK68A9vUvtbjhoXHvIUg4U/tgXdi/r8u+D8Lu9lBgGsKREJx4aIwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjPyEICc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CBBC43390;
	Fri,  2 Feb 2024 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889511;
	bh=0zjrnd8HxqGEk4V/+9L30lJo6lzcn61RhZYmqtdDahY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NjPyEICcCinl8z3u4AxSSHdlSJA2HhXiOK0v8gPVhLMPkDkG1KeD3HTgqSwUfxqfQ
	 Icne3B9EFy9SqptamIRc+TR2Wf+s2AV7pRbWg/zPt4EqKzovuhH5B8AoENgdSQddfA
	 c8Ka+yiJ0ellWjGRGL2fGQ+UtQwKC4r5b74KdkZHHp65cauwwa35qN42Aha/VsDx+2
	 EyYtH52Jnk8am2jFHpvfnt/ll1s4+ifKfEozdfMxNQ4z701wMKKqILKio1f7Ot+ovh
	 /3JldDJD+nf8MJxG0eQjIeeZh2M4GEwB43qFbf0pR5ANvNH7U14vctxncRD3rInEbf
	 j3DVnAR83Blag==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 01/27] kconfig: fix infinite loop when expanding a macro at the end of file
Date: Sat,  3 Feb 2024 00:57:59 +0900
Message-Id: <20240202155825.314567-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240202155825.314567-1-masahiroy@kernel.org>
References: <20240202155825.314567-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A macro placed at the end of a file with no newline causes an infinite
loop.

[Test Kconfig]
  $(info,hello)
  \ No newline at end of file

I realized that flex-provided input() returns 0 instead of EOF when it
reaches the end of a file.

Fixes: 104daea149c4 ("kconfig: reference environment variables directly and remove 'option env='")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/lexer.l | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index f93b535a080c..5f1bc3320307 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -303,8 +303,11 @@ static char *expand_token(const char *in, size_t n)
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
2.40.1


