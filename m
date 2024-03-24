Return-Path: <linux-kernel+bounces-113953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBF8888793
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A181C26786
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E37D21AFE8;
	Sun, 24 Mar 2024 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0GDI0j3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A92D14B09A;
	Sun, 24 Mar 2024 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321066; cv=none; b=OsXZji2WDFoUeNnN7tJmKmdnO+i/Sp0/+34oXHduT3bgul0RtMTmZovnXpX0+aqHuOalba74FD9gMwQaUG5R8oUDF0X56HEoXPb7WwLwuhRqTJLo5MvreYRsrQyndbyHQC6RXhU/ogjoHoAeuRt6Txh9JQwHc07mwa5JdDQcwj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321066; c=relaxed/simple;
	bh=vYDrj65XbguCNZEvMXtOEcXUTXcfMV3g0dkmYc1mhQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzgfLEmISWtuZ4qeahfNAOjWgdALp2vChvrircHeR7KdZI0TVQyw0/AJeoamdv0y72xU5aJ1cHIwpTyAcli2+vrPHBbk85DWsOMV6UKbofObkUkmFYjaunnN0ZMhaYkFaTzMxLD/W18omUIqtgDAri0pSysE7eV/6vLbUP4hwBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0GDI0j3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A40C433C7;
	Sun, 24 Mar 2024 22:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321065;
	bh=vYDrj65XbguCNZEvMXtOEcXUTXcfMV3g0dkmYc1mhQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i0GDI0j3jN0rQnMzODqIs+wlSL/owagVY1XSOQ/yv9ygxIOoob7/GLY/I7RQXphHR
	 fDkAmpcAN0IyReu1YmhuMZKNHo5S2AWBZMY9HIn6eTL66KrxmNTCpANMGRSze+GtnD
	 l9im6Y0hDEfAllmrE3LH7iCZKBtAqs+o+LnEh9z7YShrwb4asia7o9A2PAHp5xWXEq
	 k665lFbZBnxaPsp2KOPFDXqEh8gPlaufh5w8IfLWouQYGlESArXC3b0L1dbRVl2TXG
	 5wxespjbcD5HTRXT2KJkpNR1bKH0vF6Ns6K8qtyXxVq6LK7Q+8HwhL8Wexv1eTU9CC
	 1wpQes1KeydkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 629/713] kconfig: fix infinite loop when expanding a macro at the end of file
Date: Sun, 24 Mar 2024 18:45:55 -0400
Message-ID: <20240324224720.1345309-630-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


