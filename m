Return-Path: <linux-kernel+bounces-158063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A892A8B1AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8E91C211BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5E641ABE;
	Thu, 25 Apr 2024 06:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hIDayZ4U"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CE93EA86;
	Thu, 25 Apr 2024 06:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026255; cv=fail; b=Q5QbzZxabIxgE8eX42tAetZ5J1Bq6WLrAZgZ32HzRDEk0IRrofkBNKsUS6o5hq6pLWqFGrirgIikPfwVyLL9yeV8HZEkyRrD+JeevwC3aaPqfHeSF2ZK0DaMV1Y7zHJazv1oZrsdiwfk5umkBrKxqsitSAzAt2Lkg4zUkAPbJv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026255; c=relaxed/simple;
	bh=Tp6XguxhKaj42RT9RnmzL1MQNLuE1wtbx1gBpcXC0m0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uINJ4tgv/6ID96rlgUh19iJriqKFYypimJbEdG03EOI/cAm+T87N5NHieWOZz3GiUmAEwxYLR3ALxTN3rSs9A2KMikiAIN0zxhbUbJU/vPoLxCZB33vdzfs9ilu9FH56zzrnsE5XLNTjMXxMNa7gmyYjDvHS7EZwCuditwwwL+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hIDayZ4U; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD4J2KIKclonDiQPpQ98CLWla8Pv1RX1zdTn7V3AJliDccRsg8VqhGI4jV67eWKFCtrCpgunutr4zvK0OUROqoNFYQIphYkNdA1w5QBt/IbbBqtPF+re7xuakLBWMBOefgX6jPnn47QvWmcu9q8njnA/c/KxDkfvcBy67otn8tuqN1a08X13AuNQIRsbv5Vao6qNkxA2SdPt6wmTW8OFcF+LUPsaN+QgLHRDTv1bWlo/pCIFscknLDCQQKYYQtYP8excQJRHis68zuFn2j9NsvYxp7VHD+TFjwLY94w+yC/ReuP+r8hhpbZdn/SPrFgzXGfs8qX50ld7f35/1oQKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MXYMXALXCRlDvlVA0r1J9RnGVeFpBttlnPZnxmBSYY=;
 b=MI7cQuXag0TOv8cj4wPe8jyMyhX3uzgJj39fnqdXaw1yHA0PGFJkCeZvsPouc33mYKuhH4exrNhH1HX2mo00S2Tj4QvhY7k10A+GYL/HMHNJ+EFuJG6haz7VsqyECFPPr4KBZKjj8xFDBuHNouE0lFlA2dJjNh0hiHU9F0GkYtj7Jmi5zQpdm9XaUgrTStEps+gSfA143bjFa263HhilvlC39fxkpEwyNeRYl2VdLjUtLqvC44DCYXw2aw+AoNYSpcwEg6t/tgK/EDwCF3WMuMXCbTweGkLVbOYn4RFmuHrX881IBWU4HXfZaVLj2vjMhPF9utSERQGXTIKp5W31aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MXYMXALXCRlDvlVA0r1J9RnGVeFpBttlnPZnxmBSYY=;
 b=hIDayZ4U8mU7fcQowviWuQ1kHI5iH47j2Xrd1BXuRLfUfnEJTsaYa6SRZSeAmqgkAXowlgcxO5q6wF6byJ7cyhSyx53c52ePM+ibHIWVySbh3jWbLootybAq74PKx0pYN4Se3yWGJbvHTnc+UgFPsDC9cJPeVy87QG8YqpKOvLk=
Received: from DM6PR06CA0015.namprd06.prod.outlook.com (2603:10b6:5:120::28)
 by SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 06:24:07 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:120:cafe::5c) by DM6PR06CA0015.outlook.office365.com
 (2603:10b6:5:120::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Thu, 25 Apr 2024 06:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 06:24:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 01:24:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 01:24:06 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Apr 2024 01:24:01 -0500
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <p.zabel@pengutronix.de>,
	<laurent.pinchart@ideasonboard.com>, <radhey.shyam.pandey@amd.com>,
	<parth.gajjar@amd.com>, <u.kleine-koenig@pengutronix.de>,
	<tglx@linutronix.de>, <julien.malik@unseenlabs.fr>, <ruanjinjie@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <srinivas.goud@amd.com>, <shubhrajyoti.datta@amd.com>,
	<manion05gk@gmail.com>, Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH V3 0/3] Add support for uartps controller reset
Date: Thu, 25 Apr 2024 11:53:55 +0530
Message-ID: <20240425062358.1347684-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 943acd8a-0a49-4c75-7ef9-08dc64f05016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9emTQqJBFFHobgEOYDnwLsc+XfZTgdia8/GXMKGTQ7IXlgvqJVrv/kzF40Xj?=
 =?us-ascii?Q?Ws+KZygbqqIo03aLqhbGoCiIQVddF+A4D1a7Y3oRuT9z+fX66BtBIFfNcpd8?=
 =?us-ascii?Q?Q7REEWU2HpK+oN4+2x4aEnBmZMzusOlYiPXYhesY8ZoF72WQF0nbiYStGDfX?=
 =?us-ascii?Q?qBG2b2ZrLSQXncaY3Cy+twYNRB57tzUu94NBVjugXfoNS4lp3cV+oQopPElF?=
 =?us-ascii?Q?NR/7eqFA9h+QpLGP3ElpoZiFuAHMiq6N3Phgs2roIacIdAxqMdORT7k7HPE0?=
 =?us-ascii?Q?7l9hbwvxLnurWJe0mxkZl/CtzNa1dc8sxZKQ83ouo66UjQFk9HK/4xp+YqHk?=
 =?us-ascii?Q?B8WCHGv54bCB1KuV1YyU/g9qs62A+VJzHN9iW3h029JLqb0pkwKS8pDADDSn?=
 =?us-ascii?Q?F+Ay1kE8J+EirUY0CyxTygJfeoB4OpF0wPpKTzM9TrgNejZl4jB+LLR9zIOC?=
 =?us-ascii?Q?UVJtXsnPwpRNPlYbycNjN4o73L/thOwLncNVw4wNDh4kcYxs/jSbntGEt972?=
 =?us-ascii?Q?kOuTNNdt+kO0K5h5al0swSaxMHrwSC2/xKAtQTVuWU1gsRzeU2zs36y7Km5I?=
 =?us-ascii?Q?Sv+/vqmbdq6wmS1zUosjta0+xcD4EUFrj8e/Kl60erFj5eYtMabvQrSc8XBq?=
 =?us-ascii?Q?0a2gWZp7kOG6U8ddFQqNiUwMxplCHz1zi/pjzBDrT6+jIdLERhMY4Xn3SN91?=
 =?us-ascii?Q?jsJuauQCO0ouoSBQCLzKF04J5fbT+CewEI+t9t9wgzeM9xI92NWu3gmH72EF?=
 =?us-ascii?Q?y6fd9W5X4bg9ANyjYg3WDmwYU+9Fg5LGnlRrBOyqbMj/BnwP7CH5abeyEwkS?=
 =?us-ascii?Q?1Cxs+nNuh2QXXdUZBom1gvidx4N7IjCVi/G+egciK9aPxIzyPUuJMjSOvonL?=
 =?us-ascii?Q?AJnjd+GOegxXMiQFdpapAiBmOnrm3UBFfLVAyaZW1mwZcGs1Rfw5vhq6u145?=
 =?us-ascii?Q?/m9tqg3aDgedpiwuAhfYQAvJQQlONtlYfHUQAki5iJCqkIj7XwgsxYgQk7ly?=
 =?us-ascii?Q?b0hQEmdkJsJMdU0yaoXpSURhurtDYkxUOHoe/Fp/+ud5d4fY+quAVwpeJpCx?=
 =?us-ascii?Q?C0gDKv6NBGOQmXv1aEZGshmN2wp3OfxjugAuINNAS45wy8ndovno8ja9vtvp?=
 =?us-ascii?Q?LID/fW9dobkj+Oyp94vwdjcKVroxFHq8VxWd+l7+WNInZkEgeEMowZ0LOBNu?=
 =?us-ascii?Q?8036bKBZWBk0A31tdG5GPO05OXdTnQ5HoaxoathZk477rd5/2b7EuBJ+Cnzf?=
 =?us-ascii?Q?rVoBufPCe1YbCdS4V3eaweQYbGQ9yT+ZCoWlkA5ZU7QAWiJWGI0jQGD9zVgG?=
 =?us-ascii?Q?f/qu+zFrty8doE1OFMBwAcyn4XYELAF7UUiic732O8j050MWqav855z9YuUr?=
 =?us-ascii?Q?C0Zr2dWDFcYrJLS/USQ8Vt9eGe65?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(36860700004)(82310400014)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:24:07.7410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 943acd8a-0a49-4c75-7ef9-08dc64f05016
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807

Add optional resets property for UART nodes.
Add support for uartps controller reset.
---
Changes for V2:
Added ack signature for binding patch.
Remove check for reset_control_deassert, as reset_control_deassert
function internally has NULL check.

Changes for V3:
Corrected typo in subject of binding patch.

Manikanta Guntupalli (3):
  dt-bindings: serial: cdns,uart: Add optional reset property
  arm64: zynqmp: Add resets property for UART nodes
  tty: serial: uartps: Add support for uartps controller reset

 .../devicetree/bindings/serial/cdns,uart.yaml     |  3 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi            |  2 ++
 drivers/tty/serial/xilinx_uartps.c                | 15 +++++++++++++++
 3 files changed, 20 insertions(+)

-- 
2.25.1


