Return-Path: <linux-kernel+bounces-20963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FDD8287D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F839B23CD7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753C33987B;
	Tue,  9 Jan 2024 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jzcubfwk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gXS8ONN8"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC1C3986F;
	Tue,  9 Jan 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409E9Io8015071;
	Tue, 9 Jan 2024 14:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=H+fSYpOCOCZBOLFVh2Z6WgRX4qqX1ONZQXRo1e08tgE=;
 b=jzcubfwk0/gECnyEUuRAw8ObA0o+lNR0E9+Ep4+1+iKn5chMsmReuc0243mrDbWN0hqi
 75dxQGdqDDs2MhQJFIDaigJW0wZgciG6l51yH5BHAd04aulLmUVyeVtlQ4xe+CG4NHU2
 Av+Ryqv10UwM1u18HzHVIZQHag1SgokCuFmCJpSFveu4QxR6eL4Udll0iR7oWDsANHdy
 ZKAn9oyQcCl2A2uPxM4ICTpFLSjIrXCdRL8cPD+zRlSpbLZjKbsBDXRSJWIWZEAbyGdA
 MYC2UDrVPyOazP9h2rDwH0B/xbwBu0e+MY81HiXmwBRlbO9UIg2ZX+6fELjZBNBw0eQ/ TQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vh7neg0eq-44
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jan 2024 14:13:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 409DptXe006702;
	Tue, 9 Jan 2024 13:55:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfur3s0kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jan 2024 13:55:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHPjtpp+w0NGJLsjzX36uTGE/sqxi39qpjhFLsnrQrjwfrx+yQZpKd3vG7dk8X576F8yMzwC9GSeWCzgqm8l76Km1iKWn5PIBmUPbGq9C8UZExROb1y28e1pt7AzQgSLO3uB1/JLySsEWdguVONOp92gCmACwHAYIOK7Q3qn+60rNQ5wb5QHAWMKAWd6/gxHepgYswIqfKTAOHb4YLGl/3tawBQzxNSKtMwE3U56Huo0DXZ/LGkPxV+3L83TW/sh6bpmzm2TnwXSxCJ54B26kQ1hC00Llmrwe8/5b+sHoARx1ICVAyiHutpu8c6+Sf43o+gTeR0SIhuueWvnlXVJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+fSYpOCOCZBOLFVh2Z6WgRX4qqX1ONZQXRo1e08tgE=;
 b=YAytAj9yUu2RB+Nh5SfnO0/M4LIzDkgP2HWSK7mpCu2xZsG0na6/pc00FwEvMshq5+wo4AMtRpWx1vu88MxTGyb3S1irtPkc56U2mmzLfDweFWVMqYQhRJPIJGrmQtg9zNifPdg2qpPhj7BQAtt9YlOPvqOP7q0rEAVNs+n3i4zLZIY7xlMJxUlX2b5o+VxSIfVXIsg1JQIywqP+TWVnzSZCyhURAr7g+5yzQQPZHXmu4GMKY3vczLG1XcqeWGs2PQVrUPVmNh2ZfJszpiNtK2ki0wOJA+lXBX/Zd45K1iYAGqUs5UhIq0sWLoHV1cGWMvfn3SMI/tnpNGI0uXMcrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+fSYpOCOCZBOLFVh2Z6WgRX4qqX1ONZQXRo1e08tgE=;
 b=gXS8ONN87vi3qABrv9I8TR7SmCPMP6zoILx4HFEvzR/sWcK8rA9hbs9A+3AWLteUcQJNpz6cgaYRsKDSF48eOnd1j/F6jhbdqiPUhCRuMUuksaCOxyPzBVUWz/u9Z36CJdx99Tu67F2TCyJ8lIqlV1IasgAQeS4pBwMlYOJ6U28=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7269.namprd10.prod.outlook.com (2603:10b6:8:f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 13:55:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 13:55:55 +0000
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, bvanassche@acm.org,
        hch@lst.de, hare@suse.de, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
Subject: Re: scsi_get_lba breakage in 5.10 -- Re: Linux 5.10.206
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1jzoi7hrt.fsf@ca-mkp.ca.oracle.com>
References: <2024010527-revision-ended-aea2@gregkh>
	<ZZ042FejzwMM5vDW@duo.ucw.cz>
Date: Tue, 09 Jan 2024 08:55:52 -0500
In-Reply-To: <ZZ042FejzwMM5vDW@duo.ucw.cz> (Pavel Machek's message of "Tue, 9
	Jan 2024 13:15:20 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::12) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df26e42-bba5-4abb-995f-08dc111ab309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UTPCLDS7IPNBHZRm+ckI6x6UH7Y778N5m6eK3skBe6vrfMxTa2Z/7MBVT0mT0C5mTp4R6xAh2peSirkQkCOY5H16zVbCrqYOEw8VQRmjtRakw51qSlKdb4vOZSmtzuZAlelYX+vGCCHTfhS1yqS+GFV9CqvKRKe0h3T32xeQUq3o9h6IHmo4QkrcB7KLwS21wlprJstZCQ2qqPPDif1+s6N4eJTQpj4BFuDhuHAsaKEd4nTqBwYjldnM8B1oyr7ZF1FIYRhJWHNf5smIO/OoAR99Fj3zsdi+yXqbNE9ujhZJwRcljlC9S0Jupx3cxz1HD+JPxCIZBODi+m2e48Qd86lDJueHvS9pjPuvjuIbK2Wcvc3tvXRJ3jcOeGMVSnNF/ySWnh/CmFZVnRM6u3brNsNcD35qvRymWNF9fx57R8tBhCZHsJ+ZJYd4fGeMe5nAdfrLJq4wMtdQ9RDMvlfm2sJGgUDFQTw5jKAtVR4Q6gBbW1hFot5Co+4pxnEZcQG6WQoLJoJ7nysWdq2k54j4ApAmmG2GBzl0DJq4h5kmaT0nnx1iKJufWES0JQv3IGXu
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(86362001)(8936002)(4326008)(8676002)(66556008)(316002)(66476007)(6916009)(2906002)(66946007)(41300700001)(5660300002)(6486002)(26005)(83380400001)(38100700002)(478600001)(6512007)(7416002)(6666004)(36916002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uUO2e+PuMVg+XajQei876oeu9oFnaNl/lGX4XZs78GJPxiY28vzN1IMi4tqL?=
 =?us-ascii?Q?QgSpj6Cyz9p2VAcxghKeLa12KdaVGIURlxI12CbqK8ErwxjnuBaRTtdonZTs?=
 =?us-ascii?Q?YJqPRYkvKd8KjNNE01G4LRU+G+I4rLnIF0MxOTeZjJOfHUTOczB2IWxVqxx9?=
 =?us-ascii?Q?uu9Itof+8xcqUVkANzwEMd8TdUJKCWqdNGmbSx1EZQrgMfyZXPQqF2V7f3Av?=
 =?us-ascii?Q?YcAU/ZiOiPgSCvq9mcKaQpgv/a2z1KOwmHJPJai2aOBK32/g9CHbIeJJQQ1L?=
 =?us-ascii?Q?Dmz4m1LdkN+jJLPXnMbEukMOi/MDBQiOzmHqHPgeJRq2ypTgnXsrBFTF0szV?=
 =?us-ascii?Q?7yKpynzPCZqyvXA76vpNzTKXj/UdR/5MCl6SZp3MJhf5LkPrWvSxrjstla9v?=
 =?us-ascii?Q?aa70wIGtmNQkLqrRNajLULcqyeM6o6zrtQN11++lS/5SnKQmgBggwYZ5usBF?=
 =?us-ascii?Q?KeKD6hSUGZE/0jLHWHdGSHiTqxSLXuoYhiNntu+o+MQn3tjLb2wIhTTgyFaL?=
 =?us-ascii?Q?vTT3wkbk3XUj0HRSxb2T081CxpDRvo83pmJwkXddMpBThsX6oT/dFgkEeIrv?=
 =?us-ascii?Q?vRU9C96m2eRHn1P9hX7zgxyakRoyNOqkoSe4LdillwONW4aadiJS42h3HzHS?=
 =?us-ascii?Q?u0SPXZK/8QoIeyM0Mqam0I4PtUXu3yXu8HaX8gAqx/UTsoIQomIbTQT5ZwMf?=
 =?us-ascii?Q?ebLGNzM6fOsicf6scDDW0bJ1Lw3Bawh2PoFmrFCCzISXlLRiJc4yVtPP9RVZ?=
 =?us-ascii?Q?L00mrPpgUGFHP6JVqQqSLa2mXA6943XX+qpiLxtGNnq2ldANA9q+ENW9oSRF?=
 =?us-ascii?Q?VyhEwTVluYyDAK8Cznuwy1hCJhA9/FPY9pj4aK2PLa5c4+4tnWWTpdHTYG8O?=
 =?us-ascii?Q?p0oE20gO8z1C7dvL7HKt8rnrKGOy/R8T3lO26K83r9OP7cPYXdFH7oAPhWli?=
 =?us-ascii?Q?cHEj2Lvg9JLCY3IG5ei0OVKyyT7RrcR9uSVC9XgIqPQsBS9wgvQw9erjb4Fj?=
 =?us-ascii?Q?c+Oc0ac6S5ptpRPEMdGOedc4SShvNVZjP+LB4k4vN1xLqS6ue2KhFwNNmSv7?=
 =?us-ascii?Q?l0nyPcF5zhhBTi2d+b9kdAn7NmiHyAeNiZSKT1ocMYc0+wV0NZWWNlQR5i4U?=
 =?us-ascii?Q?nlcgEDoaEaMRz0pDj0BVT6qAmMN7qMh4QFA9+UBYVnLuU4yFpd+exaTpHlCO?=
 =?us-ascii?Q?L22j67P4MR+2bvcTPiqvYDAn70Mqa9Zjh12n8Tkuj1SSfGWQp5O0987OWOVx?=
 =?us-ascii?Q?2JStX3Q3PChjUhF0+KLRcvj/cj/gK1pdtvOk1ux+uLSukwVhuMvUdRELW/c+?=
 =?us-ascii?Q?PP02Phg+fce38k7b6TDKQyhJ621SUGa98d5b0wFqt2jEftoOYp4/9puekoU/?=
 =?us-ascii?Q?W6rSjrtJ5ElmvgdAukSYM3r3uBXbf8OIUFK36sH1Q09VgLEWwTdgbERW00vI?=
 =?us-ascii?Q?JzGNjrhm+7QLICRDob1Ig+dELsRFLbEkZFzcL+lckOZFuAbE5xNVWNNo6S6A?=
 =?us-ascii?Q?egSCOFDczjl0bVzjf0IXIMV+dIgXKYV2yd5ZnjuuN8hMx5irwgtKPaXvqmCd?=
 =?us-ascii?Q?8o7N6yXtc6ydDmXx4ovARuTnR3ibUm+Aie6uUJnu8QkUdx5Y0Y78Z8qKMg2b?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SRadv6rwHZXvKW2HfOnOC6tiYt2r8qCqg8+bZGR+qJhKQ9OvMO4jIon48U28dwGlQuno1GVIdaJXGJKcUIH4/TxWT8zEjsqQnPu46/MsPhiM+mX/3e2qGRl9bvKbwh+iXOamqm2kHstir1pYxNJx6871KZoUyAJI/oZXtvSco2EaQf30H/sqsrWnBbTzwZ69xCxagLlEx4iCf45ZtOr3EaBpBA2PKJIY/1l4BRvfED0/9/Ks+BOeAfvW+Du2e93pALcJUrb7q3ksYU4NjutvzmWYlqmUyEFtcOjImIn6ow/1S204/3d1cWzYHbG/r9CX0jxoBuvR5nNa0C2PLcPWXB2rhkG5reC9HUwTSDHGZ6TYQK3Jxg5fwpN0b4sfR2oXqfcqTJD5YzWZ1RS5lI7NLK5QiHCzJC+OB7S63yef7Z+4XLtq7IZ2j6XVdb33cl3GR3e1FLzdP6oTKru25vOjv6fr/K/SDBfYgfbtJOpoiUgFTGiQOCwt8UU4zFWtlm2yOT0TZpYt0Q/b/NsrRwHqBicUDQQawruXQeEwo0KHl187mJxcOW5j6WZa4ol73QMv3GnPFp5Kizfn4R/Ux6p4/zhH2VptxGLWdUg2CXggGU0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df26e42-bba5-4abb-995f-08dc111ab309
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 13:55:55.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZBMHHC2wS1lAT5kgZDii272L2m8y71YMrqx1xv9A1W0JyRkhKADllTBqZtD5lk+rOd2echNjRlzTY6sIjWjME8ECfjdUw0eN2wIgRr8WcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7269
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_06,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=463 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401090115
X-Proofpoint-ORIG-GUID: -WIBq6Hl-tCBDQgGX_39AGE-V7azU9P7
X-Proofpoint-GUID: -WIBq6Hl-tCBDQgGX_39AGE-V7azU9P7


Pavel,

> This is bad idea. This changes return value, but without fixing
> callers; there will be subtle bugs somewhere.

I'm not sure why this particular change was backported since it was part
of a larger cleanup of explicitly distinguishing between block layer
sectors and device-specific LBAs. This was done to fix devices using PI
with 4 KB blocks which would otherwise end up getting programmed with
the wrong reference tag value.

> At minimum, we need this:
>
> 87662a472a9d8980b26ba5803447df2c4981d467 scsi: iser: Use scsi_get_sector() instead of scsi_get_lba()

I agree this would be appropriate. Otherwise we'll print the error being
at the wrong sector in case of an error on a PI device with 4 KB blocks.
However, the message is purely informative.

> That will fix iser, but there's also:
>
> drivers/s390/scsi/zfcp_fsf.c:           io->ref_tag_value = scsi_get_lba(scsi_cmnd) & 0xFFFFFFFF;
> drivers/scsi/isci/request.c:            tc->ref_tag_seed_gen = scsi_get_lba(scmd) & 0xffffffff;
> drivers/scsi/isci/request.c:            tc->ref_tag_seed_verify = scsi_get_lba(scmd) & 0xffffffff;
> drivers/scsi/lpfc/lpfc_scsi.c:  lba = scsi_get_lba(sc);
> drivers/scsi/lpfc/lpfc_scsi.c:  reftag = (uint32_t)scsi_get_lba(sc); /* Truncate LBA */
> drivers/scsi/lpfc/lpfc_scsi.c:  reftag = (uint32_t)scsi_get_lba(sc); /* Truncate LBA */
> drivers/scsi/lpfc/lpfc_scsi.c:  reftag = (uint32_t)scsi_get_lba(sc); /* Truncate LBA */
> drivers/scsi/lpfc/lpfc_scsi.c:  reftag = (uint32_t)scsi_get_lba(sc); /* Truncate LBA */
> drivers/scsi/lpfc/lpfc_scsi.c:          start_ref_tag = (uint32_t)scsi_get_lba(cmd); /* Truncate LBA */
> drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long)scsi_get_lba(cmd),
> drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long)scsi_get_lba(cmd),
> drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long)scsi_get_lba(cmd),
> drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long long)scsi_get_lba(cmd),
> drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long long)scsi_get_lba(cmd),
> drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long long)scsi_get_lba(cmd),
> drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long long)scsi_get_lba(cmd),
> drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long long)scsi_get_lba(cmd),
> drivers/scsi/lpfc/lpfc_scsi.c:          failing_sector = scsi_get_lba(cmd);
> drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long long)scsi_get_lba(cmd),
> drivers/scsi/lpfc/lpfc_scsi.c:                                   (unsigned long long)scsi_get_lba(cmnd),
> drivers/scsi/lpfc/lpfc_scsi.c:                                   (unsigned long long)scsi_get_lba(cmnd),
> drivers/scsi/qla2xxx/qla_iocb.c:                    (0xffffffff & scsi_get_lba(cmd)));
> drivers/scsi/qla2xxx/qla_iocb.c:                    (0xffffffff & scsi_get_lba(cmd)));
> drivers/scsi/qla2xxx/qla_iocb.c:                    (0xffffffff & scsi_get_lba(cmd)));
> drivers/scsi/qla2xxx/qla_isr.c:     cmd->cmnd[0], (u64)scsi_get_lba(cmd), a_ref_tag, e_ref_tag,
> drivers/scsi/qla2xxx/qla_isr.c:         sector_t lba_s = scsi_get_lba(cmd);

Save for two cases in lpfc_queuecommand (which like the iser case will
print the wrong sector number on error) all these look OK to me. Note
that almost all callers of scsi_get_lba() actually intended to get the
protocol LBA as the name indicates and not the block layer sector
number.

-- 
Martin K. Petersen	Oracle Linux Engineering

