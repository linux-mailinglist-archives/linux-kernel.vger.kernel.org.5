Return-Path: <linux-kernel+bounces-148751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B1A8A86FD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C619B23E80
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA85513C3EF;
	Wed, 17 Apr 2024 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="DWD54/GB"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C4313D527;
	Wed, 17 Apr 2024 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366377; cv=fail; b=rxRrq56KKB7TNgyINh+QsKWhb4ohaCPlvfDwEMl7j/1i9XLbHZ1wM1MGYXPGBlAT7e3GE8sCIPfxZa/ujELaQ3PN4/5klgumDVMqWm02FjlYNMDN5/MqxWrJQtI8FO2g30OV3Jws8iVrjiI8S9E9E6vmXD6aEEfK2bDzbnBh/dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366377; c=relaxed/simple;
	bh=v2S3Wc9erOOSH9uqAZ6LUlGr/5v+Y6fz5YcjuS2mLr0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G4UCuASViPbXeacHF+NW3+55VAlXi4GAbZLdpPCOh0j3LTWwJxXydusHZtUeOW5yT5jLK0zOXBH8MHAo78StcfNNwlAKYM/ozzcLf1leWdJtI5dp79X0FC1H4+IrgyFkgAB6x1HfMRB+qXg4wVjCMkgetQLH4W2pR6ukCj4lWwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=DWD54/GB; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HEkwXn015644;
	Wed, 17 Apr 2024 08:06:04 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xhfdn6rqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 08:06:04 -0700 (PDT)
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 43HF63FG024801;
	Wed, 17 Apr 2024 08:06:04 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xhfdn6rqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 08:06:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPmesID4rHOxG0DQyDksPrBtI5RUDByYP691ozhXNU1UJ0/z3S1l0JJMre4Botuq80RP8C4XLvQwCYKzaUJRIPrJwUcMYPTReRXCZoUx2u9RdKA3/Hi3mt06w8c9pzFOtOeQXUeuoQsF/3GG8WcTV4+HM13NUnsD3+CakHaMa60vKM7Qsc+Ffq3W9jFTuppZYp5VwJ95jCGsMPhWDeabLBzM5mmDTrQMYAAeWb5aCC36ev5hGXRoJp+pmaItNF6AluOYyp24IeJbXJzSNI97PD9yjzP6Mvlb0F81SnVPqQHnIQLj2HtQqPRBps5cr09KKvnVXTRM+pDmyv/dPlFFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSnqwkTkG9eJgyqJIIM2Gzh1oZ319buhx1Fqi6llirs=;
 b=GjCUYl+4mn5SQQvbU/ejWU0NyXr2ocddWk8GvV8vcae9qT+x3KfvKlxEDNoZ5a3JR6BqXoSWZX9mVKKgmmyJqLLkZnmiSuy6KeLFFXq++pTAIzE4EryS3eeuvskD2IdLgROddfRlmPUwRUnuEqRCZKGE6uFQjm51+VPL1vQOo1iv0TPlSUcurlLeDM84xLGjgQovtUxmWuxyXTd4vmvFURED2WohMFMdZUxEuNEXYYAriVQbdXPg4HDlZ7x8o6Bg1JIN39hfUwIOs5fZKgQQL6j/N8x0aHKJT8jDLosQe+Rg1NkL6ccKr22nIH+aCl0uUpGUpLJVQYqotFLu7bPFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSnqwkTkG9eJgyqJIIM2Gzh1oZ319buhx1Fqi6llirs=;
 b=DWD54/GBZGEoZezD71N9s8zB84GlB5ugA782w2Delta0WceyE0QZ5yEGa8AzJZGeO1Ca5+aKiBMd7MhUDA/GvZckeOmC2iAN1a+oDRQ5b72dodpOZDX8LLFA8z7/TZJnFFJZeikmvLryQy32ZVn268LC7FV+U5FDcZgSL5EWo7o=
Received: from DM4PR18MB5220.namprd18.prod.outlook.com (2603:10b6:8:53::16) by
 CH3PR18MB5617.namprd18.prod.outlook.com (2603:10b6:610:1a0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Wed, 17 Apr 2024 15:06:01 +0000
Received: from DM4PR18MB5220.namprd18.prod.outlook.com
 ([fe80::83c:a9ac:9edd:f7d6]) by DM4PR18MB5220.namprd18.prod.outlook.com
 ([fe80::83c:a9ac:9edd:f7d6%5]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 15:06:01 +0000
From: Saurav Kashyap <skashyap@marvell.com>
To: John Meneghini <jmeneghi@redhat.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "guazhang@redhat.com" <guazhang@redhat.com>,
        Nilesh Javali
	<njavali@marvell.com>
Subject: RE: [EXTERNAL] [PATCH] scsi: qedf: make qedf_execute_tmf
 non-preemptible
Thread-Topic: [EXTERNAL] [PATCH] scsi: qedf: make qedf_execute_tmf
 non-preemptible
Thread-Index: AQHahdgWB/HLzJQ5MEq/5VYjn6Cy9bFspa4A
Date: Wed, 17 Apr 2024 15:06:00 +0000
Message-ID: 
 <DM4PR18MB5220429DAFE75922C54173ABD20F2@DM4PR18MB5220.namprd18.prod.outlook.com>
References: <20240403150155.412954-1-jmeneghi@redhat.com>
In-Reply-To: <20240403150155.412954-1-jmeneghi@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR18MB5220:EE_|CH3PR18MB5617:EE_
x-ms-office365-filtering-correlation-id: 97946dc0-ca00-4139-9dcf-08dc5eefe4d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 PGQ1MtpbxplPRvo0NvgJ+PCDmlRNbL2UMNfVIOw3ONTF+OWJM6GKA5JD3UJZpLyegige7+u0HpS6REZQFg/23NYGh+WUSWcq2otR6aCECloT++nh8flxUiUCvhE5Q5WarjxxyoODPcLAT698/gPPTss2N/nWfPK9jhUxbCM1bwPcQ92xpdWzKCd23N1HOWz3di7ajHTHk5OxRtXHqHcJpFdzNSCsxDfoqt8UfG/HWEywKGqJ2Ns09ynKsqjJlOUzNYphGaX+Of8xJGBq5fc2QxZXm9FN+mr0LU4CqZOeVJUpLxYsIsWzjd0gI/uSLlSbWJoNouWzETSc9yP0dugMEB7k4KaNvD3+AauA4kDQYUwmf8xJNVQ4RcWA6oNMNMSu+QQY/CTXjxh21iUSDl+yAOx1ahGjjB3+4fB50/x/OT9o4WpF2CP7HQDX2OBKrVnqHhYZyAzklZFArt3fCqPuR2M14DzSxn6waWS2cjFXwzXzf09XEgUOl9xRcJlTGkFmpDTHB744aDUobb/zmAu3IqC2fDwToO9zmiXDeNTxVFmWL4+9ZzsVxBpDbR6UWZHBKP3RN0vQ2m4fD2gtQE3mld0ht3Xn4KpRjSeu8y1f6ILBTGSKKBKT1LYCfUu6iFoahzF9ZSJhvUxpBDN2MCu7So7q0lo+6WuyflRcLLZtdKyQ6QJDOvqhG0IZSt+x7lYYGPnyWxTr/m/ry+srvgVO9Y0urNXqnlD1CD8yrD0d0AU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB5220.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?8ObQI7CZDwJMqKIl8s5PJmnDcf1zN0c69kP2ToMgIOmQn+mpHWaanIXy5S5w?=
 =?us-ascii?Q?jgcEB0z6aEZjTjlCWUue1XGv5PijLTcpykfU1EGwZFt5rHM1SuSNJeggn+Bz?=
 =?us-ascii?Q?punknoyJqL0y2pLiCyZKojKRjmSZPG0iI3321ArXc3vQLxruMMEoRI0z97Zm?=
 =?us-ascii?Q?7Sogag0kpWSgHZ0rJQC8AQSZ4iHVFB8nyO+pBWpbacwa+mkIjgjtiRIoh1yY?=
 =?us-ascii?Q?GyyMIuzfgy22O4qIRjFEvZDOxpHUjrVENp0Iio2RC1VZ8i1mICxU0qoFgglj?=
 =?us-ascii?Q?Xxy5pusUEB3slvmaBKJP28wvEcF64SRVgao5WbABGb6tpbdQ9IBU7bfwam9f?=
 =?us-ascii?Q?PLk0lOjeUAZLLWhtfIGw1DkFwBoAwPr2vLp9ZRARSEqlndisnfTMUo1jNOpA?=
 =?us-ascii?Q?5K4/0GrJzfeygrrMnK2Cj1N9d8yvv7C2QcP08o2cLLzjCJWT5PjvfiISzhi2?=
 =?us-ascii?Q?XUHwqhdfDNhufoN5kUGvgFKZjTsCJ0ofOFrGLXKE3iYSwxWBNddS91p2ghCA?=
 =?us-ascii?Q?OajVrHX0pf8iPoGBx4tCGduy3brO7TAFYeeZvgXCi8jOX8Wc8KydtHXytB0a?=
 =?us-ascii?Q?TpK0dMgwNMIx1zo6mxoNcsGhd2xQ6Zv/SzkgPaarPboiKrKkRA1zvqbv2uG7?=
 =?us-ascii?Q?8/xwREVR7Snm8BOTcA3v1A42907e2/rI5XxdTcqljkqhWlIqsFyUOTpdz2lg?=
 =?us-ascii?Q?OygWuGGLE0diZ3RldaLdmnx+TG9qYNF2Qj6vdqdZYzHVxeABghiOy30cuhqa?=
 =?us-ascii?Q?4ou60mqvVg/gf6CmjHkZPPiQ/G2bJvBWCynTPDfmWc5Rzv1PfDYjytV9AYcd?=
 =?us-ascii?Q?A30wpqBSggt03wwRp0K8K4oe7oLkWYo7dyZRpdZkumXW8fHj2/7mLuklWhwX?=
 =?us-ascii?Q?8nrDthteZ9FmFf/JRc8T8gaVHJo8BYH9k52dy5Orn5rijydgADE4ulqCJ8M6?=
 =?us-ascii?Q?19rQUJXogmKLu1fCCj0jeNECfjxv4EhTLPmr9i+p2iLi7LL3LgDMS2vXrFjI?=
 =?us-ascii?Q?KgceN36ArVoDNUHr0Opvsa2iZ6dbXPUamMWbHU8EtTvzwFBQtr5Ij9T7ay6b?=
 =?us-ascii?Q?SmiIhoJ+CF0mdoxxdDSXjEkdGTp+g6IerD8g/ZoAiL3BZz6/lRlOykOnsMez?=
 =?us-ascii?Q?Pkfw1HxuqLppT9BovqcI6lNX+0VTLWsuaZBmPTTG24+zzlz0ewv7SSnb1eSH?=
 =?us-ascii?Q?fpjm3taGEP4yLW5WbkFNwOnY+F3crxHDJ9bU6VakMb1upeT/3I5Am9KAHb4i?=
 =?us-ascii?Q?lBHAgSiL391mQFenm7CQsqw0A7j0IuC4XI+WDE8rktg6837DOrauq6jfQpuI?=
 =?us-ascii?Q?8861ZEg4UTMSVS67QzemHq7AF1/FW6DYKCFfN8AiX2wrOClMRdUM3oAzGgEb?=
 =?us-ascii?Q?Nkn7AKyQnVqzUcdE/b92PQuNMZPP9WXdrx8jhg2V+m+53JQEtsb/og1FbuHn?=
 =?us-ascii?Q?8npaIG/mCe9aimvr2QhTr6b1CJvKaWzZh5jdK947AOgGt5lLF4i5Mgn2waZi?=
 =?us-ascii?Q?z33I8pwZDA9G3Vdaqr9dgQYwC8Be3PZMMFesAGH4MCfZM2x4fV2j4KqP4JiQ?=
 =?us-ascii?Q?oeubbaVW8+K0WqEmlnpsremjpjnfGGsbAySKiuWK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB5220.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97946dc0-ca00-4139-9dcf-08dc5eefe4d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 15:06:00.9056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aOQR0wKNyCoYMBRnr9SerrgBK16G5nawoUtca5SGTkGml/lnpG9XrZmHT/jTFRI2VqccVDan+TcEG50qr+lTBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5617
X-Proofpoint-GUID: WD_GRf6SNvObuaT0EeSLqZ0j0pmcfKek
X-Proofpoint-ORIG-GUID: C3lUm_EY8qPeFj792-MiwcJyZUw2kcol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_12,2024-04-16_01,2023-05-22_02

Acked-by: Saurav Kashyap <skashyap@marvell.com>

> -----Original Message-----
> From: John Meneghini <jmeneghi@redhat.com>
> Sent: Wednesday, April 3, 2024 8:32 PM
> To: Saurav Kashyap <skashyap@marvell.com>
> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org; GR-QLogic-S=
torage-
> Upstream <GR-QLogic-Storage-Upstream@marvell.com>;
> martin.petersen@oracle.com; guazhang@redhat.com; Nilesh Javali
> <njavali@marvell.com>
> Subject: [EXTERNAL] [PATCH] scsi: qedf: make qedf_execute_tmf non-
> preemptible
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y before
> clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> Stop calling smp_processor_id from preemptible code in qedf_execute_tmf.
> This results in BUGON when running an RT kernel.
>=20
> [ 659.343280] BUG: using smp_processor_id() in preemptible [00000000] cod=
e:
> sg_reset/3646
> [ 659.343282] caller is qedf_execute_tmf+0x8b/0x360 [qedf]
>=20
> Tested-by: Guangwu Zhang <guazhang@redhat.com>
> Cc: Saurav Kashyap <skashyap@marvell.com>
> Cc: Nilesh Javali <njavali@marvell.com>
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> ---
>  drivers/scsi/qedf/qedf_io.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/scsi/qedf/qedf_io.c b/drivers/scsi/qedf/qedf_io.c
> index bf921caaf6ae..054a51713d55 100644
> --- a/drivers/scsi/qedf/qedf_io.c
> +++ b/drivers/scsi/qedf/qedf_io.c
> @@ -2324,9 +2324,6 @@ static int qedf_execute_tmf(struct qedf_rport
> *fcport, u64 tm_lun,
>  	io_req->fcport =3D fcport;
>  	io_req->cmd_type =3D QEDF_TASK_MGMT_CMD;
>=20
> -	/* Record which cpu this request is associated with */
> -	io_req->cpu =3D smp_processor_id();
> -
>  	/* Set TM flags */
>  	io_req->io_req_flags =3D QEDF_READ;
>  	io_req->data_xfer_len =3D 0;
> @@ -2349,6 +2346,9 @@ static int qedf_execute_tmf(struct qedf_rport
> *fcport, u64 tm_lun,
>=20
>  	spin_lock_irqsave(&fcport->rport_lock, flags);
>=20
> +	/* Record which cpu this request is associated with */
> +	io_req->cpu =3D smp_processor_id();
> +
>  	sqe_idx =3D qedf_get_sqe_idx(fcport);
>  	sqe =3D &fcport->sq[sqe_idx];
>  	memset(sqe, 0, sizeof(struct fcoe_wqe));
> --
> 2.39.3
>=20


