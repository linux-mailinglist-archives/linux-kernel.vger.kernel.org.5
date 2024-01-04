Return-Path: <linux-kernel+bounces-16610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C03B4824114
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21351C2178C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7C02136B;
	Thu,  4 Jan 2024 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DsunAFqk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D2E2135C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so956744b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 03:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704369433; x=1704974233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AaeihiujCSNV/IpYyiqh1GWzfHkk93j+fBxfYGSZUOs=;
        b=DsunAFqkdVuIlLhHUHLGKF2imFxqdZhNXhfkQ57iaq+AFbsPjHVdoWq3TtB0YhOTVG
         6PFVEqjvtzF3DrDVjTrVduIem5q3cesAEgb9yBXlaHDnUWLsHleu6wlKXEc+tjykIgZg
         9DKFp3LQ/M+HiMrGZ0ISK56z1K2mOD4MfRKV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704369433; x=1704974233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AaeihiujCSNV/IpYyiqh1GWzfHkk93j+fBxfYGSZUOs=;
        b=ia3OomvWHMtU9EtWu/uLRfrYmHkEfjMxnQy08/uMqghpO9rupBD8TTmjrMs+rcs9Ea
         ULnVQ7zhABGwwLwPvFUGBAL16Jb5j+VnmaXW/KqYxIHVNDVTXL037cLbLbWMzbl9bqTL
         D0MiWSythNcOlxFL7pEwMabwNsx+g+IXevBIudnpqTBIA6kprM3NfGi5dgL5fROcZhfw
         oZZ/0GHAzzut8K+p3y+csTeACpuGC/0bir4RR7aP1uhE4F3bty1eitm7iWEnR//aj3n+
         On1ZYSKzl4eKUKMwlJIOX1VzcFHsi1cXPMrqpoH3Ckcy9SPJDjGQNTpWsfty2U6kEuz3
         MwPQ==
X-Gm-Message-State: AOJu0YzfQbD4YMvUDcd+v7Ny6NT/BQdPOGgqDkY55pWclYmEtrM2pjBv
	Pd2j0qFXfWcQAtGIcskombPg2kaUPwa3
X-Google-Smtp-Source: AGHT+IHXkr/lgGawhP6uKQwmf9t+Yv57Xaq8+wG8HiAtDS/7poRekELI+OR7MUJW3fS+iC7hR4Rn2g==
X-Received: by 2002:a05:6a20:be1f:b0:197:33ea:f45 with SMTP id ge31-20020a056a20be1f00b0019733ea0f45mr423598pzb.60.1704369432702;
        Thu, 04 Jan 2024 03:57:12 -0800 (PST)
Received: from localhost (231.137.80.34.bc.googleusercontent.com. [34.80.137.231])
        by smtp.gmail.com with UTF8SMTPSA id fn1-20020a056a002fc100b006d9a0902934sm20668062pfb.70.2024.01.04.03.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 03:57:12 -0800 (PST)
From: Ying Hsu <yinghsu@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	chromeos-bluetooth-upstreaming@chromium.org,
	Ying Hsu <yinghsu@chromium.org>
Subject: [PATCH] Bluetooth: Avoid potential use-after-free in hci_error_reset
Date: Thu,  4 Jan 2024 11:56:32 +0000
Message-ID: <20240104115453.1.Iaa08c695d3dcf819910ea723c3eb502935638172@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While handling the HCI_EV_HARDWARE_ERROR event, if the underlying
BT controller is not responding, the GPIO reset mechanism would
free the hci_dev and lead to a use-after-free in hci_error_reset.

Here's the call trace observed on a ChromeOS device with Intel AX201:
   queue_work_on+0x3e/0x6c
   __hci_cmd_sync_sk+0x2ee/0x4c0 [bluetooth <HASH:3b4a6>]
   ? init_wait_entry+0x31/0x31
   __hci_cmd_sync+0x16/0x20 [bluetooth <HASH:3b4a 6>]
   hci_error_reset+0x4f/0xa4 [bluetooth <HASH:3b4a 6>]
   process_one_work+0x1d8/0x33f
   worker_thread+0x21b/0x373
   kthread+0x13a/0x152
   ? pr_cont_work+0x54/0x54
   ? kthread_blkcg+0x31/0x31
    ret_from_fork+0x1f/0x30

This patch holds the reference count on the hci_dev while processing
a HCI_EV_HARDWARE_ERROR event to avoid potential crash.

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
Tested this commit on a chromebook with Intel BT controller.

 net/bluetooth/hci_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 65601aa52e0d..a42417926028 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1049,6 +1049,7 @@ static void hci_error_reset(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, error_reset);
 
+	hci_dev_hold(hdev);
 	BT_DBG("%s", hdev->name);
 
 	if (hdev->hw_error)
@@ -1060,6 +1061,7 @@ static void hci_error_reset(struct work_struct *work)
 		return;
 
 	hci_dev_do_open(hdev);
+	hci_dev_put(hdev);
 }
 
 void hci_uuids_clear(struct hci_dev *hdev)
-- 
2.43.0.472.g3155946c3a-goog


