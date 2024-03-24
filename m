Return-Path: <linux-kernel+bounces-114333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C311F888FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000171C2C013
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8758170A4C;
	Sun, 24 Mar 2024 23:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ulfllgwi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41678212548;
	Sun, 24 Mar 2024 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321718; cv=none; b=lAjDQ/F0iyC3wgYFoQ1B/nkdv4p43iF6z1o0n+iK/ynvI412Vsae1wzxwAfAxBImlFgCBLL/nKFw3Yw6gmSQx1b62Jnwx4/jUBgiG3NU/jdYeGcU3Nwr7zgepFDeqwoQ/psvn4nmSv4nDaOPwhMznlBvNeJNcNeq9ogqKRkyV9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321718; c=relaxed/simple;
	bh=tkufBR9raGvxU8c3aH3i6ldwN0hrm/x4DjtThUr85q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VV84yWdZf6v57W8+jLeb23hhRmlCbxmpiXNvQLZLQZHtILcyDgBG3pf6Ig5igVPzPMvSbj/xGLWnJpDrxJJkddkn3i1em2vvpoO9U5xitnLq6aEt9R59M667gxRRxmCIF3S0a31JFRIqoIBQhnLejvw8ewltu0DRJn0KXdEeC+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ulfllgwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69454C43399;
	Sun, 24 Mar 2024 23:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321717;
	bh=tkufBR9raGvxU8c3aH3i6ldwN0hrm/x4DjtThUr85q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UlfllgwiLHob+yd6ZhmEQEwb7tMA6TO/nJJJ2z4P/1zVrjWxoe9nNmLUlIoeSX3Zr
	 ZGxkqZW5YGHWGmvs3Nx95Zq9NptmYNNJrVGdgga209kOcfk+aaYN7zppr3qwDn6d68
	 Q0Vk5+jG7G27U/i2CjzBvSB1zv9qBmS4ZfzRsx1Z7PSPAec+HUReJSmpWhjm5xsAgq
	 ixH1ZveaQzUmZ0/0XO+NUh/C/mCBt/srZBGUa67rZ4LmqL+eMtoTxCJqXJYs9q9z/9
	 5hGvXS+rrc3Nr6b9nM3tpE8y3SeJXguPYFGdE+b7dhZ5ww96hzHDMYj9lyEDa4Bfuw
	 a2yEWRhMZnGnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Tim Van Patten <timvp@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 445/638] crypto: ccp - Avoid discarding errors in psp_send_platform_access_msg()
Date: Sun, 24 Mar 2024 18:58:02 -0400
Message-ID: <20240324230116.1348576-446-sashal@kernel.org>
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


