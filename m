Return-Path: <linux-kernel+bounces-97288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C0887684B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311231C20EBF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1BD2D60B;
	Fri,  8 Mar 2024 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfMn1i71"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498F225761;
	Fri,  8 Mar 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914856; cv=none; b=gyXqthOIEMEltG+9jvj7cwTabNTEu+xBn69iszXHw6S9OJfIOCzCJY1lbjcc7HP57AQqlUjb0hcFn/ARcMhPljFpewGmryY1CuQRvynBr6fIW3gvzvtlwnZUTvjp9cSye/pnmaM4ixN7TOFD1oaqIJB/bi8GyKqHyCotPCcj7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914856; c=relaxed/simple;
	bh=9qupHguL9fRpK1DkBs11N4LB4iV5sz6pVP0WmZ3V7hE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AkUhhOFf4i+2v/x5eC8XypkKEJBgxYltTv9frDgbNqyRhkYxHNHpdCqnCCRJ41NK+SgrYBL3CI2s9t9KrtTUo2mhUZBCV8jolS+4T2kEgQ40eMqOk2wej37tudTK4BG0RXl4kY6VefdG9bvBedQLf7T18xezonYwgg6EWaQBAns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfMn1i71; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc13fb0133so7660215ad.3;
        Fri, 08 Mar 2024 08:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709914854; x=1710519654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylV49xp7G/5derN4W10dhfCftimVKGiaFzSUndcrrBw=;
        b=GfMn1i71ircfXBBq0kr8evSQFbq9Nyo6Wx6KlnqRY6jU5HOjLqZCouAZ8ctlrTeGKd
         /lYMLItp4tyvAkJ8WxJNP9UFHdRtbeYaoqktCEnA1+PCStWGoGbBG1mcZiBAbWm4Q1Qo
         eTemnP86Se0+ianNH4pbMsjCg+ZxTWbQ+cSQMLRhRzMIZfU0dSV61xWNY9VLpe16IQ7z
         kelw5/LXBKoC7eRfACRgj6VJpK/5Hmidhu87OQmyxF5vcijc32Dy9TusJMMtswqCposv
         5MiAfCB2I4uHV5rW2q048KDKEhC2aMiT2+V8P1NqZhNo64yRYJh/k3DnNyJn6b+jOha6
         XrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709914854; x=1710519654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylV49xp7G/5derN4W10dhfCftimVKGiaFzSUndcrrBw=;
        b=uoGsQMNjWJwg5/uPOVGmZIAREi/NWziuG6d6TZV97jv1Q9IPpuDAte/mTldgh168CT
         4VrFTQhUOL0TEW4xUgTi5cb55ewxlotDLyvw2x5LsR6E3v+xFG/qMpVsytKI5dS4NHgD
         5mLMWzYcEUmGXCAutHPL4DxV8Q/slgiw+HFNWa2W+qjS1M6YzezZYPswqzb6n+V3fg7k
         k5fQ81aH0xH2P/IHwZAvpgDBH6YZGapVV5C/t7cnXjg6eesPhYCefmSgbcWyZPEizbek
         NmbWW3vUWYHdd6ljimwC4zQGwtSEphSpJKGES/b/IY9iWHl7yVaGnrxPvWzypJTJaVqB
         ig8A==
X-Forwarded-Encrypted: i=1; AJvYcCX7eFGNtiHhPfbIZ63KErFqIKcUu/UUTuaPrMzEqSOwRlfRgWK94iNsQejcCXkEd3KmvjxRBYEDAlsUMdbErVERbD5F8hjdyTElBzaAlR1fQykHzZSD6hGN7yrRNygsvZRgCmPzM6q7CxJU5xW1
X-Gm-Message-State: AOJu0YyQIja6/9+wO8tKIkbQN/D66i9RLDz87REnkDXACAVngukN4TXG
	gv8YqO+8Vl2U3AESw8smJaNd+lsPstWjSrtKGhCfBcSS/VaMRxpI
X-Google-Smtp-Source: AGHT+IFCiuU2H9n8kjde079kqmMIoFXj29yk5vhNY+eKT979HwQ4aEqQ6RBhgX+/svIx/Cqmb53VqQ==
X-Received: by 2002:a17:902:d488:b0:1dd:5686:81d with SMTP id c8-20020a170902d48800b001dd5686081dmr5762693plg.18.1709914854550;
        Fri, 08 Mar 2024 08:20:54 -0800 (PST)
Received: from ubu.. ([2401:4900:1c83:357e:32b:6491:476d:5fa8])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b001dc3ef7aa2bsm16501107plh.49.2024.03.08.08.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 08:20:54 -0800 (PST)
From: Ayaan Mirza Baig <ayaanmirza.788@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: Ayaan Mirza Baig <ayaanmirza.788@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: bfusb: Updated code to follow style guide
Date: Fri,  8 Mar 2024 21:50:37 +0530
Message-Id: <20240308162037.100226-1-ayaanmirza.788@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added indendations, removed trailing spaces, added empty lines after declaration.
Fixed Warnings with checkpatch

Signed-off-by: Ayaan Mirza Baig <ayaanmirza.788@gmail.com>
---
 drivers/bluetooth/bfusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index cab93935cc7f..08beae26e345 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -275,6 +275,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 		case HCI_EVENT_PKT:
 			if (len >= HCI_EVENT_HDR_SIZE) {
 				struct hci_event_hdr *hdr = (struct hci_event_hdr *) buf;
+
 				pkt_len = HCI_EVENT_HDR_SIZE + hdr->plen;
 			} else {
 				bt_dev_err(data->hdev, "event block is too short");
@@ -285,6 +286,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 		case HCI_ACLDATA_PKT:
 			if (len >= HCI_ACL_HDR_SIZE) {
 				struct hci_acl_hdr *hdr = (struct hci_acl_hdr *) buf;
+
 				pkt_len = HCI_ACL_HDR_SIZE + __le16_to_cpu(hdr->dlen);
 			} else {
 				bt_dev_err(data->hdev, "data block is too short");
@@ -295,6 +297,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 		case HCI_SCODATA_PKT:
 			if (len >= HCI_SCO_HDR_SIZE) {
 				struct hci_sco_hdr *hdr = (struct hci_sco_hdr *) buf;
+
 				pkt_len = HCI_SCO_HDR_SIZE + hdr->dlen;
 			} else {
 				bt_dev_err(data->hdev, "audio block is too short");
@@ -365,9 +368,8 @@ static void bfusb_rx_complete(struct urb *urb)
 			buf   += 3;
 		}
 
-		if (count < len) {
+		if (count < len)
 			bt_dev_err(data->hdev, "block extends over URB buffer ranges");
-		}
 
 		if ((hdr & 0xe1) == 0xc1)
 			bfusb_recv_block(data, hdr, buf, len);
-- 
2.34.1


