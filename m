Return-Path: <linux-kernel+bounces-63979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CF885375B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D511A286275
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4861E5FEF6;
	Tue, 13 Feb 2024 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jSyTHznY"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD865FDD7
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845068; cv=none; b=ef6NrFd226Ikpl6lvLHI9f46kGG0QD/cDAs+nuOb3euLukjYEIrz4eBof2ushdmwQjDJdGnd4s7FApDkkVUFmkFPtM6H/EqRdcnLK+e6OinRyj5GXrH9kDvVCmKGnj/HosZhpA23EttdqNpkzTFEX3cGXvnHKOwGuElT8/zkP4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845068; c=relaxed/simple;
	bh=dAcS//bN5EUl0rmpd6MTRSeVq9WzyY8e6NY4x+P70zw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzmCoHnX1qoWSfyL8H9hlmOfkU7OtIEHzuIk+q9pxx2H64Hug9yHzsRFsRxCx7ZOHC5laFNt3HCSP/ShRZyAGNkaPdwNnTM2qumaY+nrNBSE6JQgWfJr5ZVrkQ750VVb2JIUUTm1PnSKSuzzSqblm1KMYoPDsi2ek4fEKzSWqHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jSyTHznY; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e104196e6eso404608b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707845066; x=1708449866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8XLUuSB3OMz4OtDEw/wq9wIqlJoGF0PKwvDRzd4XmEc=;
        b=jSyTHznYTizsJJLkDBNnEn1tFnEEfimEe8x37UwmjW5wso19x10HZZY61wY78EdTrW
         9DyOEA5wzzD5R34w2VihyXRZklBwkrVUFT593Rfr1S3C2wxXn9aiFM5ujSdmB6503qjx
         q59YdCMVaSulr24jKgyFXy9WDopCwJdtmwL04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707845066; x=1708449866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XLUuSB3OMz4OtDEw/wq9wIqlJoGF0PKwvDRzd4XmEc=;
        b=miPKVJz0Uf7YEDAq7unrmU+tHCmxQ6vgZ6a/Z3obOl2i+SE5jI6eiHhZfq4Llue9tE
         yZ5Yuum0zMB+qpacxExSvNE/6uFVFhL5afomWXIFRUAHtPeIVznJxHsfTGGU+9Uev0K/
         GWwCyI7HwoC0YTRHye0OFEPrfeNLQRt6tjso/+LiICLRBOLZcuBBVKRqgOpWczmVr3nZ
         u6m9mytOu+X/Gtk4gX+zxziTKl+8+DpiR/jgcIL/+dqKIuFzO/mpCq01oHpMFFoDe1Lx
         djWC5D23UtmTRznNNheizTBcW4/NmI2BYUMEaFgm96NWq1IHDXnn4XbNukxnp1zPWsF7
         Uumw==
X-Forwarded-Encrypted: i=1; AJvYcCUxCseYQYvlJ7eeEyi3g0E/HOOG4TWJGg1u0WgWhUR5++STIhlW1QE3e6vZYfLb95Yr5/jgmxoTUoTsDPW0wwSOeuOSaCpMha5ifb8d
X-Gm-Message-State: AOJu0YxklRulNAtZ73/WL8zNt8nyLBHYphiJfxZPsNdXyYSapHswyiuc
	4Ttki6vIE2snm1eYTWzmTuopjaGGLCNB5ZgPzSlre4edTNzk8YDcPGXZQDJhtg==
X-Google-Smtp-Source: AGHT+IFdmIO9hfCRggCQg8+KevN9Tmla+FFn050mODC8Y8KpOKXoFLl2B6fcd42BXxVy7VjHKSh6ww==
X-Received: by 2002:a05:6a21:3115:b0:19e:a270:e766 with SMTP id yz21-20020a056a21311500b0019ea270e766mr335577pzb.5.1707845066416;
        Tue, 13 Feb 2024 09:24:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3gdAZrMiwHKmpifH8I6waLmgmEwpS3trwB7VFLzXrxjOa5uNlGnMgRca14Hzd+QYpdvWYn5n9Liwb5rPRx6lgYUkHDUn2+cbT1jg1pJ5Q0cr3NA51wno716+wCz+1Ky7mnxQeNPx+XU919MMCJJL8nnt5gANYBIT/TVmz9WT2lovM+AK+ftEDGREWJSau0qCrGqe62uHuDdpTb6Nd+c96QUpwVeMd
Received: from localhost (253.78.80.34.bc.googleusercontent.com. [34.80.78.253])
        by smtp.gmail.com with UTF8SMTPSA id o21-20020a637e55000000b005c2420fb198sm2672177pgn.37.2024.02.13.09.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 09:24:26 -0800 (PST)
From: Hsin-chen Chuang <chharry@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: chromeos-bluetooth-upstreaming@chromium.org,
	Hsin-chen Chuang <chharry@chromium.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org
Subject: [BlueZ PATCH] Bluetooth: hci_core: Skip hci_cmd_work if hci_request is pending
Date: Wed, 14 Feb 2024 01:23:29 +0800
Message-ID: <20240214012328.BlueZ.1.I10eda6f375bc8dfedf4eef3a8cf6572c65803afc@changeid>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_cmd_work overwrites the hdev->sent_cmd which contains the required
info for a hci_request to work. In the real world, it's observed that
a request from hci_le_ext_create_conn_sync could be interrupted by
the authentication (hci_conn_auth) caused by rfcomm_sock_connect. When
it happends, hci_le_ext_create_conn_sync hangs until timeout; If the
LE connection is triggered by MGMT, it freezes the whole MGMT interface.

Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

 net/bluetooth/hci_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 34c8dca2069f..e3706889976d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4213,8 +4213,11 @@ static void hci_cmd_work(struct work_struct *work)
 	BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
 	       atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q));
 
-	/* Send queued commands */
-	if (atomic_read(&hdev->cmd_cnt)) {
+	/* Send queued commands. Don't send the command when there is a pending
+	 * hci_request because the request callbacks would be overwritten.
+	 */
+	if (atomic_read(&hdev->cmd_cnt) &&
+	    !hci_dev_test_flag(hdev, HCI_CMD_PENDING)) {
 		skb = skb_dequeue(&hdev->cmd_q);
 		if (!skb)
 			return;
-- 
2.43.0.687.g38aa6559b0-goog


