Return-Path: <linux-kernel+bounces-110072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467FF8859A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B744D2827B6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FF484A4A;
	Thu, 21 Mar 2024 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="lC0zz9I5"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D89E84A2C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026529; cv=fail; b=WpUZS5R5HOh55sC+DgO5laWXfibbXw3PUCgxygS9rb4gaeNbwfijhNa6KipkB6D6BsSp2FHlJ3lhWVzZgmYC8wDYfo1IJJcj0/RQogX+r8krhFr62+dTQBKmpAWni3muzzwCcW8W5ejhJMghOdwjCR3McwRK63dH8M3qlJehfo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026529; c=relaxed/simple;
	bh=dLcEcDtj53+NNrH34WPraAjd6UBsG4Ktx7SvbdwuAv0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j3+WaLQjufpp9f/vjxfvt6b5k3N3E//eL6mq4FjGAjtVZdmJ4ZX9NzHlW4W5Mj9pQZfQpLPMdz0pf43f0XMAzh+thx/EFpGroflAmi69IuHZFysq6vito1+W0LS7L59V5EF9OOpAotwEgNu5n/6sSUfUlytTUtUl0QTp/qg/MSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=lC0zz9I5; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L6omad000532;
	Thu, 21 Mar 2024 12:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=rOCowNz8cBqADztTcjL/Zxd57OetXnTY7MO1ZT7fxH8=; b=
	lC0zz9I5n1+fUiCx3AeFqInNvGw71XSLFUbpTWBPsVaFQ5Ns+mPPozghAszJdY0M
	ppAeKfWca9DEEPJuwxUD/RkvL52z06mwLvSA8798JS6TwaXmZKomcp/TxQ1M2qup
	t2MiFo3m6RrCNjLAvUkYCmJW6x3huUoGV3upMgEsGA3z6d1LYZayD76cgTBs+Hm3
	9ueGGy7Su8QjAgOl+zCR5LUOrv8t6cdc7IZL9BOSGW9a2D3RauiQpVIBgqVmjOqT
	f4C6Lh+Pgc5MnIini0KMr5KPGIMG18YyKEVmoNW5RVv2eNcuOrsYFQ8AFcqXP5V4
	Pd0Ie5ZQUUinqVTC2euzAQ==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ww2d6n0vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 12:20:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTBBzoonyHC1mileI0AVW2dkJtCi8EI0LWdIbUEFp6+/CUJ7lrDbIGaDK3m5Bb71zpgRA+tqzKfRC/yzfr+eMidMJImiWFn2U4SCJQl+SDvwUpSNdN4+4FMALbemFTBlKEC34HZMvkMWxhPQYdlsvOQZDZZYgs5XJKAf7OZNjMGxFPreOQKIPZSQRPrQiwXu9g0S0AOECLQhGc/vmCCrSlT1Y1EnT1NdERSqvv2cCphDodPSDNc6rcvMiSeG08iejQWmDRr7foHSN7sOn/oa7ILEpGtUKxW00twjmZV7ifIm9RuHSLKt91tPaIkrYsYBy498QU4+CbMhgCLJYGIIDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOCowNz8cBqADztTcjL/Zxd57OetXnTY7MO1ZT7fxH8=;
 b=BIaI31n3Hka1Yvw9vXXEFMLiYCg0G3QPvxBO2rqRbDpsYwB4IbB5RZTvjrMM0IaJMm6OFBFvZNbaAaZlJuWKCxfNwiM/OO+UltP7Yj9TPtaLrQD8lHmsKbJZtkwsewoq5jYOTr9wVqs6Oc6MHvH0Eb9WNWa3rMVUIleQHXj9sYYoQd3XQpRXCoSJaqfs4xQ0eXPlLjT7U/Lc/ir+VMqH5Nye0JReiJCZFm2sBmo9okxqP2rU2TiAHD6EJ3L3lNvK5zf81nh/Ji4YtozLM5pXZubbP/cXjL4jdiQxnD0vGmkUjSiyP9oaNVmTrXrcVWkpSDGIctmwhza3KetR/j6tjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Thu, 21 Mar
 2024 12:20:42 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::8cb4:86ac:461a:d683]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::8cb4:86ac:461a:d683%4]) with mapi id 15.20.7409.022; Thu, 21 Mar 2024
 12:20:39 +0000
From: "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>, "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com"
	<rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz"
	<vbabka@suse.cz>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "xiujianfeng@huawei.com"
	<xiujianfeng@huawei.com>
Subject: RE: [PATCH -next] mm/slub: remove dummy slabinfo functions
Thread-Topic: [PATCH -next] mm/slub: remove dummy slabinfo functions
Thread-Index: AQHae2zR49nd4JIODEC+LaQAnyvx1LFCHC3A
Date: Thu, 21 Mar 2024 12:20:39 +0000
Message-ID: 
 <PH0PR11MB51924AC8A58ABB22B8015296EC322@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20240321084415.265643-1-xiujianfeng@huaweicloud.com>
In-Reply-To: <20240321084415.265643-1-xiujianfeng@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|DS0PR11MB7458:EE_
x-ms-office365-filtering-correlation-id: 0c87ae28-2f0d-4b7b-742c-08dc49a151f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4kzCHz733bldCHTkSX6buTs0PIkl21zxOnoPRC53c+6rBG1WFBqZydGw7HZI/Sp31c+Gd9uvnmdWgUXBLbSaPsMVTneoacNavxF5BptMgsT4iaEtjrEClFuiMsA0o8Ln0faynEFqnwpj7FwP6MdEHim0BXIByetT5evne7wgtZWjG7OeWpGUwCS/bAwTNLd1KteIGTRnRGo4X5WicOVKZrUR4w6CVi2AQiX/weXNl+9sm0cqnU4M5uHMylTFuwMu0jghzJuMHCNlQK3VHVPJhye/oaoAaPJdjVNrYKFRINNhYRzFgVBfwXBkO8N5kIb11lTF4b38NHRAysKyQFIlq/HdaeqtQG66zfw/089oeTO5fPpRPuadlh6qxcCkEMuSywKsl7m5zlcQz/4UjGbMKo/rMq2peUPMPLs4rsNlq7EPYZg6VDYtm2YfkBSqPQvVkG+Dnfhd1MAO89S3oKG+fmwEJA75QlwEqo3WT1cy66WflG3idp5IMYLHNNvJGZK9nUZoDVon48wQkR7zvWB9ZiQhPD3BTfLmroGoJvl/ZqgsRrzrhZuLPvNcVpqFrfD7Ne6hSa4n7FNeGxgD8wQZwFYP2DfNkp5uTEc1juiVrXFfSN9EYUHtpup/FqfH1xgz44zI4MAPu0JOHso0AUlisEa/YivXLLTXwO3hxBkP3T4EhwWJh8xQngvh9ihPtl5g8YMVqrpx5PrAnF9P95TvVnnuuZ4RBrPbJDmQP+/rgeQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?HiGgwaCSlXfDfY+w0Eq7osQV9CZmZq0ZfF/fmmXJBUSvMxaGYxLckvphjojj?=
 =?us-ascii?Q?GqyEQn7l7Di9Dbm3DxyvTGvi+HhAqLUPKD1uGo/gJX3glIBh/dU7aXKx1tLO?=
 =?us-ascii?Q?VyjhBzOrwMBR7tYgB4moEwZOWjDv+MgAwQtQr1pZl+Fxoko/zHADjWfra5rK?=
 =?us-ascii?Q?l6Y7R6rdKMwY+z5k2LmPI0ftm7tE+DdOWVWgt7mnv6Jvw2FGceuwLLkmIKAe?=
 =?us-ascii?Q?syAQ9IPoBpQN/85mEZAOdTVeQD7mqjXuPzcqR5xyuUDjiof+Ks6JO5W2F/1F?=
 =?us-ascii?Q?3UX4eO54O80F/PwtnOD+plv8d91o7bA2r3n+r27KjjryPuGRVAiPofgwBQvi?=
 =?us-ascii?Q?Mh8Q19oZ5S1kGDBNqIEznvJg/zOSSL/n37Ld9oayPUM8yfVVmdHy2625ro/w?=
 =?us-ascii?Q?TaF0Zrys+xzSqJMDCOVc2Zldca+b2rrhUt2yZsv2d71QZZsqcgSmpHQobyIc?=
 =?us-ascii?Q?0lPYicqBmgViCQT31TDCy23j+yh2GQ78sWCcDIeW40XJARNkyX59yaj2DgQr?=
 =?us-ascii?Q?EI4lYsh0huiNBY/K+m0UGNBOahumGCJY9W6bat/7D3hU/sPA/nYUYDH/g9Ek?=
 =?us-ascii?Q?fkr1P6PaXWNyYYa7R2jRcHiHbA88tFaCFOCB3C9MnPK5q9AHyzY1KWqGhUY2?=
 =?us-ascii?Q?rpamc0XVgr0K5u0ZHEuLdjhb0jCUjJ3r1RnkiqlpHPAN12bj8jfzdDLVTN7l?=
 =?us-ascii?Q?iFOrc5B4wHTqeV+G/LWmDVfPb46SsVq3XVEcjfoMbYQghmQhnRfEn1olwHWB?=
 =?us-ascii?Q?fiJSzngxBgF9vUnF4Yhs3DciIfqR5mSS84E4LC9AQpr4mYz8DtnQt9dhR5o3?=
 =?us-ascii?Q?tdkD2266MuRJz7IM82Khm1VJ/oY5VmTYFFzig1FDvc0g9i7c0KFiiY7W918J?=
 =?us-ascii?Q?KINw0HZto9/moi8xGxDLnxLZZyeJ9SrfQ3dpzW9y9yu534052P0fU5n5141D?=
 =?us-ascii?Q?mx2Pwv03DxIXQvWDl8v5l8xOLT7AdUHaDiE/epFysBKduHN4ysPS4lUgVJ3/?=
 =?us-ascii?Q?GHbhtCCA/sZeM/m8TGPhWsiXngtNHf0UaSgXgeRywdgL285xLLD8PUSj0fpe?=
 =?us-ascii?Q?LCWlNTaT2+1HW+iQ8RtCdjfBMXQM52EDwqAmpZFuh/3o1wiNtjvn5yjg1jcm?=
 =?us-ascii?Q?RymPtckI91mpxVCDOqDrkMJvpApe3aU94/agYo5RwG2C6h7dfN2deoJX/lAa?=
 =?us-ascii?Q?6glFwp4QwHhW+1ulXgtIVme0s9eXBfYklGNNUe9tEZ3CVogjqRiyFauZ/Zq0?=
 =?us-ascii?Q?SFtA/OAh92SsPcMUuWmC9pqHawiQstZGxOiZxuYmwj5s3W7MW7xz9OukM6YS?=
 =?us-ascii?Q?pVIMPv5y9G/yya5FC0W2uLlZnDkjJljfteJEHgGOh/2Kme9wNTFNpzanEfIm?=
 =?us-ascii?Q?/3M8a6bmKZEOB83WJH1ruI2cDPObM/ZHTgkP/BzY5tqLqp5rB+n+ufq1zwDZ?=
 =?us-ascii?Q?fCr1nF1V11K4M2EVwwhi63PfLWUUcpwBsmq34SGRs3VjE5/6MB8JC28zsS2q?=
 =?us-ascii?Q?IvIq27HRQ9pz+SDJbp2/kcG41jNUruFpPGCgWtQ3Ea8OjGohDqTjVMzNYbLd?=
 =?us-ascii?Q?qlKl5OezoqSNRB4yAmqLC/dIEpIErH3glivOXPC7AC0qQnnH2PuwmoCxIb7/?=
 =?us-ascii?Q?yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c87ae28-2f0d-4b7b-742c-08dc49a151f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 12:20:39.3042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: khHHCmhC+J94QE2DWkxQV0x5xZiNiyimyxzxA30V1I+Lx1bToyfQFabpvoik9oRN25IU1h0vq47PKaZPoDCgEkqveZ+AmUIIif4ahdt4miw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7458
X-Proofpoint-GUID: lVY5Qkp8LwdW4dn-AqR-AprlqgkIE15B
X-Proofpoint-ORIG-GUID: lVY5Qkp8LwdW4dn-AqR-AprlqgkIE15B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1011 mlxlogscore=999
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210086



> From: Xiu Jianfeng <xiujianfeng@huawei.com>
>=20
> Slab has been removed since 6.5, so there is no other versions of

Removed since 6.8. The changes looks good.

Regards,
Xiongwei

> slabinfo_show_stats() and slabinfo_write(), then we can remove these
> two dummy functions.
>=20
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  mm/slab.h        |  3 ---
>  mm/slab_common.c |  2 --
>  mm/slub.c        | 10 ----------
>  3 files changed, 15 deletions(-)
>=20
> diff --git a/mm/slab.h b/mm/slab.h
> index d2bc9b191222..78e205b46e19 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -496,9 +496,6 @@ struct slabinfo {
>  };
>=20
>  void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo);
> -void slabinfo_show_stats(struct seq_file *m, struct kmem_cache *s);
> -ssize_t slabinfo_write(struct file *file, const char __user *buffer,
> -                      size_t count, loff_t *ppos);
>=20
>  #ifdef CONFIG_SLUB_DEBUG
>  #ifdef CONFIG_SLUB_DEBUG_ON
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index f5234672f03c..67c03d6bd26c 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1078,7 +1078,6 @@ static void cache_show(struct kmem_cache *s, struct=
 seq_file *m)
>                    sinfo.limit, sinfo.batchcount, sinfo.shared);
>         seq_printf(m, " : slabdata %6lu %6lu %6lu",
>                    sinfo.active_slabs, sinfo.num_slabs, sinfo.shared_avai=
l);
> -       slabinfo_show_stats(m, s);
>         seq_putc(m, '\n');
>  }
>=20
> @@ -1155,7 +1154,6 @@ static const struct proc_ops slabinfo_proc_ops =3D =
{
>         .proc_flags     =3D PROC_ENTRY_PERMANENT,
>         .proc_open      =3D slabinfo_open,
>         .proc_read      =3D seq_read,
> -       .proc_write     =3D slabinfo_write,
>         .proc_lseek     =3D seq_lseek,
>         .proc_release   =3D seq_release,
>  };
> diff --git a/mm/slub.c b/mm/slub.c
> index 1bb2a93cf7b6..cc7e68fbdbba 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -7099,14 +7099,4 @@ void get_slabinfo(struct kmem_cache *s, struct sla=
binfo *sinfo)
>         sinfo->objects_per_slab =3D oo_objects(s->oo);
>         sinfo->cache_order =3D oo_order(s->oo);
>  }
> -
> -void slabinfo_show_stats(struct seq_file *m, struct kmem_cache *s)
> -{
> -}
> -
> -ssize_t slabinfo_write(struct file *file, const char __user *buffer,
> -                      size_t count, loff_t *ppos)
> -{
> -       return -EIO;
> -}
>  #endif /* CONFIG_SLUB_DEBUG */
> --
> 2.34.1
>=20


