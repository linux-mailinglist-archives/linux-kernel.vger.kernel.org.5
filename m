Return-Path: <linux-kernel+bounces-57194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A775F84D4F7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555D31F22952
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8774670F0;
	Wed,  7 Feb 2024 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdvbbZYO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C14179A2E;
	Wed,  7 Feb 2024 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341201; cv=none; b=GF7USUZBDyJnH0E4HhkX6RivpfVURT/UGCiQv8ypsr8OHi4Qb8j6rC5cW8/NuVTjE71bhYiaIslEH9ahtD76bLA8IBdkQXR8CRjr+zzcvjw1yLh3Zg6RWbB8PxDWofnWgUZD5aUP2gwIwwP+O31xWmbLFD2uSb8gzxk7fiDI/bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341201; c=relaxed/simple;
	bh=bNk4/N865uxd8oiyvt2u0F/rM7pIoJSR5LF6seU25Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVhOn9iRRA3L5sHUq6xMN42zN0xdWsvttm7Ftzn3UNlG2O6e1bnk9qcIaXq1RqlS7KnJA+94I3zu0CqhHq9qqwSS1OHbT0qFVX0JOJrQVSOnCY8wMSgu7yfP5RjrooR9Y0Qs2hwc6jA1FI/5QNv/K3RTnOjGdrEK0YVVVM6a11w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdvbbZYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E117C43399;
	Wed,  7 Feb 2024 21:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341200;
	bh=bNk4/N865uxd8oiyvt2u0F/rM7pIoJSR5LF6seU25Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KdvbbZYOqpRz8ZWjExseX1PjW6RIe+5l5MWAYPwT3eYUHWCwHsCy+MbxkN0KdWk/+
	 ary78PhDZn0Fu2y2g8Td98oJ5f46pwcOQonqRgJgcWKO/Ih8Ht7DtViMOdMWygI+U7
	 PkdUZ7uoWRyvKYX2cdXgvdjRipIeEI8YY89976Q+2Gc/RyVq/3bYp4SaYia6SPYEl7
	 AqCtiwYKxIVPChVLYlilqAbng8Qo7ZAbXg3/0mAWdXudtb/ZtdRd7FCo1SllXmLJb0
	 6HKhHx3NjjHGNY2PVqnEjUUdxBi15vwizQaSlbAkjnD4uXX5pSEue3A4j18NWOgWO+
	 A+34VTXFhSONA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 15/23] nvmet-fcloop: swap the list_add_tail arguments
Date: Wed,  7 Feb 2024 16:25:56 -0500
Message-ID: <20240207212611.3793-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit dcfad4ab4d6733f2861cd241d8532a0004fc835a ]

The first argument of list_add_tail function is the new element which
should be added to the list which is the second argument. Swap the
arguments to allow processing more than one element at a time.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fcloop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index c780af36c1d4..f5b8442b653d 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -358,7 +358,7 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 	if (!rport->targetport) {
 		tls_req->status = -ECONNREFUSED;
 		spin_lock(&rport->lock);
-		list_add_tail(&rport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &rport->ls_list);
 		spin_unlock(&rport->lock);
 		queue_work(nvmet_wq, &rport->ls_work);
 		return ret;
@@ -391,7 +391,7 @@ fcloop_h2t_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
 	if (remoteport) {
 		rport = remoteport->private;
 		spin_lock(&rport->lock);
-		list_add_tail(&rport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &rport->ls_list);
 		spin_unlock(&rport->lock);
 		queue_work(nvmet_wq, &rport->ls_work);
 	}
@@ -446,7 +446,7 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 	if (!tport->remoteport) {
 		tls_req->status = -ECONNREFUSED;
 		spin_lock(&tport->lock);
-		list_add_tail(&tport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &tport->ls_list);
 		spin_unlock(&tport->lock);
 		queue_work(nvmet_wq, &tport->ls_work);
 		return ret;
-- 
2.43.0


