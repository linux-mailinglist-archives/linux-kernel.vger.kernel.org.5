Return-Path: <linux-kernel+bounces-16241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48002823B5E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5EE1C247B7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 04:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA821DFC1;
	Thu,  4 Jan 2024 04:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X9EJd2Hp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gc/00ctk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D904F1D68D;
	Thu,  4 Jan 2024 04:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40426xe7001730;
	Thu, 4 Jan 2024 04:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=2GK/cHMAwbkwCXxmH03nQa15fC8Jk8FfiHFnToimV0k=;
 b=X9EJd2HpzqpTgFGUgZrhzC8+Xzz5dO5iJPsOcofUxbLmv0/NdrTxOBfajeVUZQc/wxhO
 0iU17A0unrrwPywK9DtJV3IQk7QP4p1euSY5Un477Mz592rngYTiskRdYOnNlXTn8swe
 IU1JlsAsG3eEBKyWS2XA1+MxKxmliPYXwzyQWY6HQPZQ+voGhLD1qHfvgCJsVnLseeOT
 a1MsJswduVMwijM5OWnSZoTxZmoXgNoyMwj1tMLQIBZoJHkjjoH3lT9ajTPcPUB4VrvB
 bQjGVoiBBpDqJxkJ1u80xeOuiQimlBOojHnq4Z8/P3Cz7j7ytj/4OsIxIQv6PwNiY1sm uA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3va9me696g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 04:12:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40440lU0027018;
	Thu, 4 Jan 2024 04:12:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vdn9a8jbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 04:12:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XveKH7ChnH8uXlRLIRWg1TPtKx+QOmKbIpaR9GoafKh4rNlFClV4DDVhJvViZ3Y3u9sCt+F4zRwwvjuriYew/jrf61qS8YRE8xnPbjrSEMPqlZ1TXR54eNujYcv+xOx457JW+QRwJCxo4ukOdtgrVg76Aqwc4cIy0LxhJ4YUkTGjuehSLPia5yqKY/cwaQdWqnS9jFCpt4lRF+3vXrsvoo9pG5Qq5j0y9wALJrslXDeGdLXkzH+cXzOQ67WETbI6SWajlouE4mYW4XH3rMqaV5g5S4Znp8GTgLHKo/5orBSOgI3wBMLtSJ+VkfLM9MJSrFAFUxkjY6+xp2zZ0PK2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GK/cHMAwbkwCXxmH03nQa15fC8Jk8FfiHFnToimV0k=;
 b=N5PmjGQA9QXXuR174fdb2fAdKaeIdpXQwNhFMaa0pgr1cP8a3rvxwl5TBc7z+rka3mlCJuYON0KDHyoEEndQWcwgVOOH6ncXR/i6ZKD2AZ6kl/aeLc2fNuFnRC7hVGdv5S61Nxrmeec2vIaDfTJ1YY/EX5sBPe4LgDJMJMH2BP3KFGyfx/St+qgr4sHbwlP1T+Si6TFTB2F+ORe5PfrKL/2CZofXntudR06mSYtyhrgpmfvtJpVXktN2HGlhigxHWGIuUm0NvRjWG6z2LKZ+MFaBXB9CG3jQ2dKse6nioVSfH438DcyH9TeiQ0nFEs+XWQElZ8LKFbyJQbjVqSLDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GK/cHMAwbkwCXxmH03nQa15fC8Jk8FfiHFnToimV0k=;
 b=Gc/00ctkFADcHYNOTwNty0k7fUyLH7Ysz8QmvNZl4KiIS6ux0b7xsZPOCvRmjcc8xaCqI3sWDP/6YV6oVEIMkwEX+KvpOupUjbgIFi6Zx4XWGmnCz7lxwKUUS2aKv/QGgAoCcrx0IHUQkqS0o8v17WeAsJ3rMLhYrEW6GF3Bvzk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB6738.namprd10.prod.outlook.com (2603:10b6:610:149::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 04:12:42 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%4]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 04:12:42 +0000
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org,
        Sathya Prakash Veerichetty
 <sathya.prakash@broadcom.com>,
        Kashyap Desai
 <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        mpi3mr-linuxdrv.pdl@broadcom.com,
        "James E.J. Bottomley"
 <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: mpi3mr: fix mpi3mr_fw.c kernel-doc warnings
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq134vdag9a.fsf@ca-mkp.ca.oracle.com>
References: <20231221053113.32191-1-rdunlap@infradead.org>
Date: Wed, 03 Jan 2024 23:12:40 -0500
In-Reply-To: <20231221053113.32191-1-rdunlap@infradead.org> (Randy Dunlap's
	message of "Wed, 20 Dec 2023 21:31:13 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:a03:333::8) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: c8387a66-175e-4c08-dc5e-08dc0cdb65ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YWXbjfeAEycu7IhpW8N1nXsgZWloVJKj6D+lpOHOBbS/WTAMRad2pTsu3ioJTzD0Z+XlHSzdOOYiS0tT2LnksY4wpF/huZsULEZOJ2VX87Xuku7l2poXP/Zef8ROKdX3AZ9qR/wL36HO6a/dNxH2KFt1nbhpIeGzL7AmnEad9hnP0GQn7+gdcBloXfcuq5GK6lsDnKCx9C8N9xB02DqjMkufywmcSN6+GB1Su7I9AtXoYMd0N0dvGvfTWp527tlealxFnvIHcAGOX6FVRV5ZYBpmhPgVHEFVf0yZ/n0pRSL039wK8qcHMsIbvv0DpJY1LAhYvzwjAX/vqqewPbeCwwDu73v27wcR91PtdIWH4IanO6BbE1jrff6BWTrcu2yjaLuCfNE82U89ILvwX+us1+Zqr7CN1bnxdLE0un4y5jZXva77vUPD3PDLeWtdiJpgmpzRRVchKHUZuIjrspDOUaRrvIP5TMMRmExMHlB+DkITX0UBizopuFhw3b65X3RG1WVllStVw4C68Qponfymgs6N3RRIrLwlqroQiJEm9W2Qzy87JVjfdj4zkDXEB4UjRDhhjnFgfguF2Tp/ZW99j8VPEqu1LvC+eztWiY5pAnU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6506007)(6512007)(86362001)(36916002)(478600001)(26005)(54906003)(66946007)(83380400001)(66476007)(66556008)(6486002)(6916009)(316002)(4326008)(8936002)(8676002)(2906002)(38100700002)(41300700001)(5660300002)(558084003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4T95YLfQAsqHkmZ2NwPyk3OUZzstJcTrTMXH+YskWz+iyXnAYFrzXF/4V78x?=
 =?us-ascii?Q?FbHkmJGaYkFWztut6osVIFc5dpLv3NhCmLgj0ApXFyEI55VFk5JDw1iSYG6c?=
 =?us-ascii?Q?U1R7tBp4KxkF6u0UBYAK+S5wZpB9jtYB6LWPVC/ESEK4768Uyj51XtdPWhOT?=
 =?us-ascii?Q?fwFMR9alasTd5jcvuJ6+DH72sxqMRFCXWxshkFhNRZaVJDjK3oFrNlfAaXKg?=
 =?us-ascii?Q?zfPx1n94j7EjqRZ7fXuhUHkU7aLEdQJsOuCc3eOVh1JbXI5GRBN4oomO9IfG?=
 =?us-ascii?Q?bksDMO1J11FW+tLcEs777wM/iVi5OyVOv8VlV/aPlIs5Ecp+j7Y7CLTuiHv6?=
 =?us-ascii?Q?KWmiCtBaUvr32CwnowbgbFzbb+ASvgYplBf0/LN70G3etkm2ak/yHBT7eiq9?=
 =?us-ascii?Q?Wh5JCERB/Z1Qy2lMFxwpwZ3Jg/Jsw0NO5bvstk79ov3xikJzOXyKq36EvyeM?=
 =?us-ascii?Q?KkLpGQIs1P6CwiXzKQMf5uwBwjBlClRR8A3gG2FpZgbnpZqyFecMXTaHfB3x?=
 =?us-ascii?Q?kxt+mmeNuIF9Kv720qG5Vze0UWBl4JBZpJgwPMUt3gMNyQwiZ8iKrnMRqm7y?=
 =?us-ascii?Q?DG0DbrBJSDE8VhI0qXadVmA66mWAdS4QmVKfFBrzAu+9nOb6+Xlt/UYwfcGC?=
 =?us-ascii?Q?/Sx09bNAVGhZar6RvD1AMNRxkseS6T6ZnjdyKbDTnj3bplzbnCJTngSFDjFU?=
 =?us-ascii?Q?PYwFn5SV05L4oAzUrlCMaUMuYhHEdnftsF1B1jODWmbMEyhej52KDeIh9OlH?=
 =?us-ascii?Q?Eit8nDQ2zcWFLXBDAfkT7fJzJudKutbYQhwNAYvcaW/QQqKr/qA14r/0OvBL?=
 =?us-ascii?Q?SRaTArqXf2g2KrklYr0FRrqOnvhiGgIsw+MY7a0JdnaVVGbtaxrVQCjpCE52?=
 =?us-ascii?Q?9HUFjofuiFz2YpsJrZtYnxt0i0UTB0uEFtEN4FWdLNmWkFLRd2oe9SFIa3cg?=
 =?us-ascii?Q?Ke+FvzLvJe109FoRUw0m6gPIwYsQDgXlY6n9TjxSf4b624lQQ4OBZmlThsdx?=
 =?us-ascii?Q?JMLU84CJWEd1NdoSdFjqxbT7cP1yUi6aqUKS8Sb2A4Yc/DCiPpm3o+Nj+oDX?=
 =?us-ascii?Q?yjO51JyfstKJWSQ18F8APJHOnFGVWOyOXNqPEiS4uz/MaybnF3FpoAwdx+Ff?=
 =?us-ascii?Q?MMews/TYnz56BM7p94Acxp3gPWkWN5eYY8iTc1rYDQ672wQXZn1j8dX7VGNJ?=
 =?us-ascii?Q?/l24fCaQ6+D+IxwwG89gG9Tjyajt2tDXmuYxabQHXD9PafYYYXswgj6QgXGR?=
 =?us-ascii?Q?UUv0RsYWc8SZpRkOYhkvTWYdo5z7IhO2N9tg/ei3XWn/dsCrkiyIULnVPbh/?=
 =?us-ascii?Q?kIU7GVJSOs6yGS9X0G4iyJHdkbFz2kFkn2fH3zxRQZVtsBXCgYBhpUs00oYd?=
 =?us-ascii?Q?mmKWpDvqb1MKowFL2OUvQkxg1etHpD744YHt4LvEkplHAtNiscwVR3haluTa?=
 =?us-ascii?Q?Fmk2RPLpnaTpii9GcvDkbdtvWjypxQuvnyTWmDdUJSUxkSdCnJYZNMvRKCat?=
 =?us-ascii?Q?uK5NGov4rrHv2TX25xqcxJGaMHDAscDRLzIALxekE6gAkxOTOYqESI2w8xkT?=
 =?us-ascii?Q?tZHm+txHx+fyV388nLwjAZLAS7uk5zDIx+RydcHz7QbWF3rBGoC9wo/mRu9W?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FXIqIaKXGtqfX3g/7my5BJytwFimnFUF11iI0/OIEHvwcGr4LXarVj65+Nl/9rCAwsG17q+xQOkQypTE5ptfRa/jZe2B8m6F8URlrq9ee7EfqTrhonXX2BoRCkl0uX8Oqldgb5dO0zyVYmDbLjlNZVzAM445TCCnkXkMhcQkv/HMUG9lWRR4oCtVMzGcBhoBv08BiSNcqSxC3aiKaytRukzCuYx1NB8TNyNNy5hILFtnOuBZwmF4Ak4T8h8LQ6YdKZf9cOLiIgsgsi9JMTUyPKYGTMQ9FPTige8Jb8ada4NKKu+T6VGdnuYipF1ZSf1r30xoqOqgSAv8IZ7eEqcxP06tg0LYeNfHSqbvCKHNRJqDTfDqQcHNsZSE0YUQ+lwTtlSSh6GlXVYv+KL1ttFXihwT6luMMN8alLsRoYsjMfsb3dQdiFJSYkIanECy3kh4xMTrqO7nZmGZ9xw1TUgpi4BNRHrrdKvrWtqHXlWey0s/F4iSiFGIdSEchidwv5w4XK55kV2haLFP6W4sYdIGJlAhgYNn6yTzZgs5bRdolvHUFvgUBaNEpSYdIPQ5Q4jOrlehuGyxMGrza5rEbMf2V+x9a4OmiVP7mBiamjMHSc4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8387a66-175e-4c08-dc5e-08dc0cdb65ae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 04:12:42.4001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7k7iIqE0pmCWuBORHh/QcTaNUSP3K7XsyRe3G0KQ28E3w4JfgPsD6pGi9KhDL8N6gsafaz9coNSnp3QGAisrl5naZw1g6/48JJsb8oI8bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6738
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_10,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=633 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040025
X-Proofpoint-ORIG-GUID: FmwWvfT_1qgGdsos9H8qGtUcdkgpKAP_
X-Proofpoint-GUID: FmwWvfT_1qgGdsos9H8qGtUcdkgpKAP_


Randy,

> Use correct format for function return values.
> Delete blank lines that are reported as "bad line:".

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

