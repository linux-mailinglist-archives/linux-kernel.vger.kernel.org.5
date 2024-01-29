Return-Path: <linux-kernel+bounces-42512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF10840267
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DD61F224E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EF455E7F;
	Mon, 29 Jan 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="evJlvbdt"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040155E4F;
	Mon, 29 Jan 2024 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706522894; cv=fail; b=nIBZSMDiWfPsJAnN0PAuLhdrlSBX+S7Z045zZZlPr5/IoatLV39JHkHPrfs5cJv0Fr6PU2+kBVWqVvylHpCdWN32G5KHMYV0EjiEi2njPu7aR1K7GFosPw2Cf90AMt8p8pR0zvdCCP2Pkvuv2sXT7biv5HdPAEGKFCXJUXac2YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706522894; c=relaxed/simple;
	bh=PZR+BSENitqcN5naSh5Tatsb+f1GrOJDuXupzVSNlYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YkQDOY+qF26hVyI5eRBKhEzqtxfEvwL/WivMuNBzSv9NtMec/DzlWZFpgmVLMDzNU/6gY85ArMGYjFFAYBY2v9VaWDKjShvtWJpAnKELXWzvYnKPI/Iv+gV0XcCFktXwjHEJU+It4A4ju6xn3JkKfZLjRTRWrv2VWWd6ktBlTYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=evJlvbdt; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9DD61EPmnTjimMdnfrcnp8dzJ6gShBjvdOJmgskSUVz9ZknneUmdT0V/CV3mtfhcjKHVg50d8M7G4y2fXzTZ6qoydN7oCAzppFzSg9zBRBGEQLwE3k7rblq6ddCNl3U8eWBMV20IJW2v86w45Py6j7Ak5cHz0PrciDumPZwbP7PlImtqhSFlHoErP5pTzdBv5pFJgGVEp5VpMzPDhdHtUZtAFyJzSv5s/a206WPXcqHD8l1jlpbh2YwdNgtFOz0NsJaO2SE+eydrokTDAVdJ4jWYj5MwACaJK7Qm0L5ZrCUR9SaBt2p5m2HiF/ua5YGV+3jzuxoKNV2T3tWF59XQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZR+BSENitqcN5naSh5Tatsb+f1GrOJDuXupzVSNlYU=;
 b=TQpormM4lw0gObYQj0g9HlMe0DQpdDxgol0Lp+9GP0S28WBkVvH+DfChJZZtHzSPPtuY8ac5nB0iGJ8osxTg4AoKhTIY7Oyus0kGJUmXa6kajNTt2xWjaIZ4kH8zthTEFB9wqOGzc1n6QO7qh1oeTa/sIu4ZFQUREZnfz6w/X+s7GBBaetJzxGXQr1gpcb5FTS8EP1xW7bylt+Dg4iKpQ5BDRnneKdX2tITuktSaXRDmF325cgwZoqTU+EiYFsZfF5iGzc1MZ7Uvvd2jU0xQxhfjRBwDvuzHlqMW+rhPF6duznFjfJu2nVMtD3a9+WLngwb26OBTH1J8TEg1jJyCCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZR+BSENitqcN5naSh5Tatsb+f1GrOJDuXupzVSNlYU=;
 b=evJlvbdtBCsRybsC/fDi8BQR8kZ+x+QPRMQDXm0qM4Vs9nHmEyuDbyDS7DVzXWn0bdogwBfrfzp3Ba1PTx/e8I/MurwX273UrxySUOhhApStVEzJIKiCigaiDW2xoEcZrCox7zbchLlANyzWctUV3wNYQOgNsxrZasq40tyxA/o=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 10:08:08 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::aea:c51c:23ee:6b49]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::aea:c51c:23ee:6b49%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 10:08:08 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Dan Scally <dan.scally@ideasonboard.com>, Kuen-Han Tsai
	<khtsai@google.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>, "Mehta,
 Piyush" <piyush.mehta@amd.com>, "Paladugu, Siva Durga Prasad"
	<siva.durga.prasad.paladugu@amd.com>, "Sayyed, Mubin" <mubin.sayyed@amd.com>
Subject: RE: [PATCH] usb: gadget: uvc_video: unlock before submitting a
 request to ep
Thread-Topic: [PATCH] usb: gadget: uvc_video: unlock before submitting a
 request to ep
Thread-Index:
 AQHaDVvg8JAIX7opVUGPeVND2R+OwrBm7bwAgAlqngCADGtuAIABEQoAgAAcxwCAVT1twIANsP0AgBA2vOA=
Date: Mon, 29 Jan 2024 10:08:08 +0000
Message-ID:
 <MN0PR12MB5953C70F29987CCDF3EAC67DB77E2@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <80a05f4a-eaae-4db1-9604-c5eed9ff594c@ideasonboard.com>
 <20231108114848.794045-1-khtsai@google.com>
 <d040f84a-b55e-4b1d-85c1-b6cec6554198@ideasonboard.com>
 <20231117014538.ro6bo2ho2jgl7l6s@synopsys.com>
 <20231117032832.6k4msq2vlp56asho@synopsys.com>
 <MN0PR12MB59538FF4FF9C753EB9264E21B7692@MN0PR12MB5953.namprd12.prod.outlook.com>
 <20240119021520.757vpt3oeig4hws2@synopsys.com>
In-Reply-To: <20240119021520.757vpt3oeig4hws2@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DM4PR12MB8572:EE_
x-ms-office365-filtering-correlation-id: 6e787a7b-4b9d-43f0-7cdb-08dc20b23137
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QxK8cobDtPj2QVbL7IovLJl3skGj0o9qR0JjaCVWy6UbzQDSC+neIgHKKpSFHoUPnuDlt5FWs/QpbOTH/v/Ub0eZxZCF+TJx/677nZ2CKfrE5+n3hxyMmzI+Y4wcZ3JS1GCbg20c9F3lUwWgKAqH7QIT8OGZlThqkCH/4kXLsHaGpwXJcF81WbzwLlr+J6P4gM4xNM2yl9wrKEdA7MYrLl6tggbmT1CVRZsbwbX9VuWUFidloP5K2y86sbB5AW/NSbtTECV9lqVLCw3QSG6kRGPbHrpPNr8TQ3YcRknPPjsuX7XS0ShXBmOlaRs0Jf9QM2wKIrBsqu/pP798HhluBSbSPAl1sQsoU5uaDqhhlILoEGZuO2L2mgWT6yxvPmMzSSuLJWwYjzV+wuijOfXRs48Kp+cjzUJ+UO+uva05E5mSLVW9rVJjMLcceC5SGJF7ZDy7d0xrCKRnabyglYcIXQ/+VbI493V5wSnHXUrUWu/mhM9zXEEiMQWN4JfdnJxVJmKIi0penBHN19k7M4IyNx4lrNmljabmi1WA2sxdMDX7CRyNoWQZrxqmbbuv+dT+EvPKfE0HdVsEJ5TGJv2mG7/AUWfsP0cB59WLIxpHu47xwl2uhPQYn5HcKLQZ1Wwl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(83380400001)(26005)(7696005)(6506007)(53546011)(33656002)(86362001)(38070700009)(5660300002)(52536014)(41300700001)(4326008)(8676002)(8936002)(9686003)(38100700002)(122000001)(66556008)(66446008)(76116006)(66946007)(54906003)(64756008)(66476007)(6916009)(71200400001)(2906002)(478600001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEx0amZNMFMySCtjQnB0M2VxU0k4N0tsQmNISG5vbXFrZDNnSDRsaGJKRmds?=
 =?utf-8?B?TFB3V3U4ekRJMDhGUzlIQVBrR1UxYWx6TThPTmhEM2tXTVFUYjhRODh5WDFW?=
 =?utf-8?B?WVM4VE1PSG9MaXJ5RUpQQWZ3bm80SHJhWVNPWHYyZEVUSVQyeDg1b2laNS9X?=
 =?utf-8?B?SVBJTU10UTJiU25uZDgxRFJOSHlTZi9ZZ2ZZVWs1U052eXpsOHNrRUZoUEZw?=
 =?utf-8?B?S2h0K2NXS1RpR1Z1MDh1YjkrcFRZQ0hsdGV6dUtUMTcvcGlrOWNRV0RnZkFN?=
 =?utf-8?B?ZDk4eExvMGwycWtWVm1jTmJWS3BJV3JLTjV3WEhPakdFRkp6T2l2NjVjaUNH?=
 =?utf-8?B?Mm1SbXdDd1NqVXZ1ZlZua2NvaVlDZG1jRml5U3V3UkxYaFdTYUd2aS9tTEd1?=
 =?utf-8?B?QllqZjdBU2p6UWlEc3NaanZHd2hJSlpCb3ZvUUhTb0h2Vkl3RmdhRVFKSVEr?=
 =?utf-8?B?VE1nVkorSUUzMkU5Ym9CRHpUdWFUOUtFOTBYZjgzbFFiYnVNWFNORWJ4VnQ5?=
 =?utf-8?B?bWtXUmtzYzhxbG9xSjFHWTZDdmloc1pwMjI5UVg4WXpVVnFDZHExSnBGWkUv?=
 =?utf-8?B?clhpV21IUmhYY01vNWVrdVhJMTBQczF0bnpGZDhJdHpOeGJhaDM3UnVSK2JI?=
 =?utf-8?B?Q0NUTytBeXFTdjU3bGE5WW9UNzBoMlVaM1dESGFLMXJRbGt3TC9YQkU2TnU5?=
 =?utf-8?B?dUdOYWwzOUh0WmdPTFJQaG5qZWtwZ0xTcjBseVR2REFpMysrR2FtUUNuUTEr?=
 =?utf-8?B?VW04QUhXR0pRRVZibXM3R0NPS0s0d0l6bS9zQjFTY0pldGZWODVBQXp5TW1Z?=
 =?utf-8?B?c0lmaWpUYjl3dHp4ZVZ4c05JUkFCbG5rK2pQN2p3Smh6WDBzNTMrTW9lN2tu?=
 =?utf-8?B?S3Vub213SkVweWV1aFUxUnJna1hNZE9hTjR4SXdjQ2dUaXFCNURjNE9GcDNr?=
 =?utf-8?B?U1I1ZW1CZDVlQkhFN2RQdDd4RTdBOFMxRGZhS05XaUJ4MmIxTWtHYUY0ZCtF?=
 =?utf-8?B?bVRyc3RYd0FraWFWRERCWnM2dXoxclBLNGE4MmNkNlJ5a2hxaXJpa2R1dE12?=
 =?utf-8?B?R0RFNG1ia2JFR3NYTTF4YkhrYm9yd2FSTTBwb21HN2c1QkJXczlibGlvajBk?=
 =?utf-8?B?MVlIMUpTbnd2dXlJV3diWjNPYVZkSTlXK08ySERSNXBpSExpMUZmc1ZXUXhu?=
 =?utf-8?B?R085c2VDMnJxM3NUMjZmckxrTGhFQmVtWSt5TS9KelhlR2l4NFdrM3M1d01z?=
 =?utf-8?B?elIzNjlqMzUxODdQS0g3TXhFbUNRVXk3OVI3U3FUQ0NQb0MxNTNsbWNnWjk0?=
 =?utf-8?B?RVVKOXgzN1NyQ25iZlJwN1BQRU9VUWhHVURwNkxaMlNFTFpWZzhiOUVDVEhT?=
 =?utf-8?B?bW1PeWZVZUF4ZlgzTjFCa0lGNkpUWG56VHRhRFppcEd1VkpUSkRYcllRVUhV?=
 =?utf-8?B?b1dvR0hGL2QwblBVS1VNMi9QMTU2dzV0SG10RmxDLzcvaVViems0R3lMOEVF?=
 =?utf-8?B?Z3BDRE9yVWJIODgxWXByekZ2SFpDQkdibmpJWmRjbERvUCtYVGg3dUhiZXk0?=
 =?utf-8?B?bGtuWTEyZ2d3c0ZYTW9qZmJ2RXlrVTVaTjJYcURGYk5KSlVXdUJIMlJwTmhB?=
 =?utf-8?B?WlpuUnovY3lzc3FNajJvcFZXbllBN09oWFVrTVJVYTYxT09YVDQ4Nkh5R3Z1?=
 =?utf-8?B?UWszTUJzbUxWL0RncHVSMjUvVFlxa0hsK3NCN1E4RFFOQzVOcUlPZkVINEYx?=
 =?utf-8?B?ZVJCVUd3ckRRODlUaHlENS9yc2VEaFhIamJnR0o5dlpjQWQ4aFZjQ1cycWZO?=
 =?utf-8?B?cGZJNjhDV0dyYk82dmFTLzFmcTl5TW9tS0Z6dnlZd0RXZkg3STJqV1pUZCtv?=
 =?utf-8?B?ejJIQTBnMjM0UDdNTVBBQXJrVkNiZ2R1YXJidHFOQ3dEbHlZeW1oQVdDRU9v?=
 =?utf-8?B?OEFZVWVpYlZ4WDQ0Yzd3SC9DWDk3K0hUckt1SFZYRTFSajR6dWY5U09odmQ2?=
 =?utf-8?B?bjd0TGRqWW5FN3kxTUNRd2tZbFFiYzVNWXJ1ZWFVdFYzWnNaNzNvRU0xMTBQ?=
 =?utf-8?B?UmkrVFR0UHZGcnpKSXlZYTN6SzdrVytETFk0ekJLVnZqVXBuNkYwWlo0cVds?=
 =?utf-8?Q?g3uY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e787a7b-4b9d-43f0-7cdb-08dc20b23137
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 10:08:08.1710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPyCdA0cVsfC44HbGEkfR9ng1RPsAecs26veER/5yI2zepU9bqUS/q34eewFkiHM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaGluaCBOZ3V5ZW4gPFRoaW5o
Lk5ndXllbkBzeW5vcHN5cy5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAxOSwgMjAyNCA3
OjQ1IEFNDQo+IFRvOiBQYW5kZXksIFJhZGhleSBTaHlhbSA8cmFkaGV5LnNoeWFtLnBhbmRleUBh
bWQuY29tPg0KPiBDYzogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPjsg
RGFuIFNjYWxseQ0KPiA8ZGFuLnNjYWxseUBpZGVhc29uYm9hcmQuY29tPjsgS3Vlbi1IYW4gVHNh
aSA8a2h0c2FpQGdvb2dsZS5jb20+Ow0KPiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgbGF1
cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgU2ltZWssIE1pY2hhbA0KPiA8bWlj
aGFsLnNpbWVrQGFtZC5jb20+OyBNZWh0YSwgUGl5dXNoIDxwaXl1c2gubWVodGFAYW1kLmNvbT47
DQo+IFBhbGFkdWd1LCBTaXZhIER1cmdhIFByYXNhZCA8c2l2YS5kdXJnYS5wcmFzYWQucGFsYWR1
Z3VAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdXNiOiBnYWRnZXQ6IHV2Y192aWRl
bzogdW5sb2NrIGJlZm9yZSBzdWJtaXR0aW5nIGENCj4gcmVxdWVzdCB0byBlcA0KPiANCj4gSGks
DQo+IA0KPiBPbiBXZWQsIEphbiAxMCwgMjAyNCwgUGFuZGV5LCBSYWRoZXkgU2h5YW0gd3JvdGU6
DQo+ID4NCj4gPiBUaGFua3MsIFRoaW5oLiBJIGNhbWUgYWNyb3NzIHRoaXMgdGhyZWFkIGFuZCB3
YW50ZWQgdG8gY2hlY2sgaWYgeW91DQo+ID4gaGF2ZSBzb21lIGZpeCByZWFkeT8NCg0KSSBoYXZl
IGFkZGVkIE11YmluIHRvIHRoaXMgdGhyZWFkIGFzIGhlIGlzIHdvcmtpbmcgb24gdmFsaWRhdGlu
ZyBiZWxvdyBmaXguDQoNCj4gDQo+IFdvdWxkIHlvdSBtaW5kIHRlc3QgdGhpcyBjaGFuZ2UgdG8g
c2VlIGlmIGl0IGZpeGVzIHRoZSBpc3N1ZToNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBpbmRleA0KPiA4ZDE4
ODFhZGNkODAuLmY0MGM3YjkxMDVjYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC0xODA4LDYg
KzE4MDgsNyBAQCBzdGF0aWMgaW50IGR3YzNfcHJlcGFyZV90cmJzKHN0cnVjdCBkd2MzX2VwICpk
ZXApDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgdm9pZCBkd2MzX2dhZGdl
dF9lcF9za2lwX3RyYnMoc3RydWN0IGR3YzNfZXAgKmRlcCwgc3RydWN0DQo+ICtkd2MzX3JlcXVl
c3QgKnJlcSk7DQo+ICBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9lcF9jbGVhbnVwX2NhbmNlbGxl
ZF9yZXF1ZXN0cyhzdHJ1Y3QgZHdjM19lcA0KPiAqZGVwKTsgIHN0YXRpYyB2b2lkIGR3YzNfZ2Fk
Z2V0X3Jlc3RvcmVfcmVxdWVzdHMoc3RydWN0IGR3YzNfZXAgKmRlcCk7DQo+IA0KPiBAQCAtMTg3
NCw5ICsxODc1LDI3IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF9raWNrX3RyYW5zZmVyKHN0
cnVjdA0KPiBkd2MzX2VwICpkZXApDQo+ICAJCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShyZXEs
IHRtcCwgJmRlcC0+c3RhcnRlZF9saXN0LCBsaXN0KQ0KPiAgCQkJZHdjM19nYWRnZXRfbW92ZV9j
YW5jZWxsZWRfcmVxdWVzdChyZXEsDQo+IERXQzNfUkVRVUVTVF9TVEFUVVNfREVRVUVVRUQpOw0K
PiANCj4gLQkJLyogSWYgZXAgaXNuJ3Qgc3RhcnRlZCwgdGhlbiB0aGVyZSdzIG5vIGVuZCB0cmFu
c2ZlciBwZW5kaW5nICovDQo+IC0JCWlmICghKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX0VORF9UUkFO
U0ZFUl9QRU5ESU5HKSkNCj4gLQkJCWR3YzNfZ2FkZ2V0X2VwX2NsZWFudXBfY2FuY2VsbGVkX3Jl
cXVlc3RzKGRlcCk7DQo+ICsJCWlmICgoZGVwLT5mbGFncyAmIERXQzNfRVBfREVMQVlfU1RBUlQp
IHx8DQo+ICsJCSAgICAoZGVwLT5mbGFncyAmIERXQzNfRVBfV0FJVF9UUkFOU0ZFUl9DT01QTEVU
RSkgfHwNCj4gKwkJICAgIChkZXAtPmZsYWdzICYgRFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEKSkg
ew0KPiArCQkJLyogSWYgZXAgaXNuJ3Qgc3RhcnRlZCwgdGhlbiB0aGVyZSdzIG5vIGVuZCB0cmFu
c2Zlcg0KPiBwZW5kaW5nICovDQo+ICsJCQlpZiAoIShkZXAtPmZsYWdzICYNCj4gRFdDM19FUF9F
TkRfVFJBTlNGRVJfUEVORElORykpDQo+ICsNCj4gCWR3YzNfZ2FkZ2V0X2VwX2NsZWFudXBfY2Fu
Y2VsbGVkX3JlcXVlc3RzKGRlcCk7DQo+ICsJCX0gZWxzZSB7DQo+ICsJCQkvKg0KPiArCQkJICog
VG8gYmUgaW4gdGhpcyBjb25kaXRpb24gbWVhbnMgdXNiX2VwX3F1ZXVlKCkgaXNuJ3QNCj4gKwkJ
CSAqIGNvbXBsZXRlZCB5ZXQuIFNpbmNlIHRoZSBjb250cm9sbGVyIGhhc24ndCBvd25lZA0KPiB0
aGUNCj4gKwkJCSAqIHJlcXVlc3RzIHlldCwgZG9uJ3QgZ2l2ZSBiYWNrIHRoZSByZXF1ZXN0cyBv
biBmYWlsZWQNCj4gKwkJCSAqIHVzYl9lcF9xdWV1ZS4gU2ltcGx5IHJlbW92ZSB0aGVtIGZyb20g
dGhlDQo+IGVuZHBvaW50J3MNCj4gKwkJCSAqIGxpc3QuDQo+ICsJCQkgKi8NCj4gKwkJCXdoaWxl
ICghbGlzdF9lbXB0eSgmZGVwLT5jYW5jZWxsZWRfbGlzdCkpIHsNCj4gKwkJCQlyZXEgPSBuZXh0
X3JlcXVlc3QoJmRlcC0+Y2FuY2VsbGVkX2xpc3QpOw0KPiArCQkJCWR3YzNfZ2FkZ2V0X2VwX3Nr
aXBfdHJicyhkZXAsIHJlcSk7DQo+ICsJCQkJZHdjM19nYWRnZXRfZGVsX2FuZF91bm1hcF9yZXF1
ZXN0KGRlcCwNCj4gcmVxLCAtRUlOUFJPR1JFU1MpOw0KPiArCQkJCXJlcS0+c3RhdHVzID0NCj4g
RFdDM19SRVFVRVNUX1NUQVRVU19DT01QTEVURUQ7DQo+ICsJCQl9DQo+ICsJCX0NCj4gDQo+ICAJ
CXJldHVybiByZXQ7DQo+ICAJfQ0KPiANCj4gQlRXLCB3aGF0IHdhcyB0aGUgZXJyb3IgY29kZSBy
ZXR1cm5lZCBmcm9tIHVzYl9lcF9xdWV1ZSgpPyBJcyBpdCAtDQo+IEVUSU1FRE9VVD8NCj4gDQo+
IFRoYW5rcywNCj4gVGhpbmgNCg==

