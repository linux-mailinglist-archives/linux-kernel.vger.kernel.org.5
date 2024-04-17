Return-Path: <linux-kernel+bounces-148589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A49808A84CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2923E1F2131C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE2E13F440;
	Wed, 17 Apr 2024 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Iut6ZCoQ"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309013E02E;
	Wed, 17 Apr 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360964; cv=none; b=CMoBjUoWgvGI9NPtGMcbWyI2S06d6AcAvdrvLaDDoGSThw7TaqFaX04DLea7P6EdkzlP3NzIG7UievkkAkjz+CX61wcgVV6D03Zwc6haPfavDTLI8/m8vaXi6rKOzJykCKFoskMYskpFWm3K2aZ1jA/GmewIUe4SS4uZ6NxhxxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360964; c=relaxed/simple;
	bh=h92k1xHyMgFVok7WfNz9v6tzZtdrwMuIrOivWMDoZ6A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ggusTHpkFHUk9u0Su4+nDXwkzBTQiqImFJcxF1/gaKli/bNW7viNiJoHRdqZW/BNtYcczhW2nLs+Pd7Bb0vRojDt58MdHb7RCv78W4ddCdhEaAHiCvrRGZRyn7mDQqxs2pftEQbMi4hKUFMbkWTiymN8t8xUu1RXYcdx26ir7uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Iut6ZCoQ; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HD5rGh028141;
	Wed, 17 Apr 2024 15:35:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	selector1; bh=mAzfUH2JQVtTcRFhC4KauimOnBF3lRBNQq0x4HuwCLQ=; b=Iu
	t6ZCoQZc6gQPnMULIOBnP5aWTQepYWPwpCp/RwkUyfLDNzCYt1/xdxfh14bQFqqU
	r6kJsWP/8HmwGxSDvEeaSS/xnCJ/vBAP+j8snhIhkktisgYJycRaW8tZ3wC7eEWU
	HX3Ud3LmIJPQSExUOSgqZhrQt3/R8qsxQz7UuQ8H+annIFEITLSqo5VANYHJVGPD
	yqLN/ZlSKAxSbN/zkME/IMZ9bgE0kJ7Bl9Z3BGGAHKpxdaYsXowjACKTx7DajWoE
	/unufIBRGuIwKUO6CWPiMng9RXqaU72c7Nl0rQvPkFR1tPNN1IQjL/ZgkG1tAekd
	29wsOVIkr+NheCc4jjYQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xff64hxb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 15:35:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 598074002D;
	Wed, 17 Apr 2024 15:35:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 95AFC21682E;
	Wed, 17 Apr 2024 15:35:21 +0200 (CEST)
Received: from localhost (10.130.72.242) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 17 Apr
 2024 15:35:21 +0200
From: Sylvain Petinot <sylvain.petinot@foss.st.com>
To: <benjamin.mugnier@foss.st.com>, <sylvain.petinot@foss.st.com>,
        <mchehab@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] media: Add driver for ST VD56G3 camera sensor
Date: Wed, 17 Apr 2024 15:34:51 +0200
Message-ID: <20240417133453.17406-1-sylvain.petinot@foss.st.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_10,2024-04-16_01,2023-05-22_02

Hello,

This serie adds support for STMicroelectronics VD56G3 camera sensor.
This is a 1.5M pixel global shutter camera available in both Mono
(VD56G3) and colour (VD66GY) variants.

The following features are supported:
- Auto exposure with expo bias or
- Manual exposure with analog / digital gain
- H/V flip
- vblank/hblank/link freq
- Test pattern
- Supported resolutions in both raw8/raw10 :
   - 1124x1364
   - 1120x1360
   - 1024x1280
   - 1024x768
   - 768x1024
   - 720x1280
   - 640x480
   - 480x640
   - 320x240


This driver supports coldstart parameters for internal AE feature.
To make it work, the driver save gain/expo values in ctrl's cur.val
during poweroff phase.
This implementation transgress V4L2 rules... Any advice to make it
proper would be greatly appreciated.

Driver tested on RB5 and RPI (with and without libcamera).


Sylvain Petinot (2):
  media: dt-bindings: Add ST VD56G3 camera sensor binding
  media: i2c: Add driver for ST VD56G3 camera sensor

 .../bindings/media/i2c/st,st-vd56g3.yaml      |  143 ++
 MAINTAINERS                                   |    9 +
 drivers/media/i2c/Kconfig                     |   11 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/st-vd56g3.c                 | 1619 +++++++++++++++++
 5 files changed, 1783 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/st,st-vd56g3.yaml
 create mode 100644 drivers/media/i2c/st-vd56g3.c

-- 
2.17.1


