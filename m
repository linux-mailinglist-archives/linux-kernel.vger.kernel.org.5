Return-Path: <linux-kernel+bounces-152873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218D98AC58A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80861F24283
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001184CB28;
	Mon, 22 Apr 2024 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVMy6d43"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BFB4AEE0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770717; cv=none; b=ONaSZ0tr2Y2dPJyhCdTiCltpDPzo9myFN+RXnflfviLWEtT/MtzthLQDChoFq++fQgQjbVECrs5OJAILvxC9ga4HPDDzmVvycpfWf+2ws30RAQxlvR6Q/upjUo4pHutXqsepslMtT0NSrdIAko14sYQSe1ORM/ts5fr2hZAB1oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770717; c=relaxed/simple;
	bh=EDcOlr+IXSRQzC67CmMiUWrT6tgVWB6LEzOR9zHRnqg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c6y2pkMmcY0OrhI2ekTdSjAoFzfDzganPH4lErbQqyhVODIATUWfhntE47lAdjRl0d5Hz2W7xQQgFS4Qma26wQBWytS4l6pfbJUJuEUBUxLyTs3LJ7ePWD+Hs7xqoya2SHxyKn4AzUwa4AMKQWu4RwZxIyP+El2XxnyjmzQk4cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVMy6d43; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de45dba157dso6940645276.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 00:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713770715; x=1714375515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GFcyxEC9zbVLPap6Ey9gG9OoDKAWEGSfij/agCtqgRs=;
        b=FVMy6d43K6gnbRNYkqijdJdtK0/iyqlLPjSJmTK16pVT4vLJv1ySiOvikzHufk2/0s
         tM8FDaf7ghlObrm85vA57+RM21bvQcTzD7NFHuw1tOcH5pI9B0+vmfh45HGZlRjXSipc
         rUojJk6idHABZe4K0Hox63xBEd7cUrwtK3pHR4mne5xFAevzsw//bopOG8jmUsN/E7EB
         H+yA5fDnJrrL31MOIN1jcPdskamNl/reSOZzVFK0HxHsHbzFrNuHMIzLWc7lV+WUkUm0
         YXlQ1S0Hb4t/evVywnEglFEyXenoRRJ5MJhsnPr5R+6zDlOTyT5EWA83oz7q735JdgQ+
         ivDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713770715; x=1714375515;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFcyxEC9zbVLPap6Ey9gG9OoDKAWEGSfij/agCtqgRs=;
        b=tu/cxZ2QrJNVDO0KHoqWzRK7gQGHUOM5GXLh/Mq/nzwU4rmlTInkM78c9lTKE/bSbk
         C7WemJOsjQvWHAP7mhNZ7h4CQ0yZuXU/M7BlAWV7ZpokYQ0Bl8BydXKaX/u6sSVgGcK+
         pNAJimnm2ZWHeNxFLF2QJYbkM/Y9gZriCuOMH1hVN0MxbXsbIUZ4gGIWPs3ioWILpDj9
         aXgVH7S2W3pd5cgI5+/YtydURUascL7pCPUAy70/zcIs2hNfjlFnO32pjHIJDphlJDYN
         FNG92xYcZUX5V0NCWfYIVfIa29XkNmF1d+/1oatM9X/CzUNgSS/T6IcoLCQrYcsgDqPt
         EvWg==
X-Forwarded-Encrypted: i=1; AJvYcCVqH842B3N/w+wI/rB6gGAV4/YslSW35RPefWTIRp/NJ7USSyu/tnFr0/WwRn6ONWxlTEG+Eh7WzmzxZaJGNRSUmB6Tjysa/VqW0jFt
X-Gm-Message-State: AOJu0Yxxb3wZ20AavkoudIyhyqCDnAsxC6kdoT9pdGOG9slv8xjkLq37
	nWYgiyOm8PgHJPIGDcYabHKdZYAMpjxzpB4s3jnuSiVfCO7E06AaQiJ6S3WbmSespa/NZFPXyRV
	HdsiB4A==
X-Google-Smtp-Source: AGHT+IEGFEdCCHbuaKhEU3U0OHmIQH6peL/wCW0VUPpxDYeKYiIvQgjR3u+Zdc6yZaJTLiExsft4+JYTrTah
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:59d7:73d5:a990:d869])
 (user=apusaka job=sendgmr) by 2002:a05:6902:725:b0:dbe:30cd:8fcb with SMTP id
 l5-20020a056902072500b00dbe30cd8fcbmr735816ybt.0.1713770714905; Mon, 22 Apr
 2024 00:25:14 -0700 (PDT)
Date: Mon, 22 Apr 2024 15:25:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240422152500.1.I8939e49084a6fef78496eb73edafdf3c2c4afbf4@changeid>
Subject: [PATCH] Bluetooth: btusb: Add debugfs to force toggling remote wakeup
From: Archie Pusaka <apusaka@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Cc: CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Abhishek Pandit-Subedi <abhishekpandit@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Archie Pusaka <apusaka@chromium.org>

Sometimes we want the controller to not wake the host up, e.g. to
save the battery. Add some debugfs knobs to force the wake by BT
behavior.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>

---

 drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8bede0a335668..846b15fc3c04c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -873,6 +873,9 @@ struct btusb_data {
 	unsigned cmd_timeout_cnt;
 
 	struct qca_dump_info qca_dump;
+
+	bool force_enable_remote_wake;
+	bool force_disable_remote_wake;
 };
 
 static void btusb_reset(struct hci_dev *hdev)
@@ -4596,6 +4599,10 @@ static int btusb_probe(struct usb_interface *intf,
 
 	debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, data,
 			    &force_poll_sync_fops);
+	debugfs_create_bool("force_enable_remote_wake", 0644, hdev->debugfs,
+			    &data->force_enable_remote_wake);
+	debugfs_create_bool("force_disable_remote_wake", 0644, hdev->debugfs,
+			    &data->force_disable_remote_wake);
 
 	return 0;
 
@@ -4702,6 +4709,18 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 		}
 	}
 
+	if (!PMSG_IS_AUTO(message)) {
+		if (data->force_enable_remote_wake) {
+			data->udev->do_remote_wakeup = 1;
+			if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags))
+				data->udev->reset_resume = 0;
+		} else if (data->force_disable_remote_wake) {
+			data->udev->do_remote_wakeup = 0;
+			if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags))
+				data->udev->reset_resume = 1;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.44.0.769.g3c40516874-goog


