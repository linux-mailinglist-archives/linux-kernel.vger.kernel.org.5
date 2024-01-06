Return-Path: <linux-kernel+bounces-18512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06798825E72
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA551F25E6A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0772B4428;
	Sat,  6 Jan 2024 05:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A9LCAeun";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R/9B1gMW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBCF2BAE1;
	Sat,  6 Jan 2024 05:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4065RpWv028039;
	Sat, 6 Jan 2024 05:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Q9BbNypW///Vg+y6lz2pXcd7d/gHScB4DwaN3eWKkYM=;
 b=A9LCAeunCLVHoVb0TidM5/75X11DDTV5kWpc7KMD9vvmzOp7yYaxR8KrrXhAiIZOGLcH
 nyGYL0uQsmMh9Z9I3JEmLWjfoxJ37xuEVL76kr2mXCSQB3kFb2VG2sGpkyE5Wd1s9SHY
 xm3zZjFgbrfnFRgFsytteGehi2jVY/v+F9PA5vNuiBdyfHa85VEwMz2M1dge1pQWz8JN
 MywDuINslaxBeTQ4WknLlDUtj+3LDL8Pjp35VE1T3pOo5jt1VOBo0kNw7XMHeH+KK0lj
 puwuD03x25SrQsA7vp762pEPmqDUz/VwZsbG9/wkuDZWFcaQhccNlgnHQfVunxHnid0a bQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vf0d1g1vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jan 2024 05:55:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4064cn3T002678;
	Sat, 6 Jan 2024 05:55:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vewa36xuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jan 2024 05:55:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2NaeIH4xYMWok7LLdPiryuuIb5l0xmeOskQIvsXw2GtqA2Bgn5ZcFv0+5MWcW9pf5iM6hQZoZy3P7a/g8GgLosfjrgGRORXyFD6a8j0VTP+abMh1mNP3+CTCB+u4jB6XK06OO1fkczTEEmNXSZyMenkaHbp5U6FlefK8yUIMN21uxYwncTfg5a3riDJPkjYl+a3K0jg9nL6zxBH1q+F/DCZaEb+ROnSX8LYpgxVwhyXoHvASOXCS0iu046sPerDYp7oFL9hYFKS8rrotUolmTCgfZdmRvgduYdIzpwvFCFshLPDgZDIDnChEm3Wt+2Elop9twKu+UyqD/DfQMw/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9BbNypW///Vg+y6lz2pXcd7d/gHScB4DwaN3eWKkYM=;
 b=no9845fk841u98b9Qqk8af7qIvXRWiLmhEAtissvJegZDrhUa70lXkEF0KFkY5gVWaqX9kChhcLxN0iWJxqIjY/chd7zCx5ITFgN7BW4PL4oe/GvpjpAl0lKyhWsdcVJnX9Is2uRDreey1FucikiEnp2yZnkQMXVjtvRrFFwZA6HOBAbsur+sh/SGRo12Z3X5KhqBWQ8oY8WfGrUqtLbeJO23BzuJukH28EjC7RfV33tLf+NvAzNiQ38fbW1ZPGgzZQTu6bPJB49MdIOli4QvnInATFeOVmWMe+q165XqrTR3FrJ3SnEtEUT8+Uiw4NUjyChmGSFtiKptYDUEglWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9BbNypW///Vg+y6lz2pXcd7d/gHScB4DwaN3eWKkYM=;
 b=R/9B1gMW8YlzNWun8Z5xDIZvlbAyrVASmHoU339B04X7N53HdM5yzDnVZvJTZVT4my6/NTDo8Xa5ChU9rCQ9WKeiqqfOCsABAcP7j71hZrCh+KrzktJJDHYItBNgv43eGEHnU0MQtSMGifA9VQUJEDI0WFA0LeSE2XRWJ7k9kyk=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by LV3PR10MB7938.namprd10.prod.outlook.com (2603:10b6:408:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Sat, 6 Jan
 2024 05:55:51 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7159.015; Sat, 6 Jan 2024
 05:55:50 +0000
Message-ID: <0da2fe6a-88c8-473a-a4d9-fd244f4cdb6d@oracle.com>
Date: Sat, 6 Jan 2024 11:25:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/41] 4.19.304-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240105143813.957669139@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240105143813.957669139@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::12) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|LV3PR10MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b1e41c-7f4a-44fd-aaec-08dc0e7c22e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	te+UZW8bRQ216AXG4w4MNq56TFPVlBxkNS4oCgfn1PA6Td44CnxqS/jSUatSuorijhnoNF1ox1DQLr6EvKJofm2/KyYqcrgMenUUvqtVnIz/XefYxuok+Q7Ixj6QSSD5V4DtvIebiqY8U3CM9HzA0fWYdj9pG9gerZnhh9AN+/adXhVBdbt5uMuqPehRvBOGHsLkMHyUBs8gNfgOlmCmzYhf4gRtEAaq2NSedsXiXmyCa7TsBdWM4IAFps/+lqKSQI1JRqWuy5sDAAvTwT0ZE482oMZy0kGqVbiGVdJXEIWnp7etl5t3nh7sokWMg8FY5XTdHP1UfFJIapasryvi5hWejmiIXXeuzrHc5vRlWI9JG1ZGxnP2KqNlLyOd/Fp97TqI72fWzXmNZaTh806FDKZL0TY/0XO6sxpC/bahx0cbPwAaPTpYYXofQfI/F7v+u8uqXd14Jx29lFU253XeOShDRFfMJB6vHJBJUOjxuOxS5gqkYI2cxy5myzhmD5uLSKsHKOSeFQY1nyxOn1HPhUH1lI1J0RXlrjXz0kvRs4Hy0T7/MxeifAS58dsRXy63FOrwDxn067PVfNWaLWw/i1Arj+qs956GNG1ocyMQzzXvZ5WyLD/ts4kVBWP76ywERJw22UH/Uqie/2rJW6l9GA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(36756003)(41300700001)(31696002)(66946007)(86362001)(5660300002)(316002)(38100700002)(26005)(2616005)(107886003)(53546011)(6666004)(66476007)(6486002)(966005)(66556008)(54906003)(478600001)(6506007)(8936002)(2906002)(8676002)(4326008)(4744005)(7416002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dEJSdHpsc1JxTks4d093QUJiMkF6RzA0ZFZtNktjelk1WGxNUVFsTFN1dWsx?=
 =?utf-8?B?N3RJM2ZxK24yWXYxaHlDTk5kRzZpU2JZM21PcVBvc3lEYjhna1hqb0FaWVFM?=
 =?utf-8?B?OFJBOFY0ZjJJczFpS2s1RTZzdktjNktqaTFXb05UcGlIczhjZjNTbXR3STdM?=
 =?utf-8?B?U0FzZzNCWVM5MnYrK1hFT3FiQjZzTUxBTXJCV0YvOHBaSXNJOW9ycVZ0Z0Vh?=
 =?utf-8?B?NENXamhmWks2SHZKS3ovN2NPRjBwL2RKQkwyWjBRbWxxSDIrbEEvaXo4RTQy?=
 =?utf-8?B?d2pSMVVpZlJyNEI2M2locTVPZ0dzWHUyQkRHb3gwa3gxL2laTHBmRGQ5aGh6?=
 =?utf-8?B?aVJ6VDNKak9RSk1mYW8xSkJCQXZMbFRaVzBMZG5HdTk1NXJmYS9LWmQrM1F0?=
 =?utf-8?B?U1c2Vm9oSEdJdXgvMS81MlBRemhhT1ppMG00OUdvRkUyNkhQTFdMcVFueTRr?=
 =?utf-8?B?SldxNXlCdWpac1hzcmg2T25hNWhUeWEybmcxY1o2dU8rSmtMMGpDRnFIK0Fm?=
 =?utf-8?B?cVFXWVBjU3Z0dUpoYjRWYktBSlNYZHlVaUFRZjlvdEF5NmxKaFI0YXZZTWlM?=
 =?utf-8?B?TVJISEhDY1liK2FoRzk3NGpzSDRmYjVObEhnNWFrc1NhQTlmME1SMVhHZUFz?=
 =?utf-8?B?Rk1RQTNLMk90ZFY0bXlBVkw5QkJSSXR0WndaMUN0U1lueElZZEo0My94ajlE?=
 =?utf-8?B?NUpNZUgybU9uOThmT1hnVXF3TTQ3Um9MQk0yalVEUFZHMlM5L2Zxa0JZUDFa?=
 =?utf-8?B?cHFpYzVITklmSndKSlh5YnhUNCtmV2lvMDhERW5MMzVlQjFPTUpVd1NaZkxs?=
 =?utf-8?B?Q1E5Z2oyOStiZDBWRnFTa05POFBxMzhQczJmYXljRXQ3SFUrTDA5V1VGRGdC?=
 =?utf-8?B?YnJ2akZPbHUwMFExbFhoMWpqRkkva2M4cjdRK2ErUmo2Z1prMmd4VzlXWU52?=
 =?utf-8?B?YUJPUVRYK1BveTBPb2E4S1F5RmpoTTVoV2l0NzU0UFdkeGgvanAwdFdlV0Nw?=
 =?utf-8?B?Y1UvbHp3WVNkWWpLVEFack93T0dMVTl1TlZvVEJiUC95bXJTQ3piaWVTUlBw?=
 =?utf-8?B?VWN3dzBWRW5FRTRveVJyUGcrdTNGT2NPMXo3bm5wYndyQU1sZFZIeFJvWU1v?=
 =?utf-8?B?cUFmd2R4WWJlUjM2SmJMYzdpcXBVcDlWZXJESCs0d2VNNk5UWU1YSkRqSHVy?=
 =?utf-8?B?OW1pQlFLWlR5NEMxYTRJM1RLRWhkajVQaHcrdE9Ja3loVW05VnFaRzVmN2h5?=
 =?utf-8?B?cmh6Z2d1ZFkyS0p0aFI3WWhsZzJ1RkJES1NyaGVManZaelNRU01ubDhyV0ZX?=
 =?utf-8?B?OEx4a3JUMThjRmg4Zk5xdVlReGdUZDRVZW5aZEJaWlNIV05BNDczeWhGVVZs?=
 =?utf-8?B?WUJuTnJSWCtKS29CMGRIZXVkRGFXdkR1dEUxQS8xb2xCQ2lxWWpTR2ZmdDZN?=
 =?utf-8?B?Sm83MEhnSG1SVUIxQ0ExS210aERBTU1YV2c2bHVQbFl0ZzFYWTVmWkFFRTRF?=
 =?utf-8?B?TTdrTVRrdWRRRFdoUlc5WWpjRGtwS1MzWE1VZEc3cW5TNVVXMTNMYm1DQXZv?=
 =?utf-8?B?Mjg3QmFSZDNLaHlhSXY5N05XOXlITmhIZndJc0gwb1JTZHVJL09QY0NEWWNT?=
 =?utf-8?B?RGprdG9FRHY4UEszZjRLRlZhaGhMUWg1NmJ1cC9Cd1VLTTJXbC9QK3RYUEUz?=
 =?utf-8?B?S2gzZWZuUGVDUFFxeEJLUnY3RlJpZTV1dW9iK0ZYeThJdmgyM2FyUU50TURt?=
 =?utf-8?B?VzcrWWJkT2FSVlpzN3kreU5oMXBtTzdSVUxFdFd1SjFzMklTOEY4SHNLR0xK?=
 =?utf-8?B?RUNob2lkTHZTOGdtWFc3Q0pYenRocmxRNFFNL0NkcHdtRHdvbFJpMUZ4R0xB?=
 =?utf-8?B?RVRjS0UrK003TitTTnlsbWdHcU1IWFlwdWhORm5wR0RHa1hvSDZoMjlXdmpG?=
 =?utf-8?B?TElKV2IrZDM2d21ORkpkT0IrWEpGWW5GQ1I0SXdqcHZKNFVqK1FCOFN0OEVh?=
 =?utf-8?B?WmFwYmFNeE9ZYXB2T0tiUHB0eDhYUHpSOXFMQnVnSC9MbzBsdE93UFBZTmxJ?=
 =?utf-8?B?MlRKS2J3NU92MUFtQzN1WmtETElTSmZoY1hGVUtPZEZmK0hBcnRDc0ZlcWpP?=
 =?utf-8?B?Sm9JTHJVVFhteTVMRC91SFB6NE96UlRuQitlZlczN1liRWlRV200NnpqNmhz?=
 =?utf-8?Q?tdaA92iVmGKQ7dX9Q+v2jSc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rKkGx1vPFEWLJSH8fs3LwA3KVBXB5zDejaLtCBSmDvwxfSiaAjBaNcCGHyUv/ER98ZzyGHJ/jnY+6UqfcwxcimaK5ZdP8A2Vo+dMv9a0vCw1BvirGfD1QEwKIzOBfDCNVfRNXnZ6FCH+oON01lewzyxMFr3g8tIqLz5bi/95JKzRIbbUcypkXrhleVBdQZ5v7dSBATAVDZS/47iLAcW9o7aYtlwo9DPOoHWMgPHFELJIDjqDAD9KICk3XUHDYMe2Ivk4pbxh7AO16emrQlHizjHO8t1ezpNG+JH8pYSlyT4FKEg/2FgB3KsfK1Mdsb/g9yMBTMguqMaLTv7c4PrBotoeKSk43TQtf6kLwpQbz4zuBXSRp6e7of9Pe126MtecVO9SGDI1OQEeKKoR8iVk3DvQPdUdES4N1iFnpQvFTZOs+kuf0HRdCc9Ktx6CFCLiaTmVjYh5odFapls/owQhFSzqp2409hWlymUPhbS6qvGThY9AnOyLrY9eeoJ7DusaGRSisKXauIkxoA8+JMdnt57gCXHT37TOD0VFHu2q6PpSrjVbfXcZiltz8SbTuZN6d9ZZmlad0jJztSE/GMzS7CCAJxdtIyOE7A7QjXxhMeY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b1e41c-7f4a-44fd-aaec-08dc0e7c22e4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 05:55:50.7496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slC+8hoUVEqtuqWzgMEBkynlJSJTfkABGW8PbBKV9TuGqyfGxzJFbzEzvN1/GRCxhzOHoViZQMi5H2QCo3jUQ/a4/eC442qNd1OkbZ66r++J82CRhqELMoPuC+XzWUH7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7938
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401060039
X-Proofpoint-ORIG-GUID: UVK1V7yHGVCuTaLyDuTPRDzRi9GV7CE6
X-Proofpoint-GUID: UVK1V7yHGVCuTaLyDuTPRDzRi9GV7CE6

Hi Greg,

On 05/01/24 8:08 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.304 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 07 Jan 2024 14:38:02 +0000.
> Anything received after that time might be too late.
> 

Built and boot tested on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.304-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> ----

