Return-Path: <linux-kernel+bounces-99077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE0387832F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47E91F267B9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9955BAC3;
	Mon, 11 Mar 2024 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8UYp7Z8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DF25A7BB;
	Mon, 11 Mar 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170001; cv=none; b=ECGtvaKb6Sx6lPHhB9WqjmRHFBspEhJlwrCRsJ5dBPz9yoWb8pTWquVZUWWupiZtj11BuCpvLq/ShgnPXLF2F1QnEy1lrnEZwKpdFIfCa5NfLlezbGgct3uQTh5hJSuYkhIWYoZHPC7D/OXZI1gMAuE94gX+OOfUbVqwMYC36pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170001; c=relaxed/simple;
	bh=d+U/DMyqrJmz9isk37XQbdH4HzIhR5FvXPZ0QF5sqY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhxLQF8Ce2loJAMb1qXv+XmvXIedLU+ksVP73+4EjfO9phhvd5c9SPkQ/3ekvjk96a3zbE/XOnHFj3j4dvmoJjh2xlvFEI1peFPIEs5pRSfcfPtNrO0YROOv8u6urnGWRERejgCyO5gG8F9S+GqRJ9ZOWdabWPe/eoNmwFvNQbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8UYp7Z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E93C433C7;
	Mon, 11 Mar 2024 15:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170001;
	bh=d+U/DMyqrJmz9isk37XQbdH4HzIhR5FvXPZ0QF5sqY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8UYp7Z8MrCGEUxj52hgjiPgAYy28G7sGz6butJ5D+bmTKu/6Z4fDoIeAN3CDaBTY
	 hhcOhCAvCqhemtnMQAfPtvNIGWkypvvhvCoXEt1431uf7vbM7btXcuExyKR/npdv3/
	 18flvgfsAYxuz/mzin4T3vrEq7STTl7i7dF4PdH4Bxj6zF/kxD/Y2zqX9KROi0el1F
	 unjglmWDCOmgJ4EkM/q/Bk6kSqcG8NERZjAq2LRjGTdA07Vnw1TxO6wQBd5qovNwcl
	 uDwQTh7VxyOZK2+60ALKixKqadaR1tH+YYyvU49JtC/f6byo4WeVg9590NDpd8iXQP
	 4Ri5mT0YZ6q2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andre Werner <andre.werner@systec-electronic.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	steve.glendinning@shawell.net,
	UNGLinuxDriver@microchip.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/17] net: smsc95xx: add support for SYS TEC USB-SPEmodule1
Date: Mon, 11 Mar 2024 11:12:55 -0400
Message-ID: <20240311151314.317776-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151314.317776-1-sashal@kernel.org>
References: <20240311151314.317776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.21
Content-Transfer-Encoding: 8bit

From: Andre Werner <andre.werner@systec-electronic.com>

[ Upstream commit 45532b21dc2a692444b6ad5f71c253cca53e8103 ]

This patch adds support for the SYS TEC USB-SPEmodule1 10Base-T1L
ethernet device to the existing smsc95xx driver by adding the new
USB VID/PID pair.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
Link: https://lore.kernel.org/r/20240219053413.4732-1-andre.werner@systec-electronic.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/smsc95xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index a530f20ee2575..2fa46baa589e5 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -2104,6 +2104,11 @@ static const struct usb_device_id products[] = {
 		USB_DEVICE(0x0424, 0x9E08),
 		.driver_info = (unsigned long) &smsc95xx_info,
 	},
+	{
+		/* SYSTEC USB-SPEmodule1 10BASE-T1L Ethernet Device */
+		USB_DEVICE(0x0878, 0x1400),
+		.driver_info = (unsigned long)&smsc95xx_info,
+	},
 	{
 		/* Microchip's EVB-LAN8670-USB 10BASE-T1S Ethernet Device */
 		USB_DEVICE(0x184F, 0x0051),
-- 
2.43.0


