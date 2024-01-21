Return-Path: <linux-kernel+bounces-32009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA1283553A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940D6282236
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B176336124;
	Sun, 21 Jan 2024 10:35:42 +0000 (UTC)
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBFBD266;
	Sun, 21 Jan 2024 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705833342; cv=none; b=tP0UvJBh7aa6rmRmZx7TCitnYMY9zmv+9bXL8V0l9jINCLKNtqYb4SGYBkMaSzD38aUAwRBf2RMjK9y3igWgI9AhCQY4zPpXDfuRh6NFRvQwt19ITuCo7IXQQOoSTlp/Dzi40DWnuTSdqfhrtLWPIfD+EL/532kq7gLEZPPr6aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705833342; c=relaxed/simple;
	bh=zton66vizI/VAUU/Qb5d7y2J2WtBt701vRPP6Sl6dxU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fmCaxELdjuXcMg4jm7jU/18GE35F7ultCbyve5QO3hbt/DK8BNDUWyiN4ZqL/gxeP90uXo110wuKaOZBn2eiojnGs8k+hCHRqUrcbBzOCfVTOChClNWhtSllcR7wnbAR4NTQfMYs8Jqor53ENzUjXICGjonZCt3nfpRk34uNH3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40L5hi5P022571;
	Sun, 21 Jan 2024 05:35:25 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3vrwch0hb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Jan 2024 05:35:25 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 40LAZNZx007367
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 21 Jan 2024 05:35:23 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 21 Jan 2024 05:35:23 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 21 Jan 2024 05:35:22 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 21 Jan 2024 05:35:22 -0500
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.242.67])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 40LAZAod021011;
	Sun, 21 Jan 2024 05:35:13 -0500
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski
	<brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Kim
 Seer Paller" <kimseer.paller@analog.com>
Subject: [PATCH 0/2] ADG1414 for review
Date: Sun, 21 Jan 2024 18:35:03 +0800
Message-ID: <20240121103505.26475-1-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 5w69qJ9LK5WsPd69LIB3sqI7v8MLtslq
X-Proofpoint-ORIG-GUID: 5w69qJ9LK5WsPd69LIB3sqI7v8MLtslq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-20_06,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=731 spamscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401210081

I'm sending this patch for review, but I'm uncertain about the suitable subsystem
for the driver. Currently, it seems like the GPIO subsystem is the best fit.

If that's the case, it's open for review, and I appreciate any insights and feedback.

Best regards,
Kim Seer Paller

Kim Seer Paller (2):
  dt-bindings: gpio: add adg1414
  gpio: gpio-adg1414: New driver

 .../bindings/gpio/gpio-adg1414.yaml           |  66 ++++++++
 MAINTAINERS                                   |   7 +
 drivers/gpio/Kconfig                          |  10 ++
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-adg1414.c                   | 141 ++++++++++++++++++
 5 files changed, 225 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-adg1414.yaml
 create mode 100644 drivers/gpio/gpio-adg1414.c


base-commit: 7a396820222d6d4c02057f41658b162bdcdadd0e
-- 
2.34.1


