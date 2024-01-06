Return-Path: <linux-kernel+bounces-18513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9447825E74
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62BA61F260F6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CC66129;
	Sat,  6 Jan 2024 05:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ksoJV8Zy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w49HMuSX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206482EAF9;
	Sat,  6 Jan 2024 05:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4065esQ3017925;
	Sat, 6 Jan 2024 05:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=7rrDTDN/Vku98E8tQqVUiSYDk0gqpxiSmvVvgRa+ulU=;
 b=ksoJV8Zy3kJrxKRcySC4wU+PXckXyMdhIh3C0/QMwfwgNVPqxA3VOlRdrFdCVxBId/fa
 2Hiv3Pd5wn84sqxOF+RaiitvcRVxYtYHj4ZCna7x+/gYPvp5yTgqyzwsvpXXGpImyby5
 N6w3FBBKMg5iPM1xtIuUARxs3PSIeVq2/RtMPRiLOYYirNeb4GeV26s2ypAh7rI6quko
 MY0wJy5dL7OjwgVdW78sbd0heYXrXgOeaTaJfeSGGi2BLl3BBbFD4lIHH5xOa12J/aNa
 LgcA8Rr8NnF/WRY1jhtmZetJ/Oi538zyvpnYDQ32YPZodIrVU/NeUkNUPzinPpWGueku pQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vf0wq80e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jan 2024 05:57:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4064clTq020864;
	Sat, 6 Jan 2024 05:57:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vewa36efx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jan 2024 05:57:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eG7k2Tver2ZyTgxgdgmopCrD2dusXFMdW9sZS6RrnCFUlLNTAj6em+CmOTfeixBMY9a55GXoI6fiTxdHIM2jqFoWb2BNo0/uTAdcsZ3FNChfyZ6VTyLmkCrY1M+Qzmxjy4aCYWc3QYzEtWORKEMepfTOfOQCpGWX8NRWnpfSkEcVmMz8yqwqGp6JDuZ4v11EK4RBrOh61XvhaQtrhoAPi+UKt4kewGPcUOtVv5rI0wNM8W/qhQq4kDHobVFUTbGB6S9kPOkZnLvVPQcp7h5iz1Lh3fnB+hhaheq6tvGvHRLEj/oFe+eBtg4jfBcye1Ajyj8wSfoDWfcxqxnlzp0g2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rrDTDN/Vku98E8tQqVUiSYDk0gqpxiSmvVvgRa+ulU=;
 b=N98QMJcTtWxdCesJIoYuHciOSl+a+mvcvB76tcX7BOhsPCp7xANpm8r+cWX2paoKP/xArGs7QJRfVr9DlJJWZzxiqqg/u3mfY7Zkj3nR4xQSkIdreaAD6az2qjn43CeR4/Iud/IBGR4sYFcQGUE3am3G/CZBdyVQzKk/d58GF6t+aZ2yDtYiCHV47EBBb0I2YlrlKdn+Kn9roTcRZJ/QVtHfXwDN7kHMvCj17FxgXKZi9TfunCxo4wWZfHx6GdL7cn30HCNLmo9jF+6ebC4g9GmsAMGQiVOk2yEoRud3sB+7/rihS2x4z+DK/RKY1bio4IIPRwAOGeCdeObE9RhTBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rrDTDN/Vku98E8tQqVUiSYDk0gqpxiSmvVvgRa+ulU=;
 b=w49HMuSX4VOP7AhPN2pN0e21PELeSp7dKeGiJTowCaDg26W+wVrhZfexceJLDUM+en9/wDneOxMVggZfisSyoNbtRDsEOKmJisAu8BiEkGfD1YD3vulzddsOwpmXQdVC4woY9YPC0nzf9oJdasrKgcCX6Naru83df0Wsn6D3/pc=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by LV3PR10MB7938.namprd10.prod.outlook.com (2603:10b6:408:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Sat, 6 Jan
 2024 05:57:06 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7159.015; Sat, 6 Jan 2024
 05:57:05 +0000
Message-ID: <3d63428e-366f-462a-b911-2237f9e8914a@oracle.com>
Date: Sat, 6 Jan 2024 11:26:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.14 00/21] 4.14.335-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240105143811.536282337@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240105143811.536282337@linuxfoundation.org>
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
X-MS-Office365-Filtering-Correlation-Id: ff949f83-d72d-4006-6d44-08dc0e7c4fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cOUbpkA4PsOsbmZaDx9O9slk83ZojRrilYPrHUzcc/5EcuzWe/PQ3mzBnzbbKR1uTcMmy7kAmfxt3D5XwLFpegDW6YIWd5O/RvC2VKLGwjm1xFzI6N64glYtkpyB+gvasWzdePhpB7+ycNIITwH9b+IvPKA9NPOXoloeC4TkYJQTH0zCQ1DX+kMSk5uNqg9gB3YEXpqWDvwT6aq7elDiOXy+RNUdcaKvUG0ywT6I5sXNrr92d9UMPNPXvF482CLRRBHLeE561v0exK818FCM2FfZqEdLF0Kxb6wfcgedjmK3CYkiwXVD8fPrQ21LNUWHYlqeyvIDWcDSZz2ve6GCWLOfAzZBaB1XBoQ8vzhbrmm9U6fgSpkhB+Xzo7lmtAAU7Vl07AYt4ELFoVioZ6Gn23urr6+Pqr9HtLPMtiQmCjszljwllclreHJ5/BHMozVvHAXSUzp1f2rY9fV3MgLRCCVByR3wE6oPBe8xL52pW1AOBg4yWy7mqLgvpVRdn/gkCyniL5tBPP2L/m/vsQyZ/7y6Kz8Irn5d2+wasS5Gvnc2ND+2Z23IFv9H+CFz2JNRbOE5sRY+9n3NkfThah5iq7qgskLMKXM1D4c50Qxrv9RKHt9yXMWfAj9rX/NtSy6z5ijeA8w2jgN732YlYCbR5g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(83380400001)(36756003)(41300700001)(31696002)(66946007)(86362001)(5660300002)(316002)(38100700002)(26005)(2616005)(107886003)(53546011)(6666004)(66476007)(6486002)(966005)(66556008)(54906003)(478600001)(6506007)(8936002)(2906002)(8676002)(4326008)(7416002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SkxmQzFuVUMrV0lCejRJVTc5NmdPa0tvdmN1dklEbDZMZWE3VDNuMkovQUxP?=
 =?utf-8?B?Q25hcmx1b3N2N20yME1meGRsbG9rT3ZaaGFhc2UvQytDMTJhRGQ3SWZqM2pD?=
 =?utf-8?B?RWdPRzM2SXJudFd2QlhrUHVYVzhieXk0T1ZxM3QxVEFpUDFkSXBPVTlOckgz?=
 =?utf-8?B?bitBbVhHK1Y5ZTk4SWJqa1RMMDNSTUNZMzFXSTUrSTRjOEd4U2doYTdYejNv?=
 =?utf-8?B?amNRMXVCVzBxUC9lRSs5TnNJM1EwNTJYSXV5aFVpOFBtV1c4OHVvdHQvSWVL?=
 =?utf-8?B?bFYvV21oMHhTZmoxSi9hUWR3emdTbWdCcFAwamNKQ2VzZmt5aFZSa3Fra1F5?=
 =?utf-8?B?NEloSWI5WkIwYkxCUllYSnR2QjZoY1huWk0zTXQrajU1OGZ1Y04yVWdyMmd5?=
 =?utf-8?B?Y2dGODRkV08xUWlibzZIelArV1NEOW9lbHFVNGhDYXFldFo2MnpVdCswcFEr?=
 =?utf-8?B?NTBFeE1pRmRHeVExQUZrcXRZNmZqUXg2K2drVSs3MmVLMWRMMGg2WXA1VDhJ?=
 =?utf-8?B?VHRmQWZBOHNxWG8yRW56Nzg0alpQTXQ3YWZvTERCRGpFU2NKc0labjEyTkUy?=
 =?utf-8?B?RS9FdjRTSk1YSHpkZFQ5U3ZRYXRyQTdRYkx0ZDRIVjF6bnliUHNlQXR0VHRD?=
 =?utf-8?B?ZTUzRG1EK0VxSmtNKzhrQUZJZTU5VDhWUW5MWWlaS3EzbnBDODMxSjI2aTVh?=
 =?utf-8?B?aCtqU2ROL2R2dXJJTGU3NjBVQitXekNzLzBjaS9GZHZ6cjNVVVlDalF6WHBG?=
 =?utf-8?B?UmJqK3NLYWxDWkdMWDBkQUwyTmtFd09aS3RxRXBRN3VJai94YWdtdHp2TUo0?=
 =?utf-8?B?Q0k4WGZYcS9rMUdUcTh4ZXUvRkwxcVdQM2E2MXhFWTQ1MTg1c2ZTYTNyY2lm?=
 =?utf-8?B?RFhwZDBxVm5ldzJhTUYraytjYmlsZkV4T1pGdzdjZnlXL1ZvVW44S0x0N0JY?=
 =?utf-8?B?S1dCUmlxaHlBZUhPYTljSEdNcDVIcFFucFIxVmFUTnljd2k3TUVGVm9nUmlp?=
 =?utf-8?B?UmR0Vi9ycFlRQ2t5WUYramYxYmFsZFAyZ3pTTXdxVDRKUyt2MzZFUE1Ienpt?=
 =?utf-8?B?Z1NpQWVZUWs2b0YrUmJmbENyWE9NRS84WUwyMU13bXVqc2g0MDNQenZGT3FY?=
 =?utf-8?B?NlA5RUl1MzllVnBsOS9za2wxSHJSSThOSVQ2clNIWG5ka0pYaDRPR2dJNzhK?=
 =?utf-8?B?ejJoTkF5L2VmcWZVeXVlK2djUUNYdGdzb3VYaFFaU2lEWkNtNXV1c1dTMDdx?=
 =?utf-8?B?cVQ3ZCtlRS9lMEN6dExORlMxcmcwR2ZxbzZSeFVNRHJMc3UvMFFxSnNyeVZj?=
 =?utf-8?B?aFBYbElMeEpQV2RPelpVUTl3T2VYUm95TlYrZTc1c0U0bmdCVkdkZTBVZzBG?=
 =?utf-8?B?azVzZ0RLSXc3SUpva3doMW8zbWZlWWdBNXJBV3BxOUk1R21tSG9OaSttWjFF?=
 =?utf-8?B?b0NNNU00WlBRcVJtcm9GNWk1Q3h6ZG1ZSWVKSHZuWVR6NmV0NDQvWGhSaDN1?=
 =?utf-8?B?dUt6OWFOay9aaTZIeVNTY0hESG9kOXdLdnh5STVFbGVhWCtySjE1UFNyRGt0?=
 =?utf-8?B?UHlrMzZQN3BWUzlCWjh3YlpkY215RmpsRXNEQjVaYk9uUGxSKzRYOWR5dkZV?=
 =?utf-8?B?ZHpEYi9YbWg5Um9iM3JacC9BSklqanNBdEc0S3JWTWtLcStsUEl6MFpRaHhK?=
 =?utf-8?B?RzI4YURLSFBHekJQZmRMYU1SdzJtdlJUYWpGUFJCRnVqYlVQbEhudTEzbXJ1?=
 =?utf-8?B?UkhUS1R0eENXTHJsbzExLy92Skc3NDlzdGwzT0ZlOTY1RWtXV3hWUC90Lzh2?=
 =?utf-8?B?K3lsZkNxWEF3WlIyRDlKVlJ2K2ZoTWY3U0NEV0Y5eHFlVmRBODVyY2J1b2pK?=
 =?utf-8?B?Tk9ZY0FYVlBOMzVTWEVXeGVaU2NaVUZjV1B2NVBNTkl3VmtiQXhRSmlYdE1W?=
 =?utf-8?B?eVAwZzQ5YzZEbTBOallCMVcydDQvNWRyeDVPTlZnWUVNdzEzTzRCZWE2VzZ2?=
 =?utf-8?B?ZklMMEF2SURLMkdPemdHSWhCbTY4a2V0bEV0cWpLcWtsU05UNjh4WmlrSzdt?=
 =?utf-8?B?WnJPczhPWXNPYUpWRkFvZmpDRG9IS1ZDb3NCaGkvMlg3Sk9jbElaT0F4MFlC?=
 =?utf-8?B?dml1eXlSYTI4UHdZNmdYN0NvQ1lNNlh5eGFaMG5CaStnSi9uN0xXOXpTM1Fl?=
 =?utf-8?Q?kRDlv3YNQkKD+jEwYKXN5Y8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YDXdXKU63fqa5LDrTaoXVUQRDHm6pbs95od9EiXQhWxQRwzkDWtaVYeDOc7tVwnWdPGdx2jCLQoD6DiMvAK0Zah6nolSDEtWn9AXIi4GoCNmH+H1Fv9IAGd1Tpx/XyuTu7MRdftPcD7S1fZ0DaVXebHhulG0hBm+9NaxSf0Nekw+vh083TYIx+5SkGd95/mbukN/Jk07924GMNnRddvIvEhrRTZHWvXnrO29v/xweORJq9MRK5/TnwU8fp1OTF/cKi9Zgr5GeN37Xd9HXGSWTh5OGvWwNWVZS+gjIuraaFiJ0uk98K3opaiCHq2rNNgs/Rk0B341P0NeEeSPVCyrGfEkrS0+sDnH6ojkWNZGwweYBT+/eTth0EEwcIASiTz39yVTrm9XmMXm55ATCsdzlj3UaZZVI6lxJAyWXKJWhBG8tAc4guPYIa38P/OGE2YeAes03lr2cxZHA8TM+DK+kzmyXyIForz44K//FnP95Y3WcOwlf9w+JoBE13q6DEEx/WCcjnjhvge5x6P1RMvLLwbTq4+bu6Z7IQPQmMRa/6Pgzz6zZTbVDoifzHvGsrJGSmz++u/vJxoWKLLOYhxY/V8Oa6VC6tNp7UnZ+5DPois=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff949f83-d72d-4006-6d44-08dc0e7c4fcd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 05:57:05.8574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvBtM+Go9m4mTRatZkoAIlnRKP2B3n19aBwZe1NSMaf/Ds8R6LRDB1eK4mVk+rjfmuJdTrPqVQ/o1wIRzAi0eSfEh498NxD7OB5iHxBM+2NfukcFF1cn8jX1HrXNQHp2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7938
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401060039
X-Proofpoint-GUID: 1UvG-vTBwtxpPASzBcpOewr1Iqz0zdl_
X-Proofpoint-ORIG-GUID: 1UvG-vTBwtxpPASzBcpOewr1Iqz0zdl_

Hi Greg,

On 05/01/24 8:08 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.335 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 07 Jan 2024 14:38:02 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.335-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
>  fix a memleak in atl1e_setup_ring_resources
> 
> Eric Dumazet <edumazet@google.com>
>      net: sched: ife: fix potential use-after-free
> 
> Johannes Berg <johannes.berg@intel.com>
>      wifi: mac80211: mesh_plink: fix matches_local logic
> 
> Heiko Carstens <hca@linux.ibm.com>
>      s390/vx: fix save/restore of fpu kernel context
> 
> Kunwu Chan <chentao@kylinos.cn>
>      ARM: OMAP2+: Fix null pointer dereference and memory leak in omap_soc_device_init
> 


