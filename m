Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811FB7C71DC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346441AbjJLPwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347251AbjJLPw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:52:29 -0400
Received: from DM4PR02CU001.outbound.protection.outlook.com (mail-centralusazon11012012.outbound.protection.outlook.com [52.101.63.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03223C6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:52:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEUuN99sKxJu5JyrYENSjPgUiPpDXIbR6BrAyukVmTNCFn6fSNkVvoX4R7CwucPrfB2Zs3yntVGGX1EDNxE7Gcc0KBy6XdJoMy/1MD0nTUrrq6ZPVITCx7425XmcqgOS9pYHMsyISNQtWSrwu1hxc95F7jfu2ZB/4s66svS4NiRY15Xflmp0FEuER9BLBZm5Ve0/ZryzYLwgEtURYFpalOcZ5Tbc+Vf86tKdp1sa9WhdA+377yIkDokjP5jwq677Bp7Giu5LxSBcnp/CbaxwdfsJ1PZB/tGmrsYSciLmnsPWV+gMWzKAqCwrsdFXVtxLX/jNAhrRz+O0MN/Bhpqvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdTxAIb3HcgJLT0RNsvAaBlvJ5Emgtlb0OaN4vTa7wE=;
 b=JzxFW2wr2oD62tnSrYaRjnZz50dYp4UYGfi0zCugPxfiGdWZF+eE4k4DEOg67Q0Jlu0DrM8TlYlpHaAg+RC9k14y7d47hhnH4Hv/rXYNM5qDVEXGXpf8ecMC3lfTmKm+ntvijV/OzPQnjstkdMssRl8UAZiFMgTmiuCwrPKcmB0j3Smiy3Vs0BDSRz5z5IGFXtBRBYS9CYbbJfYUyrOnFPJlSDb1sVe/Zdr9XvnNhF7/4S+YYQcH93dgSqsc2boykSWEz5RuFHZ5O0s82zafIkRkBB+p2Vgr85E55i2t3g6XfHO1p8S4VaqapCDzrhP8Rd5ObsTF1Gkl0kMNJGaMeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdTxAIb3HcgJLT0RNsvAaBlvJ5Emgtlb0OaN4vTa7wE=;
 b=aJ3bIo5rEV14cmWggHJeZdExdTM0tnxm8OueFiOFbD87Ymdg7jIiBO59CcrR0BNz/EgpvoDsCxWxycJHevmr9pQNenzl9JqeqrMaQLMQKqXBDj3gHDiM81/s8MPezSJ0yOPe/PM/JlAOePh2hYHx6Oc/3WcIbaHlOAb5GX305s8=
Received: from SA1PR05MB8311.namprd05.prod.outlook.com (2603:10b6:806:1e2::19)
 by SN7PR05MB9282.namprd05.prod.outlook.com (2603:10b6:806:272::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 15:52:25 +0000
Received: from SA1PR05MB8311.namprd05.prod.outlook.com
 ([fe80::cbd2:31a1:4175:2d]) by SA1PR05MB8311.namprd05.prod.outlook.com
 ([fe80::cbd2:31a1:4175:2d%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:52:25 +0000
From:   Ankit Jain <ankitja@vmware.com>
To:     Yury Norov <yury.norov@gmail.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "qyousef@layalina.io" <qyousef@layalina.io>,
        "pjt@google.com" <pjt@google.com>,
        "joshdon@google.com" <joshdon@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Srinidhi Rao <srinidhir@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Vamsi Krishna Brahmajosyula <vbrahmajosyula@vmware.com>,
        Ajay Kaher <akaher@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH RFC] cpumask: Randomly distribute the tasks within
 affinity mask
Thread-Topic: [PATCH RFC] cpumask: Randomly distribute the tasks within
 affinity mask
Thread-Index: AQHZ/BNsdynFPMpzJ0mlzh+uh57DDLBFSnoAgAEFggA=
Date:   Thu, 12 Oct 2023 15:52:24 +0000
Message-ID: <1635E7EB-5FD5-42DA-8AA5-61450E415779@vmware.com>
References: <20231011071925.761590-1-ankitja@vmware.com>
 <ZSc60HJ8mZGhLkAn@yury-ThinkPad>
In-Reply-To: <ZSc60HJ8mZGhLkAn@yury-ThinkPad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR05MB8311:EE_|SN7PR05MB9282:EE_
x-ms-office365-filtering-correlation-id: 19251921-aa8f-4b04-d182-08dbcb3b3a8e
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IVYLTKOFD81j7J2WyhxS37cnRfLs/VEujmOCQ8tzYobqsGtVw7gtRVt+HrQ8KP4ezkyQNQJKowUeRHzLSCtX/NBRiYQbHPQ+ySqc0gsbhPNIJPHKgRPmmI8OYCbQiXN83dUYSuG+4W2eyhdyf9elpyjOGOOyyQS5J0e5JoHRTYJ0uKb3mkfbkEwHAWed1KZP7fiDBBgeSvC9brpcVXJvznudat2rpfSFlbC+z6vVEjcu3cMA1SwsZKjkMW+HNt9hsXgdgqFcqh2oYEazLou0PH+85ZgFiTUmwfWWK9SIM8p4Y5x4plCCq386aZgAiG2gdYdtfFnRiuX96F7jr4gO4eiWXw7tZFScRYPNXQsCV4CuHd8nssG/jKfjuvMU0DC+PpYi0ZwajYyXBafZNCPYdLzzvjUGAdD1IGosSubN5TV8fIuee6OWg5B3izs/3WBWwVKih5OdDFck7nJELo5ZfYsW/GgQiijR5vzMXDqSCOqTbq5gHH1+ptz/PCEcPtdcOkaEsSZR4VZC55cZRpN27D3J7dc1sHSGvaGwnhjiCk8P4o1FKwwHfx8voIk3bYRiYXpt1IINADpJLNkPiZksMkoVx3mgbjicAOrrlTdrVO6jYt2n62jqSNFRyeo3gwI1K8DHMRev4ScdtR4DXyf0k4/6Of5iarW8TzmgHjheiqj1pLmzwCzS6Y7XHLtM46PSRMX6Cw+5fMgkk4MaTnfARW2wMoPB19vAsXYxmF6j1iY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR05MB8311.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(53546011)(6512007)(2616005)(86362001)(36756003)(38100700002)(33656002)(122000001)(38070700005)(83380400001)(2906002)(7416002)(6486002)(71200400001)(6506007)(478600001)(8936002)(8676002)(6916009)(4326008)(26005)(316002)(41300700001)(66446008)(66556008)(76116006)(66946007)(91956017)(54906003)(64756008)(66476007)(5660300002)(45980500001)(357404004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qi80YmRleDdUME93TEtNbkkwTnZlbjF0SXE1N24yeDIvRUo0bHh1ZHYvUEhM?=
 =?utf-8?B?UHBpend3LzQzSkhTZnNGSXFjSk8yNVFtemI4dkxMMGkyd2pNd2xJL2ZTeDFB?=
 =?utf-8?B?aTN3alhBc1hETDdRcmNObDFKNHppOEpYTXgvV3N3ZmxlL245d043M044Q3NK?=
 =?utf-8?B?R25oQk1YYVFONFdmaGs0c0pydzliK0hSbm5zK2JUdUlGYndENG1qYzllUHIr?=
 =?utf-8?B?TzRMWWRLcXYzMG1CdmtVYkUrU1RxWEJSanY1ejVFalM4RmhaZnVnbWZKR1N6?=
 =?utf-8?B?Q3pRenAvRkpnRFB4Z1hjY3Flc1pUTHZMb2c1d3Z2citZNEw5MW9lYWtpbHI4?=
 =?utf-8?B?Q01DelJCaGdkNHBYTlkyU3FaQTAzRTJ2c0QzWVZmNjRmQ2kzbE0zN24vOWRB?=
 =?utf-8?B?SzNqM2xvOUhwQVRwVHZHUlJhVWxzYnhjdmFoQlNhNDFRdytUaU0vVmVCNVhj?=
 =?utf-8?B?azErUWhWNm9tampOdkRUeGhESkZDQTVJYXFVcklpcXE0YXAvd21oazcrM09o?=
 =?utf-8?B?UUJiU2NlcTdPdWVSRmpRZ2RtWnQzOUU4WjA1MW1tUFNXdkNTNEI0ME1sdzFJ?=
 =?utf-8?B?TGNOZ05yMXpUMElFY0k4cDA2a1FnYmVYYkloTWMyME43cGlUT1g4Umw3Q21D?=
 =?utf-8?B?dlVOakNVVENodGwxWDd5OHd6ZG1aNU1WaTk1OGZaT0NLeEtzTzJ6L3pXdU9p?=
 =?utf-8?B?RkI4QkR2QThMYnpwUVZVYWc4WDFqdmVGV2Z6U2hReUs4MjR0MmJCdEs5TzRR?=
 =?utf-8?B?bU4zTFNuOXNiMXFNTSsxMnNBWFFGSVJBTVU2cDU2UE1lVlF1akgwbHFZYUVT?=
 =?utf-8?B?amxWSFlkK0JsYzJQaWFvcVBUejJBdlJseEdHT0RKN2t2UFhyQVQ1dlNsT1kv?=
 =?utf-8?B?V0lqOTY2aEZLbVc2aG9iN1dJYy8zdmFVR3FGQk14ZTY5UktJWHpEbVU0NUJM?=
 =?utf-8?B?NGVaaFdERFBnNm0ySVp6ckNNSnlrSkRRMkdIeTU1M2IvbTdmZlYrZmFYM1hi?=
 =?utf-8?B?TC9VWXFYcTUrUFVKRzZhdDdUeHZ4YVdGaEt1K3J3MG9VL29qYzY0NjFIYURF?=
 =?utf-8?B?Q2g5Tk4raWJKR3VNMXovSStpZUhPazdCcnMxUzNpeTRLTkxpc05uZWRHdG42?=
 =?utf-8?B?ZEZheUljc2dOMm5zbXJIdGR1dzhhSTBremJjSHRkUlJDZkczOUNBQUhXQm1M?=
 =?utf-8?B?L2pIMjhpVWNLNk16NEdERDEzK21pMnQ4WTVrZndxUjdaQmczby9NbHUzQUJj?=
 =?utf-8?B?KzhPVldYMGdhNFNmZ21kTk9VY3Zld0lXQzIxUHRsOHdjcUhHMUZSaFZpNlJ5?=
 =?utf-8?B?Q2NvTWVxbG4xK1FDWFAxWWtqblRkaTNkcXFkYi9NR2hvUTFES3FCMnJiRVdn?=
 =?utf-8?B?cVl5VVJrZTB1TkNkNEVWdmc2MW5wNDcyOWx6alVkWUY5U0dEOERHVVJTSGUw?=
 =?utf-8?B?QjRLS3RGNFM2dkRrWXZMRmozZUcveEFCWXZRVVA5dU1sT0tvTHBXMXV2bGxR?=
 =?utf-8?B?cFUyRU9tcHBrL1dTOE4waXpnd1g5YmNuWnN3aGhlZVFnZmxYZHVBcXY2RlF0?=
 =?utf-8?B?YjR1WFlCVS9pbzBLYThiUVYzT1RGK0paSDdydUN1cFdLS21hYTZZVEZpQXEx?=
 =?utf-8?B?dXFicUIreDU4V0hNNVpUYUZzMnB1aEhuc0xHbzE4T2Z6R244MlYrT2JncVpK?=
 =?utf-8?B?emlQbHlhdVhCZlEwbktLVStXdUVuWm9QT2hYRnlDQmlrNVVOSVpBbE1hbDRi?=
 =?utf-8?B?clB4cC9LSmNnOG9tVUhVU3I3OVFwUzh4Y3NJeW5KbFdiV25pTFFBQ1k4YmRP?=
 =?utf-8?B?VEszTFhWd0ErbnBRcjdyeWJRWDU4R05pUmF4Wjh6djArdHdMR3dDSmVVOEhv?=
 =?utf-8?B?dFRKc01nSWZydVhQU1NXZ09NUG42b25JcmtvbVZPV0NjUTJPVURYQzZKZ2gy?=
 =?utf-8?B?WTExTk5YblpWUXBUNjNxWUZ4SnpjZWZLL2orNkpJeDhWSlNPbjcrUWUxTi9s?=
 =?utf-8?B?YUdERGRqNTJSc0hiMjlKaDFrUXFEaUNvalh0Tkt0RzY0cllNb3lnOFFDa3NC?=
 =?utf-8?B?bmJkZjhZcnlrM3UrWVJCT2h0cUxXbGF2UWN2d3ZyWHp3SzU1WlJoN2hqYTlu?=
 =?utf-8?Q?0cljgadHQ/YWtW4JKugbyiZ+C?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69894A426A29344F8264D3498E0B3653@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR05MB8311.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19251921-aa8f-4b04-d182-08dbcb3b3a8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 15:52:24.8965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Tz5IjweFFC9ergO7lJ0xZf5CTBvUJAZeJhU0eJ0suuIesFP5wJGiGNp7d6sBtK2gYKVbUDe9vZwHZpqUCpcBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR05MB9282
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMTItT2N0LTIwMjMsIGF0IDU6NDYgQU0sIFl1cnkgTm9yb3YgPHl1cnkubm9yb3ZA
Z21haWwuY29tPiB3cm90ZToNCj4gDQo+ICEhIEV4dGVybmFsIEVtYWlsDQo+IA0KPiBPbiBXZWQs
IE9jdCAxMSwgMjAyMyBhdCAxMjo0OToyNVBNICswNTMwLCBBbmtpdCBKYWluIHdyb3RlOg0KPj4g
Y29tbWl0IDQ2YTg3YjM4NTFmMCAoInNjaGVkL2NvcmU6IERpc3RyaWJ1dGUgdGFza3Mgd2l0aGlu
IGFmZmluaXR5IG1hc2tzIikNCj4+IGFuZCBjb21taXQgMTRlMjkyZjhkNDUzICgic2NoZWQscnQ6
IFVzZSBjcHVtYXNrX2FueSpfZGlzdHJpYnV0ZSgpIikNCj4+IGludHJvZHVjZWQgdGhlIGxvZ2lj
IHRvIGRpc3RyaWJ1dGUgdGhlIHRhc2tzIGF0IGluaXRpYWwgd2FrZXVwIG9uIGNwdXMNCj4+IHdo
ZXJlIGxvYWQgYmFsYW5jaW5nIHdvcmtzIHBvb3JseSBvciBkaXNhYmxlZCBhdCBhbGwgKGlzb2xh
dGVkIGNwdXMpLg0KPj4gDQo+PiBUaGVyZSBhcmUgY2FzZXMgaW4gd2hpY2ggdGhlIGRpc3RyaWJ1
dGlvbiBvZiB0YXNrcw0KPj4gdGhhdCBhcmUgc3Bhd25lZCBvbiBpc29sY3B1cyBkb2VzIG5vdCBo
YXBwZW4gcHJvcGVybHkuDQo+PiBJbiBwcm9kdWN0aW9uIGRlcGxveW1lbnQsIGluaXRpYWwgd2Fr
ZXVwIG9mIHRhc2tzIHNwYXduIGZyb20NCj4+IGhvdXNla2VlcGluZyBjcHVzIHRvIGlzb2xjcHVz
W25vaHpfZnVsbCBjcHVdIGhhcHBlbnMgb24gZmlyc3QgY3B1DQo+PiB3aXRoaW4gaXNvbGNwdXMg
cmFuZ2UgaW5zdGVhZCBvZiBkaXN0cmlidXRlZCBhY3Jvc3MgaXNvbGNwdXMuDQo+PiANCj4+IFVz
YWdlIG9mIGRpc3RyaWJ1dGVfY3B1X21hc2tfcHJldiBmcm9tIG9uZSBwcm9jZXNzZXMgZ3JvdXAs
DQo+PiB3aWxsIGNsb2JiZXIgcHJldmlvdXMgdmFsdWUgb2YgYW5vdGhlciBvciBvdGhlciBncm91
cHMgYW5kIHZpY2UtdmVyc2EuDQo+PiANCj4+IFdoZW4gaG91c2VrZWVwaW5nIGNwdXMgc3Bhd24g
bXVsdGlwbGUgY2hpbGQgdGFza3MgdG8gd2FrZXVwIG9uDQo+PiBpc29sY3B1c1tub2h6X2Z1bGwg
Y3B1XSwgdXNpbmcgY3B1c2V0cy5jcHVzL3NjaGVkX3NldGFmZmluaXR5KCksDQo+PiBkaXN0cmli
dXRpb24gaXMgY3VycmVudGx5IHBlcmZvcm1lZCBiYXNlZCBvbiBwZXItY3B1DQo+PiBkaXN0cmli
dXRlX2NwdV9tYXNrX3ByZXYgY291bnRlci4NCj4+IEF0IHRoZSBzYW1lIHRpbWUsIG9uIGhvdXNl
a2VlcGluZyBjcHVzIHRoZXJlIGFyZSBwZXJjcHUNCj4+IGJvdW5kZWQgdGltZXJzIGludGVycnVw
dC9yY3UgdGhyZWFkcyBhbmQgb3RoZXIgc3lzdGVtL3VzZXIgdGFza3MNCj4+IHdvdWxkIGJlIHJ1
bm5pbmcgd2l0aCBhZmZpbml0eSBhcyBob3VzZWtlZXBpbmcgY3B1cy4gSW4gYSByZWFsLWxpZmUN
Cj4+IGVudmlyb25tZW50LCBob3VzZWtlZXBpbmcgY3B1cyBhcmUgbXVjaCBmZXdlciBhbmQgYXJl
IHRvbyBtdWNoIGxvYWRlZC4NCj4+IFNvLCBkaXN0cmlidXRlX2NwdV9tYXNrX3ByZXYgdmFsdWUg
ZnJvbSB0aGVzZSB0YXNrcyBpbXBhY3RzDQo+PiB0aGUgb2Zmc2V0IHZhbHVlIGZvciB0aGUgdGFz
a3Mgc3Bhd25pbmcgdG8gd2FrZXVwIG9uIGlzb2xjcHVzIGFuZA0KPj4gdGh1cyBtb3N0IG9mIHRo
ZSB0YXNrcyBlbmQgdXAgd2FraW5nIHVwIG9uIGZpcnN0IGNwdSB3aXRoaW4gdGhlDQo+PiBpc29s
Y3B1cyBzZXQuDQo+PiANCj4+IFN0ZXBzIHRvIHJlcHJvZHVjZToNCj4+IEtlcm5lbCBjbWRsaW5l
IHBhcmFtZXRlcnM6DQo+PiBpc29sY3B1cz0yLTUgc2tld190aWNrPTEgbm9oej1vbiBub2h6X2Z1
bGw9Mi01DQo+PiByY3Vfbm9jYnM9Mi01IHJjdV9ub2NiX3BvbGwgaWRsZT1wb2xsIGlycWFmZmlu
aXR5PTAtMQ0KPj4gDQo+PiAqIHBpZD0kKGVjaG8gJCQpDQo+PiAqIHRhc2tzZXQgLXBjIDAgJHBp
ZA0KPj4gKiBjYXQgbG9vcC1ub3JtYWwuYw0KPj4gaW50IG1haW4odm9pZCkNCj4+IHsNCj4+ICAg
ICAgICB3aGlsZSAoMSkNCj4+ICAgICAgICAgICAgICAgIDsNCj4+ICAgICAgICByZXR1cm4gMDsN
Cj4+IH0NCj4+ICogZ2NjIC1vIGxvb3Atbm9ybWFsIGxvb3Atbm9ybWFsLmMNCj4+ICogZm9yIGkg
aW4gezEuLjUwfTsgZG8gLi9sb29wLW5vcm1hbCAmIGRvbmUNCj4+ICogcGlkcz0kKHBzIC1hIHwg
Z3JlcCBsb29wLW5vcm1hbCB8IGN1dCAtZCcgJyAtZjUpDQo+PiAqIGZvciBpIGluICRwaWRzOyBk
byB0YXNrc2V0IC1wYyAyLTUgJGkgOyBkb25lDQo+PiANCj4+IEV4cGVjdGVkIG91dHB1dDoNCj4+
ICogQWxsIDUwIOKAnGxvb3Atbm9ybWFs4oCdIHRhc2tzIHNob3VsZCB3YWtlIHVwIG9uIGNwdTIt
NQ0KPj4gZXF1YWxseSBkaXN0cmlidXRlZC4NCj4+ICogcHMgLWVMbyBjcHVpZCxwaWQsdGlkLHBw
aWQsY2xzLHBzcixjbHMsY21kIHwgZ3JlcCAiXiAgICBbMjM0NV0iDQo+PiANCj4+IEFjdHVhbCBv
dXRwdXQ6DQo+PiAqIEFsbCA1MCDigJxsb29wLW5vcm1hbOKAnSB0YXNrcyBnb3Qgd29rZW4gdXAg
b24gY3B1MiBvbmx5DQo+PiANCj4+IEFuYWx5c2lzOg0KPj4gVGhlcmUgYXJlIHBlcmNwdSBib3Vu
ZGVkIHRpbWVyIGludGVycnVwdC9yY3UgdGhyZWFkcyBhY3Rpdml0aWVzDQo+PiBnb2luZyBvbiBl
dmVyeSBmZXcgbWljcm9zZWNvbmRzIG9uIGhvdXNla2VlcGluZyBjcHVzLCBleGVyY2lzaW5nDQo+
PiBmaW5kX2xvd2VzdF9ycSgpIC0+IGNwdW1hc2tfYW55X2FuZF9kaXN0cmlidXRlKCkvY3B1bWFz
a19hbnlfZGlzdHJpYnV0ZSgpDQo+PiBTbywgcGVyIGNwdSB2YXJpYWJsZSBkaXN0cmlidXRlX2Nw
dV9tYXNrX3ByZXYgZm9yIGhvdXNla2VlcGluZyBjcHVzDQo+PiBrZWVwIG9uIGdldHRpbmcgc2V0
IHRvIGhvdXNla2VlcGluZyBjcHVzLiBCYXNoL2RvY2tlciBwcm9jZXNzZXMNCj4+IGFyZSBzaGFy
aW5nIHNhbWUgcGVyIGNwdSB2YXJpYWJsZSBhcyB0aGV5IHJ1biBvbiBob3VzZWtlZXBpbmcgY3B1
cy4NCj4+IFRodXMgaW50ZXJzZWN0aW9uIG9mIGNsb2JiZXJlZCBkaXN0cmlidXRlX2NwdV9tYXNr
X3ByZXYgYW5kDQo+PiBuZXcgbWFzayhpc29sY3B1cykgcmV0dXJuIGFsd2F5cyBmaXJzdCBjcHUg
d2l0aGluIHRoZSBuZXcgbWFzayhpc29sY3B1cykNCj4+IGluIGFjY29yZGFuY2UgdG8gdGhlIGxv
Z2ljIG1lbnRpb25lZCBpbiBjb21taXRzIGFib3ZlLg0KPj4gDQo+PiBGaXggdGhlIGlzc3VlIGJ5
IHVzaW5nIHJhbmRvbSBjb3JlcyBvdXQgb2YgdGhlIGFwcGxpY2FibGUgQ1BVIHNldA0KPj4gaW5z
dGVhZCBvZiByZWx5aW5nIG9uIGRpc3RyaWJ1dGVfY3B1X21hc2tfcHJldi4NCj4+IA0KPj4gRml4
ZXM6IDQ2YTg3YjM4NTFmMCAoInNjaGVkL2NvcmU6IERpc3RyaWJ1dGUgdGFza3Mgd2l0aGluIGFm
ZmluaXR5IG1hc2tzIikNCj4+IEZpeGVzOiAxNGUyOTJmOGQ0NTMgKCJzY2hlZCxydDogVXNlIGNw
dW1hc2tfYW55Kl9kaXN0cmlidXRlKCkiKQ0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBBbmtpdCBK
YWluIDxhbmtpdGphQHZtd2FyZS5jb20+DQo+PiAtLS0NCj4+IGxpYi9jcHVtYXNrLmMgfCA0MCAr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAxIGZpbGUgY2hhbmdl
ZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQg
YS9saWIvY3B1bWFzay5jIGIvbGliL2NwdW1hc2suYw0KPj4gaW5kZXggYTdmZDAyYjVhZTI2Li45
NWE3YzFiNDBlOTUgMTAwNjQ0DQo+PiAtLS0gYS9saWIvY3B1bWFzay5jDQo+PiArKysgYi9saWIv
Y3B1bWFzay5jDQo+PiBAQCAtMTU1LDQ1ICsxNTUsNDcgQEAgdW5zaWduZWQgaW50IGNwdW1hc2tf
bG9jYWxfc3ByZWFkKHVuc2lnbmVkIGludCBpLCBpbnQgbm9kZSkNCj4+IH0NCj4+IEVYUE9SVF9T
WU1CT0woY3B1bWFza19sb2NhbF9zcHJlYWQpOw0KPj4gDQo+PiAtc3RhdGljIERFRklORV9QRVJf
Q1BVKGludCwgZGlzdHJpYnV0ZV9jcHVfbWFza19wcmV2KTsNCj4+IC0NCj4+IC8qKg0KPj4gICog
Y3B1bWFza19hbnlfYW5kX2Rpc3RyaWJ1dGUgLSBSZXR1cm4gYW4gYXJiaXRyYXJ5IGNwdSB3aXRo
aW4gc3JjMXAgJiBzcmMycC4NCj4+ICAqIEBzcmMxcDogZmlyc3QgJmNwdW1hc2sgZm9yIGludGVy
c2VjdGlvbg0KPj4gICogQHNyYzJwOiBzZWNvbmQgJmNwdW1hc2sgZm9yIGludGVyc2VjdGlvbg0K
Pj4gICoNCj4+IC0gKiBJdGVyYXRlZCBjYWxscyB1c2luZyB0aGUgc2FtZSBzcmNwMSBhbmQgc3Jj
cDIgd2lsbCBiZSBkaXN0cmlidXRlZCB3aXRoaW4NCj4+IC0gKiB0aGVpciBpbnRlcnNlY3Rpb24u
DQo+PiArICogSXRlcmF0ZWQgY2FsbHMgdXNpbmcgdGhlIHNhbWUgc3JjcDEgYW5kIHNyY3AyIHdp
bGwgYmUgcmFuZG9tbHkgZGlzdHJpYnV0ZWQNCj4+ICsgKiB3aXRoaW4gdGhlaXIgaW50ZXJzZWN0
aW9uLg0KPj4gICoNCj4+ICAqIFJldHVybnMgPj0gbnJfY3B1X2lkcyBpZiB0aGUgaW50ZXJzZWN0
aW9uIGlzIGVtcHR5Lg0KPj4gICovDQo+IA0KPiBUaGlzIGhhcyBiZWVuIGRpc2N1c3NlZCBhIHdo
aWxlIGFnbywgYW5kIHRoZSBib3R0b21saW5lIGlzIHRoYXQgJ2FueScNCj4gaXMgbm90IHRoZSBz
YW1lIGFzICdyYW5kb20nLiBJbiBwcmFjdGljZSwgaXQgbWVhbnMgdGhhdCBnZXR0aW5nICdhbnkn
DQo+IGNwdSBpcyBjaGVhcGVyIHRoYW4gZ2V0dGluZyByYW5kb21pemVkIG9uZS4NCj4gDQoNClRo
YW5rIHlvdSBZdXJ5IGZvciB0aGlzIGNsYXJpZmljYXRpb24uDQpNeSBvYmplY3RpdmUgYmVoaW5k
IHRoaXMgY2hhbmdlIHdhcyBkaXN0cmlidXRpb24gb2YgdGFza3Mgb24gY3B1DQp3aXRoIG5vIGxv
YWQgYmFsYW5jaW5nKGkuZS4gaXNvbGNwdXMpIGV2ZW4gYXQgc29tZSANCmhpZ2hlciBjb3N0KOKA
nHJhbmRvbeKAnSBsb2dpYykuDQpIb3dldmVyLCBJIHJlYWxpemUgdGhhdCBkaXN0cmlidXRpb24g
b24gaXNvbGNwdXMgc2hvdWxkIHByb2JhYmx5DQpiZSBhZGRyZXNzZWQgaW4gdXNlcnNwYWNlLg0K
DQo=
