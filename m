Return-Path: <linux-kernel+bounces-99679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2858B878BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438431C2119C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC5259B56;
	Mon, 11 Mar 2024 23:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbdwbjG7"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA20459168
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710201569; cv=none; b=uKjacML098Mx/pq1sKaiJPEcKTV9Cnk3il1PezSIXcExXaR6zvcf6MqNYYl7AVsuQxauLsC67rjI12e7lO4qF4A9Dd+08U4dgW4rT8vmkfA2ID1bDwwMGJHjG01lez7CVCM/4Zu1junDFebu+wp3ujogRKZPTj+uWvmoX47dIZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710201569; c=relaxed/simple;
	bh=T7M7NZEQRhhodetICIfYpWBR0HCAnaZGMFMsMEWrF80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fc+nebdHzmLG8sumRXWhNn+9TgrnLN+BcUBrg5uCflLPDYuQa9qAFndzgtyYy/5esI273u+9drXEPzlELPfpRgmNDAVR5d5xJRxSVdcTSt4LbteqOBLTq68r2pOSmBtK49K31ShMqWUzi31rS1bDoiF8NqilPWBJgqEzg2bEYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbdwbjG7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc49b00bdbso27555365ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710201567; x=1710806367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsKPWyHq5LYsk7GmH1W3pe42SNKM0nIJT896aTATdGM=;
        b=fbdwbjG7dMhxUpde9eCJ24tMKgdiwqjxMqzTQnrX10m5bdQ/08po95ox4aDygsH5sT
         EgthdUlHy1LGLu3+T3L8HBRANnxW7XAGVGpPbArMYHtg94UetXqUDBTkccvbJGfZNWx2
         JX0tiL3v6N4si2YWHxPEobRairTpiEbKO8NO2uBtacpN1ZogzW5O2f0Mi6ePIuzIu+8s
         mcRDVD2LkgT6cbSMG8k1r+CSdqEGll79o0qmoRFpzcNKC0pkEU27xMEAqnxlKGx6JfMJ
         eLpNQl5kJoBl+dCbFjmky25l1vPp11dnhHRQFOu1g770T49eeC3uTDP+hjLydSzptDKw
         VF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710201567; x=1710806367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsKPWyHq5LYsk7GmH1W3pe42SNKM0nIJT896aTATdGM=;
        b=IAK9dWFlOj4UA49FpaLdTTsJi+DpVxcZdV2HyUJlst0Cqug00q7HHyKhvOEJvx+5at
         IR5V7GqDDYgvTRQQmhO47wVUaCRWfOvuUOS1znHFkBaVHzIEuKlqkXHMn3TmxY8v/29Q
         UPm5KOzZKrSzoUoXL0Lhce+OAlTqcFqOD3QGufGhlJaBx3NjaMW8VyTxfHwHY4UTbq1m
         NXzdrdkUGEwRL74KepE12o6JDfRlSx7uP2vChRaZ0RrwvcVSU8UX1xhmiQkxxF2ZiRCC
         OVUZbDeVKNspJPC9WbSAPf8+08JMOBgDlNtB+aKok5kkl+F8gbRqHVwXb8rrUnIeVw6u
         uGFA==
X-Gm-Message-State: AOJu0YxbtX5SajuM4tsZvfhA/EiOzfTeV73Tr52wm4ylIew5Ah9oU7/f
	N+W5bzi2HQxznDgEe38L+LWbdXZzi23vrgLAVzsOev0lvGzvrOG7nDmAzB48
X-Google-Smtp-Source: AGHT+IF1ABXbK5i77LpXCYRbv/tMLOus7tMygDXhPh8Ov+wEPEEPpqo8jJgj3TyfgoigtHBBcQVnLg==
X-Received: by 2002:a17:903:2b0c:b0:1dd:a608:483d with SMTP id mc12-20020a1709032b0c00b001dda608483dmr3329862plb.1.1710201566787;
        Mon, 11 Mar 2024 16:59:26 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:d706:f56a:f0d2:75d])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902d2c500b001dc8f8730f3sm3473272plc.285.2024.03.11.16.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 16:59:26 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 2/2] f2fs: prevent writing without fallocate() for pinned files
Date: Mon, 11 Mar 2024 16:59:20 -0700
Message-ID: <20240311235921.1832684-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
In-Reply-To: <20240311235921.1832684-1-daeho43@gmail.com>
References: <20240311235921.1832684-1-daeho43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

In a case writing without fallocate(), we can't guarantee it's allocated
in the conventional area for zoned stroage.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/data.c | 7 +++++++
 fs/f2fs/file.c | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c21b92f18463..5e4c11a719a0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3378,6 +3378,8 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 		f2fs_map_lock(sbi, flag);
 		locked = true;
 	} else if ((pos & PAGE_MASK) >= i_size_read(inode)) {
+		if (f2fs_is_pinned_file(inode))
+			return -EIO;
 		f2fs_map_lock(sbi, flag);
 		locked = true;
 	}
@@ -3407,6 +3409,11 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
 	if (!f2fs_lookup_read_extent_cache_block(inode, index,
 						 &dn.data_blkaddr)) {
+		if (f2fs_is_pinned_file(inode)) {
+			err = -EIO;
+			goto out;
+		}
+
 		if (locked) {
 			err = f2fs_reserve_block(&dn, index);
 			goto out;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 82277e95c88f..f98730932fc4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4611,6 +4611,10 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 			return ret;
 	}
 
+	/* For pinned files, it should be fallocate()-ed in advance. */
+	if (f2fs_is_pinned_file(inode))
+		return 0;
+
 	/* Do not preallocate blocks that will be written partially in 4KB. */
 	map.m_lblk = F2FS_BLK_ALIGN(pos);
 	map.m_len = F2FS_BYTES_TO_BLK(pos + count);
-- 
2.44.0.278.ge034bb2e1d-goog


