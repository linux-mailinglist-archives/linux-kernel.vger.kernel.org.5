Return-Path: <linux-kernel+bounces-36903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACC783A873
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06721F21DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC575674B;
	Wed, 24 Jan 2024 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="NLH4gs5V"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2060.outbound.protection.outlook.com [40.107.113.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831FC55E5D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096674; cv=fail; b=jVYgebjMgNQQjuIewIZRmSwGMCVOgSC7GZFRXpR36sNcfO8Jmp6+d2BpcH3pe/mbSRoiJtrB8Ao/UDMH+HQibdI6ys7zwqtg0qS7sxCo88dbVSl5V9QSIzCjOtqAXgMbR3qFRF2U3bcx4UeZ+KRE8Bd02J5EpIfUkYsS79b1+D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096674; c=relaxed/simple;
	bh=59enYh//gCJnTtRmZt/SM1OGFv9Gc4nReuyqhKN83nk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AmMrHOu5nvm9k85N1qEEIU5W83nq8lzGbCoSrOONlDpjDdqnk1u6oBrYffc0AMVZUBbkqg8c4RXhrwhswzAESRt7eb94CRYSr7yb1XYH1ZtBbqN/SROjx+nISl3gdIpx6vcQon8APredxqRvwqDj6HT2VMutC1tN41YiSWOXV5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com; spf=pass smtp.mailfrom=nec.com; dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b=NLH4gs5V; arc=fail smtp.client-ip=40.107.113.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwxwhSUqxSvtNM+gtzDLjB/lSZpNqnF8ckGDGlZ2Rxcz91Jhx4/GwH+4CqSHnQNTNefQx525F3ipu1CYnRLiiCV4Bsh/BFJmIRoahPB+NOHdGp7F/KzoeeKDW/euTSLlWsPikUWv47CznB+JBLi35v/7EhraZ8ruOFrfUyI9s/aMrT2ZpAp8fJZIcRJpVP/k0q6t4ysaJDuCY8wj3q7J5xMzAzk7DHPpUMYWR7fwG2r5I1yAQS55leuJcYxQavHgFO22ntNfmMzDg/Qzp2vG5qVO6qaRppB3zuziMR1EW+B77J2b3wMeZk5wnPH+UvTk54Tklh/9ufQy9kKiSLVMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5uHMIjj85Zks5g2mqAxZmbtYahLFaD1mgxDDPu2DNo=;
 b=LeA4TZZwyXL1QAK9+QMmWM5Pp3IWnuZBNlHpSWBn6Kfcg+I+eV6kVzul79jAKQTfiHtMAKT+TZ3NL4d3DLxw/HlvSfYcKMymZuvI2B8FztasSR9F3ZVFXzxYh8lnvECPThNId7s8RXGum8yj/lR4eXTgSP3qEXEzXC8ibNEB6wh796CIxk8vo9kPYC1TS0xrXZ+NjqviU+mUAtRVdRb0C5obB9ybuUrecU1R+8fYi6ke71I58wx/ojYLDcbJEInRdgviB6rLvyP0rPXwXDQpMyRTVVi/vwr4JKgKcC2conasfuZpZYdp4gKPs1RiBgvMFo4+nMlLIpdSwjHOsHo3aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5uHMIjj85Zks5g2mqAxZmbtYahLFaD1mgxDDPu2DNo=;
 b=NLH4gs5VD34yRSQ01G7p6Y2lEG83geZP5xxUCNxOUbXkh/7KWDSH3fTBX4Tl7hqASZCb1bpn5nCE3zvGnMOFNzhGLEz0l1nVnvRKxw1VCX+JW5I5pSOtNFeH5h4smCYYczblEXrC3XlkZyYGiscy611PwfVo0D2Z63Nc0+Se+f30xY4H7Qli2NVw+iB5osiq4WyOz5q2empcXimt4L02zER16w4c1DTGuSnOx3DaK+2y6tJb4N0GQHGp4zrMm3ggbRNS524YUpMCDutEJ+wCeyYSq31Dm3y1CvyUh3JYQ9qqEfJDf3oqxGOg63WN7Pa516seI7z/xAMDMfLiZQvouA==
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com (2603:1096:400:15f::5)
 by TYCPR01MB9908.jpnprd01.prod.outlook.com (2603:1096:400:20e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21; Wed, 24 Jan
 2024 11:44:29 +0000
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::1d90:2d0b:4619:5a7d]) by TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::1d90:2d0b:4619:5a7d%4]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:44:28 +0000
From: =?utf-8?B?Tk9NVVJBIEpVTklDSEko6YeO5p2R44CA5rez5LiAKQ==?=
	<junichi.nomura@nec.com>
To: Borislav Petkov <bp@alien8.de>
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "ardb@kernel.org" <ardb@kernel.org>,
	"david@redhat.com" <david@redhat.com>, "nikunj@amd.com" <nikunj@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "debarbos@redhat.com"
	<debarbos@redhat.com>, "jlelli@redhat.com" <jlelli@redhat.com>,
	"lgoncalv@redhat.com" <lgoncalv@redhat.com>, "dzickus@redhat.com"
	<dzickus@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] x86/boot: Add a message about ignored early NMIs
Thread-Topic: [PATCH v2] x86/boot: Add a message about ignored early NMIs
Thread-Index: AQHaR5EAWHIL4WxRGkaPN0LZEAQra7DnTtwAgAGVKrA=
Date: Wed, 24 Jan 2024 11:44:28 +0000
Message-ID:
 <TYCPR01MB8389C46BF755C31EACE8DB37837B2@TYCPR01MB8389.jpnprd01.prod.outlook.com>
References: <ZaEe8FC767f+sxRQ@jeru.linux.bs1.fc.nec.co.jp>
 <20240112120616.5zjojjmjeqg5egb7@box>
 <ZaTziftQSSg/v5Np@jeru.linux.bs1.fc.nec.co.jp>
 <20240123112624.GBZa-iYP1l9SSYtr-V@fat_crate.local>
In-Reply-To: <20240123112624.GBZa-iYP1l9SSYtr-V@fat_crate.local>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8389:EE_|TYCPR01MB9908:EE_
x-ms-office365-filtering-correlation-id: e1a4771e-ac77-49c6-ad0b-08dc1cd1d2c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ljUTXszptwxLqGvirl+iMKp9DysVstobCKiPzSWoC5DtNEztFXc2RNn4tqhqJxKpwS0IgYP5J5jXx8ciJJpS9hpO3vJmda77sd4y1xrebnuHaRLzkA8YIuaoTxBRbt38Q5H84xAhMPYOHskd99nB8IwuLPzhEB3Aer+D+zLkMChVF0Xo6RyzJwAtyxqC3hXAi+4djCeapyk6oCRv44rIOhbiNO+oOPd0KSpMlJmm4LZNdgn11C8vLQ+aq2EVBYNGuK1ZVfg3JwVLt3GkKr9SoA2pATQKQ+e3zE9G3Uzx1e/tdPsa+3c+LENTuFxULAZ8wMbQ/JSA63rGtekJ6SgIFUYr4zCqAvD7fz9ooDLfpLY4VXWSSqExtbLog5FO+1pWWL/E/qvKq7cYgJ4rwJD+OE6k/P0dMVxizCYkewhrgSGr/cQciPzIjKtIVQrMQbLSW28Lo/wpv2p6STV1HXJkokh+anHO2oGvVZI0q0sDEOH73cp5W/R5h2sYrOsFBsN1Gfsb+E3rdqYdBDApungr+1lRuFIBl9UsAwVyiwc/L5P+tlnTIdfpGx5J/Vf4walqIq06CiUmK9tH1/AOrx33dAP8S4yOGGcMkQkZ9zaT/RjaUuLU7dOuCmLt7TU/04IV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(33656002)(55016003)(55236004)(478600001)(85182001)(86362001)(38070700009)(71200400001)(26005)(8936002)(99936003)(82960400001)(52536014)(6506007)(38100700002)(4326008)(7416002)(4744005)(8676002)(54906003)(9686003)(64756008)(316002)(7696005)(6916009)(5660300002)(2906002)(66476007)(66446008)(66946007)(122000001)(41300700001)(76116006)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RTNGNVdwa0lqbW1KVGhYUFMwV1FWMFY5STFJYXJaclk3T2FBSjQ2SHh6Q1N1?=
 =?utf-8?B?bGNmZ1hVVXJDV3dWYU14QnBSTm5RNkxKSTlwVTYwdHFFZmN4SjBpNGxBSFpy?=
 =?utf-8?B?dG5aOFB6NlNya2FZdmNGWmNQb3doTmVrZmVGTnp4bVJOd1krKzE1ak5aY3dw?=
 =?utf-8?B?Yzl0ajRJY3IxM2F5MUM4MjJXTy9RMmNvdW5KckZ1STZWT0xqektoQS9yc2hM?=
 =?utf-8?B?Rlg2WWxiOWJpMXE0L1J3WDYwLzZTazJZQnRTdlhYaDhseEl6czQvdFJvYW1W?=
 =?utf-8?B?SjhtbkVEYkI2RFd3OEJiZlNkeGRJQnJaZGtHVk54ZW5zSG9PUS9jL2d0SU9l?=
 =?utf-8?B?ZExlZUZkZEF0SG9vS0s3MlZRQllIUmxPOVJTbUNaT052YlZMeUNodE1Xa3JH?=
 =?utf-8?B?bnYxdmRSVEV4bkdNVElUaWdwdnhGdUJycGJ5YzVhSytnSWtOYmlMdFRMT0RB?=
 =?utf-8?B?UkhpZElwRWh1VDJCNWtTN0pHeUFzZ1MzbHVtUm9OWWpqQklmTFAyZWprM3FM?=
 =?utf-8?B?dCs5Zmhjd21jWkVIQUs4dTZiV1R2cXpIQVcxcGpuZEFaNXE0eDgzbmtSUm90?=
 =?utf-8?B?VkFtVU5MM0xqSnM2R1RXSGFHVDNrd0hpTVpzaHVHRTFERkdmSStmbnBERUh1?=
 =?utf-8?B?QUpHS1Q3ZGdZMTVZTG5nZUZSOThmZzU2RmZIYXREOGVoeW5vTlpXUCt1WS9k?=
 =?utf-8?B?UHVKYlR5ZWY2WURFODNhL0pXaFZNalZZLzZBdXIvaDdDQ2RDemRUUGp1eHhu?=
 =?utf-8?B?c0ZYS3M3SW1UcEd5NUZnT0szRndoQXN2eEdERHRmc1NEclJzWmdNajk2cENk?=
 =?utf-8?B?K3lRMWNxS0VITXJkNHg1aHh4dTEySU5ZaW5UOTM3Ymk5d2VjODIxWTFFL3lS?=
 =?utf-8?B?cDFXVkxSVEhTbXRYOVFBQ1NsSExsOHNqYUJuSWtZcDhkNng0dDRzU0E5Q2l6?=
 =?utf-8?B?cGxQdVFZNzdZdzFpbHZwbmhQVE5MTDRldDBadW1WMGYyVUcvR3MySVczUUw1?=
 =?utf-8?B?TEtpeGlzQ0hSTVV5NTJNQlBPRXB5N3pmUkZ5d2NhWUVJNVpXcFhPTHJlSVpr?=
 =?utf-8?B?Qnl0SE9wcVZmMUpoZ1lGTGRpVnlyR2hTK09BL2tSaFA3YzUwNzJMN0ZuNjR5?=
 =?utf-8?B?ZSt6NHJRZVptc3pTNi9JeHVBT0JBM0tDZTF0RThTNTlsU0Q4WVdDTEF6UHZR?=
 =?utf-8?B?ZjdsLzZuUTJXTkNGdXVJMkxCNndKd2RCbmE1bUl0UkgzbDlpQ2lIVjIyeGRi?=
 =?utf-8?B?UUIzQXFxd2EvaWtJNUwzNzM3Q1BQN3g0ajZTclIzc1R3VkNlY1J4TVpyZ0tq?=
 =?utf-8?B?TC8reWFiQ25lZ282QmNXb3JRY2lnRnNtU0tLaUgvQlRsb1dyTFFUQ2Q3NHFC?=
 =?utf-8?B?K283Rzh2NXM3dUx4TjVmREttY2JuZDh2cFgxM3U4NU5zSFJRWGo5aEpsN28x?=
 =?utf-8?B?OU5XcU5icHAxdTBwaVdtM3BOcjhSYlpDaG9YLys4VlpPeGtVQUdBVXl2eWFt?=
 =?utf-8?B?NDAyaXoydVNRSXB4WjRqZkwyM0xRMGYwM1VZcWhzYzloYmZxZ1dhbVVoNWlQ?=
 =?utf-8?B?b3FpbmdmZGZkWG9wdEY2L3V3ZkxEcWdxeWtCOGpUeUV4M3IyS3JFUHBUdHB3?=
 =?utf-8?B?SEhuUGJGZ1lsek1oMGhINEJ6R1BxT0NLTkhYRStQSE9XZm5JY0dVYndqTzNu?=
 =?utf-8?B?VTBxVUJ4Y01oUTh5SG1LYmhGdTloVzBoNHorQ3BTRElVNVBBa0RuVEgwZG1s?=
 =?utf-8?B?b0hWQ1dOUVhBZ1JEV0NuK244QnE0K3dCSHFUWXI5TXNHMlY4U1lVMmkwcEpK?=
 =?utf-8?B?c2tsZjJNUkFJV2szU1RBcnhKMFFtRXQwbEgrL2FEMlo4L3ZaSjVXdXYva2Ri?=
 =?utf-8?B?Wi9VeXI4RG5aYm42bi9KS2gwWjR4MDQwT2JCd2txVTF3bXFEWllrQmlXNU9v?=
 =?utf-8?B?ZzZCTGwwc290YmJ2NkUreUJaL2VQZ0FqcytjaW8xZ2xUbHVvamJjekJaeWsy?=
 =?utf-8?B?RWRkeTZSTkl1czZxLzMyQ1hzYXpwOENEYUZFNmJ5Tmo5R0FGYlhzRGIyWEJu?=
 =?utf-8?B?ajlPVitjVXdaQTRBblk2dCtMUXBOZEFLdDBVKzV6ZjM1bDIxSGoxd0MwekFX?=
 =?utf-8?Q?+4NpWrTiHrnjvNdrafg8p/fVT?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_0276_01DA4F06.1F1AD060"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a4771e-ac77-49c6-ad0b-08dc1cd1d2c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 11:44:28.9176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R9vvwKr9vIK291rmr6AsX+T70/+GJzON9eo2UMa7U+HsQiPXeZYA/VdTAFwDCcuey2Dm6iN4uA+ez0ygxDWTMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9908

------=_NextPart_000_0276_01DA4F06.1F1AD060
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> From: Borislav Petkov <bp@alien8.de>
> On Mon, Jan 15, 2024 at 08:57:45AM +0000, NOMURA =
JUNICHI(=E9=87=8E=E6=9D=91 =E6=B7=B3=E4=B8=80) wrote:
> > +	if (spurious_nmi_count) {
> > +		error_putstr("Spurious early NMI ignored. Number of NMIs: 0x");
> > +		error_puthex(spurious_nmi_count);
> > +		error_putstr("\n");
>=20
> Uff, that's just silly:
>=20
> Spurious early NMIs ignored: 0x0000000000000017
>=20
> Would you like to add a error_putnum() or so in a prepatch which would
> make this output
>=20
> Spurious early NMIs ignored: 23.
>=20
> ?
>=20
> So that it is human readable and doesn't make me wonder what that hex
> value is supposed to mean?

Yes, it would be nicer to print that way.  I used the existing =
error_puthex() just
to keep the patch minimal.  I will try to add error_putnum().

> Btw, please use this version when sending next time:

Thank you.

--
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.

------=_NextPart_000_0276_01DA4F06.1F1AD060
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
aR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYjytEdvfkxz1WtX3SjtecZR+9w
LJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0rpD8KkPj96sy9axzegLbzte7w
gTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG71gpLdB1ZhP9IcNYyeTKXIgf
Mh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyfG8lUzpUNZonGVrUjhG5+MdY1
6/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mvSa0te5Q5tchm4m9K0Pe9LlIK
Bk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc4pgkQE5ShxYMmKbPvNRPa5YF
zbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0x3FFTnmhU+5t6+CnkKMlrmzy
aoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4wggF6MA4GA1UdDwEB/wQEAwIB
hjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcUAgIGCisGAQQBgjcKAwwG
CisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBQAKTae
XHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi1xzWx/B/yGdToDB7BggrBgEF
BQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9yb290cjYw
OwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L3Jvb3QtcjYu
Y3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vcm9vdC1yNi5j
cmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4ICAQCRkUdr1aIDRmkNI5jx5gga
pGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcnbHUStur2/nt1tP3ee8KyNhYx
zv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79YIgbYWATB158tvEh5UO8kpGpj
Y95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1Q3BTNKSrHrZngadofHglG5W3
TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXrdJPKadpl4vqYphH7+P40nzBR
cxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERgnz6SLCjLKcDXbMbKcRXgNhFB
lzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75AI2v8qwFWXNclO8qW2VXoq6k
ihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4mEPq9GsPPQq1UmwkcYFJ/Z4I
93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb5CYPnt2LeiIiEnh8Uuh8tawq
SjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7ZcnuCzCCBrYwggSeoAMCAQICDEaH
sr4bt0RnJ8OJezANBgkqhkiG9w0BAQsFADBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFs
U2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMzAeFw0y
MzEwMTMwNjQ1NDdaFw0yNDEwMTMwNjQ1NDdaMIHSMQswCQYDVQQGEwJKUDEZMBcGA1UEDBMQTkVD
IEdyb3VwIE1lbWJlcjEOMAwGA1UECBMFVG9reW8xDzANBgNVBAcTBk1pbmF0bzEcMBoGA1UEYRMT
VkFUSlAtNzAxMDQwMTAyMjkxNjEYMBYGA1UEChMPTkVDIENvcnBvcmF0aW9uMSgwJgYDVQQDEx9D
Qy0yMzQwNVIyMzYyMTAsIE5PTVVSQSBKVU5JQ0hJMSUwIwYJKoZIhvcNAQkBFhZqdW5pY2hpLm5v
bXVyYUBuZWMuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3A3JDZBygNMzTo6i
Ssk4sfKLVAS+Qmaa9jvJJnkKWFfS7EAhqsY3q8bxISaFka2EVo0ZWa5ERQf/WzD75WnSPpI1Gr/V
IPUos8DmB9a8SoPqf9/eRSOqG9vpk8aA1I+6UgvdAe/qeeGDW0lHxsdAZ6/HwAmclwMreKyZ7thE
O7DsknbqYvk3Xmv7JhyfsxQ/PTd/Q2SUzdNtftGl+n9QTvJZ9S1tN/R+rqPDIJey0Gw41yZ2F9ib
sGvlWc+1pUULr670xx8WAEN3FZAZsbB/ogMtyCL1eH/abqiTllfiAZZjQWUeXvT1q+3cEMr+Gap9
BuX8n1+ylZByb7wXQ8myCQIDAQABo4ICCTCCAgUwDgYDVR0PAQH/BAQDAgWgMIGTBggrBgEFBQcB
AQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQv
Z3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2ln
bi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDATALBgkrBgEEAaAy
ASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNv
bS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEEGA1UdHwQ6MDgwNqA0oDKGMGh0dHA6Ly9jcmwuZ2xv
YmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzLmNybDBJBgNVHREEQjBAgRZqdW5pY2hpLm5v
bXVyYUBuZWMuY29toCYGCisGAQQBgjcUAgOgGAwWanVuaWNoaS5ub211cmFAbmVjLmNvbTAdBgNV
HSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiw
oJIwHQYDVR0OBBYEFGt3hQiwRuOVQpsnbpZxYwip1PsnMA0GCSqGSIb3DQEBCwUAA4ICAQCfb3uN
tiplDwGA5LL5G6h4ZMVNEgETMOeR9pX7gXekL8iiDnqRk/lJi1aPEUQKu0kq56rvQS/SWFb03jU4
Wj7dcOlQ+wS/wdMnuYk4XsD37r0skdDN1Vmk4ZJTpPAS8OHjhnpAByLe3pXKka9JVb4J8ldoUTaa
Z09i5qmNzQiaKp5eoHPKu/p6O5i0kIkpI+831iYNk5/FgMKt37IcNf6EnxYKIbv2KYF1SrveMPOC
KmZrM6Ta5wllsi2TNwUGN3/9t4bHmz3fxdT9zZu4Fwewt1/MRyXHSGVFHZg1/h3k8Ap7DlZRgLQa
WJnS0JIpRw8DYK5uY/AY8noxGkcbor1Zlp2yr1uoHejAEOILvJFoOxWjvfCI7J06oAPXhKs+KrMZ
1cV1PrjORjU1pl3U+8Q61akqJhYi0h/aC6M9otXYvtNPgJv3rH6IuEJiPM+Dvy+9Xj3H6pKgMy8p
tmSGcwOZcdYp8dRP5fe5rK/h86jR1JfOVHpl9vFMeNHYqINESzPrLZ7p1Pp7lxoarmJWrpLT+pn2
t9W917wbVKHHHQ/9ol/8UZRSfAYxdc3Alz7DI4EoZJd4qBTGLHKXTHEJei0Is6mrIB1HmkF0CZse
bfTogx6Xd86TPTqCuGNKscLQJKAGbWehsA4CPNwDfjq1ipaSf22MXtgrI/eCogGOcN/+7jGCA2gw
ggNkAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNV
BAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDEaHsr4bt0RnJ8OJezAJBgUrDgMC
GgUAoIIB2zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDAxMjQx
MTQ0MjdaMCMGCSqGSIb3DQEJBDEWBBS7i9VHKIC482JAMCtauiQOw0oHqzBxBgkrBgEEAYI3EAQx
ZDBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9H
bG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgxGh7K+G7dEZyfDiXswcwYLKoZIhvcNAQkQ
AgsxZKBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQD
Ex9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgxGh7K+G7dEZyfDiXswgZMGCSqGSIb3
DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFl
AwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAhowCwYJYIZIAWUDBAID
MAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEA1asEWoZI3S8bqaGq
1YL3lkDTyc47mqxPY5ksGZ43IQg4LXZFc3f3Zij6kpD4FD0WtOsHlZMUXQhmhvv4tHLuhT8rA5os
SeNrhLN2abvJO1nqHNYbDSqBFiMUewlfrWvXmvzeg36SI7U4+K/fuGHvawPF2LdSI5LZsXVExz28
mewZIx5DYsZ7z9OJ5dNHOuxmj3Wu8r/sdcIWDsUDzib6JsnlsHPLaaKt9dPj6JFIZMwpODJ9oQeE
ch51wchU3F2r8eU3Xwkg1Al+H/NqCvA7tGBOBSu/lapcVGEOYoJG3upKwmOqJi5VM/L8woIzPtMK
LTRoy+ncJhKCySBE/vFYoQAAAAAAAA==

------=_NextPart_000_0276_01DA4F06.1F1AD060--

