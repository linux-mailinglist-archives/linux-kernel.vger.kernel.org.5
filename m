Return-Path: <linux-kernel+bounces-113493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124D08884BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D061C240E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC531B8857;
	Sun, 24 Mar 2024 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou+6Blfx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028751B883F;
	Sun, 24 Mar 2024 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320295; cv=none; b=SMlWUM7Wy5JXicSAH2vLalk8vQaub9otMxegu/nkcu7w3iv2FWLdiAuhEbP2N1fQCBwqF2G3R20SKPv//TQqNrDnjFmgx/WKBTpK/ncIK+TLWglDeIFOiuUv5DjOMVNWt+WLU3Sp1vHTeNVTNf219zn/AUlgDsY9lhVg7nLS2Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320295; c=relaxed/simple;
	bh=zQy2LVIN8f5XRjnza0GCXEGiZpgSzImzkALKV8OtVyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaZUSrjVbZ+aedVwVI11GeKJdopEpzCPIDZTlz61WxdgUs+gB0IlB6l31/A63oCeojJk0YtdLYwzfDxuUZYK06Qpd7NHFD6x1KkOEcbzp1X39WtnJtraamvReS97VgkajIEze7vNlYh+SGcAhKPr9m+EJcItrDZtPjfQ3wKabsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou+6Blfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06680C43390;
	Sun, 24 Mar 2024 22:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320294;
	bh=zQy2LVIN8f5XRjnza0GCXEGiZpgSzImzkALKV8OtVyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ou+6BlfxWYxfgVdCrfJn5blJOvqDdSaszVZ8GN6yOO0Q5VqL3+OuuVRHej+AxuTtQ
	 PlOxZvSZt+TG1pphsUY9ZqsyV0nKP59MpaOx88UYvPOBKEipXWO/jc59Oi76Y2uke1
	 B4ViRc7x134oo3184xtCrkFHgtMZQ1GvNewdtmVYb1/mNgqXTijx2faxU07T4Bqw8h
	 kS3hc8vzmUWeQYl/9t8TPUDnLtk7og+ZauXzwyUJd+uNy8SzO1Fpudwc0IzqKbOtRY
	 6Y2UaZXSiUOUYZu5W4M1oTp3Y6cFYfP272DMSDlDqV5v5Y4ep5+tPS1bU9z0pBxj0f
	 l/oOGfeGIOu8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 602/715] afs: Don't cache preferred address
Date: Sun, 24 Mar 2024 18:33:01 -0400
Message-ID: <20240324223455.1342824-603-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 83505bde45e347f1451d007b3ddd7f06cee4c269 ]

In the AFS fileserver rotation algorithm, don't cache the preferred address
for the server as that will override the explicit preference if a
non-preferred address responds first.

Fixes: 495f2ae9e355 ("afs: Fix fileserver rotation")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20240313081505.3060173-2-dhowells@redhat.com
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/rotate.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 700a27bc8c257..ed04bd1eeae89 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -602,6 +602,8 @@ bool afs_select_fileserver(struct afs_operation *op)
 		goto wait_for_more_probe_results;
 
 	alist = op->estate->addresses;
+	best_prio = -1;
+	addr_index = 0;
 	for (i = 0; i < alist->nr_addrs; i++) {
 		if (alist->addrs[i].prio > best_prio) {
 			addr_index = i;
@@ -609,9 +611,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 		}
 	}
 
-	addr_index = READ_ONCE(alist->preferred);
-	if (!test_bit(addr_index, &set))
-		addr_index = __ffs(set);
+	alist->preferred = addr_index;
 
 	op->addr_index = addr_index;
 	set_bit(addr_index, &op->addr_tried);
@@ -656,12 +656,6 @@ bool afs_select_fileserver(struct afs_operation *op)
 next_server:
 	trace_afs_rotate(op, afs_rotate_trace_next_server, 0);
 	_debug("next");
-	ASSERT(op->estate);
-	alist = op->estate->addresses;
-	if (op->call_responded &&
-	    op->addr_index != READ_ONCE(alist->preferred) &&
-	    test_bit(alist->preferred, &op->addr_tried))
-		WRITE_ONCE(alist->preferred, op->addr_index);
 	op->estate = NULL;
 	goto pick_server;
 
@@ -690,14 +684,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 failed:
 	trace_afs_rotate(op, afs_rotate_trace_failed, 0);
 	op->flags |= AFS_OPERATION_STOP;
-	if (op->estate) {
-		alist = op->estate->addresses;
-		if (op->call_responded &&
-		    op->addr_index != READ_ONCE(alist->preferred) &&
-		    test_bit(alist->preferred, &op->addr_tried))
-			WRITE_ONCE(alist->preferred, op->addr_index);
-		op->estate = NULL;
-	}
+	op->estate = NULL;
 	_leave(" = f [failed %d]", afs_op_error(op));
 	return false;
 }
-- 
2.43.0


