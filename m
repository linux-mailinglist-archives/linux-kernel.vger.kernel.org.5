Return-Path: <linux-kernel+bounces-38501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A24B483C0C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6444128953C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A82428E3C;
	Thu, 25 Jan 2024 11:29:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99122206D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182156; cv=none; b=KliUt5/TwZz0SNCEv5tDevMHCI6WPembwHTPaRd2l3AcV3QABv5Awc2FKJvcFLOGNykOQIiPtvC6S63ZMqIn0NTok3VLg99fPBffXdyLZFhWBH6yteFMIdVpFTEu+c8PBO/AJlZ63vQ2rez72FuTlVaty1256eVaYZUOtyTaSug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182156; c=relaxed/simple;
	bh=Nw538rruL/XSyChWFyI5KX1BM2Qj4bt/rXvZNCB5Jxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P0azz7fQT+K0Gt9QmrjuFOxskihmjGLJfuvdPz8DVvq/lWg7gGW1NmAgsIb5Klq5ogoyz86Jl+j1WlN6r2x4i8mEnAlrMVwScrtZcVovjUbAzcUC+kApYYPuQt9HQKuIg+bjL3Z1Q5R0YZeGAtW9afHnWs2+nzDh/Zyen10ANnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rSxuw-0001TG-WB; Thu, 25 Jan 2024 12:29:11 +0100
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Thu, 25 Jan 2024 12:29:08 +0100
Subject: [PATCH v2] usb: dwc3-of-simple: Stop using
 of_reset_control_array_get() directly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-dwc3-of-simple-reset-control-array-fix-v2-1-1ab6b52cad21@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAANGsmUC/5WNQQ6CMBBFr0K6dkxbWFRX3sOwIO0Ak2BLphUhh
 Ls7cgOX7+f//3aVkQmzule7YlwoU4oC9lIpP3ZxQKAgrKy2jTa2gfDxNaQeMr3mCYExYwGfYuE
 0QcfcbdDTCtjgzVlZuRCUnM2MEp+iZys8Ui6Jt9O7mF/6t2IxYMBpZ5z1vu41PmaMw1takdZrQ
 NUex/EFujhQZuEAAAA=
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.13-dev-a684c
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Use of_reset_control_array_get_optional_exclusive() instead, it is
implemented as:

  static inline struct reset_control *
  of_reset_control_array_get_optional_exclusive(struct device_node *node)
  {
          return of_reset_control_array_get(node, false, true, true);
  }

This makes the code easier to understand and removes the last remaining
direct use of of_reset_control_array_get(). No functional changes.

This change was made possible by commit f4cc91ddd856 ("usb: dwc3:
of-simple: remove Amlogic GXL and AXG compatibles"), which made the
parameters passed to of_reset_control_array_get() constant.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes in v2:
- Drop Fixes tag, adapt commit message.
- Link to v1: https://lore.kernel.org/r/20240124-dwc3-of-simple-reset-control-array-fix-v1-1-808182cc3f0e@pengutronix.de
---
 drivers/usb/dwc3/dwc3-of-simple.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index d1539fc9eabd..9cf9ee1b637b 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -52,8 +52,7 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3"))
 		simple->need_reset = true;
 
-	simple->resets = of_reset_control_array_get(np, false, true,
-						    true);
+	simple->resets = of_reset_control_array_get_optional_exclusive(np);
 	if (IS_ERR(simple->resets)) {
 		ret = PTR_ERR(simple->resets);
 		dev_err(dev, "failed to get device resets, err=%d\n", ret);

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240124-dwc3-of-simple-reset-control-array-fix-e4e9822028dd

Best regards,
-- 
Philipp Zabel <p.zabel@pengutronix.de>


