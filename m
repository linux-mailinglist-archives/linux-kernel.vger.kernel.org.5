Return-Path: <linux-kernel+bounces-98831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1C3878002
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E841C210CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53863D0A1;
	Mon, 11 Mar 2024 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="SpMQVh0G"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2118.outbound.protection.outlook.com [40.107.255.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B9C33CCD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710160295; cv=fail; b=SdUDFR8cNwQ1/JeM4zIsxKk6aHg83ZFwaKOWuPmKMx3MscPK71UcSiC3Gb/E0Xpc/LRkzNaoMFsFfz9UbqhVnQXyx0PWeSiBGgmgxbhO5Wj+8Uu9pz7L2aYUYq5qDtvZne2pK2aXlYtvn4Zx9mmxGAseR2/ss5N560UN+4m53zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710160295; c=relaxed/simple;
	bh=65JqdneqLZZp4h0tGHpEBnEjG83bhjFjpMjMM16kNfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aGWgaa7ASQAGLG9kI4h6tgZ+koEXBJ206G5OjmAnCGVYTmD8ef7HdbKiCmzPDo7HvDipC+sHAHFBJILCCLDBU+cBS7ScZahQ3ibTTUqddBNFE4ylOgYi4qMpNk1wI5GSGmqEkojhcsK/xhKwn2AuYgKthryEUFlFSUnR85rbw0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=SpMQVh0G; arc=fail smtp.client-ip=40.107.255.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NowdWrVLNgn174mGfZBbYDZ9IEA5h51iH2LhbklyRMAQHG2v5rq1fgPGYGQwENC+Fs9ShdzbvDWfCGfprI7QxM/YQs+La6KT2GEaHDDh4UglqoBx9Yq3ifn3TJeIXWFC2i+5T7+sl64R3Gz/0a5AADgvzbPYGYc3rtfHUjRB98FmH/WqPbVdybSeDo3ucDIe7ofXfzG7D89cKw1+YHnp4AWkOJU89fwYGT1JKi3+q7MgOZlFoIxpbwVTvFNTZoWOfvaXAQqJzQ6dBt0jOOiRHLm8zHbTbl9QvtFu6YNI5rHgsvjStoHHkJMYrKrLT/9GRUeXEH3WGyp1a53TKQtlAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65JqdneqLZZp4h0tGHpEBnEjG83bhjFjpMjMM16kNfs=;
 b=MhsiVtty74Vi/Grs54puk4ps1+luz33dKnJgqR2T/GBBYn2CUkRhuGJwZB7JI7h3XEL9y6dhuIP2Jbk8snfO0mcFOFyf2C9ZD+h2apq2He+CAO8Id6bHraaIRtv2ALPMJIuAaR8LXEvBN6gXvT3WPsWwwhrb7/t7EJw+/iUwIhOocgMQSJQKlhYCOPM+iJtsmXlutC8laP+ps7FbeUiOweg0/qHhBiD3Sk37ydP941+NOCpMg1SETvlElAQmd8frLuSr3V/j7PFlg5t9lLNOelKZzT1sRPVkx6WoXFOpmzhOFZt/rPCMdpJTxkxKPH7rldCwnb8hEAEmM8VShcNNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65JqdneqLZZp4h0tGHpEBnEjG83bhjFjpMjMM16kNfs=;
 b=SpMQVh0G6sW91BBmk6gUt2jB/EsgqmKTMUvNxQGXyHxAUb3DtPs61C1QWWk+MpMgzk648Q9EVMVq/evg2YIxKSGX1o+573u1QXRp+w7zFPT+hsbMX9c8ETOlK4BMU4grpDZ5uPiSOsAW/0R7wepHpHfaTwIM4gar2XHqBvgYyKZG5ZNgW0CfjpGwsz/mWOTLQn6tuXkmimPVXU6lH5D1tIuwANAk+pz4nkn+nvfs3OSYuyuwsZCFgHERSc8761cQqcX1LWzGPB/4oUcXesZfTqO5BuPvTf6Dw8yzsvEy4O0Q035nlaYQEwFaVvTp5d6vPrdXSltZ/WZKgDHK5UxLBw==
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by PUZPR06MB6268.apcprd06.prod.outlook.com
 (2603:1096:301:112::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 12:31:28 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::1ecf:ff1c:bbe9:49e3]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::1ecf:ff1c:bbe9:49e3%5]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 12:31:28 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, Maciej
 Wieczor-Retman <maciej.wieczor-retman@intel.com>
CC: "james.morse@arm.com" <james.morse@arm.com>, "fenghua.yu@intel.com"
	<fenghua.yu@intel.com>, "reinette.chatre@intel.com"
	<reinette.chatre@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Liming Wu <liming.wu@jaguar.com>
Subject:
 =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF0gZnMvcmVzY3RybDogZml4IGRvbWlk?=
 =?utf-8?Q?_loss_precision_issue?=
Thread-Topic:
 =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGZzL3Jlc2N0cmw6IGZpeCBkb21pZCBsb3NzIHBy?=
 =?utf-8?Q?ecision_issue?=
Thread-Index: AQHac4AkEIbtytV3wE6T19k1pZ0h/bEyM+8AgAAHshCAADHDgIAAB94AgAADJ2A=
Date: Mon, 11 Mar 2024 12:31:28 +0000
Message-ID:
 <KL1PR0601MB57730994C0501212DF6DDC6EE6242@KL1PR0601MB5773.apcprd06.prod.outlook.com>
References: <20240311064822.891-1-rex.nie@jaguarmicro.com>
 <2u7eg2khp2zrcmbfpnh6ighxqbttv2w7giwdxlkndeywpgq2bq@2lccnqwkbo65>
 <KL1PR0601MB577303C9D0B1247436BB06F8E6242@KL1PR0601MB5773.apcprd06.prod.outlook.com>
 <3fjeeggediya7cl26snya5o5oif6x2xfd26qmsvroe6jygtufu@whanfahntydy>
 <dcef573e-dada-efdc-32d0-8e6070af9d99@linux.intel.com>
In-Reply-To: <dcef573e-dada-efdc-32d0-8e6070af9d99@linux.intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB5773:EE_|PUZPR06MB6268:EE_
x-ms-office365-filtering-correlation-id: 6d3f5c94-6513-47cd-48f5-08dc41c72cc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fSq17vlmUFNxsmIK7ubSGT1vplSr7NEu1EjvBllKR0j2AeEhGN89AC8lhL3I5ezN7hdFKFAeXn85N2HARaXo9lufyocSqPWJZ2mUvu8g2U5/JCDRUCDTWVA+rKpBa/RQROJNxiDEwP0J9+LzAwLLseoUnMCulauwKGVWzQ/dkzR6dvKutfId6iog00ZwrAFkMl/4QzgjosfY3J82xSNtpJjjo12xL+xdy5HtVpQhdg090wA4wj71rQ9vGJ06DFGp7cGMjze/+i8gb9HmZYm+Pa3dQwLe27nIwFSqBeitLM3OguipNvGU5Ax/FHM8fT1CC4jYuB+08z/ACWNfOc+eSIqel8lL2AafMQYxFb96Hh/6r3aoVP/aW3i0iRKDU/iNYmwyLIYFraQazuEoV1VrS1PsQD51zk4x8JioMzORG+AmFG9GzTSOSGS7EddkIMczI0l3afMC8mTOmT70r3d4VHBlP0pT1RGGC1xm+XAyvNHu0x5k1cdSgmMX4zmmczAcOE+PqoGFbckhVqcOsuZNbLujIDkUMg00OT+ei4cV6R4hHNYJxOEr1eErQ8NG5fmBP7BNs5/vm3cVb5OH0OE1/BvgoWnlcmju/z88rNlpaw0DRIJtVV1yMLt1Reen1rAdmaAbsmvq1DGBuXRDf4ZLsHWOk6K0bGe/93VFHd8141c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WlByYS8vMmlPZ2ZKWGFGeHB1cWNqcnUvdlVMSVY5VVAxQkl2QWV0dy90d1cr?=
 =?utf-8?B?SFVPcFBBYXplOC9MYnhwcXJvcVZEMDdLdmVYSHZ4QVJPN3VxcGNRenk3c1Zs?=
 =?utf-8?B?cU1hWk03NWlFVnhYWjBwSGhKM0Q5VDlzL1NnQkRSVkY4Wk5mcE4zOGtOVHo5?=
 =?utf-8?B?UXV4S1hyTEVIZm9GNnpBUFJZU25pRmppS01OWHVqZmZ2NnFHT29HVGlJdE9Q?=
 =?utf-8?B?TXE5eVhBMWlRZUJRM3d1Rit2ZE05OEFtZjFMajEyZVR6aFhuZUYzSFMzRWtw?=
 =?utf-8?B?SnJBUVdZN2FNNEw5RUxIMWVsM0d3SkxRYnp0eXppS0wzYWlRMFIwVkpsUlRq?=
 =?utf-8?B?ZnN6OXk4L1ZleFBDc1JQUmlwaks1UmNDS3VoMGJqWE5hcEJST2ZPL0V4cDV2?=
 =?utf-8?B?RGtMZ0NoOXp2NHl4YlVzT3htQ01GbmtNNlFIelVxTlNXS25ibHljT0ovanAv?=
 =?utf-8?B?ald6cldHdndEN2ZRK3JtK2hZaERFU3FYRmRVdk14amt1SnA2Uk0vRE9oSDlL?=
 =?utf-8?B?TXpsdzgwUWxQeVA4MTN1RTVVOGRwem52bWxnSDA4cFBDWDgvQlVJZ3ZZVENW?=
 =?utf-8?B?MWVtZzFnejg2OXJaTjV6dmZEZnN1OEE1YlBGNWlnSXhoN0REUW5RdysyaDhy?=
 =?utf-8?B?QUFNNFJlKytPQVZ2eC84dUpsZnA2YmF0dmo1dkhUR2FER0NVamJxcDgrTTB4?=
 =?utf-8?B?SHUwUmFOQXZyM0ZVdTEwZzY4T2k1TEd2WEVIZkU0cU5WYUcybFhRd1A5WWxK?=
 =?utf-8?B?TlRNZ0hYUEFXRVBia2IwRXJsV2d3ZmZjMW45UnVOdys4OFF3d3phNVVCckQx?=
 =?utf-8?B?UTBvZlJHdU13VlM0dW0vTlhldUdNaXhBUEEvbDdrU3o1RTR3cUZCUFI4OGZu?=
 =?utf-8?B?SEJzYVZsT213VTN1YUphKzZTVy91eVNQRzRpQ0hOYTNVQTJ6bmlleTk4NE0y?=
 =?utf-8?B?V1VBRGU4emZRTWhiUTlaN05WU2UyZkdzaXdOUnpOOWFFWHk1aVRERGRBVWJ5?=
 =?utf-8?B?RG85V1pMdWpCZWs3L1RGMUl4UUhFVDhGS1F1MDhKb3hXcjRpeW0xVTUyZVlv?=
 =?utf-8?B?aUZGWHpwZ092Si9NWnEvb1RNNzU2QVdMQ1lFbHdGSGVwRWJRTEJDQ1h6eXRH?=
 =?utf-8?B?VndwRndtL3NLazJ6aFVhOEMrSDV0cDFhMUUwc2lGTVNuK3piM0x1Z1M4dENV?=
 =?utf-8?B?YlNWRXdJRVRHL2hyQ1l6ZEpheWoyR1RoZWttcG1PODM3QUgyUVp4blVndEtR?=
 =?utf-8?B?bklMYW5VS3hLbUt5ZTFOZDJLWVQ2VXErZEkrcVBuNk1JYThBVm1uRkk5dEpC?=
 =?utf-8?B?allWcDlTYjB5Rm5jYWgwYm1MYUQ4UFNwb0c1VDBPTktIUXRTdXRMM1pMdUl0?=
 =?utf-8?B?ZHJvTk5WanYxaS8weFBWY1o4REJRU3Z3N3NubEV5NlBOb3RWdHlCTjlwbUJ2?=
 =?utf-8?B?Tm1kQnRKMjJ6OGxzYnNNZEhjcEdSNXRVVGF3R2g0WlJPQkU5dU1oSDNKaUU0?=
 =?utf-8?B?WGpZRXhkV2hsSnFzR1pYRm1XOGlyMnAzT1ZZRGJPa0RHWWhXM2hUOHpPZXll?=
 =?utf-8?B?TlFqVExScWUvSTJ1Qis5NzdxTFBTQUhSTUN2L2ZuV3ZYMHFXTjlQcC9UdlVt?=
 =?utf-8?B?T09sMUpGNUJZc003d01tc3REeCtPMWlxck9IeGtHOUM5OGJMMmNtcklMY0ow?=
 =?utf-8?B?bXFNL1dWaUxBejhPYzcwNnRJZFVUblFGUHZCTkpJMG0wZnMxbUZlWVlGd2hu?=
 =?utf-8?B?aDNnU3M1N09JZ0NTdnhnYnYya0RnZTFkdjF4eXdaY21iSmpNZzlidnhzeE5S?=
 =?utf-8?B?WlVhQXJFcGM5aGNydTZhTGJKL2V6SHZSTmszNkNBZWlYWEQzQ0V1dk5pLzlF?=
 =?utf-8?B?alJFSE5UQ0NmYWlsR1VxdE9RNDZGQVpkRmJxblpjaXJkWFJwcTN0R2h1bSs2?=
 =?utf-8?B?T0NiV0pJVEEyVHFydzJ0M1d2WUlrT1kyK0t4VGRVNEdWT3U2TjhmYm5vaTlo?=
 =?utf-8?B?bXpZeEh0WXBGN0VpR3ROYWdNZGhLR24zZjFyTTh1WWJNVWF6aWdIN2FpZng2?=
 =?utf-8?B?U1JhUm9UWldHeEVtMXFTN0NBbU9RWVlKdEtXeU42RXNNc3FTVFdZdWpHb24y?=
 =?utf-8?Q?pdEETP54WOFu/0JgoXRfXaZoh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3f5c94-6513-47cd-48f5-08dc41c72cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 12:31:28.5171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EtYgA77FVPslrmook67ORXqMlb42Fq+Bt/eHd2HlV9WKpguQ606Omzjk5jDkAQ92CIWNVO6YxOClImDrguDtSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6268

T2ssIEkgYXBwbHkgaXQgYXMgcGF0Y2ggdjIsIGFuZCB0aGFua3MgZm9yIHlvdXIgY29tbWVudC4N
Cg0KPiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogSWxwbyBKw6RydmluZW4g
PGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjTlubQz
5pyIMTHml6UgMjA6MTgNCj4g5pS25Lu25Lq6OiBNYWNpZWogV2llY3pvci1SZXRtYW4gPG1hY2ll
ai53aWVjem9yLXJldG1hbkBpbnRlbC5jb20+OyBSZXggTmllDQo+IDxyZXgubmllQGphZ3Vhcm1p
Y3JvLmNvbT4NCj4g5oqE6YCBOiBqYW1lcy5tb3JzZUBhcm0uY29tOyBmZW5naHVhLnl1QGludGVs
LmNvbTsNCj4gcmVpbmV0dGUuY2hhdHJlQGludGVsLmNvbTsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgTGltaW5nIFd1DQo+IDxsaW1pbmcud3VAamFndWFyLmNvbT4NCj4g5Li76aKYOiBS
ZTog562U5aSNOiBbUEFUQ0hdIGZzL3Jlc2N0cmw6IGZpeCBkb21pZCBsb3NzIHByZWNpc2lvbiBp
c3N1ZQ0KPiANCj4gRXh0ZXJuYWwgTWFpbDogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gT1VU
U0lERSBvZiB0aGUgb3JnYW5pemF0aW9uIQ0KPiBEbyBub3QgY2xpY2sgbGlua3MsIG9wZW4gYXR0
YWNobWVudHMgb3IgcHJvdmlkZSBBTlkgaW5mb3JtYXRpb24gdW5sZXNzIHlvdQ0KPiByZWNvZ25p
emUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IE9u
IE1vbiwgMTEgTWFyIDIwMjQsIE1hY2llaiBXaWVjem9yLVJldG1hbiB3cm90ZToNCj4gDQo+ID4g
VGhhbmtzIGZvciB0aGUgcmVwbHksDQo+ID4NCj4gPiBPbiAyMDI0LTAzLTExIGF0IDA5OjM3OjM3
ICswMDAwLCBSZXggTmllIHdyb3RlOg0KPiA+ID5IZWxsbywNCj4gPiA+ICAgICBQbGVhc2Uga2lu
ZGx5IGNoZWNrIG15IGlubGluZSByZXBseS4gVGhhbmtzLg0KPiA+ID5CZXN0IHJlZ2FyZHMNCj4g
PiA+UmV4IE5pZQ0KPiA+ID4NCj4gPiA+PiA+VGhpcyB3aWxsIGNhdXNlIGJlbG93IGlzc3VlIGlm
IGNhY2hlX2lkID4gMHgzZmZmIGxpa2VzOg0KPiA+ID4+DQo+ID4gPj4gSXMgdGhlcmUgc29tZSBy
ZWFzb24gZm9yIGNhY2hlX2lkIGV2ZXIgYmVpbmcgdGhpcyBoaWdoPw0KPiA+ID4+DQo+ID4gPj4g
SSB0aG91Z2h0IHRoZSBtYXggZm9yIGNhY2hlX2lkIHdhcyB0aGUgYW1vdW50IG9mIEwzIGNhY2hl
cyBvbiBhDQo+ID4gPj4gc3lzdGVtLiBBbmQgSSBvbmx5IG9ic2VydmVkIGl0IGdvaW5nIHVwIHRv
IDMgb24gc29tZSBzZXJ2ZXINCj4gPiA+PiBwbGF0Zm9ybXMuIFNvIG5vdCBuZWFybHkgaW4gdGhl
IHJhbmdlIG9mIDB4M2ZmZiBvciAxNmsuDQo+ID4gPj4NCj4gPiA+SXQgaXMgZXhhY3RseSBhcyB5
b3Ugc2FpZCBvbiBYODYgcGxhdGZvcm1zLCBidXQgY2FjaGVfSWQgb24gQXJtIHBsYXRmb3JtIGlz
DQo+IGRpZmZlcmVudC4NCj4gPiA+QWNjb3JkaW5nIHRvIEFDUEkgZm9yIG1wYW0sIGNhY2hlIGlk
IGlzIHVzZWQgYXMgbG9jYXRvciBmb3IgY2FjaGUgTVNDLg0KPiBSZWZlcmVuY2UgdG8gUkRfUFBU
VF9DQUNIRV9JRCBkZWZpbml0aW9uIGZyb20gZWRrMi1wbGF0Zm9ybXM6DQo+ID4gPiNkZWZpbmUg
UkRfUFBUVF9DQUNIRV9JRChQYWNrYWdlSWQsIENsdXN0ZXJJZCwgQ29yZUlkLCBDYWNoZVR5cGUp
DQo+IFwNCj4gPiA+DQo+ICggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPiA+ICAgICAgICgoKFBhY2thZ2VJZCkgJiAweEYp
IDw8IDIwKSB8ICgoKENsdXN0ZXJJZCkgJiAweEZGKSA8PCAxMikgfA0KPiBcDQo+ID4gPiAgICAg
ICAoKChDb3JlSWQpICYgMHhGRikgPDwgNCkgfCAoKENhY2hlVHlwZSkgJiAweEYpDQo+IFwNCj4g
PiA+ICAgICApDQo+ID4gPlNvIGl0IG1heSBiZSA+IDB4M2ZmZiBvbiBBcm0gcGxhdGZvcm0uDQo+
IA0KPiBIaSBSZXgsDQo+IA0KPiBQbGVhc2UgYWxzbyBwdXQgdGhhdCBraW5kIG9mIGtub3dsZWRn
ZSBpbnRvIHRoZSBjb21taXQgbWVzc2FnZSB1cGZyb250LiBObw0KPiBuZWVkIHRvIGJlIGFzIHZl
cmJvc2UgYXMgeW91J3JlIGhlcmUgKHdpdGggY29kZSBxdW90ZXMsIGV0Yy4pIGJ1dCBzdGF0aW5n
IHRoYXQNCj4gc29tZSBwbGF0Zm9ybXMgdXNlIGhpZ2hlciBJRHMgKGUuZy4sIEFybSkgd291bGQg
YmUgcHJldHR5IHVzZWZ1bCBpbiBhbnN3ZXJpbmcNCj4gdGhlIHF1ZXN0aW9uIHdoeSB5b3UncmUg
ZG9pbmcgdGhpcyBjaGFuZ2UgKHdoaWNoIGlzIG9uZSBvZiB0aGUga2V5IHBvaW50cyBvZg0KPiBk
ZXNjcmliaW5nIHlvdXIgY2hhbmdlKS4NCj4gDQo+IC0tDQo+ICBpLg0KPiANCj4gPiA+UmVmZXJl
bmNlIFJEX1BQVFRfQ0FDSEVfSUQgZnJvbSBlZGsyLXBsYXRmb3JtczoNCj4gPiA+aHR0cHM6Ly9n
aXRodWIuY29tL3RpYW5vY29yZS9lZGsyLXBsYXRmb3Jtcy9ibG9iL21hc3Rlci9QbGF0Zm9ybS9B
Uk0vDQo+ID4gPlNnaVBrZy9JbmNsdWRlL1NnaUFjcGlIZWFkZXIuaCNMMjAyDQo+ID4NCj4gPiBh
bmQgdGhhbmtzIGZvciBjbGVhcmluZyBpdCB1cCBmb3IgbWUhIEkgYnJvd3NlZCBzb21lIE1QQU0g
cGF0Y2hlcyBidXQNCj4gPiBkaWRuJ3Qgbm90aWNlIGNhY2hlX2lkIHdhcyB1c2VkIGRpZmZlcmVu
dGx5IG9uIEFSTS4NCj4gPg0KPiA+ID4NCj4gPiA+PiA+L3N5cy9mcy9yZXNjdHJsL21vbl9ncm91
cHMvcDEvbW9uX2RhdGEvbW9uX0wzXzEwNDg1NjQgIyBjYXQNCj4gPiA+PiA+bGxjX29jY3VwYW5j
eQ0KPiA+ID4+DQo+ID4gPj4gSG93IGRpZCB5b3UgZ2V0IHRoaXMgZmlsZSB0byBhcHBlYXI/IENv
dWxkIHlvdSBtYXliZSBzaG93IGhvdyB5b3VyDQo+ID4gPj4gbW9uX2RhdGEgZGlyZWN0b3J5IGxv
b2tzIGxpa2U/DQo+ID4gPj4NCj4gPiA+SSBmb3VuZCB0aGlzIGlzc3VlIG9uIEFybSBGVlAgTjEg
cGxhdGZvcm0gYW5kIG15IE4yIHBsYXRmb3JtLg0KPiA+ID4NCj4gPiA+QmVsb3cgaXMgdGhlIHN0
ZXBzIG9uIEFybSBGVlAgTjE6DQo+ID4gPm1vdW50IC10IHJlc2N0cmwgcmVzY3RybCAvIC9zeXMv
ZnMvcmVzY3RybCBjZA0KPiA+ID4vc3lzL2ZzL3Jlc2N0cmwvbW9uX2RhdGENCj4gPiA+DQo+ID4g
Pi9zeXMvZnMvcmVzY3RybC9tb25fZGF0YSAjIGxzIC1sDQo+ID4gPnRvdGFsIDANCj4gPiA+ZHIt
eHIteHIteCAgICAyIDAgICAgICAgIDAgICAgICAgICAgICAgICAgMCBNYXIgMTEgMDk6MjQNCj4g
bW9uX0wzXzEwNDg1NjQNCj4gPiA+DQo+ID4gPmNkIC9zeXMvZnMvcmVzY3RybC9tb25fZGF0YSAj
IGNkIG1vbl9MM18xMDQ4NTY0DQo+ID4gPi9zeXMvZnMvcmVzY3RybC9tb25fZGF0YS9tb25fTDNf
MTA0ODU2NCAjIGNhdCBsbGNfb2NjdXBhbmN5DQo+ID4gPmNhdDogcmVhZCBlcnJvcjogTm8gc3Vj
aCBmaWxlIG9yIGRpcmVjdG9yeQ0KPiA+ID4NCj4gPiA+QXJtIEZWUCBNUEFNOg0KPiA+ID5odHRw
czovL25lb3ZlcnNlLXJlZmVyZW5jZS1kZXNpZ24uZG9jcy5hcm0uY29tL2VuL2xhdGVzdC9tcGFt
L21wYW0tcmUNCj4gPiA+c2N0cmwuaHRtbCNtZW1vcnktc3lzdGVtLXJlc291cmNlLXBhcnRpdGlv
bmluZy1hbmQtbW9uaXRvcmluZy1tcGFtDQo+ID4gPg0KPiA+DQo+ID4NCg0K

