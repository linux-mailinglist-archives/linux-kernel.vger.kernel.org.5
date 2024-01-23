Return-Path: <linux-kernel+bounces-35389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1405D83903D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CA11F24929
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421465EE9E;
	Tue, 23 Jan 2024 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O3kcYL9J"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04605EE70;
	Tue, 23 Jan 2024 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016863; cv=fail; b=edGAcETE+YVERUC/Sk3VmCmTrZfHF3DFSMFLQzEnPBxqHctA+jeg/X8Pw7Eg83KDS+kUxc7H1XCaPFGqiU8dkjy2iuSBPcJD8pzWFS2X/XI022EiwI3/rzPY44RsjCNB5m/gf257/GSXecFtoRCpz1rvsbk8NSnDzns5AhBAFIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016863; c=relaxed/simple;
	bh=rUyk/e2AruiQAzonTXuHc+juYV0z9JluOsjYAEtuurU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WdfbDDMhC36s9Yta04da8FuGaM8an2LfCE/tgqVr4YJzCfmv/E+sPp0cwSCQS8j7ylFd+VhHls19oJLHbdOKbLN6s+9xtmXMOqZvlg7WaZV1TXIDj/Us5Ae5QHWr7Hnl+xc1d2ngLNwBKZXNszb+hy8zZ+/aHsE6c8mRl7muZ6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O3kcYL9J; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zuqo+ylz4vbgqiZ45pMlHCwpfjIfnv9jgG0r1XCjKCrbaUwgnpYLiIAfpCqM4g7cvQIrvl/QZxcUPRltWg+Y5jit14SY+ncqb0tYpW5NIDFjLRvFnpPESCOGwQyTP1a6dK5RIu1OClYctJqPdrqEl762sX61MlqYERSa/ZTHSkoca+Nln4BJ4rJWokYaN4cdqAE8TpD4II1dSY+K3lEaHFEdvR1XPs/FQqSWpAqMfYr/kSliIRmpSxePtkg3pFnwrFBZJZRoFP5b+5Q7S/9KiX42jkZT0sJVDjVjCgBoe6LNJN8ntjKv4VWGTO88yefBIjd/mcupinmzjC+YBQRi3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUyk/e2AruiQAzonTXuHc+juYV0z9JluOsjYAEtuurU=;
 b=EAgcaTpKK0h3QaD4VILs5qTJzy2UT6eBhQ3fURgGGa3BRW/dvcAuQdlfi4Nhxw5DxPOietLsaHM2Ot96E9C7dCAV4anVjnAViEQIGTMkeCbqni0GPizPJWijDkMFK2lOxx5SzX8fjgli6Wdrt4fdVYdhrrh2Rq8gOaOHkd/kWqvvPFi00fYIvEhGQhEXX0hwxbup4PYd8J9HCZp7VsSGTTqMkDeTk4RMoyu1EcZBUfZYRiDnMoDX0dTVzBfPPqP2MtlgKCHMdouyuykCKoodgb8hkbyG5YDW/YIquzJUB8Bi0SeSsH/lfT7MesqX/xvV7K/ZP3c3Nm3/jAm1AwhSiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUyk/e2AruiQAzonTXuHc+juYV0z9JluOsjYAEtuurU=;
 b=O3kcYL9JMhmPX5v1gOGgISyxsyllv16AEGdgnB7UC7M8iCjJ76lkel5vTN0atNEhOi5r+U+8r4K+Lb1N+dMjiCNCp39rzKj4PMVXPdWrGlBPJVwQI4SR4uKEwfgvPlnf3zvmSZnO6DeP3Xtu+9dq0r1GwHTKt68Q6LgAapqyWE92O6kjnxSGzWrE39p6bKzPkLdGD+YJVqtdsGWbzTc3jVawcWlP30eSIoz3+rWYDnbE00bUXyGyaSZYxUATDKS32mDX/IXYT8+ag3hhy2QOf8pPu5vfsnDNXH+4dCIMiGkJLpMNFOX0h33V3AgXPrt3VH7DC/OZNbVdXvtVV+jGOg==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 13:34:18 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4%5]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 13:34:18 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "sdf@google.com"
	<sdf@google.com>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, mlxsw
	<mlxsw@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: RE: [RFC PATCH net-next 3/9] ethtool: Add an interface for flashing
 transceiver modules' firmware
Thread-Topic: [RFC PATCH net-next 3/9] ethtool: Add an interface for flashing
 transceiver modules' firmware
Thread-Index: AQHaTQ93Zpqz9t+48kKaHw6SoBdbD7Dm1VUAgACQF7A=
Date: Tue, 23 Jan 2024 13:34:18 +0000
Message-ID:
 <DM6PR12MB4516C97E6EC715DB78466FD3D8742@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
	<20240122084530.32451-4-danieller@nvidia.com>
 <20240122205046.5bb0ffe7@kernel.org>
In-Reply-To: <20240122205046.5bb0ffe7@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|SJ2PR12MB8739:EE_
x-ms-office365-filtering-correlation-id: bad98842-9b02-4a0a-bc45-08dc1c17ffe4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kJrr7coeKj8xyPqkw6aqy90Zy38+tQC+EtoFz2eUvDDfalFwqvP08Jce2qeN7ojU/GYHraGzhFNhryN16+42Kj6MUKz5UWRtI2T1jB7vVTDq9wBNtWgDj74voGLyxh6PSoa9tTIVKoWRVMG3TRRP+5ExGdjlN6daF+eXcH8J7F9ORnByz+Xdb8SO4XO5zRXdihCnPGVBUSQO5eBjGvM8Ysq1YubnQtqJg5YNnWxMfDOQp4ZxrE7DQKC+ndu5vyxpHn1qHk+jvXmCt4PdAAJONR4cwzCnLYnv017XOeZPy5kTbBtWTA8JXe6+mdi4JJu5Q/T009dghavs81Wf2gOkXiQ72/WW/RS3fZrcsi9esapqbW6sE7sGZmitFZ2ILnCUfiR+Jwq8W/C0sSLP0LFbvFsowAN2bMepS66oxBiE6+57UD1QaqM0LR3oVkVVZSCaftUWtN8h8BXC9AbDHBqmC/GREvo4JCS7DrUGULWNrwu7qc4hqLL+jeFjhvxPEzvp/GioAUnTPm71x872cep0kNJrRjEdY804qBjhW0guIk/hbP6qSEPE9eJWEsfUpJBDzKOTEgM5gkLjEe5pO/YLJT3oHJ+cPUBXK6Ny14cx/yH6Bv2BYxUqLC9XKT9BVe/X
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38070700009)(7696005)(6506007)(122000001)(478600001)(55016003)(107886003)(9686003)(66946007)(71200400001)(8676002)(316002)(4326008)(52536014)(8936002)(38100700002)(76116006)(54906003)(6916009)(66556008)(66476007)(83380400001)(64756008)(66446008)(86362001)(26005)(41300700001)(33656002)(5660300002)(2906002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0VGby9peWorTjZoR1d4UW11L1FWVEtjYmJKaVVYSENxQUpXSHNmc3NhVmUv?=
 =?utf-8?B?TEdFaGVwL3lteCs0SFVoOFJWMkVaN09qbHN4UUdVTGFoSjB4SnhSd2t0RVkr?=
 =?utf-8?B?ZUQyRTd1OC80UzZrOEdDVG9YcE9QVE9la1hPbFR3QXl5MHRWR2hERVBvUXNl?=
 =?utf-8?B?SmpLeFFYaVZGYlpldkd2d3AzdVpMVm9xbTgrUnFJZGo3U2tTc2NGRUpBRHpv?=
 =?utf-8?B?eEU1YWg4T0hVdlhobkUvRjdDSFN6NE9BbHJBbnJuOTcyWHJjdUE0amQ2OW5M?=
 =?utf-8?B?VGw0SjJzT21HdGpralJ4WHN4ejhHVTA3Z3BhNXhIaWxLMWJMaGQzUVNhQkpL?=
 =?utf-8?B?MVVDVTg2SFlqdTAwY0ErNXJQNUQzVHp5UXFIcGFNTTI4NXlOVnBCdVViQXlt?=
 =?utf-8?B?VjZndnI5Q1E3NFZYbXdVVTJTVUc4TDVSWitBTU1FbWZEajhTYURXY0FNbEhv?=
 =?utf-8?B?QzJVSStGSHpKU3c1b3FZYTgyRGJVcEc4aU9YSVRuOVpHYnczNE9idXNvakx0?=
 =?utf-8?B?aDh5blVGb3A1YUdHZXoxRGdXbSsrdTJVeFlVbzdRVFVjZWlRR3JwMDBVczBr?=
 =?utf-8?B?b1M3K2t0VEErOU45SGxXRTRRblVVOVA0b1JtbjZtZHRLaEtXa2hsQXBwcGZH?=
 =?utf-8?B?L2JYOGhhVlc5WmV6eEpYdlIvRUptZDR3UWxtcHNMQUJSQlFUREFQaU96K0lT?=
 =?utf-8?B?VSsxK0I1SHdSaHNNRjRSNDFuakFDVCsvMERLMVZaQXhSTnNxYmV1Y0FPSUxh?=
 =?utf-8?B?T09kUUIxRU5jcWpYK2ppTTBXS3RTS24rSTM3SlhNdVViUXorQWdvQ2x0cHhj?=
 =?utf-8?B?VjhTUHFDMXJVcU5xZHYyazJWellobXBQZGh0OXlvQmhrb3JySmRyZE9GTHZu?=
 =?utf-8?B?Q3NMS1d4MWhBeGpzbkd3ekpBOEZXWTVvazNEYzZEYVZxaVRGTjBUY3ZvLyt1?=
 =?utf-8?B?TVp2UVR3WTlURVVHMS9EWDFoMzI3YXQ1RmdpMzN4K0k5cmUxUjBzMFFZMWx0?=
 =?utf-8?B?TkVZcURhVWh3aG5HbHFDT1kxRUxYc0dPVUNQdm9nTnJKaVFwNlJPSEQzUlJo?=
 =?utf-8?B?cjRKOGc5QmNRSTdhQTRSd0NDZVRmYUI4Y3BKZDdwK2huNllrZnBrWGEzZ1N5?=
 =?utf-8?B?WVdyOG1zeUZ1eG9QaFNYbWxZSk9DeGJUYXgvS0xpSEFyQ1k0NmZ5dzNUR0I3?=
 =?utf-8?B?dG5VZ25tbVZtVXRBQnhWVnhrZUNvS0Y2T215cUlJbEZnOGEyWHI3RFJyd1Ry?=
 =?utf-8?B?T3dhWE9tNnRpS1RFTHZBb2ltQis5enhlU3lnTWxSTTA0TWxYUHhIeFgrRGx1?=
 =?utf-8?B?c05vWVArUkl6dUNqL1RlZytFNTdoVTdpTi9ud0s3WkxFb090eitxcFhKdk52?=
 =?utf-8?B?VXNCSjFsK2FoUWVYUGpndy9odm5IT05peHJxTS9nWU5NK2p1d1NzZTM3RWF3?=
 =?utf-8?B?ak9ESEhCYzgvcDVJNEt5Yld5TWhZckRESjZqMForZDB2dXNYWFJSVTdJdnJ0?=
 =?utf-8?B?QUEvc3Y3aVdaT2ZSblB4OXBueDhXd3J2WW1nYlVCRXdPWXl3QS9ld2NISjBa?=
 =?utf-8?B?WFdVcTAvZXg5TzdvQmZSMVltQlFMOHRUWjlNRU41dnJRQ3hldnpEZEJGT2tm?=
 =?utf-8?B?SXcvTGRDWGY4NVhUakRmaTlBOHhOV3k2T0drdHpLWlVJOTZwOTJ2bmk2dXJV?=
 =?utf-8?B?OUdZRlpJWUkzSlZjNFg3blJJc3lQdzVnN2d6dXNJOUJYZXpYSjcxbE83aUlZ?=
 =?utf-8?B?bW5MYnNPOVV0c0JsalJaeEdrNlp2c1ZJdzZOM3M2d3c0NmxpR2FqOWE0Zlp3?=
 =?utf-8?B?Sk1WOEFnV0IxbnE3bm1EV25lOXYrV0pFRnIwZHNRaytFUUYyc1A3endUTVJn?=
 =?utf-8?B?aW8yZ2JuYmdja1pXV2p1Rno0QWRXLzdJcmNweGpNQVEybGdhYVhaYUxkZVFH?=
 =?utf-8?B?M3JSTTZ0QmswYkR1S3ZiNnhwbFg3Y0w4RjkwNW9TNHhlelVoTEtndGdXUTd5?=
 =?utf-8?B?RnRTTUYzd0R4bGVqb1p3bTZ6QXFSemw4TXkxQnY4QVFYSXo1dFRGTUlneGRx?=
 =?utf-8?B?aUxDNkJwYWR2MUlNZURCV3ozdFN1M2NKTXdnL2RIcDl1UHJBVUlvbFpxM29K?=
 =?utf-8?Q?30Dt3AY487pYaZO2WJP2UI0c6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad98842-9b02-4a0a-bc45-08dc1c17ffe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 13:34:18.2731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VxPF+oxO2CSRGXzUP4XydR/6rGQU0CK0MItE2p/a3ekt4k4+a9bVIiGpDdmref8NBZ4sh/xnZM7OZrJassqtFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8739

PiA+ICtUaGUgZmlybXdhcmUgdXBkYXRlIHByb2Nlc3MgY2FuIHRha2Ugc2V2ZXJhbCBtaW51dGVz
IHRvIGNvbXBsZXRlLg0KPiA+ICtUaGVyZWZvcmUsIGR1cmluZyB0aGUgdXBkYXRlIHByb2Nlc3Mg
bm90aWZpY2F0aW9ucyBhcmUgZW1pdHRlZCBmcm9tDQo+ID4gK3RoZSBrZXJuZWwgdG8gdXNlciBz
cGFjZSB1cGRhdGluZyBpdCBhYm91dCB0aGUgc3RhdHVzIGFuZCBwcm9ncmVzcy4NCj4gDQo+IFdl
IHNob3VsZCBzdGF0ZSBtb3JlIGV4cGxpY2l0bHkgdGhhdCB0aGUgb3AganVzdCBzdGFydHMgdGhl
IHByb2Nlc3MsIGFuZCBkb2VzDQo+IG5vdCBibG9jay4gTG9va3MgbGlrZSBjYWJsZSB0ZXN0IGFs
cmVhZHkgdXNlcyBfQUNUIGFzIGEgc3VmZml4LCBpcyBpdCBiYXNlZCBvbg0KPiBzb21lIHN0YW5k
YXJkPyBEb2Vzbid0IHNlZW0gYWxsIHRoYXQgaW50dWl0aXZlIHRvIG1lIChvciBhdCBsZWFzdCBs
ZXNzIGludHVpdGl2ZQ0KPiB0aGFuIGNhbGxpbmcgaXQgX1NUQVJULi4uKQ0KDQpGcm9tIERvY3Vt
ZW50YXRpb24vbmV0d29ya2luZy9ldGh0b29sLW5ldGxpbmsucnN0Og0KIg0KTGlzdCBvZiBtZXNz
YWdlIHR5cGVzDQo9PT09PT09PT09PT09PT09PT09PT0NCg0KQWxsIGNvbnN0YW50cyBpZGVudGlm
eWluZyBtZXNzYWdlIHR5cGVzIHVzZSBgYEVUSFRPT0xfQ01EX2BgIHByZWZpeCBhbmQgc3VmZml4
DQphY2NvcmRpbmcgdG8gbWVzc2FnZSBwdXJwb3NlOg0KDQo9PT09PT09PT09PT09PSAgICA9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KYGBfR0VUYGAgICAgICAgICAgdXNl
cnNwYWNlIHJlcXVlc3QgdG8gcmV0cmlldmUgZGF0YQ0KYGBfU0VUYGAgICAgICAgICAgdXNlcnNw
YWNlIHJlcXVlc3QgdG8gc2V0IGRhdGENCmBgX0FDVGBgICAgICAgICAgIHVzZXJzcGFjZSByZXF1
ZXN0IHRvIHBlcmZvcm0gYW4gYWN0aW9uDQpgYF9HRVRfUkVQTFlgYCAgICBrZXJuZWwgcmVwbHkg
dG8gYSBgYEdFVGBgIHJlcXVlc3QNCmBgX1NFVF9SRVBMWWBgICAgIGtlcm5lbCByZXBseSB0byBh
IGBgU0VUYGAgcmVxdWVzdA0KYGBfQUNUX1JFUExZYGAgICAga2VybmVsIHJlcGx5IHRvIGFuIGBg
QUNUYGAgcmVxdWVzdA0KYGBfTlRGYGAgICAgICAgICAga2VybmVsIG5vdGlmaWNhdGlvbg0KPT09
PT09PT09PT09PT0gICAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiIN
Cg0KU28sIGl0IGxvb2tzIHN1aXRhYmxlIHRvIG1lLg0K

