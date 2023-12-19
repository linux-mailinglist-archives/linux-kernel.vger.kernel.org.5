Return-Path: <linux-kernel+bounces-4570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D721817F6C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085AA283AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5203FDD;
	Tue, 19 Dec 2023 01:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dIoS2lCb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t6o91liP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BA315C3;
	Tue, 19 Dec 2023 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0Jvmo019051;
	Tue, 19 Dec 2023 01:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=gSSUFaIev6zQmRSEsoKzegK4pEJkGfpPRBSIembmyao=;
 b=dIoS2lCbgbkj4Zjdk749ABoGJ+SmxuqTc6HuRGLQ44z5S3Dzd0FRNo2IHUzUM3TBzPeQ
 +/h7OS8WEQV2VzYUYvnV58cUvgiHQka9lgqPiW2Sh2c+QBx+UyUUFb0iUYdfSpi0Z2ur
 vmgtRJDu+ngZZ+4DlUUK9HkBGiR/C05VPYpUV/GRJMVODKEFnFXweXsMEueloHoNKbQX
 +qg+G19OaFgeBJZDGlHcrd4ZvBBQC+cWDLUVDE4PmH2qbC51u4Fn+F66G6bXMW7wJVT9
 avtrazruu9WA3cIG79S8ch9cflTVlh0AkLLp5GUlyHFlgun5mejg4F4zdSsodbg8AAYi Yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13gucs62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 01:45:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ1VoAs027438;
	Tue, 19 Dec 2023 01:45:25 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bc4mgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 01:45:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BP9SVqa9WzRdDp+P3wf4xWHT3kN6JLPoAfuj1fZLZbz3+E7StYxLISexvDiCMJpVqvolOvU3w9ciQMLBzeZt54ZDuDgRRNxf7D7TVAvCwsnQeMG1T+oC7iQjRIyL47nWHHllaf7l4YjTMqRFl2MvPsgD6ZZZ7uS6mRy6qMe0E23o+3GwoEB+llqnLpc7mdyhgg4opXyCI/TaIxSYy4LBNdz1he29cHXcvH8Uka0ah24arrGnA1WHFEBdR84AvrXDd2qEgxZDeUHSH923WarGJg4GEpp+T2mmvA9BJvFjVrwq/Z5enjqe67C36tcO9Ghca7Euo5aJZQ0XjLC27yavfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSSUFaIev6zQmRSEsoKzegK4pEJkGfpPRBSIembmyao=;
 b=N6tHgMa4RRqt1RXe3xOpp5Pm1Gpy21PQzHOXdWyw4Qs+61aodlcxbvyDxp2LjMHILtzNCwW3zxARhLFGEiyAeju9aQr/UsuMorAb4fZZ9RPlJ5ob0g/Ma0ZQB1oOa0NGE1i7yeSwLCC8uPyzyM+/k/P1koIx7QE9TsfWJ217t2a4yRGsBO3vhJgqgKLNEZumv4aTjZq/TbHDNRZy+xfqg2oJaqoNeEI29tV7e8jPZhxjwjEnB1CZjrJN5fx1MY4bxivgRcieyUtzECEx4r/HZ0cWPE7Dc+jHbATstsukJvVLQosC8jYMxWQjF15lww0L2KOcyISXppetrlAN0+oD2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSSUFaIev6zQmRSEsoKzegK4pEJkGfpPRBSIembmyao=;
 b=t6o91liP7iDBru/HFViqqMJP4H1xdvCECXifqi8NT7h3jBnqgD8PPN8Wtlm4Rn7okz8Ec9nRPdXUU+VZzDGlzIazINoT3XCpa/rdXZN/8Ox6KBJheNe2LXqfuvTQn4p67/MTZJAHmwdKsfeFN5Y8IAmAbkZ9DWIEgFPFPjYNaJw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN4PR10MB5638.namprd10.prod.outlook.com (2603:10b6:806:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 01:45:23 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 01:45:23 +0000
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew
 Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH] scsi: ufs: qcom: Fix ESI vector mask
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wmtbc6dw.fsf@ca-mkp.ca.oracle.com>
References: <20231214125532.55109-1-manivannan.sadhasivam@linaro.org>
Date: Mon, 18 Dec 2023 20:45:21 -0500
In-Reply-To: <20231214125532.55109-1-manivannan.sadhasivam@linaro.org>
	(Manivannan Sadhasivam's message of "Thu, 14 Dec 2023 18:25:32 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SN4PR10MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: 70dbbdeb-3bcf-4b3f-d7de-08dc00342ad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	F0oVGaKR1boSfW9zvK7tlrESbWsUlLLbIZZ2+UyvvAPtYP/ZeO0iobUz6UIn5NWfmfNL8URvz80vNmdC5YBv1U+TYj4w6txvMwhvQFS3uf3lRwtAfoDuXb75ThF0/X9d8b+uLlIxXNKO8niZLrjqU8BBBzFSagkAwZb364Bb+1Gqvymjul8bss4sY9aBCZMq2hDuxCIakp6TTXssp9pKgjfSl5BYp+prfqhS2UW6K1Gu5vyz3uinK4zSZTtRL4sX1yAotX10WQolUXINYEf3WTN8/mQoZtwCUhGlws508BXYvX+JKdLJ4cH+wzxcoCtE/3/MpI+pdOAs/fRsZvjXuaPOeeGHBeVfuTmGZzU7RSAoHnErwBd6MST9A2F+nC/cCQhYRWUzT4cdkauCqPdkleP2//scbSn1VBdfMSNoJmfkH2qe/itywGZ1HWnju0U8KZrYWsCpjewsopXsRBBXKO1DZFFooT4QcawqvhIwzauMG6ZIo5iILa2rxjj3rNVhnOnlgTLP62E0m5jc17N7ON5Z9WqwZ5b9Y1l9vPkb7SHiljCoIHYLgEPdjYbW/N0n
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6512007)(26005)(38100700002)(4326008)(8676002)(8936002)(316002)(2906002)(5660300002)(6486002)(478600001)(6506007)(41300700001)(36916002)(6916009)(66476007)(66946007)(66556008)(558084003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VUNHJ2O/YONx0fhFrplYLhaIzWO7ckO5oyBRboPEMge12CixSO+yVgwJW+/G?=
 =?us-ascii?Q?pgxzgSF1iSty568IXVimUHE71bXT2YIMemsd7vFR4GkVLfSUoVj7V2wrnBzb?=
 =?us-ascii?Q?2D1mnBsusADX5bEnFeGzds7tGlo0nZ/c4W5fEXKfFlgGx5RZsLMM5Kpig6fe?=
 =?us-ascii?Q?JTkm+aXQbHuBP7gsPRHEV4d2TdY0B2f6xaiq7LwIIUModGjluKU3z3goelMv?=
 =?us-ascii?Q?6EJ38n91N9TRIuHQMf6moXY0fe9oPMgcL+GUcTzjcGUIVMpFGuiCtAx7T5BY?=
 =?us-ascii?Q?p9RLm7KvOcFFjORZw5f6ZHENOLLv2LHuz/83uLmIz8lNRvbAEDujDl+gwYBo?=
 =?us-ascii?Q?AOCrf1TEIrwBpArbE57Zr0jOR/ql8UdzLf0H0VC9mtOD//K7FnSIXJOsNiiF?=
 =?us-ascii?Q?fEQq5BJXTspQ+wbZovhnK4DLU08DXN4IYYn29e+kBtabBhvm64omYqH7KOgU?=
 =?us-ascii?Q?QbRj6//xD0SzTsNsBG/1x9x5B/Y1SoI3eqIx4j0HIn/T0ZfdfeVPwgXlG3fL?=
 =?us-ascii?Q?eWc83dmZ9/ZRcpraE3IXlWcDUFrGV9Q2IjfVZ4uZUIMhm45uOhCeTmnSv+Sv?=
 =?us-ascii?Q?bP7pZklrk0mvpk5pw5U+7yB1PenIXLeLxBjgDDeKH+61aI7h4fEJ+ggTrvbl?=
 =?us-ascii?Q?G8zdIPORGk7n4qnYqlGhac+dlg6VJXHOXpmlJA8kmUIUzq9vfEhWb7BNyJGX?=
 =?us-ascii?Q?luPsrlvRIkPaEnr3sH3aE4Iavm/1QXNVmbk3Io4e8C4L0uUsnl5v8Dkg5kih?=
 =?us-ascii?Q?Lb1uYdS1nbfgasueQlHQpzkjuFY3BO+ff6o/5wiFvONk9bAYajmOb6QmgEqs?=
 =?us-ascii?Q?hB5NOqcevy/p6ophOKMqyidRR89KG1FNpSTmcAjAtMxfoPrbWn54bpdGeXzH?=
 =?us-ascii?Q?6GSh7FuWNp4DUBsKUX9QAZodhIgZdPzwyVbZJawj8S8RMTP/h4e91JhOHMxo?=
 =?us-ascii?Q?VnEDsLz/TXRIW0z3d94hRKkxFq9/y3H3h1UADggvIVRnWEJ7uz++MsjVMbhn?=
 =?us-ascii?Q?2zvuSHKLTEQPLgwoqdNgxFrJJKxyGyQXq4KL7xfPdfyYknSoatJFJSLE+mim?=
 =?us-ascii?Q?mFccDP2kHyx9oxrOE7ZULB6bORz5lIPeQQtz0ZzCB8f6SYvQ087M3CqnStys?=
 =?us-ascii?Q?ArdWIFUNQArpJvVe6s+ORzhaPe3lAdwp5fd87DM7HS0O/kFgCiMrXEvClN4Z?=
 =?us-ascii?Q?6qo3P1VvivCAicfveSWQP9wvEN/sK6TRy180wpZZAhqXQ88ZNDD3t1Dl9ziC?=
 =?us-ascii?Q?lABH01yWBtKL0dBi8kGUlLVLx1mT5nnzN57QbaGoM1O/iGHbzazqYNT/jDUG?=
 =?us-ascii?Q?RPN53Zf/qQFU83PZBI6ZBFW1gmcbK9X+RBNkXk9NN1xFKNxMHB45Upc7Bi2E?=
 =?us-ascii?Q?oIM6Xe02dyjAd2FNqnc4JqijkjaAJWo6jJx8WlAj5GGIS8uUgh5U0kub7Ry0?=
 =?us-ascii?Q?CZo6Tz1tZ1OALq2Gi/en1zOQpapvpEp6ji49AAIAhqSp6vIGDIl85+Ibib1F?=
 =?us-ascii?Q?VQNT7TDkFaBk4azCgLVYyqvhBjwtfS2WX4RXFeBwxPNTsFXnE8KCdYRoZ7GN?=
 =?us-ascii?Q?uJcBCKDd5BTP44zH6YK1Sp9kHBezKoKjcDRYfQbh7IVRFL6o32vkm5r9Ikuz?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+jwXJ7Dk784d1zgzbUeWLOfkhhDGr0e9eTlzvYwYTem3Bqdbb7LKlmjpjJyThw+LXH+aYvuZPZoqVa39x1zJ+PACZO/J8VffjKcp4+iaPnFv7oF1q3WTgtFVMir9ZFIRzS5C5FlP7UL0Yxjhl2xxdWXyoEwPQG/+hAbdyZf+ZRJtg6bArGrfpMYJ98vCeqbbMuf0OhvVCuXzcgYWLKiP458PcTztXJfl+bZWL+to7wM/AZgM4Y/3ApXUgOJynZlyIAo1yAOY/aThiCfdedCHYDXlF2ARPog3uO59kN6VbWluubTMT7yWrUfsAiQrPpG8KtGlH+A2bCofCgvNUykctUbzBrDNFeuti8rwtQXwToUSUdVvaA+39fRatLgBMXJtGgIV33VFSMqa+O7ChegJot9mRrC1gBLLv5PcJj3eejxkpFIEhP1C0ZZPR779bSz962RJ8q3dppFDebR25nnu0K3mgguf+8MaJbv9HfXoWA7GL5eFI4ZnpFwNEHyYtm4tsVfY/hSf0XtcVW14ZEIYZLSAQGZ9SqTgdLSwr8j1PW7uqoKsojyXs0vyEv6EdvLP50csTq+Nz45qxnTWJK2nafgcSf3t9Ex4j9eful9MTpM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dbbdeb-3bcf-4b3f-d7de-08dc00342ad0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 01:45:23.7443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53hHymF6SxlaU3JSZ0p/sHfJBq3OFmqLl2Lc/UnCdjyacTd06H/7IgiU6QsblH64+5tDhqLeNx19prQn0WaGLzrhL/MN8vPjM7F1Y5vpOas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_15,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=811 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190012
X-Proofpoint-ORIG-GUID: b3_OlRB_vc57OwqBGlw7bpkNya_u9uol
X-Proofpoint-GUID: b3_OlRB_vc57OwqBGlw7bpkNya_u9uol


Manivannan,

> While cleaning up the code to use ufshcd_rmwl() helper, the ESI vector mask
> was changed incorrectly. Fix it and also define a proper macro for the
> value together with FIELD_PREP().

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

