Return-Path: <linux-kernel+bounces-16238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A353C823B57
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B051C244C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 04:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4EF1A594;
	Thu,  4 Jan 2024 04:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e05l2zMK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yAJzxbIn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83B218647;
	Thu,  4 Jan 2024 04:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40433swx006689;
	Thu, 4 Jan 2024 04:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=d/OK8VqOu1YkT8sbIhMG5vVn8ymLtGr0S1MFz04r840=;
 b=e05l2zMKiF0L3h3LBBE1FbHCO/0NBC/KEHQIpmkvF+e36fJZeZjTevBQI0jPGLb4Gwlk
 eFeQ0sqisLSj1d1y8VfSlzgRiujeyrAE3E/+jDh+hvB8pfDcLqnw2SiVhvdeOMFogoLY
 MJZzEe3sOllokxmZf2D7VmSWrFha1k92rnUyYmChOsHqU001ZkuqQ1zXlOauiaESFx38
 PlssmoeChrK1OoXRD4xoq8zKM5QJEQs9LRFUvcmdbOTfEeVV4s6jBqYPJK1BdcRgybiu
 rVDMs0aohyPmfB6rqrD0VeQ3/+3jRkrYvPmBgJgzrJDt2M/H2BAtdGvZkgYGXT+zOTMo Zw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3va9t26cny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 04:05:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40440ljY027044;
	Thu, 4 Jan 2024 04:05:46 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vdn9a8bm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 04:05:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fx2cvNAfuZlK4Dt8u0QZ346uukVP6OS+C1ks25HeBrb51Y7RWY8+uqQFa4hTDNPgadusIkaaHcU8chYZf/sMIFFsIUZhj9X+AxZZ2sbOwxxJ64eJzx/yqkx2wbqXc2x7MvzyK172GQCDM2Yxu/e6FuQ9dwQUOVm6+HYyLaUkY+oyPY9mmNy8qFNQJHNQuB+luCCOlXCrQ0qGGUrCYI3g/WqDTR+O/cR4AYVGbAASodQFkf6FFGPLzT0p8zNbfzQ5LaEeIe6wVCYqVkkHpzVU6kqtbU5G8qA5iib4dye0WNRQkYH3eIlgTk1Lb1lyZDqWaE4bqj+I6hK90uKCiiB3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/OK8VqOu1YkT8sbIhMG5vVn8ymLtGr0S1MFz04r840=;
 b=JkzjNOUgoHjZO++trRDJTmotK7ngz7/tc61m5KeH2kZGelZxGgkGAcbDkWamCSXtlpvzqC6Q/jU2ChA9USrhRdjQG2SFw0yJUu5GkPUyEmrn1hYy8RtX6rMR3ylDRL3g6rqEt2GlWUdlij4xky3vy7lHQ64JmRaa4Eu60KDUqv2tiYFVKpgg6MzPBkJ4BJbvFGAzByk+9qQDqYCXKHTgZMTKxYFuYCCMSte8M+/GGe3zJbV2ASLg3c3IJIqFj5Hg3XzBv3AzIYjYyvJfBmMjkezq4SNLf2HJbqAbTsBLon4SSHyzSoYQUvvGLzVZIRNpFsBuOhDJsyzvHsY8+aLnMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/OK8VqOu1YkT8sbIhMG5vVn8ymLtGr0S1MFz04r840=;
 b=yAJzxbInV786otoGjckhXmwfx6Am2znPco/XczrZnKqB05FDm6amH800bS4e6JXl1tRRI8MjMe0DT85MMI0TS2zCW+V93GReC5fOnMQ2+o6KyPYmzKi+OhS7y2ild4DJ7Qsw+TqFUyhbiGiswnkuk5K0HJXKKctuEcg8Nb9WzhY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB7098.namprd10.prod.outlook.com (2603:10b6:510:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 04:05:41 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%4]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 04:05:41 +0000
To: Chanwoo Lee <cw9316.lee@samsung.com>
Cc: mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com
Subject: Re: [PATCH] scsi: ufs: qcom: Remove unnecessary goto statement from
 ufs_qcom_config_esi function
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1edexagl0.fsf@ca-mkp.ca.oracle.com>
References: <CGME20231219082757epcas1p33bda4e0723d3d57552132054d3e5a3fe@epcas1p3.samsung.com>
	<20231219082740.27644-1-cw9316.lee@samsung.com>
Date: Wed, 03 Jan 2024 23:05:39 -0500
In-Reply-To: <20231219082740.27644-1-cw9316.lee@samsung.com> (Chanwoo Lee's
	message of "Tue, 19 Dec 2023 17:27:40 +0900")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0042.namprd08.prod.outlook.com
 (2603:10b6:a03:117::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH0PR10MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa8cb15-9fca-48cb-8d10-08dc0cda6ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UMgwNq9adPOAbUo48I9L21f4D4RZ4U/nY4i9/WaZlZrVcvwrngbhngwF5luiRpt8QPlz0l3B97bTezEVkYLQdwMsckZhntQqoFRaGC4IAi+oPMLE7P6S1B912WfoqB5cvgWcaZbnz88JuikuY5Z9iGVMuLWkubPvVZTGeNQ1OShBUc5hEqtsWYKonai1yLYtCXKj+YqJd8+7EX9pCjZGp2qEJ+F7pgVRKoxVi7sZy0Ya2+SdyWaq9FN10lli8wviU6oFdkiDkyzg44w7rH3l3q1db6MlvaaB5GqbEHC7ENWEOx72djEJz2En5pvvYq5ZxNgRjOM5PkldUZXjJatDmeJ/uzFKDtN/NwrIQXajzWHAjl+c4gLEk7mFDEVFOKwddzYDlDvDcdSCxOTqEXy/Mp1szGXCzFk42YF9oHDu/mroBR8KWpoFlWBHKHXGfDo2O95wXm36QuCUI6CcJxqkijLaWd1/RrSYxR/Luv6DoYvyHM+jlKQC2BISIGDmlBTfpVOV6bJYgsTkVUzqWxl8r7rqT7BVFAgD4jR1AU+knKaC59tjlRbvPjDhdZZNC+ef
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(478600001)(316002)(8936002)(8676002)(4326008)(6486002)(66946007)(6916009)(66476007)(66556008)(6512007)(6506007)(36916002)(26005)(2906002)(7416002)(5660300002)(41300700001)(558084003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?T9NATcs3/OA9y1McL5srKqnAd4yrSQDWOc2xYxpOBdIGRwOjheTPwyoun5PB?=
 =?us-ascii?Q?0aqk15MIcfEiuokmJ8a62rpT13Lm19/HqVtIb7JSPVNGGbURcQoe6KDAhw/o?=
 =?us-ascii?Q?9AxIPWrDwOzhkawkauZ8SfqxcncQs2XgoZDe6nv9gWGB1gcZRyD3whEHWPej?=
 =?us-ascii?Q?SQjlSkRed2KUmSD1tMvuyepLpyFlgKCZUmL+xzwSHf13vO2BTgR0Z07oW/6n?=
 =?us-ascii?Q?qlk1JYROZFvzL38dKvvq99e948H1bzbq+D8+tQk8KdNMeAngUFZVohiiU4G3?=
 =?us-ascii?Q?wK4X4cU8/wIQ8gCX/0V18oErVEITh/EA78nCOHVsNLNV0XBBylePyND31sVo?=
 =?us-ascii?Q?UrJiPtrLMBbBvAkAU53zk+wkIKtb/8ysdwr+Mq9XR1mxGxw9MRElUnazatam?=
 =?us-ascii?Q?RCplPFTlJ8tTOe/AmBGz56qCdHaJQZSFv9SMPM5S7Cd5xUxwp2hYgLVeFFqb?=
 =?us-ascii?Q?+KbBHJiLum/dpPONAlEmVL+u+xkvq11563TbPlZQTsjWgusQB0dzx1QOiYvI?=
 =?us-ascii?Q?XlGox0vvEcikqHEu1Xe12/9rWKsCdJowzSWpIswD25hjAklrb9MPGr+OQ53j?=
 =?us-ascii?Q?IGtckXJZP8rhizDvVsyzsnuxTXKDj3/SelEv7nXi6Mgrxqvipr+rTDVsexn6?=
 =?us-ascii?Q?xFhil5NQtxjk05rPDWla8RurYnjh1axy+B6O/MWFNtiTQM4Jdw1CQuw7m/Gx?=
 =?us-ascii?Q?YXx5iJN81TdmxKBIwDKr8rIdMLjbX9dZQMBjGXWgc3pu7knx6N2eV/UFAFET?=
 =?us-ascii?Q?FmFRxu7OJTtkHAOjiQNpIKSkTKSW/XU+zZhyavNNKl19qwIFFRmt4qazTB/g?=
 =?us-ascii?Q?sr8INFmVt27nVFIaL8a2pqvNgI/vaKwZrOvaNaiM8fKWTuTj2a29GOdGYFb5?=
 =?us-ascii?Q?VeKaA6jWhPwMqOEZLp2u28lzGXiRzFCAnHYrQRcSjHG+ffdyuD5vegcQbw/J?=
 =?us-ascii?Q?olYgHneHKK+zZDtP8PILBPRQUduW2ZEuQveBKpDB5LIZpfJq5btHR2xo0xpZ?=
 =?us-ascii?Q?uaJ4QW/8exIiG6wG/tOH2JvcUGor/Q47MIC/mXTYjCX0nKscdohhX97gvrsH?=
 =?us-ascii?Q?Lq8trGFK8qvIZCwY8EZI/pe7jTIWEebkt5XeMS+pAwH906lJzTigfdTWLYTh?=
 =?us-ascii?Q?Y044qR5vNMfv9l3CTgMb+ZDaCdkGBMJguNMNVMtTnb9+2ieuR0CsMFeAmS4s?=
 =?us-ascii?Q?snNOxrgx6ANoIzfACHEFlc9SC4piLI1OjCtkXYqqGYbdMHcWjTkrhmz1HOll?=
 =?us-ascii?Q?fiBmh4qAdGbsMQe5AgRmge2B/5l/7aXIKX2qdwzTXdLPlDnM6z7Su/g0qCdX?=
 =?us-ascii?Q?GF0pQ+jGwQz1JSC6YS+kIUmabGHnB2ceIemrvwCGHQWrEKcOxOKwGz1Cm8RK?=
 =?us-ascii?Q?McL6yTEvE2xSwnY8tqd64L52kHz7uCZkePgzoIuqVppOi25zy1YfAes3viPP?=
 =?us-ascii?Q?fbDByf4zKnfp3oulWeDZLKqVagzj7xtinuMvOmS8g8Udjlkqd6l5A+gN8Tmk?=
 =?us-ascii?Q?e6FHzfE4a7i0qTgUGfKoN8u9SduEpPegZm9tl48/NyhlOweLrUv1Gj6ppq9x?=
 =?us-ascii?Q?qfAUg/dJagPh91oCU9nVK5YX8iUxUErO/LCkJPS2MUiEUgWQHa4XeS8iNwwC?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iPYh38Hj+3yuwDJyUfWL4QVYva/ng9IL1RP1Y/pYIXFgV3VfsGBPyp2p+yjpYLmfgj2spqIfp4ni04zS4ojzOSPCcinDxxTCNx+zTYTn8Y6dYfUJtomTSsytgERvwWgB3UOK0w6gLcDjKZXszQQy5er863BfXFNVPzQafR47jOgMdoMiByQ21tlC09G0NlKZVUkqMt64+N/6v9V/x/+gndmQ5LKSC3Pzr/hJambkDDOkrzwun6jDDF3EluI/x8DyWUVl4zxzrvrk382Ob9Kk3fxzePwSbyLDzMijfml3UHQLBhxJ7KeI8LwiQeXfJlZJCiIF/FjlRsdO05wPTSUNdsnsih1UsrF1qf0ZeASrsGdX/BiqVJXAJKNLF8Y+SoubMYeRuaA43ujVMILvQoWIkhEK+Cw4Ie3QR6tWx6xD5P4SVpWIecJ/HywhitmwIrs+uj39ZUFyBCfs2/BybsjIKy2Q5nZMS0Wy8ph8PrWD5Pdtb9rw9LdAfA6WU47aWf9k/eo5XI91ou+oNjEw4qco0Trcs9YJRkun6XJoamUGbfTfycMQYVZl4St7CwL0DrHk0REhAwnzE2KOYtGw0C22GiUJxm3yepWrSDnshhIpfFE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa8cb15-9fca-48cb-8d10-08dc0cda6ac2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 04:05:41.4394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsglukZdPpEzgc7PsLwZdzzLaTnKS7Gu89M6SMqTj/jboAkl/6BMERix1YMdya0PN+CdpuuwL/VEqnyxSX5HmnoJl4mfjZHgUCHz0F9DtAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_10,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=960 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040024
X-Proofpoint-GUID: CxXGC3qWUGILQmKhidXlw5d4vw1W6DLK
X-Proofpoint-ORIG-GUID: CxXGC3qWUGILQmKhidXlw5d4vw1W6DLK


Chanwoo,

> There is only one place where goto is used, and it is unnecessary to
> check the ret value through 'goto out' because the ret value is
> already true.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

