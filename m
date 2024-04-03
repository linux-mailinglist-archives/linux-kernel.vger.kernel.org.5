Return-Path: <linux-kernel+bounces-129370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E25896993
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E061C25E92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF9670CA7;
	Wed,  3 Apr 2024 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RVMm/EqJ"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2115.outbound.protection.outlook.com [40.107.7.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E396C6FE0A;
	Wed,  3 Apr 2024 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712134281; cv=fail; b=ZCIqpjob0cE3ZB1YfoGt8SbjXapxuveTKUQuAtIm1ne1Hhe5Q42lT8+XeKX4BqUTcwyJLKbcFtL+ZxDbx70536Zunacdph4wQCy44dJpcs3ZexT8AbYs2cqWFMXmw89yOyGZ/d2LtczvawDZtmaFW+i2vjY63HW3SauXVS2JrIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712134281; c=relaxed/simple;
	bh=HJ1Zx9rGVfFkhqgRvlX2XlFeRXjmEDv/2+jlknXLjXQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mIpyO2ISWEWfovWO+ZqIVdbn8FExDQZOPWISOrYrb001brtFS1niKEv+b4JNZPplFZ8L5a/VRd1QOmHs1mnL48k0xMQp9eolVUfwGPZsIbeniIZx+r/C+kFiGLcQwwFSehxSzm7f6/ZPhCplebMOhApG4Wtb+xOnFJlLwul+QnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RVMm/EqJ; arc=fail smtp.client-ip=40.107.7.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2+pHM6z0c0OfRNudOIqt93Xftw7EjGbUTevCpB33q7ks+g8QUBA9kATPhT1Zu3+7iVGFD7M3BXG3mqRPCx2o3tR84Ru47bitmOal9vg60rxouD4Rso0QUE2kXkisZjZgM/uoklr6zqU/ItdBhL6/GZyKmzeKo8lkarAZ9bECk7ix/epX97bNvFf5/tpy4SspUvAquD+JOuDY/jNjLzs+f9soui9wzw1IcNjacun6oy1Yo0zNOk0WBqwzdYhmnxn/Mp2sijPjfn+86UyFI9zKNVAupJQg92vvsvyFRakWg/Dly4mHSr3H/bac7ShfU/GNDc8pJfjvSohh5ZI23tiYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJ1Zx9rGVfFkhqgRvlX2XlFeRXjmEDv/2+jlknXLjXQ=;
 b=UyDqqNev50Lq88qWtTYi9bhKd7ey9wu4WouUYu26wyQf13wsfsSiy7pxHToT6hNR571ZbVKbPeVina2aB7zID/XbMGVlG86mDBTAl+ViBgQUnaUB2PH8V8pTBBKM4h0PTJg0IaepwLmgATeV6EOgeRE1ntTZSJbqluz1ryAxIu/Ttjia7HXBFkaygZcEl5/E+2PUWCh9HvM+X4lQpePqP+O3dphVEQjO0HKpXogqtSvZUqVYVhkKJLjsRNhJnYvgNF2uPCUKyMtBAQLPayXxnsxppFugSk77K14xR9PZHzInPNIjbHGu1AKTeXO6waCG2ukRZr4mxska38aj88FfJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ1Zx9rGVfFkhqgRvlX2XlFeRXjmEDv/2+jlknXLjXQ=;
 b=RVMm/EqJl1SInZRlmB+TT1M3URr2Q6gv2UGev3HrsnKy2VlNlVMNPJMqF1vEO6EsT5PV/eoXKun0xQRBKTXZBI1LrzFIPpcFvAeKMSOZOc6abACuHEfueKcXgVfWGCM/j1kaZ931B4qmZuZj+N5fI3D58sv4Q/C9uhNVQJ/GoCUE2qGHif1uXdNQQr5HMa8gWx8+8nm0sor1NenU3qYllnVUpq+1TdA8wEahpfi7sLM9g2D/rFSeAHXw3oJFoBgDtl7ZYHOivSeP6TIQj/8foHhGHqKx62Ns5ntJ87+0nvRSsPJkKOTPaSAqSdIjRume7idsNY4Xrg7NAwQUd12BEw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB9PR10MB5427.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:334::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 08:51:12 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ab67:6d35:16b1:81c8]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ab67:6d35:16b1:81c8%3]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 08:51:12 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "broonie@kernel.org" <broonie@kernel.org>, "carlos.song@nxp.com"
	<carlos.song@nxp.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "haibo.chen@nxp.com"
	<haibo.chen@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-imx@nxp.com" <linux-imx@nxp.com>,
	"jun.li@nxp.com" <jun.li@nxp.com>
Subject: Re: [PATCH] spi: spi-fsl-lpspi: remove redundant spi_controller_put
 call
Thread-Topic: [PATCH] spi: spi-fsl-lpspi: remove redundant spi_controller_put
 call
Thread-Index: AQHahaGywPuhGlUN9kGEXqyzEc+EBrFWPOOA
Date: Wed, 3 Apr 2024 08:51:12 +0000
Message-ID: <3edc4bb76ce0bc96f90cee789e1d0cfd979d356a.camel@siemens.com>
References: <20240403084029.2000544-1-carlos.song@nxp.com>
In-Reply-To: <20240403084029.2000544-1-carlos.song@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB9PR10MB5427:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Hkx1OGjONSb/sp9rwdcLRtQEKdpnF33We8mbQocoQp/69J0vSXoipfUFwqmy9D+1+3psIy15dN7XjHwfoi4NiL0b0bqWJ8c41ki3LISabTTq/ziACibV2O248srOZVNcSzLhGp77dGxYsWFVDgwTseS8tBABp5fGZWgc+eajVguZ047SrVxMuzC8NxYltsMaFGv+hCSPoxs9jEtI9UJvMYRETz0yY6hcbsvBcZZ6lgv3mRrRTjPHCrA/RcZnKTMZF1PakXDML8RMpUdZWZI7yZZq18jqeD7U7/heqr4FdGyTkeSK4arlC0gQ0sk6mpVUHhvCLTPlIgrfiva8F8GyRs6MAB+dpYxLZbhrTASHCtZu+9piVmy3b+GFCpdkk70OhaaFoLoMWUv7eJ/OZlohOWo20GH45PgeznzgunfpKehGaM5qquPYjMRFTaUwi1xpXeLCwTzdgDvjyTmq4WPjYs2MgTuvCeYfG8IBOpsjED88ZufRiLHm2x4yr7J0kWplmdpCYFP9ia6Un/1N2pAhLVDx3zrWnMFJri1G9BFRAmXLQ7xDimzTPtwOvoEI7P0oNBhh5mC8jLpj5R4J51VHegMlslP3xhyhL7LEX5UHyVY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXhHYjFrVitNOExFVUtHbHZ2RFFUbDlCVHpsNmNJcTNzbDcrOVpxNTVVYWk3?=
 =?utf-8?B?QTJLRGxwK3lQQW40emFndDRncXhxSWx2QTYyMXNNblhxZ0hTUk41M3V6L29H?=
 =?utf-8?B?Z1VieGhnV1NEQUNrTkQxdjRZbUlySGVjVWZKTkk5djZLV29pb3lWRHo0cVpR?=
 =?utf-8?B?SXV1OEgvTStBL1AwOTBTb2src2RUUzdUeUJnZCtUSWdBdSszNjNYOFN4UjY4?=
 =?utf-8?B?VXlGRVhXZDZ5WUQzTEdFaFBzSjdPdXZWcHRIZ0tPbHgxYUVCNW9aa0p4T0VE?=
 =?utf-8?B?S0tLWUNXVDBFRGxVcjUzU0QvNGZSakI0SmlFRHN5cnFDQWpHMFB5Y0lVZ0Ju?=
 =?utf-8?B?alVxNWxzQnBXcUtMMEhTa01odzVZUks2ZGtsUC91Ni8xc2tSUkNPZEVLQUF0?=
 =?utf-8?B?UUV3NHJ4ZzBNdDdNS2RBdmg3N29IYlBpWGswNThXTGY5U1BnWXpUZE1UWFpt?=
 =?utf-8?B?R1NmQ1IrRFhCVTVnTWJ6RHl3QU9QY1EvM3B6MGQvMXpSWUpFRU9Ya05HQUFU?=
 =?utf-8?B?c1lpT2l4ZnpUbmtWWmc0Uk1TaXBnL05SVlVJU1ZScUVwODE3OXFaaVFqUWdH?=
 =?utf-8?B?L2x6OWUrcXVwWCs1RkZpNC8wSUIvNERFc29UY05JcmtZancxYWhmbktzcGhO?=
 =?utf-8?B?Z1RtOHhMVzhBQ1dBcHFYSmZXWTMrNkFDU2pCMXlyb2Nrc2pTbzEwOWJXQzFq?=
 =?utf-8?B?SkZ2Y2lEQjBlRmVzTnV0NU41T296ZlRRN1hLOWxRcWVMd3Z1QXovYkRPZk4v?=
 =?utf-8?B?VlEzTUNzdWhKVlJZTmxmaC9Ld2ZFT0w4eGlkL1kvK1gyMHhkZXJmblZFazEz?=
 =?utf-8?B?NGNad29iSlJkUGkrM2NJMmUxU04wWjNKVE55VTlHT016czRjOTR5ZGRQbUNW?=
 =?utf-8?B?SkVHWDJVODhybUdWR0hVVkZqM3BCeldzcmd4blFmcmFIRzhKSm5IckNUUjRL?=
 =?utf-8?B?cC92YmRrWXBVTFFTMVpmMEdqdWQ3UHROS2gwS3h4TjllTkY1S2I1c2xwbk9N?=
 =?utf-8?B?K1FkamEvMWJIZFRRTnQzQzJPTlhDY2tmOVpvQTlXMzNvRjYzNjFPTEFsOGhj?=
 =?utf-8?B?OEo5OUM5SnVsR1k3aWNlZk1YWFVwTWRPemNRVkRaa3NXRmJCdjRHdTBnUDE0?=
 =?utf-8?B?ZklwdklMTTIyMXNFT0F2OUozNldxdWVoV2tEV09WeUxDcGpnYlpzRU4yVHNX?=
 =?utf-8?B?NGZ1QmJUaWpRL1NrR1JMeEdrbWUxUklxVG1zeHYzaVZSUnlTS2M2UTc2dUlH?=
 =?utf-8?B?UW9zb3R5SktWeDdscnhPYTNTVWkveFBheG1KTVl3VVdOUTdERGdIN1NXTHJJ?=
 =?utf-8?B?bHJnaXdRS1dEN0hQTUZONlhIQ04vWFV0ZjRSc3NyeUc1QVhpenVSM3hqTVpp?=
 =?utf-8?B?ekhuZ2k2ZDZnaHplUzJDUWRCckVNWmVyT0lBWm9YS0hzY0pSNjdVc3BrcW1a?=
 =?utf-8?B?Qi9pTHFWUnBGRGVKbjhYa1AzbVlGc0xVQU1ja0cxQXdLa2doUWp6TjFrRTRM?=
 =?utf-8?B?WDZpYWRRZ2oreGR4UUphODRsa2JOVnVLaTNHNUZNR29BeW16eU8vTE03WFJ4?=
 =?utf-8?B?b0gybmFWY0pJWnNIbnhtazU2RktYeDZ5L0ZxckZ6OWR6TkdvRGl3MmY1TFUz?=
 =?utf-8?B?NmtyeldsSGtEUGp3bzZQL0lJRzdDWDRVR2hkVHBJUm93RmQ0UjBWbGtzMzF0?=
 =?utf-8?B?RUJIYkM1bmdDM0JJVWplNzlseG5zaHZxc1lxWnVDc1R2b0RFNnZ2SGxPazJk?=
 =?utf-8?B?ZlBpdXNEV3lacjBSMmRzVEFuSXhHcnc3QVFTZUJZdU5OdTZsM2d0b2xXYlRn?=
 =?utf-8?B?V1lHeHZtZXVRL2ljREZnYjZaaUVnNE5sRmNQQXFwS2pMa21ienU4QU4yOTh3?=
 =?utf-8?B?ZS9EL1lPY0llWTRyOWhBcmVMS3NRcHh2aVVHMWlPcE81WlorSnJlZHJmbTUz?=
 =?utf-8?B?RVJQUmZMcXphWmRYQ2NaQ3hHUml1M21HdEtkK0pkODE0QkhWMFFpRmRZbDd4?=
 =?utf-8?B?QVA3N09wallSRWNqcWhwbWs0TXBiNk9wa3daMkprM2RTK1h4WmczVUtIWDFh?=
 =?utf-8?B?eXRaaDhCTXp0VTZncFhuQW8xSThIUVNJb2lNUU5Ta1Q0ay9pcFJRR3R5V3Nl?=
 =?utf-8?B?bUYyaWloUnptNzY1UVN5KzJOc0lCU2ZSOGtFMjdpNUxuKzl1ZW1DUHNFTDlK?=
 =?utf-8?Q?ABbrTP1QHOuZse1mVjubenI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23489E3A41A5FC44BD826076019BBF18@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c482565b-61ce-4105-e97a-08dc53bb36e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 08:51:12.3997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8oFpWZtWMQ4g3ymB6c59kPsPjXbsTB56KUEidyYG/lRlrGRUcCM2gwMFq11TTNjvU1AZ8dGyhIQm49nGvH3wj7k+4zyzQKnoc4nXAod/HfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5427

SGkgQ2FybG9zIQoKT24gV2VkLCAyMDI0LTA0LTAzIGF0IDE2OjQwICswODAwLCBjYXJsb3Muc29u
Z0BueHAuY29tIHdyb3RlOgo+IGRldm1fc3BpX2FsbG9jX2NvbnRyb2xsZXIgd2lsbCBhbGxvY2F0
ZSBhbiBTUEkgY29udHJvbGxlciBhbmQKPiBhdXRvbWF0aWNhbGx5IHJlbGVhc2UgYSByZWZlcmVu
Y2Ugb24gaXQgd2hlbiBkZXYgaXMgdW5ib3VuZCBmcm9tCj4gaXRzIGRyaXZlci4gSXQgZG9lc24n
dCBuZWVkIHRvIGNhbGwgc3BpX2NvbnRyb2xsZXJfcHV0IGV4cGxpY2l0bHkKPiB0byBwdXQgdGhl
IHJlZmVyZW5jZSB3aGVuIGxwc3BpIGRyaXZlciBmYWlsZWQgaW5pdGlhbGl6YXRpb24uCj4gCj4g
Rml4ZXM6IDJhZTBhYjAxNDNmYyAoInNwaTogbHBzcGk6IEF2b2lkIHBvdGVudGlhbCB1c2UtYWZ0
ZXItZnJlZSBpbiBwcm9iZSgpIikKPiBTaWduZWQtb2ZmLWJ5OiBDYXJsb3MgU29uZyA8Y2FybG9z
LnNvbmdAbnhwLmNvbT4KCllvdSBhcmUgYWJzb2x1dGVseSByaWdodCEKU29ycnkgZm9yIHRoZSBz
dHVwaWQgbWlzdGFrZSBhbmQgdGhhbmtzIGZvciB0aGUgcGF0Y2ghCgpSZXZpZXdlZC1ieTogQWxl
eGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+Cgo+IC0tLQo+
IMKgZHJpdmVycy9zcGkvc3BpLWZzbC1scHNwaS5jIHwgMTQgKysrKysrLS0tLS0tLS0KPiDCoDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1mc2wtbHBzcGkuYyBiL2RyaXZlcnMvc3BpL3NwaS1mc2wt
bHBzcGkuYwo+IGluZGV4IDA3OTAzNWRiN2RkOC4uOTJhNjYyZDFiNTVjIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvc3BpL3NwaS1mc2wtbHBzcGkuYwo+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1mc2wt
bHBzcGkuYwo+IEBAIC04NTIsMzkgKzg1MiwzOSBAQCBzdGF0aWMgaW50IGZzbF9scHNwaV9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+IMKgwqDCoMKgwqDCoMKgwqBmc2xfbHBz
cGktPmJhc2UgPSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShwZGV2LCAw
LCAmcmVzKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKElTX0VSUihmc2xfbHBzcGktPmJhc2UpKSB7
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSBQVFJfRVJSKGZzbF9scHNw
aS0+YmFzZSk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X2NvbnRy
b2xsZXJfcHV0Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+
IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqDCoMKgwqDCoMKgwqDCoGZzbF9scHNwaS0+YmFzZV9waHlz
ID0gcmVzLT5zdGFydDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBpcnEgPSBwbGF0Zm9ybV9nZXRf
aXJxKHBkZXYsIDApOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoaXJxIDwgMCkgewo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gaXJxOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBnb3RvIG91dF9jb250cm9sbGVyX3B1dDsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gwqDCoMKg
wqDCoMKgwqDCoHJldCA9IGRldm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRldiwgaXJxLCBmc2xfbHBz
cGlfaXNyLCAwLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBkZXZfbmFtZSgmcGRldi0+ZGV2KSwgZnNsX2xwc3BpKTsKPiDCoMKg
wqDCoMKgwqDCoMKgaWYgKHJldCkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ZGV2X2VycigmcGRldi0+ZGV2LCAiY2FuJ3QgZ2V0IGlycSVkOiAlZFxuIiwgaXJxLCByZXQpOwo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9jb250cm9sbGVyX3B1dDsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiDCoMKgwqDCoMKg
wqDCoMKgfQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGZzbF9scHNwaS0+Y2xrX3BlciA9IGRldm1f
Y2xrX2dldCgmcGRldi0+ZGV2LCAicGVyIik7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmIChJU19FUlIo
ZnNsX2xwc3BpLT5jbGtfcGVyKSkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0ID0gUFRSX0VSUihmc2xfbHBzcGktPmNsa19wZXIpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBnb3RvIG91dF9jb250cm9sbGVyX3B1dDsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gwqDCoMKg
wqDCoMKgwqDCoGZzbF9scHNwaS0+Y2xrX2lwZyA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCAi
aXBnIik7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmIChJU19FUlIoZnNsX2xwc3BpLT5jbGtfaXBnKSkg
ewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gUFRSX0VSUihmc2xfbHBz
cGktPmNsa19pcGcpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9j
b250cm9sbGVyX3B1dDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJl
dDsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoC8qIGVuYWJsZSB0
aGUgY2xvY2sgKi8KPiDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gZnNsX2xwc3BpX2luaXRfcnBtKGZz
bF9scHNwaSk7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpCj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGdvdG8gb3V0X2NvbnRyb2xsZXJfcHV0Owo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHJldCA9IHBt
X3J1bnRpbWVfZ2V0X3N5bmMoZnNsX2xwc3BpLT5kZXYpOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAo
cmV0IDwgMCkgewo+IEBAIC05NDUsOCArOTQ1LDYgQEAgc3RhdGljIGludCBmc2xfbHBzcGlfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiDCoMKgwqDCoMKgwqDCoMKgcG1fcnVu
dGltZV9kb250X3VzZV9hdXRvc3VzcGVuZChmc2xfbHBzcGktPmRldik7Cj4gwqDCoMKgwqDCoMKg
wqDCoHBtX3J1bnRpbWVfcHV0X3N5bmMoZnNsX2xwc3BpLT5kZXYpOwo+IMKgwqDCoMKgwqDCoMKg
wqBwbV9ydW50aW1lX2Rpc2FibGUoZnNsX2xwc3BpLT5kZXYpOwo+IC1vdXRfY29udHJvbGxlcl9w
dXQ6Cj4gLcKgwqDCoMKgwqDCoMKgc3BpX2NvbnRyb2xsZXJfcHV0KGNvbnRyb2xsZXIpOwo+IMKg
Cj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gwqB9CgotLSAKQWxleGFuZGVyIFN2ZXJk
bGluClNpZW1lbnMgQUcKd3d3LnNpZW1lbnMuY29tCg==

