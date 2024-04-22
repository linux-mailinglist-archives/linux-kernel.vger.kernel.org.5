Return-Path: <linux-kernel+bounces-152871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672E78AC586
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DEB01C20937
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D48C52F62;
	Mon, 22 Apr 2024 07:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RL8CBo9E"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423E751037
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770678; cv=none; b=LfqUqGtAErEeNrp3dwZRSYBKNyGFt0ojmPZt26VrxAMIW6xxRFa6HkaAHF+EnEWVwUIMLLaVjSOWl3cR2ACXuBa9rwfapkxsa3irda90Q29B/dJUHiua7hEoaaCBbdbXRk9TCgCxgQW87ITwL/ox+vdTgEbOxC7PSOu4XzxdNkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770678; c=relaxed/simple;
	bh=dpgOmQJHRrHOsYFgWaLnsjp9j6Ut9V7hlwOOQWs5FWQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pNgzYdaigqOfX+/WngK2hhibAhMFJ8zvh9wX9GVDGBvCLIjcMKWIZOotF3WT5ctnYYVmH7EEuNAUJNOB/N0FXiITXOArA9pAlvyoL4HhMB20LXVQ+cnMulXRxvBqG3kbcTQfS71G3/xs26Qq5b0MhwRldwjUMmGqTHz3imtO5h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RL8CBo9E; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de45daf49deso9440726276.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 00:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713770676; x=1714375476; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i9wOGbBfat1hzQwTRQUOOQ0qZfxZpdbfky7UyfMjHY0=;
        b=RL8CBo9ESvvBEBmUy5HVNnW1d1umQxu+ZB4iQ2x3VpRAPEFC9wb8C3/2v4JAnSCHMP
         ZdbrPtXLS+/FemPXQiY2z586oSZ8ayiAkizy6buffwUV7n9HA+Mu2TwmrlPOy+95BHYB
         9lD4T4CsdQPdminAwivWiXZPFumwRnGjMCVF/uUErruhTVg4kO8eUPj75awZb1TlflkX
         2M+Wg8YZKiWXXjmt5yYTifm6JO8gTuKIeWb3+T6qmAj3lAhFRVInCwPnBcuZ0fNYGzns
         QczV1YDs5MbNlD/wMCHgv43vGhJXOqRNnco/NMVinihogTfViaHCzqO32lFda//wqBlq
         yx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713770676; x=1714375476;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9wOGbBfat1hzQwTRQUOOQ0qZfxZpdbfky7UyfMjHY0=;
        b=qAcEXgGdZN0htnFTxRDsSYg2xbQG4d9GPgWezMp4Gl302iCZM/YRUCLbSwNySIomRi
         Zf2ZdwkbcI5fYzhGMo/Ijxed5UY+ahMMXPoNIzGhKp+Wa8rYoZasfghvOWCkpQwdKruT
         gszZJJKyuyQXXP33ar8mY/Rn/t3UGNy8zXPUH+DWL6ZD/gHEj9BE5dtb0DjJCs6vVr8y
         xSYJ3AoUVlIQ2AOkg9XqVhISnQO5tyTUBuL/rRZHwSqsBT6qYztyOA9Cwax/t2a34I1s
         3MDJ4zlUbEB2No/KQ/HVRFVfBNza8GTxRxII9xKWh9qfRiz3IRZZwhoWW6bOmmshdpe1
         quPg==
X-Forwarded-Encrypted: i=1; AJvYcCWWP+OTXHKfmHdbR1jh9ylx6LoEhad+FOiOPZ1ab7IBSWOJj/lbSiTRR5gTdcJ6XvKEe3n4txNH5jLRiyJh+6ir3Ly+pp67HqkYcsJX
X-Gm-Message-State: AOJu0YyJjRy3zfXqrMGqvjl1XaUFaOatsyd07+EZcCSUOVony6PEcyJu
	m79PcxeHz2bYmjjRtKmmdvIirFH2RoR8r27sR0ipQUPQjoZOBoTJv5+iF2xhIizbRuDeVEL7BRg
	K2li4Gg==
X-Google-Smtp-Source: AGHT+IE/hTCb8Slwze2loKhFJ/zmVV1DW7WbkF5OHZy4fac2xvijx0KJZp+i9C6xdb+Gib9KNLezOi0V4aQV
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:59d7:73d5:a990:d869])
 (user=apusaka job=sendgmr) by 2002:a05:6902:c0a:b0:de5:2694:45ba with SMTP id
 fs10-20020a0569020c0a00b00de5269445bamr759614ybb.0.1713770676156; Mon, 22 Apr
 2024 00:24:36 -0700 (PDT)
Date: Mon, 22 Apr 2024 15:24:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240422152413.1.Ib96985e197f3db620a127a84aa20f3f3017aaf57@changeid>
Subject: [PATCH] Bluetooth: Populate hci_set_hw_info for Intel and Realtek
From: Archie Pusaka <apusaka@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Cc: CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Abhishek Pandit-Subedi <abhishekpandit@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Archie Pusaka <apusaka@chromium.org>

The hardware information surfaced via debugfs might be usable by the
userspace to set some configuration knobs. This patch sets the hw_info
for Intel and Realtek chipsets.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>

---

 drivers/bluetooth/btintel.c | 9 +++++++++
 drivers/bluetooth/btrtl.c   | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a19ebe47bd951..dc48352166a52 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2956,6 +2956,11 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 			err = -EINVAL;
 		}
 
+		hci_set_hw_info(hdev,
+				"INTEL platform=%u variant=%u revision=%u",
+				ver.hw_platform, ver.hw_variant,
+				ver.hw_revision);
+
 		goto exit_error;
 	}
 
@@ -3060,6 +3065,10 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		break;
 	}
 
+	hci_set_hw_info(hdev, "INTEL platform=%u variant=%u",
+			INTEL_HW_PLATFORM(ver_tlv.cnvi_bt),
+			INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
+
 exit_error:
 	kfree_skb(skb);
 
diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index cc50de69e8dc9..4f1e37b4f7802 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1339,6 +1339,13 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 
 	btrtl_set_quirks(hdev, btrtl_dev);
 
+	hci_set_hw_info(hdev,
+			"RTL lmp_subver=%u hci_rev=%u hci_ver=%u hci_bus=%u",
+			btrtl_dev->ic_info->lmp_subver,
+			btrtl_dev->ic_info->hci_rev,
+			btrtl_dev->ic_info->hci_ver,
+			btrtl_dev->ic_info->hci_bus);
+
 	btrtl_free(btrtl_dev);
 	return ret;
 }
-- 
2.44.0.769.g3c40516874-goog


