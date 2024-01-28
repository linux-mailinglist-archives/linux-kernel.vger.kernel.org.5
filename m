Return-Path: <linux-kernel+bounces-41760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B7D83F76A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4147D2835C2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BA86A340;
	Sun, 28 Jan 2024 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzkpIQpe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26336A354;
	Sun, 28 Jan 2024 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458475; cv=none; b=tm8vogMx+loklyVkyhgiz03jX4hHkFr/hhGxf71zdLL/lNkr47dBSWfChUWKQRFA1cH7RTcad8fXITWPCqCBc6Yle1ciujFz4zAD+5N50hgoPXr2t7bbMHbC8m8N9lQ/o5WxCmaPN0IroET4x8A2sXiquUGtHhDa4jp91+ydD+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458475; c=relaxed/simple;
	bh=6RWIa5cHgrGOfwC1ugvpRhrS3uTT5drfVvS54Wzfsgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVUM4MYQUGdipUzQZ7LJthLe2IiAcoA+pN654PKTDZr4bZct5IVX+oTCSzbaZdIURbLfbb2SdP/AKPO4cfspl0DepOD9zx9qOfHBpkTTOTaeEkXPP5C/rjGPxwdT3q/dqlmgyOHbOEHLbgRm+9v43Ark+nkySbUD6irTeR9iJ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzkpIQpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B573C433F1;
	Sun, 28 Jan 2024 16:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458474;
	bh=6RWIa5cHgrGOfwC1ugvpRhrS3uTT5drfVvS54Wzfsgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NzkpIQpeDe1dYjf+Evgiq0mLnrJevlMSNPzTxNeRtC7f0OtxrJCTVhfluSILaoJZ4
	 bNDEABlkyXfa2VrM9atvWZvJOSi2J8G8KAc3jxKDPEH/4pkP8bCA3YXOjcZnLMqVYa
	 olyO0PyVcVBohWSqbtuN1pFf9EwliIc9S1f/F7RGLNciX6Hh69EPNTVuM7A/QXEgqJ
	 Mv7GqcetcRqTDEsMF/Hy8ZdkH64zlfXgK7KqeGfYF6+Ko7epn6qgIHjRvRdvC9bOaF
	 S2U+PAmsM6ydmMQD0TTFNeZUV/+PY3uWXgV+4JKT6oZzDM5jQPPUYuJu9Iikgpdlc1
	 ZmE6YuIfdx/0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hardik Gajjar <hgajjar@de.adit-jv.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stanley_chang@realtek.com,
	johan+linaro@kernel.org,
	heikki.krogerus@linux.intel.com,
	ricardo.canuelo@collabora.com,
	royluo@google.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/27] usb: hub: Replace hardcoded quirk value with BIT() macro
Date: Sun, 28 Jan 2024 11:13:50 -0500
Message-ID: <20240128161424.203600-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161424.203600-1-sashal@kernel.org>
References: <20240128161424.203600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.75
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
index 81c8f564cf87..9163fd5af046 100644
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


