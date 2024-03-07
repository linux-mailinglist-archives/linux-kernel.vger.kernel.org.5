Return-Path: <linux-kernel+bounces-95258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CA0874B6F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD767B213D5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F2B8528F;
	Thu,  7 Mar 2024 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k/yUmt4K"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D5484FCE;
	Thu,  7 Mar 2024 09:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805319; cv=none; b=HaVTHdriEJTGP8yq/h0sX4WJHBgegpPblw0jZEgkgvX0zhPL9n34TqlHj+pZB+xNXbodtNKoO6edk8dwvEGRLy/LLQZpzWufOE+79tpOZIuuN9cisTNgtvkDRfS+mEyNUxWCCX9iEFTUvewkzqxSMPbskGzl50AlgMsQRLPsUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805319; c=relaxed/simple;
	bh=GX4KTVPwu7/sM0ebVF3+c9yx37JZf8jPLcPRgBdmNTE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D3ji6phbQLlZZ3iEJxrU+qPH3UD9l4yaG1GxWPvSROJ6wyB94oCRkqfIpdXLjHICxat8RdOs53t8tTri3q+DbtOSq5yYMp5SN1th7J+/fVHAAVtO4R9R6ViiG5v1ZjWM5JcyQZeHV0MB00z78bdMHvXCXuUIuxrnHBQaLJUZ67s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k/yUmt4K; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C43F81C000D;
	Thu,  7 Mar 2024 09:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709805309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FrpwCNaPpyNVsE9fXv374zUizJeKHMMetWPo1eTKKX8=;
	b=k/yUmt4KXSwbxveB9wpW16SJznSJ9mRn6kLa8aaHoW4mozDs/f0A5uTGDym04VWj41AMI3
	rzF0rmTpqAKPJMNXffFVGi33HJ5K44JM1ZB5JNFnKMIFUthFq2GklqZfFblwxSJNhjFX8H
	DLxcvcS6cS+z/SfdE5fgP/vMtJ6/GMnYJRFZo5vceWJZYJPuZ7k75JqxzLe6eT7ywuRsdP
	lrlZMbPuv/KDqSzoH2hURhAHMtpc9u1V54PYCrby7e+hrmZC8sTZNEWJepZG4x478cGi3D
	4FUrENZksqXUPl5MJt7tuH3BqXRCl0pthrQc5Ka3g3DEWLrgDdxzgUFyEDfkmw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v4 0/9] usb: cdns: fix suspend on J7200 by assuming
 reset-on-resume
Date: Thu, 07 Mar 2024 10:55:01 +0100
Message-Id: <20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPaO6WUC/33OSwrCMBCA4atI1kbmEWl15T3ERZpONaJNadqil
 N7dVBAUxeU/MN/MqKK0XqLaLkbVyuCjD3UKs1wod7L1UbQvUysCYkRkfc4IQPex0LGPjdSlJmu
 yiihHAaPSXtNK5W9Pc39IffKxC+39eWLAefpPG1CDtiWKZGhyXrtdEUJ38fXKhauavYHeDIJfB
 iUDOHeZGMtlZb4NfhkGiH7+wckoDLpNvmGLDJ/GNE0PLxdAZDwBAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>, 
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Kevin Hilman <khilman@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Hi,

Here is a new revision of the J7200 USB suspend fix. It is currently
broken on the platform, leading to a kernel panic at resume. Patches
are tested on a J7200 evaluation board, both s2idle and suspend-to-RAM.

This revision only changes dt-bindings and DTS stuff. We fix the current
situation (as discussed previously [0]) and add our J7200 compatible.

Have a nice day,
Théo

[0]: https://lore.kernel.org/lkml/20240223-j7200-usb-suspend-v3-1-b41c9893a130@bootlin.com/

--
Théo Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v4:
- dt-bindings: usb: ti,j721e-usb:
  - Remove ti,am64-usb single compatible entry.
  - Reverse ordering of compatible pair j721e + am64
    (becoming am64 + j721e).
  - Add j7200 + j721e compatible pair (versus only j7200). It is the
    same thing as am64: only the integration differs with base j721e
    compatible.
  - NOT taking trailers from Conor as patches changed substantially.
- arm64: dts: ti: j3-j7200:
  - Use j7200 + j721e compatible pair (versus only j7200 previously).
- arm64: dts: ti: j3-am64:
  - Fix to use am64 + j721e compatible pair (versus only am64).
    This is a new patch.
- Link to v3: https://lore.kernel.org/r/20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com

Changes in v3:
- dt-bindings: use an enum to list compatibles instead of the previous
  odd construct. This is done in a separate patch from the one adding
  J7200 compatible.
- dt-bindings: dropped Acked-by Conor as the changes were modified a lot.
- Add runtime PM back. Put the init sequence in ->runtime_resume(). It
  gets called at probe for all compatibles and at resume for J7200.
- Introduce a cdns_ti_match_data struct rather than rely on compatible
  from code.
- Reorder code changes. Add infrastructure based on match data THEN add
  compatible and its match data.
- DTSI: use only J7200 compatible rather than both J7200 then J721E.
- Link to v2: https://lore.kernel.org/r/20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com

Changes in v2:
- Remove runtime PM from cdns3-ti; it brings nothing. That means our
  cdns3-ti suspend/resume patch is simpler; there is no need to handle
  runtime PM at suspend/resume.
- Do not add cdns3 host role suspend/resume callbacks; they are not
  needed as core detects reset on resume & calls cdns_drd_host_on when
  needed.
- cdns3-ti: Move usb2_refclk_rate_code assignment closer to the value
  computation.
- cdns3/host.c: do not pass XHCI_SUSPEND_RESUME_CLKS quirk to xHCI; it
  is unneeded on our platform.
- Link to v1: https://lore.kernel.org/r/20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com

---
Théo Lebrun (9):
      dt-bindings: usb: ti,j721e-usb: fix compatible list
      dt-bindings: usb: ti,j721e-usb: add ti,j7200-usb compatible
      usb: cdns3-ti: move reg writes from probe into ->runtime_resume()
      usb: cdns3-ti: support reset-on-resume behavior
      usb: cdns3-ti: pass auxdata from match data to of_platform_populate()
      usb: cdns3: add quirk to platform data for reset-on-resume
      usb: cdns3-ti: add J7200 support with reset-on-resume behavior
      arm64: dts: ti: k3-j7200: use J7200-specific USB compatible
      arm64: dts: ti: k3-am64: add USB fallback compatible to J721E

 .../devicetree/bindings/usb/ti,j721e-usb.yaml      |   6 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |   2 +-
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          |   2 +-
 drivers/usb/cdns3/cdns3-ti.c                       | 125 ++++++++++++++++-----
 drivers/usb/cdns3/core.h                           |   1 +
 drivers/usb/cdns3/host.c                           |   3 +
 6 files changed, 105 insertions(+), 34 deletions(-)
---
base-commit: 1871c27e3539e5b812d50ec6ccad7567ec5414f2
change-id: 20231113-j7200-usb-suspend-2a47f2281e04

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


