Return-Path: <linux-kernel+bounces-57103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD9884D40D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A962284B68
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9474013BE80;
	Wed,  7 Feb 2024 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAexUWvX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED4913BEA0;
	Wed,  7 Feb 2024 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340991; cv=none; b=VOP3JjzJ1s0iZMhpmNw1rxFJNaHOKDTAqIZ2s/v6xALlV5ZqUV1wDLuF6ZDl6tawARCME4PZWYBc/hKoL3hN4o8ZxME1Jqa4abb/7pHbZJNeQD6EajUkWhD7paxbXxttoeu5QnIewfuBj5weNl9q21LoZGAXqV6kpqabMycQJP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340991; c=relaxed/simple;
	bh=iOziTvu6wmjSavSMr9/wOzK6SY7pCtHgB6PvF+dkuuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/kihV8ZwN/jUV/0Sz8dD2X7DMCu6n3Ygt96oaxBRxAxNUaU5h+FD1ZzsWylphrPu+kGc41cKAKnLZqzEMqFwlM1zn+d97Z3fzWtR0/75pvwWIIDHBfWkdU+aXj1EtKnsny+yLdoByNBV81t5e8gBxlZIlb50lkiaMxkeLkrxjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAexUWvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4838EC433C7;
	Wed,  7 Feb 2024 21:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340991;
	bh=iOziTvu6wmjSavSMr9/wOzK6SY7pCtHgB6PvF+dkuuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fAexUWvX3DM0geGnB+0miqIpKJHjB9yO4iXb7g3oK7lvY5//MdRF8BmP8zcUFdcn6
	 RuyDv3T25NOxu+tfKYClTcrcwewWXMjK3IsVQCxpSCQBA0kZXYeQbb6S9IIkC+4ReZ
	 vuCoXLrQJgqeuLt51iLjKNXIsNTPNhy9IavUBE1DMRrTXaYxBYxjguyeL6J3pvJg+z
	 RikeoFVtP6Mc0i60yLMfPrcaqKqsF8t7EZZpsdkY9a6FdDkDYNyLZ58u9RFe4atkgk
	 GxcIPceAgxGyPhyjjznnhapOYY9/At1nsiiL7ZO5pnZSu0tBx7LjgiLXjPdeUnoPJO
	 hym9UsB8gORwA==
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
Subject: [PATCH AUTOSEL 6.7 37/44] nvmet-fc: do not tack refs on tgtports from assoc
Date: Wed,  7 Feb 2024 16:21:04 -0500
Message-ID: <20240207212142.1399-37-sashal@kernel.org>
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
 drivers/nvme/target/fc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 6d111b03d371..d50af99e847d 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1108,12 +1108,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
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
@@ -1143,8 +1140,6 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 
 	return assoc;
 
-out_put:
-	nvmet_fc_tgtport_put(tgtport);
 out_ida:
 	ida_free(&tgtport->assoc_cnt, idx);
 out_free_assoc:
@@ -1181,7 +1176,6 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	dev_info(tgtport->dev,
 		"{%d:%d} Association freed\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
-	nvmet_fc_tgtport_put(tgtport);
 	kfree(assoc);
 }
 
-- 
2.43.0


