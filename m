Return-Path: <linux-kernel+bounces-114500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35DB888ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81AB8B2EB6D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFB228A5B8;
	Sun, 24 Mar 2024 23:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUtpjHpM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C70157A70;
	Sun, 24 Mar 2024 23:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321948; cv=none; b=jcAAK/jgoWRcQpm7Lm0r8lvCKVO81f5qzChOy2ur5fx20qZDBC8uH/OGj1o2Lw4e0Qv0NP/A7FSO6bcUpswFQsDeCqDM2Iu+mf4ASOw95xCZK3SdtR0XwoVV6Jii5mnKEiv+iN0WJPomu+2yf+9MbYOtfgqeWvmqAnzFYzeQxrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321948; c=relaxed/simple;
	bh=xCRkXkxj939qhQga1OEIUAKaWDt7w7dJ1mcqA2JkAV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbceJeag/M8jXqGCH15pgzJt4aIkM1sroqxDLu6RKTJcJLN960Ehea84jJJO4KZdXh99+G0UgRqycUgqlOmJ79dzKe24oGsQj5Pc/V2kV9BJRcidTD/mv4BaGN8vy43o6i4P412quVCLisyKxKSof5txu7UQTBNFpVYJScqkA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUtpjHpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14070C433F1;
	Sun, 24 Mar 2024 23:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321945;
	bh=xCRkXkxj939qhQga1OEIUAKaWDt7w7dJ1mcqA2JkAV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUtpjHpMpDeGpNBtv8tPqbFHXIoV0SAPFym0US1J8hNbkS2ka/8Rz4ALp3srvkLH8
	 QjM+NalS5/v+QwMZRWBmobUJ27QLb9S8+zs64NiUZeKP4E6+tIDbe2ac+ED+IZme8I
	 EW0WJpWHOlhr7qu0q2odwRnyjSDK7o43D+zm8L7vfra+6OiewgI1Puw1WQF9jyc330
	 zzaPJfZIjziBxPN4irsCW9TdAvqORq2jMBOPfjBrw7K+rhBjBdTIXcq+9F3zcDJmSX
	 OqDOmAkXN+yH2AVIem1Jc/CCm7hsNe5XXaq5TxDPsGun2bU6BcSVBi0utn0BPW+e5h
	 gKqBK0LgNxjdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 017/451] NFSD: Add an nfsd4_encode_nfstime4() helper
Date: Sun, 24 Mar 2024 19:04:53 -0400
Message-ID: <20240324231207.1351418-18-sashal@kernel.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 262176798b18b12fd8ab84c94cfece0a6a652476 ]

Clean up: de-duplicate some common code.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 597f14a80512f..514f4456cf5c6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2541,6 +2541,20 @@ static __be32 *encode_change(__be32 *p, struct kstat *stat, struct inode *inode,
 	return p;
 }
 
+static __be32 nfsd4_encode_nfstime4(struct xdr_stream *xdr,
+				    struct timespec64 *tv)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT * 3);
+	if (!p)
+		return nfserr_resource;
+
+	p = xdr_encode_hyper(p, (s64)tv->tv_sec);
+	*p = cpu_to_be32(tv->tv_nsec);
+	return nfs_ok;
+}
+
 /*
  * ctime (in NFSv4, time_metadata) is not writeable, and the client
  * doesn't really care what resolution could theoretically be stored by
@@ -3346,11 +3360,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = xdr_encode_hyper(p, dummy64);
 	}
 	if (bmval1 & FATTR4_WORD1_TIME_ACCESS) {
-		p = xdr_reserve_space(xdr, 12);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, (s64)stat.atime.tv_sec);
-		*p++ = cpu_to_be32(stat.atime.tv_nsec);
+		status = nfsd4_encode_nfstime4(xdr, &stat.atime);
+		if (status)
+			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_TIME_DELTA) {
 		p = xdr_reserve_space(xdr, 12);
@@ -3359,25 +3371,19 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = encode_time_delta(p, d_inode(dentry));
 	}
 	if (bmval1 & FATTR4_WORD1_TIME_METADATA) {
-		p = xdr_reserve_space(xdr, 12);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, (s64)stat.ctime.tv_sec);
-		*p++ = cpu_to_be32(stat.ctime.tv_nsec);
+		status = nfsd4_encode_nfstime4(xdr, &stat.ctime);
+		if (status)
+			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_TIME_MODIFY) {
-		p = xdr_reserve_space(xdr, 12);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, (s64)stat.mtime.tv_sec);
-		*p++ = cpu_to_be32(stat.mtime.tv_nsec);
+		status = nfsd4_encode_nfstime4(xdr, &stat.mtime);
+		if (status)
+			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_TIME_CREATE) {
-		p = xdr_reserve_space(xdr, 12);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, (s64)stat.btime.tv_sec);
-		*p++ = cpu_to_be32(stat.btime.tv_nsec);
+		status = nfsd4_encode_nfstime4(xdr, &stat.btime);
+		if (status)
+			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
 		u64 ino = stat.ino;
-- 
2.43.0


