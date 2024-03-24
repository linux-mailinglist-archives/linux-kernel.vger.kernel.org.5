Return-Path: <linux-kernel+bounces-116212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 690938895B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20EC0299587
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9133BEA2D;
	Mon, 25 Mar 2024 03:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv5QYpF6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C1A17D247;
	Sun, 24 Mar 2024 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323834; cv=none; b=YdaPuwdVRNswhLQyRqnKA5ksxqFOSMFrkRNbZJnkrk+MCL+hiMOlWrS/Z0nPxmotvY1p4xc184g6TjwxQdqJ4KK2UVNbB43bUMl6MbVnzz3DtLwBxvii4y2LS+8t1f+4RccLrVzj7pQt8NiPAWAXEICIJf7TgP6bbBUw68nLhPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323834; c=relaxed/simple;
	bh=HsUg5S/3AqL4buyV0K0NxnhMGaC2KNaoIWRU8mW7eOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSiC4LqTjC4sDfBz5bA81HQjz/yRpgy2hwZgrusI6wGj9m5pe2TZMr35RFd0lr2BW7JTJl+b4DxgNdUTA2z7vIbkGaEw0dwwkxoo8FJ1cdl3eHZxJxjz4orGJemRXeUZezVasL6nWyONS5ISagOvOj4S/XmG+Wmqd1zhxywegmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv5QYpF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91BEC433C7;
	Sun, 24 Mar 2024 23:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323834;
	bh=HsUg5S/3AqL4buyV0K0NxnhMGaC2KNaoIWRU8mW7eOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dv5QYpF6LqdRqVUTpqYITd4jLS0G43jTz60d82SbgXKEJj8aA63vfA+vnLq2VsdSH
	 oTtgS6RBVAa3LONJ7QKzYh4yirDplOw7RPQEZVHAPD+1IADgpm065lN6AbX0ukKB5V
	 x+vEbDZw7R2M8yYCMbAnDzjrW4o6p1bphmrJ8snprLK8OMl9dfK7quCeVMt1JeNsDl
	 tJ7+6m1IbKd7reUg3Bn2Dt5zDi8u5KdOIv1AneGv8TLTMBSGH5WEY4VEjgMVA+Qg+Z
	 sMXcDLYDz3EN7WHJ7gtxXyWfRk9M68BQ58XGzpcyF0G88/eNyLVTlcYJMW8Zc2Eg+z
	 vwQsBlIP2kaqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 213/238] kconfig: fix infinite loop when expanding a macro at the end of file
Date: Sun, 24 Mar 2024 19:40:01 -0400
Message-ID: <20240324234027.1354210-214-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 240109f965aeb..72e5e9ac52bb4 100644
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


