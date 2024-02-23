Return-Path: <linux-kernel+bounces-78326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E3D8611EE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F6DEB26D97
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DFE7CF02;
	Fri, 23 Feb 2024 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="T1Mw1dVr"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2112.outbound.protection.outlook.com [40.107.249.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619007BAF8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692631; cv=fail; b=f5dPQQvAZxETADHOxkErnx/X0Ts0inz2CKPpkm+iUDD0wF2e+36Z1eW5gCBm/cbeEeNpQsEKZKONHoLBtZ5YT7ZQHhKPjskRwASGEddJAUHD/hvI0l6o9MdCUy+Gb5s6h8Ft1O+xPYDsTwoSrwM6TSVbyKV2OSZ3jSYnujXo58M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692631; c=relaxed/simple;
	bh=IrrukdVi7ANm8NnEmG3IMidSBMCz3iXuwwHpUuXFkDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hUPfDOwsYFrzJG6fHQ5Y+KshA1tuKpO1b3pgy/ZOnfKKnPUs1/Ah3+1f216eh9qMT6eC+ZtqT07nIQW+dB2niwNlyPplGfFHsy4h3DkG88IaZv6a3Am9Q6ZqUIjtNYHYqdeedtCbbzCQXr0Oow5Mp5fjzWXB7rsyqDLwCeIzKZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kontron.com; spf=pass smtp.mailfrom=kontron.com; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=T1Mw1dVr; arc=fail smtp.client-ip=40.107.249.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kontron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwVdtubLa03DCqlGwyfEp5bSP7MQsICrLIkKEsWNlLQynbAFPEeu5C1V9dZpUu1X0E1M1cAz1fpzp520yRBz00fZNbz1bvvfNiFWJ0yMvnox+KBmryT0QDA+IZVMbeYt6UMcmAleQ7fHnedDcer1HqFpCifFL0Z+mA/A0QoSCYicWQMx44KQPQ9NMIWlE8pljwEZ1PUFh1yooD5z5XLk4EKECHf6/HRe28iRqKddtI+YUVFNWkQEXEyg3gH9PIy62bw4Q1mpeqPDsJKVBrzB/ZhSmSikQpaIryYWs55Ty/zafsCcs9ldvCvaWZoTvCXpMhvXiux+7lmUErhBT7E3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrrukdVi7ANm8NnEmG3IMidSBMCz3iXuwwHpUuXFkDY=;
 b=WaNe0VsWZxpQ6MXcqe4O8E9cOlmp8cWXI3ifbV0xH+vqpwv4GtlFFx9m7gUNzIBAQA+43gKF6LufJ1jlMY11zguIuxYZTlM6psg0hvVclltJknkIiORRaqa+b0ArFAp1+CFtX0KNpFaiNtN3JdFRD6hbF9wlcVwT6z0N3rkyrYWsqmzDKnfKmIVwSpTMJ2bT+9BncSHXRs86ZqvAcNburkwgnVfrmGFB/yCJLtXBXiAl8DyRH8kf+Kb2b9RjJGa8k0HNKBYl7o7G10VcuPAnJlsWotz3QZp6+D8lvGF9SVoSVhOcI2pB6KUKlgqcMAeLX3Zc10wVpX69zT3ZUBH60Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrrukdVi7ANm8NnEmG3IMidSBMCz3iXuwwHpUuXFkDY=;
 b=T1Mw1dVraGHjwt59zMR0nituxGsW2Vf6xre2bFSmsZ+fMziwnFldQMT534puHxRaI3RXw0f1EWwjGGL/jNnElwlpOSOyxvHInx54hkbBVtsLf7QVR1/0sUptQSqTwIOVqyUPfIEc7npKQRIlfFW3rm7GX+8aUvNHvArnCsCTypQ=
Received: from AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:591::19)
 by PAXPR10MB5735.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:249::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Fri, 23 Feb
 2024 12:50:26 +0000
Received: from AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5208:477d:77da:84f8]) by AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5208:477d:77da:84f8%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 12:50:26 +0000
From: Michael Brunner <michael.brunner@kontron.com>
To: "lee@kernel.org" <lee@kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>, "mibru@gmx.de" <mibru@gmx.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: kempld-core: don't replace resources provided by
 ACPI
Thread-Topic: [PATCH] mfd: kempld-core: don't replace resources provided by
 ACPI
Thread-Index: AQHaZOjnqjSdKUSjjUiE5C/QNxRHxLEVDr0AgAAEVoCAAq/0AIAAIOSA
Date: Fri, 23 Feb 2024 12:50:26 +0000
Message-ID: <90a654846eb9de78e8beaa072797561c9ced6726.camel@kontron.com>
References: <09855448430a5f090dbe09cbb269959a08881ee7.camel@kontron.com>
	 <8ec638c2-93b6-48e4-8ac4-965072b1d5af@roeck-us.net>
	 <de6bc09c779a4b4fa2ddaa1fa3a595de323b7f5a.camel@kontron.com>
	 <20240223105242.GR10170@google.com>
In-Reply-To: <20240223105242.GR10170@google.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB7551:EE_|PAXPR10MB5735:EE_
x-ms-office365-filtering-correlation-id: 779ba620-a5a1-49ad-df0b-08dc346e01f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FFzQh/LrnvTv0EhACI1DDIXuRFt+7aNA1+ce+TwRfA4JgVg4/fsfJ3HFNyz1zhUfme/jzNqUYYC7Nh/sU17m/0L2BJUXNBwoK1Er6P+LBySd5C7scenSWnslY7ALPEfdLVBuCCDq0M1nYKpxPiThhvUyuz3JJL4/wF0vcQL4ls0oaJp+ap89nVy3w8+uPKQzC2cNLY92y+oPZ7BZkOf02cCE2WqjcZd3M0/GR+cINK1LJ0smgD0I5SAdIGGZ9HNesHyg9zulf0WgPmLJd35lTTtPOsZPOuAO4f+LCB8br2o8F4FmeoLmN5N6a2jt5YlcRCHf/kny14ecCBdsjSkihgI2T1wLoJKUe0E8Hpa8IT9I8CS5+uxhOGseVe/3xxqHR1CvJ4/SAAk0mz/3INqhxGCtOy0Ng4v7tzhgggF3AVHKHMWQN21p0mN569yQQb+z/LzUiO3n2R7fKtFGWyyVYSyc8oCnRi7R4hM/qdDI06GstoNuSeIcoSoe8E9iKfoeogBK4ZDOQHrV8C/Q7xV9zE4l/SVEvD6EFg6cXdzOXM0WUW2YpvWuGK49d5BNMkc6/bz9p0aBNuh9LjsyveQyoYQgucxq+u8Q/mqZeG+N43+FyDQ6WRTEwErKREUrGCKl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-15?Q?6NdIqPsAwWuNVVi+TppJnAnY27/a4WK8P3m/BfzSyfZPYpDcOhFSl/LoE?=
 =?iso-8859-15?Q?bbKV0l78m10/xbEpbA2vCvVMc2YeY6pvIBkx5BaOkcIyPWcx1Q3tFr88r?=
 =?iso-8859-15?Q?RB3rZiCE5PDuYX4MnHE+ESp5/Y3vLzzLJO/7x6vvtxnywV9ZnuJ3OBp33?=
 =?iso-8859-15?Q?WnduIVVzCT/vyGIcGgoDbMkZkKCDseuR7vl234Fn35zM4wM3aFDJQ+OPr?=
 =?iso-8859-15?Q?yXUtJFa2dtVR0vX0YGWeeE92C4PxY666ljSvxp+Tc8AoodthRwcwl2RCe?=
 =?iso-8859-15?Q?vCGQNdLQeR0p/wVr1VRPl4sIO+XmIe1tRqeqJ9HcQ171itSk6hK+LVU+o?=
 =?iso-8859-15?Q?UxdeaKLxuN9dRTeela5wLuc532u5ozpXD9U+nkmXhalgwcXZGxOCfUCx+?=
 =?iso-8859-15?Q?R2Hi8mdEmzs10Rrid65rupKEJ9j6xKW2b1MJGkOH64A/KwkfH791ZZo+7?=
 =?iso-8859-15?Q?93Gnu0Kn1aro2y1Kx3MWOKdqGNpuEmftbX/hOEPBDVC2T3cboOPmTyuNq?=
 =?iso-8859-15?Q?Zdc42vMFcw0NhLzaZHgtivOyrel68Ue8ukrdt4+h9TqrtPFU+INaKbc1m?=
 =?iso-8859-15?Q?nj9vZ/DHCHqkDcO4a9fTz6rhzA8AI0AK24el/mP+QGYMhAgXsbuV8DwTF?=
 =?iso-8859-15?Q?v3rkIDkP7gP7XVbKdUoMCgfbqOXpLKIlWRplfNRZShCscWbrtcSzFvNN6?=
 =?iso-8859-15?Q?rixPugKUHD94EDN/rkJIpNOJXhOX1CND25hBhnUTur8tvqM3OOmPS1zil?=
 =?iso-8859-15?Q?s80xqvpBIwy0MtRMYAVPR3JtiQhhN2vBU2ZTS81/HyEAvfjSmOULPzYbv?=
 =?iso-8859-15?Q?I+8x6GypW7qCqNLr7m/oo8/yCdFGF/gss7igdiZDPWdKCYUIeawgURFrL?=
 =?iso-8859-15?Q?n+/nA/xJG/Q9sprw7+yJT/vQczCE0IJJawQNy+vabcwATgCmL1I7emh5Q?=
 =?iso-8859-15?Q?t7uG9qDPhJ8rwI7cI6FZRux7aw580ZQO/epi6LqvvYipGS1F0fnu3JvC7?=
 =?iso-8859-15?Q?KMvhdVl5QYQ4KgEHBLMVAl8XXZS4T531z04d1IAO1lCLoNyfiRxE9koBw?=
 =?iso-8859-15?Q?JJOhVZdCXgAS4AcF5A1KsM3XO6HHcZfQ52WynC2Jeqkvy9rs1AQ47DNdz?=
 =?iso-8859-15?Q?aUm7rYxvoATRwt/N+BSgdRfbiEQBdr8n3tvQxI6qv0Woz9YeL54gSQLDU?=
 =?iso-8859-15?Q?2XVAJpPzWuGQz9yc3Dy57lB3K/r2lqKl4NH4ygVYfq6pKm5zslIk+J90k?=
 =?iso-8859-15?Q?VHKozRR9wFGd824NnlGPpQfdPlYk3vVi3G6gMudsfOZJVSjzlkuPPtfAS?=
 =?iso-8859-15?Q?JNpFkEmycCj2MmtEChmKvBJiBUuB/raA5gPrr7IsPJGXeBiks3dKgGczL?=
 =?iso-8859-15?Q?vMu02CByyfhjjReT/qxV6cSasGIosGEF8v1cty+r3IU5Zs44chmmzzrla?=
 =?iso-8859-15?Q?XAb+bonx6yCNg6Entww1rBXfNnEPOVXGCQV0H0UKEfufMOdzcqougi684?=
 =?iso-8859-15?Q?gH3FoqLAbizkbifQ1mL1zs3aG2s3Z+ZxjO1Ml5HKwWl20fJY/GGTO0ENr?=
 =?iso-8859-15?Q?6mobPXu7j9ptQoLE8wXyOJoigussQodU+pl2W9QbrGuEVkFll0jxKLtaR?=
 =?iso-8859-15?Q?tarp8VQfNqkO6oclEpfbq6+58AuMVpME/vgRF9Wp5I/7mMOb9MS7CDJSS?=
 =?iso-8859-15?Q?X9epeqvendlKfnrUZqWssPdWCfpFFrgI/tVOH8Vdx951GRU=3D?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <F982AB56BBB0114CBED7F1AF96BBC914@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 779ba620-a5a1-49ad-df0b-08dc346e01f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 12:50:26.3399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +IUjzLbYhhq9M6/SJVH+1MeDFRSY7OMu/YLUjwLrHuh/CaInT3nKadGIf3UD1r9s589pBFKM6a/2nPxjp0rsfGAp5X9GljvTRoxRWDBSKx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5735

> On Wed, 21 Feb 2024, Michael Brunner wrote:
>=20
> > Added Lee Jones again, as I erroneously used an old eMail address
> > in
> > my original mail.
>=20
> I can't take/review patches like this.
>=20
> Please [RESEND].

Thanks for the hint!
I resent the patch twice, as the first resent version had the comment
garbled. Sorry for that.

Hope everything is OK now!


