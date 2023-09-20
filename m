Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770AA7A701F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjITCHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjITCHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:07:46 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2087.outbound.protection.outlook.com [40.107.249.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C40BE;
        Tue, 19 Sep 2023 19:07:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTlDRVe0sUMPkUWsP/TCVVnRENrb0purR++vigTQcuFJZJw4SQaUt0URU9VVC92ne+KRrJieu9uZMfcJ1Ldr8k6ELWmehZdklAoC4/YE0R50JTuym1ST90fltNrd6hGdscQOYd9y8vePpSpKS2RBDmusm85VVw9C1J4E8Ey3aLz3hvNbve8Hjhmg5IUT4QFZioRxK6aQaY8PSzgmo198gi1xLUXP7REQWif5TACizX1VeAGX+8ptkercRGFH6wq7szF5PibyC23KNf3LsSQSz6jJiQM21e+NLu66YPA2DcaQZK11UmjHENnYPbnXv7PIBZmMXO7vFjHkDUzvm0EPvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VehUoVtnpI2wIMq9U80KxYvQe9KkfjJg+IanEms74Pw=;
 b=ZDpqmf2+B9x6FnXYea24VHPAucIlIjJnHKD+CjgDmBWjFwmBqrhlgO0EWGvirPoF0anVMx2bFNJhVyvjLvPu7yQrzxfO2+WTIVnhWaVSePk8qC6VYMYGoDriPLtA2xdI4vi1LtzT6ZCkdAcpd7dT1gaf4d91FGymoeoo6oV/XRhANAEKe9I+CNWmdJMvARzv4QF0wymdmBJvBGJ+A4LCHNpp/roXYhUeVeBcpi8sppgJuwLpP4Yya3F+jr2foBsgAxwHvua675Bb2Nq/NNaOYpLG26joDUQZUPsNBFxaDDyD7lCXxbr2pX7C8MKso5M6yQa7NYNEnGSlJIpQaIqJmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VehUoVtnpI2wIMq9U80KxYvQe9KkfjJg+IanEms74Pw=;
 b=KZsThOKp4bK29xLes6li/zr7n8Dtiv5b/cTJiJXF5zkmZtCa+1i+l0Gp/1XU2BL+aO7GG/RwM8J7K30RkojZtgtxfhZeaZf7SXFsDjF/Gw2uSvcNUvw0OerKJmAOuEOFjuJKbDAiQZESBff7yOCTPhdD1SrgHVFSCKa2gy8mpIg=
Received: from DB7PR04MB4505.eurprd04.prod.outlook.com (2603:10a6:5:39::26) by
 AS4PR04MB9573.eurprd04.prod.outlook.com (2603:10a6:20b:4fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 02:07:37 +0000
Received: from DB7PR04MB4505.eurprd04.prod.outlook.com
 ([fe80::6444:e07a:e7f7:3923]) by DB7PR04MB4505.eurprd04.prod.outlook.com
 ([fe80::6444:e07a:e7f7:3923%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 02:07:37 +0000
From:   Xu Yang <xu.yang_2@nxp.com>
To:     Ian Rogers <irogers@google.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] perf jevents: fix no member named 'entries'
 issue
Thread-Topic: [EXT] Re: [PATCH] perf jevents: fix no member named 'entries'
 issue
Thread-Index: AQHZ6s/3JFwCL+WAsEqlzRMMHng7dbAiTQuAgACpjLA=
Date:   Wed, 20 Sep 2023 02:07:37 +0000
Message-ID: <DB7PR04MB450509DB2DBE1FAEF5F06CCD8CF9A@DB7PR04MB4505.eurprd04.prod.outlook.com>
References: <20230919080929.3807123-1-xu.yang_2@nxp.com>
 <CAP-5=fX46xYdE2bheU+LhW2Joce+De42=d-XqBuFS9F-CPsQsg@mail.gmail.com>
In-Reply-To: <CAP-5=fX46xYdE2bheU+LhW2Joce+De42=d-XqBuFS9F-CPsQsg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4505:EE_|AS4PR04MB9573:EE_
x-ms-office365-filtering-correlation-id: 270cfad1-00b8-44a5-9e6e-08dbb97e5caa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GJIj7knQ6UalKK19KPXxhbEVuyjoPpi35VdGjqgmD9s3mBHhpXg0bkAuzULA6ytoOKJTWa78G5pXZkoMnaHDSV5VsW4u8hSCxpI8SDdi6FOA4eAlBm1tIgjO2Q6QJEpZu/I0xLMbUIhmhBnpeQ3ct3VFatdBwZmm4r7x/YwuSf4eGc+lkYf48EgfXm8hcPv0RDTgm51/qAiGf/ivOX9r6yWCnwBT6yr2PfYiffOc5zOMrUQZrbKoN1HSmxKEBnrXs2pGTJ2AMjS+8PkEHEwm5JtFbCdCHQkUTHX2g9gImuoFgkaMnAy5xP31iPuqEOik7ZvAS5a24MkEYGIrm9pn9YPO/kquQjBgoYVf9xF3y86tIXIR2mm/VC+5mPrZ8/VjI9jzey/zPYMVxATHpyViNQIZmjaU0RAwO0Zq+mvHv2hNSnb4laHjOJVoZL4YYGR/mESORPHvx6j2DZdF+UlVzgwmT+ty10IbDa50fBnBNPjvZhNZ7FcJ0Lj6r7+C2rOwBR1quYyU6MU9Su8XMgHItJHA7HmZ6wZyr0PqDvmZIimKdnT09F6GhHWu6/57rbstatq6LihqEYjh1S1UW3h2GjUB8Iql4HsAeAdcUnRYESqPOsHURpTiF8LDYoP7OVgS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(1800799009)(186009)(451199024)(6506007)(53546011)(7696005)(83380400001)(9686003)(71200400001)(478600001)(2906002)(7416002)(54906003)(66446008)(66476007)(76116006)(64756008)(66556008)(66946007)(4326008)(316002)(5660300002)(52536014)(6916009)(8936002)(41300700001)(8676002)(33656002)(26005)(86362001)(38100700002)(55016003)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU5VbXkyZHpOSlVLQXVoQUtvdWhiSk9Cb3V2eE1LNWFrbFVmbDd3QzlDNVM0?=
 =?utf-8?B?VEVvUGRHMXRRalBGT0NVMnIzNGhnQzZZWnlGY3pzMjkrTTBMV0pQSUhwQ293?=
 =?utf-8?B?ay9TZkk0bFI1MWw0Y1JFZmEvRXlDQjlQTGhkeHNiNWFZMkJYMENTWmRQaUMv?=
 =?utf-8?B?VktMeFNPNTVXMmpzWW1SekFxR0kvTG1NUnh4M2JtdUVOL2NvZy9CZHlYYy9H?=
 =?utf-8?B?Z0Z4UlBneG9CRitlc09HTHRxcEgrTWd6SGJXVU9seDdSUFJpUmE5Vi80My9r?=
 =?utf-8?B?MHNQMEdBamtiMlpuT21QaStoRSt2OTZTYkNRTkcxZlZzK0lBeFdhYzhFcFdr?=
 =?utf-8?B?YmxSU0c4anFtVTE5bVJDblAzUjBzVmFmbzEwNUt5VFNoU0wxUFN1UFZZSjdK?=
 =?utf-8?B?WkVmQUM1NC8xc0orRUs1NjcxMWd4QW42YURJbTF5M3NhK3N4L0ZhOTVVK1Y0?=
 =?utf-8?B?TGRTbnF4c1p4RFF0dk1jeGhoeDNlYlBrNXhjOTdIbVpnaUJ5MzVZSmNaQWcv?=
 =?utf-8?B?M0RiY3hGZ3J3Ylo0cEtsZzlsd0RwT3F2cnVQWGhoNzJCRjVXT3FNcUdwQldn?=
 =?utf-8?B?WEIzZTRDVytsK2ZFL1VRZnd6eG1aeWprcGN5dnBPdTg2VXJIVlRaRnlSR1hJ?=
 =?utf-8?B?QSszLzY3azZITnJZcTQwbUQxTDN2alhPaDlzZFVIa01YWnRmOUJ1d09yK1dE?=
 =?utf-8?B?a21NUHRpUmJIdGZzdXc2Mmg0SHN6T1JFei90RlYyZDM3VkRZZlRTUmZEdmZP?=
 =?utf-8?B?Q0NRMFBkT1B5WWhUeHpRYmUwR2hmQ3czMUZSRnlLYnBIQVkyRDhUQTZqQ0Rw?=
 =?utf-8?B?ZDMvN1pXTS9UdVNtRzVYNTdHZkFRY3Z6aHgzdEtZNDl2eFVCYi9TeFRiL2xI?=
 =?utf-8?B?aDhkNVUxU1NMRmYzeUo5dW5YMmovZ0d2Rjh4T3l5WWJiWWh0M04vSEdIR0lD?=
 =?utf-8?B?dTVOcUhQUmdsZ0wzVm81eXA2SFdqVktmYzh0SDU2NUNrWnFraU1jdDRDSUVJ?=
 =?utf-8?B?Yy9uUmV5cVQ0dE12MmZaSTYrK3RSY1FqMTRSdHhvWEl6M2ZpUEV1N3M1ei96?=
 =?utf-8?B?dHpaYndrWUJsT0M2MTFhOVRSTEF5NTVGSDkrMHI5ZGlFbXRKQzU1WklTbitU?=
 =?utf-8?B?MnJLTlE1elRKZFVsMWczMzMwUzhDSWc5RkVhczJjVmlwZEN2QXc2by9Cc01t?=
 =?utf-8?B?UUUycGpXOFdRVTJXRFJPQXkvMmNZOFhsV3g3dEJUdmJpV2dKT3NLdlpHa0lk?=
 =?utf-8?B?b1dlSGU2Z0M1MC94WXc2QnEzd3pCaWVBMnR3RFNNYUhzam9TR2NkT2R6ZEhE?=
 =?utf-8?B?ZnpzSzZTZWxwaU5vamNoMTROT2dVMEErVSt2MjMxUU1Nc1lVczdlOUhyRnRT?=
 =?utf-8?B?QTM1NlAwYnNXd3J0Q2pyMkhCSlpVOEdLdXVLelRjUmRwWlM4YUdlT2ZSQlQ3?=
 =?utf-8?B?cUF6clBkUTNVSjBrWVJ5TS9BbWpvMXAzS3dYZmFLaGp2dmpveUNzeW5VRTdK?=
 =?utf-8?B?Z0J3SEQwQWxzVWlYV3BxL252YUtzTmVySFJaUTJ6dHhsK1AycmZFK2tKemZD?=
 =?utf-8?B?bVFHK3JLc1NOQVJ3M0RmZjNhZUl2aWpleHhhWENWK0Q3USs3dW5WODBYUUx3?=
 =?utf-8?B?a3dkY3JtMTBCMnorU0xhS2hpdEFHeWN5QUhjWDJJeDZ1VjQyeUVuNlllRW12?=
 =?utf-8?B?YXBMTEhNN0c4WXkwNDU1L2N0cGZEK1AvYmxSRDFTVVcrMFliTlNHUnBaL3Yz?=
 =?utf-8?B?OVBHbFR5SU1zTVFaZlhJMlM1SVRrd0lXY3lvdnhKbFUveFJoWmdlRVIzNzR0?=
 =?utf-8?B?OVpzd3lmTmo3Q2RnTlkzTTJEQXg0NHR1T3lYWEZ3TURNSnh0VEs5MlAwaFd5?=
 =?utf-8?B?RFBGUkFVQlBOM0lwRkhVTHluNDMybm84YTJYU3pCVkE4N3Q3dTg4ejNWR09P?=
 =?utf-8?B?cE5iNmw3OWl6RW10SnhaRC9sNDlKZE1aRHU0ODg3MGJ5RnM4TGNOUll3SnRD?=
 =?utf-8?B?R2RKZzZtaXFoV1FmK2Q4N0U4ZUFHRm5pdk5LMVVOS0J0SEVTcmNUZU5haDFj?=
 =?utf-8?B?YnN1YURZNytKRHNhbVhpQ21NbnhmdzNjRkRxTGFHTlhrRlBJRk1seURPM1V2?=
 =?utf-8?Q?+No0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270cfad1-00b8-44a5-9e6e-08dbb97e5caa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 02:07:37.4661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYBFwv8/X/F2nFdJDvz80i300GAaTBeQByESzxoItICpimCMfn4sshF09tWNCzdu+Ur01TFFMeZ/+vWZy+jRbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9573
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGFuLA0KDQo+IE9uIFR1ZSwgU2VwIDE5LCAyMDIzIGF0IDE6MDTigK9BTSBYdSBZYW5nIDx4
dS55YW5nXzJAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgc3RydWN0ICJwbXVfZXZlbnRz
X3RhYmxlIiBoYXMgYmVlbiBjaGFuZ2VkIGFmdGVyIGNvbW1pdA0KPiA+IDJlMjU1YjRmOWY0MSAo
cGVyZiBqZXZlbnRzOiBHcm91cCBldmVudHMgYnkgUE1VLCAyMDIzLTA4LTIzKS4NCj4gPiBTbyB0
aGVyZSBkb2Vzbid0IGV4aXN0ICdlbnRyaWVzJyBpbiBwbXVfZXZlbnRzX3RhYmxlIGFueW1vcmUu
DQo+ID4gVGhpcyB3aWxsIGFsaWduIHRoZSBtZW1iZXJzIHdpdGggdGhhdCBjb21taXQuIE90aGV3
aXNlLCBiZWxvdw0KPiA+IGVycm9ycyB3aWxsIGJlIHByaW50ZWQgd2hlbiBydW4gamV2ZW50LnB5
Og0KPiA+DQo+ID4gcG11LWV2ZW50cy9wbXUtZXZlbnRzLmM6NTQ4NToyNjogZXJyb3I6IOKAmHN0
cnVjdCBwbXVfbWV0cmljc190YWJsZeKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmGVudHJpZXPi
gJkNCj4gPiAgNTQ4NSB8ICAgICAgICAgICAgICAgICAgICAgICAgIC5lbnRyaWVzID0gcG11X21l
dHJpY3NfX2ZyZWVzY2FsZV9pbXg4ZHhsX3N5cywNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFh1
IFlhbmcgPHh1LnlhbmdfMkBueHAuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IElhbiBSb2dlcnMg
PGlyb2dlcnNAZ29vZ2xlLmNvbT4NCj4gDQo+IFRoYW5rcyBYdSEgSSB3YXNuJ3QgYWJsZSB0byBy
ZXBlYXQgdGhlIGZhaWx1cmUgYnV0IHRoZSBmaXggbG9va3MgZ29vZA0KPiB0byBtZS4gSXMgdGhl
IGZhaWx1cmUgY2F1c2VkIGJ5IGFkZGluZyBuZXcgaW14OGR4bCBtZXRyaWNzPyBJJ2QgbGlrZQ0K
DQpZZXMuDQoNCj4gdG8gbWFrZSBzdXJlIHdlIGhhdmUgdGVzdGluZyBjb3ZlcmFnZSBzbyB0aGlz
IGRvZXNuJ3QgaGFwcGVuIGFnYWluLg0KPiBJJ20gdHJ5aW5nOg0KPiAkIG1ha2UgLUMgdG9vbHMv
cGVyZiBPPS90bXAvcGVyZiBKRVZFTlRTX0FSQ0g9YWxsDQo+IENvdWxkIHlvdSBjb25maXJtIHRo
YXQgdGhpcyBtYWtlIGNvbW1hbmQgd2FzIGJyb2tlbiB3aXRob3V0IHlvdXIgZml4DQo+IHBsdXMg
dGhlIG1ldHJpYyBjaGFuZ2VzIHlvdSd2ZSBkb25lPw0KDQpCZWxvdyBzdGVwcyB3aWxsIHJlcGVh
dCB0aGUgZmFpbHVyZS4NCg0KJCBjZCB0b29scy8NCiQgcm0gcGVyZi9wbXUtZXZlbnRzL2FyY2gv
YXJtNjQvZnJlZXNjYWxlL2lteDhtbS9zeXMvZGRyYy5qc29uDQokIG1ha2UgY2xlYW4NCiQgbWFr
ZSBKRVZFTlRTX0FSQ0g9YWxsIHBlcmYNCg0KcG11LWV2ZW50cy9wbXUtZXZlbnRzLmM6NzY1ODY6
MjY6IGVycm9yOiDigJhzdHJ1Y3QgcG11X21ldHJpY3NfdGFibGXigJkgaGFzIG5vIG1lbWJlciBu
YW1lZCDigJhlbnRyaWVz4oCZDQo3NjU4NiB8ICAgICAgICAgICAgICAgICAgICAgICAgIC5lbnRy
aWVzID0gcG11X21ldHJpY3NfX2ZyZWVzY2FsZV9pbXg4bW1fc3lzLA0KICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgXn5+fn5+fg0KcG11LWV2ZW50cy9wbXUtZXZlbnRzLmM6NzY1ODc6
MjY6IGVycm9yOiDigJhzdHJ1Y3QgcG11X21ldHJpY3NfdGFibGXigJkgaGFzIG5vIG1lbWJlciBu
YW1lZCDigJhsZW5ndGjigJkNCjc2NTg3IHwgICAgICAgICAgICAgICAgICAgICAgICAgLmxlbmd0
aCA9IEFSUkFZX1NJWkUocG11X21ldHJpY3NfX2ZyZWVzY2FsZV9pbXg4bW1fc3lzKQ0KICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+DQoNCklmIG9ubHkgbWV0cmljIHRhYmxl
IGV4aXN0cywgdGhlbiB0aGlzIGVycm9yIG1heSBvY2N1ci4NCg0KVGhhbmtzLA0KWHUgWWFuZw0K
DQo=
