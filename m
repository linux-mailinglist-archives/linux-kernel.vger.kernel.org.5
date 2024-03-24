Return-Path: <linux-kernel+bounces-116095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CC588993F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CA11C3256A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118D33A763D;
	Mon, 25 Mar 2024 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOLc41Is"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F2C13C693;
	Sun, 24 Mar 2024 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323564; cv=none; b=PmwhuCyptQsv73cvvcXdqTemzjt/wup2mI5NJbfDrSlErj4Z6KzJcRS3jzRIeBdCqr8HaCzbM3fBevPbMRHZuIdelGNFOdws22G296fie/yvGLJ6T95g9HOwutXEdNVXkKRRz4Ss630LzCzCGV/NPhtDXPfO/YHaxOStGnMVL8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323564; c=relaxed/simple;
	bh=Roie6MsJdNvp73cKniu3QDUBbywUVPcSI2K9N8bQLTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHkQO+kxrO0Y3SsQyoB7/xO+aumpYT6zm9zS9eiRtQkGU0RqL1elGc3mZ+b+VdnYnVtp1Ch0jmLnpDkT0LKGsY2NNrJmAqKgl9BlC1ziBIwBTvSr8QvXShQYkIdCX7OxiUXtJUv6aKlSP4URve31/Ewj0dDIOSWKHpninhmCMA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOLc41Is; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD5EC433F1;
	Sun, 24 Mar 2024 23:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323564;
	bh=Roie6MsJdNvp73cKniu3QDUBbywUVPcSI2K9N8bQLTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sOLc41IsPszOiRRjheGm/ii9McJAXwiwsg8QPVDUXMBd4Oijd0j6+XU3JSQgvgAcb
	 Wb/PJHZwJaWnaBAS4FrWlP84iQ2udj4w8LD1CglfZn1xCq1PhMvkoepVZxXxL7oiob
	 Z/EykgStK2BV6IuZcAsE/ZupWKenu1nWAVw14b+qYMJy5LpfEARSrWqvTk7x0DgWnj
	 Bzjl05/PGFGLC+evhcCRthyZx6V0P+tvG0/qNufLyllvwkbAX5/zVN0vRZasTen1lW
	 AGR7iNT+Td/qhaxEqthbIKoYEmSG4pp4ZgqzE3Lt4INAMfuLJGXRqna1CZ7fpZe1/J
	 GOvMsYVywwgTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 271/317] NFS: Fix an off by one in root_nfs_cat()
Date: Sun, 24 Mar 2024 19:34:11 -0400
Message-ID: <20240324233458.1352854-272-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index fa148308822cc..c2cf4ff628811 100644
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


