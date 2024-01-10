Return-Path: <linux-kernel+bounces-21656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D56D2829273
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286901F26B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CDA23DB;
	Wed, 10 Jan 2024 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l6xCTWh+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KXbSnz+S"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E2C1FA6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40A2Sti9014881;
	Wed, 10 Jan 2024 02:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Yac6pwHZ97RsB8LdwS823L6qxsbp4drFXDXpYKLMmr4=;
 b=l6xCTWh+vCJ4L4gbMJmg7Rvwuu18C4UfuvldtlcCDNpQ6beea5ZvRxPY2aZT/Oi1GxFm
 1RepG5ijuCMvJTf4OYRtVTrDvtCzJhJ7gAfYOFZNl7eEu05ePb04rPuawr/jbkkqyDBd
 E68sTd+VS/0Ppxy5anspfl0pgj5x11i2oMZ9y3rq9ns/bRsVO0dI+1p0PDcr8rYa3S5/
 gaOaHmq4vc4cC2fRcI+bdaoMXTjg4RqfoQNuQw1YwscVE9zkMlZsDopQbPrEKJM/WTlR
 Gp+4MACz8nqPV7s2KEVZPDQx/SO7+S0NQAhbpQKF/zxscfTBmNjsAW/VOd2mfI0mkqk4 VQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vh9r9911d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 02:29:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40A2MWGu030204;
	Wed, 10 Jan 2024 02:24:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutmx9s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 02:24:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEq3BXWuuv5JTY2sG4dPP1MOPhSG55zUjzoLm1plIHwI8fiz+qnvKGdmZ+jmaB/nvs+bOwSGfk/Hkl6B0cx5IoNIaS3udGampQ+iALcqy5aZAMdVNYy0VbyRj6+YZXDb5J2h19KzVWsIUg+GwTITa7y0CwGyr9+6rMpF//hI2ILA66nfbNnUlnPKYqpn8nk28uYrg0k9lLcfDThjsL/jgn4wtkpS/u5skSfE2c7iUEuxCPDnTjLON6lMrTV+hmRGfRCAbWvO32MOu3ORW33+NOeZqfnBlJnFphtZl65XvyTcBL+SRqoVssIKqZUdCQKAdsbeSpUsSuAjiyI0EmDb1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yac6pwHZ97RsB8LdwS823L6qxsbp4drFXDXpYKLMmr4=;
 b=kEUGELbfRU+YaMBCbskcUMaEdM8GVz8z8xMuWsQWSpdan0M3veZLFgq2glUNb+jvkdzy0C0uIW4xMt8OUpQNW6lRE7/ULVspPGlKpFSODaDBuXjOlMrMsznXKnWYENKuKzcIDCuZ31FZB7qK/mDyDZIsV02qkpRNa4BwdGCmMfWQ4zlIKHpd9+OW3wcAblDQEYr/nOJGVm6zxRvbOq8hYJpL1twz8Eq72xVXOZ6fadqeGcW06VUA/8iKA6mNHv9wZK95td5Z+4JvYAml4c9oqE0PkBMRpY1/le89ujdlcCnwerAREd2wsVDB/Fn7Zh716iNLvAvLgJBWg492Nr7vkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yac6pwHZ97RsB8LdwS823L6qxsbp4drFXDXpYKLMmr4=;
 b=KXbSnz+SCNGFbxbym5aEHwL3NZQHARez+3yd+mDQh1GQqqQkzSHSQ7/cvpCaTIsmlMaxWsLJS2oDxTB9zvgGS85xYpz7kqiqKkVaGoEQVVWnhohnKbEG1HkjBio5oZ3AfXxZvah6ad4JJ7HzIjtyKWItyoQ1bY9Rc9HeIRThNmI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB6821.namprd10.prod.outlook.com (2603:10b6:8:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 02:24:39 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 02:24:39 +0000
Date: Tue, 9 Jan 2024 21:24:38 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org, akpm@linux-foundation.org,
        zhangpeng.00@bytedance.com
Subject: Re: [PATCH] maple_tree: fix comment describing mas_node_count_gfp()
Message-ID: <20240110022438.5htfrewpgtn6gaoa@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	maple-tree@lists.infradead.org, akpm@linux-foundation.org,
	zhangpeng.00@bytedance.com
References: <20240109223119.162357-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109223119.162357-1-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d05f31-f432-44e9-2dfb-08dc11834c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gnx3vDVNUOtllXiAw82UcDAio9YRB/b7t8F5dsdJO2aJuNjN5crmJVffTRkrQUAWr+ZmU+CyPLakdBVtSwQ1djEm3bx2rtvgVfLL/hHsZMBg2I1a3KCNQLtRPo9NLfuHFBbu18aGmYDhQSU6m34LTvDtpUyNymbSH3ei9l5Zd8IIL4AwINeuECiBzKEHRoJdpankue8Kbm6SAQzn0MX03QRKBezMQHswh28VtxgwXIRaP3KOp4Pn2CDbgcSz04w5IjOcUa80vC50q2LBvEDAsllhWF5uStocO2EUhwo4qHWd8Mf9JHoguwvUb5ykkHEKQFd1gJa2RDBLAnW/rZVZHIONSQe2F0QTa8v6EaMitTymDxB8P6NzirAqRnGEPtIk4lwggf+tgOX5psK9GMEtpnY07Vzis+y8XkY3Ofc5UaqpzkNRR2t8yi3QVjKJhsLxYukFfiQtOk//UJoLeGKP6d+BcOTPmMxrAv6eTCen40I3ro7sMXG4OCk/96oEA3RohB/QdNFzmncLAnIxILuL1SVQ6Y0dxgvFfuEawmFRBXEdLfDkQZVYmzqeZUkJO/ns
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(346002)(396003)(366004)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(26005)(1076003)(6512007)(9686003)(6486002)(478600001)(6506007)(41300700001)(5660300002)(33716001)(316002)(83380400001)(6862004)(66476007)(66556008)(8676002)(8936002)(4326008)(6636002)(2906002)(66946007)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TpbPwFhPrs6lpHbKWhYtZs9xS7DaF+kR0jmuVS1xuW3T44klES7MWwSW0+Ee?=
 =?us-ascii?Q?Db6P0/FAB+RUhS+DIFSVAzfWZTyCbfOa2Pi6HmcqfS/x3JbKuXa3SGww/iWo?=
 =?us-ascii?Q?r4m1dCGyCd4lS6kykonnL+PM7YG1GqCWue11a7DK+EVWxEJZ4XDD8qErHsh0?=
 =?us-ascii?Q?6S5GhldqJC1Vd/uuXF3Pw4hDhrXU4xUdk0f4kgt4s8YOOokhrE865cK/rT7p?=
 =?us-ascii?Q?i641ngvQwKPnk3A7NtIymt9nTn0JpFK51bU3oL6Ix8YiI+p6iETyVW3+p5wy?=
 =?us-ascii?Q?E79GjfWkZlQRZJZOU+Tj16zEvXyfYGoFCQxoHpwWiuIsxk/rouS5TW5VD9Nq?=
 =?us-ascii?Q?4/uUYTTSOkX+x+mnyfZe8UXQmmMuxKlKTlXmBZZ/C1RENQNDgYcUAMLyz9Cu?=
 =?us-ascii?Q?7LMeL0c2yB8jIOFwhCbbiXtNXZlsk//ftrBsv2SP+vh5AX/MRQzVYx2p2hNI?=
 =?us-ascii?Q?tA2axXW6pQJmnrqiMg6JGskR1/KyK6ZCOSZPVkFvA7pVEO51YY39xfuY1eR3?=
 =?us-ascii?Q?lurEP8yirdqsd3prcSwdqWnC6VlGOp20G2/yolL3/eq5qtDUSIP0ovCOFb2h?=
 =?us-ascii?Q?RmBu82Mtq1VoZEqk85lvpe3QN6ovyWP6OUxNpDondFmtVVLCr20SpVwtMVIS?=
 =?us-ascii?Q?A6oPkJYsX1yJVf5yljFk2buL4g29C+OB3IMDUbibyNfw44NGLChPaCeObArB?=
 =?us-ascii?Q?p0XK/+nwbMfK93QU31o6DW1epTXSgPTuoTiv1D7JoUKTiY7JMpqceYwi6YKI?=
 =?us-ascii?Q?Ei9vq4FITWRzE81y0Awdc7dlvRtSzhj1PUlcfSNnIrvtna80F/rm2rZzzqNr?=
 =?us-ascii?Q?w1ItXHOUk2a5kLebGGtEuXJ0aIP/XJeDCxs0Iy+a8pXWOzzTqWM4qpXj/htz?=
 =?us-ascii?Q?qhawKD3qEfXMOlmlLcwveeTufgI3lwovk4Q7G/6/QMqYife41QoT/0ffesil?=
 =?us-ascii?Q?QwRHBvGq1ikmwmhpV+fjytr9B92VocpeAbkv3qYKlw1xN8HTGYKsaYX7wGpQ?=
 =?us-ascii?Q?LHoMyqxXFmu9yWH+TChvLNiYIqWdzbvXfUtAIka3ve2FileEFH8kQwiPkBr9?=
 =?us-ascii?Q?3fRNk2tXa23YLlNM7++FTKGFtT/2NBolz7M80uamqN/k7UZB9hNUn9i84THv?=
 =?us-ascii?Q?qATCulPPnOQQSGrlmJu07mkUAaUDsgg4Mol5DqlBAeY0zQYy2nkCN+4Jz3BX?=
 =?us-ascii?Q?MApm8uw89j1K0deurDGNKCUiFk7s01lESUyot31nMGG422Fv0vuVtPDz0KJ2?=
 =?us-ascii?Q?O/n8f9bqWT6bi+/JenPgZ2ZhvA9nWzOzvKUmLZpKGgcLNfCU5dhJ7DTAPRLP?=
 =?us-ascii?Q?SHTzV+1EQY6Msa2wC+RmCYFxbFMkbVMfPZ+D9Vkm9uT3KMIKVXy4JD+sPCjF?=
 =?us-ascii?Q?avxjlwxMOnjyXApSSdGk5C6lGYqa8q7/yDCHaethqNCaEbTEy+cddyUH1+FT?=
 =?us-ascii?Q?2aUm2EaCuep04eh58x8CVRNeKLCovXghbMvcqoVIgnbLaz2IMM2lUQqZRJ7i?=
 =?us-ascii?Q?JGFa6W8LsgWptRdWljCanm/wNUoD5lEA0jI7vVUIlEUUU4SsP1J1/krSzu50?=
 =?us-ascii?Q?+lloIYOL2ASv9xPkXR9wW7SdB6ebKrnrgX+olxH6Z/RyecZ3Fl2Lvnn/7ReS?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DJHKFpvYrbZardFwawTkTrRRRWAHiY6zBdfCB8pfgv/x+UUl1zlNgPrS36BrcNbCC8V5RxuoaotmC1NgJ7BW9uNsUJr9C5e93WBtAvgi6SUBWKmafxevN52PSuAbbEbbYCHxqZYDJACYlJ8W4FBcoB21X+1knjBr8YXkgY5k+b/a/SmPDxrsyQONWdpNn3gDwK+DFfr3xNVn3erbIzSJDQD72pnRR14CHiU/T8v5RPQF3N3h3UMpJDMrXfYFUSdgTPjcMAIAXNjP9+pIohN1NvQSU+LaUC8d3UzB82ewTqNQFXBqwM+YzQodwjjpwoDIFSZNItQVsmB5TCQk+2vDxLH3N4w/Var1WJ14NtMv2sUZgvPlAHn/qetrtpYWvkK+6Aw8Ct8y+YnZGx9KUmW4WjpKpC5dw592rOC4UmHhl4TNq+MRnEtLDc8tYXXh9twYQGrdQCfpMO/u3zGGaP4UT6OaWW4xw6f6zQQgN40Jln8WYHuOVgUheVHZuP81n+q8L5ScEpZdKU73bBJJPVSmrMhlcEO8OSbAI/TEWjlGNY29F1veG4Y8ryVzdUmWxBcFwbp0mWoZ0iyRyYI01wf44hgRMSe9xl/B7WTbVMmY1nE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d05f31-f432-44e9-2dfb-08dc11834c38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 02:24:39.8094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bRWyKr5NTeHlNkkLe9oPfc47RK9Y/yeRgFDIvL6JVieZwY1ZXg7fCkQW7cOHfrAnXiCHajVtytlh++c7MWYQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_13,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100018
X-Proofpoint-ORIG-GUID: NED6I2vY9FvoL4OyTZcfTFbRdV315Wqd
X-Proofpoint-GUID: NED6I2vY9FvoL4OyTZcfTFbRdV315Wqd

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [240109 17:31]:
> The function description comment for mas_node_count_gfp() mistakingly
> refers to the function as mas_node_count(). Change it to refer to the
> correct function.

Looks good, thanks!

> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 6f241bb387992..7b161802860bd 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1307,8 +1307,8 @@ static inline void mas_free(struct ma_state *mas, struct maple_enode *used)
>  }
>  
>  /*
> - * mas_node_count() - Check if enough nodes are allocated and request more if
> - * there is not enough nodes.
> + * mas_node_count_gfp() - Check if enough nodes are allocated and request more
> + * if there is not enough nodes.
>   * @mas: The maple state
>   * @count: The number of nodes needed
>   * @gfp: the gfp flags
> -- 
> 2.42.0
> 

