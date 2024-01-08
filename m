Return-Path: <linux-kernel+bounces-20100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999CF827949
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D371F23EC9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4975E56451;
	Mon,  8 Jan 2024 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BXwXiL1B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9B555792;
	Mon,  8 Jan 2024 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 408KcPNZ030100;
	Mon, 8 Jan 2024 20:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=9q7+tEry8R9Kh5w+IVwYzZtxPjhplrHIhVcuJenXIJ0=;
 b=BXwXiL1BpsEOeyvUMpc0T6dgIQgaq7GcabdtrEWZ/q18omPgX5Wxbd908hrjwRLGXmK6
 0pBLSZN2pjG24bRqJgl92a05J/hgbnG1CB2uXQ7G/bE6+M48iOXsyqbdXQ1/TQ7cMBR2
 eOrJPr1DxrG6qJR3VXF40MbKA6jfRXTmpNfqwaQj5K9QxVwFIKNLqZ51IsoXrHO9IEr7
 8OAHDG4VRRxdRDiz9coqYfKGGVrJ/gHJmKa15Lf54BC0+lqt0ilZ03nHMIwyI0J48+kS
 fjEFOiOkhWdihA46hmtROrtKhMxbuPIh4bCw3di5GlkBtiajBkuRdY+gGyz7lt+0Jnwo hw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vgkjm83t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 20:41:48 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 408KK7MM027395;
	Mon, 8 Jan 2024 20:41:47 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vgkjm83km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 20:41:47 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 408I6FtV004407;
	Mon, 8 Jan 2024 20:41:19 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfjpkjdag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 20:41:19 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 408KfIHZ30474918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 20:41:18 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2FD058059;
	Mon,  8 Jan 2024 20:41:18 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFF0B58043;
	Mon,  8 Jan 2024 20:41:16 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jan 2024 20:41:16 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com, ninad@linux.ibm.com,
        johannes.holland@infineon.com, linux@roeck-us.net, broonie@kernel.org,
        andre.werner@systec-electronic.com
Cc: patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com, bhelgaas@google.com,
        naresh.solanki@9elements.com, alexander.stein@ew.tq-group.com,
        festevam@denx.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-hardening@vger.kernel.org, geissonator@yahoo.com,
        geert+renesas@glider.be, luca.ceresoli@bootlin.com
Subject: [PATCH v2 0/3] Add device tree for IBM system1 BMC
Date: Mon,  8 Jan 2024 14:41:11 -0600
Message-Id: <20240108204114.1041390-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F3ozJSSUjsPBmRPic02j93zmWMaaJZKG
X-Proofpoint-GUID: gNjXQfcHif7mEFfzs8r41hDA86qeVb4W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_10,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=985 lowpriorityscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401080171

This patchset adds device tree for IBM system1 bmc board.

Change log:
v1:
 - Added device binding for IBM system1-bmc
 - Added device binding for TIS I2C devices
 - Added device tree for IBM system1 BMC board
 - Added i2c and muxes
 - Added voltage regulators
 - Added GPIO, Fan ctrl, Led
 - Added more compatible strings for tpm_tis_i2c
 - Added power supplies, sensors, EEPROMS, TPM and more

v2:
 - Incorporated review comments from Conor Dooley, Jarkko Sakkinen,
   Guenter Roeck, Rob Herring, Krzysztof Kozlowski
 - Merge all patches into single patch.
 - Split the trivial device patch.
 - Cleanup commit messages.
 - Fixed bootargs string.
 - Fixed node names.
 - Dropped tpm schema patch as it is covered by Lukas's patch.
 - Dropped "tpm: tis-i2c: Add more compatible strings" patch and
   send it as a separate patch.

Andrew Geissler (1):
  ARM: dts: aspeed: System1: IBM system1 BMC board

Ninad Palsule (2):
  dt-bindings: arm: aspeed: add IBM system1-bmc
  dt-bindings: Add DPS310 as trivial device

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 .../devicetree/bindings/trivial-devices.yaml  |    2 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 1623 +++++++++++++++++
 4 files changed, 1627 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts

-- 
2.39.2


