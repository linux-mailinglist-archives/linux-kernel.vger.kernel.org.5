Return-Path: <linux-kernel+bounces-106039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B40B87E838
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199FA28208C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8557338F9C;
	Mon, 18 Mar 2024 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHqV08Sn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAA6364A4;
	Mon, 18 Mar 2024 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760139; cv=none; b=sBvpcr6p2mUKSeG6u+A+IlkRBxkPuMnlvWLOhqohTqpMRqF+a7DDAR9/uIXfFnXDa1zdJ3E4OgLhTG6Y6vBzYguVgHjKN+gPtRYtdraFpegbQtEGXskbwmSvjtBkaHORIS365mQqgOLhfQO/anoCzmDNQ0YC6GJTuBbRIeTTK7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760139; c=relaxed/simple;
	bh=IkqXsf80aD3AGxwdY+jhdtqTqWS35qqFvr4ZSgDa2Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXpk6YMMZj/j0sbjS080xLM8Xhcv1qpWzitmUatZf4wgGciksAsrLkrnCcdtYRUbrXkqd+y09wumsuFkkvGSDLOAgjSxbIsJFWEcD9wHhyNzZFGc8q/8UwWqizJWk9SijrqHlZYL0pYUSx7g2Vu0YeP1eyCRLWC2mAw2EoQTF/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHqV08Sn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E102C43390;
	Mon, 18 Mar 2024 11:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710760139;
	bh=IkqXsf80aD3AGxwdY+jhdtqTqWS35qqFvr4ZSgDa2Xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DHqV08Snc3Tt5Pe7MU8wwT9wFDWUmwpyYnYje2cQ1wzsNM6rCX0kkZmVSaq9PZS9L
	 OsuW6KeozvRFAaQEcG2QjOdwVdXOL5SP/SR6ftEtZa4rbNcMAO5nq1C0JwP36VWI/6
	 PgT7jn5CTU6BVM+19GsIDPd0VHuko5lxGoXsxxfg7bZX8+yJrgQ0qWecOBF2fkF3Z9
	 GpawddXktnw8cSGNGpMEyWED1dcr8c9BSEZvUWTQcfRgUHM5VUoLwbVWDQ5pv+cH46
	 eE7ttyzM3cam1bG1SvVQB7P45i7555QnvkXsKJAV8SpVLZI/h1ey0xaaJI9EnPd47X
	 g/tyeoX/YdZRA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rmArY-000000008Jn-3Nlm;
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
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] Bluetooth: add quirk for broken address properties
Date: Mon, 18 Mar 2024 12:08:53 +0100
Message-ID: <20240318110855.31954-3-johan+linaro@kernel.org>
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

Some Bluetooth controllers lack persistent storage for the device
address and instead one can be provided by the boot firmware using the
'local-bd-address' devicetree property.

The Bluetooth devicetree bindings clearly states that the address should
be specified in little-endian order, but due to a long-standing bug in
the Qualcomm driver which reversed the address some bootloaders have
been providing the address in big-endian order instead.

Add a new quirk that can be used to mark deprecated compatible strings
that expect such broken devicetree properties and use it to reverse the
address when parsing the property so that the underlying driver bug can
be fixed.

Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device address")
Cc: stable@vger.kernel.org      # 5.1
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 include/net/bluetooth/hci.h | 10 ++++++++++
 net/bluetooth/hci_sync.c    |  5 ++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index bdee5d649cc6..556cffed5698 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -176,6 +176,16 @@ enum {
 	 */
 	HCI_QUIRK_USE_BDADDR_PROPERTY,
 
+	/* When this quirk is set, the Bluetooth Device Address provided by
+	 * the 'local-bd-address' fwnode property is incorrectly specified in
+	 * big-endian order.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback and must only be used for
+	 * deprecated compatible strings.
+	 */
+	HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
+
 	/* When this quirk is set, the duplicate filtering during
 	 * scanning is based on Bluetooth devices addresses. To allow
 	 * RSSI based updates, restart scanning if needed.
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5716345a26df..283ae8edc1e5 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3215,7 +3215,10 @@ static void hci_dev_get_bd_addr_from_property(struct hci_dev *hdev)
 	if (ret < 0 || !bacmp(&ba, BDADDR_ANY))
 		return;
 
-	bacpy(&hdev->public_addr, &ba);
+	if (test_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks))
+		baswap(&hdev->public_addr, &ba);
+	else
+		bacpy(&hdev->public_addr, &ba);
 }
 
 struct hci_init_stage {
-- 
2.43.2


