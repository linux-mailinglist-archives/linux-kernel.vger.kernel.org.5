Return-Path: <linux-kernel+bounces-52791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F09849CB0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43701F25CEB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E388D2C6B7;
	Mon,  5 Feb 2024 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwYqA+6Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324092C6A9;
	Mon,  5 Feb 2024 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142354; cv=none; b=Jw8mftVnWtYmAxK3NUWB9XTTgPRle0dXUe4c47weEa2LDbdZ9cx4KEosPZcB5Ifc20PTL6ta3vtrfJClxyOLMAc7mefR1KVYkBzzLR0AxRMg0MDSBtyBL9+0vHUUgS2qlbgu9Bjdx+oJpIEBXTxow1haVNvy1MalY4WqT1ALubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142354; c=relaxed/simple;
	bh=/rPhwXHZ3xKXpN/7zhU9DA4Kcd5ElnQq+143lheukRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eVAixK6YpGzKcJsoc3RxN487huaKhYTmcRbfHfo+bGkFA56ZXkdaDkPDeMfEamr/iwyw+zfqC/WZg5+4QZr0xIuLDTzxmW0FRIBD1UNQEZrYtCAUqQZOoJ5P5o+Bsz4O0HfdW29J9Nd5CLVAby+olPfkvO8w1Un91cLOjLk7WAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwYqA+6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30098C43399;
	Mon,  5 Feb 2024 14:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707142353;
	bh=/rPhwXHZ3xKXpN/7zhU9DA4Kcd5ElnQq+143lheukRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwYqA+6YbdtPGlEOzoSOtBbozjKAMKFVpTgUyq2t182CXX4m3L3ku1nwv8rM6f1EC
	 cc2VP9Ba5yV6zBxUVaHDUIJhK1n2GvIkxPA3/xeOXQIt35Us/F5YrLZufzQBduQcGR
	 3Jk0AXGTzC+uNqPDOiOIcLjgZfnkSQTDKqluuY+NqP11kIz5NpwqqsoQ1KPHnmmnsO
	 +ROL2ckwH+vT1/GZFgNxLvn+4zpSU/bcsxySENz/mA9Dhgwe9TWp9SHPkCm3wb2lfj
	 Z0qBxZTo3E1GXzgLBhOK2eoiFpgb2udzaMQBNNdh0ksEDGEXXpPAumvC2FZYBmUv73
	 pjH/1msR7nsrw==
From: Roger Quadros <rogerq@kernel.org>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	r-gunasekaran@ti.com,
	b-liu@ti.com,
	afd@ti.com,
	nm@ti.com,
	srk@ti.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 2/5] usb: dwc3-am62: fix error on module removal
Date: Mon,  5 Feb 2024 16:12:18 +0200
Message-Id: <20240205141221.56076-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205141221.56076-1-rogerq@kernel.org>
References: <20240205141221.56076-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As runtime PM is enabled, the module can be runtime
suspended when .remove() is called.

Do a pm_runtime_get_sync() to make sure module is active
before doing any register operations.

Doing a pm_runtime_put_sync() should disable the refclk
so no need to disable it again.

Fixes the below warning at module removel.

[   39.705310] ------------[ cut here ]------------
[   39.710004] clk:162:3 already disabled
[   39.713941] WARNING: CPU: 0 PID: 921 at drivers/clk/clk.c:1090 clk_core_disable+0xb0/0xb8

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---

Notes:
    Changelog:
    
    v2: no change
    
    v1: https://lore.kernel.org/all/20240201121220.5523-3-rogerq@kernel.org/

 drivers/usb/dwc3/dwc3-am62.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 1bfc9e67614f..600ba9cfefea 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -273,6 +273,11 @@ static void dwc3_ti_remove(struct platform_device *pdev)
 	struct dwc3_am62 *am62 = platform_get_drvdata(pdev);
 	u32 reg;
 
+	pm_runtime_get_sync(dev);
+
+	device_wakeup_disable(dev);
+	device_set_wakeup_capable(dev, false);
+
 	of_platform_depopulate(dev);
 
 	/* Clear mode valid bit */
@@ -281,7 +286,6 @@ static void dwc3_ti_remove(struct platform_device *pdev)
 	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
 
 	pm_runtime_put_sync(dev);
-	clk_disable_unprepare(am62->usb2_refclk);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
 }
-- 
2.34.1


