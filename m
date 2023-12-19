Return-Path: <linux-kernel+bounces-5252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8DC818890
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67FB1F24A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522D41947A;
	Tue, 19 Dec 2023 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BMTbbzUR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RW2jnGIq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1771944E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ9wv9r010585;
	Tue, 19 Dec 2023 13:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Bun4BxhPs228skuxKZtiNfso6m9SSuXl7i0Tstd1Xas=;
 b=BMTbbzUR93oiXokaf1cnymRWpSg7poHPTkz7fEZ22TEJV8OL/cncziu4h8jfpS2Tg3lg
 buZkCTSXnhadMA6qXlZGVhRMcWzQ7BojA7S5IIpS8cuS4LlgSIyLE+VYpOenJu0jQpx4
 WpvGOioErgzc41sIq7GyUcWt6kbTsf7k0rT7bHg8hxPeMUC7jFAASmcF6vwyy06GBRc1
 UFM9EOrFHsUit25TawvYau+EWL0fj74cJ6XoiUy15fteVPoYpCMc6l27FLkvRC8iIAkm
 Vqt5rsgokPVxwDcsQ0IupqOrRcUzPTt79oQ1wOej0joJzA4/DlouKdi0x/KF1dFwq0gi lA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13xddw9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 13:22:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJBV477022394;
	Tue, 19 Dec 2023 13:22:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b6ypdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 13:22:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqxbsOLnlXyYRaRmIbH6yj/DDDcWc9Tu4MVaTUIKq4A8SE24gx8WFVWJQenJ8tuI2SsUJkaL8kZki7vi+hinc7b5w/jwXLmhJNpMvHwDImZzHUHrQAyMCLkCsDB6LTc1zTcbd3pMbBHk1olgL7XgpaEISxkb/YqDjhsWIAR/4Ml7iO5DTSRcYSMX+kQAMxs6A4cCo9MGoyBqRrVd5lDE3TgGGJp+Jzb1h7m2br9IpdAwz9zM3CKEFJCrJ9rSG8e3fidodBtpvJ90NxBG9xyrKFEv3GyqEGceWMsVx0kufVv4n7s1sBhiZNqg9LF8O7adJhYp8r8hFvJLxIfNUeRmgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bun4BxhPs228skuxKZtiNfso6m9SSuXl7i0Tstd1Xas=;
 b=IdjI7wPtfJp9Sb6URTWv59Pm9g8Y+PmVNsMPpJm53FdAPdY1Bsx9oxFL4ZklyjMmCNWN59GePjUGuEXP1hquQGqAZDlAm4eVx39PSrAyJrBNOzJl7Lt5Di8gNqEwqDqalkLkzFIB4yauemqOxR86jNkP27Edv65vqRlJX4J2dHGtZnvFM+yk7Hv+C5duT7woxGMFOgAJM91RbQJT6QWRQzSkwSjHSqQHUZXnuzwIIYZusklzTbGTNhKRuLWpkT5q4kWDeA1iClxL/ubKRnD2lnqi65nUNRX+Y1HT92e3gyXB2M0baSBUxLDRWsP0UZcB80krB+zfF3QEsut4xBbvWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bun4BxhPs228skuxKZtiNfso6m9SSuXl7i0Tstd1Xas=;
 b=RW2jnGIqMTyTFjNewb9OxE3LZeAYz3KYEmRhJZo02wI2zNTNRwpN9YcZLq8IrMJdPag9oC2dGbQzBdY8wQYyg+ccMofhTxzi3J9Lg9UJEuYnVjZMeuE0EQoV/VDySQ8DFwCkMl0jslQvf6FvapocfaJeLVqcof1M9vLS8jf2XpQ=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by IA1PR10MB7448.namprd10.prod.outlook.com (2603:10b6:208:44d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 13:22:53 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::dec8:8ef8:62b0:7777]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::dec8:8ef8:62b0:7777%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 13:22:53 +0000
Message-ID: <da494232-b3da-d236-2138-bc3f481a60a8@oracle.com>
Date: Tue, 19 Dec 2023 05:22:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] perf/x86/intel: Hide Topdown metrics events if slots is
 not enumerated
From: Dongli Zhang <dongli.zhang@oracle.com>
To: kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org,
        joe.jin@oracle.com, likexu@tencent.com, linux-kernel@vger.kernel.org
References: <20220922201505.2721654-1-kan.liang@linux.intel.com>
 <91d8d712-f20b-0809-7272-9b16bf83968d@oracle.com>
 <d48fdd31-c989-e610-f9be-5c51a0a1402a@oracle.com>
Content-Language: en-US
In-Reply-To: <d48fdd31-c989-e610-f9be-5c51a0a1402a@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0187.namprd05.prod.outlook.com
 (2603:10b6:a03:330::12) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|IA1PR10MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 006a7be5-6532-4ecb-b44d-08dc00959b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QJOsU3EwkTCiWIxrEDCCPfdZNE4rq3IIRdu6a1smw942JxcARtvDZjNzFgatEY8umJqxA4diPU8lxQonS5HoESb22G+HJ5z1D0piJa9v1I6n5fnhrow6zhkc6+u/mlcAD339c+tIYkVDq1kkX4P53IncDPDeB4ZpJVrQYDONi0Qrs3XHoaE3rTMZFhMWJtbVXWxBkgy7p+1/r1r8eSlwt0urTRJo9SLs755v/hhTA53L7OcW7/SxFijVwCIkO2sbMvchmRxXW5X5RBiwUIMt5hKqSVn5x6ynLVU+C4hQ/i+nTSfeMa2dO4FTz0R2uGRdxgZe3fyUqiPpANI/IgXzCZuACh8xKoX9hLaeDt+KnB/bXhUL+IWFfV4lh+MjhyZQlKTnHLfy9eAp1FAUX8nC0u7wjMDvOsVtWDNLuKtw+FxeYb8f6rvmQWGYoPJX+Qex8bNcpfSuefpsI2IbIjOM8XBwVJdAfwHoC/W3Z9Uq2NzOoYdVclPgm2t0naK4iAaYgl7WhjrtKbU7mQuZcA1fc6ptuecjhmLb/XPT4QPjj3+eWILTOtkPHaF2G/IoKd88NmQNhPG88OT0J+uNx3wg9jx9+AZ4lkwH5g5P8XCzmkaojrTGOkbakvMUJiHGdtNIv4PAMLTQA4+ftqP7GxV+uA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6512007)(5660300002)(6506007)(53546011)(26005)(41300700001)(38100700002)(36756003)(83380400001)(86362001)(31696002)(2616005)(2906002)(44832011)(6486002)(478600001)(316002)(8676002)(4326008)(8936002)(66556008)(66946007)(66476007)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VVppazl0MS9XZnlVVkMrandwREU1Z2s5L25xdGQ0VUVlT1A4Kzl2dUdBZlJ1?=
 =?utf-8?B?ZGlTQTc3UFlwRmdKSENKZGtXL1dWM2tXSCtUODJTZ0VxbFBTUWxVMU1Oak1V?=
 =?utf-8?B?TjFIMVJQS0ZoS2RycFF4T3FFODI0T0xKbmsxSzlLdkh1VGFYWHJtbXZOVHpi?=
 =?utf-8?B?QUFzR29LK0xyeGs2aXFaUEdLb2JBS0J3aVlzWEpNWTBRSkVQVVovdm9SUC9i?=
 =?utf-8?B?dU9WSWpnNXgzaFpicUtIYTcvaW5hb3pMZ3hWbUZzQUtmUkZPTHlRR1YzeXVu?=
 =?utf-8?B?S2RrYWE0SnU1U1k3Q2Vlb2M4MXJ3cFZtNmZUZ01ENTdXRFZQK2pyZklKTDJO?=
 =?utf-8?B?RFJtZktWY2NRWkVvLyszZGRpc29ZUVEvNkFaWHNSaU9CRnlXczZWMFlZelkw?=
 =?utf-8?B?TERIMEJVT3dwNVZsZnVvQStVTTdOaEtDNUh1elRJak1UQUFCbzZCYldlaFMv?=
 =?utf-8?B?REJmNjJzR05iaG9zdFRDNG1Bdytyb3dwYUlKbXBEVjVXYzMwVktXZkZkS3FH?=
 =?utf-8?B?NytLai9RekZ6YUhlQ28wTGJ6NTZrSFlobG5KMlNWYVBnY210Zmg4SE5penp2?=
 =?utf-8?B?enQwWTJHd2h6dGlGL3U3MVBlbU84UWJHdzBsaTh4UkQ1ckJmOVlBaDN4S1RD?=
 =?utf-8?B?TTRNbWFZQUJPYUlmWk9YaHpjdGFjc1IrckY4ZzFmcFVyandxSVNYTzBGN1pR?=
 =?utf-8?B?eTMrb3JVY09seElhOHZNb09NMFRzeVh0eWE5ZnliMEUvRVBsSnlJMUVmd1Fr?=
 =?utf-8?B?Yys3akFTSERrdU5GYlFhWXA5eVp0MHVIbDRoZ1BRd0VacmwrdnRNTG1ySWl6?=
 =?utf-8?B?a2diMUhPUk9rU0x0WGxDVEJQK2JsbnpmZmlWaXM1T21OU0JyamxJOEhxRFdh?=
 =?utf-8?B?eGMzeW9FMDBYbFJWdXg0V0RKNzRaOWowV1hOc1VUK0tFNzJlSHZ5SVMzS1Rm?=
 =?utf-8?B?a2Z6bUxZd2h4ZDBxV1pjQ0VYbFR5Wi85blBJQ21jK0JZRnhHdWFFV2FmeEN0?=
 =?utf-8?B?TDRBOWsyMmZuQXY4VDZyQzRkb21ZVXM4R0xoVXgzQUFDZFJWc1JOOXNVdW9M?=
 =?utf-8?B?MVpaUXlmRlg2anRMY3pUKzNHVnJMZVpHWCt3VzArenFFKzdhMTBmL0kvYkp4?=
 =?utf-8?B?dlFzckNCdzR5OHZaM2U2eVkvbFFMQ0tieFYwTUJGTjc2Um5mcy9OQnJTUHNN?=
 =?utf-8?B?ZmdOL05EaG8vbkJtWG14M0I0ZmxmSEM5L0tWYVNsOUxJU1NYUURrS2lqWVIv?=
 =?utf-8?B?NUxGSWs0dlo0YkNOOU5CSzl2aVRjNkMzTnFNS3hieGRyeUI4MkxRTmlYcTVO?=
 =?utf-8?B?ZTA3bnB6Miszd0RuU1hJUzZ1NUwya0NkMG1wVVdSL2Y3L3IzZzFMTlF3Qkhl?=
 =?utf-8?B?UzNud1VjcWRtcGRKRlRYM0ZnTXZrbzBDZzExS3NQdmpldkF2Z2RNYlhJR1pm?=
 =?utf-8?B?cmkvOGlIL2h1bysvbnBQZm1UNWsvY1c1RUQ1OGx3d2IzNDI5d1hWdThhL1pq?=
 =?utf-8?B?d2l5OXUvdzQyamJQU2l4NHZabDVWQmNjMkx2cEl1YWZ4cnFEeTkrMDR1SlVr?=
 =?utf-8?B?VXZBT1ZaaVJHL1l5QUlKeDZ4NCtPZGsrTmxGS3JhclhJQkNJZlE4TEQ1allZ?=
 =?utf-8?B?cnFTRE4vR1NsUG9SSGVSNDdqZlVrTGhXUy8zNEM5MVF1MlczZ3lKTHozd1lw?=
 =?utf-8?B?V2YwNkZldjRIcWpEV015bHFMWEIzajJ1U09jYVEyWElmKzdNUzB2MEMxNUFl?=
 =?utf-8?B?WG5lYU9NaCs0Q1FZRGZXMnBHWThydU9CTEJpRGw4eEF2VVc5VFZaQzFtK3V4?=
 =?utf-8?B?S3dHN3BGL3hTV1dXbER3YTBFTXRFK2pzVlZtazZyVDhRZW5ZZk9FbmUwd1FK?=
 =?utf-8?B?aThEVFpFQ3ZLbmNJb2x2MWpLSzA1ODZHaGt5aHFFd0g3RjZDVDI2c2tiWDRF?=
 =?utf-8?B?R241ZzZBSEhkS1RmZ1AvRXVPNlFVTEpCbGhlOHhmdUxLVkkvVG5zb3JsTkpu?=
 =?utf-8?B?cjMrU2ZmQlRUbjM4ckdBdFo1NDlpOUI3UjBIT253NEcvM09UU0lPOUtHWnlY?=
 =?utf-8?B?Q3d0eCtKaTZFaEUvaFVyVm9uYXpIb2VLc21QSTdxQk9zd3dwSFl2OVZwaTIv?=
 =?utf-8?Q?URZk0AsYcrrto1gBF/5wBFfFv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nrgfCWGZWLGcjWS1oZrI9UdK6vaxDXKHWzckx+IbuNYylvcn7drwGCV5HD5pmTbxNeL3vouh8sNX2Lwe8QxrBMo0Vs2kyWnSabwd2YJkXMU/6ID7T7u1ATbE2HObbJ9x/Au1efgX5qbmwjZkaxi1goAG9uULMDQ9lkhXjgeFFiouDD2gVD/j5h1CU3NyDV6uuVj3q5zeC9mppNlqYXoTSMeumaH48YkUFQ3ZeDgOiVcS9+tdiYxc17R2+gseJV9p5GcWZcgYwuZbIxcLr6tgurHE7HjBL13J7yFGo9po+4yOV54xZy7wJYbhxBAcsw/ayiIvBstyXZhnlLigQ6fWpLPnMHsHshCITcLwf1kkFs1hRBDA1tLsRV4uOkTHLFuMdmnDj+kseZxbSJt6XKGUO8M2kRJhBoIYIJDhMMSZDDMaj8U4/YJbtufhi5zWUKaN3cdQ4Xgl3WBUR2E9lAxU5YC8/7hAyByolrxFLVGPN0v9F0BVBkK9k49knu39iRAsRNxoeZuE2yPrSQI2J9d6q2wP8Qe4iDyPX2cMvIDEUlgboXXXH1pKwGUt77YRCTGsTIoHEd+3o9YWB7NC01RZnJTHUy2yR9QnQvVIZL7lttw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006a7be5-6532-4ecb-b44d-08dc00959b4d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 13:22:53.7125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nvRt54kGa013cWUbmM5GjKDdRFbUfs7nBahYLhQr/+sWlf8m0rA2YYX+PzHcvpuyUNtYvscsMaAMkNFHdeKFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7448
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_08,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190099
X-Proofpoint-GUID: 8HfRJKHd_PEHAoC-WNy_Rg9_f7Jv2J2_
X-Proofpoint-ORIG-GUID: 8HfRJKHd_PEHAoC-WNy_Rg9_f7Jv2J2_

I can still reproduce this issue with the most recent mainline linux kernel (at
least when the KVM is not the most recent).

Any chance to have this patch in the linux kernel?

(We may need to rename 'cpu_type' due to commit b0560bfd4b70 ("perf/x86/intel:
Clean up the hybrid CPU type handling code"))

Thank you very much!

Dongli Zhang

On 10/27/22 09:17, Dongli Zhang wrote:
> Ping? Any plan for this patch? Currently "perf stat" will fail on Icelake VMs
> (without the topdown metric). The user will need to manually specify the events
> to trace.
> 
> Thank you very much!
> 
> Dongli Zhang
> 
> On 10/9/22 10:03 PM, Dongli Zhang wrote:
>> Ping?
>>
>> Currently the default "perf stat" may fail on all Icelake KVM VMs.
>>
>> Thank you very much!
>>
>> Dongli Zhang
>>
>> On 9/22/22 13:15, kan.liang@linux.intel.com wrote:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> The below error is observed on Ice Lake VM.
>>>
>>> $ perf stat
>>> Error:
>>> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
>>> for event (slots).
>>> /bin/dmesg | grep -i perf may provide additional information.
>>>
>>> In a virtualization env, the Topdown metrics and the slots event haven't
>>> been supported yet. The guest CPUID doesn't enumerate them. However, the
>>> current kernel unconditionally exposes the slots event and the Topdown
>>> metrics events to sysfs, which misleads the perf tool and triggers the
>>> error.
>>>
>>> Hide the perf metrics topdown events and the slots event if the slots
>>> event is not enumerated.
>>>
>>> The big core of a hybrid platform can also supports the perf-metrics
>>> feature. Fix the hybrid platform as well.
>>>
>>> Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
>>> Tested-by: Dongli Zhang <dongli.zhang@oracle.com>
>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>> ---
>>>  arch/x86/events/intel/core.c | 33 ++++++++++++++++++++++++++++++++-
>>>  1 file changed, 32 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>> index b16c91ac9219..a0a62b67c440 100644
>>> --- a/arch/x86/events/intel/core.c
>>> +++ b/arch/x86/events/intel/core.c
>>> @@ -5335,6 +5335,19 @@ static struct attribute *intel_pmu_attrs[] = {
>>>  	NULL,
>>>  };
>>>  
>>> +static umode_t
>>> +td_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>>> +{
>>> +	/*
>>> +	 * Hide the perf metrics topdown events
>>> +	 * if the slots is not enumerated.
>>> +	 */
>>> +	if (x86_pmu.num_topdown_events)
>>> +		return (x86_pmu.intel_ctrl & INTEL_PMC_MSK_FIXED_SLOTS) ? attr->mode : 0;
>>> +
>>> +	return attr->mode;
>>> +}
>>> +
>>>  static umode_t
>>>  tsx_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>>>  {
>>> @@ -5370,6 +5383,7 @@ default_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>>>  
>>>  static struct attribute_group group_events_td  = {
>>>  	.name = "events",
>>> +	.is_visible = td_is_visible,
>>>  };
>>>  
>>>  static struct attribute_group group_events_mem = {
>>> @@ -5522,6 +5536,23 @@ static inline int hybrid_find_supported_cpu(struct x86_hybrid_pmu *pmu)
>>>  	return (cpu >= nr_cpu_ids) ? -1 : cpu;
>>>  }
>>>  
>>> +static umode_t hybrid_td_is_visible(struct kobject *kobj,
>>> +					struct attribute *attr, int i)
>>> +{
>>> +	struct device *dev = kobj_to_dev(kobj);
>>> +	struct x86_hybrid_pmu *pmu =
>>> +		 container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
>>> +
>>> +	if (!is_attr_for_this_pmu(kobj, attr))
>>> +		return 0;
>>> +
>>> +	/* Only check the big core which supports perf metrics */
>>> +	if (pmu->cpu_type == hybrid_big)
>>> +		return (pmu->intel_ctrl & INTEL_PMC_MSK_FIXED_SLOTS) ? attr->mode : 0;
>>> +
>>> +	return attr->mode;
>>> +}
>>> +
>>>  static umode_t hybrid_tsx_is_visible(struct kobject *kobj,
>>>  				     struct attribute *attr, int i)
>>>  {
>>> @@ -5548,7 +5579,7 @@ static umode_t hybrid_format_is_visible(struct kobject *kobj,
>>>  
>>>  static struct attribute_group hybrid_group_events_td  = {
>>>  	.name		= "events",
>>> -	.is_visible	= hybrid_events_is_visible,
>>> +	.is_visible	= hybrid_td_is_visible,
>>>  };
>>>  
>>>  static struct attribute_group hybrid_group_events_mem = {

