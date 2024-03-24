Return-Path: <linux-kernel+bounces-115771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2005B88986D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0984B270AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36B72618E3;
	Mon, 25 Mar 2024 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cy+palL5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D538E1448FE;
	Sun, 24 Mar 2024 23:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321970; cv=none; b=AycSWCcT0U/9djHVbH90dG4aIdtRCicCQGPZX2Rk93pkRaLrVA7jOC3V5wditBBuX9Fbc/yhe4TTyi8Ayte0t9+1EX27lhoj58po/DpLYmq4Nw9dC1lZC6+oNduPH7K9yxWw6kPsAa2qMtEUTCqK4+T8VKuRF2/bUH6T3VJ0akE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321970; c=relaxed/simple;
	bh=d+U/DMyqrJmz9isk37XQbdH4HzIhR5FvXPZ0QF5sqY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9xyBj4rjis9+57EqFWhJA+RtqJNB2ZmO8SMaquP/YX8JfiXqJQz/Jx2+jtcmWXxTBVKDYjjdfdR8fmCYCJZZRAYkvC5NRTysepVzLlpL+s6KiCBAvMAuHxBYGgytHOK6Zp7TvXb/zWctpabpQ5lO+eu0RgP3ZwgIMVjIK+YVD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cy+palL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22CBC433F1;
	Sun, 24 Mar 2024 23:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321970;
	bh=d+U/DMyqrJmz9isk37XQbdH4HzIhR5FvXPZ0QF5sqY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cy+palL5Y0i1N6luL4ofQoUW4dHzfWMe/Z6LtU84wMCKA6oCnOLNPG/iCoRUggYZE
	 RSFGZ7+MulPpJveNaFzeCOdJQ6WX2EVvSsV1ip206HxBE8k5QA1tsxthJ0PnYX/qC0
	 E4OZR+jHigJi+CYULMnuORjwXhpr7oN+VikgtopGC4ZE3TmgkhENYMtPT06uUFm8iw
	 7blUnXslGhUDvRlS3iFK2tpfbs5pobOwIJNtO8kn/n17JVfkkSmrWMGFOLV++E3Pke
	 8ewo7D+Yzj2fXMv4y0s9uIXTO4azvvzGrVCnImSD7tGbp63tVONwd68w5NA6nvLQ4O
	 RWtSpjIzFptBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andre Werner <andre.werner@systec-electronic.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 042/451] net: smsc95xx: add support for SYS TEC USB-SPEmodule1
Date: Sun, 24 Mar 2024 19:05:18 -0400
Message-ID: <20240324231207.1351418-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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


