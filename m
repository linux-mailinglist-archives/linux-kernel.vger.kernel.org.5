Return-Path: <linux-kernel+bounces-27330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4CD82EDE0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86571F24533
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32E41B81F;
	Tue, 16 Jan 2024 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rA40L7Fi"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E811B800;
	Tue, 16 Jan 2024 11:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705405121; x=1736941121;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PQeNXtr+NkYNtKHVcFa9uvxt+sHMYxZ2puRpVAyiBNw=;
  b=rA40L7FiKhu5I2uM5ElUT+w46g4MM6v79FjdhrjdVBVtwqAQMrsg2Gj/
   GFLrCmYQfAawyZZxofSP+rVw4Q6T0WN59jCnJ0aBOSJCxev59ltLNtxqG
   uCXLjGx8W0eYT4twhwiOeWLCn0IwcvB9/OC3aIUJguze/a/UnIgnGUP9A
   fBuQGnC9sAaSwIiT60mjpHQdWQD169dpFbuaDeU6LeBSAKsDE70xdJrgU
   0YjJJfJQTReGo6TPG1EZXvHn3GOlhLL1WEQ9Q+psMRjgGZ3ecXXvyo5ir
   Rrwu1Enu9wIn6YLNPplZxjZlZzbgwD5iqdkypXezT27azhxbHP10x9TaZ
   Q==;
X-CSE-ConnectionGUID: Y1TZTt6mTzupuVN87CGEZQ==
X-CSE-MsgGUID: wavDEACOS9Og9sJptBYlHw==
X-IronPort-AV: E=Sophos;i="6.05,199,1701154800"; 
   d="scan'208";a="14824997"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2024 04:38:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 04:38:26 -0700
Received: from che-lt-i70843lx.amer.actel.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 04:38:14 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <conor.dooley@microchip.com>, <sam@ravnborg.org>, <bbrezillon@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lee@kernel.org>, <thierry.reding@gmail.com>,
	<u.kleine-koenig@pengutronix.de>, <linux-pwm@vger.kernel.org>
CC: <linux4microchip@microchip.com>, Dharma Balasubiramani
	<dharma.b@microchip.com>
Subject: [PATCH v2 0/3] Convert Microchip's HLCDC Text based DT bindings to JSON schema
Date: Tue, 16 Jan 2024 17:07:57 +0530
Message-ID: <20240116113800.82529-1-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Converted the text bindings to YAML and validated them individually using following commands

$ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/
$ make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/

changelogs are available in respective patches.

Dharma Balasubiramani (3):
  dt-bindings: display: convert Atmel's HLCDC to DT schema
  dt-bindings: atmel,hlcdc: convert pwm bindings to json-schema
  dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format

 .../atmel/atmel,hlcdc-display-controller.yaml | 110 ++++++++++++++++++
 .../bindings/display/atmel/hlcdc-dc.txt       |  75 ------------
 .../devicetree/bindings/mfd/atmel,hlcdc.yaml  | 105 +++++++++++++++++
 .../devicetree/bindings/mfd/atmel-hlcdc.txt   |  56 ---------
 .../bindings/pwm/atmel,hlcdc-pwm.yaml         |  47 ++++++++
 .../bindings/pwm/atmel-hlcdc-pwm.txt          |  29 -----
 6 files changed, 262 insertions(+), 160 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-display-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt

-- 
2.25.1


