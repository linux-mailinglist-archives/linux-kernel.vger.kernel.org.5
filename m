Return-Path: <linux-kernel+bounces-28739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC253830272
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21A11C211C9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36911401D;
	Wed, 17 Jan 2024 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MKlhaZku"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EDC13FFA;
	Wed, 17 Jan 2024 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484328; cv=fail; b=HWp7MPrjesFVCaeqwD+jrEryd5Q//xd2YGK7oUPoYWyDNtgmX9RHS1DX9kuQxEwmRaoPXFbjDUS060/kqvxJDa+VjI6YIWDDalsBSoVx5KAgFn393fp/3ihqJbGHTH5qn/tsqFdW8y+CEdOXw8fGW4xrGpyDgh0lNc6vZc9cCN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484328; c=relaxed/simple;
	bh=hSWagL5dcx/5OT6R/IWxsNi1gwkL61YE9bkgAs2UJ6g=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:
	 Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=er6l07SQxQT7TynG5rM06TME6cpsqBlgShwjGvyi23oeXHnPcFpB+GcdfKS1crUW9eFzhWQ9yY829f5Ef4FB2sZHE9cK22pGOuNpzhkdNA5KC5KT64ZuJX/xA4rOXTbZDqKENh1JVw+AwlAmPsbsl+yPUFEFwfNCa5Zm01q4fuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MKlhaZku; arc=fail smtp.client-ip=40.107.8.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdHaVjpG2LEtNYMhWv27yofDBpyQdLRwckifI/4ppZPUxVtU1KHF7/3/mf0fUjsF3sfRMq3mHr1ExRSW4KXBwUC+yxQcZ8OaOXqLWa7dMqvXB8xD2qp9/8wS+sECdsEsFmWnJ1rSX8u9jyIFNkFbU+DgIu9QtFPO7jmvIwwpcV1pXhu86ubWKO8kgHF48I714OBz1c3igdFQKrXhCO6pTjCxs1wMAkYf/L9Ojy2+6DsVJOdQshzO41CGNDWDOGUBHJuuykLXyMTNcglgnlPYOEfr8UzS7Mrl340zJf0vLL11qZT3c+PgxgmcH3J1zCIxJzcAFdX0pU3IZ6f9vQ5BmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwnMclvjhftzISEw0rNhZQrRIofxZkPsSL1wqhtOzdE=;
 b=kVJKWEIpl9ceqzJHFTxYJJmNMK+gC/7C64NZU1pTHAQOjq7/5Mu+rFkMdX/9lcSRJbeZjdGM0uaSFk7g+2ztHrEihO/SmA3KrzxdZj2ZVss+afXU4QMcXB3OWDzjj0fXTF29MSPR5mf2uiR9CDD9OBEaHkIN4nWd7K6Ng1jERGZzhqXpunbmmjX0nx408j4TJkzrSulCuLzehwANFREKvm7JCbcrxhYUHYxSZSzsGf5jaWJeIjlqzGoTCrubIKPQ2byrOZHGoTYnZgZcrQc/aqtiX8a5y56D1wkOvkS2ji9rWVUx9Y8R9cpX+7Es2yYK/zVe5npAGfkTv2dfr/IEPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwnMclvjhftzISEw0rNhZQrRIofxZkPsSL1wqhtOzdE=;
 b=MKlhaZkuHHxnTQI0cZawbNjZgQo6fRuL/UFnGMeGMqQBp1rSUCdhO8wIfwNsOk2Y5nfBOz2DYLryp8jhPfU9oK+izRzpikTNKxe1IVRhB+nA2qB9CL0OP9Darwq/VLP5n7vslBkMb7scnsoqvcbVKWkwiVpQ2ptlY8HXm+DUlAs=
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM0PR04MB7010.eurprd04.prod.outlook.com (2603:10a6:208:199::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 09:38:43 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::748a:98f4:59fa:f206]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::748a:98f4:59fa:f206%7]) with mapi id 15.20.7181.022; Wed, 17 Jan 2024
 09:38:43 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Sherry Sun <sherry.sun@nxp.com>, Rohit Fule
	<rohit.fule@nxp.com>
Subject: Re: [RFC PATCH] Bluetooth: btnxpuart: Fix nxp_setup in case chip is
 powered on late
Thread-Topic: [RFC PATCH] Bluetooth: btnxpuart: Fix nxp_setup in case chip is
 powered on late
Thread-Index: AQHaSSj19sN+8TuMTk2XZIqniCJI4Q==
Date: Wed, 17 Jan 2024 09:38:43 +0000
Message-ID:
 <AS4PR04MB9692991FC87A8FF21E455BC8E7722@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20240117030501.149114-1-neeraj.sanjaykale@nxp.com>
 <20240117090932.GA3787@francesco-nb>
In-Reply-To: <20240117090932.GA3787@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AM0PR04MB7010:EE_
x-ms-office365-filtering-correlation-id: f4f7fcee-348f-4802-1022-08dc17401862
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qTJPtMGJt0PuEcxfn+jBaKCw/E6SCTN+O5tYTMoZeltz0OFj1/uB/sNxuJaVWAm2WKbKvWDReDiBOwONG83YoiE05UoAb7ydfOKc3dwuuY471jxqUW56Ju2u+Wv2rpGNU/HxbYWJ+g2wUAyw+aSLRVYf/cFYRAjLN4sbWRcACollLWTSwgkcoxgEVqrufwASFIqtpyJO1eU0N0z13ibDozmnEYtDO33ZtoyD41IhIdUu42KtQdjqKYqCx3dw9l16I92zh6cKiNohKx43yfhbYrcJTtKFzfCOGtYm78dUMtz1FBPHDYNHqp7p8yMeiqRnf5ASQRFlngT0BFtQM2tn10LZfrbEYmGWN9Ej+RKWG43Quytmi3n9SkyuczSn6xg0OopSDbyhdNcE4kTFRKMKTI8Wv1gPpIBOeMl04MqJA5tALO6AXcPRb27GCcPkUBHB3v1DEXRYEykqNcdkAQi2FOI3V89+wd5O05VVqdrnDVkCc1QjL5BgrT2+4WPrhmt5YdapFwXxqqf0huudlvZLP3CakJGb4tG0JZFlkPcgnwhPRzNs8Lzwx50tQqiWmvB49FOZ7V+aAhJ4xG6VwKtkx701/XMed1ua8SD0gOKqDUAZORzgr62B0EOYqTUfIjql
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(66556008)(64756008)(66446008)(66476007)(76116006)(4326008)(52536014)(122000001)(8676002)(8936002)(54906003)(6916009)(38100700002)(316002)(9686003)(478600001)(41300700001)(7696005)(6506007)(71200400001)(83380400001)(26005)(38070700009)(2906002)(33656002)(5660300002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Io5qTITzwNIWkaL5ZltV5ozkPmFIKJofaUKd4RU5Hs1RA35bWysXAl5Vs7+/?=
 =?us-ascii?Q?Zg/m+t1hvKCHbGryYulZW+8hkqPe3xcYByKcBcUiPpulSA2/9jPoC02ulItc?=
 =?us-ascii?Q?dVRoKro5f03hjAZ81micE1tq9J2HW2pcgiZ/cWuixYeVf1P/qBjy2H4k6Tq3?=
 =?us-ascii?Q?56Rag/kgE6DhQNkztD3tw6sFaOPSrxq7P0y0QCIKLG+Fkn2qs7fnGfji5CId?=
 =?us-ascii?Q?tMZx5t1ObuJAZpY/ByD9dWeEjaJ8rO2Y7Vs+BtqrdeCYWpXBuNyQ8+MXyPSb?=
 =?us-ascii?Q?VY8uSiDBXH72ELQ0OFsribqy5u86S1OyDU+U1cKF7nDisoVnw6vR3dTu8541?=
 =?us-ascii?Q?uS+jzMdmt9C3DgiKuNN9IcL5Jbhbo6uiDsSGkrk6AW1oFu/OlushDgae2Ory?=
 =?us-ascii?Q?wq2inU3ZrI59GOK4OgeqpOkJzuZadas/ftBPp/J5vw6luDrzm00HD7cQSUff?=
 =?us-ascii?Q?UV6jZqOxZKFX8+DCfgbHAqbfGXOhpUiEylDC/CkNHxgVykPEmvLa3bHrrLyX?=
 =?us-ascii?Q?uL3a5c8rRQum93jA+V4byqUmnhcgvgoy3iueyZ805CrfOorFVvOpGLIKy2IQ?=
 =?us-ascii?Q?q4lizbbt8IAo8T9PClSBb7FCFnvnBp+ajyNSlVdZgKU2+f8OEa/xe5QKDzMD?=
 =?us-ascii?Q?gxNjaWYMw6rvzxvalo8AKXNjqdeQ36qxPztpOReyamwiDWkf7WTYWNgIJgkJ?=
 =?us-ascii?Q?z79YKAfsxOIajIITT0nVNyuEFpqWoBH23L3p1wEQv8dd8OaLGcYaixDXFLei?=
 =?us-ascii?Q?ZUwYztanDxr0mhDCcM0KSgK7r/xBfgyCfKnTum/GchzA5EbmQZ8fqzMX3P6t?=
 =?us-ascii?Q?/j3GhFfq2pmhARd3RLtXuxtNUI2NJre2NvIokb5VHp+s1QKSsKzdmEu+nbk4?=
 =?us-ascii?Q?Kg4PyiRhbPPcVnt6XFw35W+Ubgf2wGsoxtwBk6dKTRXyHSwMtCPmj8HCCJ0W?=
 =?us-ascii?Q?nz7m/Cf4Mzag/j7i9aVNXbaBDbOtGt+Pu/U6/8gfCitpki+3XSpbJvh242RU?=
 =?us-ascii?Q?IqrYv5uaf5tsJmZG6QGfdn1gHBFPTjnpBqNP33Goz8+ez/hPIqMn5/Z4R8DV?=
 =?us-ascii?Q?rKk4NQjVXiTqc6fFO3ogh5/tdycy/mjKhldIaWA0txfKRh/VKFM9ABgCmx0+?=
 =?us-ascii?Q?EQSjsQexl0JJLXRypQuDj6ahA3KKJ0dWbDf6d9Y63WT3/YpgOhNfQObWqmOR?=
 =?us-ascii?Q?/Vx9man7Ws04THLGp13bXQhXqmOvpHceF2x0yvwwGbtDdyUSDMjdo+NHujX7?=
 =?us-ascii?Q?GjirPqLfb5cyQzfakD+MsnnU5d4VNioFuBeH4ujh8Ih1EiEhWbmemnI6bUBi?=
 =?us-ascii?Q?nET+m84J/YV9ZQ2lPR0BXPg6rgsd3KX3MJ06eWksRM1j/JQZO5b9f5w5DIBW?=
 =?us-ascii?Q?1Ym/2hnfpfhhD+oUoygl5jz/g07u4Arm9i8p3GWZRaEftGbjJdkHKrouCa3/?=
 =?us-ascii?Q?Cnt4eWtoPCxS8FFvVNwwzcvO065WIpT9q1Fc0jgQgGnPAjt80JTpwfkVXAgt?=
 =?us-ascii?Q?K++SeQ1w4NNJvzm2NtFAUZnP8tcJr9mOuE9WJnClo0hRT4e/KtpE/jeilrXy?=
 =?us-ascii?Q?VUsW6W6jsaYe4xEZxSqX6BpewhFhU4t02x2o35Qe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f7fcee-348f-4802-1022-08dc17401862
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 09:38:43.4081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +KEhh2IiqXkJSRAAYtAdsBtp7DiwjyY9Lmwq64NS3Bdirr1MFFxaCz2798rui/LfBSpoLmKBhomgW3PLtSN+TWFdElpLMEpwiwqntNf74nY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7010

Hi Francesco,

Thankyou for the review comment.

> > diff --git a/drivers/bluetooth/btnxpuart.c
> > b/drivers/bluetooth/btnxpuart.c index 7f88b6f52f26..20a3a5bd5529
> > 100644
> > --- a/drivers/bluetooth/btnxpuart.c
> > +++ b/drivers/bluetooth/btnxpuart.c
> > @@ -1036,6 +1048,13 @@ static int nxp_setup(struct hci_dev *hdev)
> >               err =3D nxp_download_firmware(hdev);
> >               if (err < 0)
> >                       return err;
> > +     } else if (!serdev_device_get_cts(nxpdev->serdev)) {
> > +             /* CTS is high and no bootloader signatures detected */
> > +             bt_dev_dbg(hdev, "Controller not detected. Will check aga=
in in %d
> msec",
> > +                        NXP_SETUP_RETRY_TIME_MS);
> > +             schedule_delayed_work(&nxpdev->setup_retry_work,
> > +                                   msecs_to_jiffies(NXP_SETUP_RETRY_TI=
ME_MS));
> > +             return -ENODEV;
> why not just
>=20
> return -EPROBE_DEFER;
>=20
> and remove everything else, no need for any kind of retry or delayed work=
 if
> the driver core takes care of it.
>=20
Wouldn't returning -EPROBE_DEFER make more sense in driver probe context?

Here, the driver probe registers an hci interface (hci_register_dev()), and=
 returns success to kernel.

The hci_register_dev() queues hdev->power_on work at the end, which opens t=
he hci dev, and ultimately calls this setup function.

In this patch, we are queueing the same work from the delayed setup_retry_w=
ork().

Returning -ENODEV (or -EPROBE_DEFER) would only affect hci_dev_open(), whic=
h is in power_on work context, and not driver probe context.

Perhaps, we should call it hci_retry_power_on() work or something similar?

Please let me know your thoughts on this.

Thanks,
Neeraj

