Return-Path: <linux-kernel+bounces-24241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B9682B9A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EBD1F24B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4037C17E8;
	Fri, 12 Jan 2024 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h0EivvFO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KFF31bw1"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E763F;
	Fri, 12 Jan 2024 02:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BNwrtE007178;
	Fri, 12 Jan 2024 02:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=2637quazIyMqkqj4QMhnqOsqZdpAg0PMp/loMxBYx0I=;
 b=h0EivvFOiyfVNui6clmCbpjOSm/n+GFUy5x7nwPz8i521EdU9meQlxX/SwMbC/mLlnUC
 yjc3CllxxMybqxTRjq2GUwFe2d4OjSn1L7LGqSo+c8W2/7FbZeac0ugTbDkA9PempUZL
 3c4azzTrQ0PW+thnzYzXS9luwuOXzj9L5OWDrjF2wwC6X69EsAK6xzvW77LMdZXXrW50
 GAGtrsD703bk4wGQAPmoUpJ7u98ffPNbuC37woKEJyL76Bs7ooM0g1FdYMyu8OffhS4q
 tpyQ563caCMNmMpIj8sKIU//BM8elyCsZKkMJ+A/jXGEmpgbow2ZIWApvkBDtbtJ3CE4 xg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjjb6sq1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 02:35:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40C0e0Z9012177;
	Fri, 12 Jan 2024 02:35:55 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuwmx1g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 02:35:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKK7OkdBL9/rCoUEGrvylnsD43Olc90kWYxrrYVFftCJ8FCABEZlf86i3ucxwbJcWuG5LetLU0r5JDYLx1lG6XAz9oC19BYdB1bagaiD7u0frGA7sMrtpK5RD06nNUjo20dXR4B9D8vniMIiuFX0hgtIj44Y8dDQN+Uihpp/N9SvKPWzRwLK886wHWCdbEmgzw1+B5ccjlAw2jAJR8W6NM6rk00HRT/0QZxDWgWBYsNgCNpBqavxaMGkxfdI32gSumsumn03DN7FDIw2RCZSZnP43cNw3pZBx4SK6TI1poH6srB21wSm7OSqaBpQkIM6QIPbvfmIh/9KDhr0vIIHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2637quazIyMqkqj4QMhnqOsqZdpAg0PMp/loMxBYx0I=;
 b=oDlIQz9kAZR+PqafgPegLKLoG/0RD57joZCvPR1+3zuiXTYfHS1E9mCUAOmnaEe5ZTchUEXgZs3lOs1RvYiDUbV41LzqVMW8oq7dy2id4oPlssV2n8lSkIQU/fp4V3TJS8RjVxA7rZBup4rEhYALQx/Zqi7Gx6DNN5PmixPD3XBuRRjF8gKuCT14i6Ha0Lx0zcFpPbawvasWcjN/ZEM8naFe1OhvmcTfFVfaabZuXafp4CWZ2EA5GlouAahF3zPKMzjpWWvl/mDnRjHTmPZ4HMCB82CdH/ehm3mDdKTiIo5N+Nn4BCoQsvSF+QjCn1y/UpyvawIfxvOboNm8AnS64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2637quazIyMqkqj4QMhnqOsqZdpAg0PMp/loMxBYx0I=;
 b=KFF31bw1eW51rN1OnqT6XfPpaQ6VWkLG2S6DUCQs1DQ+pO2OJzpNbTj1V9B6Gije45GPAPkzFalI/bFCT/9Z4F+WyI1MtxH42eWIFvTALPt0ZL9CBAQUoWelgHmtd1FKa9GEsA7gvUIEuk+Ny1p67g/y2NtLT4vP2WUVnBhkCgo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA0PR10MB7641.namprd10.prod.outlook.com (2603:10b6:208:484::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Fri, 12 Jan
 2024 02:35:53 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%4]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 02:35:53 +0000
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Karan Tilak Kumar <kartilak@cisco.com>,
        Satish Kharat
 <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E.J.
 Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Arulprabhu Ponnusamy <arulponn@cisco.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: fnic: unlock on error path in fnic_queuecommand()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq134v35ldu.fsf@ca-mkp.ca.oracle.com>
References: <5360fa20-74bc-4c22-a78e-ea8b18c5410d@moroto.mountain>
Date: Thu, 11 Jan 2024 21:35:49 -0500
In-Reply-To: <5360fa20-74bc-4c22-a78e-ea8b18c5410d@moroto.mountain> (Dan
	Carpenter's message of "Wed, 10 Jan 2024 21:41:55 +0300")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0333.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA0PR10MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: c78db4a1-4624-44f2-cdfb-08dc13173274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CvKsf5jxVL5MN4uBqJJBoq9nBNYhF5srklDmuf0l/3IZ8LDiP9sb+DC7Qeio/KMiyBu3+mNwD6PomiijsgXR5ABVclB1ZjYu4T/fH4nv/WfXAPGK41dABRfGLPMxFzrzxKrPXlB60cvd73aDJKjEDc+LbDAwcfShep2Sqdrg7RXvMuGEwQnvfV0rco6qR5oM2oy31xNh3n7XRLaroCIaA6tthDNjH/TmgQfqyGeQKoGr4C2H5C1Cy5H4T4bFGCQ6LGeTsQJ6IZS4pJGfFmgWiI08fFnkF3Q7QkSTz1qHFE+CIIaRMFzguZ0UIbXwvfWxci54CU2BrWriDjEuBxCz91t+Wzp4cmeYyrxK5ZDuQljtqpIJ2Op7WJaq6f46jbLlDwE0E6oY2+ygHOsP8vsnXAu3SzwYAwlQMY+xutO5GMpbF49/tRHFJzA1ykEX61OUXL6i2ghPLMfqV3Swffmj2ys1ZF2TNNsyNWsRtJuY5D9LwVM7vFfC8kXl7Ep7WPhVClVv39JgQR945Mf8wlbube3YnPzOHInXRV/Fe3fOtS/7CE2cNnEXmcYJ5DCZp9kF
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(26005)(6506007)(6512007)(66556008)(5660300002)(38100700002)(8676002)(8936002)(2906002)(478600001)(6916009)(66476007)(6486002)(54906003)(36916002)(4326008)(316002)(6666004)(41300700001)(86362001)(558084003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RBAZN/xxNGlgW5maapuicoSNN6HbLFZRGHQKE8VnLmRHgik2Dul2d3O9sUQZ?=
 =?us-ascii?Q?bTHWxFMUgFQzgm+cyhNOwbOeDpDAVNRG4nFiTnR9L0di0bL2yrTVaBvkyS5Y?=
 =?us-ascii?Q?dpGu40xYkp8tyNFaWmJWBCz5i1dg7gc1LYUE1Xa4CeDZOE92N1edPFaVvdEn?=
 =?us-ascii?Q?gEkD1mqZ874JYvVjpbB483giQ8JFPZ3fNunE82UujPeA2TgUSK6qyfv2Bqth?=
 =?us-ascii?Q?bTsgbSMJq6tDVkfBVhzSc7JmSZg+vJhaBM/0SDFJb7+yAQfOwgCFU1Fqk5Y4?=
 =?us-ascii?Q?W+sRqQOpzcHnERYqg/QI+9hiRgUs8+b60h5T7svKBnDEEmJaD7Zq6OicDLZh?=
 =?us-ascii?Q?WHdBJQ7dFT/RGO5xWCK82XJkR8FAwmwHtK9HQOlOhqfqrqpdE1/C9jsTi7aL?=
 =?us-ascii?Q?62of6n4s9uePkycL77UMRSUGiBTItDDvkfWhyxMqKxMKGyDf1EWtKMIkTj5F?=
 =?us-ascii?Q?u8LlOeDWg/J/hnE1Z2pv9AH+1kWqCHpOXC0JeuX4NY7ToN/F/qsho/EjWCn3?=
 =?us-ascii?Q?RyiOSGu5myqPOy3mvGjrZjVbGhz8iin8Fl563pniEUYO/xuEqlM1TY/9btga?=
 =?us-ascii?Q?4ZCqCMmQKI8auCq/LBomRYKT2odVsvoxaXI8OMjnfzq5uj2Lrf0mYWlh65OV?=
 =?us-ascii?Q?NhZfmhFxBWuOeiAVddMiIIPsHHyw3F4Nrh94Yx+7cAglwuQKEQK4ixq52dI0?=
 =?us-ascii?Q?CyJEKYg4+KhGAzmfGa1NACZbjDMnctHCzVr9UxaQ4keCUzIzyerLikdM1dpr?=
 =?us-ascii?Q?sb+8ypo8VTAoV3PqPs/ZrfBWn5N1Np9RhZMPi+9FZbfFXWkJYnbdpH+rdicL?=
 =?us-ascii?Q?xFZ+OfweLpY+APVYFU8NTb4ARb6OEJrMTb2Un5p7lYgPh8z+dys0w+rpPdYs?=
 =?us-ascii?Q?Aa0k8KbhG6xkk21MdXl+UngWGTY+NGE7aD9FcJCwy7n9z5Vf+Z7Bq+Aoc207?=
 =?us-ascii?Q?zWL7+m21CXPfbmS84LstI9+5P+Hvn4cmEJBmhVjtauaY2etfs2nARx0YhRKv?=
 =?us-ascii?Q?elKNd4xnYy8ehr1znQs9QCj1o7CP1X2Qh3smbjKRL+afOP64Ihst0MalUCQN?=
 =?us-ascii?Q?JfKIjtdhXbWTCIvzXZqCi82hevqydSGDtO9Fx/W60JOv+lvIJglqTQTYIY91?=
 =?us-ascii?Q?/oMYIMAh3j92y4cTsjbnsK+XHKCs3lhR0udRiifLgBp2RneGPu28XGurXPvL?=
 =?us-ascii?Q?RmPzMUIU1UbafnI7LWRR+U8V9lKDgJfpKI6AlY6q2ZvvHWSNXEK4Mg3b8W4M?=
 =?us-ascii?Q?J3YwuEEFVwvLTDWAaYoJw93I6m7J1aBPPN0anMSi5in+axMxE2CqrYKkMko8?=
 =?us-ascii?Q?Y3Q+oLv+wdyhxOB9jNLuwuPks7WSVVo+cUUzlazlAtwNHFxG+0Hu51zeAAoz?=
 =?us-ascii?Q?7e9Fo8YpXQODtPKrujB/3QoxIh+nYJ4V7g48wA4h0D40HHNUqMeqDHFekAZT?=
 =?us-ascii?Q?R0JvnijdH443TZsgTmRPbtGQgxk6h+OSJdNrSHDo/xzNtxaHtboLsOwDQpHQ?=
 =?us-ascii?Q?aXk4MAQ4yxe/VU8K84ghhekfUwt3ziEDLkrb+aIxq81nRRJTlYhebhGto1R7?=
 =?us-ascii?Q?+r7GLyzVrZRiyIjDi1sjhNGg/P/c6P3tjrNctBPnGgTH7YV3SNWl2mh5eIrf?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gwZCcAHRKH2ZFfhSHtqA7TPa3Sw36/vVrTT9dJKCJBibLaDHAExW40TBxONLBIa/7KAe+85rqCHcrflkhYFurUJ4RX+pOPEdOEW58M830nUC5zJgF9/wo0v06TCcuNdw8u495ruF7veNjL4ftCGWiSELZuojCP+n2/1Im4YsrwDZ4RMXHbHi5OzxLHvdul6CR3k9nLmO3dCZYyZM/8DfuKnejcQkCdNTtcURTKEmW+jnypJnP4qxzvh1GoodeW/KtvWgBxSmKJL3FmTbromxLK0e5JmJY4wAxsYpUM2n0zmxfczIXRQUXQ7bbxn512mEzpkJyfpkJ96GcRXZnZ+jRF1mN0EDpJCqSXkJegKAKhRjMC4xlLv0pomwY3xk+7k0yeiw5i9/062z9t3rmLpmhFFZjCQ46pc4GqmjqUi9RO34wZ+G3UTzJIFptgElukGbK7S48dHHj1givXjk9qvv9d0VhQNxaQEZ5jf8Lg01Gpn4R/8GxkTGPv5Yn6swus2Jlzn8GhftFIxTVltHjRdREnvRiQIbRt+2nOwzswbRuh0/aJnwoMBcY0iwLX7fmJQlP1o+nk2veKqRoJz6kpLasweqHKYdWTWlL1dlLUPh8Rg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78db4a1-4624-44f2-cdfb-08dc13173274
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 02:35:53.2488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0r1naVlhsWxpdnCMz3wqyhF0QAY/ROWe9U5Nk0rTEfLKVAGUoSaky3C4c2Mc5Ok+lmekADvZOl8btFqNA49y80KaqbXTmi4WcNO51f8ZXzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_15,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=747 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401120016
X-Proofpoint-GUID: CyCPYKWXW25OXwF3sk_0WPoDErhEInfC
X-Proofpoint-ORIG-GUID: CyCPYKWXW25OXwF3sk_0WPoDErhEInfC


Dan,

> Call spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags) before
> returning.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

