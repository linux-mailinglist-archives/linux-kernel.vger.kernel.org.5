Return-Path: <linux-kernel+bounces-116064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E45889541
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E24828BD1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E348C2811CF;
	Mon, 25 Mar 2024 03:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quPfKd+t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B8D1774CA;
	Sun, 24 Mar 2024 23:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323480; cv=none; b=ESyiyVI1Dz7dT1kMZzVca+XbG6JznUPp9Aim9P3izuenmEA4Msup0Kr+cq21BI91c2GA65vHrRbETLbFcmjgG4t3OcHi5w8FvsaN/xNOFRxl85KMrRpmO2Ji3EYT9h7+hleBa7R8a5isnrzhGdjwQ4StkKAavCSJoh3Whu6y/g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323480; c=relaxed/simple;
	bh=LqNuI54SZG/j3JOM/Yao4FqRkZ3a3sKSz8TdXZ2yarI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3xHUUJSUXMXujX3RhMF7/O16NcM9fwoS5J3UFAo0P24uGoOrAiToNZbD5f5JAJokFuvxOWwXmGALM3VGjj6hQvDONJUk90hwOEERl4o/Hq4jDm8+9WA2dLanwyPfCZQ4yLc/xEYfo7fzDv6BrZH3ZxvZQKeuzdN6gyyW8VLFbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quPfKd+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F9BC433F1;
	Sun, 24 Mar 2024 23:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323480;
	bh=LqNuI54SZG/j3JOM/Yao4FqRkZ3a3sKSz8TdXZ2yarI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=quPfKd+t2cwKZWMc0Ij+1yXyLeH7QiibMbPZ9+cFRNNqmIy58YfjBIDHORQRLZv5t
	 0lM/Yt9/LP0G7j2XFLQOa0E52LFUCuuYEGsCOOi1J+BlxxQFMvqBhmm32/AQIbVXit
	 FGcGFlc9XLwwsOZxTF1I9oZtJeHKs+wwzF4y/xK2K67EItM/ILQqp192dD0513iDFz
	 bSD36vxzScsiNxEkLA4h+0IbZKV+sLnfdCL5o/5ba1bbOJlxCjYcrRcY4SLxAvEie7
	 ZDT4SxEPZoWaqV7sLgCGiThVjMlk5reoy9bTVkB60bUHyOfjSe6BsD7uKod1EqCTae
	 NcyvfzRZuYXyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 185/317] media: v4l2-mem2mem: fix a memleak in v4l2_m2m_register_entity
Date: Sun, 24 Mar 2024 19:32:45 -0400
Message-ID: <20240324233458.1352854-186-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Zhipeng Lu <alexious@zju.edu.cn>

[ Upstream commit 8f94b49a5b5d386c038e355bef6347298aabd211 ]

The entity->name (i.e. name) is allocated in v4l2_m2m_register_entity
but isn't freed in its following error-handling paths. This patch
adds such deallocation to prevent memleak of entity->name.

Fixes: be2fff656322 ("media: add helpers for memory-to-memory media controller")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index 8aeed39c415f2..5677bccd583e9 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -1062,11 +1062,17 @@ static int v4l2_m2m_register_entity(struct media_device *mdev,
 	entity->function = function;
 
 	ret = media_entity_pads_init(entity, num_pads, pads);
-	if (ret)
+	if (ret) {
+		kfree(entity->name);
+		entity->name = NULL;
 		return ret;
+	}
 	ret = media_device_register_entity(mdev, entity);
-	if (ret)
+	if (ret) {
+		kfree(entity->name);
+		entity->name = NULL;
 		return ret;
+	}
 
 	return 0;
 }
-- 
2.43.0


