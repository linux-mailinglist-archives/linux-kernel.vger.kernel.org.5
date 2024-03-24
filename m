Return-Path: <linux-kernel+bounces-114499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4034A889032
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B6A1C2BDFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147EF28A594;
	Sun, 24 Mar 2024 23:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpIMBjvY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E9157A65;
	Sun, 24 Mar 2024 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321947; cv=none; b=dACzO7GhmkkvQdNUYbw3QG5qgheT7O70UsWYIfVILLUkrP0T8bfz0aVFTk3XF806YIV1GvKnqqqbUyB16bG8GFMG1btFFJW4SuGcQrXrS3PxgASVsA9mwiXmIf9paMa6jgC2IdG3O1Z5Ftxv+e49RxxSxM/mClEBoJshK71M78E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321947; c=relaxed/simple;
	bh=a0if71l1FNllGDMmeoMnyoNpzH9AzjuGJnJySfgegms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSVMFQPNgcp+vYR740M7HR3AIn8gPfAXdbDymVqApEwQk4ix3RIATAD+yUWD2RgoEHIqYtcUm6b/SnwMyNEV51v8ilnkDePrcnF51f0b9FwiR616zFZSfVck62YNEcLbaAh92pF7YigHIXdfsGM0jlI0PMp00XqzYHJ4zOLINsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpIMBjvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A8CC433C7;
	Sun, 24 Mar 2024 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321946;
	bh=a0if71l1FNllGDMmeoMnyoNpzH9AzjuGJnJySfgegms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PpIMBjvYrR8vlNW2MOGrj34Sf6KZjGmgBdNbI+ltMYusX1yEc7jbC9MrYxP6Q5HzR
	 YwHBCTdnX8tqfIVGTnJ51cUImHBKRZvX2LmpiaCk+YL6zjbNv4tW6ZYnn+zMAwZtJD
	 1Y47yHlsOGhzpR5UUmg24gDiUdr3hACGwTNfuB4iPBZNU6gLdXUDowUs9+y8xHhkPx
	 /xcUTm5Geb7KTlJemnzXjIM5zDirg+Wmr/gaMkKmBx+w5LApXeLkGiFDtkuRWLIwrj
	 7OxAM/3mu6o0+X4jE8/CJRys7u4f4XMw5PMm+IzXOLV8xYfvfh23oFnOc+WOAIz7DH
	 XSFeUiCryaBvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tavian Barnes <tavianator@tavianator.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 018/451] nfsd: Fix creation time serialization order
Date: Sun, 24 Mar 2024 19:04:54 -0400
Message-ID: <20240324231207.1351418-19-sashal@kernel.org>
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

From: Tavian Barnes <tavianator@tavianator.com>

In nfsd4_encode_fattr(), TIME_CREATE was being written out after all
other times.  However, they should be written out in an order that
matches the bit flags in bmval1, which in this case are

    #define FATTR4_WORD1_TIME_ACCESS        (1UL << 15)
    #define FATTR4_WORD1_TIME_CREATE        (1UL << 18)
    #define FATTR4_WORD1_TIME_DELTA         (1UL << 19)
    #define FATTR4_WORD1_TIME_METADATA      (1UL << 20)
    #define FATTR4_WORD1_TIME_MODIFY        (1UL << 21)

so TIME_CREATE should come second.

I noticed this on a FreeBSD NFSv4.2 client, which supports creation
times.  On this client, file times were weirdly permuted.  With this
patch applied on the server, times looked normal on the client.

Fixes: e377a3e698fb ("nfsd: Add support for the birth time attribute")
Link: https://unix.stackexchange.com/q/749605/56202
Signed-off-by: Tavian Barnes <tavianator@tavianator.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 514f4456cf5c6..4ed9fef14adc2 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3364,6 +3364,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		if (status)
 			goto out;
 	}
+	if (bmval1 & FATTR4_WORD1_TIME_CREATE) {
+		status = nfsd4_encode_nfstime4(xdr, &stat.btime);
+		if (status)
+			goto out;
+	}
 	if (bmval1 & FATTR4_WORD1_TIME_DELTA) {
 		p = xdr_reserve_space(xdr, 12);
 		if (!p)
@@ -3380,11 +3385,6 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		if (status)
 			goto out;
 	}
-	if (bmval1 & FATTR4_WORD1_TIME_CREATE) {
-		status = nfsd4_encode_nfstime4(xdr, &stat.btime);
-		if (status)
-			goto out;
-	}
 	if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
 		u64 ino = stat.ino;
 
-- 
2.43.0


