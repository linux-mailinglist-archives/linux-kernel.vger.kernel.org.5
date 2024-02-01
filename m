Return-Path: <linux-kernel+bounces-48093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D7084571C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2E81C24623
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C385160886;
	Thu,  1 Feb 2024 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urvYrxUW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C87A16088F;
	Thu,  1 Feb 2024 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789552; cv=none; b=H8Yhtzmtudn0sflidhGiJpYnn7kJKZBvRxLGLhrjZwqRMG+k2oxTODwJ+TfF1nwdarGbU+gXRpMZzqj+EhjbAjgEkVRmC4O2+kmMm58FNTIxcuZrNii9AusflXDx03ksosquDZZ5inE+FXrgZRvX10HdWdOVv42I0ajdFvju4k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789552; c=relaxed/simple;
	bh=U0KOgz6nOgOjNNhuSJI9UM8ClADua2irwTRLMiXXge0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g3SMPx8SCp6L68FwZj2HvF+PPubKmrtw4ABnixr0NL6fSHgFhpfsGk/nyP6/N9QXwvNcuIT2rexwvJlrKkvcnkSSXTqLQ+5vknLYfhKTvqbvCLYxxtmLIefi+tnWzEHZCvbHRM92Jn4Ldvvdy+DItZErbi45fZqoCMBTWJUoZQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urvYrxUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119FEC43399;
	Thu,  1 Feb 2024 12:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706789552;
	bh=U0KOgz6nOgOjNNhuSJI9UM8ClADua2irwTRLMiXXge0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=urvYrxUWsMAFZTUvGyLBQVD3pWRgURGRXvf8giZcgNy4TQ8rhNMfJPHktBC0RXDzH
	 288iRyPCfec97Ogu5T12whCkNPH9UtbHJpYYhZRjZnotrOZsoxHotS+5Iw1Hl5fun6
	 4Uhnbrb+U03wYPhQQH+CBcAoVFQIi6ezE1C3au44gThPiGc4jPe008PPoQhP76BQ2i
	 Jn/acVTuhMClwChUy0zJEm5jPwQPcvj8e/pnXa+Ay6jIn04nAZWQslJLUpkBEVKWjn
	 0ZmiGwJxtYVs5Lor46tD7eMVzhJ9K1Dd0V7fSDoBAlfxM9F4PqPrWalc21jLUy8w4e
	 o5tynXZTmYGJQ==
From: Roger Quadros <rogerq@kernel.org>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	r-gunasekaran@ti.com,
	b-liu@ti.com,
	srk@ti.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 2/4] usb: dwc3-am62: fix error on module removal
Date: Thu,  1 Feb 2024 14:12:18 +0200
Message-Id: <20240201121220.5523-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201121220.5523-1-rogerq@kernel.org>
References: <20240201121220.5523-1-rogerq@kernel.org>
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


