Return-Path: <linux-kernel+bounces-98637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE8B877D14
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A888F1F23589
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B17418643;
	Mon, 11 Mar 2024 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="GdD1xOpO"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2119.outbound.protection.outlook.com [40.107.215.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B670C12B7F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149866; cv=fail; b=DoSelMecZ7C9YLcSYrgqv8YOEV90DhqhvBbTrJGV669Cqxcdem8c117giwRF7jaSO/G9BQc2gcNjt3BP4YYpKbz0lZjrNkmRX0zMgOCLCxjsxtHL1fBl2YdFzBVxlErEmB6TR5JCeu6Eu/Sr9kYrVpsznyNpuD56f6suuEJlrt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149866; c=relaxed/simple;
	bh=vrTQnU95z/pPOdApiC2cnwqZZcZn1vBl1SGgEaqvpSs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dneC4g5NZ/jlCHYEaXCfnceApA7MB/PB9doTPVe82CBXLY5Fo/fOknSW3OdGRnwYOSmZtGA2N7DaPxUOhe7DAp4YeKrAyJY65TF4WzwZSOjAZn8uXEjjKBdQkHpeT3eryfHfmPW8L/SF5gL49jjF4Yu3hEoByn7pHStHxSQvqJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=GdD1xOpO; arc=fail smtp.client-ip=40.107.215.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVfQeHUwLq3lZ6vv8tiWR8b9aA2nkd42KtzZHx4NNT4ik3YCkYCixT4tEbu7xIAYj7PL6q5rVCDdyl9phRZAllkKEQxU8Crt3TatpcjgaLexZSN8cFg9lpucaKARerc/Pt/aNG5TZ0YBjSqeOpgxclY14h7JdzdqKoa3AZK/vu9RNOcGq07V/15w3/YmOa8wp5agRG+kh0pmeCK8UtiV3D7b9PlfmH5E31xaLO2JY3y+Eyf+MyAinYOyBBqlPa1oVmfLhGVU1hmPmE7d1/Aqc9DyNvsij5XkZv1YDoLD4AgmIcvQHFkU6v8OH4qvWxLwcS33XYSBOgfLyfUOBYZOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrTQnU95z/pPOdApiC2cnwqZZcZn1vBl1SGgEaqvpSs=;
 b=gHs0CWLzLq2YNDfU3P6a1Tvb4C2La24BiK81IEGIQuhELakGoHFLkBMwSBrB/1nhv97hs+Qh7NcxtUBgRxlxc/P+2n7xNW0qsvaHMcISEfDzjbz2AMd/efbkLb/15F7b71ESMKdv7c+W40fthPCbXE0UKf/HIw5c0XaVhCMVUEeiT9hQawJOvOPdz/dJOtayju45XyBtLN0LioMxzNo0+C6J4cTVPGAom5qrNHQeaNq19vyw2iuig7Sw1IhKp5O630gXHHMWC8YHRafvJH75KXm/EPl5Jd9osmz/aG5h0t1ISNd3FGKiqvpGlO0V6DGWjemvriJ1NetFB1Fz9SFtIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrTQnU95z/pPOdApiC2cnwqZZcZn1vBl1SGgEaqvpSs=;
 b=GdD1xOpON++IwTp0F+Mna0O129LwztWa9CG8cwvpzFx/Ra7QLL+USW3+5CIKEcjqLRR2R8UFNfGKBUdBkJRBZzNK5bjToFfUs0+JFCm2HZW1Buc3VeL+MgRvOQ7mYVmYq5X1fykMLWUQ+Dr+IUyhU2OM8i+KqqlQ6/nqySQKuLauRUmKmJMn7qxQ45GOH7M9wZ7lVnVl7YIVHbIjw7VECIWhfvsz5d1DBv/rwiBd5KX3M7dgiIVj2hzZEXFbFxBQboduHySYsIC80Z9ne278rmqfcECpOZJt7FkEfEsJuzJQIt27RkXrFNqdL63v91RPofnpURjGVnlE9AE++hd6tA==
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by JH0PR06MB7236.apcprd06.prod.outlook.com
 (2603:1096:990:96::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Mon, 11 Mar
 2024 09:37:37 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::1ecf:ff1c:bbe9:49e3]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::1ecf:ff1c:bbe9:49e3%5]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 09:37:37 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
CC: "james.morse@arm.com" <james.morse@arm.com>, "fenghua.yu@intel.com"
	<fenghua.yu@intel.com>, "reinette.chatre@intel.com"
	<reinette.chatre@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Liming Wu <liming.wu@jaguar.com>
Subject:
 =?gb2312?B?tPC4tDogW1BBVENIXSBmcy9yZXNjdHJsOiBmaXggZG9taWQgbG9zcyBwcmVj?=
 =?gb2312?Q?ision_issue?=
Thread-Topic: [PATCH] fs/resctrl: fix domid loss precision issue
Thread-Index: AQHac4AkEIbtytV3wE6T19k1pZ0h/bEyM+8AgAAHshA=
Date: Mon, 11 Mar 2024 09:37:37 +0000
Message-ID:
 <KL1PR0601MB577303C9D0B1247436BB06F8E6242@KL1PR0601MB5773.apcprd06.prod.outlook.com>
References: <20240311064822.891-1-rex.nie@jaguarmicro.com>
 <2u7eg2khp2zrcmbfpnh6ighxqbttv2w7giwdxlkndeywpgq2bq@2lccnqwkbo65>
In-Reply-To: <2u7eg2khp2zrcmbfpnh6ighxqbttv2w7giwdxlkndeywpgq2bq@2lccnqwkbo65>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB5773:EE_|JH0PR06MB7236:EE_
x-ms-office365-filtering-correlation-id: aed7494a-d102-4ac7-d74b-08dc41aee356
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gblCRqCRkVd8uZam6noLc8SZuUVV8/gvxjsn92m5kxBLRd0N3ECzxj1X3WGbeDu//Vhjys6GHJx0XA4z6zD3/sNx7WyEDed8o2qwwkDgw0uRyMqZdjPUlUyN4bjLfQzDchUaOE5a8TFy7q5SW3+UwrJOxAMfA7aGTquGWhI3mJKbwDId9evnryVpVMBv0wGpFSlpJk2fZQEEVWIn+EY8iOazyyk38cMEv1heMeQzaEBsGPhgt5x3o4CoHlbIkusiIiTWBDBR+kKV4KVc0+2FI7Rnu40KqfJ24uEfAkC5+JU6Lab2NbbmRbbMRcImqzZjJgXFFTPpRqqjuFhVY4bZTzjwFOq4wabWh3r5Z0P2EuUpPT9oB/lU/abSlJMqwR/bKSbBIx1qPvbqAazEQCyy/VWCLW7pgbxGuuAxN8UaYYxN1MqISirt/88H9eZAyj9CDLhwsX6ddyEhW2jgVWY/lb4VZCHXdY38brh5ODBNRssCSpr4lf/2U9sqJIuCJ3rTY6XuIgNuF6yYpo0+pzDjgziaNYl1keWJTEzpxwM6Z6RUeyTrZvGk/egNrP37XoEb31t0tDuJdyW5U9580lZi7alwx3WSTeEB9ZzCUoz0mz8Kk1IubU4UtGBTdwgpiXxT1lCTKrQOINrP1uOJVlSN7nIsdsJklakNWH2xcHEpZdU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VDlCUi91SFYweEZIRnlrS0JiRXFRRlJvVTNwZmYyQlBKMS82b2x5Tk51cTJQ?=
 =?gb2312?B?VytJTHJwcHJ6Z251dEdQOEQ4bjROcHkvMCtLZ1AxMEhLbUpFcWJBM3RDOXE2?=
 =?gb2312?B?eVNUdjZnL0RCMjl2RFBaRHpYZFBFQ2d6amRhUjNXWUZ2YWEyU1ZPREFBK1ky?=
 =?gb2312?B?c1ZuT0FheTFTQlcxUTZ1THBwc0plOWJQUnQyNVQ0T1k4KzUyTmJibVNJL2pa?=
 =?gb2312?B?Q2RRSUsrcTBYMUhDTHhuTXl1WnNOTmhCV3RaZEFCbHhKeG9EM0tMVGM1bXZE?=
 =?gb2312?B?UllVMnVMTTdTa3QxWkFCY0hyR0VFNFNPWFVMMGMwcmo1NGtiZU9qNVJRaTlp?=
 =?gb2312?B?QXdDUjNPVU10eHJwS2ZSek5pSXRUaVM0OG5VeFpJcEVNQzFJRHIzMXNuU0RJ?=
 =?gb2312?B?V2pDMWRwRDJsMm1SOWkvRjhlOHVhTnV6K1NHVDhqOEVNNjRmVlpZRWN5SVdz?=
 =?gb2312?B?TUpOM2NvTWRmWU5CR2gvbUtYYWs3aFZLVGZDS0x5U1YxL2lXNm8xR1RvWTNu?=
 =?gb2312?B?ajlxUndEUWdOQ2hSclNuWWNJRUorbXpkUEVnSzNBcGJmSHFYOG1sOEgrUFM3?=
 =?gb2312?B?OHloVjZtaldnbGNnKzBaL2xhL1VGMmdYZjhFbTJjV21KcTR1UlR1WEVHYVJx?=
 =?gb2312?B?SFJtb0Z6cC9yUDdxbGxFUE5RYWxoVmxnY3ZkN0pQY1JIRExzV0t2blV3bGhW?=
 =?gb2312?B?cWJRRW5Za0R3MWhnZy9vVnQ4WWlIb25qQW5JRXZCRmRZZnN6Sk0wNm5BalFZ?=
 =?gb2312?B?K094LzhZT0NnWXltSVozNjFGUFhCVUdZelN1a0Y5K3k1Rzk5eWwxQmRZRHBS?=
 =?gb2312?B?cFF3TiszYUc2MEZZUTNGdHJyT0c1NmRCcmV2MTkvUGsvSlhRZGozaEtZY3VG?=
 =?gb2312?B?MU80WWlPNFBqbDVZTmtWQzJtUUEwcU52Qm4rcWdlK2U5dXBsdCtPVGZrSStN?=
 =?gb2312?B?d2ptR1lrOUhCeDdKY3l1UzI4THZnYnUyUk9xVWNuZHpKYWFWT0kybTVRSkFN?=
 =?gb2312?B?WEVrZjNlR2pobEZ3RDFkYThqTU1mRDlMR1g1aUdMY1dndVhHNGRNaUdxcVdB?=
 =?gb2312?B?b2pMcVhaYWhoZDhHTmxLMEdtMk5sVGRobmxwZ0hhSlp2eDE5cThPNm8waEpT?=
 =?gb2312?B?TVZINHlvb0ZMZUJlcWI1TkZFYXFqb2wwTjl2ODZmQkFSU01zTTVJUkQ3bHF1?=
 =?gb2312?B?Y0J6Q1UrVDZxTlpoalRRc3gvcmJ0ajlQSS8xMkRLYm1sZGhCakRxZnVua2xN?=
 =?gb2312?B?U0U0S3FYZ3NlbU11L0F6U25FMHlPQXVqUW5Va1lDR1lnYWUxL1lHTzlrd3RY?=
 =?gb2312?B?QjhMVHBQbUhleCsxaUk3NjcxaWNxOHlJeUR5aTBMZ1lhenRCcUJ2OTZLYXdt?=
 =?gb2312?B?N1M0aGtTOGFBWHVyOEdwWlZGV0pFUWZveUNQSEZmY0ZXU1ZTRFRoSVkxNVp6?=
 =?gb2312?B?MjZsbDN6K1NuZE5Yc3A1cEd3bDJuRXd1a25DV2tjdnpOR0hxeFBjcVBzRXQv?=
 =?gb2312?B?Q0FTUHVBMW44RmZYR3AxNytJQ29KRVh6VTJzT3ROM0tmK0RPVVV3RE5DeWZ5?=
 =?gb2312?B?eUFDZnhMRmdjWkNQZWsvZ0M0elU3T09tOEd0WmRLSFdrL0tFaGc1clkxc0Jq?=
 =?gb2312?B?ZUlraDdlU3hDS0lUZ29IQlNLOW9weWlPU2tjdldDNGhreDVwQUNXQ05PU3kr?=
 =?gb2312?B?WmFnZ1k5TVZoWHJNdkdWaVlnT3BXajAxZ0JOUkJUckcvNE1BZGl6Ly9UNy9T?=
 =?gb2312?B?NTd5ZnNnY1o3cUV2T3Vic1pxbGVoWFUrQVYvLzBGaGVJZDdiancza0pyNVZn?=
 =?gb2312?B?bW5NNXNzeTZOaEdFbk8wYUVHcUpxOXE0UXlzU0tZa05YNTNJcTFwOGk0SkFs?=
 =?gb2312?B?byt4dm5WMDdtZEFiU0Z0RVpLb1JndytHM3dKNXdMbTdyekNtSnQ0VzY2V1dX?=
 =?gb2312?B?d0RQQWNNZGtJdGNLdWtHMHhsSDBUZ011V3dpV1FTTTM2QW1vMjF2ejVQTUhK?=
 =?gb2312?B?R084Ri9STUJaNkxGUjZjVjhGU0V6TTZaazV2amp6RUNXWTFxOFhXVmI2cWJ1?=
 =?gb2312?B?bnZ1ZllRQ2NuQUZBQVZZZm93OFVURmVDZ0l3N2xqNVBCYzNUaTc0aWNuR05M?=
 =?gb2312?Q?liWuEHZ2d8J6OCd6p7qWix5GC?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aed7494a-d102-4ac7-d74b-08dc41aee356
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 09:37:37.3775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QqBdxRpFaFTbGiQE7FsLggWjAqEjT37RyfDQtCwVe62pUwZaQXXHVNx7n6fHG3jxgPieDfE9AOdxan8+7pWbJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7236

SGVsbG8sDQoJUGxlYXNlIGtpbmRseSBjaGVjayBteSBpbmxpbmUgcmVwbHkuIFRoYW5rcy4NCkJl
c3QgcmVnYXJkcw0KUmV4IE5pZQ0KDQo+IC0tLS0t08q8/tStvP4tLS0tLQ0KPiC3orz+yMs6IE1h
Y2llaiBXaWVjem9yLVJldG1hbiA8bWFjaWVqLndpZWN6b3ItcmV0bWFuQGludGVsLmNvbT4NCj4g
t6LLzcqxvOQ6IDIwMjTE6jPUwjExyNUgMTY6MjQNCj4gytW8/sjLOiBSZXggTmllIDxyZXgubmll
QGphZ3Vhcm1pY3JvLmNvbT4NCj4gs63LzTogamFtZXMubW9yc2VAYXJtLmNvbTsgZmVuZ2h1YS55
dUBpbnRlbC5jb207DQo+IHJlaW5ldHRlLmNoYXRyZUBpbnRlbC5jb207IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IExpbWluZyBXdQ0KPiA8bGltaW5nLnd1QGphZ3Vhci5jb20+DQo+INb3
zOI6IFJlOiBbUEFUQ0hdIGZzL3Jlc2N0cmw6IGZpeCBkb21pZCBsb3NzIHByZWNpc2lvbiBpc3N1
ZQ0KPiANCj4gRXh0ZXJuYWwgTWFpbDogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gT1VUU0lE
RSBvZiB0aGUgb3JnYW5pemF0aW9uIQ0KPiBEbyBub3QgY2xpY2sgbGlua3MsIG9wZW4gYXR0YWNo
bWVudHMgb3IgcHJvdmlkZSBBTlkgaW5mb3JtYXRpb24gdW5sZXNzIHlvdQ0KPiByZWNvZ25pemUg
dGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IEhlbGxv
LA0KPiANCj4gT24gMjAyNC0wMy0xMSBhdCAxNDo0ODoyMiArMDgwMCwgUmV4IE5pZSB3cm90ZToN
Cj4gPkJlbG93IHN0YXRlbWVudCBmcm9tIG1rZGlyX21vbmRhdGFfc3ViZGlyIGZ1bmN0aW9uIHdp
bGwgbG9zcyBwcmVjaXNpb24sDQo+ID5iZWNhdXNlIGl0IGFzc2lnbnMgaW50IHRvIDE0IGJpdHMg
Yml0ZmllbGQuDQo+ID4gICAgICAgcHJpdi51LmRvbWlkID0gZC0+aWQ7DQo+ID4NCj4gPlRoaXMg
d2lsbCBjYXVzZSBiZWxvdyBpc3N1ZSBpZiBjYWNoZV9pZCA+IDB4M2ZmZiBsaWtlczoNCj4gDQo+
IElzIHRoZXJlIHNvbWUgcmVhc29uIGZvciBjYWNoZV9pZCBldmVyIGJlaW5nIHRoaXMgaGlnaD8N
Cj4gDQo+IEkgdGhvdWdodCB0aGUgbWF4IGZvciBjYWNoZV9pZCB3YXMgdGhlIGFtb3VudCBvZiBM
MyBjYWNoZXMgb24gYSBzeXN0ZW0uIEFuZCBJDQo+IG9ubHkgb2JzZXJ2ZWQgaXQgZ29pbmcgdXAg
dG8gMyBvbiBzb21lIHNlcnZlciBwbGF0Zm9ybXMuIFNvIG5vdCBuZWFybHkgaW4gdGhlDQo+IHJh
bmdlIG9mIDB4M2ZmZiBvciAxNmsuDQo+IA0KSXQgaXMgZXhhY3RseSBhcyB5b3Ugc2FpZCBvbiBY
ODYgcGxhdGZvcm1zLCBidXQgY2FjaGVfSWQgb24gQXJtIHBsYXRmb3JtIGlzIGRpZmZlcmVudC4N
CkFjY29yZGluZyB0byBBQ1BJIGZvciBtcGFtLCBjYWNoZSBpZCBpcyB1c2VkIGFzIGxvY2F0b3Ig
Zm9yIGNhY2hlIE1TQy4gUmVmZXJlbmNlIHRvIFJEX1BQVFRfQ0FDSEVfSUQgZGVmaW5pdGlvbiBm
cm9tIGVkazItcGxhdGZvcm1zOg0KI2RlZmluZSBSRF9QUFRUX0NBQ0hFX0lEKFBhY2thZ2VJZCwg
Q2x1c3RlcklkLCBDb3JlSWQsIENhY2hlVHlwZSkgICAgICAgICBcDQoJKCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KCSAgKCgo
UGFja2FnZUlkKSAmIDB4RikgPDwgMjApIHwgKCgoQ2x1c3RlcklkKSAmIDB4RkYpIDw8IDEyKSB8
ICAgICAgICAgICAgICBcDQoJICAoKChDb3JlSWQpICYgMHhGRikgPDwgNCkgfCAoKENhY2hlVHlw
ZSkgJiAweEYpICAgICAgICAgICAgICAgICAgICAgICAgXA0KCSkNClNvIGl0IG1heSBiZSA+IDB4
M2ZmZiBvbiBBcm0gcGxhdGZvcm0uDQoNClJlZmVyZW5jZSBSRF9QUFRUX0NBQ0hFX0lEIGZyb20g
ZWRrMi1wbGF0Zm9ybXM6IGh0dHBzOi8vZ2l0aHViLmNvbS90aWFub2NvcmUvZWRrMi1wbGF0Zm9y
bXMvYmxvYi9tYXN0ZXIvUGxhdGZvcm0vQVJNL1NnaVBrZy9JbmNsdWRlL1NnaUFjcGlIZWFkZXIu
aCNMMjAyDQoNCj4gPi9zeXMvZnMvcmVzY3RybC9tb25fZ3JvdXBzL3AxL21vbl9kYXRhL21vbl9M
M18xMDQ4NTY0ICMgY2F0DQo+ID5sbGNfb2NjdXBhbmN5DQo+IA0KPiBIb3cgZGlkIHlvdSBnZXQg
dGhpcyBmaWxlIHRvIGFwcGVhcj8gQ291bGQgeW91IG1heWJlIHNob3cgaG93IHlvdXINCj4gbW9u
X2RhdGEgZGlyZWN0b3J5IGxvb2tzIGxpa2U/DQo+IA0KSSBmb3VuZCB0aGlzIGlzc3VlIG9uIEFy
bSBGVlAgTjEgcGxhdGZvcm0gYW5kIG15IE4yIHBsYXRmb3JtLg0KDQpCZWxvdyBpcyB0aGUgc3Rl
cHMgb24gQXJtIEZWUCBOMToNCm1vdW50IC10IHJlc2N0cmwgcmVzY3RybCAvIC9zeXMvZnMvcmVz
Y3RybA0KY2QgL3N5cy9mcy9yZXNjdHJsL21vbl9kYXRhDQoNCi9zeXMvZnMvcmVzY3RybC9tb25f
ZGF0YSAjIGxzIC1sDQp0b3RhbCAwDQpkci14ci14ci14ICAgIDIgMCAgICAgICAgMCAgICAgICAg
ICAgICAgICAwIE1hciAxMSAwOToyNCBtb25fTDNfMTA0ODU2NA0KDQpjZCAvc3lzL2ZzL3Jlc2N0
cmwvbW9uX2RhdGEgIyBjZCBtb25fTDNfMTA0ODU2NA0KL3N5cy9mcy9yZXNjdHJsL21vbl9kYXRh
L21vbl9MM18xMDQ4NTY0ICMgY2F0IGxsY19vY2N1cGFuY3kNCmNhdDogcmVhZCBlcnJvcjogTm8g
c3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0KDQpBcm0gRlZQIE1QQU06IGh0dHBzOi8vbmVvdmVyc2Ut
cmVmZXJlbmNlLWRlc2lnbi5kb2NzLmFybS5jb20vZW4vbGF0ZXN0L21wYW0vbXBhbS1yZXNjdHJs
Lmh0bWwjbWVtb3J5LXN5c3RlbS1yZXNvdXJjZS1wYXJ0aXRpb25pbmctYW5kLW1vbml0b3Jpbmct
bXBhbQ0KDQo+ID5jYXQ6IHJlYWQgZXJyb3I6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCj4g
Pg0KPiA+VGhpcyBpcyB0aGUgY2FsbCB0cmFjZSB3aGVuIGNhdCBsbGNfb2NjdXBhbmN5Og0KPiA+
cmR0Z3JvdXBfbW9uZGF0YV9zaG93KCkNCj4gPiAgICAgICBkb21pZCA9IG1kLnUuZG9taWQNCj4g
PiAgICAgICBkID0gcmVzY3RybF9hcmNoX2ZpbmRfZG9tYWluKHIsIGRvbWlkKQ0KPiA+DQo+ID5k
IGlzIG51bGwgaGVyZSBiZWNhdXNlIG9mIGxvc3NpbmcgcHJlY2lzaW9uDQo+ID4NCj4gPlNpZ25l
ZC1vZmYtYnk6IFJleCBOaWUgPHJleC5uaWVAamFndWFybWljcm8uY29tPg0KPiA+U2lnbmVkLW9m
Zi1ieTogTGltaW5nIFd1IDxsaW1pbmcud3VAamFndWFyLmNvbT4NCj4gPi0tLQ0KPiA+IGZzL3Jl
c2N0cmwvaW50ZXJuYWwuaCB8IDIgKy0NCj4gPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+ZGlmZiAtLWdpdCBhL2ZzL3Jlc2N0cmwvaW50ZXJu
YWwuaCBiL2ZzL3Jlc2N0cmwvaW50ZXJuYWwuaCBpbmRleA0KPiA+N2E2ZjQ2YjRlZGQwLi4wOTYz
MTc2MTA5NDkgMTAwNjQ0DQo+ID4tLS0gYS9mcy9yZXNjdHJsL2ludGVybmFsLmgNCj4gPisrKyBi
L2ZzL3Jlc2N0cmwvaW50ZXJuYWwuaA0KPiA+QEAgLTk0LDcgKzk0LDcgQEAgdW5pb24gbW9uX2Rh
dGFfYml0cyB7DQo+ID4gICAgICAgc3RydWN0IHsNCj4gPiAgICAgICAgICAgICAgIHVuc2lnbmVk
IGludCByaWQgICAgICAgICAgICAgICAgOiAxMDsNCj4gPiAgICAgICAgICAgICAgIGVudW0gcmVz
Y3RybF9ldmVudF9pZCBldnRpZCAgICAgOiA4Ow0KPiA+LSAgICAgICAgICAgICAgdW5zaWduZWQg
aW50IGRvbWlkICAgICAgICAgICAgICA6IDE0Ow0KPiA+KyAgICAgICAgICAgICAgdTMyICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBkb21pZDsNCj4gPiAgICAgICB9IHU7DQo+ID4gfTsNCj4g
Pg0KPiA+LS0NCj4gPjIuMzQuMQ0KPiA+DQo+IA0KPiAtLQ0KPiBLaW5kIHJlZ2FyZHMNCj4gTWFj
aWVqIFdpZWN6qK5yLVJldG1hbg0K

