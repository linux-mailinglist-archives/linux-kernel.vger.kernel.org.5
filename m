Return-Path: <linux-kernel+bounces-26291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E807782DE2B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FCA1C21DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4964F18032;
	Mon, 15 Jan 2024 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NlRyHxxD"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403BC17C6B;
	Mon, 15 Jan 2024 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705338512;
	bh=GZjv5jDQUKVKK/gKAMres/tfnHPmalotCq2ySiKnMws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NlRyHxxDgXm4JkpMMHu9Hn6t1+3bJEXjlNgb0dRykO8BExbN8BlvZ8yU637hxQWuQ
	 6vAMIGOwMwQqy0Yct/lcgOFCK5Ke6JXmLGcCgejbAPmbwFQ55HNBvivsQT8tB2oWEk
	 IGIc7m25/MEgq8ufmtFwqQysyyRCxjt9AjUwo1YwGxBobkN8b4d+4qzNLub6Os/vET
	 jG7iUgjCMziGmI7G+vBHGHzs8RtjJ0c36b+G3vwiehr52EnlIBX5iQHbXtf+mO3cXt
	 qf7cE8+Fu5XQVe5h5+PvBdMZta2Vq1DCcZh3JloEKkDd9hojL029dFfRjy8JWt3gdS
	 fxuLBkIcIhUhQ==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 186CD37813E4;
	Mon, 15 Jan 2024 17:08:32 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: tfiga@chromium.org,
	m.szyprowski@samsung.com,
	mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] media: media videobuf2: Stop direct calls to queue num_buffers field
Date: Mon, 15 Jan 2024 18:08:26 +0100
Message-Id: <20240115170826.214519-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240115170826.214519-1-benjamin.gaignard@collabora.com>
References: <20240115170826.214519-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
This allows us to change how the number of buffers is computed in the
future.

Fixes: c838530d230b ("media: media videobuf2: Be more flexible on the number of queue stored buffers")
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 41a832dd1426..b6bf8f232f48 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -989,7 +989,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 	bool no_previous_buffers = !q_num_bufs;
 	int ret = 0;
 
-	if (q->num_buffers == q->max_num_buffers) {
+	if (q_num_bufs == q->max_num_buffers) {
 		dprintk(q, 1, "maximum number of buffers already allocated\n");
 		return -ENOBUFS;
 	}
-- 
2.40.1


