Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641077C0362
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjJJS0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjJJSZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:25:58 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012005.outbound.protection.outlook.com [40.93.200.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A058D9E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:25:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y23nEcjQIP/q6M6OCPZAUvfBqLHf+haBR1XBEH+PUky1qdlIno6/Dkcc35h/wAa0cUCEHVbX0GpzWPAtaeRAuki3ouRPsryeeBf9js/gys7sjzfcLFvSLSbNK29ssvO394DP0eLgEu8MLP1sITLkkR0qtWTUv0IX3qeghCWxe7kpn9e9BrtmJgLXbBJG0FVy/o5OcrGszqdD1DLGg16DwAJnonfZuqb0GDsirWbHkh5HsfQiBZu1+cW2AICLzP4wz4yl8jNbQniWMimQEpCyqVnTypqYkqnwpCyuFl/6/7FiHXQsHuuvhsjqhtu2+0YkQDpg4tncw7r4WNDQpUB4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddcBrL+gdIFUXvVY8HHGJ/oXVArHxaInniihOgUAYKQ=;
 b=lpVAJTDabuo2Tw7S3gvVdFLYdZ1YunoxLK+570YrSt2QDr4UUghX4k2i5ApBsyhyHWWngi2eY2pjmdcRKWuPERfTOpf61T6MiUZiYQBTWH4dRR+d+EwvZSSX/vaNEiLHl2pHXormIYQWTseuEO+XhBnsc0yKtS+L8bS6kvwooSL5L6qwjGIRDOAyZzJcad0GZKcfnVvBqg8V3HiTXrMcCiQ/iaEsnp7lDM2ILPc83UIxxGzO/0XZijuH3inh6p2o1qYigxheKjGBnhL+j43gKDIqaP8or4ZMejbLAvFSigGDfEe7AuzSSNgHi/v3eZHzlipwKoXdCHdzwqkc8RDKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddcBrL+gdIFUXvVY8HHGJ/oXVArHxaInniihOgUAYKQ=;
 b=pm2eC624OmU4QlfhqabuBbotObbijXgwpXhu94unDYuORyDs2tCU0SwbKY592PeMJYeCnTzjblbCAhiwki2QL2QzhJYuE6f7OWjBG3o/NZnm+S225oe6nY3bRAS0YZ57PW49CIlEVAtvtcVoVwoZO0Qi6Y3+Hf0Vz8m38ULTjMs=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SA1PR05MB9365.namprd05.prod.outlook.com (2603:10b6:806:255::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Tue, 10 Oct
 2023 18:25:53 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 18:25:53 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Uros Bizjak <ubizjak@gmail.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Thread-Topic: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Thread-Index: AQHZ+5jZGZywpkB5zE2yxvhqDFo/FrBDSECAgAAOE4CAAADTAA==
Date:   Tue, 10 Oct 2023 18:25:53 +0000
Message-ID: <108536FC-445C-41F9-8A87-B7D31A45AC4B@vmware.com>
References: <20231010164234.140750-1-ubizjak@gmail.com>
 <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
In-Reply-To: <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|SA1PR05MB9365:EE_
x-ms-office365-filtering-correlation-id: 461796f6-ba63-40eb-72ac-08dbc9be567b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DBro92KBJbJWO3hAwaW5lyph7AO8zDiHkHIZyolB6vhXn2hBRQFI4lJToo684Flvsve0QwopcISVnUIl/scGvTeldt9KzbFh4U3qN47jtwroxK26Iia/3c4DU1qgW1GKcBff8ozwvrIJpbL8iF8N5x403b2CY6FRokWO3HKOh1rjWMtQouWX4gqP//Ild8XyS9hFQQDice4nSLsZ+NHmg+es3EWF/mA7KK4RLRyxF5ELoaZptAthv+RYLms1vPDCS6/BAODy3PwBMIAOvmyMdyE/pQtns32x/v8enbTgy5UG6kR7yV/SvbdpMr8HpQqY4mD5by35vgYzq/I4z7y7mtvNm5SqfmZ7UolWxIrN4pBKa7illnHtmak0UDnKtOe1lRPjgMWLwCKyG7XkFLroxSJ39yVSff6WVuaICl7AYWO+I1VsLw7w1LlmIG9aD5/P/veKc9TddUkxuqqSTg5x2QVL0VFmxrf6XzIQxti32QlAGHMGSIu1AemIN822LAXZnEa2Ww11WZeMgg9tHByKIpS43yggLfl6U67+HQ9SK3HWOg3VU0TwD4OCNx07w5/eu2mRHymeBuB8cRM0nA5xG+H42YGZiStOHJwEOBpzdbMMPaSY+6JBAqPu4mXsYI33oMYC9a4ra6GpY49z6gA62tSIWWK9+ei8U+XhsIzChsYT2Dis9k1K2CtkmbycofRLXMgmhBSBDUQmLmauUfvV5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(53546011)(6512007)(478600001)(8936002)(8676002)(83380400001)(6506007)(6486002)(71200400001)(38100700002)(7416002)(2616005)(41300700001)(64756008)(76116006)(66556008)(54906003)(91956017)(66446008)(6916009)(66946007)(316002)(66476007)(5660300002)(86362001)(122000001)(36756003)(26005)(38070700005)(33656002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmZhUnE2QzhHVHZKWnRSbmF3SGVtMjVtVExGTFJVaXNLWUk0QlFqbFBBZmYv?=
 =?utf-8?B?T3l0VmdDVVJoSEJCeHFWVU9QZHBpMk1iTHBmMGlpYnlJeVpBQk9DMTRjR2J5?=
 =?utf-8?B?RHhFZzRrWU8zMGdrR1YxQ1lrVllPY1B5VTRoOXVudklybWNvSm12eHdMVFl4?=
 =?utf-8?B?TDlLVGpZMzRBT1lrQnd3OFc0Q2ZWSG1lMzI3aFhaem9hMnV1bHRINk11WVU4?=
 =?utf-8?B?ajV1b2Eza21wM0pSWUNzZnRxdWZNbmFYTmgwVmVqeHcyVHVETFQxOEh6cXVx?=
 =?utf-8?B?UEZjMG9STEwyVHpyaWM0SWlGekxvRDJ3OFJNdVlNaE8yR0d1Rmpwb1RSRzF4?=
 =?utf-8?B?NElaSEV0TVN4alpGMWxKeUJ4TlNPU09QcjEvREw0dWNCRWw3UGVPcTJ5WHlv?=
 =?utf-8?B?cUlRT3dVMGVWUEZEdHNBekpZSDJQOUhISHo1MmcxeTcxRDVrTHBPNTBMTDI1?=
 =?utf-8?B?aFhvOUV6ZXMxcmdIeERuS25DNE1GOVBWSlY4MTI3b0hRY0JDOWlBN2cybWNv?=
 =?utf-8?B?K2grS1VndldYSy9USVl6di9TbHNLdU8xR2REQ0V5MWJ2dzZqUVhwYVlFUDZj?=
 =?utf-8?B?K2FKdzI5UWFCZlpWK3REUnZFL25OZ0dmUjgwdEtjSG9xU1VHMlM2Z1ArWHpq?=
 =?utf-8?B?UUxaVWh2NUNLWlY1Y0ljTFJSMkJ1ZWkvMjg4ZVhDVXg3ME04R1A1dFl0dnFa?=
 =?utf-8?B?Q3gxVkdPSGg3Z0RtellMTlU5ckREQlVRa3lTUjRuQXFKbUFIK1NLa2VJWkN0?=
 =?utf-8?B?MkxETTdaMGxxYVBRK1haTktBS0ZmSGh5WnZ5TUZVR1EzOHU2dkR2ZTFrZmVk?=
 =?utf-8?B?cXE2R3RVbHBBV1ZJV0QxYXBuZytMOFB0cWlPdCswK2VBZFFPdFdRd1BhZUQ2?=
 =?utf-8?B?dXhUeWFRY1FIOG5mVE1NaTJnNVZKK3RMREZXQzBHSUg0aDFaVlhFbmZEa1dR?=
 =?utf-8?B?L0s4NXNJUVlNRzhnVW0vNkFTK1BGeVBmK0VhWE9JY2NvR1ZVNHhKMi8yUDZh?=
 =?utf-8?B?K3NVemwvZXNucityVmtxaFZhZnFJVjBBbHNIV0gxV2ZURU9tL1pMcUlIOTgw?=
 =?utf-8?B?S21INFd2UE9IdlN1MjRRWWpobXFzREJFb3dlM3VFNHA2YXBWV2RLVmU4a0Jo?=
 =?utf-8?B?eVFmVWhSVkdMT2NGc2ROS0JBdGl2MVpVWnVROWk4MU1BakVTM1R5VmVjckdH?=
 =?utf-8?B?aGM3RCtKVUFmNHIyTEVueDFVT2V2NVMzZ2pxWWl2a2NhdTBtR0ZnaUsxWDFl?=
 =?utf-8?B?T0JlLytLdDVkbFRmQWtwSWJGRnJiSDZTRE9GS2NVTCtCS3NzWFpoWUVOMGR2?=
 =?utf-8?B?Y3d3YUpObUs4bEpiUE03TWJpVVBXSUU0dlFMS3VoWU53a08yb0RPQTFvNGNt?=
 =?utf-8?B?Sk1STy9hQVF2c2wzR1huMUZKQ2xMT3UyNk44VzY2VzZnQTFIV0Izc29NbUEv?=
 =?utf-8?B?dGxDeENBNTZFbmpFckN5Tm1udnNHSnc5TVB4TFMyOEQ0RFBKSDV1bDAxYXdS?=
 =?utf-8?B?YzBWM1pUSEcrOTQ4REJxanBTb1JYNStRdVdWNW5zL2xZeGRxcHk4aGFIeVhv?=
 =?utf-8?B?a3Q0dWNqL2pUY1ViUWZUU0xBSS9Qb29pMXBvelhGOTB6czgxUVNUMnI4QnNx?=
 =?utf-8?B?UVhwQXhZdFFoNEZQdEM0ZHNWWXE0Z0syRlZCaXdFQkM4RHFlNVAzbjNVam5R?=
 =?utf-8?B?YmR3bXJhUk9TV0ZXSEFWTi9nMk00TVhFcEkwRXBxOWZoWWh4UXlueDBQY25Q?=
 =?utf-8?B?MlIyZ3JoU2ZYcGliUHRudzhOb2tzRE55TjM3ZXBmSlpETDRZcnMwbWNHTEdC?=
 =?utf-8?B?N2dFcWJYcXp6RWZvc2hQdEIwcS9aUkEyRXdVZ3VOa09XNFVPM0QxWTVDRmgx?=
 =?utf-8?B?QnVOZy9WY2RDWk9VN3gyekk4WlJvRldTaWRVZit2a2lyNEk2SjJ2TXN1RlpJ?=
 =?utf-8?B?alJydndXa1RhLys1ODVJK09oOUNsMGlMRWtUckx0NWhMSnlNNlRVbmFMU1NV?=
 =?utf-8?B?UE4yRHRHMmgyaXNIV3JueVZhZXdrUUdHT296WE8wU0pNWDRBNWw2RGNpanNC?=
 =?utf-8?B?NGg0dmRDbXVIdXRSR0g0UyszMmU2Nkp6bkowT0t3b0RDZlZnY0RtODZIWjMr?=
 =?utf-8?Q?6aSNxNx66ZStWUqnW26mslgAi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFC65070C7B76E4B82D0E5FC52F16938@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461796f6-ba63-40eb-72ac-08dbc9be567b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 18:25:53.4385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Cf31q1EnqS88BKl4NiJUcWuwUFtMchKIQ5z2QM/sqdNh0bPabJjxwjP53SSmsff1+5r4tuD4Fr6vu9hQz68+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR05MB9365
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDEwLCAyMDIzLCBhdCA5OjIyIFBNLCBVcm9zIEJpemphayA8dWJpempha0Bn
bWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgNzozMuKAr1BN
IExpbnVzIFRvcnZhbGRzDQo+IDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6
DQo+PiANCj4+IE9uIFR1ZSwgMTAgT2N0IDIwMjMgYXQgMDk6NDMsIFVyb3MgQml6amFrIDx1Yml6
amFrQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gSW1wbGVtZW50aW5nIGFyY2hfcmF3X2Nw
dV9wdHIoKSBpbiBDLCBhbGxvd3MgdGhlIGNvbXBpbGVyIHRvIHBlcmZvcm0NCj4+PiBiZXR0ZXIg
b3B0aW1pemF0aW9ucywgc3VjaCBhcyBzZXR0aW5nIGFuIGFwcHJvcHJpYXRlIGJhc2UgdG8gY29t
cHV0ZQ0KPj4+IHRoZSBhZGRyZXNzIGluc3RlYWQgb2YgYW4gYWRkIGluc3RydWN0aW9uLg0KPj4g
DQo+PiBIbW0uIEkgd29uZGVyLi4NCj4+IA0KPj4+ICsgICAgICAgdGNwX3B0cl9fID0gX19yYXdf
Y3B1X3JlYWQoLCB0aGlzX2NwdV9vZmYpICsgKHVuc2lnbmVkIGxvbmcpKHB0cik7IFwNCj4+IA0K
Pj4gRG8gd2UgcmVhbGx5IGV2ZW4gd2FudCB0byB1c2UgX19yYXdfY3B1X3JlYWQodGhpc19jcHVf
b2ZmKSBhdCBhbGw/DQo+IA0KPiBQbGVhc2Ugbm90ZSB0aGF0IGJlc2lkZXMgcHJvcGFnYXRpb24g
b2YgdGhlIGFkZGl0aW9uIGludG8gYWRkcmVzcywgdGhlDQo+IHBhdGNoIGFsc28gZXhwb3NlcyBt
ZW1vcnkgbG9hZCB0byB0aGUgY29tcGlsZXIsIHdpdGggdGhlIGFudGljaXBhdGlvbg0KPiB0aGF0
IHRoZSBjb21waWxlciBDU0VzIHRoZSBsb2FkIGZyb20gdGhpc19jcHVfb2ZmIGZyb20gZXZlbnR1
YWwNCj4gbXVsdGlwbGUgYWRkcmVzc2VzLiBGb3IgdGhpcyB0byB3b3JrLCB3ZSBoYXZlIHRvIGdl
dCByaWQgb2YgdGhlIGFzbXMuDQo+IEl0IGlzIGltcG9ydGFudCB0aGF0IHRoZSBjb21waWxlciBr
bm93cyB0aGF0IHRoaXMgaXMgYSBtZW1vcnkgbG9hZCwgc28NCj4gaXQgY2FuIGFsc28gYXBwbHkg
b3RoZXIgY29tcGlsZXIgbWFnaWMgdG8gaXQuDQo+IA0KPiBCVFc6IEEgZm9sbG93LXVwIHBhdGNo
IHdpbGwgYWxzbyB1c2VfX3Jhd19jcHVfcmVhZCB0byBpbXBsZW1lbnQNCj4gdGhpc19jcHVfcmVh
ZF9zdGFibGUuIFdlIGNhbiB0aGVuIHJlYWQgImNvbnN0IGFsaWFzZWQiIGN1cnJlbnRfdGFzayB0
bw0KPiBDU0UgdGhlIGxvYWQgZXZlbiBtb3JlLCBzb21ldGhpbmcgc2ltaWxhciB0byBbMV0uDQoN
Ckkgd2FzIGp1c3Qgd3JpdGluZyB0aGUgc2FtZSB0aGluZy4gOikNCg0KQXMgYSBtaW5vciBub3Rl
IHRoZSBwcm9wb3NlZCBhc3NlbWJseSB2ZXJzaW9uIHNlZW1zIHRvIGJlIG1pc3NpbmcNCl9fRk9S
Q0VfT1JERVIgYXMgYW4gaW5wdXQgYXJndW1lbnQgdG8gcHJldmVudCByZW9yZGVyaW5nIHBhc3Qg
cHJlZW1wdF9lbmFibGUNCmFuZCBwcmVlbXB0X2Rpc2FibGUuIEJ1dCB0aGF04oCZcyByZWFsbHkg
bm90IHRoZSBtYWluIHBvaW50Lg0KDQo=
