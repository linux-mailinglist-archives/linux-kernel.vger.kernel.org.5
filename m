Return-Path: <linux-kernel+bounces-157212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E1A8B0E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E42128E34C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59DE1635AA;
	Wed, 24 Apr 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="NRb/X98j"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2103.outbound.protection.outlook.com [40.107.95.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038E0161322;
	Wed, 24 Apr 2024 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972902; cv=fail; b=SsI4qTdKIWU5Yg9wSw2kXBCn1TWCnZyPp/TnS0OueapmMVcAzVmGkzGs2AAYNCt6FkYxCyQ6XkOK3YoPPbkmP+eg4hSmR0SglybHOcP/3mdVZT8CP4KtbPAgC1JnlvcS29+w7HloUkDCIxSjj7wSqVFY4rL3fCxs6CcAqhjPE3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972902; c=relaxed/simple;
	bh=kHd1Ry3YnBdkXkRcPuiomPS+1pRowH3aS3iSttM88eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u5iORqmTsmUrUr2xH/+y4ymeMzejLyEWbG35rLnolV3BLRQGp4kj83vRXM9PWpwm6SZIE3zppBioVgEbtnaTS9u2ewFA6WB1dAUo6FbzR2oNCnp0Xo9oGWSeUfO3as1fEu70Ug/W4zCf9QeKxjgcYBaegICaU2Ekew/ZpSC9v68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=NRb/X98j; arc=fail smtp.client-ip=40.107.95.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8cbm8vVscye2ZzUf5B7chWIeCeBPcAfWzLnC10DrGg4q+MbsF6t9IUmUumkQ2f6rZJrOxUWDB5t53n2Mc31A6Fx7Al1NM79yA17hq3AJEwpY9CuU+4niHmAEsIJ1QkQ4HLX/BEVOA2gJonJj8czYA84oaMDyl3Qedy4V8FWmQmw4mZrUAQVsjBkdQ+38JesvEi1cajL0v9zUKHccOQERs3BF9EEKcHancAA3drHKyfr79XZOpbbnn4OrG/YgglCk/84sW8snQ7CRKnNmAN4plYVtDkf5H8xmWQoA85TSycPE1hUFtffprGR2Uqqxsl0+/SaRulkepUmW+dGIKiSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMs+xrt9+k20FUg4sXBvJmVVC1Dhf1Gh7jQGK6WsOsk=;
 b=DNX8lNxCyfVdStWCXUGIfDBzyzZ1t96w3DAm58IJm7i2aR+7Q09qEUWpFY+55XdMsBYhtQBm1AFHJ7ODlkabZupMSjhBYRZ9CnmWA6SVJUMalasrJWPXt02VOxrPRBrWPqDsEFwKhPx7UGGqcLV/viJ9uO3oOEOygr6AvH4ZnZRMyhe9XFWTKAT6juQPoEHedAPbzjabWv6wiqiKBusT44cGcp8TTrrmRFDEfK185FyXtC7S1IWwsN+l9zWdlGuNSds3xc2B6nCkuOvzK/Kas/ax+tTz55ZIzlnsCA4pRIprSkpupp99vHCCSWqGxqARVo7Y7aEZISdRazYKHck8jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMs+xrt9+k20FUg4sXBvJmVVC1Dhf1Gh7jQGK6WsOsk=;
 b=NRb/X98jCNAmbZmkjOOwVG2I+vw+b2aUW4KkkaJlP9G9abG8OpTTzhUTZXq26BCH+A1yjmqC7F4WXGQu5Asvx2DJTS6XQwCK+NJnqVmNzrG8qdocD+QaoAfa81lzfNl4sfhEXCYKVW8kD/MZ/qZ2FDqoZLUqJcnTeBrOTr0C3ak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by LV8PR17MB7134.namprd17.prod.outlook.com (2603:10b6:408:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 15:34:57 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 15:34:56 +0000
Date: Wed, 24 Apr 2024 11:14:08 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>
Cc: Dan Williams <dan.j.williams@intel.com>, axboe@kernel.dk,
	John Groves <John@groves.net>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang.linux@gmail.com>
Subject: Re: [PATCH RFC 0/7] block: Introduce CBD (CXL Block Device)
Message-ID: <ZikhwAAIGFG0UU23@memverge.com>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <66288ac38b770_a96f294c6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ef34808b-d25d-c953-3407-aa833ad58e61@easystack.cn>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef34808b-d25d-c953-3407-aa833ad58e61@easystack.cn>
X-ClientProxiedBy: SJ0PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::26) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|LV8PR17MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f52e2f1-eebe-435d-5dfb-08dc647417ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUN1Z0lDZ2Rsc2lIWWNXN0RlTHNzak1yNUtLWU9VMjRaNEFldHZzSGdwZm1P?=
 =?utf-8?B?STJSQmRIdlZOVmRGd3hWYnlPWUdDaXhmQ1pKRnd3OTVHVzJiZWxqY29DQ2dM?=
 =?utf-8?B?M0puMmduK1Vqd0xEV0xyOEh2eGlYSmFIQVF3c1pHOUx0UzI4Tk9NQ240d3RC?=
 =?utf-8?B?TXFoZEVKazJrN1dnNnFZdFN6T3NMTjZHdmdDSnVpalZRNDlJVTRkanhZU0kx?=
 =?utf-8?B?c24yMDI3bHRUdlViblo5a0tLWXVTK3NxOVV6cnF0cVNHVmgzUlJoT3RVS0Yz?=
 =?utf-8?B?WnltY1dxTHFMam9lUEc3NzRaRGp4NUhhZC9pZmtlRW1idlVpdXJFUFU2ZjEv?=
 =?utf-8?B?S1VsTDhwOVU0bVNiUU5ZeEpFeUx0MXh0aTZjbHFvWTQ4VSt2aXlBYkYyL3Bp?=
 =?utf-8?B?UmtwdHZWa05nVmZ0Y0RDRXJGaW5UbzNia0JXZUVFWCsyYTl0NUN3c1pKZEkx?=
 =?utf-8?B?bEpYUEdFQ040SitSd0Y4Z2JLYlBJLy85L1NsU210Z0hYNXFoRktjUEFqeHJr?=
 =?utf-8?B?a2Y5NExhMGhJbEZWeE5vTmpBdGRUSCtxdGd2ZGo1UHhCK1FMbWxyTVZCNXFz?=
 =?utf-8?B?M0dtUXV5TUFsMWdGc2RXbEo1Ykh1Y0orVlJ6cXRpT3poYjNBOG85T1NJenhq?=
 =?utf-8?B?RVMzR2JLNGkvc00vVWFzZ0daQ0Vpck4wN3NWUTJHTkQ5OUpFalhiMkoxclZF?=
 =?utf-8?B?cFdnL3JOMTV2S3R0cWRYYk5KaS9ZTzJ1VzFCZlNBWk9wRTg3NTloSXhvWkRU?=
 =?utf-8?B?RGNvbC9ZQndLVFptajhmbnZLZG1ER3JpVUVhZ2c4eXptL1doMVNvN3hGME1G?=
 =?utf-8?B?VmNUSUJRWDNQY2g3VitxTDNuZVMzRyttaTBISm9pa3JWUWEvd21XN1ZFZ3dU?=
 =?utf-8?B?eFJUUEF1YVljNUdCQlZzRzdBbHZ2NTVHTFB6VFZlTGhaTHEzTWdXS0RRa3lK?=
 =?utf-8?B?S2NnaDl3cjUxWDZieXpCbHRybFVPUnI0YThWWGNSZ1hCUGNOekg0SVBoL21Y?=
 =?utf-8?B?bHowVkhiSFNodStRVktxUlpETG50UlF2WGJ3ZzdERTlBNDdlY205VXVzSjNz?=
 =?utf-8?B?cGx4N05WZDk2NlVPVVZBTEpBaGtobWV0aFNVTEFkTWVqL2RkRk5ua2tjTVhN?=
 =?utf-8?B?Nmw1bWsyaVdHM1lPNEJKV1FWbDhCVFlZLzB1b1hPdWhRamR1RFFETnU5YVgv?=
 =?utf-8?B?UEZWWEhMWmpKUUZPUldPZUNNQ05NSFd2SkZBMnNEeXplb28rRlQwa3VBVHdC?=
 =?utf-8?B?a3RVTS9oY1pMbDMwRmZ0Ylh2WTFxQkJMVU9zZ1lCbGtmaUNuREJKWEllQlZJ?=
 =?utf-8?B?eGZrdElFUU93VVZ0Q3JiMTNiVXZtcVEySjRxTnZuWXpqazR0OU5sb29yYXha?=
 =?utf-8?B?Tkc3UEdqeUNxM3lsZFM0T0IweHE0aXhhcUlIMC9TQlpRVzZoMGdGcjlOWU1X?=
 =?utf-8?B?SUZpcW5lN3RaenZEc2hMd2tlWFFxQU9md2h0Z0pBdUQweUwvT1c5ZEdPOEs3?=
 =?utf-8?B?anFEMHVFZHFvZ1BpbjlFT29mM1ZpcnViajUyaXNTbTFMcU9Db3F1M01pSzlx?=
 =?utf-8?B?N3ZKYzgrODFoZDBqcGVnaWRXNHJpdkVKZzQ4ODJOdWFZNjQ2WENYR203bC84?=
 =?utf-8?B?Y2k0TlFnVmxGRW1XbFFMTUFMeGRBb2hnNSs1VHVHR1RJdUt1bWtvZWxjL2Nt?=
 =?utf-8?B?UmlFRXdiMmpXTUVOMHRsaU1nZjl6VXc2MzJxVGJuWjJpWThtMlFRUWFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjYrVStXd0JDYzQ3d0ZZZFI4VDdzdjNackt4QnltcEt6L1p4Ny93VmRTQndz?=
 =?utf-8?B?SGtmUjI5dlRXWFVtY0FoYUt0K2dLMlJ4S1U0WWU5SjV6YnRkYTlRb0pHd2ts?=
 =?utf-8?B?V25DVUFGV0ZoWEJUbkdhc2Uxa29jdWM0RDgwT1RGWjcxSFpiRmhFaVUzWkYz?=
 =?utf-8?B?SEtUWTBNUUVnd043QkJRZVY1QXlSWHdHUEJoNjdGWGx4R3RvY0paeURpOURL?=
 =?utf-8?B?Tk4vN20vTDFVQ1F6ZXVtZGYxbmM2VHFoamNpZGorVDV6WktRQjNCcVQ2bW84?=
 =?utf-8?B?OWhkaHZvTncyL0dvT0ZVdERxcEtiSUdHZlpES2FqbHYzR3lSQ0JlRVppaXpJ?=
 =?utf-8?B?MEVXM0FGcU1nMnJ4VmdNSlA1YkFJNUIrYkFYQzJUcDlFRkU3OWdseWxVdzBz?=
 =?utf-8?B?V1NOSno3eTNCRktkNkh2TGNCZWVxYlI4Zmx5c0xjaFp1QlJScjR4Y3FWNCtV?=
 =?utf-8?B?aEVkWmRkVFBsWlZwQ1RGMXJ3OVRTUUZTKzl3VU1MaEYyd2FTdGVPSGxOQ0Nr?=
 =?utf-8?B?Qmt5Y3BuR2pTZERESGdmR0xSc2xUNlZ4U1FERWhiNHhqaVZ4SUd0UDBhcWl0?=
 =?utf-8?B?UHE0RE9kdjA3K25yNVJuQlVBdmFodTRleWFiQUhUOUVRVkJWVDlFdUU2VWtF?=
 =?utf-8?B?aGdaSmxZN1NHQXB4dnVUUGxod2FYb3NEa0RVRGhuOWVBNFpzTnkzd0wrRFdY?=
 =?utf-8?B?M3g2SUZrVUovZTlRdTBpeVU3V2FHYUhlTXcvQzZnNVNnblBuRXA5NnBMZUds?=
 =?utf-8?B?YjZiV0JVOGlnTXlTUUdyUG10M25PWmdCbUFYVjRjcVc2WHRwcUlVTUVxTEM1?=
 =?utf-8?B?RE5xa1JQTXJjTmdDaFc3dlMrRExoeUF3RTZhTWkwQXdxc2lzYUJyWVpEYzds?=
 =?utf-8?B?MUp4RFZFWkQ2dFh1dkw4Q1V3OGNYdWVvbzN0a3BZWVJuUzExRXl1SjlJbjhJ?=
 =?utf-8?B?VjdBbnFFMWd5cUNMZFNNNUVWbXpLbnY4blZMUEpTcXUwVEJMOG9JOXZWY2pD?=
 =?utf-8?B?VCtEaW9DWkg0ZzBzTXN3MC9UUlFweVJINVhGZXUzcithc1I5UG1RdzNla3da?=
 =?utf-8?B?cFJGWUFsVWZmUkZjaytJWTV4ZUVRNDNaV1FYYjJnZUlqUUZOWUFCekR6dDZk?=
 =?utf-8?B?dk1RdU96R0puVW5uZUFnZmc2UlY1N0dWdm0rclB2M1cvTHR5M2FNd3NKTlQ1?=
 =?utf-8?B?dkRFYjhHUzhiRHpybTI1blpDcmM2d2pVL2QrOHpWdGxsbjVvRkNXYVdsd2x6?=
 =?utf-8?B?ZlVXeHU3alJSTkZ0RmNIdmxaclg3Tm1BdGZBWm1oS2xDUWJ5Vm5FUGk1OWtD?=
 =?utf-8?B?UURwUHpISXptZkg4ekVCNHI5aUd3YnM3bnBCMmZlNjRiMWhsRVlwZVo1Mmlh?=
 =?utf-8?B?cjlKZkUzYnhWNjRsb0JPaXA2RWdUNDVqeWxya1ZzMmFtVzQvem1yU0gybld1?=
 =?utf-8?B?aDZ3cjN2SDdWeU1PY2xIcVdmc3F0d291ek5mL2NjdmlDTUtyWmMyMWhhdG8z?=
 =?utf-8?B?bXdLV0NaanRnTWNqU2ZDNG5SMUVWc2NIVDJkd2FGRUxiYzZvaFhKQVM5UG4w?=
 =?utf-8?B?Vit5UWJOa3kwcHJRbk5hNk9QSEdZN3hqUCtvazRjWTFQU2w1NkNldFUxT3p1?=
 =?utf-8?B?TDVMOUhtd0dlaDJxbXZSbXlFdzVnbGtJZys5TWJDZU9yTzh2dFk3VjRrK3Uy?=
 =?utf-8?B?bzVIa28rQURhVlZZZlBUYnZaUTVESTNVZzIwZUhVaW9wMzF4S2R0NnVNOUFs?=
 =?utf-8?B?TCt6WXNZL2kvckZqVStEam9pMkZ5MVZ4V2ljd1hqemVNWDl1Z1N0SVhQUWVK?=
 =?utf-8?B?VFovaGR5bjZhMmhrNXdzTkE5RGxzdjZNcGpySU1zNzBQMkU0b1JENXBFaDkz?=
 =?utf-8?B?Qnc5V1A4Z29JOUkya0p2MmdySXZyblQ4OEhFL2pYK0RTZlBRaGVXTTVsSnlX?=
 =?utf-8?B?emQwV004QWhDV3R4MlBZNHl2TWZ4bHRqWG9BMjk4L29xWkl3R1YzdFdRVGxs?=
 =?utf-8?B?MnVqU01rVk96bFhyQ2p5VG1QdGV4V0hCWmg0cTJKUElKZ0U4dWtIYTB2eFgr?=
 =?utf-8?B?YzVnYmptTjl2Q0pWcTdnRk1KdGJCUnEwcEJFUHRocWVHTkhNQXBLMElpRGV0?=
 =?utf-8?B?R0RWOVlDZndvb084YWVuSk5wY3VwVTJadVAwbEtXT08rSklRcTRYQmQ5aXI1?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f52e2f1-eebe-435d-5dfb-08dc647417ef
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:34:56.2458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkE5orBfS7zeH+MPgYVjmkVh35jJRbiIqTw7+BB6szvUogMXNayDyMha5AIV6rSYzuUumrAE1Mhd2IgpIjkUnCZdpts3k3n7rxy6pHzjGXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR17MB7134

On Wed, Apr 24, 2024 at 02:33:28PM +0800, Dongsheng Yang wrote:
> 
> 
> 在 2024/4/24 星期三 下午 12:29, Dan Williams 写道:
> > Dongsheng Yang wrote:
> > > From: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
> > > 
> > > Hi all,
> > > 	This patchset introduce cbd (CXL block device). It's based on linux 6.8, and available at:
> > > 	https://github.com/DataTravelGuide/linux
> > > 
> > [..]
> > > (4) dax is not supported yet:
> > > 	same with famfs, dax device is not supported here, because dax device does not support
> > > dev_dax_iomap so far. Once dev_dax_iomap is supported, CBD can easily support DAX mode.
> > 
> > I am glad that famfs is mentioned here, it demonstrates you know about
> > it. However, unfortunately this cover letter does not offer any analysis
> > of *why* the Linux project should consider this additional approach to
> > the inter-host shared-memory enabling problem.
> > 
> > To be clear I am neutral at best on some of the initiatives around CXL
> > memory sharing vs pooling, but famfs at least jettisons block-devices
> > and gets closer to a purpose-built memory semantic.
> > 
> > So my primary question is why would Linux need both famfs and cbd? I am
> > sure famfs would love feedback and help vs developing competing efforts.
> 
> Hi,
> 	Thanks for your reply, IIUC about FAMfs, the data in famfs is stored in
> shared memory, and related nodes can share the data inside this file system;
> whereas cbd does not store data in shared memory, it uses shared memory as a
> channel for data transmission, and the actual data is stored in the backend
> block device of remote nodes. In cbd, shared memory works more like network
> to connect different hosts.
>

Couldn't you basically just allocate a file for use as a uni-directional
buffer on top of FAMFS and achieve the same thing without the need for
additional kernel support? Similar in a sense to allocating a file on
network storage and pinging the remote host when it's ready (except now
it's fast!)

(The point here is not "FAMFS is better" or "CBD is better", simply
trying to identify the function that will ultimately dictate the form).

~Gregory

