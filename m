Return-Path: <linux-kernel+bounces-133109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82623899EF8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224AB1F21CFC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB0516EC04;
	Fri,  5 Apr 2024 14:06:38 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22F816EBF5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712325998; cv=none; b=WAeE+pvCbgJk45ZRMfGpOfi+gPQWZHfpWQHKEEdcm1E0aOMsjx/Fb4jceu3uXCPVAfaAc7gZEVNNzEOyAUfODcJZDRjT3C/UhyHS8Of0xtU9YjHOP5OsAOOlgS6WMAZ/E91ubJCh7v8pIC+/6ZqLaYfdaJIMbAAwT5PzjTJnpvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712325998; c=relaxed/simple;
	bh=C6ZFrayco9a5P7c5NFHKafjcSAFeafQiz7doTSCE7aQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nKvT7I2uEcX2Pncu8WZ7+pVaohW/WzxNoa20X0DHdhNClMfOCkcBSNmKmOm/f7Pr2/81IB/Zd5Plrmy7/+SfBfqxw5gHkvabE4wTOWt1w47mz8b836OlVOS3LBBBRv7m+tp4IYQgDwmzWjQH1afeohU0fg0djY+BqlZ5B+QgJdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 5 Apr
 2024 17:06:32 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 5 Apr 2024
 17:06:32 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: WARNING in ar5523_cmd/usb_submit_urb
Date: Fri, 5 Apr 2024 07:06:29 -0700
Message-ID: <20240405140629.22663-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Enable endpoint checking.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
---
 drivers/net/wireless/ath/ar5523/ar5523.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index 815f8f599f5d..5cac4a6452db 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -1594,6 +1594,20 @@ static int ar5523_probe(struct usb_interface *intf,
 	struct ar5523 *ar;
 	int error = -ENOMEM;
 
+	static u8 bulk_ep_addr[] = {
+		AR5523_CMD_TX_PIPE | USB_DIR_OUT,
+		AR5523_DATA_TX_PIPE | USB_DIR_OUT,
+		AR5523_CMD_RX_PIPE | USB_DIR_IN,
+		AR5523_DATA_RX_PIPE | USB_DIR_IN,
+		0};
+
+	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr)) {
+		dev_err(&dev->dev,
+			"Could not find all expected endpoints\n");
+		error = -ENODEV;
+		goto out;
+	}
+
 	/*
 	 * Load firmware if the device requires it.  This will return
 	 * -ENXIO on success and we'll get called back afer the usb

