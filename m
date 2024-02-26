Return-Path: <linux-kernel+bounces-81149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F404867123
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2511C267F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3C91CD17;
	Mon, 26 Feb 2024 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ShUMdVFr"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C41CABF;
	Mon, 26 Feb 2024 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942611; cv=none; b=CSKRW1sn6o4n/5/MfJhs7/C3uy80WFZJjD8ihO0NfTi9DAJxiCGrrrRGLWsKwOmpK4ndiyGNi2fmZJ711AlBxXiblJ1HBsREoCIgGHoDpoBmR3dsxKKIMWVM0jXyC8pLZQQVO3rYQlsbhziwbW5+j5clPNi/n8Dbptcxfyt2vv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942611; c=relaxed/simple;
	bh=X0g4usZS5mnO5dlqfbYG2kC/be6Su7c6FhyR2wlZvSM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gp8ntz7ovOZ7twWZ669QcpgTle9ogoLpZdWOzkzsFVvn0p55RVscBPHCKgun+caTfMXgoCNc9WIpN8qXqrEjbLV1bdGca3p/spr7bWrg9OaqmzpydBEyNMVPAdhvdZiR4lVpIt05e989GARhgip5YgiZI2IfgXpupB/9JUfhfkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ShUMdVFr; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q734wL012481;
	Mon, 26 Feb 2024 11:16:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=jgDPDFK
	XvFbmudeTey1D/baBegkXRr3OBNhaAR0TYBo=; b=ShUMdVFrFFSAFax/Yk11wVu
	OnGxfuDZBm0CSqma9WBae/qb58XWND0yh2+Y3h67QzJRFtECXxvIIANACF6GDz0k
	TDW4k0vec0gr85ZfQmTgOVTFIr5HcwWj0Xdvs+GPWGggKorUX3rQSayrtb/a7oni
	RqEcWbP06KWRov3vhfiwbeyA5ht5G2831w06a0IZwlD1d1tASxT0RLmE7iZKVHlh
	/13HM6F0KhbIiC8jEmKai0keCTT2cubFtc2r/X22WZ3lSRiXk2DPkX9Xp02huVMx
	rtKxhzg2SRHLJhJKRKRdKNYKpcKdBrC7MLFpP+C1LF9p468ItZXYNvyqyNTy6cg=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wf8p26eqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 11:16:43 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 08F9440044;
	Mon, 26 Feb 2024 11:15:21 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0819925ED80;
	Mon, 26 Feb 2024 11:14:52 +0100 (CET)
Received: from localhost (10.201.21.177) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 26 Feb
 2024 11:14:51 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH v3 0/5] memory: stm32-fmc2-ebi: Add MP25 FMC2 support
Date: Mon, 26 Feb 2024 11:14:23 +0100
Message-ID: <20240226101428.37791-1-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-23_01,2023-05-22_02

On MP1 SoC, RNB signal (NAND controller signal) and NWAIT signal (PSRAM
controller signal) have been integrated together in the SoC. That means
that the NAND controller and the PSRAM controller (if the signal is
used) can not be used at the same time. On MP25 SoC, the 2 signals can
be used outside the SoC, so there is no more restrictions.
    
MP1 SoC also embeds revision 1.1 of the FMC2 IP when MP25 SoC embeds
revision 2.0 of the FMC2 IP.

Changes in v3:
 - Simplify stm32_fmc2_ebi_save_setup function in patch 2.
 - Do not check non null ops in patch 3.

Changes in v2:
 - V1 patch 1 and 2 have been squashed and commit message has been updated.
 - V1 patch 3, 4 and 5 have been squashed and reworked.
 - V1 patch 7 has been renamed and associated commit message has been updated.
 - V1 patchset is split, one for memory, and another one for NAND. 
 - Regmap_read API return value is checked everywhere it is called.
 - A platform data structure is handling the difference between MP1 and MP25.

Christophe Kerello (5):
  dt-bindings: memory-controller: st,stm32: add MP25 support
  memory: stm32-fmc2-ebi: check regmap_read return value
  memory: stm32-fmc2-ebi: add MP25 support
  memory: stm32-fmc2-ebi: add MP25 RIF support
  memory: stm32-fmc2-ebi: keep power domain on

 .../memory-controllers/st,stm32-fmc2-ebi.yaml |   7 +-
 drivers/memory/stm32-fmc2-ebi.c               | 729 ++++++++++++++++--
 2 files changed, 686 insertions(+), 50 deletions(-)

-- 
2.25.1


