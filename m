Return-Path: <linux-kernel+bounces-114490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E637B889029
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B731C2B155
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28BA1802B6;
	Sun, 24 Mar 2024 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRhVLuqI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EED92251E8;
	Sun, 24 Mar 2024 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321936; cv=none; b=puPh7EkeCa3jpBHCisxyspna/yiCO6/bA6KGl8VJTR0e/M+l5Yo0rEnhYKoXYhJzQmY+R0O4mYqXVJmGjmlDOvqvyQN0AZjSHzKcJ11jtCGPR/9NYLZMdQvsAYehezfCSpy685bUXwv73EskLim4azzHjKVEHKG2qyBpust0lW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321936; c=relaxed/simple;
	bh=8XXOns9lt6hyCk9TvaQg011KZvUoFs/LBL8puhHyXhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHX/EZfcs6FSNuXGuVaMq8y6Eq7n478+YRzkgw+Hj4hCEf1fp06HA4WRjF4UToHKv8hxZVoUU9rryQMvYXLCzUwFMSWapxr2lihfW/VLXgSS32BiggCy4JRk2lYpi94fntzrLS6s6E1/gmBmbDdrxgu010PkohC+qpkvM/CU/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRhVLuqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1297C433A6;
	Sun, 24 Mar 2024 23:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321935;
	bh=8XXOns9lt6hyCk9TvaQg011KZvUoFs/LBL8puhHyXhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DRhVLuqI2vxji8Cf8ezWgDWeKdmtJ9MK7a2jel8musTiAVPUd/PI+myY6aPQ3Nbkh
	 mP5jytQv0xhqn4zzW6LoC7TmXhbWOfoRWMf8rgqvk1b7rO2iAsLCxnnH4+CCvOf+9e
	 TO67f/P4es7okks4nde/e7ky7aheD9xFACbMAoCYykXKndJhKBegoi2NGscfDopUsc
	 dOVG7q2v7SIqrz7CoiZUgshUvxShCHr+zo+qbRVXM+bfcyA1RaAXQSh2E8m0bafOUe
	 HAtMC1QOSNk4BPZ0XzZsShHzrR6ZvjDebtganU4hWYrMNd4g7rbulOv1yqmF5vIalu
	 cu/IiEQ2jUm9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 006/451] nfsd: don't open-code clear_and_wake_up_bit
Date: Sun, 24 Mar 2024 19:04:42 -0400
Message-ID: <20240324231207.1351418-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit b8bea9f6cdd7236c7c2238d022145e9b2f8aac22 ]

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 6e8712bd7c998..5b5d39ec7b010 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1174,9 +1174,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		status = nfserr_jukebox;
 	if (status != nfs_ok)
 		nfsd_file_unhash(nf);
-	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
-	smp_mb__after_atomic();
-	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
+	clear_and_wake_up_bit(NFSD_FILE_PENDING, &nf->nf_flags);
 	goto out;
 }
 
-- 
2.43.0


