Return-Path: <linux-kernel+bounces-114575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3259E888B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF1028EDE1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D975C29A127;
	Sun, 24 Mar 2024 23:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpwMVkKc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8601122F8FA;
	Sun, 24 Mar 2024 23:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322218; cv=none; b=WqKWxGYHueGr+rCKEUuHqRAh7dtOmsabLKuW6h8B47jR4WyJ1/UORn4y8/F3rlARIE+VQx0HwTLZd8mNantaiIdZayegb2fj1XElmv7cBQrzabs8uXyprgWuteQ5gzsJG6KK7mWNYihRra6yb+Wd02kJa7KACXYRZ9x5YzNJWRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322218; c=relaxed/simple;
	bh=aWgCLk/g9cLSdgGYirRgwcop9PDc5vxNAmij2AoyzlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvjDcNKndDfMx1rjF3+R+/L37jL3vOu0MdtsN7li1+WlQN1JHKk/Mwbxbl6oNkIG2Co2FTOGtpWypa3jRAc/xbPddcoQHx55h3RTWXsTRszeyvveLshqdoJdpIbRzFf3BODqhjgcOys6FowvRO98MEH1s6a9U1LT4u/kYJ8GwWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpwMVkKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE842C433F1;
	Sun, 24 Mar 2024 23:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322217;
	bh=aWgCLk/g9cLSdgGYirRgwcop9PDc5vxNAmij2AoyzlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LpwMVkKck5l5guPCy3vhJvbJLkIhZoBheC15XVXAyNe4Cfsx/uWQMOUQdGjaMlO5h
	 WJBN4JGXVUsnMY1v9O//ZPyvzxl/lpJEkJw3CQ9BtJG8p/9rY4Jaz5Q8Bk/CzvkmV6
	 D/wbgw1UZiNLZkaHu6AR9vycUgGQRlJfsWcKXK3+SjKqcLSm1DcFZidco5ct5ELNVT
	 BDBXR9oSYVKJAMn/WGm3qRvw91MTtbLSnc6yJA2chtgDV5+UrkxIrl30tW0gjgPgXb
	 TBo2znY5eOW19VvqdqLYRE8tE3pFgf0+SUJG+lgEPVtn4aCKijpfU10m2vS9loiVrB
	 QhCEtGzLoMseg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 297/451] media: cedrus: h265: Fix configuring bitstream size
Date: Sun, 24 Mar 2024 19:09:33 -0400
Message-ID: <20240324231207.1351418-298-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jernej Skrabec <jernej.skrabec@gmail.com>

[ Upstream commit 3a11887f7f11a6bb1f05e7f67b3ea20dadfec443 ]

bit_size field holds size of slice, not slice + header. Because of HW
quirks, driver can't program in just slice, but also preceding header.
But that means that currently used bit_size is wrong (too small).
Instead, just use size of whole buffer. There is no harm in doing this.

Fixes: 86caab29da78 ("media: cedrus: Add HEVC/H.265 decoding support")
Suggested-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 7a438cd22c341..9f13c942a806b 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -414,11 +414,11 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	unsigned int ctb_addr_x, ctb_addr_y;
 	struct cedrus_buffer *cedrus_buf;
 	dma_addr_t src_buf_addr;
-	dma_addr_t src_buf_end_addr;
 	u32 chroma_log2_weight_denom;
 	u32 num_entry_point_offsets;
 	u32 output_pic_list_index;
 	u32 pic_order_cnt[2];
+	size_t slice_bytes;
 	u8 padding;
 	int count;
 	u32 reg;
@@ -430,6 +430,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	pred_weight_table = &slice_params->pred_weight_table;
 	num_entry_point_offsets = slice_params->num_entry_point_offsets;
 	cedrus_buf = vb2_to_cedrus_buffer(&run->dst->vb2_buf);
+	slice_bytes = vb2_get_plane_payload(&run->src->vb2_buf, 0);
 
 	/*
 	 * If entry points offsets are present, we should get them
@@ -477,7 +478,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 
 	cedrus_write(dev, VE_DEC_H265_BITS_OFFSET, 0);
 
-	reg = slice_params->bit_size;
+	reg = slice_bytes * 8;
 	cedrus_write(dev, VE_DEC_H265_BITS_LEN, reg);
 
 	/* Source beginning and end addresses. */
@@ -491,10 +492,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 
 	cedrus_write(dev, VE_DEC_H265_BITS_ADDR, reg);
 
-	src_buf_end_addr = src_buf_addr +
-			   DIV_ROUND_UP(slice_params->bit_size, 8);
-
-	reg = VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_end_addr);
+	reg = VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_addr + slice_bytes);
 	cedrus_write(dev, VE_DEC_H265_BITS_END_ADDR, reg);
 
 	/* Coding tree block address */
-- 
2.43.0


