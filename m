Return-Path: <linux-kernel+bounces-114494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1FE88902E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD431C2B975
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCC92892D4;
	Sun, 24 Mar 2024 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHdsgDvk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297A6225219;
	Sun, 24 Mar 2024 23:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321941; cv=none; b=lWav+pCX+36Wabd8NGaVfo4aeUU8JbCPzapTvNyC5zB26h7spNtAvFmZj1YfifOuwGDJzDSw4hlmgvlmwVd7wRfmBXpjAdMxHs+NyERnssK4wadVajF6FeaC1LRb8Pfyd+Ts3KodtaSlHZcqZKVJCaSNEMN/7EKtQj/zhfDWTSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321941; c=relaxed/simple;
	bh=QojNL+Cb9RditocGthFN/Ct6+fVG+hVShAGwJAb8Xxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2TmIAaw0EdTt9/ddQKhd7ooC/KyegKT5p2mRC2SOQAtVwkyrWtiIqkWuYymJ3qo1eYwaHfRU7udyi9lVMZu/l6iBJuCn8V+XRCx0GDX0x0ZSovmqoxLvkWV354EySRJPk+F0X2xNVBnRn5ja7Sb0lUt/tvhYkQ7dqm7CiXAbYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHdsgDvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6590DC43399;
	Sun, 24 Mar 2024 23:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321940;
	bh=QojNL+Cb9RditocGthFN/Ct6+fVG+hVShAGwJAb8Xxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XHdsgDvkGy0+I1RuocdNrYvbS/KbygKFD/HQP9yVMTW2aQ9np3piVh/ejZJRNAcnV
	 cqTrOgh9JMPJavXilP8HdddEHJPXVbLI2Q97OWM2WijvjajXWt2JoIodKwC2cd0kJp
	 0HaIdDwZdcfnnmi++zmXIyGSIuFGW8QIm0rsoX1eXeEBLffTSH8MvYBqlAP21tbqfw
	 P2sM8llO+5Vd95da+glMMTJRW1tqEo7S44we2hr1duJFi2JnQ7m+VkPaQAK9B/n/gu
	 Te2Yc7kTxVpGEcs60sonmZai1LMwsKqqzJWi3Cjt3Zed9oBtDUm7DWna4a1FP0nuVu
	 lQnk63e1Y0B5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 011/451] nfsd: don't take/put an extra reference when putting a file
Date: Sun, 24 Mar 2024 19:04:47 -0400
Message-ID: <20240324231207.1351418-12-sashal@kernel.org>
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

[ Upstream commit b2ff1bd71db2a1b193a6dde0845adcd69cbcf75e ]

The last thing that filp_close does is an fput, so don't bother taking
and putting the extra reference.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 50349449a4e52..51e2947c21a7d 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -382,10 +382,8 @@ nfsd_file_free(struct nfsd_file *nf)
 	if (nf->nf_mark)
 		nfsd_file_mark_put(nf->nf_mark);
 	if (nf->nf_file) {
-		get_file(nf->nf_file);
-		filp_close(nf->nf_file, NULL);
 		nfsd_file_check_write_error(nf);
-		fput(nf->nf_file);
+		filp_close(nf->nf_file, NULL);
 	}
 
 	/*
-- 
2.43.0


