Return-Path: <linux-kernel+bounces-37053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F21583AAB3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 571D5B26441
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5B977F10;
	Wed, 24 Jan 2024 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qO7NLGmF"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A56C77640;
	Wed, 24 Jan 2024 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101887; cv=fail; b=CY6SWwPQmTfCbH5TJfnuRXiNYzijY20Kv1EcHzf7RP2CZNJGqDVMhGMmzxWuQu5n2E37ZRJ6fuGkqTPAS5Au3CwMbG3XBbEParw0VU9C7baERLfwhE5BfI8am00KT1JSJmK1A830tD1kDvfrlTav07ETX/kSYiwhyVrcCW1jnF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101887; c=relaxed/simple;
	bh=mMaA5dZRiBZo8Ex39NVOgeGVb6462oyqahj+fElfNAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cjPDGsYJ7CFcD9PNnie1JFKeHRs1NGXbbIjDOxtFTQugW1gUqf40vY1mt9+2e3ckG3Jdqzx4XvdPvWAOGT8g5reT6gB6ZSEIvyvxHd1oRSJX+iLaepiAM+ueeNYm55lmGC5P5AeG2lw9cyZ8vA6jwT3DcrXlkDkW8nWl6i+fvpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qO7NLGmF; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feGzVG/rQj7hzrhyvLFIsWHisZvC+zjSwU3ORA5HugRdHp8APuFHnbNWxI07WHgtFMTKoSo1qk0CogJ4QKbGvi7fTeHoDdOPeO10E6ZLxHnbfkXGWabXOmSa/88sJJ1C06RIRJHoxvgj6IzLaErVPm+Udo13vvpyvKmuPNC6YnOIk5WkeQQIM8YevL/VNeIFZGlt2+3z93C09wjB85IogCMqKHdeewZcisSSc2xMnmJwhTeFE/tmWgA38LNHb6MEZiue5l+6PWa5irKhhNDT6+rw30qfHqM7JQvAOMHFYLdPwgvfJu/xYFdGSGL64AgmKnBgDyfygmRhEaOq4e4T4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMaA5dZRiBZo8Ex39NVOgeGVb6462oyqahj+fElfNAI=;
 b=Nrtoeyv49yirmbw/uoF2S+SBdVbksRMQqkqP7URnF55+CPzankkDjxuoD3rLAi+UnmmrcAnF8Cs2VRPQXrSN4j0IdaMiStv8ocsWuPFzlAMvjbSoOJd9Yr6JNzOgEuhyNwBsdyGJ4or8x7IAysgBTlMiQECggodm35QgMfjVedUhcdr4PiUmixtyVv1sbyQlKYD4WWHNozQHaFqkeoZDYfOr3RGdrcs2QljR0ggIstsoPFmC0mu6JFAbGstJn1vb3IBbSMiVTOwJw7sPBpdajZ/8DnCY0UYVPIyOWui+4SmlaUg25+SQ8Luod2YHS/drlM++xjzzvuySoUIonbAZ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMaA5dZRiBZo8Ex39NVOgeGVb6462oyqahj+fElfNAI=;
 b=qO7NLGmFy0xLfmOM5TpULQtzzKTK5lMmjFkuDQAGcv3oDK/GsHPNlO8VYazMweYzsKrvFCNXJK0GpC2l5i729F1IUhQPTDWjljn1K4J1UEIv/kxJYaIvnJ5kyirMAvSJggDADaYv4reXxxWHdHgYI2OlKfKFGc14GU/vaIjUxNIJYUSK9mr8xWOUTbtQrHpGnO+QVqZuIw9wo0emGtzksZkFfgCzzxAhdN6xfrNuvZugCyArdgBN6fqZwSziQ+rIlBMbYVd4QAELk5vuULVBGwCYMXGt3FV36ovHOIuueE956GR9LMUOVNl+u6wwn6DsPTYkzXtVGa5QhkonM0/LXA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 13:11:22 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 13:11:22 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Russell King <linux@armlinux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "sdf@google.com" <sdf@google.com>,
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
Thread-Index: AQHaTQ+QQZNGrHyNcEuTxxeyuUrKM7DnmBUAgAFbTeA=
Date: Wed, 24 Jan 2024 13:11:22 +0000
Message-ID:
 <DM6PR12MB451661BE50E8FECF6393ACDDD87B2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-10-danieller@nvidia.com>
 <Za/pBGBB3H+VEbX8@shell.armlinux.org.uk>
In-Reply-To: <Za/pBGBB3H+VEbX8@shell.armlinux.org.uk>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|MN0PR12MB6223:EE_
x-ms-office365-filtering-correlation-id: 27c4d668-c5ff-4309-00c1-08dc1cddf659
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WtHFgctr4Im7HcOTOld7+B03rj2MwudCdsFuBDo/PkM7fxXQ6vJWU7d6jRDtIz8uBicjcT1ljBEydHLi1H9J74wSXVjxraIBRZtVEvXW1rvGrqHT7+uwAkcN0lvkkxLUFV4XeLcQ5RKXgC4qRvbX8S/tEpYq6p209HZ+2WfrLNi0zZvvvLN/5ztvvGtFNIV07hBkZNtgHO2MbxytO75ok9Aoh5N8STAjYnCrG4esEXjr5RPiEsrJqWGFiqEEyzwgBPkndbHZbnqH5ZSG3q6Gjad05STEg9e6LF9mmXhF2YD7mDw36Q7NgyOk9qGKDa7QJlx9kLrYVl5MjrpqmXB0mWld1PfnCCjb5tLg2NeIgCF+99zGek+EvfapiSydR5WMc8N7q26E7gr9Zf6N8DoGLhQG9V4XtYAf6PXQh9hqk9DcMqSAHoTDIl0oqHd+EQr9BCBh0ewirwttMZNcraEXJZa2GZsfnhF2uiaP+Bub/pmXpsAOT5rUMYOphagB71Nsr6mJmZF8wWk5c7+97VafWdyZ71seC7lrWhuzGjfmoSG5P4v6X5kEXD6N0Q+Qc7GuGetOtuhQf52DQ66j8O0d9mWRfOwKO3uMkwg4lt+H4xmWr14pRpNsh0XNkQZUkOy2CxbpAiHCeVDYt5OfyGfap3K6+ktcV6MlC7toh2PCXTY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6916009)(52536014)(8676002)(4326008)(8936002)(33656002)(7416002)(2906002)(5660300002)(966005)(316002)(86362001)(54906003)(66946007)(76116006)(66556008)(66476007)(66446008)(64756008)(38070700009)(38100700002)(122000001)(7696005)(9686003)(6506007)(478600001)(71200400001)(26005)(107886003)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFI1K2RiUkloSDlEajNlZFNoWnUvQWlGRjRpTGxPMmdWZVdKSGdNRzEwQ1NS?=
 =?utf-8?B?S2VwaXlyYlZpU1AveGJ3RGIvTWRaQ0pYN0tvallrOGxwYlEvcW92TkQxdHFX?=
 =?utf-8?B?bXNndTBDL1RkNHZWWlF5YXR4ZTB1dDdrU2Q5VndLcld1UXdzdGdoZ2UzcDQy?=
 =?utf-8?B?M3JJcWtpVkk1WFkyK0kxQnNBejRMZW1XMjZ2Mnd0MFVBNU1Fd2NHaDFRN09w?=
 =?utf-8?B?ZGFnVlVUUkNnb0JYektqWFJ2YTczbStFWGZqWFBoaUpBRmRsallaN1dFc2NW?=
 =?utf-8?B?WEwwckFRaFFUNXdyU2JJTFBjSFU4WUZaaTBFMnZVY05TRnFwUWFsM0M4Y2xS?=
 =?utf-8?B?ZXVCQ3dsZklPRnVzQUFWRk1EY0tJYWNscXlPRGFmdm02ajBkRHVYbXFJOWs3?=
 =?utf-8?B?a054NE1LSE9kMDQyTGNndVNvd1IwY1l1OU5GOU1Eb0tSWWpTdjkrMDhBREsy?=
 =?utf-8?B?MzB6N2pVSmk3TU5XNVdCZTNHWXBlVjZvSWdkKy9BaDRPZ1RubUYya3UrMzhD?=
 =?utf-8?B?Sk4vbU1BTXkyM0hIQXhidDBLcnFKeWt5VVIwRDh2OGduRVNoaDhwdjRhdnA5?=
 =?utf-8?B?enpXNjEwYW1SQW9jbmNkUjY4YmUrK1B3ZnNsdjJLeDFFczlqRzNvTmhwenRB?=
 =?utf-8?B?N25CV0tRT0d3M2x6T2pmcVVSS25UU3o0VDVmQW5xdFZoak1lRDIrOFhpbWls?=
 =?utf-8?B?UWU2UVBCWlRHZXFjNGtmOHh2YzRWaTR6Q1dtWk1vai9pUFNnbHpoeUhjWDlS?=
 =?utf-8?B?TkJIcTRKK2lmWnVOcHlST05sYkM2SGVLc3M3TElhVDNpMm5KYnVRYTlYZ2lt?=
 =?utf-8?B?ZTBkTXpLM3ZrbFNIQTlmZTI2ek5jeEg4ZzhjZHpXTS9TMXRzZXN6OWVqZncw?=
 =?utf-8?B?MDZPWEZkd3NMVGl5c1QreER0ZWt1Q2hjSVN4czI4Rkt2enROQ0ZrTzNiUDRa?=
 =?utf-8?B?SEYvWHlzbVFENmRxZU1JWkJLK2J1TVc5aDQ2azdHd1hLZFhGQTdqMWFRTjhB?=
 =?utf-8?B?bjZJd3Q3Wm9ZbWYzT2hXbWlxR2ZiVGs0a3JFMnlLMldMNjdnV0NYSXRWbVpQ?=
 =?utf-8?B?bDFxQmpjV0xsZkVqbDlMZkRDVEJ0L1RYQUJKbDNEbVo3bm5VNm9uZjV6TGtS?=
 =?utf-8?B?TmdIM3d0dFVGNnBGVDlTS1R4OHVUTnBpWGUwUEJNSWgwbVBUblpFQ2QvUWdW?=
 =?utf-8?B?WXJwVExnOTllY3ZUN3owTmVwYnNEc0ZiVTdlYnJkbjVaaHFscjhzMTJEdGNF?=
 =?utf-8?B?dHoxQlBBZzZrQ2tKS1RNSDVtY0E5eVg2RFVxaHBGemRKSnJ2TWpWUER5NHVj?=
 =?utf-8?B?b0IvUTdZTDkrSG1XYTRaM3E4akNxa2ZkMmdoQ1pOemlMZ2djdEY4a2ZqVERZ?=
 =?utf-8?B?ckxabkpXbVMyV2E1cjV3QWtKdTluelZjcUJWamlodEwwWGZsM21mZVByeWRQ?=
 =?utf-8?B?RXZOamx5UkRMRk1aSERNeThvcVFXODQ2WUFFMEVvajl2dzZQMEhOYy8zc0F3?=
 =?utf-8?B?RW5PWFdVMklVekFaREFmcVFpbG1WMkw2WGFFVjQ0R0YyZmM0a25wTDBETFk4?=
 =?utf-8?B?NE1TQThQU3Q5SEVvWGRDQXRjamVhdkZOYndZK05TSGNISFh6YVBOekNlNnlG?=
 =?utf-8?B?YUhTRXpDRnRnT1JNcDhXNy81c3hZQUc1VFk3L2N1VXJyV0J3VTdQbzhvaFVK?=
 =?utf-8?B?Rm4wUFJqNS9wNnMvRzdTUERlK1ZwTndjeExwWUhYSmQ3ZnNEZEVwSGhHRTc1?=
 =?utf-8?B?eGRHSmk0Y0twakFmN0l1VVlnWGZPdzhUMlNnVTZTOWJycVVPMUNBblhrVUxS?=
 =?utf-8?B?SFNzdW1JUDh3NWcreklUNGdJTlZjS3V4MlNYbkxtUTNPcUczclAxaktWcG53?=
 =?utf-8?B?cFJGR2RTZUZVS0JnbzhHeENreFpsTmNXZXRYQVh4dktVa2xhWlVqRm8vTDE5?=
 =?utf-8?B?ZXRsb3RTUzVsbWwvMndtNVFBMCtUeHQ3NXozamU5WkVyaXM4L1pwVXFRcUtz?=
 =?utf-8?B?WWU4dEZKdjRzUjZBSWxOVzNZSkJJUUlLZmRybVA4Q05PWHJHVDJqaTUyaWpK?=
 =?utf-8?B?Ymc2OEdlZVhFNEs1Tzd3T3BqcVRaY1Q4LzBodEV3NDJhWmJNSkg5cERseFR2?=
 =?utf-8?Q?iPeHA+sWot+22RY/jSeDtJmFX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c4d668-c5ff-4309-00c1-08dc1cddf659
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 13:11:22.5988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8eXa4a1dAAOqWog+mheJoGJXY12siQ584tzn4w+E6VtRl8y0zxauspsdqUfn19bH3syBdFOzAPH+wV5VLhOlEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223

PiA+ICsjZGVmaW5lIE1PRFVMRV9FRVBST01fUEFHRQkwDQo+ID4gKyNkZWZpbmUgTU9EVUxFX0VF
UFJPTV9PRkZTRVQJMA0KPiA+ICsjZGVmaW5lIE1PRFVMRV9FRVBST01fTEVOR1RICTENCj4gPiAr
I2RlZmluZSBNT0RVTEVfRUVQUk9NX0kyQ19BRERSCTB4NTANCj4gPiArDQo+ID4gK3N0YXRpYyBp
bnQgbW9kdWxlX2ZsYXNoX2Z3X3dvcmtfaW5pdChzdHJ1Y3QgZXRodG9vbF9tb2R1bGVfZndfZmxh
c2gNCj4gKm1vZHVsZV9mdywNCj4gPiArCQkJCSAgICAgc3RydWN0IG5ldF9kZXZpY2UgKmRldiwN
Cj4gPiArCQkJCSAgICAgc3RydWN0IG5ldGxpbmtfZXh0X2FjayAqZXh0YWNrKSB7DQo+ID4gKwlj
b25zdCBzdHJ1Y3QgZXRodG9vbF9vcHMgKm9wcyA9IGRldi0+ZXRodG9vbF9vcHM7DQo+ID4gKwlz
dHJ1Y3QgZXRodG9vbF9tb2R1bGVfZWVwcm9tIHBhZ2VfZGF0YSA9IHt9Ow0KPiA+ICsJc3RydWN0
IG1vZHVsZV9zZmY4MDI0X2lkX3JwbCAqcnBsOw0KPiA+ICsJaW50IGVycjsNCj4gPiArDQo+ID4g
KwkvKiBGZXRjaCB0aGUgU0ZGLTgwMjQgSWRlbnRpZmllciBWYWx1ZS4gRm9yIGFsbCBzdXBwb3J0
ZWQgc3RhbmRhcmRzLCBpdA0KPiA+ICsJICogaXMgbG9jYXRlZCBhdCBJMkMgYWRkcmVzcyAweDUw
LCBieXRlIDAuIFNlZSBzZWN0aW9uIDQuMSBpbiBTRkYtODAyNCwNCj4gPiArCSAqIHJldmlzaW9u
IDQuOS4NCj4gPiArCSAqLw0KPiA+ICsJcGFnZV9kYXRhLnBhZ2UgPSBNT0RVTEVfRUVQUk9NX1BB
R0U7DQo+ID4gKwlwYWdlX2RhdGEub2Zmc2V0ID0gTU9EVUxFX0VFUFJPTV9PRkZTRVQ7DQo+ID4g
KwlwYWdlX2RhdGEubGVuZ3RoID0gTU9EVUxFX0VFUFJPTV9MRU5HVEg7DQo+ID4gKwlwYWdlX2Rh
dGEuaTJjX2FkZHJlc3MgPSBNT0RVTEVfRUVQUk9NX0kyQ19BRERSOw0KPiANCj4gUGxlYXNlIHVz
ZSBiZXR0ZXIgbmFtZXMgLSB0aGVzZSBhcmVuJ3QgYW55IGJldHRlciB0aGFuIHVzaW5nIGludGVn
ZXJzLg0KPiANCj4gTWF5YmUgdXNlIFNGUF9QSFlTX0lEIGZvciB0aGUgb2Zmc2V0Pw0KPiANCj4g
PiArCXBhZ2VfZGF0YS5kYXRhID0ga21hbGxvYyhwYWdlX2RhdGEubGVuZ3RoLCBHRlBfS0VSTkVM
KTsNCj4gPiArCWlmICghcGFnZV9kYXRhLmRhdGEpDQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+
ID4gKw0KPiA+ICsJZXJyID0gb3BzLT5nZXRfbW9kdWxlX2VlcHJvbV9ieV9wYWdlKGRldiwgJnBh
Z2VfZGF0YSwgZXh0YWNrKTsNCj4gPiArCWlmIChlcnIgPCAwKQ0KPiA+ICsJCWdvdG8gb3V0Ow0K
PiA+ICsNCj4gPiArCXJwbCA9IChzdHJ1Y3QgbW9kdWxlX3NmZjgwMjRfaWRfcnBsICopcGFnZV9k
YXRhLmRhdGE7DQo+IA0KPiBXaGF0IHB1cnBvc2UgZG9lcyB0aGlzIHN0cnVjdHVyZSBvZiBhIHNp
bmdsZSBieXRlIHNlcnZlPyBUbyBtZSwgaXQganVzdA0KPiBvYmZ1c2NhdGVzIHRoZSBjb2RlLg0K
PiANCj4gCXU4IHBoeXNfaWQ7DQo+IA0KPiAJLi4uDQo+IAlwYWdlX2RhdGEub2Zmc2V0ID0gU0ZQ
X1BIWVNfSUQ7DQo+IAlwYWdlX2RhdGEubGVuZ3RoID0gc2l6ZW9mKHBoeXNfaWQpOw0KPiAJcGFn
ZV9kYXRhLmRhdGEgPSAmcGh5c19pZDsNCj4gCS4uLg0KPiAJc3dpdGNoIChwaHlzX2lkKSB7DQo+
IA0KPiB3aWxsIHdvcmsganVzdCBhcyB3ZWxsLCBhbmQgYmUgbW9yZSBleHBsaWNpdCBhYm91dCB3
aGF0J3MgYWN0dWFsbHkgZ29pbmcgb24NCj4gaGVyZS4gSXQgZG9lc24ndCBtZWFuIHRoYXQgSSBo
YXZlIHRvIHVuZGVyc3RhbmQgd2hhdCB0aGlzIG5ldw0KPiBtb2R1bGVfc2ZmODAyNF9pZF9ycGwg
c3RydWN0dXJlIGlzLiBJIGNhbiBzZWUgdGhhdCB3ZSdyZSBqdXN0IGdldHRpbmcgb25lIGJ5dGUN
Cj4gd2hpY2ggaXMgdGhlIG1vZHVsZSBwaHlzaWNhbCBJRC4NCj4gDQo+IFlvdSBhbHNvIHRoZW4g
ZG9uJ3QgbmVlZCB0byBjYXJlIGFib3V0IGtmcmVlKClpbmcgb25lIGJ5dGUgb2YgZGF0YSBzdHJ1
Y3R1cmUuDQoNCk9LLCB3aWxsIGNoYW5nZSwgdGhhbmtzIQ0KDQo+IA0KPiAtLQ0KPiBSTUsncyBQ
YXRjaCBzeXN0ZW06IGh0dHBzOi8vd3d3LmFybWxpbnV4Lm9yZy51ay9kZXZlbG9wZXIvcGF0Y2hl
cy8NCj4gRlRUUCBpcyBoZXJlISA4ME1icHMgZG93biAxME1icHMgdXAuIERlY2VudCBjb25uZWN0
aXZpdHkgYXQgbGFzdCENCg==

