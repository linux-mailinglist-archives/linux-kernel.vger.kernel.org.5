Return-Path: <linux-kernel+bounces-7522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4B781A941
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0C61F23C51
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61134A988;
	Wed, 20 Dec 2023 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H7Zrlm5u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n8GjNhBh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8114A9B0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKMd4oV012758;
	Wed, 20 Dec 2023 22:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=qln7j0UF+9oeyKVjDnrdnNRpqlbK4Ab71zAiAaitsW4=;
 b=H7Zrlm5urjeTQx6CPs9OdSirI8l1Sy8AdklelhDahDZg2VCsv1xCWL6U/nUjpzumcc+i
 EVU/5Y3Ns6bWygjgDdzmZdSKhUx0Y4gReABfhitkQXPCne5g3H6wi+QH7cfOZGwajLpR
 dqpf+RAlnEebDJNkq4TaxzDTtDKb40y+QK/Gb/jc7KnBQH1BuljaPJmcqjn/32cu9yZn
 AoDIiiEFI3EB2GSBDCaUn1PcaKCt/ZMng264MzwxH5SV25wjjN0mMHXF/8ovAGgUazS4
 R0q+JnHHdzNWgZmOsp6wRk3ZACbIhwBpH6Q077ibymJbfFdq2n59wk9fwhtAHxub2e5F gg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13guhk2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 22:39:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKLXpWE030864;
	Wed, 20 Dec 2023 22:34:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bff9mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 22:34:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWLbrWQVuwIEfteSNn25qHEp4k77rgYIH3ARMZiRNCdWP/KhXcJjCcX+z8GpFwGmWQT5mvCoQHMTFa6I0DOIO27UkN/rXiZhkJuvU27+6EJge5O707GgOip0RwXoilvBebZveMyS5FMy4P5vveEz3F2DBfJFWB2dga+ya1r5K4wSy69+B0nVaPlafoh2VFsmzL+PGDwJ3RzKxzpoKrbYghh8zpRgHW9xVhenKuNhClsY1LBpxntp50VFCe7Xy8mLsf2/sO4nkpDleZc1Nymw8XHJpyAweJIO7w3LkKx60uJ1a3lw72NGmHbtjR/hDfpfTF29FqLHvwBJC0cw2wmX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qln7j0UF+9oeyKVjDnrdnNRpqlbK4Ab71zAiAaitsW4=;
 b=CqhZT/qr6PgBbeGnOWnF7OKI1KhmtvXeJpnP6wqszq1KwU0jN6QZ+9BFm+r9ew1LZkDEOVx4AVOUTv/BtMVu5recJVGFngBfZghmUBfoydz9KFu6sg7uCFoDdr4LsYmGFyW0csVq2pv+xI6Op6Gxka0qkS7Fo8Qixrv5yZMaMmXt7au8dAumTDfCgrddzBsqVx1SIUMXHaWDiAGyG+ezop/IDQgFuJ1yf2Wi0yrbFGPjPttNdBdPtjlnuokPUu24exFmsj0JvfNbqJh6kJMMoXXqPU4/X+a7IC65SVkrGjQXw/pxN7mdHzGsp7TJujAIQsQF+9ymGbwXmMUk2DGMYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qln7j0UF+9oeyKVjDnrdnNRpqlbK4Ab71zAiAaitsW4=;
 b=n8GjNhBh2sFqmVZ1XNLMqA+w3LonCy30EzZzcD1M0mbDohruObKpRO0+l0ZY8rMYxOKaX+BcniU2B4Bp4efYjc7K2OZcBhrjbNasbo00F1auC4dXkq4jWctv/drcgqVqRrbtYo7qOamlFnI05n7obv9HmPx0ddBP74sqboVwAxM=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by IA0PR10MB7383.namprd10.prod.outlook.com (2603:10b6:208:43e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 22:34:20 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::5d54:7d56:454c:4ff5]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::5d54:7d56:454c:4ff5%6]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 22:34:19 +0000
Date: Wed, 20 Dec 2023 14:34:17 -0800
From: Mike Kravetz <mike.kravetz@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH] MAINTAINERS: remove hugetlb maintainer Mike Kravetz
Message-ID: <20231220223417.GB3505@monkey>
References: <20231220220843.73586-1-mike.kravetz@oracle.com>
 <20231220142655.e8797dfc0fff619f12bff53a@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220142655.e8797dfc0fff619f12bff53a@linux-foundation.org>
X-ClientProxiedBy: MW4PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:303:8d::11) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|IA0PR10MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbe671b-4794-4fb9-b95a-08dc01abce9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	D6+9bHvXFSr7NVs9hDVdPxv6BvO573+l4Xhz7+T2at/tqIkU74QG0mD56IRxcDPh25VzPaDK0s4Q1AZvkn5SOKZO/iVCjvC//3jMrJrw4jmG2f3Z2XedWiQlz2JVpCO5IuN0diDvhDq8lP58XpLnBwTuHEq14YSb68ewVXV30WkDu1KF0+517hDA2H2FE8OwNDklBmelk5AtKtWKFOYqIGyr5bQ4vFGC3BOSPRru+gR+cEJzcAc3NS6XIfkJU7UK1sH/ir+Q7i9kCK33avDh8MVqDPHwMWfi+6EOqCrqmFN8VXWrvD9W+ZIoetx3yIILuomZUWos83EfYrM6CYqzR9+HwvMC8vs8ogzrxlKf44kXi1iaeGHQZyY2ZK+23TQ/3Jg8hK/GTuWpXVo6rrac0HMzHGE87kHJXhnxXS5Mzw71BEic5wkFRw6HHhEbm+zlqQqxe09R1mUsjMfHrlEj0mA635B9rusiuemNNMn8ScTsmYqlS3Gmjv9ln+HMFbWj24WpgKR/XUFLgq0tTYyUsHBaA4uTX8zgtySM7lU2fwVfOOJFcdzZxm5TYC1Umfga
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(1076003)(9686003)(53546011)(26005)(6506007)(6512007)(83380400001)(38100700002)(33656002)(2906002)(86362001)(41300700001)(8936002)(8676002)(5660300002)(33716001)(66556008)(4326008)(6916009)(478600001)(44832011)(66476007)(6486002)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HD5sEOWF+N4OJvpPcgOT3ZH9dJjZo9CsEmtO8iez7i84OUTeg3AIWnEtyRiQ?=
 =?us-ascii?Q?rB3VaWCL0ah1SPuiFkGQBckEzCbfUxuFHsFJRTFQrtcnjlCIQjnmfR0kZz96?=
 =?us-ascii?Q?SmZfImG45mCMM4/hJ1fZOt3ZDrVKXNWspmwaVPDzezrng3hi9FBuv/mTBvuX?=
 =?us-ascii?Q?nxyyIjs47sr7E7bTIuy33Vd2I9SWa6rpsQ3sMWAQa3w7rrVN9v25szAZMG0q?=
 =?us-ascii?Q?BE1NcUFdkMMitQaAUnzcoxTxQcuwDXCho6c/iNDuvGmQFtko0DwG6eyOkBJd?=
 =?us-ascii?Q?CsCa+NPcyp1S1TzChz0M92qblkgI0snzKAL4wRvvVPJcl20IXzGe25NfeqSx?=
 =?us-ascii?Q?0vcvpidT9IGCEAyq50L9YGDVHpC/RDZlUugd1TXULQSV9s5956cXkzEIgM8H?=
 =?us-ascii?Q?+CnfLHsO3WpdQtfXZze8LDHXwMKJPxwKfk9cMBb+Ldymve/KuleNq1IogPyd?=
 =?us-ascii?Q?yrHCXZJ+HhQr0DzuUQyLR0LDH9KVCtOHOLyX45ddIPnoHSotY64Ls+bZIzK6?=
 =?us-ascii?Q?q0ND2oEEKEj4WW0Eq72dsaS60PRMSJu2WRGPyu2539eeLJdJ4fPAjtjpetdU?=
 =?us-ascii?Q?wPeP/o7yVXgtk5XDIUDJ54ZWfSeFYROiHa7/Jin9L11XcdBGLTQdvqs1wFHd?=
 =?us-ascii?Q?W2yIN+UYNTqMJToEWtBa4kjhnNY6EAgCsIwIe2+FHuvC88qGK7ks/+xAzbmT?=
 =?us-ascii?Q?3v6h8UTGoYKT5YRuI6t9HTg2dV46qfnrBgzo/gerwvDzHdzRRuOxK4wDQwsZ?=
 =?us-ascii?Q?HDOVFSSmzDB8FDGlkmFFv6OBZuq8Z6FPO5pyrwtiRTZsV69E3v6EJCxxyB0A?=
 =?us-ascii?Q?fNcXlBWOmEe/SrkSxpdexE3RuwP2wGRDm9w5qnaRk+cYJ1mXnkjFtfbOvgPO?=
 =?us-ascii?Q?FmDEwXaehv5GB/t1BgPJaE7mWv9p7taLL+nJzcB4J7iUGMuV1eP0XAZZLs0g?=
 =?us-ascii?Q?YiYCuMWP+YXdFdHqmfkEaqhmv1miKZbgMDYIBv2WDXCxMwNo/3EUV96C81Np?=
 =?us-ascii?Q?WzV6VS1nbvVmFM+G0v0AoPYnbQUOmSQwmq19Go0/rGV8i2KUoMpxyf6ETtxq?=
 =?us-ascii?Q?+r0n9SurTN4AGHUT52hH/ij4g1kkBw82nvLuQ/9FYb6WjbVbRcN6x+KLIihM?=
 =?us-ascii?Q?zxiFenTSZRzehl0Z/C0j9ASV0N1PDa6NCPeSShTNrlAAi1x/Kuw9g1xaPcNs?=
 =?us-ascii?Q?x+RqC+h58WqIsJaDW9ahWVsVYuhmGiI45Fd9fN+XujddUqIvgnaOAi+XLPL5?=
 =?us-ascii?Q?SQoOEoBlDm9kvhsiXU2YVK5sjVwocEfRk9G4qBn6DMDKbxvZ4u7OvTlOuxWg?=
 =?us-ascii?Q?VwEw4dp6FRS5sA1uUrL+KOqOfYNEcoNIMxkhZvKP1RByg88OQnzLM/O3ry9p?=
 =?us-ascii?Q?bDgi1ym/ZiLYLy54qlNCrmhxytaOXuqPEir127pDHZROO8AU4iCaPIaCUWvu?=
 =?us-ascii?Q?a+UhLjWjjE6D/OBzWyDCD2vEhcRSKAw3VHHQsctuVjx+wEfOMED+VASLm1Jk?=
 =?us-ascii?Q?cq6fNEvGMPVGjyIcVThEANxT/TgHQ2u3HIi3/GaXgwl6yjkwLV5kWmej9eEz?=
 =?us-ascii?Q?7aRsKZ70pqCArM4t++s8k1UcFIxqoNMT+UtCOLcC/P9BuIYewWzx+PVZfv0s?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Rv7I4gLWx4FYBp3mhOypGefXSv652daWM525t+Qf9mmR1NpbX0xcTQfVyH3Am/3eYie+D1K7SlDkb6oCwUYEfuju4Zv7UExm6e0EVuVkGPFFfv8jBFVDHE6nir6bMkF7FB1fzgn6hw2wPOSjNXIgAw2s1SJMVPWuptgG6L/UYUaRAAy4TUi3TGY6hJ8OHaaBBzGpUwvIc3rPP3ywo6JlwjDECmOWlNda5mRmHIGewAoHE0XuUAT8OSrOJbq0IWn+t6Ylh9xzxj7SdEPPD0K/K5BQaB8XayJtgdVbWIp9+6Fr9UjwPUGghJl1XwHxpkvmXa0b7vEtMwIcSUatVDuvW03L+D9q7ulOaZU94Ly2mXCNSgfk4rkpVdCJhVdNFmqXVutZ1aVT+DP5DibWYsnc87F8vObVPWalwgMy/uHxIpqebJlmClWxfT8wDQFFY19TJDJBIYajnfae38rpMDjsU+gA7E2mDr6FMgtU4ufiaXZj0lXvL1NQP7GHQYaQ25lO5iYZbw7fLWTGReAQqJ/YzZymHw0SJ7+gJKdGZ3sGXTvYHEsgWMnOvJiTSf4rKhuaupRe7mDbTSiMuOcThqp0298UoUEJYhlqQ/8AkfPCScI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbe671b-4794-4fb9-b95a-08dc01abce9e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 22:34:19.8987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mkvdCH6vzUzoyXUO8LEc5pVHC2ASbmzkh1qF95ALppZudNMJ+DRILve/kJcfmfxnoY1Xq5cNCoCqx3x1/1ZMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_13,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312200161
X-Proofpoint-ORIG-GUID: YrQGJb_hI2Wh7BwFM4vp7y_LWbIDfHHJ
X-Proofpoint-GUID: YrQGJb_hI2Wh7BwFM4vp7y_LWbIDfHHJ

On 12/20/23 14:26, Andrew Morton wrote:
> On Wed, 20 Dec 2023 14:08:43 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> > I am stepping away from my role as hugetlb maintainer.  There should be
> > no gap in coverage as Muchun Song is also a hugetlb maintainer.
> 
> Sigh.  Thanks Mike.
> 
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9762,7 +9762,6 @@ F:	Documentation/networking/device_drivers/ethernet/huawei/hinic.rst
> >  F:	drivers/net/ethernet/huawei/hinic/
> >  
> >  HUGETLB SUBSYSTEM
> > -M:	Mike Kravetz <mike.kravetz@oracle.com>
> >  M:	Muchun Song <muchun.song@linux.dev>
> >  L:	linux-mm@kvack.org
> >  S:	Maintained
> 
> Your patch is buggy.

Figures :)

> 
> --- a/CREDITS~maintainers-remove-hugetlb-maintainer-mike-kravetz-fix
> +++ a/CREDITS
> @@ -2126,6 +2126,10 @@ S: 2213 La Terrace Circle
>  S: San Jose, CA 95123
>  S: USA
>  
> +N: Mike Kravetz
> +E: mike.kravetz@oracle.com
> +D: Maintenance and development of the hugetlb subsystem
> +
>  N: Andreas S. Krebs
>  E: akrebs@altavista.net
>  D: CYPRESS CY82C693 chipset IDE, Digital's PC-Alpha 164SX boards
> _
> 
> if that's OK?

Sure, I never noticed the CREDITS file.

-- 
Mike Kravetz

