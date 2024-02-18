Return-Path: <linux-kernel+bounces-70588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 623BF859980
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 118E9B2092B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9B47318A;
	Sun, 18 Feb 2024 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="TVTh33e5"
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A43D2E3F2
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708291090; cv=none; b=NyIYVuwSOKZtTsClDdx34xpGAyRN5ywep99c/x8uARCE36xP/8L4CgWwcOkHEwXUFDhf1/1ZQKjmOMSreOiXrt6osV8mG5rl2KhEAShlD6xUAI6chVHROvo+CDbGajAh1iJXLFmKhqlTaK0w77qUpoMYDyBjihc3M2bm+VgS0UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708291090; c=relaxed/simple;
	bh=BxcqsSOye6RaQDfKIvGr2bgaquYxTiPvYyIpjcx/QPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KPFaw3vKCZYeVvRyo/VsWtIYxWS6mLuYlpP/MYPGTQWrG0SUTPig7M59wNEyHuwSn9F5rusweQQleaUDr3hBSRDUOLJTeftTptzyq7Slv8OGeOoH1nfYw1C6eIqSGqV8jR3iBHjholCMtU2uSoKHsIbO8X8+Q0XwnyGWDLyrxEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=TVTh33e5; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id boWurGUjG3aavboWur7NMi; Sun, 18 Feb 2024 22:16:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1708291018;
	bh=ncaSDgs1+enPP4UVmeGBwEY2+QQ+tg5QlYg91NhYxGo=;
	h=From:To:Cc:Subject:Date;
	b=TVTh33e5zGD+jTgYlXCXIyyKR0D1mAhWmmyu6zt6Innsy7t2jdchKNdz6ImEfAN4R
	 hIBlfXwDCuvS/ArMcl8M0zPB14z3VgJli6Zhu+30RHRqAfwA0YpuCHIR8mlzBBsfbq
	 oUnvoxE51so0miM5RYzMSVGFpFtGmHfxiNZIIx3HpplsyQ8Aew17aGD8VDllEY+8zV
	 HD0tPZ29As9evqkTJDE9FgKZFO9F32nLmzYanz2D12zmhYFu7AXwyNYQA/IGwyymnY
	 cXfWvV2O2bjvrnQK7tnb/Xv5FZ1lAGo+DR3xcDlORd3+mkD24xA0pyazx0drXdS+qp
	 OmPrZuDsZrzOA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Feb 2024 22:16:58 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: bcodding@redhat.com,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFS: Fix an off by one in root_nfs_cat()
Date: Sun, 18 Feb 2024 22:16:53 +0100
Message-ID: <fb121003ce56182477c693ad7adc37e4308e35aa.1708290887.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intent is to check if 'dest' is truncated or not. So, >= should be
used instead of >, because strlcat() returns the length of 'dest' and 'src'
excluding the trailing NULL.

Fixes: 56463e50d1fc ("NFS: Use super.c for NFSROOT mount option parsing")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
---
v2: - Fix a typo in the commit message   [Benjamin Coddington]
    - Add R-b tag

v1: https://lore.kernel.org/all/856a652a7e28dde246b00025da7d4115978ae75f.1698184400.git.christophe.jaillet@wanadoo.fr/
---
 fs/nfs/nfsroot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
index 7600100ba26f..432612d22437 100644
--- a/fs/nfs/nfsroot.c
+++ b/fs/nfs/nfsroot.c
@@ -175,10 +175,10 @@ static int __init root_nfs_cat(char *dest, const char *src,
 	size_t len = strlen(dest);
 
 	if (len && dest[len - 1] != ',')
-		if (strlcat(dest, ",", destlen) > destlen)
+		if (strlcat(dest, ",", destlen) >= destlen)
 			return -1;
 
-	if (strlcat(dest, src, destlen) > destlen)
+	if (strlcat(dest, src, destlen) >= destlen)
 		return -1;
 	return 0;
 }
-- 
2.43.2


