Return-Path: <linux-kernel+bounces-62672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF4585243A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8221C237E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A2F64AB6;
	Tue, 13 Feb 2024 00:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCBAK0E2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D7463CB4;
	Tue, 13 Feb 2024 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783716; cv=none; b=FiN3GURxvx+ErDcxbLOPwoqrnuC6lptN0JGI+9X9W0XpbULoJufPST3e7DxyrMIfAMEPR15dJnJwaeH/N1qW0zazF25GoxzW8Fve5a1dS8Un7ukQ4xOiN3SFdIxkiVvnGI+m0bB8Qg8P3OzJNG9C2aVBF2zmFfBCiVpgY+rakOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783716; c=relaxed/simple;
	bh=k89xFbyGwJEbzgkK7f8r2lTSUKobgTo9d5zHFqwHJ7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/lMrZg9JhFryUt2SYLSQgJfwgRqJIdQgbSGAp1yV9Qw6m2WIsLF+3UO8XBF37/PtnJWJpQCNxUAxucMUIk/EG+E6CrHO218ShFmU3GwnNVmwfcxLRy2106MqEpiY+wRMUKdfFne0D5AZMMfGIXU7BMxo11ORDBDHL0whHOxVpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCBAK0E2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF52C433C7;
	Tue, 13 Feb 2024 00:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783716;
	bh=k89xFbyGwJEbzgkK7f8r2lTSUKobgTo9d5zHFqwHJ7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VCBAK0E2uPibjCGm93cnhx9ce1rH5qOzHV0tHAyWABVkqbJTI3I3ldGn67qAIsy6U
	 mSb0t89bn1f85XcGb1L1cj3fSlihg2FXdSTnQckQdamsqgwWMG+JFtjzKRi2R2RT+C
	 6a9hSyjpb4phJWiORbnodXXxH40/n093cIv+edwoXUvahu6EX5jMFmjtTKe7k/UMAo
	 pUh3+ySaCQfewQnozGUpVIxltk2/ysWH5JiSWXsg5JgCIKQT/var5cNZfrFtrOUj6e
	 AP1scrGUiaeOfNlqgh84qgm+2Uyj6Mm+3GnRZTi993bIucWNHo88fWSLxSwYu9mJFQ
	 Z3D4OC+kkjLAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ceph-devel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 41/51] libceph: fail sparse-read if the data length doesn't match
Date: Mon, 12 Feb 2024 19:20:18 -0500
Message-ID: <20240213002052.670571-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit cd7d469c25704d414d71bf3644f163fb74e7996b ]

Once this happens that means there have bugs.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ceph/osd_client.h |  3 ++-
 net/ceph/osd_client.c           | 18 +++++++++++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index bf9823956758..f703fb8030de 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -45,6 +45,7 @@ enum ceph_sparse_read_state {
 	CEPH_SPARSE_READ_HDR	= 0,
 	CEPH_SPARSE_READ_EXTENTS,
 	CEPH_SPARSE_READ_DATA_LEN,
+	CEPH_SPARSE_READ_DATA_PRE,
 	CEPH_SPARSE_READ_DATA,
 };
 
@@ -64,7 +65,7 @@ struct ceph_sparse_read {
 	u64				sr_req_len;  /* orig request length */
 	u64				sr_pos;      /* current pos in buffer */
 	int				sr_index;    /* current extent index */
-	__le32				sr_datalen;  /* length of actual data */
+	u32				sr_datalen;  /* length of actual data */
 	u32				sr_count;    /* extent count in reply */
 	int				sr_ext_len;  /* length of extent array */
 	struct ceph_sparse_extent	*sr_extent;  /* extent array */
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index d3a759e052c8..a2abfda17a24 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5859,8 +5859,8 @@ static int osd_sparse_read(struct ceph_connection *con,
 	struct ceph_osd *o = con->private;
 	struct ceph_sparse_read *sr = &o->o_sparse_read;
 	u32 count = sr->sr_count;
-	u64 eoff, elen;
-	int ret;
+	u64 eoff, elen, len = 0;
+	int i, ret;
 
 	switch (sr->sr_state) {
 	case CEPH_SPARSE_READ_HDR:
@@ -5912,8 +5912,20 @@ static int osd_sparse_read(struct ceph_connection *con,
 		convert_extent_map(sr);
 		ret = sizeof(sr->sr_datalen);
 		*pbuf = (char *)&sr->sr_datalen;
-		sr->sr_state = CEPH_SPARSE_READ_DATA;
+		sr->sr_state = CEPH_SPARSE_READ_DATA_PRE;
 		break;
+	case CEPH_SPARSE_READ_DATA_PRE:
+		/* Convert sr_datalen to host-endian */
+		sr->sr_datalen = le32_to_cpu((__force __le32)sr->sr_datalen);
+		for (i = 0; i < count; i++)
+			len += sr->sr_extent[i].len;
+		if (sr->sr_datalen != len) {
+			pr_warn_ratelimited("data len %u != extent len %llu\n",
+					    sr->sr_datalen, len);
+			return -EREMOTEIO;
+		}
+		sr->sr_state = CEPH_SPARSE_READ_DATA;
+		fallthrough;
 	case CEPH_SPARSE_READ_DATA:
 		if (sr->sr_index >= count) {
 			sr->sr_state = CEPH_SPARSE_READ_HDR;
-- 
2.43.0


