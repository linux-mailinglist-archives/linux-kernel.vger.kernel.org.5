Return-Path: <linux-kernel+bounces-64999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A2A854666
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B496B275AE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860E314A93;
	Wed, 14 Feb 2024 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poqQgFMH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B874479C0;
	Wed, 14 Feb 2024 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904106; cv=none; b=NehbTpOkxPHRW2diR9rVfB7+LyvhJhlQPT3JjjWm90HzHSFHR59+BR0bnr0pzbxTYyve8+lmPss1YYFXkbrZXySkjKhB+JUaSxCVAcpfpdiCEBGz9vUsillyUqfM9MO9a2+Y7WPWDMLr0P55LN9apHJEVir4YZGMDDQLF50jpLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904106; c=relaxed/simple;
	bh=/xTaGjBQPaCyfEB76FY9ozcyH+U4sK2JxoGVc4RldH0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HE/TcB90HSwXTBfkP7dnrMRp6HUHaM06fEfRSzVfZrSbmiY0tD6i50/73Acld+WaWtyDsMmVPPadZqdbO+BWrQDq0i5UMW/pL16CqREkawFdboqFlLDe/2IPtBvJ4q0Fs1GXMUjwZ6ydODG16ERHAAkZ6VEtmoLW5o1KPje1DVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poqQgFMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064C9C433C7;
	Wed, 14 Feb 2024 09:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707904106;
	bh=/xTaGjBQPaCyfEB76FY9ozcyH+U4sK2JxoGVc4RldH0=;
	h=From:Subject:Date:To:Cc:From;
	b=poqQgFMHxdq5tDAna0YN9HeabITO9bu2TQVUZbp8ahgxsZP6Yd45DONhupKDKnSj6
	 pasnPIvE8q2sL1Iiu9MrpOz4gdtasEntSDNQIG/ANywwQ1HiPmXHkBIqV6CoJtc6EF
	 C1gIx20SOTaGlGsfeijRVMtTxmF7YkGNKT78yjd8e/RgNBntFdFKBat7KoMLB0sVuY
	 yIftBpI3rRPyPx/5qhYIHie5mgEc+faqGbHhbGe/asI274BknHK3yB6+MdPqXFT4Hw
	 agMZRK4M1Hq4ihnQDXQYKQ8w2cF36EnyvMRxn7mCTyA544Q1ahiIe3GH08ipMPDS0x
	 iINWvfsKd0Ezg==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 0/5] usb: dwc3-am62: module removal and errata fixes
Date: Wed, 14 Feb 2024 11:46:44 +0200
Message-Id: <20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAWMzGUC/x3MQQqDQAxG4atI1v4wZMpQexXpItZos6hKpoog3
 t3B5QePd1BWN830qg5y3SzbPBXEuqLPV6ZRYX0xceBH4JAwzI4toYH8EmPNHdRd/oKIAI6xdCp
 PbXoqi8V1sP3et+/zvAALdWm1bgAAAA==
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: nm@ti.com, r-gunasekaran@ti.com, afd@ti.com, b-liu@ti.com, srk@ti.com, 
 francesco@dolcini.it, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=/xTaGjBQPaCyfEB76FY9ozcyH+U4sK2JxoGVc4RldH0=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBlzIxmmv2WqK272ksCvRfa5TzwwHAkG2z3CqXyw
 ZPtc6/jOjOJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZcyMZgAKCRDSWmvTvnYw
 k+rFEADKqAAkmkkSTNDWarxJR7LeLLcA0vlONIi7J4KBIJ4u3LV6/iA7XIAMISZQDGH0JDHxRwc
 6iOPXiWHZyOnZB/+PNvbPoD54b9QERKQEdawubNQbKRPlXzgXuugGwnE6KkY1DBSAbdNSXDszy/
 w4XUad2ShN1Zy96FVRuycrAuATIIMKJvTGkQgFq+d0ddqlXC+PThwbtW/5sSMbiPniZ+n5wDTUw
 ZZa/BltulnfnrOL1LF4WCDBEGpfDC2WTW4BtyMxEIA46G8a+9nt+9GgKAftCaw/tCaXTw7syIII
 KlbNhCe8hG+HjrLG/Y73+Ev9ZV5a5xNRrnX+Txrrek6C3GCBoe3Gyo2EEKrvCVVbR+4d3yLr9in
 G0B+f2XwKkNSdCBPVtUZKZTrApPCdX4ls8nt3822ts06AlHFwAjlyQ6C49TRu4wuz103RQHlwwW
 KtmIQ0bybQXf4Rnuh5IE4y0n3YovaYvm9xcwmBiTXzlE5IqOg5Lf0kz9bCB54TpkeOadgDqpq0Q
 CEh5forzBK51rMYmmzUyrMDUoYC26XaZX+d0AHqvO3be1ExqoCvMr9jiERHxM9v4WguQvAj3DRn
 JY8Sw3LEIxyzuQDjuxHsCpEPikPO7YQw/hjDrAELoIfds9AXIYhpnmN4wPFHI/b0KvyxV3Kv4l4
 80AvGtyui2WGRLQ==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Hi,

This series fixes errors during module removal. It also
implements PHY core voltage selection as per TI recommendation
and workaround for Errata i2409 [1].

The workaround needs PHY2 region to be present in device node.
The device tree patch will be sent later after the DT binding doc
is merged.

[1] - https://www.ti.com/lit/er/sprz487d/sprz487d.pdf

Changelog in each file

v2: https://lore.kernel.org/all/20240205141221.56076-1-rogerq@kernel.org/
v1: https://lore.kernel.org/all/20240201121220.5523-1-rogerq@kernel.org/

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Roger Quadros (5):
      usb: dwc3-am62: call of_platform_depopulate in .remove()
      usb: dwc3-am62: fix error on module removal
      usb: dwc3-am62: Fix PHY core voltage selection
      dt-bindings: usb/ti,am62-usb.yaml: Add PHY2 register space
      usb: dwc3-am62: add workaround for Errata i2409

 .../devicetree/bindings/usb/ti,am62-usb.yaml       |  8 +++-
 drivers/usb/dwc3/dwc3-am62.c                       | 45 ++++++++++++++++------
 2 files changed, 39 insertions(+), 14 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240206-for-v6-9-am62-usb-errata-3-0-233024ea8e9d

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


