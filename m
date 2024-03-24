Return-Path: <linux-kernel+bounces-115111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD51889312
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7E51C2DEFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67982FC074;
	Mon, 25 Mar 2024 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Im0jsLHn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994E328CE7A;
	Sun, 24 Mar 2024 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324105; cv=none; b=olOr73By+kfIO23jFsPQFS1uV2W1VuolCCBVILkitXa42hlPIAfU/HJuLZuTtpsWtClVQ1X+n0IuU6TLtu1rRBjGmEofC0klGXpmoRQpz9LaFE4juGBwA+MrhEfeh5WV/MdxEla5hFoAfh95J+XIDoGCdfrqScg6u2way91qDts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324105; c=relaxed/simple;
	bh=pR1er8jPDX+T1NSc81hDwj4KYR4Ba00o1SJz9wmNUxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxP2wbI8T7JUvdgUdxbluLBPbgZ3uH9PvbwNJTtgdwMZDkksMpR7KzpJLksQF/quGP4bc5fJGbhDwCjiBQsfUAVwpGdOqP4Pmw/0dHsZQkDPr2ZcAnIbo01USlk1bFk2qRatu/zVdo2lyBq07lir/Yvk5NmBP59QNuessjFBGoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Im0jsLHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C5FC433A6;
	Sun, 24 Mar 2024 23:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324104;
	bh=pR1er8jPDX+T1NSc81hDwj4KYR4Ba00o1SJz9wmNUxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Im0jsLHnmImoqiWvXeACChsWDNrX+J2vHTNXbnDdaPaF6Ru3FvCgE30a9q/F7KQeh
	 uADGbjWzVZ8uImrP5BRZSebN+abBcwVP3eLgj1WJSR/goWvzKWHaUcLlUO09FqO7rs
	 DSm9/ZQ7KY0xHBUGDvrFT8vZzCQiHRzAVDJVfSbkw33iI3ue4W1feggjdkjpbnnhYd
	 8xADR++N0YeNjnjBitg56O12r9nHw1tmBtjh4wzZoaW+Ai/14OOQgFDjMZ5mqc2RUB
	 9oIO9KiB0VOSjyfRzM2+du9kzgy6eYhVuwIS0opq+VefnsOyJt4EFM3Yx8JJEMaNw+
	 Uxf+TdFnAYEqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 103/183] media: v4l2-mem2mem: fix a memleak in v4l2_m2m_register_entity
Date: Sun, 24 Mar 2024 19:45:16 -0400
Message-ID: <20240324234638.1355609-104-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index d56837c04a81a..b374c9fab4b9e 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -799,11 +799,17 @@ static int v4l2_m2m_register_entity(struct media_device *mdev,
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


