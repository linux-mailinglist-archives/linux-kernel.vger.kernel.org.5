Return-Path: <linux-kernel+bounces-82064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E4A867E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC00A298840
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016DE12E1FF;
	Mon, 26 Feb 2024 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vP5fKHhk"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0344A12D77D;
	Mon, 26 Feb 2024 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968692; cv=fail; b=e9M7SUujV7RjGNapNKz2ECCtBzlBuDPo+elCCnBDYmVHpUX9GI0y8uCbyxKkyhffNAKjVq9YjcbQApk9GaYjOvo2iK96YDoTthMHn/Dexm472jTsTHSmeyfTgY88CBJT2uzTrpQuw9V8CIrFslwAYYO16nMHGiP7VApXQFYmth0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968692; c=relaxed/simple;
	bh=kYjFphgTWUYIH29nJu32BdOEgcph7fQhcYUVeTR7/x0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SSSY/VDzp42g6ykeobdvM4KVHZZzph4AjFNo6Fb6wlWhNfkMD6ZUFfzgnuRYCtgsqKrTBtBgTDCFaDQrVwgZbY0/J3+SL/TJ5HiFLl5W3qIoY89efAVA18CySKMRAcoVubjyJizONbO7rO4TsPOQKVFy8Qzvd+JB77ocL+zlmHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vP5fKHhk; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FatZ+nGsNVBL+uDKJlvkR3PsRKZUiSdEzmuUEH1nSe95bGPMnTTDjVbTR+rF8jEMPaKBAwyJsUSvtcx2dM80cdmXLPNPbhrlrd+qGp4yHNfvU/SjPWD1jQCZhM9YhvkzjkwBGIr14dcZBbfBa7dLv+X9FoX1AkF8qW0iy48F4hBCbIRDxv9UY6/H5/PCUhNQ0994VRPJfQZF4xW+/YKg13z+PgqESXBr9PKJcSHNGeVwxTkDrW+n5Q9PpMD4r6tla8MBk8QrTIJwTn3sCrXNQeVnwSZiSjuK1dE3url/uSZlzj/ynTmO2/THZm11vA00rFny2j/u1SBO724Aa9Ezcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcR5JItewXJrjhUN1SXtdun0NziJt6SObCLnwMRBUFw=;
 b=ldM/nxxp41QVFj+8NjPBTGjhO7xqv75/Hre7NMp8nXxdsTkvgoDFaAlxoUTq17oT/Aakg2nn65tnTTTHAU0Vnes+c054oAipSt2Fm6oTtxHQgwS9MLoBdW8XLbbWWAAhf5wxWjPwCDkx02vFi14xuwDfuCsJEHzLkEzhu5v7EjJisCzrajr6IzjOtwtDmh0XUmbpdBUWmDSHInKsBQrLYvFBwFvpiaUWNlctFEztiqsDTyL552qeyjmf/EunJs+pgKDXxnbMJGT/sx13P3tquFrOIA3k9gzb+mFNRUKuVUTxlVlpoBSAzKZ0pkVX5TeWLLKzSqf2n4J1nvT84xad4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcR5JItewXJrjhUN1SXtdun0NziJt6SObCLnwMRBUFw=;
 b=vP5fKHhkCmkWltpj76oZV8BL+xG/dhriBwz19ASgo55JdBQDYmEOe1KEMByoDh3AY0BlpYim4NUoQjTTIqkN7+JOWg5G0qk3wFuFd6Qb6jMnV8XtZ9qPT02qy02ewL8a7HOoegUHnUjhGx0NePJXcyEiAPBUGzMnAK1x5I1RfEQ=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 17:31:26 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::ca5b:3117:e891:239c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::ca5b:3117:e891:239c%4]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 17:31:26 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Conor Dooley <conor@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "balbi@kernel.org" <balbi@kernel.org>,
	"Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "git
 (AMD-Xilinx)" <git@amd.com>, Piyush Mehta <piyush.mehta@amd.com>
Subject: RE: [PATCH] dt-bindings: usb: dwc3: Add snps,enable_guctl1_ipd_quirk
Thread-Topic: [PATCH] dt-bindings: usb: dwc3: Add snps,enable_guctl1_ipd_quirk
Thread-Index: AQHaYEFhkwmQuNFmm0CifTb3wto0B7ELzNsAgBEkmpA=
Date: Mon, 26 Feb 2024 17:31:25 +0000
Message-ID:
 <MN0PR12MB59533C9B163F0A9997561C66B75A2@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1708023665-1441674-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20240215-crying-lunchtime-977afb05e45f@spud>
In-Reply-To: <20240215-crying-lunchtime-977afb05e45f@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|CH0PR12MB8485:EE_
x-ms-office365-filtering-correlation-id: 9ebb81c7-602d-4400-48dc-08dc36f0c258
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KKJy6zKNJ86wMukBetS5oeG+NCfMSW0WxULaWveSlUQqyL5gdkiPypgeMAESdbnEOASvuZ1e47uEcl/tXMVYW1FLgnEj9fD4J4Yt9xXLHKdSliu9Xy+qCHQsggBfDJ34/OcXhxXhujZ5fmEhZx3bLAVoF/IBVAh8RGQvDQ6v0bqR8nVIFwZC6p9JM7dkWiF79wxq6MYjvYnBja+r719FVY/zrJDJpj8jm2MSfCUv+2fYmijJ3XCbZ+p+5IirAOMiGyU/gZZe28ZRewZVDhFhrBVM/Vf+F6JKN1YBxtU2eeF+wrVQLIkiTFIee2Y1nyVY7Edq0IgsvheEFiHCPlWTQVa5c2+fcM6jWSzQ/r8koq9iUl2duvb/WfRHkxk+cPxNyNfVKWz4JLxUr01Ilu2GAfWwqPumd0MlsTP3En4WHqTwbyiElX1P6FgZwOBPoiCZY2H5K4tS0ZHv125H/mIAWnRd8PDtegyEHJc+DiZbtMJXripFcm9oQrqRUPURxG2QiyiogdKCjqbmOnp8j0wpXrDQaFnD2WIyVDp7rtgQlvTz5f5vWYFgh38FcQG9Fa1pf0w0QG9MEPPfIrvGCktiwjEP+hyVIRoiAI/XWnhRQ77S1cTAHq97F9UodiUaGTERXq5isbrIjBspKVdwd0L3M1AVXHUuZNpiIPdAbxSE1bn/XUNSIByXnkgy1he0+75RiVlt3kbLKyMos+E59wAhqA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uJuAjCYEvR4Y5MmS5BbN896r99fe80CVD6SHOaBPRaXv1bOEkCurL3O5ST5r?=
 =?us-ascii?Q?GI92buIA1B3Gspz3nsj9MfaMyUWcjAbeDPGoxFIGFGkLsdyQ/C7NOwxHV6pe?=
 =?us-ascii?Q?8qOMvUtCSjKMlJOE8TxjEBF/CVt4uk2TV4PXNkG435qFi0eG5pcqIWm1Zzyc?=
 =?us-ascii?Q?LaJdFyoMGKuU5xAsjX2c0llmGVvsncbwQKVtiKfK6+cFgTq9d13Yvj9IxKXY?=
 =?us-ascii?Q?HuTNTacpHgzkdIgwJQzrhrRM3VWy2H8eieaPmFDmWu1diZcxs7uAaWLPCwjt?=
 =?us-ascii?Q?djHSYEwAwdz1Uhs3anTv3zL4u8/UhDc7gkaMFnY9TVi7kaZygIOxLPIaf3Xp?=
 =?us-ascii?Q?TSZWwVBOL9kPhz9LvOXLQrrXvjq3RDtcxQgEQbEovrFAXBhPiE9BrvlhD2yd?=
 =?us-ascii?Q?z5G39Y0Tej2Dagi2FLBX1S1g679+TxL3tNU9lv4CKmLgW2dd/LTBAWikjXXc?=
 =?us-ascii?Q?Bh6dJJei5FWHMM3vrVGWcxuP/aG9dvVNFxcLIkCTF5faoC5YLrJnnpJkD1k4?=
 =?us-ascii?Q?Zkvbec9Hp6cgKXMYO2caU+4xjGQ5/CuGtTOcI77CYq4XHN9OByEhSj9nlZmS?=
 =?us-ascii?Q?xRzjXBnsOKnH6rKOsxjBilUR7KB5xLqIhbEdnXUnFFJTb3UNXiGMALZSI0hN?=
 =?us-ascii?Q?wkuYmm2kn3k/1rkGZ8gQA362togVYDjlxAZ+6XMpcHOrLQNqCClrN6+X/+EA?=
 =?us-ascii?Q?8sdPGHnS1R63+6Xxn7lo47ggKs/Hxm0IMiO9VQyLsVa+JEllha9OzhfirLot?=
 =?us-ascii?Q?A7czrtoiuQGwy8A9AcYrI0uKxwrm8tDHOfdUVJYR9qd/n3mI2Jrc5fg6cNko?=
 =?us-ascii?Q?0wCxlyWVIaHsmQAF1kCZocd5Ne+BZadOivPrq2mUzyc/khiOOFnoOC7Dn4j+?=
 =?us-ascii?Q?9/2PAkRm9ztOjnnBJirpOYVLmeus+vctKNIxlexwAUPsij/mv8JwUTMYB8qZ?=
 =?us-ascii?Q?zcVYaQgFWjCNp02rA0AJX6hhcZHFHdTbtLoBy3JgKILY3I+njv+J7x+2sMvC?=
 =?us-ascii?Q?mMGwAVbUmYP2g07bg/X9RBzd2nDeBiVRuMWWQM1djyP86bn4vXrHT2Tej9+b?=
 =?us-ascii?Q?mAteywWvOIMyo+m5Sor86TgZyPtJzhuiFd7uS+iUEPyzrVRdTc/jIRI26g+L?=
 =?us-ascii?Q?B8OrNdJh80IuGjZId9HNvOYWWoSlbAkzUro1wt94/Om+oPXeeq2rBpSmmfNt?=
 =?us-ascii?Q?zvYSz1rIyG2q4GBsBbANcqArpJLK/bxM/ANkfcgazfh3Go/WX5dSUJJ6iWNI?=
 =?us-ascii?Q?fF9nYprJ8jgWCzhQ9n/Nu0WEmAckBtDaCOhykvtgPWdT47bEE3EMXfjG3c+1?=
 =?us-ascii?Q?NMomstaPhzYU1sU1PU28jIUpFCAlpjzCjwNdyEi0bxUTNyrWWbsjbJEux5tV?=
 =?us-ascii?Q?ndMe5BibN6HFr0QM9xw5wx+NokouFVLUMC/j68lW0iViuSR7JuqgcMyCqA4o?=
 =?us-ascii?Q?NbNtQrBdzRGDPpazOlQzRfC2PA9B6cN08FtefwwsgJhdPWY4+sH8HdkrmByR?=
 =?us-ascii?Q?bC1dPV452O1G/V6nGC55aQAb1GU1smIHHB7edTFSlJ/KHb/8LuGgYGHSB1x4?=
 =?us-ascii?Q?euxLTs+13lY77BvocxM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebb81c7-602d-4400-48dc-08dc36f0c258
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 17:31:25.9839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTc8VY638NPv2uxKt9LJtxg+VxxBp3hgyXgits4Or5kp9jgZPAMZ7gxKNgcuuWdW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Friday, February 16, 2024 1:09 AM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: gregkh@linuxfoundation.org; robh@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; balbi@kernel.org;
> Thinh.Nguyen@synopsys.com; linux-usb@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; git (AMD-Xilinx=
)
> <git@amd.com>; Piyush Mehta <piyush.mehta@amd.com>
> Subject: Re: [PATCH] dt-bindings: usb: dwc3: Add
> snps,enable_guctl1_ipd_quirk
>=20
> On Fri, Feb 16, 2024 at 12:31:05AM +0530, Radhey Shyam Pandey wrote:
> > From: Piyush Mehta <piyush.mehta@amd.com>
> >
> > SNPS controller when configured in HOST mode maintains Inter Packet
> > Delay (IPD) of ~380ns which works with most of the super-speed hubs
> > except VIA-LAB hubs. When IPD is ~380ns HOST controller fails to
> > enumerate FS/LS devices when connected behind VIA-LAB hubs.
> >
> > To address the above issue, add 'snps,enable_guctl1_ipd_quirk' quirk,
> > This quirk set the bit 9 of GUCTL1 that enables the workaround in HW
> > to reduce the ULPI clock latency by 1 cycle, thus reducing the IPD (~36=
0ns).
> >
> > Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > ---
> > In the zynqmp public database GUCTL1 bit 9 is reserved but it is used
> > to enable a fix related to Inter Packet Delay in HW. The documentation
> > team is working to update GUCTL1 bit 9 description.
>=20
> Does this just affect the zynqmp?
> If it does, then you don't need a property - do this based on compatible.

Yes this only affect zynqmp. I will apply IPD quirk based on zynqmp compati=
ble.
There is related discussion ongoing[1] on how to do it ? i.e in core or pla=
tform=20
glue driver. Thinh suggested have it in platform code and I am working on i=
t.
So will drop this binding patch.
[1]: https://lore.kernel.org/all/20240223230758.s7rodlxbsfa44frw@synopsys.c=
om/
Thanks,
Radhey

> If it does affect other devices, what prevents the workaround being
> performed for all dwc3 controllers?
>=20
> Cheers,
> Conor.
>=20
> > ---
> >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > index 8f5d250070c7..b226457a6e50 100644
> > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > @@ -280,6 +280,13 @@ properties:
> >        xhci reset. And the vbus will back to 5V automatically when rese=
t done.
> >      type: boolean
> >
> > +  snps,enable_guctl1_ipd_quirk:
>=20
> No underscores in properties please.
>=20
> > +    description:
> > +      When set, HW reduce the ULPI clock latency by 1 cycle, thus redu=
cing
> > +      the IPD (~360ns) and making controller enumerate FS/LS devices
> > +      connected behind via-hubs.
> > +    type: boolean
> > +
> >    snps,is-utmi-l1-suspend:
> >      description:
> >        True when DWC3 asserts output signal utmi_l1_suspend_n, false
> > when
> > --
> > 2.34.1
> >

