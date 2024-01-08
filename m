Return-Path: <linux-kernel+bounces-19502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609A3826DED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8189D1C224BB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B077405EE;
	Mon,  8 Jan 2024 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCszEp8B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0C042052;
	Mon,  8 Jan 2024 12:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F8BC433C9;
	Mon,  8 Jan 2024 12:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704716894;
	bh=opb3qO0OY2NI17zoyL1H/sSnvpBzXA8yXd5kYvYY5H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jCszEp8BIc/JVjc1uoO6L3ZQA0KwEY+E+rLyQEXclj8myz2Y2TxO4A/iLqhUk/8NS
	 mfafNpv/vG6IeAXfRg3edn1p7lNMW9Si9Rqw2YmPjwU+Kdl3I+oizPOA6N5Vu9vhNN
	 y1uR1YaELF756kgiuAljSqoJgVh9GIbrZ+AlzWWhLXfdxqloKZLHyINDUsmBDHCVgA
	 Xltq2tL63GIp1A87BKi45jT92g69TrxeuTgXUM6VpmUA5ltcAZhIkgjSZyz8DkWjBE
	 rHuP310JrqdijvHaGImEg8emNsNrwk8kQuWLVrhtCNpkR/8KbLNZ6OzEQQUbxbFRBN
	 Pm3QGzU6t6/0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Airlie <airlied@gmail.com>,
	Dave Airlie <airlied@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	kherbst@redhat.com,
	lyude@redhat.com,
	dakr@redhat.com,
	daniel@ffwll.ch,
	bskeggs@redhat.com,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 8/8] nouveau: fix disp disabling with GSP
Date: Mon,  8 Jan 2024 07:27:24 -0500
Message-ID: <20240108122745.2090122-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108122745.2090122-1-sashal@kernel.org>
References: <20240108122745.2090122-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.10
Content-Transfer-Encoding: 8bit

From: Dave Airlie <airlied@gmail.com>

[ Upstream commit 7854ea0e408d7f2e8faaada1773f3ddf9cb538f5 ]

This func ptr here is normally static allocation, but gsp r535
uses a dynamic pointer, so we need to handle that better.

This fixes a crash with GSP when you use config=disp=0 to avoid
disp problems.

Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231222043308.3090089-4-airlied@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c
index 73104b59f97fe..54a3017f4756a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c
@@ -276,7 +276,7 @@ nvkm_disp_oneinit(struct nvkm_engine *engine)
 		list_add_tail(&outp->conn->head, &disp->conns);
 	}
 
-	if (disp->func->oneinit) {
+	if (disp->func && disp->func->oneinit) {
 		ret = disp->func->oneinit(disp);
 		if (ret)
 			return ret;
@@ -377,8 +377,10 @@ nvkm_disp_new_(const struct nvkm_disp_func *func, struct nvkm_device *device,
 	spin_lock_init(&disp->client.lock);
 
 	ret = nvkm_engine_ctor(&nvkm_disp, device, type, inst, true, &disp->engine);
-	if (ret)
+	if (ret) {
+		disp->func = NULL;
 		return ret;
+	}
 
 	if (func->super) {
 		disp->super.wq = create_singlethread_workqueue("nvkm-disp");
-- 
2.43.0


