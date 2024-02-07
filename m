Return-Path: <linux-kernel+bounces-57146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED23A84D476
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CEF28CC78
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE121154088;
	Wed,  7 Feb 2024 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0I0X5oR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A82D153BF3;
	Wed,  7 Feb 2024 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341090; cv=none; b=as9z59bpYnCeGzcfcVM5iegST/jkwaLdUK1MXz9CRD6X+53KvaIomlCpJp+h7vVwI9aZyGqwFF4A3ASj3W58n3uPJrInHc/taK2Hd5jVoKoq+Jn6XPW4knE7LYYMxvCxm/xRiTYR3M3JLTFu904zWAqqr41ht2RScpSguRC/rj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341090; c=relaxed/simple;
	bh=Ba8y75ugfKC0c+0AUawHfVBNym71ulVihe5wwvG66mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOf2hRTWNC8yW1wtiK/5A8j4hdYTeYL5+p4z7bBDz+6RdZiCh8NHCbG+t9PXq8iPNSuypAmHMibDny9m5fWWZjJd7xXU5/AL7alswDPupbo1o9mf68qiJVnGQ1+miVHxXYiIZcyX48oeYcrXNO3vTKuFgPBwjv0zsOTmLjnlHrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0I0X5oR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE84C43390;
	Wed,  7 Feb 2024 21:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341089;
	bh=Ba8y75ugfKC0c+0AUawHfVBNym71ulVihe5wwvG66mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0I0X5oRw1U5rKoaQoinb41MPIItQG7CvqrgOctdAkt+sal2J19/nhVpkxwVDDByu
	 qMCfP7NofRiaFLf7aA/b1KEbkCY32ZgX0VSYLTVXXDlqBqm4IkzRhVV33xkFGcHFJb
	 4lFOt/ZWm+4XBa/EP/ubJOdJSFp0HM2Bj6gwDdi15RZPBL8peeKvJVfp58RPalCKcF
	 TsifQLsPPfJ18u9ecDLqe1q5MONs//AWk2wNVzwtz6k3cpWHd790GATiH1IEq50mXA
	 wxNdmZ1JTw/4GwqN75z6TLr0NWcw4shE0DoT6KentDHrhXbm5tU8xe52PcEh+nDPen
	 LFBmeX900smxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.6 36/38] smb: client: increase number of PDUs allowed in a compound request
Date: Wed,  7 Feb 2024 16:23:22 -0500
Message-ID: <20240207212337.2351-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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
index 75ca732a1679..b65ce8d13143 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -82,7 +82,7 @@
 #define SMB_INTERFACE_POLL_INTERVAL	600
 
 /* maximum number of PDUs in one compound */
-#define MAX_COMPOUND 5
+#define MAX_COMPOUND 7
 
 /*
  * Default number of credits to keep available for SMB3.
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 4f717ad7c21b..2d9146600371 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -428,8 +428,8 @@ smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
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


