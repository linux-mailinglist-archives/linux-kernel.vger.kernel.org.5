Return-Path: <linux-kernel+bounces-159451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19218B2EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F1028265D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5AB33EA;
	Fri, 26 Apr 2024 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="FfwRrfYY"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2081.outbound.protection.outlook.com [40.107.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39CFEDC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 02:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714099342; cv=fail; b=fjGkzFEzRYn0r5vbaUCQdhw+sfhfVxJNTmdCyb2XNZwAmo7CoqTsQFj9t9/PbWJ6is7aE2zRtcjw35OehJKw8ux+7xg2oFoYplc/IDq8cIvhWb803pJzDGj+hwai9hhn+b14Fix1uGDbTQBxQsTKTOdVhivu3i0EsAy0g9hHv1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714099342; c=relaxed/simple;
	bh=DrRjMhbmO+SGXCfwd7GiFNa2CO8invAVfRTiFEqWrWc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I/qnRuEEewJ56cUcEtnvSnQGAMNbbWdTzDvl7zd73kbpur0YXDrxWTy5DaW5FK5dpsA9PukZp166cvqLzPySiw70H+QQsK6N03TaYiK3lWWe0GK78E0JLp5f78RiAUPveouPqDjjmpFrnKrQP17Z2ZA3MmkRuIAhgU03dZQmUXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=FfwRrfYY; arc=fail smtp.client-ip=40.107.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFbQ9wgEpbaM4LX8aYVHn0rTqNbxrvG1O8Ute2c4H6Aa100sBa2T/KuFg406+W7OE48oh/nioU6UpB6+AD6tMsAMfuBsmpvKQaM10JuYwyFDnab0DIMiVUUCDYrzQZFUdUxbwcbotNXfA2h6kDFb9UNxxiuvyIhF6zIn710tCiF1FoipBJQgEaszxSXNap5+CLW/lPUuv58fEJ4fpqBZSyyfDNUZ2/XK6EPhTJh1Tdaof7bsomNtfTcHw84EyN52gYSBxqQ9xjw7A3b9NRQ/pCwNAxFZ2MKceSbNNCrA3LyvP3qKh4eMVuYQHJYy5JmVIe0XYe8GVmPddzZtsQVp7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBC48aIJAsA8XkHfaD3wU/Rub0q4GdFutM6FCJKvUAM=;
 b=B5b1BfJ6RePYyBf1rsQqrqF3yFT3SJB5HsIBkLgR6HmEWLCqlU7OriAMCxVBLNATGBYzvPFhW82j9jJFJh7HpmCTt9EGeoeHSyDpO5K0QvifWT9euDtgeao9uF+uaQKy3hCSLLA1XFb17r7JzPtscqERG0SsM1lyc0lCpyKq0CtVKTUHL9Ot7d3HW3Oi2tuIFJT5CrtDk2Z1hUsM2kKqlhDH6ZugntI17FN10coPSeprbtzdqnhC6J3vEWPTeyhgRVMoPXMcygjj6T2l5lIpwubmIMFFxJALQfVXzAV7F9pevqAVlDL2H+kBQ4hB5S/spDZfmqF6KyTOeqklT1aqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBC48aIJAsA8XkHfaD3wU/Rub0q4GdFutM6FCJKvUAM=;
 b=FfwRrfYYRT8kqMbQ1Pyht8SBn7mG4l+Mm43V3AC88Zs1bBjIWAHdmxqZhx50j6bAUKsOjgynfzVRfNOAzKLb+1i7kMLGvI/GDW9uQkeHI+OQnQk3oVWXfbUITLfNJHcxKR49LDzCWr0akOFZ/B6bBJdrknQCtRPksH04KLiglAk=
Received: from SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) by SEZPR02MB5495.apcprd02.prod.outlook.com
 (2603:1096:101:4a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 02:42:16 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::18) by SI2PR01CA0037.outlook.office365.com
 (2603:1096:4:193::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Fri, 26 Apr 2024 02:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 02:42:15 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 26 Apr
 2024 10:42:07 +0800
From: <hailong.liu@oppo.com>
To: <akpm@linux-foundation.org>
CC: <urezki@gmail.com>, <hch@infradead.org>, <lstoakes@gmail.com>,
	<21cnbao@gmail.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	Hailong.Liu <hailong.liu@oppo.com>, Barry Song <baohua@kernel.org>
Subject: [PATCH v3] mm/vmalloc: fix return value of vb_alloc if size is 0
Date: Fri, 26 Apr 2024 10:41:49 +0800
Message-ID: <20240426024149.21176-1-hailong.liu@oppo.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SEZPR02MB5495:EE_
X-MS-Office365-Filtering-Correlation-Id: 093f007e-9553-4427-5a1b-08dc659a7c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400014|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnpHaVpRczBuNGtOenE1cnF0Z0Nwckgza2lpNkZpTVZTTHJhdm1xa3JRQUFH?=
 =?utf-8?B?aFJJVDZxUEo0TXdMSXlQYXJQQUlvcWV3MUttMGY1YkVuVVhLNW9UdllnaUhP?=
 =?utf-8?B?MUJ4UW9pN0prdGFUOWJ5dWJaZnAzeHE0MTV1bEtkZEV4QnBrV3NFbFNCa3Fp?=
 =?utf-8?B?eWRJRXlaRDJvQkgrQy9qUlVDeTdoMHprazBKQnJYTFdNVmVqQlRxZExwM3FR?=
 =?utf-8?B?Y3daQzhmaFQ2ZlE1M2VhUFNLVVpXcm4wczV2bkJJZngvVWxZczU2U3ZtWVpC?=
 =?utf-8?B?TDl2Q2liaGhiRWxoVFRkbk5NV2hBY1JsRlI2SkFuL29ZS1htUW9SR0Vzdkxy?=
 =?utf-8?B?UWpMK0V2LzFaZVkwOTc1bTZhbWlKeklIVFVEQjN3OTRCZ24za0pMQjFaaUxn?=
 =?utf-8?B?ZFhPSnVZNVl1SlNmSjhXRkNkR2xueXBoU3NwOUwycENTNTBrOTE5bUw1bGd4?=
 =?utf-8?B?Ri9TNjhIZ0hRaTJIZnNNTHloRHRxbXBHUXcxRjNnZFhWZ3QyakUyMTdKVXJs?=
 =?utf-8?B?a3R4TDViOU9mNTlpQ0lQWHduYUN0RmUrR2NzV3RodGN5WnhKNS85V1JhYjRy?=
 =?utf-8?B?cC91bTJjMVdVWmNBQko2dnhhVEl1VTZTSnU0SU54RG1iYnBFZ2prMWNYK3A4?=
 =?utf-8?B?KzNVNm5kbnVJTGFxOXFnTDhSTVJrN1p1YWtnU29ieWFnQmdRWnRhckFNY3dL?=
 =?utf-8?B?aFUyV05lRUFQYll4aUdGcDNqSFp4VUYwWEUyblF6Y2FMcEttUVIvRnA1T0tV?=
 =?utf-8?B?YWlXcnJWNnBCZVlhbGpmQlp0QStZaStOM1BMd1BnWmVpS25mb2QyRDFwdFlL?=
 =?utf-8?B?OEQvb0g2bUZIS3Jkd0Mwekswc1IybUJPaEZJREZ1VjIyVElMSEtURXZ5c0px?=
 =?utf-8?B?aVJMMWY2NXNITjRFRjloSEIwR1hrTDNrSG1CVEh5QUpiZDdpc1ZodU9sUmsz?=
 =?utf-8?B?eHEzSUZ1VnFkTVhIdDhLWWlrWGk1cDBFdVFUUEhGZm9jaVc5NHpTYTA1QkVr?=
 =?utf-8?B?bXBadHhNWjJpZXBYTW0vNnlkQjFvWXdsTk5oRHIwUGt6SURsdmRTVXMwNGFy?=
 =?utf-8?B?M2MzSU43bi9tZkJkSEpDQmpEYlQwc1c4YUtIODBGMi8reno1RXJ2NnltVTdy?=
 =?utf-8?B?bkh1RFQ4dHpZNkhraEt1ckZjMHNaN3VWQU9vdkpKVzFwR2lZbGhvdXYrVENm?=
 =?utf-8?B?a01NendYU0FzWlJjQ05WOWdzNjRtd0l0azVJaWl6YmRGanl6WXgrdUo4NVA2?=
 =?utf-8?B?YWQ0dTlzMG11ZWlFWGxhazUrNVpCY1gxRWZ2aVo0dmJ5WWk3YitWVERKbzEr?=
 =?utf-8?B?ajh2VUxHU1R0OFBQUnJaVWd2N2R1QkJiTmVWT1Y5Mi9ub3RUV2FyRUd1aTho?=
 =?utf-8?B?WFU3emNTbmRlVnV0endZdThnL2VFeVF3RTkrOWpkdUJxYkVQK0hPN0tycGRX?=
 =?utf-8?B?WHpRR24zSGU4TFI4d0krSlcxd0UrakFTczdYdDBtc3J0K3hRSmJtWThNNFJT?=
 =?utf-8?B?Y0pqMFZkT1VBYzVhdjFld2IyTVMwTUhnT0RwVitFZWlvcDdRdTlUaERPNEU5?=
 =?utf-8?B?QTl6OExhU1VZeSt1OU9IMlY4OVkzYm41VHNVcDdmMHhQdEExV1Y2WWNCMTdw?=
 =?utf-8?B?VVk0S0FLNXp5Y1R5cWNZR2JadXNLb0owbWJsV0JSV0VGVjRNTnExTTlCN1k0?=
 =?utf-8?B?MWJ2NXpiaTN3RmhaZlZoUEw4VlM5cEtOdy8rcnF0dm5GU1laYnArOXNBelI0?=
 =?utf-8?Q?zdda0nCX6wd24qYbkzV4rKCQHWQbp3i7VHJeTOC?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 02:42:15.9292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 093f007e-9553-4427-5a1b-08dc659a7c0d
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5495

From: "Hailong.Liu" <hailong.liu@oppo.com>

The function vm_map_ram() uses IS_ERR() to validate the return value of
vb_alloc(). If vm_map_ram(page, 0, 0) is executed, vb_alloc(0, GFP_KERNEL)
would return NULL. In such a case, IS_ERR() cannot handle the return value
and lead to kernel panic by vmap_pages_range_noflush() at last. To resolve
this issue, return ERR_PTR(-EINVAL) if the size is 0.

Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
---
Changes since v2 [2]:
- Remove RFC tag
- Modify commit msg, per Barry
Changes since v1 [1]:
- Return ERR_PTR(-EINVAL) or not check IS_ERR_OR_NULL

[1] https://lore.kernel.org/all/84d7cd03-1cf8-401a-8edf-2524db0bd6d5@oppo.com/
[2] https://lore.kernel.org/all/20240419101643.11534-1-hailong.liu@oppo.com/

 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d12a17fc0c17..44be3edb3f42 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2173,7 +2173,7 @@ static void *vb_alloc(unsigned long size, gfp_t gfp_mask)
 		 * get_order(0) returns funny result. Just warn and terminate
 		 * early.
 		 */
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 	order = get_order(size);

--
2.34.1

