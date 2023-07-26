Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9F1763D28
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjGZRDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGZRDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:03:36 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1A71BE3;
        Wed, 26 Jul 2023 10:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVg/Ql3k+LFo8iY2qVrzpoOXeSAGI0SVfZHhAsJMR+6dOHx/+98RVmNNGehVEi3U7mxJ7qdweM4DPUolZWmjbP81yxUlOmJpa2rs8lXKJNiJ3z72H0WGgr0Nlq0KUHgYQJAPN1jzD1gkgJHGycpYudSu74WgjKeGeBGkA32LPvWWC2aDm9T7lh9HOlY0wx727Lqfo9+3Z6MZu1nUukLAPP02sDPoT0UonWpDBfTtd22UEgl7scfKk7D5CNOC4i+8mqvtpj7Y5cCT3x8BCiYuPyTFLpjNLA8LtMm2HsABaAmKFZoimlVAQucHAQs9snct0FdPGm22MXFWKlPSx5w2Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtQ24QO2Nj8Z83Rt7sggclRdliM4xpRbtue3M8lT6Lk=;
 b=FYGqABmMaCxpqV3VuR2RDq5vbuNJfgDNymwXu9fjlI4aRSUE7JjxQ8CwLjbtdQfA1HYrFFD6Ob/v6oEuf7x4ssshhgU4tNoauOK+P5WKU4Ox4fh9yciI06BwXN8PlYQujp5f55XHi+Mh2ywyZe10n1cCiu45DuKkDjVfocfg7jGeIPISUixVmB9oHQsVqNY6jEPXlRpE2vGySkLz7e8RygG3qpG+gt96PJPAfpQlXFUrOvUnIlYW2bh4gfXrjoycA4NO7Z5QtsO0C6iiHN6DUcOBJCkjm1NNXdQ50i3NyP79jNa6kSV18faKXCLhljeclPZqJ5p7FSkeMr+gVttePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtQ24QO2Nj8Z83Rt7sggclRdliM4xpRbtue3M8lT6Lk=;
 b=lhQCKubmtNZxs8syUnCi954GZTp55JTV411X4PzyAPlXz4S1IYpc9ijEHYEGHWRqLYqRcrgAUfHeJTvOlLxTxiO4XKUI8JBFneilZDw2v6Kmvh2azDfKsdzRWDAbhpNFxYWiicjulOCsKvpF9VpR+b09fdT8w7eQd8fvPquKyOQ=
Received: from SA1PR01MB8062.prod.exchangelabs.com (2603:10b6:806:335::13) by
 LV2PR01MB7599.prod.exchangelabs.com (2603:10b6:408:17c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Wed, 26 Jul 2023 17:03:32 +0000
Received: from SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::9683:1d6b:f08e:2839]) by SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::9683:1d6b:f08e:2839%4]) with mapi id 15.20.6609.022; Wed, 26 Jul 2023
 17:03:32 +0000
From:   Steve Clevenger OS <scclevenger@os.amperecomputing.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     Ganapatrao Kulkarni OS <gankulkarni@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 0/6] coresight: etm4x: Migrate ACPI AMBA devices to
 platform driver
Thread-Topic: [PATCH V6 0/6] coresight: etm4x: Migrate ACPI AMBA devices to
 platform driver
Thread-Index: Adm/4xtlQfjmYoWwWkyBT0KXabRGeQ==
Date:   Wed, 26 Jul 2023 17:03:32 +0000
Message-ID: <e15a4a99-6fda-6f03-3ffb-3db93d678b2c@os.amperecomputing.com>
References: <20230710062500.45147-1-anshuman.khandual@arm.com>
 <9c3b4a97-bbe2-a978-b000-9562123af523@arm.com>
In-Reply-To: <9c3b4a97-bbe2-a978-b000-9562123af523@arm.com>
Reply-To: Steve Clevenger OS <scclevenger@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CH0PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:610:119::19) To SA1PR01MB8062.prod.exchangelabs.com
 (2603:10b6:806:335::13)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR01MB8062:EE_|LV2PR01MB7599:EE_
x-ms-office365-filtering-correlation-id: e660ef71-97ef-42e2-920f-08db8dfa3de3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F7i27OshEYp7+W3ybn/Wx1JyNWTIFZS+qMHtjk7angYpxcIhlnkq99YbMqeU+eDKHiaSoy8SCkdmTuzFCGxPHB4DjUTr0lgva0N9Smp+QH/R6TJCT9uoYBsyl5NYzoKy/4x5u9srxya9dEUCYQxn1nz660xopxnyQlnZOixM3euAzaENt78TAvgqPZPjuVgYGDbViCqBOgNkGPg6/RYH5cOfbk8UZo/nA6RENr4iZ9lKWLJFv8xnMO0sdY6iBuq4i2jOb6wSCOAfYsFkpw8ZwSaIEDn1OrP5scQkHCmUvRhEsYwYmfN7DF0sEm+m9RX4tI6P0kJbD3wxF8QwaQtVtjRTXMBlzDauLHm0+Ze+1rqkyKDGVpxcJMyCBkGZdeI57Zt8KpeSo2O5/YX/lbqrQ9BM+7RzSY6fvm2Fx2SjOXrG3htHWRWMjHduxztIiUlaaFJ9VuqQHvgPku2XJLRzGPfF8GSL37ZvTWbX82pXBCIwIRuDc5Ayh3237AAk+DkAG+2rtSOKw86XCXkrmStrvkwzFHdNBvw7IJMmEF6tkexRajoR48PpTttVbS82bkGhlxSA1TA7X4QQame94YQRqJDSyJ+i+DCsdR2VoPOJcHE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8062.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39850400004)(376002)(366004)(451199021)(478600001)(31686004)(31696002)(86362001)(2906002)(3450700001)(7416002)(66556008)(83380400001)(6506007)(186003)(26005)(122000001)(53546011)(71200400001)(6512007)(2616005)(6486002)(41300700001)(110136005)(316002)(8936002)(54906003)(8676002)(38100700002)(64756008)(4326008)(5660300002)(66476007)(66946007)(66446008)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WU83cFlzdnp5ZW0ySjg3YmhzWjI2NENpb0lKWVdPRStpS1JHR1hoT3ZvU05F?=
 =?utf-8?B?c0J2andKT21LcFIvem9KSVQ4VGZEbGMyalc4bUVoUWVMMEVHNnpMV2doS3da?=
 =?utf-8?B?VC9yWkdBeG1WN3Z1WlgyTk9wTC9FamF0OS84UHVNRkNXQjI2Y1FVL0tIb09S?=
 =?utf-8?B?elltZ04wZkJEeFJIQ2ZOVHRxaURLVU5sUHhQcWJoNk9SazF4QzlYRkRtaTRG?=
 =?utf-8?B?SlZuUFJGcHhnWVpTSE5QMXR3ZlZ2S1llOWtIZ1IxVmRjM1MycHhyOStuYkRy?=
 =?utf-8?B?b2VPWU1EMmEyd1Y4YSt5MnBWU056dXlIb0RnQlN6TzFEVkFCN0hBUm8zU3B1?=
 =?utf-8?B?c3QzcWErVDdaN1NMV09aNE1DaWsyVmFEcUpKbHRkL1BGOGtxRnMySjg3SFZ3?=
 =?utf-8?B?RlpuYUFheW1jdGdHNk1hRGZKV1ZhaCt4TmswRzNvNTZNNjRvcWxGczA4WXBC?=
 =?utf-8?B?U0JSbzNwbTlZV3VsTzYvQVY3eG1WbHErNi9qZjRqdXVWQ09EcGVJaWdQL0NQ?=
 =?utf-8?B?ZFczaEticTY2aGxTVmM3Rld5QWp0VU5ZdTVZYUtGaUYyL3ZWdGJIcTdyZmpQ?=
 =?utf-8?B?b1JvaXZ4WFlzOXptMzZDd0NJbnRLTWFIcVJoU1N0Z2VnQ0M1NWNobW9rMFV0?=
 =?utf-8?B?Ni9PNHdPK2FYWUlPdGkwMzZBMzE4dlhLRGZNcDVmWkptNzdOeExqaWt0bzVk?=
 =?utf-8?B?YWlHTy85MWdrMGs0UTYrNVlqN00zTTRrekdabFNjdmtRczYram8zZkRldkh0?=
 =?utf-8?B?YWhOZ3hyK2ZTU216a0pkYXgvZ1JOODdkeFFsb3NZK3dvMFNHZlgxdVVocnpn?=
 =?utf-8?B?aUluM25peFFvMksrQkdUVjBuVWVyOEJFcjRVZ3hNaVdBSTN4NGZWb1hmbHlC?=
 =?utf-8?B?dTJhVHNUTkdYQUVvdWhxZmFSdGFzVjFJVTB4cEJCQkYzZkV3NHNieFhTRy9B?=
 =?utf-8?B?T2EzeUY4TnV6RUovMUpyODh4U3JpZTFXSFMyZ0p0Sk9yWTg0bjRUWHJWTlJ0?=
 =?utf-8?B?NGpMRFhSNjU4dG9tb3VYc0I0TUVoc2o5SE9ZT09pZUJiZHkxVmRvYWNqWUlP?=
 =?utf-8?B?ay83ZTI2ZWtJa1Y4MkYrZ1d4MEQ1MGZqWW5kN0crQUdEWXFJSnArckl3Wm1t?=
 =?utf-8?B?Y2VoRGdNalNBNGhIQW0wc2xrUExJRTZ1S1dGL0NTKzNIcysyY216KzdmR1Rj?=
 =?utf-8?B?Y3NiOXQ3SUdiWGVtdW02Y3pnQlBJM0UrMUVrSEN6a1RZdTd4SUxVREc0aDcy?=
 =?utf-8?B?M09IbHErZTF6SU42Y2dpS3FhN2dUdDU5OUJGQjRlMzVJZlFxd0pBNWZ2dldk?=
 =?utf-8?B?QWhlZHZFUGZ1NHpGdU1wM3U5aUtDcUVYdTZCRTZPREhXcGZIcCtzUGtpUVdo?=
 =?utf-8?B?Q01uODZVaUNtQm5Pd3N2QS9LT3FzSVV3UzFDanByL1QveXVNZEE0ZTZiaWRV?=
 =?utf-8?B?cXZiMTU3UFVVd1oxS21sZmlsaE9Zd0QxT1d2dWpMcXhZVWVCbGJhaEh5UERp?=
 =?utf-8?B?ZENEK2VCV1k3Ti9teFErQWNDL2FaVCt2YmlHTEl3bGJpdHJweko3TDdxZ0J1?=
 =?utf-8?B?Q2pFOGFURElTN2hIamtxNTdIMkk5RnF2WEI3Z3hoR1FKRWYrbGp4VCtHRFBp?=
 =?utf-8?B?R09GdnA2ZVV1dlBlWm9Hd0p4d2tMYUY5VWZCWjlKbEoxZ1piREhSTVBLRk8x?=
 =?utf-8?B?cnU0OTlhM3BTcjNNZUdxMDUyWmF2NU1laDF6N1NtRGhGN3JuLzRQN2ZPUmxt?=
 =?utf-8?B?bzc3dVdyb3Btb1Nhc1ljaFNOTGp1ZnBhZEh3eDRqTVJiTk8wbU5NK0NvaGZ4?=
 =?utf-8?B?bEQxNWNMWU5jbVUyamx2VnUxVW9RNTZIVmRIcWhFR3RYZ3RkY1NMT2ovandt?=
 =?utf-8?B?RTNZZnBzQy9yc0NXOUF4T2FXbERVOUV1blN0Q3oyYm51NS9FZ2g4ZTBTZFgv?=
 =?utf-8?B?YWd4REdKZ2hJNXhwYjYxUjdSS0IvdDY4b2hIb3JwZEZFT1hDUGlRd1JpUG5E?=
 =?utf-8?B?dTZhRFlQOHAwWkVBdVNiU0t6LysxWkhYVjlXUFZiUXMvTyt4RUdBNFlnYnZo?=
 =?utf-8?B?QWRWMTBESTJxQWVHTmczMW9kYTZWRUk5V2tsVUdjS0hibGpZUEpQenptVDRW?=
 =?utf-8?B?cytVZHZ2MkI0elJvZlJXL2gwSU43eTY5YWxNZWM4VWREL3BEdTlTTWdsWldI?=
 =?utf-8?Q?LYTZWUGmngl+gNe0L1KaoSk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B87FC37FE19BBB4384D32D5842B950BD@prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8062.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e660ef71-97ef-42e2-920f-08db8dfa3de3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 17:03:32.2395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3da4b9UiGRgEO3q4dkLQJeGOYJU/qIDYAEpJLO5TQtmfwOcNFkyZ1DepaK6x1IVhMpLFYMtQ4fNN8g/5nR47L4dZl5qmqBImeosDrsjWT9yLQuyEAhiJJjay+xLuyq7y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7599
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBTdXp1a2ksDQoNCk9uIDcvMjYvMjAyMyA5OjU5IEFNLCBTdXp1a2kgSyBQb3Vsb3NlIHdy
b3RlOg0KPiBPbiAxMC8wNy8yMDIzIDA3OjI0LCBBbnNodW1hbiBLaGFuZHVhbCB3cm90ZToNCj4+
IENvcmVTaWdodCBFVE00eCBkZXZpY2VzIGNvdWxkIGJlIGFjY2Vzc2VkIGVpdGhlciB2aWEgTU1J
TyAoaGFuZGxlZCB2aWENCj4+IGFtYmFfZHJpdmVyKSBvciBDUFUgc3lzdGVtIGluc3RydWN0aW9u
cyAoaGFuZGxlZCB2aWEgcGxhdGZvcm0gZHJpdmVyKS4NCj4+IEJ1dA0KPj4gdGhpcyBoYXMgdGhl
IGZvbGxvd2luZyBpc3N1ZXMgOg0KPj4NCj4+IMKgwqAgLSBFYWNoIG5ldyBDUFUgY29tZXMgdXAg
d2l0aCBpdHMgb3duIFBJRCBhbmQgdGh1cyB3ZSBuZWVkIHRvIGtlZXAgb24NCj4+IMKgwqDCoMKg
IGFkZGluZyB0aGUgImtub3duIiBQSURzIHRvIGdldCBpdCB3b3JraW5nIHdpdGggQU1CQSBkcml2
ZXIuIFdoaWxlDQo+PiDCoMKgwqDCoCB0aGUgRVRNNCBhcmNoaXRlY3R1cmUgKGFuZCBDb3JlU2ln
aHQgYXJjaGl0ZWN0dXJlKSBkZWZpbmVzIHdheSB0bw0KPj4gwqDCoMKgwqAgaWRlbnRpZnkgYSBk
ZXZpY2UgYXMgRVRNNC4gVGh1cyBvbGRlciBrZXJuZWxzwqAgd29uJ3QgYmUgYWJsZSB0bw0KPj4g
wqDCoMKgwqAgImRpc2NvdmVyIiBhIG5ld2VyIENQVSwgdW5sZXNzIHdlIGFkZCB0aGUgUElEcy4N
Cj4+DQo+PiDCoMKgIC0gV2l0aCBBQ1BJLCB0aGUgRVRNNHggZGV2aWNlcyBoYXZlIHRoZSBzYW1l
IEhJRCB0byBpZGVudGlmeSB0aGUNCj4+IGRldmljZQ0KPj4gwqDCoMKgwqAgaXJyZXNwZWN0aXZl
IG9mIHRoZSBtb2RlIG9mIGFjY2Vzcy4gVGhpcyBjcmVhdGVzIGEgcHJvYmxlbSB3aGVyZSB0d28N
Cj4+IMKgwqDCoMKgIGRpZmZlcmVudCBkcml2ZXJzIChib3RoIEFNQkEgYmFzZWQgZHJpdmVyIGFu
ZCBwbGF0Zm9ybSBkcml2ZXIpIHdvdWxkDQo+PiDCoMKgwqDCoCBob29rIGludG8gdGhlICJISUQi
IGFuZCBjb3VsZCBjb25mbGljdC4gZS5nLiwgaWYgQU1CQSBkcml2ZXIgZ2V0cw0KPj4gwqDCoMKg
wqAgaG9sZCBvZiBhIG5vbi1NTUlPIGRldmljZSwgdGhlIHByb2JlIGZhaWxzLiBJZiB3ZSBoYXZl
IHNpbmdsZSBkcml2ZXINCj4+IMKgwqDCoMKgIGhvb2tlZCBpbnRvIHRoZSBnaXZlbiAiSElEIiwg
d2UgY291bGQgaGFuZGxlIHRoZW0gc2VhbWxlc3NseSwNCj4+IMKgwqDCoMKgIGlycmVzcGVjdGl2
ZSBvZiB0aGUgbW9kZSBvZiBhY2Nlc3MuDQo+Pg0KPj4gwqDCoCAtIENvcmVTaWdodCBpcyBoZWF2
aWx5IGRlcGVuZGVudCBvbiB0aGUgcnVudGltZSBwb3dlciBtYW5hZ2VtZW50LiBXaXRoDQo+PiDC
oMKgwqDCoCBBQ1BJLCBhbWJhX2RyaXZlciBkb2Vzbid0IGdldCB1cyBhbnl3aGVyZSB3aXRoIGhh
bmRsaW5nIHRoZSBwb3dlcg0KPj4gwqDCoMKgwqAgYW5kIHRodXMgb25lIG5lZWQgdG8gYWx3YXlz
IHR1cm4gdGhlIHBvd2VyIE9OIHRvIHVzZSB0aGVtLiBNb3ZpbmcgdG8NCj4+IMKgwqDCoMKgIHBs
YXRmb3JtIGRyaXZlciBnaXZlcyB1cyB0aGUgcG93ZXIgbWFuYWdlbWVudCBmb3IgZnJlZS4NCj4+
DQo+PiBEdWUgdG8gYWxsIG9mIHRoZSBhYm92ZSwgd2UgYXJlIG1vdmluZyBBQ1BJIE1NSU8gYmFz
ZWQgZXRtNHggZGV2aWNlcw0KPj4gdG8gYmUNCj4+IHN1cHBvcnRlZCB2aWEgdGhhIHBsYXRmb3Jt
IGRyaXZlci4gVGhlIHNlcmllcyBtYWtlcyB0aGUgZXhpc3RpbmcgcGxhdGZvcm0NCj4+IGRyaXZl
ciBnZW5lcmljIHRvIGhhbmRsZSBib3RoIHR5cGUgb2YgdGhlIGFjY2VzcyBtb2Rlcy4gQWx0aG91
Z2ggZXhpc3RpbmcNCj4+IEFNQkEgZHJpdmVyIHdvdWxkIHN0aWxsIGNvbnRpbnVlIHRvIHN1cHBv
cnQgRFQgYmFzZWQgZXRtNHggTU1JTyBkZXZpY2VzLg0KPj4gQWx0aG91Z2ggc29tZSBwcm9ibGVt
cyBzdGlsbCByZW1haW4sIHN1Y2ggYXMgbWFudWFsbHkgYWRkaW5nIFBJRHMgZm9yIGFsbA0KPj4g
bmV3IEFNQkEgRFQgYmFzZWQgZGV2aWNlcy4NCj4+DQo+PiBUaGUgc2VyaWVzIGFwcGxpZXMgb24g
Ni41LXJjMS4NCj4+DQo+PiBDaGFuZ2VzIGluIFY2Og0KPj4NCj4+IC0gUmViYXNlZCBvbiA2LjUt
cmMxDQo+Pg0KPiANCj4gSSBoYXZlIHF1ZXVlZCB0aGlzIHZlcnNpb24gZm9yIHY2LjYsIHNob3Vs
ZCBhcHBlYXIgb24gY29yZXNpZ2h0L25leHQgc29vbi4NCj4gDQo+IFN1enVraQ0KDQpJcyB0aGVy
ZSBhbnl3YXkgdG8gcXVldWUgdGhpcyBmb3IgNi41PyBPciBoYXMgdGhhdCBzaGlwIHNhaWxlZD8N
Cg0KVGhhbmtzLA0KDQpTdGV2ZSBDLg0K
