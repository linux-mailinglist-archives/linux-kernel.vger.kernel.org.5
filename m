Return-Path: <linux-kernel+bounces-106333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6907487ECA2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899711C20E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAAD53391;
	Mon, 18 Mar 2024 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wQaAlgF7"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16D7524D1;
	Mon, 18 Mar 2024 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777072; cv=none; b=qN0IkzWACVl05251TD9jX9DfflAa4ELWeLSO3VnYLFIFzPwBog/i/yiLneeXsKF9cin1OVnnqVaQDyedNxAbOkgsLpqE6G+TMaNDty2ewD3PQX7ZExzP/iO/zLaCCw6SmjEFNvZ7jqydCwwpVIlv+4TECswiQRzy6P438IQkUoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777072; c=relaxed/simple;
	bh=ey41zW7cilaZHFny2QLte4eGi7mCyvfDTnx7ZAEyFhE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A5ptLWfE2LPe64nt6TQ8ZHEtNY9T+ioVIIPDaxTXMBOxRWz9rfacJIzMq8O9RxD29gJFJagoOvGhuGfL4Jck+yLYIGZs7xB2G7UWP5R7+uoLEQDkt/FI/jEyvBr041+JdcITgWHvmPHSWbCKDrcZsXeMczuSojf7WzVZJ3VqYJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wQaAlgF7; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DB39A2A5;
	Mon, 18 Mar 2024 16:50:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710777040;
	bh=ey41zW7cilaZHFny2QLte4eGi7mCyvfDTnx7ZAEyFhE=;
	h=From:Subject:Date:To:Cc:From;
	b=wQaAlgF7cY0I9zK93ZQa4Rktbs7LfywXjXsKlDwydEnjKpoDkMIOdNMeK/oZh8wds
	 0VwZOil91ypK/Tpmv0bKrjm9I3BOSKonnijJVP+eePH2k6xzD52+WOdBU9c2UoKCxg
	 ueCntxev0sd6yWydjKbPq2SSAQymG1Ftf5LrC/uQ=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/4] media: raspberrypi: Support RPi5's CFE
Date: Mon, 18 Mar 2024 17:49:55 +0200
Message-Id: <20240318-rp1-cfe-v1-0-ac6d960ff22d@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKRi+GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0MT3aICQ93ktFRdQxOjJDMjiyRzI0MTJaDqgqLUtMwKsEnRsbW1AEf
 iHdVZAAAA
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Naushir Patuck <naush@raspberrypi.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3886;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=ey41zW7cilaZHFny2QLte4eGi7mCyvfDTnx7ZAEyFhE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBl+GLkN3N05QSjcuydlBFJSye5DaOwL1ujsQmNl
 8VxrTRncxuJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZfhi5AAKCRD6PaqMvJYe
 9UMGD/9u9kAGm9u2EwcGdtyVt+G+RrFu7OcujX8GwWlJ5BM2U3ocWxaIlW7E/hU5MIJ2UuCk1RV
 gbEGLaRubgXTd1iUhIDdvrhRK9u3twOM5jC6VERSSPCI87a20UIsdjnGuy/1lUni2hnyz3wuXWR
 TJoVJgCT7nxQvfmB2iuKSXUH06ai4HH8G1jiZbuUVtwDjwHdi2RNziiQpF2WzQcIhQZrHn2bTHS
 E0e4kyNCxTT8/iHB7cWNO2L0XYkQ3cpkLwDBwvw1fi4dRy14n6vPB34xjTn0uhrjSBF8gQx7oMT
 LS8BmM95F4f4jE56eiRmnK8QxoEaRIjgFPCKzHAXl5IeWhUPjbPOms7BL6pOFNbzI0x4fmn91sI
 c6G+ruQ0I7JXf2EGBmh03fbwGLAoUsBXQPRgDWdyyWaRIxvlQJqgzXm5XYaFcBYWLWfD7lEvner
 ngwmOJcQHkwqiTL4DFGgLtQ2/b9vnwDuQPOOScgL7U0GgX88/BlpB+eVuDB5BiCJZmPfOk4d19e
 sBFLnBLHu9FEIKUfvDESMS0jLhbh1IFU4MIS0PSONbW1zsHzvDO2M0I6X95m0hhDO8Rqvkz3Zl8
 QhjOkr2BNlQOifXACNetze/3xhXFgiEo/GSnmTNynB+z+uz+3V/6/tdqy0wHgmWv+WXHX6CFbls
 F7F2oLAPYBwdIKA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

This series adds support to the CFE hardware block on RaspberryPi 5. The
CFE (Camera Front End) contains a CSI-2 receiver and Front End, a small
ISP.

This series is currently based on multiple other serieses:

- Sakari's "[PATCH v8 00/38] Generic line based metadata support, internal
  pads" for metadata support
- Laurent's "[PATCH 00/15] media: Add driver for the Raspberry Pi <5
  CSI-2 receiver" for a few new pixel formats and imx219 (for testing).
- Jacopo's "[PATCH v5 0/9] media: raspberrypi: Add support for PiSP Back
  End" for some shared uapi headers.

And to run this, one of course needs the basic RPi5 kernel support plus
relevant dts changes to enable the cfe and camera.

So at the moment we cannot merge this driver, but hopefully the
dependencies will get merged before the reviews on this one are done.

A few notes about the patches:

- The original work was done by RaspberryPi, mostly by Naushir Patuck.
- The second video node only sets V4L2_CAP_META_CAPTURE instead of both
  V4L2_CAP_META_CAPTURE and V4L2_CAP_META_CAPTURE like the other nodes.
  This is a temporary workaround for userspace (libcamera), and
  hopefully can be removed soon.
- The compatible string is set to "raspberrypi,rpi5-rp1-cfe". I added
  the "rpi5" part as versioning, as there's no clear CFE hardware
  version defined. I'm open to other suggestions on the versioning
  scheme.

I have tested this with:
- A single IMX219 sensor connected to the RPi5's CSI-2 port
- Arducam's UB960 FPD-Link board with four imx219 sensors connected

I have pushed my branch, with all the dependencies and everything needed
to run this, to:

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git rp1-cfe

 Tomi

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Tomi Valkeinen (4):
      media: uapi: Add meta formats for PiSP FE config and stats
      dt-bindings: media: Add bindings for raspberrypi,rp1-cfe
      media: raspberrypi: Add support for RP1-CFE
      media: admin-guide: Document the Raspberry Pi CFE (rp1-cfe)

 .../admin-guide/media/raspberrypi-rp1-cfe.dot      |   27 +
 .../admin-guide/media/raspberrypi-rp1-cfe.rst      |   78 +
 Documentation/admin-guide/media/v4l-drivers.rst    |    1 +
 .../bindings/media/raspberrypi,rp1-cfe.yaml        |  103 +
 .../userspace-api/media/v4l/meta-formats.rst       |    1 +
 .../userspace-api/media/v4l/metafmt-pisp-fe.rst    |   39 +
 MAINTAINERS                                        |    8 +
 drivers/media/platform/raspberrypi/Kconfig         |    1 +
 drivers/media/platform/raspberrypi/Makefile        |    1 +
 drivers/media/platform/raspberrypi/rp1-cfe/Kconfig |   14 +
 .../media/platform/raspberrypi/rp1-cfe/Makefile    |    6 +
 .../media/platform/raspberrypi/rp1-cfe/cfe-fmts.h  |  330 +++
 .../media/platform/raspberrypi/rp1-cfe/cfe-trace.h |  196 ++
 drivers/media/platform/raspberrypi/rp1-cfe/cfe.c   | 2526 ++++++++++++++++++++
 drivers/media/platform/raspberrypi/rp1-cfe/cfe.h   |   43 +
 drivers/media/platform/raspberrypi/rp1-cfe/csi2.c  |  579 +++++
 drivers/media/platform/raspberrypi/rp1-cfe/csi2.h  |   89 +
 drivers/media/platform/raspberrypi/rp1-cfe/dphy.c  |  175 ++
 drivers/media/platform/raspberrypi/rp1-cfe/dphy.h  |   27 +
 .../media/platform/raspberrypi/rp1-cfe/pisp-fe.c   |  581 +++++
 .../media/platform/raspberrypi/rp1-cfe/pisp-fe.h   |   53 +
 drivers/media/v4l2-core/v4l2-ioctl.c               |    2 +
 .../uapi/linux/media/raspberrypi/pisp_fe_config.h  |  273 +++
 .../linux/media/raspberrypi/pisp_fe_statistics.h   |   64 +
 include/uapi/linux/videodev2.h                     |    2 +
 25 files changed, 5219 insertions(+)
---
base-commit: d87156e95652bc6463f86b25149f75cc3b8742eb
change-id: 20240314-rp1-cfe-142b628b7214

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


