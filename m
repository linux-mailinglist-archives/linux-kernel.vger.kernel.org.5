Return-Path: <linux-kernel+bounces-29526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CA4830FE1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975A81F25DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B2521A12;
	Wed, 17 Jan 2024 23:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCCjNYVK"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A2A1E889
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532439; cv=none; b=kubmNXuvGLCYiyOCbknjUCW6cIczuRm6+5IY00/Cqb5f6u/eVmvlHYe+zel4GTxbGVbk+95ItOJeZKfCkFFdqmehPQgKZmyo6kmtOci7cfhV15I+E55LBbBEAmBOSuR7H4WvhOXLd8Au69ftNwy/A3I68yq4JqxUc5PAmkyci24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532439; c=relaxed/simple;
	bh=PmFsxi6d9e+Zlb3E4C1SRmLXOx2XOWKkOd3qfavXo9c=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=AN9wViwdhjI80gfV/EaWja+yTvyWFiwRYV6praSD6dt93RYs4Rcrb8DMWvu3N3d1I/+3xTBxcN2meuq05mkfpfKhyguLR+TvZJdOowqCuI0y1iyjhK75oHf8ZwALUEpm+UsYGkRCqQCTQ44YXIsVCqtzw5pKDp3dKn+64BzBAa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCCjNYVK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d5dfda4319so19608515ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705532437; x=1706137237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7m0N7t1XW7ex4DXEj0WY/wok48BDAnOfTPeDrj1R5vg=;
        b=YCCjNYVKgMYt3kdgnP9VN9x82JBV/w+2HgkHZR5H1e0KsXjTPQw1qxK0842X+++fXW
         LiwGvnybk+txfOlHgGihyg8aRxo7kfp38AtID73SJGxiEypKxP+JV3Nz8X48NFgR5JtT
         PC45RTOF+K96BbIEeZV7cLRPv5aMw4o41f4c24u9XHNg5QfmM5pgAEJvbbSFzXZbpQdD
         mAZiZsjwg2EozAEHaGIxb/YBLUPeAJyssrwtFwHY6vbn5D0txYCPkFOf0NZna1JFt5he
         Q36r5ugppUNWzCYubrjdnbrjngHnVVdO9G/3WSOubZ+e2mB2asHgeOBBRKVW5Wzu1DKm
         P+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705532437; x=1706137237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7m0N7t1XW7ex4DXEj0WY/wok48BDAnOfTPeDrj1R5vg=;
        b=slc4g1mvAIbQUIzRWhNKrR0A7zdCqz32pfI+GrB+3uuXmk6M24XZIz2+GC3qOKdT2o
         oGaki+ZpRrzagRFdMdq1KNLAqPJjWobJBukV60bxosiqNWmj5ukca9CVHDZkhOoZuT1K
         EYsOPL7NZtixmjCbI9eglnh5CPFMcCjmsd65OkdmBII8JOh2GF9XFfPhL73DuN0Dwk/C
         ElAc/lByiTyKxeauR0tXJje27zXkBu2w+UQx8jtIjR6CAJOIZtPdZyZ/itNkUa5bIyYb
         DNkX7O2Gy7LsQdG/q6fffMfRVZfa/B03gGU0eH+uHeLBe7h5PH7fmyJDWk9kYYX4zTlY
         n2ag==
X-Gm-Message-State: AOJu0YyKm9HBVagjR5X5fFtaso3WJbtlDHyqqGr+njSGb3xshvL0BkWZ
	NWhTbSWYPO8EOkQEeOwgPsBChGgo3oxHs8i2dopygs4X4FnRscOfNl2nPoad
X-Google-Smtp-Source: AGHT+IFNBgUAqSpqdp6LHvt4RyUJrX42pQdx+maDN9Bq2jOF4HQOREnS0fyNSrZDosS3tCc+gKtx6w==
X-Received: by 2002:a17:902:db06:b0:1d0:a9fa:5939 with SMTP id m6-20020a170902db0600b001d0a9fa5939mr1446plx.111.1705532436888;
        Wed, 17 Jan 2024 15:00:36 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:9c1b:9344:efbd:adc1])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902744200b001d5f5887ae8sm167964plt.10.2024.01.17.15.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 15:00:36 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: allocate logs after conventional area for HM zoned devices
Date: Wed, 17 Jan 2024 15:00:32 -0800
Message-ID: <20240117230032.2312067-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Make to allocate logs after conventional area for HM zoned devices to
spare them for file pinning support.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 mkfs/f2fs_format.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index f2840c8..91a7f4b 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -557,7 +557,8 @@ static int f2fs_prepare_super_block(void)
 		c.cur_seg[CURSEG_COLD_DATA] = 0;
 		c.cur_seg[CURSEG_WARM_DATA] = next_zone(CURSEG_COLD_DATA);
 	} else if (c.zoned_mode) {
-		c.cur_seg[CURSEG_HOT_NODE] = 0;
+		c.cur_seg[CURSEG_HOT_NODE] = c.zoned_model == F2FS_ZONED_HM ?
+			c.devices[0].total_segments : 0;
 		c.cur_seg[CURSEG_WARM_NODE] = next_zone(CURSEG_HOT_NODE);
 		c.cur_seg[CURSEG_COLD_NODE] = next_zone(CURSEG_WARM_NODE);
 		c.cur_seg[CURSEG_HOT_DATA] = next_zone(CURSEG_COLD_NODE);
-- 
2.43.0.381.gb435a96ce8-goog


