Return-Path: <linux-kernel+bounces-39305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035C083CE81
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EAE0B25684
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C6913A271;
	Thu, 25 Jan 2024 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZDEztOj4"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2322B45951;
	Thu, 25 Jan 2024 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217933; cv=none; b=uW03jmhwM6p/3UUTTfYjxJtqgolnMj9QTzbSYqNpyYQFeovvBc4uqyIFVsr14xEMmnaSHYRJzslsDDo5pyR434WDqKF5r2ffCBNviR7v0baU+Np1dlXgVoeifAl4539eV0XjdkMGjHgNVpVnekrvMEDcptXtpeDkcMx07rL+RGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217933; c=relaxed/simple;
	bh=+1rzo44MVhdG1twaPoxAFs/i5CPmmmD3ebkTckAOXgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FrFqjRPxvrCbLcwrEDtt8JGT9ktSaTQqCvX2Fp3dqa+Pk3Wjb/2VkjDeQ6eNNOYtBcd9Rx1Gnvfh2b33fjbdU2+RglTUG2uzR9+xdOxDO2NIlARga9mB96HQw2TipJBs8R7wznql4QxxayRNRgAL6xofqOl1ScqcxQNupg4bB/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZDEztOj4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PKrCkj028747;
	Thu, 25 Jan 2024 21:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=TFZLj+iicDe+vF0MlXRj2JagqhpN0qB/SfThMG1aMUg=;
 b=ZDEztOj4agiJQ17j2f9Af8WlWqTH6pFrMi/3nBfhC8ZQmmaOX/HuNs6zoWkUXbH2vjUX
 pqAwyyczjCG6x86Hgz1b5A4ckJngo33vQOLdS6hY6uIlfZmsw6gNhNR7a6CB/vRflhij
 ItvVduz80fiXIB2NS2TmUkTi0xKOBY9ptBTi2EbfSJvmyijnVGkXcTH7l5b5EiXw6nrj
 fne0PhIN56q9axeA853ev+7UPyxAJ6jPJUidNvhtybefk+1xB8RA7W2wGYTGvzA0vZNq
 syaTIXw0XR4D+BRKnEH+1Am1wDPtsREvCiyITKsg0ehI+XKxN8Vo3C+Nt0QZj/N1E9/O Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vuy2srs0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:24:40 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40PLLcEj028686;
	Thu, 25 Jan 2024 21:24:38 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vuy2srraf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:24:38 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40PKe4u3026485;
	Thu, 25 Jan 2024 21:22:00 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrrgtq1md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:22:00 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40PLLxq427918698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 21:21:59 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28EFA5805C;
	Thu, 25 Jan 2024 21:21:59 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5370658058;
	Thu, 25 Jan 2024 21:21:57 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jan 2024 21:21:57 +0000 (GMT)
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
Subject: [PATCH v5 0/2] Add device tree for IBM system1 BMC
Date: Thu, 25 Jan 2024 15:21:52 -0600
Message-Id: <20240125212154.4028640-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GysTMrm6-mcL-m8x12davFsbB12pYHLf
X-Proofpoint-ORIG-GUID: _vbxIRZNqiN081HErlJ-GrANPNmq_t_E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250154

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

v3:
 - Fixed voltage-regulators names.
 - Updated commit message about TPM compatibility string.

v4:
 - Removed compatibility string "nuvoton,npct75x" from TPM

v5:
  - Fixed commit message as per reeview comment by Bjorn
  - Dropped following commit from patchset as it is already merged.
    -> dt-bindings-Add-DPS310-as-trivial-device.patch

Andrew Geissler (1):
  ARM: dts: aspeed: System1: IBM system1 BMC board

Ninad Palsule (1):
  dt-bindings: arm: aspeed: add IBM system1-bmc

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 1623 +++++++++++++++++
 3 files changed, 1625 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts

-- 
2.39.2


