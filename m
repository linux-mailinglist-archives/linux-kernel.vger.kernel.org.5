Return-Path: <linux-kernel+bounces-33308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35320836836
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675E51C2230C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9345FDB7;
	Mon, 22 Jan 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPnnF0b+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C855FDA7;
	Mon, 22 Jan 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935743; cv=none; b=LP9K63JPCdZMTLWrWeFP2ZaaW296X5qVIyj7Q1USHGgJkVma7Azm/NV6GtCU9zKOEC9ig6UxrcnCouxnAD2fm3Plon+ckWtpPRcFfVmeWj4rEVP4uV/bFxz0lkL5W4nk07hjvZvJKLdNnwzydJfmFTKUz9S84BTDfBmOQtKWmaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935743; c=relaxed/simple;
	bh=WEZtMWkUIVh0idP1DuCajZLtTaEoy5YLC8AvqYloBZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQ1NeWNttdaUkdHTE1naRErPYA1Nbef6uFMS25xhB/0XiWDQnIQy7B6/iEWNoqd7d78zJIBT8u2BG2/dPXocxEkn8pCKy9qrGWLA4zHrIWh5QjWw/nE6dYnHbEAXUGBOwVXj8494sJbjoe3Lo2YTA2eGULJ+/ja5VUKkGPLxvBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPnnF0b+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CE1C433B2;
	Mon, 22 Jan 2024 15:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935743;
	bh=WEZtMWkUIVh0idP1DuCajZLtTaEoy5YLC8AvqYloBZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aPnnF0b+u1ogRKqC0sy/Aqukj+IuFm3SrKkDa67Ngz9cO0sB7+fJoHbBKjKewrp3g
	 r5MDCN5lfhXmddC54g+GHmMW3RiikI5SlF10A4VHH9Yx1rRiF6ByTljdqeFKsoI3NO
	 tvPGax3LmRoJl/QM8D01DYgZ+UhscH2BqNWZ/aqc/ZtNlnxwm0XVhpzYgEpXu6PteA
	 46GW6HSp/gKWh0u5AHOfRcnwAX/CLdo8XfQjr/+THwDiRKG+MKLfYo6e+dEITThef6
	 0d8p2h7N+Pt9pZJJCI4wlWuoO9kl5fM8w1exDw+/N5SgcJDkw0L6h1r84ymZYv0/Z3
	 NYUJe/CNiIiTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 86/88] ksmbd: set v2 lease version on lease upgrade
Date: Mon, 22 Jan 2024 09:51:59 -0500
Message-ID: <20240122145608.990137-86-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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
index 562b180459a1..9a19d8b06c8c 100644
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


