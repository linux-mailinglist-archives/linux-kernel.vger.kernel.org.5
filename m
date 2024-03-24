Return-Path: <linux-kernel+bounces-114284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4D5888994
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26798288C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAA715E5C6;
	Sun, 24 Mar 2024 23:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeGBBgpv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D0920DD3A;
	Sun, 24 Mar 2024 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321655; cv=none; b=BkeenQw/XDxon5/dDxdTjwJ0Gj0Wyc5im0WVL9UAeJs7v7HqAKN8otGHtNuJZ/FkQ1X7dga5yY3UCGMhTXezqKdmk5qL8jeIasOhlgT8rfqKshVoOKy9AZWb0MhPpp4BUrXIL+YEfAjEtI7m/lc+INVIdYIlNDve4Hm2TzkPLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321655; c=relaxed/simple;
	bh=8POOEHMBodqPxKTRL+FZX71hTSWmfb8XiVKdy1zhITA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFcR/qtt7F83wA57pLqGk3GgT5lpVnBJOfVO6IctEJhmx9SVV/TslpWBMjz2fr7A2qXd3omOx8CFlZs+SoZoy8va+w9cANxeqVuYrGRqgYLDyUBZSO06BLQnKMDt5pvYtCzIMaYM1f8EPqyO57mLZVYZJcp8lU9a2H+4pfEfYHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeGBBgpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764BEC433C7;
	Sun, 24 Mar 2024 23:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321654;
	bh=8POOEHMBodqPxKTRL+FZX71hTSWmfb8XiVKdy1zhITA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JeGBBgpv6LveagcIp3eC0HbX3AaBh4Pnx+EYh32jl56F9BCudOgtpvy08CYZqZ5GK
	 Db7mhWR53EbUeIHhCohnW5zqag8Ka/2eOjG0mQ3zZq9R0Z82ZimVcg4OhhgR3DitT+
	 w56Al5+f1neFRiwzpwCrudcgv3GIG3nvrMtcGeDUo5XRNqsUjpW2gkSOvF6Eiqu3q/
	 sfGftGmUKggsypOMuitKIxKW+En7lfZbeEPjYtFC2wYfHDg11XIAKsxCAhPgDuU/Xz
	 DXjAyrVETy2u0et2PdPOGXXVvw8lEk0MIlimMhRqbK9kmxdZyRo9uUmVD6RWoEPuNd
	 EubvVC64JJM2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 383/638] media: v4l2-mem2mem: fix a memleak in v4l2_m2m_register_entity
Date: Sun, 24 Mar 2024 18:57:00 -0400
Message-ID: <20240324230116.1348576-384-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 0cc30397fbad5..8db9ac9c1433f 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -1084,11 +1084,17 @@ static int v4l2_m2m_register_entity(struct media_device *mdev,
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


