Return-Path: <linux-kernel+bounces-53036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A866E849FBC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599D71F25B9F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E948F47F72;
	Mon,  5 Feb 2024 16:43:44 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBC73FE4F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151424; cv=none; b=U+IzDDNpXUnBz8uuGsB8eGMHbOxiW1vJYWHeyPmievtJhfbCR9C6Jhnf+F1UjsKkLpTywKSzdJxAPlx92RawboOHlL8US1YKtJ87NRsDyw5Y/sj+kAC+9iBpTJrRygG3noNtkXl4Los3p3wNaTdTLhbfKMru1le8fXU3lvXjhjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151424; c=relaxed/simple;
	bh=BFvZkNV6wb7PoKEUe58zRpeKa5nlGZK65hmeJTAj55s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jUBJ42QSxE+8bXqdmYWFnMTZ/bMspiTKM4qcRmjZEFymVxf3HK9x84CHFakt41EaHjXOPkZxahZMqbzJOMh2Ds0GpDJ5LgxT6lLLDUjHpfo6zDMoPx1Ey8ODHjQ6+gJ5IL2sqOAQUe1F0KZGs8SUus4JV3bfp5yZk+cCUlghgaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1rX240-0004Lp-7a; Mon, 05 Feb 2024 17:43:20 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	heikki.krogerus@linux.intel.com
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 0/4] USB-C TCPM Orientation Support
Date: Mon,  5 Feb 2024 17:43:12 +0100
Message-Id: <20240205164316.805408-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

this adds the support to controll the optional connector-orientation
available on some TCPC from the TCPM.

I used an custom board with OnSemi FUSB307B TCPC which is spec [1]
compatible but albeit the spec [1] says that this pin is controlled by
the TCPC if 'TCPC_CONTROL.DebugAccessoryControl = 0' it isn't at least
for this device.

I'm unsure if the usb tcpci spec has an copy'n'paste failure since
'TCPC_CONTROL.DebugAccessoryControl' shouldn't control the state of the
'connector orientation' pin or if the OnSemi FUSB307B has an HW bug.
Because on my device the 'TCPC_CONTROL.DebugAccessoryControl' is set to
0 but the register wasn't updated automatically.

Regards,
  Marco

[1] https://www.usb.org/sites/default/files/documents/usb-port_controller_specification_rev2.0_v1.0_0.pdf

Marco Felsch (4):
  dt-bindings: usb: typec-tcpci: add tcpci compatible binding
  usb: typec: tcpci: add generic tcpci compatible
  usb: typec: tcpm: add support to set tcpc connector orientatition
  usb: typec: tcpci: add support to set connector orientation

 .../devicetree/bindings/usb/nxp,ptn5110.yaml  |  4 +-
 drivers/usb/typec/tcpm/tcpci.c                | 44 +++++++++++++++++++
 drivers/usb/typec/tcpm/tcpm.c                 |  6 +++
 include/linux/usb/tcpci.h                     |  8 ++++
 include/linux/usb/tcpm.h                      |  2 +
 5 files changed, 63 insertions(+), 1 deletion(-)

-- 
2.39.2


