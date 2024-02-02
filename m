Return-Path: <linux-kernel+bounces-49537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F22D846B9D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E511F2A9C0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2229E7765C;
	Fri,  2 Feb 2024 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TQe9eeyj"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEF77691F;
	Fri,  2 Feb 2024 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865127; cv=fail; b=D8PZm+Fv8JeyFM9n4ZcAoPNeB/VrYll7MmDmexfMEjepPTSLD2YpjWhCW7+xShZ2fd+wQUXpZgnK94D/2La913QvHdXkO3v4h9/THM8GCHyLisVAZZFkzuLMyjWjxtiWutF10hvWo10e6h1DzOKaVeGogILaYsjHOJjMVAmBUGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865127; c=relaxed/simple;
	bh=OEspwwEcrHUugQM8BJcUdVCiu3InDe7XedvfbTc66/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IEGItyw6sI9StFPe9U9WGXWskY2OwciVmBle4zYj1R8eOCMyopewVNGam7IqVnU3++rzg559Bmaj0UjoIm8cmBJ3BRDCx5Ixhv5gVPd7J6Od2HccCHteoabfPj1+rWwqNGmgePDLukybw3vIamYI2OV7CXh++9Dm0eKBSxzbesw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TQe9eeyj; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoRmmzX32w/FpRpGeTKSV+cW/RoxdmkJJMieHdstEmz999XD8banwxN8kmLOCo4JBvQ6rq0nEBNWqFkf8dLSR+i3e7gN6ZpHm9bsjjvzaax64xIOdtXDkTsVhJ9XPHmReWXpOP2G3P+vgeQ+ciP0fIBFoPY/fFlWTA8II5mMh6v1P2XmjF1mptOzVQlIZJnanmc98Skb13IOMdnadf6L6q/2P644DhLfHfmpgafE1WcKgPgLVr9AMsLPRtdfBi7tFV/7ysnYfY55txSprmon1rZkhEHO5ISDyoOvxlfzHffwv+sOZvlc7f2c12OxKYr4eybphhVC01qkGHtmVWpICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEspwwEcrHUugQM8BJcUdVCiu3InDe7XedvfbTc66/Y=;
 b=evxUJjSFeO32rjLp95gWcefURVTFuWeQR92LVl1L75Wy/vAjws6jilI4I4mutRsxL0AJIX/WVRIvyIuyzwlUSZ12RVtRDnlMDW7o9Qga2oTWRBk2QoWUvwfkxIB2uKwr6blXGYfsRyuZAyKGrRCMRSgbnabR1Fi3fkFZJNotMPNEb23vAecztc8QOqe4Zp7GGFMUiXIvdTUnCuA9ILIJETAQB71bmDQavp1iKTipGdtnvVtSOOerzrs5LWKsoqsuNRb6ley/OPnjhdvjO+dMLXFRpo9oMKe7MEXHXtCYNoo3eTYLUSMlWzP6axfvibOW8PhjRgJH48RiG3+iSFx3Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEspwwEcrHUugQM8BJcUdVCiu3InDe7XedvfbTc66/Y=;
 b=TQe9eeyj3yRJRQ9/OvjjiBr8vzZG1jWB1em1h1IMeeMS8D0thSbU0IVt4Kq7Pvp+fAwSdqzb6a1DtOSBdDVeMOqnghuodexOvsoxeTEA3zV2VH7A3VrGOdARqVJNfpoCG7ocbWYvVzT4rLbqE11pOn5Mxqk8hidV59F/oxSPVFM=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.13; Fri, 2 Feb
 2024 09:12:02 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4%4]) with mapi id 15.20.7270.010; Fri, 2 Feb 2024
 09:12:02 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Tor Vic <torvic9@mailbox.org>, "rafael.j.wysocki@intel.com"
	<rafael.j.wysocki@intel.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Shenoy, Gautham
 Ranjal" <gautham.shenoy@amd.com>, "Petkov, Borislav"
	<Borislav.Petkov@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/6] AMD Pstate Fixes And Enhancements
Thread-Topic: [PATCH 0/6] AMD Pstate Fixes And Enhancements
Thread-Index: AQHaVCNk4hhcsxszf0KGLSwQbDyDeLDzy0yAgAL61hA=
Date: Fri, 2 Feb 2024 09:12:02 +0000
Message-ID:
 <CYYPR12MB8655BBC9EABDD956948322869C422@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1706690577.git.perry.yuan@amd.com>
 <63c2b3d7-083a-4daa-ba40-629b3223a92d@mailbox.org>
In-Reply-To: <63c2b3d7-083a-4daa-ba40-629b3223a92d@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6fd1c0ce-6fec-4808-9952-57f1bc058f30;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-02T09:07:10Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DM6PR12MB4481:EE_
x-ms-office365-filtering-correlation-id: c28b783c-19e3-4767-2f48-08dc23cf04f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zkIoSRWjFKUFFvBqgXDOr/O3hjtdEsDMdI9++sWla4rRIbQX/xddEFSBf//7xbhgAwQKNyneniJZjLux5KEyBmkR5KVihBooYbTrjki62xHVVGCKsXotzdfwn71v528ZtBaB6KZ6K9/hcvAzZavgKI5s9kAreatHE4cyDdu20hDvbvndhHYXUHtur2IJhY/+wolyGRoA1ZleD78mO3a4ACHXlGyKe4JXN7q13uoL4RQ7s12RHQJxBguFMmaFBdytA3gqoz9keTHTxXU9UzFuLtR2ruJ3ZxgDaKfMKgU/Bx2q7P0crKFLjk1/51h4JSltSQP+hKh2Ersmd+tPL56dtd+KAHLGBXf3U4VQa3A5DCHh/2GjzDUGzRSBrkPfZEJ3QetpLnYPyMPIE918UK0ZM/jQQlRkQNKdrM6FrQi5BI8CAQ7+p+yVRzsJqEf6zMDuvSDB4//XFBkxYOdixt93yUhcEU5a+hO1PwfwpUtCDH0t3KVPS95feeLaUwtVV/2UPqErM/7E90yX9eJ5s0xoG6UqpTKpmi2Wxt8jwdlKbVVTXZZle5Oy7qzTa/hKAjy71NB7rUIKzXHzmxno+ldrDK9xGcGtNBrmxoz6dml9pnlMT8BoFKP4xwBO5s1o3bAWtp1sRxCUTBgoFhJAK3yFg2axCObb8iP6hVLRdxVonhA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(41300700001)(66946007)(52536014)(8936002)(4326008)(2906002)(33656002)(5660300002)(8676002)(86362001)(110136005)(76116006)(66476007)(54906003)(6636002)(316002)(66556008)(66446008)(64756008)(38070700009)(966005)(38100700002)(122000001)(53546011)(7696005)(6506007)(9686003)(478600001)(71200400001)(83380400001)(26005)(921011)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDJBUnVtdGZHV3U5TCtjdG0xR0xpdUpJVFNUZEU5OG5vdUp6VS9Qai83Skpm?=
 =?utf-8?B?OGZFb1hWem1zWDBPWHJRakd4NEJZTG4xRUEvSTZ1d2VFd1J1U0YwNEttTGV4?=
 =?utf-8?B?bTRucDdpcFN4NzBzOW9ERFhSOHNlVzAyK3VldFFhaW0yUlZibnNWVmczVWFL?=
 =?utf-8?B?UlhPRWtERzJYY0NYWDVhTXp5M2VOdFd6OFVSMDhodWdNNFZ6cVMvS3RVVGla?=
 =?utf-8?B?ZjAzUzR2ZXVaREJUVjFuVzh0SjBzY1lFRGdGSS9jU0c3YWVnOURKblhUaHlP?=
 =?utf-8?B?MFlHTG11bzJiWEFsMUtHajdKM0tabFB4aitxNzJ4bnRqekVUSUtUVVhXUS8x?=
 =?utf-8?B?V3lJTVhTL294TXJkOUlQZGNiWU5mWENzdDI2cWxlZWNwS1NwWXY0OEtmMXgv?=
 =?utf-8?B?SHUzMmhVdFJ2VklVMjNuVlc0Uit2Qzg3WDEvSlhwV2d4RXhLYzdMYjlYYWZZ?=
 =?utf-8?B?cVp0UEdzd2N1ZU05RjdPclAzMlZNUjIrKzFGaENsRjZvMUU1bkVheXVIaTgv?=
 =?utf-8?B?WlkzMllhaHkvSHRmZ24rcmJKQ1l0V3FnU3NWYlZ3TlRKMnJQa0xpWC9BR2Zv?=
 =?utf-8?B?THJqNENhWkh4dEhLWU9WZWpkc0Q1emhJQmxtWXhoTlFneWc0eElRaGRBN3NE?=
 =?utf-8?B?RmhvQWpQMFRvU3hXcjNoVHM2c1RRVU1QOG41dnhvS0FkejFiM3NsV0xvNUpV?=
 =?utf-8?B?aWJseklDUllUT29aQ1FUTEoyNzRFeU92ZjhmZXY0R09mamdVUG9wd2R2dmVt?=
 =?utf-8?B?aUhkSGxyK1k0N0FhbUcvZDhEc2YrbWFCUFVHNU43dXBMY2FFMGhkUTEwV2pY?=
 =?utf-8?B?UnQxOE1iZmFKaGtSZ1NJWCs4c0dST2sxVnZrYzJUK0QvVFQ1TVdSY3lpV2hT?=
 =?utf-8?B?ZEVhbzZuQTBKTjNlUTgyc3pJOFlFNEtSK2ZQN0ZCb2x4UGN4S05qYlk1TXgy?=
 =?utf-8?B?bzloWWNxTVI0RzJ1aEVsMmJ6eEdjVENPVTZNUU9VQ0krM0RUWURTZG92ckRR?=
 =?utf-8?B?U1dhL0Qxc05PeDFmY2ZWeTJvdzlVZTBSMzFFTkt6WWw0YUhDVWZZUWVTQ2Ju?=
 =?utf-8?B?YUZUaXIzVVpTdlhNWTB1Mkp3OWpNQTlORHdmK1AvekUvZHAwRlFja1h1Z1RX?=
 =?utf-8?B?SXFka3l2RFNJNHFoTHpWR3JxVkpmZXlpTWtaeFlBZ1pqeDFwT3pHdm50REs2?=
 =?utf-8?B?c2w5WndIcHEzNFcvMDZkY0FDRlNwTzRGWFlHTExQVm0vN2lGWGJvVVhHamZs?=
 =?utf-8?B?bGZiTW83TlRDcmZZbVJyQi9sR0NDTUh5QkRyb25sa1dralJXQ1FQdldvRXY2?=
 =?utf-8?B?dDJiOC9JcUg4Q0E4VExRVkREUEF1dFlPWGtGY3dmajZ6V1FvdmVoSFVXa2lG?=
 =?utf-8?B?Z1dpUWZSNkQ4RkRBOUZ4K2VuRThyQ3BpRU1zb3hqeFk1V0R0USsrWmRoaEdJ?=
 =?utf-8?B?QWFZSU13WmNJeGx4TnIxQVdEdUJPU0xZeDN4Z1FndDZGcDYwNlF4UEVSN2hp?=
 =?utf-8?B?ZTdHbzVTZkxOTnR3cGdiSlZ4NStvaCtzdkZxV05kREEvWnFid1RXaTM0OVUz?=
 =?utf-8?B?Tk05bXJ2MVd5UjVsRnNPQjNRWU11dWkyRitiYU9jR2RraDB2U3RxSGJRMTlF?=
 =?utf-8?B?TW5IM3JUc2k0WjNkZlFrZHdwTXRyazBCZFJjWEpwazVIQUZPZFlEcFNqT2FJ?=
 =?utf-8?B?MlltZEgxRWdNQmd6ZDNwbVlOSGY1ekQwMDB2enhoNjFwblJWVFBwU282ODRh?=
 =?utf-8?B?eDgwVnI4S2YrTG8rclhla1FxeFkwRUpycWs0UGN5TkY0aXRlZGpXSHpyMDRp?=
 =?utf-8?B?SDBvMGdNN3ZFL2ZRa2VrY1U4cDJNMmhDMGJ0ZHAvQlovQ3Z6VGtleGlndTRx?=
 =?utf-8?B?OHdrNnIzSWwyM1RlZnhEcEdmOTBrMXpiRG1qMnNYWWVmTDAwRlpsMVprdmxs?=
 =?utf-8?B?VGlPdE55ZWRWTWZhWGFuM3V6NFVkMXdWOFZMWXBOaGVRdm1VdXFpR3FRMDk3?=
 =?utf-8?B?RERPYWc1YVIvNnJ2anUxTC9lSkdDMW5ydkpZcDNmeDBucTMzb1BuazM5U1pY?=
 =?utf-8?B?Y3I0OEQ3c2N6NEtDeHhUenJzK0tiY0hOS3VkVnkxM3NIQy9zRXUySU9ZMEx3?=
 =?utf-8?Q?GbrE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28b783c-19e3-4767-2f48-08dc23cf04f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 09:12:02.7910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKJusIdD413sM9UmYnWgShaoSI8ob82Hku81etym8kA1eU6cowlXN/FUBbdkEjPT7DI/VdaSTjtEXOOm566/6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFZpYw0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRvciBWaWMgPHRvcnZpYzlAbWFpbGJveC5vcmc+
DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAzMSwgMjAyNCA3OjM3IFBNDQo+IFRvOiBZdWFu
LCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgcmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb207
IExpbW9uY2llbGxvLA0KPiBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IHZpcmVz
aC5rdW1hckBsaW5hcm8ub3JnOyBIdWFuZywgUmF5DQo+IDxSYXkuSHVhbmdAYW1kLmNvbT47IFNo
ZW5veSwgR2F1dGhhbSBSYW5qYWwNCj4gPGdhdXRoYW0uc2hlbm95QGFtZC5jb20+OyBQZXRrb3Ys
IEJvcmlzbGF2IDxCb3Jpc2xhdi5QZXRrb3ZAYW1kLmNvbT4NCj4gQ2M6IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBTaGltbWVyDQo+IDxTaGlt
bWVyLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1QGFtZC5jb20+OyBN
ZW5nLCBMaQ0KPiAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5jb20+OyBsaW51eC1wbUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggMC82XSBBTUQgUHN0YXRlIEZpeGVzIEFuZCBFbmhhbmNlbWVudHMNCj4NCj4NCj4N
Cj4gT24gMS8zMS8yNCAwOTo1MCwgUGVycnkgWXVhbiB3cm90ZToNCj4gPiBUaGUgcGF0Y2ggc2Vy
aWVzIGFkZHMgc29tZSBmaXhlcyBhbmQgZW5oYW5jZW1lbnRzIHRvIHRoZSBBTUQgcHN0YXRlIGRy
aXZlci4NCj4gPiBJdCBlbmFibGVzIENQUEMgdjIgZm9yIGNlcnRhaW4gcHJvY2Vzc29ycyBpbiB0
aGUgZmFtaWx5IDE3SCwgYXMNCj4gPiByZXF1ZXN0ZWQgYnkgVFI0MCBwcm9jZXNzb3IgdXNlcnMg
d2hvIGV4cGVjdCBpbXByb3ZlZCBwZXJmb3JtYW5jZSBhbmQNCj4gPiBsb3dlciBzeXN0ZW0gdGVt
cGVyYXR1cmUuDQo+ID4NCj4gPiBBZGRpdGlvbmFsbHksIGl0IGZpeGVzIHRoZSBpbml0aWFsaXph
dGlvbiBvZiBub21pbmFsX2ZyZXEgZm9yIGVhY2gNCj4gPiBjcHVkYXRhIGFuZCBjaGFuZ2VzIGxh
dGVuY3kgYW5kIGRlbGF5IHZhbHVlcyB0byBiZSByZWFkIGZyb20gcGxhdGZvcm0NCj4gPiBmaXJt
d2FyZSBmaXJzdGx5IGZvciBtb3JlIGFjY3VyYXRlIHRpbWluZy4NCj4gPg0KPiA+IEEgbmV3IHF1
aXJrIGlzIGFsc28gYWRkZWQgZm9yIGxlZ2FjeSBwcm9jZXNzb3JzIHRoYXQgbGFjayBDUFBDDQo+
ID4gY2FwYWJpbGl0aWVzLCB3aGljaCBjYXVzZWQgdGhlIHBzdGF0ZSBkcml2ZXIgdG8gZmFpbCBs
b2FkaW5nLg0KPiA+DQo+ID4gSSB3b3VsZCBncmVhdGx5IGFwcHJlY2lhdGUgYW55IGZlZWRiYWNr
cy4NCj4gPg0KPg0KPiBIaSBQZXJyeSwNCj4NCj4gV2hpY2ggdHJlZSBvciBwYXRjaHNldCBpcyB0
aGlzIGJhc2VkIG9uPw0KPiBJdCBkb2Vzbid0IGFwcGx5IGNsZWFubHkgb250byBlaXRoZXIgNi43
IG9yIDYuOC4NCj4NCj4gRmlyc3QgSSBoYWQgdG8gcmV2ZXJ0IFsxXSwgdGhlbiBhcHBseSBbMl0g
YmVmb3JlIGFwcGx5aW5nIHRoaXMgcGF0Y2hzZXQgYW5kIGZpbmFsbHkNCj4gcmVhcHBseSBbMV0u
DQo+IEkgZGlkIG5vdCBhcHBseSB0aGUgInByZWZjb3JlIiBwYXRjaHNldCB3aGljaCBJIGtlZXAg
aW4gYSBzZXBhcmF0ZSBicmFuY2guDQo+DQo+IElzIHRoaXMgY29ycmVjdCBvciBkaWQgSSBtZXNz
IHVwIHNvbWV0aGluZyB3aXRoIG15IGJyYW5jaGVzPw0KDQoNCkhpIFRvciwNCg0KSSBoYXZlIHJl
YmFzZWQgdGhlIHNlcmllcyB0byBMaW51eC1wbSA2LjggcmMyLCB5b3UgY2FuIHB1bGwgdGhlIExp
bnV4LXBtL2JsZWVkaW5nLWVkZ2UgYW5kIGFwcGx5IHRoZSBwYXRjaGVzIG9uIHRvcCBvZiB0aGF0
Lg0KVGhlIHBhcnQgMSBwcmVmZXIgY29yZSBwYXRjaGVzIGFyZSBhbHJlYWR5IG1lcmdlZCBpbnRv
IExpbnV4LXBtIHRyZWUsIHNvIHlvdSBjYW4ganVzdCBtZXJnZSB0aGlzIHNlcmllcw0KSGVyZSBp
cyB0aGUgVjIgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9jb3Zlci4xNzA2ODYzOTgxLmdp
dC5wZXJyeS55dWFuQGFtZC5jb20vDQoNCg0KZ2l0IGNsb25lIGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3JhZmFlbC9saW51eC1wbS5naXQNCmdpdCBjaGVj
a291dCBibGVlZGluZy1lZGdlDQoNClBlcnJ5Lg0KDQo+DQo+IC0tLQ0KPiBbMV0NCj4gaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXgu
Z2l0L2NvbW1pdC8/aD12Ni4NCj4gOC1yYzImaWQ9ZmViYWIyMGNhZWJhYzk1OWZkYzNkNzUyMGJj
NTJkZThiMTE4NDQ1NQ0KPg0KPiBbMl0NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
cG0vY292ZXIuMTcwNjI1NTY3Ni5naXQucGVycnkueXVhbkBhbWQuY29tLw0KPg0KPiBDaGVlcnMs
DQo+IFRvciBWaWMNCj4NCj4gPiBUaGFuayB5b3UhDQo+ID4NCj4gPg0KPiA+IFBlcnJ5IFl1YW4g
KDYpOg0KPiA+ICAgIEFDUEk6IENQUEM6IGVuYWJsZSBBTUQgQ1BQQyBWMiBzdXBwb3J0IGZvciBm
YW1pbHkgMTdoIHByb2Nlc3NvcnMNCj4gPiAgICBjcHVmcmVxOmFtZC1wc3RhdGU6IGZpeCB0aGUg
bm9taW5hbCBmcmVxIHZhbHVlIHNldA0KPiA+ICAgIGNwdWZyZXE6YW1kLXBzdGF0ZTogaW5pdGlh
bGl6ZSBub21pbmFsX2ZyZXEgb2YgZWFjaCBjcHVkYXRhDQo+ID4gICAgY3B1ZnJlcTphbWQtcHN0
YXRlOiBnZXQgcHN0YXRlIHRyYW5zaXRpb24gZGVsYXkgYW5kIGxhdGVuY3kgdmFsdWUgZnJvbQ0K
PiA+ICAgICAgQUNQSSB0YWJsZXMNCj4gPiAgICBjcHBjX2FjcGk6IHByaW50IGVycm9yIG1lc3Nh
Z2UgaWYgQ1BQQyBpcyB1bnN1cHBvcnRlZA0KPiA+ICAgIGNwdWZyZXE6YW1kLXBzdGF0ZTogYWRk
IHF1aXJrIGZvciB0aGUgcHN0YXRlIENQUEMgY2FwYWJpbGl0aWVzDQo+ID4gbWlzc2luZw0KPiA+
DQo+ID4gICBhcmNoL3g4Ni9rZXJuZWwvYWNwaS9jcHBjLmMgIHwgICAyICstDQo+ID4gICBkcml2
ZXJzL2FjcGkvY3BwY19hY3BpLmMgICAgIHwgICA2ICstDQo+ID4gICBkcml2ZXJzL2NwdWZyZXEv
YW1kLXBzdGF0ZS5jIHwgMTEyICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+
ID4gICBpbmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaCAgIHwgICA2ICsrDQo+ID4gICA0IGZpbGVz
IGNoYW5nZWQsIDEwMiBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4gPg0K

