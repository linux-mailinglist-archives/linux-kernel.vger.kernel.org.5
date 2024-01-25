Return-Path: <linux-kernel+bounces-39301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E02283CE6E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758EC1F27768
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81F213A266;
	Thu, 25 Jan 2024 21:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jyj/dk0U"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB7A137C2C;
	Thu, 25 Jan 2024 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217814; cv=none; b=i2BVjhg6fqRhl6QP1MjKLidu1S5t5MjUDM3NzXzTKVPuD+U8Q49fuK+KCOacUl8Zmja2Xp1RNsWyEv7URPh6R9Sb87jSQhJwXreKgciss9/rv2m43WbzEiJDN2dueS/K5k5oySuzmlqZn1BX4cwFF6ndUuWqvv/HWwk7CqBs3To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217814; c=relaxed/simple;
	bh=cyz+PbStDgvOthLZVj1wnafWOrjmgOQLkkyH2Kkk+B0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YAkDtZIUFOtFDiy/40MXZAo7XNgpPr5jilP0Cr2H+9KydyNauIBwvBQChf2ErgZStNE4uFmTdq77aljAtNxouc3X6e3CY/8tOyS+ys8rq05MTfone15vjDBdLPJMIw6qPCVfAVMTjUHYc3aVNabdz4g/wGBrgI9DiOSKRaLGevY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jyj/dk0U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PLGClI023768;
	Thu, 25 Jan 2024 21:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vOKfvVC2hJZUCKOksgWtgYitG0VgMNWVDDXh6x6I4t0=;
 b=Jyj/dk0Uwt0XW/hRtrnRJCiL/dtv0OXLJf3m4cJHwJAkXDFMLzNqeQ0s16ee+0O1UFy7
 V4tIWzkBGbk+ivgAhsz42GQr7Mn2w343BN+8PXl7gRn7qc1reHQKn3U26HyacVkqPsu7
 nZy2WlBjBfkYpjmAHYwp4YcZJExlZZxkbAfZE2cBaVwnRm6QQo6wd9MsXPB7Jdq+wC1A
 LurFJ8wo0P084c7DhL4i+TCGtVq7pcqZnDBVfOA4czub+HaQ5zLPHhQdkZTkep5NUPh4
 pEDIKKhFZa6iR/JVq+1gefjhgkVKmK5mCMUYT6KOxim9oSIcSbJS3wLg3dMyM+I/mnqR Og== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vuu1bxw4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:22:27 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40PLGLwG024263;
	Thu, 25 Jan 2024 21:22:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vuu1bxvvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:22:26 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40PJVWoC022438;
	Thu, 25 Jan 2024 21:22:02 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrt0mek1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:22:02 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40PLM1C430998986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 21:22:01 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07D9258059;
	Thu, 25 Jan 2024 21:22:01 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45B3B5805F;
	Thu, 25 Jan 2024 21:21:59 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jan 2024 21:21:59 +0000 (GMT)
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
        geert+renesas@glider.be, luca.ceresoli@bootlin.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: arm: aspeed: add IBM system1-bmc
Date: Thu, 25 Jan 2024 15:21:53 -0600
Message-Id: <20240125212154.4028640-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125212154.4028640-1-ninad@linux.ibm.com>
References: <20240125212154.4028640-1-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AhwcslmG7af1NosVBxsByb_pf248Dj9b
X-Proofpoint-GUID: vtgA9pSR8KI2188Ropjdtm9JONAnpIbh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250154

Document the new compatibles used on IBM system1-bmc

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 68f717670f78..093b28f4ecba 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -82,6 +82,7 @@ properties:
               - facebook,yosemite4-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
+              - ibm,system1-bmc
               - ibm,tacoma-bmc
               - inventec,starscream-bmc
               - inventec,transformer-bmc
-- 
2.39.2


