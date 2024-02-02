Return-Path: <linux-kernel+bounces-50358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3320C8477FA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D171C2593F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505778173A;
	Fri,  2 Feb 2024 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/oP5Lax"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905BC81759;
	Fri,  2 Feb 2024 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899187; cv=none; b=HMaV6mn1u6IzYOu0bk73aKyxs7UR9o9pXuBAWoqVtkLSGF+LgUmRj6tfST5tPWw6F4Rk7416Q4gbxeg54sUSseG3GFaif9jIpf3o5/YGsMIZiIOpYTjiRT5yhkMFOuIzH6CSaZxqPw/f/gaA4J+l8rCZ/RDv6LfHxRSgJGyPyKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899187; c=relaxed/simple;
	bh=oL7JlFfSrv/b+OraAgW7UZGCKvSYERj0lJfWpM7VO+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5WXLejeuvvxz03Kz7Fcj8zw1gdFcKpGCAba9DRq2j4NJUjhXGB8oPMeURqrOyQ1kopNoAynGXvawhRzapKWooD0vWRqr7wBDyXoYQ9sekHh5FXHAfR13yWUaN2OpPcAaDRnBuGEObdx/aSb5qrmTgbmO4ryPELCNz2yPO/9VpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/oP5Lax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B983C433F1;
	Fri,  2 Feb 2024 18:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899187;
	bh=oL7JlFfSrv/b+OraAgW7UZGCKvSYERj0lJfWpM7VO+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C/oP5LaxuYs7WervXyD8ec/qHoPZEJ48zc2qVNAjD0yOqUtjbyBG7TQqcc97WDFtl
	 UeX8CWy+RF4bfH4cxGFF975xU4VctM19oYysaWti53/AhbFdzgcmhrvUGR48vMJ01O
	 vsQlswLUUxJ9FUWHqj207yD7n09JOtXCwi9Ex48g5tGbSNAjexTe+O8ySIfSTMnm38
	 h89lXM6taXvYX+gbei/CB1+SIQWGfOo2JFg7bihQTQzAB/a7QihOOsNg0xDf0gIIgn
	 UVl31hS6v3wk6lCG9UpwrMiPI6V97fLPvnRb1LCmas2Si0eeECR/TeV50ECEwCMPci
	 ynkaLFwUiNoAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.7 13/23] cifs: translate network errors on send to -ECONNABORTED
Date: Fri,  2 Feb 2024 13:39:09 -0500
Message-ID: <20240202183926.540467-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202183926.540467-1-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
Content-Transfer-Encoding: 8bit

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit a68106a6928e0a6680f12bcc7338c0dddcfe4d11 ]

When the network stack returns various errors, we today bubble
up the error to the user (in case of soft mounts).

This change translates all network errors except -EINTR and
-EAGAIN to -ECONNABORTED. A similar approach is taken when
we receive network errors when reading from the socket.

The change also forces the cifsd thread to reconnect during
it's next activity.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/transport.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 8695c9961f5a..e00278fcfa4f 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -400,10 +400,17 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 						  server->conn_id, server->hostname);
 	}
 smbd_done:
-	if (rc < 0 && rc != -EINTR)
+	/*
+	 * there's hardly any use for the layers above to know the
+	 * actual error code here. All they should do at this point is
+	 * to retry the connection and hope it goes away.
+	 */
+	if (rc < 0 && rc != -EINTR && rc != -EAGAIN) {
 		cifs_server_dbg(VFS, "Error %d sending data on socket to server\n",
 			 rc);
-	else if (rc > 0)
+		rc = -ECONNABORTED;
+		cifs_signal_cifsd_for_reconnect(server, false);
+	} else if (rc > 0)
 		rc = 0;
 out:
 	cifs_in_send_dec(server);
-- 
2.43.0


