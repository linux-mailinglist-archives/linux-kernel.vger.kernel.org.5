Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA0A7762AB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjHIOjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbjHIOjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:39:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145CF2123
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NA3y06c+WJYIY75Aw3FEc6WGu0L9Nj2Mc1cIEDfH3/lkRrL9FnHsBBaewCsvwuV8KlvQGDx6+dBbLvB4ChCcU900ktOnLbMfmqBJdEdnJfxsb5cM0efU0PH180xf8FQbyu/lCre3kzhYJuJUZFw+zHy8g+DFzlCfd3s0oNktwE1YRugzoEdjeQVLgU3KgJTUJF/dFmo0kEaqx/ADPaaKJmXPMdzHpF+cB0/cd/KCKaLinCm5n4dL3g1BrtJu5NuCvSv8r+P1v/EnVyU6Nsb767HuyLOxBCpQu9ELRvhJb8ccErobe6dum7WIJ4BregV9G+x6bDF3RImwIqM4/weaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXISelewrC3N32ivI6a+WbeuemwFA4gpK8cwn1vsAjI=;
 b=JVF5U/u9TeZGNcbQ0/ag2/4HxY6FUwcxF9eFmcKEKP7UunxeUFiVU8lSydCNBCDs5lAwDqaoyPXV9445yffFHWKtGjpjl/T8xxLMtzLNUUp73r4r6fdeBLIJCsT+G0Msp1JZA0ij4Uy7ekC9G/aMgaP/d2VdxiY+6MArOamnZviXtdpDCK30aWmcHi9UT5xEmUBrxP24g9m7/IRuoHO6/Y1RFfadOcgAQojrNM5cy+CGjQDE1aGhofm6cDbXUnx1UXIaFYFxLXOXPHheo8Ivq/PXrtJ9CEzOfNzPVJEDWpzTW4cFoRpp3jTTocYaynbvQAjni2IuTLzFfGbUVDbmdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXISelewrC3N32ivI6a+WbeuemwFA4gpK8cwn1vsAjI=;
 b=mtTG2nU0B08aJ4OWfcDaw0bKfIzaJiEItLHXrCx6DsOfg45AhDmQFAWi4WlM6DTXraaFvkl0fS181MrTJysjRmBOhU+awtJXdIVhCCc48R529zsf6UEBHUQ5+YD2sqDPgTrwJl/9rz4ls4XJSmYC+jTJe+Q9kkW45Fu72+SRlNQo2cd1s5iUZAk8Sad0QFUH0l58tFc3JjmoiYdVx4ufrnZozRM9cfynMQpF856izZGkp2J94jvPkGO3ZZbAnPikwS7vlOdugAz+qz/n5ybkqYWww3SjNbABaCEjilszp7jv7rF4TlKAksIc3GYlAjx8jcprytSdYt7QH8GXKNI9bg==
Received: from BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 by BN9PR12MB5339.namprd12.prod.outlook.com (2603:10b6:408:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 14:39:48 +0000
Received: from BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::5fa6:31e7:e6fb:3beb]) by BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::5fa6:31e7:e6fb:3beb%4]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 14:39:48 +0000
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     Asmaa Mnebhi <asmaa@nvidia.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] mlxbf-bootctl: Support setting the ARM boot state
 to "OS up"
Thread-Topic: [PATCH v1 2/2] mlxbf-bootctl: Support setting the ARM boot state
 to "OS up"
Thread-Index: AQHZyswHjZ8w+2z6VE6NyPL8guSFpq/iCPZg
Date:   Wed, 9 Aug 2023 14:39:48 +0000
Message-ID: <BN9PR12MB538105BA5D339F2CB27FE54FAF12A@BN9PR12MB5381.namprd12.prod.outlook.com>
References: <20230809141513.9058-1-asmaa@nvidia.com>
 <20230809141513.9058-3-asmaa@nvidia.com>
In-Reply-To: <20230809141513.9058-3-asmaa@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5381:EE_|BN9PR12MB5339:EE_
x-ms-office365-filtering-correlation-id: 6f70d808-001c-43a7-fe52-08db98e67b48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GqjhGhtI2JdQu/J0Szxdh7VqBTa4Dfp4oocG8wUh2rrnYgE0lRM7Zt+xdJ6ohTVt4MDLelia/dEdwI+Q3JsHE+EevmeK8enZbncATZ0lwt7Ul01hC7tthL90WkaJnJaGyn0rJ3Xt4Svjmkg7b9yCX1lY8zZIf/eeYfmmo4uQbgAlr1bpVVsrjuKMaR8SELKdSrwuQGPREdEcNhuxDQ+6Kc6KwxcTr0XldtmwhBxEnQYiUH7gFJ4kXNsz01fqtOoGJxOvyeKE3wj36qe4gSQgYl49KbHPdUygCs4ePAFa5PibSwnpS8CkI8gMXLABR++b1au1wjjCFJaArd4jqshXRcr0UMYr4XZhDZ0At0+y3JQzNDps6L1/AST7XGyigynW9siCTSlYJULVILIOwh761JQ98m5D4wk97zaHmEaot9j1vffUBF7oMCI/JqqOd2p2Naon1mxAfgnZvNjWSmqw3F+44tQnOl0deXVwJMLTsSlbNdmnfdI2gOeOQUJJ0fYTw7+98F72aFAiPabH5t6bzIjkM0m0a3DrqsBKMZmcrFVnt7B7Szy75a8Ibr0ylIXxvmk1g3C4BPXHbSqaTZ04YCeo0bU5rpgRQ5nbP8oWa5Y6yiORze/verCaJTFE1YWB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(186006)(1800799006)(451199021)(83380400001)(122000001)(478600001)(9686003)(26005)(53546011)(6506007)(55016003)(8936002)(41300700001)(76116006)(66446008)(66556008)(66476007)(66946007)(64756008)(316002)(8676002)(2906002)(7696005)(71200400001)(110136005)(38100700002)(33656002)(52536014)(86362001)(38070700005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmRSZXloQkhFSVM2NmFKVjhOcDZkMXVtUUluY1l2RDQwRVhSTXFVSDJXOThk?=
 =?utf-8?B?OEpuQnZmeHJQbHZVazBhMlgyMjhqMHpjUVpjOXpBcm41YXdpVXo2Yk1vYStq?=
 =?utf-8?B?V09hd0ViYWl6MVM3UDBnc3BNdnNlTmFYMXhBWHNZcGd3a2lSSjZPYjk0bDRs?=
 =?utf-8?B?MjhtWXBIYzZpNnl5ZzlaLy8xZExKZndab2FVR1VjZVFHMTF5bmIwL0E2M0Jk?=
 =?utf-8?B?S3lSaWFCWkI2bHlMUkRvOXRzbUhwWU9XczR1R2xaenlMcmRNNlJlRFpYNHZB?=
 =?utf-8?B?Wk5naCtRd1hDNS9xbEpmbEU0WnpVbytzYTRiMzJMaUxDTEhIeVczU2FNNGha?=
 =?utf-8?B?c09NY2FEL0p6c2dJM1pZcEpoa2ZwYTZDcUNob0prWE50M3VUTnVXaGVqOXU4?=
 =?utf-8?B?K0FHZjhXVTNkZkRtVWoxa2tSN0M4Y1JjTmxodkxmR0VSbncwR0dlNEl0MFF3?=
 =?utf-8?B?bERPT0lIYnIrL203dnFuUlN5N2xnalpSUGhiTjVHUDhzMjQrY3Y5dXlxZnRo?=
 =?utf-8?B?SWxlNHJXOGl4S0FTUEp6dnVKU1ZyejBLK01lekxDanVHcXd0YkNhL1BMMWJh?=
 =?utf-8?B?OWhxSml2UlJOcmpwR0crMk9QVkxYcXkvTXI3T2tIeVNoMUhCR0RWWE5KZlVz?=
 =?utf-8?B?bmh1b3VsODl1Y0VkRCtIZVJsSm1aQk9SSTFvcGpSSEE1b0ZSbVFsRVQyOWpq?=
 =?utf-8?B?aTF1RHFPcC9hVzVQU3NUTmdBbS9pa1lCem44SkZpekJWazZXMC83WUFVSkFy?=
 =?utf-8?B?TDFmTXA1OTlYek5pWnJHU3VDY296cGxWVDh4cUxucFdWUGpQVlR3NG1xN0Np?=
 =?utf-8?B?V2REYmt0N3lneDZSM283LzRXUU9nbzg4SU01WTZ3MmRyTURnWTh5bUFaYlc5?=
 =?utf-8?B?c3crU0hSVmVtemwzODFXS1VXekNwdUt5b0lTeFpjRW9wcDlVV0NPTEMwSjhV?=
 =?utf-8?B?elpUZ0IwWHFpSGlaSHYxM1B1b1RmWnpyREp5V3ZxVVU2ZGVCT2Q1cWdKbUcx?=
 =?utf-8?B?R2haMHl5WmtOc0FOU3BYMFgwZlBSODJPZ090SWZwRldDL3VVRVNhd2ZXY0ZY?=
 =?utf-8?B?a0RWbmF3bGhMKytPamdlMGd4YTlVd2l1SGFDRXJvd2w4NzhoaElIVGpWeWIv?=
 =?utf-8?B?S2tick9LMGg1bU1QUWlRK2lEeVhYTFRDSFM2amIrMU55VVhRdTJSY1h0dnph?=
 =?utf-8?B?YXh1a2N2NERRbkw4WWk4b3hkNVU1Ti9xQlVRaVVLUjRla1VFcGZHbWNXVC9u?=
 =?utf-8?B?K3NnUDNxNk4yaXlrcS9Hd0M5M2xBN05jdFE4NDI0WWVIWDVqcElTWU5WS2lY?=
 =?utf-8?B?dkZmeGJkeTZ0emFhUWRNRXdJb3Judnl6WXdoTytUUGdMVXpUY3dsZVltQjh6?=
 =?utf-8?B?T2laanVnd0JIVk0vd0ZMUVlZV3pId1dYTWF3NGcxUU1CcFEvZkRZaUlieDRR?=
 =?utf-8?B?K2JJT054d1JIRkFmM1FHamhENXBsQkJxZTdVMVRCbHByQlVudzRYSmxxdm94?=
 =?utf-8?B?T1pEbTJkRjhOMnJFbVZ0WTZQMFpzRjZhcGdQbTJ2V05NMit4UVQyWHFIc2l1?=
 =?utf-8?B?ZytMbzVoVWN4aTNSek1uUWEwSGZPMGVUd0MrekF0Y2djUzdyRE1qNzJBLyt3?=
 =?utf-8?B?TU1oMWNlNVE3Q1JUUC9PM1ZuTGYvdVJ3UVV5eTByUnNsWk5jdWplSmEzbnVG?=
 =?utf-8?B?bjdBN0doUFIyM2FTY2czRVI5K1k1blRJVVdqSENDVFBjRUVEMVRhbGtaVUl4?=
 =?utf-8?B?cHIwK3BQVEdyNVBDQnk5S1llRTU1MWZjZk1ncHVSLzA2ZGEwbXFRcm4rVG44?=
 =?utf-8?B?ZW8zRmxuVTUyR3JDeTB2TzRRZUVidzk2Tml6ejdNVjFTOS9wU21EVU02K0E5?=
 =?utf-8?B?UFF2WENkWDIvbFhsRm9YSHZ2ckR1RXhhUTRzQVdER0FpY0JXSGpYU0t4MlNq?=
 =?utf-8?B?a0tsVVNIY3pDU1lzRmh2U1lsMnczSGZXbjk5Q3N6dEhzVFc1SjcyalJxR3pJ?=
 =?utf-8?B?cDMwSlRQbUdvdjdMdEN0SVE2VldVaTduaTFzUjc1TW1BRE5iZVpsZEZ2L3NI?=
 =?utf-8?B?Z0pVaTFMOTk3dkNMNlNEV05lVXpwS0htUnUyVU5WRzVWdWovaDZ6TTEwcjRI?=
 =?utf-8?Q?Kfg8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f70d808-001c-43a7-fe52-08db98e67b48
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 14:39:48.1068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uFGUztzHmKelZW8nBdw/DMbV4f9q0bap0djHI9RUcJOlFj/d14jLaRcsZ/Bpz22S5CSsx7s2cghYdVMEq/fHnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5339
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXNtYWEgTW5lYmhpIDxh
c21hYUBudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIDkgQXVndXN0IDIwMjMgMTc6MTUN
Cj4gVG86IG1hcmtncm9zc0BrZXJuZWwub3JnOyBWYWRpbSBQYXN0ZXJuYWsgPHZhZGltcEBudmlk
aWEuY29tPjsNCj4gaGRlZ29lZGVAcmVkaGF0LmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBDYzogQXNtYWEgTW5lYmhpIDxhc21hYUBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBb
UEFUQ0ggdjEgMi8yXSBtbHhiZi1ib290Y3RsOiBTdXBwb3J0IHNldHRpbmcgdGhlIEFSTSBib290
IHN0YXRlIHRvDQo+ICJPUyB1cCINCj4gDQo+IFRoZSBCbHVlRmllbGQgaGFzIGludGVybmFsIHJl
Z2lzdGVycyB0byBzdG9yZSB0aGUgQVJNIGJvb3Qgc3RhdGVzLg0KPiBTdXBwb3J0IHNldHRpbmcg
dGhlIEJsdWVGaWVsZCBBUk0gYm9vdCBzdGF0ZSB0byAiT1MgdXAiLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQXNtYWEgTW5lYmhpIDxhc21hYUBudmlkaWEuY29tPg0KDQpSZXZpZXdlZC1ieTogVmFk
aW0gUGFzdGVybmFrIDx2YWRpbXBAbnZpZGlhLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvcGxh
dGZvcm0vbWVsbGFub3gvbWx4YmYtYm9vdGN0bC5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysr
KysNCj4gZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhiZi1ib290Y3RsLmggfCAgNSArKysr
Kw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhiZi1ib290Y3RsLmMNCj4gYi9kcml2ZXJz
L3BsYXRmb3JtL21lbGxhbm94L21seGJmLWJvb3RjdGwuYw0KPiBpbmRleCAzZWExMTI1MGI2ODEu
LjdhNjdmY2M2ZGQ5OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9t
bHhiZi1ib290Y3RsLmMNCj4gKysrIGIvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhiZi1i
b290Y3RsLmMNCj4gQEAgLTgwLDYgKzgwLDcgQEAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBt
bHhiZl9yc2hfbG9nX2xldmVsW10gPSB7DQo+ICAJIklORk8iLCAiV0FSTiIsICJFUlIiLCAiQVNT
RVJUIn07DQo+IA0KPiAgc3RhdGljIERFRklORV9NVVRFWChpY21fb3BzX2xvY2spOw0KPiArc3Rh
dGljIERFRklORV9NVVRFWChvc191cF9sb2NrKTsNCj4gDQo+ICAvKiBBUk0gU01DIGNhbGwgd2hp
Y2ggaXMgYXRvbWljIGFuZCBubyBuZWVkIGZvciBsb2NrLiAqLyAgc3RhdGljIGludA0KPiBtbHhi
Zl9ib290Y3RsX3NtYyh1bnNpZ25lZCBpbnQgc21jX29wLCBpbnQgc21jX2FyZykgQEAgLTQzMSw2
ICs0MzIsMjgNCj4gQEAgc3RhdGljIHNzaXplX3QgbGFyZ2VfaWNtX3N0b3JlKHN0cnVjdCBkZXZp
Y2UgKmRldiwNCj4gIAlyZXR1cm4gcmVzLmEwID8gLUVQRVJNIDogY291bnQ7DQo+ICB9DQo+IA0K
PiArc3RhdGljIHNzaXplX3Qgb3NfdXBfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0KPiArCQkJ
ICAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+ICsJCQkgICBjb25zdCBjaGFyICpi
dWYsIHNpemVfdCBjb3VudCkNCj4gK3sNCj4gKwlzdHJ1Y3QgYXJtX3NtY2NjX3JlcyByZXM7DQo+
ICsJdW5zaWduZWQgbG9uZyB2YWw7DQo+ICsJaW50IGVycjsNCj4gKw0KPiArCWVyciA9IGtzdHJ0
b3VsKGJ1ZiwgMTAsICZ2YWwpOw0KPiArCWlmIChlcnIpDQo+ICsJCXJldHVybiBlcnI7DQo+ICsN
Cj4gKwlpZiAodmFsICE9IDEpDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsJbXV0ZXhf
bG9jaygmb3NfdXBfbG9jayk7DQo+ICsJYXJtX3NtY2NjX3NtYyhNTE5YX0hBTkRMRV9PU19VUCwg
MCwgMCwgMCwgMCwgMCwgMCwgMCwgJnJlcyk7DQo+ICsJbXV0ZXhfdW5sb2NrKCZvc191cF9sb2Nr
KTsNCj4gKw0KPiArCXJldHVybiBjb3VudDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIERFVklDRV9B
VFRSX1JXKHBvc3RfcmVzZXRfd2RvZyk7ICBzdGF0aWMNCj4gREVWSUNFX0FUVFJfUlcocmVzZXRf
YWN0aW9uKTsgIHN0YXRpYw0KPiBERVZJQ0VfQVRUUl9SVyhzZWNvbmRfcmVzZXRfYWN0aW9uKTsN
Cj4gQEAgLTQzOSw2ICs0NjIsNyBAQCBzdGF0aWMgREVWSUNFX0FUVFJfUk8oc2VjdXJlX2Jvb3Rf
ZnVzZV9zdGF0ZSk7DQo+ICBzdGF0aWMgREVWSUNFX0FUVFJfV08oZndfcmVzZXQpOw0KPiAgc3Rh
dGljIERFVklDRV9BVFRSX1dPKHJzaF9sb2cpOw0KPiAgc3RhdGljIERFVklDRV9BVFRSX1JXKGxh
cmdlX2ljbSk7DQo+ICtzdGF0aWMgREVWSUNFX0FUVFJfV08ob3NfdXApOw0KPiANCj4gIHN0YXRp
YyBzdHJ1Y3QgYXR0cmlidXRlICptbHhiZl9ib290Y3RsX2F0dHJzW10gPSB7DQo+ICAJJmRldl9h
dHRyX3Bvc3RfcmVzZXRfd2RvZy5hdHRyLA0KPiBAQCAtNDQ5LDYgKzQ3Myw3IEBAIHN0YXRpYyBz
dHJ1Y3QgYXR0cmlidXRlICptbHhiZl9ib290Y3RsX2F0dHJzW10gPSB7DQo+ICAJJmRldl9hdHRy
X2Z3X3Jlc2V0LmF0dHIsDQo+ICAJJmRldl9hdHRyX3JzaF9sb2cuYXR0ciwNCj4gIAkmZGV2X2F0
dHJfbGFyZ2VfaWNtLmF0dHIsDQo+ICsJJmRldl9hdHRyX29zX3VwLmF0dHIsDQo+ICAJTlVMTA0K
PiAgfTsNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJm
LWJvb3RjdGwuaA0KPiBiL2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4YmYtYm9vdGN0bC5o
DQo+IGluZGV4IDc1ZDU5YWRlOTJiZS4uMTkxNDJjYzcxMzEyIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJmLWJvb3RjdGwuaA0KPiArKysgYi9kcml2ZXJzL3Bs
YXRmb3JtL21lbGxhbm94L21seGJmLWJvb3RjdGwuaA0KPiBAQCAtOTAsNiArOTAsMTEgQEANCj4g
DQo+ICAjZGVmaW5lIE1BWF9JQ01fQlVGRkVSX1NJWkUgMTANCj4gDQo+ICsvKg0KPiArICogU01D
IGZ1bmN0aW9uIElEIHRvIHNldCB0aGUgQVJNIGJvb3Qgc3RhdGUgdG8gdXAgICovDQo+ICsjZGVm
aW5lIE1MTlhfSEFORExFX09TX1VQICAgIDB4ODIwMDAwMTQNCj4gKw0KPiAgLyogU01DIGZ1bmN0
aW9uIElEcyBmb3IgU2lQIFNlcnZpY2UgcXVlcmllcyAqLw0KPiAgI2RlZmluZSBNTFhCRl9CT09U
Q1RMX1NJUF9TVkNfQ0FMTF9DT1VOVAkweDgyMDBmZjAwDQo+ICAjZGVmaW5lIE1MWEJGX0JPT1RD
VExfU0lQX1NWQ19VSUQJCTB4ODIwMGZmMDENCj4gLS0NCj4gMi4zMC4xDQoNCg==
