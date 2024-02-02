Return-Path: <linux-kernel+bounces-50380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1E584783F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D78292A49
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEC7133297;
	Fri,  2 Feb 2024 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOggb5Pd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C141F133284;
	Fri,  2 Feb 2024 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899235; cv=none; b=dSld+RXfp+NRHbCwv2Y1aC8yz46NtA1GqvGyiPJnKKVKyKfT5JMuXnogfdHZd0VzqTgFqVQvJVXeLY4gk4cYcOxKl7V6c8AbJZjXd/Zdx01/eqQj7Pxsb+L4ezIQxviddxf9Dn2OwRexMOGvE5dtga9wKhBUZuRKGtmc+DHZ5yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899235; c=relaxed/simple;
	bh=iFp45mGFMA9uQPZxVUZOM5cXEnpPojorRW7JXIbpb9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahut7MfDtLfmq59utwUqSUkay/wj+oHkEK7/j6WjRpUe3kHduIPYSx/32WzMNjeErXItGd9hi7wrYGxJSzt2tPaHMTjw9finNORRzkHOsgP1r2BbLArOemTWPfZ25BJe0Cn2M8QM7zgdZDVCLWitzpgY6gF4mI2/lkxsddKhKgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOggb5Pd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A34C43330;
	Fri,  2 Feb 2024 18:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899235;
	bh=iFp45mGFMA9uQPZxVUZOM5cXEnpPojorRW7JXIbpb9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sOggb5PdpCA4DU0OzVRRPuphijTkMxmNXpTbwQ3GY/c2OF/cabM2TWLlnBkGUij2I
	 4Ap7a6j3E7W591Ao6nTBzwmry7PmWJzvZon+JT/zg3U0KJiB6oVAkFYCBtPbauyk9x
	 +Qdz61vIEoWl0xHn0dAdK++vWbydZnzzVwTZ4fHBJhPNkZQs17u0DWa4fzpj8zwm0D
	 NTh5f53q/z/2jKOCPIgoGINMs8HrSeTO9LT2vWrthId8LYZIYGLcXrt11ifEiDFbKa
	 rOCiPcs4xInuxGxBy9jPRYVEKZrC78O2nzIIGvlkOtkdnF2HAHohsHU4/1InNH24jH
	 8MwSItTiqSI3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.6 12/21] cifs: translate network errors on send to -ECONNABORTED
Date: Fri,  2 Feb 2024 13:39:59 -0500
Message-ID: <20240202184015.540966-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184015.540966-1-sashal@kernel.org>
References: <20240202184015.540966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.15
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
index 2d0a2951cbea..fee0cba264ee 100644
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


