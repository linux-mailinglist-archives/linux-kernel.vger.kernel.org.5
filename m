Return-Path: <linux-kernel+bounces-167396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 034AB8BA8F0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669B61F22854
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86FC14A61A;
	Fri,  3 May 2024 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="it8WXQPl"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2058.outbound.protection.outlook.com [40.107.14.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEFF79CD;
	Fri,  3 May 2024 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725684; cv=fail; b=lB7Sdqlh2QeVTC4FTgUhy7vnFXqrS0UIyxekVl3X13cqO3i8IUF5t0ahYjVKYYJyWzTgovGtg+x4FosFcadaB+1bfzK5E2i93MmJ7dRAxJO1ep5JyJzHF+Sura/J4JHomrxoMdShT7/dGdhFWx4ROXErDEsdxstOkL9NfDdkOFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725684; c=relaxed/simple;
	bh=TP6MxVvRed7gq7I+fxgjVWsa3D/UAG1bnDDdzijVt6g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cJI4SFDsWUiLcSYKaF3iUzSYjquBvcdHJRCAq74X8jDDYDgoGdhMsPVwyeEs+ks022+Ya4oqlU7SzGhto2xX5Mg9LjhDeKrtfxUhAgOUyrGXFLglr+D+2iFbLOBggS7YOh+Ul/YXND32DwcKEib5ve35DU0LTfdnmFqTQtUobO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=it8WXQPl; arc=fail smtp.client-ip=40.107.14.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5PKvJUtMx0q4Y65I7ensC2AfK6CWRQOlh4rL5QNtQm08wC4Ng0RGUkqhUOx4OC78etE3DNQVXJvGh6ZAUG0UwSHerwhKZchAEPEK7YC906ho2thA4zUd5P65FNlvR8QHlcSmiUq33HEeWRQajXIc0PXbYmLjtHx/YkifSVFZ+mt3Og+zxagxfVLcqgQUaTbWWXS7rKEuUF30SEDD2lDvioSLpkwfvy4oXzPYO9IGRh3ePbOZJ/gpH6YefS7i7A6VStitzyMKgWeHAo4KyR4bS7Ts75OMgd1dcN6SxN5l4v1QU+AWuEaughUmcriC9uU46iD9h2pwArQEAtLfe1lHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECzCRteI9Lfwn1cLw14YEPYuLnR3EBIhJVW4H7ad5R4=;
 b=YpaVCffgFbnV28aR0C1biQ3eL6OhujN8ekY+uATuozyycK1RLs+JIrBRZScjz8BNhDcgUfkNfULUrlWGBuu7qX+mBKtt7kubm4ys5ljI9EllaWBj6Oph5BRtHKWEKaPy0hFPkaOz8e9oYekoeH737aznf4t4Sq2VMTrqCLMDyQPSx5oPFXY+bk+CMhfmMUi1UV/E1TIAwbxP4xdc3U1wFURFdA/2xaEOLOA1cra0YHFBlb/3HpBtFxlzdiMjfAcr1F0CVgvHFTclmg4DEqkBFiTj5/hWVDvJ3vbRefYth8JJya4BedeIcdnKDWxNaAYY3Qs8Lw4R8LsBxgAcq19YXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECzCRteI9Lfwn1cLw14YEPYuLnR3EBIhJVW4H7ad5R4=;
 b=it8WXQPlQKDlThUzZmLtCr1GHlwQRcA7M09fEAk/byLRhxrpFVyauSDaYDsjJx0otKc623//msJA2nemR6eAot6yACFAXsrGEH2r09sQScwETFPkRD7Pr9Wv1/E2JwHc/OQCSkuAxQCeRiFefqW43k1xKdVnrB9+nprsegpBqRU=
Received: from DB9PR05CA0001.eurprd05.prod.outlook.com (2603:10a6:10:1da::6)
 by AM9PR02MB6625.eurprd02.prod.outlook.com (2603:10a6:20b:2cc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 08:41:19 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:1da:cafe::3a) by DB9PR05CA0001.outlook.office365.com
 (2603:10a6:10:1da::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Fri, 3 May 2024 08:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 3 May 2024 08:41:18 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 May
 2024 10:41:17 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] net: phy: bcm5481x: add support for BroadR-Reach mode
Date: Fri, 3 May 2024 10:37:16 +0200
Message-ID: <20240503083719.899312-1-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A01:EE_|AM9PR02MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de0ba31-c2fc-4dc2-bb59-08dc6b4ccd64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzBCSlNmdllZaW9QZFRSTDdzL2piVkJqQTRZbDA4T1NPeENrb0NYY1B1SGR1?=
 =?utf-8?B?ZUVIRzRsek9ZNjV4amdmdnE4Y04yTmFocXNMejlncGFTT1oyNCtuY1BlYjVo?=
 =?utf-8?B?c0hrTkpBbHJjbWkyMzB1bU84OWQydWFNdC91NnYzR3FLUUx5QkNjQmtOd25l?=
 =?utf-8?B?MEE0blQrc2tuc0x5ajA5aENJNnZRa2hxREI2TWJRWk5CZXAxZ01CbFhsN1VH?=
 =?utf-8?B?U21MNmQ1eUc4ck1RbjY1ZnhlYXJSd0NhVjFQUlNrbEJsT0NpdmFjalNqbFJH?=
 =?utf-8?B?bGVueWQvay9laGpWL0MrejBOUHRGNXJrZ2NkamNNczdqUFhMUXNqWTRKSEd6?=
 =?utf-8?B?ZkJtNDhXbEltdUkzb1p4alppY01EK3hnOFlsNjJZaWdQRjQ4blEwekVBcisy?=
 =?utf-8?B?US94Q3JqRENQRUdVRkp3Uk00MXFjUDNob0dmeWVLc29FRzUzaUdUeFc4RGNU?=
 =?utf-8?B?ejhwSTI4MGN2ZS9NRU5RRVJ4YXFDWWRhSXp5Y2R3KzhUb2NzRXFOUVRjdkdr?=
 =?utf-8?B?cXIzNVh5NFZGdklzT3pxenE0bUxRamZLUEZJK01pb3BlMVdKREx3MDI4bkhu?=
 =?utf-8?B?LzB5NVlVTDFmdmdrVkJnR2VzM01hSzJTT1BWWkpLajlZWjZaNXdWN1VteVBx?=
 =?utf-8?B?ZzhxNUxrem84R3piZzM4VFpHaXVXcVM1cHNCbUwvYVRTendDOFlySjdwaHI4?=
 =?utf-8?B?b2hRVE1NVmRQbWNreC9lUkNOTmVrUnVKNXg0d3VHWllkR0llYkxiY1p2Tnoy?=
 =?utf-8?B?TlJzeVgwZ0E4bnhUamFsdFE3bk84M2lUUFBNVU1MTzlCaU1kQXJ1Qy8xMFgy?=
 =?utf-8?B?bjQ4ZFFCYk9vbzJyMGFrdkdRS3l5dVpwOHJrUnlsS096LzFFaUM1Yys3UEFD?=
 =?utf-8?B?bU5lajhvNzZiRzdhV0hObnY1eHRoeW5pamZSR3RTK09vZ0xjR2p5UERRUjJ5?=
 =?utf-8?B?cEc4Y215VTFnWjlUSGZ0Z091ZFNjWUZtUHVBUGNrdjBIUGw1VlQ4N2ErN0pM?=
 =?utf-8?B?MFp4N3FEZjFKSVUyMVJ5dDlWY2huVWhObGxYWFJtVGxsKytZZnZjaSsxQnln?=
 =?utf-8?B?U3daUnd6cThZNkx2eUIvdUw2SC9KZS8reWpuZldGUTlPamZDdzlHNW90RFFL?=
 =?utf-8?B?VHhVK21ZeXF5ZmtVa0lVaXlOTE9YYmJTT3hUeUxOaVlwZ0JuMjduYndiOFNV?=
 =?utf-8?B?WFlsZ3NVSnR6ZGdSYVFWQ1UxamZSeXo1bE9EY1RVWlpvd25UcTZDQjNpQXZx?=
 =?utf-8?B?Z3pMVnJpb0dSYzh3TFNhN0tzMGNlVFdiOW9QSVJxRzlhNUQ4L1B6ODk3cncz?=
 =?utf-8?B?TXp4SitYTWphbDhtQjlEaWxoVWVwRU5FUVZxVHRtU2JENUs0ZHVlVlJ5ajFZ?=
 =?utf-8?B?cEI4MjBOUDZ5VFFjVzhucWp5V21IVXlpR0FIU3hibnFISUljT24yY2RoWFdF?=
 =?utf-8?B?STA3UHloa3hQYmZQSFpubXJQTXZYL0Y4M2EveTkyTzREdkhlVGRhMnpHU3po?=
 =?utf-8?B?TFBUTjh2Y2dZNnozVDNvMFVJdk5uemtkbm50TE5kclBkMGttRFJlOVlrUHFU?=
 =?utf-8?B?bWsvSVBQc3AvSld4cXNYZ2pkU2FYN2hqRkdNUlA2SGpUQ3hwTlJiSjZ4SWFI?=
 =?utf-8?B?K3dQNW9pWFhLeVdhcEpGbzFSMlFXVFAyYU9WTnVyMXBXOTFHNEk1OStQdGpD?=
 =?utf-8?B?WVNrcU1EZzBySE5Ud1VLc2Y0a2lZZytnczZsaUFWbmtDT0dZWVBwUFZkS29R?=
 =?utf-8?B?b0RKSUdjU3Q0Mm4zbUVvR0RNNkdHUHZZdldCcndwdmwvTytiOXRUcmVSUXdp?=
 =?utf-8?Q?/nsXJVwb3wXyS6wlyRLEHV6Br7cbI6xV80oy4=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 08:41:18.6603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de0ba31-c2fc-4dc2-bb59-08dc6b4ccd64
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6625

PATCH 1 - Add the 1BR10 link mode and capability to switch to 
   BroadR-Reach as a PHY tunable value

PATCH 2 - Add the definitions of LRE registers, necessary to use
   BroadR-Reach modes on the BCM5481x PHY

PATCH 3 - Implementation of the BroadR-Reach modes for the Broadcom
   PHYs

Changes in v2:
  - Divided into multiple patches, removed useless link modes


Kamil Horák - 2N (3):
  net: phy: bcm54811: New link mode for BroadR-Reach
  net: phy: bcm54811: Add LRE registers definitions
  net: phy: bcm-phy-lib: Implement BroadR-Reach link modes

 drivers/net/phy/bcm-phy-lib.c | 122 ++++++++++++
 drivers/net/phy/bcm-phy-lib.h |   4 +
 drivers/net/phy/broadcom.c    | 336 ++++++++++++++++++++++++++++++++--
 drivers/net/phy/phy-core.c    |   9 +-
 include/linux/brcmphy.h       |  91 ++++++++-
 include/uapi/linux/ethtool.h  |   9 +-
 net/ethtool/common.c          |   7 +
 net/ethtool/ioctl.c           |   1 +
 8 files changed, 559 insertions(+), 20 deletions(-)

-- 
2.39.2


