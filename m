Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476277E5D88
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 19:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjKHS5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 13:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjKHS5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 13:57:31 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Nov 2023 10:57:28 PST
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58B7210A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 10:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com; s=toradex-com;
        t=1699469847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/TEY6KCImea7bpV4k8P8BRVXguR9uRHZ2AQJfw0Extg=;
        b=WjTdikM77vxhauULJ12a8l2r6fWAqwvMd4QmTpzfi0pc4abl+zus6enxteWwv0B/WwI+d1
        lfMylT7FV+BCK5AES1PwVrZokr5IFfZuV9yg139DZrmtJiN2lW2TrmqI2KCSWfLaesLp9o
        s3ujpstp033fk1nG5QGpTp/a9aF9I0w=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-l7PJ52OSPzGkbT5MtfWoqw-1; Wed, 08 Nov 2023 19:56:21 +0100
X-MC-Unique: l7PJ52OSPzGkbT5MtfWoqw-1
Received: from ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:48::5) by
 ZR0P278MB0872.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.18; Wed, 8 Nov 2023 18:56:19 +0000
Received: from ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM
 ([fe80::4587:99bd:381d:2042]) by ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM
 ([fe80::4587:99bd:381d:2042%2]) with mapi id 15.20.6954.029; Wed, 8 Nov 2023
 18:56:19 +0000
From:   =?utf-8?B?Sm/Do28gUGF1bG8gU2lsdmEgR29uw6dhbHZlcw==?= 
        <joao.goncalves@toradex.com>
To:     "nm@ti.com" <nm@ti.com>, "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: SDHCI AM654 driver delaying boot time
Thread-Topic: SDHCI AM654 driver delaying boot time
Thread-Index: AQHaEnVCf5sjwm2UEkq/5WYQVpvAvw==
Date:   Wed, 8 Nov 2023 18:56:19 +0000
Message-ID: <0e81af80de3d55e72f79af83fa5db87f5c9938f8.camel@toradex.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZRAP278MB0873:EE_|ZR0P278MB0872:EE_
x-ms-office365-filtering-correlation-id: 400136c6-9969-4c17-44df-08dbe08c6506
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: v+GlcgNo+oKQHXIPiV7Pq2iiF6vxe34NPBD2LyAFcrwCFMnrSLMAnxK8NcBYBrTz8oz9zoWbEtNF2rMnRtSoSNbyttksOvhKiSwO6658xkwhg2YjOzI2hBXExk2RZgh0ICAoCQ6WRVdCLX0E324D45oI31N3b4/pLxcH5FSQtKfkwfKZj4vGUj9jeNbB0or0YtlsC1fV5OMl3iGD9COgc5US5xqApn/WzUS6DjUl/Vic+Ab4Z53ANK00s51gI6IAOQJqlvRaM8+BgZE66svdZe7EtoCl7V+gM266SOkA0PN0v5zL3y1e16s58DK8+oCKBbb2cINUO+GdizlVXNv2mn6IV8uewDwHdnU5lBC+R4uJxsxEoDLNRW4e/jEpIlUcQlTriT6EUEbHCgJS+SeTuuiPMv2Os9LL6IYj75orCq5tIgOPjWz7jDjOn4JQRNoDBMEB0ctcFlYVHQGrgODQXPatw5tVy6ucYWYMZmEwrVXL9oNeo36zcbsp05HVJtNKDOAcaOog2/1DTKanv+rO2J9J8feYKnj77Yx06xDEfVm9PrjxUJivULQf0PqpfDkjM/c0YfqexvluH66GWuA+xZiPOm569k5Yb0VBRhy/WhgISRNM1/G/f/rrIEXSlaO4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39840400004)(136003)(346002)(396003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(5660300002)(6486002)(2906002)(478600001)(4744005)(85182001)(2616005)(41300700001)(26005)(107886003)(85202003)(6512007)(316002)(36756003)(6506007)(122000001)(38100700002)(4326008)(83380400001)(8676002)(8936002)(86362001)(38070700009)(71200400001)(91956017)(76116006)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(110136005);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WThORFdwYlU1dlI5eWJtYThZdlhFZ2hvbkpTY2wxRDQ5ai9PbW1aRC9VSURJ?=
 =?utf-8?B?REdmTGtqcmtlSUJlUlVIWURQTG1tTDlLR1JSNTIvSldiY2NsNFBoUGYwRHRE?=
 =?utf-8?B?a3JVYUZITUVoUU00RmJidWI0S2cyRnRhR0VNMGI3MGw1amNlY2tiTUpGNElH?=
 =?utf-8?B?YmRMUUZmREVKZWxFMmZaUGdoMnFVaEJJMG4zUVJCOVNyZDBxaC9PL1IwejJi?=
 =?utf-8?B?T3VvczI3ZXRQZzlzYTFWZjlHcW9SVngzYkZrS3ZPaTdTOE5tdGE4akJ1LzUx?=
 =?utf-8?B?RjlLVHZrYzNmQlE5MmNIOFgwY1I5aTZ6aWdxWDl0clhaWGU2ZHVha3UwVXlG?=
 =?utf-8?B?TlpnUFB2bmNDL3REUnJ6ZGhpNThRcDE3SEp2b0xzSTA0eWlFd28xSGxqQ3FC?=
 =?utf-8?B?NjA5Y29LMjlZVzU2U0ZTcFNCLzBMNkFIMHRrUy8yRXc5YWVzWjRBbHNXc2RW?=
 =?utf-8?B?OS8xdlFkUUZqMEZ3a1N1VFJJa1BweGRnSWp5RXRMY0xmNnFRUWMxZG1xOG1j?=
 =?utf-8?B?VmQwSTI5TGZvWkVicG1wcHpka1FvYSthb1Uzclo2Ly9MbkJVa3pHMWxMNGww?=
 =?utf-8?B?bU4yYlgyMEdlQVNKUnpvQzFOSW5xNTJ2OGJjb0VDZDJHcUNDNlo5VFUvUTYr?=
 =?utf-8?B?dmFwbmsrVFRESi96c3R3UE9CYU5XcGJqejFkSk85QmRxQ3ZBVWd2ekpkRUxM?=
 =?utf-8?B?SFhZVk5YMTlQYlJxdnVuSTAvQ0lYVmZUZ0FaZHZHaXZuRmpqZGRRaGdid1Vn?=
 =?utf-8?B?Si9rS3E1akhaTEd4ZUJmbXhITnFXOHZQYVNqdmdwUkhVMjB5dUFUZm5RZVBl?=
 =?utf-8?B?cnlzdHFNNnBxWDE3Smx3YXR4VE8zQWRGVEh1TGdLUmZkRUNDdmNtSFFXbHZG?=
 =?utf-8?B?NUFkZk5SRGdhRWl5dVlkTVF3QnZZL3BsZVJaMEd0WU5kTk45ZVJkZkJheENO?=
 =?utf-8?B?K05xM2kwNTlwb3NWNitYM0kvdVBoMGlZYW1QUGlCTDFZd2phakFBdGpZL0R6?=
 =?utf-8?B?Z0daWlJobW0xdWhKM2xFWUVqU3Q1bUNaWWMyL25oaWtMU2Vua3Z1RTErTE9X?=
 =?utf-8?B?SDBlbC94bkt5NHllTExrR0xMdWtYcnNTdFB4Wlg4ZyszTytIam1NQ0tNYy9n?=
 =?utf-8?B?ZzdZRHNYWTV4Ymg3N2ptbUdheFhVeW9Cd3ZxZGZDYlZxRmpIK0p0NnQ5bFFw?=
 =?utf-8?B?UzV6UXJTR0lKT3JpQkJzbVVPNUJpQ05Yb3hheitSdVNoZUdZUUExRnpxRXZ0?=
 =?utf-8?B?d2w2QUxjVzAxOWd5d3RobVl6QVR6OE5kenRabUxQOEgvSGNkSXNNdWhFUDJy?=
 =?utf-8?B?U29Vd3lIS2NISjg1Q2J6ajFvOWdLditkR21rWXZLRk1FT1c1QytJeXBDenR0?=
 =?utf-8?B?R2o4RWt0aXlZSXBwdWxnTXk4U3ZOVEt3NU1wWWcrOUtlbXFYcGoxMzJ6RnVI?=
 =?utf-8?B?RVJ6am1FSWdkS0VrRXh2dEJkOEpCTnBocUdIa2d2a3Z2T1JIRkszcFpXSU5L?=
 =?utf-8?B?eFFBNGJnSWt4Q3l1eGI4YVdJRGI4cDBMQVl1S3ZaQ2FOTFc1eDVscCsvMWg3?=
 =?utf-8?B?VzA1SzFNaDVwdTlLeXdQbWhGRVMxbU03Ky8rV1Q5OXF3RDRIRllmdkZocXNz?=
 =?utf-8?B?dGZYRVNmSFYzeDlMYVpaTTN4TFpvdzRqWHB4ZG9SektmN2J5ZXk4TWZvSDNr?=
 =?utf-8?B?Y3hKS2FXaUhKSTJVVHozWG9qbVdEQ0s2cm1WLzBlKzVTVk9oejJNR1dkanNn?=
 =?utf-8?B?R2YxZkpmYTdqSGhrSDMxYUFwY3JlVE9weXJQRS8wT255SjhrSlBXRVEzR2pQ?=
 =?utf-8?B?RThOb2FyVnhFeG9pMWR6d3h6QnB2WHAra1ZieDI2bUtXUkZCYzFVWDlCVno2?=
 =?utf-8?B?ZDdVTjk2dUFicDc4VjNCRnA1bVByTjZhdnhSd1dtWDlQYjVnRnBQQWFKUC9r?=
 =?utf-8?B?czcvU1BCcEFxT2dDWEM0U0hHdTkvNlNIc09Xb2xjQmorcmR0WFhrYnlUdFFi?=
 =?utf-8?B?b3VGSUJPYWp1S01yT2Q4a0RvRmppa3liRlc0V0ZrWlJZaXRvck15djdRUTFy?=
 =?utf-8?B?MEpYUkxtb2hWOE14QzI4emtjTzZ1bm02eGFwNk5wM045akovSm00UDNVcWxC?=
 =?utf-8?B?bWtiTmh5NVprYmdoaTgyYUs2L2dxWGNDZVplb3gxZDZQOWREMFhxM0lVUDdI?=
 =?utf-8?B?TkE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 400136c6-9969-4c17-44df-08dbe08c6506
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 18:56:19.7932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IttWFaqmxNvUnRywxj5VKtn0g1mjPmtzqtLvyV3p+mzP4DrlXjcJM9WL5Rj7IZzHQwTtYOkm0UjjCDXNrX717QP8sbX/Ro3TusXoMaNxMq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0872
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <CB059878777D25489D8CC435742A5AA3@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gYWxsLCANCg0KV2UgYXJlIHRyeWluZyB0byBtaW5pbWl6ZSBib290IHRpbWUgZm9yIG91
ciBBTTYyIGRldmljZXMuIFVuZm9ydHVuYXRlbHksIHdlIGhhdmUgaWRlbnRpZmllZCBhIGRlbGF5
IG9mIGFwcHJveGltYXRlbHkgMS41IHNlY29uZHMgY2F1c2VkIGJ5IHRoZQ0Kc2RoY2lfYW02NTQg
ZHJpdmVyLiBUaGlzIGRlbGF5IGlzIGEgcmVzdWx0IG9mIGEgdGltZW91dCB3aXRoaW4gdGhlIGRy
aXZlciAoTUFYX1BPV0VSX09OX1RJTUVPVVQpIGFuZCB3YXMgaW50cm9kdWNlZCBpbiBjb21taXQg
N2NhMGYxNiAoIm1tYzoNCnNkaGNpX2FtNjU0OiBBZGQgd29ya2Fyb3VuZCBmb3IgY2FyZCBkZXRl
Y3QgZGVib3VuY2UgdGltZXIiKS4gVGhpcyBpc3N1ZSBhcmlzZXMgb25seSB3aGVuIHRoZXJlIGlz
IG5vIFNEIGNhcmQgcHJlc2VudCBpbiB0aGUgTU1DIHNsb3QuwqAgV2UgdGVzdGVkIHRoZQ0KZHJp
dmVyIHdpdGggYSBsb3dlciB0aW1lb3V0IHZhbHVlIGFuZCBldmVyeXRoaW5nIHdvcmtlZC4gSG93
ZXZlciwgYXMgaW5kaWNhdGVkIGluIHRoZSBjb21taXQgbWVzc2FnZSwgdGhpcyB0aW1lb3V0IG1h
eSBiZSByZWxhdGVkIHRvIHRoZSB3YXkgdGhlIHNkaGNpDQpjb250cm9sbGVyIGhhcmR3YXJlIElQ
IHdvcmtzLiBDdXJyZW50bHksIHRoZSBkcml2ZXIgZW1wbG95cyBhIHNvcnQgb2YgYSAiYnVzeSBs
b29wIiB0byB3YWl0IGZvciB0aGlzIHRpbWVvdXQgdG8gcGFzcyBkZWxheWluZyB0aGUgYm9vdC4g
V2h5IGlzDQpuZWVkIHRvIGJ1c3kgbG9vcCBmb3IgdGhpcyB0aW1lb3V0PyBJcyBpdCBwb3NzaWJs
ZSB0byB3YWl0IGZvciBpdCBpbiB0aGUgYmFja2dyb3VkPyBBbSBJIGFtIG1pc3Npbmcgc29tZXRo
aW5nIGhlcmU/IA0KDQpSZWdhcmRzLA0KSm9hbyBQYXVsbw0KDQo=

