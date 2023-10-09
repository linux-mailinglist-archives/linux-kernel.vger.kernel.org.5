Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6967BDCE4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376563AbjJIMxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376610AbjJIMxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:53:07 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012013.outbound.protection.outlook.com [40.93.200.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A891994
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AO44r72QJXyIdp5yTVZfrbhZD9ZnD2fWbX8uUiJcoeGh+2R5kCx0jtt1Q/Oi394zbGSR0UCGleNsc4QSdh0meDF7WuBYBCWt/HoXfG8GzA02zCImaaLdS/Z/uG8mi3aMOdNCJ0cVY2Hs410QTdKapPYY1lIhT1rqPOv4uloRjO+AOAJrdvWwHrCBDHFUsz1ZR59YlspjRO/gGb+8so/0t3mUe5ZRV/YgSu4Clwhzuypk0/MVY94YNUSaJRVedYfNDqv9xYqGXTKlcRxFVfLcUTl5HhScsGaX0cPzGAYTa0GqH2OKHgzTL0Lr/r/u2TJYP1Cn54NXDhdd0cd0O/52UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TSd34Ge1W9KW/ny1mXJVSKkf51VIOJ9Z7+Huvted/4=;
 b=FXD3aINwUoWuJlXGUfEMF1EPL6gMXi4wPGRKleguSMKW+JhmMJd5i74eLkMwBCF1hF2xkuLfPTKNkHc5XP4dUHFp5CGvktgRcyHVeB7iSl5D3BstO4MKZXpcWsQUHxVpDbDpgOAJEGSWk9gbwiW8wHhUXXTl8wJ067n9mTeD1x+IgojbMYZh/+Wrc2GpbH/6V87dhNJA+3syNz+W5hmEIFbTcZpEbwmp7tJHU1gvnNC0tvJjmEkA7qU1FusMHX7s0GhzNDcsn3dEApMgjH3FIxVKazer8xVTCwHmcZfkFNl7J7tN3l1ovg/aisxtGXCrFz56XqM1ETT+jXIeD0kfxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TSd34Ge1W9KW/ny1mXJVSKkf51VIOJ9Z7+Huvted/4=;
 b=TAf3IqbE9iDRg2nr/JoYPhUmLdJhtz7LWVyJ/5iR7TnQPca8wKB+L2H7gYzTSmfUh99m9ok7BYYO4gqvk4jwKV7BwsEiZevztS/CoVY0VwLh0AcxssZlj7buPq9rOgAMADGpKE22e1GKYu9k1tl6S/cNiuEPwHRlmYchQZ3+UJo=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SN7PR05MB7536.namprd05.prod.outlook.com (2603:10b6:806:f4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 12:53:03 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 12:53:03 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Uros Bizjak <ubizjak@gmail.com>
CC:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
Thread-Topic: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
Thread-Index: AQHZ9tJVBFQ4epXLdUKoG1JrhizpE7BANMmAgAAV0QCAAA+tAIAACY4AgAAO9oCAAOqmgIAAAuqAgAACeICAAAum/4AAAukA
Date:   Mon, 9 Oct 2023 12:53:03 +0000
Message-ID: <2EEBC1F4-7732-4F01-BD2B-64F55A814D8E@vmware.com>
References: <20231004145137.86537-1-ubizjak@gmail.com>
 <20231004145137.86537-5-ubizjak@gmail.com>
 <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
 <CAFULd4YWjxoSTyCtMN0OzKgHtshMQOuMH1Z0n_OaWKVnUjy2iA@mail.gmail.com>
 <CAHk-=whq=+LNHmsde8LaF4pdvKxqKt5GxW+Tq+U35_aDcV0ADg@mail.gmail.com>
 <CAHk-=wi6U-O1wdPOESuCE6QO2OaPu0hEzaig0uDOU4L5CREhug@mail.gmail.com>
 <CAFULd4Z3C771u8Y==8h6hi=mhGmy=7RJRAEBGfNZ0SmynxF41g@mail.gmail.com>
 <ZSPm6Z/lTK1ZlO8m@gmail.com> <ZSPpW3zLTn7IohOJ@gmail.com>
 <CAFULd4bjnro3CFQLY=qR0S5M0WY3NkrVUW-JUk4nB4mV7xhWNg@mail.gmail.com>
 <EEA95C45-87E6-4033-AEB2-0EC109220074@vmware.com>
 <CAFULd4aOSz0ZCtDdh=eST6DCr+ds2B9O2Rk0cyUeS+qQmWdOMA@mail.gmail.com>
In-Reply-To: <CAFULd4aOSz0ZCtDdh=eST6DCr+ds2B9O2Rk0cyUeS+qQmWdOMA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|SN7PR05MB7536:EE_
x-ms-office365-filtering-correlation-id: 47013499-7c35-4a0c-6131-08dbc8c6acd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JKmxbvaME2XH+WixqZHXzC5EG1XSJD2PP1o29KlhRk2MzJokxl/V8a8PamlFSBbk3MhUKxRizQ4OmdSPemd9QMpIxv4nDc0+9OEDt2vCcolZsZa7fIfFOlM80Vea+hqbS6Jc93J6OFfGkTRQGr4sJ64klrxfUels+iX7WZzvHvoRDYojSgpK9xSPKTsOJcIMg1orpJMe2RYwUqrJIpDc8z5DNLyHmWyzXF8U5D0psvpH5mN/64jiZNk67k+wnEGY44cV3AKRgX8ha2arXSR/DydrssNDTx7aVqmnkNKYJ7BOxqzZG345q45CWbBDDw65Pw7BZTEaBb9aMljFdcYTXcz15D2SLvfAOKe22JlzZbDJQvQBAade3AYArtf6zXxpSGG463GJzXysdfaQUh5Gr3pVyFfsx9rjgPU3pWQwBeSgpzkUsvJVsViAo4V/+O2X31Z/ZwvgDAIWRSvfWFNncWizw41TW2W26KJzbY4WVAlZTLFJeGm1N5TousGgpb0Pt0Df+EJltdSbrds8MwqjiSQ/bobRivlhGHpzRfP6qv0dxLg0YGGIQtWF/PAnQafew21gsB+Uky9UsSJhYfspOIAN9Y2wy+3QZaEUh4kI+shP2lTBk9ZdgNAclT1bF+ZLSBp8s4Jczt559oR56yeE6nO9AdPz6gusX2ngzKh39PC2SeDCY8gAFzyViQfC2SiYKgl5VPA7yHKs9Hb6Ke8BOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(83380400001)(122000001)(38100700002)(8936002)(8676002)(4326008)(316002)(478600001)(76116006)(66946007)(66556008)(66476007)(66446008)(54906003)(6916009)(64756008)(91956017)(7416002)(2616005)(2906002)(41300700001)(5660300002)(53546011)(6506007)(71200400001)(6486002)(6512007)(38070700005)(33656002)(36756003)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWpSdEdGVnRVZlN1cFMzTWpLc0wzSmVPdE42OG5wclJmVWxYdGFCUkJtdGkx?=
 =?utf-8?B?dmpFN3JNN1FQajFKRjUvdjBxSURWUVN5NjJPV0habXJJUm54WXUrN01veE5x?=
 =?utf-8?B?SVhoLzRnM2ZlbnJmSTZTVzRtWHlFZzhTRjZGYlR1K0RTNTQ4cFVSWGJCNCtw?=
 =?utf-8?B?eVk4V3QySEpnWDRuRFN6WmZMbmlqVDFpcmloRjFxb3dWeEhmMTB4VlJPWm13?=
 =?utf-8?B?WjRpNXhrOUFHQ21veDgzSks2d1FEU0EvRmxicndoaGRLS0FWWmpIb0h5dHJu?=
 =?utf-8?B?eXBYbTJZeUVFOEZrUFFGQktQKzIrcmE3UnA1QVp5Sk5hSnRnN3BNTy91TWFh?=
 =?utf-8?B?RW5DNXNWMkJYM2F2ekRtR2hVMUErUUpuZmhjdDFFQkxSdXRHU1JaTkt2Tk4w?=
 =?utf-8?B?VHdRbDdqZTUxSWhtUkw5VVAyT056Z0pMQUdnTTVocmU3K21WWWdpd1drOWdD?=
 =?utf-8?B?cVJEWFd0SkZxOXhmS1YzY3lNNUNUSkRxYXpSeUplR1dENG1Fa25KNHp5anNn?=
 =?utf-8?B?RCtEZ3AxczlnTXR6Y2pLZStuWTAzOVI0aXNFaE9Tc1U2cm81TmNJSW5XQkg0?=
 =?utf-8?B?Z2lXeTBDYldFcGRpczNNeTFLWFBlWHlDVWNmdTZIbHZWWnlZQlF0WDRFcVNB?=
 =?utf-8?B?aVV1UmJRZVVqWHBjUmlsZXF5MnI0c29ndWU0YURDM0cvZ0E4L0tBQWcxWkFh?=
 =?utf-8?B?WTR1Skt0UXlyTlB2aUFISlZPT0xDZTVMMU4wVnRQVmNnbUpMTDBzWkR3QjFw?=
 =?utf-8?B?TG1VT0pCUFFyUnJuS1cvZndwTkVudHVqUWRFVUFkV0xhcVppY3d5T2dJdmRj?=
 =?utf-8?B?c3NacDU2NEkranpCNldlNWYyOExVaEJWNmR3Yk9SUlYremF4TmFuckMyWGRX?=
 =?utf-8?B?UnAyQ29ueTZ2aElYd2FHQWRqdTJSbmFIc3RpaVFjamZ2WGVRSjh2Q1JhY1BF?=
 =?utf-8?B?UUlqak1LSzFWMHVIMDZXS0YxYjQ4bzJJd3NnZjdsQnJ1bmNPMVdrK1U2RGdF?=
 =?utf-8?B?VVg1ZFcxSHJ3dmYzWjVya0hQekNTUC9lN2d2Zis2bmV3T3F3S0lVQ3kvbkZp?=
 =?utf-8?B?QnVwK213RkQzOWsvUVpEelEwU21lOGRlRTVaZkhUUU9yYTVDV0Yrc2plNmpK?=
 =?utf-8?B?U21Ha0ZVNXAvTWRTaWMxYzZNWDREQ1FsRGQ5MXladm9hV0RzaWlxQUY4ai8z?=
 =?utf-8?B?ZHIvYlhvZ1lDUXIwRlExOTBnaE9ZNlpRU1I4NlJlZUtldkNwQnpRVVRjSlMv?=
 =?utf-8?B?Z3lxMWtZaEdkZUpSdUdna1IrcVZjTWJqWk5NZ0NFYXFnVkh6Mlg2WmpxNTAr?=
 =?utf-8?B?RUNyUmRqK0t2RmdJVmdRUU9mM3RYS3VPekF6a1A3SGFFUi9mRThSVVJwUHQ2?=
 =?utf-8?B?ZkY0QmdHTTd6dnh3a3Fnc1E3V1JvdVdEQ2RidnpDNE92ZnVYSDZ6ZFNHUmpp?=
 =?utf-8?B?Y2Z6bEc2c0NXUVQvYkNHVExhWnhmM21yb0JDYkpzZ1JSRFc5d3E0WDFEYVhY?=
 =?utf-8?B?Z24ycTEwYS9NMG1iclM1T2JTWVQ4Rm5nRmZKVUl3VEdlNEpZOHc2Q3ZMeDA3?=
 =?utf-8?B?eElERTZybkJRS3JtS2t0NzlHc1JFS1BOQTRkRUk3bSszcDh1RkRuWDZFZm1j?=
 =?utf-8?B?ODJjaHo5QTdJNjdwSk44NnMxTHdxaG9ubG5PdUZIUEVOcXVmQW1PTEVUd29T?=
 =?utf-8?B?ZUVmNXZSS21SWkM3RStaVVhDTVo2dVZDL0pEb2x5V1VvQ21nWTlXWFVEWGVu?=
 =?utf-8?B?WFArV3JvUEhOZGJ1QTQvT1d0aCt5eXBhUks2bXRVWHpLWDhaMUdka0RlQmpN?=
 =?utf-8?B?ODdHSVM4ZUhHaXRsM2VyN0g0ODVsTWZwcVkxb3dJWlFacGpYQXQzaitCWHk5?=
 =?utf-8?B?a2ExQUxKSTc5eElqTU9qMnBmMEp1WWlicEpFcjE1NktHWkpVbWxwMXRFTUFy?=
 =?utf-8?B?ektJY0FEM0VQd2czOC9CQ25PTTVoQ1N4a1JqTVNvbjBqYitIS0ZUaHVGY1VN?=
 =?utf-8?B?N0VPb3Z6MEtwVDJpZ3lMNmJpVmZGN1dnOGhnQ0lYbWNCajErM1pDMlNCa1lr?=
 =?utf-8?B?cmxCSmpLb0JDZU9mNFIrRzBvTE1NRHo1STExc0pXZVFnVkNGK2Y4S1VaYnV5?=
 =?utf-8?Q?8IBwr6gwPe5ro03TtuM9MKVXn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA21AECCFF3A7842B899B8FC24C957D4@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47013499-7c35-4a0c-6131-08dbc8c6acd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 12:53:03.0983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jFuAy1gICASGvLFwaWTdDkhQJjmdUVFqwlZB/lylt2aW0ekaphKwb5kEjn4HXh44GKEk0YRSFr/w8EhqRbreQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR05MB7536
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDksIDIwMjMsIGF0IDM6NDIgUE0sIFVyb3MgQml6amFrIDx1Yml6amFrQGdt
YWlsLmNvbT4gd3JvdGU6DQo+IA0KPiAhISBFeHRlcm5hbCBFbWFpbA0KPiANCj4gT24gTW9uLCBP
Y3QgOSwgMjAyMyBhdCAyOjIx4oCvUE0gTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4gd3Jv
dGU6DQo+PiANCj4+IA0KPj4gDQo+Pj4gT24gT2N0IDksIDIwMjMsIGF0IDM6MDAgUE0sIFVyb3Mg
Qml6amFrIDx1Yml6amFrQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gISEgRXh0ZXJuYWwg
RW1haWwNCj4+PiANCj4+PiBPbiBNb24sIE9jdCA5LCAyMDIzIGF0IDE6NTHigK9QTSBJbmdvIE1v
bG5hciA8bWluZ29Aa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4+IA0KPj4+PiBCVFcuLCB3aGlsZSB0
aGlzIE9LIGZvciB0ZXN0aW5nLCB0aGlzIGlzIHRvbyBoZWF2eSBoYW5kZWQgZm9yIHJlbGVhc2UN
Cj4+Pj4gcHVycG9zZXMsIHNvIHBsZWFzZSBvbmx5IGRpc2FibGUgdGhlIEtBU0FOIGluc3RydW1l
bnRhdGlvbiBmb3IgdGhlIGFmZmVjdGVkDQo+Pj4+IHBlcmNwdSBhY2Nlc3NvcnMuDQo+Pj4+IA0K
Pj4+PiBTZWUgdGhlIHZhcmlvdXMgX19ub19zYW5pdGl6ZSogYXR0cmlidXRlcyBhdmFpbGFibGUu
DQo+Pj4gDQo+Pj4gVGhlc2UgYXR0cmlidXRlcyBhcmUgZm9yIGZ1bmN0aW9uIGRlY2xhcmF0aW9u
cy4gVGhlIHBlcmNwdSBjYXN0cyBjYW4NCj4+PiBub3QgYmUgaW1wbGVtZW50ZWQgd2l0aCBzZXBh
cmF0ZSBzdGF0aWMgaW5saW5lIGZ1bmN0aW9ucy4gQWxzbywNCj4+PiBfX25vX3Nhbml0aXplX2Fk
ZHJlc3MgaXMgbXV0dWFsbHkgZXhjbHVzaXZlIHdpdGggX19hbHdheXNfaW5saW5lLg0KPj4gDQo+
PiBSaWdodCwgYnV0IGZvciBHQ0MgeW91IG1heSBiZSBhYmxlIHRvIGRvIHNvbWV0aGluZyBsaWtl
Og0KPj4gDQo+PiAgICAjcHJhZ21hIEdDQyBkaWFnbm9zdGljIHB1c2gNCj4+ICAgICNwcmFnbWEg
R0NDIGRpYWdub3N0aWMgaWdub3JlZCAiLWZzYW5pdGl6ZT1hZGRyZXNzIg0KPj4gDQo+PiAgICAv
LyBZb3VyIGNvZGUgaGVyZS4uLg0KPj4gICAgI3ByYWdtYSBHQ0MgZGlhZ25vc3RpYyBwb3ANCj4+
IA0KPj4gTm90IHN1cmUgaWYgdGhlcmUgaXMgc29tZXRoaW5nIGVxdWl2YWxlbnQgaW4gQ0xBTkcs
IGFuZCBpdCBzaG91bGQgYmUgZG9uZSB3aXRoDQo+PiB0aGUga2VybmVs4oCZcyBfUHJhZ21hLg0K
PiANCj4gVW5mb3J0dW5hdGVseSwgdGhpcyBpcyBvbmx5IGZvciBkaWFnbm9zdGljcyBhbmQgZXhw
ZWN0cyAiLVcuLi4iIHRvDQo+IHN1cHByZXNzIHdhcm5pbmdzLiBIZXJlIHdlIHdhbnQgdG8gZGlz
YWJsZSBrZXJuZWwgc2FuaXRpemVyIGp1c3QgZm9yDQo+IHRoZSBlbmNsb3NpbmcgYWNjZXNzIGFu
ZCBJJ20gc3VyZSBpdCB3b24ndCB3b3JrIHdpdGggZGlhZ25vc3RpY3MNCj4gcHJhZ21hcy4gSSBk
b24ndCB0aGluayB0aGF0ICItZnNhbml0aXplPS4uLiIgaXMgaW5jbHVkZWQgaW4gdGFyZ2V0IG9y
DQo+IG9wdGltaXphdGlvbiBvcHRpb25zIGFsbG93ZWQgaW4gUHJhZ21hLg0KDQpVZ2guIFNvcnJ5
IGZvciB0aGUgbm9pc2UuIFlvdSBzZWVtIHRvIGJlIHJpZ2h0Lg==
