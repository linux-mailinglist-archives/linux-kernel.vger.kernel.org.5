Return-Path: <linux-kernel+bounces-115499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7875E88946B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9660FB35BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C9D233CCB;
	Mon, 25 Mar 2024 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfLAqZdf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A051EBD3D;
	Sun, 24 Mar 2024 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320934; cv=none; b=Cmf0uU6MBcrv6LSXgCvl4eddmW+iv+u9M+wDOa4gTE5Mn8xYSsHDUhezaJzJqVI/aPASTOwdfqbx00OTUJwQX9EOn9Wy9YFB/iUHV6GcUJUOpLKmoF/XhYk+cBxvjRbOINiWqFZeE0ZNRHSu9VO1W8xCaQRdYXAyQUUtm+linfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320934; c=relaxed/simple;
	bh=tkufBR9raGvxU8c3aH3i6ldwN0hrm/x4DjtThUr85q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhLrQADmAwy4fEMUZKxXzFpMOa10oeg7f0LwYt0i2v8Wq9bbbrEBubgeprB2dF0odQlmCTUbMN1EEuJqqhd9RJLpIfQOhnXF6rhApJ3nDeBo6aaA5xLeK234ss70ZPmVfUH8nne7wGSOJm9vHzR2hgYzjyzCyWBcMND1H9euCD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfLAqZdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C953C43394;
	Sun, 24 Mar 2024 22:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320933;
	bh=tkufBR9raGvxU8c3aH3i6ldwN0hrm/x4DjtThUr85q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WfLAqZdflfgXAQFazefS4bR0E4p4TJdi8M1EAwKqHRNfrGwYjUMqH+59KV48vBUpI
	 /MVku3SDO6RDadxzekplxgRFC1TulDikhsD6GsB/YOb9ladKo9DzjcoNH26AYKvOOW
	 4XeKZhZ3T3bfTdlRzMS9yjYsembXZbVToiFB3eYQvBQJ/mffszTbBzBf3FO5UrjcTP
	 QWpqImwGxlTTlHBwgGEE5bKCfI42XvEp3EMmasiQov3w+tJ3WO6XPy0uy/w1q7BRTL
	 Z++Ce/cYQIJ9KQA5eXDyU8hdwqxCMZQYYK3dZruoB7z4g9RA+W3inyDSPoCns5o/x6
	 j58/IHGTV5S7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Tim Van Patten <timvp@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 497/713] crypto: ccp - Avoid discarding errors in psp_send_platform_access_msg()
Date: Sun, 24 Mar 2024 18:43:43 -0400
Message-ID: <20240324224720.1345309-498-sashal@kernel.org>
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


