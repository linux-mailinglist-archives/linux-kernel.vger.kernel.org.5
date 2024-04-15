Return-Path: <linux-kernel+bounces-144636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D85F8A48AB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54799283DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBE6208C3;
	Mon, 15 Apr 2024 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b="AeTpPv0Q"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2064.outbound.protection.outlook.com [40.107.117.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20A225DA;
	Mon, 15 Apr 2024 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164820; cv=fail; b=BuSdkyiyS9vJ1zaYkUrqbce1vDoUamknJlBeWLw3GT/niQ7A6GzgGT/YrbWKhWUxqlq7srBnskR7IqbecO9JljB+2xsnSWgHIdlq/YoM3VEp5eTNORjDc0KDbb7Fgj6jnxbP834bA5AbSZDmovwC7SlQb+gioic5Bg16gayUChM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164820; c=relaxed/simple;
	bh=asjB5ymnNwfKC7/+jHCn004zMn5Zj63RB4zXXBGLvWo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qFZe0k0HbdyftWGH7jfPLVY/yMP/WrR+jhuPnZ6k5AyWBT4lNsQMzDJsiw9Hn+nrBHIYUtE0/WiPyF0MbruxxBrQZKpodI0S5aLdds2B5rvEM6JT6v6+Z1dfPEMSdsE1Yk4pei7FYsEYcBGQHDaQIWqjbBKbPnTvaB3Dr1e4+IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com; spf=pass smtp.mailfrom=nuvoton.com; dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b=AeTpPv0Q; arc=fail smtp.client-ip=40.107.117.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQ4dx/zJeKqSYcPY7DZYnK/uspZPNxTCggRcWiGU2syOObMYThjPY+yYQ5p/46w4H3qvTWtB/4WZZkgghp3fYIiBTPvQKoBSRmV8ZnJJstJVpJ2as4KArJ4f0dfoLUaUUHRDRjcXt1fRmMK94TxLN9a+6C+1vhgu1FzG2FnTOfbasHVHlCVbsyZoF/PDixrTV14e7ez+9qeAiY7uPbxPb+ozibfF3NjF0WtX2DijJGiTmF2+k/RfdQ+2I3VPkos8Bk6RLhRPar5WF/nqOGsZtwfdKVLnCaUyjDeMJiOKgwhfY1gX+VHpOTGnDM8yQLt1Ma29l6hRqc1uSSJwWwBrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i62pncbv3VWogTcToUsG2UHsS7zKeidCm7kf2HGSJj4=;
 b=mN8JyLWg7AG/iaoMbGbI0wqrqKZCN1xhUaFyTlIMsxWJPSsK7altOVQ2Mp1syLqwxh8PqBvfIS9vs9OppuFEaIwDGiZAQDIYPLJOr793s1EoAAXdtWjRO2mutLwhRNRwRuyIwUoHaqU7s6x8Op2/hKab7BGWfjHC1RgnwcP4+YQLn4Kpeug05XvXy5CxzfIISxE3Rot9ZdE/cXM6FEiq6TAXk0k4Y2ni8NXFHIpXTBQorlb/vhkit/+yFTYeitbc7Ymlvq8LRQUBUR5pF9WVTMHBjoQIiFOYNSSuPB3syPWnVXg2TNNofXPmTlOWvOB6lH10anx1+Rq1VCGVIartiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i62pncbv3VWogTcToUsG2UHsS7zKeidCm7kf2HGSJj4=;
 b=AeTpPv0QgfFnunPEnvsQFD8a9TMPqv53ZMVOtysd2O+dIl4z0hpwU1eCmAB5SUvbuDeg+jxW0ngACEGHipm6Lc0mqo5OKGvkbOZWUJ/KISvtoRg0GZupBZrR9LMYG0atxJv2qJDayv+0fNCgeNsfJpLQpoU7Z3sRH3JEUZM2HjY=
Received: from SI2PR06CA0011.apcprd06.prod.outlook.com (2603:1096:4:186::16)
 by SEYPR03MB7816.apcprd03.prod.outlook.com (2603:1096:101:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 07:06:54 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:4:186:cafe::38) by SI2PR06CA0011.outlook.office365.com
 (2603:1096:4:186::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 07:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 07:06:53 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 15 Apr
 2024 15:06:51 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 15 Apr 2024 15:06:51 +0800
From: Seven Lee <wtli@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
	<devicetree@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <linux-kernel@vger.kernel.org>,
	<robh+dt@kernel.org>, <conor+dt@kernel.org>, <perex@perex.cz>,
	<tiwai@suse.com>, <edson.drosdeck@gmail.com>,
	<u.kleine-koenig@pengutronix.de>, <YHCHuang@nuvoton.com>,
	<KCHSU0@nuvoton.com>, <CTLIN0@nuvoton.com>, <SJLIN0@nuvoton.com>,
	<wtli@nuvoton.com>, <scott6986@gmail.com>, <supercraig0719@gmail.com>,
	<dardar923@gmail.com>
Subject: [PATCH v2 0/3] ASoC: nau8821: Add delay control for ADC
Date: Mon, 15 Apr 2024 15:06:46 +0800
Message-ID: <20240415070649.3496487-1-wtli@nuvoton.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|SEYPR03MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: a19073d1-bcfb-454d-2197-08dc5d1aa13d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cRJ4lKGr8NbpRH96/0K1tl1fLZTOtAT0L7+DwZOIkkZpMT89GtvBvcj+2TsR?=
 =?us-ascii?Q?XC5XdmLadiY3gqOAkDCEEloF7JM/uIDm8Ba6mrzPNKSOrUE/ksKFtFHm1ojj?=
 =?us-ascii?Q?AN/zoQhvEUfo0WMsf7JpdnP8VfGHd1re3pa4i4L9vdZRXyDcX5rhdB7ZKUh/?=
 =?us-ascii?Q?dqgGMD3hHroDzJsp7IJKENUZD9sf1aoR4oilYxGR8ArjjDa4uJIgcA/YQ5K0?=
 =?us-ascii?Q?suzVCPYOshU/8408NJSYX7bSbmLfxTd+C82JwTz9QoEKV3aCi0CK/pRUgCZI?=
 =?us-ascii?Q?86pAY8GU8ieVd+bqj2qGoc9TJACnRmN7CZulqz6lDkua0mms5gdCxrzNd5p/?=
 =?us-ascii?Q?pxW4UYB0Ytc084Fwfdv/VJz6C+NviTZgUFyaOcuD6+Dcf/Bot3EonwTRVmfN?=
 =?us-ascii?Q?KYOniFPkFzoXYjHm8jMCzjrYQT87TBx0N/BO1Ee0uJBzPwCR5adeB4+u5evY?=
 =?us-ascii?Q?ST4csEXY8mN623kqUlcpZHKMponvisbmQLhm+soB3CDN3ODPKSKgOTcRz8M0?=
 =?us-ascii?Q?aohHvAgcgrntYJZo4PKizSqS+m6HZb8dxZVq3t/GQEbmaBIUcVdeCCF1UIu5?=
 =?us-ascii?Q?Pbzew6uL8ts4tDN7nv5xRB3mJHcBX9Aq5qtDzAgc7jGxj7LTG43NceGuWvo/?=
 =?us-ascii?Q?dqmOUoDKUlLj/PqaZCo6c1EtycFOF3EzsJy3ZaUi2bf6oSRUW/Biqkj03qO/?=
 =?us-ascii?Q?Vx+TgKu7hxuhFfhBtd0XvDUtObBqBGMK4Tj0IFZnkToy3brorsg9JzUeJWCh?=
 =?us-ascii?Q?31klS8tJt94TfyG1DEWEDkx4ehqh0u2HKtbAwG4yyXoqP3RtH8r2MUuQUi/t?=
 =?us-ascii?Q?d4M0S8Uw9gQwcT86VgQ1EFVFfbt56u16yUv/NrBTGzUxN1LA4+l4BJlarHPm?=
 =?us-ascii?Q?z31F0QsJ8N6O5ydOVNA//IUDhFC/j0t5Fk6ybrLWQCUp1CZAcLky5xLk+Wyi?=
 =?us-ascii?Q?q8mioUh+VHIoawlVYHthZqtt2ET3hiSlQpqPdGGif1X3PN7NkP+pdfb9GXwi?=
 =?us-ascii?Q?jGQV9MDFSNkyZd0stW/v5aENpdYZvAADNsWy7aJtv94EegHo41gmLXgm7u4G?=
 =?us-ascii?Q?rWjVnEwf+crPhGdkS7S/dn6WFGFc+if7i3ngG/BD1UJ+25TmU2+m/911FpUb?=
 =?us-ascii?Q?eC1MWTOJIYZ00g5age7INKnf7XsIPv2V7KRHQA5etwU9diFiAOS1bM8zW6z+?=
 =?us-ascii?Q?TntQ3QbHCJzY7XH+oOe5ugV9RgKGkZta26rHKVHDpPjCVt7vAd7ssW0XsBXW?=
 =?us-ascii?Q?oMJIlnbWk1DW/djEZSRS9wmBW5s2fEDN9Nt6Z6KiXeHQmFjcedhGIIr685Ja?=
 =?us-ascii?Q?0xFJ48nt+BGQnJ2tGV+/WdoON74vA1LVKewPe6GoNMzIC0hn4V45VnsIaFVa?=
 =?us-ascii?Q?OiKt3GE=3D?=
X-Forefront-Antispam-Report:
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 07:06:53.5126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a19073d1-bcfb-454d-2197-08dc5d1aa13d
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7816

Change the original fixed delay to the assignment from the property. It
will make it more flexible to different platforms to avoid pop noise at
the beginning of recording.

Change:
V1 -> V2:
- Revise adc-delay-ms properties description.
- Fix examples of bugs found by bots.

Seven Lee (3):
  ASoC: dt-bindings: nau8821: Add delay control for ADC
  ASoC: nau8821: Add delay control for ADC
  ASoC: nau8821: Remove redundant ADC controls

 .../bindings/sound/nuvoton,nau8821.yaml       |  7 +++++++
 sound/soc/codecs/nau8821.c                    | 19 +++++++++----------
 sound/soc/codecs/nau8821.h                    |  1 +
 3 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.25.1


