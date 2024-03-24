Return-Path: <linux-kernel+bounces-115749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235B088949C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0426294BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C34052F99;
	Mon, 25 Mar 2024 02:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSOLcnTy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDD52251F2;
	Sun, 24 Mar 2024 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321937; cv=none; b=mOH9apUAtkh9zra06JsPGkNP982XigEd1h0TtSKCzt0sYl/W8/dGBuEKKTOIHaSu/lhRrWyHyBYJ3Cet46tNAdUwF0//K6Qlyx+6Jw6CTev2E9zCsax1NVR2WA3csAJCFIQFJlrJdRh8hBBVzqN5mMHTPg3AWaP/QnOzh7+PXaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321937; c=relaxed/simple;
	bh=XT1yZ8Jye37Pt1dNEFHUCS6lEDPqswFnIVZBkfvzm7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oieUowT/xzbozSS9SI+Z9f2F93VRgawropQjz/2FecixBPO92HJqnhcrXpf8xLxHDpdaovxNZFUoeRA7cks7gJh5Svf9C06A+U5mZ5O0yjTgCzyM1K7U4FtFI1lLx9xsrqkbPYD36stQ5YFiyAXW4sIBhvxovNikC+mH8X/5fHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSOLcnTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E46C433F1;
	Sun, 24 Mar 2024 23:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321937;
	bh=XT1yZ8Jye37Pt1dNEFHUCS6lEDPqswFnIVZBkfvzm7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSOLcnTyl6Q525aTy5tGUBkjv0bZtq3qL0dEGr/YwCodCNYHjYWAyem3xHssPh1x+
	 h6t+OT4sZS/M8MyRrZB6HZQNAh2V56VueogJsvQQSJpmDqviIk8P843VFwbiu/DyQ2
	 Ipj8I0LGLAQnx8/ChqbanCwbC6YgLkcKkdevgFBq76AexATvibeU70BpdW5MZlsZ7s
	 KUMz++13J/I5gNNX6MJNeGXMDrQ2sc80VTZYtHReKUALLSl7d3pVI7GD+2ZFeX446F
	 /jmsp0sIpVv/2Gv5nPJy/1cR0LNZd1VB26ym70pzmL1OLaPCN38ATlA7QB89Dnow7p
	 cBXYOfs8niVkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 008/451] nfsd: simplify test_bit return in NFSD_FILE_KEY_FULL comparator
Date: Sun, 24 Mar 2024 19:04:44 -0400
Message-ID: <20240324231207.1351418-9-sashal@kernel.org>
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

[ Upstream commit d69b8dbfd0866abc5ec84652cc1c10fc3d4d91ef ]

test_bit returns bool, so we can just compare the result of that to the
key->gc value without the "!!".

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index c36e3032d4386..568963b8a4777 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -189,7 +189,7 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
 			return 1;
 		if (!nfsd_match_cred(nf->nf_cred, key->cred))
 			return 1;
-		if (!!test_bit(NFSD_FILE_GC, &nf->nf_flags) != key->gc)
+		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) != key->gc)
 			return 1;
 		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) == 0)
 			return 1;
-- 
2.43.0


