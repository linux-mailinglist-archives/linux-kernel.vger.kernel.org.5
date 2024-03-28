Return-Path: <linux-kernel+bounces-123831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E12890E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E811C2591D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD851386A4;
	Thu, 28 Mar 2024 23:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="FJUk3OOU"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2093.outbound.protection.outlook.com [40.107.92.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA5231A89;
	Thu, 28 Mar 2024 23:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711669193; cv=fail; b=K5wG8LY6Cbvfv3LV3y/TnjM7x6e/o0lSxHNQwkzwTrG4nYTMPzVEOSRmzPFsA2WjDVKgJzOy8iY4AMkunAFbScNtFIoWchRtrZ5hkne/pgxtGQNN6t+1lLf1pSSND8g7cA86+zYaFKgBxYKfy817cH58GqiDDlem1Dr1fSAX9bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711669193; c=relaxed/simple;
	bh=nHf7h5Z5teGy2pUM3vNLJDX6rtRYpBzolpwMWuNakCs=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cDrbWfDmEx/R6n1nswfKeMJo07i1tjnmLva8SeQmF4lzBXXzptd34aSQwuHreyx/SyNoSZFg/OAdDJOAYIafItOyZgOE2om3skYAjSf0aWPlVD+pO32ZjowsgVQu3pNzP9dtjq+4M5JFPcYchV9f4smR2iX37TPzTJE/QZWIBME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=FJUk3OOU; arc=fail smtp.client-ip=40.107.92.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gc6obCeHyFD/iWGwYnW6cM2pV+BnUXjoXPQ4tQNipK0WhnusbOwh66b0YdWFlG4gNvKW12Z1da7fXr0JqoIrQqMJ6zpUrYFUnvV/Vwia4W/k2QuRQ8iAe7RMzlHLVCoyclPZhbjoYI8UZTIVbIlwWLZLFShm3A7NUli2QrKmoqx9+4usy0s6m6q9ZKuMAFeq22A0TE1z99peJmI2Ft2BqBK2X5ZqIGxhqK+42Jm2v0IT9jIGaCtjwVNy+966qmLqsBPtfFlSS85wxJ03pgM9dTcSn3AEAVj9ZMzJi+8bTM0gowrT8UDQeIbSyQ8rctJbSgqt/PAUprqus3la/kaUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKo5hnhswaXSkcMDlFaJkiG7TFqG7scMK9fwUsx5K34=;
 b=VrVZBnyEAHKTlgYUPft2RSz1Wlg+DLCnxs95gRmrVJPEx44byreQ3eJsDzRMSPxZJLyoyoA+qbYasjeeB1+V6kC0t9Ey2B6Uv3J5nj6nF4yLdQk1HLhRJBbuK0xKYMrmGOJ745xtS3qbSWBcQX6C566pZEM0W/CM1iM9pnN3O5HHdTehAM8ZZH5QOI+kPqAxnlKgforLARO8keC40foPJVvzDmJ6MMfo0dXnYONkJp7enmV7LPN5N9SAad26PIdESbFUiKOWCjd3A0iONrAqLPMVtGwB4E9B4FI+7aAbg6gyYsvMM+to5mUDt4kSVXx1IouonW+K1BDUrN+OFOY68w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKo5hnhswaXSkcMDlFaJkiG7TFqG7scMK9fwUsx5K34=;
 b=FJUk3OOUuM6jLop/Est6TDKIBMuNQXry46Q7QTCnU9s/TQgnsSXtHvO8IVJDx3Ujocsb0up9ThoRWUugs3DfCb2WqOF+C1qFoQGMUHevpofbBDmJ+4hD2MLvpOHBqGtDWzo/uR+iLY0sfd1W0OOpk+vKNTDqF47QPO9ViAG4czE=
Received: from CO1PR01MB7370.prod.exchangelabs.com (2603:10b6:303:159::16) by
 SJ0PR01MB6400.prod.exchangelabs.com (2603:10b6:a03:2a2::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.40; Thu, 28 Mar 2024 23:39:49 +0000
Received: from CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::994c:4200:8a4b:6882]) by CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::994c:4200:8a4b:6882%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 23:39:49 +0000
Message-ID: <0309f5f9-9a95-485c-a442-e9fba603d676@os.amperecomputing.com>
Date: Thu, 28 Mar 2024 16:39:44 -0700
User-Agent: Mozilla Thunderbird
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: Re: [RFC PATCH v7 00/12] memory: scrub: introduce subsystem +
 CXL/ACPI-RAS2 drivers
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, dan.j.williams@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 david@redhat.com, Vilas.Sridharan@amd.com, leo.duran@amd.com,
 Yazen.Ghannam@amd.com, rientjes@google.com, jiaqiyan@google.com,
 tony.luck@intel.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
 rafael@kernel.org, lenb@kernel.org, naoya.horiguchi@nec.com,
 james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
 erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
 mike.malvestuto@intel.com, gthelen@google.com,
 wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
 tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com, linuxarm@huawei.com,
 wbs@os.amperecomputing.com
References: <20240223143723.1574-1-shiju.jose@huawei.com>
Content-Language: en-US
In-Reply-To: <20240223143723.1574-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:610:cc::13) To CO1PR01MB7370.prod.exchangelabs.com
 (2603:10b6:303:159::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR01MB7370:EE_|SJ0PR01MB6400:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oY/cTr1Y2ZBzYKzf89VaHlzZuaTuAGGhn6XFXT2P91vhzriciD7xeSqUhUj+AaFw/Bx9ALrbriw9TCccyJSaG9u15q7tst1JZimcl4QG4zfm9qlmAgYgL/gr7gMbLIAT3ZZnagoFg3Hal2Vnkm1LIFu5Fw0l6lrCGau3Q/oREqA/sZYh507qWuHCy+EJeB/IMyZ8sf+XTDD1d7N9YPq/O3ISnZUO/O4t4vvqAhZcPa26gZqEjwLJUaLm2mt2Xvt7j9K/e7YberaOJ/fchDe3n0zcsJT8iOWq258p8fiFTdC7wDspfoUxs21spJkiAeM3HgKQhEtWjl8zZsDO6Ou0riF2hfMFyWX0rmJTIVL4Bivkexhzj3dmLFubCS7xKx9qG6nVI4Si3Gq7PfPok0TjmHPXKvV7pv5lbcTokF5cceQug4yijgSMhVQhudMKi3PPwruI6eo3QImqczD1UBUV+eGCe9Wz3SmIHbxNkoCuRD9Mhy4QkqoaBikqZ+1f35iW5cUyXiGQ13oLMq+FvtByq0tD1EqG0zE7CiUXQVR1nuwfKxQiRx6mRSGydHAI3J6gMVqBzwCN5qicR3Jx5sgVG+acRyJ+Vt80kfSamoiO0kx5xm/YGITmyXYRd4tsnn4MsKX8uytQw+3BQN5hlRH2PoOnyjrcex4WlWXD5IQPxARRYv1nUhHJgB45bAohL2oaBH8UXluRslQO60Bd3rKbaQxDiDgbIRiNQQNvyQ12Aa0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR01MB7370.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDFKK2lqbCtXYTI0N1l2Z2ZlUnhNemJOZjNxOE91LzBUcFU2VkVwNkRPN2gv?=
 =?utf-8?B?aTQxUlZOYm00RE85OGRpV2J1blg5Uk02VnJUYm5hSkllUzBnYWZVSnBaUlV3?=
 =?utf-8?B?aEVHTGRYd3oydER4bFpKYWtDNjdJM1pLNnFVNGpMNzdOSzBzSytHcmw4K0p6?=
 =?utf-8?B?cTFGSmNDaVdncm1PNzFUNW9xRFg5SldUOFpEMDlVS3dCVkNKWlBoRWdVRlZ0?=
 =?utf-8?B?azEvSnlWMHJPNkpUVGxzOCtsQ0gwZDBvWGlHdXRYemxYZ29DUWFpUHhuK1V2?=
 =?utf-8?B?eE5pbEtzRERpc0dkOTVKeUFoU3RJK2o3Y2FidTJXOFhYbHUxUmtaQ1Rmc3Vl?=
 =?utf-8?B?NGZoVTFkbmdqTnFwcXExVHZ1ckplOTh3bFFYYmVRakdHa09DM2k4MXdtWG8z?=
 =?utf-8?B?aGRlaEhtRy9oTkszTWhSMzJmUkRJN0FDTWkrVnZhN3BEU013UitrWW9HUlRT?=
 =?utf-8?B?TTczZFROUGtvNEoyY3QyVDNBMVk4OEUxWVE2Y1owZng2Q1NZcjEvQ3JLbFBt?=
 =?utf-8?B?VVZHeTVKVGFZc1cwbmFFYk5tR1E2aGVhVW1NQTNLdWltYVV2WDRwNWlHczRH?=
 =?utf-8?B?QmVZUVhaMXMzNm5zOCtnVkR3Q2hxV2R4NFM2enJYb09MZ2t5MStiZ0M4ZUY3?=
 =?utf-8?B?K0JERHlSYUdrSDZyL0ZwUjVCb1g4bjIveTBLWFhRdlhwT3RoVm9iOU9rQ1NF?=
 =?utf-8?B?NDVoUG9nWGhIYUdEUEtzd2tmNjExbXhVc05QLzN4cFl6S2QvaVdVekVUajNX?=
 =?utf-8?B?Z2RQNHVLenlWbmJ1bGprTDliUTdaMGtUOGJFU0l3UDVQR05FSlZKY3E1bjJv?=
 =?utf-8?B?ZzUyZFVyOWRRSXAwUTZIWjM3K2cyNlZnanlFQnFNaWtVbEdIb1BBa29NSkVJ?=
 =?utf-8?B?cXB0NzJlZWUrVDQ0NzYwczI2TWw5RFltbmszMnE5WkVFTjZZNnRNN3ZsNWc5?=
 =?utf-8?B?aGU0Vmg4UTBYaStYVWNXSlJFZnZaMUU3S29BTENRS3dxUnVCK1FhdVZRMWUw?=
 =?utf-8?B?NEswOTl4K05UaDlVK0pkUDJnaEpaV1pGdlgxVHNXVHRQbko1RkpFL0NENWhR?=
 =?utf-8?B?QnFjQWtsaDhwN243dThRKzkrYlJoMTc2QVd1dUJFZmxHd2o0cnlUV25kL2dl?=
 =?utf-8?B?ZFBrNHhEUHNTNG02Ty9HWll6c2t0MWozejU5bFo0bGNPbEFKMWE0dFJWRlZJ?=
 =?utf-8?B?ZVNCby82QmVBdVZVUzRxdXhsbmxSVVZreC95ZWl6SWxocWZSYjgxQjVPQnVv?=
 =?utf-8?B?ZXhmWThrMnJic3FYaHQzY0RhVFNod3g0UUxrWmtRNVd0dlAyeTEzUnd1UEgx?=
 =?utf-8?B?d0N6Ny9tU25TNXNnTlJqSDdZaDhGRU9sU0pXZ3NabVo1RkIwN0p5ZXRFNDZ6?=
 =?utf-8?B?NURPU3FLWXphVmVwd0ZkeTdCK2FNajVHeERUdHNlNnp4bTdvdHpRdmZhcjVD?=
 =?utf-8?B?d1pUQVArMjNWMjNmWW5oM28rTklrOWs1NG5POEQ1aUVhT2xwZUtnU0JNdGxQ?=
 =?utf-8?B?dDJ2dU9HZURSSS9aUit4Uzh1UHl6b1pQa2gwUzJrRSswNHVCTVBxcnZGbjRi?=
 =?utf-8?B?RG4ybUVZTGNCWU5mdVdCUUFCVWNoUGJKKzhFb1ZtanhwOTdJcGpxRVRUVVV2?=
 =?utf-8?B?S0lpSTNvdFloV1ZnSW5EQ2RKczN1RzJ3ZHVxdExUdU15SkF0R1pkZ21neUIv?=
 =?utf-8?B?YnM1alhPcXRsbmRmUFlqMXRCRUJIa1dReExHSEhySWVpR2VCRDlaYUZrcDVT?=
 =?utf-8?B?OHFNWEZuTmlqUlI0N1BJZXFLcXZIOXRrQUl0ZXpwdzdwY3d1dVdIdGxvY0ZJ?=
 =?utf-8?B?cmlnNkRnQVpRNmVFRjZXUGUwQ1YxQkw5bDhVR3d2SFFoUC9uY3ZzWm1oT2FY?=
 =?utf-8?B?TFJhZzkwUStoQ2JoczVWNnpzd0JMUWMydzJ0enFES1VrVjZnUEZqK3FTK2x1?=
 =?utf-8?B?Y3NLa2M5N3dJa0lGOEhaZDMwVXdtUnFGUjllRTZKRS9PNTZOa0kycGsrOXpO?=
 =?utf-8?B?V2xMTm1jalYxb2N6TXJkSExmWVJuNkh0Tks5Q0liWFlSWnAxdlZ6ekJya3RP?=
 =?utf-8?B?OGZPbFRXZU5DTDFqVXFzVHRRUGlGL2xZdmh6UGdJYkZ5blJyNkJ4S3RjR0Vm?=
 =?utf-8?B?UjFROVM4QmpzSzJsQkdSN25tdWx2emdyU1JKY3o0Ky9TZW13Q2hRYzMxeHV5?=
 =?utf-8?Q?jkK9cBixD2L39SRuKsnVQHg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5788c87-846e-4c83-521c-08dc4f805b6c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR01MB7370.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 23:39:49.1017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fJ2w6/Rxzljqz1bm3XokxkbhadSOdxlRVzQrfCVzxHd6R7fy9xrjiwTe+VVKC0mEO5ZCzVBdvbiTt2wnRAGXOR+fdH2GRnsYUtDlSoW29T7tUBnviWW3LaP/nQZ5A8N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6400

> RAS2 HW based memory patrol scrub needs RAS2 PCC interfaces
> and ACPI RAS2 driver for communication b/w kernel and firmware.
> ACPI RAS2 Driver adds platform device, for each memory feature,
> which binds to the RAS2 memory driver.
> Memory RAS2 driver registers with the memory scrub subsystem to
> expose the RAS2 scrub controls to the user.

Hi Shiju,
Thanks for this work. This has been very useful for us, as we've
been using it to test a RAS2 implementation here at Ampere
Computing.

In general, the pieces implementing RAS2 are useful and functional. We did,
however, encounter a few places where we had to make some bug fixes.
I'll reply to specific patches with changes I can recommend. Also, there are
a few implementation choices that I will have questions about.

Here is an outline containing the generalized comments I plan on making
within/near relevant patches:
1) Found a bug in ras2.c in how the pcc_desc_list pointer is incremented.
2) Executing a RAS2 command seems unnecessary for feature detection.
specifically, in the functions ras2_is_patrol_scrub_support() and 
ras2_get_patrol_scrub_params()
3) Consider adding more error detection/reporting in ras2_check_pcc_chan()
4) Concerns with multiple scrub devices attempting to map the same PCC 
channel.

-Daniel














