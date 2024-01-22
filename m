Return-Path: <linux-kernel+bounces-33396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 036B6836931
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E9A1C23E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA277A72C;
	Mon, 22 Jan 2024 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gea95LSO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5987A71F;
	Mon, 22 Jan 2024 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936131; cv=none; b=dIAFOLKtQIGNtTDdVCDNaQutpXrSaM7ih+2rYhuCrDHDt/As6jHWRnmuL70dOsQGKwcHuxNPei1hJ3etzazoDi6dpAD8qFmntJk00rE0J4z17C2Cqi98mRHpQQ4+Ovcac6oXrvtm51TVxa72ok7sZXG53EQqe2eO/s3wGa2+8ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936131; c=relaxed/simple;
	bh=WEZtMWkUIVh0idP1DuCajZLtTaEoy5YLC8AvqYloBZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yo4nsfvd/b8zs14vsiy7Eh/m9V65mT24R4Flu6TrYg1Wyf+byx7uVOJIP/Gp8oqKBAkai7F0pr4ynX87od1c37IoiM1OQKg4UlHJcBTlRE9wrPVUZzR6WBPjfBb0pOHIlCgOCTeRjh9c1sB0OVDlarjPG717bbmbCKecvgqvBzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gea95LSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386ABC43330;
	Mon, 22 Jan 2024 15:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936131;
	bh=WEZtMWkUIVh0idP1DuCajZLtTaEoy5YLC8AvqYloBZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gea95LSOJfb/AssakwFbRfjsA6WNfQWZpKLOo0Qrsoyxmc2YemnGo14Rm25X9zFxT
	 TDWu/a8E0lc3K326DuoZR1LK6G7DXoAKZWGhpBoCpAfxLGBMJJBp1zn3zmcjjgQcPP
	 XR5xI7iF+Fj959zkVIn9PgQ+GG/4Xg2Majb17i1tZYIpYr4MqWcOWcBlmV3qYPVEk3
	 MVgKCYLdjZTGBLcO4pNTaSzNGcdg5Za7CpB+YsIMOSiXr3sT5Au6dKABVuWA1MNdaU
	 wscSi9TcUUwtdhb3+noRgrD2dhgdmbFG9HJdNwz+XuvlKMkQzvLx5GRdbVsU0m3h0I
	 HRK/aar0Bm+Kw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 71/73] ksmbd: set v2 lease version on lease upgrade
Date: Mon, 22 Jan 2024 10:02:25 -0500
Message-ID: <20240122150432.992458-71-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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


