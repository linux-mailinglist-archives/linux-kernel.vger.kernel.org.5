Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008CD7B4A6C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 02:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbjJBAMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 20:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjJBAMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 20:12:05 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2090.outbound.protection.outlook.com [40.107.113.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD75AC9;
        Sun,  1 Oct 2023 17:12:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYpSKrlU9d1+nzbysKMqazqlTxcZwUq15PJsyWeHemddMxCkra2WUkLnRoSP4A0PLZXWuWelh+H6ByYzfwNgxYaFNSrQ0qBF5Pg9Be+sojxnb2anDLr8b1lFrHHhPf8zOc7+c1gUk8fgXQSinLymBj/56epGSxC8fyRjusGypN1/oLA+VW5DwrhTjb5UUIaSyvafLleKY3+BYtvoGPTFCCkv7CIfJ6R7E5DzthxWtlAhlwAUrg6wmU+LQAsq2L2xvyQJM17Ng3GHUTuY+Zby2CfBWrMh5Q6OXkSOMjyiROlc3ttGtDkVEYxse9KUfjcudwxk2gTsEKeZhZPGmX9oJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LctNEid7CPvucE9AmTzMhRJaJt64CSA9Km7V4CbHGd4=;
 b=Md4gSzQ4+5wxwcK3ztZ2HKpxCaU5nbWj2EeNP59CK8SA9y79eh9JaKIYcU8RvgCfhMpXAP+PXCjnZGqKSOGYo6L0rMwXxZ5EE48in2CzueKxNZH0wmWXXo+MaMNDB/PzWFFrMJMr3x7rgqEwE2i0cqY2hRHVZpcm8QaZxrcgJZWI3rnkYVR4fbWuoguiAD+S+T2xEEeImepYzk1P/uasCGFl5lsz853kVrE5akkoRCmWiEaqeukjKnSBZjdpleCw3+9HOEHzKaNiJeJdD0f6P9vARQ+a35A5YcB4d7cYkx3UrmzBcEq7NkZf0d/gqPG3VbeBr7SUoT5d4SNM3iBFyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LctNEid7CPvucE9AmTzMhRJaJt64CSA9Km7V4CbHGd4=;
 b=p1p12r4WTEfQDxKQsDQx8yRufTfPBcoxDBg0kCEe/2MaAHHiTRT1C0yBL3GNR3pRlhvJoQjRCt46fX7R9oPK7tBncl4uJabvC2h1asP8yKP4XdWyb1Hz4ugyOSXtPD/VbPHyIH2yXsgPKzTsXe9qKTdxYl5qyFJ0y7RBwbBQoyM=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYYPR01MB7830.jpnprd01.prod.outlook.com
 (2603:1096:400:116::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 00:11:57 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7%7]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 00:11:57 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Zheng Wang <zyytlz.wz@163.com>
CC:     "lee@kernel.org" <lee@kernel.org>,
        "linyunsheng@huawei.com" <linyunsheng@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hackerzheng666@gmail.com" <hackerzheng666@gmail.com>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>
Subject: RE: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
Thread-Topic: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
Thread-Index: AQHZvqRVuDoCAQ7YqEiPPoP/ALhCca/LYswAgAHmgICAAK9XgIBVS6xQgA9j64CAA2QMEA==
Date:   Mon, 2 Oct 2023 00:11:57 +0000
Message-ID: <TYBPR01MB5341D229813B991E0F2E051CD8C5A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
 <20230725201952.2f23bb3b@kernel.org>
 <9cfa70cca3cb1dd20bb2cab70a213e5a4dd28f89.camel@redhat.com>
 <607f4fe4-5a59-39dd-71c2-0cf769b48187@omp.ru>
 <OSYPR01MB53341CFDBB49A3BA41A6752CD8F9A@OSYPR01MB5334.jpnprd01.prod.outlook.com>
 <e9eb099d-35df-6a9a-8eeb-5ef3e4f26c0b@omp.ru>
In-Reply-To: <e9eb099d-35df-6a9a-8eeb-5ef3e4f26c0b@omp.ru>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYYPR01MB7830:EE_
x-ms-office365-filtering-correlation-id: 69d42770-7dc7-4db4-94d8-08dbc2dc30ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jjntwwqCpX0zmhywo38GTu++2PKQh51mKt+bc1uAQtiNKgzb2QjOCBLjBLZX/uZLd85Rx+KdeljoZ4PEk5sydhJqGiVyVv2OKJW3NMw6e5DStkQKQj9+cDrApW7aB3L8Q1Ul5pt7CH9iGYLOGjn2YpvFM/+hwVcbp5YD9QVTglW5RX6I9fj3MGYQRWJdYawmKV2lvU+7P7NJuVDzZuG2uvWLG6iXY2vqFge7FOMHR20PomarSKbjc1Io0c3cKQ2pa4lVwcBpaZi7S9czrg+qwhBStzYwYiIpUIbgWNySZkzi7GT6932lBeFNaYYS67mHFMwK15BpH4vZhz9jUtOLXh+axvTS0ssyxz8aBW6up/vNge05QN5XgCl53ehT4eK25dVH716ERFbGYpgQNJZvDhTJ+0chbLgd5FmeQVZFuLU1bh/bGxl9kA2UISwOXIcC+LXflhIG/fYb18SDdhh5by6Evegf0cAjhbXGfZyCG5sftbq3cLL413UqQN3Qh81a6+bGnXyuvvs99x+qBNTPdr/WklnJ4KGfuHreB0QmA7pTp/qSXWsA+QH+MugYnbEm0MVUEta/ORBAYNuv3B+HAfL3ay3t//DlBrv5lmyyfvGIoyvQJ9Q8FMWJNEEUj4Nf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(136003)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(9686003)(122000001)(38100700002)(38070700005)(33656002)(86362001)(55016003)(41300700001)(54906003)(64756008)(478600001)(66476007)(66446008)(7416002)(316002)(52536014)(8676002)(8936002)(4326008)(5660300002)(66556008)(66946007)(110136005)(76116006)(6506007)(7696005)(53546011)(4744005)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWQzMUpseEl0Q2w2Y0hlbXdUUk5SVVQ0aEFLYWU4U2R6dUdia0dpK0V0Q0Vr?=
 =?utf-8?B?TjFzckhNbzhDNHJ0OTA3dDV3VmJyVmo1T3VpT2N6ZllFWVlEdjg4Z1NHZlo4?=
 =?utf-8?B?T2dmZzN2djVBbXR4L2JkYmdjTVdCSUNNVGRVZlI5SnIxdTNKN2psTDJRa0JV?=
 =?utf-8?B?dTZxeHkyS2ZvNitCd2hyakczSnVKb25iU09IbXZHcXl0YUJjRVJUWDBlK0xQ?=
 =?utf-8?B?MEhFR2djUmw0R2hkeVYvdm9SdUpNc2F2MlFqTGFCVVhoWjNLWHlVcDVJVXZM?=
 =?utf-8?B?R3I1NE5CbXMwZVJ1ZWJTdWVZdEtNTFFVdFMyam9TWTNEM2tpbTNEMTlEaGdx?=
 =?utf-8?B?cnlENVB3L0VNUDd1eDVseGhYZDFyUEJQVDBMYUVuMHZEME5QeGxLc0wrN0Rl?=
 =?utf-8?B?dFNZcVRiM0gzMzFOV0poUVNPM1dLTmNKaVVoQ3BNc0h2VVUwaVdid1QvMkVn?=
 =?utf-8?B?K21TcGV4UVRhYTIwYUtrUm1qOGg3MU9HbFl5RTIrV2w1OFprY3BUeGpyeEZF?=
 =?utf-8?B?T1ZDSDFHdWpBTEN5Qk5NV1gvOXRwYi9rMkJNRDVSMWlLYUdwMS9zRXVGRVJE?=
 =?utf-8?B?YmhENXdpcEFQVG56VkM5ZFlDdWtzMTU5MWNhemkrVkVkUHRKT2lLOFlsWm9D?=
 =?utf-8?B?bHVybVRIWHZDakNrQ284MUwzVncrSUN1U0h4WjBzODFOaTFicWVOekYwQnRn?=
 =?utf-8?B?UU44ZXAxcks5WUdVNDJEUzFxZXFMMGNUeW0zQVp0U3FnWll2ekNneXZZbkIv?=
 =?utf-8?B?a0M3eUwyamxxci9yWTdRNXlTUW4xRzI0WXhvNmh4cUQrN01xenUvVE5OaG8y?=
 =?utf-8?B?bzgvNWxZTlcwTFFZOWY1Sk1lQ1h0RzVpemVoNWtvcUZUbW42Q0J3RXV3Zzgw?=
 =?utf-8?B?d1pBa0s0bzJObkZkTERLanJ3WiszZVE4enpJVndRb2JHaTlCUHNJUUZxZnhv?=
 =?utf-8?B?OFpJV2MxU2RmeWt5ZGpTZUxybEZRbWZPeDJZSXhvOFRXNmdjeFMzeUV1ckJj?=
 =?utf-8?B?ck5LTnA5alh4N2hMelNxV1ltMFJ5Mk41V0FEWG5scjFCVStJQW5oazZiUEww?=
 =?utf-8?B?Uk9MODN5OTdFdkhyMUh0WlhTbUw0UlBDeVZLeE5nUzBFd3RpclZscGRqblJZ?=
 =?utf-8?B?UndmdDdKU2NVVUQ0anUrTGc4aW5EeFd6MkZYcXlBdEVLN3RtVHkxVE42dlhp?=
 =?utf-8?B?ckJ3dEF2elV2TTFDSXhpVUJuUmM5aTRwVXZyR2ptVEUvNkRDU1FzTSs2NnM1?=
 =?utf-8?B?b2ErMVFDOVAzVCtwR09OTjRTK285eGZmTUg5b0Uzbk50aDVibVR6akxsaEh6?=
 =?utf-8?B?Wkd1M1UvZmIzWVVIRWh3QTBsQU9URFdqdWpxZlpSYUxqcXZ6U2pCZ0o4MGxq?=
 =?utf-8?B?Q0N2THV5UG9DU1ljeGtGQWdLQmowR3NQU3RHNndOMjh6Tk1SclB3M1Z5Rm1H?=
 =?utf-8?B?VHB5d2t2Z05LRkwrUDF2WGJSelNyOXpvRTZlK1NXNmV2c1kzMTBxOFUwNHpv?=
 =?utf-8?B?dHI2eUJXTzhWL1B0eFZ5VUVHQzhpY3ArdWQ3WUVtd1JqNFBBZDM5S25zNnZ0?=
 =?utf-8?B?V3FlV2JvenpONCtvL3J2VFhvVWpWa0dmZ055anM1ODNJVFVqUjRHSVR6M1NB?=
 =?utf-8?B?ZGNoMHlWYVJEUlJadEhZS09lVXNUYW1SdGJxSmNFejg0aDBJVUJlcTRWSnhq?=
 =?utf-8?B?R1B0TUxFd052Z2xtRHhqdGtCR2cvdDdIM1FJYkxJT2l1b1VxV0xycnZVMVpi?=
 =?utf-8?B?RWZCemxBWjRlRlJxL0NtMVhsaHBFd3FLejl5VFl3azRFV1huMXpkK3J5WHI5?=
 =?utf-8?B?c21xZ0JBL0hNaDRXeCt1Rmk4clo3SzFzR0hjNjFhN3BXR1crWk5hMTcxdUhi?=
 =?utf-8?B?cEs3OC9CY0JEbDhBYnBVUWlQVWpZS1RiY21KdVJPbHF4TUgxRTJOamQxeTAw?=
 =?utf-8?B?bzNEUk4vT2JDZmczZVNwOWVkUzFZbGVIWGxoOWNoZXZuWHVXZVJreU9LcktH?=
 =?utf-8?B?d3dCWEVGNXVGdFFrMVRnaGNReHFDdGFaajhlN3FoRGZ3Wk1RUHo4UTk1dlhm?=
 =?utf-8?B?SmxpWEtqRU9QNHk4RmZUZ3IrM25qeG9Wbk5nYlg5N0ZIRGlPZ00zVUZrOE5r?=
 =?utf-8?B?bHg5cys2b2dhdW1aRmFRMGpwUTVUcm9OaVpwTWdHWk85VzZGbFpMMVlvc3Uv?=
 =?utf-8?B?THJockhPa1cyRSsvT1htYXpHZTE4MlRqZGxnZE9JMHJ3cFhQZEhpc1NmYnhn?=
 =?utf-8?B?YTQvVmRNWmRETzZsU3ExbDFKSjhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d42770-7dc7-4db4-94d8-08dbc2dc30ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 00:11:57.2199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SvTEbMSgc8mwdgB48vb0pgHv77SnK3B6AVkHBJToLh2YxZpMGNFNQemBs03pK4r+7C3uVbr4GuvvnFZMduUkRrx25S7NySbOEJHQqsxq22epaHRuM495Yz+w3D7Vj2aI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7830
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gU2VyZ2V5LA0KDQo+IEZyb206IFNlcmdleSBTaHR5bHlvdiwgU2VudDogU2F0dXJkYXks
IFNlcHRlbWJlciAzMCwgMjAyMyA1OjIzIEFNDQo+IA0KPiBIZWxsbyENCj4gDQo+IE9uIDkvMjAv
MjMgNTozNyBBTSwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+IA0KPiAgICBTb3JyeSwgSSBn
b3QgaWxsIHRoYXQgc2FtZSBkYXkgYW5kIHN0aWxsIGhhdmUgc3ViZmVicmlsZSB0ZW1wZXJhdHVy
ZSwNCj4gYW5kIEkgZm9yZ290IGFib3V0IHlvdXIgbWFpbC4gSSdsbCB0cnkgcmVwbHlpbmcgdG8g
aXQgb24gdGhpcyB3ZWVrZW5kLi4uDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseSEgSSB1bmRl
cnN0b29kIGl0LiBQbGVhc2UgdGFrZSBjYXJlIG9mIHlvdXJzZWxmLg0KSSBob3BlIHlvdSB3aWxs
IGdldCB3ZWxsIHNvb24uDQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4g
Wy4uLl0NCj4gDQo+IE1CUiwgU2VyZ2V5DQo=
