Return-Path: <linux-kernel+bounces-39532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F30983D266
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D48F28CBC3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76E16FBD;
	Fri, 26 Jan 2024 02:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="IlCj3hhN"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2056.outbound.protection.outlook.com [40.107.113.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61A546B5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706235322; cv=fail; b=Kx7Wun2l5qLvovv0nqb6YmHoRIFkhzIErjg5mUoNe19H8Q53YW2by2QCQH0hifWNnFNi9N0wcGzqMDAdqg4mlUBPWgFfaLQwlqBOVB+Lr8NKc7fRNHOmf9Atr2hrqVKl1VEspo6tzt+EvNzgG8SG+z0XXjmrlmEZQ/LEum0BsvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706235322; c=relaxed/simple;
	bh=vjg5EdB5p6nFmwMuLIZ/bSdiygJTcPnDrVROPnGiscM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eDN1K5J1DgKNAg4VZfOTxuasCQ1aUhW68LmV9zvBYYpezKjIgDX2x+TgV2Z/NEa93TJBwa24qc27uQsJTX2+dXRmfD3IpXnd1M8Jy0IheLgk+wIk8PGRqDQmn3/AqdhWIqY55t7t0VxbE3XOqXcYrtzO9W/1F5T1fP4wQTvFDf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com; spf=pass smtp.mailfrom=nec.com; dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b=IlCj3hhN; arc=fail smtp.client-ip=40.107.113.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QItGUcoo3vxkNzpZkyCqKBx9orcAgOdPdz/vqIdY96ztYs4/DbOJLIR0Q3XH7yTlHdK1slLqkqRNfnNab2b7M9DDqW01nQ1FQQbiDILyyVhWHx0fd5jiixX8LBX30E/trJX10uRg3rOix5xMR9qiHquSbWKRFJ5IwRsNW0+Nmi8jmyzdCAtUM9UY2d52B1ecPBandtx0JvVAWi/KwI2bro8jWxy3DIL2TC6hWRjbsGnv+wlH/3O2VOGevTDqJze6RtLRtlLlUMJNv+SHMxxMcaKPhSSfMNYOGEcSzPFM6NHP+kvLqvRfCpm6IC0GB+AZBXrSevstsySTQ9sg28uTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ygVkLaxr+2PkDI8DR2w1j2nRVob8vWo6z7hGsPvGic=;
 b=F1B3C9P12E2G2pnFrIBbW9iotU4tnju+8Nxtnxz7LK5Bhf4JGuNMbFqlpiTpSreWFBHgOgdxmaUuWH0Yf2snsN72IYHLpX/xCCUr443uLFeDxv3F8rTkyqx4KWMRnlEjlGjec54kBOwToVycDp8Kin4KVlFIeQZ1FbfCQ9KFW4H4Id8ZRUk4MRNT5fshkqx2ZbnzrMdclYRS0EjbQRleg3kl/tzVlwL4MuOzZA4lWQizvh7v0V3SapewReQI52tJ07isvH+TcNeSk9J7/3ajv/8jzQvDK6Y7+GGFHkwfffefivTVvqf8FZ9EjQfxkTWch4+xvQf73B0iK4OL4b/lRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ygVkLaxr+2PkDI8DR2w1j2nRVob8vWo6z7hGsPvGic=;
 b=IlCj3hhN8InHUXp1c7MxU5j/gsZpwDErCpygA0Ybc4aM3E4vahJ091a+UhZPlkkdwuGqWHwM0vv9uZ0zru/PpguVZwbz0E/8cZhpWV7Coy25H86K2tgNQeWBrIOgt6KA7QClByCXHNBWBCgPvdUttNe8t5CMh9k/YTqduVi8MYXfn32iesEQSYTO9baI0xhVUIv+9kaY5U8LRqbuYhdr8up5Tc4NST52UkVpN1jmW251fZkdZ3A1C4QjSIpk0uXrwESWYaooiBcjY4He181aTzpkdNqSp6TV8/ODyzvC6rLExAzVD3LTs+ZPoifWoljbKhc0U2QzH8sOKrtUJomagg==
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com (2603:1096:400:15f::5)
 by OS3PR01MB8177.jpnprd01.prod.outlook.com (2603:1096:604:173::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.15; Fri, 26 Jan
 2024 02:15:16 +0000
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::1d90:2d0b:4619:5a7d]) by TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::1d90:2d0b:4619:5a7d%4]) with mapi id 15.20.7249.015; Fri, 26 Jan 2024
 02:15:16 +0000
From: =?utf-8?B?Tk9NVVJBIEpVTklDSEko6YeO5p2R44CA5rez5LiAKQ==?=
	<junichi.nomura@nec.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"ardb@kernel.org" <ardb@kernel.org>, "david@redhat.com" <david@redhat.com>,
	"nikunj@amd.com" <nikunj@amd.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "debarbos@redhat.com" <debarbos@redhat.com>,
	"jlelli@redhat.com" <jlelli@redhat.com>, "lgoncalv@redhat.com"
	<lgoncalv@redhat.com>, "dzickus@redhat.com" <dzickus@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] x86/boot: Add a message about ignored early NMIs
Thread-Topic: [PATCH v2] x86/boot: Add a message about ignored early NMIs
Thread-Index: AQHaR5EAWHIL4WxRGkaPN0LZEAQra7DnTtwAgAGVKrCAAPFTAIABlKBQ
Date: Fri, 26 Jan 2024 02:15:15 +0000
Message-ID:
 <TYCPR01MB83890E6AAACF90C3A45A8E0F83792@TYCPR01MB8389.jpnprd01.prod.outlook.com>
References: <ZaEe8FC767f+sxRQ@jeru.linux.bs1.fc.nec.co.jp>
 <20240112120616.5zjojjmjeqg5egb7@box>
 <ZaTziftQSSg/v5Np@jeru.linux.bs1.fc.nec.co.jp>
 <20240123112624.GBZa-iYP1l9SSYtr-V@fat_crate.local>
 <TYCPR01MB8389C46BF755C31EACE8DB37837B2@TYCPR01MB8389.jpnprd01.prod.outlook.com>
 <c0527ca3-22c3-4b92-a34f-adf0cae78146@zytor.com>
In-Reply-To: <c0527ca3-22c3-4b92-a34f-adf0cae78146@zytor.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8389:EE_|OS3PR01MB8177:EE_
x-ms-office365-filtering-correlation-id: 476a05b4-2397-4720-86fa-08dc1e14a2e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 syN9Mhc7saoOcvhF7zh7RC9p69P2LIus7Hg+2CwPUcOElOku95Zu/N+8QzHCeTFE0glk4Z9xf+1+YaP+dKEAhKoRbD/MSdsDs/Z/L/gKYuBjdtpLb60mIbOb9XyXzyeliuXB/Nuh7yuDN6a8Xg3RdDReXHZq6csTNPwACvhdn+52ujF6G9dIHo+0L1Gutc2s4VUXoBNxQC5XqMq1z5uIdUx4BvFLF4wCmqxYm+NCrRXpWqnd9Jt7Gjjv9vmIpdZxss5kTD5YY2B5iPXMW4KefahwMz3QGC1pSeQFA7OwmdVGziy/P9viTCYFxTcQYLGZgUVbOZwkfGBC+I7uKRxB5VibYyvy/IVLGJXvJHMpTmUPr8/UaEwmumdSR99EQtSfftPkbkvK+ZgAMynCwi+k1o7LQ9ot1LweETdREEuGafJZEmBSj5ALLbh4Jx1jZkYKQs9KNXU1kfQNbxp4T1AdTKONb3pNpSRsqUbMcSDbzVjoHb/OUxnQvEiGAXzQ06dsEMNOSwrMm+N8AILN7MwusiFRt4vhlCtdjjO5HNKRJICl5j7KvKVwD4AG+j/xW32lBBz1PfbzH7yAlHjU4EO+d77fnwZUM8cFrsjYvXjzFb1zP7aOiANCVXl9XULg9lLA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(110136005)(86362001)(82960400001)(76116006)(316002)(122000001)(66556008)(66446008)(54906003)(478600001)(66476007)(66946007)(64756008)(8676002)(99936003)(38100700002)(52536014)(26005)(53546011)(55236004)(6506007)(9686003)(71200400001)(7696005)(55016003)(4326008)(8936002)(5660300002)(38070700009)(33656002)(7416002)(85182001)(2906002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MlE3aFdWZDFzeXVBcWVOUlFmSVUxbGZpOExjMEFQYkVNSHRSZUZuYTJNc2pY?=
 =?utf-8?B?L3grbUlUaEpMS1pBcyt3VEVxRE4vcWRYTExRKzBXYlpWci9OdCtON2g4dEJR?=
 =?utf-8?B?TjF5OHJpM3R6cllhSW15MmdTaUVPM0xKWFB0citCaEIvcGMrZDRJWmxnV3JD?=
 =?utf-8?B?TGtud0dTS1NRSGMvNHZYUDFITU9RVXg4WDFVb2I0ZlBBam54WUFGWlNSWGhX?=
 =?utf-8?B?WXA5M3hxNXhqeVg4MnRHdkgrZW1vUU1ndmRYTHpSVm5OT2FrbWFRaXhFNng1?=
 =?utf-8?B?Mm1qOWJZQjBhd2ZieVE4Q1YvKzNWZnZLdElLM1N1dmxDTm9YdWkrSC9Pa0tO?=
 =?utf-8?B?L3lOQlpqR1NHRDdQUEJCSi91QmpWQW9MUFpjUVNRM3NkTkN2a2FMTmMzVGxo?=
 =?utf-8?B?SkJ0Ny9pa3Vrc1QvdWIyVkYzVlA4MzludU85bnF6NEJFS1RXdW8wRkhVUEtQ?=
 =?utf-8?B?ckk4T1lXT0t1cUhudUJqWnZxTjcrSkoxS0swTDcvUm9Tb2pBbzBYMzBBY0hl?=
 =?utf-8?B?QWdnc3VzY2ZhbU1Bd3JrdEpFZm1DakNIbHg4SEpBcmdJQVNneWFCR1ExRzQv?=
 =?utf-8?B?TENHb29Hc2ZtdkQ4a3cvUnVyQkUwTnd0b1NtQi9BWkhEY3g1cGRQZ08reVpT?=
 =?utf-8?B?ZWtJaDdia2piQWR6YUdjT1lWcDkyNHRSdC9yRjNyYzV4Q2xKS0UrdmFCOGZN?=
 =?utf-8?B?eDhIRnFNVXNIcUZxQ3QwY1BXOGRsbHQrVlNzSWRWU3Fuakl1aHJjcS8xS2Q1?=
 =?utf-8?B?Z0xBZmpucEZ0MUFCd3hadmp1QmtCVnJmUXR4aHlsL25MUDVZQytJdDNXZDls?=
 =?utf-8?B?czVlaVl6NG14R3hxZ0NHUTlXNWR2TGRkU0hGZFN3di93RXJUOU9mVkh5bTR1?=
 =?utf-8?B?UmEvQUh4dGppQXFHUGtDclhJS3ZjOUVpRnEySUdldVNYcnpxMml2MkZIdmU0?=
 =?utf-8?B?WUswS3E0RVZENi9vQWxqZ0RYWGtHTW0zb3RJMUtFdVpianVjK0EwRCtlZ1Js?=
 =?utf-8?B?Nlg4QVJvU0ZISHB1d1JydkpMVVRDMlVLV0hIYllPSzB2UFlmSSsvYTI1V3B2?=
 =?utf-8?B?ckVjcVUxOGYrYlluam1mQXlQR2c5dVJRN2xYY0t3a3VoeDNmQTI3cTVNelh0?=
 =?utf-8?B?Tmd1NEMvZkVqQ044OXZadjNhcHZBclhRZGRNMk1ZMWF6aTdTZXFoRUtZTU1E?=
 =?utf-8?B?VHp5QzFBYzV5T0t1Y1BGRFVRdGR6ZnVySUQ0dzVRai9DdmJkR3BvMDhoWTlW?=
 =?utf-8?B?akZOWEd2ZjBoQkMzRjd1WmV1NEc1cVVHSzZ4ZzZCTi9mb1E3NkFDYlZVeXVr?=
 =?utf-8?B?WG9OYmJUYXJnSEZGeEx5SDN2MTIvYm96Y2tGQ24xYU9qMzY4ellzcUltdGVw?=
 =?utf-8?B?ZEh0UmxybnFDS3JnNDJjUVZiRkl4eWwxR1dSSFNBTXRXOWQ4WlNsNmJZendJ?=
 =?utf-8?B?NWN0NVZZcWFYV2Q2dUg2MkdOWnFlTTBGZnZwRmxsTWZOcTBONGlRSVBRTWxz?=
 =?utf-8?B?YUF0SjBOamZzOVFKNndiRWhIRHNkRDljZHN0c2RMMkJnOW9Va295YWxTVFJK?=
 =?utf-8?B?Q3NVa3dxYW9OMkpUWURSb0ZFOE1UUUVPcmhEVzkzKzdVaEk4WnBpbWZjTkhF?=
 =?utf-8?B?Qnh0WGRGcVJVWGhpVjhHTlp2Vk1vMFdUWXY0WG9IdXpUWnRKZGpFZzVkZHQv?=
 =?utf-8?B?SCtQWWNPTXc0eUVFWE9RVDVneHkwN1o5ZEgrSythanZ0SkZPeFh6MnNtYTNu?=
 =?utf-8?B?b3BtRFZYUndQbWNaaGlxbVZZMkpyV0hNY1ZyK1h5L0xEamZMdGZBMVYza1VK?=
 =?utf-8?B?TVhqc1JnOE5EaFlVSkVKZWpQc0UwUExGSHdFV2FVUnYwamMxSWVjenhuL3ha?=
 =?utf-8?B?RVJDY0xZdFE0M2dmWlBmUVdPTmxmaFZlcVR0MVRmbUNmVDU2KzMwRWVkcGpv?=
 =?utf-8?B?b0c4NDdselZtSXhzUFNic2RRWWtLK1BNb2xHeXhSN0xLSGZrVUkzeHFNekQ1?=
 =?utf-8?B?RTkrVWxIcnE4TXlGRlc1UHNUMTFzNW1IQWxvYUhDT210Sm1YaHdBenBxMHJl?=
 =?utf-8?B?NFNVMGMzcjJIVFM1c005TWg3RDhseGNrU3Exbnl1YU1MYzE4S3R1QnBuQS9I?=
 =?utf-8?Q?vu1DVz7VyMfNuTXteFAxxGe9J?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_0114_01DA5048.EE9EC1A0"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476a05b4-2397-4720-86fa-08dc1e14a2e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 02:15:15.9988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDCVPtoIF83Zpfezwf64t+gB2tqigdo7eyJ8/fscNYgVnwb9PaznOxQeTjifJQhEL1ti9SASvclBAaKWWjtaPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8177

------=_NextPart_000_0114_01DA5048.EE9EC1A0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> From: H. Peter Anvin <hpa@zytor.com>
> On 1/24/24 03:44, NOMURA JUNICHI(=E9=87=8E=E6=9D=91 =
=E6=B7=B3=E4=B8=80) wrote:
> >> From: Borislav Petkov <bp@alien8.de>
> >> On Mon, Jan 15, 2024 at 08:57:45AM +0000, NOMURA =
JUNICHI(=E9=87=8E=E6=9D=91 =E6=B7=B3=E4=B8=80) wrote:
> >>> +	if (spurious_nmi_count) {
> >>> +		error_putstr("Spurious early NMI ignored. Number of NMIs: 0x");
> >>> +		error_puthex(spurious_nmi_count);
> >>> +		error_putstr("\n");
> >>
> >> Uff, that's just silly:
> >>
> >> Spurious early NMIs ignored: 0x0000000000000017
> >>
> >> Would you like to add a error_putnum() or so in a prepatch which =
would
> >> make this output
> >>
> >> Spurious early NMIs ignored: 23.
> >>
> >> ?
> >>
> >> So that it is human readable and doesn't make me wonder what that =
hex
> >> value is supposed to mean?
> >
> > Yes, it would be nicer to print that way.  I used the existing =
error_puthex() just
> > to keep the patch minimal.  I will try to add error_putnum().
> >
> >> Btw, please use this version when sending next time:
>=20
> Here is a *completely* untested patch for you...

Ah, I was preparing decimal only version but yours is much better.
I tested and it just works.

I would like to use yours as a prepatch.  May I have your signed-off-by?

--
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.

------=_NextPart_000_0114_01DA5048.EE9EC1A0
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
GgUAoIIB2zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDAxMjYw
MjE1MTNaMCMGCSqGSIb3DQEJBDEWBBTGlY9YuQA2etTHPzYsnUA5q7ObYjBxBgkrBgEEAYI3EAQx
ZDBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9H
bG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgxGh7K+G7dEZyfDiXswcwYLKoZIhvcNAQkQ
AgsxZKBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQD
Ex9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgxGh7K+G7dEZyfDiXswgZMGCSqGSIb3
DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFl
AwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAhowCwYJYIZIAWUDBAID
MAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAlVLEKx7lTJENOUif
iZEJIZM2UBaeAcj6xXYNn+Z/HZoUkl5XOmOHqUnfLg5Dsvrs7h/H57TsrqtlVPRaYM+L8MEr6tGI
/2iLqGEL3CRHBi2zW5U1ilV4MScCCVPK/GSKqdQ7etO7Kl/I9bxnREPXHEEMZ78KWw5QmPk1Ijyg
EIL4pCmQl1a1QTwdATs+UMRSqAFwSjovQlUXIU+n0SziES5sKY94eeliYzmPqrlIPuMy+6/cW5GO
mqKfsca4kddbrXIj25LiShA0yXBQGeeXNc/DXCwZRFakSYHD4octs+jDNYeZ4x5YxJbykH3RAx8P
nEDGr7Deh52cwn8QbCA4LAAAAAAAAA==

------=_NextPart_000_0114_01DA5048.EE9EC1A0--

