Return-Path: <linux-kernel+bounces-43803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C61E8418FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F043A1F25185
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED01364BF;
	Tue, 30 Jan 2024 02:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="q4fR0FNU"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2127.outbound.protection.outlook.com [40.107.255.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A07D364BE;
	Tue, 30 Jan 2024 02:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581103; cv=fail; b=uZXJna5fTmKmfUBgq0joL8nUNGPZCfvQjOLLoRQQrZxBOz+WvlRgP39DJHeJAaT7P4P71NMGo8wYPY9v37+yTBE3FJzjKMJHdoj7qBhlCyDLryFh0Jsgd5JTuHXas4vEzxNdREh9hGPCKZqLEI1iLggUNdDT/ZhYKVP1GAvZVEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581103; c=relaxed/simple;
	bh=Gfw0Sy7gbJoQLmNy6ao3VNh6yCFrhOtVzrBekAz7jbc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y82A1jRd1IHo13aFOCwUXa2/s/9Z6UgYK1bW/rbv8rkAEDHjTOH9RVrY0gUmdFtKjBUxjKjJa5j57c0FjUV2ldl8izqRtUISu+YLTIOhAws+cIyNnUTXhur25S0NqeZSk7cvCPMqoe/gdrGhdrC9GT5U/nfDw8jMYrYscYtdQgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=q4fR0FNU; arc=fail smtp.client-ip=40.107.255.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMKQkXi+lhF/bK3MAd1v0AElnest73pI+z2zyjkb7uwnIZ4PeqPxgMVvwaSY1kusSeTg36Xp3P7wKFIBEbevEae+kuH4FM3yk6h3kYsoE5Lp+DnyOigIUSd9UC2JloIkpIX1Nu6HaU2/THFt4a/DgCA9dCdXvz9IegqZW0S7XaF3Og5+Tbs6ik681D9azNNhUQa2YdXnsWyp8K4AZrtdBeESdLN5jPz3L0v0BjGrKLdkL16x/2tUH61QWt4lRDnoND91BHS5BgY2F1oRrQ1UOE4ShvzsZizLNAzHXJ240ufBoIdwLUztSzjTlxovT4egI5pkut3JfPuFePvML0ysBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gfw0Sy7gbJoQLmNy6ao3VNh6yCFrhOtVzrBekAz7jbc=;
 b=Oj5dQ2exsE+CZVTfTmG263hQJsX+tdO+nHI5426Tpdl/ePbGYVNMqEHdc5nAu2sksVtTlTI6aH+2m76hZOkbbGzkdz1K6UJFsGaECo5u6vFZqspMo0R99r4CFiEVgL1G6ikZDWTgA7xJvw6kw4+Q1vE636hl/ejcBwA1riY18gzNSyuITbFlQJXujXJN+SvvA1XrXee73I3XuEULUwP9Q1QmBHAsJA5/rnDx3Umy/VNfS9ArT2Zwk+Fz7uJr0eu7NmVnY2X73oT7IlA8aPxAbzkDUHhYthfmi+Vi7Q5E/yFvxkvQ6nEx+OmtxY2U2d9ma2sSAZ0pDMnUFSRiL/mGRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gfw0Sy7gbJoQLmNy6ao3VNh6yCFrhOtVzrBekAz7jbc=;
 b=q4fR0FNUUdE4nwB+Bq3gTt8ozj0EogHFuz6a7MH4Wb/H+ZwuI8Nsd11c11HExsMDsRZ7SUGtUn6I5C3bOTR2bwBQkQFiBbnSGzBHNtxVs5/2fdawZRUQVPFsi90gwfm4wDMY7yUxGP0OiWXHLEJPYJ5Q2cyjj9Ru56zP2JmLysMJZySV8NqqAtqz0NPCzD3V6twwSxfUwFXEnNHt0qtEcu6BatEVyUkiOG3qcPBYU+gcdM9334lIaIk75GldH1V+A8DMLutSfch/8pAw6kVOWRxoeeOId25Y+2tUh+oEaqezfCJwxU29zn8t6mc/jVOZjaoE10p9isOB7OLrRsmR4w==
Received: from TY0PR06MB5470.apcprd06.prod.outlook.com (2603:1096:400:264::9)
 by TYSPR06MB6575.apcprd06.prod.outlook.com (2603:1096:400:480::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 02:18:17 +0000
Received: from TY0PR06MB5470.apcprd06.prod.outlook.com
 ([fe80::adf8:c18e:5c1b:55d0]) by TY0PR06MB5470.apcprd06.prod.outlook.com
 ([fe80::adf8:c18e:5c1b:55d0%5]) with mapi id 15.20.7228.028; Tue, 30 Jan 2024
 02:18:17 +0000
From: =?gb2312?B?zfWzzLjV?= <wangchenggang@vivo.com>
To: Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>, Yanteng Si
	<siyanteng@loongson.cn>, Pierre Gondois <Pierre.Gondois@arm.com>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Lukasz Luba <lukasz.luba@arm.com>, Ingo
 Molnar <mingo@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/doc: Update EM API em_pd_energy to em_cpu_energy
Thread-Topic: [PATCH] sched/doc: Update EM API em_pd_energy to em_cpu_energy
Thread-Index: AdpTIlkEoaNA5a/QQv+Kh73b2vob0g==
Date: Tue, 30 Jan 2024 02:18:17 +0000
Message-ID:
 <TY0PR06MB5470E30E86989E8CD84FCE0DC47D2@TY0PR06MB5470.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR06MB5470:EE_|TYSPR06MB6575:EE_
x-ms-office365-filtering-correlation-id: eec01805-3700-48c5-d82d-08dc2139b8e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2M2YUhpzuD20L6c/XFzRFJB8omKRr+3VeWn2gM3E575o32EYtp+Rj8sYXpXlO9mGA+GJl/4rjEjtCJp0VV6yh9HoGkXNrUGnPDUT9DalVq+bYeRtN281ckaHN8UiyNrrbGMX7WnK5JdNvPlFug0rgP7/RRAEjzNpvES9n14cozcj9TbyWL9E2T6+6x4BR+vgkTJZS0M5R1ZHGWhDqk78+YWgzDtRGr9W0CEzSmmxgtZK/Grh9eoBP4VmAcrJhwX6x4R1hTNhGmo+ah0v9sjM31znOwiJKcEdcsDUmWIK0q8kYzgUpYI6wdezUl/4ADBxMLylh1BSyQQKsj1fSAIFYZumNR/3PRZb85cuI8a+fk/tGalqJMcNpzefdzHngSOwUcVxDEGiQp5/1A2myNMbLTLLd4345H1XnrNDPa08rT2HjevHjnm/C3uRqc+VmguYIzATemty6bEde4UE7hPqDMNUMlFLEJ7e4q8yozvgk+0IWdqPEFT4LYW17rG3m6KQGqvyPBd1BvWVpXnZtdKp9TabC5yFvXUuv/Kn8tRot1WNyu0r2Nsvvz6NHut7nvdtWpLjGbDjXALioIqK7nNAyCxggC06wI5xZROgDkyEQ6W0/jn2emstx7RlbkbwhzBFeEA+0pHexFvZ0zPIKFnVUQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5470.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(55016003)(26005)(83380400001)(6506007)(7696005)(33656002)(86362001)(38070700009)(85182001)(921011)(7416002)(8676002)(41300700001)(5660300002)(8936002)(9686003)(66946007)(38100700002)(122000001)(66476007)(2906002)(76116006)(66556008)(71200400001)(66446008)(64756008)(478600001)(52536014)(316002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VCszUzdha1VWZHFVUzRmalUzalZ0VXI0MEFpV3VnV2JwUndTTW9KcDNwU0p5?=
 =?gb2312?B?VU9mUUZiY3MwRGQrT1lVZHBvdWZtMGtRUEN6VU0vYWRnS1B2bmwxMEZIcERN?=
 =?gb2312?B?TFdOUHVjTjVxTjV1ZXZ3cTdLNjJJYkNzQUs5QnpaendtcXVoRHlFUkZEVURn?=
 =?gb2312?B?VmFDbGpxa040bkQraHp6dlZhdVovT1ZpY0E1RjRvSVdhTS9lZm4yaFM1VTNw?=
 =?gb2312?B?czhLSnFJNGxWYnhuUXBIUlNqNHRJZ01LNlVBeFZzWUkwNnBSYkJiajY2eFB3?=
 =?gb2312?B?SU9rMkttWXU1VTJxKzdhdUsraHpnOW9LZUdzZCtRd0tScHZBekFLT0VuZmVP?=
 =?gb2312?B?RDlENitDbEhmcS8xa3JWa2pEVUkrN1hmMXZNOUhyZHU2YmRGeklRSkYza0pC?=
 =?gb2312?B?dkQ4ODF4emg3Mzk1YURlS0J5aHl1dXFYOWpJTVR5aWVCZ2ZGMytrR21aSnF3?=
 =?gb2312?B?VmlpcXN0dEwwSk9KZFJJK256MUIxZXJaZi9NTmczTm9uSDl0NEx3QVQya1lm?=
 =?gb2312?B?UkJJOVhiREdoY0hVM2NmYTgrcTl3UkxkNzVUNEx3NDdIZ0h4M2xxZzBtcmZF?=
 =?gb2312?B?UTVKQXhsSG5CNEpQV0lwN0ZvT0tLVDFKQ1pBeXNVS0ZTMU5lZFp1TDJKTEt1?=
 =?gb2312?B?a1RyVDdXd25NMlpzaTJvTURlU09LSThMRk4zSnFub0NscTc0U2hzazZTYW10?=
 =?gb2312?B?OGY3N1RId2hqWk5NL0hFWTBnSDcySXFGNGN2WEZvQ2JGMlVSR3phRnkwSGk4?=
 =?gb2312?B?ZHlXMzZxTmVsT0p3T0dqOG53YXYyM0E0aTA0OWorQW5GR3dhczkzVWJRYnBs?=
 =?gb2312?B?eUhUQUtPR0w1WVNCT1ljZWhBb2JhU1ZWWitlUndNYzJDSFYvOWNjNzg4b3lK?=
 =?gb2312?B?TFJnb1Y3NjU2L1BVc3hXUy9abXI5UjRpbHoxUWNRZi9EWkErREdrVGkwZkVv?=
 =?gb2312?B?TUEyVlFCY0kwRktubUw5eEFKaXJQUUI4Zm8xUG9veDVVR0NVTy9rYXRvYXg5?=
 =?gb2312?B?bGdsYVduNnd2bmNMaFROT3ppL3FHWkNXL1lWTElhcE9zMjA0Um56UGdxK1BP?=
 =?gb2312?B?dlZwNGJ2S1RPc1YyTldMN3JtTzdnNmMzeVh0NUpkSDh0Z3VlTzYxQjlyRHpa?=
 =?gb2312?B?VnZkRndGa2d2UFNPTGozUXBwdDdra1NJeFQ4YWMzMnEyb3dXTWJEeE1jdXBp?=
 =?gb2312?B?SlFUdjRPeGVGL2xxQVJDQ3lKekhNK2pJZWZtYmhWdFhIbXd0OUlHY2Nsc24y?=
 =?gb2312?B?ZC9BalVOZHdySjBrbDc0YkZrNjdEazNMV041M2FDV1VoK3NrcmRNa00zTmRM?=
 =?gb2312?B?ZXRPNEhodlJLM2ovK3h3TWl5dzFSSVcwblBRR2k4RThEQll0YzdxOFRlME5N?=
 =?gb2312?B?dy9mUnZTUncxZkN5ek9iZGY4ZzkrRVBRaGNjZG9SQ1N1S0liSXJHdjhVZzJj?=
 =?gb2312?B?c21xZXp6amtpMUhFaFZicThXQlVWeE15TGxuZ3pzSjNNZ0doUlBjRXhPK0lL?=
 =?gb2312?B?TkZGRG9qbzdtLzhGTkx1SXFaRHB1bDJPUGdoangwanJiZVYvWExhVlRzVFkv?=
 =?gb2312?B?WkoydGlOWElnZTVYT0NGMjd3cFM4UnNiTmdYZ1FiN1UyVk1jSUp4YmgxQ2dT?=
 =?gb2312?B?emhXd1pXYUpUSllBK1lGdGRBSldVaFZkY1RvZ1hKa2NabGlXZHhNS0h2dTM2?=
 =?gb2312?B?QTgzK3l3ejkxbThxYkFtbGxEQm5XTW10T2NlYlFjNit0TldtRURSNC9YQWUw?=
 =?gb2312?B?QjYzYkE2RHEwOFNwOUdSUTJFUExWZi9UMlB5eGxxTHVkZXpKcW1namIrc21T?=
 =?gb2312?B?UTBVZ2VwaDJvaGdMNDZKRUhsRW92cGZQSjd3SXBTT05zR3BQc3A4NlZFQzRU?=
 =?gb2312?B?QzFjcnNoNTliM1ZoNkpyTUhhSHZXd0FJdDV1eEF1Nmx1Tm95RncwVHFsQzJN?=
 =?gb2312?B?Njd2YVhRNVRaYWt4UERDVFdRTzQyNkdsdVhMRGhjTXQwMDZxTS9JU21YUU83?=
 =?gb2312?B?WkxMa3BxUjVUdEdPM1hQay80UzBtY0MwNDZuMU9abHQvbXR2ZGZWdkNkcDFD?=
 =?gb2312?B?UlY4OHh1TndLVVFrWklWQmdUMmw5TFlhVHFEWkRCb3hTWkxYZUNWenBsZm5H?=
 =?gb2312?Q?60N4=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5470.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec01805-3700-48c5-d82d-08dc2139b8e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 02:18:17.8107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k73g/cVgkoNAN6SRjnN/JnqLz9dvk0f1DwF8Liwr0uH411hSUcO+xn3+CwPNM4Ma+IkcYsI6JlilkJMdX9+ulA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6575

VGhlIGVtX3BkX2VuZXJneSBmdW5jdGlvbiBuYW1lIGlzIG9ic29sZXRlIGFuZCBub24tZXhpc3Rl
bnQgbm93Lg0KDQpTaWduZWQtb2ZmLWJ5OiB3YW5nY2hlbmdnYW5nQHZpdm8uY29tDQotLS0NCiBE
b2N1bWVudGF0aW9uL3NjaGVkdWxlci9zY2hlZC1lbmVyZ3kucnN0ICAgICAgICAgICAgICAgICAg
ICB8IDIgKy0NCiBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9zY2hlZHVsZXIvc2No
ZWQtZW5lcmd5LnJzdCB8IDIgKy0NCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vc2NoZWR1bGVyL3Nj
aGVkLWVuZXJneS5yc3QgYi9Eb2N1bWVudGF0aW9uL3NjaGVkdWxlci9zY2hlZC1lbmVyZ3kucnN0
DQppbmRleCA3MGUyOTIxLi44NGIzN2EyIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9zY2hl
ZHVsZXIvc2NoZWQtZW5lcmd5LnJzdA0KKysrIGIvRG9jdW1lbnRhdGlvbi9zY2hlZHVsZXIvc2No
ZWQtZW5lcmd5LnJzdA0KQEAgLTE0MSw3ICsxNDEsNyBAQCBpbiBpdHMgcHJldmlvdXMgYWN0aXZh
dGlvbi4NCiBmaW5kX2VuZXJneV9lZmZpY2llbnRfY3B1KCkgdXNlcyBjb21wdXRlX2VuZXJneSgp
IHRvIGVzdGltYXRlIHdoYXQgd2lsbCBiZSB0aGUNCiBlbmVyZ3kgY29uc3VtZWQgYnkgdGhlIHN5
c3RlbSBpZiB0aGUgd2FraW5nIHRhc2sgd2FzIG1pZ3JhdGVkLiBjb21wdXRlX2VuZXJneSgpDQog
bG9va3MgYXQgdGhlIGN1cnJlbnQgdXRpbGl6YXRpb24gbGFuZHNjYXBlIG9mIHRoZSBDUFVzIGFu
ZCBhZGp1c3RzIGl0IHRvDQotJ3NpbXVsYXRlJyB0aGUgdGFzayBtaWdyYXRpb24uIFRoZSBFTSBm
cmFtZXdvcmsgcHJvdmlkZXMgdGhlIGVtX3BkX2VuZXJneSgpIEFQSQ0KKydzaW11bGF0ZScgdGhl
IHRhc2sgbWlncmF0aW9uLiBUaGUgRU0gZnJhbWV3b3JrIHByb3ZpZGVzIHRoZSBlbV9jcHVfZW5l
cmd5KCkgQVBJDQogd2hpY2ggY29tcHV0ZXMgdGhlIGV4cGVjdGVkIGVuZXJneSBjb25zdW1wdGlv
biBvZiBlYWNoIHBlcmZvcm1hbmNlIGRvbWFpbiBmb3INCiB0aGUgZ2l2ZW4gdXRpbGl6YXRpb24g
bGFuZHNjYXBlLg0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhf
Q04vc2NoZWR1bGVyL3NjaGVkLWVuZXJneS5yc3QgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9u
cy96aF9DTi9zY2hlZHVsZXIvc2NoZWQtZW5lcmd5LnJzdA0KaW5kZXggZmRiZjZjZi4uMDNkZWRj
NiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3NjaGVkdWxl
ci9zY2hlZC1lbmVyZ3kucnN0DQorKysgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9D
Ti9zY2hlZHVsZXIvc2NoZWQtZW5lcmd5LnJzdA0KQEAgLTExOSw3ICsxMTksNyBAQCBFQVO4srjH
wctDRlO1xMjOzvG7vdDRxr264rT6wuuho9Tau73Q0ca9uuLKsaOsy/zKudPDxr0NCg0KIMjnufu7
vdDRtcTIzs7xsbvHqNLGo6xmaW5kX2VuZXJneV9lZmZpY2llbnRfY3B1KCnKudPDY29tcHV0ZV9l
bmVyZ3koKcC0ucDL4w0KIM+1zbO9q8/7usS24MnZxNzBv6GjY29tcHV0ZV9lbmVyZ3koKbzssum4
90NQVbWxx7C1xMD708PCysfpv/ajrLKis6LK1LX31fvAtA0KLaGwxKPE4qGxyM7O8ceo0saho0VN
v/K83MzhuanBy0FQSSBlbV9wZF9lbmVyZ3koKbzGy+PDv7j20NTE3NPy1Nq4+LaotcTA+9PDwsrM
9bz+DQorobDEo8TiobHIzs7xx6jSxqGjRU2/8rzczOG5qcHLQVBJIGVtX2NwdV9lbmVyZ3koKbzG
y+PDv7j20NTE3NPy1Nq4+LaotcTA+9PDwsrM9bz+DQogz8K1xNSkxtrE3MG/z/u6xKGjDQoNCiDP
wsPmz+rPuL3pydzSu7j208W7r8Tcwb/P+7rEtcTIzs7xt8XWw772st+1xMD919Ohow0KLS0NCjIu
Ny40DQoNCg==

