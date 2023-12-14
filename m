Return-Path: <linux-kernel+bounces-264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA06A813E72
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9191D283CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7B52DB9C;
	Thu, 14 Dec 2023 23:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iP5nuzlU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D4qz/Rdn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044A92DB65
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEMHO2p032542;
	Thu, 14 Dec 2023 23:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=PE15cxvoWVkDwemZm6Q3fshZA2pegTEghYzghOU9IuE=;
 b=iP5nuzlUg/CWYYG2EO8FVT4Q1osx9HvpSusAXANBmvxeiH1SGGHB2zzsW8z0DCB6jFyj
 rSqFXvjucAEoGKAbjuGd7/LKFC8t/pXLgKSNR2pQFmRY1+tUJEBNgogc6p2WU7RYbkGo
 qlPUv0XrKbkSHLEaEIHvfwQ7bEtFHSxfPXt6l+SDfDXU9f8i5yp7Pt9KxK5CQgYLuyvi
 gS6rINORMNolwU/7hcpbxPqsernuavt1/Ft2TkgKkkyGzE1RFgPSw0viQu01rmVh3gwc
 j531HR0fpfsYUxHikJpeqXt5th9UFKHaDr9DHx7sZ83lHPGOteAmMlaESif22x0EX/qc Rg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvgsum4ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 23:56:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BENY68H018236;
	Thu, 14 Dec 2023 23:56:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepb1kmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 23:56:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Li16tSRRh/suAE4UZl2MZxEFHTX6Q/XvEoSPFpCv/qGL+Kv1xt3UVjkcuEQi6woKnYcXft5WwE/3YdDsmQQwcLyXEj0w4aOt1RO/XU9UnblpydUUmkOzSAjUHCbUuyWlUfwTSfwHY78KmEfeh9Rr1b60+n3qBnIVlWzF/9RUfOIxvgluXvRQORdKitSsCtIi7UYdZlkUXSQO/qXVt1NcUY55rHCqd9eiOQqTmByVWDAGNKgmyfYCDpggFkiS6S18goVrMlvjJfNGoIu3ZhdAiJdxtlNPRCg9JcNYWdZDAPSN2j7PtHbfs8yXw/1kdrZAdi8iAxrwSIPx7xWEu4Jg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PE15cxvoWVkDwemZm6Q3fshZA2pegTEghYzghOU9IuE=;
 b=TDQqswPkt0FLwaJizXmslODcfvFIu7j9jFvosTbClnwzr6b2qkjSu4lYrgodC2mBGI1eUGDL1HO6GX0wSO3lYU4rOgMsdsvcCS2Le3Uq1IZnBdsGyO3sck3svMMBHFpvAjlrOt1O75C+SkjQxwsuBY/tvDK0Mc/vvM49WoM5A42fMtLCrF3dt+oSfqkE0mtEsjYyjYaHflfFLdo3bklZ0H8pgzgCRAebdDPF5J0UhLldMojgJwDz4dMuGkk80b+4AWfUg8UZoE4bCKg5tZkvams3WftLor94O7uxvIGHWFKlaKWJ0hanI7ufaQEZZ6/12/eB7U5PLWQgY/KJOxH5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PE15cxvoWVkDwemZm6Q3fshZA2pegTEghYzghOU9IuE=;
 b=D4qz/RdnaE/VE5kXbEOdxl70TBw/ShwI8Ekfn3+0eha9QyWA2MQdWIOpixsQEOPX43fX6lANuDFe14YNpIK8g39SxLV0uoLp6yiaQowzH5UsAGMrtjJVYp9SxfTj7+RmHNbQ4zln8wTcQmNV+72OSCnv6yIR+hlY+uWzKWrM8TU=
Received: from BYAPR10MB3558.namprd10.prod.outlook.com (2603:10b6:a03:122::29)
 by MW5PR10MB5875.namprd10.prod.outlook.com (2603:10b6:303:191::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 23:56:37 +0000
Received: from BYAPR10MB3558.namprd10.prod.outlook.com
 ([fe80::2410:62eb:80e:cc7d]) by BYAPR10MB3558.namprd10.prod.outlook.com
 ([fe80::2410:62eb:80e:cc7d%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 23:56:36 +0000
Message-ID: <cd587281-093d-4eca-8eb6-81d589573e32@oracle.com>
Date: Thu, 14 Dec 2023 15:56:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH v2] mm: remove redundant lru_add_drain()
 prior to unmapping pages
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, tim.c.chen@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231214222717.50277-1-jianfeng.w.wang@oracle.com>
 <ZXuJKAInbgtuSU9b@casper.infradead.org>
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
In-Reply-To: <ZXuJKAInbgtuSU9b@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::12) To BYAPR10MB3558.namprd10.prod.outlook.com
 (2603:10b6:a03:122::29)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3558:EE_|MW5PR10MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 6927d088-acab-42dc-751c-08dbfd004e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SW/w3kpMfW3ZPRbfRQC/FJbY+ktq5qTZowzFP9kJU2uo2rPkWWpExVCWMgCn4jx0JdIrPN2o2raudew4NSwgayqGU/hsvCiz9CS6Os1HWjHo9hBGRnuOnIjDO9AD3yvUHMZ52NicgjbHkudd4L1giI+kEzzD9mN5ZX9e5EDGZlP5FMHli6GRz3zKEp3kUQ6YGLMTp0W3gUC58JGk+o8VHQIGMc47e0IGEd5xinfBW/peW8DL6BwyPV6NGe6k0zhIFm79dm2mcEfPxAfnBxWFpzpxD27pfkNjkcDyvsePvi+byoYV/p70kKHkC6ybIJCw3D7L7rCFaWuQWQ4rdXybGCHHueg+ztNqEUp7BSfV/v6deqhAjt5CGEGUDvLQIwiz4JFCd24wZU/4/ozqXL7i/qPWuout7uPnvOa7dBQ9NHfS0nJWCt5Uw3HhgHAy8kyKBEkHPRqleeKFobFgBuqQvnNLlq3S9QwWgMkFeZbGYLsnRVeDQr3w61QVfPKinGAJO/Bro/Gn3XFvGq+crt/Pvz+lMvnD5Ua6VDbo6Mu3m56KN1GCq7f//mOtlJt0fSCd09wpTX8P6vE5VKpQcF4wxNGgp2RRceCiiuQb5VpbfmP5PZCPuFxh41DxRBhlmwLWBt6AJGHD3yneHLeve0+1aA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3558.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(346002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38100700002)(5660300002)(6506007)(6512007)(53546011)(8936002)(4326008)(8676002)(66556008)(2906002)(66946007)(66476007)(83380400001)(316002)(6916009)(86362001)(41300700001)(31696002)(478600001)(31686004)(26005)(2616005)(6486002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TjFhRWNvSS9EQ2FnY241L3hFZjJ1ZkkyYit5ZEVoYXkvQytZQkQ3NVZEUnND?=
 =?utf-8?B?TWFkM0hrbkFUM0F0ZHhZM1h1MFFESlRac2dZaUZwcWNRTi9rZVVNb2haejQv?=
 =?utf-8?B?WGJxdlBSbnprYjF0ZlArZmFWUWloZU5NRGZYZFpiSWJkS2c1NElmdkJkVzNk?=
 =?utf-8?B?d2dlcFAvdzA2KzBqMzluY0VhWjBIeW8zb0dCZWIvSkhlOTRtVzNpMVY5dkx6?=
 =?utf-8?B?ci8zaVcrMXFiWUp2aktnWnJlcFlnaGxnNytQQktVSXRhclIvUnZvQzJzeU5P?=
 =?utf-8?B?K2l6RFZqK1pVRlJmNWNrK3grbjN5Y0p3djd1ZG1LdUhiL05PNlNoN2lueHVw?=
 =?utf-8?B?dkhoSjBVTnlaSHpoZ2lwRk11Y3RBSWFvN0FwdE5FeTFzM1Y4dUJGVXJGQVky?=
 =?utf-8?B?czczWHpmRXV2cU9ITGFTWUUwT250MEdrTWI4NVptbXZzN1UyU2RGMlh6alVh?=
 =?utf-8?B?U2dWWWwyRVNFWWxvajFlWkVQSFpOdUdMWnBzQi84UGdhVXprZmloTWl3d21R?=
 =?utf-8?B?djl0M3cxa3BnUHRPV3I2TjkvYVQwSEdFbThHSXkvOGdaRm9HVU1XQkNJM0Iw?=
 =?utf-8?B?SEt1YXNOaU9EZkwrQkg3ZWk0c1QxY1NxSC8vUkF4NVBVTnR4UE5OaTBXSmlK?=
 =?utf-8?B?MTAzSFZqdDlTUFJ1bzVOQlNVSVpTRWc4RG1kK3ZIRzFhUzFCQU1VVGcxbEZ0?=
 =?utf-8?B?cll6YmVZUmdud2lIQkxXeHl4NGZFNkIydEdRWVlxeHZLVjlHMkZQc2ZNc1Fx?=
 =?utf-8?B?V3c5RU1ma2FEWlkvMkRRQTgxRlppRlJQTi80b3JKWnBVY0tSWk5YbzAxVE0y?=
 =?utf-8?B?bFdMZ29uYWphaC93S0dXNDd0U29yd21mOGYzUk9nZ2FxbzZNcFg5cnVSZjZ5?=
 =?utf-8?B?czU2emllK00xL3lMaitOU0JScnpLUUM3MTVYekUvL294T3JsWk5ZK0F4bzVH?=
 =?utf-8?B?MktWQzRncDlhY3F0WnZ0TUFybnNJRVVXU2sxZEFnWS82alZZdEtvbGRodWcz?=
 =?utf-8?B?WGZmRTJrNi9xY2F5WFdSSXJiNXpYQlFrNmx5b1RLTCt6UEpsMTM4MFU5bFRx?=
 =?utf-8?B?SDF1VWQ0T0Exa1FuNTJrUmtsRThQTld4akQwSDR0cnJDRmQ5T3Fya2xFd1cz?=
 =?utf-8?B?QnpRd1M0NE1JYXRVaDVhbVk5RTBQdGp6dVF4eWxCS2JUUFd0VUpaTURhS2Jo?=
 =?utf-8?B?c3JSQ1ZHUkFaRFNPSUI0SDNlKzFkNlNjOHlkcDhBRFJRc3daWmh6VU1rMWF6?=
 =?utf-8?B?S3hkQTlzOUpuckZRWDF2dTFPSm95WWVDdDk4QmNTUXAxbzhMdVZsSnRGMkdu?=
 =?utf-8?B?aWtHYk1uZ2ZDOHZFSGlLd2NFOEtvc1pyeHgrckVkTTRXSE1pNXU2MjNmRGJ5?=
 =?utf-8?B?SVdPa3RuYWRjdGlsWEc1TS96cTRoQXNtdmgwU3BVbGV1djVnWmI0ei85dHd3?=
 =?utf-8?B?cENVUWpYTHhOOVQxWEpiYWFvNGhkcGxmeTFDQ2tNK2Q1Rm5teXMxSEM0RHBv?=
 =?utf-8?B?N1Bsa0F2MklKUWlwUmpyWUtxTlpIUTRDTWRIckRWbWVJRnJ0U29zRE42ME5m?=
 =?utf-8?B?czMzUk41R01yVHBISnBPcU1wbDQyODlNdTRoSzgvRUZ1Y1NabkNOMnhyd2gr?=
 =?utf-8?B?UEFmOTZ0NzJBNmRsU1EwM1BjL3A1dkVhaFNIeWRRUWlLRThPejZ2aHdaaEZI?=
 =?utf-8?B?YUhCNlVGa2tPQnFrMnorZmQ3SFAwNmx2cS9JZ0hSY2thdFNob080MGdCYVFu?=
 =?utf-8?B?UnZCbGNPd3RJeWloQzR1NTM4dldRb3F0RzBjVGVjWndMYjFvM29jNnk1S0lQ?=
 =?utf-8?B?b1F5Rk14bG5TUVZBV2x2WFRLTjFoakdmK0dGVlJOMUQrVlhOemhFRkNtNC8z?=
 =?utf-8?B?NjNmRnpkTXZINmJKWjlpQ3hyYVAyYVV2ZzFvYVJHVXh4aUlwTE5scjVZYkEr?=
 =?utf-8?B?bHl1a1VvYkMxVFNlKzZhdkNJQWFCNUFVR2RlVktBQ0plYThwenBtTHo2WlFI?=
 =?utf-8?B?R1lKKzBTWGVmWTF4UDZzTCtNczZaVzFWR0NEM2RpdkhLcEpjSTRxek56ZVNu?=
 =?utf-8?B?cENJQlZaa01yc0hzVisyWVpkbm1zeGV5Wk9ic2dhdHZsRkNZOFRsODJrdjUz?=
 =?utf-8?B?M3RJT2xHM3ZTVUk1Nmo4a3lOcWFOU0NqYmdYQnRrZzFTWmlCNVFkVHNkZk45?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jEG+dZaLpiA/9ONu6bupMZP4AxnViy5o5BUkkCr51SDrzVUcbPgylHOwjAMxLhyKEXxObrkgO/CyRumU+9geP5f8qBKHY0ZIINi1CXgTaT/WKyFmoeHTov6OtPWybNkS8Z4ZZvLhlYb201rlxG51e68zLrEwaXlNHIGGOtUUxUXhCym28L36CJfDEwA09K/8ZoZnZp4hLO0FgBcY00k5Ml0CZHImsaYWnKX6TvG1PWfZsq86E15+STdyOk1WavX0MHZRWeCZqeRaLsPgqrVaj+Fj/DCrqdK/qhK/pg5fgxxzQtThYc0LevmVSeA2sO7RwWf1sdM8wE45WWwVFyFCRJhOEBvHEAE+0mu9TDueZO0L2WrpPtz2x1xCPGsBtPLWUIlXYowLcSdVsAtJRubKUYsBb+kW9hmKFjPPVwK9d7Ha88S0euQlbcUMIVHDtel7d/54SEgA04ckMu0f/GWJ7IpobRhjkI1BNojfhYVNcBRwPzngTrtPOwtz/vWrSfWY/RMqjNjmlzBcCiRZ9Klct1T0zOlYR2nXNBx69q74tXE/78R1OAREE+Bu3fdGcormOXGhPvQeQzrkuXJt4gFrHHXVT2LBfM8H1TiKUHWmg9YiJFE6lijpFAbR0Svo94C+ToR/bm4eUC7UIkJB38X+DF6VTyMU/lzu8GC6S2oekDId4yri1M6z/0tmwVOhJL4u6kIxEcmFpMePa9TlJPecRcaGmffsoSXZtHJWnuMY+o4GBN2ucFSqCebgAgzX78gAGY1cEjGMMFq/7DQ/EYAZJUo0KFgOPIwknudbHTzW4EKdA/7Y4XGMCTMbrV2mfOELIqPNnmsTMRxeuZf66qD/aMhCmPXsiMST22e33tv2BiIuzo9oBj1lvzgFtSaWZ/mo7LCtZvbDK9HP6ellxGDTY3S9SSQgzn6Fyup8uODapRA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6927d088-acab-42dc-751c-08dbfd004e98
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3558.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 23:56:36.7228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TdK7TcKdTaN6zWgt1vDaY/GsbfseVM/PHiXLWxidYROo8st/6fqoESoShUXakmxYAD/+zRdXOQK0ZC7I9Wzjh5d7StQq18C7MMyWgpnxjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5875
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_15,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312140167
X-Proofpoint-ORIG-GUID: RCoxFebgXiWNCyA-cG53PbUB0R5cIJQ_
X-Proofpoint-GUID: RCoxFebgXiWNCyA-cG53PbUB0R5cIJQ_

On 12/14/23 3:00 PM, Matthew Wilcox wrote:
> On Thu, Dec 14, 2023 at 02:27:17PM -0800, Jianfeng Wang wrote:
>> When unmapping VMA pages, pages will be gathered in batch and released by
>> tlb_finish_mmu() if CONFIG_MMU_GATHER_NO_GATHER is not set. The function
>> tlb_finish_mmu() is responsible for calling free_pages_and_swap_cache(),
>> which calls lru_add_drain() to drain cached pages in folio_batch before
>> releasing gathered pages. Thus, it is redundant to call lru_add_drain()
>> before gathering pages, if CONFIG_MMU_GATHER_NO_GATHER is not set.
>>
>> Remove lru_add_drain() prior to gathering and unmapping pages in
>> exit_mmap() and unmap_region() if CONFIG_MMU_GATHER_NO_GATHER is not set.
>>
>> Note that the page unmapping process in oom_killer (e.g., in
>> __oom_reap_task_mm()) also uses tlb_finish_mmu() and does not have
>> redundant lru_add_drain(). So, this commit makes the code more consistent.
> 
> Shouldn't we put this in __tlb_gather_mmu() which already has the
> CONFIG_MMU_GATHER_NO_GATHER ifdefs?  That would presuambly help with, eg
> zap_page_range_single() too.
> 

Thanks. It makes sense to me.
This commit is motivated by a workload that use mmap/unmap heavily.
While the mmu_gather feature is also used by hugetlb, madvise, mprotect,
etc., thus I prefer to have another standalone commit (following this one)
that moves lru_add_drain() to __tlb_gather_mmu() to unify these cases for
not making redundant lru_add_drain() calls when using mmu_gather.

>> Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
>> ---
>>  mm/mmap.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 1971bfffcc03..da0308eef435 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -2330,7 +2330,10 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
>>  	struct mmu_gather tlb;
>>  	unsigned long mt_start = mas->index;
>>  
>> +	/* Defer lru_add_drain() to tlb_finish_mmu() for the ifndef case. */
>> +#ifdef CONFIG_MMU_GATHER_NO_GATHER
>>  	lru_add_drain();
>> +#endif
>>  	tlb_gather_mmu(&tlb, mm);
>>  	update_hiwater_rss(mm);
>>  	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
>> @@ -3300,7 +3303,10 @@ void exit_mmap(struct mm_struct *mm)
>>  		return;
>>  	}
>>  
>> +	/* Defer lru_add_drain() to tlb_finish_mmu() for the ifndef case. */
>> +#ifdef CONFIG_MMU_GATHER_NO_GATHER
>>  	lru_add_drain();
>> +#endif
>>  	flush_cache_mm(mm);
>>  	tlb_gather_mmu_fullmm(&tlb, mm);
>>  	/* update_hiwater_rss(mm) here? but nobody should be looking */
>> -- 
>> 2.42.1
>>
>>

