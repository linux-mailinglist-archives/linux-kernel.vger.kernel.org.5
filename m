Return-Path: <linux-kernel+bounces-46737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6AC84435D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78F3288476
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BB312AADA;
	Wed, 31 Jan 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e0FRHy+1"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD481292FA;
	Wed, 31 Jan 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716132; cv=fail; b=FWYIhGyHBezxc4Ue/ouc1ic0aLqinyhqdTg8Mq9rahXuvSUa8JfQfxDzs8q5P2A8lER94F/cCVzl1sdtePS9CgXsiAYoEqnIqSEGuakF6qGoXDRmRjPcHz9+cEzaN6OJhWeCGz8rzgAK9G1f1tKYctD8DbVqRcvzNYJ57xSVDVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716132; c=relaxed/simple;
	bh=kkz5vIN+fBQgAqzVWM2i5COZ3wyGFm08BNmCKpm7p5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q9uzpD3SvO7eyunaOJ7IlgZsTxgGrREnMGYQg4QEtlwQrMfhz7voix2Hxd5NIa2SeG2aP8lhIXWuB98gK5+6P78k6V0gvld7ubZE4MpeBxV7pyKF7YKPEOwSQhiB5fslnF2fdxCHDPM14+Ltbo8s6ky2SO5oOYWRAM05Hgggk+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e0FRHy+1; arc=fail smtp.client-ip=40.107.95.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=la/byDaFn8/hG3hZLqubf+MrnkzXPacw/AtOXmjlbEn4LV7gN18A90vPlDDG7qCB9oQ266mlm6yED+2KlvmmHELZcoyfOLl4a9NoCUN9P6U3ciM8qOY6U+xTY95U13yluAhZBJWJXCn2YuYIUVtwgN4aP2tTjOas3l7KVxKFRX3xf0nPzi652NdQihdqnl2Hn/sznd4ePY8aln9QPYMrT0jA2rPqkdOkkJrFF7f8yWltb2genZNzjvVcGXiqNys+4m5LUxLR6BvUooEqFUqh/6arTHgjOphqzvDZdg31VUU4juGg+KXFD3LA6KCTQEOK+5n8d+9f+crMZ4zl/oHswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkz5vIN+fBQgAqzVWM2i5COZ3wyGFm08BNmCKpm7p5w=;
 b=W+IKqb8Z28fTurZBKwk2N21a/DsCOI2kId3n0CZKUAnwFICyHN9W8OxR1gwOCaBy5zKKYZ5n5xX+XvXw2oxRMqtK9vcGvnRg1hExXyoeXAoujtZnRPHGCdaTbWbaKLpds2le/1k7vQw3IebRFU/S4huvNFJ+TnTFvjGOlImKX8IZMp5fVdk7RejInUUP1HKKCZ0aymSZVJ510Q1kZIDgqlMrWP85dTcdu4G5ENVRjHVd/FKtTrSswDmRog/hN79VXbft6h/uuZlbXBPTn+8quCfttMNL/iaf/vKy2Edfi2LQkec3Zb0NV4auRmNaXSQZCxAKlK4HsC5zMZzq7uuxHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkz5vIN+fBQgAqzVWM2i5COZ3wyGFm08BNmCKpm7p5w=;
 b=e0FRHy+1K7buLKEI9WpvvS/QOx/uH0qraEuOIw2xjaL8DsjhL35S5Gv2NOnggQ5t+WixmAbokOSpRvH6ujdsRL2C2LTOya1dB7gbepooT2jmQ3j6/yrEMhUFCW+QntBtjJH5r4yRzQ5rSAm9zwKpGsblodUqjNYC6rOkTorhPxjfVE+jTCXrLs7zZteeZEbSYs+jEo94mTm1RbL5FHYTbVJN+0xGbjLBcuGC3gMMkzChc4l61spjODxvbQOb4IykpVRd/B27TmdTSU/zgkqebHv1+HqY634SKv2LDxezorjEywWonHN9ciJIqANw/Q6A+edatpJyqqzk58asb6jBEA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.36; Wed, 31 Jan 2024 15:48:47 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4%5]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 15:48:47 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "sdf@google.com" <sdf@google.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
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
Subject: RE: [RFC PATCH net-next 9/9] ethtool: Add ability to flash
 transceiver modules' firmware
Thread-Topic: [RFC PATCH net-next 9/9] ethtool: Add ability to flash
 transceiver modules' firmware
Thread-Index: AQHaTQ+QQZNGrHyNcEuTxxeyuUrKM7DrCc6AgAb9nvA=
Date: Wed, 31 Jan 2024 15:48:47 +0000
Message-ID:
 <DM6PR12MB45161C82F43B67AD8EDB950BD87C2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-10-danieller@nvidia.com>
 <5bf6b526-02c4-4940-b8ec-bf858f9d4a58@lunn.ch>
In-Reply-To: <5bf6b526-02c4-4940-b8ec-bf858f9d4a58@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|DM8PR12MB5399:EE_
x-ms-office365-filtering-correlation-id: 78dadc55-774a-4db0-02b4-08dc22741d03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 d1x/NpgSWVOwabIXOGxrkyWh8mKhJfp0RoY68Gb8knkZamt/VmrrxL7ojXqwTJ/6UpzhQpPGdEapjB4YwusGPs5U5aGtuUFhiEALaxEBJwS/w8gGdSNb90ZAgWnwczmw9UFSS5kWD1FKRdJNnwWlmYO2uh7x0ap4a6fAxQvSRdGcDkiScxYiWf5bcUW4IjsisuTkz4X8I0jIr75T9MY/sFxWEdgrjpowwpZa+zoSTQn3IxJJOgf2s17G4HSh0rmcHQC4wT6n6v6pzFQVt8sZ4nKq+ErOIyxMFN/vvjf23JL1GIHqb9ZmeN4Tw1pwmGGVqSiEzeQ+o68M5Mr1eyClAtxdL/sOScOFODlB1Ax/OSltcmAJwAyWwFf9hSzBvg8RdyDwNT5ahKDCuINlJvsxQtXa4NJjT7yg/qruoWAzPRfqqnBm/HN2HVBoFWcY03/64hGjB/R7DsMH4ToT9ZJ4CBUorW5HQnPlqK+k1+1EYXnFLE/iU5xRLPEzQ2UtSEVXC2PGyXzTexPkhPMgzeLebgvf6c7j3bg9hTU6dYKJD9LLkFteOmSVrHbA/2RkCQheC5vYih68TN99qMflb+8V4/rdUJJo8lZTX7GfWjiCicUys+OyJ4fPOtjRN8aTXTnP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(316002)(66899024)(54906003)(66446008)(6916009)(64756008)(66476007)(8676002)(76116006)(66946007)(38070700009)(8936002)(66556008)(478600001)(4326008)(86362001)(7416002)(33656002)(5660300002)(2906002)(41300700001)(52536014)(83380400001)(55016003)(26005)(107886003)(122000001)(38100700002)(71200400001)(6506007)(7696005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vmo0RmlFdDZ1RWowcURIaEJDRTk4dFNCQTlQUGhiUTVTL2V6bW8rREh6elM5?=
 =?utf-8?B?S202ckZjMnkyYjJ4Y3JuZUlWODVUZDRWV05kVUFrOVMvY2lDdC9QRU1nYUx2?=
 =?utf-8?B?bHhuWG9QejVTMG9TNm11ZEVoTmVDRmswbDFzRFUxQXA5c0pRV0ZkaUxFNDI3?=
 =?utf-8?B?ZEk0cFpZUkY0QUJTUnh1cU9yUnFLQndZTnZjSnNBd04yYTZqbEZCN2JCMzBo?=
 =?utf-8?B?M3VuKzRxYjJDY3pPaTFRVTJldEs0TE5FOUx1Tkh1N2RXbENqYm9UM1dZVlNC?=
 =?utf-8?B?cVlwQXUxTVFBTkh1azR1cUc0NEVrSmpwUm5CS3JiVGpCUmFEK1ZQYXlZU0dN?=
 =?utf-8?B?QzRpVkU4YmwwOHYxeHpjakdNOS8zSWVvUkk2RmJkMkdGRnJpMUxodVo2WFFW?=
 =?utf-8?B?Q1gwVlIzbEU2ajdJNVpCbjVySHFteTdXcXR0d3FHTVVyTkFXYUFBUmhRazBy?=
 =?utf-8?B?YnZkb1VNSXNITEgyQU9GOU9sSE0rcjFDREhMbmdhdWtqNi9QN0dvQ0Roek1j?=
 =?utf-8?B?enFJSU5HenZDVVJTZS9aY2JkMzlnRzRMY2RXajd3M0g3QnRuaEZhMnhZK2Ux?=
 =?utf-8?B?SUVFSUVHeUN1VWZPNVBCcXRzRmlOYVZidFc0cG1MTkhxUVZCSlVObERGNXdw?=
 =?utf-8?B?T05tTGtuYXN0RXlVaGVESnlSbk54dmt0SmJNcmdJVUltL2JkeUgvdG5rTS9v?=
 =?utf-8?B?eCs3RlBqNk1qVWtGeUNyaDI3eTVlT2lPQ2loV2ZYUXZTb29SclJ3UElCRmJq?=
 =?utf-8?B?clBhMk1zV1JvdVlpcTlFZUZ0UzZ1V2ZCWms0WWI5c1BQSnpVSVZTR2Q3OEpL?=
 =?utf-8?B?dTMxcThqWCtOL1I1TG91NU96OU5SNUVaMzlXMHZ2UFVKQnRQODNrdG5HNjRC?=
 =?utf-8?B?Sy9PQUVXOEcyb0dGUGwvSGxEclB0ZmliNDMrZTJDdmNPWmdjQWRCUks3YS96?=
 =?utf-8?B?SmVvY29rMTUxRnkxeTluS0N4RzVka2NUUUxoc0tLZnBsMjh4citqME0yQVJj?=
 =?utf-8?B?ditmWFNWejh2REc0cVd5bzJ6Vmw5bmRKSWRhd3VGeG44OHdWZ1BmQ2QyR3Bo?=
 =?utf-8?B?bXQ0TlRiZkgzRlR4SGx6SG1PdURmM01tcFdZQnEydStPVE5TdW1SNC83SU5i?=
 =?utf-8?B?QnRGRGxmclRTb3lOd0hvT2pocXRtL0xTa3ZKa3FBNUNDOFp3M3NXMno3T3V5?=
 =?utf-8?B?RFRPZG41bVQ0bytJOTVmUmdlczg1bENYQ1dNeEJTcEg2SlYvRzhFRTRIQVNZ?=
 =?utf-8?B?M1RxQ0llR0NWai9kT0JPSkZhWmRVaGdMbFZoS2t0RUsyQnhDR1hVcW9mVjdm?=
 =?utf-8?B?WGRsY1E2bW9UbmFiTkUwb3A1WFlsOHNsaStTNDVWb2x3QUpTZElxMCtmTS9i?=
 =?utf-8?B?LzVybjlJZE1yOVdlRENJVy85TGR1eWtNakZSdmtwaHN5TXIrTTNxSjVIK3BZ?=
 =?utf-8?B?Z2Irc1ZzL2VGcHBEbEdCREw5RnFCODdJQzhZaklUdXFrdUlXS0FnYkVrTy9G?=
 =?utf-8?B?a3JRdllZY01TN01vRTl2QUxvQ25KcTkvejFWY0I2MDBxeGJOL2JWRkZWZ2l4?=
 =?utf-8?B?ME43Z05RN0ZPY2dHY0g1RElZRSsxSGpZNzh3MytYM2pobTRDcG1MdEdtSmRZ?=
 =?utf-8?B?V0hCVldYcnI3YnI4TFVnTC80M1dpUndhM3F0MkM2blkvU29qOG1YbW5UUkVm?=
 =?utf-8?B?bVU5N2lSeFZxci9wSWdLYmtPdlJCWEdiVXVRT1FpRnRpeU1GRFQ2MDhVellB?=
 =?utf-8?B?U056YmlSSE8vMkM3N2p4bm1TdHErbmxSSWttcUtHSDBCTlU4UjJJZngxWnNP?=
 =?utf-8?B?RW9ueWFlcCtMMklMMmNKYXJYZytUMkIrL3lDZTdlTnM4RGJnSDMyWFgvbmZp?=
 =?utf-8?B?N1p4Q0kzc0Z2eHJOWlozcnJCWmtKYlFxc1lnOFU4RG5uczQ5TStqbVZiOURx?=
 =?utf-8?B?b3Q5ckM2NDNKaXZkM24rSGRNV1FmRVVuQzNxRmhpaHJPeHRweDZVRWlCNUNW?=
 =?utf-8?B?K0ExSWxJYjRsRWdJUzR3ZVdkQ3FSa0RyZTI1bkFWbGtab2U1OVlTZUplWlcy?=
 =?utf-8?B?eXczNWdKREZoRnV0S1IvN2tRRmFqUjJjaUlWQW5qUjBBWFJ5UXBneXFrdXB0?=
 =?utf-8?Q?tFjI8ODJ8U9q9nrTRP3YBODU8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 78dadc55-774a-4db0-02b4-08dc22741d03
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 15:48:47.8030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgm0K7Zce2PRFMQFH975PioaHHIaT0tVEC1GrekOA5JeSGSk91Fu1iNcDsIzDyjTQ/FNSTkX2AMQ0xPRa4KGMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5399

PiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCBuZXQtbmV4dCA5LzldIGV0aHRvb2w6IEFkZCBhYmls
aXR5IHRvIGZsYXNoIHRyYW5zY2VpdmVyDQo+IG1vZHVsZXMnIGZpcm13YXJlDQo+IA0KPiA+ICtz
dGF0aWMgaW50DQo+ID4gK21vZHVsZV9mbGFzaF9md19zY2hlZHVsZShzdHJ1Y3QgbmV0X2Rldmlj
ZSAqZGV2LA0KPiA+ICsJCQkgc3RydWN0IGV0aHRvb2xfbW9kdWxlX2Z3X2ZsYXNoX3BhcmFtcyAq
cGFyYW1zLA0KPiA+ICsJCQkgc3RydWN0IG5ldGxpbmtfZXh0X2FjayAqZXh0YWNrKQ0KPiA+ICt7
DQo+ID4gKwljb25zdCBzdHJ1Y3QgZXRodG9vbF9vcHMgKm9wcyA9IGRldi0+ZXRodG9vbF9vcHM7
DQo+ID4gKwlzdHJ1Y3QgZXRodG9vbF9tb2R1bGVfZndfZmxhc2ggKm1vZHVsZV9mdzsNCj4gPiAr
CWludCBlcnI7DQo+ID4gKw0KPiA+ICsJaWYgKCFvcHMtPnNldF9tb2R1bGVfZWVwcm9tX2J5X3Bh
Z2UgfHwNCj4gPiArCSAgICAhb3BzLT5nZXRfbW9kdWxlX2VlcHJvbV9ieV9wYWdlKSB7DQo+ID4g
KwkJTkxfU0VUX0VSUl9NU0coZXh0YWNrLA0KPiA+ICsJCQkgICAgICAgIkZsYXNoaW5nIG1vZHVs
ZSBmaXJtd2FyZSBpcyBub3Qgc3VwcG9ydGVkIGJ5DQo+IHRoaXMgZGV2aWNlIik7DQo+ID4gKwkJ
cmV0dXJuIC1FT1BOT1RTVVBQOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWlmIChkZXYtPm1vZHVs
ZV9md19mbGFzaF9pbl9wcm9ncmVzcykgew0KPiA+ICsJCU5MX1NFVF9FUlJfTVNHKGV4dGFjaywg
Ik1vZHVsZSBmaXJtd2FyZSBmbGFzaGluZyBhbHJlYWR5DQo+IGluIHByb2dyZXNzIik7DQo+ID4g
KwkJcmV0dXJuIC1FQlVTWTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwltb2R1bGVfZncgPSBremFs
bG9jKHNpemVvZigqbW9kdWxlX2Z3KSwgR0ZQX0tFUk5FTCk7DQo+ID4gKwlpZiAoIW1vZHVsZV9m
dykNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKwltb2R1bGVfZnctPnBhcmFt
cyA9ICpwYXJhbXM7DQo+ID4gKwllcnIgPSByZXF1ZXN0X2Zpcm13YXJlKCZtb2R1bGVfZnctPmZ3
LCBtb2R1bGVfZnctDQo+ID5wYXJhbXMuZmlsZV9uYW1lLA0KPiA+ICsJCQkgICAgICAgJmRldi0+
ZGV2KTsNCj4gDQo+IEhvdyBiaWcgYXJlIHRoZXNlIGZpcm13YXJlIGJsb2JzPw0KPiANCj4gSWRl
YWxseSB3ZSB3YW50IHRvIGJlIGFibGUgdG8gdXNlIHRoZSBzYW1lIEFQSSB0byB1cGdyYWRlIHRo
aW5ncyBsaWtlIEdQT04NCj4gbW9kdWxlcywgd2hpY2ggb2Z0ZW4gcnVuIGFuIG9wZW53cnQgaW1h
Z2UsIGFuZCB0aGV5IGFyZSBwbHVnZ2VkIGludG8gYSBjYWJsZQ0KPiBtb2RlbSB3aGljaCBkb2Vz
IG5vdCBoYXZlIHRvbyBtdWNoIFJBTS4NCj4gDQo+IEdpdmVuIHRoYXQgdGhlIGludGVyZmFjZSB0
byB0aGUgRUVQUk9NIGlzIHVzaW5nIDEyOCBieXRlIDEvMiBwYWdlcywgd291bGQgaXQNCj4gYmUg
cG9zc2libGUgdG8gdXNlIHJlcXVlc3RfcGFydGlhbF9maXJtd2FyZV9pbnRvX2J1ZigpIHRvIHJl
YWQgaXQgb24gZGVtYW5kLA0KPiByYXRoZXIgdGhhbiBhbGwgYXQgb25jZT8NCj4gDQo+ICAgICAg
QW5kcmV3DQoNCk9LLCBJbGwgaGFuZGxlIHRoYXQgaW4gdGhlIGFjdHVhbCB2ZXJzaW9uLg0KVGhh
bmtzLg0K

