Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49D7769275
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjGaJzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjGaJzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:55:18 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142B71BC1;
        Mon, 31 Jul 2023 02:54:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK6cJMELj9iWxC/fposouBEUArAEyyZFRHqhAPPu7N/6lV792zFoYdA5f7YTJ8AzQxVBzVm3pCDXwByq2YVZfAmSFfZ453SXn7LWHxIADnpJWus1ynugQE4XPNyOTkumqM7mg9uQaDOz2jgEjkvkGgxDk00dwsA7wWB/mz/aNLgLx3rXGHn4pSRfTr2bdTi15kZZq0qst/v9n3Uat7NYFpQrX6ppfKAywff0CoeRzwfpoGZqc56JgmOw+NNuLDOp2xHOXa7y2lirkQEz2UXFLEOm/SU7Z04fypyHbKvb67tPJrbNTGrzyyc4QnekK/0+kEHOqFoDNqrkmmR3jpIKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUQIKyQcyY5OfowyIgBIy8V/x7Nzp7Jp/02mNOxnAzw=;
 b=QJB+eV01Buvgwu0rLqwvNiiQAD9m2kAc1HuL0FIYjY7yAC3JG7y9epV3BXv3LndCf7kee1M3P8cEUtvvnB0l/Hh0z9Ox3TaQNpXWMr+NR+UHdYtRqUqNfLQP7yvGrICccXwU89BD3CXJA+bHrbo4tJtr4xJ6FTE5qF5oCc773P7gzFNOegOr9IgGomUEm0P2+zQX8oipwL/uZ1weazsu9LAf6qUnsB3bUQzV2YVdMteTilCPMI5fZLWN76esiS/VGkZZmaIVzTgZxqL+eTG9IrbJAgcaP+26LkmRKY8B/p/5UHbq4HCGhmD00bF45+FGZAhzbjjgXVVq0larefuxcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUQIKyQcyY5OfowyIgBIy8V/x7Nzp7Jp/02mNOxnAzw=;
 b=JRE+UH9qPoR/nVsgGEZsICMZVF6YFG8nUzae0nlcoKS1d0QOiHveMufA5WQtrmNbaTpGiuTuSeK5Rr1i+rzXL5t9HWcH2+Sv7TyGqmmojFXdkkALogONe6Bn/cfZkaPj0/YzBWTpDYA1xLfuKCrxradDCmBuQVKk/15ojXY5awIHjpw5mOQd8cXvhvwLqJk3Z+xlUPAARYs2VxkaSh12zgV4Qp1Eq2jvLknphpD/8cjKmcL7TAAlTL/RIgRniKtyc8iSuVuoPpk6BdsaoXvQHUza4AORQEQa88/mgCWG6l9uyMiI/JA5vGWjFqXD9renT7mzbsuO14lNGX97WD2jcQ==
Received: from BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 31 Jul
 2023 09:54:48 +0000
Received: from BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::5fa6:31e7:e6fb:3beb]) by BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::5fa6:31e7:e6fb:3beb%4]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 09:54:46 +0000
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
CC:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] hwmon: (pmbus/mp2975) Fix PGOOD in READ_STATUS_WORD
Thread-Topic: [PATCH v2] hwmon: (pmbus/mp2975) Fix PGOOD in READ_STATUS_WORD
Thread-Index: AQHZw5B9uXDBK89VZ0SfeBirFhIhHa/TofOA
Date:   Mon, 31 Jul 2023 09:54:46 +0000
Message-ID: <BN9PR12MB53819FE51F98D80CE6F5A724AF05A@BN9PR12MB5381.namprd12.prod.outlook.com>
References: <20230731092204.2933045-1-Naresh.Solanki@9elements.com>
In-Reply-To: <20230731092204.2933045-1-Naresh.Solanki@9elements.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5381:EE_|SA1PR12MB8724:EE_
x-ms-office365-filtering-correlation-id: bce83862-a24b-45ab-7375-08db91ac2c6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b/uQdeHl1XOulBA2YHa2fTXlZ7EVQLgk9BDGGV31sBkbxfzA00R/3WSXUU9cb2oiqSvwc/ll2oSsWGH0BurinyehdFzDLYz+JpJBQtdn5WzoNnu3pN7S4qA8ymuuZ/LaMfXr3fGNnVZTYfpFDXDhgMka8qoftrxFQQiA15Yv+nOfdhBDFX6hjJPMTK/dlH5jNm7R87D7svOPgh9hbPFoME/SXNoBZW6C2g4cMj0eiMMdbSlTfm/Z2qvnmrMCZ1AM3M60TY6xq4lKwMUcw3IYZIEHOYXN9xC+sB0JKt3+YQ+FwFOt0WKOburc1xSO4UEko0THWBdPjISMHx5TGT7oTcAqCL9G/kfWXwTl+tHJyarjfn+ro8kQCLqCYHdSQXxcSGLyfpQ4lia7RNlL7w1juwgf2f+mFLlrWd2Vlfyw/cPwWY1061CHDn4xkjP4ioDyjy3vsdaF/5w2eH6cMpO4Y3MZgq7qZafvTpfpgDg0qQ+z0U3yTnP/MuZLpzRBgC2hFtSeQoqRCeApZnLqKBEimK8hOxglgZ0g61zsMGu3HSmqBUosyo9kYnfZCBZZdNwXqnDcihCZSFUOrIMz4g1nDed3mRZGDvflgwc/56rgNcX67IPYPKligwmPf278rBbJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199021)(53546011)(71200400001)(33656002)(478600001)(55016003)(6506007)(186003)(9686003)(7696005)(83380400001)(2906002)(66476007)(122000001)(4326008)(76116006)(66946007)(38100700002)(66556008)(8676002)(8936002)(316002)(110136005)(86362001)(66446008)(5660300002)(52536014)(64756008)(54906003)(38070700005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWpCekNBejFVSjNJYlFxbWw1bS90UGE1Qmp2QmlFSDcwc2hyVGNQS0plZmMv?=
 =?utf-8?B?SjI5MHk4ZHg1UTAwZlFSSFhBNVNkVEtnNXJraHg3ZE1QaThiRW11cE0xOS9a?=
 =?utf-8?B?RDgxNGJCaStNQTJKTGM0UnVJYzlRbW1Wb3IrWEpXblBacU02elhkQTl3ZWtJ?=
 =?utf-8?B?cXYwOGRlRlFrY2JDc3ZpdkpoR2RId3MrKzcyeXZ6WCt2Vm9MaGx1dkdMT2t4?=
 =?utf-8?B?MmUvRnBEWFNnZWtuWVFnbWtXaDNod1U2MXQrRTduRSt6bUdvZTBhcncwNjNY?=
 =?utf-8?B?bVc2S1BzM2xDK2xXc2czdUJDZ3lPNHhPbXl0SGpBenN3My9jNDVUWU9JUEJL?=
 =?utf-8?B?YmdmMmdML0lLWkF3UnkwR0hOZ2tpZFFYWloya3Z3d01IYU9KODFlSU0zM3k0?=
 =?utf-8?B?RHJsZmtQTEZEbmo0ZjhrUmRweTNiNDVKZlBNUDIvLy9iRUFmTkdjenYyY08y?=
 =?utf-8?B?cUdJS1A2OW5KSUx5djJWdDBNQ1puRFlIak5RN3ZGRGxLK0txY2RrMU1KWkFu?=
 =?utf-8?B?ZXBBNGZmMm52OExGV01XTGFqSy9UcVR2RFZHUTQ4RGt1eUh6Tmo4a0l6eG5H?=
 =?utf-8?B?SEhqY2VjYkhVTEI0ZEorVEtpSWhhN0J0bkRuMzBmYWN1ZFhtandJaEV0c2gw?=
 =?utf-8?B?aFIvUVBkVEJCYjNmcHBrbjV2SXJtaDZGMnZzRlVhVW5ZUzV3WGRSSEJOOUJM?=
 =?utf-8?B?Z2htMHhGekFVSzVtbVZHWnNzYkVQQk1XczRYc0tSUUdlcTZML0M0T3BQOEZW?=
 =?utf-8?B?TTdFQlVzQ3RKNWI1ZW50VHdvR24xZjJtT1dHWmhkOStxKzIwT1BWbEJUdnpR?=
 =?utf-8?B?OGdIc0lDc3MwV2VuWVFST0xvU1lINjR4TWQzdVhPOWZ6dXpGSmNUdGZNSW55?=
 =?utf-8?B?ZHgrYnVtYW9ibXhhRGpFMVp2R1pRNk16RVVoVGdhbHlKbkkrMHpPT1F0ODVS?=
 =?utf-8?B?UzlBVjJHenVVbmFyTmNERlVDNEc4YzVuaVpjbWxOT3VCV051MHBxVTVkRVJ3?=
 =?utf-8?B?REI0em1iSWRMb0U0TFdFVUh2YmxCcUVrNGtNVkc5S3I4enJsdGZTSkJTUlIx?=
 =?utf-8?B?MS9KanlLSXRKRUZsNlVwaEl3cGZBb1NaYW9Zc1VIdXNaK1pWTTdMTVVJUmJk?=
 =?utf-8?B?RXBOaFNNWHN1c2JWL1hNZjZYNkwxZW1BTUFiQnFmM1lWbEZRbm1LMGVROTNZ?=
 =?utf-8?B?NTVjbkFHYVRhQ1IzZ05Wd1FUQUNXcHJGekoyR3RCK29mNFA4UDFzemdUSUJN?=
 =?utf-8?B?NUpzdFRhbUJ4K1ExcVF3Zk9WN0xKY1Y1SSthbktCbHk5WWVYem1SRU9lSHRE?=
 =?utf-8?B?VFNKMFNZM0tKQnBlM3RxWkpScE81OFplV3V4R2xrNzJ2VTZFVEFBTjRFSExQ?=
 =?utf-8?B?T2dycE9PK2RnLzc4NUJudjltaDVYV1krb2FUejA1LzQ5N2t1WU5zV3Q5LzJo?=
 =?utf-8?B?bXdnOFYvMkNIZkNCRzFvRDh1bVpZWS9EMldxZFFMekJXYldrZm93djZtd0Nz?=
 =?utf-8?B?Q0pLZHlIRDM1NHJWUmhPUHoyaTg4Rkd0VFJyQ1VqcnJOcExqTUEycU5waSs2?=
 =?utf-8?B?VlNsamFFeDBIczhpWDFhZ3hKTW5ITG5OeTdkbElUL1lQcStDdlhsOEo2ZjVE?=
 =?utf-8?B?ck8vZjZKZUNoYmlYcXg0Ni8zaHFyZjhHWGpCM2lrNTRlZUl4Y3NDcXJ6KzR0?=
 =?utf-8?B?a0h1QVpTb1o1UUkxdHNtckE5Y0E0VFlTRi80MTdvLzY3WFNZUm5ieTcvamJu?=
 =?utf-8?B?aEVmR3k2UTIrTVlVS0xTNjhwRktiSEZJb2FuOHdON2ZTWVpWZGlKbE1NZFpD?=
 =?utf-8?B?cDJONkhFSDZsQUVEdTM3eEVVd1ZIWkNiQlQ0c1g0KzJQdjc1T1JJeXJqSG82?=
 =?utf-8?B?SXNtYk9UcW1acWYxc0llMVRMWUxZcUFQNnFTSG5QV1dLNm05K3Z0YSt2Slh4?=
 =?utf-8?B?OW1RTlhkbnByR3FNMm84dlVIeE16TDNZMFcvWXBVRXk4cWl0aDJlWHhtU3ZQ?=
 =?utf-8?B?WVYvbStpT2p3eWFtV2huOGw1c2V0Tll4M2FTT1NlaW0xSjlWRkpIOHl2QnMr?=
 =?utf-8?B?TTRrUFdqSkxhUm5tellvZWJ2R1pLTy8xOXN6dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce83862-a24b-45ab-7375-08db91ac2c6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 09:54:46.8348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8XKzr2lgFv8NEMClJu4hfq4yDLJcsOOPk7Aqe/6tU1AiIHloE+UJ4AQimT6mop+eEeRJZ9AsuiXbm1fXjPuFlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFyZXNoIFNvbGFua2kg
PG5hcmVzaC5zb2xhbmtpQDllbGVtZW50cy5jb20+DQo+IFNlbnQ6IE1vbmRheSwgMzEgSnVseSAy
MDIzIDEyOjIyDQo+IFRvOiBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+OyBKZWFu
IERlbHZhcmUgPGpkZWx2YXJlQHN1c2UuY29tPg0KPiBDYzogVmFkaW0gUGFzdGVybmFrIDx2YWRp
bXBAbnZpZGlhLmNvbT47IFBhdHJpY2sgUnVkb2xwaA0KPiA8cGF0cmljay5ydWRvbHBoQDllbGVt
ZW50cy5jb20+OyBOYXJlc2ggU29sYW5raQ0KPiA8TmFyZXNoLlNvbGFua2lAOWVsZW1lbnRzLmNv
bT47IGxpbnV4LWh3bW9uQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIHYyXSBod21vbjogKHBtYnVzL21wMjk3NSkgRml4
IFBHT09EIGluDQo+IFJFQURfU1RBVFVTX1dPUkQNCj4gDQo+IEZyb206IFBhdHJpY2sgUnVkb2xw
aCA8cGF0cmljay5ydWRvbHBoQDllbGVtZW50cy5jb20+DQo+IA0KPiBNUDI5NzMgJiBNUDI5NzEg
cmV0dXJucyBQR09PRCBpbnN0ZWFkIG9mIFBCX1NUQVRVU19QT1dFUl9HT09EX04uDQo+IEZpeCB0
aGF0IGluIHRoZSByZWFkX3dvcmRfZGF0YSBob29rLg0KPiBNUDI5NzUgbWlnaHQgYmUgYWZmZWN0
ZWQgYnV0IG5lZWRzIHZlcmlmaWNhdGlvbi4NCg0KSGksDQoNCkFjY29yZGluZyB0byBNUDI5NzUg
cmVnbWFwIGRhdGFzaGVldCBmb3IgU1RBVFVTX1dPUkQsIGJpdCAxMSByZXBvcnRzOg0KIDExCSBQ
T1dFUl9HT09EX04JMeKAmWIwOiBQRyBpcyBhY3RpdmUuDQoJCQkJMeKAmWIxOiBQRyBub3QgYWN0
aXZlIGhhcyBvY2N1cnJlZA0KSXMgaXQgdGhlIHNhbWUgd2hhdCBzdGF5cyBNUDI5NzEgYW5kIE1Q
Mjk3MyBkb2NzPw0KDQpUaGFua3MsDQpWYWRpbS4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGF0
cmljayBSdWRvbHBoIDxwYXRyaWNrLnJ1ZG9scGhAOWVsZW1lbnRzLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogTmFyZXNoIFNvbGFua2kgPE5hcmVzaC5Tb2xhbmtpQDllbGVtZW50cy5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9od21vbi9wbWJ1cy9tcDI5NzUuYyB8IDUgKysrKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9u
L3BtYnVzL21wMjk3NS5jDQo+IGIvZHJpdmVycy9od21vbi9wbWJ1cy9tcDI5NzUuYyBpbmRleCAy
OGYzM2Y0NjE4ZmEuLjI3YmIzOTM3MDY2Mg0KPiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9od21v
bi9wbWJ1cy9tcDI5NzUuYw0KPiArKysgYi9kcml2ZXJzL2h3bW9uL3BtYnVzL21wMjk3NS5jDQo+
IEBAIC0yOTcsNiArMjk3LDExIEBAIHN0YXRpYyBpbnQgbXAyOTczX3JlYWRfd29yZF9kYXRhKHN0
cnVjdCBpMmNfY2xpZW50DQo+ICpjbGllbnQsIGludCBwYWdlLA0KPiAgCWludCByZXQ7DQo+IA0K
PiAgCXN3aXRjaCAocmVnKSB7DQo+ICsJY2FzZSBQTUJVU19TVEFUVVNfV09SRDoNCj4gKwkJLyog
TVAyOTczICYgTVAyOTcxIHJldHVybnMgUEdPT0QgaW5zdGVhZCBvZg0KPiBQQl9TVEFUVVNfUE9X
RVJfR09PRF9OLiAqLw0KPiArCQlyZXQgPSBwbWJ1c19yZWFkX3dvcmRfZGF0YShjbGllbnQsIHBh
Z2UsIHBoYXNlLCByZWcpOw0KPiArCQlyZXQgXj0gUEJfU1RBVFVTX1BPV0VSX0dPT0RfTjsNCj4g
KwkJYnJlYWs7DQo+ICAJY2FzZSBQTUJVU19PVF9GQVVMVF9MSU1JVDoNCj4gIAkJcmV0ID0gbXAy
OTc1X3JlYWRfd29yZF9oZWxwZXIoY2xpZW50LCBwYWdlLCBwaGFzZSwgcmVnLA0KPiAgCQkJCQkg
ICAgICBHRU5NQVNLKDcsIDApKTsNCj4gDQo+IGJhc2UtY29tbWl0OiBjYjcwMjJiODk3NmUzYzRk
MTJjZWEyZTdiYjgyMGEyOTQ0ZTJmZDdiDQo+IC0tDQo+IDIuNDEuMA0KDQo=
