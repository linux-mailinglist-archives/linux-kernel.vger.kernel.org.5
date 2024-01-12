Return-Path: <linux-kernel+bounces-24232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0815A82B97F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7134D1F24D01
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DCA17EB;
	Fri, 12 Jan 2024 02:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i2Tl3jV1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="udFmMgVr"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C80C1841;
	Fri, 12 Jan 2024 02:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BNXaNB019265;
	Fri, 12 Jan 2024 02:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=wbrD2L8gqYNbQm8UZZ/O+mg8zt0dipJbj4FIuJFF+o4=;
 b=i2Tl3jV1eR4zRvgFC0Uf5iVERgG3vmfcDKH2IvEWeiUzv8wHqYvV6C8HfH1F4GXUDICz
 VP6I8yBHxqn27fQQcVFhGVyRfWs1IFrFBAnzWV/Vda6XMonG1GqsspTWS2QRZN/4+fbb
 iLNuyMq3F4QkNjGfghGU2jVVNjQpZ4gQaGCzvPk8cHQqqaBgAnO6etbOi2IafdMPib0Z
 1t5fvLkzzpVkyZ9edBlxeK7QG45EhXGejOTP/zY8n3Zae6S1d7utmlUrQmZPgy34y8Ym
 Ci4/wHKF9kiPhSQMJpDX5vAEQWrAmGJs0rhu6Jbo5yArY2Ji0Z14is/gO5wuMXm+q+at Jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjq0xrnus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 02:27:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40BNx6oR013671;
	Fri, 12 Jan 2024 02:27:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfurfmcas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 02:27:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqMBz3byS/DqQ3Ibsyi2tr40PIkv9685GAkmT0btK1j2hFdRdmPI5vr7x4o8bMO4tp+KikkVTWWubIhuTSDXCua11l/cLXceiOupiISq+1UPJstier0cWaWEHWOj2CvAKzpKeYidNhFS85z8fLbd/y9x0VlYkZwdUJa1nePvYGUDBfa/c5lPw6xvIJwAlFmukAt8YRFqnVq6S1EUjPtmeMa4XicFHL3hbM1QNOmjY+DLyR2iGAP40gismv/bw3c9lYFb0opeDq+hImIHONxgcThEfVx3fLqFyAgVnpQCk7bADCqsovqCX8Wv3KWrG4bpaNAjGOjKAkpZJo/8mul2ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbrD2L8gqYNbQm8UZZ/O+mg8zt0dipJbj4FIuJFF+o4=;
 b=fIUxIZ9BbbXNiA3x9xrxFOKdcb2kTHvT3ER58wu69V5WKll9R56X1HclQYwQvfgjutJ3z9Yf80a3Yt0ZLsAAq4XXEYxmJb7XzBM2vJHQuj2NdTPJhHhpvfVjtyFSATiFJoCRW9VrcS5o1RY3Wp+OXnUbMRzj0wyABbTjGOtzNYEud8+Nau4rt1gYhed2JfjBJ6D8zLyhZVbjKTfdOOGea97gFgoQekaMyo8VMlX1vJfuszttvrwyQOGJE3o3Q6GlMorCKVipRoUMno3FVTcKXyPqT+RQe+ZiPmWmww1AfgMr/a4oaI+NwSb9Y1bHSGIrXsSIwC4vmKTf3J2PIt04Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbrD2L8gqYNbQm8UZZ/O+mg8zt0dipJbj4FIuJFF+o4=;
 b=udFmMgVrkrgLnfDLijuk05RGe4NbV3+iAebCyDCpuxktCQWqwN9V718WvjxrydkTAeQDoAwAu9ZQyeePAfBBwPowx7ag/H6XyVpBQSLHrwZYaG7zbWmHD4jZmpF4vFRCRWvSjviB2+NLesHLMY7PBLbbs9GugpfPYu4kUrgKbuI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA0PR10MB7641.namprd10.prod.outlook.com (2603:10b6:208:484::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Fri, 12 Jan
 2024 02:27:26 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%4]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 02:27:26 +0000
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley"
 <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook
 <keescook@chromium.org>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH] scsi: fcoe: Fix unsigned comparison with zero in
 store_ctlr_mode()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1cyu75lss.fsf@ca-mkp.ca.oracle.com>
References: <20240102085245.600570-1-harshit.m.mogalapalli@oracle.com>
Date: Thu, 11 Jan 2024 21:27:24 -0500
In-Reply-To: <20240102085245.600570-1-harshit.m.mogalapalli@oracle.com>
	(Harshit Mogalapalli's message of "Tue, 2 Jan 2024 00:52:45 -0800")
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:254::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA0PR10MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a56f4b-b25a-4ab4-1fe9-08dc1316045f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iT2SBabZr2PYrvR65y9FXCLOsoo5kUTwDyKQYBf8kEbsUymE6+tnAcY80cPu1XKrM1XcN87F9auu81Evnfe5z9wpa8p7I+5PzHp6BqKPxGH0j+8OnKEJfMu+9CIUDeniRWwMcS+m2vRgck9IYuzm4ME4eM6jM31Wza2/cNl8B/ApNemJE6RzsjZCCxaWHlW9YFbEI9/3YHfSNs1LIYagc6pVb3agrsC29plZgcBt+58zeQUNnBPZ7AxPP2NsfQeMNpXxXKctdJHFnWKucUC0LiR4IFEeAQQ+EDFLAD9BRa/PBI4UKxwIcfMn+pjFOLtKJ6OfHS04pteO+Xf3fW1lrXzRFU7ViLJCObXqXoq7nIr2TEKukLzecJnh3UyROr51QKu90KjWkbYtey9EFirIkrlsSur+qpauQ+8/lNC10ivznaGOA/riahO2eEXSZDyAMLJpoKYsNZjKzf1cvbClVEqBdjX3InH2zDwLSc9NLd2hC6eiHLpFBAPAX1TLAApYoW731T5jELxVUdBKmC2vM5AZYoxxAjVwZv9Ijeg0tND9F0dkKaN9bFtsh8ktP74E
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(6506007)(6512007)(66556008)(5660300002)(38100700002)(8676002)(6862004)(8936002)(2906002)(478600001)(66476007)(6636002)(6486002)(54906003)(36916002)(4326008)(316002)(41300700001)(86362001)(558084003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gniT8lTMhYZTWCEgrw7E4CjE2W5QV/+wVF9hygeczcuhan2Pr4SlbKptbqu1?=
 =?us-ascii?Q?KEblJjXVl4Jre6YhA6MDUX7vLBVQRVV4bfT8CnPnZmaf0IGguVLEM0RinfuS?=
 =?us-ascii?Q?fVi3xstVBiM/6zePwdq0shDDAJ3RSlO3UVuBwGzERFAcWT7yYyiOlFCX8WjB?=
 =?us-ascii?Q?yRe2mxojNfkL5imjd4F9Zo6/clgVLHgEmY/Jq5p21UIkubnvNrw0A3peqBG1?=
 =?us-ascii?Q?uOBjMSUcocyWGtrKBNzoiL3mdUR06EcnGK49ZEDDRq0lSlvUPEFiIKPlj3J9?=
 =?us-ascii?Q?r+bN1q2YUy3jOoz+PbQ07TBixDehREQLR12mzWp4c3ng/loqFwxHafGqk+DI?=
 =?us-ascii?Q?QbJb491edUT/D6efpxu8dCPv9TxLkAZ0eYoXIBtYZ17EFf8XmKr9+D6FF8YN?=
 =?us-ascii?Q?+KTQG/wdmOkg/DmxbkSZbkzzM1fXkiSrIIWuHwCGUlRlP8ggJnIMoC+u4IZV?=
 =?us-ascii?Q?Sz1Vl/IWsX7XuVmU79dURSgRjRy+KFIJckOnPtaqcSP1oZrhWyH9j/XQW2M9?=
 =?us-ascii?Q?z8dAion61ccqm2bTjkbYRFFKabfS2zkTQCFPqo1KrJgfPchciXBgNvHIA+oM?=
 =?us-ascii?Q?41PYNr0l3Ni0pzQLdlxB5j38FpSnC4JJOSGy4k5kVxNq1MMPpX+68uZWmgjn?=
 =?us-ascii?Q?VFjjQk7wKQR77ni6Wd5PlrKdNAGkPi1cHDJ9H3u/UCADCBhTkiZ8jwbE3E5c?=
 =?us-ascii?Q?BauyYnRfYCZ7q1tnU1sTWLvXiRWoCtqOrZe9wO2EM8DI8geFCGOwwVJ63MOI?=
 =?us-ascii?Q?WvcbkBXluBSxgaPU2tvnh9EJIU8L8OsxM1x8vnWMqjC658M1Ktk+F0WGB9Sp?=
 =?us-ascii?Q?er9JW5+xnXIkk4ZSNiX/pVmyX7AC9uk4l2vHa3Hiuq85DsYqDWm0iRujy46n?=
 =?us-ascii?Q?d3YDXki9pqsxhj+TDdlw1HM6y0vyGJF1I8tSPAgI/0cega63r97dgrcWGAQp?=
 =?us-ascii?Q?uOwAf8QAqxvXP5SXdj28g8roZVNCn6qmyWKcxqkZeDP8tr5ME9sM6NthFXkt?=
 =?us-ascii?Q?m8ucnoff4ltl0DszGj0T+f+M0s4xundAF8LKJCnjcCnp7BZr4gty5EXfseJC?=
 =?us-ascii?Q?KTU9MB404DON/BY0eXZyk/ahkbjGl2/XzqVNYp0bFoWzwrPcdsdNJdzT4jxg?=
 =?us-ascii?Q?Zq0EYtKez0U/ZfXrGUfGvWoTzqPeH5VnT/uwZf4+726zJjjwycDVDwR75sYK?=
 =?us-ascii?Q?oZgVUJ+kNyigvzWp33EDx0V0c4WsoTivt79Xst6e8hUjKz6K36Mf4l/kAuqV?=
 =?us-ascii?Q?rYJ2f5esJ3l39B1NV705ljOppQCciNeQ6wFg82yW0IRCP47u0+DtwurcsmMx?=
 =?us-ascii?Q?CeUFis2GXeYFL5vx4hEx2sIJ9F4PNa6zropGgtrZGUNcxDQT/aPBeYqWIy73?=
 =?us-ascii?Q?ub7nYPL/439qeXdG2kLvb4dNyRC1w889fTSU21sLkzyOM98T/sgYK1EL1AGb?=
 =?us-ascii?Q?VqEa1VebKnzFBXT35Xvh+NaLs2hT3ZcPTorQI44GITAMSd86M74IqYW9o7kt?=
 =?us-ascii?Q?HifeY1XxRDj7I2OxuGFhJ+7M4Fq+4tsXbsONxovxevoJkp4CeGXzr5fZ/aBm?=
 =?us-ascii?Q?YIW4ywz7zZrlSwrdwXxKY+I6WzKqwBpJIHhKyomMV66yG7xwIxQp9emDkvQA?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gusL5YWIPrN6wCLP6dB+BnHxdYylt1zQ73BTXCSaKp4RUba+AwV1biz7G7KYw/jrjZmXGq9Fl3cpDqNI2SkQh36Czd7BSHdoVvrv9AQi74kStzMIse5e9tkSiTKKJJsfUS9FrH/4KYurnC1VKRawMl0/f3sDSxo231PJ1CodZ1bdhvLFTm4I9Pgop/Ki76wxXiXkx2L3vIPtiOVnRdFwD/P4FrZ4RMv67Za7Shf5rTLneTNUueNdlrjqP41N1r+EM34ytthhuJ1Ou0oKfU95t3K0pQbR9HDgjwgd6RxhbiXPbcN8GBE4MkPAkBGfd4xmCExYRvY9yQxuVWTyYSS7gphpODk12mIX2xwVkER9P+iHFZlfedibKbpW7ayK7/KnX/+zzjI0v4QD8I2XIybjdHYj5kiNFAlT8IAEMq7O8/16WwYj6aTqOGEJ/yNqbzhPQyT+uQwzlc8FmwnMzUlgG4+tqICyeddguvHIpbjHvpp7cXd/J4TUX0JffzzF61Y1u2G3k9zQskNtPcO5ujt9L7YDAuxClbYxzsgKR7ZgN1Tam4PHqsdPyudFoq4JMsHgFOJvf2EMpOgV/EeLCqtM8jX0COayXKEcaBS2eaB2IAw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a56f4b-b25a-4ab4-1fe9-08dc1316045f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 02:27:26.4375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MAlF/2ijGC4zSgnbLl7CRMMuRpFRWQKpjCz+V1Zp02ncschNxecfoay5DvcnWTt7UKvEcAFFJyIrtiX+8RnSh8Ylrcb93nz4nT8OXr2E9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_15,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=677 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401120015
X-Proofpoint-GUID: H02pjjMoJ7a42be1zUR92CEybUiffgww
X-Proofpoint-ORIG-GUID: H02pjjMoJ7a42be1zUR92CEybUiffgww


Harshit,

> ctlr->mode is of unsigned type, it is never less than zero.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

