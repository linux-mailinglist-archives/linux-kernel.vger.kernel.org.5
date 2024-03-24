Return-Path: <linux-kernel+bounces-113781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E99888694
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E0928ECE2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6069712E1D4;
	Sun, 24 Mar 2024 22:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDKGolh/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070DE1E3054;
	Sun, 24 Mar 2024 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320792; cv=none; b=MrOmfDdbv+/GqCI99VEueeRDICDLnj6OMVb4HdNMXT625VWkamsHRvEjfOT0Sl05posdVN9dmtIJNWXGbkk3fUYImrXspiMqx1H4SqSp/ro5gU1c33XH7OvIFPh/+3kibpaCDhlQ8CX2Tf4peL+Tcy9xQi5M9a95AQvC5YgZoOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320792; c=relaxed/simple;
	bh=eZ8P3VvFJh8AOiFHtetE+vSb5xhTtJgCpVECyeF04SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Faf271TysClRn6cOzl6prjk4Pki5nltDwFslWaHxSey1qv9d5Z8NPoYgIjTIBtwmDvuGGpjhVVAZP/5hMoAx58qUaVouXbPZ6Xrx/bv+C7cvMEZgP/s9jVPnS/dPQwP8G4RMX10q5uwnd462Xw3wsRg4q0+yCTaZJKofQUsNihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDKGolh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFB0C43399;
	Sun, 24 Mar 2024 22:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320790;
	bh=eZ8P3VvFJh8AOiFHtetE+vSb5xhTtJgCpVECyeF04SA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UDKGolh/7YWF57I1TeQONS37UulKlZ9un7gyprOkEbJ8nj3WcqvKWx+Ihm7kQQAyZ
	 F8WHeDcGo7Q/SBirhnNTjL3Gm65jOc0H9L+PQ5cLP7oY6KjvRyGe9orl2/0zoiItqQ
	 Gl6G1NWLTubAvCl09kCnx2NgHzDsMvj2Lfjq/SWtUO9+jP+rY/55Mkzv2vT81M02o6
	 ZHrsNsK86G61ebO6Wy5zg57P5yMAa504f/OSwPRB3sCWTrFURbsJaLV4MIiVPG0Z8b
	 d3oC6QEUopnES7KXmKMkJPtllK1Qo6IUuypalz8zYVXiN07z/IZCsQ7Dew2WIUfiA4
	 87mlAGhThVk5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 354/713] Bluetooth: msft: Fix memory leak
Date: Sun, 24 Mar 2024 18:41:20 -0400
Message-ID: <20240324224720.1345309-355-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit a6e06258f4c31eba0fcd503e19828b5f8fe7b08b ]

Fix leaking buffer allocated to send MSFT_OP_LE_MONITOR_ADVERTISEMENT.

Fixes: 9e14606d8f38 ("Bluetooth: msft: Extended monitor tracking by address filter")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/msft.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index 630e3023273b2..9612c5d1b13f6 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -875,6 +875,7 @@ static int msft_add_address_filter_sync(struct hci_dev *hdev, void *data)
 		remove = true;
 		goto done;
 	}
+
 	cp->sub_opcode           = MSFT_OP_LE_MONITOR_ADVERTISEMENT;
 	cp->rssi_high		 = address_filter->rssi_high;
 	cp->rssi_low		 = address_filter->rssi_low;
@@ -887,6 +888,8 @@ static int msft_add_address_filter_sync(struct hci_dev *hdev, void *data)
 
 	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, size, cp,
 			     HCI_CMD_TIMEOUT);
+	kfree(cp);
+
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Failed to enable address %pMR filter",
 			   &address_filter->bdaddr);
-- 
2.43.0


