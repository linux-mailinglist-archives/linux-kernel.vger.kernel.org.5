Return-Path: <linux-kernel+bounces-33452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1EF8369D0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CCA1F243F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9599112C550;
	Mon, 22 Jan 2024 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukc1ChzN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D387312C541;
	Mon, 22 Jan 2024 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936348; cv=none; b=nOvbZuKip9jrG6p1kpMLjIZNUCzmnbLvciXLQhNtH/LCMq1VGCkWfovcbdhKNHy8q1d7s41ke86tmzceKEvhYa720shvZPayrLxWdbBFPypvuKNImxYTktoDMf83xXjRlRv2aOqVFNaJC+wboZuISNMeQfBmdpUGS94B0egL9aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936348; c=relaxed/simple;
	bh=1K+TRw4TUuaHRm9hT3Dq/XA6TWRuj9WC+F1/zWcrTZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHXu6Q7CXTk5S3O2YmVM/guEutykspi2wkQgRrZhpsbrL2+D7z31IyqtMwZIbk2BtiOzJtIqHTNx0TTp3aTnFybazxq/f7KsW1JY8fZ0/9zMAh/AXV0rLdmQIbNusZoIp/I0mdiEd89dABlPbLBplLw5g10XiJYzi7EFG5alK58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukc1ChzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6339AC43390;
	Mon, 22 Jan 2024 15:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936348;
	bh=1K+TRw4TUuaHRm9hT3Dq/XA6TWRuj9WC+F1/zWcrTZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ukc1ChzNqr/cGi9Y6lUv9ZCZPt3NyAdiGPTgCHfgVTSb2x+nrGo93ykc4l3WIpcx/
	 eHtPZ3HOKhDIEbEOs6ZZvcB5fO1C4mzi+ZmFurl1RQUnOwZ/98xvf77FRwreDE2Xvp
	 n/1HG7fvBLMMB4YQkdNbKRMmQcmo35YIGArcocKPQKsRTAUC32I5PZwh/5pyV3PA5T
	 8oPGXrq+PkIUz7eYBEjDjzCL6b1CJA9+jv4k/rivjnS5W415RwgDUEW1bGfr1GmYPn
	 taFs0UargvDT7EmaoZhv6qHRX+js+Vau2RLcO2hfPublY2rgbJtUOS1ju8NSxQ/mnb
	 Y03Y+SRxv3Zfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 51/53] ksmbd: set v2 lease version on lease upgrade
Date: Mon, 22 Jan 2024 10:08:52 -0500
Message-ID: <20240122150949.994249-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit bb05367a66a9990d2c561282f5620bb1dbe40c28 ]

If file opened with v2 lease is upgraded with v1 lease, smb server
should response v2 lease create context to client.
This patch fix smb2.lease.v2_epoch2 test failure.

This test case assumes the following scenario:
 1. smb2 create with v2 lease(R, LEASE1 key)
 2. smb server return smb2 create response with v2 lease context(R,
LEASE1 key, epoch + 1)
 3. smb2 create with v1 lease(RH, LEASE1 key)
 4. smb server return smb2 create response with v2 lease context(RH,
LEASE1 key, epoch + 2)

i.e. If same client(same lease key) try to open a file that is being
opened with v2 lease with v1 lease, smb server should return v2 lease.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Acked-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/oplock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index af0f6914eca4..ebb7d100c851 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -1036,6 +1036,7 @@ static void copy_lease(struct oplock_info *op1, struct oplock_info *op2)
 	lease2->duration = lease1->duration;
 	lease2->flags = lease1->flags;
 	lease2->epoch = lease1->epoch++;
+	lease2->version = lease1->version;
 }
 
 static int add_lease_global_list(struct oplock_info *opinfo)
-- 
2.43.0


