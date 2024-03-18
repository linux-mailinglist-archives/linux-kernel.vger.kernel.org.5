Return-Path: <linux-kernel+bounces-106041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F39087E83C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB031F24B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E0939AEB;
	Mon, 18 Mar 2024 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RstFvpPV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FFB364BA;
	Mon, 18 Mar 2024 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760139; cv=none; b=sxzCQ85zcnlMq1BA4WqmgTs/wHUN88CfTmIjPopHbKAEf95eikCuITVhGTn3qsV+JfJBJ/v+S6/hBrUVEJu0jEGCkUVgENTd85vIUbaKD49tcwPdy9Hmgbsg6NzdzvTOidWyY8syCRYEHL5gvB/iRGre3Y9p/bwmD/B6g4GVfGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760139; c=relaxed/simple;
	bh=VQl76OihFJ6MD7Q7CC4hfGfrDaQ2DcOqSN3Z7HUNPy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bt/HVZ+9u8h2+dp+CAsrLQEzGnrwqLILw3SEP22O1Tjry1qQRZFII53och698WW6+zQPmjuBpGkXFNy8/GaVuPupZjF8IRUAWJA1BM82EeUJMBQHsvgxsit7imZU/zd6v5Fg2eG6z6mNqHaF2UBKOXVEbq0AQDQo4VfFc9h222U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RstFvpPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA0DC43141;
	Mon, 18 Mar 2024 11:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710760139;
	bh=VQl76OihFJ6MD7Q7CC4hfGfrDaQ2DcOqSN3Z7HUNPy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RstFvpPV6fSrd69/0/PjEtpdZXRg9OeNvTe/kgTqto/4Fk8qVpZUDM9VkCwGYgk/v
	 MrFQSwPnH+g2WO6EmFW0H3sSlF1XYFo7016p+hEu6CTsKJ9n5uB1nmWofWrjTwEv21
	 1R1xDrw+RYhh06fFg1vSNCdG5WIT5QtsZfBTkgf2RWaurGPeI8OnTxMgOsqzhc7xfP
	 BGa+JR1/XDwcPECcHIbwYSWDy1O/++R0YE0xj9HE+h+4OrFYTtYrarHw0QYBT566gu
	 YV2UavkOmmsClR4Qv7yGZkMk+TzEgi1K0jGolhsi4T2NsLQKYBL4UOQWLV+3jhdXt9
	 +EE0qOruf1n6w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rmArY-000000008Jp-3iDJ;
	Mon, 18 Mar 2024 12:09:04 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Doug Anderson <dianders@google.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 3/4] Bluetooth: qca: fix device-address endianness
Date: Mon, 18 Mar 2024 12:08:54 +0100
Message-ID: <20240318110855.31954-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240318110855.31954-1-johan+linaro@kernel.org>
References: <20240318110855.31954-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetooth
device address in big-endian order when setting it using the
EDL_WRITE_BD_ADDR_OPCODE command.

Presumably, this is the case for all non-ROME devices which all use the
EDL_WRITE_BD_ADDR_OPCODE command for this (unlike the ROME devices which
use a different command and expect the address in little-endian order).

Reverse the little-endian address before setting it to make sure that
the address can be configured using tools like btmgmt or using the
'local-bd-address' devicetree property.

Note that this can potentially break systems with boot firmware which
has started relying on the broken behaviour and is incorrectly passing
the address via devicetree in big-endian order.

Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device address")
Cc: stable@vger.kernel.org      # 5.1
Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Nikita Travkin <nikita@trvn.ru> # sc7180
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/btqca.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index b40b32fa7f1c..19cfc342fc7b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -826,11 +826,15 @@ EXPORT_SYMBOL_GPL(qca_uart_setup);
 
 int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 {
+	bdaddr_t bdaddr_swapped;
 	struct sk_buff *skb;
 	int err;
 
-	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, 6, bdaddr,
-				HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
+	baswap(&bdaddr_swapped, bdaddr);
+
+	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, 6,
+				&bdaddr_swapped, HCI_EV_VENDOR,
+				HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
 		bt_dev_err(hdev, "QCA Change address cmd failed (%d)", err);
-- 
2.43.2


