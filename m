Return-Path: <linux-kernel+bounces-101869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E6587AC4C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8911F28E94
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9488460DC9;
	Wed, 13 Mar 2024 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML1mL0Hw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44F160BBF;
	Wed, 13 Mar 2024 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348001; cv=none; b=jMsRW0DvDrOsu9Y7fQsOEc5/L9Kbtj+OZMIZ/FHGDW/z5gQ0VOV51UQsaa7BGSVB8QxnaBpcnu4f8fm+RysbM3n3auk9Gyfh+be1l2wGBw62DXEeKYTFABz0Y8tNzBtjQ17X6sfP3pFRnOnCVrLdyzo+m6kxHJGD3VQ+d5a7eoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348001; c=relaxed/simple;
	bh=fetMmWKyXFJtuI4glze4+8J8cGiST54vLEbHQH2dG/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/2xQxWkri3on6aPuH/DnHX18sPBsSNTm4/Osm6sUHzjQb8/pYkUGpz6lv0JQj991YYeLwG2iSTGrfPjVSPq5D0Dp9owA+jKme/SDRqtUJoJh5eLx+YcnYP9oHmbg711WiQRH79wUN558cNsxR4V4mrkupoPZN1IqkCYeZUIeq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML1mL0Hw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1459C433C7;
	Wed, 13 Mar 2024 16:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348001;
	bh=fetMmWKyXFJtuI4glze4+8J8cGiST54vLEbHQH2dG/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ML1mL0HwFbqKNr1PPhBY5JqSw94yPHjsXT9IfxbWksgaDMgVrQxzq9HwbeBTlK73q
	 SQKZMe77VU39NWh9h89X38bKsn2Szyd2CQ1R0wphIe4Q/71p/9Tcbu+G8XqMIivmMr
	 ekhIHGIuzy/D3DHHFWqVpDhppC2BJHsqwz5J7N1537nFMhKQJkB0pejOrKaHo7YeKK
	 w5sDuSyO4Ahkvv38ARHWlj9mWtoV3itYJtANk4nFYwQ6Am8G/LJOPHVv4AAAZFmwcb
	 c61I3cf4WxnOXEHYZkI2qG4buH8P38G9U8mXbDktEer071O6PDsC8/OFad+dC2DQ/v
	 5wWr+YxNX0yYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Patrick Donnelly <pdonnell@ibm.com>,
	Venky Shankar <vshankar@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 01/71] ceph: switch to corrected encoding of max_xattr_size in mdsmap
Date: Wed, 13 Mar 2024 12:38:47 -0400
Message-ID: <20240313163957.615276-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 51d31149a88b5c5a8d2d33f06df93f6187a25b4c ]

The addition of bal_rank_mask with encoding version 17 was merged
into ceph.git in Oct 2022 and made it into v18.2.0 release normally.
A few months later, the much delayed addition of max_xattr_size got
merged, also with encoding version 17, placed before bal_rank_mask
in the encoding -- but it didn't make v18.2.0 release.

The way this ended up being resolved on the MDS side is that
bal_rank_mask will continue to be encoded in version 17 while
max_xattr_size is now encoded in version 18.  This does mean that
older kernels will misdecode version 17, but this is also true for
v18.2.0 and v18.2.1 clients in userspace.

The best we can do is backport this adjustment -- see ceph.git
commit 78abfeaff27fee343fb664db633de5b221699a73 for details.

[ idryomov: changelog ]

Cc: stable@vger.kernel.org
Link: https://tracker.ceph.com/issues/64440
Fixes: d93231a6bc8a ("ceph: prevent a client from exceeding the MDS maximum xattr size")
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Patrick Donnelly <pdonnell@ibm.com>
Reviewed-by: Venky Shankar <vshankar@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mdsmap.c            | 7 ++++---
 include/linux/ceph/mdsmap.h | 6 +++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 3fbabc98e1f70..4a089d70ebd07 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -379,10 +379,11 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end, bool msgr2)
 		ceph_decode_skip_8(p, end, bad_ext);
 		/* required_client_features */
 		ceph_decode_skip_set(p, end, 64, bad_ext);
+		/* bal_rank_mask */
+		ceph_decode_skip_string(p, end, bad_ext);
+	}
+	if (mdsmap_ev >= 18) {
 		ceph_decode_64_safe(p, end, m->m_max_xattr_size, bad_ext);
-	} else {
-		/* This forces the usage of the (sync) SETXATTR Op */
-		m->m_max_xattr_size = 0;
 	}
 bad_ext:
 	dout("mdsmap_decode m_enabled: %d, m_damaged: %d, m_num_laggy: %d\n",
diff --git a/include/linux/ceph/mdsmap.h b/include/linux/ceph/mdsmap.h
index 4c3e0648dc277..fcc95bff72a57 100644
--- a/include/linux/ceph/mdsmap.h
+++ b/include/linux/ceph/mdsmap.h
@@ -25,7 +25,11 @@ struct ceph_mdsmap {
 	u32 m_session_timeout;          /* seconds */
 	u32 m_session_autoclose;        /* seconds */
 	u64 m_max_file_size;
-	u64 m_max_xattr_size;		/* maximum size for xattrs blob */
+	/*
+	 * maximum size for xattrs blob.
+	 * Zeroed by default to force the usage of the (sync) SETXATTR Op.
+	 */
+	u64 m_max_xattr_size;
 	u32 m_max_mds;			/* expected up:active mds number */
 	u32 m_num_active_mds;		/* actual up:active mds number */
 	u32 possible_max_rank;		/* possible max rank index */
-- 
2.43.0


