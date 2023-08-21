Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AFC78299D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjHUMzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbjHUMze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:55:34 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB042E2;
        Mon, 21 Aug 2023 05:55:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3Z86o3rNSFTQwh3GRXgsM2ntRCtvmCj21itx9QJW68qXuTpB5pHWEPBWbYgCv8rzhmIoCEl+3yfUXB1fP0fazJNbDb5SZ6WvWyyLmFoOYe+7M5qJ+HUGzUztfcfnz871zhZ/o8s3hk53K1hXyTC1y2d4LJAOwesbQDQIGOZBwgZzcJafpstjUVT4OgPkjekAD0p3ZRWHeKKx69z5AQ0o2Y8M5aAPIej5GVRz7dUTCcIhWRSP73QPL2NDyY0LTaFyLDzQHtnOqL8eVGj3e2XcCJZgtaNu+fEhxOGzxtjsFCHwT1RFezXlMby9/lvG8wS4aOBaM/bGxd+LAk6BIUOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AvXhcY88WY1sYcCEhykHKW5pS8zcks+Oa3VSX6vA4w=;
 b=gwmEpXDpcMtMZFwv/4lmbr287cNb7ylfNg5qP+8yYlHxMv64ZTlLYfIfE9yG9jcP99Kg2LIv7Ek4yHAgyHkIZ4ienE+WvPo4hrlE6D0f+wohMa/LS11aUEGf2Y15wUKHxm8luRPuVkgLfFF3w0HWqSKS0j5+KcfcQce9ZvkyYPJXv1Tz2N2/rDHhHpcMEURFnXMCYn84+QYVokveAyDphdHsNgmgU5hoIBugaK4uhwc8ZHq/Wg4gXJNvmh082gYnuCgmdSgDSlj8X7i5tSwdVsj57GWdA+Q3CZ69DZCHFuuMgLgPQByu/uDXWa7RgckhaQlZaenuseYcZNnaTgFXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AvXhcY88WY1sYcCEhykHKW5pS8zcks+Oa3VSX6vA4w=;
 b=OkfIhQma1uJX/npGJ0R51UHnAD40DwsbX1RIkeahQ/G8/xHGfzceJKayX07DLdebDWUJ/WuStxD/MD+aDGyo/xWLRMwe6RxQgi/cFUv2t8Q8hGo9vjHuperRLTBIdS5LwE6fbdCrs2prV95KAdTLl/XH7zrfT28HOKgF0+8wgckMiGVq4nAqGuouQ6F2M6WHM05BlFAO08E53LjJgwmqJ53hUnk4fnAi2VmR+uxmduxttLjF8b2aPaeJtvSHhj5QO+D/q6z9kNGGo3O9xJOXvuSeXm5ro2p9XlqIAygso9Niu3Z1ENMMNBHHZoWUORaxt8RutomuB4Nvukn14pCbtQ==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by PH7PR12MB7162.namprd12.prod.outlook.com (2603:10b6:510:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 12:55:26 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ae25:4f33:8a19:32c9]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ae25:4f33:8a19:32c9%4]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 12:55:25 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] gpio: mlxbf3: Support add_pin_ranges()
Thread-Topic: [PATCH v5 2/2] gpio: mlxbf3: Support add_pin_ranges()
Thread-Index: AQHZ0fMhOzHDGQm+ykqF9YD9NYMIj6/0tPeAgAACyLA=
Date:   Mon, 21 Aug 2023 12:55:25 +0000
Message-ID: <CH2PR12MB38950DCD03CFB45E4DB34E32D71EA@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230818164314.8505-1-asmaa@nvidia.com>
 <20230818164314.8505-3-asmaa@nvidia.com>
 <CAMRc=Mccsc=RY5Evw4-k8LYDrfuxFoWsn6wajybY4SY_89fjNw@mail.gmail.com>
In-Reply-To: <CAMRc=Mccsc=RY5Evw4-k8LYDrfuxFoWsn6wajybY4SY_89fjNw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|PH7PR12MB7162:EE_
x-ms-office365-filtering-correlation-id: 8737340a-b413-41bc-ff9f-08dba245e3ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9nJu3bWwcJiK77gSLt8uqc/cA9zrImdmSQp/lq0o59t8DsUG6xXfY7wFtPJyr6S6dWFRm7hVH6ApCHvbx5qFQmLD+7Xmm3e0I68WP0nVquuvNnFhCGxyFy5O3jM/2uajrYc4JlQRp9BPQuWFxZlQqa7LN7PZJ6nWScPgvIH3O8HirezS4JD4VEDU/OTe8ujyRbRYGerd6Em4/OfeVxWZ9sHC/SdfdhcaF45IedO/O1r3vt/NaVJLQ5yQHk1UjWNgZeGmzwwUBjBneiv7oFxcORim7eTfioLW/hjYpzhMH7LZo//+jx3YpwSTBp9IeMnyErPcrvEDSWuICE3zHzkdrm1lwvPA0cLfZ+aGGSciRR2Vyp0L80Hm72CZqXZfTGem0LyBXmzEZM6ClxK5nOeZgXES9aeUpaWahJZNAE64K+eL8g2xESD6j0yJluwY/sJgy0DJgyBirYqtey31l7I4ngj0soJJj1BA4fdKhqkEzeuzeRajc+RurjfVwzvMHF0yxWDteOj7tn8aibivaO9WOlkzl5luwUbRZacajIc4ul/s05kPk//O8MIZ1OzKEDXEHSrzUyP8Mn9d7UG84jgiZBUUr5nJdrCjgLpG+kJnYRIXr1WoVZE5B3GFxgfoN42b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(4744005)(38100700002)(38070700005)(6506007)(5660300002)(52536014)(33656002)(26005)(7696005)(86362001)(8676002)(8936002)(4326008)(316002)(9686003)(66946007)(64756008)(54906003)(6916009)(66446008)(66556008)(76116006)(66476007)(478600001)(122000001)(55016003)(71200400001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THowR2JmNjIrYmhSSkoyWHZCc3hjRWZLSktQQlJiTm1zcVFCaXFyWDBXT1Fw?=
 =?utf-8?B?S3ZuZGI0RUpKOGVrbGU0SnprY0dFL2FudVowcDA4VHNjUndkeERlVCs5OURY?=
 =?utf-8?B?bHRNT0x5QndDM1dRNS85ck1jQzhXZVhmYkhqa2tTd0pPMXhPUEl5S0NXYksv?=
 =?utf-8?B?VFNyeGdLRGdBNmErUWJaTmNTQUNaMXA5UnpXVXpQeTFCaGwvYTlVMGFHZ2Zw?=
 =?utf-8?B?bE5RdlIybGRPOUIxbUg2dlZqVTVYSkRWUG4vTWtvZzZkS0NDRmFUUG84VzlQ?=
 =?utf-8?B?OFUrdTZ4b09YUHg0b2E5VWNVTzNkamVmQTAzb0VML0pyWSs3Q2ZKSUFDY2E4?=
 =?utf-8?B?OG8zQmtGNmYzRkUwdTlJaFdHQTNhSk1kMW9JZUNQb3J2S3h5NkdndVl0WWFl?=
 =?utf-8?B?SjVnZkllNER0UGg1WnVBL29ETm5QdWhNT1NHbXhBaGhidTlkdGIxN2Mzd3ps?=
 =?utf-8?B?OC9oSlZXK3ZodnMwT083RC9RNmdHd2hkNURvb3IySWVOOEVUd3BBdGIvM1Jp?=
 =?utf-8?B?eHU1c1RVL1BZWFUyYTlVTThJQnFVVkFpQVhNbDNxb25BUWEvcTZlVGQwNldS?=
 =?utf-8?B?eEVqNFVsdXFSdWc3U2xsUXIrZW5nZ0laL3d6S0E3SVZoQlEySHdZRXI3Z21E?=
 =?utf-8?B?eGU5T1V4UHE1TGRUVWlRR0t6ejc2ek9YTzhNNE9CQTRVODBzVVlrcXBsSFJ0?=
 =?utf-8?B?UC9FSGY4ZzFmcjhvL3dPUTllLzZFTlJsQXNxTDAxUCtSaTU1TGRCQTFqMSs0?=
 =?utf-8?B?Q3BZQXJ0QlQ4UkRINjBQS2lTYUU2OUVoQWVINENDMEEwTXptR1B3amZvS0Nq?=
 =?utf-8?B?azVXcWFjOXM4ejBMVE8xb0JIdk5hNjZDUGtJSFRPK3VSZlgwZmE5WjZkc1hv?=
 =?utf-8?B?dnlvN3E1dGcyNkk3NXhZVnRKNHh6YWVWNmoxS0xUdE1waHNncGZ5d3B4V3Jx?=
 =?utf-8?B?WXRvMTFqNGhnWXdYc0c2eEw0NFJ5Tkx3WS9pc2hSNWZnQkZaQlNQcGpzWnlW?=
 =?utf-8?B?WGJXR1ZhaUpSUzk0aXNNUmxOWFAvelRZVlV0TmV3R1VldlNaT1o4Z25tZWNm?=
 =?utf-8?B?WVR4S05ob2NRUjh3cnprVEJxWVUvTWsrazJnbStOajR4aTVRUFdIa2dOWU1R?=
 =?utf-8?B?RC9uOXdTWjhrK0lURzZCUEFHQUV1ODQvVHBpTU83T09EdkV1Z21YT2FlSWhu?=
 =?utf-8?B?QTJPOUF6RlBmY0RENjgzRGxpMlExZWVnLzZ1ODNrTjFRRVJOTWtHMXlSemhl?=
 =?utf-8?B?NnNDbVFxYzNHNWxrdUQ4Ny93WkRjYXlTZnBxSkJuSkJBSWJXRWdXTitnU3ZJ?=
 =?utf-8?B?L09NQzU2UStBSHZ1eGt5RTF4YVhCanZIczBFeXhoL3IzYk5DOERCaTNacHVx?=
 =?utf-8?B?Vkcxd21SejlyTXd3SXBacnNpWFFyNHYxdFh2aVVTYzFYMXFuNXdjMmw5aWpP?=
 =?utf-8?B?TFFCSkJRb08rdWQ2Sld6eDRlWERUdGNjUVVBNzN5VjZOWXpSWXB5OVhNZXRn?=
 =?utf-8?B?SnNlNUJYMk5tMWQ2cXpmVGtYSkZpNVpDUUtCM1FGR2NOYzBrdkZXVVozTzNq?=
 =?utf-8?B?b3BrSXRaSjJzZkFMU0pZajkwWjQvNEZ3V3VHaTlNWUZvYUtuR0Z2WldGcFlz?=
 =?utf-8?B?L2pCb2E5clBlOGZuWFFieGpaRm9QYTUxeHhqQ3Zmc3JrWFBtRk5lVW55Rnor?=
 =?utf-8?B?UXM5ZGRhTXk0Uy9rbDViN3BNNEEwL3hseEgvMStxeE9aRU1QM0YzWXFuZTJl?=
 =?utf-8?B?aTNtbDR4STZlNGpHTWxocytFbnVWcEdEelhORDRHZ2tIajh3TG1XeU1Cdmg4?=
 =?utf-8?B?R0t4UTg2NTQvTjhQM3pjN241eGtwS0IwYnU0OFdpR29XZ1Z4b011STdUTkZR?=
 =?utf-8?B?elpnOWJOY1VCV3JEaDQvVFFqeDlBR2ZWYzV4UjFXU3d5Yko4aElXbFNsZy9a?=
 =?utf-8?B?UlJoOFRFaDF6em5oSmZhaGxzQ1VZUFhGdTBXbDErRWZPSDZQMjZGY21NL1Nq?=
 =?utf-8?B?R1ZhNVB0bzZuOWliVEtDVUNJRHFpcERXcE5QUnBENXc1MVdUNkJkbHpzc0c3?=
 =?utf-8?B?d053RWg5Q05sMVE0MGVxUGN2ekwvWk1BNnd4WUY0V3NNSllPUmhJRTdLTGJ5?=
 =?utf-8?Q?mQ3M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8737340a-b413-41bc-ff9f-08dba245e3ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 12:55:25.8662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EhQxETXsn3zNuRjrBhYV2x76wZEIy5LdsS0gvuOadAVrzGU9UBEu93bPNYDk4MtkC5WvTS88vHVLFOUsEBZYEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7162
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICtNT0RVTEVfU09GVERFUCgicHJlOiBwaW5jdHJsLW1seGJmMyIpOw0KPiA+ICBNT0RVTEVf
REVTQ1JJUFRJT04oIk5WSURJQSBCbHVlRmllbGQtMyBHUElPIERyaXZlciIpOw0KPiA+IE1PRFVM
RV9BVVRIT1IoIkFzbWFhIE1uZWJoaSA8YXNtYWFAbnZpZGlhLmNvbT4iKTsNCj4gPiBNT0RVTEVf
TElDRU5TRSgiRHVhbCBCU0QvR1BMIik7DQo+ID4gLS0NCj4gPiAyLjMwLjENCj4gPg0KPiANCj4g
SXQncyBub3QgY2xlYXIgdG8gbWUgd2hldGhlciB0aGlzIGRlcGVuZHMgb24gcGF0Y2ggMT8gSWYg
b25seSBhdCBydW4tdGltZSB0aGVuIEkNCj4gZ3Vlc3MgTGludXMgYW5kIEkgY2FuIHRha2UgdGhl
IHR3byBwYXRjaGVzIHRocm91Z2ggb3VycyByZXNwZWN0aXZlIHRyZWVzPw0KDQpJbmRlZWQgZnJv
bSBhIGJ1aWxkIHBvaW50IG9mIHZpZXcsIHRoZXJlIGlzIG5vIGRlcGVuZGVuY3kgc28geW91IGNv
dWxkIHRha2UgdGhlIDIgcGF0Y2hlcyB0aHJvdWdoIHlvdXIgcmVzcGVjdGl2ZSB0cmVlLiBIb3dl
dmVyLCBhdCBydW4tdGltZSwgdGhlIGdwaW8tbWx4YmYzLmMgZHJpdmVyIGZhaWxzIHRvIGxvYWQg
d2l0aG91dCB0aGUgcGluY3RybC1tbHhiZjMuYyBkcml2ZXIuIFNob3VsZCBJIGFkZCBhICJkZXBl
bmRzIG9uIiBpbiB0aGUgS2NvbmZpZz8gVGhlbiB5b3Ugd2lsbCBoYXZlIHRvIGluY2x1ZGUgYm90
aCBwYXRjaGVzIGluIHlvdXIgdHJlZS4NCg0KVGhhbmtzLg0KQXNtYWENCg0K
