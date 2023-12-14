Return-Path: <linux-kernel+bounces-93-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4AB813C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1F22836F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448FC347A1;
	Thu, 14 Dec 2023 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UEK+BOrm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qdovz99I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BB56E589
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEIDp6l031500;
	Thu, 14 Dec 2023 20:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=5VpihmVjGrWqeEqRwj9wFsG0veWnGaa9fxLNdTccHuw=;
 b=UEK+BOrmaBCrtPaSdBXSiGE96Hku2F/NUwhs/pr1O82/gpPTWQV7DdYN0PAFyXmOqIly
 RzTGWjYY3qF+mhTG7U+r9kyi7VNcC2LfTC0EGdjmXxgn1IKGDt6SSzyoCi0gKBj1ub0z
 cXyRw2y9lgD8NivLTzWUo6kMlovPCD66ZprOahJGIf2VHuaDO29JfR7BS79Ezjp7PxSY
 3Y4tCecoV9ZFOq/T9HGFQ6BKAfHM7W5JPSsq6oalzgzvZqmnN+6J8Se2W+e1Hsv8VwL6
 XGSdI4IGZf5mNNv8aJx4OGz3ldgl3igewL0HpMCB5qy1iEakLerGsQOOs5gLQQK37mvx sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9dbycf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 20:51:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEJBctO003152;
	Thu, 14 Dec 2023 20:51:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uveparc1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 20:51:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/4M+8JjF1HltrhafmmCng2B4ddfpvdEyfitzV03D0l2NbLKRQfUDKzG/5JoBHkhdyPz1z19dOrAzjUa1ib+z91ByN8x/KFSqpcU4T2b/c7+YVxxN/LK/YWduZWV0qM0H4KxGkxRaEV/eHuXRsu9zfZXxJwF0ovDOTUynKz7hj0WpytB3NvUg5DkNH3iSv2diWzF9mOU5wfnPQCeputIqL8YxkXa74Z0dDCBbIiRsIY5y6mlUIQX7DO5CYR3yTNnHoTZGnb5Jw1/2SGTox4v90Qj8OFu7do+KyqE7zHchGzUT29hWWiDqdKNuCqQCG1woS0p+IIOzjyMjjyPI7WUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VpihmVjGrWqeEqRwj9wFsG0veWnGaa9fxLNdTccHuw=;
 b=SuH+Shh7uZL/a8TMDnUFvpZBjIXQEjmps/fTIeHYEy5lLNpWhH5WKNzTlJ8Ws2BeMTqOBny+REPb2c3td+vYpceegCq2feSjSd8yEBTdTLL8QzvBDAvbMmXIQoYidK2041EhZVUb6ID+p7mU11UuBTFAX/mZLDUmL0MohY7GTPZbgYi8sMvg5V02pnEWes7jRkCKhYjQ17uGh6MqT+iyD6r8PKtpETgOcZWTJtViChFNvUKnzamJhy7cEqMATq1qriWkAGIoxp7z4s2STNOaXbw2pSX1sPeB+mtTxVwGso1MbW5mndha6b9SwBrwGYIr9MXGGRD3H6HTWDTwYfnnNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VpihmVjGrWqeEqRwj9wFsG0veWnGaa9fxLNdTccHuw=;
 b=Qdovz99I+5/t2j2sXXjQPcm9xws0A17ypt+mdz29Je3FfFAaH4zccPYsFGKM8JeyHxATjOFU5Br0pgTw9irpxuZ11q6OzhwW9ItIuOuT7gsLRmXDD9gxwgik5lLy6NfAVW7DiL+tqtu2aX+CTvmOL4A0lzvFye7r0MEOV/IHH8M=
Received: from DM6PR10MB3564.namprd10.prod.outlook.com (2603:10b6:5:17b::26)
 by SJ0PR10MB4414.namprd10.prod.outlook.com (2603:10b6:a03:2d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 20:51:48 +0000
Received: from DM6PR10MB3564.namprd10.prod.outlook.com
 ([fe80::8eed:6b59:2786:1ac2]) by DM6PR10MB3564.namprd10.prod.outlook.com
 ([fe80::8eed:6b59:2786:1ac2%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 20:51:47 +0000
Message-ID: <6bf0d9c3-23dd-4ab8-b96d-cbab9eeba190@oracle.com>
Date: Thu, 14 Dec 2023 12:51:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: remove redundant lru_add_drain() prior to unmapping
 pages
Content-Language: en-US
To: Tim Chen <tim.c.chen@linux.intel.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20231213072805.74201-1-jianfeng.w.wang@oracle.com>
 <3c7d9b8878220571cb7e0760c3a463951252b762.camel@linux.intel.com>
 <d9284139-e32e-493c-86ea-77130b503a77@oracle.com>
 <962b75502b6456a8b698a4ca89d6deedec118ef6.camel@linux.intel.com>
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
In-Reply-To: <962b75502b6456a8b698a4ca89d6deedec118ef6.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:208:36e::26) To DM6PR10MB3564.namprd10.prod.outlook.com
 (2603:10b6:5:17b::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3564:EE_|SJ0PR10MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: 1381113b-1c7d-40d9-5d73-08dbfce67cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BY7kZHe0P/P34zR1XYOardC0qV7VR6mJUrzdbLHPB8ypDZd29KOX2MLYOfE9XELCLYbG0kyyRTV/QFTC82RtSLvPoHiU10pJQLI0Pt+aXHuOtlUUoIVjLDrNEnQe/McoQHrAgbVQc06zmn+qBzS10kfzuIzy4BGoLjxXc+/0AtG+caGJQ+y7/Rf7Vk96ch77yVm5Q5BBkBYg7IlVXUf5YUremJqszneiwVXhjKcDic3tihnyu7kA+hKOWiQ/vVjOjIUSZ8+aDw8byLq45tl2sn9Ba0WchaGKrv5BUHJrCoYoEetbt7wV6mVMsiQ3vJXZFAuWCl3Qn9mW290c0ckEor+H32lh58NCFCfQb35ags8CzjIpNiBNC0/wsg3mbYP6dN8Pn2kIY2leXdrEwKcZW8P2xCdZlRclUhB1OlHhAyOnrnQHprNikanLOcrInj21UlDDSIg79NcK+rthRZwk6BtCI66pK/IFGdNQPWoe2lSA0uNWswfUYMkgQKdeh/9PMe/Rri9xkh/BMqHmoKxlnEheJG70qwK4J787x0MC/8kh38U9j7OhJTGUnPvmLlyNMYoMEl4evmD6aN6AQpjYj7sW9Y9Sg7LKi9+OwvujBsgIwKpmY7n4+hkPfDbAbOLNTg9itXEhkcYKDMtvJStcHw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3564.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6666004)(478600001)(6486002)(38100700002)(31686004)(26005)(83380400001)(2616005)(6512007)(6506007)(53546011)(5660300002)(2906002)(8676002)(41300700001)(4001150100001)(36756003)(8936002)(4326008)(86362001)(31696002)(66556008)(316002)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z1l1b2M2azRtek9aeFYwSWp1SHhPaEdvb2lwWWJvVDBOZG1YRUpSb0JwRm0x?=
 =?utf-8?B?cnQ4UjBOQkFvRjFOV2ZMK3hNa2ZuYXdWT1lBS1l6ZVJWMTFFNkQ4c3dUMUVO?=
 =?utf-8?B?T2xJeWFiQWd3djUxdGFUakc3R09pWUVoZEdtZWs4RWJEUXdHRWJZT0R4c3Q3?=
 =?utf-8?B?VXgxRlZZbHV5UGF0Z1dmekozeUpndG9wRkxMMDJmT3BKY0hRa0xHRnAxV3Fk?=
 =?utf-8?B?MTFGOEViTWUvNzYvb1h3R1pRamRoaXhuTS8yRUlnc3hLbUdmMFc4NHNQSysy?=
 =?utf-8?B?ZHI4OHllc1ZJbW5NbndtM1VMRFIzT09BNnhqUDdVeGxtM1ZtOENIMWhHeE83?=
 =?utf-8?B?UmVqa2hGOFkzdHc5RzlWZ0l5aWtxOS9PYUllTlZGdGNKeFA5d1R2RiswemZF?=
 =?utf-8?B?citIMGpUeVlNZE5JMVFVcWQ2bjdlclZSV3VGVUxpUW9uQThLUVJZVk1SQ3pC?=
 =?utf-8?B?ais4S3o0RzRmbGsyaWR6UzJ6Z2xtemV4S2dIRVdxa1FtUkE3RDVRdmVEUTE0?=
 =?utf-8?B?cXhzWUhheVRvaGdybUszV3N4VXBOZWFMOTVqOXU4ZkZqaE0vTVBaKzRSbUFq?=
 =?utf-8?B?a0pBWEtpb2NvOFpJOWNVZHVzSWFZa3RvZ1p5KzJWL3lpWWNpNjYwY1ROWkZq?=
 =?utf-8?B?dS8xREtCeGpKdTRDc1UvK09FeTRpaTYzbitlQjdVRGkxMUxQTFZOQTNoVHhX?=
 =?utf-8?B?elNCOE5UQUJES3dsYzRaOE1NV1p0UGIvNE5QQ2wzRUkrcnMyL1BQb2krL3Rw?=
 =?utf-8?B?aHhlT0daYTdUb2orL3NublF1VjhiZ1AzQm1GZ2tPQTIxU2l1cUdMbG0zenpO?=
 =?utf-8?B?cERQcnp6WnhNa0ZQcm9GZS9QS2dueGIrRlQyNUhLWDZOdE9iUWphM3VxYjM5?=
 =?utf-8?B?WHk3dldQWXhHUE9EWkJITkNLMWEyK1Z5V1RpWEo2UFlHNzFmSXR4K1Q0eXMz?=
 =?utf-8?B?dng4eElZREVMTjhYK1NyV0lLTVNuazkvcW9WOFlrMGJDeGc2SWxuanlVZWJ2?=
 =?utf-8?B?OThJd2w5Zk5iWHBnNS9aYjEzNm9FYVV0ZWJHd2MzSnkvb2ZwS3YxSThpRkdl?=
 =?utf-8?B?OThjTmNJbGdhVjRibTdxbUhCdnRVSjNLK1Z0QlVNcG05UlVjd3pEN2xuRXZy?=
 =?utf-8?B?ekJzWlp6NFBNOW9Wd2VTTVREV08xNjIwQ0g0NjB3QzdRaWxGZHBlSGxHeXdh?=
 =?utf-8?B?UW9vbFIwRGM3WnFJUzExUjFtakt2empWV1lnQXBIc0ZZTFUvaU01Nk53U09m?=
 =?utf-8?B?YlFNbTJzWUZCajlHZVRHdGE0NUl3V3ZrU1p3c0UwbmcyOE9IL21ZZlk0aXpO?=
 =?utf-8?B?WVRnelVUOWtaZDVCSG1UdVNKM056NHI1Q0hFcVdkYmlEU2YxWGZGQThqd1ph?=
 =?utf-8?B?QW5zQmEwMkJ4ZDl4a25SY2VGeEYvUDJyellINlpNT2crcXpVaEZKSmFCdUs1?=
 =?utf-8?B?NGZCcDhIV3N5UkZNVG81NHZBMGRlb292RkUyL2pxNHpWWnRQcDZqcHMvTTVI?=
 =?utf-8?B?dU5nV3RXNm13NXNkeUViaE55cFp5UlplaWJZNTU1cFhHa3IweHoyOW9RK1Fz?=
 =?utf-8?B?cFRMcE9vaUZJMmVnYXAwM1R5aWVrY1hTRXhvaDZwZ3ZhSEVYMVE0U3pzTHZH?=
 =?utf-8?B?RG5GOGcyUHdoN2xSMkZkVkJDL3Fza1JwMDFzbEVWYUtKYkNTMEd5VjZlTjd2?=
 =?utf-8?B?U09Xb2E3V2ZhckRvWkgwQ290bm0vTkEwTkxkNThELytLKzR6dVBVTVFyamFM?=
 =?utf-8?B?RHQyUTU0SnlQYmFSKzluNG1yQ05SYzVGYnp0ZzhoaFEzYTZEMEZuRjBoR20x?=
 =?utf-8?B?cXVRekl5RzdHbWtzbGZWTVk0UXBsWjVVZVVWTHpueWZJQ1o3bkl2cEZCZGY0?=
 =?utf-8?B?RFczOW5TQUlneVZWS0J6RGVqQ3JKZTlvRFVyWU1EczZiUGFjL3ZpNUttSVhO?=
 =?utf-8?B?NzVMa3pqaDV5cjBRYmFXZzc2aUdRVlkyNmNUYnpuOHp2dkpDRG03QmtsbTVh?=
 =?utf-8?B?SHR2Sm1jWWpPWVlONGU5cHd4b1p4SWdubXJCeFFDZ0hvU1AvanpFTDJDaFRF?=
 =?utf-8?B?NXVVK0QweEVOS3h0ZlJXbzhIMmtvS2tHT0xSL0Nhb2FGRnppTGhpYVpBa1VW?=
 =?utf-8?B?ZkRCb1hiQnBlamVMN0ZXNTFLeWhvT3FVYThlVlJOQy9weEZSYlFQMHBlSmNC?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YgSqq25JLDqIa4Q3oYecdggpSAAbs1+jyFZ22wz0zOref0WegL8RzD6gJ3peq8Z2EMSsT2e/u4MtN/YZNYAyIViSX5sntPvJ6evn8egMbbVDGd95FKgQTy8dM7iE1fhT+4alv8rtQMBJTNlt6NEnILqo7qgH7pbhcluo4P8JuEUPxg4BWtI928HFcmq0njBxfbWUUMAeMysTIwAk32fonjsFq6/866dK16zrOaS0Rv+8/RD1E1PDkwI6z5CU6Fxqtg6qscdOf4RfZKZPCJ3VA5YA4a5lPimCl37siJZ3QZwKh2SbNDEQIzjpieSJ7wPrycfDevsNEk4GdS0wnjfhmbvWBSb6sZ1DaobSREN9q+IfP8miW+4p+n9sarF5tQ7rvrYyZRZgAGBDxkt05tj81s+UCNUry3qwbAxjrKOJ4DVQIw3Pao6VrdABusNrqDGb/ZUN6hNWG/BTBLEycwwCdXTEVOMHtluuGN62dB/RqQpqCAN6iPMvV1S6xjqniRAwXhM5lR0ZEZwzNVaIBC2MeAV2A2+8Vlwp2DcPPoRBXGpbj5tZXalqzRVd5rR+Jm1/a4236poMP9nX0a+0O0raTaZx/GK4ClQ1z53LqqeNl/k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1381113b-1c7d-40d9-5d73-08dbfce67cea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3564.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 20:51:47.4367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYPbvHZOgguE6/ITXvYypcqDrijxbkaXneZsLsuIR8cdoQmzzMa+0S/qVFXfBBP/uipOqvrJtedYf3ffY0Rn+tJtanYKznrKSbIvITOgog0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4414
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_14,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312140147
X-Proofpoint-GUID: ZgHmvnIqujgJRvS2mxqMF75czoqNO5Ym
X-Proofpoint-ORIG-GUID: ZgHmvnIqujgJRvS2mxqMF75czoqNO5Ym

On 12/14/23 9:57 AM, Tim Chen wrote:
> On Wed, 2023-12-13 at 17:03 -0800, Jianfeng Wang wrote:
>> On 12/13/23 2:57 PM, Tim Chen wrote:
>>> On Tue, 2023-12-12 at 23:28 -0800, Jianfeng Wang wrote:
>>>> When unmapping VMA pages, pages will be gathered in batch and released by
>>>> tlb_finish_mmu() if CONFIG_MMU_GATHER_NO_GATHER is not set. The function
>>>> tlb_finish_mmu() is responsible for calling free_pages_and_swap_cache(),
>>>> which calls lru_add_drain() to drain cached pages in folio_batch before
>>>> releasing gathered pages. Thus, it is redundant to call lru_add_drain()
>>>> before gathering pages, if CONFIG_MMU_GATHER_NO_GATHER is not set.
>>>>
>>>> Remove lru_add_drain() prior to gathering and unmapping pages in
>>>> exit_mmap() and unmap_region() if CONFIG_MMU_GATHER_NO_GATHER is not set.
>>>>
>>>> Note that the page unmapping process in oom_killer (e.g., in
>>>> __oom_reap_task_mm()) also uses tlb_finish_mmu() and does not have
>>>> redundant lru_add_drain(). So, this commit makes the code more consistent.
>>>>
>>>> Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
>>>> ---
>>>>  mm/mmap.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/mm/mmap.c b/mm/mmap.c
>>>> index 1971bfffcc03..0451285dee4f 100644
>>>> --- a/mm/mmap.c
>>>> +++ b/mm/mmap.c
>>>> @@ -2330,7 +2330,9 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
>>>>  	struct mmu_gather tlb;
>>>>  	unsigned long mt_start = mas->index;
>>>>  
>>>> +#ifdef CONFIG_MMU_GATHER_NO_GATHER
>>>
>>> In your comment you say skip lru_add_drain() when CONFIG_MMU_GATHER_NO_GATHER
>>> is *not* set.  So shouldn't this be
>>>
>>> #ifndef CONFIG_MMU_GATHER_NO_GATHER ?
>>>
>> Hi Tim,
>>
>> The mmu_gather feature is used to gather pages produced by unmap_vmas() and
>> release them in batch in tlb_finish_mmu(). The feature is *on* if
>> CONFIG_MMU_GATHER_NO_GATHER is *not* set. Note that: tlb_finish_mmu() will call
>> free_pages_and_swap_cache()/lru_add_drain() only when the feature is on.
> 
> Thanks for the explanation.
> 
> Looking at the code, lru_add_drain() is executed for #ifndef CONFIG_MMU_GATHER_NO_GATHER
> in tlb_finish_mmu(). So the logic of your patch is fine.
>  
> The #ifndef CONFIG_MMU_GATHER_NO_GATHER means
> mmu_gather feature is on.  The double negative throws me off on in my first read
> of your commit log.
> 
> Suggest that you add a comment in code to make it easier for
> future code maintenence:
> 
> /* defer lru_add_drain() to tlb_finish_mmu() for ifndef CONFIG_MMU_GATHER_NO_GATHER */
> 
> Is your change of skipping the extra lru_add_drain() motivated by some performance reason
> in a workload? Wonder whether it is worth adding an extra ifdef in the code.
> 
> Tim
> 

Okay, great suggestion.

We observe heavy contention on the LRU lock, introduced by lru_add_drain() and
release_pages() for a prod workload, and we're trying to reduce the level of
contention.

lru_add_drain() is a complex function that first takes a local CPU lock and
iterate through *all* folio_batches to see if there are pages to be moved to
and between LRU lists. At that point, any page in these folio_batches will
trigger acquiring the per-LRU spin lock and increase the level of lock
contention. Applying the change can avoid calling lru_add_drain() unnecessarily,
which is a source of lock contention. Together with the comment line suggested
by you, I believe this also increases code readability to clarify the
mmu_gather feature.

- Jianfeng

>>
>> Yes, this commit aims to skip lru_add_drain() when CONFIG_MMU_GATHER_NO_GATHER
>> is *not* set (i.e. when the mmu_gather feature is on) because it is redundant. 
>>
>> If CONFIG_MMU_GATHER_NO_GATHER is set, pages will be released in unmap_vmas().
>> tlb_finish_mmu() will not call lru_add_drain(). So, it is still necessary to
>> keep the lru_add_drain() call to clear cached pages before unmap_vmas(), as
>> folio_batchs hold a reference count for pages in them.
>>
>> The same applies to the other case.
>>
>> Thanks,
>> - Jianfeng
>>
>>>>  	lru_add_drain();
>>>> +#endif
>>>>  	tlb_gather_mmu(&tlb, mm);
>>>>  	update_hiwater_rss(mm);
>>>>  	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
>>>> @@ -3300,7 +3302,9 @@ void exit_mmap(struct mm_struct *mm)
>>>>  		return;
>>>>  	}
>>>>  
>>>> +#ifdef CONFIG_MMU_GATHER_NO_GATHER
>>>
>>> same question as above.
>>>
>>>>  	lru_add_drain();
>>>> +#endif
>>>>  	flush_cache_mm(mm);
>>>>  	tlb_gather_mmu_fullmm(&tlb, mm);
>>>>  	/* update_hiwater_rss(mm) here? but nobody should be looking */
>>>
> 

