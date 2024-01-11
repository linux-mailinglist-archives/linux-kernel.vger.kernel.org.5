Return-Path: <linux-kernel+bounces-23965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E6782B48D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2434B1F263F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1289553E37;
	Thu, 11 Jan 2024 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q2O/BF9q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NUZgcu42"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2054553E23
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BGmw57017285;
	Thu, 11 Jan 2024 18:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=EjB/6oFslutHK0mGctzSTTs5r1IgdhWzC6KCBZI0+kY=;
 b=Q2O/BF9qFwQk3RKdRA8Q/yy38aZY9Zeoxyy1X4sYfmjTYmqUX5WSmN3Z+4RlHA45xlgZ
 ilXS8a6/zmRC55jjrDZkwKReQvREt+eWIsLIJ7QL44rJwQ2pW/rWVU1nsWcYRuaPVhKk
 GTtZGH6UoAc0J8354T6UxdpjpEbMP+eZwXzyI3bG9sf69aRs+x7iwMBgLkToT+6OQdO8
 OUXkfcW0vVl4+5b0o9QR9ZFOBJLi7UAaZVQluLb+dCyKC8WvV+X3QiyygbAedY4by8aG
 TNRN/ra9vEJmYi4y8unpWcH9ZUkA0I1Cuyro0Pbb307wWLuL4yHIPnX+LpLCJBlPr3fN wQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjcbkha0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 18:11:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40BI96uK035052;
	Thu, 11 Jan 2024 18:11:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuu823ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 18:11:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI6BZJDU9pBOSI2K/FQLsmRm+dnw83LIXrH3sI4iG0P7lskBMh/3g6MA6oSS4ATe+uS8x6oI1MLamL8eWIL+SyUliEv7EWIecqjq5IPdCoQzxJxoyAsg99r+wl1eDqEQEpQlwUKU5Dczl49Lo6Tg/yMcCrSmP0E5W63OUgKVF2Pr5F12ioDN5W8CceYNHuhf/6Cd6JRXDesjnJAQAIl55QNK2PV29LISn8oVx/zAAdO1s0eM2jmrklPpqEO0R3MQnecAenAmZ9Dc38jUDU5rcrJ+w/EjU/5VNnf0QPIMr76tcMt/4N6jc8yinOULGeFpTFaahJtzAekT3Cr0WwE7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjB/6oFslutHK0mGctzSTTs5r1IgdhWzC6KCBZI0+kY=;
 b=PJGHsank8pgFna9CZ6y0wRHfSqxKoCbt6xHJHeUUfeOKXD2ysOiKfKouSBE51pTt3CHl7M4inKWZcsLL2JvPMurLXb4D3LnBaje8DUjSB9wNqvG8Z8ZIdx6JbgcAI58xm8Sn96yX7ELMHSf2be//Aj8kMh7bdLVG2QBHjbv0Rb1dbxCkd9NNgHlSySvG4KQlZEB0aqgSa+N/LpscFc5j4qUh8VLTM6sPe5DvYBVykVyU8sNSFAS2XfC/MBOc0ziAy9hHnwQQxXZLHXCoObzXRkbYMl/JWH/JHdNpd/InpoVXV02k7cx0yP59oeHIycMb41r/ioEPNRMxNrqaRNgrrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjB/6oFslutHK0mGctzSTTs5r1IgdhWzC6KCBZI0+kY=;
 b=NUZgcu42y01iz1M4BBUVBGF5OdDxxB67f6729ep4q5qJcVkchs33GqXDDmwKgBwI28we0FtGVVoWAJtUDrSeGFUZ9uDj8ZUYN4yt5AOWPWGKO0iw06Pu3ccxbPEcrFCqnvA5tASJVACSz+LwR3LWZq9VSvvjkMJLZmmET7rNZjs=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB7313.namprd10.prod.outlook.com (2603:10b6:930:7d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 18:11:16 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::78b9:5082:241a:d1fb]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::78b9:5082:241a:d1fb%3]) with mapi id 15.20.7181.020; Thu, 11 Jan 2024
 18:11:16 +0000
Message-ID: <39b90dce-fe0f-e1d8-3094-75cabbfa38a3@oracle.com>
Date: Thu, 11 Jan 2024 10:11:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 4/4] selftests/mm: add tests for HWPOISON hugetlbfs
 read
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: Jiaqi Yan <jiaqiyan@google.com>,
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
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <ZaAtjVVTETdQDR4B@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:208:36e::21) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ed3b5d-2cfd-4c95-23f0-08dc12d0b429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dGEqdhn7s7um4wywEvszdwgWWTSnYt8PF0fxV+iXwNwYSqrdzneyhQHswY7XPF0o1pKgTBw9kimnlpTHBUIEo9NbezzOcLeKDiR6m/KZr3Gh4p0mu43PFGgkTvwVgU9sr7AiVexbbGAEcb8W7OVa7JtVEcxAecggIkJHYnnobL0tPet39ZAvBwX7/OyvJyQ+LGhfBcAelQ60ftWqpF3gFMa256Gszoty48aBzOgTOHTpeukW5n1vwG+bo9CRYzSV7/+c5swd39JwtGACV/v28sm1gqDMrHs3D0obPw8oubf2qwT/b1HiLcdGMeRY0fT2fwMDEmweKOsd2Ub6BPizI4GNZbwbS7TPZPXYzucH+AJqrFyTFDrhwe2IJ5a8zuu2IBq3jRD5f7Lh8U8t+BuvWSFHpkW6+VNWsGv4KsOYDfF9uwm7pdteKjSq402uSkm+7xAn89oofXJsgPRprakEm+8a5wl90W02gnJklAZWWelOmQeAqF4gTUW2zpXvcjX+dvfLM2xCW8Y7eh4byHm58HZiIya/37waNTaO5TqeXJ1Y+tuVrgJUZRd+kxhuiUyMbRmzoaSEdZ2OCXuyoVQWmOWEAZmXqGpb61qFzGnDNOHkwlQhwf8bzJAQv5i2CJpVqX1UGdA50TdvqpZlWJuiBQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(39860400002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(86362001)(36756003)(31696002)(8676002)(4326008)(6916009)(38100700002)(53546011)(2616005)(83380400001)(6512007)(66556008)(6506007)(6666004)(66946007)(478600001)(66476007)(54906003)(6486002)(316002)(41300700001)(44832011)(8936002)(5660300002)(7416002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aVpOaDgrdXRjZERia3hYR0lCUkNrbDBjRExMMi9YOEY1cXBHbFVOYXQ1ZFgv?=
 =?utf-8?B?OTJaWmZidmJ0YlBjdXpucDYrUmhxTURnaEpUVzc3NzdEcE0yZGZHNC9oeHVq?=
 =?utf-8?B?VTdKWFRkOEIwOGorV0hSblZ4eVU3M1B4L1plV3pBMWNlYTlYV3hzYXQ2ZS9H?=
 =?utf-8?B?MVpnT2lUOEJJdTdJTUN1MWY4YnVuOXd1dkI0dlZkbkpEbHdqVlVYRm5XeUZI?=
 =?utf-8?B?VHRKTVBaUWFDWENsWlAzODd4RnZrSjZPTVVOb1lLMGRGMmR6K2lhQk1lTlNJ?=
 =?utf-8?B?VmROT2drSVdjMytoeTNyL1puN1lPM2tpc3pPYWpJMVMrTUZzanp3Q1VCeStp?=
 =?utf-8?B?a3N4Rmk1SW1kSXFiZEMzTzRkQ3RjWUY4Q29ibWkrYWZSTVN2MWJ1UUJzMGxE?=
 =?utf-8?B?WmF1MGhIVDlKeEFyNmlHMFhqMnpuemFvemVUNjZVRGdNZzNJNEp6RHBON3RG?=
 =?utf-8?B?aDFCcmRHKzhoWSswKzlTWXhQcHB1UDlWRldwSjNqdkwwRXR3K2ZrY3JLc0Ix?=
 =?utf-8?B?L1hXcXJMejFzV1RJMmZOT3I3dzlxbnpHQ3RKSlRvNTFndjZNYlRZTllWM0cy?=
 =?utf-8?B?UDVuVkp2SmxUaU1Edjg4RVVFOTZnNk5rQTdhazk0enZGWmdwTkkzQUJwMmJR?=
 =?utf-8?B?T0k4UDQzYkVqMTBEajlXeXpSb1YzN0xGdkhHdDI2SDZYaTV6UG5KeURVZ0E3?=
 =?utf-8?B?ZGlhT3hNN1U1VDV3SXNTU09YOUc2ZkEyOXpTN2xibUd0UXUzekZkbm9RM2xY?=
 =?utf-8?B?Q200eExDQzF2cDcxcmJiY0RRdWcvUTY1NU5MbncveDl2VnZMM0lSTVhvNm0r?=
 =?utf-8?B?RUFTTExqdXRZakRtZHJhWmw1NDBsVHJ6dXJISUR0N01EQ0hSMFlralkxaHhO?=
 =?utf-8?B?aGFnWW9LZGFDbVoyY1IrZVFyZk1XR3hpNEcwZUxPN1oyZzhTaUQ3NStsUHVQ?=
 =?utf-8?B?UVk4WVFvaDRqN0I4M0c5OGp5ZWtocHBMQ2ZyMFFqalVzM21UU01GRW9WVkFG?=
 =?utf-8?B?YWVqcjZYamxvVnpTNHZ2Z3hEUGEzdjdRYm0vekdMY3oxVXA2QWhtM0lNV0pH?=
 =?utf-8?B?aUc1MUo5MUdtbFRodmhxM2pqaDBZTlZDOWZVREhxWWV2SFZ3OUFNYXhvZ2o4?=
 =?utf-8?B?VHBYamdEMTdQRnNvTHdVN2s4TFI1MWtIZlBNU1ZxOTRVOVhtdGtzNytrMVVJ?=
 =?utf-8?B?MEVldnZlcnNLRzZOa1o2RXFXOER0NFBzTkpBQ25iWGtvQ3hJVDhwVHFtcW9v?=
 =?utf-8?B?RVl4U0lqRWlYME9RTDcvU202YUowbTBkVmxBMjgrL0Z1QU4vcGczeHBmU04x?=
 =?utf-8?B?VXNkY0ZvR1JlTXp6YTJzK0podUkzT0M3Sm9TNXZrSUxOdmlRTmswRWZBa3Jn?=
 =?utf-8?B?eHFseUUzWEhoRU1NbFdVQUtYNU1BSnRlcW5wTlArb2Q1L2V0aWZ4UWI5bmZs?=
 =?utf-8?B?OXRmSnVHZ3ZNRVovRitiWFY3aVhCMFowQkdwNytDd04yOFFkOWNGUm1peG9H?=
 =?utf-8?B?WHNwKzEzVkJQR0tGWEdZSGx3K0ZTZE1lOWJsVHVRelNYaklCYTdSZ09zdm5s?=
 =?utf-8?B?SFhzNGNxRW5WY0xvenRTeWxiZlVWSC9rdzVHWUNtWUFlZFR2SHdTVFlFN2M1?=
 =?utf-8?B?UTVQUkdiNXc4NURtMDRQYmF0RXBKV3kwNXBBNS9KRnFNUy91dlJZUXgrOGgv?=
 =?utf-8?B?WEhyeklQbVFXR3oxTEw2d0RVL3Znem5KQ3FTUi90SVpVLzFENmhEM3ppTndq?=
 =?utf-8?B?SXdBRi9GalJsWTE3TmlhS3p2eUhRYW1oSnRDWDFDRnF1ZVl2U1c4STdSaFhQ?=
 =?utf-8?B?WFduS3MySnFqSWpHK0pSa0tlV09ZcENQZnhEVmJtZVhtTE1wVlBiTWEzRGJI?=
 =?utf-8?B?d2VEZjlqcmFla3BORldOVHo3WUVBeS9OQWcrLzVSUW5ZT015ckZiVWhXQlRh?=
 =?utf-8?B?Z3ppeEFIdjgwZi9hWnk1anAyb0RCTW1rU0dnYjE0RFBzcWlTTUJwUzc2WTBD?=
 =?utf-8?B?d3g3RkJaeS9DZlhyRmlsR3ZaUnFNUzNDby9FQmY4R3pjc2Z6VDBnWG9rbWp5?=
 =?utf-8?B?dDJyVWp4WkhSSGtQSkxDSVFmSnZtcEpNOVVlU3dBeFhIc2Zjck5FVGIyMWth?=
 =?utf-8?B?SFdWa1dZQ1l0S3FYamo2YlV4anhQUEUvaURLTzJuRWFKNERiZWVTRnNiOVUy?=
 =?utf-8?Q?kNKul3zQy8yRN1ZVmmsJego=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/HGKQG1EDPKMgLTTEltQu571BpCjTCYgbEbuTPi/gwT6zPekrLSm0T32E8N1np5YLdJT2KDjIfNOpnPyhKXUwgNGWB7kpbhoyGn24kmNqf7lmzS6sKmNYtmVaW6fE5H5jycn8j+O7VJHwUczCruCJOH1bVcp7/mRZJnV6SQVJws+TbXFglXk6OHYrw7KvXsHlt1sksYofVOK+66FxexlPqmYgwKhKUEd7fEmogByEj8kCY6XenLwoBA0ljid2vMhbkw7eElu1W7FmwE3YCegpy/QKHpnDyddD/8bRDMVPVZZ5rO92yMaNk9GS7EqYHM2kuNGCG5Tj36o3LOhlSSj5SN4JB6UJ5MVSJraUFmuev6Gtj9jaoHhfqA5ZDYaiU++GsjgHcQrVqAOSmCKtzjMTUMXaIF65Q6UOCcodLSAP7K+ZNcWxjBljUn60Kmreyijl81mPDn/yTYJrYJVZuWUw+wAEXH6K6LERGy3WWouIGW1mRwWmlpgdE3iFsXaPgCa268d4+uYVRdP1QB7WwE+xw/Efoxi8qklyRQQPnJvTA1ud6/QL4ydgxisgsXD15nzrnczuMxraW91nRjlLcwF8NClqy9qSRRl1ct0EOMTbsE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ed3b5d-2cfd-4c95-23f0-08dc12d0b429
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 18:11:16.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lA/NuFnXWn14sigpJcXTmbyRRxxgvK4Cjt4GlYm1MR6gQd4k/d12tVsJd+BJUfyeoDP38eh8AeA/+GDyYOugvxvqxD8nbwlzz2btvr56/NA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7313
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_09,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=905 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110142
X-Proofpoint-ORIG-GUID: G-IUUz7qZub2scK_UAIpGSiCkQiDOeyb
X-Proofpoint-GUID: G-IUUz7qZub2scK_UAIpGSiCkQiDOeyb

On 1/11/24 10:03 AM, Matthew Wilcox wrote:
> On Thu, Jan 11, 2024 at 09:51:47AM -0800, Sidhartha Kumar wrote:
>> On 1/11/24 9:34 AM, Jiaqi Yan wrote:
>>>> -                       if (!folio_test_has_hwpoisoned(folio))
>>>> +                       if (!folio_test_hwpoison(folio))
>>>
>>> Sidhartha, just curious why this change is needed? Does
>>> PageHasHWPoisoned change after commit
>>> "a08c7193e4f18dc8508f2d07d0de2c5b94cb39a3"?
>>
>> No its not an issue PageHasHWPoisoned(), the original code is testing for
>> the wrong flag and I realized that has_hwpoison and hwpoison are two
>> different flags. The memory-failure code calls folio_test_set_hwpoison() to
>> set the hwpoison flag and does not set the has_hwpoison flag. When
>> debugging, I realized this if statement was never true despite the code
>> hitting folio_test_set_hwpoison(). Now we are testing the correct flag.
>>
>>  From page-flags.h
>>
>> #ifdef CONFIG_MEMORY_FAILURE
>> 	PG_hwpoison,		/* hardware poisoned page. Don't touch */
>> #endif
>>
>> folio_test_hwpoison() checks this flag ^^^
>>
>> /* At least one page in this folio has the hwpoison flag set */
>> PG_has_hwpoisoned = PG_error,
>>
>> while folio_test_has_hwpoisoned() checks this flag ^^^
> 
> So what you're saying is that hugetlb behaves differently from THP
> with how memory-failure sets the flags?

I think so, in memory_failure() THP goes through this path:
	
	hpage = compound_head(p);
	if (PageTransHuge(hpage)) {
		/*
		 * The flag must be set after the refcount is bumped
		 * otherwise it may race with THP split.
		 * And the flag can't be set in get_hwpoison_page() since
		 * it is called by soft offline too and it is just called
		 * for !MF_COUNT_INCREASED.  So here seems to be the best
		 * place.
		 *
		 * Don't need care about the above error handling paths for
		 * get_hwpoison_page() since they handle either free page
		 * or unhandlable page.  The refcount is bumped iff the
		 * page is a valid handlable page.
		 */
		SetPageHasHWPoisoned(hpage);

which sets has_hwpoisoned flag while hugetlb goes through 
folio_set_hugetlb_hwpoison() which calls folio_test_set_hwpoison().

