Return-Path: <linux-kernel+bounces-17291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D020E824AF4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1092857DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029082C872;
	Thu,  4 Jan 2024 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VJach6FS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A195328DB0;
	Thu,  4 Jan 2024 22:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 404HdK1Z029968;
	Thu, 4 Jan 2024 16:37:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=M
	Shzt3LVhFxMMuG6ippnJ3aKDGhRinbXBUUZ94iQi08=; b=VJach6FSwwbzt9KmI
	GWjCTzJzGjLLeGGhyU96URR9nObLd4F+tECWcYZVXnh9so3tG/UyD3OMzAekeJPR
	yO/CLF3Cyt7sS9sZJyxiSlsdFeIczLXTD5+PjX+5DTlD0ryn/29hyd5YeCCMTar+
	M/udBGMya454ibWyxn9mZERg12Gx+HFsP6vi67cBDnTcXnfDUQ4e5IDq+FZh07xm
	2g4iFzL2z5yxYKuAfCFpe3VFVdbw7LwUZy0BJ72/MAisZP7A6Z1U4RqpguIX4THo
	aixE2vx4Yx9W5aqLCMOJ1qbD5sAcq5X8nf12uir/DFeip6K2PC+GakcXUOR9tHSS
	LIY4Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ve18src5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 16:37:18 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 4 Jan
 2024 22:37:16 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Thu, 4 Jan 2024 22:37:01 +0000
Received: from aus-sw-rshr002.ad.cirrus.com (aus-sw-rshr002.ad.cirrus.com [141.131.145.53])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E99CC474;
	Thu,  4 Jan 2024 22:36:56 +0000 (UTC)
From: James Ogletree <jogletre@opensource.cirrus.com>
To: 
CC: James Ogletree <jogletre@opensource.cirrus.com>,
        James Ogletree
	<james.ogletree@cirrus.com>,
        Fred Treven <fred.treven@cirrus.com>,
        Ben Bright
	<ben.bright@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rob
 Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax
	<ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, Liam Girdwood
	<lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        James Schulman
	<james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai
	<ping.bai@nxp.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Weidong Wang
	<wangweidong.a@awinic.com>,
        Herve Codina <herve.codina@bootlin.com>,
        "Arnd
 Bergmann" <arnd@arndb.de>, Shuming Fan <shumingf@realtek.com>,
        Shenghao Ding
	<13916275206@139.com>, Ryan Lee <ryans.lee@analog.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        "open
 list:CIRRUS LOGIC HAPTIC DRIVERS" <patches@opensource.cirrus.com>,
        "open
 list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
	<linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        "open list:SOUND - SOC LAYER / DYNAMIC AUDIO
 POWER MANAGEM..." <linux-sound@vger.kernel.org>,
        "moderated list:CIRRUS LOGIC
 AUDIO CODEC DRIVERS" <alsa-devel@alsa-project.org>
Subject: [PATCH v5 0/5] Add support for CS40L50
Date: Thu, 4 Jan 2024 22:36:33 +0000
Message-ID: <20240104223643.876292-1-jogletre@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rpOIz0vGtpWU2aw1DIz15-q1kEDNu-vQ
X-Proofpoint-GUID: rpOIz0vGtpWU2aw1DIz15-q1kEDNu-vQ
X-Proofpoint-Spam-Reason: safe

There is a massive delta from V4, so only the highlgihts are
mentioned below. I intend for this version to address all
feedback to-date, so if you find something left unaddressed
then please let me know.

Changes in v5:
- Added a codec sub-device to support I2S streaming
- Moved write sequencer code from cirrus_haptics to cs_dsp
- Reverted cirrus_haptics library; future Cirrus input
  drivers will export and utilize cs40l50_vibra functions
- Added more comments
- Many small stylistic and logical improvements

Changes in v4:
- Moved from Input to MFD
- Moved common Cirrus haptic functions to a library
- Incorporated runtime PM framework
- Many style improvements

Changes in v3:
- YAML formatting corrections
- Fixed typo in MAINTAINERS
- Used generic node name "haptic-driver"
- Fixed probe error code paths
- Switched to "sizeof(*)"
- Removed tree reference in MAINTAINERS

Changes in v2:
- Fixed checkpatch warnings

James Ogletree (5):
  firmware: cs_dsp: Add write sequencer interface
  dt-bindings: input: cirrus,cs40l50: Add initial DT binding
  mfd: cs40l50: Add support for CS40L50 core driver
  Input: cs40l50 - Add support for the CS40L50 haptic driver
  ASoC: cs40l50: Support I2S streaming to CS40L50

 .../bindings/input/cirrus,cs40l50.yaml        |  70 +++
 MAINTAINERS                                   |  12 +
 drivers/firmware/cirrus/cs_dsp.c              | 261 ++++++++
 drivers/input/misc/Kconfig                    |  10 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/cs40l50-vibra.c            | 572 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  30 +
 drivers/mfd/Makefile                          |   4 +
 drivers/mfd/cs40l50-core.c                    | 536 ++++++++++++++++
 drivers/mfd/cs40l50-i2c.c                     |  69 +++
 drivers/mfd/cs40l50-spi.c                     |  69 +++
 include/linux/firmware/cirrus/cs_dsp.h        |  28 +
 include/linux/mfd/cs40l50.h                   | 128 ++++
 sound/soc/codecs/Kconfig                      |  11 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/cs40l50-codec.c              | 304 ++++++++++
 16 files changed, 2107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
 create mode 100644 drivers/input/misc/cs40l50-vibra.c
 create mode 100644 drivers/mfd/cs40l50-core.c
 create mode 100644 drivers/mfd/cs40l50-i2c.c
 create mode 100644 drivers/mfd/cs40l50-spi.c
 create mode 100644 include/linux/mfd/cs40l50.h
 create mode 100644 sound/soc/codecs/cs40l50-codec.c

-- 
2.25.1


