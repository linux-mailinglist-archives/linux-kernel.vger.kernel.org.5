Return-Path: <linux-kernel+bounces-36475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 277F883A170
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C42CB29982
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91F6171DC;
	Wed, 24 Jan 2024 05:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C96mfb8q"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64328171A3;
	Wed, 24 Jan 2024 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706074582; cv=none; b=SNOjOIl0UNglt+CP96RgrLp6X+giJp7PFsKiKyABjiL1pCkpBnqehgAdZ77CQ+YGRCnRLTP2kMVRXsq71XTYWHjBusHj7lh9j19tBlWaEsxnVS5l3kZbGndm5jZWqPKVQ9CAarW8cU+J6T2rJ5mo7GqeiuCoqo975oo+F1rL0IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706074582; c=relaxed/simple;
	bh=8feU4guz9hArhCl04Z9vzJaGKxbjXW+xRImH90hRomY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TFF7a0BGg6EBMhxSy4ar5ZjnLXD8E88csrcd9gE3ddobgv5ODK7/l49i4sTnVQ6JJpJVZk4j9fEeVCNG54tgrislCOjkRTxmr+ccYeegTyXsWpsIlds4GfjFEWEhtFX3+6M0SVuTcFCHu3mLL6+x1p/OfFTCH5w5ao2k5CmhtLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C96mfb8q; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6dd80d3d419so987243b3a.3;
        Tue, 23 Jan 2024 21:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706074581; x=1706679381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQTsvHi1Xi8RfgpJ+r1gUAH45t6Iv3m0mcpAy4KCiow=;
        b=C96mfb8qY5pDLW8jmfWDBS6NJQtW2PS/GVfNyqJopdzMVlTC8PowbhbzdZvzzLKNGp
         o5uD48tcIULlHODoP2cwWl2Zk4EHEztTC9vZ+VMzG2xZRbqFagwcvDkIaVgqw0T5sDKU
         ga2PTOXtCoCqge/nwy+gnp4mw1gGWwzPximn8D3esvEOCLQmpupuLOCK2Weoi3FRHUD6
         rI1NduZhLnhLkBtnjEVQDBiMDJdi8TEXtcCbPTGpXikq3AdwwH3pxlCud80zp4yAfoI8
         bm0DFHn2lS57EC+WKJk8UgOuaUaXjn42Pg7vwtHuayp+4WFzEhknmoCv88G0+RM6bNso
         tqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706074581; x=1706679381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQTsvHi1Xi8RfgpJ+r1gUAH45t6Iv3m0mcpAy4KCiow=;
        b=CIxcJj/RctFxMnocUrnM9FORWtivflYA/G5TuwG2OeGU+Eia2yOAVBIqPyHEs6dsp6
         05yiv1I8vt5V9BJsequB+ympac8dJGSkXp+YHjLtZ9YlT+Ez4DM1GhPH6iGtBLBMg6gT
         jlcSMqWIX/dxfko9V7DtXiUvzNLEuWYZcvhW4omuzUFg7phwhiW1lhhnxp6EqkPI2oi1
         /Nq4US6Ttj1VucKBQ+JYNnKIq8yWGQNCVS3nMtvxHl2acwlCJAo7gCmPz+2tFL4KhUfx
         x3iXki65QlXuBlYsg2/2r1pLta2Jg0KIyUVS2KSSmTHHHcFRG8vNehaasqPPJ8ZOVS9K
         nwmw==
X-Gm-Message-State: AOJu0Yxi1SeaitOFZzP6Eo3nL7vBzoj8NAiPz9Quv6mraojqC+vBMKm7
	xgpF1yGXXMGMecGWxqNGHZYMBwovrEhbczKdz64INXW/lv8M9H3i
X-Google-Smtp-Source: AGHT+IHntzjpUgnHbgr1/r4YwxqErlErlGZTkG03JscxLq5XW6o243rQeVz/vwZto1taufEW0c3uPA==
X-Received: by 2002:a05:6a20:ce96:b0:199:ddac:ad4f with SMTP id if22-20020a056a20ce9600b00199ddacad4fmr246977pzb.100.1706074580699;
        Tue, 23 Jan 2024 21:36:20 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id kt6-20020a170903088600b001d755acec64sm4015663plb.189.2024.01.23.21.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 21:36:20 -0800 (PST)
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	axboe@kernel.dk,
	ebiggers@kernel.org
Cc: zhiguo.niu@unisoc.com,
	ke.wang@unisoc.com,
	yibin.ding@unisoc.com,
	hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH v8 4/5] dm verity: Fix I/O priority lost when read FEC and hash
Date: Wed, 24 Jan 2024 13:35:55 +0800
Message-Id: <20240124053556.126468-5-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124053556.126468-1-hongyu.jin.cn@gmail.com>
References: <20231221103139.15699-6-hongyu.jin.cn@gmail.com>
 <20240124053556.126468-1-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Jin <hongyu.jin@unisoc.com>

After obtaining the data, verification or error correction process may
trigger a new I/O that loses the priority of the original I/O, that is,
the verification of the higher priority IO may be blocked by the lower
priority IO.

Make the I/O of verification and error correction follow the
priority of original I/O.

Co-developed-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
---
 drivers/md/dm-verity-fec.c    | 21 ++++++++++++---------
 drivers/md/dm-verity-target.c | 12 ++++++++----
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 49db19e537f9..066521de08da 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -60,7 +60,8 @@ static int fec_decode_rs8(struct dm_verity *v, struct dm_verity_fec_io *fio,
  * to the data block. Caller is responsible for releasing buf.
  */
 static u8 *fec_read_parity(struct dm_verity *v, u64 rsb, int index,
-			   unsigned int *offset, struct dm_buffer **buf)
+			   unsigned int *offset, struct dm_buffer **buf,
+			   unsigned short ioprio)
 {
 	u64 position, block, rem;
 	u8 *res;
@@ -69,7 +70,7 @@ static u8 *fec_read_parity(struct dm_verity *v, u64 rsb, int index,
 	block = div64_u64_rem(position, v->fec->io_size, &rem);
 	*offset = (unsigned int)rem;
 
-	res = dm_bufio_read(v->fec->bufio, block, buf, IOPRIO_DEFAULT);
+	res = dm_bufio_read(v->fec->bufio, block, buf, ioprio);
 	if (IS_ERR(res)) {
 		DMERR("%s: FEC %llu: parity read failed (block %llu): %ld",
 		      v->data_dev->name, (unsigned long long)rsb,
@@ -121,16 +122,17 @@ static inline unsigned int fec_buffer_rs_index(unsigned int i, unsigned int j)
  * Decode all RS blocks from buffers and copy corrected bytes into fio->output
  * starting from block_offset.
  */
-static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_fec_io *fio,
-			   u64 rsb, int byte_index, unsigned int block_offset,
-			   int neras)
+static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_io *io,
+			   struct dm_verity_fec_io *fio, u64 rsb, int byte_index,
+			   unsigned int block_offset, int neras)
 {
 	int r, corrected = 0, res;
 	struct dm_buffer *buf;
 	unsigned int n, i, offset;
 	u8 *par, *block;
+	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
 
-	par = fec_read_parity(v, rsb, block_offset, &offset, &buf);
+	par = fec_read_parity(v, rsb, block_offset, &offset, &buf, bio_prio(bio));
 	if (IS_ERR(par))
 		return PTR_ERR(par);
 
@@ -158,7 +160,7 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_fec_io *fio,
 		if (offset >= v->fec->io_size) {
 			dm_bufio_release(buf);
 
-			par = fec_read_parity(v, rsb, block_offset, &offset, &buf);
+			par = fec_read_parity(v, rsb, block_offset, &offset, &buf, bio_prio(bio));
 			if (IS_ERR(par))
 				return PTR_ERR(par);
 		}
@@ -210,6 +212,7 @@ static int fec_read_bufs(struct dm_verity *v, struct dm_verity_io *io,
 	u8 *bbuf, *rs_block;
 	u8 want_digest[HASH_MAX_DIGESTSIZE];
 	unsigned int n, k;
+	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
 
 	if (neras)
 		*neras = 0;
@@ -248,7 +251,7 @@ static int fec_read_bufs(struct dm_verity *v, struct dm_verity_io *io,
 			bufio = v->bufio;
 		}
 
-		bbuf = dm_bufio_read(bufio, block, &buf, IOPRIO_DEFAULT);
+		bbuf = dm_bufio_read(bufio, block, &buf, bio_prio(bio));
 		if (IS_ERR(bbuf)) {
 			DMWARN_LIMIT("%s: FEC %llu: read failed (%llu): %ld",
 				     v->data_dev->name,
@@ -377,7 +380,7 @@ static int fec_decode_rsb(struct dm_verity *v, struct dm_verity_io *io,
 		if (unlikely(r < 0))
 			return r;
 
-		r = fec_decode_bufs(v, fio, rsb, r, pos, neras);
+		r = fec_decode_bufs(v, io, fio, rsb, r, pos, neras);
 		if (r < 0)
 			return r;
 
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 4758bfe2c156..8cbf81fc0031 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -51,6 +51,7 @@ static DEFINE_STATIC_KEY_FALSE(use_tasklet_enabled);
 struct dm_verity_prefetch_work {
 	struct work_struct work;
 	struct dm_verity *v;
+	unsigned short ioprio;
 	sector_t block;
 	unsigned int n_blocks;
 };
@@ -294,6 +295,7 @@ static int verity_verify_level(struct dm_verity *v, struct dm_verity_io *io,
 	int r;
 	sector_t hash_block;
 	unsigned int offset;
+	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
 
 	verity_hash_at_level(v, block, level, &hash_block, &offset);
 
@@ -308,7 +310,7 @@ static int verity_verify_level(struct dm_verity *v, struct dm_verity_io *io,
 			return -EAGAIN;
 		}
 	} else
-		data = dm_bufio_read(v->bufio, hash_block, &buf, IOPRIO_DEFAULT);
+		data = dm_bufio_read(v->bufio, hash_block, &buf, bio_prio(bio));
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
@@ -720,13 +722,14 @@ static void verity_prefetch_io(struct work_struct *work)
 no_prefetch_cluster:
 		dm_bufio_prefetch(v->bufio, hash_block_start,
 				  hash_block_end - hash_block_start + 1,
-				  IOPRIO_DEFAULT);
+				  pw->ioprio);
 	}
 
 	kfree(pw);
 }
 
-static void verity_submit_prefetch(struct dm_verity *v, struct dm_verity_io *io)
+static void verity_submit_prefetch(struct dm_verity *v, struct dm_verity_io *io,
+				   unsigned short ioprio)
 {
 	sector_t block = io->block;
 	unsigned int n_blocks = io->n_blocks;
@@ -754,6 +757,7 @@ static void verity_submit_prefetch(struct dm_verity *v, struct dm_verity_io *io)
 	pw->v = v;
 	pw->block = block;
 	pw->n_blocks = n_blocks;
+	pw->ioprio = ioprio;
 	queue_work(v->verify_wq, &pw->work);
 }
 
@@ -796,7 +800,7 @@ static int verity_map(struct dm_target *ti, struct bio *bio)
 
 	verity_fec_init_io(io);
 
-	verity_submit_prefetch(v, io);
+	verity_submit_prefetch(v, io, bio_prio(bio));
 
 	submit_bio_noacct(bio);
 
-- 
2.34.1


