Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9189380AE99
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574772AbjLHVHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHVHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:07:08 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D295198E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:07:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db5508d1beeso2740993276.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 13:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702069634; x=1702674434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=atKYixDgc1IYLIAixNFTtgRe8JLDt6J5MMwxSW6b7Pg=;
        b=r7BdHG8VStUbm+h4QyUFMMRIhoNDnQY0D3t/d7dmkMDYDKOyP4v1tYRszFTXTUO31n
         MxsZetvujkvUK41OaJBcqx0zUSrEdjFPyGJPUMcPxJK1oteunVwzTg48fuUuRaJAyy6d
         7NWpv1EzHYhMIgyS6r57tlO22qtO711ZfbkMCADPpV+OPF4klJnRZ+1UBbuOSSarB3G8
         NBAYeJHhb0DQHxsgNwPLd9ozu0J8gQMWNTD7YSwswLPzdhF+p2qVNWx/fzAendxYXIWJ
         pM63C4V06AW4dRnquvD5EepNv8eamaMt1UunBvdTvkKPajW05e5VgtXtEOyc1wcAMmMp
         Bh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069634; x=1702674434;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=atKYixDgc1IYLIAixNFTtgRe8JLDt6J5MMwxSW6b7Pg=;
        b=Qy/xVF6zF0tRqgA4TLlu8MzuwDAs8bzK6PxfeCcpxlE5cKrurL8wDhZPL29nH+vQio
         y1lclAYz9vZayy7zBx0edKhFe8hnjwzL3s/NJsAUy6vMmFLKmq5WkNHlixtM4IbgBc47
         bLPELV//T+uPW5fsJcuVaEGX14BAG2UL1sGRs4sF7rmqYhHcJGivan9rkgSC1fmLfd8O
         Uz8dYKmsoGUtvSouKOl60pzLIqAJRWeKKVoGWx0L7bIyJveLRnAVHVJlezaSq+igk4Fk
         5X5W9QY/hQIrPZWJfipDVHdXQZKP8sQlWRY7aljWVSsdsexGptrMJd8Do5QIPd/cUuD5
         PcIw==
X-Gm-Message-State: AOJu0YztWC9H12zz16+nAZrMPFsjR2EDciYMCO0B0GlOjqs50uRHlfeq
        /4zixM+BpUbDYSOIgN0Bh+8j2K52Jt4b
X-Google-Smtp-Source: AGHT+IHzeDvqNFdRZWKrYRWtX4T16qXBWuRFYuGxk14i3a32wrWAEXwhbb0Cto5r9VdTV4zgSQTlXO1gQzao
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:38e4])
 (user=jiangzp job=sendgmr) by 2002:a25:ce4e:0:b0:d9a:61d2:38ca with SMTP id
 x75-20020a25ce4e000000b00d9a61d238camr7101ybe.10.1702069634325; Fri, 08 Dec
 2023 13:07:14 -0800 (PST)
Date:   Fri,  8 Dec 2023 13:07:06 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208130705.kernel.v1.1.Ic5024b3da99b11e39c247a5b8ba44876c18880a0@changeid>
Subject: [kernel PATCH v1] Bluetooth: btmtksdio: clear BTMTKSDIO_BT_WAKE_ENABLED
 after resume
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always clear BTMTKSDIO_BT_WAKE_ENABLED bit after resume. When Bluetooth
does not generate interrupts, the bit will not be cleared and causes
premature wakeup.

Fixes: 4ed924fc122f ("Bluetooth: btmtksdio: enable bluetooth wakeup in system suspend")
Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Clear BTMTKSDIO_BT_WAKE_ENABLED flag on resume

 drivers/bluetooth/btmtksdio.c    | 10 ++++++++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_sync.c         |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index ff4868c83cd8..8f00b71573c8 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1296,6 +1296,15 @@ static bool btmtksdio_sdio_inband_wakeup(struct hci_dev *hdev)
 	return device_may_wakeup(bdev->dev);
 }
 
+static void btmtksdio_disable_bt_wakeup(struct hci_dev *hdev)
+{
+	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
+
+	if (!bdev)
+		return;
+	clear_bit(BTMTKSDIO_BT_WAKE_ENABLED, &bdev->tx_state);
+}
+
 static bool btmtksdio_sdio_wakeup(struct hci_dev *hdev)
 {
 	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
@@ -1363,6 +1372,7 @@ static int btmtksdio_probe(struct sdio_func *func,
 	hdev->shutdown = btmtksdio_shutdown;
 	hdev->send     = btmtksdio_send_frame;
 	hdev->wakeup   = btmtksdio_sdio_wakeup;
+	hdev->clear_wakeup = btmtksdio_disable_bt_wakeup;
 	/*
 	 * If SDIO controller supports wake on Bluetooth, sending a wakeon
 	 * command is not necessary.
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0c1754f416bd..4bbd55335269 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -672,6 +672,7 @@ struct hci_dev {
 	int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
 				     struct bt_codec *codec, __u8 *vnd_len,
 				     __u8 **vnd_data);
+	void (*clear_wakeup)(struct hci_dev *hdev);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3563a90ed2ac..6c4d5ce40524 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5947,6 +5947,8 @@ int hci_resume_sync(struct hci_dev *hdev)
 		return 0;
 
 	hdev->suspended = false;
+	if (hdev->clear_wakeup)
+		hdev->clear_wakeup(hdev);
 
 	/* Restore event mask */
 	hci_set_event_mask_sync(hdev);
-- 
2.43.0.472.g3155946c3a-goog

