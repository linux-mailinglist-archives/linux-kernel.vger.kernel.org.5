Return-Path: <linux-kernel+bounces-57215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE1584D535
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8CF1C24923
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1EC143652;
	Wed,  7 Feb 2024 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqGgRgZi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524EF143661;
	Wed,  7 Feb 2024 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341245; cv=none; b=ExU/J9Z0sSnMafhv0J/PVaxSGzJDWvtOfcKwZ2rAJ8xO2QRvpZt1nC2KCOxT7cgPqJDUiFtIU99TLLuTorGLLwsTFxA3Vgph3sBJoSXv+T4ZUOkYIiK8msPt4n+oT9vwV4vgmzLdQgCWxcoS+CtoQTO3KYrXpBE18r8oKAq/17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341245; c=relaxed/simple;
	bh=QOfzfBWnSePPrn3EU/czqjpW8X2ZbStvoN5lzrDArKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyvmzaJiL1hkOOIxNzBaxpIK+kwhkAi3+m7q8b5TKJDBNhpUsGiuOncBPFEoTu1sPrWtnPhZYrkN0UTJiI4ozKz4xjv95c3IER+VoYRSnfC4aXqiZdmBT+tRge3fFiBeNJ6JZCk0BYNiCJYK+xBjk1hB7V5eYHDhJ09ZT4BtWXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqGgRgZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C21C43394;
	Wed,  7 Feb 2024 21:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341245;
	bh=QOfzfBWnSePPrn3EU/czqjpW8X2ZbStvoN5lzrDArKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rqGgRgZiFF7NOR55bEjMMgxIC5FY+6mPPpK8Wd7NhVkN8VgilQlLOO4RuAPCp11tB
	 j/kHl31U7cnfKgYlvcIFwvhuI6vdGH8sgZbx+NlIQr4u5SRytYA8Su7J3l5LymEaHZ
	 QiCAk4JisXokGU8jqvc2d2Ul/sY7wUf+tWjGvRQj/UrnDbL4GOXHofGCP1uLf9L+KJ
	 X+oOW/Mou0SftLETm1pTf8z8fsCOtMIe4wQ/quaTqgmNPfQOIOVp9vPv6Id4pO1WrO
	 AziBPjY5eGy5BKpZ7ezSmyuv2hmsuz57N3u0czl/wiEq2SXv0FDCAI84JpfOj9bZwa
	 QjMOySDjK4pqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 13/16] nvmet-fc: do not tack refs on tgtports from assoc
Date: Wed,  7 Feb 2024 16:26:53 -0500
Message-ID: <20240207212700.4287-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212700.4287-1-sashal@kernel.org>
References: <20240207212700.4287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
Content-Transfer-Encoding: 8bit

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 1c110588dd95d21782397ff3cbaa55820b4e1fad ]

The association life time is tied to the life time of the target port.
That means we should not take extra a refcount when creating a
association.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 18a64a4fd8da..ebbc513682e1 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1110,12 +1110,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	if (idx < 0)
 		goto out_free_assoc;
 
-	if (!nvmet_fc_tgtport_get(tgtport))
-		goto out_ida;
-
 	assoc->hostport = nvmet_fc_alloc_hostport(tgtport, hosthandle);
 	if (IS_ERR(assoc->hostport))
-		goto out_put;
+		goto out_ida;
 
 	assoc->tgtport = tgtport;
 	assoc->a_id = idx;
@@ -1145,8 +1142,6 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 
 	return assoc;
 
-out_put:
-	nvmet_fc_tgtport_put(tgtport);
 out_ida:
 	ida_simple_remove(&tgtport->assoc_cnt, idx);
 out_free_assoc:
-- 
2.43.0


