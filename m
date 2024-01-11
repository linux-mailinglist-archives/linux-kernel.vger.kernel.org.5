Return-Path: <linux-kernel+bounces-23988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896A282B4CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DBA1C24793
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93EA482CD;
	Thu, 11 Jan 2024 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XGWn9fei";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qBtAoNTB"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F61CF86
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BI0hag004546;
	Thu, 11 Jan 2024 18:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=MLqNoqi4O5o1b/G0uxbw74IF7dYeZNsUEPG6MhysDUE=;
 b=XGWn9feiIBDkQor7peg6slZ6YZfu0bt2gPC6wDedudscM2LvJ0pHAcHYVuVfMh+yUEvt
 Wa3+NJG5GdQGarbQUXrYnIf2glSaED4J2EPB8yRtCgqiAXPPE4q+25OWEqbaVTGUalt2
 owAOg38t7x4RFq0wqCbNhqvFoGmXZKalPShr3yv1gRftISFazvMRal83NJ0OPAGbr2g6
 8UpdvfhYtsnKJTYMx1tNS6nvjghFXPvgJoxyVwrTOtInK2ammptNpbYSkzX0T6yfDz3B
 B/vMGvfECtri3UQslpZXhx9B04pnGx8AMRTLGJeii4NnAMV2hQld9YbyCUBMrVKTO0y5 dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjjb6rj06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 18:36:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40BI6Jiw035279;
	Thu, 11 Jan 2024 18:36:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuu83acc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 18:36:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mytlpMz96ERZIOI7yTUQPG5hfSYblAGAKh+YiuMA+EtTcl30bwucfhyK3VMRE9yB3HsM9OrY+rBa9dKMibnDqZFvJXKmV0DUKjKpe8qjHC2m0IJvV7HqNG7gEQZaFGwuL+m37JHYbbrzzPFSqN0+gqVLofWHwyO5KBlHEz0foY4P8YHfZU+Y/2A7068WYjQzLL257eeoq07nLJPY+27YwH3vdUJbjkakwITnFwoTGe8dBCsN5/N+8Dv1CjVvwxaA0QasgDTfbyKfvywLCsH9WJs+kU1TUjr2Izbcy9JxxSfi1066xPzBlJ4wIajXhF1V/0MMqf2Ss1G1hMo3UggobA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLqNoqi4O5o1b/G0uxbw74IF7dYeZNsUEPG6MhysDUE=;
 b=B5yl0xbuCLqbPo5OQ2Jizk+zRzI5nGfaTsYfhjdWh3JKFDzonlzohZctKqAXncnsVidUYgMPlJdnPZ/yBBe6g35e87jgCs+YSt0AD+OdkdM1Xrj3CNLhQ34y5MsAaXXdYUyM58xVDTxPnW2HPXtWdsl/x+9A3llwMX5W7BXwOdU36s7AaRWe6eMAxrZhTh3+XHXKMD4E+oXaoBV7AZdoMOpesQ70lw+qrN9VMeqjOZIF/xFFai+6/9NO3sD34p+xHq6lc6KXLl59UZD7z08pSRZLrpHpdNYbA+HFd3b2UX3lkjBSmUY+7LaH9NdqsnFySypPR6pKvDLLd0aNieQI3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLqNoqi4O5o1b/G0uxbw74IF7dYeZNsUEPG6MhysDUE=;
 b=qBtAoNTBqIbNDQm3vc6owEZX/Bv1boaTBJh0YS8q61pCYFlczOgIpYueg3+yZOt1G0JKvjnvmv4UqpkB6bXSLFfwF0iVAu04jBKeJKv/YvUabRHFTxSb9Nz/3XtzJ9jXuchh5OIuriVJgUEENFYgfXA/TjGc1k1dvYyQNxUpWsk=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH7PR10MB6201.namprd10.prod.outlook.com (2603:10b6:510:1f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 18:36:03 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::78b9:5082:241a:d1fb]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::78b9:5082:241a:d1fb%3]) with mapi id 15.20.7181.020; Thu, 11 Jan 2024
 18:36:03 +0000
Message-ID: <2db8eba4-f4c8-7a7c-38d3-44abdd0abbd3@oracle.com>
Date: Thu, 11 Jan 2024 10:36:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 4/4] selftests/mm: add tests for HWPOISON hugetlbfs
 read
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>, linmiaohe@huawei.com,
        mike.kravetz@oracle.com, naoya.horiguchi@nec.com,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        shy828301@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jthoughton@google.com, "kernel@collabora.com" <kernel@collabora.com>
References: <20230713001833.3778937-1-jiaqiyan@google.com>
 <20230713001833.3778937-5-jiaqiyan@google.com>
 <be3976b5-0a9c-41c6-8160-88e6c1e5d63e@collabora.com>
 <CACw3F51WvZDVCpVg9j4j8WmnmAFOsnK+FZDDoVqhgLqVwhPTCA@mail.gmail.com>
 <e68488e4-764e-4b25-8a47-05bf8976bd19@collabora.com>
 <079335ab-190f-41f7-b832-6ffe7528fd8b@collabora.com>
 <a20e7bdb-7344-306d-e8f5-5ee69af7d5ea@oracle.com>
 <dd96e476-e1ad-4cb5-b5d1-556f720acd17@collabora.com>
 <CACw3F53PddeCHUHb=m8OSO6yYQJoM==urn+Axp=Xi1szozJH9A@mail.gmail.com>
 <6bacbd7c-88cb-1399-8bd0-db98c93a1adf@oracle.com>
 <ZaAtjVVTETdQDR4B@casper.infradead.org>
 <39b90dce-fe0f-e1d8-3094-75cabbfa38a3@oracle.com>
 <CACw3F52B9ckzqUmGzzQxpskJGRZu+3m+tVRoSekhgsX-mQaeBw@mail.gmail.com>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <CACw3F52B9ckzqUmGzzQxpskJGRZu+3m+tVRoSekhgsX-mQaeBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:74::32) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH7PR10MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de04861-8e23-4f4e-ad64-08dc12d42a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SQ8admtRPJ6QHBbkcbEYQcQFopzXjlKs0MNtkpZShukhw7B0yEXVytogonqe2G0nQSNGksRL71vJV2Stz/c6u6DmmXi94oe+rTQUZ+KsTvGvKUfNwYsjJUjrfdoPAw7DK/MyrGt+TLpgv56HJw7j2f+BeFpNTbsQaP5Dls8r9Ya4zl5iEJ2pFD4oVgySnDpDbFVGsJXgy4wIyBr4fKlhwD1Qi54ti5jO9sGc/cCXjIIPKPzCwcad4U5gsZi28VN+2UJteZqC6LoZTYPttoay64LOK9mq4krILhZKnEUkgHn7Honoa/TEB9tm39F9D+euIK4sfthHtbk/N1Bws/O8Kdba+j3KyZPbSJRG+SsDYUXUf0pt3yPUIlq7TuGMC4AUKJVTFsP4OHclZlrA6t4d1ze5eVsLL20EAYbOTiJEU5TpFFTfrIlrgrgHm4tnsgD4yXLT/HpnRda1l95I+x4Vd8AqgFpGhrOl4PTFFMSKz6KktSfypMj3es7wOx+r1cGJTZjOwTZzfCCvKD1IYBBzIC0aijd+uToE3n3yavr8O1oVTmIlpA5aZMtuWrGqy+ThQr8Ik+/g0srOeucJQSwiokdu7Wi/zITJknvRD6NUi+i3xiPC+6iHfHLFdwg6R4ImvNPyorXxp93RL1i96viQjQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6486002)(6506007)(6512007)(36756003)(2616005)(86362001)(38100700002)(31696002)(83380400001)(41300700001)(478600001)(53546011)(8936002)(8676002)(4326008)(5660300002)(44832011)(54906003)(66476007)(66946007)(66556008)(31686004)(2906002)(316002)(6916009)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Nk5YeTNRQkVObzFFMkJCTGlrbk93bHpVZS9IV0o2NXZoZlQ1TitCVWtVYW9I?=
 =?utf-8?B?RVpqU3hKOFJjMWVRN1FoM0x2R0hoNW5JZTB3WGprZ2RhQzVrdGVLM1dlNU5N?=
 =?utf-8?B?VWpTZVVJWHZZT3dERWZkNmFpZFJqUHVDTVRqMkNlN3NOVmlFNW5PZU5GYWJM?=
 =?utf-8?B?ZEJFVHdqakxtRy95SDJCa3RpeUtMN2M0c2NtTEhEejRYRmY0TkFkLzFabjdJ?=
 =?utf-8?B?bGdTd05ZYUZTWmVsM2ZYNEtBQmFKVXE4SFhZZU52WlhDRG9mSGxtcVBKYm9C?=
 =?utf-8?B?ZkdQN3Byc0cwUzd1RUVuR01XbnBJNjFsK210dGxKRzR6S25SQ1hUVEpPVkgw?=
 =?utf-8?B?NHNBQTg5NUlQb05qa1V4bkc0dXE4YTV2Y0NSNTNKLytLdm41WnM0Yk80cGpU?=
 =?utf-8?B?aDNSV1JuejQ3OGl1VmpzNGJ2V29qNnNXV3FZVTFuV2k3QWJQVTlmTHgwQlV2?=
 =?utf-8?B?OXFNQ0EvNmNDLzhnQ2ZrUlFqTWFlc3dzZWlrS0liT3daK0UyVEdCVHdBZzhO?=
 =?utf-8?B?cnpCSlR1S0RxZ2o0VzZLMTM0ZDcyRk1PM3FyZC93TERYeElHcmJPWjNwM2Zw?=
 =?utf-8?B?NE1BbVRkbFpvQ1Fvd3ZiNnpxZ0RnK1ZaM2Zxd0Ixajdpdk8vZ1UvK0gzZ1hV?=
 =?utf-8?B?elVCRWJmazUycnJKNzdSQXNVdE5JQ1lEN3RlQkV5b1pKWFJ6MnFzSktnR2JI?=
 =?utf-8?B?YUhyWGh2Tk1ZK0RSaEsrZ21kdVdBNWRlK1dsTXBiaGg4c3lEWGFFYUx6WmxD?=
 =?utf-8?B?K085b0NiREEydDVJbmtSWFZMYzhRdmVodWd0UzdDREk0LzhJRzZBRHp2cFlY?=
 =?utf-8?B?NjlldVBPMEFFczBxRGFBZHBRQ1BpUkF1bWVxeldEVzYwRHRUZlpxSnp4OTdC?=
 =?utf-8?B?ek8yTURub2JSVnBjNG82MzNwVkQ3QWVPNGlKbkE5cXVIYWpUL0lWQk5QTmRq?=
 =?utf-8?B?SG9sL0ZvSmRZQUJPTlJiaFVmeXRna2Q4aS9oNnhoNGFNa2VJcXEwUVJ1bjVn?=
 =?utf-8?B?VXZheTllMzZ5WjN1MXhJSC92aFQ2T01MbFpsaTFrWHNqcjFJc1NUQm02Wi9C?=
 =?utf-8?B?WktuZm5hSXJWL0pPRStJcXNNZWlvdVN6Z2FPZlJyMGNySEp4OVBxWlB0Smd1?=
 =?utf-8?B?dXRWaDdxaVpVU1RmZUJxWWZvd09nZXJHcXZnOEZhWkZQbkloWWRHU2l2TG82?=
 =?utf-8?B?K29pb2JqakNSVldQVXpNdm1NYnA2ZHBNM283LzBJY2t2Z2p6blg5UENqSDdI?=
 =?utf-8?B?L0JyUm1VN3JteU9tSXFyT0tvT2YrMG16dERrTk1IWXltUStTejY3b2JVSGc3?=
 =?utf-8?B?Ny9aZndVa0k4SnZBOGQxOGRPZEdEYW9hdW1HOWhHSjFCUVdpMzhyS25VR0Jt?=
 =?utf-8?B?VERyc2dBbnZzSjc5aStFcmsvcDkyUzMvMkpkdzB6UUNWM2J2M1ZiRUx2UkI5?=
 =?utf-8?B?SzRmSGZTdWh0RnlLUGxJUjZUbHovY2cyM09rblBtOERoNC9BaDNmOTFqak8x?=
 =?utf-8?B?TStlVnlTaTdpUGgxcXZxa0t3WGovZ2JLaXdMQ1Z4TGtWZGlHSjhhbmJtdDZG?=
 =?utf-8?B?Rm04WXlYUEFKbFFGLzkwZ3ZyUm9zVVBpQ2lXUFd0bXcraVlqK3VsMk1pcGdj?=
 =?utf-8?B?T3FFdTczcGZZMXgxNWlxc3B5eENoUlIzczFTbXdURjZ3dW94THM1Q2RUL2ow?=
 =?utf-8?B?aHdkMWJKK1BSWFhURXRSRGMxMEhDODIzc1ZscFFkaU5vNWhrV2ZBZ2RYUE9I?=
 =?utf-8?B?cTJ4MjEzbW43c0NOZkpZclBYSm5iYUl6Vmphd0pQRy91S1gvaFJPSTN2ajBq?=
 =?utf-8?B?Ym1kS2wvRmR5SldvcFl4YnJqWmxsenhwcVo2aHNYUm1IRHErVE84cjMzMW9s?=
 =?utf-8?B?eVV3QlRRUitEWW1oWUFVTFRCd2FSUVVXZStyUmlnako2YlNRN044c0ZQK3Yv?=
 =?utf-8?B?RTd6a1FiNDFNOEwxVXRVVG9CcFNLUzRlaFVpWFZGMEp2eEd4Q3NNM3l3U0li?=
 =?utf-8?B?M2gvK0MwRG0ybDdaQjZYZGIvTHhuUStyTnF1b0I4UHdpUW1VV1cxSVh2UUdN?=
 =?utf-8?B?RG5MN0NMWGxWZmRkZlk5MUw1V0RjMkdqbGtLcnJzZDBxRXZDR1JEbmpwOTZm?=
 =?utf-8?B?UWhFcmxnMHFaQ2lUM0g5eFhndjdZanVTcG1HMTJSQ3JGelBRUXRiSXVZdVpU?=
 =?utf-8?Q?Xf4Cpx1k6WxGBzWq1n6H+qA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pUTrw+b0lcvBsA9AZfC5LsilZHcXIMCvRZFtc6ukkep1P7jm2Pc/KNxL3wYFq4hbeg8pX4saBLxFMsD7vl67h/P4aYBSnmLBS2P4jX7cpZ4KDQFEpEFjK5LpxGvUN7V1zNQJfbfpIRezS61tcZo04nyL7+tKJc0GCgzKMmdmol44klqW8LLIfrCuYRFRJGR2BETV9hQt6AKNP6K+K9uFHC9wVssgLs7nSOZdI8Tt6UaEhLAYR86ziJttEuk6DaZypYgD8zCUWWo1pGcF2U5RvZ7OuCfA409a0fGEYgaYHnQV5Ez7ZVR2ErqfhecZHMYvYB6ytiVdyCWSDE5MmXew+GwzhHREW00icNzcp7KdXTmfNmgtm8CP9TrSum7OrHexaoX1i1xbJnLREskpEYXplKkt+JgHZCU30rKN4/r2jZJOe9Dzcv+PVXDu8p1gNTHx5FO72v7AWRfJM7u5//jek57k4wIcfdzRtGsNa5S/FAHWJ9DTkNHf+pZNZm+MDZWJ9z8kGK46+DSXt6xfmyVIDYN3fDJ2b1NhG8WUvdxvi7ci/BG2DuFNcfgT0EnjzCkhYj1A616gr/x2QCpr5XHKgOtPGu9Sx7eXJ61dXZ3HnGQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de04861-8e23-4f4e-ad64-08dc12d42a82
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 18:36:03.6580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2Sl+8Po9f/Py1cH95Bg2q7kE/G6GwO/BicdLb52r5Qvok2lezNByEQrVEnfmtEiXBD48C6hMWTdnEn2msvmzJtemoaPW649kW6c0NNYUbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_10,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110146
X-Proofpoint-GUID: Yy4S2e8JfO6YJFVWU3jc2huOKs6MZ7Ou
X-Proofpoint-ORIG-GUID: Yy4S2e8JfO6YJFVWU3jc2huOKs6MZ7Ou

On 1/11/24 10:30 AM, Jiaqi Yan wrote:
> On Thu, Jan 11, 2024 at 10:11 AM Sidhartha Kumar
> <sidhartha.kumar@oracle.com> wrote:
>>
>> On 1/11/24 10:03 AM, Matthew Wilcox wrote:
>>> On Thu, Jan 11, 2024 at 09:51:47AM -0800, Sidhartha Kumar wrote:
>>>> On 1/11/24 9:34 AM, Jiaqi Yan wrote:
>>>>>> -                       if (!folio_test_has_hwpoisoned(folio))
>>>>>> +                       if (!folio_test_hwpoison(folio))
>>>>>
>>>>> Sidhartha, just curious why this change is needed? Does
>>>>> PageHasHWPoisoned change after commit
>>>>> "a08c7193e4f18dc8508f2d07d0de2c5b94cb39a3"?
>>>>
>>>> No its not an issue PageHasHWPoisoned(), the original code is testing for
>>>> the wrong flag and I realized that has_hwpoison and hwpoison are two
>>>> different flags. The memory-failure code calls folio_test_set_hwpoison() to
>>>> set the hwpoison flag and does not set the has_hwpoison flag. When
>>>> debugging, I realized this if statement was never true despite the code
>>>> hitting folio_test_set_hwpoison(). Now we are testing the correct flag.
>>>>
>>>>   From page-flags.h
>>>>
>>>> #ifdef CONFIG_MEMORY_FAILURE
>>>>       PG_hwpoison,            /* hardware poisoned page. Don't touch */
>>>> #endif
>>>>
>>>> folio_test_hwpoison() checks this flag ^^^
>>>>
>>>> /* At least one page in this folio has the hwpoison flag set */
>>>> PG_has_hwpoisoned = PG_error,
>>>>
>>>> while folio_test_has_hwpoisoned() checks this flag ^^^
>>>
>>> So what you're saying is that hugetlb behaves differently from THP
>>> with how memory-failure sets the flags?
>>
>> I think so, in memory_failure() THP goes through this path:
>>
>>          hpage = compound_head(p);
>>          if (PageTransHuge(hpage)) {
>>                  /*
>>                   * The flag must be set after the refcount is bumped
>>                   * otherwise it may race with THP split.
>>                   * And the flag can't be set in get_hwpoison_page() since
>>                   * it is called by soft offline too and it is just called
>>                   * for !MF_COUNT_INCREASED.  So here seems to be the best
>>                   * place.
>>                   *
>>                   * Don't need care about the above error handling paths for
>>                   * get_hwpoison_page() since they handle either free page
>>                   * or unhandlable page.  The refcount is bumped iff the
>>                   * page is a valid handlable page.
>>                   */
>>                  SetPageHasHWPoisoned(hpage);
>>
>> which sets has_hwpoisoned flag while hugetlb goes through
>> folio_set_hugetlb_hwpoison() which calls folio_test_set_hwpoison().
> 
> Yes, hugetlb sets HWPoison flag as the whole hugepage is poisoned once
> a raw page is poisoned. It can't split to make other supages still
> available as THP. This "Improve hugetlbfs read on HWPOISON hugepages"
> patchset only improves fs case as splitting is not needed.
> 
> I found commit a08c7193e4f18 ("mm/filemap: remove hugetlb special
> casing in filemap.c") has the following changes in inode.c:
> 
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -334,7 +334,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb
> *iocb, struct iov_iter *to)
>          ssize_t retval = 0;
> 
>          while (iov_iter_count(to)) {
> -               struct page *page;
> +               struct folio *folio;
>                  size_t nr, copied, want;
> 
>                  /* nr is the maximum number of bytes to copy from this page */
> @@ -352,18 +352,18 @@ static ssize_t hugetlbfs_read_iter(struct kiocb
> *iocb, struct iov_iter *to)
>                  }
>                  nr = nr - offset;
> 
> 
>                  /* nr is the maximum number of bytes to copy from this page */
> @@ -352,18 +352,18 @@ static ssize_t hugetlbfs_read_iter(struct kiocb
> *iocb, struct iov_iter *to)
>                  }
>                  nr = nr - offset;
> 
> -               /* Find the page */
> -               page = find_lock_page(mapping, index);
> -               if (unlikely(page == NULL)) {
> +               /* Find the folio */
> +               folio = filemap_lock_hugetlb_folio(h, mapping, index);
> +               if (IS_ERR(folio)) {
>                          /*
>                           * We have a HOLE, zero out the user-buffer for the
>                           * length of the hole or request.
>                           */
>                          copied = iov_iter_zero(nr, to);
>                  } else {
> -                       unlock_page(page);
> +                       folio_unlock(folio);
> 
> -                       if (!PageHWPoison(page))
> +                       if (!folio_test_has_hwpoisoned(folio))
>                                  want = nr;
> 
> So I guess this "PageHWPoison => folio_test_has_hwpoisoned" change is
> another regression aside from the refcount thing?

ya this is another error. The refcount change fixes the madvise() call in the 
tests but the poison read tests still failed. The change to 
folio_test_hwpoison() fixes the poison read tests after the madvise() call 
succeeds.

