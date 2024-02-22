Return-Path: <linux-kernel+bounces-76116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C41485F31F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66011F21534
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE3524A0D;
	Thu, 22 Feb 2024 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b="N+njsBqB"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2050.outbound.protection.outlook.com [40.107.215.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DED2261F;
	Thu, 22 Feb 2024 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591127; cv=fail; b=OiJiN0Fh9aiR3F2ruLFyNBNd9FKYW687+VUc+L6SKsaezNSNexg+ElGDBOJLKCFxw3Ow63sh2s2Cy0PRgUhEwVOdvna7If19emt4UXqLyCFE/os0p1JahN0BEFVT0FOQvQd/tkCC+kuG3j7/WhvFN5Ge41xZ218d4BR+R2IhV3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591127; c=relaxed/simple;
	bh=urpBMRg4QJ/+erpVhxrs3D7M9jaAucnv/nvlYHl9zUY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ogvnt3Qk/sfCrRdWK1qTCJTKTSCViHqbXYdrdYV5ClT6Lb+WdRlgWAPX5XrUrq3hocL3uEOqKPCKoi0rtjqZ41DnfB8UmMrtf+XCXf2743GFxbxFjK/P/9qaVL32GC4GRAXf+ILp8tGqdZA9ZStDyArcWQaVRDigZ1f1DzMMNVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com; spf=pass smtp.mailfrom=nuvoton.com; dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b=N+njsBqB; arc=fail smtp.client-ip=40.107.215.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFDhbap8blGlutriPlDzr3sDs4fAS+YzrJkD+cPO9DZM/4ttA44k5dCFJAVuWagQTQ5Cyx/nOZYBhsGoYEoej04+9BTtIMpMqxPdKwQSQhsakdvIUG31U/MPHU8kngbAiDXMpXnCeizxuKIa7ZxqI9QWK3y7YzTSuHsLQ4Z/K+ZRZMJ0Io0IdABMB0vieHrXFEfaeT5HIAwb+LK9lbizQMb2fpv4y64qiKdiAFuz1nwDQET71sCvfrJqdNHNjan5ZrgWqRkUXfgEopLTCjjaX383B1rg4sRzCfTymamABVRqMREnzzYDlMrK3RFjEQrx4KhwuLvgkOt7cq9jYBivPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuuSublDF3WqGdilez+Yu8tqbNiAXUNSAgn4+jcjmtU=;
 b=PCtTqeSzwK2us7xciTT9n6ANlwRUmPpZqSz35/j4s2BTKQaJN7qdJBN0H0vHhwkLYdMGT7gXNo0TdjMN4kQ1KIc1a/W3i7KNZdmSbRK9RMd6Z3hmXA1ukUi/vToTwUfTSZ5DPRw7hKr3AHA603dhurw11buj7Hm6O1jJ1OI3oAL/X1um0TnlG7Lwo3cqt8QiuBJFOJck4BbMZToZhGOv/9xSHboXXxz3NKdrrnl8YPSCIKhbPY9a6uVjwVIF5BmUkFdbnSKFlp1L1BjXQiHVqCxfzlKaPcfjerY/35KXDF4UpwUDAf1+FH9vupd0mZ5PSdAun0k/DL5JlA+78pvPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuuSublDF3WqGdilez+Yu8tqbNiAXUNSAgn4+jcjmtU=;
 b=N+njsBqBZvHj75nskfXED2d9viRKC8zaYELC9y4BP6VEoL0H/QNpJjd+ualp0Keqy3Tsc9MIsbuZPjafd4FiVnA1hRnomb43++K17dtAzX/htowH1N1iD/b8i/A9nq0nON++jYPO8mQ7Ds1rV/A0u9VGZGh4QJOzzIeEq6z3bLc=
Received: from SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18) by
 SEYPR03MB8391.apcprd03.prod.outlook.com (2603:1096:101:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 08:38:38 +0000
Received: from SG1PEPF000082E8.apcprd02.prod.outlook.com
 (2603:1096:4:0:cafe::fd) by SG2PR04CA0156.outlook.office365.com
 (2603:1096:4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 08:38:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG1PEPF000082E8.mail.protection.outlook.com (10.167.240.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 08:38:38 +0000
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Thu, 22
 Feb 2024 16:38:36 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 22 Feb 2024 16:38:36 +0800
From: Seven Lee <wtli@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<robh+dt@kernel.org>, <conor+dt@kernel.org>, <YHCHuang@nuvoton.com>,
	<KCHSU0@nuvoton.com>, <CTLIN0@nuvoton.com>, <SJLIN0@nuvoton.com>,
	<wtli@nuvoton.com>, <scott6986@gmail.com>, <supercraig0719@gmail.com>,
	<dardar923@gmail.com>
Subject: [PATCH v2 0/2] ASoC: nau8325: Modify driver code and dtschema.
Date: Thu, 22 Feb 2024 16:38:23 +0800
Message-ID: <20240222083825.190854-1-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E8:EE_|SEYPR03MB8391:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8309d1-b293-4163-5eb7-08dc3381aa65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HB6kpCcQlX1LYxCYiSwhUFYDl0YiH6s3oIglvaA6KIvgmEA0UJknhMvnywihfysQO8gdMudq8WOqQj4ykwykcwokU+ErkuAthVxPXb/TTOOzkL3/uOL0I2x1qEFVxH3G8r2Ri8xdPPzOA3EAdfwQTxkEZv3FNhjVRKiY5B4KwO7Wqcgw/iiyGNXORzUMtie4Fw2kmdaJuQCIkixCXjt+oUtBfzCG701K04XZFo/mak1Rta8lw33DYS8uyKK8XU6N+m3vdUSSdpp4q4Ndw77yahF9dCczp3JjGzUzuiICXkcN8bOniwXCFwPhvRs0fVpveCB8NgYJwfgjelSF4l7OLhWaHYE9+Hi9TQTHSFr6P/p1vphce6Q3rcnWms+MsYZ+fv8w3tWax0316s6NES1ZorXDbUAek7SyolobShEYJyWCzhZW3T/eZO2eE2uqE5/S7R1haLE+Wqm84abHP9YV0Vel2swfeDIF61weFrohO3IA8hhe3kGHWS4r3RiLZzm2gROdUbQMbH28CxFuoMqilOn3xts2NT99kRcgR/g2dNTHSLOv/7I8tdW/o6omprC6U5jiYclVlOx9IoD+jVDO7JJmfETuZP3SRMBoEWYSBbsu4IFn6K/dCp36VoU4Qn/FL4l2HX2E8/rrxX4bUEfcWA==
X-Forefront-Antispam-Report:
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 08:38:38.1241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8309d1-b293-4163-5eb7-08dc3381aa65
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8391

Remove the "Clock detection" switch control, and modify dtschema
for the explanation of "nuvoton,dac-vref".

Change:
V1 -> V2
 - Revise the driver description part for the C++ comment.
 - In the nau8325_clkdet_put function, modify the max variable to hard code.
 - Removed "Clock Detection" switch control.
 - modify the "ALC Enable" switch name.
 - Revise the dtschema for "nuvoton,dac-vref".

Seven Lee (2):
  ASoC: dt-bindings: Added schema for "nuvoton,nau8325"
  ASoC: nau8325: new driver

 .../bindings/sound/nuvoton,nau8325.yaml       |  82 ++
 sound/soc/codecs/nau8325.c                    | 856 ++++++++++++++++++
 sound/soc/codecs/nau8325.h                    | 391 ++++++++
 3 files changed, 1329 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
 create mode 100755 sound/soc/codecs/nau8325.c
 create mode 100644 sound/soc/codecs/nau8325.h

-- 
2.25.1


