Return-Path: <linux-kernel+bounces-137697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393C589E61E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E34F1C224E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F7115920B;
	Tue,  9 Apr 2024 23:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGFWtNyz"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D96159201
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 23:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705658; cv=none; b=NCUoEKBgQLWfaNRZ6JiPSHUK7/88CWdZCqBuUox3YqOq1TR8w0Y5aY3YrR3r317JeQgjXRNHQhJGwtvBa6f9AMymA+8O1lIgqEEBWkM7AbtZ9VKhcSQ54ofWdeHCwralqYhl0JgwPAQ/rjo73K1KVgq71cI9PYqfSfuh1XABEGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705658; c=relaxed/simple;
	bh=f22HyjkIzjMWg5Ym1cTX5CnazZXsHqPj5TZFPRbjcag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sokcr4u6gGggkXP3zvWhmlFcjjza3qMIESlIIxOpYNQuCRHVBn5yz7YrKO7/FuVw4bNoSng4vCeWYbZvEDyPRMddn1JrsdeCmr+aK9MqpL6I0P7nvJoSD9ulWb5DKgBFkDcynnrAcV1wmh8/loL9JDfT0LGEJOlNhBlpvUdrVS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGFWtNyz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e4149e7695so21152545ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 16:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712705656; x=1713310456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6odFHMEXFzZMinU+/jCuQ/6/uayaOc5n4IeqpxK5Lj4=;
        b=bGFWtNyzUH0u/xXUR173fTHLrO3dGlZcDfKHIwMBoQ5anoP69sGxjcWyROHAO0AUXz
         iRvWevnpfT+KAezn+jhvkk88opVgkEzgT0c6RIByLkXE8ZACA7i1ZxGIJdT0IamRz3iZ
         WVPSAlqK+MpQawNPOQPR5+5GsBBpCxZ/sEsqFZ5wbAFT4z2Ql0ro7rA2q64HpExZ+t1D
         TilqJk0tn5adOfK/GRMvu58gD6buJ6UCWdYIW/0Trmbx46XYTkCFCzHhXMToHh6Ce8No
         w8i24+GXLzDu9BtrKEXcgrHMRWNZb2FFUmhn560wKIxO/mQ8NBO7dTq5+qsAJUKzVhP1
         99IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712705656; x=1713310456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6odFHMEXFzZMinU+/jCuQ/6/uayaOc5n4IeqpxK5Lj4=;
        b=POKbdi5Ueg0iC72iJT+LdJP3xrwLt5ILscKGPSFlC2I/7tcql+ulBYmq6uEX07H0o7
         NpOcoHigJZ6X4Ia4LUtAMuaYN/mAJL3e2w0Q0EiWyf3KiO5Vx9tqJPRRDO372mXYhIUJ
         RSW+e88nueD+qwe914Gj5uG8PrBz6PCy1t5VJmjCFeefzRWAoaDX8bZcC/zT6/bKLOCN
         tmWkkms/pB0lIoQGuc3Bg9OjPNh0B6g5SYUdCyT1nd+tFi0oKwdPwkfPPtzWnQNMstGE
         LrtAgl7kuzqmaontoM3fJKJB6qlheY5RP9Rsrsvnk8Zn9o4mkixfRkk6AAX1fnczmhMF
         tQcg==
X-Gm-Message-State: AOJu0YyCN3b6hwHkgSnQy/JHL/xYjmHDPNU7kRz/nkd9M5sW4Nojsw4M
	YUr/wh8aNtVOLwtggOV0ayFU0vaV2ZE0SqHQpUjuJ/LtjMDLV2n3HYNI4WkL
X-Google-Smtp-Source: AGHT+IHkJr8feUvKJuTXxw3mj3hdsJ+535brp1RYR3IJHjcS9AsHhDj+0eU7FhodjhHv9PWsUEOl1Q==
X-Received: by 2002:a17:902:d905:b0:1e4:9af6:ddc2 with SMTP id c5-20020a170902d90500b001e49af6ddc2mr1027083plz.40.1712705656411;
        Tue, 09 Apr 2024 16:34:16 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:1d4b:7a42:2921:f1b0])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902ea0100b001e042dc5202sm9426408plg.80.2024.04.09.16.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 16:34:16 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: write missing last sum blk of file pinning section
Date: Tue,  9 Apr 2024 16:34:11 -0700
Message-ID: <20240409233411.1197830-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

While do not allocating a new section in advance for file pinning area, I
missed that we should write the sum block for the last segment of a file
pinning section.

Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4fd76e867e0a..6474b7338e81 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3559,6 +3559,8 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	if (segment_full) {
 		if (type == CURSEG_COLD_DATA_PINNED &&
 		    !((curseg->segno + 1) % sbi->segs_per_sec)) {
+			write_sum_page(sbi, curseg->sum_blk,
+					GET_SUM_BLOCK(sbi, curseg->segno));
 			reset_curseg_fields(curseg);
 			goto skip_new_segment;
 		}
-- 
2.44.0.478.gd926399ef9-goog


