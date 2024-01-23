Return-Path: <linux-kernel+bounces-35384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C54D0838FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7152128E6F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A8D5F541;
	Tue, 23 Jan 2024 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="EOfChNuj"
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2089.outbound.protection.outlook.com [40.107.9.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B035EE8D;
	Tue, 23 Jan 2024 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.9.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016372; cv=fail; b=PpnR60DY+wigjCe60JeK537c1XLn6Z4x/3AeGGpVnyjIPfmnHv+KBzV3jHIdHck6JRMm+dFXIntkQe9jt+fhzVnhE0+6dyQBCbs8aopuyoj5sJ6YrFXhcc4Kci3orrUjjibIktYRlWM2Z8sDVyU+ou6uUk64Jw7GCSXFJ01OR9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016372; c=relaxed/simple;
	bh=EP6HLY6ocVKdfCnDHkZQfeZ2TA33j5T2bNTKTr7fvAc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rKmte9wreufAMm7Kl9NrjHBsIEFdLZx2Cnt/Nn6UWBldoiqNxRxkP1lGEnawDd+42qf4ZbMr7zYbxODebPfoxibpbYrZy23fIvTe8rRWrla/QJBWGXga570LRLTDOYfriOXsdiCUPh3xFIcUkAjqP5vUVgXzmQPKHDlDiHH7H0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=EOfChNuj; arc=fail smtp.client-ip=40.107.9.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZaB6W9fU2TrmwClLGM/1aiPtoW+QLNMC/BMNM3aWSzlW44cb2Ok7ZVVSInAfNNQYoXztyaNKPBBm5OiFJGiOVJ6Hqkvhin9mmnb+1c8GAfK0iNgum1iyB0zCR9fZ2Lqd9mj/HU5KtsQ+0q1Yc4SMcMuBI0u0Endj5EZz/G7YHHYMMmrnIDqlo+OwqxzaHjPKOF/DWVBlLeteo9ZNOUHo6xFTNhI5P+sCjBZUfoIh5pE/l3Rh4wP84ap5ItbV6o3rWOAtyF+6ZF84YpSChfLHmdFZ6YOZrGrPzwQAclCPWZj1e2i+N0p1u5E2Wujw9slnIr/CYXTF1iYLNZx85lG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP6HLY6ocVKdfCnDHkZQfeZ2TA33j5T2bNTKTr7fvAc=;
 b=bUrVP1tq/qVcSjn+XzxlFHKrFOfhUrKIjWxHklGNs9kzuDQBNwMR6zWjt+Avn22VInHi3yX03+a7EqlMv39n7ncOT+/WfPOkcc4Y2oUhGm4FJgP3K/G4iyfOEJ5piBPYXRixjJvcyzNrwOwqvrk4FI+rT9o9LycbDBZd1G0YLvgQfGNv9zOGixQ5zZ26NKVWjRahAhbipGCVQmX0WQJwqgT6gdPypMtW8TTkqwGs0LL8I+9M3K3cr0eb8TiV+SM7k26NOD7iGa1iDZnnBwAsdDPEcBoaboxVOE/VwoYrI5jq1uI9lrU4L6z3qeEDfNDoVHdMgEhEBxKAZ6ITUx69kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP6HLY6ocVKdfCnDHkZQfeZ2TA33j5T2bNTKTr7fvAc=;
 b=EOfChNujb3+47RbMeXeDqfcqCofWL9jf/0bllSj4WBjoKpiK/zpmaiq346322PvSFcnEjA0z48UJb0GVKQw4A3UbgAvAebC4Fc4qzQqC3CIsmbd5RPQojVe1noAWNADqr2bSxLxBfLftB/g1MvSMp8Qfulag04TPxkIzmT3SnnaQ+zF7CXy8RgwmQCMpbrbAy9bOXEOVyFncK/hcx8ll9bRDVVnX3f7e6U3aztYU+5F2vx3SKh33RLvAuFXikwzpuloYex28ceLZUnbF93nVgvRMQiWHjBrQOyJZHBxtbAQ7rnxey18QoAba7p1yI6vMBqoFSywCh9esCZXQi684Cg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2811.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:18::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 13:26:06 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9f77:c0ff:cd22:ae96]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9f77:c0ff:cd22:ae96%4]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 13:26:04 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Mark Brown <broonie@kernel.org>, Herve Codina <herve.codina@bootlin.com>
CC: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, Guenter Roeck
	<linux@roeck-us.net>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: Raise limit on number of chip selects
Thread-Topic: [PATCH] spi: Raise limit on number of chip selects
Thread-Index: AQHaTevyXnY9D2HHOkixM7NCrJ+XOrDnYXyAgAACFwA=
Date: Tue, 23 Jan 2024 13:26:04 +0000
Message-ID: <93385fc2-7596-4f66-b0c1-07d7d5c9ed8d@csgroup.eu>
References: <20240122-spi-multi-cs-max-v1-1-a7e98cd5f6c7@kernel.org>
 <20240123120430.75c7ace0@bootlin.com>
 <cefafa30-b78d-471b-83e0-b05060d806d4@sirena.org.uk>
In-Reply-To: <cefafa30-b78d-471b-83e0-b05060d806d4@sirena.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB2811:EE_
x-ms-office365-filtering-correlation-id: 11509aab-cf91-4784-1bd0-08dc1c16d968
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 s8Sts4m2c5Q+aXxlb7j02x3m6khu6OBXw9PR+te13eq+NOIrtqMMAHP+PrhRi9nBcVqZ184+KYdefKbRlR1dCdX1+TxUwVhRG+XgJ3oaE7MOdZ9sTwxPoEmIR6F0rmf6iMplin+n2WTfD1p4YWkhMYBlL5IA5qg4snbrxKo5Wku0qkd5QoZevIW7Y+g6PcNho17U1QYc1qWjKhSff7HcOx7x51xgblYj6b6DutqKJ1wJAhoFw0Trbd25BD6BmD01UgqkqD1G9rW1EIz0pdRT8/TuS8PAVC/fXOzc4OwJBXh/7Y6nHjGJEKTJLO+OPdIdYjvpBbw0z1m7Ys8MzsmwzRwJ1qDcPStYTbelh1c/1VBUJPs9+VVRYQioWEHRvnXa6t3wf6/9EE6Pw7ooCNrGmL5oiewVfiPFW/2GhFo3eqMmDUPp7FLRBQaz91P1ut0EFeNeqouzuMKmqrBhQV8/NGrD3So+Bwxj3qoCq4c5TRqIMX/kbGgyU/jDSfbuRzBBwXwqj+yrQXZw4VbMoyhd4o3a9coWAnjJ5/qrVqakpRfYgAT8yH7JySZknXhWN5kTUV1IkJWVYfpojYKRfnRG4IHrg3gmWJqRLLJBwn3If9WaLXdyDFmHLOdEuITEGCS2ReM9oc0dqhquX0DxBGMXs3W9wdLPInsOt/zanMF36mSMI9e3tsC543msacM8V8hK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39850400004)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(71200400001)(31696002)(66556008)(86362001)(66476007)(54906003)(66446008)(64756008)(110136005)(76116006)(91956017)(38070700009)(316002)(2616005)(36756003)(41300700001)(66946007)(6512007)(6506007)(5660300002)(4326008)(8936002)(122000001)(38100700002)(26005)(2906002)(4744005)(8676002)(44832011)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXFwazcxS1pvSk5ZSUpVU00zaXVOOHpYMjUvUmc3QUdQTjJMR0RjL3hXZVZq?=
 =?utf-8?B?em13RGVHVjhVWHlKRzExZ0RUVnppVU1OZ3JpcG9OSEo4M3RXelNkRkVjenhH?=
 =?utf-8?B?d0tvUWttSVZGVEhBTy9iSE4zaUJmWmlTQWI0cWlqMlhZaFB4OHRBeXFheWVG?=
 =?utf-8?B?ZEFzN1Q0VnFJOExaME8zaEdzQkZBSWY3aWYvTzhpdDg0bXNEQ0N4RUdiU1I3?=
 =?utf-8?B?aGxpbnBLWWozSE1vaStiUDJIeG4xNGhDdjlHQlRzcUZIQ2JDOHlOSEYzYTlH?=
 =?utf-8?B?QXJTeWRjNTYxZHNnQUV0czhUcm43bmlPRGcrWWJDZ3VGSUNZQnV6TmJoUXcr?=
 =?utf-8?B?eFRLWGQ4blFRYU5ibmhna3ZZU3FHcFlvOFdIaXRWbVRiaDI0bDJ5NkV6VFpT?=
 =?utf-8?B?SW1IR3EzRnoxcjAzb1RUZkM2TlYrUEM0Q25xNjFmUXlKK3loVGZUNzJqOHYv?=
 =?utf-8?B?clFEREtKdXhKeWo3S0RKb0V0dkdwRzExeTVocHVqKzRlWXpPbk5JNFVvd2lC?=
 =?utf-8?B?TVhBS0gyYUV2cHIzK0F1TXMyLzcvR05GR3RMVHJ5c0dVaERLaGQ1Yzk3Zzlv?=
 =?utf-8?B?aS9sK2IvQnhUaHhCUHdDL1MxM3QyN3ZJVGtmOEVNcm9scUYxdUdJYWRDd3hu?=
 =?utf-8?B?SkJudUpveTdLNnBYSVVBRGVaOEp1elVkY1BBT214RnZ5cG9BU01iTVBsTXJQ?=
 =?utf-8?B?MXk0RUhRaEt3Wlp0eXhuYURMUS92aDlPVUlYSm1CTlUyeVNyc09DT2RrMW43?=
 =?utf-8?B?NFRnN0I2V1IwNTIvT29PZ3ZZczhTV0JwMDdzK3BCVDJONkVrYlU1UGt2aHhw?=
 =?utf-8?B?MXNzTTZxMFd1aXpLbzVubkJLZlRQVnhPMHg1WGxDOUhMMUt5ZXBKeEFDVjFI?=
 =?utf-8?B?eG5MblNUckEyUDRmQXZFK3BLdkhCM0NLa3JwOFVhNUt0S0dwb2VWa0VkbUlu?=
 =?utf-8?B?QTFTSHZEaXFMSVVVRUJyZ2t0SGhrN3ZNTXc2YmVDa3g0ak9VYkh0M21UVElD?=
 =?utf-8?B?YjhoR1JxSlgrUUJ5Sk12encwZVNLSitsTjU2eXppZDVUaGhxS0g2L0IxdXNv?=
 =?utf-8?B?S1djamVJK25tN1JoVUh3Q2tXZ2xOdVBXNVo2Sko1eTZMeHlPYjlZT2ZnZERx?=
 =?utf-8?B?Tk94S09ZS3RhRjl2ZnE5YWI5OE1pWU5WU0xOajllSllNZGpOdUlhZndYQWsx?=
 =?utf-8?B?ellVc1d4Z1RsYjJvdVFGODVQQm8xY0pHcHRzcXBYdTJSVmFKQlRpVWJyRDBq?=
 =?utf-8?B?Nmdpb3NydlppOEhVKzZtZ0d6UDM0c2lGQ3NYNy95ajUxd256L2xQMkVIRnJM?=
 =?utf-8?B?b2JySVNZRDZqdFNjMndSdUswNEZ2TloyYk5KalZPL1ZGbkllbUdUczFpbHds?=
 =?utf-8?B?L3l1YUZKOVZ0dnJxVnRrckQyNXhJUVhlVFpUL1FoeHVqR2t0dERoRWlCaGZU?=
 =?utf-8?B?VkNrY2JCbVZSd2lHamM2SnVMSEZlWVhRWjVoVE1NakJxZzJENURuYW5wN3o4?=
 =?utf-8?B?UVVzNEc0RlpXVmFDY1hlVUx5Uldnd0NJR1BzSmhiSitReEMzeEhtRjRhU3JV?=
 =?utf-8?B?VWpNN254bTc3aE9sSmhWNGhxUkc2VDN5TU1qMTRGaEszWVpPMDhHVjJZSlJh?=
 =?utf-8?B?bERGY2FxVzZIVkVWM21tSU1RQWx3VkRTc1JLT1QxRTJrei96enRnQW9BcFJ5?=
 =?utf-8?B?TGFQR1h6OFh0SWdCZktCTXRVclVqL3ZpVFFYNkxrTTkrR0xTeHpWazNrM0cz?=
 =?utf-8?B?d1Uzd3ozdEl4SnNzZnVkSVl5V3B0ZjVCUnNXdkZPK3k5TkJWK3hOV0RndmtN?=
 =?utf-8?B?MEZ4VkxUWEQvNkZhSFBidUozZzgyV003L0tPUEZSNUIvY3FMZCtKWk1Ea3pY?=
 =?utf-8?B?UTVJd0tjY2Q2ZWhwcHhJdjNHMHFvY3lMdlR4Zy9GK2psdWVBU0dCMUFOQjEx?=
 =?utf-8?B?cUhzaUF0b01WbEV1cDJzVGpHSVBsN09BQXJKQk9rdGdXbFZCaHkrNXJqbFhD?=
 =?utf-8?B?V1g1R2YrSVdEaFZnb1RCaCs4V1ltbm5Zbi9TZmZITFpUR1lpTzladFF0Y2I4?=
 =?utf-8?B?dmtUaExjNktqbmErSVc3QXZVVGdvcWpscHFMdG1hRTg1NVVQMWhhYmJ4bk5K?=
 =?utf-8?Q?gg31xd15MNJSwunluANBT1db+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B6DD72ED7FD524ABE82E40A77406FD7@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 11509aab-cf91-4784-1bd0-08dc1c16d968
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 13:26:04.1739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PL9T4YNG9YHcqIwngqDVS3SYTQ+jNJFiqBRBvtU+1Z+mKaQsX7tj8cV2sEWKbH3cregHRYxITug8Ah7osNnsUzA2hrJrQs+rT10qBt0e8fA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2811

DQoNCkxlIDIzLzAxLzIwMjQgw6AgMTQ6MTgsIE1hcmsgQnJvd24gYSDDqWNyaXTCoDoNCj4gT24g
VHVlLCBKYW4gMjMsIDIwMjQgYXQgMTI6MDQ6MzBQTSArMDEwMCwgSGVydmUgQ29kaW5hIHdyb3Rl
Og0KPiANCj4+IE1vdmluZyB0aGUgU1BJX0NTX0NOVF9NQVggdmFsdWUgZnJvbSA0IHRvIDggaXMg
bm90IGVub3VnaCB0byBoYW5kbGUgbXkgY2FzZS4NCj4+IFRlc3RlZCBtb3ZpbmcgU1BJX0NTX0NO
VF9NQVggdG8gMTYgYW5kIGl0IHdhcyBvay4NCj4gDQo+IE9LLCBJJ3ZlIGFsc28gaGVhcmQgMTIg
YXMgYSBudW1iZXIgd2hpY2ggdGhpcyB3b3VsZCBjb3Zlci4NCg0KQnkgdGhlIHdheSB0aGUgY29t
bWVudCBpbiBpbmNsdWRlL2xpbnV4L3NwaS9zcGkuaCBpcyBjb25mdXNpbmcuIFRoaXMgDQpTUElf
Q1NfQ05UX01BWCBpcyByZWFsbHkgbm90IHRoZSBtYXggbnVtYmVyIG9mIENTIHN1cHBvcnRlZCBw
ZXIgU1BJIA0KZGV2aWNlIGJ1dCB0aGUgbWF4IG51bWJlciBvZiBDUyBzdXBwb3J0ZWQgcGVyIFNQ
SSBjb250cm9sbGVyLg0K

