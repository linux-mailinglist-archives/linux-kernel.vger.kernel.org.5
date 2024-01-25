Return-Path: <linux-kernel+bounces-38052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFC783BA4F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BB06B22D28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9831119E;
	Thu, 25 Jan 2024 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FSNpcPnF"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DA011187;
	Thu, 25 Jan 2024 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706165487; cv=none; b=AMXFn7bTKBHmdT7F+aNkRyH2cGgivAPEr07zSvBy7U1+gS733Yvf5soJfwUUtGxiNlDW8AJ36HYjTxyBCmdFfvej88tEZM9j4m7gPuS57k3oQuWxIBMWprnQNnqjFzo4rMh2KW+6DeVOXWjtwPp5X3L9PDX8YCPB0K2EiQkyH4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706165487; c=relaxed/simple;
	bh=uNKw14rmWjq29WbMqjEi11A7FWTJk+zIhqQOTIfMogw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O8dSaL1hrlGfhAgDs29ruYjK1vTuiZarBEsEKHOgiS3zF1HuPMMQkgJ/dtSvNrXWzornBF44BPwiuyCnjfik5lqEVrLQ5sbTlIR5KCepzLr/2NnrFQbgN/6FSn79zuK9//8TRtmGiW/GUsMJfxqFoudTHnbwlYe+I2FQRvMA0jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=FSNpcPnF; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 785363F6CA;
	Thu, 25 Jan 2024 06:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706165476;
	bh=1L/lLKv/ucdyNwhVxP/cwqKnVwVXOIPr9ovLtgnwmWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=FSNpcPnF6r+1jcfa/QkybGIrAgOefakCOouU800ZEqaEOSnDX/8PoHwxjxLlegMR8
	 h0aGDA73zKj/iy9VemZI2Nj5gP99wNfZJXTNRccJTx6vbYCqj2u1UlRrJ4NQVjtb2F
	 dBiXobl0514EmgFZHw/SbKO0mT4dKmKgF/E2dDLQAWj6bV5QDJ63xLGBd6u4fSMCNR
	 rNsCOLy6HPXnmwotFkHyg0Fc3PTEp1dzeYIKlKCYXvWqYuVOSeY/UEFYlrrng8AOBg
	 4zXAXUgzBtLemu+5/uGLWM9JZt5MLK+6sW8wh/bMNojAdUHdrOj5DdBwfxa1RKHa5O
	 W1tq/QI5dnYDg==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: Enforce validation on max value of connection interval
Date: Thu, 25 Jan 2024 14:50:28 +0800
Message-Id: <20240125065028.228877-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now Linux BT stack cannot pass test case "GAP/CONN/CPUP/BV-05-C
'Connection Parameter Update Procedure Invalid Parameters Central
Responder'" in Bluetooth Test Suite revision GAP.TS.p44. [0]

That was revoled by commit c49a8682fc5d ("Bluetooth: validate BLE
connection interval updates"), but later got reverted due to devices
like keyboards and mice may require low connection interval.

So only validate the max value connection interval to pass the Test
Suite, and let devices to request low connection interval if needed.

[0] https://www.bluetooth.org/docman/handlers/DownloadDoc.ashx?doc_id=229869
Fixes: 68d19d7d9957 ("Revert "Bluetooth: validate BLE connection interval updates"")

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 net/bluetooth/hci_event.c  | 4 ++++
 net/bluetooth/l2cap_core.c | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ef8c3bed7361..0ed3388368f9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6794,6 +6794,10 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev, void *data,
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_UNKNOWN_CONN_ID);
 
+	if (max > hcon->le_conn_max_interval)
+		return send_conn_param_neg_reply(hdev, handle,
+						 HCI_ERROR_INVALID_LL_PARAMS);
+
 	if (hci_check_conn_params(min, max, latency, timeout))
 		return send_conn_param_neg_reply(hdev, handle,
 						 HCI_ERROR_INVALID_LL_PARAMS);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 60298975d5c4..656f49b299d2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5613,7 +5613,13 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 
 	memset(&rsp, 0, sizeof(rsp));
 
-	err = hci_check_conn_params(min, max, latency, to_multiplier);
+	if (max > hcon->le_conn_max_interval) {
+		BT_DBG("requested connection interval exceeds current bounds.");
+		err = -EINVAL;
+	} else {
+		err = hci_check_conn_params(min, max, latency, to_multiplier);
+	}
+
 	if (err)
 		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
 	else
-- 
2.34.1


