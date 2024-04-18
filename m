Return-Path: <linux-kernel+bounces-150813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 355878AA4DA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 892BCB22207
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18990199E89;
	Thu, 18 Apr 2024 21:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b="kt5AoyIh"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2118.outbound.protection.outlook.com [40.107.20.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418EC16FF26;
	Thu, 18 Apr 2024 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713476873; cv=fail; b=gXJL+xzgaHrwMO3wIeK0ChEQzlVKQaUH1XHlgw5VfPeSRhMKfYL8i3xq4xI/B/A4I4QViGj2m9VBBDg19Agauh6Z27YQr2gYh6H668vcNoFwV57YbE/+FXzUxCgbraOMgrF19UBRb9CSWT0HS6zzaNWbugqftCqObR+UwspqAoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713476873; c=relaxed/simple;
	bh=kor2ut6DXvSir5LuxXp3DpLefTQJiFH3VTLqPd+rQJo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rwxjgq5Xbb8xje4bT9ba/TkaN1EWNOlPAzDiKBHl0k2jbcuL+NOOyZdtZElrsebFMzf+cgfBHztgHNKIzzlCM7ztP8zkGVsKpInLup9JhSAHEUSNp5oLVHLzMfBaoOfR32VDL3t1x4Lnm+kVnITVEB6k+6ULoG+N/9Nkw92bpcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn; spf=pass smtp.mailfrom=supcom.tn; dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b=kt5AoyIh; arc=fail smtp.client-ip=40.107.20.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=supcom.tn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzoOPQj8/2PQ9hyfRw7SfL8kffjfZKuIFXPR8MxN9VmFe8pKqZTNgILyDBgjuhRWy7LUDBjb+JKxfIO37sELpaD3CpZ1OCGXu8k8dBmz2gXhplTNs79P7+149DOy4rDzLcUwUjy8y/w4SCSK9CKFhSofGp4Ty33kH88HkPjpGp0XDlJCcp+IdI3Z7JTO4nKeyPC/gknJgX0oY8Sh+hkDk3SxYqbgxP90Vhlw60lCbIVLIyeftuoOkoKJNWHeifxD7HwvrBWq4aGcY8G1xpn8rQyVGIaaYrEKYSNyJ4fjyAXIulMX8a0gXACe+6eVPTNAynsuyGk3nK+MUsk/Yyazjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGDI3/Vc+hU/J0CXe/j0jQOXuBNroOVEeidunRSiyd8=;
 b=QAN+fxxVr6CILjEL+d7SRTYKddWVb1aCKAzDyzeN+LrPXtfdafts1gBIDyFWf8Aw92CfE2oj5B6cxqEXJPaG6t2PcWz0h+rclASyJzJ3OaheRPb11PJDWTDhXwQB58lTmh6keMBNOo1HBNCujqUIm3EAbIUf05uHmyKwxQmLsQo8hrBraHXb+BIk3IWNDkbIbwy4GtAE8B6WlXMFOwvGknN/zxoBHW31WRBJE/W9DRSvPKaF/SoGDSzTsT+jqJFF5LhwUZixtmCFxYBx2h3q9LO3EUue2a+nYQXc4OPvJAz20FHgZ8oqxDhANdW46N8maeOpfl6CU8ANPoMaiJYNog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=supcom.tn; dmarc=pass action=none header.from=supcom.tn;
 dkim=pass header.d=supcom.tn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=supcom.onmicrosoft.com; s=selector2-supcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGDI3/Vc+hU/J0CXe/j0jQOXuBNroOVEeidunRSiyd8=;
 b=kt5AoyIhfEExfUFVNHFiowTeAfsQSNDyxiU+HVNsBN0LHW4mRNpUCLlgFvf9Z0qngwqpVeQF3OJio+RDZRdT4A0Gx2h+HU7YGBNopsFPkqvlkLtMhAblZxyEpR7xvZn8di1oMX+MkcmF1oC0+d9XoS4MS3MfQQbdA91RC2ekt2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=supcom.tn;
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com (2603:10a6:208:b::23)
 by AM0PR04MB7092.eurprd04.prod.outlook.com (2603:10a6:208:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 21:47:39 +0000
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::eb9a:367f:6384:7d62]) by AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::eb9a:367f:6384:7d62%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 21:47:39 +0000
From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D . Jones" <luke@ljones.dev>,
	Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Subject: [PATCH v2 0/1] platform/x86: asus-wmi: add support for vivobook fan profiles
Date: Thu, 18 Apr 2024 22:47:24 +0100
Message-ID: <20240418214727.10658-1-mohamed.ghanmi@supcom.tn>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To AM0PR0402MB3905.eurprd04.prod.outlook.com
 (2603:10a6:208:b::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3905:EE_|AM0PR04MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 099f037b-584c-4d90-cff7-08dc5ff12abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	06nqkjNBLIewS0nINwU9g+yiEHbuV9Z0L8RM8r5RjoHPzph3PFFtdgMJx0JPQAxop1jO6pvxnH2IPbJGQRoA4x8c0LmFbgJdSQWze2WI0zvTHKKDWp6VFgLOXxvNK7t4wsAoiRuTqt5rPlOTemxgz2fGUA+ek0UUIHsyP83+eHe2WpZ5suSh+12rdiqI44h/kZzLdLdX8cnZUIAz/90HH5pFPZftBr/pchO40vb7FpMbPm6KssDFH8n8ToUrdZhJn2T3n6z6RjaAgwWBvWE+B9EfZq74ZASDHVVen5gzdfJ6tSU+IT7y8noE58UPuc98X5Mh8qK+H3OzLJd75tFRjd3bIyPUKyNa0SxujAGDN06zcseZC8spaJDqv8iyjGRY72pGVGoiTrNePjDWptIbRvab6w45EyHL8+mu3Xvac7748PnJq19SaL5Wxkele0NMkgeAJbG+KYt/PlRtFhSKYIpTTCVueasNWWQBoRHTiG44Ut/XNl+kk9cXZoESiOYsGaOhDdnu47O2Rh4zW3l58JYVCQPWBRLxk2FW4/4Q4ghlKdJt3+9H5ixN2s0SdcQsSz5yD3L5gpCTjNAl1YsrC1+9xwtdTT0Ag/rrrRBodAbEq9FoGZ2jBTdPVeFpJ9OjRZ6eYa4lcHRODL62TQ5W1yZYazR7LT6xKWZJiOXyes1tBagae+oFdqKHLso3InLtchv24lGc04Fm1YSZkpJNA7k1xmfRgKFUSRuBTrVYDL8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3905.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(41320700004)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cG43M3RLaFU0bmNTcmNMUzJPbU9OTlZXYWZjM0xITk0yVHFDRUd3WUJrNkt3?=
 =?utf-8?B?M0Q3S29CNElQMkFoVE10NkdjRFVUS3JZMTViL2d2cnVRRVN0VVRzZUVVckQ2?=
 =?utf-8?B?cXl3ckU1V0lDTnF1V2lyS2tZQWhMTUY0N3FQYTE3aXlGZitmK2M1VERGcnJo?=
 =?utf-8?B?Yy9QTEVIcGV4Nk5FWEFGSjBFTTlUaTg2QlZwQlVuQkdudjJISWQrUmh4NE0x?=
 =?utf-8?B?MkJuZ2dYOEF0R1NmclcwVGZaYldPdDhRckVGRnZJQStnOXZwQTJHTEJXS3Yx?=
 =?utf-8?B?Z09qYmd6clFRTmM0YVdmdlVPaXAxd1ExRjYwZzR1VE1HUDVYRHEvdURLM0Jv?=
 =?utf-8?B?TE1QNi94R09XYzJOc0NxY2xLYXBPMmhOS2dhYXZEazF5RDJUOGRQZFBjVXlB?=
 =?utf-8?B?MHJUTURFQ0tYUkJwZXk1RTRUbTE4N2hjUHZMU0g3TzFncVo2cEM5d3d4MW1y?=
 =?utf-8?B?ZFdETXJsNHI0SE01RkF2QXRvc3JsR001cCsvRFA2cGpEelVudXZQaWtsT1ZB?=
 =?utf-8?B?dDUzMDhIZHBieDMrNWU3ZDNLdjdTcmU3dkV4T0xGUzBvNmM0Z0VMRUQ5N1Ny?=
 =?utf-8?B?MjNBUkh3c25zblRkcHFMV2xIQ0M0b0dPcndHRC9kUzdUZVF1YkpVbjNvSkxs?=
 =?utf-8?B?Z0dVa3ZGMVJiYzBkUHNhU2xKUWZLcXZ4SGhyWmRyWXZuNGNGSGVRbTVlTmk0?=
 =?utf-8?B?d2tlTFJscnNudFZEVGQ0WHFSbFVnWC8rN2JuYmhOZjVEb0JCckJnU0M3aXBD?=
 =?utf-8?B?VEE2Zk1rd0ZNTUZhWTF3RmFTMUZ6Sm1VNXIrbXc1MXNQVWVFbHZBQ3BOeVJV?=
 =?utf-8?B?TTVsL01GOHVQUEtFdHZ5am1naENRL1JnbFczVmV0MXF3K0Nvbnc4ZnFIRlFN?=
 =?utf-8?B?Z1Nma3paNDBoVmVOcmJBNEZmSDJqTHk2dzkzRkY2K1IyVzh3anJYOG5ubzZp?=
 =?utf-8?B?M3FISGVXYTR0Sis5STRrZC9OYXlhSnYzQVMyemtFSTJYVEtUNk1pTGYyeU9p?=
 =?utf-8?B?QUl2K1RaQXE3SnBhSHM4NllkZnFMUkpnOTlPanVoYThPZ1hRSWxRTTJkTXdC?=
 =?utf-8?B?K3JiemptTXZFWThIMFF1Rkd5cHRQbEp5NWdOZnJPY3hTR1k0VzF3Y3FHeWs4?=
 =?utf-8?B?ZU9mb2lPL296MFFmQ0RBbkVNNW1IZnczK09POG5ZOWJMaUYyS0x4MVdya2xr?=
 =?utf-8?B?T0toVVVBbHVhcHlLc0dlNSs1S3JoQTltRFNMUmFBYVVRN2dsKzBxN0pyTFR6?=
 =?utf-8?B?U3VMS3dFdVVqSVpUTjVaRWEwRHVCRVJESFcyd29NQzl3S3Zpd1REUUFYLy83?=
 =?utf-8?B?eWM5ZE0vNEpuSFNlVStWdWNmZjcrRjZoRkdEaTVBZThySlZJQkh0YjBVUjR1?=
 =?utf-8?B?ZUdtRGtRK3l2YlB5cGs3QzBJakZrOW5tL3hBYXJqcDVOSDlhS1VkOUlObUR1?=
 =?utf-8?B?MDc5VWFvSWxEb3l5OHRPU0hjZTdOWkIrWW01TFVPa0F5WXkvcXQyQmVlZ2pW?=
 =?utf-8?B?K0FQWHovTENVcXRWR3JnQUhFaW1kNUVJNFRKajFiSnFaOVZsMnlQNzcwc0xy?=
 =?utf-8?B?anBtcE52Q1dUWGV6eHFnaVE2UkZCRlhic1hXeTJheTBGelhySHNiK2lORkdJ?=
 =?utf-8?B?OTZOUnhqY1VGelB6S2lJc0Jwb0xSeXVzekVjcjk2UjBmR3pGRTlWT3JuamlP?=
 =?utf-8?B?Z0M3K2VPUXhRU09vaUFkQkhSa1VnTWp4bVlIdjZLMWs2NHorTkozRzVySUVP?=
 =?utf-8?B?T1poUGJReXNOM0RpOVF4UUhINlZPWm9hKzRRbEpFM0RXZ3ZXMFlyUWlvckh0?=
 =?utf-8?B?eisxMDZWRVZueStFN1hRRmtJK1N3RHFYUnZPckk0WjQyeEtDQStZaklTemtq?=
 =?utf-8?B?bnM0OXBEcGhjSDJBNk04Q0tZOU52b3hXaUpzeSs1b01HZEFYT2trRTZweTlh?=
 =?utf-8?B?d1hkRkdGdDJTZmszTnUyZzhNMTFHdXVKQmlsTGRBWDFNTnFYcHlvZVA1TDdt?=
 =?utf-8?B?YjkyQnRmTUxqQTRUdU8zeXBUeFZSNFVPL3JmZGZ2VUJ0L2I5cUlwbFZuRHA3?=
 =?utf-8?B?dkZUQUVPSWE3MHROQkw3NDVUaUpldm4wWm9XV2VGRC9icFJ3Q3VCUEE4QWt6?=
 =?utf-8?B?cU5tMCs4b25rWEF0NzA3WTYrODNTR1NoekdaLzZQdGh3OW9RTWZoekp4dFN2?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: supcom.tn
X-MS-Exchange-CrossTenant-Network-Message-Id: 099f037b-584c-4d90-cff7-08dc5ff12abd
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3905.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 21:47:39.0513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f85f528-6195-4e97-8e41-f5a9ad3bed4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUJ/8wXV99PphgzYVf6efWnOK4afUijN2ctYipTjZskMwLE7iJkFy0pbw0muOkwAqgcUys58Ohhb6i0gpwKKR1tpMNX90J+bKUq4FJU0oV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7092

Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
to adjust power limits.

These fan profiles have a different device id than the ROG series
and different order. This reorders the existing modes and adds a new
full speed mode available on these laptops.

As part of keeping the patch clean the throttle_thermal_policy_available
boolean stored in the driver struct is removed and
throttle_thermal_policy_dev is used in place (as on init it is zeroed).

Changelog:
- V1
  - Fixes grammar in description
  - reorders macros
  - adds throttle_thermal_policy_max_mode() helper function
- V2
  - removes unnecessary braces in throttle_thermal_policy_max_mode()

 drivers/platform/x86/asus-wmi.c            | 93 ++++++++++++----------
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 51 insertions(+), 43 deletions(-)

-- 
2.44.0


