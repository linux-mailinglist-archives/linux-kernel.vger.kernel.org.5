Return-Path: <linux-kernel+bounces-155461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5748AEADF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B9128BF99
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9D813C90D;
	Tue, 23 Apr 2024 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QAq8gBX/"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841521E526;
	Tue, 23 Apr 2024 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885563; cv=fail; b=co4spVm86Wv2X4aJqAJHBQdK9PqVSnnXyiOftBZzzcatHGQUIFJKZZB2AkSP94pEQKk1nMkOoqZYWYzbFylZPEtEv85fGb5IuTyLCZheq1rCkqQnVLCIH6nNHV3jNLeeY7rGddXVAM0E4NktbEsSEl+80EtLeoPGpdPlknyLyTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885563; c=relaxed/simple;
	bh=NmobX3ukwfG2BKwehhsYoF20+kmGdO4V+HuBhFLkwBw=;
	h=Message-ID:Date:Subject:To:Cc:From:Content-Type:MIME-Version; b=NCNfnct++4iZRVnpHD0/hZQkK842pfuA6M+QKwrC/s1pevKZhBXH08zhjL2aYZJhZaCo1sJdPcs4ljjbuC+MuuBtH3bKhwODUFcgAGUHmB0ZioupJpKfsGc0qsq4hCRvCHUH4vTHtFhePxrg/3bMNjEkmvvw4jszISkGE7knfII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QAq8gBX/; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iX/GtsLEPM6QCFoBVqLQzkc1uqiI4a/GnnkROGU3CIHj4Ygibse/gM+7AJzdgeYvtLI2CozWhqOR2MRJDTze1oW7D9wXq9W5fqsVsajQNZteAd68uDZRIOm0o5hT01Hof0L+hZNSaFHoWo3GwUJwL8VB3aoZX+vZu4bTA7Y5H1R31ptFHB4jknKqbSl3nXTdKccm4CNEC3OS5tJHmo2Kw/EmDyEKKuxQrkSVBjNEeoHf8IQaoaJIHXyxPKT7emY4RfRYCP+44Gqhq4b9HtfhgSOHV0i8z+lzzuAJA7l3iYoBmKcOTKUSWyjldIK8giNkoOaz8C22tXZjvz4YpgDReg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyLVpV2XIDiltxZjwyHyt7oZAXMFshn++HrcG5IdP3Q=;
 b=QCPtvdIqvFMLj38c+gIYc7F4bLz/PMhAB/ZzSW5g2qORkg0pzUfgy0xs0GET71f+mTI3r1PYNo5pjAxex+5CpZzS/xtF/Wf0dBIUj5Xsl3EqoM9Fb7NkhA8pHIMGnis/uOJPsDY2N8KxObOIleSN01tjLBEyA+2RwslqnyY2/gogT/NwifznIyX17LrXHBOa6nTKf068XqAza6LJMTI72Tq/zmTOGNW5e7hULKQ/fxiQ3RXVIG/eo3M4AjtdHc7eF2cDj9PbUorbjrK3eK0xQDEx4OHHOXE2VLywVQaP/AuqakBr8kGebBfWYsqW+9gbNBMsFn/XaIEhBobYVz14SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyLVpV2XIDiltxZjwyHyt7oZAXMFshn++HrcG5IdP3Q=;
 b=QAq8gBX/5HW9XYLRIkY33WMfJpJd8V/ACOnzxbS7dLAsdKD9jHUSDL4y0kMq22N/B2UHi2R5Qwl8OrhMGsgSNaXqV+hyLj2Prv9GEaFP1flL08G4e6dUyML/rDM078wDsNiYwddBIiOA5iDko0N9suIwJsZQjgOfE60Roaf1j4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 15:19:19 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 15:19:19 +0000
Message-ID: <109e7532-6265-4476-93ea-34fb0b209691@amd.com>
Date: Tue, 23 Apr 2024 10:19:14 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] docs/MAINTAINERS: Update my email address
Content-Language: en-US
To: corbet@lwn.net, elena.reshetova@intel.com,
 Randy Dunlap <rdunlap@infradead.org>
Cc: bilbao@vt.edu, "Naik, Avadhut" <Avadhut.Naik@amd.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
From: "Bilbao, Carlos" <carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0196.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::21) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: aaea987c-3988-4022-42f2-08dc63a8bee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0tFaE9SUmxIYVFtcThteHB0RC80dVNKbHpHalhFQlFvNWJNZnhDUjdReVNl?=
 =?utf-8?B?aVVRRzFPaURsMzk4OXFFT25rRnIwM1FwZDhPUVVuMDBlMklsbUxwY0YvOEFN?=
 =?utf-8?B?WEllN0FSeUhENmVYV2FMZDJvRS8vL01BRmtRK1h1aG11eWhUUUY5dDJ0enhm?=
 =?utf-8?B?T2NkZld4azh6TG9sOHZWa0EzeENDcEdMNTkrVmxVMlA2NEljaWM5bnJreXJ5?=
 =?utf-8?B?VlVpaHlpK1g4UU9QNlN5aktkVzFpNDJhYnNZZjdWNjZOdXdGak1rbnN1N2w1?=
 =?utf-8?B?NWFJdmRYQmRTdVpIR29sSHZYVjAwdDVQQ1owVVZwcE1mV3RqbklzUkFDTk9w?=
 =?utf-8?B?QTBWRjAvNkFDSnV1Y0JwYStSVVNxaDdINnI4ZG9HeDRrT3B4ZUs2RDFkNzFJ?=
 =?utf-8?B?Z2IxeVdKZVVLUkpqQ044ZUVwZU9yVDEzMWR1d1prRWZBdVFxVURLc2MvallC?=
 =?utf-8?B?dThFUEtMMDcrNUkwMFV2TDdBL1htU2x4NVR4enRVc1BreG9nV2k3RUFLMGZR?=
 =?utf-8?B?ejV5UWpmTmtZNlZrRVpBYlovM0N4c1ljRGs5SVVNalBVNEpJd3ZJenhzQkM5?=
 =?utf-8?B?Ukt6ejJEcjJQTkFFZFFWSUdOMzJ1dm4xS1RONy96U0N5SnJjdGpFczc1TUVH?=
 =?utf-8?B?YlpRc0h1aFB4dllSeUhxRWUwUDhiSXBnVVVxYTFTK1o2Wmc2YzBrc0dSRGZt?=
 =?utf-8?B?RUdkU1pwV3VJQ2NwL3h1cm52cktLT2UxUk9PaWwvekhQL0pIYmwrR1NYak1S?=
 =?utf-8?B?dllpNDIweTg4cTYweDBQUUVQbmRMZUxxZkFuRFhWa1Z2cXlPZldVdk5JQ3FD?=
 =?utf-8?B?NGNTL2ZZQ2twU1lFS1NXQjVlY1JGVytPcEwzNHNvMWs2c2h3eEhRUTFmR2dv?=
 =?utf-8?B?a01VamtLdEZXM0JRZC9WN3hDL05LNytNSEh4aUhSeWxtdWhxMk02bG4rbTlt?=
 =?utf-8?B?UnJzWUh0anFvbWdxcjgwcm1RQWc4WTJQc3VkYll0Vmh2RkZIZEcySlFWaE9s?=
 =?utf-8?B?K3laSmVVT1VGaTJjbWJBbzlZaG4xM0VnSUVYem9DNENqRkExdEM0MTkwN0F4?=
 =?utf-8?B?MDRhVU9FT0FwcVpINjVBSXJaSyt6N0Uwak53MzBmZHhJdVJBYi9wWmwwaFdj?=
 =?utf-8?B?dDBMWGhiYllpb0pIOWd2ZlJrTG1PbVJCblNEVVJhaE41dVBydkc4M3pTL25Q?=
 =?utf-8?B?WU5nTXIyd2UvbmJ0Q3dtR09nMThSRTFKYmtlcWlha2J3QmRGSjlONSt1MGVH?=
 =?utf-8?B?YlBnc2tUeDhvNkVaMkJRK0NLNFV2MUxiczdyN2FINUYzYzdUZlc2U3JYMlJ6?=
 =?utf-8?B?SjVSdnp5S29CSDZaZkZFcGppQlMxWWVWMGkrMGRhR1pML1Mvc0l1RHJEdEVn?=
 =?utf-8?B?TmFrYTE0TTEzY0V4MlhVazhkQmc1aUFCU3lRSTNBL3FTdzdIZTlkSnVTZDho?=
 =?utf-8?B?TnU4cE8vd1E5azRDWjczUEtSSEF4THAzMHpNa3dSYi93QjltbXNXTjRZM1ow?=
 =?utf-8?B?U0dwZDBXYThsb044Y1VTenM2Yi9kN2dLam1LeWQzR2tOdHR6RzFVeFlTOTNV?=
 =?utf-8?B?aTZHeThHQmZ5TnBTSHVMUlkyelE5MWhZSjRyY2lFOG1CYUpaRFFHRUczbzFK?=
 =?utf-8?Q?OvCuGltTCXGdMUL6jWsX2DSrtqZ9MJdjSusPsBfI7hN0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yzl2WkNkUzBncmVBRXp2ckhaUXNOK2pHN1VWVUJ4eWRxSkprNjd6S1ZKcHpm?=
 =?utf-8?B?VFNRTlJBZzlac3ViQ3p2NGp2eEVSdFpmSUtsaXJ3ZmZ0WkJhaTdZcjlST0VM?=
 =?utf-8?B?blE3dEQrTTRVMFpxSyt3Tm4vMlpGSEZuYUExUEp4TUJ3QWNnRkVSblZoU0Q1?=
 =?utf-8?B?cVlhaUJMRURDWDJxTFdMZ2pLYUlHTXFDVEdFQjFsTjYvekcvMFo3OVVHOHNV?=
 =?utf-8?B?RzVIK0gxT2hqckhZd3B5MmZVSUNoOUVlOXdCdnhMUkttZ0VSczBnQ1M3V092?=
 =?utf-8?B?T3VmRnpLQjByZklXWjZ6T2g3LzBXSmorWmJhejhTNFBBS3FnbW5ZbFZLRXla?=
 =?utf-8?B?SFZxRTJYcDNPZVBZRE1SRzdDNUJUcWFYTnpxbzRkOUVkaGF0cDQ0QVV5MlZL?=
 =?utf-8?B?REhCeHNsekVnM1QzOWpmeXZJeGpVaCt5MXhqVXRxdGR0My9kR2hjTUtPZWtZ?=
 =?utf-8?B?akVBSmo4WXB6WkNhTUlTcW42aG9QYXBReWFCcjdzQWxNK0hWRUVER3F2aUNs?=
 =?utf-8?B?SDNhRE4rS2VMcjd3RWQ5bFBMQkRuNktrZmkyNDBuSFhLSUJyMVFUcnFuOHpl?=
 =?utf-8?B?QTY3TGgyZGpXZzd2NzY0U3lPYjdIcXVPRHFqZ3h5ZzZQNGVreklNOHlXbHkz?=
 =?utf-8?B?MUc0bmxLQ3hyWWpBdk9GQzZ5Sm5YejBKc0Z2WWwwcWlqT0R4cytjcVo3bUcx?=
 =?utf-8?B?d3pGVmxlVWNVZmZBSmFuMU5EbkdIVUlrbW5nR1lYazVnUkI5TWIxYUw1enJ5?=
 =?utf-8?B?VVFZRXh1dk5uN1dVZlR4bnJoVUNpZ0lCTG5GVWJuQjVjOHpaTzBOTG5WYTJM?=
 =?utf-8?B?NSt3aktXWktRWFloc28rMmQvNUJaSU5rTGJRVGVXOG5aTlNVbGcvRFNRTU5x?=
 =?utf-8?B?TzJtbVRaUTZXMTFWK2dKdWRBTVBGdmVUdXBWNlNmcHhsZjJCVytFUGlqMU5h?=
 =?utf-8?B?RWhBWDR4Ui9WdnN1ejcxU1E5UEE2NTBFS1J3TjdScjBrMEVuME9oeWVLZ3ZI?=
 =?utf-8?B?SG1lYlIvMk5SUTlSNW8vbHRmWFlKVlRCblVCVFpqTTZ6K0VqVzZGdGtTNUVN?=
 =?utf-8?B?TjVNU3paUWUvTndnL1k5emJ1bTRQajBKS2JsTXhhVXVjWXNyOEsvZGJiTmRj?=
 =?utf-8?B?bUZOZU8xcEsrMjJFUFpYRDJGbG0xZXFna0xQRGNHSkRnNjJuODVmVjEzNHN4?=
 =?utf-8?B?MTkzYmJvbFcyMnYzTFIrN080ZG1NM2l5dGNQaWdFUkkvOG51SERlaUs3SnJq?=
 =?utf-8?B?VDd5cXFNem5KWTRmMkkrSlllNG5IK1BrTVZGZytsamYrUE9mcUJzbEhncmt5?=
 =?utf-8?B?dTRUUGhma1ZQMlBod2xPQkNEZ1p0UGhDdG41OUhpUXB1YWd0MjBrSVptNWZD?=
 =?utf-8?B?NW1KV0xEVjlBNmlEWXZiOTR5Vk1BRC9sSXg3ZjNYR1NXTVY5VW5rTWtrZmFU?=
 =?utf-8?B?L0xGS0hhV2tvRURZRXJxQ05keFNvb0RzUURVRElEV3ZERnlMSlk3TkVpVG5u?=
 =?utf-8?B?SmFUYXlSZlUyNWM1Yi9vZDV2ejhNZmVJSXYyd1hsOEt6aXlROUFNVTVTdTdw?=
 =?utf-8?B?VGJEajdMRWNsUU1ldGZkZTUvenlVa0pGL1BaZGF0a0FrZnVRSEJWTGd4ZFp5?=
 =?utf-8?B?VU45NmJmTlBBTDd1UW8ydlc3VFJSNExDM2N3SXhCWkx0ZDdpaWM0Zm0ycVBk?=
 =?utf-8?B?cm9wZDk2emdYLzN0NFlyZlZUWWpOSlZzR05IczIxVHdHaGwzUG8xbWZHTmVW?=
 =?utf-8?B?NUI4UDZIdTZmOFcwTllaSVdlQmRTRWhNdkd2eERGNE1BNDZoOGQxSkdydElG?=
 =?utf-8?B?OHJvYjZxQm9PL0xyNTQ2SjJiOUtMSXkwZUlTalR1dUJrbWhTOFE5MzR5YzVV?=
 =?utf-8?B?MGFlY3BpbzFnelVDdGcrVzZ5T3BqQ3BUZUFXWVJRWllVK3dZbGYxN2xuUVlM?=
 =?utf-8?B?VDdGekIrbkJOVUorSmlPa3JHdkdOQk5lejRHb2MvTjNjOVlSWjBzd0J1MzNV?=
 =?utf-8?B?YXdRYTNpRWlPUExVa2NMQ3hBdHg1MUxlamhIdmU2cE56WnZhbTFlL0I2b2tK?=
 =?utf-8?B?R2tqdloxZmQvUGhOdU14cnhCQ2FmcFJ6WlJJakVQTmtSSzZjVlRySWI1WVlv?=
 =?utf-8?Q?C/m1JzZEy1ScCe06NWySPszUs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaea987c-3988-4022-42f2-08dc63a8bee5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 15:19:18.9567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4iiMZV7t7RjImpyb9u/Slm9N06+zXAMbukW0Ywono9tm8gYx1L7HcW4Xld3lVMtkTcvblG4YA2ipJg2oztFBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143

In the near future, I will not have access to the email address I used as
maintainer of a number of things, mostly in the documentation. Update that
address to my personal email address (see Link) so I can continue
contributing and update .mailmap.

Link: https://lore.kernel.org/all/BL1PR12MB58749FF2BFEDB817DE1FE6CBF82A2@BL1PR12MB5874.namprd12.prod.outlook.com/
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---

Changes since v1:
- Update .mailmap

---
 .mailmap                                                  | 1 +
 Documentation/security/snp-tdx-threat-model.rst           | 2 +-
 Documentation/translations/sp_SP/index.rst                | 2 +-
 Documentation/translations/sp_SP/memory-barriers.txt      | 4 ++--
 .../translations/sp_SP/process/code-of-conduct.rst        | 2 +-
 Documentation/translations/sp_SP/process/coding-style.rst | 2 +-
 .../translations/sp_SP/process/email-clients.rst          | 2 +-
 Documentation/translations/sp_SP/process/howto.rst        | 2 +-
 Documentation/translations/sp_SP/process/kernel-docs.rst  | 2 +-
 .../sp_SP/process/kernel-enforcement-statement.rst        | 2 +-
 Documentation/translations/sp_SP/process/magic-number.rst | 2 +-
 .../translations/sp_SP/process/programming-language.rst   | 2 +-
 .../translations/sp_SP/process/submitting-patches.rst     | 2 +-
 MAINTAINERS                                               | 8 ++++----
 14 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/.mailmap b/.mailmap
index 1eb607efcc6e..4bac5578426a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -113,6 +113,7 @@ Brian Silverman <bsilver16384@gmail.com> <brian.silverman@bluerivertech.com>
 Cai Huoqing <cai.huoqing@linux.dev> <caihuoqing@baidu.com>
 Can Guo <quic_cang@quicinc.com> <cang@codeaurora.org>
 Carl Huang <quic_cjhuang@quicinc.com> <cjhuang@codeaurora.org>
+Carlos Bilbao <carlos.bilbao@amd.com> <carlos.bilbao.osdev@gmail.com>
 Changbin Du <changbin.du@intel.com> <changbin.du@gmail.com>
 Changbin Du <changbin.du@intel.com> <changbin.du@intel.com>
 Chao Yu <chao@kernel.org> <chao2.yu@samsung.com>
diff --git a/Documentation/security/snp-tdx-threat-model.rst b/Documentation/security/snp-tdx-threat-model.rst
index ec66f2ed80c9..3a2d41d2e645 100644
--- a/Documentation/security/snp-tdx-threat-model.rst
+++ b/Documentation/security/snp-tdx-threat-model.rst
@@ -4,7 +4,7 @@ Confidential Computing in Linux for x86 virtualization
 
 .. contents:: :local:
 
-By: Elena Reshetova <elena.reshetova@intel.com> and Carlos Bilbao <carlos.bilbao@amd.com>
+By: Elena Reshetova <elena.reshetova@intel.com> and Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 Motivation
 ==========
diff --git a/Documentation/translations/sp_SP/index.rst b/Documentation/translations/sp_SP/index.rst
index c543b495c042..274ef4ad96b9 100644
--- a/Documentation/translations/sp_SP/index.rst
+++ b/Documentation/translations/sp_SP/index.rst
@@ -7,7 +7,7 @@ TraducciÃ³n al espaÃ±ol
 
 	\kerneldocCJKoff
 
-:maintainer: Carlos Bilbao <carlos.bilbao@amd.com>
+:maintainer: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_disclaimer:
 
diff --git a/Documentation/translations/sp_SP/memory-barriers.txt b/Documentation/translations/sp_SP/memory-barriers.txt
index 27097a808c88..153e57130775 100644
--- a/Documentation/translations/sp_SP/memory-barriers.txt
+++ b/Documentation/translations/sp_SP/memory-barriers.txt
@@ -1,6 +1,6 @@
 NOTE:
 This is a version of Documentation/memory-barriers.txt translated into
-Spanish by Carlos Bilbao <carlos.bilbao@amd.com>. If you find any
+Spanish by Carlos Bilbao <carlos.bilbao.osdev@gmail.com>. If you find any
 difference between this document and the original file or a problem with
 the translation, please contact the maintainer of this file. Please also
 note that the purpose of this file is to be easier to read for non English
@@ -18,7 +18,7 @@ Documento original: David Howells <dhowells@redhat.com>
     Will Deacon <will.deacon@arm.com>
     Peter Zijlstra <peterz@infradead.org>
 
-Traducido por: Carlos Bilbao <carlos.bilbao@amd.com>
+Traducido por: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 Nota: Si tiene alguna duda sobre la exactitud del contenido de esta
 traducciÃ³n, la Ãºnica referencia vÃ¡lida es la documentaciÃ³n oficial en
 inglÃ©s.
diff --git a/Documentation/translations/sp_SP/process/code-of-conduct.rst b/Documentation/translations/sp_SP/process/code-of-conduct.rst
index adc6c770cc37..a6c08613aefc 100644
--- a/Documentation/translations/sp_SP/process/code-of-conduct.rst
+++ b/Documentation/translations/sp_SP/process/code-of-conduct.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/code-of-conduct.rst <code_of_conduct>`
-:Translator: Contributor Covenant and Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Contributor Covenant and Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_code_of_conduct:
 
diff --git a/Documentation/translations/sp_SP/process/coding-style.rst b/Documentation/translations/sp_SP/process/coding-style.rst
index a37274764371..b5a84df44cea 100644
--- a/Documentation/translations/sp_SP/process/coding-style.rst
+++ b/Documentation/translations/sp_SP/process/coding-style.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/coding-style.rst <submittingpatches>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_codingstyle:
 
diff --git a/Documentation/translations/sp_SP/process/email-clients.rst b/Documentation/translations/sp_SP/process/email-clients.rst
index fdf1e51b84e4..55d5803daf41 100644
--- a/Documentation/translations/sp_SP/process/email-clients.rst
+++ b/Documentation/translations/sp_SP/process/email-clients.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/email-clients.rst <email_clients>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_email_clients:
 
diff --git a/Documentation/translations/sp_SP/process/howto.rst b/Documentation/translations/sp_SP/process/howto.rst
index dd793c0f8574..72ea855ac9dc 100644
--- a/Documentation/translations/sp_SP/process/howto.rst
+++ b/Documentation/translations/sp_SP/process/howto.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/howto.rst <process_howto>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_process_howto:
 
diff --git a/Documentation/translations/sp_SP/process/kernel-docs.rst b/Documentation/translations/sp_SP/process/kernel-docs.rst
index 2f9b3df8f8fa..a62c6854f59b 100644
--- a/Documentation/translations/sp_SP/process/kernel-docs.rst
+++ b/Documentation/translations/sp_SP/process/kernel-docs.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/kernel-docs.rst <kernel_docs>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_kernel_docs:
 
diff --git a/Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst b/Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst
index d66902694089..d47a1c154610 100644
--- a/Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst
+++ b/Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/kernel-enforcement-statement.rst <process_statement_kernel>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_process_statement_kernel:
 
diff --git a/Documentation/translations/sp_SP/process/magic-number.rst b/Documentation/translations/sp_SP/process/magic-number.rst
index 7c7dfb4ba80b..32a99aac2f6c 100644
--- a/Documentation/translations/sp_SP/process/magic-number.rst
+++ b/Documentation/translations/sp_SP/process/magic-number.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_magicnumbers:
 
diff --git a/Documentation/translations/sp_SP/process/programming-language.rst b/Documentation/translations/sp_SP/process/programming-language.rst
index 301f525372d8..ba2164057f45 100644
--- a/Documentation/translations/sp_SP/process/programming-language.rst
+++ b/Documentation/translations/sp_SP/process/programming-language.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/programming-language.rst <programming_language>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_programming_language:
 
diff --git a/Documentation/translations/sp_SP/process/submitting-patches.rst b/Documentation/translations/sp_SP/process/submitting-patches.rst
index c2757d9ab216..18bb3413c3ca 100644
--- a/Documentation/translations/sp_SP/process/submitting-patches.rst
+++ b/Documentation/translations/sp_SP/process/submitting-patches.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_submittingpatches:
 
diff --git a/MAINTAINERS b/MAINTAINERS
index cd7980e5b1ad..6b7c08907cc4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -997,7 +997,7 @@ F:	drivers/video/fbdev/geode/
 
 AMD HSMP DRIVER
 M:	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
-R:	Carlos Bilbao <carlos.bilbao@amd.com>
+R:	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/arch/x86/amd_hsmp.rst
@@ -5352,7 +5352,7 @@ F:	drivers/usb/atm/cxacru.c
 
 CONFIDENTIAL COMPUTING THREAT MODEL FOR X86 VIRTUALIZATION (SNP/TDX)
 M:	Elena Reshetova <elena.reshetova@intel.com>
-M:	Carlos Bilbao <carlos.bilbao@amd.com>
+M:	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 S:	Maintained
 F:	Documentation/security/snp-tdx-threat-model.rst
 
@@ -10590,7 +10590,7 @@ F:	drivers/hwmon/ina2xx.c
 F:	include/linux/platform_data/ina2xx.h
 
 INDEX OF FURTHER KERNEL DOCUMENTATION
-M:	Carlos Bilbao <carlos.bilbao@amd.com>
+M:	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 S:	Maintained
 F:	Documentation/process/kernel-docs.rst
 
@@ -20701,7 +20701,7 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/dvb-frontends/sp2*
 
 SPANISH DOCUMENTATION
-M:	Carlos Bilbao <carlos.bilbao@amd.com>
+M:	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 R:	Avadhut Naik <avadhut.naik@amd.com>
 S:	Maintained
 F:	Documentation/translations/sp_SP/
-- 
2.41.0


