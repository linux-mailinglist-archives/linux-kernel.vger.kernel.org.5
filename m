Return-Path: <linux-kernel+bounces-57098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1A384D403
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7534E1C2206A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB56513AA4C;
	Wed,  7 Feb 2024 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOEV9abw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A813B280;
	Wed,  7 Feb 2024 21:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340983; cv=none; b=ZxIDZqhmraWT5M5GjB/joy7zc288JBWc71irmMpj18MQiktA+8m1HswP6esWJXSAfgW4jJI7CPQ8kzJtFv5A5/JgbbzDpB5QZLQ1KNQ/XoPDLSPz9Or4vmCJoDuMBtSympg8J6K8/JGW6+7M6Tmqwn6M36FvI3WYC+syL9CsIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340983; c=relaxed/simple;
	bh=8Zk0CzA0tVU4lBXyhl7hjsNEW2keRPbiMZnj5O9LUXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptKJwNAbZtqiU0nINpfhb8s5aGHABVg6gbMrGw7GDZFNGToUeSid7//CrurG9nxsB44MCJdsWq7k+qnblS0l/7mOzhspTihpuxjTO1LJAQeWD1TihmbygeFjyVcpV8hNAYj48ZKVBgi3ON+Kmwad13VrMmINfm14WoaXhoglXUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOEV9abw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A53BC433F1;
	Wed,  7 Feb 2024 21:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340982;
	bh=8Zk0CzA0tVU4lBXyhl7hjsNEW2keRPbiMZnj5O9LUXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOEV9abwxzN2ADlWZ9POy1SfqKQbV5YQY7mf5ILKJV18V5WosSeD/YoiG9e74cfOy
	 Jskmvtjo4oD15OvG4S9OPOoJ3rMPODUM68qe8Bx45XKSeZjiIDj5LjA1rWMD3LMa4F
	 oqiPsSl7hT4SVhOUub3L8z/qZ8aA9Om8A4o64WsmiIIfcSOAAvhfL0wxVDWwQDQugm
	 vfiCD8ODAIZrEox9i0oopTRaZdi4BLQwLsqkxvPGTGnnhr59A8fmMUF5zCor2CCMkb
	 Br5fh8O19hZnNMMVnct6cNau3lkqXSdUlIwuQ9/P5rKflndDZWAeQavRzrncJumqfv
	 XREuMkHgZD4lg==
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
Subject: [PATCH AUTOSEL 6.7 32/44] nvmet-fcloop: swap the list_add_tail arguments
Date: Wed,  7 Feb 2024 16:20:59 -0500
Message-ID: <20240207212142.1399-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index c65a73433c05..e6d4226827b5 100644
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


