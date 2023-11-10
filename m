Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B0D7E8571
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 23:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjKJWSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 17:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKJWSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 17:18:14 -0500
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012010.outbound.protection.outlook.com [40.93.200.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AFD4229
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 14:18:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCvrjwSGEPKAzr8DAaTXseNUxTnDwqyjUdtwqZ0fZK/KkL4hgUN5VL5KtG5RiySYg0NU5xPZU/L6+LMwwmemYftAyFWVNzaeYQPKtV3Q6C8U6ytOpDcWLQGKXmzs7qn3RGcIsnSWYU6LcO0Ow3NjpiVISk84x6y9J+Qkmik0inziSfUkfyBsga08G1dH9p6yZGxvaYe40XHCJItzlHBJpI7MJTH6FsUTZvTYcE8yQyT9VSUQ/+UVhN5588z4C5K8HFaag1UktlhHYTBpsyqwgP3FRmVMN6EC2QVmVDQN6l2Q/uat+DqW5vl8MrYyylJchOZJJrAUTqtkncSVfQ6N4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46gzcnoSyZADUcHbUqt0fnn3IQqLE5FE1WtQtQW6Sdg=;
 b=jJXA37ZPd5kY9zhRVdH5KqZOJ9m363tKMl64ZG5iZu0Oij0RbZ/Ldri1vTUnjwNOcnw7VsYZLKbmKOybdMF0wMk0AZXhB5ruxIUnu6/5SrsViZXTuJFZ0lVHLKPlnfKRA9vxPB22zYjD6arcNkIQCQnjTQp5BjICQFjs/Jn1KSl7JVWiS7FsEw4kdM9xLkh7W+KoDBYCqgOak8Io+Ywr3Fx4eQkBclVyJFKbKGdByVmB1p4Q5LO3/NGs/6R2eKTLQEyFaXNO9ypWkIHiJH3yRB/+RsAD9CVy2fLfZ0xvmkgQz0TMEBwBxl+rsr6jBFkEXGZGwIlwc/zebXoHi3Aesw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46gzcnoSyZADUcHbUqt0fnn3IQqLE5FE1WtQtQW6Sdg=;
 b=fd+rR8RRj3E8uQafknPRjtjj6gz9PN/HbOxeOQhlZwZWMm79tqc/7i6TsjlmQ3cgQZAGqx8lYgKOO9G9Xar6v1HubofxFWlMO1ozFzpwI/HS0Cmw6IcU8kzQ9JvW6Ag1ptr7GqWKD63049O0DA34yFw8IO5QA66MfdXmMKbI+p4=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SA0PR05MB7260.namprd05.prod.outlook.com (2603:10b6:806:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 22:18:07 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fc:9264:2535:6ce2]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fc:9264:2535:6ce2%7]) with mapi id 15.20.6977.020; Fri, 10 Nov 2023
 22:18:07 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Byungchul Park <byungchul@sk.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "kernel_team@skhynix.com" <kernel_team@skhynix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "david@redhat.com" <david@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [v3 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Thread-Topic: [v3 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Thread-Index: AQHaCwJWAIN/MoWKfkqwslHpJdh5ILBiSanQgA2TzACAAu+c9oAAJMCAgAE7nQA=
Date:   Fri, 10 Nov 2023 22:18:06 +0000
Message-ID: <0EC1ED50-2370-4EA6-9A02-D36E1913224E@vmware.com>
References: <20231030072540.38631-1-byungchul@sk.com>
 <20231030072540.38631-3-byungchul@sk.com>
 <63C530D3-3A1D-4BE9-8AA7-EFF5B895BE80@vmware.com>
 <20231030125129.GD81877@system.software.com>
 <20231108041208.GA40954@system.software.com>
 <C47A7C40-BE3E-4F0F-B854-D40D4795A236@vmware.com>
 <20231110010201.GA72073@system.software.com>
 <20231110031347.GA62514@system.software.com>
In-Reply-To: <20231110031347.GA62514@system.software.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|SA0PR05MB7260:EE_
x-ms-office365-filtering-correlation-id: 2a8a12f0-53e5-4ce5-c69b-08dbe23aea2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GiK1CM55ZljfxGI+yTVfzVWm0DZCWo+lTP2rZ0+hJyK3Ag6j5lTpi+SrmGTEonw5RTi0WFYHaud/++lO2zhWjiIH9u8Pt0HiDnfNkWErOJhhIIzjbE7LAhunc6ocPc8kyAt4si2eMStmxWcRMmS+fj9hbg3oB4u7hlX6XYq+wKF9mw9SzM0rXmh5K037/wiHRnJmUuVIiAaybFd9YYGEDslpL7R4xEj4uLSj3qyNtqNefRfEveF2jlsPAZr/6kGDn9MoWq8UnlY7Cmr97Ekd6rwRqGq/LWs2B+/aE4nTcUwT7JpyBcQZ6ci1ByDs47W0cmDnpx4cQ8tCfrmkaY494MdMLgdoQCqN129xEkuxGXt+qaqqm1sAhcgAvq/dd7ay8+sYoKoucSbiOorT5PsB4qVhEUhPPML7g6jaDntk8VjzwYT6NStmql2peu3NqbuUCn1DiN3ZbgOQt+h8s3adYEKmf/wBA2g2qE9wAo/NOVkGdx+P/7hXPVZGodjSYGZoyASWJVZ2hW0yN5Yg/DvgKJjZ+jfPwQeMRuLWb9ZZee+6/5PdBTVi//HUBONaaL3RwwUWzewGPt07+sHDM34kg1Rj/Ki8fz70hhC4TpJ/s9+uetto2T9r+y7ZJni1sMXkCuZJ9WJ+7ysWaWZjN99hgx+g8jLJ/n6YrUvbQh97D6/OZ3raY3cyQQVwU7waanwe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66476007)(66899024)(36756003)(38070700009)(33656002)(53546011)(71200400001)(6506007)(41300700001)(4326008)(5660300002)(6512007)(8936002)(8676002)(6486002)(316002)(54906003)(7416002)(2906002)(2616005)(64756008)(66446008)(6916009)(83380400001)(66556008)(26005)(478600001)(122000001)(66946007)(91956017)(86362001)(38100700002)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eitGUHA0RmRmK2xsZFNya3lIMThmRkx0MEJwcHpRMFVwQ1VwaitPSm1EclBQ?=
 =?utf-8?B?WHRHcVBqZHNia2lPeTFLc2ZDdG1lWkw3RDFVMXBqaWhuTEtUOWFGZi81dlZ5?=
 =?utf-8?B?R0pRQ3VPemQ4T1MvUlZiZWZmNFpFTGd6bldzL1Rla1dlMnVqa0pQeHkwcS9Q?=
 =?utf-8?B?UEM0aytnSmdFRlRKMEFsQXdvckFicm5zL3NBNWpWR01MRW1EbWN3RTNZV0ZW?=
 =?utf-8?B?WjR3UEZtdFVoNDBldlRhMlAyYWtuVjV3UjdMazBWaStKTHVCTWx5WTZGMUh4?=
 =?utf-8?B?U3NtZ3JRazBKWUx4OWhDa1BuVit1VTZTeFdpUnNNVFVoekw5c3lVcERQdnNN?=
 =?utf-8?B?QXBnNGdRckpjZmRiNG1TbDc1b2JrZ3E3SDMxY1VYRHU4M0NGMGtKZUQxaW1Y?=
 =?utf-8?B?K3ZZcUZ3Z0dmUkZyYkFVOHBBcXowUEtXS2Y1b2VxMGlMVC95WDJ0c0J6TjJT?=
 =?utf-8?B?L1dYSVlxb21BbnR3VUNZWmdDeDFFdjBlWDQ4VmZDZHMwRHVEVDJGR05vRDl0?=
 =?utf-8?B?SFVGVS9FVVR6WW5sZVdtTGJUZVB4dW9VcWFTRWxTM3BveDVQczNBSEgwSlhx?=
 =?utf-8?B?aEEwRWNLQmVvWjEwTTB4Nk1HWkdpV3h2YjNKVENLbE1xYU5QcU81OEgrM2NC?=
 =?utf-8?B?eGt1NEswUFoyaVE5VXFOMDJ4RHBuMG94Q2w5R0FxQXByN1QyS2dzYnFpZVQz?=
 =?utf-8?B?bWttSHE3TTlNMGtmZ2wwZmdLZWhTYUE1S1pmUVJSWmJXMGhJUldEM1lJeHpI?=
 =?utf-8?B?SEJvbTZTZnpBVDJQbUtOMVk5RGppRHFVc0U5NnloUFRlYWxQY1MyQTA5VlRi?=
 =?utf-8?B?MUVyMXliTkZad2JzYmY4WUdGYXRQSDFZNU9jZUl0NkE2R3lKcDhzZFZlYTR6?=
 =?utf-8?B?L1JYZ0FVOXBybTRMRk1LUkJISFJLcDY4YkhFRmZDdCt2c0R5ZEtVTDU3Vnhq?=
 =?utf-8?B?bnVEMWdhSFIvRmQrcW14S3VKeGoxTkFlaDVKT0V2VGRXOVNNNnlVellqMlU1?=
 =?utf-8?B?VXJuK2t2VGQ4YzN1bFg5d1NoczhZUFNPVy9oSms5Skx1TlRqa0Q3bTJ3blVR?=
 =?utf-8?B?RWtOUE1aV05IU1phNmVPbStxcnk0Smc1RGhJdUU2TFZ4UktkTlBZczZad1dK?=
 =?utf-8?B?cS9vOTFldDYydDZ5dFhQQXlxMnRORVJycnRFZnZZNjEyMmNldGhhNGhob0ZY?=
 =?utf-8?B?OElKdkt0WFR2cjFCeFVabCtNQzJoc2F0T3l3YnV0QnZlV0IwSTZTQW41K09w?=
 =?utf-8?B?OGMremVmK0x4UDdCQ3VjaUxpRXpBZ2RXK2QzNVc4VXk3VXdxRnRsL1BPNlBP?=
 =?utf-8?B?YkxDQTM4cTNqWUM0VTFOMnFzTThWSHpXVU51bWhzZ3BqSG1oNjR4Rng3L09w?=
 =?utf-8?B?aWN3WHl2L2FXaFh4ajQxb1owa3JjK04vS0didHVKVy83RFpERXFWOWtyTWdZ?=
 =?utf-8?B?N1Zvb25UTXhhZnVUTW80enF6aS9WSjNVK21zSm8vS25MaXlsekVPQmNJdk9R?=
 =?utf-8?B?aU1CMGVtVFN0SWlORll5U1VBcWNrVm4rVjY4QW50cnFyeTRSOXYyeGZoT0xW?=
 =?utf-8?B?cExPQTd4Umx0NHlOSXhWS09nbXZzRncyOWtXLzMxeGFteTFtRUIyT0tmYTcw?=
 =?utf-8?B?SGc0SUZJd2svTWJmeHZELzY3Nmw1b0Zydy9jbCtud1ozZWFFUlpoeFBybzRF?=
 =?utf-8?B?QXFDZE1PeVFLbEgyeEdqTkRWOVlhaEYvTG9TamxUaUJCYWtyOWRERTh6MWwx?=
 =?utf-8?B?bkJyMlpSM0E0V0drUHpZNFFoQ25jbXlIRFFzSXB6WTMvL3BEQ3BHNE4ydGdG?=
 =?utf-8?B?OGxCdTBUYnB0N2UzOTRmbE1OZ1dVbm5KWmN5S3ZOdVQ2Q1RBekNaVTZJMyt2?=
 =?utf-8?B?N3U5RUtSWDZmZTgwVld0NmZ5TFIwMVN4NmFBSzRwbzFZWkpOQzdpUE9OMzN1?=
 =?utf-8?B?c0NUOU8wWVZrR1YyRjRkcEFaWHhOMzgwY2gyT3BJdjZpa2t5WSszUzM3N3A4?=
 =?utf-8?B?MFg4ZkUyWFBUTU9rMHFOOXVCQ0J4Uk93MnE4NlpheEhxa0hETHhzbmlxOVVj?=
 =?utf-8?B?V2VEQ3ZJb0F6U25zbENscEFwUUdpVmRPbWdDdGVpaHJVVU5LdVk3cTNISHBP?=
 =?utf-8?Q?K38aDVOBhLbALCfUxKgoYTbD2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <172A4166681FA14CBFFA7726D29B99E3@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8a12f0-53e5-4ce5-c69b-08dbe23aea2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 22:18:06.7510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J57z8RO5nQLElm0uUhfiXpe9rqi46LBAaLAVf12IzOHJ6J0yyocQOO61Or9Ev7cIgg7khM659aIq1rtBqFoTaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR05MB7260
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTm92IDEwLCAyMDIzLCBhdCA1OjEzIEFNLCBCeXVuZ2NodWwgUGFyayA8Ynl1bmdj
aHVsQHNrLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4+IEhlcmUsDQo+PiANCj4+IG1wcm90ZWN0KCkN
Cj4+ICAgZG9fbXByb3RlY3RfcGtleSgpDQo+PiAgICAgIHRsYl9maW5pc2hfbW11KCkNCj4+ICAg
ICAgICAgdGxiX2ZsdXNoX21tdSgpDQo+PiANCj4+IEkgdGhvdWdodCBUTEIgZmx1c2ggZm9yIG1w
cm90ZWN0KCkgaXMgcGVyZm9ybWVkIGJ5IHRsYl9mbHVzaF9tbXUoKSBzbw0KPj4gYW55IGNhY2hl
ZCBUTEIgZW50cmllcyBvbiBvdGhlciBDUFVzIGNhbiBoYXZlIGNoYW5jZSB0byB1cGRhdGUuIENv
dWxkDQo+PiB5b3UgY29ycmVjdCBtZSBpZiBJIGdldCBpdCB3cm9uZz8gVGhhbmtzLg0KPiANCj4g
SSBndWVzcyB5b3UgdHJpZWQgdG8gaW5mb3JtIG1lIHRoYXQgeDg2IG1tdSBhdXRvbWF0aWNhbGx5
IGtlZXBzIHRoZQ0KPiBjb25zaXN0YW5jeSBiYXNlZCBvbiBjYWNoZWQgVExCIGVudHJpZXMuIFJp
Z2h0PyBJZiB5ZXMsIEkgc2hvdWxkIGRvDQo+IHNvbWV0aGluZyBvbiB0aGF0IHBhdGguIElmIG5v
dCwgaXQncyBub3QgcHJvYmxlbWF0aWMuIFRob3VnaHRzPw0KDQpQZXJoYXBzIEkgbG9zdCBzb21l
dGhpbmcgaW4gdGhpcyB3aG9sZSBzY2hlbWUuIE92ZXJhbGwsIEkgZmluZCBpdCBvdmVybHkNCmNv
bXBsaWNhdGVkIGFuZCBzb21ld2hhdCBoYXJkIHRvIGZvbGxvdy4NCg0KSWRlYWxseSwgYSBzb2x1
dGlvbiBzaG91bGQgcmVkdWNlIHRoZSBudW1iZXIgb2YgVExCIGZsdXNoaW5nIG1lY2hhbmlzbXMN
CmFuZCBub3QgaW50cm9kdWNlIHlldCBhbm90aGVyIG9uZSB0aGF0IHdvdWxkIGZ1cnRoZXIgaW5j
cmVhc2UgdGhlIGFscmVhZHkNCmhpZ2ggY29tcGxleGl0eS4NCg0KQW55aG93LCBJIGEgYml0IGNv
bnZvbHV0ZWQgMiBzY2VuYXJpb3MsIGFuZCBJ4oCZbSBub3Qgc3VyZSB3aGV0aGVyIHRoZXkNCmFy
ZSBhIHBvdGVudGlhbCBwcm9ibGVtLg0KDQooMSkgQXNzdW1lIHRoZXJlIGlzIGEgUk8gcGFnZSBt
aWdyYXRpb24gYW5kIHlvdSBza2lwcGVkIGEgVExCIGZsdXNoLg0KVGhlbiB5b3Ugc2V0IGEgUk8g
UFRFIGVudHJ5IGZvciB0aGF0IHBhZ2UuIEFmdGVyd2FyZHMsIHlvdSBoYXZlIG1wcm90ZWN0KCkN
CnRoYXQgdXBkYXRlcyB0aGUgUFRFIGZvciB0aGF0IHBhZ2UgdG8gYmUgUlcuDQoNCk5vdywgdGxi
X2ZpbmlzaF9tbXUoKSB3aWxsIGRvIGEgVExCIGZsdXNoIGV2ZW50dWFsbHkgaW4gdGhlIG1wcm90
ZWN0KCkNCmZsb3csIGJ1dCB1bnRpbCBpdCBpcyBkb25lLCB5b3UgbWlnaHQgaGF2ZSBvbmUgQ1BV
IGhhdmUgUk8gcG9pbnRpbmcgdG8NCnRoZSBzb3VyY2UgcGFnZSAobm8gVExCIGZsdXNoLCByaWdo
dD8pIGFuZCBhbm90aGVyIGhhdmluZyBSVyBhY2Nlc3MNCnRoYXQgd2VyZSBsb2FkZWQgZnJvbSB0
aGUgdXBkYXRlZCBQVEUuIERpZCBJIG1pc3MgYSBUTEIgZmx1c2ggdGhhdA0Kc2hvdWxkIHRha2Ug
cGxhY2UgYmVmb3JlaGFuZD8NCg0KDQooMikgSW5kZWVkIHdlIGVuY291bnRlcmVkIG1hbnkgcHJv
YmxlbXMgd2hlbiBUTEIgZmx1c2hpbmcgZGVjaXNpb25zDQphcmUgYmFzZWQgb24gUFRFcyB0aGF0
IGFyZSByZWFkIGZyb20gdGhlIHBhZ2UtdGFibGVzIGFuZCB0aG9zZSBkbw0Kbm90IHJlZmxlY3Qg
dGhlIHZhbHVlcyB0aGF0IGFyZSBoZWxkIGluIHRoZSBUTEJzLg0KDQoNCk92ZXJhbGwsIEkgdGhp
bmsgdGhhdCBhIHNvbHV0aW9uIGlzIHRvIGNvbnNvbGlkYXRlIHRoZSBUTEIgYmF0Y2hpbmcNCm1l
Y2hhbmlzbXMgYW5kIGhvbGQgcGVyIGEgZ3JvdXAgb2YgUFRFcyAoZS5nLiwgNTEyIFBURXMgaGVs
ZCBpbiBvbmUNCnBhZ2UtdGFibGUpIHRoZSBkZWZlcnJlZCBUTEIgZmx1c2ggZ2VuZXJhdGlvbi4g
VHJhY2sgdGhlIOKAnGRvbmXigJ0gVExCDQpmbHVzaCBnZW5lcmF0aW9uLCBpZiB0aGUgZGVmZXJy
ZWQgaXMgZ3JlYXRlciB0aGFuIHRoZSDigJxkb25l4oCdLCBwZXJmb3JtDQphIFRMQiBmbHVzaC4N
Cg0KVGhpcyBzY2hlbWUgaXMgYSBiaXQgc2ltaWxhciB0byB3aGF0IHlvdSB3ZXJlIGRvaW5nLCBi
dXQgbW9yZSBnZW5lcmFsLA0KYW5kIGVhc2llciB0byBmb2xsb3cuIEkgdGhpbmsgdGhhdCBpdHMg
dmFsdWUgbWlnaHQgYmUgbW9yZSBpbiBzaW1wbGlmeWluZw0KdGhlIGNvZGUgYW5kIHJlYXNvbmlu
ZyB0aGFuIGp1c3QgcGVyZm9ybWFuY2UuDQoNCklJUkMsIGl0IGtpbmQgb2YgcmVtaW5kcyB0aGUg
RnJlZUJTRCBkZWZlcnJlZCBUTEIgZmx1c2hpbmcgc2NoZW1lLg0KDQo=
