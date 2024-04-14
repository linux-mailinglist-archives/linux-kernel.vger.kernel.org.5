Return-Path: <linux-kernel+bounces-143986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2BA8A406D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD1C1C20E8E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 05:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B641BF35;
	Sun, 14 Apr 2024 05:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YFyv5In2"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B021B7E9;
	Sun, 14 Apr 2024 05:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713073336; cv=fail; b=tn0Bm56ydfYUHy91fwio5dLyYwjQ4exsUGMQvgj8xpBiBqKRBMyQFe90yWimdGL6b5CF/ZleuyiVF7drsI8ZtAS87j6SuaFK3ynwSSWLrggY1jIT2Mc+MxuUNMNK45lhXfT6L8YhzMj2ufiy2Azw3GE5rIRs6IX2pI8KkcC5WNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713073336; c=relaxed/simple;
	bh=mU5Ess38ElK9Y/0TsFCFVnr1fQOlsO52u8spmb87X7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DmJYdsp5IvERhDp8lj+axA7p5nolKmFy9xrLPhldPxJ+ZHoFgwAy4YqXXomru9KSt/aBLUFSDaUx3Df5RxlJHuiO9SYqExP+V4jeaacU8yfcPAocAOV4Z5F6nJ2Vq1P/2dpG6e5WHzfim5jSZTRh6yKYEm8Fz7iEoiybGX6IrCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YFyv5In2; arc=fail smtp.client-ip=40.107.8.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtqLqFE3r80gGb9AzbaW3wp/aaT8k9cdPa7EqdvQEvClfULmkEeN2TxKMvHo6UFfrkYjZdaK5VtMDFVqbMqgczpXqBktYZQYI3R9mRaDhqUF5muJeJNApDTsN7TXH8a+EpXdWsrL8ZXAFQLWvey9JaLBGZgTyKzwiSSBbI20/EF5rv9xJKWLn8BZ/XLi0cV7nGG3PglcyXcpcbCo712KPsxLI1UTRCoRP29nD2p9h1V0vxocdnQBnUNGCzw55xoe7Gy3qhcdyhxrha2MUxNQ3vVdCWBNQg7/FzoGSxqbjtTCC4qoHhGkTgfLLTqNzo6X/wZQd1r5WQAD7Nh6PVXYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mU5Ess38ElK9Y/0TsFCFVnr1fQOlsO52u8spmb87X7U=;
 b=VLWmTZzNgWDYsM/k3VrfuxtGds0sNwrfv3jAd/W1dn5MbdZPghM7Bpod/L8U+3qJGhF9q27fpmWeLAT3z+/4qAZ+ULO1vhYOgmM0q1YbG347f0FVKz9IRx4hhht64nQXYqN5oxcwaGL/fYuFlbTitkRtMMYSNDvrZ9zEyigx3pZauEijRPOBdtiy5boOhMWd6p591uMprU1uUqcp66y54iGpiAxTQA08Rzy04m/BKhi22obQITXKW+i3uhPeAJ1qXvbp83dIImP1CFGZbDt46/rdSFYlEikMAw1OfpvsGdYuAhPO7QB2bT4VpBkizfX0zbjKre9dIg8BfZdvrRv8Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU5Ess38ElK9Y/0TsFCFVnr1fQOlsO52u8spmb87X7U=;
 b=YFyv5In2lcZoHzclrCkrB9JI9eY4s46/W5GVZUfQN6hofebgVnoAI1qbgeHoQmRHMVD/uPZ3ppNqVAJAQdgSwuVj5hkL0OTzt7RMrrIjp2GLFI1xtBR4BppDXplJHoSz5cKdrGaBT397M2FdxtKUTDJWYkCDx3PZO2BbadV2LfQ0Eg+dBbCiRkZOLdZY+fVltC4qKROXgNfI23xBjpHOVtCEqTaYOUebaMsam6oMRsk5Aa9yYANz5bQFYAz+LJTo/Vo+pELDh6A4pLvHYqrVRZG0YkrXc5cPxZnGx/Cw15DLo0BfuokUhIQvDXmkFlmIFi2gF1+DRxYNMjI1i+YwMQ==
Received: from DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46::26)
 by AS4PR10MB5645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Sun, 14 Apr
 2024 05:42:07 +0000
Received: from DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f293:fe16:3e4c:18a]) by DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f293:fe16:3e4c:18a%7]) with mapi id 15.20.7409.055; Sun, 14 Apr 2024
 05:42:07 +0000
From: "Haener, Michael" <michael.haener@siemens.com>
To: "lukas@wunner.de" <lukas@wunner.de>, "krzysztof.kozlowski@linaro.org"
	<krzysztof.kozlowski@linaro.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"peterhuewe@gmx.de" <peterhuewe@gmx.de>, "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH 2/2] dt-bindings: tpm: Add st,st33ktpm2xi2c to TCG TIS
 binding
Thread-Topic: [PATCH 2/2] dt-bindings: tpm: Add st,st33ktpm2xi2c to TCG TIS
 binding
Thread-Index:
 AQHajXKMFk8mwsoMoUWVe+Co/8YqIrFl2UuAgAAjioCAAAGcgIAAAwyAgAACgACAAAIhgIAAAJuAgAAAyICAAAGBAIABORAA
Date: Sun, 14 Apr 2024 05:42:07 +0000
Message-ID: <ca685f5b60ac676a72b80b65b73b33d532617acd.camel@siemens.com>
References: <20240413071621.12509-1-michael.haener@siemens.com>
	 <20240413071621.12509-3-michael.haener@siemens.com>
	 <8c13a349-a721-44d3-9e23-2e01f4c2ca4d@linaro.org>
	 <Zhpb2URMxuoilKAZ@wunner.de>
	 <3d08cf54-f58f-446f-977e-21ba65986924@linaro.org>
	 <ZhpfwaIUc0HpfZP1@wunner.de>
	 <889ca65c-c9c7-4658-9c34-5d89774218cc@linaro.org>
	 <ZhpjozjbeWrb0OTl@wunner.de>
	 <bbe365cd-698e-4507-b5e6-d7dd4dcc7a75@linaro.org>
	 <ZhpkzWhOdW3OaJfn@wunner.de>
	 <548b7a66-9a56-4971-89eb-1a147d658f0f@linaro.org>
In-Reply-To: <548b7a66-9a56-4971-89eb-1a147d658f0f@linaro.org>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR10MB2506:EE_|AS4PR10MB5645:EE_
x-ms-office365-filtering-correlation-id: 4e38914a-8cf4-4d2b-8540-08dc5c459f75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 G9vq4ux7WSfuqsvp7LeARDAfhR4B9GowSHPEhzL97Z0MiOMuQx9Ito8kKfrtaxg0ZKwwScmKfNTCmjguWc796KK4mQ4JnK2LAHWb3Dmmphs83IIJZQ3eD/OgspG/WUnS2m+WVv+BqYgaRKyyRfsaGkYWEFV5qqm6qBi7zDum36LBy8KbQnrgHwGMbRsHxRpqGmDaNkTMDDeT3osdzowg1Z4TekZPf/wM2hHaIGTu223OoKp2BQZCCq9bo0yUesaEIeLz6CLa7Pq3aCkvOsO2tokLvwYe+voN1XfErfjvlsezF5ALBEdwkFdAt6iTTVYeJEsD01KzNvvmhOjc9gAs9kEM9C2tkmuY/6z6+YkhNOh2dPn4ZnefLYFfM9ZY8kBnMeW1kEfms9xOq5prL325Qf9IAjNFhlnrbVb2BcsZfeR0tc1rA4o3VOiGINOphOKMulqOhpdL5R2oYVxV+fb/KJuhd5UK2nypkNL5cvBhGYzNPgSGGtNjsjPW3kG/IX5WZf9Yx4vqqgg1oWeqGXpLQ9R0Xn4402fUAgEN+vAFsHPd606KzSgI1ux8HG2vRNcPUSaLQ402obEUP1fmHLrN3rKV/6dqAEOSbP71lBlSXC3BIb2Ax7LYX3j7kItlbgInQHi/SxEhwcZ0nuGMLYwpzf8ZglZkMQVOGg7Tf6DC/o+PZ4kz+a9UYR8YOqGSPOjupZ+3uR1sYGUoW+DTopsUg7S8/E7keeFKjJF3LwN4YiENUQBr9alx2Z0/fUpceroY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODhYYUpzRVhjOVFsUGZlcTlnTTZoVmV1NE5UVlI5OXo2bUhuRTE4V3JaWFFV?=
 =?utf-8?B?cStKU0oxdCt5eXZmeVJydVFKRGs5L2hCYWRyaXJrNVpKaFdSeDZhWUw3UFo1?=
 =?utf-8?B?R2tGVi9KNWV6SVpyVThlaXdLcmNVTWtWWnBseVg4ZVBHVm16NTMwRmN2ZWFW?=
 =?utf-8?B?eWIzTVVRWXNLT1orZVZaTzlvVDY4R3A1NklQSURtM2Y2dmxsUzhuWWVway8v?=
 =?utf-8?B?UjlVVkZvTlpMRkxsY3M0OTI3MG5IL1BvcVBpY09TRTlqZldocXlNVTR5WHJT?=
 =?utf-8?B?ZUxpMGVyTDFScUQ5Mjl0aDl0Yjh0cG9OOFJMOE96TlhFOWEwYWYwRjlvOWM1?=
 =?utf-8?B?NHE5bEhNa2RTczJ3WC85UVplTXUzcklITkNxM0JGL0JYancyanVEZ3ppYmdG?=
 =?utf-8?B?OWFiUTBZbEpoZjJTTFE5OFNaSGhjSUNnZTZmb2UycHRsUzNkdmE4NjdVV3Nm?=
 =?utf-8?B?aXVYdjVJZDhJMGtpZVlqVUVDUDNLeSt1bUxpRU4rMStMZTZ2dVhMVmt0dnpX?=
 =?utf-8?B?L3BCR2lSb0ZZZnVqR0k2dFVOV3V0ZVUvK2o3VVIrWUh1aUVWZUtZNnY5SzJo?=
 =?utf-8?B?eFk1NlI5eHhyOTk2YnJaVHc2Z29GNEhiTDFVeVRkcFZtVFdEOWd6enZkSFdI?=
 =?utf-8?B?dWtDUVlKNTVtZExPU21KdnNUd3djOHcxcFN6bklpYzVudzB1R0c2UHRYOUw3?=
 =?utf-8?B?elNqMFZxRHdzM25hMnkzUVhMOW9IMkZUSHIzNm9vaExhNXY3NzR0NnlqT1lm?=
 =?utf-8?B?aURiWHNzWGtXbHVOclN1WXRBMS9GNElGWnRLK1JKa044eGxSRE5vRk5nNzli?=
 =?utf-8?B?MmJqVHYxWWpaM1hIM1NaVitSbUZ0dlB6SHhaem1hY0c2R0xMUS9xbHJnSjJS?=
 =?utf-8?B?UFRzT1BJSHBrOFJ1NTRVRE91NFRHV3ZES3k1dHNKQVBWQWVFWU9wMElmaDZl?=
 =?utf-8?B?RmZKb1RIcE5PVEhqZWIzTkRmUG1zR1BMVlZEMHV4QmNPRGZ6SURFSEhVZVZK?=
 =?utf-8?B?SEliUUVTeTg3WjFxWUFHKzdzTXBmcVA5T3Q0RS8vMFNIK1d6MmxBWFNzWVNr?=
 =?utf-8?B?eGxrblBXUG50ckJ3MnlzUGRhVGFxMFg1Qnkwa0kwb3hPZmJxbVZ4OU9wbGI3?=
 =?utf-8?B?SUZKT3pBbUpGV21iWkk0NTMwVU4wYWdiWFlyT1hJLy9sazBOOHh4WlR1NVFl?=
 =?utf-8?B?OHRmckNJTTBqRElGbE1WTVB1RlphR3ZLbjNYcGIxVkNvNlE5OWg1c2hPR2ZX?=
 =?utf-8?B?ZWN3ZkF2YTNDUGRRQlRwSWhyTnljTmc5WUcvS1VqRmxnMFhMeWkxWThWY2NU?=
 =?utf-8?B?SStWbWRzV0d0bDEyZzExN0dtK3lqYVd6U21kVjhES1ZyV2ZPd0owMWNrL1g1?=
 =?utf-8?B?Zmk5dW5pc3BwQVFVVVJ3RmhjV1g4UlFRRUpTUXNobFBKVEZPZmJldzlnQ09G?=
 =?utf-8?B?V0dmVW1hSkl2clROa2JUUDgzWmYzd3lhd3A2UGdEdHpIbzFlWmd5RlRYRURJ?=
 =?utf-8?B?L0RhZE1rYmxzMkhrVGNLdUN2em81djFoV053MVNGMzVZMjdkSjNSVzVPUEk5?=
 =?utf-8?B?TmE1bFRNL2R2dkluQThhb0lxeVBHN3NUWFljT1dUNDErTS9vQkFpTkdLRGQ3?=
 =?utf-8?B?ZFUreXVta2VPVVc0aUc1cTV1Wk5nek85d0Q5cGMvVnlNSlNEQ3l0NUhHYTJ4?=
 =?utf-8?B?WWhKSEt5ck1PMUhDZnV6NUplV0szdXYrMG9XZk96NjVHcG9MTVZNTlJYcmFC?=
 =?utf-8?B?R255WEZUTHJWYWlaWC9IL1FCbUxRM3hpVVRzVVFSRW82aFdLRkMvT3RYZjhH?=
 =?utf-8?B?YmVHck4yZlVNTjJWbktBNTloY1FHZTNocm5MZ1VQcVFCQ0g2NDVzTDIwQ2VS?=
 =?utf-8?B?d3U2eDdiY2l2ajVQZWhmRjE2aVBGWitmQ2hvc0N1TTdnSXhqZjJTZ295cmJX?=
 =?utf-8?B?SzdTLzRvWkloOXBzcTg3VC9BSnV1VDFWa2dWbllPQjVKa0xwdCtLUW14NGJa?=
 =?utf-8?B?aWVURlc0cFZFYThQZU5DUHVnQUhGempDQ0ZsSTk1eWtQYlNIaFFHUFVaR20x?=
 =?utf-8?B?dS9JWVMxSmN6OHF0cE83QnBOZGtyNitWYWh1U0V0TDFKeEJuNTM1WlBPSXI3?=
 =?utf-8?B?M1BDckZPRnBvbHVLL0I5REZ1eUF1b2k2RUxNeDRubXRkQ1cwY2hyYld0Q3lv?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20373D48949EB645AE0489991A07BA69@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e38914a-8cf4-4d2b-8540-08dc5c459f75
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2024 05:42:07.7151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5yKJshst7i71n4gQqpiBXvu6rJP/5biqv98jn0w75uH+EQiltqTb/zOcNk42r23O36hzo+Uha9kNPK0jnAZFHwrKS7OmIn/gXAiItKLFKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5645

T24gU2F0LCAyMDI0LTA0LTEzIGF0IDEzOjAxICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxMy8wNC8yMDI0IDEyOjU2LCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+ID4gT24g
U2F0LCBBcHIgMTMsIDIwMjQgYXQgMTI6NTM6MjVQTSArMDIwMCwgS3J6eXN6dG9mIEtvemxvd3Nr
aQ0KPiA+IHdyb3RlOg0KPiA+ID4gT24gMTMvMDQvMjAyNCAxMjo1MSwgTHVrYXMgV3VubmVyIHdy
b3RlOg0KPiA+ID4gPiBUaGUgYmluZGluZyByZXF1aXJlcyB0d28gZW50cmllcyBpbiB0aGUgY29t
cGF0aWJsZSBzdHJpbmcgdXNlZA0KPiA+ID4gPiBpbiB0aGUgRFQsDQo+ID4gPiA+IHRoZSBjaGlw
IG5hbWUgZm9sbG93ZWQgYnkgdGhlIGdlbmVyaWMgc3RyaW5nOg0KPiA+ID4gPiANCj4gPiA+ID4g
wqDCoMKgwqDCoMKgwqAgaXRlbXM6DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCAtIGVudW06
DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gaW5maW5lb24sc2xiOTY3Mw0K
PiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIG51dm90b24sbnBjdDc1eA0KPiA+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogdGNnLHRwbS10aXMtaTJjDQo+ID4gPiA+
IA0KPiA+ID4gPiBUaGlzIGFsbG93cyB1cyB0byBkZWFsIHdpdGggZGV2aWNlLXNwZWNpZmljIHF1
aXJrcywgc2hvdWxkIHRoZXkNCj4gPiA+ID4gcG9wIHVwDQo+ID4gPiA+IChlLmcuIHNwZWNpYWwg
dGltaW5nIHJlcXVpcmVtZW50cywgaGFyZHdhcmUgYnVncykuwqAgV2UgZG9uJ3QNCj4gPiA+ID4g
a25vdyBpbg0KPiA+ID4gPiBhZHZhbmNlIGlmIHRoZXkgd2lsbCBiZSBkaXNjb3ZlcmVkLCBidXQg
aWYgdGhleSBhcmUsIGl0J3MNCj4gPiA+ID4gY3VtYmVyc29tZQ0KPiA+ID4gPiB0byBkZXRlcm1p
bmUgYWZ0ZXIgdGhlIGZhY3Qgd2hpY2ggcHJvZHVjdHMgKGFuZCB0aHVzIERUcykgYXJlDQo+ID4g
PiA+IGFmZmVjdGVkLg0KPiA+ID4gPiBTbyBoYXZpbmcgdGhlIG5hbWUgb2YgdGhlIGFjdHVhbCBj
aGlwIHVzZWQgb24gdGhlIGJvYXJkIGhhcw0KPiA+ID4gPiB2YWx1ZS4NCj4gPiA+IA0KPiA+ID4g
U28geW91IHNheSBkZXZpY2VzIGFyZSBjb21wYXRpYmxlLiBUaGVuIHRoZSBzZWNvbmQgcGF0Y2gg
aXMNCj4gPiA+IHdyb25nLg0KPiA+ID4gDQo+ID4gPiBJIGNhbm5vdCByZXNwb25kIHRvIGl0LCB0
aG91Z2guLi4gc28gTkFLLWhlcmUtZm9yLXNlY29uZC1wYXRjaC4NCj4gPiANCj4gPiBJIGRpc2Fn
cmVlLsKgIEl0J3MgdWdseSB0byBoYXZlIGluY29uc2lzdGVuY2llcyBiZXR3ZWVuIHRoZSBEVA0K
PiA+IGJpbmRpbmdzDQo+ID4gYW5kIHRoZSBkcml2ZXIuwqAgU28gSSB0aGluayBwYXRjaCBbMS8y
XSBpbiB0aGlzIHNlcmllcyBpcyBmaW5lLg0KPiANCj4gWW91IGFyZSBtaXhpbmcgZGlmZmVyZW50
IHRoaW5ncy4gVGhpcyBwYXRjaHNldCBjcmVhdGVzIGluY29uc2lzdGVuY3kuDQo+IFlvdSBldmVu
IHJlZmVyIGhlcmUgdG8gYmluZGluZ3Mgd2hpbGUgd2UgZGlzY3VzcyB0aGUgZHJpdmVyLi4uDQo+
IA0KPiBXaHkgdGhpcyBvbmUgZHJpdmVyIGlzIGRpZmZlcmVudCB0aGFuIGFsbCBvdGhlciBMaW51
eCBkcml2ZXJzPyBXaHkgZG8NCj4geW91IGtlZXAgcHVzaGluZyBoZXJlIGVudGlyZWx5IGRpZmZl
cmVudCBiZWhhdmlvcj8NCj4gDQo+IFRoZSBkZXZpY2VzIGFyZSBjb21wYXRpYmxlLCBzbyBncm93
aW5nIG1hdGNoIHRhYmxlIGlzIGJvdGggcmVkdW5kYW50DQo+IGFuZA0KPiBjb25mdXNpbmcuIFRo
YXQncyBldmVyeXdoZXJlLiBUUE0gaXMgbm90IGRpZmZlcmVudC4NCj4gDQo+IEJlc3QgcmVnYXJk
cywNCj4gS3J6eXN6dG9mDQo+IA0KDQpTb3JyeSBmb3IgdGhlIG1pc3Rha2VzIG1hZGUgKGtlcm5l
bCBub29iKS4NCkkgbWFkZSB0aGUgcGF0Y2ggZm9yIHRoZSBkcml2ZXIgYW5hbG9nb3VzIHRvIHRo
ZSBpMmMtdHBtIG9mDQppbmZpbmVvbixzbGI5NjczIGFuZCBudXZvdG9uLG5wY3Q3NXguIEluIHRo
ZSBkaXNjdXNzaW9uIEkgcmVhbGl6ZSB0aGF0DQp0aGUgY29tcGF0aWJpbGl0eSBpcyBhIGR1cGxp
Y2F0aW9uIGFuZCBzaG91bGQgbm90IGJlIGV4dGVuZGVkLg0KDQpJIG5vdyBhZGp1c3QgdGhlIGZv
bGxvd2luZyBpbiB0aGUgc2VyaWVzOg0KLSBjb3JyZWN0IGNjIHJlY2VpdmVyIGxpc3QNCi0gZGVs
ZXRlIGRyaXZlciBwYXRjaCB3aXRoIGNvbXBhdGliaWxpdHkgZXh0ZW5zaW9uDQotIGNoYW5nZSBj
b21taXQgdGl0bGUgdG8gImR0LWJpbmRpbmdzOiB0cG06IEFkZCBzdCxzdDMza3RwbTJ4aTJjIg0K
DQpCZXN0IHJlZ2FyZHMsDQpNaWNoYWVsDQo=

