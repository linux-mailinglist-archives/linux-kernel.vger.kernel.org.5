Return-Path: <linux-kernel+bounces-24004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE40182B527
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7431C23BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF43954BF2;
	Thu, 11 Jan 2024 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fpzD+ksV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dxyTpRAn"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3859C39F;
	Thu, 11 Jan 2024 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BHs4Sw027519;
	Thu, 11 Jan 2024 19:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+mkMUvZfpk0HpyzfJehyg66YDrtjHAhFHXWlU1erZBQ=;
 b=fpzD+ksV6vKDc+KqN2hhmVRrUMU0Mtb7bKPe2Ny8YR2ualAwkDFtpUWqCUwj9hUJPOyC
 t6Rv7M+Lul3djo37p8KJCB9tB3mD8HJNRGaCIq7ejCbIrueWFcaQXQjkQpyVREd6HBN4
 BOZfjhIqoiXaSFAI9Nw7hEgdMzD0L9xWZiV1lXH6FvvUSXumDOxoYkqNY6UoY4dteyqM
 t6Aw1bHrXqJEydf0I7aS+AtxgNfjuiS8vy2TroT2tOjSkzQfyJdY5XPQrz+bFuu6LTI1
 dVVSDW6Y5G5ltkPjXP3czGfNISAeLaCHt1t/Gndy2M6uB1TIj0KcmilcbzKs//S2qhR3 /g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjjb6rt6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 19:21:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40BIxDLh030119;
	Thu, 11 Jan 2024 19:21:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutqmxgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 19:21:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmKxzxCQYhCfoP123PHh2LGOQA8XCeRuPrCp11HhqFLEkldNkYWyDb6CKg9jfGbkubftsUQ2WtFL+8jWSqLv71xoN8+TDfmRTiNRrHXIwvkakrY2MvHRQMuxya8ZnrH4rKhS4QGycr1cTI/eEPmW0uukIhzgOjh1eNzi2Xc/oZHtBOwxzZ1lkZX42dy4eueofntHAufs2cp61hdwWTsahdW5eRa2tUMDMAkXBkaRi2DAJy77ACuHVN7CcKljzhE5GbBcg/kWOHpP/e3eCgZovueymXfBdqzlCr/3DpZim1gh4tMiXGfGVaj1Vz3KN49XOGCgb7K3ZbBIvwmxp38SiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mkMUvZfpk0HpyzfJehyg66YDrtjHAhFHXWlU1erZBQ=;
 b=obQktla+wuXVuJkOOnmHrQeRqMXKuVSjacOBFFB2f0UaSqgLPLYuDsGxqxGWquc9GmVFzpLZmPYkHepiHm47NMlDoy755ecSdLHVlIvmvtjkkhjgJR1j6iZr1UdGbeft7ZEecE/+90gKpIeFTZTLJl1B91a0y6RH/9ZZ90h1yElbClndP4ElY/19V/412D8/HYvZVoHpbXzb1VbhCkJMoeYhtsC/htF1z/GWcdbZGrwNDmI1UNPzCQBKTodgg90cHF+S1NhUz/8Y04Br1P0LG3OsbWaiby9inmG7+S3bQIGmZoDpLZVz4QPSM8WoYozmTHmXvQ1ZMyhliaxPt440ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mkMUvZfpk0HpyzfJehyg66YDrtjHAhFHXWlU1erZBQ=;
 b=dxyTpRAnQkT37reXP69nOrdvoJ/P3Zi3HAoh8jklfXk4i084Jphyav7wzt+RHrYEcwR7jIh1f7ifkfHY1fGEOe2vJdYWuySOkGnv/qRYeh/jUs/5JFqFDegNboOachHL2lexqHc1IIj/85KRlgqhvi1UQYeYFEOV1JZuzRENcJc=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by IA1PR10MB7200.namprd10.prod.outlook.com (2603:10b6:208:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 19:21:15 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::78b9:5082:241a:d1fb]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::78b9:5082:241a:d1fb%3]) with mapi id 15.20.7181.020; Thu, 11 Jan 2024
 19:21:15 +0000
Message-ID: <b43ed3bd-ddf6-6587-7eb2-3e081ae1d928@oracle.com>
Date: Thu, 11 Jan 2024 11:21:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] fix hugetlbfs hwpoison handling
Content-Language: en-US
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, usama.anjum@collabora.com,
        muchun.song@linux.dev, jiaqiyan@google.com, willy@infradead.org,
        linmiaohe@huawei.com, naoya.horiguchi@nec.com, shy828301@gmail.com,
        jthoughton@google.com, jane.chu@oracle.com, stable@vger.kernel.org
References: <20240111191655.295530-1-sidhartha.kumar@oracle.com>
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20240111191655.295530-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::35) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|IA1PR10MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 193c8177-41ec-4c63-4daa-08dc12da7ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ivFyeL5wQsHTwNW7yeiuvVuqrOJioO+PUeJaW7Pju3gPza4YRikSxHPGrRPKDnBzt9OPVPBHsfKpRROLM/QsmfuKS290dUG+uErHAfaskCotE1ctqzMjWJgU531Xxe1VfD1CYY7eWy+GJ7fiTC3QWYlMSLvnI2zXLEzcoiD71h9E/S3a2Z6HdU0quSgJKaHUVJu2IlccOfb/N5seLA468VAf0ofYWat3d36My3HKQTdAXhUZJ8R7fqDRlVBHaVaP6Li4eQUnHWwrMothSnmaf99TExZKkd42Jn4yAJvyNzQUIHbe4DvaGFWPmu7GgtqIv3nfEgtDEmT5erp1pvaPHztfLfIVoK0rksdlexqkeZzcw077WnoZAq2p0CbufBtAroIy0wcd4N0a2El0c6Umdn4/R4KQ0/jikXXA4PfwQ4M7NbZaWhMyVBrUj0yvBHTZ3UCW0KvXttmoF2IGQdsk8ONomLm8fqD2PbtHVIxHVH71I6kP4Wg9kNAJyC8ptXJQtuBuluxgr5o0/1TO4CHBhI3Ay4vvxj83OoTVEFYNI9eYhXn2rJMYTIexIjFUnAkfHSZKk1xZh4GNkw9r1xucUMqT2pNVaLcrsCLH9eAuxZ6ocv3s6BJD4dNBebGcWt36mFRSo06ZOX+RprMsY5zJ3A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(44832011)(66946007)(5660300002)(66476007)(966005)(66556008)(478600001)(8936002)(2906002)(316002)(7416002)(8676002)(83380400001)(4326008)(6512007)(53546011)(6486002)(2616005)(41300700001)(6506007)(6666004)(36756003)(86362001)(38100700002)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OGIzLzh4Zkh0VUVXSXpNOWozQ05BOEE3UGpFbTF0SmtiOUdpcEdkRWQ3M0NO?=
 =?utf-8?B?ejd6b3QwRkxTV3dCdlIrQjFkS1B2TjFrZ3NCSlFtSGcydzdyNDJacjRIZ2g1?=
 =?utf-8?B?TDd0V3UxVUtIclJ2djlmTmZid1NOSDBNTXhXQ2JWZk12N2lOSkRKTlRhRTJP?=
 =?utf-8?B?eDNnV2FEV1J5eTVVQlR5aGxRd1QzT0FDbG5RelMraDEyT0EvcUZRQlNFMHJC?=
 =?utf-8?B?Y2ZtOURINnAzdEVoVG5QWXdscHRILzBJNGcvMHordUVvcGY0cTdMWWRRZisv?=
 =?utf-8?B?RnROcTZXdHovSUhLQ1kvc1RKdklVekxBMkRPQTRzUkdxVis1NzJaZ2kzQXlN?=
 =?utf-8?B?UklRV0I2WTlJNGk1emJYZTBiOVVtNzdKTUR1WVltd0t2aGRUQ2lFOTNtQXU4?=
 =?utf-8?B?SzQ5MlVLd2RoUnhJRDZDeTVzVFNBNUZxNGJKSHlvSFNUU3IzaFBUcHE2WDMy?=
 =?utf-8?B?T205NE4rYTRFemxuMldvMVloNW1seFlUNVRvRWdkUFVqK24xSGczMEI4NHk5?=
 =?utf-8?B?RXZVdFB1Z2pqeGlJS2RyVkZ4N2NIKzZrdjJxbWQxQndnQUtQS1BQYnFJeHlm?=
 =?utf-8?B?K0xKTHJoRi9PQlZIZUlhL3pWT0tsRVpyZkhUWUpHUTBoZDk1Z2puVXFJN1N5?=
 =?utf-8?B?WnovZlJjazFUcjA0cndvUjNLcmEyelc5R0R2cDA0SExhNXJQdDJvdHNod09W?=
 =?utf-8?B?ZDhNWFpmRWJMUXBldDlGYTBrdEMxYnRnVmY3cFpOZU5rakQyWW0ralBBbGxW?=
 =?utf-8?B?cXpWN3ljTzBtVFhPN3ZRbnJkaDU1RjVMUGVyQVhsT0JiQkplR1dub1dTNHpE?=
 =?utf-8?B?ZUdpMHFrSnBrODYwUjRrUjNVZ0lwSUhybkN3MGZ3d0tMTDRieFRVUlg4bzFv?=
 =?utf-8?B?WHk1N2pNVGZCbjRZYjd2RS92eTI5S3FnQjZPcmRoVHJobnhRb2hEdUdVWXNj?=
 =?utf-8?B?aHQzdit2Yyt1djNJTmdKMGxNdmttZE1UTnVUTTY5M0pBSU5BdG5vTmJSRE9L?=
 =?utf-8?B?MUhTWHU5QUs0SDUvTG5NSFNWa2FiTTF2TEt1b0J0VndCWHE3UTRVcmRpZk1C?=
 =?utf-8?B?enhtYWtWSU4zRTBxK1NyL2d3UlgrUjlwcTNYcHovb3BwNlZHekJweTRGTHBz?=
 =?utf-8?B?MHNJQnpnMHZrbDFDeUM5bC9LZFh6SmJtenJyTFExaWtxdnBsQnBHRlBhTW1T?=
 =?utf-8?B?dzFHU3psaWw5Uk5JdUxWZldjUXNVMlR1b0FuQXNwcElWVU5vOVZsbGZVei9D?=
 =?utf-8?B?bWF3VTFYL2NFSFZrdWtIZEh5bW11ZWh0Vy92UzFCeWtGb3hzekpyZXlwQ21K?=
 =?utf-8?B?cmpxNWx1MEhHWWsrMlVrRS9aMXhPUWhPeGNicm9uZG1xbGpjRHFtenlmMUMy?=
 =?utf-8?B?ZUY2b1FrZXBXNWN0OHFuRzNHcWk1VnFIdzNOSndjRHl1ZTdZOUhlRUFqeWRo?=
 =?utf-8?B?bVIyVDJpdGx2ZkJFdmZMczd6cktSckxEYnVSVTNyUHp2VFROYk5qRDNLKzRo?=
 =?utf-8?B?NFlmWGFQMllvQU45WUozNzJudEF3aFFuMEI5bXpUb0hPS2ppbjAyeWZQWlN0?=
 =?utf-8?B?MVFlbmJDeUFpRjFkaXRiZ0RhUzhiVENQSGJ6My95bjM4WG9ZNUZzK3M5WDhz?=
 =?utf-8?B?T2pHQ3lHTFVOa1pwNzU1M0kxNmNhMmxsVUJNSGQzVjNHazRjZWh1ajcyK1c4?=
 =?utf-8?B?aEtLbEFQYXhudThCd01PQzNDc0I3cjQ2L2xhaU5xWmVBUzdJdytNZm0xenhT?=
 =?utf-8?B?QXNYRmxmUG1KNGhSdDJtaUZiR0hXNVVOWEJidDBDTGhIYURZSVBFNWVyY2xM?=
 =?utf-8?B?M08vRW83NW9lTXBHUUV2LzQ2QkxtQ1FoK0ZlZXNGeldzUGx6anBJeWM5TVB5?=
 =?utf-8?B?VGdmcER4T0x0UzE3YmZMcjIxRk5uYTNQWWkzYWROOHptWVZ5eGlsajg1Zlhy?=
 =?utf-8?B?bm5KOTNqSWJyS2V0VUorVUJLMjJTenRrSTZreTlkaEVsWlNFYTJXVU9wc3dK?=
 =?utf-8?B?NVRqV1FZU3JTY1lSMnVMSWVWQk1lWW1UU0F1QXEyZE8xc1R0M2VrL3lSNEl1?=
 =?utf-8?B?MEticlB3WGllQm0xRExBcERLN0NwbFRvbDdTb1NkbFZ1YkhIcHRMU0NLSXls?=
 =?utf-8?B?NHhLMVVudTVMeTE4OFkvaU52dG9PbGJYUkdWRU5nSnpJSGM5K2VRVW1sVnZX?=
 =?utf-8?Q?W6YIEfLFeqmLMOQvpw1O/Q4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IeC6Cv8TYbF6e5Eaq6zNIUI7YOdK9yVEdviiPlDThTHy1K8L+rg/XfyAUXmfg9OlLWL67zWUZ3Zc5j8Tr3reA3/Dl14uYVF1UF4JpF58ZL9u9HxW22Ct5knzmoGIHxRiXFgxenymm/BL0xMc7iTKZixpfwaBRTAbfVFpQPOROrDsaGu0IBLgElF9exnIxSrBxi+4KcL71pUY9+u6m0aiC6xVemkFVpQ8T218zjBBTkTtFUMqutt5NIPGer3rFZIhli4T/F4TsYfCPqzLEGFly5HbmEWEg7b6mmy5eczwN4wul/fWTpPriGVD10R8J6RlbTnRq4HSuqNYaeOfdfrgZ2L0gPlRX+oSu1aKge4ju7hi2zucgOrsSLIbgxcUS9SGKqI9T68T15QStyrTQJCwSkJH18p66sl5EnOSkHOdJoDAujYCu4ulw9XEwmTmSfz8FyYhpXUwNO50gntsqxNx7UaNK0b8bRFXDLUsrT8iz9YpgmZqGsDYxoKfWRLqSebx3ir+RMluY1pRfTcwqMyLBZHsaqgek0oNsn+ghwmRKIWcrbpY+Wg3kRyyOGO+Za9PpHzogKnATCNn9bLyduvHKLcInD/GhPCH1xu2LOyIO0U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 193c8177-41ec-4c63-4daa-08dc12da7ad6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 19:21:15.5048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdVgo/Trw7SCjKlNtaCSk/LB4yzlBned/lKRNn6x3tene61qvqQP4LnpCqhGGq0G2xgV2jJ0F5GEtEKe86bOrd4zUJ35MHQwat38uDYB8aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_11,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110151
X-Proofpoint-GUID: yLO6KSO2927Dit6g_TsUFbImwOCHfkXB
X-Proofpoint-ORIG-GUID: yLO6KSO2927Dit6g_TsUFbImwOCHfkXB

On 1/11/24 11:16 AM, Sidhartha Kumar wrote:
> has_extra_refcount() makes the assumption that a ref count of 1 means
> the page is not referenced by other users. Commit a08c7193e4f1
> (mm/filemap: remove hugetlb special casing in filemap.c) modifies
> __filemap_add_folio() by calling folio_ref_add(folio, nr); for all cases
> (including hugtetlb) where nr is the number of pages in the folio. We
> should check if the page is not referenced by other users by checking
> the page count against the number of pages rather than 1.
> 
> In hugetlbfs_read_iter(), folio_test_has_hwpoisoned() is testing the wrong
> flag as, in the hugetlb case, memory-failure code calls
> folio_test_set_hwpoison() to indicate poison. folio_test_hwpoison() is the
> correct function to test for that flag.
> 
> After these fixes, the hugetlb hwpoison read selftest passes all cases.
> 
> Fixes: a08c7193e4f1 ("mm/filemap: remove hugetlb special casing in filemap.c")
> Closes: https://lore.kernel.org/linux-mm/20230713001833.3778937-1-jiaqiyan@google.com/T/#m8e1469119e5b831bbd05d495f96b842e4a1c5519
> Cc: <stable@vger.kernel.org> # 6.7+
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   fs/hugetlbfs/inode.c | 2 +-
>   mm/memory-failure.c  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 36132c9125f9..3a248e4f7e93 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -340,7 +340,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   		} else {
>   			folio_unlock(folio);
>   
> -			if (!folio_test_has_hwpoisoned(folio))
> +			if (!folio_test_hwpoison(folio))
>   				want = nr;
>   			else {
>   				/*
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index d8c853b35dbb..87f6bf7d8bc1 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -973,7 +973,7 @@ struct page_state {
>   static bool has_extra_refcount(struct page_state *ps, struct page *p,
>   			       bool extra_pins)
>   {
> -	int count = page_count(p) - 1;
> +	int count = page_count(p) - folio_nr_pages(page_folio(p));
>   
>   	if (extra_pins)
>   		count -= 1;

the patch title is missing a fs/hugetlbfs: prefix, could this be added Andrew?

Thanks,
Sidhartha

