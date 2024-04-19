Return-Path: <linux-kernel+bounces-151012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C038AA7F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5AC9B25642
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEEBBE49;
	Fri, 19 Apr 2024 05:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NOW8nHX6"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A0748E;
	Fri, 19 Apr 2024 05:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713504552; cv=fail; b=P+LAOChveMXFQ7B1Ioj1OI1+kO1kqTSwmpkWTlRtLnzXR0jMCduWksuEURZssxXGV95R4zMMa3Skw61oqKGUmmjIPB9l5ytRxK7vcRKPuzffJTg7nn+ZyhjeYI+g6KVLOB8Jfvz4wJnMA+kDbevh/IH1GWXoQ5NeFnoM77sVphw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713504552; c=relaxed/simple;
	bh=hrcvqMpdOyWWxVdg/JJQzJbp50kBbbtWWdBi0/gN8hs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JytkmrzzdN+12KWt+wlW4GYsOnCazBcdDU4mnLKhYuSFELznLmshbPmOQe1wjhi6w1fakfif5k7U/aPqW275MQkkj/v035PsQd9JgO/5Gs/ifUypSMqetNCjhUaptew2f7dJMb95N8OAc8FkS7eATFZKPINFJThtkjHINUIFLxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NOW8nHX6; arc=fail smtp.client-ip=40.107.7.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+NG/2jled+NCZ/h7XMQ0mdkOXLWvBC40Dn6qTgK4MV3T1vBxioHjuCO3aSzGI8ePNIg7Js3LY1Azl+lMCVblkrOqe/gtidfDGfhpLFkNaL5iJjWd+QRFRPQG6kKGRCarVGe2ZaL3Ri1Tv7qwqdDXDnpBITuwTcSNZtcUDlxpRZ+o9cZJIGsagVF4h87nofezqmnGtj+RtTfveREWAbpphFeNiq2qaQklE8byiRGgoz7ZVxB90DfKb7V8hyvXNybXbY7ofWisYmDzlVSBWcDrSoDZQKmxbocUVk0H/T88lcr89uOr7z1qVWByTYSA1RQXuWF4UEmipGGyuW9OoZSRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrcvqMpdOyWWxVdg/JJQzJbp50kBbbtWWdBi0/gN8hs=;
 b=BX6y95d7QN1o6iN0NDQ0tDMdNst1V9uFqMmKultM5ZNWBRC3iznSwN3zufnBhaCCZe8RCjA+QEsjsdR1fpXQ+asAyi+DWpNfpJTZ7FU+FOoxLWijdb8DV6Zs0u1UtmTfaGII7YTt87463ZvsY1YAa+vibvv2MRV3Ew6XV8XxbY1tFG6wuaimAAuA/ZYcrPfNryclI7v+s7dOfchKIHb/neH50ZlszCBZivUSjFvgr33qfOfzFn7YaP/IJLlX+k0WkQGwdPn0oMmEkcSDoSeg6avyavNpz4M7wp0EfR4MqK26cPYDwFnUG6aVMsVPLhv8aDIXEh7gJogQH4x6VMljVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrcvqMpdOyWWxVdg/JJQzJbp50kBbbtWWdBi0/gN8hs=;
 b=NOW8nHX6dzRxAEVSSfswso0sRlDOc7wpnxYAg8qkbKa/g34NiVzhuOuUxUx1PP3G1QxuPoIBgPu96QKAm4Q7rRHithQxy0Xye1Fmh9BxJ3t9qDW92EZYYkETLTKvpPlaO2RDIyv3meSsR/Cgd4fXCaoCpJm1GhcBp87QIWHyT7U=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 05:29:07 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4%2]) with mapi id 15.20.7409.042; Fri, 19 Apr 2024
 05:29:07 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Horia Geanta <horia.geanta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
	Varun Sethi <V.Sethi@nxp.com>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>,
	Iuliana Prodan <iuliana.prodan@nxp.com>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3 1/2] caam: init-clk based on caam-page0-access
Thread-Topic: [PATCH v3 1/2] caam: init-clk based on caam-page0-access
Thread-Index: AQHaj7/jd4TDxURXIUidF1KPvahm+7FuH9YAgAD1jzA=
Date: Fri, 19 Apr 2024 05:29:06 +0000
Message-ID:
 <AM9PR04MB8604BF1315261414E728546F950D2@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240416053303.421259-1-pankaj.gupta@nxp.com>
 <20240416053303.421259-2-pankaj.gupta@nxp.com>
 <a4143756-e046-473c-8507-d638c5ee0442@nxp.com>
In-Reply-To: <a4143756-e046-473c-8507-d638c5ee0442@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|DU2PR04MB8629:EE_
x-ms-office365-filtering-correlation-id: 135d2b8a-df35-435a-ff35-08dc6031a228
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y20xdkFobk1Mc2tCVnh4blNtMWg1VU9OM1pGM2lIZU05TnZzNGVYSEd6clRR?=
 =?utf-8?B?NE5HTzFKblBrditJYXVRdFB3d3RaY2IzNTBwNVhvc0EwenRCV0hzV2kwQzJC?=
 =?utf-8?B?OHBYQ1llb0xmMVBLTU1ka0pPdUxEbkRqcFZvOVFVUWNZY2lrZFczYmhqakh5?=
 =?utf-8?B?a2J6QVZ4clZvaG1OQUpkc1RWZzVaNW9uelhDU1czUDdEaE9xcUVhQTNsdWdM?=
 =?utf-8?B?d1dlME9QK2IyWUFXS1AyaXFaWmF0NGVzTVBiVWY3bUh4dkRDV28zSythZDEr?=
 =?utf-8?B?OU52eWlGN3kwVVNMWWd4MTduSnpiQ0NGc0dFVXZqb3c4c0I0TmowMkQ1cU9G?=
 =?utf-8?B?T2VpRG9sbkFtYTF2YnE4MWZCSFFDa29SYm1SVHo1SWIzcjdIbHdUYzEwY1lF?=
 =?utf-8?B?emczcXQzV21TY1RtZEZKK25uUkJhSU9pY2l0SkI0SlJEZ1NFYk1HY2xudm9w?=
 =?utf-8?B?dGdET0Z2R0xwaEFub2J1ZVRvZk1nSWx1LzFnSS9xaEZwa0tKNjdKT1RxbHln?=
 =?utf-8?B?NGtOTHpDelJYYXJQMExVNzRxWnFBYTc0Rm1Gc0xpY3Nvby8vczNsa0xZNnNW?=
 =?utf-8?B?RGt2dk9lanllendURjlTdEhQcUVyYmh5TW05VHVrb2ZNdVRTVmpsNUVzMkJa?=
 =?utf-8?B?UG45UjBNT3NsZnJPOHpSdmtSNE03eStJL3dORUxkdTFkV0xtWHlCekJRekNM?=
 =?utf-8?B?WlZJenRPbXJ2ZnJtRmxzdG9kTkEvZG5Ga25jcHNBbzFqVEpwcXgyZGVoZG5H?=
 =?utf-8?B?MnRCcjNRcWVXbUhuVldJaWN1QW5Ebm8yWmxET0pVSVdhRE1jZXp2ZGN1TDJm?=
 =?utf-8?B?TlA2MzJVVkJIZ1RsUlVPK0RGY2xmY3dPMUI1bXNVWkJIMDZmYk9VQnJUQjBh?=
 =?utf-8?B?VUhyRTRYODFNNEhOWDRvQ2tJV0ZBRlh1d3NBME9BaHRGSGVKZXNzS2ZLV2lP?=
 =?utf-8?B?Rkg5VThSVUVyZnVqVzZrelEycmZjWTgzY1lGREg3YU42bE50RmlCdHlSckNT?=
 =?utf-8?B?MFhjZERtbXpNVldUcXJlTXdIUFhpME4wb0ZoTE9vdDNSNVptdzFMemlXbFJx?=
 =?utf-8?B?Wit5YnRuVnpaSXZ2SzFQaW5LVE9KaXVpWjFGUmtSNlhWNzJ3YkhYL2lTUnJD?=
 =?utf-8?B?dVEzV21NZXFCOVhJanZ2VkUveHh1QlIyc0EvU1NjaG96bGdkdVV3ejZkek81?=
 =?utf-8?B?eU54UWVZZEw0eDlyeGx4aXE3WGZINXU3YmhMdVI0NHQ0ZzJhbUFUVHBRYzZx?=
 =?utf-8?B?YnduQnJjZmRwWFdmNllJTUF0R3BvRTlZSDZWRm1OclB3bDV5MXlyMmJYV2ts?=
 =?utf-8?B?cVZOUXhUSGdkUEN6MTl2cDNWaEw0Zzc5WWt5cWsxZUxRRFU4VENxT0k3WERt?=
 =?utf-8?B?NEdMZ3BIY3FvWldXUDE0bmtpS0QzMVR6RFBEcFM3Mm92Y2l2M3RaazdCZm1X?=
 =?utf-8?B?WUszRWZNV0tJd2JtenFuMFEyVnRudUIyejdhZldHTnRZQU5JT0lWcTRwZXBI?=
 =?utf-8?B?YjBRbmE3ZWszQUxpN1htTEdidHhLcU5iZ25zRE82U3dINUF4dGNUZDlUb3hn?=
 =?utf-8?B?WUZuRzFCTG9TRzk5Uk5FS0luaFU5NFRsUThhR094eWVQck5oandjUlpDVkpF?=
 =?utf-8?B?Q3RGV2NzWGdWSWN5WllCRmpPOTFkUU80U2VVTEFMME8zb2d5WmV4YnpGWGpw?=
 =?utf-8?B?SVR3REF0ZUJKSDB2Q3lscDNQdnNORlRzWm9PbWxpWVdPZFNKUTREK0x6NjFT?=
 =?utf-8?B?MFpWRU1jc1hiOVFoNzFvYUQzUmMxKzVvOUNYRjBLcGtudEdSNlRNV0tHMlVa?=
 =?utf-8?B?OWtMcTRCazJ4dDk5b2p2Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzc1NGdJbGEyUlBmQ2tDUmt3MllXZExrZERtb01MNGJocEt4aGwrRDlwcEls?=
 =?utf-8?B?L1VscTBNRm4yazZYT0ErOEJ3dEJEcmxLWnJBWEpEZWdkT0FzMUFKK1gxZHA3?=
 =?utf-8?B?blhVeThUbjZBZFViZ2Qwb2lRSzhzbGFhR1paY1RoMXdETkdEVHN6cFNRMkN4?=
 =?utf-8?B?M1pYcVJYZEV5SDdoMm4yR3RhQy8wMlZ3UEw5eW12Y2VzUGZuQ1VoVzJCZFdn?=
 =?utf-8?B?QmZCTXhKTFIxK2x4UFBBc1BwdGtlVlpHbkZYZGtIOW5qcTVxRE92OXNBNVpG?=
 =?utf-8?B?OTZwRjlqVTZWOXZiUm9mSFRuRHdheE01OFgwV3ZZZFBEaEdYZXNabFZITWNi?=
 =?utf-8?B?d0VFUU1RUm4wbEJ6VzFYcE1zbVBybDZ2bGc3bkdBY0JlL2lnZEdBaXFNZ1ZI?=
 =?utf-8?B?N2VjOXN6MjhXNGRzL2ZINUxPVjh4b1BNU2Fkei9tV3ZmTUFwWEU1bWc4U21L?=
 =?utf-8?B?bWREazZ1V3JRK1RqS3RSVnpuVWEzY2VIVlE4bGZkVDB2Z2lHRFM3OG5ZK0RW?=
 =?utf-8?B?T3RUbXVVUFdKK0xQQXhQVi9yWjNreUMxM2dVdFJOL0J4NlZQRGxPT1FuT0kz?=
 =?utf-8?B?R3BoRWgveGQ2M3BWekNQY3hTOFZJL0lpV0JSVDZXYWRZZ0w4a05IVUlod2Vt?=
 =?utf-8?B?eXg2S3NjTi9XTEJENUV0M3IzODlPaUZDWDV3cWRxS1BtV0oySGdlTEQyaHYr?=
 =?utf-8?B?TWxUYVRDYkIrTE9MU0pzVWZXdzdGU1NaZkpqQVpGUE05V29zWmxMeXVGZE50?=
 =?utf-8?B?Y2syamY3RVdaVWhoa3hnV0FVZ3VZKzJjTTM1MVNFNjZnUFJkZWZWVzgrb215?=
 =?utf-8?B?WWpVc2o2S0JRUmRnM0JHdFZmK0VCRFRvbVlIUzlYbkFDYlpLOFY5UDJBQXV0?=
 =?utf-8?B?elE2UlBxeU14RlNDY1lsbURmV1N4cFBobEpJc3R1L2RYMnREMG5mT1pKZVRZ?=
 =?utf-8?B?ZTNoTy9vc1FnNGVoQnh0VHRzcjBiQ1F0MTBhYUR3RytMeGxpWW9DTlZlVGgv?=
 =?utf-8?B?R003ZC9PQXk3ZDVad3YxZnRtT2JhNGNnUmZMU1RHY3pGVkI0VmlKcFBEY1M2?=
 =?utf-8?B?VkFudGZIQVVwZ3JHYzlSM25ub3hualFVNGNxcjh3Q2pueUs3Um1LdXZoazdB?=
 =?utf-8?B?VGw2cUtXc1dUdjJmclJiRlJoZHhuN0xyWmU3VFBZbUN2TktEZWtnNTNiV1M2?=
 =?utf-8?B?aHpsVDlSMmlBdFpiWHFKajU4T3RDeXRPWkpLa1dpa0lvZ050MkZJTk96VTQz?=
 =?utf-8?B?cXQ3YXpicER1N0kxQVdqRXN0TWd5KzhoZkJ6NVRZZ2x2TXBxRDllL3Z1Y0xV?=
 =?utf-8?B?NWpmbXpqUWRqd0xHa2xOZmJMcS9mNVBDWDZJVE9PSUxGZ2pwbGxNdTVQQUdP?=
 =?utf-8?B?cVN2OGZ1aWN1Rko2N1RYWnlxSWRrZXpIZ0Z5WE83TCsvWkRGeG93S3BGTjRN?=
 =?utf-8?B?cHozMDVYS1d5NStJZkk0akhsanpYVGswNCtKNm4vd2NWOHN2a2dVZk42djZp?=
 =?utf-8?B?UDFTR1EzRkR4VTVLczU5TkRiemhlYWlYTlM4QzhKZGI3bzhDUHZpbEJNTndw?=
 =?utf-8?B?YVhCWmUwZFJSbjdPTS94MWFCN2EwTzdQMkxOVkJyM2kwQVphMFgxSFRzbXJo?=
 =?utf-8?B?Rmk3aTBocFZKMmEzcTB4cmxkVmJrOW9XMlFuT2x4cUVocHVMaUxsVzV2R3J0?=
 =?utf-8?B?R09LQVNYbFNieVBBWEk4bUFGU01FVUJmUCs1bHJmYnFpK1ZrZUVWbGJYWVVv?=
 =?utf-8?B?Rk9PNXJtN3lpUXV5UmhOVGZSNTYxT1pWSFFYVTI3c0lpVjZlME1HdE1XUmVm?=
 =?utf-8?B?VkVvaGVLeEJqT2MwYVV0TkhtYUVCMTAveE1PVGNBbEY3Z1BsUUFpU09mTDNi?=
 =?utf-8?B?N0tzRWQzdFYyNUVkR3F0OFphY1pIWmVXQlphSk9mOWdXckZTamlXMHdmV3Rq?=
 =?utf-8?B?U2oreGVDZ0w1RDJyVTZ2S1dLb241SVAwYjVzUHZONTRLMWt2eURnNmo4WWZm?=
 =?utf-8?B?U3B3c0ttVHdwZExmRVpScEFLWXl3cjJBZ2dGWlZ1M0lqU1lRa01mWTM5SVVt?=
 =?utf-8?B?YmdjSm5ESHNuQndXdC9BK1BSRlNtOVk3N0FVb2xFaWhmUjRLeWhnaC96RFJF?=
 =?utf-8?Q?dtiekA1ZBca6a18nUOjgRobjD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135d2b8a-df35-435a-ff35-08dc6031a228
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 05:29:06.9451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k/55hVgoHDtYzwunKyhieyofn4bNL/d6Xo4jbEL8Bdh+yeNcFnYCbXoGYQojlJjuuntpHcb6/SRTGV+5C9cjnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8629

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSG9yaWEgR2VhbnRhIDxo
b3JpYS5nZWFudGFAbnhwLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDE4LCAyMDI0IDg6
MjAgUE0NCj4gVG86IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhQG54cC5jb20+OyBHYXVyYXYg
SmFpbg0KPiA8Z2F1cmF2LmphaW5AbnhwLmNvbT47IFZhcnVuIFNldGhpIDxWLlNldGhpQG54cC5j
b20+Ow0KPiBoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7
IEl1bGlhbmEgUHJvZGFuDQo+IDxpdWxpYW5hLnByb2RhbkBueHAuY29tPjsgbGludXgtY3J5cHRv
QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxp
bnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS8y
XSBjYWFtOiBpbml0LWNsayBiYXNlZCBvbiBjYWFtLXBhZ2UwLWFjY2Vzcw0KPiANCj4gT24gNC8x
Ni8yMDI0IDg6MzUgQU0sIFBhbmthaiBHdXB0YSB3cm90ZToNCj4gPiBDQUFNIGNsb2NrIGluaXRp
YWxpemF0IGlzIGRvbmUgYmFzZWQgb24gdGhlIGJhc2lzIG9mIHNvYyBzcGVjaWZpYw0KPiAJICAg
ICBeIGluaXRpYWxpemF0aW9uDQo+IA0KPiA+IEBAIC04ODksMTcgKzg5NSwyNSBAQCBzdGF0aWMg
aW50IGNhYW1fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gPg0KPiA+
ICAJCXJlZ19hY2Nlc3MgPSAhY3RybHByaXYtPm9wdGVlX2VuOw0KPiA+DQo+ID4gLQkJaWYgKCFp
bXhfc29jX21hdGNoLT5kYXRhKSB7DQo+ID4gKwkJaWYgKGlteF9zb2NfbWF0Y2gtPmRhdGEpIHsN
Cj4gVGhpcyBpcyBvYnZpb3VzbHkgaW5jb3JyZWN0Lg0KW0FjY2VwdGVkXSANCj4gDQo+ID4gIAkJ
CWRldl9lcnIoZGV2LCAiTm8gY2xvY2sgZGF0YSBwcm92aWRlZCBmb3IgaS5NWCBTb0MiKTsNCj4g
PiAgCQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gIAkJfQ0KPiANCj4gUmVnYXJkcywNCj4gSG9yaWEN
Cg0K

