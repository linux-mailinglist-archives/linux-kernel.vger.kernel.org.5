Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE0D780E07
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377727AbjHRO2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377757AbjHRO2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:28:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A8C3AA4;
        Fri, 18 Aug 2023 07:28:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzBxzXZWRvv3P87VBGcfOQLUaGdfJgM2wg5Ag/i73OqHpvj7YsFYuQFsR13Wqvq1h947zzws5Y/ya8w2L5e6bP8s8FEQnEKxLuXTPo/+li5sNgTeV9XGp3drAY8tk+6DB4MQETajlqPv273lPNF+ZyEVeG+cCcHWIZ9we5ylN/BA0WPVbxzrM1+jS/K0TD9KK3crLS18ngcmwtzwKzY/rfWWMo6RR9/1vSdDdJE8eFd6O7/1Xpu9eiu03WmQ3834inymYgsoTVMqvope9nSvd85XN0A+cWL2ex3eE3y/CyObNTjNcQHLhpSqPHK1+TzF0ks2YolKXgqP3JPZdb6GOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBxhzW8tzAw3aydRazZARxopLAreQk86Isw+nDBFHKk=;
 b=iqcqz5JGzhMSc4YK8sMlRRaH8rKmLDnhUuHegfuvb4J1aAbbpWhWyrvED9crNlr5RzajYxrW8S4u1mkhqQlX1vP7m88XTONgTZXy08hdtR9X00h2fPbmXVRtAUMKyyTRZYj/ydJA/mQRgvbU1LrpEAJx+ZFiaUoPSTcsqPLymuNjB8Ey3YRkGxW0BLqFmwq/lM1NClNdCpDr3fJFcWPzXvI70UMhgGtbIfzewUDRNvU4KxWFsMwhZkTtWMwzPAgMluGfWTux5k0P+NNpucf1RinS5qDXTpFMncs/z/PFaOCKiiuab4xTQSrIQxtHNG05CfRf/hbNL1+rhlv9IBGoYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBxhzW8tzAw3aydRazZARxopLAreQk86Isw+nDBFHKk=;
 b=BiCShfhSS9kDgRWpa6gKPKH39Bb1N6K4dQdQgJ/ZWlohLwbxVcMZIClwar0AY4MJC41Kcl3CF7Sy5MBUK4KbgmedGkIadW9k+jOfCe/l/jInNh2g7sNz3Q4I+goNM9UPX95bCQohZ9GPIc+X0M+XlXSgi5L3c4gEep8AmWCGumg+tM595q8UB1TWlDVWd1j5f55zkc8xgl10oZMzDCH2j9+PG7IaNLJv6IqDIx0mGYDQxTt7qkGXmdixGJdiKeL/Jn66LwvSt2U2evqytXDjAxQy66ZZvDExKWp8CII3JoXuzQxV6Ne9M9V2pHCzeg8wim80LH8ehfXOZg1UXMQ3lw==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 14:28:08 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ae25:4f33:8a19:32c9]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ae25:4f33:8a19:32c9%4]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 14:28:08 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] gpio: mlxbf3: Support add_pin_ranges()
Thread-Topic: [PATCH v4 2/2] gpio: mlxbf3: Support add_pin_ranges()
Thread-Index: AQHZ0c+nM+lIePZHfki1EcVrzQbB96/wG92AgAAAumA=
Date:   Fri, 18 Aug 2023 14:28:08 +0000
Message-ID: <CH2PR12MB389516E862515EA0A2A8C4E9D71BA@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230818122909.7122-1-asmaa@nvidia.com>
 <20230818122909.7122-3-asmaa@nvidia.com>
 <CAHp75VcZ43Zf4co=cVAPNUqHrhJ_zm=Gg7L=v1DYGxntr+Lkfw@mail.gmail.com>
In-Reply-To: <CAHp75VcZ43Zf4co=cVAPNUqHrhJ_zm=Gg7L=v1DYGxntr+Lkfw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|MW6PR12MB9020:EE_
x-ms-office365-filtering-correlation-id: 841216b6-7e2c-4c72-16c7-08db9ff757e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: stTmXAC/EniXX1/3R/3w73cuT0eF7eXwctJgf2svVHuG/wziNNASUKgucskj7nw2w23kSbosnFxUzAchFXm3g7p3+398c7Oy3G6SZx7rC245LHzyHX5YzzPWNuW1RsFvCMK2a01jFTk1sv5TdVIix6utxO9PQZgtieOeSchPFnkdhXobEy2nuJakdS1SyGyg/9QB0LNAEhoUxt1+4O2Snxgi7Csvc+P/vufJCpKYInBInSRCJ+10EQkgmplCgKqN4FH+Lv/uUmvFC9x3c+hBbV/EiegbRaLTxMSeLfaMUkW72OPmpdrn7SQp/buFKDW6aup5fXyb5IcAYazuGXrE+os8qw11xZloMuwzSRB8aPboRygI1akqjh6cFYiXhcFrN2t2BUqqa+lQzcAZIEr9V9px4yXOkZs5/jnTG6Q4MP1GA+D63PHlb1xmPjI7IfUGPXfDNle2zggWS/njLPMYFC5bECLhzaM52LPhEgVcqr7xVDV26EvV1UHzEY3RRoMtXMxNVjsup4Ofk2haEMOKZ+Eoiy4KYUkR24PoLP6SPKPZ0ONTqwA8+hdhcUfnz6qhn97efLCt2/JBYzQHm0kQi3eR/ot+Cmh5YJPIEGVsTTzM5634I+Vi1HJpzN55FBkk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199024)(1800799009)(186009)(86362001)(33656002)(122000001)(38070700005)(38100700002)(55016003)(52536014)(76116006)(5660300002)(66556008)(478600001)(6506007)(66946007)(66446008)(66476007)(7696005)(54906003)(71200400001)(64756008)(316002)(6916009)(26005)(9686003)(4326008)(8676002)(8936002)(41300700001)(83380400001)(4744005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0VPUDVkaWdNNDFCM05BSkk1Z2IzaGhjcjIxT1N1bXNQTTVUeC9EMldPakxC?=
 =?utf-8?B?aDhJQmY1OVdUd25qUG95MVB1RmJZYWxzdFdrSjhTUmdVTzlna1JLZHQyaVdk?=
 =?utf-8?B?cGJaZWtjMzBycW8remR5NmFzUXl6SUZDeTdhaStLZmZsOU53WTRtQ2tvRG9Z?=
 =?utf-8?B?ejlsK1Y3RWhnWCtkL0lPenZKYkQ2T1ZudjgvM0NaaE04cVNobXVScHVZREZy?=
 =?utf-8?B?KzN3L01wYU9UaEdwSGxNY3ZXb05WUGRjY0hDMW93QTBUdFg2Yk1rOTY5d1Vo?=
 =?utf-8?B?U2ZsTHErOWdWL0F4UVdWWGptWlFVUEJSUTZVekl6dDVvQi8zQWl6cEdMYWxC?=
 =?utf-8?B?YzQrd2xlWkoxQ0FTS2ZxaXlUSFFWUHkxMXFmemdIWjJrVGg0VnBqNlBTa3VE?=
 =?utf-8?B?bFAyeG5aNUZwRjJQZVpaS2NXL0IyQ3Ava0t2NDJ3dWE1LzdDOW1XWmV3eDFM?=
 =?utf-8?B?UWZ0UW9UcTJIcEpRVXdWSHZCRlZ4UmYxQTBrdzdnaThJL2gzWW9hVGVCNzhx?=
 =?utf-8?B?bGpDcnZYcjd3NjU1L2t0K2lnVFVHaCtWMHVNQ25qWWdxTzRQaGpva0t2b0tD?=
 =?utf-8?B?d0JWMjBaMlovYTNhQ2ZnYUg5MWJlSHRiQy84TDZ0YXlSOWExcmlYM09DSzVj?=
 =?utf-8?B?VHpxalBTZHhqTFE5K3NMWDFYMmk2Wm42cFFkeisvam1zU1lqQjJLM0xncmI2?=
 =?utf-8?B?Y24wdmJpWklra3pNcDlNbGRLY2tZMXg2SHRFb01BTXROUUMxWG1SUkJXeSsw?=
 =?utf-8?B?VStQQ3dZZDZGTHVNMzVVUHV0S1FxQ2YxaXNNZThLTyt4SVh1OGVzUW1HMXlU?=
 =?utf-8?B?Uk9GUUpWc0VSbXJtRnFyNG5OQ1dDN0NLckgzekhSVDA0blhSK3cvc1U2dG9j?=
 =?utf-8?B?OHIwM1pDc0dpeU1KZ1FSeHhPa2MzTC9CUm5kdHpLYVhxWGRCUC9EbjFxckk2?=
 =?utf-8?B?Y3lTRUQ5dGdHNzVuL2J4MUowSzBPYkZ2UTdwKzhPY05IYnNHL0RCZ0dCN1Fi?=
 =?utf-8?B?T2ZuQmJaR2g2bm90ZGNQODZqVCtRMEk1dWtqSHMzZ3lEd0kyM2t4ZmV6TEdQ?=
 =?utf-8?B?Vk9leGxSc1RvYktDMEUzQ0p4dnBWVDAvY1VaV2x2VlJweWlkQ1FGZS95OVhh?=
 =?utf-8?B?NXhwOWUyRlJQQnpDc05KbWh0S1NrTmlubnRuYXVlMTFldjFuTWdET2FUMmFN?=
 =?utf-8?B?TnI5UFduUG5PVHpQbUx1clJEQldtR2crQzhQSklIL1dnalNOTHJsc0c0blow?=
 =?utf-8?B?Y3ZKRG5zNnNGcjhxNElydWNFZjRCUjNpVnYwR3hpdk5WZ3hObnhMaEl2UlJS?=
 =?utf-8?B?c3JncjRmN3R1WnBCSDdjTVVJL1pQMzh3ZXY4aVFyc2d2cXAycG5VUmhYaVZp?=
 =?utf-8?B?c0c2Y1lWR0ZNRnZCaDBsOWxQbSsveVNrWmtzVFdmaGJiQnFrZFIxYVF4T2lh?=
 =?utf-8?B?YWFWMVg4V0ZxSWJFb2FSeEFFWXFBOVRDNDE2dWt2SWRiRk9jVUhCNzF6YjVl?=
 =?utf-8?B?SEtHVHJ2OHhDVFFaRFhtcG5aWHRkV1BERTVaY3phQXVvTEtleGhSVzI0Q0Ja?=
 =?utf-8?B?c1ROQVFEV0pyVTF4dE80ZkxyemFoVktXSHdLeXpvdGk1VXVESGxZb2hvYWVG?=
 =?utf-8?B?ZXRkdUN5YkRaajVySE9uNWtkb2ZhNFNzU01qZ0dTQXVaNEtSWEUzbXl4Smk3?=
 =?utf-8?B?eTRlYUhRcDlNWG82MUVWZkpGdVRqQlZheXJYTkxCekFiams3M3J4TGNPeHUz?=
 =?utf-8?B?Z3dCSkhoTlNhelp1LzFjSmpRaUdEcGFBMTR0QVg2bnBkUFdTM3lnRjRPYzlS?=
 =?utf-8?B?Ly9vbFZxV0FxQmVkWWNwZnVOQjZFZFJZbmZKREpkMTliZ2tQS21SRFVBaXNX?=
 =?utf-8?B?aWVuZ2pOSXNPczR5NTVUa0gvWTRNMkZBc2RJOW8zcDBORUZKN3E5TUZVUmhC?=
 =?utf-8?B?VnR4RHpXdWxZY0N1NDF3Zko3bWIyZWxEZEFxMU1aSFYxbjBQYzJXa1NTYnll?=
 =?utf-8?B?LzRVdVRFNnZ5MWl4bk5pQXBNYU1ZWWJhMzQ1Wi9Objg3U2FtMVpZTjdsSnJU?=
 =?utf-8?B?Q0V1RTV5bGY5Rk50dENtVlFnSWtRZ3dJMjVicG11SU8vU3BpSkIxM2ZlRm9x?=
 =?utf-8?Q?rf18=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841216b6-7e2c-4c72-16c7-08db9ff757e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 14:28:08.2917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E4Uwv1E2Jva5497aWE+ZcXFysXBMqj5bssnnsYldVuKgjEHhdqySFoqetutYiTrzPjMyMtj0pXIFFYZ++p152A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFN1cHBvcnQgYWRkX3Bpbl9yYW5nZXMoKSBzbyB0aGF0IHBpbmN0cmxfZ3Bpb19yZXF1ZXN0
KCkgY2FuIGJlIGNhbGxlZC4NCj4gPiBUaGUgR1BJTyB2YWx1ZSBpcyBub3QgbW9kaWZpZWQgd2hl
biB0aGUgdXNlciBydW5zIHRoZSAiZ3Bpb3NldCIgdG9vbC4NCj4gPiBUaGlzIGlzIGJlY2F1c2Ug
d2hlbiBncGlvY2hpcF9nZW5lcmljX3JlcXVlc3QgaXMgaW52b2tlZCBieSB0aGUNCj4gPiBncGlv
LW1seGJmMyBkcml2ZXIsICJwaW5fcmFuZ2VzIiBpcyBlbXB0eSBzbyBpdCBza2lwcyAicGluY3Ry
bF9ncGlvX3JlcXVlc3QoKSIuDQo+ID4gcGluY3RybF9ncGlvX3JlcXVlc3QoKSBpcyBlc3NlbnRp
YWwgaW4gdGhlIGNvZGUgZmxvdyBiZWNhdXNlIGl0DQo+ID4gY2hhbmdlcyB0aGUgbXV4IHZhbHVl
IHNvIHRoYXQgc29mdHdhcmUgaGFzIGNvbnRyb2wgb3ZlciBtb2RpZnlpbmcgdGhlIEdQSU8NCj4g
dmFsdWUuDQo+ID4gQWRkaW5nIGFkZF9waW5fcmFuZ2VzKCkgY3JlYXRlcyBhIGRlcGVuZGVuY3kg
b24gdGhlIHBpbmN0cmwtbWx4YmYzLmMgZHJpdmVyLg0KPiA+DQo+ID4gRml4ZXM6IGNkMzNmMjE2
ZDI0ICgiZ3BpbzogbWx4YmYzOiBBZGQgZ3BpbyBkcml2ZXIgc3VwcG9ydCIpDQo+ID4gU2lnbmVk
LW9mZi1ieTogQXNtYWEgTW5lYmhpIDxhc21hYUBudmlkaWEuY29tPg0KPiANCj4gWW91IGlnbm9y
ZWQgbXkgdGFnLCB3aHk/DQoNCk9oLCB5b3UgYWxyZWFkeSBnYXZlIG1lIGEgIlJldmlld2VkLUJ5
Ii4gU29ycnkgSSBtaXNzZWQgdGhhdC4gQW5kIFRoYW5rIHlvdSEgSSB3aWxsIHNlbmQgYSB2NSB3
aXRoIHRoZSB0YWcuDQoNClRoYW5rcy4NCkFzbWFhDQo=
