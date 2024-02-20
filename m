Return-Path: <linux-kernel+bounces-72201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9685285B0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239D31F21BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097133A8FA;
	Tue, 20 Feb 2024 02:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="JKWFTqeB"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8622C11CA1
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708394967; cv=fail; b=mO5WHePBfpGOzBuNgmyPz+y1TJcZsFMCIKFP2+O0zANBtEcWuTZFEhoJUtU0hvrY2sTnhlAmEelVmDdONjzz/AFoITZ7PACEKxeXTd3XAnA+SaziIQtglE0cTQgAADpRk7x4N7tZrVLDtXthmQ0REhRsU5/oy0LJMlDR/pHAJ6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708394967; c=relaxed/simple;
	bh=PTWU9m/PUQLZHOl6tSbl0VTqodkRp+9SKQrLjiFU7Mg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=euyW0c/OWc0+CPH6/tM6m5bFZtTQ2L/nDvgicNL6flgTAXd+UIHkystbUptwHSwjOBwPPYU5D/iODMLwU2cNclv5RIl83nV1nbMYEqAe+9XBLKmMmAdsFie/TfBzlD637iVUdO/a2xnPAKmCduE+lgUG2VunrET7rhCOjLdu9pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=JKWFTqeB; arc=fail smtp.client-ip=40.107.117.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/b7WJrX9Gmpm0XnUY278hkjrsrphJRWqiAHE+5n74R2sVEpJA+khvtIgSOZ96gA52nttH0Kjcsriq05R1MYoaNft/fnYSuqkjbAUx9HDW+zOLxQMptSfhFfF6y0RS+uKOypY/ecOiNO4F/U7EC7oEkazMPIAjr4XTGmSW9Dh6wC6wWkWRYjAPDM1j3jBBFVCVOAVbbm0+lffdwmsoZqmxGa8W7V9D5aEqiIJYhokQ27xw21IEn8DGlOgMsuHQcuR+mV6Ru8eGlKyAO1x4L+X56EsHNXRkyxHyapSeRl3nOhHYJTZCVmNDDjtUtrvfLJxCHtfaSWNm2mRYiA4ZHVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrFvPqeH7fgLvxn6lsI8imWZpHD8plWdr3ueLVCvPHA=;
 b=XcJ1NmovGWS75yURc3/0TGh2e5x8bbaB4NX/D+/sevD4spGYbOtctDY5mEwp1snFB1N7ogLGwg73BsVjkzcVMxwHR5ocR/4/t6TiVPGM1GdJmAFFNnH1SGPYe3u7VuorMfXxuSN/ZCUuKxchsXC2I/sldF3dn4dSyW2ibx8wB1ZCCoUpArk/eWy5vDQGlVBcbJ9ibNOUQT/GpqqlEuqBaFl3KbVPXlvR4kBw7gpecdOZULZVtcxvcIJ+LLgY3I/0DCQZNDVkSSNJGiUvHnqZYj8aql2imBolMqkNOgHeTqqQI4KGfESx9CLEWHHgYC7mM5JjD4ZHA/T6lAZAf9bjbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrFvPqeH7fgLvxn6lsI8imWZpHD8plWdr3ueLVCvPHA=;
 b=JKWFTqeB7r2Q7k79MoEPHmxV9t8vj7xAtIO7j0BWVGeJvZ412xbAjPr4PfIknTjsst4wNBsghC1ByOlAQPTKMeUpSDLcnlLGl099TU3FslpIEt0WcyhaKfgdTklqZRwC5ebdoLb7ueJ84LLytYa8pfOhdMCdIlbDET9WA+hblSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5612.apcprd02.prod.outlook.com (2603:1096:4:1ab::12)
 by TYZPR02MB7682.apcprd02.prod.outlook.com (2603:1096:405:4c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 02:09:21 +0000
Received: from SI2PR02MB5612.apcprd02.prod.outlook.com
 ([fe80::5002:785e:e85c:37b8]) by SI2PR02MB5612.apcprd02.prod.outlook.com
 ([fe80::5002:785e:e85c:37b8%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 02:09:21 +0000
Message-ID: <2e4d50aa-7531-7e36-d999-8eb9b5bf3c7c@oppo.com>
Date: Tue, 20 Feb 2024 10:09:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] Support kshrinkd
To: akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de,
 Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, tkjos@google.com,
 gregkh@google.com, v-songbaohua@oppo.com, v-songbaohua@oppo.com
References: <20240219141703.3851-1-lipeifeng@oppo.com>
From: =?UTF-8?B?5p2O5Z+56ZSL?= <lipeifeng@oppo.com>
In-Reply-To: <20240219141703.3851-1-lipeifeng@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0322.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::11) To SI2PR02MB5612.apcprd02.prod.outlook.com
 (2603:1096:4:1ab::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB5612:EE_|TYZPR02MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: a2eade61-a839-4f20-662b-08dc31b8f3d9
X-LD-Processed: f1905eb1-c353-41c5-9516-62b4a54b5ee6,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hjnzh6BQ1ijY2A35D+0mEucmyP/cDDa2VBDGWkZeOh+8qOWoXzZRCsxgt0lbpAhTSpy8YYgKT+BWES3fMK57uw/IwpEDPJzN2Ba4ZPkukSzdSkJDGWoUfPKcuLARCsb47DaglcvVZh3n/tztSZ5q2LkaPyp30tjCnWZLLTcK40glLQ/vgt8MAm3UFgtVJsjCENWKiEIA8BB8RYO6dPc74hYRdAQUAyAXyQ2+2Z2JxrkL6BF47bAxNaBQmx+yTWsWODWjuGlAy8XFL7Ci+vk/k4/V8ib/7gq/fqMVHQQyumsxRw2eqhHtoeX6NiXD0m0WD9T3/jNPR4gAJFZkO+/Ap9BTOYUCmNld7C37Y32WXqUFMIoJ8J/2xdAHJHDP8YrMLVegRoj4HdDSEptSsCFLLoHDefs0s8NdsDCra/sW6Naxj6SSdo+wNFufGlcLL051V/CXyEscKPwbY4iok21XyTC8/CDuLnvnj8sGIUIJR+1TS8iG0g4tMWHDdQvTyLsTkAEPjCe1IijkO4mSC6l8r3HCA3l2HAw6queyObZMwKA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5612.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjRFTVpMVUcvN0o4d3lBNlRpcm5LbXF5aEt2dkJIb1JyOHJCTlNDMTNMKzZJ?=
 =?utf-8?B?dWZYeG9qc01jZzRKODlEOVFBWEt2dk5xemxMaEJEK2h5Q2xFb1VCc2VMY1J5?=
 =?utf-8?B?WUwwV3NPWWVhWlVzNTF1QVhxSVpQazRVeDduRDJVVURWdXEwa2I0RVpLSTY4?=
 =?utf-8?B?Yy9sUk9nZnBVZjFmeEJ3RTJDYTltY1RBMEltSkplclJ1cmRXSk1VQmdjYm1u?=
 =?utf-8?B?MktQSVRIeE5LVm5QbC9DZ0x0cXZhTWhIMmNiQ2FjejJEUi9VZ2FtK1VTNmNL?=
 =?utf-8?B?R0NHU2cwOEVGU1VWS2RqaEMxbTErWmp6NDNxTFhCdnl1ZmQySGtPd2h1aDl2?=
 =?utf-8?B?QWQ4RFI0U2QvNmlFS3AwUHJmMkNTTVNUNDlnM00rVnViSzYwcFAzN0s3aWdZ?=
 =?utf-8?B?TjM1eHFPNWp2cjIycVR1MjFldW5iU0hKb0NZU0JGdFduZlRzTUoxaE9Sb1pj?=
 =?utf-8?B?RktOQzdmbHhJZ3pHNVNCUXhNdGo5N1hxNHNnZGFLamJjQ2tCb2FXRTJyakt2?=
 =?utf-8?B?YklhOFlKL2Z0bUd4VlphK2xwL0NMajRZSE90ajg5WWF5TjNrQUFZUzV3TWhP?=
 =?utf-8?B?amVUZWhETW5IV3JJUEk4bHV4ZTduMDNQZ0hSUGpTUDlGYm83RGV6NFRiQ1Bj?=
 =?utf-8?B?dmxLTFo2Z3ErTkRXVEt4Y3hsTFJDTmtxRWtXWmpBUkdVaHg5OGtyRFJ0MHVt?=
 =?utf-8?B?UTdJOE1iY0lrYmxEc3N1WWZZdTlnSEpFY2hDbDJ3eFdxakFXNlJGMGp6VHJj?=
 =?utf-8?B?OXJ5S2hxdlJJOUJDMnh1Smh4Q1JJWjV3QlAwbXJ1ekJnRHEzQ0JOZk1YTWVJ?=
 =?utf-8?B?N3pzOTVsU3VhY2E1M0w2QkNYVUErYi9vTEdscGR5SXE3Sk8wbmV0Y0hzUExj?=
 =?utf-8?B?VDhMQTBTeVFlUENaRnJ6RnNtUnViTWQ1Yk5Da2VHTFlkNXkza0UwdFQ5aGxG?=
 =?utf-8?B?aUg1b053OVhrOFFGd05maGlRbVIxZ3RQY2ViQm9RTGlQeDlWSnRyZnJXL2Iw?=
 =?utf-8?B?Tys1cnFkaFNDaExSWkI2a1VoVSsydEpXaU9DZE9RVS8yZXFRamRnbEJac2hX?=
 =?utf-8?B?RGxJM3BhSHpMZTBibnJoOURUaDlFVVZjRkhqTnJrZE9oVmF6aFpub3Qwa3Nx?=
 =?utf-8?B?UHptY1lqU0hER2M1WFlIakxQRy9SNFhpSGJ3NDFlbTJLUGwzVVkyV09WT3Z2?=
 =?utf-8?B?TjVXamZYelQ3VWQrMmFORnZWK2p4YXkwSmJMQklFNDZuU1FBVXZJd0g4QVRU?=
 =?utf-8?B?ZnRGNFB0TUFSZzR5dnQvWlp3NUcvUVlGb3VybHlya1oralNHb241VEZ6L2Ft?=
 =?utf-8?B?Yk1XbW9qeEZNZWREL1dmRnd6U0txUzRaWWw0L2lJay9rZG56M2V3OHdkYWN5?=
 =?utf-8?B?VnJrRDRpclJwb3pXc0NrUEJ4TmU5K0RGYTRhMDAxV2o1cVIyRmFHbDlINzB6?=
 =?utf-8?B?VmNjVEZtSHRoa29Rd2VDL1FpLzBrVFpSeDN3eXlxUzJ0dmY2aHFRNGZKdlNI?=
 =?utf-8?B?M0RpMktldDNadnBXdmpNTlpuNm4vK2I0eWJOM1JyekRZcit0VTQ1bXB0ME5O?=
 =?utf-8?B?dWZJOEpQb3BvZWE4YjRzY0xUcHcwcENPd3piWmxISzhaei9XUWlKUjIzZ1NJ?=
 =?utf-8?B?a0VuWG5QdHNuTU5ha0xseG5RV0ZZellHcG1EL0FpWWthNjM5Umh0Qjd2cnhB?=
 =?utf-8?B?b3M5Nnl3bmpuTTY2cXRncHN6R2IyZ1hBdXpZaysxMkNHcUdXenlxRmVFVnpk?=
 =?utf-8?B?Qmo3eXR2MGx6Z2VHS2Q2MnVOLzdoRXV2Yzg3Wjdqa2NjQm9nRUl6ZzQxVkRP?=
 =?utf-8?B?VFp5anZKK2x1UzVUQ1cxQ1dvTU5rdzg1WDdXalJMSzdlZnlsUXRYVmZLcFp5?=
 =?utf-8?B?SXZ5UTFCd3piN0x2SGpJZTJxWStFWkw1Zk84L0RaSHkwREpYSHI1REJpLzRm?=
 =?utf-8?B?L1VXa1o5RkVLTU9aMFF2TWErc2RjNmtyQkRvUXBmRFk0SXZrM0duc2dyMEpO?=
 =?utf-8?B?Y2hCM1kyS1B2SkpadDA4TitjakdTVDN6SzZTOEwzSG8xY1ZMaGdyMW9kYk84?=
 =?utf-8?B?K1pOMHRNb2Z6WEIwZFpBY1p6cU1ad3hQTDBXcHNjNmJSS3Urb05tV1h3SlNt?=
 =?utf-8?B?UC9GYXVXb25GWm9sWnV2MHdaUE4yL0s5WGxOTFk3V1VMNG9iQk1uZTNENk1T?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2eade61-a839-4f20-662b-08dc31b8f3d9
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5612.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 02:09:21.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qakao/QwWPmuy09yE1URKdTyUSDz6tXrSiBYmJ0hK9fL/oRuaXSbDy9hRgeeBcBthYDIb6BpvCN3JwjcCXtHGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7682

add experts from Linux and Google.


在 2024/2/19 22:17, lipeifeng@oppo.com 写道:
> From: lipeifeng <lipeifeng@oppo.com>
>
> 'commit 6d4675e60135 ("mm: don't be stuck to rmap lock on reclaim path")'
> The above patch would avoid reclaim path to stuck rmap lock.
> But it would cause some folios in LRU not sorted by aging because
> the contended-folios in rmap_walk would be putbacked to the head of LRU
> during shrink_folio_list even if the folios are very cold.
>
> The patchset setups new kthread:kshrinkd to reclaim the contended-folio
> in rmap_walk when shrink_folio_list, to avoid to break the rules of LRU.
>
> lipeifeng (2):
>    mm/rmap: support folio_referenced to control if try_lock in rmap_walk
>    mm: support kshrinkd
>
>   include/linux/mmzone.h        |   6 ++
>   include/linux/rmap.h          |   5 +-
>   include/linux/swap.h          |   3 +
>   include/linux/vm_event_item.h |   2 +
>   mm/memory_hotplug.c           |   2 +
>   mm/rmap.c                     |   5 +-
>   mm/vmscan.c                   | 205 ++++++++++++++++++++++++++++++++++++++++--
>   mm/vmstat.c                   |   2 +
>   8 files changed, 221 insertions(+), 9 deletions(-)
>

