Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB887D0A92
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376489AbjJTIdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376471AbjJTIdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:33:07 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BB41A8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:33:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gwf+wgBRAVJqnubBFY0nD/DO8ld338euAIPKex5B+d072BpTTYoZSQGP0eKZPYul0wkocpIMQMJocvuNhcu7fTfM3SaibRSyVW3L2+2kPeYYTZQMKF6G/VMvzDLrKEY/w7Ucu3/TAx6AWo+dN8KTHNbWglI14pVcq0X3YS7LetX4A2BCB4jMbob2y7o0ISogKmEqaFo8lrdlGns/GTIOrBLyunqf7p1CcvAChDnxTH0SQkCXZX1xLJJqJpIIZznlJpdc9HsaU0VOEkJ46b9FNd90zbvqA7GRfYwphvVh/u3Ap6FcbukTtLJ1r7AfmXfaWskbLoUOeAesYC5FzjInfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLeDCsHgTXb+SDtdjGQ+dctpNlokNe2hbYV75VLhZls=;
 b=WNjGnuAjbLvnXxYorS2yC/hCqtdpPih3pr7T5uZp243qNXbxuwUIbJnnhTJalCcGDPLOvEaxUE/+LhDEahARIvXaxyFVTTyy5HH2/XstDhQCBmS0yI2EqRbI4unrDsgMXH+JXCnk/FKBinRLFau1jDlrrmM7f6A75WvL2SxFI6JrIeifWJg5pVxlb86Dd+DeV7LntfnYhrRppomKT2JMAJTdR+wru0gOFTyMwLGmu0diu0w1PMV9nfnY+bFIZAanRG3zoHfQYboSujoS3Dv8l4MCSEKv5/zAFHkcOHMI9ObDsffBCUShve5sdv+TJ3MAbTdj+TgTi4cSuJcpoch72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLeDCsHgTXb+SDtdjGQ+dctpNlokNe2hbYV75VLhZls=;
 b=D69XU1mhStaJ5B/+VCnYv7nUStqEb8Ahg6E5ONSXYfMLZR2dAzc/U9QmHI9tftt/6XnFR0svrDLzFINsfOWYOLMrfHmKuCnjVRWUMkbQwskdvMSj+t1zu2csKrgrz6qyq1foPWrdtYG/VBgt7D0GbxUstTWZBaHvXo7UDmSOuS0=
Received: from PAWPR02MB10280.eurprd02.prod.outlook.com
 (2603:10a6:102:34f::18) by AM7PR02MB5782.eurprd02.prod.outlook.com
 (2603:10a6:20b:104::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 08:32:59 +0000
Received: from PAWPR02MB10280.eurprd02.prod.outlook.com
 ([fe80::ae8a:f8e:f622:d3db]) by PAWPR02MB10280.eurprd02.prod.outlook.com
 ([fe80::ae8a:f8e:f622:d3db%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 08:32:59 +0000
From:   Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To:     "edumazet@google.com" <edumazet@google.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gus@keba.com" <gus@keba.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "viro@ftp.linux.org.uk" <viro@ftp.linux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: AW: [PATCH] amd64: Fix csum_partial_copy_generic()
Thread-Topic: AW: [PATCH] amd64: Fix csum_partial_copy_generic()
Thread-Index: AdoBilvmES7GiG9dTkSxSspB8XHmAgAT0kuAABppQjAAAY4CAAACgE2AAADfOIAAAhtsgAAA7O6AADM5eAA=
Date:   Fri, 20 Oct 2023 08:32:59 +0000
Message-ID: <44b4e841067034f937f80869f967c7882d162452.camel@axis.com>
References: <VI1PR0702MB3840EB26EF2A1A35BFEA53BFD9D5A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
         <20231018154205.GT800259@ZenIV>
         <VI1PR0702MB3840F2D594B9681BF2E0CD81D9D4A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
         <20231019050250.GV800259@ZenIV> <20231019061427.GW800259@ZenIV>
         <20231019063925.GX800259@ZenIV>
         <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
         <20231019080615.GY800259@ZenIV>
In-Reply-To: <20231019080615.GY800259@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|AM7PR02MB5782:EE_
x-ms-office365-filtering-correlation-id: 4e367b69-913b-4f90-97e0-08dbd1472add
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K4chdNm/Jv35+sbMlzl/xqMLsAgtRvqo3j2eOexNLL1gpqv43TuwO7vu7Tcdo4N31fbLjMjyfIf8PCfSWPN+WLCgZtJw+ftipXUSdcEC9pgtkXP/FGAlX51f3gC2FgiytDFgkW28Xaite8R2gWNiA391JZ6N6+5t8b4y7XjsL91v9vtaRZKN0rwDFOLNmALemWNRIbNfQfm/J3a+dQSHR+fiC013xJgYPzsGRnjaamUd9Y28RxO1Hd1yR/dvEvEV6OGyQeWbcKDb0cUCYz5xSMrEkPDnM1h+y62L+chGvUfEtpjSR0jPnOtiGl0vYb9rssHCGaQAEWoTgaJPV96W1AMrU+ylZG5eNi9hjcGtMaAIz/Nnk/+0uEWLPJCkfCPhh9xUyrLOLjnyi35D7QRhO866mRkj756ReescKpol9Vd/LTQ61NRyhVURSgdabjf2TX0j+5h+Maw42LbU59pJz2+tcRLgwgnNwg58VEyp4MaBC5ssizngrGLNZnxscZkqCMUpIppQVaS4WBmhKjF3A5t2sbQfFVfE27Gvs8A6yJ8dyAAyuUwGiLHIGI1HwjH+gznGCseGQLt9yaDgykRSVxW+uyOp0PBk564/3vASYb+aRHlTKQz6XFlc73KAHO0aQSh4LcAYgXdNQqfYsoSPHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(376002)(136003)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(86362001)(6512007)(26005)(2616005)(4001150100001)(122000001)(41300700001)(478600001)(6486002)(5660300002)(8936002)(2906002)(4326008)(66946007)(66476007)(64756008)(7416002)(316002)(66446008)(36756003)(66556008)(54906003)(76116006)(110136005)(8676002)(91956017)(71200400001)(6506007)(38100700002)(38070700009)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm5nWGFZcktaQWk0QzE5OXB3OS9kakVHcmJXNm1Dc2QvUExCTFdNS3dtQWl5?=
 =?utf-8?B?TWNvYXpHQkZGUWFOcXZiVWM5UVVtbEVxZDU1dUNEY2ZWSDZtYTlVbU1XcUti?=
 =?utf-8?B?V1ZlQ0FnTnJnREdWbFo5WTZDMGtTc3Q2aWg4UzdVQnhhTW4wN3dUM2gvRVQ3?=
 =?utf-8?B?K1RWa2U2NVNGYTRnT3E3RjdNckdQSEpPQTFHdGZpdWZBVXZzMjRjZkt4aEVF?=
 =?utf-8?B?UVN6Wkd0VGhKOGljZ3FVeFJiT2gxRTk3U3dSejlYdDZwRndWVFFGOFJVN1ZG?=
 =?utf-8?B?aWxkU1BCZGJsVmxMS29xa0JNTjZpaTJjeDRhSmtMY3dMRlVsT21wWE9iQkRC?=
 =?utf-8?B?K2NQSGNXY29DczVoMjhkOUtjWEhDUDMxU1RrblJQNEREUFI2UGlTdnE3YTFm?=
 =?utf-8?B?aXcveGt3NE9vdnd6eUQrdkF2cTJpenJ2SytTTmt2bTJXRzFZVjl2aUR6cFBY?=
 =?utf-8?B?Mi9SMW9tQlFBOFFzVHUrV0licE5vL0JQak4xM2lTeTdHd1BQbW1Qd1NSdWVE?=
 =?utf-8?B?cUpNNXd6allBWWdFNmNQdWpXWHlFZGhBZ0xYRnlOTC9RckNPS1ZDQ3FOMk1F?=
 =?utf-8?B?blI2TGNST3k4eTFVajRlOG8wMUJZNTZoa0FxMkk4eFhXL0JWeDgzMnJITnN2?=
 =?utf-8?B?WnA1NTA1cWZWRDQrWTFmMGFKalpkUFB0Q3BuVXBSdHA4UTJWZXFRcGtFNGhC?=
 =?utf-8?B?ZkFxaGdUdTh6d0d3ODU2Q29HeWpQcDQ3cGx5SjZsbFE0OHk2ekhTVit6dTB1?=
 =?utf-8?B?Mkw2NkhDYVVaMFd2SDRSVlBqZUhhWjNjUzFLd2ljWThzbkNNMHlidCs5a1Vz?=
 =?utf-8?B?Y2RaU0thdjRTRlV5ZkNWa2hMVWNKaTZNb2NOQ3ZMWHEveG9YQ2hjaDJOb1ZM?=
 =?utf-8?B?TVkrT1M3R1RZV3VKVW1SaUZOT2Jma2pGM2RWOUtITU1PUE1VYndtWUNHNDAx?=
 =?utf-8?B?cC96ME1HYTd0Uk5uUHVNTGo0S3d6VzFHQ1ZrSDV0N0hKak81MVBaT3UydFpX?=
 =?utf-8?B?OFFZU3diQnpTMldrYWMxSkZoTmV4TGdjbDZkb0dtc0RQSHJIL1RzMmZpMllM?=
 =?utf-8?B?NnJlQWlGNk1mY3hPa1V6NlN3azhkU1UxNmEyY1EwTXAybnJraTZrM29hUmx3?=
 =?utf-8?B?elg0c0hNaXRZYXhjVjJ4eGJrbTNFTjBmYmhqMjQ4YkJjUWFUak43cEhIUmRu?=
 =?utf-8?B?aUlnanJ2ZndhN0VZNVh0S3QxNzkrZkxzL29ObzFpakhTYTRmcm9jNjFGYW9t?=
 =?utf-8?B?TEhIclFBcmIrV2VFZEZLdHhhSTA4UmpGUG5tMG5GMk16MERVeEdaTXp6ZTBU?=
 =?utf-8?B?THZkRUdMdlphTzVzL0pMUXlXL1hoSHEra2Zzb1lNcUx6eWZqM0FFY1ZmVUcy?=
 =?utf-8?B?OVNvVHZvMXlRNnA4V2ZkQ05zM25UUnVUQW5TMTdlQ0lZZWJFOWo1TWViWERq?=
 =?utf-8?B?V0MvSkVuSVRlcUlhdUkzSURaRU5MWHFpdnQ3WHJVZE1ycjgxR1pKeUluN2dV?=
 =?utf-8?B?V0dqNWNrRDBxVHp5bHdacUFVMHRDZmx2WmlMcnVTdGE2dzhzYWh3dVVnejB2?=
 =?utf-8?B?ZFNkU1NMd3V3Tys1ZkhiRVlIclg3enNpbzRlYUxtR1ZDUjhja0lFaTB1MjQ1?=
 =?utf-8?B?Q2pLb0Zoakh2c2ZKTWlEaS9CZEtuUHR0RVhoRFdLK1dUeUVPdlZmTW9nWGRx?=
 =?utf-8?B?R1pMc3RWUlBLNjJKMGp2TWpUTk9mWEZMWDhXSTY3dmoveFllM1VGYXNBK3NN?=
 =?utf-8?B?d0k0b3c4WTA4T1VJVmlWbEx4bW9zeUdMK2NveFVoVTNJcWdER01zYnI0OXdX?=
 =?utf-8?B?R25uT1FMSmdxOEtLcjRsYU9DWEVUU1B1VWwxWHJHYUJERHpTK2JBVWFDcXFn?=
 =?utf-8?B?QzZsaUdJdmJuS2R0Z0M0M3lTY1RXU3ZtYnhwYkpFQUxPZWNHZ1pvaHdndWtY?=
 =?utf-8?B?QlVwMWZBWXErSEcwakVpSGtYMzNXODhvMkIwRmV1Tk1VemxPVk82UHBJWXUz?=
 =?utf-8?B?UExnR2NLSlV6UGZvV3c1MjNWdmFYaCtuNlNwZGVHQyttSlJ2Um5XTXJuWG5M?=
 =?utf-8?B?cE1idG1FVUcwNEhHaG84eDBaZEoxUGxNcFZjbXV1dlFmcmpvbFAvczZFai80?=
 =?utf-8?Q?/XHL3EtSMG8pYn93bl4fvB+j5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <020C3D39E0BB54418324A76F3DBFBD46@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e367b69-913b-4f90-97e0-08dbd1472add
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 08:32:59.4815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1VgLkaJnBMKpA6RSvwYoFZCGF1vMeexqoRE2cuR0ytZ/jxNEZmykJIk5oxqp22s5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB5782
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTEwLTE5IGF0IDA5OjA2ICswMTAwLCBBbCBWaXJvIHdyb3RlOg0KPiBkaWZm
IC0tZ2l0IGEvbmV0L2lwdjQvaWNtcC5jIGIvbmV0L2lwdjQvaWNtcC5jDQo+IGluZGV4IGI4NjA3
NzYzZDExMy4uNmRhMDkxNTdmNzIyIDEwMDY0NA0KPiAtLS0gYS9uZXQvaXB2NC9pY21wLmMNCj4g
KysrIGIvbmV0L2lwdjQvaWNtcC5jDQo+IEBAIC0zNzYsNiArMzc2LDcgQEAgc3RhdGljIHZvaWQg
aWNtcF9wdXNoX3JlcGx5KHN0cnVjdCBzb2NrICpzaywNCj4gwqAJfSBlbHNlIGlmICgoc2tiID0g
c2tiX3BlZWsoJnNrLT5za193cml0ZV9xdWV1ZSkpICE9IE5VTEwpIHsNCj4gwqAJCXN0cnVjdCBp
Y21waGRyICppY21waCA9IGljbXBfaGRyKHNrYik7DQo+IMKgCQlfX3dzdW0gY3N1bTsNCj4gKwkJ
X19zdW0xNiBmb2xkZWQ7DQo+IMKgCQlzdHJ1Y3Qgc2tfYnVmZiAqc2tiMTsNCj4gwqANCj4gDQo+
IMKgCQljc3VtID0gY3N1bV9wYXJ0aWFsX2NvcHlfbm9jaGVjaygodm9pZCAqKSZpY21wX3BhcmFt
LT5kYXRhLA0KPiBAQCAtMzg0LDcgKzM4NSw4IEBAIHN0YXRpYyB2b2lkIGljbXBfcHVzaF9yZXBs
eShzdHJ1Y3Qgc29jayAqc2ssDQo+IMKgCQlza2JfcXVldWVfd2Fsaygmc2stPnNrX3dyaXRlX3F1
ZXVlLCBza2IxKSB7DQo+IMKgCQkJY3N1bSA9IGNzdW1fYWRkKGNzdW0sIHNrYjEtPmNzdW0pOw0K
PiDCoAkJfQ0KPiAtCQlpY21waC0+Y2hlY2tzdW0gPSBjc3VtX2ZvbGQoY3N1bSk7DQo+ICsJCWZv
bGRlZCA9IGNzdW1fZm9sZChjc3VtKTsNCj4gKwkJaWNtcGgtPmNoZWNrc3VtID0gZm9sZGVkID8g
Zm9sZGVkIDogQ1NVTV9NQU5HTEVEXzA7DQo+IMKgCQlza2ItPmlwX3N1bW1lZCA9IENIRUNLU1VN
X05PTkU7DQo+IMKgCQlpcF9wdXNoX3BlbmRpbmdfZnJhbWVzKHNrLCBmbDQpOw0KPiDCoAl9DQoN
CjMyLWJpdCBBUk0gaXMgYWxzbyBhZmZlY3RlZCBzaW5jZSBjb21taXQgMWQ2MGJlM2MyNWVkZjRi
OTUgKCJhcm06DQpwcm9wYWdhdGUgdGhlIGNhbGxpbmcgY29udmVudGlvbiBjaGFuZ2VzIGRvd24g
dG8NCmNzdW1fcGFydGlhbF9jb3B5X2Zyb21fdXNlcigpIikuDQoNCldoaWxlIHRoZSBhYm92ZSBm
aXhlcyB0aGUgSUNNUCByZXBseSBjYXNlLCBhcmUgdGhlcmUgb3RoZXIgY2FsbGVycyB0aGF0DQph
bHNvIG5lZWQgc2ltaWxhciBjaGFuZ2VzPyAgRm9yIGV4YW1wbGUsIEkgc2VlIG5ldC9zY2hlZC9h
Y3RfY3N1bS5jIGFsc28NCmNhbGN1bGF0aW5nIElDTVAgY2hlY2tzdW1zPw0KDQo=
