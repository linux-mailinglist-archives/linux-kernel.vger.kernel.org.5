Return-Path: <linux-kernel+bounces-89691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777B986F439
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 10:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E541E1F210B2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F55B657;
	Sun,  3 Mar 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="tRUSF43q"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2083.outbound.protection.outlook.com [40.107.114.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E946AEDC
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709459732; cv=fail; b=cf8AJwk67/yotOlp5fVBMsdff1pOhfudrTs/iRLmk+GSun6U72bUKCeOEI4rMjh8gQyx2mOTjKGyu45Uu7913L4oD7SKRXZj2ATA7CS4XQ9e0RWT48mvmTWL2B6YGGAjWj1B1aoqYK0Ebkal65aw7iqD3bR3v3Pw+nbDAQxbOL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709459732; c=relaxed/simple;
	bh=4By1ZyTPIuJVq2R5Qm72HruYEqmjVWFf2PYLlQyKIC4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CTijvhuGykYze3xQzLjktnHTP1CbSa5AzBRN5bDPmHDy+Pgi8/CPJDNCYh/CmHv+1mq+SCRWCJhTeU2HPX75VsdyXyT04M7jGfyEwPapwmS+Q8KVzyUXe1AR8EJ3gcYjq1E2xneRHb8sKICvjH78t2lOlSwFGINGOkVnaODBjbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=tRUSF43q; arc=fail smtp.client-ip=40.107.114.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7JEQIGCzvfABfirvrCLB8LPoBkRTBRMH6tmqIEm2ph7z3GC7xb7v9DJH45iEeY6SxyIHBEm6KXsutlsfdQbmDZ86btpR3RLnAnzE+yv5ubYEp35le1mpnnfCq1CRjGRQvq+DBpvTPZitwabjuzJk3vrPtmfq51eWLUWECraRQC77Uy3lRrRIAh4bJnP0njiKE14fXWbLh+1GVsUTBVbi88lPdp5ZBtd2pFLyYpgJapolx3wd3fDgLXB+PrW77D2Jf+7p6vCifEC5x1WGZwzR7ecoNAwB0+c+u1UBolpb0zYlH7h9wYLVGbRtP/vGA8pBhBbpdn/jFVQgtquVu/VzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4By1ZyTPIuJVq2R5Qm72HruYEqmjVWFf2PYLlQyKIC4=;
 b=gvaeY8+Xo6CNsKNWRodG8iWOE/y0AhIbj+f5WezmW1gKXHuCSnJozU0kA9f2OcKzoZJPq7sexxu4Vy5DHnTnhJxdKDbBLXga28aaoCrddpDfi/veXHSzuWgk6U5iIWq0VKRol6oBrHLLevMg7Hbftt16LfjYTDvX0iAj0BS6ReTGoOJBm8Wh1s/SVSaQ4dJRVA8nu95KwQQdoBEQSSdCvl88UwPMxC5I0eqo4oGgO+STJlysSSjfxCKxccL79SwgerURnY/mWQCNu+CFFCtJ85C8gqbEXVN5FXnFpjkSj3yJWYTz88GsyLljhSc5EPUZRi9enOoyq+qFReHk5udERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4By1ZyTPIuJVq2R5Qm72HruYEqmjVWFf2PYLlQyKIC4=;
 b=tRUSF43qU79a+Zpr9ewM1/Lta6AGZo8r/ZYyD3GJBsJUARwtnLvN+LAGnz+vKlCPE2FVBl7baCPDn5tJ9kfWNpt+TZnbFZcxG0riAQABupDMAzy2ZNbx/E0mKXo69ZwziRdFtvKbe/3ok87TvG4+eiFPqe20lCe+3G6QyxufyR4=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYCPR01MB11120.jpnprd01.prod.outlook.com
 (2603:1096:400:3c3::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Sun, 3 Mar
 2024 09:55:24 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7316.039; Sun, 3 Mar 2024
 09:55:24 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v2] mul_u64_u64_div_u64: Increase precision by
 conditionally swapping a and b
Thread-Topic: [PATCH v2] mul_u64_u64_div_u64: Increase precision by
 conditionally swapping a and b
Thread-Index: AQHabUyWkQdLgTvBzU6TxXgU64zNArElxsGQ
Date: Sun, 3 Mar 2024 09:55:24 +0000
Message-ID:
 <TYCPR01MB1126903087A6D6AE3E6A7FEE5865C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240303092408.662449-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20240303092408.662449-2-u.kleine-koenig@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYCPR01MB11120:EE_
x-ms-office365-filtering-correlation-id: 4ea5300e-d9c9-44a8-2ccb-08dc3b680c4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bvPwmPEEsDFXci2Sxp9rW/hFrqSBJCtmO2SeaaNV/FPtfaBRruA7p7uE1AgivDdPXkUMeqJqOkypyG2ykddmAp+g9N1RZJ+bJ3wtMwN7VcJbOePtWiNIckS4jl1H+3fKchLCFTfVt2au4DAGYKGVlpuM3D4Vdc+j9vHgay4av99hiWUnskSjjONMLboS3tpYiXoIdnYSDOIM0m5u/Z8+hsWVcBjniCDiQXo9Be0VtiDJr1rfgKeFP8KwvPoTYOtGwzz+cxkntLbdlvH6mYaC1gMl7lLv5G0XSzNMnhSTXUB/OL561lr1zJjnSY+jVGvXoPuvpV1IKBu7gGSrfeASl5CX48+TxFuFwu3l5nXeyQ3k/5rxwgk6jsyfEeqjNzjk1VXx+H5mZxK2VWkK1suQ8uQfZK06dAR7jM88p8kyXOedn19/2ggG65cIsW9yj66cn0xMRCmTkUQgALhUCN7dpcdowfmBEKjZa1cVwFBChw6lHfCFZtEsl8aTz1IB5zBmaQ1ktoOi516fPOr3gkuf4vtrMKE6fEIba1zLjld5IwG19m9WPXFi9eWMNaXFJzzL3Ig5//lBAEJw/rRTtICFXSQu/ptVNdzD6R2xVj6x8Fqu8eICRjLqheArabo1dECwLCxcTpo3eY51Yt7ugc5ggwMXc5+trvcYF+SDn2tAVM0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmdmSmg5VUhTWFBWbXQ5NEtrVTR5UlppZS85UEZyb0NUZkhOcjZUT2xta2hJ?=
 =?utf-8?B?THhNSlV1VmpkWGhmbFE4ZTZUWkVhcHNmL0duTmRvVTIxTXBPWTRBYTNJcVlO?=
 =?utf-8?B?QndGZGdMK3pYQWFBa0t2RDJpY0V1TVBpWUwvMnVsQXVuMWd6M3EzVFFIcjVa?=
 =?utf-8?B?SThjN3pOWC9RS2xxQmtaVFQyVFh6OG1XVCtSYWV5ZkNCY1lVN2RiazNtSTBB?=
 =?utf-8?B?b0tTOVJtMnVEVXZqaDU3d0g4WE5VckhJNEVFNjQvM3pwZk96NWUxYXNSOUNr?=
 =?utf-8?B?bE05YytyYWRoMTcrUEZhTElpdDhuQktUUm02U0pYbTllRjJvcThsa0o2N3Fa?=
 =?utf-8?B?Z0NTZjFsQzd4MzFIMXlEb0w4SVQ3V1R5dHJTaVVLS2U0VDNmME1FNkoyYTNW?=
 =?utf-8?B?K2lKdFUwQWhDTjEyaG1ScFdYUVd0dmtva2swZHlPeEYvaXBSSkxneFhuVUgr?=
 =?utf-8?B?dWw2R0o2Q0RZTi91WktJQUhSL0kxdEQ0UmJNeitDeXRRRFFXa0UrRGU4UUlP?=
 =?utf-8?B?Y01tL0YremhML0VuMzZmU0d6d1U4SFp3R0tDT3NjM3EzZXZzQUt4aHVFWUdH?=
 =?utf-8?B?OVlPMXNYUGt2K0owMVFqc0dqYWllaEhoMG84akl3TGhMQmJLdHI3MnM0T0lx?=
 =?utf-8?B?aG1IaHdXMEo5YWltNjFWM3N1VkZqS0hvN3NNc1JrNS93OHNhdFJUMHJRMHJK?=
 =?utf-8?B?bkdBTzFOZWdOMnVSR2VZQXpHd1N3WmJ5UTJ0NHdDS1lsNkljVGFYSFZMeG1F?=
 =?utf-8?B?OXJzNjhIbk1jdEx1WmRFbmZwV1lzU3p3UzRQMjN0bi9DNGdkRWFkeG5MUkNW?=
 =?utf-8?B?TXVYMUZtazVqckJMNHJ4YU1VQXg0RmxrWlNFVEUwb1VsUW5kaXduWmZCZTUw?=
 =?utf-8?B?bmcrWlJicFlZb2ZUQ0VYY1Y0ZGtlM0s2Z2xnOXVSSzIyQllVckp0Z1JOSU13?=
 =?utf-8?B?NTZIZ0ZiaUhPalJBR3NHRVFKb052OVFpSjI3K1A3UjM2SHg2V3l2cksrTDVE?=
 =?utf-8?B?ZXJYQkE5WWR0UVBpNnZyZFoxWUpDQlJaVDMvZU8rRzNXaUhhYkVVbkVFVFlm?=
 =?utf-8?B?bDN6TW9CWW54QS9vaTBaVkxvOFRIWmJCQy93N0NxbGw0bnlTelNtUXQyYUlC?=
 =?utf-8?B?Y2k3ZHBvaGtXbEgvaS9vUWhFdmRxY1B3RmpONldpTWltcGRxYUsvb1ovdStK?=
 =?utf-8?B?RGI1QzJ5cDRHbHRJRmZQTSs0NmtPL0tVS3VhcEE0cy90TE9zL3E1Zk5zekpU?=
 =?utf-8?B?STJOdklkd0FxVUpZbGJoUmI3aXR2c3NrVSs0TEExTFQycWV5a25pWlAwVmw4?=
 =?utf-8?B?Wk1nRjllQ05qaGRFSzJqUjZ1VTZSdkJMRnl1djNWejdtdlEzR0RlUit0MnVE?=
 =?utf-8?B?Uk1iYi9XQnExbjMrTVdTei85QWlvdG1OMXhNUkdDWDVGSWNBYndpRHRYL0cz?=
 =?utf-8?B?VzJzTCtrSlI4NlB5bFRPSld6Wm05ZXdlRExpMWR3anN4TXcwbjFsQ3JFdnNG?=
 =?utf-8?B?K0RFUlUvck5MTDI0a2FLUERJdi8wMVFGZmhqU2lCQmlFdTY4bEpaaVFsTyth?=
 =?utf-8?B?YVBPT1dZUlFyU2cvOWxJMGpNVFBIRE9VTlNzNnV2ZVJEMHFhRWdLdDhvT2hY?=
 =?utf-8?B?dW8zTEdvNlcrU2FGM3BiWGJEUU5mQzh0SCtUem1EMmlQL3pKV1lHMnVEeE9N?=
 =?utf-8?B?OGlOUzhmaDN3a2xYbDFLMngyYjdBZmJzcXFuRHM4WENZbklwTWJCMjN0T2lF?=
 =?utf-8?B?MUNyZlNIRHZ3ckZZMktmUzNmL09wUDNISnJUcU1SSkowRW0xcTVYM3JJZXZG?=
 =?utf-8?B?bTVPWFNodUoxSXJsNlFjc3MzWFlydWsyelpFZXIyeCttZitadmJKa3lHWm9y?=
 =?utf-8?B?OUxuZWp0ckhISHJrcEtOeW9GTjV2eGN5Q3FJYWN5ZUVxTTkwOUtBY1ZFYnNn?=
 =?utf-8?B?dFdxRjczVVNDOFdHelpoeXVxS1p4U3I0ODBncUZ6bHFROU5lbXBzZmtLazBP?=
 =?utf-8?B?Y0QxVHo5ejRhSzJ4WTFzR2VBUUxXWUxqSytTWXJxeFpFSWF3c3JLa3lsS0d2?=
 =?utf-8?B?d1QwZzBLRjlpS2d2b1dTeWxpU2RUTlBHOGt2YTMvTy9ML0lIVTZ2bHB3YTdH?=
 =?utf-8?B?SFMrN2xVTmU3OFVOSkFmRDYvTjFrNmtMaVQ5cWN1MjZwMFRDd1dkMTJrSGpx?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea5300e-d9c9-44a8-2ccb-08dc3b680c4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2024 09:55:24.8458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PWFss2YYJd3ZN3QPE0WHcMqg0SaBNi9xNEOMlqhA+e1I1KKgJh4WFUZY9+7MKQr5RH5euKjMln8ZDEt/KnAdcPPo8my7Of4dGYLad3rMWWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11120

SGkgVXdlIEtsZWluZS1Lw7ZuaWcsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4N
Cj4gU2VudDogU3VuZGF5LCBNYXJjaCAzLCAyMDI0IDk6MjQgQU0NCj4gU3ViamVjdDogW1BBVENI
IHYyXSBtdWxfdTY0X3U2NF9kaXZfdTY0OiBJbmNyZWFzZSBwcmVjaXNpb24gYnkgY29uZGl0aW9u
YWxseSBzd2FwcGluZyBhIGFuZCBiDQo+IA0KPiBBcyBpbmRpY2F0ZWQgaW4gdGhlIGFkZGVkIGNv
bW1lbnQsIHRoZSBhbGdvcml0aG0gd29ya3MgYmV0dGVyIGlmIGIgaXMgYmlnLiBBcyBtdWx0aXBs
aWNhdGlvbiBpcw0KPiBjb21tdXRhdGl2ZSwgYSBhbmQgYiBjYW4gYmUgc3dhcHBlZC4gRG8gdGhp
cyBpZiBhIGlzIGJpZ2dlciB0aGFuIGIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5l
LUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPg0KPiAtLS0NCj4gQ2hhbmdl
cyBzaW5jZSB2MToNCj4gIC0gTWFrZSB1c2Ugb2Ygc3dhcCgpIChUaGFua3MgTWFyYykNCj4gIC0g
Rml4IGEgdHlwbyBpbiBhIGNvZGUgY29tbWVudCAoVGhhbmtzIFJhbmR5KQ0KPiAgLSBGaXggYSB0
eXBvIGluIHRoZSBjb21taXQgbG9nIChzL0lmL2lmLzsgbm90aWNlZCBteXNlbGYpDQo+IA0KPiB2
MSBnb3QgYSBUZXN0ZWQtYnkgZnJvbSBCaWp1OyBJIGRpZG4ndCBhZGQgaXQgaGVyZSBhcyB0aGUg
cGF0Y2ggY2hhbmdlZC4NCj4gSSdtIG9wdGltaXN0aWMgdGhhdCB0aGlzIHYyIHdvdWxkIHBhc3Mg
aGlzIHRlc3RzLCB0b28sIGJ1dCBJIGRvbid0IHdhbm5hIGFzc3VtZSBzdHVmZiB3aGVuIGFkZGlu
ZyB0YWdzLg0KDQpUZXN0ZWQtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNv
bT4NCg0KRG9uZSB0aGUgdGVzdGluZyBieSBkcm9wcGluZyByemcybF9ncHRfbXVsX3U2NF91NjRf
ZGl2X3U2NCgpIGluIHBhdGNoWzFdDQoNClsxXQ0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wcm9qZWN0L2xpbnV4LXJlbmVzYXMtc29jL3BhdGNoLzIwMjQwMjIwMTk0MzE4LjY3MjQ0My00
LWJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tLw0KDQpDaGVlcnMsDQpCaWp1DQo+IA0KPiAgbGli
L21hdGgvZGl2NjQuYyB8IDE1ICsrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDE1
IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9saWIvbWF0aC9kaXY2NC5jIGIvbGli
L21hdGgvZGl2NjQuYyBpbmRleCA1NWE4MTc4MmUyNzEuLjE5MTc2MWIxYjYyMyAxMDA2NDQNCj4g
LS0tIGEvbGliL21hdGgvZGl2NjQuYw0KPiArKysgYi9saWIvbWF0aC9kaXY2NC5jDQo+IEBAIC0y
Miw2ICsyMiw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvZXhwb3J0Lmg+DQo+ICAjaW5jbHVkZSA8
bGludXgvbWF0aC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L21hdGg2NC5oPg0KPiArI2luY2x1ZGUg
PGxpbnV4L21pbm1heC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2xvZzIuaD4NCj4gDQo+ICAvKiBO
b3QgbmVlZGVkIG9uIDY0Yml0IGFyY2hpdGVjdHVyZXMgKi8gQEAgLTE5MCw2ICsxOTEsMjAgQEAg
dTY0IG11bF91NjRfdTY0X2Rpdl91NjQodTY0IGEsIHU2NCBiLCB1NjQNCj4gYykNCj4gDQo+ICAJ
LyogY2FuIGEgKiBiIG92ZXJmbG93ID8gKi8NCj4gIAlpZiAoaWxvZzIoYSkgKyBpbG9nMihiKSA+
IDYyKSB7DQo+ICsJCS8qDQo+ICsJCSAqIE5vdGUgdGhhdCB0aGUgYWxnb3JpdGhtIGFmdGVyIHRo
ZSBpZiBibG9jayBiZWxvdyBtaWdodCBsb3NlDQo+ICsJCSAqIHNvbWUgcHJlY2lzaW9uIGFuZCB0
aGUgcmVzdWx0IGlzIG1vcmUgZXhhY3QgZm9yIGIgPiBhLiBTbw0KPiArCQkgKiBleGNoYW5nZSBh
IGFuZCBiIGlmIGEgaXMgYmlnZ2VyIHRoYW4gYi4NCj4gKwkJICoNCj4gKwkJICogRm9yIGV4YW1w
bGUgd2l0aCBhID0gNDM5ODA0NjUxMDA4MDAsIGIgPSAxMDAwMDAwMDAsIGMgPSAxMDAwMDAwMDAw
DQo+ICsJCSAqIHRoZSBiZWxvdyBjYWxjdWxhdGlvbiBkb2Vzbid0IG1vZGlmeSBiIGF0IGFsbCBi
ZWNhdXNlIGRpdiA9PSAwDQo+ICsJCSAqIGFuZCB0aGVuIHNoaWZ0IGJlY29tZXMgNDUgKyAyNiAt
IDYyID0gOSBhbmQgc28gdGhlIHJlc3VsdA0KPiArCQkgKiBiZWNvbWVzIDQzOTgwMzUyNTEwODAu
IEhvd2V2ZXIgd2l0aCBhIGFuZCBiIHN3YXBwZWQgdGhlIGV4YWN0DQo+ICsJCSAqIHJlc3VsdCBp
cyBjYWxjdWxhdGVkIChpLmUuIDQzOTgwNDY1MTAwODApLg0KPiArCQkgKi8NCj4gKwkJaWYgKGEg
PiBiKQ0KPiArCQkJc3dhcChhLCBiKTsNCj4gKw0KPiAgCQkvKg0KPiAgCQkgKiAoYiAqIGEpIC8g
YyBpcyBlcXVhbCB0bw0KPiAgCQkgKg0KPiANCj4gYmFzZS1jb21taXQ6IDE4NzBjZGMwZThkZWUz
MmUzYzIyMTcwNGEyOTc3ODk4YmE0YzEwZTgNCj4gLS0NCj4gMi40My4wDQoNCg==

