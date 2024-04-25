Return-Path: <linux-kernel+bounces-158382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BFB8B1F09
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350911F242AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1278663E;
	Thu, 25 Apr 2024 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pQrMK/mE"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ECD84E19;
	Thu, 25 Apr 2024 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040448; cv=none; b=gZKQcZfFm0MaZY56W0LfPciBc7W99cG3se6m1rFSenuzovjXn0cD7Tziqa82Eq5qjcQqerUnaGudSU4QnFZ8F9X158qmyDZSC5m2OtQnDz1KJxtZsrLo9/NTemFlkywoZI3nu1ODf02sgIqKnBEZhq0C/ruZxkAVcKtQtq23XUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040448; c=relaxed/simple;
	bh=hh3Kw6YahM6tTCYxpSRjyLVkH6XMqAqyxT4fZak8Pc4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jrH34eDJ1EnpVyYqMyAJdDTyROkZqZpsDobMf43plBNs/1+BMy4S0ACFRss+Ris4XGKD91troIwDZJ8K42WiHUt7L+GCPuW4Yv7x2ctn9xAPWvD6tAen40m3gxdanfhGuT+QfoBkQxqkN3sAFJUuHGATwlRLjVqG9fcx/nNI3I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pQrMK/mE; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PAKfqL122853;
	Thu, 25 Apr 2024 05:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714040441;
	bh=jx0wZ+Xj9hfZLPL5M0DAVCFD8HH/8ENzF9Ty3x44gcs=;
	h=From:To:CC:Subject:Date;
	b=pQrMK/mEB2Yf2073TCol9SbE/uBrkElKHiIOJpLr68UBdDzBLQWabdXgkqnzGHBpg
	 8vKr1wy7jxodX26dBTzEE+VwdFd/uciXgzp+KDWBJXyImyuN6pKVlQZG/oAvHkef4L
	 X0jm6x1XjrAW0ID0mmldPsYZFpp80w7CowSgA/34=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PAKf1q021883
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 05:20:41 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 05:20:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 05:20:40 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PAKeax002339;
	Thu, 25 Apr 2024 05:20:40 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <s-vadapalli@ti.com>, <srk@ti.com>, <danishanwar@ti.com>,
        <r-gunasekaran@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH v2 0/2] Add support for CPSW3G port 2 on AM62A7-SK
Date: Thu, 25 Apr 2024 15:50:36 +0530
Message-ID: <20240425102038.1995252-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello,

This series adds support for CPSW3G MAC port 2 with the SK-Ethernet-DC01
Add-On daughtercard. Also, the missing alias for CPSW3G MAC Port 1 is
added to the am62a7-sk board file in order to allow kernel to fetch MAC
address populated by U-Boot for CPSW3G MAC Port 1.

This series is based on linux-next tagged next-20240424.

Link to v1:
https://lore.kernel.org/r/20230424111945.3865240-1-s-vadapalli@ti.com/

Changes from v1 to v2:
- Since support for device tree overlays for am62a7-sk is already enabled
  by commit "635ed9715194", it is removed from this series.

Siddharth Vadapalli (2):
  arm64: dts: ti: k3-am62a7-sk: Add alias for CPSW3G MAC port 1
  arm64: dts: ti: k3-am62a7: Add overlay for second CPSW3G Port

 arch/arm64/boot/dts/ti/Makefile               |  3 +
 .../dts/ti/k3-am62a7-sk-ethernet-dc01.dtso    | 61 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       |  1 +
 3 files changed, 65 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a7-sk-ethernet-dc01.dtso

-- 
2.34.1


