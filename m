Return-Path: <linux-kernel+bounces-162813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9578B60E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD7E1C2129C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE764128394;
	Mon, 29 Apr 2024 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l8cAQKsk"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB97F8614C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714414108; cv=none; b=aV+7yfxfpCsfqhXEt6qeL2hyQt8YKh5aS8rOPCcrZQ0dKYbfPnHvTu/iHr7wkgGQzHNStfqldqAJL5QIE9gy2KDX8efCJggCR+935sXqjg18CxfS/JtuDhFzsAg58MfVc03zIou3P+IW/UVQC/wn9y6vL/+mjTpb1G2PjgfWdDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714414108; c=relaxed/simple;
	bh=ZdfPcczF7xRDV5aIKhhSE/OBvQACkiweQ02X0owtYuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kNLV0O3cCv98fMQTvVIaKs932ckXDvzNgsmxvmT/AkgRRmNK4Qk/nsUPO4IBY7IiGn7k9Y9wxkvhkw1INJGQ38Z1zlSbcTU3sKhP2JtBC9PQRpK1IIvYBfm1lLCBYoYCrKBrYF5cCFEsAiVVgqfskMr+HuXYdpde7BaVQ/aCBxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l8cAQKsk; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-790fb2b780dso78999585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714414106; x=1715018906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nf84ojcMOq0M0VVKXZcmBf3YAZLtizS/AKsNC5U5GYU=;
        b=l8cAQKskurRSjog+c7tB695KI+VrF0fVEz6ixKEw4hepxxHCY0sTzQNG+VPrrDg0J3
         xd7UC9uhgEBZabdsGAgIyeJVOiILLg0w5taWgixi8dtIx09VyBN+0DDA5ZJcflV7LY9n
         0+9/bs7IfOQpLiN2uaXMZSxPzxD0Ky6bzaxi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714414106; x=1715018906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nf84ojcMOq0M0VVKXZcmBf3YAZLtizS/AKsNC5U5GYU=;
        b=J47ngU3u+SFBziKgLmTRTwhZJjv0qguzQ66ME8qowxgdBu+hUSHJm+l6iSbmO+yYjA
         F+p3xSyNjSY0929UgV2wA0wKSmu7mAqit98Cfnd2c1liDQkZ9PJONhIW321Pcq4Xsf3z
         9AQr48LzkHPLKzwbDFjsnGP5lnhpvs24vHGxcuYrz/8zGX9pzQ67ZS8Ozpre8nq6HbEC
         Qv1IobNEbDwlgqTNgNWPIDGlvEv6GBnU+zrcjoEfAxugk5JGyOwDdh5rhmzbHzBZjNhq
         ZZ8B9LBTGazjt0ZWwBT+C138tNci7U4JsGz9t5g4//SKn3FS6ibATHVyqXGI7MNG4qzg
         YThw==
X-Forwarded-Encrypted: i=1; AJvYcCXgmI8JxWplnrRfuP6dQD3IXvm5HB6rqZwHs3XEuBvIsftuRKUMmOHUmdzvsWhMk9CIfy7LUdoayiHdJPSJbbdgim3Y6gKaYj/UvlzS
X-Gm-Message-State: AOJu0YzqEimSir68myjZYQiND5MI95OutMqjqb7imGJDHN985RcG13nJ
	oxM5kK3s+rt/TUuc3Fyj5XzBZoS1BRV0Tx/EQS4dwqr4gUPlYkq+FsGkcN0LeQ==
X-Google-Smtp-Source: AGHT+IGP1JSt1zLTAdWv9/e6S2FAtWsol5Gu2tWZkbfJuYw18dt64uiBxNizrMEZPQkdCdYZac/8Vg==
X-Received: by 2002:a05:620a:4551:b0:790:a3a7:7cab with SMTP id u17-20020a05620a455100b00790a3a77cabmr392969qkp.39.1714414105812;
        Mon, 29 Apr 2024 11:08:25 -0700 (PDT)
Received: from seobrien.c.googlers.com.com (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id m6-20020ae9e006000000b0078efdcd9aa6sm10669039qkk.127.2024.04.29.11.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:08:25 -0700 (PDT)
From: Sean O'Brien <seobrien@chromium.org>
To: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Sean O'Brien <seobrien@chromium.org>,
	Jiri Kosina <jikos@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: Add quirk for Logitech Casa touchpad
Date: Mon, 29 Apr 2024 18:08:05 +0000
Message-ID: <20240429180804.1.Ie7e8d0ba595f9e39f71cbe4ab3468f79c00b4581@changeid>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This device sometimes doesn't send touch release signals when moving
from >=4 fingers to <4 fingers. Using MT_QUIRK_NOT_SEEN_MEANS_UP instead
of MT_QUIRK_ALWAYS_VALID makes sure that no touches become stuck.

MT_QUIRK_FORCE_MULTI_INPUT is not necessary for this device, but does no
harm.

Signed-off-by: Sean O'Brien <seobrien@chromium.org>
---

 drivers/hid/hid-ids.h        | 1 +
 drivers/hid/hid-multitouch.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 8376fb5e2d0b4..68b0f39deaa9a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -823,6 +823,7 @@
 #define USB_DEVICE_ID_LOGITECH_AUDIOHUB 0x0a0e
 #define USB_DEVICE_ID_LOGITECH_T651	0xb00c
 #define USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD	0xb309
+#define USB_DEVICE_ID_LOGITECH_CASA_TOUCHPAD	0xbb00
 #define USB_DEVICE_ID_LOGITECH_C007	0xc007
 #define USB_DEVICE_ID_LOGITECH_C077	0xc077
 #define USB_DEVICE_ID_LOGITECH_RECEIVER	0xc101
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 04a014cd2a2f6..56fc78841f245 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2081,6 +2081,12 @@ static const struct hid_device_id mt_devices[] = {
 			   USB_VENDOR_ID_LENOVO,
 			   USB_DEVICE_ID_LENOVO_X12_TAB) },
 
+	/* Logitech devices */
+	{ .driver_data = MT_CLS_NSMU,
+		HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_LOGITECH,
+			USB_DEVICE_ID_LOGITECH_CASA_TOUCHPAD) },
+
 	/* MosArt panels */
 	{ .driver_data = MT_CLS_CONFIDENCE_MINUS_ONE,
 		MT_USB_DEVICE(USB_VENDOR_ID_ASUS,
-- 
2.45.0.rc0.197.gbae5840b3b-goog


