Return-Path: <linux-kernel+bounces-46972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8696D844731
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16EC28DA80
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8FEF4F5;
	Wed, 31 Jan 2024 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl190URC"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3E520DDA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725996; cv=none; b=sAY7YUmmvsKJ1qmS717VKp4KpSJcvMOlqGQ/Yq/7fHLhLtGvujwT/b9JRmjzqQ9svaZpkHVS4riqW5Zsj5cf9XMkZFJTOR0npambtPn5bzsp/pbO6q7ScG6wwqjePHqKUxk5uhpLzr0+q5NFZCVjKxmxWzqIKXrPsrmAOPg+c4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725996; c=relaxed/simple;
	bh=MY8JtRhZcNmuRzCHA1QKNmscqeTHXjyq/nYHOBTf8h4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wry6jHJeWvN/CnOrcQbsAt62qfDzjKDoasoWI8kabaZtbfV0TjnW//mRy1kzKt69ZEb+mAURaTRFjzp1H2fns61afa6w706r0et6usch9HogL0YBrEFPVDB3+4qHP9/bsdksXc61/cn5qY1hdnftsIxAZADUFE2qgYR9Z1tx+G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl190URC; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6daf694b439so21058b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706725994; x=1707330794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i3HqJfEyYAV9x9E8qNujfqhtfVC27wsVyRT1JllQJy4=;
        b=Nl190URCinC3Sc+pHbOU9/lYkJYhdsEmut9iqqh7Hj97RMHNMXctHJ7kSHNd/3SSaA
         T5G6d6usK8bAgqpRXOXZaS/13zSwIXgisPSYyleZuZ796s4eZPyEfpyuUFz9jZO34hQR
         IbPRYeC6kLTM+prPz1ZwKzT+vvwkFSji+mJSi+M8dTgjYUbjxbOS1TBiHiLr8S3zT2ww
         X9qDFKnDxh76vz9SPuCIIQ5Fom6NlRVkHnmVaBwSA5whknOoY7U72xVlWFuxxWLw4peu
         Ms+tuLZFnc6Tqb5UGseIZ582HTdJfSaUPq1I8a3IHV9QSLZ/AU4FLWgwvPoyq+A6X2RK
         pqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706725994; x=1707330794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3HqJfEyYAV9x9E8qNujfqhtfVC27wsVyRT1JllQJy4=;
        b=cPpGW4LlLNF+K4yGRzry+eaEQCR2SHENvCmYDqIctT5h4fEE42Bogu8OzApOYUxO2x
         DIszPWi8eo3UZIIacU7y57gFXpPTn7lfNppx7X+DW0sSZbavlKulP0mA5AyKYd8kk41A
         13zpt+Tumrm29ykA3CQ87b01C4c2vLd0L1WQebIIRK9RrA3QNBkRtXQt9r3podUUENCt
         TuM2NCniLjh2qGZML0z8Ovyb3d2unZpo7mhdyUnnCrXoQDtC8tqhHrokQKblCuvIRkTh
         HT8stxvuq+LY/an0mTrILN3xAcNDP6rBxde5WZe7PbdA3sKkEwzf5Ta3xD20ZpBVMwcm
         dyjw==
X-Gm-Message-State: AOJu0YyfNuuxFAvQQDWq/8K2Ny91LRAUvHtJoNnkBJ47tqUnCPm0HZ3x
	EESbFIU62fpM1N/afCumloouONsxKGVdBAfKXdyC9dmvqgI9nKlYpPpf7xwn
X-Google-Smtp-Source: AGHT+IEXSr/QD1yLRkKwnlLJyr71HUl3kKXqwgQJE+B4DcZMVSYiefw7oL/qDvzE75jC1NHxL0JKHw==
X-Received: by 2002:a05:6a00:99e:b0:6dd:a0a7:ad9a with SMTP id u30-20020a056a00099e00b006dda0a7ad9amr3271685pfg.25.1706725993619;
        Wed, 31 Jan 2024 10:33:13 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:436b:ab62:1d08:45ea])
        by smtp.gmail.com with ESMTPSA id i21-20020aa787d5000000b006d9c216a9e6sm10300369pfo.56.2024.01.31.10.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 10:33:13 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs-tools: allocate logs after conventional area for HM zoned devices
Date: Wed, 31 Jan 2024 10:33:06 -0800
Message-ID: <20240131183306.536372-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
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
v2: make current segment numbers relative to main start block. check
    zoned block availability before the allocation.
---
 mkfs/f2fs_format.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index f2840c8..57ea9ea 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -558,6 +558,16 @@ static int f2fs_prepare_super_block(void)
 		c.cur_seg[CURSEG_WARM_DATA] = next_zone(CURSEG_COLD_DATA);
 	} else if (c.zoned_mode) {
 		c.cur_seg[CURSEG_HOT_NODE] = 0;
+		if (c.zoned_model == F2FS_ZONED_HM) {
+			uint32_t conv_zones =
+				c.devices[0].total_segments / c.segs_per_zone
+				- total_meta_zones;
+
+			if (total_zones - conv_zones >= avail_zones)
+				c.cur_seg[CURSEG_HOT_NODE] =
+					(c.devices[1].start_blkaddr -
+					 get_sb(main_blkaddr)) / c.blks_per_seg;
+		}
 		c.cur_seg[CURSEG_WARM_NODE] = next_zone(CURSEG_HOT_NODE);
 		c.cur_seg[CURSEG_COLD_NODE] = next_zone(CURSEG_WARM_NODE);
 		c.cur_seg[CURSEG_HOT_DATA] = next_zone(CURSEG_COLD_NODE);
-- 
2.43.0.429.g432eaa2c6b-goog


