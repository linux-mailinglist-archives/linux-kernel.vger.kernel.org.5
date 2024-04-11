Return-Path: <linux-kernel+bounces-141482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDDD8A1ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433FD1F2ABC9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6780F41744;
	Thu, 11 Apr 2024 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mB9eXMwy"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89713205E08
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712860680; cv=none; b=GKHrNodcsGuD+QAamAAy3CT0161Py20/uVgnXvvTuU5rdMZmkI/jSnDrqalxZkGq6OHc7sIsLgbziKtWUMCe/lrwl7RUmnZdoHEYJiMidWNRw3oOtJaUp05dvmsbHTyGnfpDwRTdg7hu3UMulldlY4hq+NijLO3sAYwY4umNYis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712860680; c=relaxed/simple;
	bh=BpACbSrmSMoqNqBdpG0z/OKxklof9d12+VKJaf/W8wY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uaQh48Ibf7K5sH3C1rvRzcB1zHPKJ36wsZjadw45qfMtaOC+q0VDNy46712TOMXD31//cIJqHJpOIEZw2xY6uTxPNpR1jdtMVotj/Nfa0awsWkGDv2MgPiog/1iAzv8CIZ1kliESh5i8IqgdKR8mIEp+DPrn5lzRHhSRHZgY464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mB9eXMwy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e2b137d666so1279885ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712860678; x=1713465478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XKRQnKissdHCzmGNa2PV/255DMDi6uK/FNddjpC3dpw=;
        b=mB9eXMwyGgD61+5SnKWtkpWFK61RW9NnXyIjhlGs8DGdO/LrivY4TLv5raVytOnrc8
         Nt8qQBI/S/vuiyKBSWRQXOaGS9bST0TVcFKCcw2k0BWmSPrULFutHaG7SwQIBL4as5xl
         WQCifxoWgOxWKFHFUHn/8zss8Ckdb4E1ZZ1bpAAwVRm7Ny6mF+5cNUtT6j/aROsbFcN8
         Z1oaQ5eThUzJb1Gh70zu7+ikieT9rXsLJA0EiWdeZB1OkGpJjZ0r8E0deBva8m4VeMgo
         J2D0rHgCl0gfkF/WlsIPVRASRtQiBstcV8Htf7RlfvxzCdib/oYWKcmtUdzV/dEMXhJZ
         mCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712860678; x=1713465478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKRQnKissdHCzmGNa2PV/255DMDi6uK/FNddjpC3dpw=;
        b=JNrG/92K388HQVmB23bs0/4b0G5cxAO0mZo/wSnQRHpjmmsK4rb/C/ZF52kjURbL95
         CEkEdzSwIQ+TtqQdW4ldUjRtPZ35jsSA30n3PKAVxs+ZfUbhv2C2Kg006QxsgOHuQ/yk
         P6G1wSHViUwekLy4dNT/JFhDTmyMi4tOKN5EUhPpYMGKGQ39RVAp/xnHdhZSoGajP7J7
         hiz3t+I5IDLHEdBdQ5XqvCSPMGKyDyIZ4er8GaCoWV0UlbGYY8jbjeyBag2YkNkvxir9
         bnJOh4xSs9JuOW4P35VBYh2PpEue+WpDm69ilAGc6nIPV4iVaBdq6HX5L9ce+EW6Vd1N
         +7ng==
X-Gm-Message-State: AOJu0YxVnAszz/fc7ja39DrDBThSul1niEzh6gbPeiKpur+hQp9PzBQj
	DoQcH8SQNsoBtGhnT1s0BKQWpptUNokK9RFdKioL2lcPHP98GzvMo+b81A==
X-Google-Smtp-Source: AGHT+IHJi3RIP7UZY7UtB+xmE16TsC8pukDMA+4xkNNmB+DzJ+cIUjpElTTwSZwvMrAJDWzMVnCEWw==
X-Received: by 2002:a17:902:780a:b0:1e2:a42a:af5d with SMTP id p10-20020a170902780a00b001e2a42aaf5dmr317714pll.30.1712860678506;
        Thu, 11 Apr 2024 11:37:58 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:e309:9090:b8ac:35b1])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902a38600b001e425d86ad9sm1519906pla.151.2024.04.11.11.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 11:37:58 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 2/2] f2fs: allow direct io of pinned files for zoned storage
Date: Thu, 11 Apr 2024 11:37:53 -0700
Message-ID: <20240411183753.2417792-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Since the allocation happens in conventional LU for zoned storage, we
can allow direct io for that.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3ee61bc82c6f..c8e086077a48 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -833,7 +833,8 @@ static bool f2fs_force_buffered_io(struct inode *inode, int rw)
 	 * for blkzoned device, fallback direct IO to buffered IO, so
 	 * all IOs can be serialized by log-structured write.
 	 */
-	if (f2fs_sb_has_blkzoned(sbi) && (rw == WRITE))
+	if (f2fs_sb_has_blkzoned(sbi) && (rw == WRITE) &&
+	    !f2fs_is_pinned_file(inode))
 		return true;
 	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED))
 		return true;
-- 
2.44.0.683.g7961c838ac-goog


