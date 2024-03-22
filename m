Return-Path: <linux-kernel+bounces-110892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF2588654B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75721C22BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADE74A3E;
	Fri, 22 Mar 2024 02:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b="JGsqeYtq"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2223.outbound.protection.outlook.com [52.100.0.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1DC4A07;
	Fri, 22 Mar 2024 02:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.100.0.223
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711076056; cv=fail; b=nLhmZIjMZkuDaZAbzIIBI3vKTwqhMCBnBit0irVNErBG0rrcSHmaDBgrF3d4WiAiuZ18z6JrUx/SGUZ8fotlYbwMZtEjHzfTkP6BaURyQoK5X69B4IZm2du2Q9jXzZ2cgub2drdskBrGsgY6lNRQswDC/q9nJ9OXXInLUvtOPKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711076056; c=relaxed/simple;
	bh=k5M153aEFWH0Axc3muhVwKFUsZO7VNozQttXbkhDv14=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=blrADCYv10TwoBWYaqavHlrc84Pm7ub3/FWC40Q+CWMNCTRJ7rXgnu4B3BNW2jTkgOIYOI6QWeQ2BsA5D/YBS68Fhap0n60icxkemw7JjhGFh2I2yxw+yHHjROZz/JIwdPAZdMRcazfO2ZYetPxqW1UMe855zgLxuCZ9tlNUchE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com; spf=pass smtp.mailfrom=nuvoton.com; dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b=JGsqeYtq; arc=fail smtp.client-ip=52.100.0.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hjwhnc+DEF15gEznZDNs5NgjRQe8BImOmGl4ZyadWu0TX5tHPFxqRec+9vZxQDSJT0FIKk/eOw7UIdYCXNio3gfX5Llh8tF88YZWKCMKOEItfnF2LXZPeomVtwVKyHuO1YizkKtCaE0spNJCFbSeoKhlyG/rauVEfjwnfzPit/1eq+hdTeP8YS7zvNK++LF7MdegLcPyTNMK+HQZ5J6qS99qttCLppEAsqMDxXQbJpxKl9xdiu/gNqsEh+9f19sOhQKeEokEmPgZf+dhzOpIXuQ8L2swIzJ3/U1ITIegLvYIkusHGF8BXIB1pY03FMLlH0xPN+v1Dd6VKbG0NGFvLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoO5NA9tP11vf8VooDR6ZvfUapR5QckrcPqlocqLdFA=;
 b=naZwO5hQ4kG7UpujxWVYfdrA6CCYYEIdLwKrmUIjcqi1B1I6fCNVHaaCbpSQ0E9+7SWcgw1NbP7tNYzcZjX20ausiOrVDDjmqm1OAEJFk2c6cucB1SPiSlBYsfutW5YeZMTmirwJs9M3VcR8J5xWp49cxy5usCq0n7YCh3WI7iXK7jZzFFkQqGVd9G2Adstdi+voLXSQG++N4AcV0Sgmk0tDbJxgKO9y4pEZvUgj3RTc0LKoRK2a/OKTRP7eCccosSy6vQXehAtD/c5AAs07iZz0T4XqKPOX36o+HGapIywTKfHK7i4blm28Ndvm+2HNvbWfGoeh2Dk2ePKD0j3RAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoO5NA9tP11vf8VooDR6ZvfUapR5QckrcPqlocqLdFA=;
 b=JGsqeYtqtCqoDgKZE9doq1xV+nhSIGm11vntH7+9HrKHi378nGqH1kk9h0vZfChLLITjK54Nh8ySOvfS/URTLI5fbcTYxvIPKV363xtIcl0Pus867qssjZHdFLDoIBe0WMBmHKCC5Mk8qWDi4gv6a7Q3zCYQpcfVMG+vGXSbW9g=
Received: from PU1PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::20) by TYSPR03MB8734.apcprd03.prod.outlook.com
 (2603:1096:405:54::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 02:54:10 +0000
Received: from HK3PEPF0000021A.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::ba) by PU1PR01CA0008.outlook.office365.com
 (2603:1096:803:15::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Fri, 22 Mar 2024 02:54:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 HK3PEPF0000021A.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 02:54:09 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 22 Mar
 2024 10:54:08 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 22 Mar
 2024 10:54:08 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 22 Mar 2024 10:54:08 +0800
From: Seven Lee <wtli@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<robh+dt@kernel.org>, <conor+dt@kernel.org>, <YHCHuang@nuvoton.com>,
	<KCHSU0@nuvoton.com>, <CTLIN0@nuvoton.com>, <SJLIN0@nuvoton.com>,
	<wtli@nuvoton.com>, <scott6986@gmail.com>, <supercraig0719@gmail.com>,
	<dardar923@gmail.com>
Subject: [PATCH v4 0/2] ASoC: nau8325: Modify driver code and dtschema.
Date: Fri, 22 Mar 2024 10:54:03 +0800
Message-ID: <20240322025405.3340064-1-wtli@nuvoton.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021A:EE_|TYSPR03MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4591f2-fb24-4b28-d51c-08dc4a1b58c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o6f7cquLpzMimp/ygDJBAAnlCfvR0suLhv/7J/UmAFy0zZ8ZM5DjXPICYM75Zz3S9j2cQlUY0wWrAaRbjElsc6f1GSfOC1iZAOJYVBlhNol1ds/5zwZRfX2ENtQqzEYKGN4RW7k7u2k62suA7qJsEGcq31Dqi/9y4IsJfRxjZKE3VXGS2xFpTDVBPAtuAyGvdC9GzuCb2X51iWGCTly7DhATu6hVZvI+8fFF1t1ubMCQXwBpSoRFfz5FvJFIU27LRdZAylmoo2e43csnJgXs1J5bs+dCanJvpYM2j40GM/AvgVzfajoQL3rxWHOpWjXucLpWRzOj4vH1Uu9gqE2XVSLHreASdumYsGMt0eJ2q/lLxjDm/J6hCjxTtm3EfLTBAqN62VfgCQzShXoJJAwoFGm8JERYHb+L6NUckblKNpu1OeKgeGZ9hUPijHaQTrcnvHmmsi7E7xSW9kkrV2Xdx+lXnpgGjr5xGMIq/XH+bNx8aNwXRv+cwXOiJCneXE5CmJGk3KVCVgbllNQ9nyVTqwverLC5DwKM1J1TjX9n6muOUydDYUXBXwvLFl9fZYoIZAxrk8bjQCt8GMl5ErCtbPS1k4qaEqZFpjxjqjkePGVC7As/95JHcXEyB3hrxWg5jRDt6g1ujs2HVqcLKGkABLtLteRD8f8wEnmZc3Wms4ttSsCtYHa87wtE+QxZRoUefKTkkfsFyyJLI/DwaTy3yrytsHo1cYhc3p26bo8Pul0f0Xhghr7KINjlQWn1Z2C/
X-Forefront-Antispam-Report:
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(34020700007)(82310400014)(36860700004)(376005)(7416005)(1800799015)(12100799054);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 02:54:09.3453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4591f2-fb24-4b28-d51c-08dc4a1b58c6
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8734

Modify properties description and use standard units in dtschema.

Change:
V1 -> V2:
- Revise the driver description part for the C++ comment.
- In the nau8325_clkdet_put function, modify the max variable to hard code.
- Removed "Clock Detection" switch control.
- modify the "ALC Enable" switch name.
- Revise the dtschema for "nuvoton,dac-vref".

V2 -> V3:
- Properties use standard unit suffixes.
- Modify the enum definition.
- Driver code should be used dev_dbg().

V3 -> V4:
- Properties use standard unit suffixes.
- Modify the enum definition.

Seven Lee (2):
  ASoC: dt-bindings: Added schema for "nuvoton,nau8325"
  ASoC: nau8325: new driver

 .../bindings/sound/nuvoton,nau8325.yaml       |  90 ++
 sound/soc/codecs/nau8325.c                    | 856 ++++++++++++++++++
 sound/soc/codecs/nau8325.h                    | 391 ++++++++
 3 files changed, 1337 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
 create mode 100644 sound/soc/codecs/nau8325.c
 create mode 100644 sound/soc/codecs/nau8325.h

-- 
2.25.1


