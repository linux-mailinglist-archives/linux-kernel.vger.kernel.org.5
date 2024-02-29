Return-Path: <linux-kernel+bounces-86220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D833386C1C7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA1728972F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFFD44C76;
	Thu, 29 Feb 2024 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VhehkOns"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376C22E415;
	Thu, 29 Feb 2024 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191128; cv=fail; b=k45s62ctbzM+nAU+WyB2rLggSRDUSObCYE0d1VJjYLH7FS5I7muCq9RDKZBwfGZgnYNzrGUyXd1DNzgS12/Bp3iNFLsPpQegb1jTHNTw7eVvhANR3aa7Zlu/deBVc0+vL/bDW0aBQNB+tV8g7lhYz7zmjeMlNJ1S/HLok+8QNkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191128; c=relaxed/simple;
	bh=DEPiiXQzd5LBvsRkjWFeeaDM+mIEv1TfILGKhwsbZCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GlpUKnw0atkCyQySvjsMcMc0tjfKWW5hrX0FyULo1aDX6Fd3tDprSResYvQ7iDksB3ek/vH7wb+7KDJ+kytbQvlLLnqjS+Q/ZDOHJvnEH+9R9tLtq6+sGtO5DYizH9nDJng0XdMI1ScPI25I8NwplkotYXXppKYUzVFFvPE6Gb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VhehkOns; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8OicX6vBzYuvL3TKleh/sApWcwAbyOMt9RJI9cNZ341Rz30ViQQ1PRYR0GJFpcowq90Ey5GGC1bx21sif1j2qqtoR3ickGfHl0IkUuLwct245fIZI+qncjNyXSlvzRU6BBZADNWpGW+egput5bXbb8okJzI5JWXjLeTN70KV/uGONwz+hUsXYImX0KpwfZcMh5eBRLBbXFDHm3vv+1yAraVLmsAwYDRrBI5J3P5ui2laPS8MOUlz53lIhATdFSqtONFnIAK44WDHvL0K+L7Jt/akBqn3EhNMRCBRvqfXyRA0KWa4szVzKM4ZBdfzKU90aM0qOzEYZ3XV1mmTshGUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEPiiXQzd5LBvsRkjWFeeaDM+mIEv1TfILGKhwsbZCs=;
 b=CpJToM+e224FbB+au/S4t57kVeEiP0VKiF8fY4Q+uU6LGInpeRPNWg0WzJuEHNXOw9M1ow7fRWihA7v3Mj9e+6c2nwUOGVCfr8HpIqgc9Ce24ww/xc5JUmPdLvDzLPwzCYVYie2wZw98cPGXpTQqBsxku7fKgAlhsIcYG7NkpbLl37TZI/7ILaDQollisT/n3lKeoaqfQs08QQ8bOmnPWXdi4S0r8u8JvHtWEu/HEILHqWbNlc/tYVi+m4EqV2E2FLnZO33CfBY7Be3Sb5g+OPZ9/YMd76PmIlGHFQvvM02kpzDVzqAah0r67MHE/At4JHlVXcp4KbF5PBFfM8Y0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEPiiXQzd5LBvsRkjWFeeaDM+mIEv1TfILGKhwsbZCs=;
 b=VhehkOnscseYCCAo+nh//5RQw+74YcsWdWES5NNMn5IxqjZJwwD+YZeK9ys9xYl9dnq+hyO5CLs2ew4xw+rbkJkpxvr7UjMDny07MaznxJsahWiW9CziAifEF4YcnWL4pvKfCO0zEXnCvncPthzLF7UcIL7JlVmMp0pYllAOYOC5OqJLoRwEwlSyoYMEJ1P33/cWnRTxWvs658F+oNqsQiyRTC33x1vwfeTsjt9WiyMhO4Xemsttt2s60KYUTS3mOxdIx7zSUnm5VY+N3AYpzhBSTQzMuMNcFGgtw9A8eY6sc6HlPJO9/CZRoODxgrB/PsImEBMwt3vrzzXCTcxYwg==
Received: from DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) by
 SN7PR12MB7881.namprd12.prod.outlook.com (2603:10b6:806:34a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.36; Thu, 29 Feb 2024 07:18:44 +0000
Received: from DM4PR12MB5988.namprd12.prod.outlook.com
 ([fe80::13c6:5879:b16d:858f]) by DM4PR12MB5988.namprd12.prod.outlook.com
 ([fe80::13c6:5879:b16d:858f%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 07:18:44 +0000
From: HaoTien Hsu <haotienh@nvidia.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, Sing-Han Chen <singhanc@nvidia.com>,
	Utkarsh Patel <utkarsh.h.patel@intel.com>, Jon Hunter <jonathanh@nvidia.com>,
	Wayne Chang <waynec@nvidia.com>, WK Tsai <wtsai@nvidia.com>
Subject: Re: [PATCH CFT] usb: ucsi_ccg: Fix command completion handling
Thread-Topic: [PATCH CFT] usb: ucsi_ccg: Fix command completion handling
Thread-Index: AQHaX/c/eIMwVv+p1k68YK3oJUul8LELPlsAgAAPkYCAFbEygA==
Date: Thu, 29 Feb 2024 07:18:44 +0000
Message-ID: <4c61b43c-1dd0-4f8a-b65f-48752b1cc439@nvidia.com>
References: <20240215101024.764444-1-lk@c--e.de>
 <2024021504-oven-worst-5c15@gregkh> <Zc39d88ikvCO+XVK@cae.in-ulm.de>
In-Reply-To: <Zc39d88ikvCO+XVK@cae.in-ulm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5988:EE_|SN7PR12MB7881:EE_
x-ms-office365-filtering-correlation-id: bfde5eb6-bcfc-408d-9ae3-08dc38f6a9d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4uhXbvXIWX/3WsjridJ1Vo0fHYOR3PfC8zUFqA/iWBr18yt5cKy3D7SjCKb/O/SuUa0rNae/nBdtRPflt+ZrewyjtPsTvEkWTDVlK8xw270e90KphIP0gBt2E/QLFqsxel51y5nMXAjhGLfivhmF4LzxGWa6eqmUayygoVtmtLW1bQ+YQoytDUn+0wG1fNVgnzC9bDkQW37ZKhE1K351I9GxFrjpK+SntK9I/OrPlUMzOhC1lDLa41c9H16Yh6nKkspoGNzERCVJ6AjpRXCY88+gznVHXZdKEHiy7amWGP6cmbI4mCoOooGA6f9S0EoD4xG4aHGu3yZ0NfYgs8YFqPyqqSu6G9YWCTG2WZP7YRV1SqWhxwSJPxvOcTCHJ4yIBGKxPTW48YyBihFiFiOkDBEzq74bEPcv7bhPeZzrA8KJqEeaL0B6ahcnBV9+wa5p/dNr02a2uzZGi0kxxQt54xN0Z3KvuQ+SOxy62+ujPyGMgRCtbFIZjhWrXAlouIQjgQBYWE3L0iKLrLxV/Rsxwd1IZPPQfji3TM3TujCLTgjr4p5FSQQH8YACZ+wZ+MqSZRh3T5O6dkN4fEf678ofXR8jqy4mAYCECJ2F+61NES6i2KkAo/9aUlYoscyJyrdpj34mQ8V8Zl9u2DbRQO4Y7B52kjIz/x0+NzG4pbP5EmqzVjba8Vj6ZzptdxhYTet0Wwlagepo+51MLRGifTfSC5OXeYEhHBgPczHE3WWKFEA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5988.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WCthT2Vrd2xGWG4ramNNQjAxM2hPdTR5MzNGa3o0NEFES0FZQ2YyUjZIVmNC?=
 =?utf-8?B?Y2cwenF0TmRsU1Y3dGpBZ3ZGdzFSQkJzeGFSSUFkYWtvMzVuT1gzQ0JWcVVG?=
 =?utf-8?B?cy9ieVhSOHc5eEVHNU52RkNkTFhJR253K0pYMTlxWjQvWElUUzRFRmFtenJN?=
 =?utf-8?B?K1JRVHd6aVlSS2xYY0lvL1plZUI4T3JidTk5VWs0VEowQ2JPVmp5Z3pvVVhx?=
 =?utf-8?B?bnRKL0JRcDhMZDlMMGtWRDU2ejJjWlZNV04rSkRxN1U3TkE3SjNVRHRMVGJL?=
 =?utf-8?B?eWFHWjUvZFhPWWhOTjhseFFDUHN2QjFiSGdZWEl6UEtreUxZMVZmRjg1SFFV?=
 =?utf-8?B?ZGExajV0cWZyTjNPMHBPMUExbFZuT2Rvb0VncTRoOGVmNEtTc1dxYWNVVTYr?=
 =?utf-8?B?eXppM3EvMWRGMWhGM3VZNzJ3Q1FkUmFjTDlRRG95eWprcGJLOS9VOC9LcE1O?=
 =?utf-8?B?STRaRXI5V1FTdWtQMm5VeEFWN2IxSkV4UENFcU1mdVpsMzJiMSswR3NOSldR?=
 =?utf-8?B?bEZFQkM5ZExCenoyK2F4cTdCK05wOFBUUGNKcWtZWlQ2eWhSUzVmWGs5SGNT?=
 =?utf-8?B?am9KaWtPdm00a2V6a0RXbXNUUWJGOFZuNFc0OE1UbXZNWHJUOG0xU2tjM1Q0?=
 =?utf-8?B?MERmUldXUVNIR043U2w1M1ljdXRMRUZWaGxpODhlc0plSUtEV1JKWTNXNExp?=
 =?utf-8?B?YVZKNjhodlBKUmhRQUQ2NlJmZjk4V0liY0NpYVlHL0ExdTFjWjR1VllrQjRy?=
 =?utf-8?B?cURPNUkvK01oMys4SW9GU3doS1M4b1Z1N24wTUUxRnRxZ3RNbllVRkpGMFFH?=
 =?utf-8?B?LzV0bkFJYkNHZTdFN0F3YkZrZ29LVjhHQmJQT1hQZnZnZGVPbVBEdC9jaDRG?=
 =?utf-8?B?NTNtWm1NYXl5ZlVZRFRIc08vaUpEL0hhUnp0S09rclZHYzEvV21qUWNtb3Rk?=
 =?utf-8?B?TDF0VzVUM0ZtenhPRDFEYzA2cnFDNXhUTU44ZHNqcjNKT01JVTkvYkxkT2xP?=
 =?utf-8?B?REFGclRYWkVhUENMTTJuQ2hrc3l0SXMwNlliTVMzck5FRkxpRzRMT2V3Q1NM?=
 =?utf-8?B?czd0LzNjOTJaOG40TXh1c21YYy95bEF6V1NieDk2ZEF6RWJWVWZYLzJEVG9s?=
 =?utf-8?B?OWltWkEyKzVDQ2k2WkZZcG9tQ2tYdklPUmhpa0hydTRPZTBjd2tvNEZHSmNp?=
 =?utf-8?B?NXZtRGs0UXBKMDQ0enlXNkczdmduLzdMYmh2bkZDZXhqZnc0UnhmYmJyeWlI?=
 =?utf-8?B?TUJzZGNWZWIzQjRrLzFKN0ZqVkJZMThpdU1zc0tDemlWcy92Wmlrclo4NHRE?=
 =?utf-8?B?aEZyb1RENzJaK3k4WGdZTGVaSWdUZ3Jpa0R1TmdhWHBOR2g1NW8vcmZTWVFh?=
 =?utf-8?B?MFZnVTZ3aVpmUjNjQjBDdWtHQVhiaHdrZHcxbWJkMmF0SmREdXFDSms4L3dN?=
 =?utf-8?B?c2lhbUtERmt6MGZWK3VBQ2hSUzlpQVN3SnpoRkQ2NzRYcTgzTXU1SUFCbHdH?=
 =?utf-8?B?ckY3bFdIVlB0M3puZ29QYndNQjVtOE1pMzd3ejhFdzZEZE90SENDWmlJQTZi?=
 =?utf-8?B?MHZwMzNtZk5mOXozMDNKQW5aUnNjWVZnOTJtREppaWVjUHowYXY3aEpLSW5u?=
 =?utf-8?B?OUhXbkluNW00Q3hXR29NZnMrdVRHTkZuenJRY0hDbEkrU2EzamhLZWRYT3kr?=
 =?utf-8?B?eVhYQkhYQWphUjY2Vk5YOU5HcWJJRUF1akFSQUNGYXF5WnZCcUltNTE4MXpI?=
 =?utf-8?B?bHp0ZEI2RStwVHIwS3JHVVBtSXZ4RW01MUNlTlpTcU8wazNIaktUNU9QbUZE?=
 =?utf-8?B?RXFWak4wbjVvQVV1V21aOWcxYjB2ZFJkd2RSNGR4dWJuUWphODQ2eEhPNjBz?=
 =?utf-8?B?OEFhSHp5MlI2WnVrRHp6WXhxMmFjdHZCZHlScE1pdjNST2JSOU1IcmpGZFVB?=
 =?utf-8?B?RGhwdUQ5UnZNY2pwTDdwTG1SRU5hWG5oU1I3ZjFIRmpid1dnWEVZeWo4Qmh1?=
 =?utf-8?B?aU1kVDlDWHROUGxEMkdhVWxJSDFUeHJySDFZSnN5bUZFRmdoSmNNeVgxMjV4?=
 =?utf-8?B?Wm1pY0NwV3A5eFpvUk1uUXA3Z1QrNTVjRHZhMVQvRVRIUEd3c1lHaU1nbTJt?=
 =?utf-8?Q?tjdArNBimE1iqVqOy0V2csSp5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAE37531430C994DB278A55362D81268@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfde5eb6-bcfc-408d-9ae3-08dc38f6a9d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 07:18:44.2160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XSJLsqPHPPZlP8oFBviRpcFFQwiVTPY6QIPX51AXC4fUEq3afGr70YszLPNfl1qaB+iS8soB/Xi7RJKj3y2E7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7881

T24gMi8xNS8yNCAyMDowMywgQ2hyaXN0aWFuIEEuIEVocmhhcmR0IHdyb3RlOg0KPiBFeHRlcm5h
bCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4g
DQo+IEhpIEdyZWcsDQo+IA0KPiBPbiBUaHUsIEZlYiAxNSwgMjAyNCBhdCAxMjowNzoyMFBNICsw
MTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6DQo+PiBPbiBUaHUsIEZlYiAxNSwgMjAyNCBh
dCAxMToxMDoyNEFNICswMTAwLCBDaHJpc3RpYW4gQS4gRWhyaGFyZHQgd3JvdGU6DQo+Pj4gSW4g
Y2FzZSBvZiBhIHNwdXJpb3VzIG9yIG90aGVyd2lzZSBkZWxheWVkIGludGVycnVwdA0KPj4+IGl0
IGlzIHBvc3NpYmxlIHRoYXQgQ0NJIHN0aWxsIHJlcG9ydHMgdGhlIHByZXZpb3VzIGNvbXBsZXRp
b24uDQo+Pj4gRm9yIHRoaXMgcmVhc29uIHRoZSBVQ1NJIHNwZWMgcHJvdmlkZXMgZGlmZmVyZW50
IGNvbXBsZXRpb24NCj4+PiBiaXRzIGZvciBub3JtYWwgY29tbWFuZHMgYW5kIGZvciBVQ1NJX0FD
S19DQ19DSS4NCj4+Pg0KPj4+IE9ubHkgY29tcGxldGUgYSBzeW5jIGNvbW1hbmQgaWYgdGhlIGNv
cnJlY3QgY29tcGxldGlvbiBiaXQNCj4+PiBpcyBzZXQuDQo+Pj4NCj4+PiBUaGlzIHNob3VsZCBh
dm9pZCB0aGUgbmVlZCB0byBjbGVhciBvdXQgQ0NJIGJlZm9yZSBzdGFydGluZw0KPj4+IGEgY29t
bWFuZC4gVGh1cyByZW1vdmUgdGhpcyBjb2RlLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogQ2hy
aXN0aWFuIEEuIEVocmhhcmR0IDxsa0BjLS1lLmRlPg0KPj4+IEZpeGVzOiBlMzJmZDk4OWFjMWMg
KCJ1c2I6IHR5cGVjOiB1Y3NpOiBjY2c6IE1vdmUgdG8gdGhlIG5ldyBBUEkiKQ0KPj4NCj4+IFdo
YXQgZG9lcyAiQ0ZUIiBpbiB5b3VyIHN1YmplY3QgbGluZSBtZWFuPw0KPiANCj4gSXQncyBzdXBw
b3NlZCB0byBtZWFuICJDYWxsIEZvciBUZXN0ZXJzIi4gTW9yZSBpbmZvIGluIHRoZQ0KPiAiQWRk
aXRpb25hbCBJbmZvcm1hdGlvbiIgc2VjdGlvbiBvZiB0aGUgb3JpZ2luYWwgbWFpbC4NCj4gDQo+
IEkgdGhpbmsgdGhlIGNoYW5nZSBpcyBuZWNlc3NhcnkgYW5kIGdvb2QgYnV0IEkgZG8gbm90IGhh
dmUgdGhlIEhXDQo+IHRvIHRlc3QgaXQuDQo+IA0KPiBJIGRpZCB0ZXN0IGEgc2ltaWxhciBjaGFu
Z2UgZm9yIHVjc2lfYWNwaS5jIHRoYXQgZ290IG1lcmdlZCBhbmQgdGhpcw0KPiBpcyB0aGUgcGlu
ZyBmb3IgdWNzaV9jY2cuYyBwZW9wbGUgdGhhdCB0aGV5IHByb2JhYmx5IG5lZWQgdGhpcywgdG9v
Lg0KPiANCj4gICAgIHJlZ2FyZHMgICBDaHJpc3RpYW4NCj4gDQo+IA0KDQpIaSBDaHJpc3RpYW4s
DQoNCklmIHdlIGRvbid0IGNsZWFuIHRoZSBDQ0kgY2FjaGUgaW4gdWNzaV9jY2dfYXN5bmNfd3Jp
dGUoKSwgdGhlcmUgbWlnaHQgDQpiZSBhIHBvdGVudGlhbCBwcm9ibGVtIHdoZW4gdGhlIGRyaXZl
ciBpcyBwb2xsaW5nIHRoZSByZXN1bHRzLg0KDQpJbiB1Y3NpX2luaXQoKSwgd2UgbWF5IGdldCBF
UFJPQkVfREVGRVIgZnJvbSB1Y3NpX3JlZ2lzdGVyX3BvcnQoKS4NClRoZW4gaXQgZG9lcyB1Y3Np
X3Jlc2V0X3BwbSgpIGJlZm9yZSByZXR1cm5pbmcgdGhlIGVycm9yIGNvZGUsIGFuZCB3ZSANCndp
bGwgZ2V0ICBVQ1NJX0NDSV9SRVNFVF9DT01QTEVURSBhbmQgc3RvcmUgaXQgaW4gdGhlIENDSSBj
YWNoZS4NCklmIHdlIGRvbid0IGNsZWFuIHRoZSBjYWNoZSwgd2hlbiB0aGUgVUNTSSBkcml2ZXIg
Y2FsbHMgdWNzaV9pbml0KCkgDQphZ2FpbiwgdGhlbiBpbiB1Y3NpX3Jlc2V0X3BwbSgpLCBpdCB3
aWxsIGdldCBVQ1NJX0NDSV9SRVNFVF9DT01QTEVURSANCmZyb20gdGhlIENDSSBjYWNoZSBpbnN0
YW50bHkuDQpUaGVuIHRoZSBkcml2ZXIgd2lsbCBydW4gdGhlIG5leHQgVUNTSSBjb21tYW5kcyB3
aGVuIHRoZSBIVyBpcyBub3QgDQpjb21wbGV0ZWx5IHJlc2V0Lg0KDQpSZWdhcmRzLA0KSGFvdGll
bg0K

