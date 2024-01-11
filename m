Return-Path: <linux-kernel+bounces-22987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 404A382A614
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BB21C231F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9167F1C31;
	Thu, 11 Jan 2024 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D5WFwI9F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wjES9t6u"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175871856
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40B0aTg6023904;
	Thu, 11 Jan 2024 02:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2FZZkzuZsQF9d7ZYJ1l9wpkqe0d5btTd+5zXuy0b5ys=;
 b=D5WFwI9F4yHhoTB/4OT+urx+4gSWrp9QxjUyvpUImNksmJgGZT69lPMgpM3BU+7s6w53
 o39uPOxacgOVn4MQLPgGFjnEoOZq/Bu1EMAz//2NiYM/wmSyz4l0yjY4jsR9cQySCM69
 HzvVz8VHPg4r9jNPR0VvyzOr/RzJcgD7NmK4QANazoTlI6O0YmR5jJbfVQRfii8ht2me
 /jA0qfKvMhVdN8sr8rZHolN7Mu8XaBXDMgnWGNUorL0SMNN0fvz71rkeC06D0cnS0K6v
 W1cqbDoYbnvngG53CMsyKgQNoMpzfLPy+7bWFbNPSqcyw1YPFolOQTorqoNK5RR6AjGp 1Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vj5xe82x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 02:32:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40B1LSPP012216;
	Thu, 11 Jan 2024 02:32:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuwka0cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 02:32:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcesElm7/Iw8kurD5Jz8KgF5PKf7XNp6ZotbJ5k948txI7JN1eOIjXMfcbV9A6SSVOwKdLnhPQxwKagmxyV48V+wiWqO39HPRzL/oZf5c8gGPPyayZFeOQFNE7yRB4xwVcn1owgstq5pQoa5qcTliuWSDC1pEEQamWWN/GGUl3VkJ1IWE/D2b+oSJfGPyaId9XtffB8tX1Cw94v2VJEcXe1LKrUkmWGb1Ave9Nc/n/Ry+6+fPP1pAWPPm/UJQwiCUovq3EQRFT8OzavYiX71XI3gPunL3VaBPS6ACJ5r6QQJ2wqjXhUJjy0k1TM+Kdam1Ajr8Pj6POG7SU0cLMTc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FZZkzuZsQF9d7ZYJ1l9wpkqe0d5btTd+5zXuy0b5ys=;
 b=gGKrKKLeQdwfPvqkLyTNq/Dwcw1YXK3Z8YKwztZOyHb5klMKcIT6rEj0hwKNNXkcmgIRGKxq4h6ofSTcoPf6NGr87RPGGX595FcX3//EKk0fUNuwGwMHHY0hXMabU2vdy15cicL0TrNNrNQI9jOPFVxdk6UfRjipLnBccubMV+Qg+d9o2KtcW7Q0uqlONARjrIiFResogWIH2vfErmkqLLlfERZkJN8WPfgP9FeA/LjL8Gwlthb5DsiH7335oezaQNuxrHStzLKP7r2pZQu21U7dgOi7aYeICARaZxQEHzs5RzXHSWUtLP9hkSsHXd9UHbcJZNtSz1s0Ss6Sz4vPzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FZZkzuZsQF9d7ZYJ1l9wpkqe0d5btTd+5zXuy0b5ys=;
 b=wjES9t6uFDSXmceKtRT3UuhI87KM20shVC+j9Jv+O4r8tjyWSKm0q6hHdEi7+oPSxVQoazvbAN/Etp42vPtVkmRRjaDQE40mpjwV/T+31yhy8VlQCSUFIe1n1BOCg1rUEdf7SrChlFHoZ/ySUGi3NOet0NQVX3LwKvsIhq0JPRc=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH3PR10MB7610.namprd10.prod.outlook.com (2603:10b6:610:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 02:32:43 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::78b9:5082:241a:d1fb]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::78b9:5082:241a:d1fb%3]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 02:32:43 +0000
Message-ID: <a20e7bdb-7344-306d-e8f5-5ee69af7d5ea@oracle.com>
Date: Wed, 10 Jan 2024 18:32:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 4/4] selftests/mm: add tests for HWPOISON hugetlbfs
 read
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jiaqi Yan <jiaqiyan@google.com>
Cc: linmiaohe@huawei.com, mike.kravetz@oracle.com, naoya.horiguchi@nec.com,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        shy828301@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jthoughton@google.com, "kernel@collabora.com" <kernel@collabora.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20230713001833.3778937-1-jiaqiyan@google.com>
 <20230713001833.3778937-5-jiaqiyan@google.com>
 <be3976b5-0a9c-41c6-8160-88e6c1e5d63e@collabora.com>
 <CACw3F51WvZDVCpVg9j4j8WmnmAFOsnK+FZDDoVqhgLqVwhPTCA@mail.gmail.com>
 <e68488e4-764e-4b25-8a47-05bf8976bd19@collabora.com>
 <079335ab-190f-41f7-b832-6ffe7528fd8b@collabora.com>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <079335ab-190f-41f7-b832-6ffe7528fd8b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0001.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::14) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH3PR10MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: a86c5d32-2561-4561-ef72-08dc124d969c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ogBnVx7Tp54XYIAY/I+2mPUlYTZRaiapho8c+mWOVCwuwzSs2zTKiwoCBwyHYlk4n8y67LspriIqZXFxomP8RHJcmS6bZupt7rHqe8jKNm3OqVPUNVDGUD3Cf7oejECRpvmU97okWYKLBx/JD6geG2r6c8CNbiggoXnsIw+mXWjCARYT8LVTdQ2L9ncEHTwWhzPgoZ8rswWmUmABB3H7uWxnaQSqLIGwRyxKK9zgLtJ+e2PdJy+qX5CvAhsAR5PecEEYH6xWt1zabRdzLxaB71/gHn88UsI6NXsxm09lTW94rQ480lZHbzHqvUyFEb7gX9647VDqTEYRogCZCfSloZhPsr4/zon8ga8pjp9ijmcPKDIQa6R+2qYFy89bgzXFPyvXJPvykN/BK+bfNq6+CwDjCxNnhZgnMonEYDPGU/lhCdgQkTY2x4qJcGNGHU0bQKvnWqKHFQTSw2KMA1+UJgJDbA/ZkIo6lGpEHlCyYh0wzKV6bXfXfbeyTRQ1NDNP/jBJUcNkYtzv47Gk/+YOZGm4ik3WCxIoVixDgNYzuBU2SgBYfaNOHx0fEKhHFKsieLycqwtRb/aHDBckLeZh0+tdfLT2KoyOWsbV4adBgqCEy6Naxigz1aKOwMHZZWcixGst9ZpHeYfpflyJ81TFcQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(136003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(6506007)(53546011)(478600001)(2616005)(6486002)(6512007)(38100700002)(31696002)(86362001)(36756003)(41300700001)(7416002)(83380400001)(5660300002)(54906003)(66946007)(8676002)(110136005)(4326008)(316002)(8936002)(66476007)(44832011)(2906002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U2NxbEFKcEdLaEJJck9qUythdEhHUXlPazFHRFVaQldSZ3FhOU5lRWpmZVFk?=
 =?utf-8?B?R2ZaZldYVUI3SlF2NGdqWFNQZmFPNHZTZEZ4Y3FsSTJiTEswM1VValRhZjZw?=
 =?utf-8?B?NG9uU2ZFc25MYTRTZnlkSDc2cEVPVy9LY0twUEZha0RhcDgydmVwUzBDRFgx?=
 =?utf-8?B?YTg5aWJmN0FzQTN2Z0pZaUQ4dUNqdTh4ZzhycmZpa2pBTy9maDFmd0piMFla?=
 =?utf-8?B?Y2tkWWZuMGd3SnJXRzJmUGlsdXVKRjNKSFdyMWFNZGhvbE5yOWFkZldYM0JE?=
 =?utf-8?B?c1BzQVlrNVR0Qy9lemdNRmt0QlRoYVh6UE5aWXVMYzY1Z2Z0K2hIRDluaEtV?=
 =?utf-8?B?VXdwZVdnWVVyQjJxTmRsUFVEcStrck9xeUI0bXB1ejRpd094dThaOTc0ZXRk?=
 =?utf-8?B?ZnpnOHFDcjBOTTM2MlorczlxbEZPUkFEa3NUcGU0RThlb0NPODFlcENyYzZH?=
 =?utf-8?B?OTArMFUvYkR6Vm5aK2hUV3pYOVJnaTM5NGpoSHRmT0ljc0xtZHpKcjE3NWRo?=
 =?utf-8?B?cTJxU2pPSEcrWWt0ZWU3NkFNRWFyZU5JOWtkQk5GOEpjUnNHOVpycy9EMG82?=
 =?utf-8?B?Z2RYbmdrR0MvNmRCQVMyUWN4YjBTVWNRSDlhZUJMZWNPdTB6dG14WGVndFow?=
 =?utf-8?B?cWx4U2tDclVtb3pMNXJTTjRBN1dsNEw3eTAvZVlpZnBTeWVkNVNjWTF6UTl2?=
 =?utf-8?B?bytYbU1OLzFYYTJFdWtseEt6OUdkb3FxcXpRdHhnQmZUVFUwdFVHUHA2Sy9w?=
 =?utf-8?B?TCtVbi9Bc1RnSjQ2dnRZeFErSDdrbXkxM25BT2tLWmZuaGhTZUUyZ294MFhY?=
 =?utf-8?B?ZG5nb0N4aDJBMHg3R3JsRndwQ0pYNEg1QytNekEwUXBIblJjZkZIb21YKzE3?=
 =?utf-8?B?Qytpam9QT1JNR1dtaU5yL1F6RHRRWUdDbGxxa0tWNStkRnpKeHF3Q2pSTEVn?=
 =?utf-8?B?aFlENE8xQ012bU1JbXVIZ3NCbjZVN1VJTDU4SHpXZDk4LzVEMFlPZXBqUFAx?=
 =?utf-8?B?MWErZGtBdW4rWFlGbm5ieXpFc2xBcTMvV0JEa0pYM0FsdXVkTjYvYzRMejZ0?=
 =?utf-8?B?VXRaaUZ3VGNyd0VKclo3MHBadFlubnFQREtpUTJUNEJaMHpENTE2dFZiZC82?=
 =?utf-8?B?N3NtK2FFdDlWYmlzbW5zZ01Zb3pYYU5rdCtwWENIdWhzUGJaa0VMalBldmxE?=
 =?utf-8?B?SjIzclc0MTZRRGEzZUxDaEtTbE1lLzNqdHh1eU4vV3FJc3dxK3FwMGlDbjN1?=
 =?utf-8?B?NmhYY2h3LzVXTkxtTWQvZVhLeUdDYzNOSnhXa3l2Z0tlOHltc0h6cmFhVURV?=
 =?utf-8?B?VitoR1cvSFFYU2c0WGtLRXg4SkpkMWlEcVlxM3BXQW1hTzg3Z25hV3UxSkp6?=
 =?utf-8?B?MEttVmFJOGlJNk5Lb25rdVRqWGFIWkVnWFg1M1FJb1liNnVOdlJVQjd3c3p1?=
 =?utf-8?B?MzY0V2ZNa0FPTFhMS08rMi9xTHlTVjF6V01HNGxQUC9kZlA0MCt1REd0d2gx?=
 =?utf-8?B?QXVnWks2QWdyMkp5bFZZazFGVlhmRS9Kc2ExQzJxdlpuN3hOV2pqZ09kNGFi?=
 =?utf-8?B?YitnVHZaQlJCcUE2U3ZYamVOZUs5VjFmbFJNcWp3d0QzSzdBMG95NkRZNHBs?=
 =?utf-8?B?ZGlpTGZxN01LanRSTFl2LzQvd3Y4cGVpbFNvNW5nSDRBeHFrWDZKVnlUbG9z?=
 =?utf-8?B?OWRMQ2R2K0ZkdnNzSDdWQXNYNHRBS0ZJMFFVUXk1NnpHM0pEb0lpRFBGS2Fl?=
 =?utf-8?B?MkdidjZ4WjJqbVNzaEVJSTV1K0ZuWThGaW0vL0hXdnhkZGxldUJBMXZvblJv?=
 =?utf-8?B?aHFKYUQyN3NYWlFFRWc0RkRKYjNrK2lldndGMStuZUZmSVpnWnZ1a0xsc0to?=
 =?utf-8?B?TlNzYzB3L3p0anFiMkFlOFd5UWRZM1hwa2dDUmFWUGtxTUdmSk1XcjdFc3Z6?=
 =?utf-8?B?WEhVWUhNZ2JEK0R6OVY2TWMxYysxSUVBZmY4OUpzbmtvd3B1Y0diWEprQmhx?=
 =?utf-8?B?UzhjdUk1UmRaRzZ4bDhEZFRxRlZWY2VhUHZzeHo2NWtBS2MxdTNwMjVPZ0Qr?=
 =?utf-8?B?T0xYbTdZNGozelE3TjY3MnMvTGQ0aFdJYWU1Q3hvN0liOFpEQ1hqT0R0Z2JR?=
 =?utf-8?B?RkxwZFpJdE0wZ0VnZlhJZEdVZThEd2NwaEcvdzBSeG42RmJuU05oREcyTHRF?=
 =?utf-8?Q?nIKzh7ePPKnDvCpwwz8lc/Y=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Teu9PmgejnJi/jZYLvcaEuAVPuXnY5PSQTgLV3uU2prsvykSdXtAFQuEhe/NYtvUsF1SqY7H+eTsnV9hW2U2shiRMU1OnuOT1ccigqXIommmbRTnMoudfTsQgQPqn/jmadEgXW8ELYd8g/mT0CdiiCjYi4T0vlrcBcmGVLOCWBinh/kMeAnts581fGiJByDfFPUrBwYwrT41w88/BUzd61mDxlgd5ByJ7doDjfDnZj5iM250UVTvD7/CabKR1xL5pyw7zupmX53MndjjAL96bS9qIcZRvtqmdzOZ/4mB58DN93n0ssLpr6XUmMDrHZtX38GKoelZJ+2yWZshG9xUUiyXQkseuTrrHK7sH5nvMfl+Bfa5w+lDqXyqSb6TIQyMfpgjdf+/rINRAQkJle7wi9G9lf6fFUp4TiSi0R8JaDNC5jJaneNee9zr1PchIFI3qVvOOGot8TEYU2jP86ZvgY4EJbTjwIyJUKZN2cN3GE3Vsb1XAr5WHMXz5w3U14/yHgtf0bkItglekEqP2I4wjD3AHklVoxmLtm0yYLbKG+jjYrU41xZvQMUi2O5xBvYa5NDvtrBQ5fHtSnLVp/ckYV+aSTkPtgnfcZf6GVLtQ1E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86c5d32-2561-4561-ef72-08dc124d969c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 02:32:43.1047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0Mt6u8kmgCMo6xt48wrO6jJXZ1EwpgmhXIgdEiyTQDuLTWB/Mr/kc0em6CLQGcfB1VlTWw78Q6jHlyHx/3r+K31vCpY35pSg5YPxjTXfW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7610
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_14,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110018
X-Proofpoint-GUID: KqOoh3iGrQAguqAtHYmuPZwpo_FbTC5P
X-Proofpoint-ORIG-GUID: KqOoh3iGrQAguqAtHYmuPZwpo_FbTC5P

On 1/10/24 2:15 AM, Muhammad Usama Anjum wrote:
> On 1/10/24 11:49 AM, Muhammad Usama Anjum wrote:
>> On 1/6/24 2:13 AM, Jiaqi Yan wrote:
>>> On Thu, Jan 4, 2024 at 10:27 PM Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> I'm trying to convert this test to TAP as I think the failures sometimes go
>>>> unnoticed on CI systems if we only depend on the return value of the
>>>> application. I've enabled the following configurations which aren't already
>>>> present in tools/testing/selftests/mm/config:
>>>> CONFIG_MEMORY_FAILURE=y
>>>> CONFIG_HWPOISON_INJECT=m
>>>>
>>>> I'll send a patch to add these configs later. Right now I'm trying to
>>>> investigate the failure when we are trying to inject the poison page by
>>>> madvise(MADV_HWPOISON). I'm getting device busy every single time. The test
>>>> fails as it doesn't expect any business for the hugetlb memory. I'm not
>>>> sure if the poison handling code has issues or test isn't robust enough.
>>>>
>>>> ./hugetlb-read-hwpoison
>>>> Write/read chunk size=0x800
>>>>   ... HugeTLB read regression test...
>>>>   ...  ... expect to read 0x200000 bytes of data in total
>>>>   ...  ... actually read 0x200000 bytes of data in total
>>>>   ... HugeTLB read regression test...TEST_PASSED
>>>>   ... HugeTLB read HWPOISON test...
>>>> [    9.280854] Injecting memory failure for pfn 0x102f01 at process virtual
>>>> address 0x7f28ec101000
>>>> [    9.282029] Memory failure: 0x102f01: huge page still referenced by 511
>>>> users
>>>> [    9.282987] Memory failure: 0x102f01: recovery action for huge page: Failed
>>>>   ...  !!! MADV_HWPOISON failed: Device or resource busy
>>>>   ... HugeTLB read HWPOISON test...TEST_FAILED
>>>>
>>>> I'm testing on v6.7-rc8. Not sure if this was working previously or not.
>>>
>>> Thanks for reporting this, Usama!
>>>
>>> I am also able to repro MADV_HWPOISON failure at "501a06fe8e4c
>>> (akpm/mm-stable, mm-stable) zswap: memcontrol: implement zswap
>>> writeback disabling."
>>>
>>> Then I checked out the earliest commit "ba91e7e5d15a (HEAD -> Base)
>>> selftests/mm: add tests for HWPOISON hugetlbfs read". The
>>> MADV_HWPOISON injection works and and the test passes:
>>>
>>>   ... HugeTLB read HWPOISON test...
>>>   ...  ... expect to read 0x101000 bytes of data in total
>>>   ...  !!! read failed: Input/output error
>>>   ...  ... actually read 0x101000 bytes of data in total
>>>   ... HugeTLB read HWPOISON test...TEST_PASSED
>>>   ... HugeTLB seek then read HWPOISON test...
>>>   ...  ... init val=4 with offset=0x102000
>>>   ...  ... expect to read 0xfe000 bytes of data in total
>>>   ...  ... actually read 0xfe000 bytes of data in total
>>>   ... HugeTLB seek then read HWPOISON test...TEST_PASSED
>>>   ...
>>>
>>> [ 2109.209225] Injecting memory failure for pfn 0x3190d01 at process
>>> virtual address 0x7f75e3101000
>>> [ 2109.209438] Memory failure: 0x3190d01: recovery action for huge
>>> page: Recovered
>>> ...
>>>
>>> I think something in between broken MADV_HWPOISON on hugetlbfs, and we
>>> should be able to figure it out via bisection (and of course by
>>> reading delta commits between them, probably related to page
>>> refcount).
>> Thank you for this information.
>>
>>>
>>> That being said, I will be on vacation from tomorrow until the end of
>>> next week. So I will get back to this after next weekend. Meanwhile if
>>> you want to go ahead and bisect the problematic commit, that will be
>>> very much appreciated.
>> I'll try to bisect and post here if I find something.
> Found the culprit commit by bisection:
> 
> a08c7193e4f18dc8508f2d07d0de2c5b94cb39a3
> mm/filemap: remove hugetlb special casing in filemap.c
> 
> hugetlb-read-hwpoison started failing from this patch. I've added the
> author of this patch to this bug report.
> 
Hi Usama,

Thanks for pointing this out. After debugging, the below diff seems to fix the 
issue and allows the tests to pass again. Could you test it on your 
configuration as well just to confirm.

Thanks,
Sidhartha

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 36132c9125f9..3a248e4f7e93 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -340,7 +340,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, 
struct iov_iter *to)
                 } else {
                         folio_unlock(folio);

-                       if (!folio_test_has_hwpoisoned(folio))
+                       if (!folio_test_hwpoison(folio))
                                 want = nr;
                         else {
                                 /*
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d8c853b35dbb..87f6bf7d8bc1 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -973,7 +973,7 @@ struct page_state {
  static bool has_extra_refcount(struct page_state *ps, struct page *p,
                                bool extra_pins)
  {
-       int count = page_count(p) - 1;
+       int count = page_count(p) - folio_nr_pages(page_folio(p));

         if (extra_pins)
                 count -= 1;


>>
>>>
>>> Thanks,
>>> Jiaqi
>>>
>>>
>>>>
>>>> Regards,
>>>> Usama
>>>>


