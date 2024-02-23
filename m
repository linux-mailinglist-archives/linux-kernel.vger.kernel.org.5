Return-Path: <linux-kernel+bounces-78665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F9A8616DE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C59A2883A1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451E684A4B;
	Fri, 23 Feb 2024 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZDKjekhr"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A83383A0D;
	Fri, 23 Feb 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704335; cv=none; b=HwAJJpj9AcRrGS6kyuOTYWBDtDLpctcAQjShu9IWf5toWIUWt0BaHQEa7MQEi6a/6hmfngHV3+pev1JFO+o53JYNOKIH+2tMxv3CEwbBHNkVsaTJxW6nbII+GoNfTaK2Wrc7TIBLaHBewTIsw/Slgg30ZyktmHbMHWyZ/R8luiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704335; c=relaxed/simple;
	bh=ckeNdwKsC7xFdcIdJOzsr7JiLrTGk1/eeg9eGYwEzKU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E0QNiKM6KxXx2bJiNPPE0G2QD4qpi9IZIkuKrpkDTAbCgRgRVcTiYWqUXmK1dHHYwANFu7XO7YkWJ+/ypoKl4YrBvs1WzMsV4VlK9iUqXPh09JBLjW7I6i0aJmmqcz2hOvPiAssMw/wVNxpLyeKqntD/ERX4fii/20uc9f6LCQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZDKjekhr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B59301C000A;
	Fri, 23 Feb 2024 16:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708704331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Li2+I12FfS24iUKA1Zm8E3sY5gCIrsUZEr/2pyoOe/g=;
	b=ZDKjekhrBvoTORZMLUVtzJZVQyZjl8JU/y5/R8bKyl5gKTSmD9cXKcE/nscy8dgBfEUceK
	N6upG2D46KFXNhKm0//+/g70X5rQ55gmMdI5TG5uWHunuowJnnoPk+oAMYuCqUDbn8EK4V
	idck7zSTCXMrcxVUXeT7AVv4JYKI5Gy+iKRuJFI9Dy73zwZT1Ce8ebFsYo79zqbZBa69ov
	k86Dr0hzH6di6CzqtwaPZiVgS6nKBdgeiiUOU7BsFb5+UvUhHrg31mVP9ihGHRUEXEKc98
	6hR0+J8WIn+J1tKSUGQGAVEcW7hZjT+9jO17Zz1xkgo2tSfvrpP2L0BlrNdS8A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v3 0/8] usb: cdns: fix suspend on J7200 by assuming
 reset-on-resume
Date: Fri, 23 Feb 2024 17:05:24 +0100
Message-Id: <20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAETC2GUC/33NQQrCMBCF4auUrI1kJpEUV95DXKTJ1Ea0KUkbl
 NK7m3alIC7/B/PNzBJFT4kdq5lFyj750JeQu4rZzvRX4t6VZihQAoDkN41C8Ck1PE1poN5xNEq
 3iDWQUKzcDZFa/9zM86V059MY4mt7kWFd/2kZuODGAZEGVcuDPTUhjHff7214sNXL+GGg+GVgM
 YSsrSZlpGvVt7EsyxtJOEvJ+AAAAA==
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

Previous discussion showed that runtime PM was not to be deleted.
Indeed, we cannot guarantee PM domains will stay active if we don't
register to runtime PM.

We therefore rely fully on runtime PM and put our init sequence
previously done in the probe in our ->runtime_resume(). We then do the
necessary to get it called at system-wide resume for the J7200
platform.

Have a nice day,
Théo

--
Théo Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
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
Théo Lebrun (8):
      dt-bindings: usb: ti,j721e-usb: drop useless compatible list
      dt-bindings: usb: ti,j721e-usb: add ti,j7200-usb compatible
      usb: cdns3-ti: move reg writes from probe into ->runtime_resume()
      usb: cdns3-ti: support reset-on-resume behavior
      usb: cdns3-ti: pass auxdata from match data to of_platform_populate()
      usb: cdns3: add quirk to platform data for reset-on-resume
      usb: cdns3-ti: add J7200 support with reset-on-resume behavior
      arm64: dts: ti: k3-j7200: use J7200-specific USB compatible

 .../devicetree/bindings/usb/ti,j721e-usb.yaml      |  10 +-
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          |   2 +-
 drivers/usb/cdns3/cdns3-ti.c                       | 125 ++++++++++++++++-----
 drivers/usb/cdns3/core.h                           |   1 +
 drivers/usb/cdns3/host.c                           |   3 +
 5 files changed, 104 insertions(+), 37 deletions(-)
---
base-commit: 1871c27e3539e5b812d50ec6ccad7567ec5414f2
change-id: 20231113-j7200-usb-suspend-2a47f2281e04

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


