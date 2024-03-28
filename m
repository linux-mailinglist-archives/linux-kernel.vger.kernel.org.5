Return-Path: <linux-kernel+bounces-123703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC1E890CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13CE1C2167B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859BC13B5AC;
	Thu, 28 Mar 2024 22:06:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4EE12F5A4;
	Thu, 28 Mar 2024 22:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663596; cv=none; b=ksOGMPW6P6UFa9uX8pJpuNB1/s9aER2mIc6lF3IkNTY0Ok+p+pwRURp51+wQIMxLace0Coe9D6+3fI3+7Vew0mc+kn2FbJMXJ3JMxIY2dIdol2rV6r1Xh412zG9l0gUOBPy6RWb6P9RRW1hKxgK1huVpvPTsCJ0ftzW5B36HO/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663596; c=relaxed/simple;
	bh=rgYJ+hvcel3iKJrUWBInSqobvK0vUg62K3lxOg+9uVw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KyO0t3S6bEGx/BXu669/rb1afBI39q9bsqXkOitWcHWz86gOD1uzHHZ9Sn6ZCHf/OOiqhAS3Fum8kRdPvxdETL6GLbw+b+Ixj6hJlnIPc8tF1syskBZvnG+l6Pam62nHBHyzzdXVp4p+v318dMEYiO8OU3q4SKapCy9qt+qVY8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47DEC433F1;
	Thu, 28 Mar 2024 22:06:33 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/52] USB: store owner from modules with
 usb_serial_register_drivers()
Date: Thu, 28 Mar 2024 23:05:38 +0100
Message-Id: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALLpBWYC/x3MQQ5AMBBA0avIrE1SQxBXEYtiMAmttCkScXdl+
 Rb/3+DZCXtokhscH+LFmogsTWBYtJkZZYwGUlSonGrc7BhWRnsadhh8j99Ar1hrVVZTSdRXCmK
 9O57k+s9t9zwvjAzICWkAAAA=
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6726;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=rgYJ+hvcel3iKJrUWBInSqobvK0vUg62K3lxOg+9uVw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBem7P90A6+d5czXeaa2TzeB9KiQmqJFykqfao
 fBEM1oOFvWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpuwAKCRDBN2bmhouD
 160PD/9rXK1Yby2eUNddT+VNITlT16L+nNRFAdBDTWh+HNqNJw2gO2qNmb4lNROzD8BdhJAjvGo
 H6aZgu04GThTEAPRfXHctd+a66EmryksYsRqskV/hMquSQYdFCupTbNkN1eoy9TUWfO7gHl2xWr
 PWQhMslMmUl2+UJkLFRS8LIpD6Q69b2bvE+Vg1JY0dD3zIFFgjOALzeKLNa9k9Kbips7bCn4U0U
 KB/qXaA/w1hdjLlpOAvj+vFnb6KQ6oQXKRCI5kyYR1L5pW5rvavK3ry5/KrVkXKRpzLV6CoGfDS
 eWBUD7a38CQj1dzl63eYfI5KkHZzyjyOcjNx/peimw25fm19dpOBy5Nk1PGwUgWr9LOedE5NdKc
 hTNXE4rYhRztT1THErLyRmCYqEnQar7NvOPi3G2adfGlWrf/Sbn8KTDMKKhSCFOIed2FJaJgU6W
 z5xcl+8o/fiieQl25UJgN1/HURmalzs+WzwmdkJXW2ryZJz3KGyQqIojQAYcCDRuna3luYWJz9F
 ebHpQNyfm7TKFoGVkjST4HlGugjwL9eTWVkkzqxjDx+JZ/UXeuc7Oc/9EI+TjI0LhtJEWlQaysD
 WleQJUxD80OUcjUmuxu08HMOG3WLIRjfbHxzJcP7fIMDNGeuUcO6IuePMUtpQ4+7tWRh6mpt7gY
 agn5++yjYjuojgg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Merging
=======
All further patches depend on the first patch.

Description
===========
This is going to be a bit of a patch-bomb, but with trivial patches, so
I think it is still acceptable. If it is too much, apologies and I will
solve it.

Modules registering driver with usb_serial_register_drivers() might
forget to set .owner field.

Solve the problem by moving this task away from the drivers to the core
amba bus code, just like we did for platform_driver in commit
9447057eaff8 ("platform_device: use a macro instead of
platform_driver_register").

Best regards,
Krzysztof

---
Krzysztof Kozlowski (52):
      USB: serial: store owner from modules with usb_serial_register_drivers()
      USB: serial: aircable: drop driver owner initialization
      USB: serial: ark3116: drop driver owner initialization
      USB: serial: belkin_sa: drop driver owner initialization
      USB: serial: ch341: drop driver owner initialization
      USB: serial: cp210x: drop driver owner initialization
      USB: serial: cyberjack: drop driver owner initialization
      USB: serial: cypress_m8: drop driver owner initialization
      USB: serial: digi_acceleport: drop driver owner initialization
      USB: serial: empeg: drop driver owner initialization
      USB: serial: f81232: drop driver owner initialization
      USB: serial: ftdi_sio: drop driver owner initialization
      USB: serial: garmin_gps: drop driver owner initialization
      USB: serial: generic: drop driver owner initialization
      USB: serial: io_edgeport: drop driver owner initialization
      USB: serial: io_ti: drop driver owner initialization
      USB: serial: ipaq: drop driver owner initialization
      USB: serial: ipw: drop driver owner initialization
      USB: serial: ir-usb: drop driver owner initialization
      USB: serial: iuu: drop driver owner initialization
      USB: serial: keyspan: drop driver owner initialization
      USB: serial: keyspan_pda: drop driver owner initialization
      USB: serial: kl5kusb105: drop driver owner initialization
      USB: serial: kobil_sct: drop driver owner initialization
      USB: serial: mct_u232: drop driver owner initialization
      USB: serial: metro_usb: drop driver owner initialization
      USB: serial: mos7720: drop driver owner initialization
      USB: serial: mos7840: drop driver owner initialization
      USB: serial: mxuport: drop driver owner initialization
      USB: serial: navman: drop driver owner initialization
      USB: serial: omninet: drop driver owner initialization
      USB: serial: opticon: drop driver owner initialization
      USB: serial: option: drop driver owner initialization
      USB: serial: oti6858: drop driver owner initialization
      USB: serial: pl2303: drop driver owner initialization
      USB: serial: qcaux: drop driver owner initialization
      USB: serial: qcserial: drop driver owner initialization
      USB: serial: quatech2: drop driver owner initialization
      USB: serial: safe_serial: drop driver owner initialization
      USB: serial: sierra: drop driver owner initialization
      USB: serial: spcp8x5: drop driver owner initialization
      USB: serial: ssu100: drop driver owner initialization
      USB: serial: symbol: drop driver owner initialization
      USB: serial: ti_usb_3410_5052: drop driver owner initialization
      USB: serial: upd78f0730: drop driver owner initialization
      USB: serial: simple: drop driver owner initialization
      USB: serial: debug: drop driver owner initialization
      USB: serial: visor: drop driver owner initialization
      USB: serial: whiteheat: drop driver owner initialization
      USB: serial: wishbone: drop driver owner initialization
      USB: serial: xr: drop driver owner initialization
      USB: serial: xsens_mt: drop driver owner initialization

 drivers/usb/serial/aircable.c          |  1 -
 drivers/usb/serial/ark3116.c           |  1 -
 drivers/usb/serial/belkin_sa.c         |  1 -
 drivers/usb/serial/ch341.c             |  1 -
 drivers/usb/serial/cp210x.c            |  1 -
 drivers/usb/serial/cyberjack.c         |  1 -
 drivers/usb/serial/cypress_m8.c        |  3 ---
 drivers/usb/serial/digi_acceleport.c   |  2 --
 drivers/usb/serial/empeg.c             |  1 -
 drivers/usb/serial/f81232.c            |  2 --
 drivers/usb/serial/ftdi_sio.c          |  1 -
 drivers/usb/serial/garmin_gps.c        |  1 -
 drivers/usb/serial/generic.c           |  1 -
 drivers/usb/serial/io_edgeport.c       |  4 ----
 drivers/usb/serial/io_ti.c             |  2 --
 drivers/usb/serial/ipaq.c              |  1 -
 drivers/usb/serial/ipw.c               |  1 -
 drivers/usb/serial/ir-usb.c            |  1 -
 drivers/usb/serial/iuu_phoenix.c       |  1 -
 drivers/usb/serial/keyspan.c           |  4 ----
 drivers/usb/serial/keyspan_pda.c       |  2 --
 drivers/usb/serial/kl5kusb105.c        |  1 -
 drivers/usb/serial/kobil_sct.c         |  1 -
 drivers/usb/serial/mct_u232.c          |  1 -
 drivers/usb/serial/metro-usb.c         |  1 -
 drivers/usb/serial/mos7720.c           |  1 -
 drivers/usb/serial/mos7840.c           |  1 -
 drivers/usb/serial/mxuport.c           |  1 -
 drivers/usb/serial/navman.c            |  1 -
 drivers/usb/serial/omninet.c           |  1 -
 drivers/usb/serial/opticon.c           |  1 -
 drivers/usb/serial/option.c            |  1 -
 drivers/usb/serial/oti6858.c           |  1 -
 drivers/usb/serial/pl2303.c            |  1 -
 drivers/usb/serial/qcaux.c             |  1 -
 drivers/usb/serial/qcserial.c          |  1 -
 drivers/usb/serial/quatech2.c          |  1 -
 drivers/usb/serial/safe_serial.c       |  1 -
 drivers/usb/serial/sierra.c            |  1 -
 drivers/usb/serial/spcp8x5.c           |  1 -
 drivers/usb/serial/ssu100.c            |  1 -
 drivers/usb/serial/symbolserial.c      |  1 -
 drivers/usb/serial/ti_usb_3410_5052.c  |  2 --
 drivers/usb/serial/upd78f0730.c        |  1 -
 drivers/usb/serial/usb-serial-simple.c |  1 -
 drivers/usb/serial/usb-serial.c        | 12 +++++++-----
 drivers/usb/serial/usb_debug.c         |  2 --
 drivers/usb/serial/visor.c             |  3 ---
 drivers/usb/serial/whiteheat.c         |  2 --
 drivers/usb/serial/wishbone-serial.c   |  1 -
 drivers/usb/serial/xr_serial.c         |  1 -
 drivers/usb/serial/xsens_mt.c          |  1 -
 include/linux/usb/serial.h             |  7 +++++--
 53 files changed, 12 insertions(+), 75 deletions(-)
---
base-commit: 7fdcff3312e16ba8d1419f8a18f465c5cc235ecf
change-id: 20240328-module-owner-usb-serial-8a067f622b70

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


