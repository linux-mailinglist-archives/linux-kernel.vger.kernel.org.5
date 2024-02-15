Return-Path: <linux-kernel+bounces-67694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD2E856F53
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CF22B2431B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D0513DBB3;
	Thu, 15 Feb 2024 21:29:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246741420DF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032552; cv=none; b=uchUtY8iG2iqGqfwMTF35TizuOPIABrjGF5A1Tfx6polUeGGN119F1/6qZ9RqPuRVkG89AK9+0vozDy71a9NN5UfcghyWolTGJI1wXDVuLqukx9OejejqtVHtDsAIxnQp2bcnzzlGIv56NPT1mO1CQVm0k4qvM1dgxr5LAPdOvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032552; c=relaxed/simple;
	bh=misj/VnHm/JTS+8SMdYAdNFoik7B5vvtXFX8JuijlvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SmIifueAoU+nnn+VtRNTwsruUJSQ/VEr2+s3DZK9p+GLEbyVQkFCAH75fcPm4BFZyMbXM4wyYeizLRxEcwwlhLPNiV/nseLl5DcOG76HUxFlKQMagzVNUTY0sNY8m3cVCZU7T+e37vSF4aJlEPARouuESUfPknEjaTTAQHmG3eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1rajHr-0001xh-6z; Thu, 15 Feb 2024 22:28:55 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	heikki.krogerus@linux.intel.com,
	jun.li@nxp.com
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v2 0/4] USB-C TCPM Orientation Support
Date: Thu, 15 Feb 2024 22:28:48 +0100
Message-Id: <20240215212852.1202339-1-m.felsch@pengutronix.de>
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
Since on my device the 'TCPC_CONTROL.DebugAccessoryControl' is set to
0 but the register wasn't updated automatically.

Regards,
  Marco

[1] https://www.usb.org/sites/default/files/documents/usb-port_controller_specification_rev2.0_v1.0_0.pdf


Marco Felsch (4):
  dt-bindings: usb: typec-tcpci: add tcpci fallback binding
  usb: typec: tcpci: add generic tcpci fallback compatible
  usb: typec: tcpm: add support to set tcpc connector orientatition
  usb: typec: tcpci: add support to set connector orientation

 .../devicetree/bindings/usb/nxp,ptn5110.yaml  |  4 +-
 drivers/usb/typec/tcpm/tcpci.c                | 45 +++++++++++++++++++
 drivers/usb/typec/tcpm/tcpm.c                 |  6 +++
 include/linux/usb/tcpci.h                     |  8 ++++
 include/linux/usb/tcpm.h                      |  2 +
 5 files changed, 64 insertions(+), 1 deletion(-)

-- 
2.39.2


