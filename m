Return-Path: <linux-kernel+bounces-3640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2951D816EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C081F237D7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A8F740BB;
	Mon, 18 Dec 2023 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8nMe5pJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C6574E20;
	Mon, 18 Dec 2023 12:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDE2C433C8;
	Mon, 18 Dec 2023 12:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903572;
	bh=B+T1ZSAQp/Ph+V3mnVeaCBPLLRQUGLJ06oa8aq1DXUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y8nMe5pJQ9iYoA8sGmjFNlwzuSpkSgri30KTbHExr8Mp0aE1N7ivtHs2/rAhkiRCz
	 nPHnvcS/WdTJpfYxmMHq0LishIHkmF80VaP3SWp4iy03+/Mfb620Wc5y/p7T28pPoo
	 WCcFK3kOljw8BoLZS2rqDEzhGn2hman8deoZFrWlz4qgn5ObkWi+GQIabcr3GUP5Q2
	 QXK5rmsdCE4hRo0SQZNanAL8CfSk1Ej+/1XpQKEfTi4gY3ZggqexRQnvmaVkjcCZNh
	 x5OwKolYEGTO4y+o9V/mTgwYsw0sule5DvT8LZqcVJGWcdOTMv4/Hb9b6rp9Nk9uzC
	 cVcUTFJguifUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	brauner@kernel.org,
	dchinner@redhat.com,
	ddiss@suse.de,
	set_pte_at@outlook.com,
	cc85nod@gmail.com
Subject: [PATCH AUTOSEL 5.15 06/13] ksmbd: avoid duplicate opinfo_put() call on error of smb21_lease_break_ack()
Date: Mon, 18 Dec 2023 07:45:39 -0500
Message-ID: <20231218124557.1380724-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124557.1380724-1-sashal@kernel.org>
References: <20231218124557.1380724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.143
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 658609d9a618d8881bf549b5893c0ba8fcff4526 ]

opinfo_put() could be called twice on error of smb21_lease_break_ack().
It will cause UAF issue if opinfo is referenced on other places.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 656c627d1bdf7..e750f942d2d47 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -8200,6 +8200,11 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 			    le32_to_cpu(req->LeaseState));
 	}
 
+	if (ret < 0) {
+		rsp->hdr.Status = err;
+		goto err_out;
+	}
+
 	lease_state = lease->state;
 	opinfo->op_state = OPLOCK_STATE_NONE;
 	wake_up_interruptible_all(&opinfo->oplock_q);
@@ -8207,11 +8212,6 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 	wake_up_interruptible_all(&opinfo->oplock_brk);
 	opinfo_put(opinfo);
 
-	if (ret < 0) {
-		rsp->hdr.Status = err;
-		goto err_out;
-	}
-
 	rsp->StructureSize = cpu_to_le16(36);
 	rsp->Reserved = 0;
 	rsp->Flags = 0;
-- 
2.43.0


