Return-Path: <linux-kernel+bounces-41688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA2683F66A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C911C21818
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3546A3C482;
	Sun, 28 Jan 2024 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYxB7iyK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE43C473;
	Sun, 28 Jan 2024 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458302; cv=none; b=F5NnsWvAznhpumzSUHT2ICi0u+VddnwfLRe242pMfb4dv9PlfixKsZmr7ghGiTmNdL41XrUBMYje/qMDAKDfdHVT/kjqivKew1e7ljUx9OKd7Ch0b/Wu7pmbrc0SivmIBkbMeDQNA62n74+ks/Xo5SOrcicH6JsUnxODdbOu3DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458302; c=relaxed/simple;
	bh=YUT3IY0ee2gNoDt/dq3315JTZwG0KfUYM3XCGZWFtM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juN9Nu6yHpRoEb4qNejSyDxQJKeMcMQtt2WtQ/bBnfbCE7j3Iq9q1rZmNUsKuU4gcCU2sJ917gkqrcVyEkGPKSrBzG3Z0m6nKSC6abhDfqY7rMAdW1ZJ/ns9lpWk/9uzwLN1CnMFv1ewLhYousmVwDiG9wrsRSKUiUDFWSi1FwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYxB7iyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF41C433F1;
	Sun, 28 Jan 2024 16:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458302;
	bh=YUT3IY0ee2gNoDt/dq3315JTZwG0KfUYM3XCGZWFtM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AYxB7iyKqn/Yw5//Lbm4r4v6c3MF+Iq1RDk0gk8jTgHgHtSfq4MZl1EzkHXFozpDN
	 rAMXtLuGrDnVDBLfEJBU3Bjnm6o/5gHsL/PSv+YGyxJzHdTL/nTvRusyUnXIjOdOkM
	 Na4EL+Sqjx9zo2OxyfPUpvJVcy3eqfOTruYoPQbqqPSfkW8tn0XoEq2repncPbvzYf
	 POG/aWp9aAIAHaUYsw0baCq6ZzQw0VuI2tIuame+8vynYRSp/yIwdxQpF6rrgSTOga
	 HrD1ocea63+yXGj+cEtARnDsRweMf+8wWbykA1aHlkZ27niuraztd31ruNhkdFuW8L
	 wRJC7BLbbXEFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hardik Gajjar <hgajjar@de.adit-jv.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stanley_chang@realtek.com,
	heikki.krogerus@linux.intel.com,
	johan+linaro@kernel.org,
	royluo@google.com,
	ricardo.canuelo@collabora.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 06/39] usb: hub: Replace hardcoded quirk value with BIT() macro
Date: Sun, 28 Jan 2024 11:10:26 -0500
Message-ID: <20240128161130.200783-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: Hardik Gajjar <hgajjar@de.adit-jv.com>

[ Upstream commit 6666ea93d2c422ebeb8039d11e642552da682070 ]

This patch replaces the hardcoded quirk value in the macro with
BIT().

Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20231205181829.127353-1-hgajjar@de.adit-jv.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/hub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 87480a6e6d93..7deeba174858 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -47,8 +47,8 @@
 #define USB_VENDOR_TEXAS_INSTRUMENTS		0x0451
 #define USB_PRODUCT_TUSB8041_USB3		0x8140
 #define USB_PRODUCT_TUSB8041_USB2		0x8142
-#define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	0x01
-#define HUB_QUIRK_DISABLE_AUTOSUSPEND		0x02
+#define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	BIT(0)
+#define HUB_QUIRK_DISABLE_AUTOSUSPEND		BIT(1)
 
 #define USB_TP_TRANSMISSION_DELAY	40	/* ns */
 #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
-- 
2.43.0


