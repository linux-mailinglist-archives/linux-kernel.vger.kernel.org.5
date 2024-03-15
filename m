Return-Path: <linux-kernel+bounces-104511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC1A87CEED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985A4283E91
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3120445030;
	Fri, 15 Mar 2024 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HwCNqalG"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A7D3FB8B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513002; cv=none; b=Q7dLziQIBwF+QW61txMqUox9JdmiWELhBbGC5cfC1Q2vaXfpBgGyXa5pbRlpq7y3E8lc80eDGuMumUIn1azk7jwTy6rFSUBM1Ge/oMd3RUA6b/HGvLaWrxy5yFoKGGudrD3VLUUd6HNSPnsaiwP6XfI6DDGwh4F99uMrCnQrEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513002; c=relaxed/simple;
	bh=KfYUBD7UBkzcBcghQDhrh4UXWg6wcsJSwijPDwGd+xc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XDRBG8qoB2ud2Oph8jOcOCXOBKCKRl8K4p51Nxc6lwnQqZSy3k1Ydzdm5htJ1l3lmp/UdjrooCLLpRO9wOTiWDgwP6vFfDtw+cZqkK2zqcEI/w+QY5I60IsFJfNO8r7Ek+kgZnvxs+GdeMyWsaKyjc68UjNC/rqJxFgRSwBzFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HwCNqalG; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a46682e71a9so198157866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710512998; x=1711117798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=26x5Ax6QaYFW/lMxTgpz/jUxgNJVrtQaQeSP0hgClqs=;
        b=HwCNqalG9e38Unx0blfPCy7hKTXJXIfw/xLgPb5GLE6RNWVa2gUMjnOxs+QF0KNJyY
         oKuOFm1zxJh/INpx6YWniq6GkotQkReSO35ln5oL7QsJMyoYwBtHebuczvkAtw6I/+gd
         fwfSweriXw0W27J3ZoQgRIlue6cUQPToraG+DRgt7xe18Yy29TLFrgghGlOVMlPdiVD6
         zipng7eC/es7xo1wBg+NVaeUPqqF8PoYStIsqxN+qdzeJrcyiE8d5lvNAHTff+/Vk/mz
         n3hJ9nDDPPp6dFcSEtf+ucaHVFFd6rz2ksIcJJRzkmovzdMNhIMqTEJ/g0l51aj0Q0pe
         8o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710512998; x=1711117798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26x5Ax6QaYFW/lMxTgpz/jUxgNJVrtQaQeSP0hgClqs=;
        b=Vz47noChkjkzDiBHFxanfUWDwbEjy274mFJuKUu1FDOxD8O1oVVLt6KCYoeZV+kyTy
         e6vpmu+6XNFswblBUq1gcq8aRkXuWxgWyuZQ7pz2ftH3Jzay5RSE/8VWAJFKSe9rL7Hz
         orGPl/dkhs1hoNoWFCH8FYXfL2TzuSOtq2JWhGfdxBlZbB1/KLc84mYL13SU2gad/BfV
         bHWb4pmut3sY7kXQfWcGOEqgI8vnbyiFFO4NTG/Uw+/gm1NaTf+M7lrTbJSdYr4DlW1K
         yw3Yp4uWPkMrfDA4E3JZKgHIF7nwCHHrgmlkFo8+zVOq0pw0U9OSz0/OUULMr8TNChlV
         8pHw==
X-Forwarded-Encrypted: i=1; AJvYcCWx0lF7xERZCaxU/AH3HSgqd0I1eN4xg0SqwAvIPzpko+NzbNkJJBpGK2K4cQAg/RlC6NGPUy2P3hdi2wI7DPQw1o/UkyC2ef3mtI93
X-Gm-Message-State: AOJu0Yw2v9ngly1G7A938sV9JeI9f6G5pmnXLUd6gwg/ppr2SJAUcrqJ
	5yfgyC+FY8Mk45yWJN3hHttn0c2B5e+QuMbfoNjlwB5thjGFPE+5tBzpllz4OwA=
X-Google-Smtp-Source: AGHT+IEZqEc+qFGuULCGQaqf2Z6e4zQ1Np1mSGjmmzxskLbaDmx1sdHG1RUdJKKtsyZZdnlj6/7Lbw==
X-Received: by 2002:a05:6402:1f04:b0:568:a30c:2dae with SMTP id b4-20020a0564021f0400b00568a30c2daemr3938824edb.0.1710512998347;
        Fri, 15 Mar 2024 07:29:58 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id y14-20020aa7ccce000000b005653c441a20sm1726147edt.34.2024.03.15.07.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 07:29:58 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	mforney@mforney.org
Cc: stable@vger.kernel.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] Revert "ext4: apply umask if ACL support is disabled"
Date: Fri, 15 Mar 2024 15:29:56 +0100
Message-Id: <20240315142956.2420360-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 484fd6c1de13b336806a967908a927cc0356e312.  The
commit caused a regression because now the umask was applied to
symlinks and the fix is unnecessary because the umask/O_TMPFILE bug
has been fixed somewhere else already.

Fixes: https://lore.kernel.org/lkml/28DSITL9912E1.2LSZUVTGTO52Q@mforney.org/
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ext4/acl.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index ef4c19e5f570..0c5a79c3b5d4 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -68,11 +68,6 @@ extern int ext4_init_acl(handle_t *, struct inode *, struct inode *);
 static inline int
 ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
 {
-	/* usually, the umask is applied by posix_acl_create(), but if
-	   ext4 ACL support is disabled at compile time, we need to do
-	   it here, because posix_acl_create() will never be called */
-	inode->i_mode &= ~current_umask();
-
 	return 0;
 }
 #endif  /* CONFIG_EXT4_FS_POSIX_ACL */
-- 
2.39.2


