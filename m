Return-Path: <linux-kernel+bounces-153254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9D68ACB88
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E842B21EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D988C145FF9;
	Mon, 22 Apr 2024 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="J8tWQqB9"
Received: from SG2PR03CU006.outbound.protection.outlook.com (mail-southeastasiaazon11020002.outbound.protection.outlook.com [52.101.133.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4E14659A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783568; cv=fail; b=ZpInsZAR/kIN635f45HLriEJb9XJRiDDlLiALtGjO6kNSxWj0lv8bF/7smVWnp6Bb9FQbjBZQPshyp0JD+Y2uHx0PwQur1ZFZRCqu4/Bte6n3PNQbMQtUIMACVIn1vN3WeYKTVhXX2DDN3YijiNy7+ocqvoKvV4cCIIDmZRzGY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783568; c=relaxed/simple;
	bh=MMrxo/RAibIPsCOLUtaE+89ULAldgh0GdDuDbkj4tnk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JeB8LdrLSZySa50/YyjYa5c9TR2eiHh0LeBmjTrgcp5y8hqUBnLrHAItqR4rPFmvp7kKPAbmkeh3LvEat0ydlZE2UJadNgHBr070sKrgucZ7vcC3DMrRTwNY2hF5QjDQ2khfWgp4lcALaSSDrruU22OXmJE4qlRGe1LWSX/SLlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=J8tWQqB9; arc=fail smtp.client-ip=52.101.133.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oupdsy33T2YUwJpiKUAxa0YS17Kq+WmKEizRKpUBb9CJGAYigK4Eu8E2Zfd6I63jU2ygNZ07VlZo1/3dpjJkr+N0yjsvoQ1qPuU/SqUkK26SFsSrOfxt4Anoq93sCVOQKT4koCrzWn5EjL1sQFD1V08Uw+fkDE87WnRhJhLGZMWsETPesHftE0StPPQ/ZMhdPlZKMDs50f1zU2y4pt+0DMNwlvxu8qlTkCbhi6uORUCtwPeC8qqzYyE65x1gur0iNmORTzSc0MfButGBdnRSZn/QRMBQRJGovO5nIOdXOM2SFqnLdh8RXC9egYq3VufgDXxrrmMguOqOfloAO5P+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikF+eNpWtCTyvA/oXGtBlCS6VQ9aLcH7XvYfCiYIqJw=;
 b=NrEjFgqat2yhGGbK2KH25xaHXaTV3vgT+xZEenhjKfDQ/uc+L/3ErA+UUYBLkrmd+jAl7yiRy8G0/hT9WlKmlZsUUoE2ONNrFDQZUNVg8bcHHio4U7BrEJygjHpid986115GPUD+yX5f8x7NjVDegbqj5yxLdyLhjYUA5X9yeC1jxJAe9wp/2R//vNMqIO6iy72CyjZQzyvzF6QP/KXBcG0RRBaGAgj+093c+U6QzXl80piUjqQBIAk1j7ql1V6C9GFh4IIEYn3hf+FIqpUfYin+O5qbluRUB1osz+YxGvBDRdczoRqxA7QIdJVVzc1gTeazokcd37V3agGtTGPJmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikF+eNpWtCTyvA/oXGtBlCS6VQ9aLcH7XvYfCiYIqJw=;
 b=J8tWQqB9RTIj8Z2vkRs6W/DrFV0xablp4f3ptVi4KcP/v8RI9EstD3yenl9by2lp9iyKrbhbLUmCyfnCz50o04Y6or1u729yfXyKr0V84FYiBcnwmlOh9s3tjk0Ilo9lh2T7CvnNmMeRF+8aPfpU84LvJicMMwfIBMKYKKjoCMlKDHLCm15EewjC/ngJKDyp8VTWHne4bIHdt4+u7zG+1cv58IT/Jw/XtEF1vBcSB2jXQEiPTxd/5kxNT4O7XIIII0mi8+iyGOCBoq/EAmhpioO22elOPbMbny7q0WhY3ayPmHVIBURWJ7qCgiQXFmY+W5DfFopP/eKIA+GnShbbGQ==
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by TYZPR06MB6216.apcprd06.prod.outlook.com (2603:1096:400:332::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 10:59:21 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634%3]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 10:59:21 +0000
From: Gavin Liu <gavin.liu@jaguarmicro.com>
To: "mst@redhat.com" <mst@redhat.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Heng Qi
	<hengqi@linux.alibaba.com>, "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH v5] vp_vdpa: don't allocate unused msix vectors
Thread-Topic: [PATCH v5] vp_vdpa: don't allocate unused msix vectors
Thread-Index: AdqUpADC1B8M7m7DRdW1tgCt/+fxkQ==
Date: Mon, 22 Apr 2024 10:59:21 +0000
Message-ID:
 <SEYPR06MB6756E76E1CEA58CC8FDD15F3EC122@SEYPR06MB6756.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB6756:EE_|TYZPR06MB6216:EE_
x-ms-office365-filtering-correlation-id: d01d4966-e76b-4e49-0a4b-08dc62bb4397
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ibyekG4uUC2ctCY0lIA8F3puf8qtv9HzBfUC9vZ9NTGh9FBygny/1RG460sY?=
 =?us-ascii?Q?tMrBvHpVDAr3OXZIgJPFWKoFbc4Z6+AvufwUw4rvOq3m4Mfxi81DUiNgzvg8?=
 =?us-ascii?Q?LhCTGUTeWv0Q/lATylxrB9f4uEljDFzxGhYtEDY6YE2MIt1zvIc+CGPpjyOP?=
 =?us-ascii?Q?PxQwM//AgYeWRTCYMwLmeh0tdl7RfreVGSncBKujYlYH0csOWjwFsExagkBH?=
 =?us-ascii?Q?C4em9EQKVMIvEbNaIej2nUn0ICmGRn/XDIjWxGggZwrs4l7u0ycPcfud9Upq?=
 =?us-ascii?Q?13oFYDZN/M9c+BX6R3yL/kRGYY/w0+7akrAxzLZwuLNJl2dvEgsi1txj1KPB?=
 =?us-ascii?Q?dXwxMoXmlByp7RnXKVnuKMk6CMAHemeI2Z5b1d3v7R4kXk2qEE4JDnzRj0O0?=
 =?us-ascii?Q?1f2u49h02eScLLJntXB/8DdLMG6A7Z7xZNiLyyxKFGcuXQQL0Kp7AdQfd+qf?=
 =?us-ascii?Q?0fmAnRZCEMld6BmxsZQGkd1+46DmAjdas/5sIZX+POhZKT3jw3/uXmmWbtD8?=
 =?us-ascii?Q?u5NTL6uReanuelYG8Gmmzk4odCCO0/OUwx+X4npLGEMjMoSMW4lvfoOZKRfc?=
 =?us-ascii?Q?tg+YFU37jtQKI8sdlzQAe+XsSZ/rP48ZHyQ4mqYZRor3G9Urpqc2eDxehpHB?=
 =?us-ascii?Q?Bdn4vcYdoEqPVFm0S6f6ngmboaemPrB0TVDgjGllFRijTmCmS9/v8HFoEolX?=
 =?us-ascii?Q?1iorTvfWt/SszRO9hlZWAExiI2NLWzCReQbJGGxtLFnOp+xAVrGg6iaIMUwG?=
 =?us-ascii?Q?c3ZjLDFW7+pqgXdkyd+dFqWSH2ONqHS5Yv9laArAmrFiTT5SJJ3NLm4K/Vxk?=
 =?us-ascii?Q?xydoh2b7dSxB18nVXj0u0Hyq3uAQ1RjsQwufKgRYgMCaGGNMkIV1nmXQoAnp?=
 =?us-ascii?Q?5OmM7+s7mIuMfltoyJA6VrVNghTyONB+Iy8m6YbfUZafnmV9XyeATV67bxo0?=
 =?us-ascii?Q?24RTCEpZPVeCsskq4Vz3Yx86JtDYNHyABRciz9DPwfG61vkVJs+oWgrOafJB?=
 =?us-ascii?Q?szuUzQDhcLvrzicCMFi9MO0MHxZD0rdesdG5uK3/XaSdRByqS0YWTZc682IC?=
 =?us-ascii?Q?A6ZxGTGWsh1mqLblgAGZ743iME8wm/IZvBuQqvh3J3pjPkn1bK1ve6oNGGiO?=
 =?us-ascii?Q?wc7ejnEZtnp6apfuGGk3RCw2fnV6X2Ga73hzvDvxfrU1nMIcfGefhMb1jDAV?=
 =?us-ascii?Q?W3Thu0DOsyDP0Mj+vFxvwyW69CsbWuFeVunES5qTNc+6w0t2Sxv1WOX0dS3O?=
 =?us-ascii?Q?VffiKpy93x0MIiJmxAnsU6kqhpbHMVyxEZG8wcWGETz4ql/32fc7DSlyeOEI?=
 =?us-ascii?Q?hC/LJgC6GAyHiCmgYat4DU92XsZMQ4YgybPhctWStWFDIA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6756.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Q3xc8iag0AjY9nKuKpYlp3ftT4znf2kVJqzp3ZC8xSeH6Z4SB3bfIzkoBcYR?=
 =?us-ascii?Q?UphP5O0+ccuYZt2JZw7P5A/x7VF/QhTlrrKLeUT2wEqjMhQXXkZFgYBPOFbJ?=
 =?us-ascii?Q?a5O/QN1CYYbiUe0PB1f1n6mRd2Kart0mJ9RI2IJpnzBSelO2eFKmCM3WEIGM?=
 =?us-ascii?Q?lPSO0Rnqowhimp/LiPBpW8Alfqbm9fYMK+d6onDrKFeZee8WCqZGZqFcjghX?=
 =?us-ascii?Q?WFKr6vhKX/nXg0Du07UVyYEfCLjqqlIMVyZkOKlfbHleb9CD43WMPL2Fgn3F?=
 =?us-ascii?Q?T/3xtkYNujp7rRtSKY5QDMTZRFuDaZXiaQFu1yTi025rXvFm07hzLleB5WKS?=
 =?us-ascii?Q?Edz5FT8W/IOV+KE68KzRKeHg3zJ1Z8kfNit9QXlnjJ3ihh/npOAF4Uz4osN8?=
 =?us-ascii?Q?5v/+BLrHw7kNzSshuchXAgudhB5YA9HJ4vpSssy2DlKFeUQOB5ZDW25zAdUS?=
 =?us-ascii?Q?vnsnVuEcSGC70Qi/ONICFlj9jD/TZ8GrbEBZqtUcpLEhyHf+VFygqe2UX1gn?=
 =?us-ascii?Q?p26umoZnbR69CFhkzCcaDaumqjww9Q98ledgIetCm8mqw1LETFdHYixJ6f8o?=
 =?us-ascii?Q?0pquZ+n8wnSFDw8X8G7PM/hPSn3kQrx06OScHIJPdwYDCIjVh1lfSmRVbzP6?=
 =?us-ascii?Q?24a3dAI4fWyNa9m9erVGzac3Eal8f+slpSscQFBR7TDHWe6Xu4RIUbXx6p7J?=
 =?us-ascii?Q?2X7YALNy50sbh5eORBcQPKWiRbndjAF4I+op0gh+TvDS0Bc34YMc/RxEI5+J?=
 =?us-ascii?Q?IoxGhLWKFH2FxgRg6xFQhylXluBuQxRQwzQwKgVdwaTpu4eXyPLG0/UjVIu2?=
 =?us-ascii?Q?M0XxpzK2DPkCaRkb9N9epR3jiWFUqp6lUfbO4KLbPS/vdJzTi6mrb9UyK4Wy?=
 =?us-ascii?Q?xWY/YCJjzHLhy7gI8wt9/kn89mFcrYA8TBxDLCQULpjbe1xI3NsJv7zwdWGa?=
 =?us-ascii?Q?YDGMGbToW+iHfnNJJ1Sm9Yzm5m0mNFO9GtI0LFablqZCUCn4oSCThPA4b7Dz?=
 =?us-ascii?Q?wXC2nej93GFnDk3wnXnLGDcpSAicMSHZccyKFMaNF+NyX3VPkfZ/Hsvv7j0t?=
 =?us-ascii?Q?UtET1m98ydv6BOt0VlFGQ6C5W72U2bMREKAQ17zgeTeRbtWtiZtOy8ok5i3n?=
 =?us-ascii?Q?Bm/XAp32nVLCFkfpC4LAtw9Nr46X+URE0L9MvUo6xva1WXs4sWG+V2KCxHMw?=
 =?us-ascii?Q?BYV+jCchEw67XvRqdXPj2rdMHSk31B/QTvLPnkoe5EbhzUeHzFGeJ/ZB+ZWk?=
 =?us-ascii?Q?ZlzmxbemHTxc0hAKx1ZPnssa3vTrD3oXaaUNl/lB2Ztu90sDSV9bU7ukFVKk?=
 =?us-ascii?Q?kADhk7CAjhHebZUrQ/jd9Oj2Wr3MUCnXnftY82W6djKm5zCdRFbyRLdWjDgN?=
 =?us-ascii?Q?vd7AnYSKKhnI58UTNGnp5OsfwL46FaYt0RIKKoPouelrDNin7W1w5b2Z/rSl?=
 =?us-ascii?Q?S1TmNLTbH/Sb4YGyFGdSFjZpLPtJLGuQi8VcXqfybP0fdwWEScUOTEmpEHh1?=
 =?us-ascii?Q?Sm+37TqG1hZ1zyxGPGlqLzRL/ll0cfSnCojm0Llu7jryABCQCzdWA9hNGZI9?=
 =?us-ascii?Q?BYRTHOTcJLlccdZxWPMdZUrED5J2HMrdibMnLuC6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01d4966-e76b-4e49-0a4b-08dc62bb4397
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 10:59:21.1558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVj35/A3bM3+khKgYdk+xzxKLpEXI8Nekyr4aMZ1BvRwVX4pyPW2P1JzYZ+cfSeOYjub2sBIyt7t+WmtCzOrPDwN7EkjGaQAcnTMJ/65QSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6216

Dear Michael,

	I hope this email finds you well. I am reaching out to request your assist=
ance in reviewing a patch.

	The patch in question is titled "[PATCH v5] vp_vdpa: don't allocate unused=
 msix vectors". I believe your expertise and insights would be invaluable i=
n ensuring the quality and effectiveness of this patch.

	Your feedback and review are highly appreciated. Please let me know if you=
 have any questions or require further information.

	Thank you for your time and consideration.

Best regards,
Yuxue Liu



-----Original Message-----
From: Gavin Liu
Sent: April 10, 2024 11:31
To: mst@redhat.com; jasowang@redhat.com
Cc: Angus Chen angus.chen@jaguarmicro.com; virtualization@lists.linux.dev; =
xuanzhuo@linux.alibaba.com; Gavin Liu gavin.liu@jaguarmicro.com; linux-kern=
el@vger.kernel.org; Heng Qi hengqi@linux.alibaba.com
Subject: [PATCH v5] vp_vdpa: don't allocate unused msix vectors
From: Yuxue Liu <yuxue.liu@jaguarmicro.com>

When there is a ctlq and it doesn't require interrupt callbacks,the origina=
l method of calculating vectors wastes hardware msi or msix resources as we=
ll as system IRQ resources.

When conducting performance testing using testpmd in the guest os, it was f=
ound that the performance was lower compared to directly using vfio-pci to =
passthrough the device

In scenarios where the virtio device in the guest os does not utilize inter=
rupts, the vdpa driver still configures the hardware's msix vector. Therefo=
re, the hardware still sends interrupts to the host os. Because of this unn=
ecessary action by the hardware, hardware performance decreases, and it als=
o affects the performance of the host os.

Before modification:(interrupt mode)
 32:  0   0  0  0 PCI-MSI 32768-edge    vp-vdpa[0000:00:02.0]-0
 33:  0   0  0  0 PCI-MSI 32769-edge    vp-vdpa[0000:00:02.0]-1
 34:  0   0  0  0 PCI-MSI 32770-edge    vp-vdpa[0000:00:02.0]-2
 35:  0   0  0  0 PCI-MSI 32771-edge    vp-vdpa[0000:00:02.0]-config

After modification:(interrupt mode)
 32:  0  0  1  7   PCI-MSI 32768-edge  vp-vdpa[0000:00:02.0]-0
 33: 36  0  3  0   PCI-MSI 32769-edge  vp-vdpa[0000:00:02.0]-1
 34:  0  0  0  0   PCI-MSI 32770-edge  vp-vdpa[0000:00:02.0]-config

Before modification:(virtio pmd mode for guest os)
 32:  0   0  0  0 PCI-MSI 32768-edge    vp-vdpa[0000:00:02.0]-0
 33:  0   0  0  0 PCI-MSI 32769-edge    vp-vdpa[0000:00:02.0]-1
 34:  0   0  0  0 PCI-MSI 32770-edge    vp-vdpa[0000:00:02.0]-2
 35:  0   0  0  0 PCI-MSI 32771-edge    vp-vdpa[0000:00:02.0]-config

After modification:(virtio pmd mode for guest os)
 32: 0  0  0   0   PCI-MSI 32768-edge   vp-vdpa[0000:00:02.0]-config

To verify the use of the virtio PMD mode in the guest operating system, the=
 following patch needs to be applied to QEMU:
https://lore.kernel.org/all/20240408073311.2049-1-yuxue.liu@jaguarmicro.com

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
---
V5: modify the description of the printout when an exception occurs
V4: update the title and assign values to uninitialized variables
V3: delete unused variables and add validation records
V2: fix when allocating IRQs, scan all queues

 drivers/vdpa/virtio_pci/vp_vdpa.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp=
_vdpa.c
index df5f4a3bccb5..8de0224e9ec2 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -160,7 +160,13 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa=
)
 	struct pci_dev *pdev =3D mdev->pci_dev;
 	int i, ret, irq;
 	int queues =3D vp_vdpa->queues;
-	int vectors =3D queues + 1;
+	int vectors =3D 1;
+	int msix_vec =3D 0;
+
+	for (i =3D 0; i < queues; i++) {
+		if (vp_vdpa->vring[i].cb.callback)
+			vectors++;
+	}
=20
 	ret =3D pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
 	if (ret !=3D vectors) {
@@ -173,9 +179,12 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa=
)
 	vp_vdpa->vectors =3D vectors;
=20
 	for (i =3D 0; i < queues; i++) {
+		if (!vp_vdpa->vring[i].cb.callback)
+			continue;
+
 		snprintf(vp_vdpa->vring[i].msix_name, VP_VDPA_NAME_SIZE,
 			"vp-vdpa[%s]-%d\n", pci_name(pdev), i);
-		irq =3D pci_irq_vector(pdev, i);
+		irq =3D pci_irq_vector(pdev, msix_vec);
 		ret =3D devm_request_irq(&pdev->dev, irq,
 				       vp_vdpa_vq_handler,
 				       0, vp_vdpa->vring[i].msix_name, @@ -185,21 +194,22 @@ static in=
t vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 				"vp_vdpa: fail to request irq for vq %d\n", i);
 			goto err;
 		}
-		vp_modern_queue_vector(mdev, i, i);
+		vp_modern_queue_vector(mdev, i, msix_vec);
 		vp_vdpa->vring[i].irq =3D irq;
+		msix_vec++;
 	}
=20
 	snprintf(vp_vdpa->msix_name, VP_VDPA_NAME_SIZE, "vp-vdpa[%s]-config\n",
 		 pci_name(pdev));
-	irq =3D pci_irq_vector(pdev, queues);
+	irq =3D pci_irq_vector(pdev, msix_vec);
 	ret =3D devm_request_irq(&pdev->dev, irq,	vp_vdpa_config_handler, 0,
 			       vp_vdpa->msix_name, vp_vdpa);
 	if (ret) {
 		dev_err(&pdev->dev,
-			"vp_vdpa: fail to request irq for vq %d\n", i);
+			"vp_vdpa: fail to request irq for config: %d\n", ret);
 			goto err;
 	}
-	vp_modern_config_vector(mdev, queues);
+	vp_modern_config_vector(mdev, msix_vec);
 	vp_vdpa->config_irq =3D irq;
=20
 	return 0;
--
2.43.0


