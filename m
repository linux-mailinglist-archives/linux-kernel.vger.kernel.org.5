Return-Path: <linux-kernel+bounces-99056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 891938782F2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80648B21487
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AE64C631;
	Mon, 11 Mar 2024 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbTII3uh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5E14AECC;
	Mon, 11 Mar 2024 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169958; cv=none; b=NX6wCwKp6ocD4idicArg8JjiWryhENUViGMh00Ad1psyUzBCi1dCCuD256Q3+1FZJb6D88obSth1xYbFWBiLFKRNZxfqgNA1GquZdfFcOvREsj5x/x62mHiApfgvq+7nhjxmlrvhcs9c+87i18czUCzLoTTWQZz6a4fFSQKcQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169958; c=relaxed/simple;
	bh=d+U/DMyqrJmz9isk37XQbdH4HzIhR5FvXPZ0QF5sqY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBDCPr598WSWBX4UncJ3I52MYNed7RSPziOQO2KLExBwGcQpZnpIXWsUryaKrVA8KjY5tRXxdzxoZjicSgKqZF5TOxShVE9y+PEgxPoSKcR/93f6RZY8Si1fiDdfBeYjXTp+VaQBS/TMO9v/Aa7eZDaMvmQaIpAQJM4ztQNjvjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbTII3uh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE7AC433F1;
	Mon, 11 Mar 2024 15:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169958;
	bh=d+U/DMyqrJmz9isk37XQbdH4HzIhR5FvXPZ0QF5sqY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HbTII3uhi/g8b2QMB6EQJtbcOigywKsx0O36GpD+Nn5J8fkxTHmsZN5RrZGOG1ru+
	 IFOWpk8eqOjec/tgxZ6q/YfvxcndJeWtCv2uEC2fbWv51McZ4DFoF7WDs6CQMQkILh
	 lXTKu62Z6hvTRIIl5FzSj6W936uRv5vIFCpKo8IUyHcZN2UFI0u3F+Oxb4h+44J2V8
	 pSN6vASrgxsxBORXXiGmCuLg2DpLBVTwxobEKdsXNRrDyNRcDx0z/ON+m7LAATkdf4
	 h0W7waZ9nC5b18XcTduIhWjHD/By0+C/FC7tS5MoMraDrMZPjYV55zycTtOLegOUXn
	 ykCKuG9vHJgWw==
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
Subject: [PATCH AUTOSEL 6.7 09/23] net: smsc95xx: add support for SYS TEC USB-SPEmodule1
Date: Mon, 11 Mar 2024 11:11:49 -0400
Message-ID: <20240311151217.317068-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151217.317068-1-sashal@kernel.org>
References: <20240311151217.317068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
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


