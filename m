Return-Path: <linux-kernel+bounces-23994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A0582B4F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9421E1C231F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965C154BD7;
	Thu, 11 Jan 2024 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GmRNYWxN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qC9MwQNb"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC818E09
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BHs6Om027571;
	Thu, 11 Jan 2024 18:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=rKfRgwMZmlF5BvgPh1uNNR4Xnjo5ctCVbqxS8IV05p0=;
 b=GmRNYWxNG1CGIecCeBSDS+zwfj6DUsan98HxLgkYGHK1JkKEQHEc8EcuyyY7kNeE2eCY
 MtcKRHT8l2X8NHNvKUzgbOZ+/RdNC6iK0YwF8deRrxzPiaJE/iTcfEhN+iEtpG1mEA3w
 qqpsLEusYeA6jV0hbGqm5/zrnca2MwFSuzlf11muqCOdZAt+9J6L9PnSwvBmTvu7KBKa
 1sCf7CbsA75B4mI2TJwwqqRs/RgI7ju7Dqs6QI0XXx9OOC3RWvdzF5UA0GhqYLXYZ+/r
 lJ410Dnt5+g5pa4VLEqPEYU8BLWS/HpGceo4vKGoKp6hAYRArqHy8yzHZPdo/19MYaez Ag== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjjb6rpsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 18:54:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40BIZxCF012162;
	Thu, 11 Jan 2024 18:54:49 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuwmduuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 18:54:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPd6xwqWkYJ1tuEfzPwUs4rPNJedwmcgWNQfuYOt8zIQmTuTN1ld0VbljIMmjgIOy2Fus51/qg1EEaIyPUyTq6tKWbBzHX6eUhtbU0jKsR3Nyf3JG+7GAZukIFFaaOY0yc0W17tG68f9U3Zu7WqIWmftOsS4htNeawsJQ6Q88i9RsUh8qgDeqGaAes3o+kUcFYUDX4yG9TF4/NdvSAIXNcEurRHHP/usBMQDZEnYjem7YKqAnT0M8P7qCirAP+ROTZ7INIpiQ9M0kIeX6dzvLyoandmmiP9EjZtdAwWTabN4YWQfeXBh1a9hUILWsq3AEWNM9QVNl9dLO0GCJxn37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKfRgwMZmlF5BvgPh1uNNR4Xnjo5ctCVbqxS8IV05p0=;
 b=n989KJF8mJo0fW2OBb8jLSgHHxgYTgVN3F/6wRpP7VCQrI3t+/whqsp0+g4r6R7PyU3UpJxIpwDiWwMhk+4NwbfhwI5Oa778OKOdppjzQs+rocTW7dj1cQcpR/zqSvP7ZH2BZ0HaR5d/w3bLU3UQA0sQ6Fal2Y1b3uCb1MWAepK7TbGBBkUao1+DI9eKzHiPhzlVPC1xXzHj+Agi7svZ6tTWQBPaO32AcGIB82kyZTTwfMq0dyT6hrmAfYTtW6UM4JRQ31lHNcybYG1dU5w2ZiosGulMgTtcarBeTbi3Us8m914224H7A0xWIPTjWDlo5RyPfwuH113FVNxqfHLTUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKfRgwMZmlF5BvgPh1uNNR4Xnjo5ctCVbqxS8IV05p0=;
 b=qC9MwQNbuDQsuCBeNOQmJhUjBehrknm980K5+T1mdjya4qTZuherXYE6eRGaVTk9yqnesdeRYTjq0hzhhcVKjFOoJs8bA1FkgyBQUnW7aQ7fAe/aA1AFzQwzm3tP38lzLr2jlRA/hYE/+UkcfkDLue7Ju/gBfhLg7cCANJadjes=
Received: from MN2SPR01MB0026.namprd10.prod.outlook.com (2603:10b6:208:cf::18)
 by CH0PR10MB7437.namprd10.prod.outlook.com (2603:10b6:610:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Thu, 11 Jan
 2024 18:54:47 +0000
Received: from MN2SPR01MB0026.namprd10.prod.outlook.com
 ([fe80::7dbd:113e:6ce0:23d3]) by MN2SPR01MB0026.namprd10.prod.outlook.com
 ([fe80::7dbd:113e:6ce0:23d3%7]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 18:54:47 +0000
Message-ID: <b2096bcb-bda6-4831-85a2-67759e783e4d@oracle.com>
Date: Thu, 11 Jan 2024 10:54:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, oom: Add lru_add_drain() in __oom_reap_task_mm()
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20240109091511.8299-1-jianfeng.w.wang@oracle.com>
 <ZZ5Zb3FYqY8FZgB3@tiehlicka>
 <1d866f1b-94b3-43ec-8f4c-2de31b82d3d1@oracle.com>
 <ZZ-q0PZ-XCDwA4oG@tiehlicka>
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
In-Reply-To: <ZZ-q0PZ-XCDwA4oG@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:208:c0::22) To MN2SPR01MB0026.namprd10.prod.outlook.com
 (2603:10b6:208:cf::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2SPR01MB0026:EE_|CH0PR10MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 839b779a-0701-430d-fe03-08dc12d6c893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	B9FIrcND9FglEnARSqr5oaheJrQiE2TTYUN+22J8g86MPGCAvmjr/8W84DgugF4YL2nOiiRzEI1F9ui4DLbN1fTZQsQW3Y3uVONct31d1QQkpXm60JqvyG2lgJboBw/vA9zrWWtIb3afbsb7aRjRN/SKQKFBV/Bs6TK0D6ZZmPv7F9ZBXkGwH/enyvJGZE3x4OpHCKQ65D4BKY10QtvtHKRDKttnRBRipU3FIkpuGmZiadHicTk6ki+qTjK8CPwBZG48loBplD5FDWIb8vcLCrQfXY8obIqRu4gr8C3ahShooXJSU8RqxbW9TFeWnZKB/bLOHHje9wn0ZVBa508DOraYRpuXOI4t4cef27fGuz96nhPG+UcLpFKwotorRLlEDaN6Wu7y80R9MazKDqXtqZeM9F7joHwcpxJQWEcHWOH/Ow+ueaoYInrPoHGSb6Nh2WsWIN4XHLnHhyLW4FPrz66cpvB4m4HwY068Iu50Uu89APSrsyFznJOG+25P4WJqwNE6JY22fzq9cn166iF6PvduXGdJ7GBc4gLdytoPjRa4LYfbZudBzllzYMUw39vUY/yiYd+B/hucD78TX/oNtlC8c8i/Kwv3kHTU/dYZHf0TNzjWc4IF/WZo+lzmnpnF5kzCu83iXVgsRsFK5WE2+A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2SPR01MB0026.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(2616005)(6506007)(478600001)(6512007)(53546011)(83380400001)(5660300002)(2906002)(41300700001)(4326008)(6486002)(8676002)(8936002)(6916009)(66476007)(66556008)(66946007)(316002)(86362001)(31696002)(38100700002)(36756003)(66899024)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bzd4T01yRkNhNkZDcXhnenp4d2lObDdjN29IZFh0WFcxZkwwUDZiTmdiUC9x?=
 =?utf-8?B?QnVubDhDT3NNdU9RQk9ybTVyMC80WEg5cTB4TmdpVG51QjhiemRRZ1pFbGQw?=
 =?utf-8?B?cXJGK3dpNlZCb0xic3R6M2xOeHd5eFliR3BhZGFpQkZpWnlXV3ZLM3pwR2V3?=
 =?utf-8?B?R3hmbGRrRCtyQXg5NzN2cDRZVXV2SDF4anJjZy9qVzZCUUMyNVRkcTR1clBp?=
 =?utf-8?B?d0RmMk5oUXloU3VsYkk2MVkwaUVFSXpYRXMwSExLTWdoMzZycWpKYU1Cc0Qy?=
 =?utf-8?B?THcxdU9EZXlTL1AxRXdCT2J2L3JYNkJhbWZMNGRlUnBLQU1aSVJPcW1rc1JQ?=
 =?utf-8?B?eWpZQ1lvWUhhbjhtckI5SkR6MmFuR0w4d251a211TStHaitrRlJpNncrTzE5?=
 =?utf-8?B?M29ITjBJbEI1ZjFoTmZJbmJzbHduY3d2WmorNk96bklneElyd1FJNTdscE1P?=
 =?utf-8?B?TDh0bitoRmg2aXRJa0lyUndiMG5VTFhITGVrSWhLRHdYOUVxWFNabTdOR1JN?=
 =?utf-8?B?MkdSNnlZekFVWW9CaHlPNUFkYWZFNXNHa2draUlKdHBoZTcyNXJwZm1wa3pl?=
 =?utf-8?B?ZVZZc21GWHFMNG4zWFVXSmV3SVlmNU5XY0VEMkdEUnFNbkJtN1lOTjNNYVNL?=
 =?utf-8?B?c2tjcFUxbVFrWmdtNHhuUGRqOFBReDVVdHQ4aGNKbVpyZ290ZVhyZmhKSVFM?=
 =?utf-8?B?R2lYZS9IOFpHbnlFN0xFZVZuRHNwYnpKUWRZYkhzeE5iM2krWWwrUFlaUnp4?=
 =?utf-8?B?dmN2U2FQRDA4N29DR3hRK01udVVRbzNmVTUyelhEb2xCOE1VZFMxc0JxM3BC?=
 =?utf-8?B?bDJtbkwxQ29VS2MxOGEyV0I2eGNhK1libVd1bURERUg3VUZydVdEVklmUkMw?=
 =?utf-8?B?TGQzVlpuTUtQTk5CdmxXZVZobDZDYjIvSmovMElDaTduSlpDdjMzd2lsclF1?=
 =?utf-8?B?TUY2d2JLa2tGSmVtNzlTUWREUUpVWitmU2cvSXZIQjNyZzNUYVFMM3gvV3pa?=
 =?utf-8?B?SXlsN3k3aE5DLzVvcWl1TG9iaEtlcHh0Z1R1QUZoQ1JlUWdvRk5MMzUxbXRU?=
 =?utf-8?B?K2NzWDQvVFZqSTU3YmduSzQyaW5iU1pGZVRWOHZHalMwTTdYckZ2ZXQzYUYz?=
 =?utf-8?B?dDZWcm9KbDN4OFVKZWQxcXIvWUxTaTJ6VFZBUXMrNVRvNWRvYjBQeEViTGlj?=
 =?utf-8?B?VzRlWEowVmJFWGdaUDA0cU1EQmN1RTRBMDRORGFWZ0hEVUZEMmFVWDRDTEln?=
 =?utf-8?B?eHhCWldBYTZOcFlhaldtbGR5NmhzY2JtMGkzUklQTjVTT21ET2I1bWhMbnZG?=
 =?utf-8?B?OU95Q2VaNVVqNXdUMXNCUHpmSjl6Wmk3aEtabmZkV2hqa3NMc2xnSXVEOWNK?=
 =?utf-8?B?S2tJMFpjellCSDh2bkdSdmMva0M3RytTeU9wU25SN0V1bUhTOW9HaGtMWUFT?=
 =?utf-8?B?cElVZ3Zid1o5NnRHbnc1WFM2MWJTOHFadlAwM3RKbmtnR3B0NXRFRU9yNy9Q?=
 =?utf-8?B?R3F0V2lJVmY4UStrTzBmUFYrNHpaTHViK0FTNzJ6QmkvbkJNUUpqV092VUhl?=
 =?utf-8?B?QUFpMVE0SitSVk4wNk5BenN1TVJrdjNRT0hhQVRHK28rV3JaN3FCMlhUNEtk?=
 =?utf-8?B?L1kzTERQOGJxMy9BNkNjbUUrVUVCSGxzR3p1YnprNnAxUkMrRGxkalZDb3lT?=
 =?utf-8?B?c29WVFlLakdPeDJiWjFJWDFvejArblNUQUFYdzZ4TVIxUzZIZlJ3VlRpbDN6?=
 =?utf-8?B?V2ovcCtrYTF0TDJwNG4xa2ttZkVzWktyelhFalQrOUR3YjBYRklmZ0FvUzR1?=
 =?utf-8?B?VTZnbzF6RVpkcDhENHpXVGlBVERmUGxuL1Y4QmlndTk2a0ZUbkNpSjlYOUZG?=
 =?utf-8?B?WEhQak5QL3ZTbXoxK1BRdmo4ckl3ckIyeGJ2SDRjbjl3ekFCMHJqMXdjdjR1?=
 =?utf-8?B?RVNMNEt4cWUwV09sM0NtbzNuRlQzdXIydDErRG9nelRNYjFuZ0huelVFeUhZ?=
 =?utf-8?B?RFFqak80Mk9oOGtPUFRFcnpDRDd1blZKdUdmVXVrZHliT05kUVl6YW9OalZN?=
 =?utf-8?B?MGd3K1N2bEp5cnF6UDh3bXhDUFNhSklpd0hQdlpEL01Nd0Q1dGhEL3ZtRDY4?=
 =?utf-8?B?MDltb3BHWStTenU4NWJuVlU5NW1kdDZsdkxJaXdsaGNJa2NLSGRLWTRheGNj?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5+LYF6rO/7avDb7lzx81C8+4TAcGZ18NXT6e436MSItCF1Oj1gOXCtJ9ImJx3AW5mXvGMay00Hsxkss+L9Qw/eUDD3Aw35rRnsLAXUb8Ih8cjKHMSNYq97n3J5UlUZAlaWt3KwXfyzL1iKQuBm8QNvEs3n9CrlJewoMTENSR6vDRvmwaRHF9fZ6sqYyy7H47bfk6/jG82SwKaFzP01pKB5MATpRS3NdFAai6+GrWeLCzJQSYF3NwUT9ii3qoQzkLqyoM4gjlGxrdL+lInVwe/qnphdHtKvbK5z82YQVuI01sfTTcwOcKMCzl5usqlCs14O+Vs6iAFod0p1HVr8s0daCqass/1/el5vsCTLHp3lV9MIKzm5nRkI+oWPR9VWQLIUMP8JGl9t3XfoXy8Eqj30DIq8uq39D/sahSNZbZAHyFxPadQMDBEEQtngZ0/F4Rzs7PH9XrFKmU5siu2l43rvABJyCOn8Fyg4sqyjt3NOnvMitNADuflh5UWSbsCUoWGXl5yecLc/HK8pa3ZUnD6Wkinwq1hpfcaSeGT4/ySgFejreI++0NvXvnt7gP3g0/apD4LDriNKURyb21aCbxAIg5vXKIXxAUyvVbXy+mLDg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839b779a-0701-430d-fe03-08dc12d6c893
X-MS-Exchange-CrossTenant-AuthSource: MN2SPR01MB0026.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 18:54:47.8364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMiK3yRNC2Xu3zqk+d9Podw2CFiG9VbMbDv6NoXrGLUwqBrYJbF322LyVveDRVaHTZSDkuvMURaZLFf54zjfNZPF2pqWKql6LqNQ///bT0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_10,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110148
X-Proofpoint-GUID: MFrnyKBCorDDXkv9WWkxWbZVo2QaVHL4
X-Proofpoint-ORIG-GUID: MFrnyKBCorDDXkv9WWkxWbZVo2QaVHL4


On 1/11/24 12:46 AM, Michal Hocko wrote:
> On Wed 10-01-24 11:02:03, Jianfeng Wang wrote:
>> On 1/10/24 12:46 AM, Michal Hocko wrote:
>>> On Tue 09-01-24 01:15:11, Jianfeng Wang wrote:
>>>> The oom_reaper tries to reclaim additional memory owned by the oom
>>>> victim. In __oom_reap_task_mm(), it uses mmu_gather for batched page
>>>> free. After oom_reaper was added, mmu_gather feature introduced
>>>> CONFIG_MMU_GATHER_NO_GATHER (in 'commit 952a31c9e6fa ("asm-generic/tlb:
>>>> Introduce CONFIG_HAVE_MMU_GATHER_NO_GATHER=y")', an option to skip batched
>>>> page free. If set, tlb_batch_pages_flush(), which is responsible for
>>>> calling lru_add_drain(), is skipped during tlb_finish_mmu(). Without it,
>>>> pages could still be held by per-cpu fbatches rather than be freed.
>>>>
>>>> This fix adds lru_add_drain() prior to mmu_gather. This makes the code
>>>> consistent with other cases where mmu_gather is used for freeing pages.
>>>
>>> Does this fix any actual problem or is this pure code consistency thing?
>>> I am asking because it doesn't make much sense to me TBH, LRU cache
>>> draining is usually important when we want to ensure that cached pages
>>> are put to LRU to be dealt with because otherwise the MM code wouldn't
>>> be able to deal with them. OOM reaper doesn't necessarily run on the
>>> same CPU as the oom victim so draining on a local CPU doesn't
>>> necessarily do anything for the victim's pages.
>>>
>>> While this patch is not harmful I really do not see much point in adding
>>> the local draining here. Could you clarify please?
>>>
>> It targets the case described in the patch's commit message: oom_killer
>> thinks that it 'reclaims' pages while pages are still held by per-cpu
>> fbatches with a ref count.
>>
>> I admit that pages may sit on a different core(s). Given that
>> doing remote calls to all CPUs with lru_add_drain_all() is expensive,
>> this line of code can be helpful if it happens to give back a few pages
>> to the system right away without the overhead, especially when oom is
>> involved. Plus, it also makes the code consistent with other places
>> using mmu_gather feature to free pages in batch.
> 
> I would argue that consistency the biggest problem of this patch. It
> tries to follow a pattern that is just not really correct. First it
> operates on a random CPU from the oom victim perspective and second it
> doesn't really block any unmapping operation and that is the main
> purpose of the reaper. Sure it frees a lot of unmapped memory but if
> there are couple of pages that cannot be freed imeediately because they
> are sitting on a per-cpu LRU caches then this is not a deal breaker. As
> you have noted those pages might be sitting on any per-cpu cache.
> 
> So I do not really see that as a good justification. People will follow
> that pattern even more and spread lru_add_drain to other random places.
> 
> Unless you can show any actual runtime effect of this patch then I think
> it shouldn't be merged.
> 

Thanks for raising your concern.
I'd call it a trade-off rather than "not really correct". Look at
unmap_region() / free_pages_and_swap_cache() written by Linus. These are in
favor of this pattern, which indicates that the trade-off (i.e. draining
local CPU or draining all CPUs or no draining at all) had been made in the
same way in the past. I don't have a specific runtime effect to provide,
except that it will free 10s kB pages immediately during OOM.

