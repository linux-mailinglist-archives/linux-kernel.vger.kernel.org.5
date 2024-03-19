Return-Path: <linux-kernel+bounces-107609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A804387FF15
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32E01C22392
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ADC81722;
	Tue, 19 Mar 2024 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBg2Lxga"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59B75A4CF;
	Tue, 19 Mar 2024 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710856253; cv=none; b=bCRVbXGkjWNwfza+gkXoBvfSVGde79RtcYsISMlPv38/mFqt9/G62fFa0xgeZRZxmtneEkJY7Qy1/1FVR0yrcd0BQ77cftDuspel6nLs/FIzi2mV7ZstwCRh5WolQN2XTgSghLeOMcOCukmhGMRd8M0oWqh0TIJwjI5VCYwMn40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710856253; c=relaxed/simple;
	bh=RMD2TqeN8sIrMbrfSJeIajNKs9E7CG3wfOneEMWdgrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mU+xZz/Us1HkhGB2JdGcG3FswO70uyZ5/ZNlhFxQbyWr9D2BD8fYlYzqpNJf2KrcdVDVe9cmCnrh3Sr9Ngh6P7e5u00vlaRhLfaLhNqtp+DV1VrlwhNUBUYSQd0AKNEgJa3+HlFcJ2U/l6yMqOFi9BXI5KK46IbR1flr/QY4fr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBg2Lxga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C405BC433C7;
	Tue, 19 Mar 2024 13:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710856253;
	bh=RMD2TqeN8sIrMbrfSJeIajNKs9E7CG3wfOneEMWdgrc=;
	h=From:Date:Subject:To:Cc:From;
	b=CBg2LxgasrRtebq44WV3KNB+YfPww8Q1gDbkafeYtTEarPfEXUgJXAGiSj9xMRQFO
	 KA2wvX5B8ajnLM7Ft/KHzTdDxkAKiqBHIMBxKaDnHcpBwY7WcjAEzPs28aJBpv+vI9
	 acFzJKZoENB4NF3cDJZxsruVrp72xW64oxZdLRaKmoSeAAvVEwwFbpYlZxdfgZb5Xn
	 0ZndJ37zUEMGc3kNDz7La+Cie+xfTd6hkPvGwftrYvT6riyEBFqLbYcVuLQxlG01/8
	 C6QQE9DjcH49VL3I/CjD+79+R6KrooAWHvsdGjtMRdimEAH7+NPJoZOnXbtzKaJ0k2
	 h5N8SWOam6u7g==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Tue, 19 Mar 2024 13:50:32 +0000
Subject: [PATCH] fs/9p: fix uninitialized values during inode evict
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-fix-evict-uninitialized-value-v1-1-cfc35424a171@kernel.org>
X-B4-Tracking: v=1; b=H4sIACeY+WUC/x2MwQqDMBAFf0X23IUkBkr8ldLDotv2gcSSqIjiv
 7t4HJiZg6oWaKWuOajoioopG/hHQ/1P8lcZgzEFF6JrfeIPNjavn3nJyJghI3YdeJVxUZanROd
 jCj4lsse/qAX3//U+zwsOFrbjbwAAAA==
To: Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com, 
 Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2017; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=RMD2TqeN8sIrMbrfSJeIajNKs9E7CG3wfOneEMWdgrc=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBl+Zg8EaKoJxkoNOdZQwjUAUlF2ousaxjANM5Ju
 54AJp7fVd6JAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZfmYPAAKCRCI/9X7Sl//
 mJ3gEACjuK5YGANuJRru6zub/UowgSYVonrxakqBCFrzGsv0Kq3OrVsYabdgczL6qApxF8BOTmD
 7yE/1SRzuBoDvR43vDlhlEyBNFAqbTEwMculhdhOpLS3FLVcmtLQgNu0sJzdpVeXuvsyBS2A/DP
 kcVfpm7ZfWi5nrVh4rkdwqUafMcFJvPGShXQNJ3StnIHn6Tj9UspFF1LBo7nk7jLY/qhUDLFPx2
 NeybP8WsyDct/VGIynkLiEt84r1Rb40TBajlntxP9RgtFpTp4jwlpC/6izJnnoEylrWkmq+FjHD
 ygNQsPBfrCCC8SyxSxOcJ8BIOF4bAvEQHZMSuFYuZ16beKaEd/DO43789OBp0XziPCfvFq+usGq
 iuz3srXvdkkld/3ec7Uan2rjGydCzQHg+JI1DIDdrEeZnErZMliuY7sO/ikqbbNRmzbhlHfM/EI
 7MuDlz/hqBUeLsG3D8gSnOTGrCqgA9SXsBDtgY7srXXTqU3Y4SPOGHgYWJr/Q4/oiuDbuBTlr+c
 35Nq3HmnfFpv0L8pZGHK38A1VDfR55xyvinq1L+255ZEVHAUg+D54TjsriXe2dZ31ZIQ4FAl5lo
 nMo+ZoQ7YJuyFM0Wl3vptvR60jPjX3PUhx5RIysrGWOFwM8TW0tQGN+hOb2NlYTN5MIGONplWMf
 CCcnKg4x0QGl1ug==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

If an iget fails due to not being able to retrieve information
from the server then the inode structure is only partially
initialized.  When the inode gets evicted, references to
uninitialized structures (like fscache cookies) were being
made.

This patch checks for a bad_inode before doing anything other
than clearing the inode from the cache.  Since the inode is
bad, it shouldn't have any state associated with it that needs
to be written back (and there really isn't a way to complete
those anyways).

Reported-by: syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_inode.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 360a5304ec03..b01b1bbf2493 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -344,17 +344,21 @@ void v9fs_evict_inode(struct inode *inode)
 	struct v9fs_inode __maybe_unused *v9inode = V9FS_I(inode);
 	__le32 __maybe_unused version;
 
-	truncate_inode_pages_final(&inode->i_data);
+	if (!is_bad_inode(inode)) {
+		truncate_inode_pages_final(&inode->i_data);
 
-	version = cpu_to_le32(v9inode->qid.version);
-	netfs_clear_inode_writeback(inode, &version);
+		version = cpu_to_le32(v9inode->qid.version);
+		netfs_clear_inode_writeback(inode, &version);
 
-	clear_inode(inode);
-	filemap_fdatawrite(&inode->i_data);
+		clear_inode(inode);
+		filemap_fdatawrite(&inode->i_data);
 
 #ifdef CONFIG_9P_FSCACHE
-	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
+		if (v9fs_inode_cookie(v9inode))
+			fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
 #endif
+	} else
+		clear_inode(inode);
 }
 
 struct inode *v9fs_fid_iget(struct super_block *sb, struct p9_fid *fid)

---
base-commit: acade3ac5c19d3e1a6e4934ab250b192dc787675
change-id: 20240319-fix-evict-uninitialized-value-a7a401492199

Best regards,
-- 
Eric Van Hensbergen <ericvh@kernel.org>


