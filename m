Return-Path: <linux-kernel+bounces-7896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7422E81AED1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BEBB286598
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6C516438;
	Thu, 21 Dec 2023 06:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tc0sc24T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TqTeVgWb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D815AC3;
	Thu, 21 Dec 2023 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKMd3WF012707;
	Thu, 21 Dec 2023 06:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=i8HDgbIKl3er3Ho71VGfl1WfZCEyuP0cd/I0RYIokuU=;
 b=Tc0sc24T9qo7kVtLll5RuBeaHojVdEeXZKo28o1jyl3VYvJCTYkmB0BTl30cCUijjIuL
 eTrsgdtysAWMLfsNGikCnFAeRSaMlKKULTflponki16oiwpGwkoNCznk9q2Y/1/Bu45x
 WoLe788OhRErZjUWvFdADnApSi9WnseO/kcJaKL3LRRp+PnwIaK6tSGuXdadtQ080Z7x
 kck9j/TB+cb+YTdVf0RYEwpxuQIWpO9hnCM89dNPLQ+ePnmWGz2+h0u2Z3ewUWmB650p
 7ymL+OJPe12i7c94NXx4Keok8IpHUtVIewsw2sgeoyyBxgiWAU0O0mKnrJfN7fuJ9h0R LA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13guj5cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 06:35:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BL6KSpK020048;
	Thu, 21 Dec 2023 06:34:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bgaqs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 06:34:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ly2QLisBsfjcnfPTtSMKksn7fDOyVFSLNHVgdvlBxq6bqmlWNKY9hLtKz3IGUbSQRNi6PTc5FyOPWEllS4iPZ5a1+AwZe7qlwVamH+qgyTCJ0PJoG+bDU8Z65NcpC4JDImZD63Dpwh5ORqvkNVq9oTcZDUK6C3iQAnOmxVUhM2PCbTM48i4qw/NV57ZIY732RozF1SlvnOH7kDsn9MWBkxC8Z0nYtKWDh05MXydQ1G4t0xvsepAMbE2vNOHd6OQ25DGG/wG8pw+FW3pikFALxbVDrpRbL7Tz7kZn6SCA1rOk6HgPxiKXtFgLkBphHKyZPO9oB1sdYt7DfaIO5fSE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8HDgbIKl3er3Ho71VGfl1WfZCEyuP0cd/I0RYIokuU=;
 b=LK+uZGjYw+usG4GD5gNkRP9FB9JklV2knK4eeQYq+Qsou4oFQwGV1v1atXLwKGjltLSXRkX6r+VMfYdbpp16niM/vychg9v5ie7L2i4mHBc1l4sbnmvrWecb72jCPIR4VDrU7obCtBIG+1yVubL015dg7MEOse+WfWGN1DpKkJOGKBpgM80uf4rJrbZhxyrhP2n1OOEthoHjyUd/5It4j4iGg3z8wC14ikYxC5Rxq2DWRitCm7qIG3AdAUkCFDokAGIPXZega6ID/ohOLXf5EFeiVLWtnktX4q7zs7laPSR4KQRNJMeoH3ZwmdMnTOwS5auyeZk5ugerzM4l/Jtwog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8HDgbIKl3er3Ho71VGfl1WfZCEyuP0cd/I0RYIokuU=;
 b=TqTeVgWbg69RiyAMiuSdLW8+hNeMSzrt1OfXLbGNp6qXtzLOR1/v1Uy+kj1cbvoPYn9JFEtikuwuQAGfPhmyBb8aFmzViXqsuRAvdMERMhfMDeoe0q7eVOVkwI5q7G4I878N/zCGfuk1fg/nCU1EIJJzTrpRHewDgdCtAosbm1s=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CO1PR10MB4675.namprd10.prod.outlook.com (2603:10b6:303:93::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 06:34:57 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4%4]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 06:34:57 +0000
Message-ID: <07fceabf-812c-4510-84c7-b9f4636a0258@oracle.com>
Date: Thu, 21 Dec 2023 07:34:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] Rework the top-level process page
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <87msuk2pu8.fsf@meer.lwn.net>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <87msuk2pu8.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0244.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:239::22) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CO1PR10MB4675:EE_
X-MS-Office365-Filtering-Correlation-Id: b38d266b-d31b-453b-9c8e-08dc01eef344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RVY/DiynPzsBD0UWYkd5fB/R1t0pplpnaLpXCmoNkHOIvlDwcwBYiJKAZ6wqWXFJW7iLoSjX0+tHga+wxxp3bIYRYWXTscg8fz+p5zRvqnZ1P8QKuCwWOVBUuODn0zIS+Q9ki09uRTjf0gSHr9Iv4BTQXFsBRyJtT245QC509jOfGHNZSAD4+e3SG0WgVpN7XT9II0Ew1hEhgRvQsSMxHM6Qkk+0uCu9/BbP1WGCsC77IpRytPenat/DHYVXcNEqW/hVf3Jks/nLz7YiO2w5h/xoeRWD7qaADOjwtwk5T7Gw4QsOMUJCBTNOrAeaExWKEAOlR/XMTqt4DtcQJZHAF9VHiwbtRbIRkGwVXQPpfHFfoocgjCLW9tJKfc5rTdQ8QDikb3C5zbp7Hv9v/G0arghKelCbdgP6YEoQFx0x8TftLy71dRtQuGKcbIeHjCLDa283hcr9xbD1z0tUB2daTEf817XF8lkSlRj2/unf4T3ROx4lLLQlg2QH6Ffr36jmOPexb/zn4rvY0ZDY/uqbd+Tife6Kv7P/np1cYpoucbiK1HBQWAuNzSl5/MjH6aajNj+41W2e6IExPnBC0SlXlz+4NiMJLjqGSCIdC7RT3x8kYOrXlWijCC62f58lQtk9vWzO/kIB2vWfnrCmfKPmhQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(478600001)(38100700002)(66476007)(66556008)(66946007)(316002)(6666004)(41300700001)(31696002)(86362001)(36756003)(53546011)(6506007)(6512007)(26005)(4326008)(5660300002)(44832011)(83380400001)(2616005)(8936002)(2906002)(8676002)(31686004)(6486002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZWFETVM3NFV4YjkrOVRlcjFRNW1mQTBmTUltNDRYbnUwR01kMk5SVHM2Szdl?=
 =?utf-8?B?NnRqOFRuYnRMVmhPdCtYMFVxVUNqeVFYRDlFOU1nM0syd3RIRmRDZ0RSRmlV?=
 =?utf-8?B?VEoxNURzY0pLSGgxYUU2eCtYU0RBcjhRNS9YWjBGYjY5OVhnbE93QUpLQjh6?=
 =?utf-8?B?UllnWXFKSVdWQVB4Tk9OcURnZ0t6ZzY2djdHOGxOOTJ6cUhZT2tpZmFMc1FV?=
 =?utf-8?B?WFJUam1BdGdndTJsSTFocFo2SjNBRkVrbmVaNkxyTnQ5cWlYSDkyQk14Sm8v?=
 =?utf-8?B?Y08zd0FqMGcycThiWTU0cWZlNVJFNXF3STk2TEg2Y0hNUWg4YWcxa0s5M1hU?=
 =?utf-8?B?c1ZQUzBQTjl3Zlh4SVlONVNKaHA4RUN2eGZSSXB6V3p5QjF5TUpucWlEdzdv?=
 =?utf-8?B?czVpZEd5cmwrKzhTVnVIR21Vb0RhL21yVkM2QTdqVmVncG1TUksrbXhsTDk4?=
 =?utf-8?B?a2VoYVpjTU1lTWp5NUNxRU1ydWY3R0NmVFpmTldvRUI5T3JqOEIzMlJmNTBL?=
 =?utf-8?B?c0dyZ3ZkTzJvQTV2Y3BxcU5maWI3aGI3UFNQWTJZV0tiZnZja3Jka2ExYjRm?=
 =?utf-8?B?aGx1VkllSUxOa0tBTFFBdnlmVmRRbG9zRFlLVVBuQnFFVk94cE9yY3orYkJS?=
 =?utf-8?B?d2VMSDBHeU93c3puRjdqNjdPbkI1bWluMW1oQVoyR2RPRy9OZ0U2MStrR3po?=
 =?utf-8?B?bkl2ZUI1ZGRTMmNPQUppaVVwRGJyMVYwRDNEL0U3YkVRdjBibGZrM1VGVUxM?=
 =?utf-8?B?UWZIWjdGVi9rSTNFbk1LTFVBWi94cHlza3lGNEluWERTNUxJM2UyZG1aVmZM?=
 =?utf-8?B?WjU0ZWxFWG5vdmFwWHc3ZzdMQURRUkUwVk1NUTNqMEcvcFEzYTFjRUxrY3VU?=
 =?utf-8?B?TFk0djFxZmhkRnY4R09zOTVUMUtiMFcrd0xFQ2dUOUxEZGpmbGR6V1hheDRE?=
 =?utf-8?B?QjVyVk1TY2dUbllHaFE4Kyt4R3MzZ3FGOCswclM2eGl0M2hzc3lvQnR6bFNG?=
 =?utf-8?B?K0x0WDVSV1h0YkxvRm5lbU42Mm90RmFQRVJ2TnM0WEVjQnNBRGVKeVg4aHFU?=
 =?utf-8?B?cEl1eUJuRnVlV1RhZy91YVBKbjBaT3NEeXRaa2wxbndoTXVKOTNITjgwc045?=
 =?utf-8?B?WjdtVEtMdnU3WTVYQWlkQjNJc3BQVkpqUDg1MWlSdVg2aUphL1k4VStIR24w?=
 =?utf-8?B?Uk5IUGEyVWdROWZsbTI3OHNwRDZkb2tJbEJGbEVlOExRN0dnVHBwbXozUzJX?=
 =?utf-8?B?K0QwcjJ1SEhJNGFvTjBvcDMzcDJSMnpnSHJFMVp1UlI1aGZ2MlNuTU90TkxI?=
 =?utf-8?B?Q0pSRzdOc3cyUllISkxQQkFhcEJGVjdkZThSVDJkNTdiMlZXbGhkWk1STkJk?=
 =?utf-8?B?ZjNJNjhnR2M2UkhSRS9rK3d1M3BoeU9FeGVQdEFteUtRa05wSXo5WEpaT2ZI?=
 =?utf-8?B?RUpoYjh1aVd4ekVaemo5dWpvWG5XTDNyVVM0Z0tEUUJLZHJOZlgzU1VnV2JG?=
 =?utf-8?B?Q3F4ZlE5QTU1VGVkOFJyNjllMXZLMm9XVVFzY3VKdHdYaDdKZUd5MTdJcmVr?=
 =?utf-8?B?Q2ZLTnlocWJlcXZDNW5LT1QzV1F1TEs4aEVjTG83ZGJOTmhBUkl5eWl5ME5L?=
 =?utf-8?B?NUthRE5ROEpHSTMzZTJ4VE95N3B6M0hMakpFdXk0dGVLK0w4a0NGSkRBZDI1?=
 =?utf-8?B?RVJsN2lLWWFsUTdDaDMvYzZZcnBHSjVkMGQ2WDJQVEJjSmU3eWVyWEJ2U2JJ?=
 =?utf-8?B?Z1JCbk1FWFdya2dxc3dmRnJ5M1Z5dVBFL09JKzI2VmU3NkZaQkpmMm1IMmpI?=
 =?utf-8?B?dFpROTFpcFJXMlNyTTZUUVA3RTYyNGE4ekZWa2xrMkgxbjhDQnhmT21pdDlG?=
 =?utf-8?B?ZkJJY2dPUmNjMjFjZjliSzZ1UHNZWmZUaU1oa2tGTVgvejY1VVlyeEhYVnpo?=
 =?utf-8?B?aHNPbjZ4S01nZFpTU2twenVLVVhONU0yU3FWNUoyUXowZmFzUkxLR0ZzVUlu?=
 =?utf-8?B?RWR1aHltZWVSSDIzMkNET2JIOThEQS9JaXE1NjBXWXpCMkVKeWR6SDZBOERu?=
 =?utf-8?B?aHJJOEtkTmRMTXJlYUNEMWdud3ZYcmhTcmtWdVo2MUdmWUVxY3hjV1pLNUV5?=
 =?utf-8?B?UlZhU2ordmE3Y3gwMXpWSjNXR2x4TW9EN0pKeDlCOEhIRlBBNGQySHAweTNF?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fta3EZdHKLZp6u3rASmF2q5cLfMRcxNBNaClSneHZK1wMkAx8P0FAsQ6W7/UnPVcppVMrwrLuK3ANxaeaxSff9cZfMMH8FP6qTlwhQ7ywIoiM7CH6MQtfCf5adWU7gmPzmnwxdSWDOQG8jspC0O9oOhCxTFcEXMo8ejG1I6rG9ECl/Yfd4EDtPWOV/BngnLw73WWmCrdisUGueGejnJBB/APm0ZjTR6T9TkY2IP+UPYOarkPE+dFMUlJcmDYDTkK/mmsbTcIosGF6m48GAQZgF9J+smFVIg7NmXNk76v4MeWPCu9Fbt2lfzpxjU8g0IMdiagLcZ/H9g3+id8ozQ2n1xdYZtkozbOgsJutCsayziK3rj6TzQl4cbMD3wBWd9RnEL2BSUNqZg+VwzltvmwmV7vnpc7q/2G3nYvvEs0RTSAUa6+30uzT1OP8ChPj2kg7/1fjjCjj+hSk07ll2rVRzKy1IQyltkrmpXuiJlapADVUtWccDcpdpd5vypdkwgr/jZbKcHFZpaSIix/4C7N+mLld2CaN4pXn+Qd0wPQDCK22S7F9fRtVVglJQYMXTw0qnumpGZGazK9CSrxCyq9ypNkr75Twgz9Deb+mtW78ZU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38d266b-d31b-453b-9c8e-08dc01eef344
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 06:34:57.6151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPtu+BxIcF7P/k6AAdCW2OlaFur8vqmAlkFVy4OwcYO+Qx8YcFgnL11z/UZr1bwtYvkp2ePxeF/Jt+079U4CuaJtlEqXvUMonHd/jspuzo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_02,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312210047
X-Proofpoint-ORIG-GUID: qZTCWsXcskC2aJ-tFYmAsyNDeyf--d4P
X-Proofpoint-GUID: qZTCWsXcskC2aJ-tFYmAsyNDeyf--d4P


On 09/12/2023 01:15, Jonathan Corbet wrote:
> The process book is arguably the most important documentation we have; the
> top three trafficked pages on docs.kernel.org are found here.  Make a
> beginning effort to impose a more useful organization on this page to ease
> developers into the community.
> ---
> This is a version of the reworked page I showed briefly during the
> kernel-summit documentation session.  Perhaps more useful than the patch
> itself is the rendered version of the page, which can be seen at:
> 
>    https://static.lwn.net/kerneldoc/process/index.html
> 
> There is a lot to do to turn this book into a coherent set of
> documentation, but this seems like a plausible step in that direction.

I think the reworked page is clearly an improvement.

The following is not really a comment on your patch specifically, but on
the page in general:

"""
Tools and technical guides for kernel developers

This is a collection of material that kernel developers should be
familiar with.

     Minimal requirements to compile the Kernel
     Programming Language
     Linux kernel coding style
     Kernel Maintainer PGP guide
     Email clients info for Linux
     Applying Patches To The Linux Kernel
     Backporting and conflict resolution
     Adding a New System Call
     Why the "volatile" type class should not be used
     (How to avoid) Botching up ioctls
"""

I think the last three links probably belong somewhere else -- for me,
those are not process-related but actual kernel-code-technical
information. The same goes for "Unaligned Memory Accesses" at the bottom
of the page.

How about putting these somewhere under kernel-hacking/ (AKA "Kernel
Hacking Guides")?


Vegard

