Return-Path: <linux-kernel+bounces-26783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560FC82E625
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF591C227DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC3B5A106;
	Tue, 16 Jan 2024 00:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tk4FDrxQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199255A0F7;
	Tue, 16 Jan 2024 00:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE27FC43394;
	Tue, 16 Jan 2024 00:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364864;
	bh=kdhhXEJc9HdVp/h1emxwajwaH4zcDSobKJF9ZQkHgTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tk4FDrxQeeE5fNm9UVb7PTvnO7ZVpedBBCtDRuE86ynM1mSFA2wrtuhnMDmUwW55M
	 uJuLZl3tG8y7tWYdK60QnGk9mjFCMsf+uh3QODTwa44qAsYryh/p/dJYjfp8E/Jcfr
	 fzi9WMXrcunp1TMI4nFCKLySHSRTtcMOP5e68sIPOHXtR5eChvlgwlfXek6/rRgBHF
	 1PlobVJskfvSyaeKyNTsxZ7wpU8xde/CSte2PoOlmun/+OIgxGg8wAp3lvK8aFkR3Y
	 UZl28kTClqZsgrxoOJlggEWWhK/50sB1Rl0m51Xtx3BHJT6sd2DdP/l2rnsn6YxaKl
	 Vjwzk3gv4AGpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manas Ghandat <ghandatmanas@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	osmtendev@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.4 03/12] jfs: fix slab-out-of-bounds Read in dtSearch
Date: Mon, 15 Jan 2024 19:27:09 -0500
Message-ID: <20240116002731.216549-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002731.216549-1-sashal@kernel.org>
References: <20240116002731.216549-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Manas Ghandat <ghandatmanas@gmail.com>

[ Upstream commit fa5492ee89463a7590a1449358002ff7ef63529f ]

Currently while searching for current page in the sorted entry table
of the page there is a out of bound access. Added a bound check to fix
the error.

Dave:
Set return code to -EIO

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202310241724.Ed02yUz9-lkp@intel.com/
Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dtree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index a6d42e49d156..077a87e53020 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -633,6 +633,11 @@ int dtSearch(struct inode *ip, struct component_name * key, ino_t * data,
 		for (base = 0, lim = p->header.nextindex; lim; lim >>= 1) {
 			index = base + (lim >> 1);
 
+			if (stbl[index] < 0) {
+				rc = -EIO;
+				goto out;
+			}
+
 			if (p->header.flag & BT_LEAF) {
 				/* uppercase leaf name to compare */
 				cmp =
-- 
2.43.0


