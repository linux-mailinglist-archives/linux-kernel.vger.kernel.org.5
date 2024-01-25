Return-Path: <linux-kernel+bounces-38057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93DE83BA6A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68D81C22A40
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD801119E;
	Thu, 25 Jan 2024 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P4s923Hg"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6210A21;
	Thu, 25 Jan 2024 07:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706166391; cv=fail; b=f5YFIrW1DvKQokzZ3Z3eakoZIkY3Tno49l5bQtFUEqij+7vnRy3Le95GqZ85XXDQGr5gFj8lcsXgAH9mFQZ7hpXzWpytzE6pG2G5mbg7Z5WQV9aTcLLuu2AqPrCYdqqzwu3WC9dJV8+rCS0ATDRslDivzNGLJ2z2DIL4VHParOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706166391; c=relaxed/simple;
	bh=Im59K3btOTrT3DuKk4jT6oJno/g+XZ3kXtyk3VMXnvo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CqaamcR9XLJZ6GfCyCdeqTDyDbTlhCtamlCZcBGxCY4CcTUGe5CNVeUZ0Ss2K6el7FffxOcl5PeNUdhDQ9SxcPJAqxixmzQ/GkgPzPpDUa+JnYfDpuHg41TyYe0MoX2aJVNnljPbhmvBsQWTnwvWXWvedXHf9uwsXBoFX7ctAog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=P4s923Hg; arc=fail smtp.client-ip=40.107.8.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQC23D4eq9bajPg3IfCci6D8V+wMfvFTJF9JeAFFDTykXBKsgS30SfKZwUCCFuSVrwon610Hs6uPjO0M/dEb7c1+Eq0KSKO7akPfIisS5xtdOweMAWWcwBD+l9i5LnmUL5Cd4od7h2oTv89h63Vo2yeUjCAqNk6zcK1A0sIg1QXKN4op05ZAEFwUlMly4K2g+tSfiFsZPAN846a3IpDS4zvVeDYlrk8khBeBVDN7IoEdNQe7t/9dJl35cjGXN1LmthhzLYCrrFVoseSzRZIBFX3pbkOADuDEQg/VsyZM/ei82B/6anceOxHpqw+b8OV2SrzonjcySPCMbzaVQxG8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Im59K3btOTrT3DuKk4jT6oJno/g+XZ3kXtyk3VMXnvo=;
 b=UeTjqI3V5Rjxp766UWx3P2MKC+5ESb/BcVvWxW+N0MV4CV6QhZxVwDH93YdWGT0Y2cAAYq/1bno1S2CjCnoY8wB5J/RfEBYNpVpU6Q621jdXlAkGggMbLYB3gLc2ETqzuSKAzZnUGTV+Elyr/0wnGYaUDnydxkp6Axtdt4Q7Fwav0Cg2SgFFK61SSScPC8O5oKj2RriO6ESnqoCHIuIiKtBhNzpEB6qxzL0Xc9NUFMnpFhwkOBdSLasReVct0lZIhnUFbWSW09i90lOwr+7GWiorOyC9miXvLiiEQm8mOH00pfpOvsRScn7u/jWd/LqpBh7WHowg/chobNa8IQ90fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Im59K3btOTrT3DuKk4jT6oJno/g+XZ3kXtyk3VMXnvo=;
 b=P4s923Hg9BaQEFGuEbYG/29hShvnFkLNeW3WtzI2eVeUHV8vsraOJi/rq7jXaNxcGhU71C9QnshW/Bzrcr4ep24+5yxHwTtEvqZhZ/s/93aOeXiB6XdciZrm6nXLDj3C4AifYt3sMUTiiw5GlEqEKb59IpZCMKLlEwXBTLjnxGs=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7335.eurprd04.prod.outlook.com (2603:10a6:10:1b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 07:06:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 07:06:25 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Guenter Roeck <linux@roeck-us.net>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, "groeck7@gmail.com" <groeck7@gmail.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>, "jdelvare@suse.com" <jdelvare@suse.com>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3] hwmon: scmi-hwmon: implement change_mode for thermal
 zones
Thread-Topic: [PATCH V3] hwmon: scmi-hwmon: implement change_mode for thermal
 zones
Thread-Index: AQHaT1lW79cmzSPKCUytPMAjATcCq7DqF+KAgAAAz2A=
Date: Thu, 25 Jan 2024 07:06:25 +0000
Message-ID:
 <DU0PR04MB9417DAD2DBB8820344FEFB07887A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240125064422.347002-1-peng.fan@oss.nxp.com>
 <b839f83f-c8c7-4fa8-8597-bdde1b40168a@roeck-us.net>
In-Reply-To: <b839f83f-c8c7-4fa8-8597-bdde1b40168a@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBAPR04MB7335:EE_
x-ms-office365-filtering-correlation-id: 1f68e57d-16b0-4108-4dac-08dc1d74254d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5ns7nx0KfaG/4XB9MYOzLfpfSuWdI7fUddV5HjD77ALxNxjA0oRU7EMJMZ6/rmDUYZ8SY1ydrhdK1yhu9H+4Y3Y8jmXPUfaF9ErwbWRBsCWfcrkIZDcYxRf/4aJN39zOoAeTsbXPHUB7bS7kEjMT31eu3bc2zaRpgSZOy6iOtL/NaBEevKyOfcU7Y+Es4wmuNx7j4bH+cA75ys7I9D70S1cq/R1ucmPbx9vVYNP3UPiqzvOK8QA7tSkcD40j34Jo8NT1Rq82payKBqx+1iZI1YpwMKsY6n5m0ly//B2FmsyNCsQCJ7porUJnvkLLEXb0YCHGr08p+dXzpAwkZOnBYl3UiNa8XyAyEiWXTi7CJmWr3b5v5MOy7AdTtVOdDdZLY1VmQYfUVXEv8MWC65CpuyAuUDLKRQD77JHyGhE2U6HZQqiEmtGT/EnfOwVuTfFhwzHgWMNVyGhaP3H/8E5WD7GbsTu14Dp5jE/ZNJhzefC7wVw0U/jHN5694J1s8szGxK1DD1CdKDNc/RaP0Pp6UaLBfQg3zr31ei/BXY8fcgiN0rQEK4aSdO5pHOUWlHCGQBOx01x1WaNSPgpJ3dHwJGDY8d6mi/2UX4bXx1G8wC16/m5MOg9irgGI3eW2hIYh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(52536014)(55016003)(66946007)(54906003)(6506007)(86362001)(64756008)(316002)(110136005)(66556008)(66446008)(66476007)(76116006)(41300700001)(4326008)(83380400001)(33656002)(7696005)(44832011)(8936002)(8676002)(26005)(2906002)(478600001)(9686003)(53546011)(5660300002)(71200400001)(122000001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGJvOTBRZ1hkaElqV0IvUDU1QXFXc0hCeit2U1R3Q0VzN25WVXBhKzZkU3Qw?=
 =?utf-8?B?WnFyWmFUaysyRk5SOENVN0dhblNzL3dwSEk2QWorK1RBcmJFN01oMDI4WFdw?=
 =?utf-8?B?TUhsMGoxS255YlFxUEtkSnkyQ1JaOUpHV0hGZnB6NitYemprNEx5YzVwYTk2?=
 =?utf-8?B?aXpxZ29rQSszOWM2Z0xrZy9ERGtKdHdkQVlTTnRxQTNOb2VGa00wRmpBZW5E?=
 =?utf-8?B?K2pwdnVjMllkTm1qdGpMU3ZkeGhHT1pqSnZsTG1IMnhXa1pnNmMyMUd3THhD?=
 =?utf-8?B?TVJCdW1tQVNsYUJ5R2EvNUducktWL1c4N0Z4cHo2c1hyaEphQXhYQ0Rmd1hT?=
 =?utf-8?B?MmduZk5Objh4REF6Z0tWTnN0enpJanBha3VPR0RZaDhaTDUzWHM1a2tEM3dV?=
 =?utf-8?B?WHNHTmlndC9qRVI5Q0thaDg4SXo5NUI0QTBJdjA5QWVxWlNEcFVsQzd2S01u?=
 =?utf-8?B?UWw4cTk3MXVVNnRmajluemVJZzIwamd5ZWZqNzZZU2ZiT2d0bTJOOEhOeXJN?=
 =?utf-8?B?aTB6YnFMSVUraUJCUmFHbFB3ZGt2SWJwZlZFM21QeGZ2WnFaL1orMGdoRmZ6?=
 =?utf-8?B?WUFBdm91QkxkbHlXS0U5a2xIYkFRMGV6c0drT3d0Z2NQUUZ4eXY5OGwvSUV2?=
 =?utf-8?B?dXpucUs1bm5pTlJVT2lPOTVXZnM3MnZKaTQ0Z1J6UE16TXFIbzR2c3kzTFZV?=
 =?utf-8?B?a3ErakRYV2VIZUFuRGUwQlYrSWZPNjVnaThnK2xYblA4cml3TjVsdHZuNU51?=
 =?utf-8?B?VnRXMkFLK0tXNXQrUnlOTVBpVW9KdExaV0IzOVVHbG5rSHVGclI4R0I2cTk1?=
 =?utf-8?B?Mld1ZVZyOWttZFpwNlNERXprNUxCUzRRVDVCV21SNXowMHdaR0haYUlDbUE4?=
 =?utf-8?B?clZ2ZHZGc0NUWGl6MnNTbDhOUy81NFlGejRUSndWTTZCQ2hjdzBFcDh5S2lY?=
 =?utf-8?B?UEtQQmFTUkt1ZVZaL0ZteW4wK2hXWlVHQWFESHVwZnN1aWZ2TXFCeXFKTkpB?=
 =?utf-8?B?WExlWnYzMHVHQStkR3QyaUE3dE55S1BTM1NDay8zWGp4TTc0VWdVZzMrYlpL?=
 =?utf-8?B?UHZvTGRRcXhEdFVzd0JnNllzd0pTUXRJZm1MRzdIcndsQnh1cmpWcnpSRW9y?=
 =?utf-8?B?bWx1L0V5TUluZUVwNEVETkxjeDFXdStWZ09qL2diMlRxcm5lTS80bXJzVEg3?=
 =?utf-8?B?YTJ2ZmFOUDZGQ0pkeGxJU2d2d2l4Nm9Pd3VDeXkyQ05RT1N0djlUVmV3aG9N?=
 =?utf-8?B?aEEwZkJYNkE5anNEeDkrdVNxRzhQMmQ5MjJTOEpCNFBsWVp3aFR2YUVUaTQr?=
 =?utf-8?B?M25GSGhvdlZITkFlT2NvTkU4L0pEUmxZclUyaVhNOVZKVXZDRi9RZ2h0TzBy?=
 =?utf-8?B?NG1uazUrQW1HUTlMRkVGaTVVbjhuaVBhejVPSWk5cWFwZk1pM1I5WlltSGh4?=
 =?utf-8?B?OFFjS3JLUy9kQW5GZ01XaTByenpsQjVQVWk0U3VzUkNsY3VHbFJDS2s0aEF1?=
 =?utf-8?B?WmhXMmlFdTkvb3ROdzI4QWhqZHNBZlJwKzIzcUp0NGM1TUh2cW44NFdGd0NI?=
 =?utf-8?B?aDN0UkxVaWpqOVpXNXVQQ1grN2JlUGRBYjFUUjZrZmsvWXFWek1nOGhKbWpO?=
 =?utf-8?B?YTZQUlk3RE80VUVKY05rZDUzSEcyS0diWTFpS0tzNVZHTW5tbmI0Y2NvUk9C?=
 =?utf-8?B?SU5rclAvY0hMdUxYajFkMGhuSGJrSlZKbVU1MUYzcnBXTGJUN3pod2Q0RnlO?=
 =?utf-8?B?TUVZTm5aQWV1K3VRdVlIRjloWXgrcThOV2tmT3ErNzQwOXhxRnk2K01Ea0Zv?=
 =?utf-8?B?WG5WYSt1QzdNb0NnRWg0QlJoUC9uVzBsUjc0UUxEQnlZK1Y0UHhRNGJ4R2ZF?=
 =?utf-8?B?dTZxdkxGZnJWRkZvNTdJZnV5dE9BUW9ZWU51T1loM3JuSGR1VEdMUFp0WkZ2?=
 =?utf-8?B?N3ZOdEhlUnA3SDZMdDhZNldLanREK01uK25URHc4YXlhc09TdXIvMEZzQzVt?=
 =?utf-8?B?WTBNSlVlakR6M0FZZXhQa2l1Q3VSSSthOHZqQ0VnSExiK2Y1ZEk2TFVBRkpn?=
 =?utf-8?B?ZFBsNFhEcngxMGlYT1BPOXRVbE1wUGhKcTZrSUFlWGV6ZElXb1VFMDM1QTRC?=
 =?utf-8?Q?cK+c=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f68e57d-16b0-4108-4dac-08dc1d74254d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 07:06:25.8646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zyoy668o6tu/IlcdOC78vSfvGhrkOC2KBE66ljV4G/pbz34mj1n0I+oo14xYrvF5gu0OzBuFLTvmrmI2KMCGFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7335

SGkgR3VlbnRlciwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzXSBod21vbjogc2NtaS1od21v
bjogaW1wbGVtZW50IGNoYW5nZV9tb2RlIGZvcg0KPiB0aGVybWFsIHpvbmVzDQo+IA0KPiBPbiAx
LzI0LzI0IDIyOjQ0LCBQZW5nIEZhbiAoT1NTKSB3cm90ZToNCj4gPiBGcm9tOiBQZW5nIEZhbiA8
cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0KPiA+IFRoZSB0aGVybWFsIHNlbnNvcnMgbWF5YmUgZGlz
YWJsZWQgYmVmb3JlIGtlcm5lbCBib290LCBzbyBhZGQNCj4gPiBjaGFuZ2VfbW9kZSBmb3IgdGhl
cm1hbCB6b25lcyB0byBzdXBwb3J0IGNvbmZpZ3VyaW5nIHRoZSB0aGVybWFsDQo+ID4gc2Vuc29y
IHRvIGVuYWJsZWQgc3RhdGUuIElmIHJlYWRpbmcgdGhlIHRlbXBlcmF0dXJlIHdoZW4gdGhlIHNl
bnNvciBpcw0KPiA+IGRpc2FibGVkLCB0aGVyZSB3aWxsIGJlIGVycm9yIHJlcG9ydGVkLg0KPiA+
DQo+ID4gVGhlIGNvc3QgaXMgYW4gZXh0cmEgY29uZmlnX2dldCBhbGwgdG8gU0NNSSBmaXJtd2Fy
ZSB0byBnZXQgdGhlIHN0YXR1cw0KPiA+IG9mIHRoZSB0aGVybWFsIHNlbnNvci4gTm8gZnVuY3Rp
b24gbGV2ZWwgaW1wYWN0Lg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IENyaXN0aWFuIE1hcnVzc2kg
PGNyaXN0aWFuLm1hcnVzc2lAYXJtLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8
cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPg0KPiA+IFYzOg0KPiA+ICAgVXBkYXRlIGNv
bW1pdCBsb2cgdG8gc2hvdyBpdCBvbmx5IGFwcGx5cyB0byB0aGVybWFsDQo+ID4gICBBZGQgY29t
bWVudHMgaW4gY29kZQ0KPiA+ICAgQWRkIFItYiBmcm9tIENyaXN0aWFuDQo+ID4NCj4gDQo+IFlv
dSBkaWRuJ3QgYWRkcmVzcyBteSBxdWVzdGlvbiByZWdhcmRpbmcgdGhlIGJlaGF2aW9yIG9mIGh3
bW9uIGF0dHJpYnV0ZXMgaWYNCj4gYSBzZW5zb3IgaXMgZGlzYWJsZWQuDQoNCldvdWxkIHlvdSBw
bGVhc2Ugc2hhcmUgYSBiaXQgbW9yZSBvbiB3aGF0IGF0dHJpYnV0ZXM/DQpZb3UgbWVhbiB0aGUg
ZmlsZXMgdW5kZXIgL3N5cy9jbGFzcy9od21vbi9od21vbjA/DQoNCklmIHRoZSBzZW5zb3IgaXMg
ZGlzYWJsZWQsIHdoZW4gY2F0IHRlbXBbeF1faW5wdXQsIGl0IHdpbGwNCnJlcG9ydDoNCnJvb3RA
aW14OTUtMTl4MTktbHBkZHI1LWV2azovc3lzL2NsYXNzL2h3bW9uL2h3bW9uMCMgY2F0IHRlbXAz
X2lucHV0DQpjYXQ6IHRlbXAzX2lucHV0OiBQcm90b2NvbCBlcnJvcg0KDQpGb3IgZW5hYmxlZCwg
aXQgd2lsbCByZXBvcnQgdmFsdWU6DQpyb290QGlteDk1LTE5eDE5LWxwZGRyNS1ldms6L3N5cy9j
bGFzcy9od21vbi9od21vbjAjIGNhdCB0ZW1wMV9pbnB1dA0KMzE5MDANCg0KPiANCj4gPiAgIEd1
ZW50ZXIsIEkgQ2NlZCBsaW51eEByb2Vjay11cy5uZXQgd2hlbiBzZW5kaW5nIFYxL1YyDQo+ID4g
ICBMZXQgbWUgQ2MgR3VlbnRlciBSb2VjayA8Z3JvZWNrN0BnbWFpbC5jb20+IGluIFYzLCBob3Bl
IHlvdSBub3QgbWluZA0KPiA+DQo+IFRoaXMgdGltZSBJIHJlY2VpdmVkIGl0IHR3aWNlIDstKS4N
Cj4gDQo+ID4gVjI6DQo+ID4gICBVc2UgU0NNSV9TRU5TX0NGR19JU19FTkFCTEVEICYgY2xlYXIg
QklUWzMxOjldIGJlZm9yZSB1cGRhdGUNCj4gPiBjb25maWcoVGhhbmtzIENyaXN0aWFuKQ0KPiA+
DQo+ID4gICBkcml2ZXJzL2h3bW9uL3NjbWktaHdtb24uYyB8IDM5DQo+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMzkgaW5zZXJ0
aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24vc2NtaS1od21vbi5j
IGIvZHJpdmVycy9od21vbi9zY21pLWh3bW9uLmMNCj4gPiBpbmRleCAzNjQxOTliMzMyYzAuLmFm
MjI2N2ZlYTVmMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2h3bW9uL3NjbWktaHdtb24uYw0K
PiA+ICsrKyBiL2RyaXZlcnMvaHdtb24vc2NtaS1od21vbi5jDQo+ID4gQEAgLTE1MSw3ICsxNTEs
NDYgQEAgc3RhdGljIGludCBzY21pX2h3bW9uX3RoZXJtYWxfZ2V0X3RlbXAoc3RydWN0DQo+IHRo
ZXJtYWxfem9uZV9kZXZpY2UgKnR6LA0KPiA+ICAgCXJldHVybiByZXQ7DQo+ID4gICB9DQo+ID4N
Cj4gPiArc3RhdGljIGludCBzY21pX2h3bW9uX3RoZXJtYWxfY2hhbmdlX21vZGUoc3RydWN0DQo+
IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6LA0KPiA+ICsJCQkJCSAgZW51bSB0aGVybWFsX2Rldmlj
ZV9tb2RlDQo+IG5ld19tb2RlKSB7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsJdTMyIGNvbmZpZzsN
Cj4gPiArCWVudW0gdGhlcm1hbF9kZXZpY2VfbW9kZSBjdXJfbW9kZSA9DQo+IFRIRVJNQUxfREVW
SUNFX0RJU0FCTEVEOw0KPiA+ICsJc3RydWN0IHNjbWlfdGhlcm1hbF9zZW5zb3IgKnRoX3NlbnNv
ciA9DQo+ID4gK3RoZXJtYWxfem9uZV9kZXZpY2VfcHJpdih0eik7DQo+ID4gKw0KPiA+ICsJcmV0
ID0gc2Vuc29yX29wcy0+Y29uZmlnX2dldCh0aF9zZW5zb3ItPnBoLCB0aF9zZW5zb3ItPmluZm8t
PmlkLA0KPiA+ICsJCQkJICAgICAmY29uZmlnKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0
dXJuIHJldDsNCj4gPiArDQo+ID4gKwlpZiAoU0NNSV9TRU5TX0NGR19JU19FTkFCTEVEKGNvbmZp
ZykpDQo+ID4gKwkJY3VyX21vZGUgPSBUSEVSTUFMX0RFVklDRV9FTkFCTEVEOw0KPiA+ICsNCj4g
PiArCWlmIChjdXJfbW9kZSA9PSBuZXdfbW9kZSkNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiArDQo+
ID4gKwkvKg0KPiA+ICsJICogUGVyIFNFTlNPUl9DT05GSUdfU0VUIHNlbnNvcl9jb25maWcgZGVz
Y3JpcHRpb246DQo+ID4gKwkgKiBCSVRbMzE6MTFdIHNob3VsZCBiZSBzZXQgdG8gMCBpZiB0aGUg
c2Vuc29yIHVwZGF0ZSBpbnRlcnZhbCBkb2VzDQo+ID4gKwkgKiBub3QgbmVlZCB0byBiZSB1cGRh
dGVkLCBzbyBjbGVhciB0aGVtLg0KPiA+ICsJICogQW5kIFNFTlNPUl9DT05GSUdfR0VUIGRvZXMg
bm90IHJldHVybiByb3VuZCB1cC9kb3duLCBzbyBhbHNvDQo+IGNsZWFyDQo+ID4gKwkgKiBCSVRb
MTA6OV0gcm91bmQgdXAvZG93bi4NCj4gDQo+IFdoYXQgZG9lcyAiY2xlYXIiIG1lYW4gPyBJcyBp
dCBnb2luZyB0byByb3VuZCB1cCA/IFJvdW5kIGRvd24gPyBBbmQgd2h5DQo+IHdvdWxkIGl0IGJl
IG5lY2Vzc2FyeSB0byBjbGVhciB0aG9zZSBiaXRzIGlmIFNFTlNPUl9DT05GSUdfR0VUIGRvZXMg
bm90DQo+IHJldHVybiB0aGUgY3VycmVudCBzZXR0aW5nIGluIHRoZSBmaXJzdCBwbGFjZSA/DQoN
ClRoaXMgaXMgdG8gZm9sbG93IENyaXN0aWFuJ3Mgc3VnZ2VzdGlvbiB0byBjbGVhciBbMzE6OV0s
IGJlY2F1c2Ugd2Ugb25seSBuZWVkDQp0byBzZXQgdGhlIHNlbnNvciB0byBlbmFibGVkIHN0YXRl
LCBubyBvdGhlciBhdHRyaWJ1dGVzLg0KTXkgdW5kZXJzdGFuZGluZyBpcyB3aXRoIEJJVFszMTox
MV0gc2V0IHRvIDAsIEJJVFsxMDo5XSB3aWxsIG5vdCB0YWtlIGVmZmVjdC4NCkNyaXN0aWFuIG1h
eSBoZWxwIGNvbW1lbnQgbW9yZSBzaW5jZSBoZSBzdWdnZXN0ZWQgdG8gY2xlYXIgdGhlbSBpbiBW
MS9WMg0KDQpZb3UgYXJlIHJpZ2h0LCBjdXJyZW50bHkgY29uZmlnX2dldCB3aWxsIHJldHVybiBb
MTA6Ml0gYXMgcmVzZXJ2ZWQsDQpzbyBjb25maWdfc2V0IGJpdFsxMDo5XSBubyBuZWVkIHRvdWNo
LiBCdXQgY29uZmlnX2dldCBiaXRbMTA6Ml0NCm1heSB1cGRhdGUgdG8gcmV0dXJuIHRoZSB2YWx1
ZSBpbiBmdXR1cmUgU0NNSSBzcGVjPw0KDQpDcmlzdGlhbiBvciBTdWRlZXAgbWF5IGhlbHAgY29t
bWVudCBoZXJlLg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBUaGFua3MsDQo+IEd1ZW50ZXIN
Cj4gDQo+ID4gKwkgKi8NCj4gPiArCWNvbmZpZyAmPSB+KFNDTUlfU0VOU19DRkdfVVBEQVRFX1NF
Q1NfTUFTSyB8DQo+ID4gKwkJICAgIFNDTUlfU0VOU19DRkdfVVBEQVRFX0VYUF9NQVNLIHwNCj4g
PiArCQkgICAgU0NNSV9TRU5TX0NGR19ST1VORF9NQVNLKTsNCj4gPiArCWlmIChuZXdfbW9kZSA9
PSBUSEVSTUFMX0RFVklDRV9FTkFCTEVEKQ0KPiA+ICsJCWNvbmZpZyB8PSBTQ01JX1NFTlNfQ0ZH
X1NFTlNPUl9FTkFCTEVEX01BU0s7DQo+ID4gKwllbHNlDQo+ID4gKwkJY29uZmlnICY9IH5TQ01J
X1NFTlNfQ0ZHX1NFTlNPUl9FTkFCTEVEX01BU0s7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHNlbnNv
cl9vcHMtPmNvbmZpZ19zZXQodGhfc2Vuc29yLT5waCwgdGhfc2Vuc29yLT5pbmZvLT5pZCwNCj4g
PiArCQkJCSAgICAgIGNvbmZpZyk7DQo+ID4gK30NCj4gPiArDQo+ID4gICBzdGF0aWMgY29uc3Qg
c3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2Vfb3BzIHNjbWlfaHdtb25fdGhlcm1hbF9vcHMgPQ0K
PiA+IHsNCj4gPiArCS5jaGFuZ2VfbW9kZSA9IHNjbWlfaHdtb25fdGhlcm1hbF9jaGFuZ2VfbW9k
ZSwNCj4gPiAgIAkuZ2V0X3RlbXAgPSBzY21pX2h3bW9uX3RoZXJtYWxfZ2V0X3RlbXAsDQo+ID4g
ICB9Ow0KPiA+DQoNCg==

