Return-Path: <linux-kernel+bounces-101710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F69E87AADB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AD1285347
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4A445BF3;
	Wed, 13 Mar 2024 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NiBQoePu"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B301047A7A;
	Wed, 13 Mar 2024 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345817; cv=fail; b=cEa5bM6Sz+3FjqtfBMlJY4W6JYa7BQTw3zGoP9+2c3PuIw8VJTySaZ/ZshALYqQbKYI8qdH6K1q66mWpvjGt/aDP/mzYTtRyNq1glzyLyAX2/6mMKHW+TreNNXV4vM/ZSn+AkXpU6lreDgP2Xu1+IKgAmrHcA4qGfCARdGxlw6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345817; c=relaxed/simple;
	bh=WSZn9Xd7HpPxRIvWm5gChQQLd/tdDU6XzWcG8m1X9Rk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g+MzjvQ012PjBYX/OGi3mUkzgmbkpPA2rHQ4LtnvY8aDmHnrPF+lgUVZ4leG03qY1G7G8VOS4aze161ckkmC4fb8ixVdAlMOWUafwITPXSOu6isxFbAbcycLRhP9iP0DL3ryo7/8Z8heiJ2DZ5T5oLo3f5vIuq0rIV/GrS/JigQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NiBQoePu; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axBgx7iwQHkCe6LlvlUuotyoJ9klKz6mPa4QWKCSPqYZAyM8ioK+uD7hTzhgprKH0+Y5BSIrmbnrSEOzDxsefOA5ThBCfaoH5ZTCA0FODa4b3WmPg1YtV7BIHFWJL6g8gwicxpyF42BBBylWqYe7tIsr1At0ssr0inHZK+zuGLNrhDx8cjna6usloJyXPex9ezxYwbSqkEWt/1xm8dERASl0lYT+tDnx1o09bydBDj9/2TJn1JE72YKlogOVbhuf/f7qw2SaVdySa3mHwLrhbKvDeQrKO6X17BGLb9a7ERegI7RKjsTdWDH4EA2CT64yQkNzAh/v6hGk49kVyhVz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSZn9Xd7HpPxRIvWm5gChQQLd/tdDU6XzWcG8m1X9Rk=;
 b=a/JlVQ3AyoxrruCQCvmCrNIDYHl0BVgbeMmL4MFz7OOFvd4DhphVy/u7fPwlbgP1FdbA3Ikc7DBLTd77lNC8p1HfpP+ZNKRFlFgjH+hn75VNZ9YFtWTcVuJMgu3OG3QXuOEycUJsp5CXTYhG/CZ80NPZn1BXjK7MBXcttgq7IEgIqMcRy8EjGMpP/tjsA7eeuAjoZD5VHbE92N5UaN/EG+NWbjFK/0GR7++bbVDOAY2C09+rv0vDigmyrMGaNptCRwBSk03qbqtYkfZDIRcR6mrNjYH9altQIGW8fsctN1CT3Jah7DwgfsyLNo12dHA+C81AniSkILZQXlIv+5KOqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSZn9Xd7HpPxRIvWm5gChQQLd/tdDU6XzWcG8m1X9Rk=;
 b=NiBQoePufFlpbSC9INXUxA9eL5aOEXGgQlxL5SrxulDAVbgvNGlEi4QVVjDGqBaqnblV19x1tg45ofBTi/wV/9otDZX6FTnFGCyODEMvsSOSH/M6AkljKwPsqcRHRdY9tCm+IIBH1udc+SLsrkVJ36URznmyCDxm5VmhwOK3N0g=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by IA0PR12MB7578.namprd12.prod.outlook.com (2603:10b6:208:43d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 16:03:31 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2318:9906:4dae:a041]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2318:9906:4dae:a041%5]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 16:03:30 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "pratyush@kernel.org" <pratyush@kernel.org>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>, "richard@nod.at"
	<richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
	"lee@kernel.org" <lee@kernel.org>, "james.schulman@cirrus.com"
	<james.schulman@cirrus.com>, "david.rhodes@cirrus.com"
	<david.rhodes@cirrus.com>, "rf@opensource.cirrus.com"
	<rf@opensource.cirrus.com>, "perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"michael@walle.cc" <michael@walle.cc>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "nicolas.ferre@microchip.com"
	<nicolas.ferre@microchip.com>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "claudiu.beznea@tuxon.dev"
	<claudiu.beznea@tuxon.dev>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "patches@opensource.cirrus.com"
	<patches@opensource.cirrus.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>, Conor Dooley
	<conor.dooley@microchip.com>, "beanhuo@micron.com" <beanhuo@micron.com>
Subject: RE: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Topic: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Index:
 AQHaH4D9pFM5xtDoeEuMNIpXuxvtzbCcYmwAgAEJ+aCABhoaAIAAMcLwgAAzdICAADdZAIABtmWAgAQ4ECCAAAuVAIAAD5dQgAAYdQCAAAF/8IAGJHEAgAFe7KCAUIcDAIA0IOxw
Date: Wed, 13 Mar 2024 16:03:30 +0000
Message-ID:
 <BN7PR12MB2802545E373A18B86C153F97DC2A2@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <e2305642-55f1-4893-bea3-b170ac0a5348@linaro.org>
 <BN7PR12MB2802BEDFB821A1748185794CDC8AA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <f5a47024-514a-4846-bc16-08cf0f9af912@linaro.org>
 <BN7PR12MB2802BB3DA682D9C13EF7DE08DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <5a6f6764-6779-42b0-b6c6-3f638b85ef78@linaro.org>
 <BN7PR12MB28029EB1A7D09882878499A2DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <c3fa1e04-92ed-48ab-a509-98e43abd5cd6@linaro.org>
 <BN7PR12MB2802E87F1A6CD22D904CAEACDC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <b3d3c457-a43b-478a-85b3-52558227d139@linaro.org>
 <BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <e212f9fa-83c5-4b9e-8636-c8c6183096ab@linaro.org>
 <BN7PR12MB280237CDD7BB148479932874DC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <576d56ed-d24b-40f9-9ae4-a02c50eea2ab@linaro.org>
 <BN7PR12MB2802F288C6A6B1580CF07959DC95A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <c6f209c8-47da-4881-921d-683464b9ddd5@linaro.org>
In-Reply-To: <c6f209c8-47da-4881-921d-683464b9ddd5@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|IA0PR12MB7578:EE_
x-ms-office365-filtering-correlation-id: 2680058e-be75-4323-7eb2-08dc437720b4
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Roy17tIbnBPLE3VvPHZESrKeseJeT1ZjB06rYRP8+8ZJp/rYGFcrQ+S3eLjj+n3wwHpHlZPplQRKuDmdZIWwOEQx+twcKc1M9yDuD3m4J86g6fkRTqKbp9qJKCbma8Ry9Lr13AZXfYhUIVlWerb9OW+DQuPULE+QtolMu3LZVI2QnwtcjuZqyAkEGcDhYWNzlPx7TgPWMlCcJOkxrNcxt1BIOWb18hYoHs/e2IKFn8a1YNY3cmRyhC5FKc6zfEK7cDlXPzt/NFZaJCR7IEWebgvg38rRmJA0KDcF6l2jvrm45C27IDI+Im+Dy0itS9Tu6h84W4941ZR0es3349y+EPD/6d+GA96E9XGOAbiMajhJxxxpPQbfNX52M2/w6NzDwv4Ub+O+Xf5YAVL9ZUmhW1VVDV699SW2+UTlq4KlCKpsC73nR7TEIOfa05Zo8frbohlnNEOfwst7hKHJHzrr/6Q4kbZzNoaw1hHRLuOSnmI9g+Y+ZIHqHPq+GP66c+fz6b0Umv/CXbRaG7iIPQuyBM8eTJW1grsgUKaRfNZLNkFQZ2uiFSukSCZYypns0LAVk3+rmupeuRJ36eaAdc77lMK7ZJmq9v0ma5S0Xg+q5ptGi/1PDeRI/UaI+yKUy6l1VUR0pXVZ2Fw541/geV6jjOeDS1pFJ8whPfDcQPw17gvfHfvB7L1YK/2TjRvYTBO1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEw2OXl3SEYzS0pPWjBQNmJNT1VSZDROWUh1czhJUXhRSDRMNjZCVXNzL2gr?=
 =?utf-8?B?akJvUGw4WnB1amc5VEZzTWJmZ2xUZnpGNjNvMTdsYmFENkRGazkxY2EyWkJl?=
 =?utf-8?B?ZnVJRHFSSUlBWm5Dc0tvMCttUjA5d0dleXdzRDVGQWF4VkVNWXdNR0llcVFa?=
 =?utf-8?B?S3NxeVR5T25OdExpNVhDcXc1NlNVSkJXTThkRmx4L2dxdXJkcjdwUGdvQlMy?=
 =?utf-8?B?VDFacHo3TjcwTUQxUjNQQVdON1B3cDhxbUtmVmpwQVJNTGhCS2dxdEN4TE0w?=
 =?utf-8?B?c2wzSkxzSTQ3c0JwRURkMnduYVd6a1QrcGFHWFYyazZ1ZERQMEtIcG96OXVF?=
 =?utf-8?B?QzVxUnQvMzczM2RkTFhZSkRPM1VNVWpXaDFTU240QTZud3lwR2RlRmU0SEhZ?=
 =?utf-8?B?dkRJS1gxNU5JUXdCV3R3cW96blVvY2VoS2NWM1RPVE14b2RwYjBxVzQvUGRn?=
 =?utf-8?B?a01rYjF2UW96UWo5Nml6S1JmUFlUc0tibmFUcFpTNC9MamhLQ0RCYTEzbElE?=
 =?utf-8?B?eFQwcHpzSUVPUTRqVy9XWUIyaVNSV0gyTTRBRHFleTFsOTFZSU40UXI3Qzhz?=
 =?utf-8?B?VmNGU0ZXVzhMMmsvVmtFSngxTDRSbG53UlN4RWZVU1JzUktJY1p4eGw3T01s?=
 =?utf-8?B?UnFpbDN3ckFiaFV3QWJ2SlZoOCt2NjhBdzVBdHp2aW1WTm9xWGpWNkhQMTdP?=
 =?utf-8?B?cGF6dnk1Ui9tQVNtQUlldDdrU0FuV3F5Z3ZwUlEyQm5iTis2SGNnRDRoUG5W?=
 =?utf-8?B?Zjh6cVBNdjRnUHJNa0E5U3BuWk5nSUM1bHZmbEkwT3Z0aVUxT280Vkt4YjdW?=
 =?utf-8?B?SzdtY3Q4akxGK0ozdGhnMkp4RTF0WXllL1NVUTRHTjFycGM4ZUFDeXBTRjQ5?=
 =?utf-8?B?b1hQVk5CazhFLy9aN3RTZHZQVTBIZ0xpNVlKN2xSQ0tsTU1SRlhqa1FFNktG?=
 =?utf-8?B?blk1bkNDVXFSVTh1YmVHL2RrQzJtbFhFWEFLbkMwdGFnak4wYXV0OENlWm1E?=
 =?utf-8?B?YnA1blNUTnhPeHVQK3diOGU0YitKWitjN1FvVEF3WWRsY01kWldUbFNJbnUv?=
 =?utf-8?B?RHYxS1p3VVNSTGtZd0krTGY3TkFzVXpKOEhQaEd5bU9MbjA1SFJZUHpRTysy?=
 =?utf-8?B?Umd1TjBZMWZjSzhMbnhzK0MycnorWmdhSFpXRzVJUlJDbzlzR3FVNll4K3JK?=
 =?utf-8?B?LzhzQ1BtTU1LTjlYcFlHRWwwVVJQVldMSXRFbk05WHpiczF0cmNEQ3dYcDZR?=
 =?utf-8?B?eG1DTWJ4ZGxuQmYwUGhLV21UeCt6WjQ0dEtFS08rTTZpNDhMZzhyS2hrdXBu?=
 =?utf-8?B?OHZpeWtSUkJXb0F6WVhZd0tCVFVHQm1KS0F5NEFHeDI2Nll6MHk2Z04ya2Fw?=
 =?utf-8?B?dUVJcFI1Q0hySTBIaTJvUWJmSlQ3Z1BORnQrZjlTeGhpMEd1eWVNRjhYNHJB?=
 =?utf-8?B?ZlljQWREcGxsTFJFYmtkYklWdEhuOThlbmZOekZxMTNqbnR5b096ckJCb1RU?=
 =?utf-8?B?N01HTHQwWDk0ekprVDNkczMvTERneUk4a29tVHNUeFFublFzZ2dvbi9GV0xB?=
 =?utf-8?B?RTZ6M3RtUk96QXVUcWQxTXJWUlg4OWFsT29CMk40MVF0TVhDZnBuUkk1dXZs?=
 =?utf-8?B?TnBUeHpjSjQxdW1MNWdSa2pBMUVPcWwxZkQzUFA0V2FBZ3RSclBqR1Q1With?=
 =?utf-8?B?ZWtXL3hqTUhPRTFwTU1WSWxCYkEzd2xqWUEvNnFndWEvbnE5U1JZRkllUkJC?=
 =?utf-8?B?ZzBuL1NRSk5nZngyM3Z0eDF0VnkvaG9QT3BVTjVqbkN0Mld5cis1OGFJK29o?=
 =?utf-8?B?ME45VW04Rk0rM0dKVDI1cXQyZGR4Y2VGMVJuaFQ1Ykk4RmdxMTJQT3haWTNB?=
 =?utf-8?B?ZlY3VVlRUlBaN0FsM2lxUHBzcXlxa0ttZFU3aWhvSEtYY1ZuVTZ6ckxJMnZW?=
 =?utf-8?B?Rkc0dVVsak1yVFA5YTAzL2tEUzZPR3VhZVVCazZnMXlkMXgvbHNzZ0dya2d1?=
 =?utf-8?B?T1BCU0FRVGpNa1lFckZDcXFiV2ZCWE56djdpY3RrYVlzZkh6Y0VmUTIzb3dK?=
 =?utf-8?B?V2N4bWRjMUZ5RndZYVFSUlkvMU5zMmx6MXpYWFdzaHpjWHkwdWdXYVFTQWQ5?=
 =?utf-8?Q?hKaA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2680058e-be75-4323-7eb2-08dc437720b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 16:03:30.8354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s6e/C2tpcxOuinBKzGEyPzICLWbhxLlkBJslN0ZfzAEw5tRUq0ZiIPj0NL8MgO3NrC3499P5OOzCU/IcUanFig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7578

SGVsbG8gVHVkb3IsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVk
b3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIEZl
YnJ1YXJ5IDksIDIwMjQgNDozNiBQTQ0KPiBUbzogTWFoYXBhdHJhLCBBbWl0IEt1bWFyIDxhbWl0
Lmt1bWFyLW1haGFwYXRyYUBhbWQuY29tPjsNCj4gYnJvb25pZUBrZXJuZWwub3JnOyBwcmF0eXVz
aEBrZXJuZWwub3JnOyBtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tOw0KPiByaWNoYXJkQG5vZC5h
dDsgdmlnbmVzaHJAdGkuY29tOyBzYmluZGluZ0BvcGVuc291cmNlLmNpcnJ1cy5jb207DQo+IGxl
ZUBrZXJuZWwub3JnOyBqYW1lcy5zY2h1bG1hbkBjaXJydXMuY29tOyBkYXZpZC5yaG9kZXNAY2ly
cnVzLmNvbTsNCj4gcmZAb3BlbnNvdXJjZS5jaXJydXMuY29tOyBwZXJleEBwZXJleC5jejsgdGl3
YWlAc3VzZS5jb20NCj4gQ2M6IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+IG1pY2hhZWxAd2FsbGUuY2M7IGxpbnV4LW10ZEBsaXN0cy5p
bmZyYWRlYWQub3JnOw0KPiBuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb207IGFsZXhhbmRyZS5i
ZWxsb25pQGJvb3RsaW4uY29tOw0KPiBjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY7IFNpbWVrLCBN
aWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgbGludXgtDQo+IGFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnOw0KPiBwYXRjaGVzQG9w
ZW5zb3VyY2UuY2lycnVzLmNvbTsgbGludXgtc291bmRAdmdlci5rZXJuZWwub3JnOyBnaXQgKEFN
RC0NCj4gWGlsaW54KSA8Z2l0QGFtZC5jb20+OyBhbWl0cmtjaWFuMjAwMkBnbWFpbC5jb207IENv
bm9yIERvb2xleQ0KPiA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+OyBiZWFuaHVvQG1pY3Jv
bi5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTEgMDcvMTBdIG10ZDogc3BpLW5vcjogQWRk
IHN0YWNrZWQgbWVtb3JpZXMgc3VwcG9ydA0KPiBpbiBzcGktbm9yDQo+IA0KPiBDQVVUSU9OOiBU
aGlzIG1lc3NhZ2UgaGFzIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFBsZWFz
ZSB1c2UNCj4gcHJvcGVyIGp1ZGdtZW50IGFuZCBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2ht
ZW50cywgY2xpY2tpbmcgbGlua3MsIG9yDQo+IHJlc3BvbmRpbmcgdG8gdGhpcyBlbWFpbC4NCj4g
DQo+IA0KPiBPbiAxMi8yMS8yMyAwNjo1NCwgTWFoYXBhdHJhLCBBbWl0IEt1bWFyIHdyb3RlOg0K
PiA+PiBTb21ldGhpbmcgZWxzZSB0byBjb25zaWRlcjogSSBzZWUgdGhhdCBNaWNyb24gaGFzIGEg
dHdpbiBxdWFkIG1vZGU6DQo+ID4+IGh0dHBzOi8vbWVkaWEtd3d3Lm1pY3Jvbi5jb20vLQ0KPiA+
PiAvbWVkaWEvY2xpZW50L2dsb2JhbC9kb2N1bWVudHMvcHJvZHVjdHMvZGF0YS1zaGVldC9ub3It
Zmxhc2gvc2VyaWFsLQ0KPiA+PiBub3IvbXQyNXQvZ2VuZXJhdGlvbi0NCj4gPj4NCj4gYi9tdDI1
dF9xbGpzX2xfNTEyX3hiYV8wLnBkZj9yZXY9ZGU3MGI3NzBjNWRjNGRhOGI4ZWFkMDZiNTdjMDM1
MDANCj4gPj4NCj4gPj4gVGhlIG1pY3JvbidzICJTZXBhcmF0ZSBDaGlwLVNlbGVjdCBhbmQgQ2xv
Y2sgU2lnbmFscyIgcmVzZW1ibGVzIHRoZQ0KPiA+PiBBTUQncyBkdWFsIHBhcmFsbGVsIDgtYml0
Lg0KPiA+IFllcywgSSBhZ3JlZS4NCj4gPg0KPiA+PiBNaWNyb24ncyAiU2hhcmVkIENoaXAtU2Vs
ZWN0IGFuZCBDbG9jayBTaWduYWxzIiBkaWZmZXJzIGZyb20gdGhlDQo+ID4+IEFNRCdzIHN0YWNr
ZWQgbW9kZSwgYXMgTWljcm9uIHVzZXMgRFFbMzowXSBhbmQgRFFbNzo0XSwgd2hlcmVhcyBBTUQN
Cj4gPj4gY29uc2lkZXJzIGJvdGggYXMgRFFbMzowXS4NCj4gPiBZZXMsIGNvcnJlY3QuDQo+IA0K
PiBBbWl0LCBwbGVhc2UgaGVscCBtZSB0byBhc3Nlc3MgdGhpcy4gSSBhc3N1bWUgTWljcm9uIGFu
ZCBNaWNyb2NoaXAgaXMgdXNpbmcNCj4gdGhlIHNhbWUgY29uY2VwdHMgYXMgQU1EIHVzZXMgZm9y
IHRoZSAiRHVhbCBQYXJhbGxlbCA4LWJpdCBJTyBtb2RlIiwgYnV0DQo+IHRoZXkgY2FsbCBpdCAi
VHdpbiBRdWFkIE1vZGUiLg0KDQpUaGF0J3MgYWNjdXJhdGUuIEl0J3MgdGhlIHNhbWUgY29uY2Vw
dC4NCj4gDQo+IEkgd2FzIHdyb25nLCB0aGUgQU1EIGRhdGFzaGVldCBbMV0gd2FzIG1pc2xlYWRp
bmcgWzJdLCBpdCBkZXNjcmliZWQgdGhlIElPcw0KPiBmb3IgYm90aCBmbGFzaGVzIGFzIElPWzM6
MF0sIGJ1dCBsYXRlciBvbiBpbiB0aGUgIlRhYmxlIFFTUEkgSW50ZXJmYWNlIFNpZ25hbHMiDQo+
IHRoZSBzZWNvbmQgZmxhc2ggaXMgZGVzY3JpYmVkIHdpdGggSU9bNzo0XS4NCg0KVGhhdOKAmXMg
Y29ycmVjdC4NCj4gDQo+IFRoZSBBTUQncyA4LWJpdCBEdWFsIEZsYXNoIFBhcmFsbGVsIEludGVy
ZmFjZSBpcyB1c2luZyBkZWRpY2F0ZWQgQ1MjIGFuZCBDTEsjDQo+IGxpbmVzIGZvciBlYWNoIGZs
YXNoLiBBcyBNaWNyb24gZG9lcywgaXNuJ3QgaXQ/DQoNCkNvcnJlY3QuDQo+IA0KPiBNaWNyb24g
c2F5cyBbM10gdGhhdDoNCj4gIlRoZSBkZXZpY2UgY29udGFpbnMgdHdvIHF1YWQgSS9PIGRpZSwg
ZWFjaCBhYmxlIHRvIG9wZXJhdGUgaW5kZXBlbmRlbnRseQ0KPiBmb3IgYSB0b3RhbCBvZiBlaWdo
dCBJL09zLiBUaGUgbWVtb3J5IG1hcCBhcHBsaWVzIHRvIGVhY2ggZGllLiBFYWNoIGRpZSBoYXMN
Cj4gaW50ZXJuYWwgcmVnaXN0ZXJzIGZvciBzdGF0dXMsIGNvbmZpZ3VyYXRpb24sIGFuZCBkZXZp
Y2UgcHJvdGVjdGlvbiB0aGF0IGNhbiBiZQ0KPiBzZXQgYW5kIHJlYWQgaW5kZXBlbmRlbnRseSBm
cm9tIG9uZSBvdGhlci4NCj4gTWljcm9uIHJlY29tbWVuZHMgdGhhdCBpbnRlcm5hbCBjb25maWd1
cmF0aW9uIHNldHRpbmdzIGZvciB0aGUgdHdvIGRpZSBiZSBzZXQNCj4gaWRlbnRpY2FsbHkuIg0K
PiANCj4gaXQgYWxzbyBzYXlzIHRoYXQ6DQo+ICJXaGVuIHVzaW5nIHF1YWQgY29tbWFuZHMgaW4g
WElPLVNQSSBvciB3aGVuIHVzaW5nIFFJTy1TUEksDQo+IERRWzM6MF0vRFFbNzo0XSBhcmUgSS9P
LiINCj4gDQo+IFNvIEkgZ3Vlc3MgdGhlIHVwcGVyIGxheWVycyBqdXN0IGFzayBmb3IgYSBjaHVu
ayBvZiBtZW1vcnkgdG8gYmUgd3JpdHRlbiBhbmQNCj4gdGhlIGNvbnRyb2xsZXIgaGFuZGxlcyB0
aGUgY3MjIGxpbmVzIGF1dG9tYXRpY2FsbHkuIEhvdyBpcyB0aGUgQU1EIGNvbnRyb2xsZXINCj4g
d29ya2luZywgZG8geW91IGhhdmUgdG8gZHJpdmUgdGhlIGNzIyBsaW5lcyBtYW51YWxseSwgb3Ig
eW91IGp1c3Qgc2V0IHRoZQ0KPiBwYXJhbGxlbCBtb2RlIGFuZCB0aGUgY29udHJvbGxlciB0YWtl
cyBjYXJlIG9mIGV2ZXJ5dGhpbmc/DQoNCmh0dHBzOi8vZG9jcy54aWxpbnguY29tL3IvZW4tVVMv
YW0wMTEtdmVyc2FsLWFjYXAtdHJtL1dvcmQtRm9ybWF0DQpJbiBwYXJhbGxlbCBtb2RlLCB0aGUg
ZHJpdmVyIHNldHMgYm90aCB0aGUgQ1NfTE9XRVIgYW5kIENTX1VQUEVSIGJpdHMgDQppbiB0aGUg
Q21kX0ZJRk9fRGF0YSByZWdpc3RlcihwbGVhc2UgcmVmZXIgdGhlIGFib3ZlIGxpbmspLCBhbmQg
c2V0cyANCkJVU19TRUwgdG8gMuKAmWIxMSB0byB1dGlsaXplIGFsbCA4IElPIGxpbmVzLiBUaGUg
Y29udHJvbGxlciB0aGVuIG1hbmFnZXMgDQp0aGUgYXNzZXJ0aW9uIGFuZCBkZS1hc3NlcnRpb24g
b2YgdGhlIENTIyBsaW5lcy4NCj4gDQo+IEkgYXNzdW1lIHRoaXMgaXMgaG93IG1jaHAgaXMgaGFu
ZGxpbmcgdGhpbmdzLCB0aGV5IHNlZW0gdG8ganVzdCBzZXQgYSBiaXQgdGhlDQo+IHByb3RvY29s
IGludG8gdGhlIFFTUElfSUZSLlBST1RUWVAgcmVnaXN0ZXIgZmllbGQgYW5kIHRoYXQncyBhbGwg
WzRdLiBUaGV5IGV2ZW4NCj4gc2VlbSB0byB3cml0ZSB0aGUgcmVnaXN0ZXJzIG9mIGJvdGggZmxh
c2hlcyBhdCB0aGUgc2FtZSB0aW1lLg0KDQpZZXMsIHRoYXQncyBhY2N1cmF0ZSwgYnV0IHRoZSBr
ZXkgZGlzdGluY3Rpb24gaXMgdGhhdCBpbiBNaWNyb2NoaXAsIHRoZSANClFTUEkgY29udHJvbGxl
ciBoYXMgb25lIENTIyAocmVmZXJyZWQgdG8gYXMgUUNTKSwgd2hlcmVhcyB0aGUgQU1EIFFTUEkg
DQpjb250cm9sbGVyIGhhcyAyIENTIyhyZWZlcnJlZCB0byBhcyBDUzAgJiBDUzEpLg0KDQpSZWdh
cmRzLA0KQW1pdA0KDQo+IA0KPiBJbiB3aGF0IHJlZ2FyZHMgdGhlIEFNRCdzICJkdWFsIHN0YWNr
IGludGVyZmFjZSIsIEFNRCBpcyBzaGFyaW5nIHRoZSBjbG9jaw0KPiBhbmQgSU8gbGluZXMgYW5k
IHVzZXMgZGVkaWNhdGVkIENTIyBsaW5lcyBmb3IgdGhlIGZsYXNoZXMsIHdoZXJlYXMgTWljcm9u
DQo+IHNoYXJlcyB0aGUgQ1MjIGFuZCBDTEsjIGxpbmVzIHdpdGggZGlmZmVyZW50IElPIGxpbmVz
Lg0KPiANCj4gQW1pdCwgcGxlYXNlIHN0dWR5IHRoZSBhcmNoaXRlY3R1cmVzIHVzZWQgYnkgbWNo
cCwgbWljcm9uIGFuZCBhbWQgYW5kIGxldA0KPiB1cyBrbm93IGlmIHRoZXkgYXJlIHRoZSBzYW1l
IG9yIHRoZXkgZGlmZmVyLCBhbmQgaWYgdGhleSBkaWZmZXIgd2hhdCBhcmUgdGhlDQo+IGRpZmZl
cmVuY2VzLg0KPiANCj4gSSBhZGRlZCBDb25vciBmcm9tIG1jaHAgaW4gY2MsIEkgc2VlIE5pY29s
YXMgaXMgYWxyZWFkeSB0aGVyZSwgYW5kIEJlYW4gZnJvbQ0KPiBtaWNyb24uDQo+IA0KPiBUaGFu
a3MsDQo+IHRhDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9kb2NzLnhpbGlueC5jb20vci9lbi1VUy9h
bTAxMS12ZXJzYWwtYWNhcC10cm0vUVNQSS1GbGFzaC1JbnRlcmZhY2UtDQo+IFNpZ25hbHMNCj4g
WzJdDQo+IGh0dHBzOi8vZG9jcy54aWxpbnguY29tL3ZpZXdlci9hdHRhY2htZW50L2R3bWpoREpH
SUNkSnFENHN3eVZ6Y1EvZkQ4bnYNCj4gNHJ5Nzh4TTBfRUY1a3Y0bUENCj4gWzNdDQo+IGh0dHBz
Oi8vbWVkaWEtd3d3Lm1pY3Jvbi5jb20vLQ0KPiAvbWVkaWEvY2xpZW50L2dsb2JhbC9kb2N1bWVu
dHMvcHJvZHVjdHMvZGF0YS1zaGVldC9ub3ItZmxhc2gvc2VyaWFsLQ0KPiBub3IvbXQyNXQvZ2Vu
ZXJhdGlvbi0NCj4gYi9tdDI1dF9xbGpzX2xfNTEyX3hiYV8wLnBkZj9yZXY9ZGU3MGI3NzBjNWRj
NGRhOGI4ZWFkMDZiNTdjMDM1MDANCj4gWzRdDQo+IGh0dHBzOi8vd3cxLm1pY3JvY2hpcC5jb20v
ZG93bmxvYWRzL2FlbURvY3VtZW50cy9kb2N1bWVudHMvTVBVMzIvDQo+IFByb2R1Y3REb2N1bWVu
dHMvRGF0YVNoZWV0cy9TQU1BN0c1LVNlcmllcy1EYXRhLVNoZWV0LQ0KPiBEUzYwMDAxNzY1LnBk
Zg0KDQo=

