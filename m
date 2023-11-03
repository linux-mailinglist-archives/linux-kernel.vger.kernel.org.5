Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C937E0721
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376371AbjKCRCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjKCRCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:02:20 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2105.outbound.protection.outlook.com [40.107.7.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF05125;
        Fri,  3 Nov 2023 10:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INHf8DjhBQUDsTh7uHgVO5RpHz30vc7dhaycg0mHqNSpxW+E/x25JyEB+0n3MfQ1q9x9AbSvcq8bOzBqLrDAQjn0BWd8+1herSZ6H5GrFHxd5NQGT+trgefygF8bjEXEu9Zgp9vm4/rTUFAmFE2j/voweCeFLFwY/YYINNzABVRpZUt82kFM8ZyA+kU+IHZpUtEBVi3qtF/7hHiVLbJEnwVpzdFNpY8cw7dpxkaz5cKqrhzyxE/vY2ow01HghPlUrfIbZ7iPZXERNemHwkbIDPnaCa7J5pEvqEEiueKuDejxKHKAMhjtrt5pvXuVaqMgH5L4SCcEpmd9CLEMvleM4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDtIq/nJJOIwOIMy3jVAVoj3bkXfDGJIKNbWrIW4C9s=;
 b=On20dYnCeL032qtb/mAj8XUij4ct1WRKDt1SzL50Gar5WqPOsWec/fsRoji1b5vKj0El37lVCyfWyskEQJ0mO8HNE0vBsAX2iC5hR4VK35VpwNwTqAcvil5QzxzquS/BnD5E+q5m6t1sS9+b6ReJvk8trR93hiWhV62RTqM0+GzbARRGRtBV69l2RY7m2QVy3jUB5nSpVNgBAiPQSHUCHq/TWBgbM3mKE4J0M15L42aJP3o3iEvOB/b6lc5USrOmlfSsjNrxvbrsAAygDS61gRz+HQ1S9E606nvoRvsnzKC7nBwpJhP/r1GeHOTfLMkUe90hE8q7HPH1GmE7GOVOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucl.ac.uk; dmarc=pass action=none header.from=ucl.ac.uk;
 dkim=pass header.d=ucl.ac.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucl.ac.uk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDtIq/nJJOIwOIMy3jVAVoj3bkXfDGJIKNbWrIW4C9s=;
 b=WRglyHjOWgESnUgFMRKZQRm5ES+gMn3stB13R7nVFdhe1vm0F5Cvlh70gaGJq+ncVjN1QAa0Hd9bQQTXbvlP3hP5lzLRV4cPDNsgZueDfoKtOK2ad3RLkyLoaCkU7JZRHwOMvCjCEa3I1Riwfp4h4m9FhnSQ2UaH8rkLlYVJa1o=
Received: from AS4PR01MB8966.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:4e5::7) by DBBPR01MB10459.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:538::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 17:02:10 +0000
Received: from AS4PR01MB8966.eurprd01.prod.exchangelabs.com
 ([fe80::4312:4012:64b1:3065]) by AS4PR01MB8966.eurprd01.prod.exchangelabs.com
 ([fe80::4312:4012:64b1:3065%5]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 17:02:10 +0000
From:   "Alglave, Jade" <j.alglave@ucl.ac.uk>
To:     "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "davidtgoldblatt@gmail.com" <davidtgoldblatt@gmail.com>
Subject: Re: [isocpp-parallel] OOTA fix (via fake branch-after-load)
 discussion
Thread-Topic: [isocpp-parallel] OOTA fix (via fake branch-after-load)
 discussion
Thread-Index: AQHaCRm5jjja+93RokWqgS0fNkFx6rBo3EHA
Date:   Fri, 3 Nov 2023 17:02:10 +0000
Message-ID: <AS4PR01MB89662350CF351ADA124816B0ACA5A@AS4PR01MB8966.eurprd01.prod.exchangelabs.com>
References: <b1634b24-4541-49c5-867c-7f24292a27bb@paulmck-laptop>
In-Reply-To: <b1634b24-4541-49c5-867c-7f24292a27bb@paulmck-laptop>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucl.ac.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR01MB8966:EE_|DBBPR01MB10459:EE_
x-ms-office365-filtering-correlation-id: a05d79ed-fc0d-4bf0-9355-08dbdc8e9e30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bYPzmkfVsBDSh7ejGp6mV9PFGrUsi2JMSIotitKKTzj2pgynGnQv6pKmquhJM5/acuEwQpmmAg6z2Zy4XPOhlH4jifjhNq9vyzpoJTnMRCVzaFMZfZQCWuVXJeuUmAoGpt2QVgF/a9QgVG6ZK0xe9BZq/Gugbhl8D+loLC46RNUc40Ph3n2t04XJ8FSvIfxeBVWMBJHWq8ehGxg2ULQ5tmYAoR5h5KaB5qYkJkhG9SYxRvCL70QhAqZE6O0r9UP+h6JlZh6cRrE1AvwtCZgkAljSi/gibwpSPdjZxRgLQVNgS6jkkMshgUpoLEm+J/VrB+wQy7Zc3fRHVSB/f+PaGw3Zdb0qEKKdEJRASO+eua0S9b4t//ZWB6SY6kmRnANHSy6LjHbpuoAZHEvH3H5UbZ+SiEjYlIgGFLBix7cz1YpTxtfTaiJB5pd0+rQdlFETUkC5zPCFV9jKYQu9OO56TKrNbDwqbfazyj0AxJVsJJCucDK6R9QAkFU1P7DP52Pb/vFk3O2squ1sKte2xh23jCs8aLUIo28Uisc7WsVZYxfhZwJTez8uq439l01c8pw4yOZMIkt+kjzbrQuh4eoU1hF6hh0rSE4LxJCtNUn6jfeark4mg+ScWu8aC/zt4aP8Mr/z2BeCXdSwAwgZUIMFiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR01MB8966.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(230173577357003)(230273577357003)(1800799009)(186009)(451199024)(64100799003)(83380400001)(55016003)(38070700009)(26005)(786003)(86362001)(54906003)(66446008)(66476007)(66556008)(64756008)(316002)(2906002)(110136005)(8676002)(8936002)(91956017)(4326008)(7416002)(52536014)(5660300002)(76116006)(41300700001)(71200400001)(45080400002)(16799955002)(9686003)(6506007)(7696005)(53546011)(33656002)(66946007)(478600001)(966005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkNhU0pqVUZ4dG9lMi9MbjJxSjRMem5KbDg4UWJxL2pheklCVWxDT0txN0ty?=
 =?utf-8?B?bnJCcjNBajFlZ1U3VE5FQnZsRUN0N3dxRllwMXcwS2FnUVpyOEtYeEZKMFRU?=
 =?utf-8?B?SS9HdXNGZy84eW1UMnd0TWhIdnpGa3AvdW5QY1lnYkhBaTUweTVNR3paNGdk?=
 =?utf-8?B?U2p2UW1HMmk4RWN1N29kNk1qMnFzRGtVTmFkQ3BpNk4xSEV1UFpjTzE5QWNM?=
 =?utf-8?B?YjYxLzJSZ3VmRUJSbVh4VzdDRW1JMVloeXJrVFNVTURnYnFmOXN5dlcrRlJZ?=
 =?utf-8?B?MDZCMjRtR2VPVXN5UkZFNXVmQ2NzTGF5aG9PSkRZMGJFR1RhSmljcjFrcW5U?=
 =?utf-8?B?R2wwUnE1QkZpM1NDUm5BUjdUaVlqU09FMjUvWmhJeEZ2QkJrTFV0VnFjMGV6?=
 =?utf-8?B?K0hES3ZvQ3ZSWnIrdFQzSUhNaG12WGtNZkw0UFN0SGp2T2RkQ2w3LytiTitI?=
 =?utf-8?B?enVDbTU1ZHNZQlRJSDhUd201cC9BTklCSU94a3VMd2Qybjk3aUlWbiswN29v?=
 =?utf-8?B?QzNGcVJ0NUFwL0YvU2Nydm40eWtSeVlUT0Jna1UyNFFzTWZUc2hodFVUOUNO?=
 =?utf-8?B?Qk14endhclZYVmE2WWFnNmZLem9zdWw4em5WTlVNL2Rva3VQNjBwQVhOSUhW?=
 =?utf-8?B?L3V3Nm84NE81T0doSUhwNnd6MVJmSkhub2xvZ2Ewc2NGQmFiRVVGalNTNUtu?=
 =?utf-8?B?bDVjaGo3WEkvWTIydWFMMEU2QmNqNnIrU0JSUzlKekZZbVpuUkZyYjJWNFVJ?=
 =?utf-8?B?NXB5bmhYUUlUUUd3OGR0ZzdmaldhM3dpQUhhTlpoL3dBT2oweCt4WUJudmlu?=
 =?utf-8?B?MzVSTDhQWkZ2V0lCOVdURVVkTGw1OWd0aEdneGI5ODQvSWVqTWFPUzR6bDlh?=
 =?utf-8?B?RGRER2VRcWVTT2srQis2N2dRYkN2OWJGd3FQbnB2bTFaNytpTi9PbDhtOER1?=
 =?utf-8?B?Z1pTbFVXNlE0RmRSRENKcVgwS0taRnhUOE1RZlY1TW5ITDh1OUw4YnFuWHhR?=
 =?utf-8?B?SnU0YVZlMkJCcmNSZ2tkN1J1THd4aitnK0JZVUQ0ZUY2RjJrbFBmOHYzREQ1?=
 =?utf-8?B?TElyc052UTBlQVhXWGo2SWVTTlFFSWJEZzZza0VTQWZGM3pCenVYU0pSSUxp?=
 =?utf-8?B?NG1lVjBtNmc3b1F2bjhLZzN4SHFlNDB6d3ZsSDZ0VU9FYWhQekwwVDlkbnpP?=
 =?utf-8?B?eEFFeVpURldBZm10S0F4TXdiR1pMd1ZYZTJiQTMvMlZpUHcwUHBvYjdCRjA4?=
 =?utf-8?B?Y3F0N29kd2tuNE51UkVybmZhWDF3MzBvUmV0ZGRPcTEwZ0p1MEJ0Vzl6MVow?=
 =?utf-8?B?TXZFNW53OFNQMTl0LzVhMUZueTdMTGhxNGdnUTFMN3Zrem1RbmxnVGx6UEM0?=
 =?utf-8?B?T1RoNzN1Y21ickN1Z2x0aklRWWphQS9FODlNcHZBRWtMSWFKUUtUN1ppWjhU?=
 =?utf-8?B?RDY1Tmx6MWI4eU5jYkVyQWkyQUNnemo1bDAwcW5xQjJqUkhoZEhWS3JuWGcv?=
 =?utf-8?B?dVdDN21UZmVaSDZicjhhSjhFWmlRNlk0TjVlQ2FvK1IwYzdEak9FK1NML0Ux?=
 =?utf-8?B?T0MwTXVvSlZJMmRUV3orR1ZDd2EzQ0ZhUGZERktaRXo1eS9ma2FFUlJTZ2xr?=
 =?utf-8?B?c3pxZzhETDh4VHFJbHFGSTVKUnl6NTYvemZIbDlVMDZnbVR5ZFk5bGRlYmRT?=
 =?utf-8?B?ZFlhME1ZN2dyTmV2TEpmaGFlbGpDcU1HdU4rU3locmlkWDV5SU9KUldncUdr?=
 =?utf-8?B?NlhJNHJNcmVybFdCVjRkeUpkemxMdmhJZHZjTnJCOGVSMkNMcFFpSUJMWVNl?=
 =?utf-8?B?ZjZsOWF5azFTZnJybHcxMUhRNzkyT0dDQmE5MFJzOSttRG1MUHRWLzRPRlha?=
 =?utf-8?B?OVc3WjdFV0lWWEhSbWo1YzhEbloyS0hEUnJrNTNlZFBCcFpwNUYvZ0UyMjNq?=
 =?utf-8?B?VFNNaWU5cWJyTWN1UllWR3FlUkVONWRsblRMVzBQRE1hcW5ORmg3M1N2VFgx?=
 =?utf-8?B?NjNMS1hObkZ6cVVCYWFzN3p4VEoxZUtyTXlGREJFa0RUSmlRckNrM0pKVDN2?=
 =?utf-8?B?R0tkMmxSVEJtQ2Y3LzUvL01UbEtBdXozb3JUbzZhdE53SnQxVUhuSHVUbDJ2?=
 =?utf-8?Q?OSX4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ucl.ac.uk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR01MB8966.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05d79ed-fc0d-4bf0-9355-08dbdc8e9e30
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 17:02:10.0288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1faf88fe-a998-4c5b-93c9-210a11d9a5c2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCXLuqPJWQXAooTGl/qE7HxCN+rbG8dcNkvHUyyYiJaG/BE7z/3Umtt6ldCjv9nuF/Ml2MZiVVjCPHI3/oVQog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR01MB10459
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBhbGwsIChyZXNlbmRpbmcgYmVjYXVzZSBJIGFjY2lkZW50YWxseSBzZW50IGl0IGluIGh0
bWwgZmlyc3QsIHNvcnJ5KQ0KDQpBcm3igJlzIG9mZmljaWFsIHBvc2l0aW9uIG9uIHRoZSB0b3Bp
YyBjYW4gYmUgZm91bmQgaW4gdGhpcyByZWNlbnQgYmxvZzoNCmh0dHBzOi8vY29tbXVuaXR5LmFy
bS5jb20vYXJtLWNvbW11bml0eS1ibG9ncy9iL2FyY2hpdGVjdHVyZXMtYW5kLXByb2Nlc3NvcnMt
YmxvZy9wb3N0cy9hcm0tdGVjaG5pY2FsLXZpZXctb24tcmVsYXhlZC1hdG9taWNzDQoNClBsZWFz
ZSBkbyByZWFjaCBvdXQgdG8gbWVtb3J5LW1vZGVsQGFybS5jb20gaWYgdGhlcmUgYXJlIGFueSBx
dWVzdGlvbnMuDQpUaGFua3MsDQpKYWRlDQoNCg0KRnJvbTogUGF1bCBFLiBNY0tlbm5leSA8cGF1
bG1ja0BrZXJuZWwub3JnPg0KU2VudDogMjcgT2N0b2JlciAyMDIzIDIyOjA4DQpUbzogQWxnbGF2
ZSwgSmFkZSA8ai5hbGdsYXZlQHVjbC5hYy51az47IHdpbGxAa2VybmVsLm9yZyA8d2lsbEBrZXJu
ZWwub3JnPjsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb20gPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29t
PjsgbGludXhAYXJtbGludXgub3JnLnVrIDxsaW51eEBhcm1saW51eC5vcmcudWs+OyBtcGVAZWxs
ZXJtYW4uaWQuYXUgPG1wZUBlbGxlcm1hbi5pZC5hdT47IG5waWdnaW5AZ21haWwuY29tIDxucGln
Z2luQGdtYWlsLmNvbT47IHBhbG1lckBkYWJiZWx0LmNvbSA8cGFsbWVyQGRhYmJlbHQuY29tPjsg
cGFycmkuYW5kcmVhQGdtYWlsLmNvbSA8cGFycmkuYW5kcmVhQGdtYWlsLmNvbT4NCkNjOiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsg
bGludXgtdG9vbGNoYWluc0B2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LXRvb2xjaGFpbnNAdmdlci5r
ZXJuZWwub3JnPjsgcGV0ZXJ6QGluZnJhZGVhZC5vcmcgPHBldGVyekBpbmZyYWRlYWQub3JnPjsg
Ym9xdW4uZmVuZ0BnbWFpbC5jb20gPGJvcXVuLmZlbmdAZ21haWwuY29tPjsgZGF2aWR0Z29sZGJs
YXR0QGdtYWlsLmNvbSA8ZGF2aWR0Z29sZGJsYXR0QGdtYWlsLmNvbT4NClN1YmplY3Q6IEZ3OiBb
aXNvY3BwLXBhcmFsbGVsXSBPT1RBIGZpeCAodmlhIGZha2UgYnJhbmNoLWFmdGVyLWxvYWQpIGRp
c2N1c3Npb24NCg0K4pqgIENhdXRpb246IEV4dGVybmFsIHNlbmRlcg0KDQoNCkhlbGxvIQ0KDQpG
WUksIHVubGVzcyBzb21lb25lIGNvbXBsYWlucywgaXQgaXMgcXVpdGUgbGlrZWx5IHRoYXQgQysr
IChhbmQgdGh1cw0KbGlrZWx5IEMpIGNvbXBpbGVycyBhbmQgc3RhbmRhcmRzIHdpbGwgZW5mb3Jj
ZSBIYW5zIEJvZWhtJ3MgcHJvcG9zYWwNCmZvciBvcmRlcmluZyByZWxheGVkIGxvYWRzIGJlZm9y
ZSByZWxheGVkIHN0b3Jlcy4gIFRoZSBkb2N1bWVudCBbMV0NCmNpdGVzICJCb3VuZGluZyBkYXRh
IHJhY2VzIGluIHNwYWNlIGFuZCB0aW1lIiBieSBEb2xhbiBldCBhbC4gWzJdLCBhbmQNCm5vdGVz
IGFuICJhdmVyYWdlIGEgMi54JSBzbG93IGRvd24iIGZvciBBUk12OCBhbmQgUG93ZXJQQy4gIElu
IHRoZSBwYXN0LA0KdGhpcyBoYXMgYmVlbiBjb25zaWRlcmVkIHVuYWNjZXB0YWJsZSwgYW1vbmcg
b3RoZXIgdGhpbmdzLCBkdWUgdG8gdGhlDQpmYWN0IHRoYXQgdGhpcyBpc3N1ZSBpcyBzdHJpY3Rs
eSB0aGVvcmV0aWNhbC4NCg0KVGhpcyB3b3VsZCBub3QgKHJlcGVhdCwgbm90KSBhZmZlY3QgdGhl
IGN1cnJlbnQgTGludXgga2VybmVsLCB3aGljaA0KcmVsaWVzIG9uIHZvbGF0aWxlIGxvYWRzIGFu
ZCBzdG9yZXMgcmF0aGVyIHRoYW4gQy9DKysgYXRvbWljcy4NCg0KVG8gYmUgY2xlYXIsIHRoZSBp
bml0aWFsIHByb3Bvc2FsIGlzIG5vdCB0byBjaGFuZ2UgdGhlIHN0YW5kYXJkcywgYnV0DQpyYXRo
ZXIgdG8gYWRkIGEgY29tbWFuZC1saW5lIGFyZ3VtZW50IHRvIGVuZm9yY2UgdGhlIHN0cm9uZ2Vy
IG9yZGVyaW5nLg0KSG93ZXZlciwgZ2l2ZW4gdGhlIGxvbmcgbGlzdCBvZiBBUk0tcmVsYXRlZCBm
b2xrcyBpbiB0aGUgQWNrbm93bGVkZ21lbnRzDQpzZWN0aW9uLCB0aGUgZnV0dXJlIGRpcmVjdGlv
biBpcyBjbGVhci4NCg0KU28sIGRvIGFueSBBUk12OCwgUG93ZXJQQywgb3IgUklTQy1WIHBlb3Bs
ZSBzdGlsbCBjYXJlPyAgSWYgc28sIEkgc3Ryb25nbHkNCnJlY29tbWVuZCBzcGVha2luZyB1cC4g
IDstKQ0KDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFRoYW54LCBQYXVsDQoNClsxXSBodHRwczovL2x1a2VnZWVzb24uY29tL2Jsb2cvMjAy
My0xMC0xNy1BLVByb3Bvc2FsLUZvci1SZWxheGVkLUF0b21pY3MvDQpbMl0gaHR0cHM6Ly9kbC5h
Y20ub3JnL2RvaS8xMC4xMTQ1LzMxOTIzNjYuMzE5MjQyMQ0KDQotLS0tLSBGb3J3YXJkZWQgbWVz
c2FnZSBmcm9tIERhdmlkIEdvbGRibGF0dCB2aWEgUGFyYWxsZWwgPHBhcmFsbGVsQGxpc3RzLmlz
b2NwcC5vcmc+IC0tLS0tDQoNCkRhdGU6IEZyaSwgMjcgT2N0IDIwMjMgMTE6MDk6MTggLTA3MDAN
CkZyb206IERhdmlkIEdvbGRibGF0dCB2aWEgUGFyYWxsZWwgPHBhcmFsbGVsQGxpc3RzLmlzb2Nw
cC5vcmc+DQpUbzogU0cxIGNvbmN1cnJlbmN5IGFuZCBwYXJhbGxlbGlzbSA8cGFyYWxsZWxAbGlz
dHMuaXNvY3BwLm9yZz4NClJlcGx5LVRvOiBwYXJhbGxlbEBsaXN0cy5pc29jcHAub3JnDQpDYzog
RGF2aWQgR29sZGJsYXR0IDxkYXZpZHRnb2xkYmxhdHRAZ21haWwuY29tPg0KU3ViamVjdDogW2lz
b2NwcC1wYXJhbGxlbF0gT09UQSBmaXggKHZpYSBmYWtlIGJyYW5jaC1hZnRlci1sb2FkKSBkaXNj
dXNzaW9uDQoNClRob3NlIHdobyByZWFkIHRoaXMgbGlzdCBidXQgbm90IHRoZSBMTFZNIGRpc2Nv
dXJzZSBtaWdodCBiZSBpbnRlcmVzdGVkIGluOg0KLSBUaGlzIGRpc2N1c3Npb24sIHByb3Bvc2lu
ZyBgLW1zdHJpY3Qtcmx4LWF0b21pY3NgOg0KaHR0cHM6Ly9kaXNjb3Vyc2UubGx2bS5vcmcvdC9y
ZmMtc3RyZW5ndGhlbi1yZWxheGVkLWF0b21pY3MtaW1wbGVtZW50YXRpb24tYmVoaW5kLW1zdHJp
Y3Qtcmx4LWF0b21pY3MtZmxhZy83NDQ3Mw0KdG8gZW5mb3JjZSBsb2FkLXN0b3JlIG9yZGVyaW5n
DQotIFRoZSBhc3NvY2lhdGVkIGJsb2cgcG9zdCBoZXJlOg0KaHR0cHM6Ly9sdWtlZ2Vlc29uLmNv
bS9ibG9nLzIwMjMtMTAtMTctQS1Qcm9wb3NhbC1Gb3ItUmVsYXhlZC1BdG9taWNzLw0KDQotIERh
dmlkDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpQ
YXJhbGxlbCBtYWlsaW5nIGxpc3QNClBhcmFsbGVsQGxpc3RzLmlzb2NwcC5vcmcNClN1YnNjcmlw
dGlvbjogaHR0cHM6Ly9saXN0cy5pc29jcHAub3JnL21haWxtYW4vbGlzdGluZm8uY2dpL3BhcmFs
bGVsDQpMaW5rIHRvIHRoaXMgcG9zdDogaHR0cDovL2xpc3RzLmlzb2NwcC5vcmcvcGFyYWxsZWwv
MjAyMy8xMC80MTUxLnBocA0KDQoNCi0tLS0tIEVuZCBmb3J3YXJkZWQgbWVzc2FnZSAtLS0tLQ0K
