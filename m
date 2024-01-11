Return-Path: <linux-kernel+bounces-23950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AAF82B458
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A0C286B94
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5687952F73;
	Thu, 11 Jan 2024 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cWU4gF01";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kJqF233S"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA0851C27
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BGmw4d030123;
	Thu, 11 Jan 2024 17:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=UBsJH+bVuCxpQuUUfV/GuJMHnrHzQ+TtvcffQzrm7b0=;
 b=cWU4gF01tBhAKeS76i+W1ikaaN5PDO8xW9Pzatw64SPaJ278myHwEYy7WPsQSmVSdIzA
 hjgUIYMPsE4i5fufrpoT8PjVsb2LcCK0ihY4wP9YdhZeP5GAEiN22XMveeT1MOkV6S8S
 CfL2HTr7JS5FI7DnP9fbT0MuREGPtM/DIGUBqK4XaIH9hY3Av+wdwmR3ka65jAj/gNjw
 sG4jbaZR6OJqEaBJ8lDoez93icavAmZqUWyc9ju2DMoj1u0MUveGFIAKevXlZtTd0eP5
 +MMonsl2suQoMkaJMRywkpX6YAINsgBzr6sFKPjQpN/M5/xgkXEghTn5txmjGgdif4oh aw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjcnv14s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 17:51:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40BGpIcM030094;
	Thu, 11 Jan 2024 17:51:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutqgp5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 17:51:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZCQdrWTl6aSiPGXIAwt1hTk9EUxxRJHQM9D0i5O3Vi3umVB8i+vAsN+AH7v14jxyEy7wrXPwBvl5y84TSTLqt7vk/JHY/YEvmop+EnjzQHHWgo7YAsWc2tVycmPGDBRMhlnsTH8oZ+YBZY3rA4eOQnEKxek6YTlo9VImkh0pkNVPpQS6BICS0q8CFF1NQKQr8DGLhvmG3sm/fM3tneJlFd7jenUjm1jfH0tGQ8Aaoy4Knb//XhWMDt7j29fuWMXlfpAFV4YtuCN8EpttW6LmZf584EdPyy2QUxW/1QrP/ZLGcaP18J2XJUfmRmXSy5BZ12EuJ9zASL+UPK61TNZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBsJH+bVuCxpQuUUfV/GuJMHnrHzQ+TtvcffQzrm7b0=;
 b=m8bFiBc1oSgD2EyyMUILRcAySLO1W35di+G1M5st2lpfuhORn9tKFvNJ/GqNLScIgz0JxCiES9e7plruM8DjmxSoWzrAzebjX8/NW+M62b6rrvEn3ZL451qE4ID4H9A0dwOrrqHN3zLf7erHLtzNq74JjTQl+2Q7rgLlvDfsi6Iy0bkmvJpy8cw4exfWBKBaJW2xPSZNtpk7j9kn+uxWxC+K9Qb/Bjvcy775TI2gVWg67dgP7AMEATVzYjTZrbMYEAF2CsOq19DyF9SBsfsGy3cJBOjXQjMRmtGsdeLbl801zLcurbs6kgah4Asj38uOkzJzBsRiMx1XXQKAgUdgKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBsJH+bVuCxpQuUUfV/GuJMHnrHzQ+TtvcffQzrm7b0=;
 b=kJqF233Sv9VSpGWCJkWMifs4VDNXsu/V8Aq/zuSiNBSkfze1awTkjpYHCqkB06EhFNkA38uLNuVO03LSkGBZCxJaEwv12ScABtDN5Y1IXmWrcXfAIQBTvG2WJRqN2H1bmbXAWbdwuVAhXOHV6Z/Mb3qfa/XQrlupnhZRiwXIeco=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM3PR10MB7945.namprd10.prod.outlook.com (2603:10b6:0:47::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Thu, 11 Jan
 2024 17:51:51 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::78b9:5082:241a:d1fb]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::78b9:5082:241a:d1fb%3]) with mapi id 15.20.7181.020; Thu, 11 Jan 2024
 17:51:51 +0000
Message-ID: <6bacbd7c-88cb-1399-8bd0-db98c93a1adf@oracle.com>
Date: Thu, 11 Jan 2024 09:51:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 4/4] selftests/mm: add tests for HWPOISON hugetlbfs
 read
Content-Language: en-US
To: Jiaqi Yan <jiaqiyan@google.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
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
 <a20e7bdb-7344-306d-e8f5-5ee69af7d5ea@oracle.com>
 <dd96e476-e1ad-4cb5-b5d1-556f720acd17@collabora.com>
 <CACw3F53PddeCHUHb=m8OSO6yYQJoM==urn+Axp=Xi1szozJH9A@mail.gmail.com>
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <CACw3F53PddeCHUHb=m8OSO6yYQJoM==urn+Axp=Xi1szozJH9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::27) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM3PR10MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 544ab8f3-011c-40a5-15c9-08dc12cdfd93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DSJCcSxSPO7G/x5lBhJ2h61GNkRSoLR1AY8AN1+lbu0YxfK0dcfwg+UWMhlrNWAzXl9keCmTzYQ0PojNBZnTkAuSy9lRbIRi17v32jOF8eWjIre29J4DZFM3g7Vpb4NuuIu8Om0yjwwEL1y4bGOoF40ENEuvigen6gBTDvTYSG3xY5PSJZvAoBtIc5s6wINGco4JtMGp7fjpq20LpIUEONcJ6iTbNeLW9PCERkcOR8uYOatVCeQ8vswxbAmVJ7eVb8Mvaeu/xANVt/+utCkzNQ4OZSC/1GjkV/E5pLGvTvfRWfm+l5tuvISxYRB+z/XdWMjBdX4VFaa59pMFItLlxuDDIS041MFQgMoc3TUrFU5yvQku28S3SVzTRamJ8Yz4TrmiH9tkOU5NLVR1kHl0tp8peqAwX4B9qHz0HjNe+mxPQ/AO8ptMqNmbQQyFEJEE1ziVPj3ROTUG5GWIEQKFzMicGm2VBckXgUGQZFYLGctOXtwP31shpzOFlPiuCCVE8u6iDwNhhe5hdyy7a8tca7H671gzSk6ao8FZ+V/BCtjck3HVo1GI5ZvhrJOTB0KMvRoD4UbfcM2UZZ6O2bilrCQ/g34GN1EYp8L4x+nqu5AnCh75KZlQsz+rC2CuXSBEkyfeIGTz/7ays7D6ZP9pxg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(478600001)(2616005)(38100700002)(2906002)(44832011)(8676002)(6512007)(7416002)(4326008)(316002)(54906003)(66946007)(6666004)(6506007)(66476007)(53546011)(8936002)(5660300002)(66556008)(6486002)(41300700001)(110136005)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WkJndUcvdjl1Yk5WbzRnbFhzZVFOdXVUMHZkbXhTb1dxcHQxeE5HZUpQbTVO?=
 =?utf-8?B?dUJZbFhJazdxSlBkVFpldEJNUFE2cWRwbXArNGdGNmwxdXBLMzJsUjU3Yita?=
 =?utf-8?B?Qi9yb1FoUURWQkFpRTVpdmFVL1drOUNtcHBaQjhFZ1IvcDVKbFBzWGxjVXBY?=
 =?utf-8?B?c28wR3Q2NVIxNEJkY0ZTdG93OGF3UjhldHJudU02YWdZeEE5N2xPY1V1b050?=
 =?utf-8?B?Q0ZXcXFxQlp1NFpXL1BzT1JraFQydkFmZ2tqeUVTUTdCUklPMEhmdVNoYUR0?=
 =?utf-8?B?T2wzUUJTODIvTmVqZHcyZzR5Zkdxd01jQTFzZGtxaFg0dXF2M3RSSjQ1cHRS?=
 =?utf-8?B?UWVFbFMzQkdsZVlwRzVaSm4yQlpXWE1JdTdBS3BpRnpZcFc4YmxoQmJXa3BT?=
 =?utf-8?B?YkhocGxTTnhJU2ViaGd1L3djK1k1a3RmZEs5akVYOG9KZGlMcVY4aXpIYWdl?=
 =?utf-8?B?eklJNlEwTmxVVm0zQmd6UDN3ZlFseTRRbitKNWIrT29Ua1N2b21VaE1VNlVy?=
 =?utf-8?B?bi96VXJUSm9Rcm5jK3JZUzUzZmhmYld1UVJpZnJZbEtYUmVGd1BNT0lFWWhS?=
 =?utf-8?B?cHUwQzlYa0FnKzFaOGlsQ0E3ZGo3Q25FREN1U1JsTURtZlk3VUpEMVZjMjhG?=
 =?utf-8?B?cnR1UXQxNTlRSkx3Z002V05ZRnA2RUVPcUdpQ0RTaXBnUlpTamhPRStueE1j?=
 =?utf-8?B?aWpwblBhc0xBdVE5Tzc2dnRNZ2xZZStCRXBLU2lUV1pFY2NsMy9EcEhiWVN0?=
 =?utf-8?B?TEUxNmplcGdJUWZnREtjRmVhOGNxS1ozRzNVZ3ZGSkxVZk5kMEdpT2JuRnB5?=
 =?utf-8?B?UHl1N1g2UGxQQTcwbFZVeTNBeUtHQVNDbDdBNkFrbFhicWJtMXdUOVNDUGd0?=
 =?utf-8?B?Tk93UnNoMlNmckREWHo0TjB2SzdMT1o2MjdEN1NTeUVjOHBUNHdzc09VcTZr?=
 =?utf-8?B?MjV3V0xoUmNERk9Da2ZXSGxmKzZxWXR1YUd2bmdDNzZWM21ab21TNDlZWjBE?=
 =?utf-8?B?Y01PR3dvQWZRK3pySXoxSjNYQTdBWG9qSlZ2RHVvYVdjM1NMUzQyYUxieCt0?=
 =?utf-8?B?QVBJNVpyVTZBYmdHV0RGd1JUR3F0eDU2emZDSG4wUm5YYnJoUjJMQ25jUllS?=
 =?utf-8?B?UmFLOEtXQmU4TExvOXlZU2NzSVdtd21uMUFIZ3JRbjRyYmtFOUNSOTJCeWpr?=
 =?utf-8?B?bjFDeWhWSTc5aHozdGplbVRmMFFJTjBUcXNrK2tobFc4WDdjRERKUXBTZDZ5?=
 =?utf-8?B?MWMycHdpaTl5SXNmaDNUeFVJS1JUSCszT3lCQWF4OHZIbTBzSjBwbkttT3Zk?=
 =?utf-8?B?clZLR2hxNytrZ2NqSFpxemNLQUw0bXZSM2ZnYlMyaFRlVE9NT01SK0FVOWFQ?=
 =?utf-8?B?NDl3Z3JxNWkzdHp1SU5ybG82NEVCcEt6M0RZb3NNeHppVFpkR0NoUHBGNzhY?=
 =?utf-8?B?aFJPQ3dERFpFbFViWDNWYlZPbWhsVG9MS0dXd3dPeUVqVThMa3dlcGlCUmk0?=
 =?utf-8?B?TlRNamVUeE5neVdmdmo4Ykt5NXp3SUcyVVhzdnZJUjR5QTU5dTdRQ3FNUlhq?=
 =?utf-8?B?OUJ0bHFabWNhU3h5Sm5KdldJdTQ4SEJ2UWdDcVJoeTVMaU92RWI0NzlwSWxE?=
 =?utf-8?B?TUREQzk4VVN4TTZ6WFdjSFRNdnNsVCtoSXhPR0txTk9GOXJhY0d6emJ3OHl3?=
 =?utf-8?B?MTU0eG51alAwVHR5SGZTR29uMGNPR3ZVNmpNVXhiMFhDWnA1QUN3S2NTTmJw?=
 =?utf-8?B?T0x1UVdKSmhmWFJ2L1c5ZE8yVmwzL0t1WjFHSGVOWmpHTWFsR1MzS2RNazlQ?=
 =?utf-8?B?cVJycENPTDFVRFE5UTRtUHhYd3M1QWJGbGdiaGRzWnFqcmNLd2Z3cFZhVHdT?=
 =?utf-8?B?Y0tuTGdaL2FvN1BYRU9HMERvOVVtSW0rSlJhSGZuY1BjV0J2cit2OVBvZ2Ew?=
 =?utf-8?B?SklialMwb1VoVnhEcEN0TmM0djNvU3podDgvVGh4bmRZRTJjOFZKNEV0OW50?=
 =?utf-8?B?aUZycm9OWmgzZkNWN2o3UDRGN3MxU3ZMbWdpK2grZGRzcTMwY0tGTnkzZnBI?=
 =?utf-8?B?bWJDZEFsaEFBbmxrZDN2ejBYUVlpUUJBeFZ4dURQSll3L0VwV09WOThLSkZT?=
 =?utf-8?B?SUtjSmU0Q0ZZUzlQTEpjcW5OdE9qQWNXYXVwaEg0QXAva1FUMWkrdFRaM3Jr?=
 =?utf-8?Q?HmgSHAxGqta+wNCBjj/w8t0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qYn6WfPfHFrHu4i6hjV+lfhU+1NNmE8aY6fWYHxUTYcqcwFc/ZWIQDJHyuG9HE0rP3x64fudkCX6sBaajvhw8HsBRqNEejN1vBNhh4SKLkMipe86VatT6SqQxQpaPrB8eccdZ7ntBGtd1hdsiz45bY3Pb5x4ap2j0FtoMLgiGdbnxOa8ER3eie55PymKHFr54eNMEy1GcCmHLfUbfZcWdg9dWb1RNsRNZdT/b8TgK13GsIN768pxVIKvmZwww7JsOGw17fruzE0pZ1SPHxiannFlTyiEvpMxCv2cvvteNgDKzAGobZPkWP47HUmYPinewXlUGaxIFaloYFn2z0OYR0QYp4EMXoJ0VZcSS1+vHfj1yaXi1XnxJa+hHjStpCUfREmoW2vJEgmkV8eEB1Q+Ilo+DJoVgzbMCwoDuGrZlyTokkOvlLejLt62RCl204N4M3HtBxMcWAcZ426MbmCZwEEW2fF8pa6yStOyFUh8oi5pd76+bY6H9OmLf2G7UAP5Er3/sLoWb1VGwaYAwhfYvYC+B9vFdUnt1BUXdxY8NNq7G7HiitLZ8U9cgATmkp4ySa5ZqxSbB8Ak/rHRAMw97HoT7licttbcxEpCh3lw1Gw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544ab8f3-011c-40a5-15c9-08dc12cdfd93
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 17:51:51.2990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yg4DWuzMS6OHQhW/8D56vpN0sHO/zAnjWb7xDDH4utKhlNisf5WGHJJ+Ysh0gsSumfs1CfxEL114Bm1kc4DmIMS4R8rwMAYXLpWxZBeRPVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7945
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_09,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110141
X-Proofpoint-GUID: snQ70iX21yvzxzFOHPYddvr1F9BUo6po
X-Proofpoint-ORIG-GUID: snQ70iX21yvzxzFOHPYddvr1F9BUo6po

On 1/11/24 9:34 AM, Jiaqi Yan wrote:
> On Thu, Jan 11, 2024 at 12:48 AM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> On 1/11/24 7:32 AM, Sidhartha Kumar wrote:
>>> On 1/10/24 2:15 AM, Muhammad Usama Anjum wrote:
>>>> On 1/10/24 11:49 AM, Muhammad Usama Anjum wrote:
>>>>> On 1/6/24 2:13 AM, Jiaqi Yan wrote:
>>>>>> On Thu, Jan 4, 2024 at 10:27 PM Muhammad Usama Anjum
>>>>>> <usama.anjum@collabora.com> wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> I'm trying to convert this test to TAP as I think the failures
>>>>>>> sometimes go
>>>>>>> unnoticed on CI systems if we only depend on the return value of the
>>>>>>> application. I've enabled the following configurations which aren't
>>>>>>> already
>>>>>>> present in tools/testing/selftests/mm/config:
>>>>>>> CONFIG_MEMORY_FAILURE=y
>>>>>>> CONFIG_HWPOISON_INJECT=m
>>>>>>>
>>>>>>> I'll send a patch to add these configs later. Right now I'm trying to
>>>>>>> investigate the failure when we are trying to inject the poison page by
>>>>>>> madvise(MADV_HWPOISON). I'm getting device busy every single time. The
>>>>>>> test
>>>>>>> fails as it doesn't expect any business for the hugetlb memory. I'm not
>>>>>>> sure if the poison handling code has issues or test isn't robust enough.
>>>>>>>
>>>>>>> ./hugetlb-read-hwpoison
>>>>>>> Write/read chunk size=0x800
>>>>>>>    ... HugeTLB read regression test...
>>>>>>>    ...  ... expect to read 0x200000 bytes of data in total
>>>>>>>    ...  ... actually read 0x200000 bytes of data in total
>>>>>>>    ... HugeTLB read regression test...TEST_PASSED
>>>>>>>    ... HugeTLB read HWPOISON test...
>>>>>>> [    9.280854] Injecting memory failure for pfn 0x102f01 at process
>>>>>>> virtual
>>>>>>> address 0x7f28ec101000
>>>>>>> [    9.282029] Memory failure: 0x102f01: huge page still referenced by
>>>>>>> 511
>>>>>>> users
>>>>>>> [    9.282987] Memory failure: 0x102f01: recovery action for huge
>>>>>>> page: Failed
>>>>>>>    ...  !!! MADV_HWPOISON failed: Device or resource busy
>>>>>>>    ... HugeTLB read HWPOISON test...TEST_FAILED
>>>>>>>
>>>>>>> I'm testing on v6.7-rc8. Not sure if this was working previously or not.
>>>>>>
>>>>>> Thanks for reporting this, Usama!
>>>>>>
>>>>>> I am also able to repro MADV_HWPOISON failure at "501a06fe8e4c
>>>>>> (akpm/mm-stable, mm-stable) zswap: memcontrol: implement zswap
>>>>>> writeback disabling."
>>>>>>
>>>>>> Then I checked out the earliest commit "ba91e7e5d15a (HEAD -> Base)
>>>>>> selftests/mm: add tests for HWPOISON hugetlbfs read". The
>>>>>> MADV_HWPOISON injection works and and the test passes:
>>>>>>
>>>>>>    ... HugeTLB read HWPOISON test...
>>>>>>    ...  ... expect to read 0x101000 bytes of data in total
>>>>>>    ...  !!! read failed: Input/output error
>>>>>>    ...  ... actually read 0x101000 bytes of data in total
>>>>>>    ... HugeTLB read HWPOISON test...TEST_PASSED
>>>>>>    ... HugeTLB seek then read HWPOISON test...
>>>>>>    ...  ... init val=4 with offset=0x102000
>>>>>>    ...  ... expect to read 0xfe000 bytes of data in total
>>>>>>    ...  ... actually read 0xfe000 bytes of data in total
>>>>>>    ... HugeTLB seek then read HWPOISON test...TEST_PASSED
>>>>>>    ...
>>>>>>
>>>>>> [ 2109.209225] Injecting memory failure for pfn 0x3190d01 at process
>>>>>> virtual address 0x7f75e3101000
>>>>>> [ 2109.209438] Memory failure: 0x3190d01: recovery action for huge
>>>>>> page: Recovered
>>>>>> ...
>>>>>>
>>>>>> I think something in between broken MADV_HWPOISON on hugetlbfs, and we
>>>>>> should be able to figure it out via bisection (and of course by
>>>>>> reading delta commits between them, probably related to page
>>>>>> refcount).
>>>>> Thank you for this information.
>>>>>
>>>>>>
>>>>>> That being said, I will be on vacation from tomorrow until the end of
>>>>>> next week. So I will get back to this after next weekend. Meanwhile if
>>>>>> you want to go ahead and bisect the problematic commit, that will be
>>>>>> very much appreciated.
>>>>> I'll try to bisect and post here if I find something.
>>>> Found the culprit commit by bisection:
>>>>
>>>> a08c7193e4f18dc8508f2d07d0de2c5b94cb39a3
>>>> mm/filemap: remove hugetlb special casing in filemap.c
> 
> Thanks Usama!
> 
>>>>
>>>> hugetlb-read-hwpoison started failing from this patch. I've added the
>>>> author of this patch to this bug report.
>>>>
>>> Hi Usama,
>>>
>>> Thanks for pointing this out. After debugging, the below diff seems to fix
>>> the issue and allows the tests to pass again. Could you test it on your
>>> configuration as well just to confirm.
>>>
>>> Thanks,
>>> Sidhartha
>>>
>>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>>> index 36132c9125f9..3a248e4f7e93 100644
>>> --- a/fs/hugetlbfs/inode.c
>>> +++ b/fs/hugetlbfs/inode.c
>>> @@ -340,7 +340,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb,
>>> struct iov_iter *to)
>>>                  } else {
>>>                          folio_unlock(folio);
>>>
>>> -                       if (!folio_test_has_hwpoisoned(folio))
>>> +                       if (!folio_test_hwpoison(folio))
> 
> Sidhartha, just curious why this change is needed? Does
> PageHasHWPoisoned change after commit
> "a08c7193e4f18dc8508f2d07d0de2c5b94cb39a3"?
> 

No its not an issue PageHasHWPoisoned(), the original code is testing for the 
wrong flag and I realized that has_hwpoison and hwpoison are two different 
flags. The memory-failure code calls folio_test_set_hwpoison() to set the 
hwpoison flag and does not set the has_hwpoison flag. When debugging, I realized 
this if statement was never true despite the code hitting 
folio_test_set_hwpoison(). Now we are testing the correct flag.

 From page-flags.h

#ifdef CONFIG_MEMORY_FAILURE
	PG_hwpoison,		/* hardware poisoned page. Don't touch */
#endif

folio_test_hwpoison() checks this flag ^^^

/* At least one page in this folio has the hwpoison flag set */
PG_has_hwpoisoned = PG_error,

while folio_test_has_hwpoisoned() checks this flag ^^^


Thanks,
Sidhartha




>>>                                  want = nr;
>>>                          else {
>>>                                  /*
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index d8c853b35dbb..87f6bf7d8bc1 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -973,7 +973,7 @@ struct page_state {
>>>   static bool has_extra_refcount(struct page_state *ps, struct page *p,
>>>                                 bool extra_pins)
>>>   {
>>> -       int count = page_count(p) - 1;
>>> +       int count = page_count(p) - folio_nr_pages(page_folio(p));
>>>
>>>          if (extra_pins)
>>>                  count -= 1;
>>>
>> Tested the patch, it fixes the test. Please send this patch.
>>
>> Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>
>> --
>> BR,
>> Muhammad Usama Anjum


