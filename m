Return-Path: <linux-kernel+bounces-22628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2A582A0A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55ADC1F239E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA8D4D59F;
	Wed, 10 Jan 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cwRmSYe8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A6G1OK3d"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8374D596
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40AHuFFZ013759;
	Wed, 10 Jan 2024 19:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=VSgqL8fxgdGS4Ui+EL2Xl04XhTM9mXTC3F5bkf6j0E4=;
 b=cwRmSYe8A1FWnn3vgResFIHZVWqb4kHX8UDGVyzmZPY4QALJR44WetZStqfQvx2Zx8Uz
 dDlQhUKF/asv+SbsMkBMZMB+FA22F00WGKbeQX9M6/yuGlaRQkGYHnPnNB4M17jSHuz5
 apsTF25jp2JGnqemjJfl9j6GX275b7QM1YvK28y7UzMocs8jo4tzCk7M/sHnmZ7+ZGd4
 QLmBGcX2zQCrBrKJCerLvA35qsq2pBhvcj995YlmZW4vwm0prbfZ74IgxRp3i2D9RnhB
 GUWi4j8Qiep7o+Rae1kBSzmJ5+9+ep4uOikK+rMYswysuh8JnLFC+uwH9BsJDh2mzltQ 8Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhs1x1456-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 19:02:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40AIhNPH035185;
	Wed, 10 Jan 2024 19:02:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuu6j01u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 19:02:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9dLYsPDvG8CUyic/MzzuFOGyFOoOh0pq+msST/aFNml37EhwuyYqvVres9Ero469Bi1UFuPoQpRETfmdoQe6ZKjl+3GfqG+YaheFXDFfLctC0ofbWWEvTXJ5fvYLl7zrFa+Xsy4WavCd3vkETe5s/2WcDg6mGwV6snpXFEDjSWL1eY9+eJKZzyr0HPcxZ6qVdsSdMvrK5YKlSm1+HQAVbzEKisoKCxMxLD3K8f7zvMrn50l5y+cDvDdYK/pa9FM1nFvEdn3zKF+Om0RuBIJ91sBJftRWmPIZYb6Rpa6dD4nQRbFZVebFIXJzh48VDBm2iT2IV0OZ/DRng+pAG+5AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSgqL8fxgdGS4Ui+EL2Xl04XhTM9mXTC3F5bkf6j0E4=;
 b=aFc782N76VNqynjy/hO6A0fFg9sd5x7gFuetLj9avE9ItV2TXqEEOzP4eOkp49jSHHLytErwJ5VL0lmMEOTT+js/eSdruWd9B1z2cLNETqxZo6pHZDU4zMaZiuUcB+ZaayHr2HGWymKqLvkjFtzwlvYjL9ZDuLkHUYxRfI8C53JXdn2cVlHQpNKKyyGhvZHaGIMDr+8CAK/JCIYaALrpXhRfhfKF8jwvExFW8ZbVnJf83Pub+xunEmYkShpFtWA/v72UolQwLnrpNfRLxOaVuhA0MSvuaiis2RpBaM2x22lwaDG0EQK7Luw4WW1kRKmR6WDjRBuCNHFPOymXuquHyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSgqL8fxgdGS4Ui+EL2Xl04XhTM9mXTC3F5bkf6j0E4=;
 b=A6G1OK3df/GyXjf/GVFjNui5kFk9qKjWZ2N4+rsXOxrmEqig8KfR3878KIF2kM2Y/P0giloBu0GsqDdJzy2U4/4bVuw+xmxM5K2jDBuKW5BR14vgqcYpnAKcdosIGlKP+F51tkQAeZrEIJVuQHYqFoXcZ4GbAlWhHzPbNxbYa/U=
Received: from MN2SPR01MB0026.namprd10.prod.outlook.com (2603:10b6:208:cf::18)
 by SA2PR10MB4732.namprd10.prod.outlook.com (2603:10b6:806:fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 19:02:05 +0000
Received: from MN2SPR01MB0026.namprd10.prod.outlook.com
 ([fe80::7dbd:113e:6ce0:23d3]) by MN2SPR01MB0026.namprd10.prod.outlook.com
 ([fe80::7dbd:113e:6ce0:23d3%7]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 19:02:05 +0000
Message-ID: <1d866f1b-94b3-43ec-8f4c-2de31b82d3d1@oracle.com>
Date: Wed, 10 Jan 2024 11:02:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, oom: Add lru_add_drain() in __oom_reap_task_mm()
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20240109091511.8299-1-jianfeng.w.wang@oracle.com>
 <ZZ5Zb3FYqY8FZgB3@tiehlicka>
Content-Language: en-US
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
In-Reply-To: <ZZ5Zb3FYqY8FZgB3@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::25) To MN2SPR01MB0026.namprd10.prod.outlook.com
 (2603:10b6:208:cf::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2SPR01MB0026:EE_|SA2PR10MB4732:EE_
X-MS-Office365-Filtering-Correlation-Id: 1837f3f5-1b44-424a-ea73-08dc120ea306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	V/P3aa4Unx2Uv2QG9V0n37hIlY+r8Meg0Vjd0XDaAduk6wAH5Z+xOVU+CD+SFTWNpCgvwaGnKrWUQxf7lGv60RPPu6kcvXIHKQTHBZxTsOytqn3yOg9eT+iDblNXj8g1mbLP0jAOYGezxogxo+JxW52CRxeaW4IAnNhwKoNcjMZIJ5i8P07bY6MTmN9a9ScDF4F0/GHEORgfpROuXkBiEtmKvwmbjQJaDcdhluCItDT70ZUOp6zsRYECz9NdOy7kPpOzwFfCUixkRmceoHEyIkA3MhyqEXazWpyHS8W9H7HSAzfb568aINkMxZntiJGc9iaSQrzNAnJ7wJi8zRvwAknQi7Aef8fa6LzaR1RcbwAdUPjLiA4gr29YfEy4yA3Qd3BEvgle+tkt2nWOl+P7XSsSRkpuleP/QSl08F4NjKk2qDRBWPDH4nymTKBBEscSjGI3h/NDTZ8PW1W46gcvpQf80zNK6p4gzbntwxEQ9n+CPcY2D7miozIScmUVWD2eZZQUgRqhVZyms1sYnXVoPbsw1dAgZCKY99nz3tD/UJ3rJHahkbkZMTo3q3AnPYhbi1NnXo8im7vET+V9d8XBvc7eqdxdLtamPc8UDljBH8fJ8akfqLZhuzhyMP6He1XVlke7wzknjgR4QFNZ9uea1Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2SPR01MB0026.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(41300700001)(2906002)(4326008)(66899024)(53546011)(6506007)(478600001)(36756003)(6512007)(8936002)(8676002)(5660300002)(38100700002)(31696002)(66476007)(66556008)(26005)(6916009)(66946007)(2616005)(6486002)(86362001)(316002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZWQvaXRSV0l4MFhaYldXei9hUk5MNGxoWGlmbm1uMXhvdkNFTHVUVCtNa1Jx?=
 =?utf-8?B?SzAwK3QrYjNEL1dsMlFaRzRGcFpMNzkwZXBWUS9qUnM0MTh5WWRJUUZrOU9o?=
 =?utf-8?B?bFVpNHF5NldYVVdSbTJGVDcwaGt1Y3JWYVRxU3hBL2JzaUlOcWkrc1k0Zjgr?=
 =?utf-8?B?dktQcDJIdHVqRFE3clIwcklhM1ZaUTBHL21GR0pVZEs2Q1FaQXYyV01VaEc0?=
 =?utf-8?B?L05UMjcyWGhrYzdyQ2hXcUFHNXBtQk5GS29wZW9zdk1FUzJpSzdsZ0d5TW0y?=
 =?utf-8?B?dzAraG50VDQ4Rm9sNG9lYlJ5QnBaODRQc0J6cGxBSk0xbUFTcGdlK1hPbktm?=
 =?utf-8?B?NmZPY2Q3dE52Sks3cFlNc1g3QXBhUTA3VDZhNlY5ZVF6dVF0cjNxeFRHaWpo?=
 =?utf-8?B?MzBFMjRZK1NLb3Nwek5vdEV5UmRLRDFLb3BEOTVMMFIzMm1TdDROZEc1R1h3?=
 =?utf-8?B?Y1d1ZHVFdGRTZC9IQVRxSklsLzJMOVc4NGpqbXR1OE9NZ1FmcEpCQnhGNVQ5?=
 =?utf-8?B?WG14REV1MC84QVMybkFja29BR1JLUEVIL25sSmtSdXM1Q2VOY3VGYllJazJo?=
 =?utf-8?B?aHlRNEc3eVRnemVHUW1acEJSRyt4b096c1FaNUNtak5TcGxHR2RINlBORDRj?=
 =?utf-8?B?NkVBOGZ5TFB1cU1sbHhySU93V1JIOENTbmI4dVMvWU9Qczc0SnZFZ2FUdGIr?=
 =?utf-8?B?WDRvakJoVFh2QXE3ZWVseitjV2dFSkJGWGpxc0hhSlU2b3ZoOFIrOWl0eDBF?=
 =?utf-8?B?V1RUMWJPS3FqMlhyQ0lHV3dBZ0ZaTU5XL2VmZ2Eyb0NNY0t0NVFmK0YrZlRZ?=
 =?utf-8?B?TkNPOVlTbDN0Ulk4R1pXQzlZNnZGRHJveDdKV2RQUjNpcExMdUVTNldKaHJi?=
 =?utf-8?B?L2JWSENIdHVCbFU1a3ZWcWlZNXlSdzFrMUlLSDR3WTZ1N0JMS0YwcVRhMFNC?=
 =?utf-8?B?Y1pCWVJIS29WbkZVR05TcFF2OVlnUG9NRlBqRkdEUGxtZEVyTURmUkFKYXQy?=
 =?utf-8?B?NS8zNTcxZHU4MnJDNEt2dStzVE9DTWEwSGVqbzVGTGNzUyt3bWRqaVVqT01R?=
 =?utf-8?B?eDRhZXFqSGsyTnJvTll4cDMxaFE1dXlZanVMUHJqSGpFa3NCTDluWUluVGRG?=
 =?utf-8?B?VjhLRXFUNWJ3YnBPN2FSVGxYUTJHRWJrdjZpT2p1UFkvOGhZcnhiVWJSRjc0?=
 =?utf-8?B?SHVoV3RQSDhrcUdxemlSa3VtM0tsZ0ZwQWxWZjVUM1dVTnYrbHJTazVERDdy?=
 =?utf-8?B?NTJ5NGE2TVRGN2g3RWpnb00zUjVCZFl6bVJmOUo2NHRhVnB1dFZIbWVyODNH?=
 =?utf-8?B?TkprSXp1aTRRRFNoblFxUUxuOGdwZFJMWGtoclB5d21IRE9uOFU3amF2VU5B?=
 =?utf-8?B?amoxMkpKRURJZkp3T0tGUDZFMGZMcHZ3RkZEakxlWE82YmZNSitNQzg4dTFt?=
 =?utf-8?B?bzgzeGdSRHZJalZmUG4yV1lvWFZpZHU5MHJFbG9hTkoyQ3JxTVFFTFFFbmV4?=
 =?utf-8?B?TG5HVFRUUUREUlBZS0g3YnpHa1pVa2xSbW1CWkMzYklVU0ZpVnBEMWFvckhw?=
 =?utf-8?B?MzNYME1SSDFmaXpkUm83VkdMdFZYb1BhTm0zdCt2a2d2eG9taDFXUkNEci9L?=
 =?utf-8?B?NFhMU0djanA3YWJMczBVQlNDWW1yV2JnK0pOMmR5R1prT1FQamJDS04rc25z?=
 =?utf-8?B?L05rb2VxVGtjb3dPcXI4U2tzT3Y5dXFpbmhXOW5vbTZOcVMwV3FqOEZ5Q0Iy?=
 =?utf-8?B?dGVkV1Q4eUZ3ZldEZGlJaE9WUkJwU2JiN1B3NWV1TlJkRUN5SEF3eVNiUTI5?=
 =?utf-8?B?RWtwWVhmNU5vK28ybG94QjFtK1ZPU2x2S2tVZmNhUVI1QTFTZ09GemwvNTNw?=
 =?utf-8?B?bWNKMEdwdDBmOEpLN0xyTzA5V0xZV2lTeUV5TmRLZSt1SU5iTE1tV3R4Ykds?=
 =?utf-8?B?RnoxRUJ0M3M3eWpJc1RNeW0xYU1xM002LzhzYjc1YlZlZlJjVGJsTkNSM3Zw?=
 =?utf-8?B?b2cxcUpjbnBRUW9SdXdRSG4vRVJSZ1B0d0dvYlFtSmM2NzRndWpvZHkrdTk0?=
 =?utf-8?B?TUdtMEVhbk5kdFZWM1pXNmlhaEtGbmxSY0VPZVh3TmQ1RTg1Z2NsNzdPYWRJ?=
 =?utf-8?B?UlpvMDRtWmNzdCt4dFA3N3Y5eERXOXJUeXMyWTErcXFYL2RSYTZIUTVYN0ls?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YnECjRuwQa44UiS3DC5xZle9DJ+yxJuogJcnF0JIuGgyUjdl58UpYYh3k4zsjyOk/NM814x9xh47wajSMpvWgSfr9vckrIjrrNFDh2hNgZ1d2y/SY//6M+V11qirUXbJxkyLsuUCo0ZkOFnbvAXEGhgv/u+q8/M1F2UCNcGI/PzsA8/leJ+qWqgJMLqNrJKhvwlvjJpp8s4GayZa7qo+7H4szLyNHd8ViR8liCHG3obYvhtwAEFRZszfkXXidJbt8hCQuF4WgAOwo3Q7OKxc5hVWi+9yTegOmObaIpTqRGLbydDdbhf459AjjWXvxzrxcWE3ohdY0W/TCqsCbJZ+agQVjuL8XkBJvMo1tL7/jXqucphOlyTwPWOpFXJERUNQTF5Wryiqvw2esvWzKgH6I1bStM0NVs5eUyVYtdxG3IH06y/BWiWTkRUIwUOf2oPpNYhfZdnph/phiIB2y5LmWiDYzuH209Ak+1JhzgEu0Y4LsbD+FvBizmMEbcAoUT4QIEP04zMU+ivk1X1P4hUWyBrsLLIL9yprpJDBTDDj6J+iq54P9aLUFKv2cGmZKwjjuZCgeWf1he1hxH3FrbinQX7BNTqV8jeDqPh4h25HW+8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1837f3f5-1b44-424a-ea73-08dc120ea306
X-MS-Exchange-CrossTenant-AuthSource: MN2SPR01MB0026.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 19:02:05.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgUjk97G21OzrySsi4m4EuNwIdjk+bwPwzVVIOWO0TA5jdC1eyDKFyF3yY6cbYXKEZXvYCYHYHfo97xgyV7dQm27APRolf9AUHxLKeAUw5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_10,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100150
X-Proofpoint-ORIG-GUID: 377hpacGuYWh-AfQOTnnX9-ZgMOMA6sG
X-Proofpoint-GUID: 377hpacGuYWh-AfQOTnnX9-ZgMOMA6sG

On 1/10/24 12:46 AM, Michal Hocko wrote:
> On Tue 09-01-24 01:15:11, Jianfeng Wang wrote:
>> The oom_reaper tries to reclaim additional memory owned by the oom
>> victim. In __oom_reap_task_mm(), it uses mmu_gather for batched page
>> free. After oom_reaper was added, mmu_gather feature introduced
>> CONFIG_MMU_GATHER_NO_GATHER (in 'commit 952a31c9e6fa ("asm-generic/tlb:
>> Introduce CONFIG_HAVE_MMU_GATHER_NO_GATHER=y")', an option to skip batched
>> page free. If set, tlb_batch_pages_flush(), which is responsible for
>> calling lru_add_drain(), is skipped during tlb_finish_mmu(). Without it,
>> pages could still be held by per-cpu fbatches rather than be freed.
>>
>> This fix adds lru_add_drain() prior to mmu_gather. This makes the code
>> consistent with other cases where mmu_gather is used for freeing pages.
> 
> Does this fix any actual problem or is this pure code consistency thing?
> I am asking because it doesn't make much sense to me TBH, LRU cache
> draining is usually important when we want to ensure that cached pages
> are put to LRU to be dealt with because otherwise the MM code wouldn't
> be able to deal with them. OOM reaper doesn't necessarily run on the
> same CPU as the oom victim so draining on a local CPU doesn't
> necessarily do anything for the victim's pages.
> 
> While this patch is not harmful I really do not see much point in adding
> the local draining here. Could you clarify please?
> 
It targets the case described in the patch's commit message: oom_killer
thinks that it 'reclaims' pages while pages are still held by per-cpu
fbatches with a ref count.

I admit that pages may sit on a different core(s). Given that
doing remote calls to all CPUs with lru_add_drain_all() is expensive,
this line of code can be helpful if it happens to give back a few pages
to the system right away without the overhead, especially when oom is
involved. Plus, it also makes the code consistent with other places
using mmu_gather feature to free pages in batch.

--JW

>> Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
>> ---
>>  mm/oom_kill.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 9e6071fde34a..e2fcf4f062ea 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -537,6 +537,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
>>  			struct mmu_notifier_range range;
>>  			struct mmu_gather tlb;
>>  
>> +			lru_add_drain();
>>  			mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0,
>>  						mm, vma->vm_start,
>>  						vma->vm_end);
>> -- 
>> 2.42.1
>>
> 

