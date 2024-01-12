Return-Path: <linux-kernel+bounces-24171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8E582B87E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD321F21B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050F215C6;
	Fri, 12 Jan 2024 00:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iCXHZm6V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Skk84Bdf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9DF1379
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BMPdYg012708;
	Fri, 12 Jan 2024 00:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=76CB0YjqyDqF1JiJpAD3K+0svNXqQ0qe5z3+AmRZmgs=;
 b=iCXHZm6VUVVoIHrPXbiKMUm1Ns+AgtZl5w4Qkun0qUG4Zbt2LHuZVLmN1rhD46y6een1
 xEXmQFK1TcKisD7n5w5KuWVrEEXPH8jXUlrYgMf96eHZRnz02o8Gpe9eLNeq11ZLL5Uq
 49T5fX7Gp7lSIOKtveu/hf3sK5gh22EwDbgsDFwctnkrPrunkhLg9mL8+nzwnedXa26d
 FFrsT0Q4lHuesfy0BXUROOsJe5W+nCg/aEZ2Co67EYrLRyhNVIkDbrmCmrJpdHA3hmjK
 2diK2LeXiHgwUWfRgpfdGZ2tmK0n1Un1wCQXXVtvazUNBub+8E2yvWL1LpVMtNcgTXgo Lg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjq0xrhta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 00:09:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40BNhAJX013691;
	Fri, 12 Jan 2024 00:09:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfurfgr2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 00:09:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cc0mpk9bZtBA5ebjAYqLFABcr7hIv1AbpL/7OtJIGJHPcfknPCxgMd+cR+oAwnGpDhEwcqJUTCzbTr9YYBOf5e3xQnZqREIDmBNkK6jl2n8GGj157Gk+Xpu2F30bjpIG2zEt+jD/eEUJ+i4Unhev4LfEyRvHBVkABoNyH2lrKoIVXoSQU73KYWBgV1fJUQtIwY0IyITZjQoNNbf1t9vwGXUr00LiJa3kolbKV8qGGiixyhNvTMinwNvWQyn4xEfoVGEA9MSE9uyAMzktNsD/mRAAB3Kjvf6QbSQRYB57Ulhmu2u8pZuv499f6Dsh0iBySqqY7jBiIFJH9psErIKTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76CB0YjqyDqF1JiJpAD3K+0svNXqQ0qe5z3+AmRZmgs=;
 b=jNq/AE07G2rO4Ao5ryk0pbv11zjsd/H7m2eY87rmziicJUPbQiZ1YraEXyjAlvj2zS9KyT16Dlkrf/I37pJJFN7kIvOl8jA10Ac+MrZvDMjrcW6w7NYxbXJPoi4csaKsMpc3VpNwx7I0VTuskr6QqRY6Dxc+8G2V9FP3oi5iuci3MKzV74g2cEQI2RlQ8UQcorPSuTZTn+zMcnCwJip1Qa4Bx++0bhmeJ7FQKygXjQZWVzM0/6OkICNbEW0+vKwii89J2zZZ7WIjYf5+2AbhsNV6FnE4c+XOKRV/5VVORtdA3qzA5RVDgrnEMEGVPop2Y4t4PvuUc+HIDOGN+U/AbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76CB0YjqyDqF1JiJpAD3K+0svNXqQ0qe5z3+AmRZmgs=;
 b=Skk84BdfNSfhwfObhUXRPK9Lsd8Kv9ad+vqiCQG8lKPHueTiRluQKHSUPmC68QMDQNKy+x1LPgYpdxa55gfhaw6JpNDW1u1RGaOTgUKzMBHqcI/FbbaiQthY+P8Epk6aYME9tSoRUQEy39yqM+0WVWK0ZUvRvkbb2RdNfuG2fDg=
Received: from MN2SPR01MB0026.namprd10.prod.outlook.com (2603:10b6:208:cf::18)
 by BN0PR10MB4950.namprd10.prod.outlook.com (2603:10b6:408:12a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 00:08:59 +0000
Received: from MN2SPR01MB0026.namprd10.prod.outlook.com
 ([fe80::7dbd:113e:6ce0:23d3]) by MN2SPR01MB0026.namprd10.prod.outlook.com
 ([fe80::7dbd:113e:6ce0:23d3%7]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 00:08:59 +0000
Message-ID: <897538a0-5ce6-484e-a9bc-4e61b3be2265@oracle.com>
Date: Thu, 11 Jan 2024 16:08:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH] mm, oom: Add lru_add_drain() in
 __oom_reap_task_mm()
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20240109091511.8299-1-jianfeng.w.wang@oracle.com>
 <ZZ5Zb3FYqY8FZgB3@tiehlicka>
 <1d866f1b-94b3-43ec-8f4c-2de31b82d3d1@oracle.com>
 <ZZ-q0PZ-XCDwA4oG@tiehlicka>
 <b2096bcb-bda6-4831-85a2-67759e783e4d@oracle.com>
 <20240111135404.609af4a26d0118c0d290f11c@linux-foundation.org>
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
In-Reply-To: <20240111135404.609af4a26d0118c0d290f11c@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::16) To MN2SPR01MB0026.namprd10.prod.outlook.com
 (2603:10b6:208:cf::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2SPR01MB0026:EE_|BN0PR10MB4950:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ab18a2-8ea7-452b-8bce-08dc1302acfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qsPrEJwjRLUuIwwKOgOtmcxOd81T4Xp62E/KNoRbab/JNtKXIlXSDQg42v+rA+AEZIWR1ICcHgWlJINf9LGs6WzuYG6pTfL2hVo+pSc3JJyhS4C/UV92Aura6cAZ+9wIafH5dmhuck2es43/hoROw4KYiG8LJr2hREGjIlZMEuiC7wDja2STFK3m+xjbxG5iilgJ4bJP97KwFHf2GPKmY65hCeKmuYfTD9TF6/XEPO/EAJcyJyFUVdG/NjOjbYtjW7I+C/d5GzdzkDLnAcPSYmI03J89IE4t/B0Sy6kKWEYyA640piePxJxbtLRf+RATFfeX8VjM9Vr1V/XWKlcvZBCaVGQKNIRY/Vra9G0F5sNMdGY2jnJS364kmLgCb5XVFdEweZMjejnJPoJgfa00oa7Jz6pX5oSzjTjnqP2FLsvh0mokGEnEMu0QPZJdfFkmslWSorEJN95rgO1ZmOjkeO6KrQW/MHZl6CJKdAOOGnvA4oZ0elBNooOCcGxcf95gjHWRR867vmQKtSqPj1ZLI+WnKJ+kPtK5eU1hHdRBpRjiuLan/E4GAEem95ovV8MaEjq8ZZtllk1dHwX/DU4Slbg/gqLN0GMof19xK0lSvfhvdz2h+umN/FhWeqjZ3XcsTexPTKX9bUUlSnmDJ64XVA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2SPR01MB0026.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(5660300002)(4326008)(8936002)(8676002)(316002)(31686004)(478600001)(6486002)(53546011)(6506007)(6512007)(2616005)(83380400001)(26005)(6916009)(41300700001)(66946007)(66476007)(66556008)(86362001)(31696002)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dG84b0hJWVM2bjlRQnU3R0J4Z0NhSDAzSjJJRVVuQTJjZkRCTmFoVnZIdmZG?=
 =?utf-8?B?UDhqVEtjZW1vRmFIRzFCd3VYQTJuZ3d6OGNDQzVrRHlxOWdmR2lncjFhbmpi?=
 =?utf-8?B?NVA5YmEwYnBFdVJQRVlpSXhYbDB6aWZ4RWNXT0hnaEdaZFhQV09QWXpzRXpR?=
 =?utf-8?B?WDJ6WGxqcGs1Rzl2K2V3Q3VaanpyMWlOZWlJUXl2SEFHdGpENWFicG1PWlFV?=
 =?utf-8?B?S1JKc0s3MmFySWpGRmVORHBORUNyYXhrMjFyRk5VZ1ZHNTlhcnJnd2VPd3dJ?=
 =?utf-8?B?RGFNTXdtMWpkekdCdC9heHFxQkk3cDhSRkNqcjZabzdyQmFBVDdZUzZHYlpq?=
 =?utf-8?B?RUZHamhTamsrQ21NRnRyemVybTgyVW1WZ1A1SmZqUUhZdnNZVG02MlNMaloz?=
 =?utf-8?B?bG40c0JhaHFtbTJXbGZIWUsvWVlNLzZqT25NMDhSc2JIbHExbkx2WDZTeEhW?=
 =?utf-8?B?UlVyaXltUXlyYnFEaTFWTFhOLzhRWHhaOTFtaVVCVmM5ZWN5K1FTNFE5ZFZY?=
 =?utf-8?B?VXhlU2M0cStEVnBmOTh0U0cyY2U3cmJBbXlZditwSzJMeGg0dHpSK1JlU1lz?=
 =?utf-8?B?SG9CT2FWT0VWMUorTGxaWDNDTkYyMVU2OThGM3NZZWl5aTd1VTJ5eHZQZDFq?=
 =?utf-8?B?OXpUVGhqTHRkUzUxVlZFMVllVEtsSkoxVGZLMW5WeSt1cnlHQjBaYjllUmI4?=
 =?utf-8?B?NDlpVndVSzZ1SXNKZVl4MDMwU2I3TXh4WVBPUzRNSS9oRHhIN3MrY1cxcHVu?=
 =?utf-8?B?UGZOakRCV2FxbHlJendmeFo0VlMrd1lwdEtyQ21hK1c2OXhCV0VkRmI5OU5X?=
 =?utf-8?B?a0hVZGJyUnJYdUxaWDdmZVJMWmFOMEhleDNLQnU1NFVEbkMydTNJRXNpT0hF?=
 =?utf-8?B?OEZabVhOamY0a2tTZlBrYkxGRzMvUGtwVVFjNlR0UE9sSVNha2ZlN0VUM3pl?=
 =?utf-8?B?S2cyUFRnamhPTzVkRTA5cGhtMHlJM2MyRmhTQnJqa2ZGU2hKWm5jR2IvV2lW?=
 =?utf-8?B?Y3NmalZMTlJaSnUvSXVOWEdFb0UwT0NPYXpNbE0zMnhsVUdtL2RjUGxZdTN6?=
 =?utf-8?B?dVJrOE1mMzV6YlBsRStuTGVweHIvcm5ZeHFVWGRqSmxDbHVnUHhjK0ZYVXpp?=
 =?utf-8?B?KzdNMHFFa2JwdmFsMzZPM1kweFROOGhPQXFnOCtHRWZubVpvYjFPTWV4c3A5?=
 =?utf-8?B?bGdrNWpXRlBNc3pSMDMrUFJzWlhuNndCdis4VkpFd2lxLzl5b0tVZFloVUtM?=
 =?utf-8?B?dnJ3WUQzaWR5Z0tyTjI0WUZiSHRLb2NRbStXYnhvUkFtcTBuS3l4Mm5IMnZM?=
 =?utf-8?B?empJbUR6d01PTTVCSDNGL1UvL2JnSHRUSHQwaWlsVEhIRkdBR0FocCt0bndD?=
 =?utf-8?B?d3BtdHB4eUxaSEt0THV5Z2h3OVdmUndqOERnQkFzSzU0KzFzQUJBdlk1L1J0?=
 =?utf-8?B?cktvbng2Vms3QjlIOG9CZnVIQW9qMjhNVVJvekJJczRlamZsdmRNQ3k3SUZX?=
 =?utf-8?B?VjU5ZlYrdWw1ckYzRmxNQ1g2QVlGNzNnZzRwNHpYeklzNkpDc3Bqa20wdkQ3?=
 =?utf-8?B?bkdza1pYRzUwc0Zrd1FtWkVzb1FodFNsV1dacTQ5aURjamNTOU1EeXNqVlF6?=
 =?utf-8?B?dmp5M1FxRWI5ZmF4V24rL1BPRHV0dVQzTjM4QWJSaTg2R2RmamFOZy9MREFU?=
 =?utf-8?B?bmtNb3RLS0Q0SVlBc2VkQzdaQUx3RkVKbXZFM3NqVTloTHZ0RTBvWEZySjlM?=
 =?utf-8?B?U0Z5VjFQZ1Z6Q29EZ0pLVG9vRDE4NUxzSG9Pa09XdEU1T0QvRmx0Mmd1cTRX?=
 =?utf-8?B?K3RBNE4zejVFNG9PQk1sYlQ4eEF6QStNaHlnWllPeUlNYkRINzBLa2h6TWo1?=
 =?utf-8?B?ZUFxa1V3YmFwVnBZNTNvT2tPZVJQUXRXNXV4cHpSZVR1Qnh0ZCtDaWdpM2tW?=
 =?utf-8?B?dFpxMlJQNC9GQ1E1MXdFMEQ1R2ltaHBiRmpQNDFKVkFQc01sUERMZ090T2Zu?=
 =?utf-8?B?VGM2OVVwOGhYYjhCbkFVQVZzOEd2VDRUczI4eHRXS1hrTmU0d09mT2NvN1By?=
 =?utf-8?B?K1NuK3VjaFc0QWE3d0N3bjdqLzlBVnRPcHFVcThXdDF1OW1NZXIwRk9YaXJU?=
 =?utf-8?B?VnRFY2I1dXhyRUVQQVp5UFJSUjdlU3N1bzUvSDlLUmZoeDVKRXBlQkFzV3hu?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KtaGd4/3z9eBTo1hBtNMrY61OfVWRRsoM2F3NCjhIb8/tTgfR+/b0ZIVya1+q3zkwy94Egub2iFFTgStYzYDeHsadk1gieVlYvoYKSNNJcoEuBy1+9ZXEFYIGO3L9U40wZQM4+QaPhAejVH5ADQTqvs0UV+Wj4v00nbfM24Up0UQjHHMenvUBJoTjrCVzAw5sBwcAEAbdfFSfqO9Ozx0drUlTQBcgxU1UDNE43rNPkRpVoh5uGLSzLWm1fS2Aaa7E9eRvj++P9O6E0GDAr6gKAP9FZpgvVowo6Ch27dGSu2160hHPAse9HQGUzXHmd00F62Ny6PZI/vubgh8CnR+iia+Fe36APxYF9Z88V95dhrnmGlHbQr+ttk+htOeb4xh0peJyAIH/xtZ59rCsqCBhY5N5LIrvuZnoT7jFc7+IB4Zd9z/xQtJ4KnAGPykCNSWMxamfrCt6Vpocihx9gbXL6jzR+qh3Jy3yz1ca96jPfc83sxRDfgBSHomI+jW0Sl1/UViftxNMRVgZbintCfKHolq5dYPaT0SOmVy3GIEONOgSxKf7ma3GpoIE3p6BMTTD2F+DTyC9AWMpwyJfrBV/3VbIfz69/R6dX7y6xj4LT8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ab18a2-8ea7-452b-8bce-08dc1302acfd
X-MS-Exchange-CrossTenant-AuthSource: MN2SPR01MB0026.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 00:08:59.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oejoRVNrappPI9vHYksjTQ1Vc+E2lM8E9IULMOK2yTGLenRxWGO38Fzeroe30i2TuHyhmPzO3XOEz/65mKPn5gV+AlP6cG/tK075/pjnRwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_14,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110185
X-Proofpoint-GUID: H9ECK4a1o80PtHFR2PiZbk7ciFTtxz_V
X-Proofpoint-ORIG-GUID: H9ECK4a1o80PtHFR2PiZbk7ciFTtxz_V



On 1/11/24 1:54 PM, Andrew Morton wrote:
> On Thu, 11 Jan 2024 10:54:45 -0800 Jianfeng Wang <jianfeng.w.wang@oracle.com> wrote:
> 
>>
>>> Unless you can show any actual runtime effect of this patch then I think
>>> it shouldn't be merged.
>>>
>>
>> Thanks for raising your concern.
>> I'd call it a trade-off rather than "not really correct". Look at
>> unmap_region() / free_pages_and_swap_cache() written by Linus. These are in
>> favor of this pattern, which indicates that the trade-off (i.e. draining
>> local CPU or draining all CPUs or no draining at all) had been made in the
>> same way in the past. I don't have a specific runtime effect to provide,
>> except that it will free 10s kB pages immediately during OOM.
> 
> I don't think it's necessary to run lru_add_drain() for each vma.  Once
> we've done it it once, it can be skipped for additional vmas.
> 
Agreed.

> That's pretty minor because the second and successive calls will be
> cheap.  But it becomes much more significant if we switch to
> lru_add_drain_all(), which sounds like what we should be doing here. 
> Is it possible?
>
What do you both think of adding lru_add_drain_all() prior to the for loop?

