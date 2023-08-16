Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B95577EBC8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346497AbjHPV2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346488AbjHPV2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:28:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52F7FD;
        Wed, 16 Aug 2023 14:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+Ddvz30Nc+pZHth4+BSYeUIU4vUy/lS9yxf0IJTl7aqw9ZV1xlLqffIM0LtVDpI+F/XqpXK0lkKBFYqMVRaU1ecWR8s2DOPYVuR0Me8e01y+Xrm1ycKqIOZdtwlCvU6f3oFGocJuQVcDQCCVqhyPk3N9WBKiwbKeNmaFtBdWoNZ2E3L+urxvRNuOm0lkpQZzq62b4tgMo1AAC7bYs6FmTyo+oPEV2XSaJ5DuawTSSD6vlNw8/uH8geL1fSVA/HsSLaxbcnyVNQxD7Fs0KF+c9N247b7yu4fdA7Ilz6TGpPVQyEcH14Fod5thD0RpFdr1pi250NUgTPfZr1W5UL33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xznmG5Zqw0KqTFiL7YueEEWAK4tz6xiCoAe7DH+ux/4=;
 b=E3EhdwRgExaR2K0fqkcyDq9lbhk4rvR9q33C0PXVUcHxcJ10uh3muJ3glbh7OjV595vpP10ktZ6LA6mYDl+1akREpiySPnchiZHi9JWfx3dGyw7EtLcxga4LvwDNjmrKTAzcE6zYV45/i+uWX467hARXf5xXOwxaslEWflvHn0/NeFCoUgqGrsr4/EozuGjZmeypJAMpzugBIbgUN9upwCTxUlAGTfCBO5Uo9OlzT27U7ibgBDnK75IfDdhBEaOFHOCFPqH98PsBwEDUZEeBVPf1zy8tEf6bd5fbX0t5WuE1OysyAGpKF3i7GC0FcQfDQx+NRCer/Txr4DnDOoob8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xznmG5Zqw0KqTFiL7YueEEWAK4tz6xiCoAe7DH+ux/4=;
 b=WNUP4anuXso3nvweJnhRkUSV2qH3/vrLlaA/izAuySit/M6sdXmshGDeJPTTjHheERyXfsU+xvBZSCGA8Um+96F9KW5CvQAFkatsPdSSpt7FbU3xCXUa0K0wfVEmiVzk0GvfENUTaLO85w5Nqe1v0Fy3/zPhdTForob/zZmjH7dtgnLeWYKk98AMHscYkTcXEW/uBHq4vQsBpUgLUMB3LYLrR3RkP2bKJ3ZcYVH1SA75rA9eD0FIdwhjAM+78Mc8Xgk3DWeonkTXdquMMKSNonBQkrjIXCd6LXV+yWCuZFvffg7mtHaNOj6NItynYjb3soFNhEY9jfH+gWMW+kK+pA==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 21:28:26 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ae25:4f33:8a19:32c9]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ae25:4f33:8a19:32c9%4]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 21:28:26 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] gpio: mlxbf3: Support add_pin_ranges()
Thread-Topic: [PATCH v2 2/2] gpio: mlxbf3: Support add_pin_ranges()
Thread-Index: AQHZ0Fiforf54onJHkGX7vWgR5BAI6/tEceAgAACvyA=
Date:   Wed, 16 Aug 2023 21:28:26 +0000
Message-ID: <CH2PR12MB38953114436B7B0768A1C321D715A@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230816154442.8417-1-asmaa@nvidia.com>
 <20230816154442.8417-3-asmaa@nvidia.com>
 <CAHp75Vdp9TYTod6UBLxG_YrT_vD4azfyrM9dTrau8CPJuH_vrQ@mail.gmail.com>
In-Reply-To: <CAHp75Vdp9TYTod6UBLxG_YrT_vD4azfyrM9dTrau8CPJuH_vrQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|CY5PR12MB6033:EE_
x-ms-office365-filtering-correlation-id: 7f8fc1f1-26c0-49c2-2bca-08db9e9fba20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 38VC2ccQ4FRfMkgOzjaGpv3s3BnQKPjyRIB4jkd2WVGlpInzHd855xEEcT4KuxE3TfESOqejRHBArf4d2ayV1ixuoiu3Qxx/aqqmiVh5OC0JsSRhNFGfpvCsXCD/jfx45B/+C+4SwYbzP50NbceFpVeDYdS5v8SAbg4xBxM6eipaJn33O3BrjKZCezjN5mLa5rIItVY+DI2aqqL1xalyMGNsS/vwgu/TMACiYVCmLvQQzP84XK3qPwycMA/S7w/6T3UfoAOr56uVGCVdCUUMXyBkGGFIpXP+RvzWnfOa7YpOqkQoB3Buq0gzeTGTavZvhUrpTrN1W/Oham2ZNZIccFPk1OQLpORnN2scaImkVLUZv/mnFTr8Ij+EAje2KxMTgn2wlQXpvKDj4N6UfP+QZ4RnS3WEt1pTTA35ixS0CMb8U5d2r2dq0pW3OGQcSJliK6z5MVwvnuLHAO32huLqVHcsSrHBVTlWRv5Z7Qfl5WqID7L63uS9nrXO0gru1nW5eYJFmI0KWPG4quYCobgMtSXiuyfVJ3sE0UFAY2tqO46I90CRPShxZCTAd0qFcVtxMcPbWahkU7N7n/E/4czpji9kxE3sWym7z380dd8tdz3IDn9e1dNo/8NRf2tuogWS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(186009)(2906002)(83380400001)(4744005)(86362001)(478600001)(6506007)(7696005)(71200400001)(33656002)(9686003)(26005)(55016003)(5660300002)(52536014)(41300700001)(66446008)(122000001)(54906003)(316002)(66946007)(66556008)(66476007)(64756008)(6916009)(76116006)(8676002)(8936002)(4326008)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUMwQmI5YmJkVTh1cHU0TDdzNHA2RnRDT2FzaFpWRzg5OTMvQVF4THVLQmZj?=
 =?utf-8?B?WnRWNEsySzBuNjV6K3JZSnN4U3NHWlFoTVBoMmVJb0o0eW5HYmZURWFmU2hL?=
 =?utf-8?B?bTh3VzFKc0JyWll1cmRYbmxMYzNZaTIxMno4a1RvbmlFRjVBUFVqdTFaZWRO?=
 =?utf-8?B?SkVoOHZQbjNVd3ZoOUl1V285WjhEdWc2STI4Mk1sdFVaTnlMbGx1NFhGRnhu?=
 =?utf-8?B?TzdEMWxTL1lyTnlnWHQwa1F0eTdYVjEydEc1SHlxRkZFY3pFdUQzQkZEZFFt?=
 =?utf-8?B?ZnNVOWlLM29tUlR2MzVoNXZuWTgxVitla3pIaDlpVWRpWHNHdnJIeFlDWmhC?=
 =?utf-8?B?and3NEpDZ0hFam5ZUGdYRW1EdERmY1NiaVQ4V3oxZzA1ZFVIRUNMdmlZbDlP?=
 =?utf-8?B?bnBSMTNZOElHaEVzenJ3eFFRUXdSN2MzM0tDcXpRejJRcTVmdFdBQVlIbC9O?=
 =?utf-8?B?T1dlOHIwZ3BKQW1TdnpCdlFZSFlXc3Y0R3ZZQWhCNFRmOWNNZ0pKUU5KYlNQ?=
 =?utf-8?B?MHhZMi9KeUJNd3dkV2hMSzV3N3A1S2srZjl2d003MVloR0tFdGtmeXBOZTgr?=
 =?utf-8?B?bGVKN1J5WTV4VkkzWTI0NmFvcGVMb3R4VTEyWHpQZElmTGpvT1F4TmttRmRT?=
 =?utf-8?B?Z3ZIeXE5aVVXdExwaGJWd04ySDZ3V1Y5Q2hhK0d2Z08zbnZiZ1BVOGVVZGFH?=
 =?utf-8?B?SkUwdzNieGV1SEtOUWkzaUdtYnY2TWxVSnlBZ0VaTk96RWl3NTVCUStmTVgz?=
 =?utf-8?B?cWEzVTNQUk9ZRVJSTXh4dUgwZFFUeFRMWTBSeUZkamFqQ0xRTGtHZnZjWjBM?=
 =?utf-8?B?T3VwTW9SSHNlTk9jY1RBemNqa084U1E3MjU1a3FtNHlUNXVzL1kvMHBYby84?=
 =?utf-8?B?eEp0TXZQU0J1SEhLNzRkSTdpdGF1eFJzRXFsdmNueU5GbFo3V2Q4c3Vyakw3?=
 =?utf-8?B?dzBBUVpDTkhEeEo4ditRbjlhVmNRK1hpWTRSZkozaTF2WGttencwdXdseEsz?=
 =?utf-8?B?OWY5Z0Fha1huNXRqY3NSVVk0NFRNc3BBNUJWYUgydGlRUys4bnFCc2FDNUZU?=
 =?utf-8?B?VGQzdWtVeFR1NU1lWmxCczBNU3ljeUZ4aEwxUTZqTEFYdnhvVUJFcmRyeGVw?=
 =?utf-8?B?THJRZVNjdU5LdlA1NFBqem11UlFiUEQ2QlpPTUlpM0l1SEJDTUlOWlJJTjRM?=
 =?utf-8?B?WWxYclZlNzVueFJRVDVpNmZPN3Zpb3ZUYVpWL2syOVYrRCt5NzdybmsvWjFK?=
 =?utf-8?B?TG9ySm9hbE9PTWNSNmpZazlKWWhCbVNFOFpxMGYwVVVCeFFabTFIM01TRXdL?=
 =?utf-8?B?ZnFMVTR4RkJQcExuUDk4aElROE9YeHhKOE11UHBUOFFJQjdzZktRN1hGNnpq?=
 =?utf-8?B?NFpMenRod0Q2ZVlqUkx0TVY2cnVRNUk1aE9IaHlSY3NHZkdaVnphTExVZ29l?=
 =?utf-8?B?SW44VGk5TUR1OXQ1L21wSWpZTmRncmtIQ2Y0c3Q0bGg2aXlOaE1uTkZGb2kz?=
 =?utf-8?B?Ymp5dW41bU52Z2NSaWJ3OW1ldEQ3YXh2Q1NyNisrVjFiem1wdlpWd0ZBb3J0?=
 =?utf-8?B?Q01uMG1wT2FIUURlUkl4L0dJcWxmeDBudGVvQUdZc29HT0FLYVhGZWhlbGNm?=
 =?utf-8?B?NENlK0I2U3BrRWhvZjEwcXJQeUM3MllEcnJjMmFuRW1sZ3ZIaXRXTFBXdnhs?=
 =?utf-8?B?eVpPcFFJd3ByUWMvRWJoTy9UUGwzbWtOajZyaElnd3d5WEpOTTBjalU0c0Mr?=
 =?utf-8?B?R2dJR0R6aUFISGJCQ21lSUM3YkZZeGs1NlZwdGR5QUJLNHBwUlg1Q1JoZXNn?=
 =?utf-8?B?TTBmaGVYdGRvYW5JVmw0YjV5SVpTTk9yT0xFcVdKYlRrcjkwcmZ5ZlJJeU5N?=
 =?utf-8?B?SjhxTVdlM21xZHFUWUhyUEFQay9jMFlhemNTNzFtU1BldXN2dm0ybXVRcFh6?=
 =?utf-8?B?YkdWbWNkVHNRNDBuTU1PS3J1c2NxaTZtVkxwaUUxMVlwQ1djdWVLd3A0WFJx?=
 =?utf-8?B?bjVDUHRQNzdjQ0ZSQzloSkxlZWtnRFZIc1lDdm50YVQ5NjIzaGVhbEJHemkr?=
 =?utf-8?B?NEl2akhaQWNJMWQ4ZHl5bzFiNnc3M29XTmxyT1Bjazh5OWU1TGZGd05MclZO?=
 =?utf-8?Q?G+0o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8fc1f1-26c0-49c2-2bca-08db9e9fba20
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 21:28:26.2265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YF397fl15cc+8+3/Hm78nQ0s+j6WiY0pLixMDoM8xgL1EOlmZufaBNvkd+IroODhSh3VNHDvOchWbeugsXUGYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ID4gPiB2MS0+djI6DQo+ID4gLSBObyBjaGFuZ2VzLg0KPiANCj4gSXMgdGhpcyBjb3JyZWN0Pw0K
QWggbXkgYXBvbG9naWVzLCBJIGFkZGVkIHRoZSB3cm9uZyBjb21tZW50IGhlcmUuIEkgcHV0IGl0
IGluICJ2MiAxLzIiLg0KDQo+ID4gK3N0YXRpYyBpbnQgbWx4YmYzX2dwaW9fYWRkX3Bpbl9yYW5n
ZXMoc3RydWN0IGdwaW9fY2hpcCAqY2hpcCkgew0KPiA+ICsgICAgICAgdW5zaWduZWQgaW50IGlk
ID0gMDsNCj4gPiArICAgICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKGNoaXAt
Pm5ncGlvICUgTUxYQkYzX0dQSU9fTUFYX1BJTlNfUEVSX0JMT0NLKQ0KPiA+ICsgICAgICAgICAg
ICAgICBpZCA9IDE7DQo+IA0KPiBUaGlzIGlkIGNhbGN1bGF0aW9uIHNlZW1zIHdyb25nIHRvIG1l
IGFzIEkgc2FpZCBpbiB2MSByZXZpZXcuDQo+IFdoeSBkbyB5b3UgdGhpbmsgdGhlIGFib3ZlIGlz
IHdoYXQgeW91IHdhbnQgYW5kIG5vdCBqdXN0IHdvcmtpbmcgYnkgbHVjaz8NCg0KSSB3b3VsZCBs
aWtlIHRvIGdldCB0aGUgZ3BpbyBibG9jayBpZCB3aGljaCBjYW4gb25seSBiZSAwIG9yIDEgb24g
Qmx1ZUZpZWxkLTMgKG9ubHkgMiBncGlvIGJsb2Nrcywgb25lIHdpdGggMzIgZ3BpbyBwaW5zIGFu
ZCBvbmUgd2l0aCAyNCBncGlvIHBpbnMpLg0KVGhlIGFib3ZlIGxvZ2ljIHdhcyBhbiAiZWFzeSIg
d2F5IGZvciBtZSB0byBnZXQgdGhlIGdwaW8gYmxvY2sgaWQuIFRoZW4gdGhlIHBpbl9iYXNlIGZv
ciBlYWNoIGdwaW8gYmxvY2sgaXM6DQpwaW5fYmFzZSA9IGlkICogTUxYQkYzX0dQSU9fTUFYX1BJ
TlNfUEVSX0JMT0NLDQoNCg0KDQoNCg0KICAgDQoNCg==
