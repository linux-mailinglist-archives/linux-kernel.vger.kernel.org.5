Return-Path: <linux-kernel+bounces-113357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B08788883AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4463D282280
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BCF45BE6;
	Sun, 24 Mar 2024 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC7nr8ZZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9427319B2AC;
	Sun, 24 Mar 2024 22:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320158; cv=none; b=alFbSIx31ExWqMrNu+t8inilRQyLrMY6sqYmRcBetgGETKVGSpSLagQQWtz3nHMk1bGgvxJ/akYLICI6LqxkGd36ph5CEm2ZIYm1PQpMzXOd8jUNTu761j0ywJhNj6vrKqT7JxXwrfXy+Z5n4eyrq6/8cluzZTCL+fjfgeIoq3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320158; c=relaxed/simple;
	bh=tkufBR9raGvxU8c3aH3i6ldwN0hrm/x4DjtThUr85q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDsuHTSmuTkglf8Rf0A5wGCwdKBd5qWfNHRp3hwA4/fVObEEaMmdxuOistsuL7RGENKhuptccuE+I6UFHmv78jOhc5q3B0uzaOwf0U+PbxFoXomuglKqWHIyNVucovKJ7CPXR+WrP93YZhT7b8HP1jISZecx9Ocg7rHcDK5XFjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC7nr8ZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61C7C433F1;
	Sun, 24 Mar 2024 22:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320158;
	bh=tkufBR9raGvxU8c3aH3i6ldwN0hrm/x4DjtThUr85q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BC7nr8ZZLZZF1OENkF7GCoQz5NSFIjVV5D0BIFhq0lyTwgotqaw/vUSk0Ou7Mv+UE
	 wW/F2UMW75MaGBs/LwrnwQddr6TI9AMY4YMKDf5hfW9t3F1jHtOg1QRhry0lr4/ltq
	 8pDFdKaD72UhzU032P+Q1knJcfXQlZVReyWviXjYRIUd7tYJmkkh+vu5TvJJm8HY9u
	 v+eZRYreWkVhOOe3VLPb6Zx/fxxo/p8vRH8RLbMxgMAiN0eOJq8Nr/3AGWQYwORufI
	 SnPGAaNfgu1Kvkcb1hU/L54IKpaQhQ0zlY12N39wzd/0D4s8Dd9VDGAFvMsv/LmoxJ
	 5ppB2Ct9114ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Tim Van Patten <timvp@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 466/715] crypto: ccp - Avoid discarding errors in psp_send_platform_access_msg()
Date: Sun, 24 Mar 2024 18:30:45 -0400
Message-ID: <20240324223455.1342824-467-sashal@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 0e8fca2f12ceb77c3a6b6f210135031f264aa612 ]

Errors can potentially occur in the "processing" of PSP commands or
commands can be processed successfully but still return an error code in
the header.

This second case was being discarded because PSP communication worked but
the command returned an error code in the payload header.

Capture both cases and return them to the caller as -EIO for the caller
to investigate. The caller can detect the latter by looking at
`req->header->status`.

Reported-and-tested-by: Tim Van Patten <timvp@google.com>
Fixes: 7ccc4f4e2e50 ("crypto: ccp - Add support for an interface for platform features")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccp/platform-access.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/platform-access.c b/drivers/crypto/ccp/platform-access.c
index 94367bc49e35b..1b8ed33897332 100644
--- a/drivers/crypto/ccp/platform-access.c
+++ b/drivers/crypto/ccp/platform-access.c
@@ -118,9 +118,16 @@ int psp_send_platform_access_msg(enum psp_platform_access_msg msg,
 		goto unlock;
 	}
 
-	/* Store the status in request header for caller to investigate */
+	/*
+	 * Read status from PSP. If status is non-zero, it indicates an error
+	 * occurred during "processing" of the command.
+	 * If status is zero, it indicates the command was "processed"
+	 * successfully, but the result of the command is in the payload.
+	 * Return both cases to the caller as -EIO to investigate.
+	 */
 	cmd_reg = ioread32(cmd);
-	req->header.status = FIELD_GET(PSP_CMDRESP_STS, cmd_reg);
+	if (FIELD_GET(PSP_CMDRESP_STS, cmd_reg))
+		req->header.status = FIELD_GET(PSP_CMDRESP_STS, cmd_reg);
 	if (req->header.status) {
 		ret = -EIO;
 		goto unlock;
-- 
2.43.0


