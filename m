Return-Path: <linux-kernel+bounces-26611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 398E082E426
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B21028312B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9411B7F2;
	Tue, 16 Jan 2024 00:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h8SoyRYF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MSFfVkuB"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB0C1B7ED
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 23:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40FEa10m017868;
	Mon, 15 Jan 2024 23:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=4Y8+dFgwdDhzSqU+2cYq5HuCn/W13Y0WsozMxJf9HLA=;
 b=h8SoyRYFHfRuCCEWfgG25WBmKEfs6BRsDIAqtZDKiFrDQ+/zmXNb1CHVddNbbTMfsHys
 2ViW6CsYzSGqKH5A9yy6ND21Ci82yej+yCgjWTEUdS1bof0NzsSWfP+lNimwdSb3+xtH
 LhpFz2HEG+ZABJy1fO/rsfLIUP2nzyRDrd1WhCnZDNI+VEPACAM47Ha8FXKkQdHoZoJa
 HvJWAnA9i9PrORIIdrd0llz9R4sMWg/Uxy4QRu3LsNV2a8VCIMK9xxYBke+wRTOKOr3I
 o8D2Mx6Wr8KRNp1T/bEaHD/njj15m9r4uV9xBGkgpida2ppP2MBSvM0rLELsSnMKZhV9 CA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkk2u39ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 23:59:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40FNcuxp005167;
	Mon, 15 Jan 2024 23:59:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgycut2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 23:59:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9JqthqJy0LGirIuhzMIt6Dp4TyagVnmcDkixwyDpGt8xlFI7Kbvwn6Uj5fMOrhop9xTeSJvFuy1mkodaICIeEMu+jjpBCIyOhYCXpXN4c99sFsoZyCxk1vQxO9KPDftgXaOIsX2b2Ta8Bc8bpkFZ5z+vntCvxciBIYUi0+mrTmYt8+I8tLcGXv9MZnn4oCEFQydrrPYNG08obte+u4iMUVMQZWhOUiT+LKCsju8PgUlbA3qMYWj/kIroneP26G4qh7uD8REu/p67wDRHiWk7wRLARvAdSUGjUOk68+I6+N8m4axE3Jc5aUV7l6YQmV1Q+UbJ7PW4facUpQF6ut7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Y8+dFgwdDhzSqU+2cYq5HuCn/W13Y0WsozMxJf9HLA=;
 b=gyvOB5SnM/g3Vf4TBQNz7a6TMAtobrBJsSNHj2eMzQaZaQIAoHdVxfuGitO/s1N4/ZK9LnB0ATMVXcvgqOrgbe+I/guKKGUQKTAMjtEidO7OiCFpXW6ijT57JxMfnp5czpCjHnIHUx0wTF/Db9Ub1PM9KCe1PmlC6uZ6OiDdgucDGFF4NSzNt2eoarhNp36fm+X4tMW0YZZ90bVzj5J/aGRrltK3dNcQA2he3jJIeEao3ZLtCAGTMPbGUAU0mnBgY4qPB9E0OcBOkswjWGUCKcbAeOz356+PlO9ZR/J5AFpRGNFlka7dVowQnzvXfNeQWjox7GqNDBjaul8EWtkH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Y8+dFgwdDhzSqU+2cYq5HuCn/W13Y0WsozMxJf9HLA=;
 b=MSFfVkuBbhjFA5076YLHcZ0zYIa206MRdVPzbjWKG4Wzb3RtkHWGDXy6cwxpTBuVKr07D0Kgvdmg6Jw7D70p/bvfW02nwkVVbSKZVz388hnoeULOrKh2kgokGoZ5YpmuMp5eYbcv6xBf1eOKbbiAnGl2XRk9WjbCdOR7mh/BZgw=
Received: from CO1PR10MB4418.namprd10.prod.outlook.com (2603:10b6:303:94::9)
 by DM4PR10MB5966.namprd10.prod.outlook.com (2603:10b6:8:b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 23:59:15 +0000
Received: from CO1PR10MB4418.namprd10.prod.outlook.com
 ([fe80::bcc5:bbae:8d5e:9b56]) by CO1PR10MB4418.namprd10.prod.outlook.com
 ([fe80::bcc5:bbae:8d5e:9b56%4]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 23:59:14 +0000
From: Eric Mackay <eric.mackay@oracle.com>
To: cl@linux.com
Cc: linux@armlinux.org.uk, Jonathan.Cameron@Huawei.com, Matteo.Carlini@arm.com,
        Valentin.Schneider@arm.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, robin.murphy@arm.com,
        vanshikonda@os.amperecomputing.com, yang@os.amperecomputing.com
Subject: Re: [PATCH] ARM64: Dynamically allocate cpumasks and increase supported CPUs to 512
Date: Mon, 15 Jan 2024 15:59:11 -0800
Message-Id: <20240115235911.80586-1-eric.mackay@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <794a1211-630b-3ee5-55a3-c06f10df1490@linux.com>
References: <794a1211-630b-3ee5-55a3-c06f10df1490@linux.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:208:239::27) To CO1PR10MB4418.namprd10.prod.outlook.com
 (2603:10b6:303:94::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4418:EE_|DM4PR10MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 499943e4-a1d9-47e9-4ba0-08dc1625fa44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XfJjf/G4F6yAu04EGzjPN1s2rd9kXhAU6B0OkC0cbQ5oUJQAM7jey92NLQeZv/qBOFzq9q6YAN/1QQsWRrFQB3g+UinO3ozgjFPU0VsB6zgGaF0RUtdi38zrMPlYC8FtLW5NiP83zYAFxD+laGghNFt2i7KQivv9IDaV69mM+PNjQL1+Szp8rNDoPoEHDxGMMjhwkyxULEhxwnMeK4s+5XLmvalD0bh9DM7cQHBfwPltr5wgJNrUhw89jUW3F/E9sjy0ICF/MNI12O7xT1eOgHYqvZaDW9lcoQRcVtYAZUvETUtnDohrIfgBGRK0y5AVFwgIYwBwQ7ij9pOh4etDXPrM9wubo2ga4BGnmu5S4TOt6qToWuxeaKJ9TXKU3bd9r75Sj1hlUeNSzae0LuqsG2RbCNSuEuhjqqOXq3QZBf3EGRx/tkcUtjQHI0c+KWCWBKdAYv8ruy3Jgw2mK6YHS28vjzgXZ+LTeyCEBTB3B3UJrsCTbfJg4XIFO/NXjHsRivkLJhNJdQ3g/II/Dy5m2i3BU7Ti/bBcl9HUOa/Tv9/JWRRfyK2dksiWeB2KP5Zf
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4418.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(346002)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(1076003)(26005)(6506007)(6512007)(6666004)(5660300002)(7416002)(83380400001)(44832011)(4326008)(41300700001)(2906002)(8936002)(4744005)(8676002)(6486002)(478600001)(316002)(6916009)(66556008)(66476007)(66946007)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GRJDycc7E56XQX+y55P3KR4Xh+gDxgUU+CixhVUhU3tItSIOAmvt0SK8+N2e?=
 =?us-ascii?Q?Jkj8rX9QITLQCXs1pFSLyyLMOEgK61z73gHFq/m+WXZxKmKPG8k3iNKeadLz?=
 =?us-ascii?Q?89nTIxx3Tl9ZN0p+78E6O+l8KejiIRQAj95IILPsBOf7YPjIYSI0tTfwG/qM?=
 =?us-ascii?Q?kTxdk1Tl6wiAg8MahlW6Oxa+WYBMJVogWISJ+0FFG9YOw+3L78dOmhGdn1lw?=
 =?us-ascii?Q?LWDznhFnUlfyi7+xu9q823E1Mzh5faI8XTD1kgqbP5VZplfmp7R35UmcZ1Qu?=
 =?us-ascii?Q?RE8cCHXSGAkVOP/mNui/AfHHjp79D1kRsR3DK3+IAYo4dsgEb8pj5bWCvoCm?=
 =?us-ascii?Q?7A04lOKGe1XdiZEnE5msnihW+hFOuVLiexuP0zMWrQ+OGUR+YcJRNAn3MZXf?=
 =?us-ascii?Q?SpJzu3/d75EfpGaBgaxkL679ZxJWZP0C2VBddf1p2R4QDL3B/0KvBNZV90JT?=
 =?us-ascii?Q?dwy7cZL2tFR4wnkVR4NVf0G9dAPRxbyYrk82oWire5IFWALXNO3F5eEmCQc5?=
 =?us-ascii?Q?dpECjNGDqHwohvmrvXuJeYH4PEYs1gNEi/QD4Lxyagio9KNBRF/h1HEfLUUH?=
 =?us-ascii?Q?fTQ9peoj6V/RJ6JcDJNUw7nheousN3RgNWxm5SXOvg26dD4kxHzE53pLfDa4?=
 =?us-ascii?Q?+XovSyPR7eW69qwCY+xJvFqXpneFcEbUvnYDMQqglWCXPFzlynXofr3x8y5O?=
 =?us-ascii?Q?C4wOrZXBQiNX+f2+hwxFGe42CVBJGVHS2y0iVKCWE49CGxHYjYgpIl9bJ0I0?=
 =?us-ascii?Q?ZKMoPxQN2NYNr9bkOi9r1FwrGhM+rKMsugDFMhGpCOSF1nNciSdZCsDa55X4?=
 =?us-ascii?Q?h4840JfAVZ2zHwykUsISX/bfqiD3pX7SC8d/KoYO+5IMmBc0jVLB7GhB9bnv?=
 =?us-ascii?Q?qznIByTj2V1aZxsLgTAT1pTQ4dZ0vpt+SdCq8xBrtwYA8aokmO6cJC8anIo0?=
 =?us-ascii?Q?uZe3HNfTzrBPao1YOk5p28NGeG+iCkJLP7qObubsHYd8gGpipzxgp15FeszP?=
 =?us-ascii?Q?+ebGP4OU0kt7yq1VXKIXhnhK0DjuvpY9Oi8LDCjapxyQpY4+wQVPgp2yLiT2?=
 =?us-ascii?Q?TmykLmDMew2vUJpNUhEbgjCACN9s2rCY132FobdZ9ZuDPbuli3yxgHw3nhTq?=
 =?us-ascii?Q?cCEb51V0+cT1SX+R5gRKjw8ZlDr8WNSdnoS3dXz0omhKrog8U8k9l+NSEtKK?=
 =?us-ascii?Q?/aLE5GYLZP853XPnj84pmZtPm2qqXe8a6KbsVesZ7bJeftuq9J4irTLyzb4a?=
 =?us-ascii?Q?MAffVKKPF87r+KZzA3CkFm4Pz2l7PPLid3TsV7rHEYM3Xoq/zcczO1sl44j3?=
 =?us-ascii?Q?g4fngwq4bNUSm5Hw9jhTYYo3Qvl5n5RCESGMSBmXye9gb1Wkzgz1pcbtVxU5?=
 =?us-ascii?Q?NPDrpE+c9IhOAZsmrD4QXiq7JMMF7Kgvv52F5RuUXJvlzGZ79YbIMYEyD/Yp?=
 =?us-ascii?Q?BNzqhYIVR2mGm29PjVFdpCugGkFW5p+YxytLgMDgOd03ZNp6mPeGhUmERVkA?=
 =?us-ascii?Q?5dlxYH1HH06OFnQevfBt+gzRElsYMF8gPmMzPehYJGFJot60I1XX/pJUVLv/?=
 =?us-ascii?Q?lwIBiPeAqDYILdVNT8P+TbJvps2MvxvmBU7HPiRjD2/7FXYlzb4jMuUHZWN1?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ih3guDj0hruVSXg5Iyc/0/X3DzP2Ham0r8F1WZTKP3BDCcR+y9PwThwy8tf/s0RzD0j4wrlh3U7MLmxQYYnYzVPW/F3SMXkIBx5eNEQNTTGLLvllwBiwZut++it2ETaGY8wAyKo0oS6q27Gb79WmFYieKsIeE6piC0X/c2uojUZpQDL6+hRs2rVYphV0kxs9ME8f8eXzqKgpT+sDabISpbttHULO528ftZXSeNo0/BtVZILmuw0+7RH0st1dU4sshFdW45FPsrkK6DbTdYTa100Eh+tXMVh5uZkdkq7JviEFknrtnSe8+/MQpk5Yg0DRNoLEMrB2dPfNMPA8U32c+CcI+KYjcNUAtdQGpZcgc3TV7yAb5JpAzCEyTSkOqoLUGiZFlU5L8p7MYkCmz8MTy+nOFxSfseB+SZMJ5QEO2fA+D0IowV/fyBVrXvRrm+F9wloWJejzZoMpbhXd0aa+6r+LciqfHQi/hDpv57LB/4Ak4OYxKA19JrVOScVoGk6nBRHMP9tjR1yTh1OPq0QOKNjbWW656A52+Jehz5tpYGOPU72Vwd0WhbKbgeh/oJIRFK+ndUow14P0FNY+Xxy0MYZEMCuj8Sf7X+rOvWCnai4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499943e4-a1d9-47e9-4ba0-08dc1625fa44
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4418.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 23:59:14.9007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omUphZ8P7PNLvKcM0HAExkXqmAOoYFRMSsayoPO/X33Wia5fI5LPzPP02fXu3wqD3cJVxWYw6MhGGiow4rJzew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_17,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401150179
X-Proofpoint-ORIG-GUID: rO7_UyixFxAsGCg8yBEwwIMRBqh3orUA
X-Proofpoint-GUID: rO7_UyixFxAsGCg8yBEwwIMRBqh3orUA

Whitespace issues aside, I have applied the patch on top of kernel 6.1.55 and tested on both a dual-socket Ampere Altra machine with < 256 CPUs, and a dual-socket AmpereOne machine with > 256 CPUs. Works as expected, with all CPUs visible and functional.

>   config NR_CPUS
>   	int "Maximum number of CPUs (2-4096)"
>   	range 2 4096
> - 	default "256"
> + 	default 512

Nit: the new default value should be in quotation marks, if we want to be pedantic

Tested-by: Eric Mackay <eric.mackay@oracle.com>

