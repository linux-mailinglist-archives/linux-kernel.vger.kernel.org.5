Return-Path: <linux-kernel+bounces-9627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4868281C8AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABC51C222BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7082168AD;
	Fri, 22 Dec 2023 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkPBiSPr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C0D168A2;
	Fri, 22 Dec 2023 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cd51c0e8ebso971771a12.3;
        Fri, 22 Dec 2023 03:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703242914; x=1703847714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IAuF7bFZaiA2XgfkF48tUoumueRVHVxfhhibupkaPcE=;
        b=FkPBiSPreOWWTFUZUP3B9r+2blYmQXxWdqU6UG+uvl8doUBB3vReRQTUhKM4j1/9y6
         DYNW70wMnd1S3/iBs9hRVujQQN1XHM8h0m1GjAmnhQqTC0F5TGC0Bqc6M1yHJ+GeVdVG
         /m0pwojzlrqzEBeA0j9dKnq0zyISrDEYDfLHJRGAuBakRNXUwsWneFMZsPX9nQUmpb7U
         5Cwe5VqoyxEgKF2yxy2mdjbXugpTOmDFizrp3+wYLATpKDhzsqbbTyo3MRWrS4Hjim9s
         Kw5UM1fg4eNauQIUqT35Te3JSa62zwfg9QhpVOJpcaWvZsWXBTf4etkAycbSvzqfk6ZO
         AKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703242914; x=1703847714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IAuF7bFZaiA2XgfkF48tUoumueRVHVxfhhibupkaPcE=;
        b=sYPBZG5zvOGT4Xu3OmatRlb62x23Ct3Y5/PVZqju94MgVi6iZ150YaAsUUA31Tdqbl
         oN7pbag3z0S6J8A8fDvjl9/OX8gfw5eUw1/3Hc7KSUNxQ2CAuM/s3uNfSfic1rXyOxS1
         6IPOPxBN/JjwPkvquPCucsG+vR6yW/ton/PMgJL6ha9Rlu1Keq57vG14enBviT836aRO
         aMBx4cgb4KHSCDI6rnZzAptkIh7/s53medwn+OXDudfkK4LdDHRNXAgWl+64rZkGGI44
         dUjINoL8fs1Eo1ZIwI8tL2tBOzyqdcRaVTU51iNn9+ikaA+WzfikQLKlq22Ktr1bCMe4
         biXw==
X-Gm-Message-State: AOJu0YzSuwe+/CZKtXyF9CZkeo7jWU+ogSvlfefAlwTdf+w+hXFOm2fZ
	s+/k8YnDYXXsakbSN2tktKuMFrxA11btFOKd
X-Google-Smtp-Source: AGHT+IGwKRk5cIFGwcfMmCHRCZJ5u2/TGeT2skB+XpOxjvTt5B3dQo5FdTCh/6LAlHckbVdTG8BIig==
X-Received: by 2002:a05:6a20:8f24:b0:195:1511:b29c with SMTP id b36-20020a056a208f2400b001951511b29cmr835290pzk.50.1703242913789;
        Fri, 22 Dec 2023 03:01:53 -0800 (PST)
Received: from g2039B650.. ([2001:da8:203:a502:3221:f470:cca0:93b2])
        by smtp.gmail.com with ESMTPSA id jc14-20020a17090325ce00b001d07d83fdd0sm3204283plb.238.2023.12.22.03.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:01:53 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Gui-Dong Han <2045gemini@gmail.com>,
	stable@vger.kernel.org,
	BassCheck <bass@buaa.edu.cn>
Subject: [PATCH] Bluetooth: Fix atomicity violation in sniff_{min,max}_interval_set
Date: Fri, 22 Dec 2023 19:01:47 +0800
Message-Id: <20231222110147.9287-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sniff_min_interval_set():
	if (val == 0 || val % 2 || val > hdev->sniff_max_interval)
		return -EINVAL;
	hci_dev_lock(hdev);
	hdev->sniff_min_interval = val;
	hci_dev_unlock(hdev);

In sniff_max_interval_set():
	if (val == 0 || val % 2 || val < hdev->sniff_min_interval)
		return -EINVAL;
	hci_dev_lock(hdev);
	hdev->sniff_max_interval = val;
	hci_dev_unlock(hdev);

The atomicity violation occurs due to concurrent execution of set_min and
set_max funcs which may lead to inconsistent reads and writes of the min
value and the max value. The checks for value validity are ineffective as
the min/max values could change immediately after being checked, raising
the risk of the min value being greater than the max value and causing
invalid settings.

This possible bug is found by an experimental static analysis tool
developed by our team, BassCheck[1]. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations. The above
possible bug is reported when our tool analyzes the source code of
Linux 5.17.

To resolve this issue, it is suggested to encompass the validity checks
within the locked sections in both set_min and set_max funcs. The
modification ensures that the validation of 'val' against the
current min/max values is atomic, thus maintaining the integrity of the
settings. With this patch applied, our tool no longer reports the bug,
with the kernel configuration allyesconfig for x86_64. Due to the lack of
associated hardware, we cannot test the patch in runtime testing, and just
verify it according to the code logic.

[1] https://sites.google.com/view/basscheck/

Fixes: 71c3b60ec6d28 ("Bluetooth: Move BR/EDR debugfs file creation ...")
Cc: stable@vger.kernel.org
Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
---
 net/bluetooth/hci_debugfs.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 6b7741f6e95b..f032fdf8f481 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -566,11 +566,13 @@ DEFINE_DEBUGFS_ATTRIBUTE(idle_timeout_fops, idle_timeout_get,
 static int sniff_min_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
-
-	if (val == 0 || val % 2 || val > hdev->sniff_max_interval)
+	
+	hci_dev_lock(hdev);
+	if (val == 0 || val % 2 || val > hdev->sniff_max_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->sniff_min_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -594,11 +596,13 @@ DEFINE_DEBUGFS_ATTRIBUTE(sniff_min_interval_fops, sniff_min_interval_get,
 static int sniff_max_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
-
-	if (val == 0 || val % 2 || val < hdev->sniff_min_interval)
+	
+	hci_dev_lock(hdev);
+	if (val == 0 || val % 2 || val < hdev->sniff_min_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->sniff_max_interval = val;
 	hci_dev_unlock(hdev);
 
-- 
2.34.1


