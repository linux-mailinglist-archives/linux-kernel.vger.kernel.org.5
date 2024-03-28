Return-Path: <linux-kernel+bounces-123073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B51A48901CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EE91F24CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6B512EBCA;
	Thu, 28 Mar 2024 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6rPZGLf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C39912D77B;
	Thu, 28 Mar 2024 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636290; cv=none; b=SHlVZSnNDHv4t8Y7Qy/Dn6fnrXuWwc7+VvzhllHQ8OJrgNYVx4phCyuP644iDuWto64Nq2NU54yZyC3bO91tQ6y7XqmPVvRQvol8xH0smk8Z1W2eGmoBixaKDU4OaSqxhu1NUB4lahhMx5P4YeYNXMO19ivjmxAe4HzP0EWWggY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636290; c=relaxed/simple;
	bh=CLKmSwfWJ51R7yRH9H4Z02ae07/lsbxBLTkdp9cvOH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NV6FqXfv7be4XkFVHyDPcZKorlDvkb6Jm74KCAb0jM/UFQCDh44p2Z9/1plwbPi3tPcCd7/osYwZl7iakv1gek7Z8jBSYI5JzMA8hATp/8E8T2C2Gd2vgC7NDarC73VBKLl/B102P6PVdsrFV1ZFe/dSLwavtoAoY28mXelMENo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6rPZGLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7265C433F1;
	Thu, 28 Mar 2024 14:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636289;
	bh=CLKmSwfWJ51R7yRH9H4Z02ae07/lsbxBLTkdp9cvOH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6rPZGLfjJ85hVRL9zvH78xHWI71xn2Fvzu/M5q0+HDEkrd6TQ/WnLodC2ogsLTvr
	 sB+1VLU0PVi30PcYICt9g8mTpwOMIDnovxTMxNzgc0eyT/e924ZhQ9TUMmE+BmyMdS
	 Et8bKBZWJ2FTljWdJZ3OH90jTqoDxKWp6NVsDt8xZ5mpFYCJFXWCRSPoG5QUOWJZuu
	 KpwIfSk1FzjWLZacCXDuyX7jJuyJqU31+/HZEs0shtldrC56E5tOQI5oTRs4RyXRHU
	 2zkvnh6eg1KMYnPyAs6+3p3rTSy9AsqD/VRw+TEMXlc+oqz4tIiOfkfeaOjp6fL+gd
	 Q9E045wcHMrww==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jeff Layton <jlayton@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Milind Changire <mchangir@redhat.com>,
	Patrick Donnelly <pdonnell@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	ceph-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 2/9] libceph: avoid clang out-of-range warning
Date: Thu, 28 Mar 2024 15:30:40 +0100
Message-Id: <20240328143051.1069575-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328143051.1069575-1-arnd@kernel.org>
References: <20240328143051.1069575-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-14 points out that on 64-bit architectures, a u32
is never larger than constant based on SIZE_MAX:

net/ceph/osdmap.c:1425:10: error: result of comparison of constant 4611686018427387891 with expression of type 'u32' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
        if (len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
            ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
net/ceph/osdmap.c:1608:10: error: result of comparison of constant 2305843009213693945 with expression of type 'u32' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
        if (len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
            ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The code is correct anyway, so just shut up that warning.

Fixes: 6f428df47dae ("libceph: pg_upmap[_items] infrastructure")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ceph/snap.c    | 2 +-
 net/ceph/osdmap.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index c65f2b202b2b..521507ea8260 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -374,7 +374,7 @@ static int build_snap_context(struct ceph_mds_client *mdsc,
 
 	/* alloc new snap context */
 	err = -ENOMEM;
-	if (num > (SIZE_MAX - sizeof(*snapc)) / sizeof(u64))
+	if ((size_t)num > (SIZE_MAX - sizeof(*snapc)) / sizeof(u64))
 		goto fail;
 	snapc = ceph_create_snap_context(num, GFP_NOFS);
 	if (!snapc)
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 295098873861..8e7cb2fde6f1 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1438,7 +1438,7 @@ static struct ceph_pg_mapping *__decode_pg_temp(void **p, void *end,
 	ceph_decode_32_safe(p, end, len, e_inval);
 	if (len == 0 && incremental)
 		return NULL;	/* new_pg_temp: [] to remove */
-	if (len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
+	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
 		return ERR_PTR(-EINVAL);
 
 	ceph_decode_need(p, end, len * sizeof(u32), e_inval);
@@ -1621,7 +1621,7 @@ static struct ceph_pg_mapping *__decode_pg_upmap_items(void **p, void *end,
 	u32 len, i;
 
 	ceph_decode_32_safe(p, end, len, e_inval);
-	if (len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
+	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
 		return ERR_PTR(-EINVAL);
 
 	ceph_decode_need(p, end, 2 * len * sizeof(u32), e_inval);
-- 
2.39.2


