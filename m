Return-Path: <linux-kernel+bounces-57177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0F684D4C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C24283A07
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16A7158D71;
	Wed,  7 Feb 2024 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPVxFCGu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CD5157047;
	Wed,  7 Feb 2024 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341160; cv=none; b=WJJW/2n6bv8wVS3fsK1aJ9T0ntgMX61owzPTUIOCuewKqbKFWBX0D99g2s0uB+81hsMjg6DlwCRs6cag3XfPVygq1RYksn6wHaOjLFmnbtlImHJWRf8v5e347+W3w29YuUiSqf/HZ4dFFz4Jq8T9+8k8kY7CCBR6azluMfQ0ewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341160; c=relaxed/simple;
	bh=3Zria3SDjxCD65ZC/gxaL0fTaARSqCzzrAlR5RzhxVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZoSC0ebHk+lrfNE/v2+xw3rfvEFLAoxiZ6Ptu6d1Phlwp80QTOHSTFhrlNC3grd25aFpZZB/aN1bd3r5jFznlywp3wgoBzjJr5lXYBBwdMz5m5yx5QNUkS8AHz59BELIGuhlTzanuebbwBqTHdDBV6ND0kUQEkt+z0RImfMJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPVxFCGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C37C433F1;
	Wed,  7 Feb 2024 21:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341159;
	bh=3Zria3SDjxCD65ZC/gxaL0fTaARSqCzzrAlR5RzhxVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iPVxFCGum/F+LblTBTWL8Sn+tBXlVxiitMU//oo7LnorzSQLhSDJ8t2CZXlVUDgsH
	 tyXU9IqVtK4yzDw+AVxaUQlSKVL8CfSTb9tyfoVO5pKqWgN1YOYjZv5Dinicamg6ti
	 j/VQN7TwXmeml95y7IGOxqJIQGZ3Z78BlJpUS3BWgzbZh+qH6U9/AC2jDzKWBPuBT3
	 3jvpDdmGE00D4vwQ6VSaY0O2iqgYN9IYKekrpo8yJFfGBUcT0WFrl8haEXHk9lovbE
	 i1PvIQlsgbvD0uplLYybR1nRskLDcP3Fmiv9Y6ERSEIUlby9hzYoPQkpK4JsSDubfR
	 AMlxd19bbaVww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.1 27/29] smb: client: increase number of PDUs allowed in a compound request
Date: Wed,  7 Feb 2024 16:24:52 -0500
Message-ID: <20240207212505.3169-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 11d4d1dba3315f73d2d1d386f5bf4811a8241d45 ]

With the introduction of SMB2_OP_QUERY_WSL_EA, the client may now send
5 commands in a single compound request in order to query xattrs from
potential WSL reparse points, which should be fine as we currently
allow up to 5 PDUs in a single compound request.  However, if
encryption is enabled (e.g. 'seal' mount option) or enforced by the
server, current MAX_COMPOUND(5) won't be enough as we require an extra
PDU for the transform header.

Fix this by increasing MAX_COMPOUND to 7 and, while we're at it, add
an WARN_ON_ONCE() and return -EIO instead of -ENOMEM in case we
attempt to send a compound request that couldn't include the extra
transform header.

Signed-off-by: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h  | 2 +-
 fs/smb/client/transport.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 7f1aea4c11b9..58bb54994e22 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -86,7 +86,7 @@
 #define SMB_INTERFACE_POLL_INTERVAL	600
 
 /* maximum number of PDUs in one compound */
-#define MAX_COMPOUND 5
+#define MAX_COMPOUND 7
 
 /*
  * Default number of credits to keep available for SMB3.
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 8a1dd8407a3a..c7254b321184 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -449,8 +449,8 @@ smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 	if (!(flags & CIFS_TRANSFORM_REQ))
 		return __smb_send_rqst(server, num_rqst, rqst);
 
-	if (num_rqst > MAX_COMPOUND - 1)
-		return -ENOMEM;
+	if (WARN_ON_ONCE(num_rqst > MAX_COMPOUND - 1))
+		return -EIO;
 
 	if (!server->ops->init_transform_rq) {
 		cifs_server_dbg(VFS, "Encryption requested but transform callback is missing\n");
-- 
2.43.0


