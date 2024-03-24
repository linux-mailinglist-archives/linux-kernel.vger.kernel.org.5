Return-Path: <linux-kernel+bounces-115734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D724889756
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6341C2D349
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66836364727;
	Mon, 25 Mar 2024 02:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0WXlKCu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E611F0952;
	Sun, 24 Mar 2024 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321814; cv=none; b=J+deTblU4YLrrWTOjCkbamU6r2g3jQxcQTGD8yPhaAxijVhHrNaZj8/k6CcpXvVwgmjQYGZ86xj5iTZH10vyhWFz4uPwtswWTHnfsOyk5dz+Dxufm/RqLDAuMcZ0oVBPW3Lb5JhDHG1SE+uiczOIHHAWBuk/aQrT9l00mq+pCcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321814; c=relaxed/simple;
	bh=Zkv4uBQK8eMbRPj/TMoLQKTy5qtiJb0tBI+C77mgZrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYdWijdooNXkdgGk9VqNC8fSptd7q59QmRCIyuyZNjYUTfefGCARyu5IB0jmyrPTx6c8GrccC+O3IjpP3SsbiISXVMuMm4A2079DTob5cYtg9QaPLlkj3addv2Nid+tWZU2GJxFmQ5AnMmoj+QkCd6UK9H1tOWcWdPX8IxKDqdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0WXlKCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60025C43399;
	Sun, 24 Mar 2024 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321814;
	bh=Zkv4uBQK8eMbRPj/TMoLQKTy5qtiJb0tBI+C77mgZrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J0WXlKCuzBgDPCA6cW2mgzIsjM7Zej4ZgfETyjzVmEHhZXFWbKtEFi+IGTNNZU/jq
	 q//UXN87qmX5FuHnhb98l1gSjsj/j6krAD6vaoPBwVJ5V3c18TRckQYYTDgzwzuLqz
	 83Tfyb9x0FBMwMT0EHTQ8wyujt6vRg0R+hsdA9Qta2j5Q01jcKyNW/hQMxVffIB1ia
	 d30Xv4o4vmpSE12Re9DAFTDh5qMTfxhul0EsATZNWcR2fWZQ2yNjn57Ks47TuOUN36
	 HOupNXHvrrCvEhpVRhQ1/1Q3nBWVu+ndi97qkvZReaCjFX7jEbn8RVECV8j8kYFyAH
	 AYwJ8xn24TVpw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 542/638] NFS: Fix an off by one in root_nfs_cat()
Date: Sun, 24 Mar 2024 18:59:39 -0400
Message-ID: <20240324230116.1348576-543-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 698ad1a538da0b6bf969cfee630b4e3a026afb87 ]

The intent is to check if 'dest' is truncated or not. So, >= should be
used instead of >, because strlcat() returns the length of 'dest' and 'src'
excluding the trailing NULL.

Fixes: 56463e50d1fc ("NFS: Use super.c for NFSROOT mount option parsing")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfsroot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
index 7600100ba26f0..432612d224374 100644
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
2.43.0


