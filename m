Return-Path: <linux-kernel+bounces-26825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA1E82E69D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2489528151A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32081BF2F;
	Tue, 16 Jan 2024 01:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQz/KNZF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A9B1BDF7;
	Tue, 16 Jan 2024 01:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D634C43399;
	Tue, 16 Jan 2024 01:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367104;
	bh=QPWavivlkwk0fveZfshUlcZyO+JSrsdu5mSEUt0p7kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQz/KNZFDv7ReTF6Pv/Uw9mbdnQaxXP96PW+CBWIDdxZdPpiQMsuqXHyN2ocd5b6M
	 TAXNdkkADZD09UUFXOXPadnqFEWfF2Ic8Mni7JW6yTS7i5MT1kuApGt+T14Hg7QQah
	 SwzEUgG6fQ608WfPmFbMlEmEUVu9Jfr0p7Kc9dLged2tL8qJ9n4s2OAX1bibaYOMKK
	 /795czc6UckqGSvxrbwBNk/snA21DwRa1xv4iWCSUV9m/n8z+tptNXCgyG1LI9E5rD
	 1brXFxc1oVyXbIVei++v/YDWv2jF0xbD7WqIlQb0OhgBcYfkmbhRel9t2L8m+OplcU
	 roMpnCg5PEi+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.7 16/21] cifs: fix in logging in cifs_chan_update_iface
Date: Mon, 15 Jan 2024 20:03:53 -0500
Message-ID: <20240116010422.217925-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010422.217925-1-sashal@kernel.org>
References: <20240116010422.217925-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 516eea97f92f1e7271f20835cfe9e73774b0f8cc ]

Recently, cifs_chan_update_iface was modified to not
remove an iface if a suitable replacement was not found.
With that, there were two conditionals that were exactly
the same. This change removes that extra condition check.

Also, fixed a logging in the same function to indicate
the correct message.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/sess.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 2d3b332a79a1..a16e175731eb 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -440,8 +440,14 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	}
 
 	if (!iface) {
-		cifs_dbg(FYI, "unable to get the interface matching: %pIS\n",
-			 &ss);
+		if (!chan_index)
+			cifs_dbg(FYI, "unable to get the interface matching: %pIS\n",
+				 &ss);
+		else {
+			cifs_dbg(FYI, "unable to find another interface to replace: %pIS\n",
+				 &old_iface->sockaddr);
+		}
+
 		spin_unlock(&ses->iface_lock);
 		return 0;
 	}
@@ -459,10 +465,6 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 		iface->weight_fulfilled++;
 
 		kref_put(&old_iface->refcount, release_iface);
-	} else if (old_iface) {
-		/* if a new candidate is not found, keep things as is */
-		cifs_dbg(FYI, "could not replace iface: %pIS\n",
-			 &old_iface->sockaddr);
 	} else if (!chan_index) {
 		/* special case: update interface for primary channel */
 		if (iface) {
-- 
2.43.0


