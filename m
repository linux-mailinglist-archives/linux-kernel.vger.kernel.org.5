Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC9076D7B9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjHBT3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjHBT27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:28:59 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021017.outbound.protection.outlook.com [52.101.62.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405001996
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 12:28:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=He80X8JiN9/SV5zFxLpNGgEnCVVs4gef6f0c+tIfZWndJ9lYXOrnN1T7APkd6qZLwwjvQCOzyABXHb+wuR7QBHt/2ujvHAyH8fSVaF8M7VsP0yqizyCgRdnwk6jn23u/NzK4fnxUHU4ZHUUiWdZ8dvApOiw40YoJFHXtxwDiOWRJrJwFBkqebtET2cpClQ+m4u9CaM9VQQQtWJlG5kyk3pP7vvH29vvGAa9gT1XtHWxM1ndfkjfHuI2mgG2NfMFp5ZZG8eXV/hnJ2gUnnyFo58+mMutSXki8J/ZQKpVtKwpwpwG6wTxLHKGwZob6WFtxjW9tsDdZzQPewcQ2Ye5Wxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0wYueuhg7oTGRmh7YxHVUUyNMJPn3mvIoT+OK5aTzg=;
 b=jRgFKKWURs/BwXR2MxLBn0X+44IjPv/gVfBHxLfmbhSj90bZ7sr6cWOENeJgalWlKAOUfOEeuUA7mtvjWKo2O+CFMkruoi/MADgbZi75gfXyazIfIPC+Dsqr+cUOCy+X8CcQp/yZso6KwbGeK9WzaU5j9ue+jnlTXCK/Rt0Heezc639rBCd0Fj9am8ReOWdXtxc/UEio/2lEwFPPdh9UEdmL2U08TzfVpBlhZbgzXWMFMKnMMXW1oO8jWMo7dVPeRTekcsfMQtl4swo+21pNaBIoE96tecF+vXjxXgnJjUdJRpk+6sSFzEGHUbJfbt3U1pUYVrGBSZ71K6saSNQC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0wYueuhg7oTGRmh7YxHVUUyNMJPn3mvIoT+OK5aTzg=;
 b=hQV0hm4FsGHyznx6OXUBNT4ZqRNaw6o3y21omQEJLOWAmof9bitOewElqIvGFOEoDJG7CzsSQtU2Jc4pa3/UxC94CDf4P7ANmLKglh1YtFDxtdrAOpjLRWWhm3+d0l8Gb31dn0qffm8n+cn3MZ7Lequ/wRqZuMFIhPh8ddJQkxk=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3319.namprd21.prod.outlook.com (2603:10b6:8:7f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Wed, 2 Aug
 2023 19:28:48 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Wed, 2 Aug 2023
 19:28:48 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: RE: [patch V3 30/40] x86/cpu: Provide an AMD/HYGON specific topology
 parser
Thread-Topic: [patch V3 30/40] x86/cpu: Provide an AMD/HYGON specific topology
 parser
Thread-Index: AQHZxSsmvwsQPZpYBEGOBpq1nW/lTq/XY04Q
Date:   Wed, 2 Aug 2023 19:28:47 +0000
Message-ID: <BYAPR21MB1688C2B1723ADDA1640F956AD70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.418143974@linutronix.de>
In-Reply-To: <20230802101934.418143974@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=af8f03d3-aa1c-402f-a517-98fe532fb8f9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-02T19:23:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3319:EE_
x-ms-office365-filtering-correlation-id: 0341afbe-ca00-4458-ad0f-08db938eb1c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: abz4cwWVIuTCSJxK8oozCYNBdkIpEu38qks4OC1NGSfvRGj5xgMzrLzqCLnifNpwe7kgLwNXzEZ5Slg3qNysM87mKkP5PGzWP22DaXwSNdj6xOUPAYC7FBP2ZCQGp9cI8UWpQDVANskQuTLv6DgjcCdj0HMpLZcbYvWB+JA0K1hFafLvd7j5puJ+Cx3qaPa5i8+hR+mM/lToGeghwfZMNxIA/ZgD5380n1aX4qEoXDAhqATBXZZ9mHx4TC4xvjTc4q63kFuEmaqdoLlLS8y+K+kUKQOPDoTXwiY1Ri4I9a4Xc87ysKV3zgZehcTVoJS0zy5I5uIT64z9EXV4zUZdHNYtzaJQFkjhchDM2FlZrc1KtMNb/qSVHNGBhFpwwy6RBqjTUOdpGVsGNJSEtfn1sgvK/RQj36lgECGklDaDrYk92V7XjO46ZBCkuLUgZgne5vqV1T+8EQIvdqNYZhcBz8LGlNpF8c03LwO6lbA4AlEHg5nkLJqypFceKCWmkerpQY3UNHTsxtMmaYT28bYAKa9pefqnyZX5fbDr/dRSF0dKVlgnRUVmb9Z5hEb8ILxMTMBN+Gt8Hn/h7CffQkXOLElRyExooj/tQ5Ji/gpq84O+tYfWiiYLdCsW3DnGpqHrhsSZAwkItug6UeDKfF7RUydbiyuBi8eRh+eLv7iGpjs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(7696005)(122000001)(38100700002)(5660300002)(52536014)(7416002)(8676002)(8936002)(41300700001)(38070700005)(86362001)(786003)(316002)(82950400001)(66556008)(64756008)(66446008)(66476007)(82960400001)(55016003)(33656002)(66946007)(76116006)(9686003)(4326008)(6506007)(83380400001)(26005)(186003)(2906002)(8990500004)(478600001)(10290500003)(71200400001)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWx3VFBQSEtOWTJRWHRMU1B3SFc1ZFJlZUVUMGxWRUJFRXRvZEhKeHNmWTA3?=
 =?utf-8?B?WWpxNDh2eVIyRng4aWFhSUsvUUh0RURKM3dpOU1BWHo4TWFiSU5NUnorZEpu?=
 =?utf-8?B?bzUyb3psZHd6clg3MUpkM0RWSGNiY2VtaEdraDU0UXhDTFVzOC8xS2kxbWJB?=
 =?utf-8?B?a2wzY1NycVZ0NTlpS1lHOFNkVTJJVDQveGRFRGYrN1o0K1daYnliMGlTMUVm?=
 =?utf-8?B?cGh1Y0Zxc2R1My9NVHpkb1lGZ3VlM0lqQmJ3NnlzQ3R1ZVdXbVZRemJRMXZR?=
 =?utf-8?B?TTVXRmdGdVlidEV6ck8vcUxiaE9CRWtWU1pNYlVGTDJpNk5QZnRpeXUwdEMv?=
 =?utf-8?B?M21UL1NkcG9yZys3ZmJvWWNIWlhlMlpWc0tvTWFjVEhjbFR2S0l2UjIrZm9q?=
 =?utf-8?B?UVBFMVdjc2lSNXY0VmY4cjN1VGtyTlhsVUlDSkxtc0o4SitKZS96Ujk4K01Q?=
 =?utf-8?B?eGhFTHIySTVUQTRaZm5teTN3VmFEc2N0aWVySEt5VVVHSklQckpDTWRwK29Y?=
 =?utf-8?B?RUtQbVRKMGJSQTZuRWRHNUIxazFweUluOXBSekJjeEtueFJKcUZvcGIva25u?=
 =?utf-8?B?MktKNXJTd2RXVE1tRWdhME8wSGFXMy9sVzlxemhjeWc2Z29uWEdxRHJFd2t3?=
 =?utf-8?B?bHI5ajV4WGM1L2Y3OVhzRThMQXltYXIzZy9HbDJPOVRscjcxek0yZVdWQXor?=
 =?utf-8?B?dFJXYndXTjFXTFprOEV6YTd0VEFhdGFDWFZVczdPdWFhNWp1YTY2R0lzSThG?=
 =?utf-8?B?d1lhWERLMkNUZ2x1U1I2S0dGVUg3ekphY3ZVeHFxSlVsS29Va2VSa3lHdmw5?=
 =?utf-8?B?SUZFZHFaZ0I5dXpFaDJVV0Q2YnkvTnB1WCs4QWxIb2lVWlNmeUsyRVh3ZXRw?=
 =?utf-8?B?TURDeTRMdGFQQmROZzBjWnVObXJtVnNPNzN1dnVQa2RVS2duNGJGL1JaUTdR?=
 =?utf-8?B?SVZpR01WekI1MGcvMjhFL1EvdHRKMXVyZmhiT0JmQU9zNmpHQXk1REo3aGhj?=
 =?utf-8?B?SFpRMkJzNml4WGJnNis5YnVvN1NPS0JPTzJ2d2N3cTZFaVlUSGJJcHhkZHQ5?=
 =?utf-8?B?RitXeFdwWllxMVhnOVAzTkhBU3ZBUXg0VmtHMHppWS8rVzQ2VEpraXB2YU1x?=
 =?utf-8?B?eElybzhpdlZyWUdNZDd3djM1ekhFSklkM2lYODU4amZtLzFaN3hTZG9SY0tL?=
 =?utf-8?B?NFI3OXQzaHZRNjBhUkJST05iMDdpUjhtRFptTVA4bkhmTU5pRW9VNEQ0c3Iv?=
 =?utf-8?B?TzMxNEtteXU2Q01Nejc4VkZGZWF5ZXVTS0xDVzdwaml5U3BoMWJTVDk4bmxL?=
 =?utf-8?B?TW40RnhWZXpGUWdHVVdXNXdIRTZ6NllNMERSTFVHYmtwYnk2RjlySEcwcGI0?=
 =?utf-8?B?ZTZGbVpPR2Y3cllrTzIzNWNHRzZJaitUZi81SDRJUmpOb1BRWW9RQ3A3K2FR?=
 =?utf-8?B?V0l5NG9taDkvYUVSQ25mVm0yRTVQK29CTXRvU3lqVnVheXMySU54Rm5RNFo4?=
 =?utf-8?B?OHBMZ09nVVlaczBndkQxOFJURmhuL1pvVjJwQnpPK1V1cGFkSkcvY1ZOOEsx?=
 =?utf-8?B?VVhFTGorbTVnVnMzRlZQdHpKVDJSK0szUms4ZUJXMDJDeVJxcEJUVFZHSmFw?=
 =?utf-8?B?MDBjRmxyZzNRTk5IN0YyMk9EUm5rTVpKZENBSkx4dlRKTlhLZDhnakFYOWMz?=
 =?utf-8?B?ME0rZGNsRW9oeHVNaU9VdUZWaGM4cHpBWE5sWEVIck41U0RQVDlTM0FETW5u?=
 =?utf-8?B?SUFRN1R0bThEaU5HdGEyT0dRZW1Xc1oxUjdiUk5MMEZjcDh4RzYwQVlWdDg3?=
 =?utf-8?B?VjV4SlQxemdyTzVwa2R5V0JGT2FiZ2hrV05tSXRDZzgvQ2g2TGxNNFQwLzUw?=
 =?utf-8?B?dEt1ZFlvZnFuNDJDVDBiSVpoVXdUTmFNb2V1Zm9MNFE5M0VTZmNpTER5b3Rq?=
 =?utf-8?B?cVdJWlp0MVlqbVBTMU1zZ0xpVHpjc1l4amRkbko3WjRaR1ZoSGhnU0RlVUsv?=
 =?utf-8?B?VmlQdm9ReGxGcDY4M3pjNUEvdWlsMGxuLzAzbEtCakJodEllV0lXR0lscFkv?=
 =?utf-8?B?Rmx3enZramFtOTFPc2I2L2ZQNXFLRFdISk93bEFrUUJJNUhlR2l1WHhYWFdC?=
 =?utf-8?B?ZG5OL3pUa3RzYWE5OGorL2YzdTNBZzRzeWZZUGM2OVlIUUh5SlgzS1Btayti?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0341afbe-ca00-4458-ad0f-08db938eb1c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 19:28:47.9679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 31MdU/yWBJtCuZ9TZVvAkuUBj7cC1fMwioxjg1Ic7jYjPy0eoovSdkyqw0WGp9beZJWTgdIblrU1kN/bJQTijOYxE55LA/PyA56hlxld6TI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3319
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IFNlbnQ6IFdlZG5lc2Rh
eSwgQXVndXN0IDIsIDIwMjMgMzoyMiBBTQ0KPiANCj4gQU1EL0hZR09OIHVzZXMgdmFyaW91cyBt
ZXRob2RzIGZvciB0b3BvbG9neSBldmFsdWF0aW9uOg0KPiANCj4gICAtIExlYWYgMHg4MDAwMDAw
OCBhbmQgMHg4MDAwMDAxZSBiYXNlZCB3aXRoIGFuIG9wdGlvbmFsIGxlYWYgMHhiLA0KPiAgICAg
d2hpY2ggaXMgdGhlIHByZWZlcnJlZCB2YXJpYW50IGZvciBtb2Rlcm4gQ1BVcy4NCj4gDQo+ICAg
ICBMZWFmIDB4YiB3aWxsIGJlIHN1cGVyc2VkZWQgYnkgbGVhZiAweDgwMDAwMDI2IHNvb24sIHdo
aWNoIGlzIGp1c3QNCj4gICAgIGFub3RoZXIgdmFyaWFudCBvZiB0aGUgSW50ZWwgMHgxZiBsZWFm
IGZvciB3aGF0ZXZlciByZWFzb25zLg0KPiANCj4gICAtIFN1YmxlYWYgMHg4MDAwMDAwOCBhbmQg
Tk9ERUlEX01TUiBiYXNlDQo+IA0KPiAgIC0gTGVnYWN5IGZhbGxiYWNrDQo+IA0KPiBUaGF0IGNv
ZGUgaXMgZm9sbG93aW5nIHRoZSBwcmluY2lwbGUgb2YgcmFuZG9tIGJpdHMgYW5kIHBpZWNlcyBh
bGwgb3ZlciB0aGUNCj4gcGxhY2Ugd2hpY2ggcmVzdWx0cyBpbiBtdWx0aXBsZSBldmFsdWF0aW9u
cyBhbmQgaW1wZW5ldHJhYmxlIGNvZGUgZmxvd3MgaW4NCj4gdGhlIHNhbWUgd2F5IGFzIHRoZSBJ
bnRlbCBwYXJzaW5nIGRpZC4NCj4gDQo+IFByb3ZpZGUgYSBzYW5lIGltcGxlbWVudGF0aW9uIGJ5
IGNsZWFybHkgc2VwYXJhdGluZyB0aGUgdGhyZWUgdmFyaWFudHMgYW5kDQo+IGJyaW5naW5nIHRo
ZW0gaW4gdGhlIHByb3BlciBwcmVmZXJlbmNlIG9yZGVyIGluIG9uZSBwbGFjZS4NCj4gDQo+IFRo
aXMgcHJvdmlkZXMgdGhlIHBhcnNpbmcgZm9yIGJvdGggQU1EIGFuZCBIWUdPTiBiZWNhdXNlIHRo
ZXJlIGlzIG5vIHBvaW50DQo+IGluIGhhdmluZyBhIHNlcGFyYXRlIEhZR09OIHBhcnNlciB3aGlj
aCBvbmx5IGRpZmZlcnMgYnkgMyBsaW5lcyBvZg0KPiBjb2RlLiBBbnkgZnVydGhlciBkaXZlcmdl
bmNlIGJldHdlZW4gQU1EIGFuZCBIWUdPTiBjYW4gYmUgaGFuZGxlZCBpbg0KPiBkaWZmZXJlbnQg
ZnVuY3Rpb25zLCB3aGlsZSBzdGlsbCBzaGFyaW5nIHRoZSBleGlzdGluZyBwYXJzZXJzLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+
IC0tLQ0KPiBWMzogRml4IHRoZSBvZmYgYnkgb25lIHdpdGggbGVhZiAweDgwMDAwMDFlOjplYng6
OnRocmVhZHNfcGVyX2N1IC0gTWljaGFlbA0KPiAtLS0NCg0KW3NuaXBdDQoNCj4gKw0KPiArc3Rh
dGljIGJvb2wgcGFyc2VfODAwMF8wMDFlKHN0cnVjdCB0b3BvX3NjYW4gKnRzY2FuLCBib29sIGhh
c18weGIpDQo+ICt7DQo+ICsJc3RydWN0IHsNCj4gKwkJLy8gZWF4DQo+ICsJCXUzMgl4MmFwaWNf
aWQJOiAzMjsNCj4gKwkJLy8gZWJ4DQo+ICsJCXUzMgljdWlkCQk6ICA4LA0KPiArCQkJdGhyZWFk
c19wZXJfY3UJOiAgOCwNCj4gKwkJCV9fcnN2ZDAJCTogMTY7DQo+ICsJCS8vIGVjeA0KPiArCQl1
MzIJbm9kZWlkCQk6ICA4LA0KPiArCQkJbm9kZXNfcGVyX3BrZwk6ICAzLA0KPiArCQkJX19yc3Zk
MQkJOiAyMTsNCj4gKwkJLy8gZWR4DQo+ICsJCXUzMglfX3JzdmQyCQk6IDMyOw0KPiArCX0gbGVh
ZjsNCj4gKw0KPiArCWlmICghYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX1RPUE9FWFQpKQ0KPiAr
CQlyZXR1cm4gZmFsc2U7DQo+ICsNCj4gKwljcHVpZF9sZWFmKDB4ODAwMDAwMWUsICZsZWFmKTsN
Cj4gKw0KPiArCXRzY2FuLT5jLT50b3BvLmluaXRpYWxfYXBpY2lkID0gbGVhZi54MmFwaWNfaWQ7
DQo+ICsNCj4gKwkvKg0KPiArCSAqIElmIGxlYWYgMHhiIGlzIGF2YWlsYWJsZSwgdGhlbiBTTVQg
c2hpZnQgaXMgc2V0IGFscmVhZHkuIElmIG5vdA0KPiArCSAqIHRha2UgaXQgZnJvbSBlY3gudGhy
ZWFkc19wZXJfY3UgYW5kIHVzZSB0b3BvX3VwZGF0ZV9kb20oKSAtDQo+ICsJICogdG9wb2xvZ3lf
c2V0X2RvbSgpIHdvdWxkIHByb3BhZ2F0ZSBhbmQgb3ZlcndyaXRlIHRoZSBhbHJlYWR5DQo+ICsJ
ICogcHJvcGFnYXRlZCBDT1JFIGxldmVsLg0KPiArCSAqLw0KPiArCWlmICghaGFzXzB4Yikgew0K
PiArCQl0b3BvbG9neV91cGRhdGVfZG9tKHRzY2FuLCBUT1BPX1NNVF9ET01BSU4sIGdldF9jb3Vu
dF9vcmRlcihsZWFmLnRocmVhZHNfcGVyX2N1KSwNCj4gKwkJCQkgICAgbGVhZi50aHJlYWRzX3Bl
cl9jdSArIDEpOw0KDQpJc24ndCB0aGUgKzEgYWxzbyBuZWVkZWQgb24gdGhlIGFyZ3VtZW50IHRv
IGdldF9jb3VudF9vcmRlcigpPw0KSSBoYXZlbid0IGFjdHVhbGx5IHJ1biB0aGUgY29uZmlnLCBi
dXQgaWYgaHlwZXItdGhyZWFkaW5nIGlzIGRpc2FibGVkLA0KcHJlc3VtYWJseSB0aHJlYWRzX3Bl
cl9jdSBpcyAwLCBhbmQgZ2V0X2NvdW50X29yZGVyIHJldHVybnMgLTEuDQoNCk1pY2hhZWwNCg0K
PiArCX0NCj4gKw0KPiArCXN0b3JlX25vZGUodHNjYW4sIGxlYWYubm9kZXNfcGVyX3BrZyArIDEs
IGxlYWYubm9kZWlkKTsNCj4gKw0KPiArCWlmICh0c2Nhbi0+Yy0+eDg2X3ZlbmRvciA9PSBYODZf
VkVORE9SX0FNRCkgew0KPiArCQlpZiAodHNjYW4tPmMtPng4NiA9PSAweDE1KQ0KPiArCQkJdHNj
YW4tPmMtPnRvcG8uY3VfaWQgPSBsZWFmLmN1aWQ7DQo+ICsNCj4gKwkJY2FjaGVpbmZvX2FtZF9p
bml0X2xsY19pZCh0c2Nhbi0+YywgbGVhZi5ub2RlaWQpOw0KPiArCX0gZWxzZSB7DQo+ICsJCS8q
DQo+ICsJCSAqIFBhY2thZ2UgSUQgaXMgQXBpY0lkWzYuLl0gb24gSHlnb24gQ1BVcy4gU2VlIGNv
bW1pdA0KPiArCQkgKiBlMGNlZWFlNzA4Y2UgZm9yIGV4cGxhbmF0aW9uLiBUaGUgdG9wb2xvZ3kg
aW5mbyBpcw0KPiArCQkgKiBzY3Jld2VkIHVwOiBUaGUgcGFja2FnZSBzaGlmdCBpcyBhbHdheXMg
NiBhbmQgdGhlIG5vZGUNCj4gKwkJICogSUQgaXMgYml0IFs0OjVdLiBEb24ndCB0b3VjaCB0aGUg
bGF0dGVyIHdpdGhvdXQNCj4gKwkJICogY29uZmlybWF0aW9uIGZyb20gdGhlIEh5Z29uIGRldmVs
b3BlcnMuDQo+ICsJCSAqLw0KPiArCQl0b3BvbG9neV9zZXRfZG9tKHRzY2FuLCBUT1BPX0NPUkVf
RE9NQUlOLCA2LCB0c2Nhbi0+ZG9tX25jcHVzW1RPUE9fQ09SRV9ET01BSU5dKTsNCj4gKwkJY2Fj
aGVpbmZvX2h5Z29uX2luaXRfbGxjX2lkKHRzY2FuLT5jKTsNCj4gKwl9DQo+ICsJcmV0dXJuIHRy
dWU7DQo+ICt9DQo+ICsNCg==
