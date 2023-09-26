Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7916F7AE3B4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 04:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjIZCnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 22:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjIZCnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 22:43:17 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF01210A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 19:43:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYO85NtvFbWgWa2fOUazLH31j5SdbqO/zSUxXk0KkZJTFdXV5tpkQSZ2L86RVFEshDq9O849FvzY+53ptO39zJsA5dN3lmw/yjGC5WTFsUrjTSvGpvBwn6jmjH6ghOcFws4DJMS3d4NA3UfClwh6JMn3NykmBakblxZBjYU02mdqB3GExFwAupRTcA7Q/KGsvmsRG1CfeW6x8X52vpdJOouyQi/H/E8mLRJzWyXzJMbfgETGhBp4gjinz8aVEji45eB754KZyJ+9sEVUybxVWgkGVgAdFL3en/9hgUEYSHYcmOIGuIYAL8LasOttTzIsVvHO1ocvLp5ePczghhMQIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnsHbjZrmCnCplIaCciPlMPlE1MCpaVZy5JzYRWX1wU=;
 b=U/SLIG1swFQ5oZBRsUA/MCotwS+NWmk8TN06OM344nuKb/LjfjLpk2cfFsmYUsFDBxKh//CNKvb8wBeh0oB+i8iDFt+2JGop4if4aWxRrFisaKe/7D6Vpwro/lj5bWRSxYgKiT4qYQ4hWvlFv3gSXk1ExBbUpFmsGXDTLwr3PMrKt0J6TzatrDbNsWlSnV3NMfnPw60u5fafEAwblPrqpeQOnzAOo9GGHCNRf4U4yFB1NhG13PpGlAhzqUz29kGNwJBLiAoqNqTbqSRhKHli/rFp7ePlvVzmrc1oqKZuEThM2mEzX0em1n8637qU9XjjzbcH3dS+PEjHUGr0a6eTyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnsHbjZrmCnCplIaCciPlMPlE1MCpaVZy5JzYRWX1wU=;
 b=Dq9WxhJi8+1ubSv3qBHOSqVGZY4Fnoy2Vq4pAZ+/jFPn7WUG+EKAB2AnKc2048/niQiOhHdyHHfiV3BJvB7tCtkUIRpQeh+GzXqTPeA0jEOiN8pzJI9bcofpJ/IarnpZ/PyUaGw8/CJqHQK4TsYEQM4LpP1fCweLR14Ah0+V8b8=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU2PR04MB9522.eurprd04.prod.outlook.com (2603:10a6:10:2f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 02:43:08 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 02:43:08 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH] wait: don't wake up freezable wait by freezing
 fake signal
Thread-Topic: [EXT] Re: [PATCH] wait: don't wake up freezable wait by freezing
 fake signal
Thread-Index: AQHZ1MzEPkBNt2+gBEykkRz3RAc98LArhsoAgAEOGaA=
Date:   Tue, 26 Sep 2023 02:43:07 +0000
Message-ID: <AM6PR04MB63411C6C49BAD1E9FB6FEA76E7C3A@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230822074547.8037-1-ming.qian@nxp.com>
 <20230925100814.GA31921@noisy.programming.kicks-ass.net>
In-Reply-To: <20230925100814.GA31921@noisy.programming.kicks-ass.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|DU2PR04MB9522:EE_
x-ms-office365-filtering-correlation-id: 352cb56d-a20c-4b5d-b59d-08dbbe3a5110
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c8w1aSqWAhuQ50Qtuvtw6VxPjRGof+fwrV8+s1cBy5PrWZwIatxXEilNKAO+3jKkKhnMGUqvB6iliz2s81u3F2MHvdhHkAG2hmTLyocfAzvN/iDhsYwhogbPs0YNKpcaZvgOjBKggkOf3kMUEaGFrEQkiCSQ10USj8bpgedASpf+yEbLf+I4nxv/CchMaP1xIxWpkQIwl1qbOy2ZkzIkTzSG4QRK/Gf1nX+NHX5ap8U3gXRrLG/HEd2NuFk+spyUmpBxS9cn7cXLaFFl08hdyaMd3LqWiayLMG8HwXOMw/REDsoL/5vpzFpbLYSmmEwJqO3m25XWPSRmqnXkwJYffCnqfO1fKUutMxGVf/b42xxRz7wxh3GonSvhk4vQX5X4zQSwuAdElRfZ2oF2UmhQDogvgNWVHk3Sd+n/aeRCBzb5K8JDovzH1ACvkXRAUy2RyTti+HEzWX+9nKy3Pxh7w1otwRpghtvY+YELeX5bYQyoQ5pUZlINijaq8rKsSOgndwzCtdbhb1rbdnhuKYoJ/UxdFeINIIWj9Y5va7+Jxp5oHekoyiy6lBxXzmrVm3WDUWSJMBgPvu/XIfrnpKjUQbp++rs68pHYrYHNbdS8gZpFwPzLe2EiJURFd8uqIG9y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(230922051799003)(1800799009)(186009)(451199024)(7696005)(6506007)(9686003)(122000001)(55016003)(38100700002)(38070700005)(33656002)(86362001)(26005)(7416002)(2906002)(478600001)(71200400001)(83380400001)(8936002)(66446008)(5660300002)(54906003)(52536014)(41300700001)(8676002)(44832011)(66556008)(76116006)(66476007)(316002)(64756008)(6916009)(4326008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ci8vUFdOelY2ZkNKemwxcW1SSkhXd3BueGhxQllVUm82YUNwRnM5a0ZYRXcx?=
 =?gb2312?B?cWhpUkhrRis5anFERkJ2QnQvY3ZVYmoycEtReFpiWmRPUDdKRWRvOGVKYnpn?=
 =?gb2312?B?cFZWS2M0M3pvVG1wWGp4aUh6MnVCR0hBRTN1RVNOdFhLL1RrLytEZEtrRDY3?=
 =?gb2312?B?NDBlc1FMYmJCV1lLQ3M1OGdhTmVoeTlXVWVqcjBEbWxlSFJLTjQ4aC9iRUk2?=
 =?gb2312?B?RTN4c1VaTkY2MlZ5MU43UEFjWGVIbTNyem0yRzdpNHdLVUR5SlhyZDY0Qk5k?=
 =?gb2312?B?c0ZrcWRkL2xrZ0MvSW5TZUJSNExDVkgzb0JVUjY1Mkc3WWlRM2hPNmV5NTQx?=
 =?gb2312?B?U2F6TjhWYmRhVVQ5ekNqREw3eXl0RzJSbXV3NUIzbGtmVWVLRzVDdFRQV0Nx?=
 =?gb2312?B?cFRJc2ZXTG8ycW40NFFPUW9iQ0xVcWkxaEkxYVhwYmxPSUVzWVBKOFM2ajU4?=
 =?gb2312?B?Mlh3YmhwUTF5NnVtLzVtMXlkYWgrUkx2OU9JN2xCTU5zdHNPY3MwcnE3TWVy?=
 =?gb2312?B?UERMZTlvSXpHSnBOK3hoQTdDd2Z6VHlBNy9xcE9lYWpUQitHY3NSeGZ2MlFN?=
 =?gb2312?B?VTZUckhQMndiNk1FYU0zRkNROEZUNHg4NTJXWXBXMFZ6SlNJZ3dmcHhlUXVz?=
 =?gb2312?B?NHF2Ym00TnA4eGxTOGpKczZ3MVJQWGVXcS8vcVdKN3RqaTlYWFhadUlENWNi?=
 =?gb2312?B?Z014UHZXSHh6ckF3TnNSN1BBMjZaMlhxNUVzeExZaFVvRHAraXFBYlJORWt2?=
 =?gb2312?B?WG03MEdabTM2YnhmTW9HTWljOTVHVjdnWHZtK3hkVTllZFEvbVlwWWtsUjZx?=
 =?gb2312?B?YWtKdWNPN29ZaGZlcFJuTnZjV3pEdFFFZEZULzJlRU1IQWpaa3pyTUk0WUNu?=
 =?gb2312?B?QSs1RnpRTFdqczVnZGZmTlk1M0hXVEFBK0x5WjZYU1BkRVBGS3FQNVFSMjJD?=
 =?gb2312?B?U1BoYno1QWNDK3BVempYYTZORFg4dW5yMlM4K0Y5NG00MnJhQ2tkN0hla1Ez?=
 =?gb2312?B?eVhPMWdsUTh4bE9SbmRBN0tvbUNGRnpxTnBJeElURjk3cTdVQmlyUnJLVmF6?=
 =?gb2312?B?ankvRVY2ZEtXTWcyWTZ2R2Y1OTRYQmk0Q2o4L2M3OVFKRjBRZEFXRnFpalhB?=
 =?gb2312?B?RGhhM2VuRkhNdCs1c2txcEs5ZUJWZDVVSXBYU3l3UWMxOGp2ZFZoNzhpcS8z?=
 =?gb2312?B?NWQ2OG1mam9XRXZUbyt5UE1zSDdjVXlKNkNZVldlQWUzenplV0dnUC9nM3Na?=
 =?gb2312?B?a2l1bksxNmxZU0hmRDhxRXJDTFl6d29iTCs1UTJaajRyOVRhSjcwYlRRUGNK?=
 =?gb2312?B?YlR1aEdscDVNcVhWWDMxck9OcmdRWlYzdlAyMnFrbXdrSnluZlEwODVad2cx?=
 =?gb2312?B?MUJQazdFd1RiZG9WQjJzN1BLMUtMajZJeElqREtaZEFzRlVMRXhWSlJiZnJS?=
 =?gb2312?B?WFRmSUprQjVkekhURTZVNVlyL3NJWUZiOFlpbFc3bVoxS2w5anhaWm95cndG?=
 =?gb2312?B?RVpHOEhPUElVSzhBcm1CcS9mSmRDSWIzOGtJQTRLeG5vUmQyN2hMTmRhRVh4?=
 =?gb2312?B?YjhBYm41dzZFN1JnMFRMZmNoblRXZVd5aEQyNm1tUGwrcVZySUloSUkvV1pC?=
 =?gb2312?B?ZXk1bWZyM3NkZGprdVNuZXhzby8yYXF1ZytZL21mQzlXZDVqd0F0WW1LRk84?=
 =?gb2312?B?UkVlanBYSnV3QU13c01GZnpCWFFZQTZKb0JqUEp3S0gyeUp6U2ZtY0FLSjNV?=
 =?gb2312?B?eCtDM0NZeUdPYWx6dW1sQ1RoUWJLL3dYZ0xUMHlGTU95YzFkRzlvYW9WSGdK?=
 =?gb2312?B?bGp3dGJaeUIzbmk0cklBSmtUck9mTEJxak54d1lWTGlyRldzT1hWM2pwMXI2?=
 =?gb2312?B?ZU01U1pmclg0eDI1R2VjLzE4UnlaQnFRUHdYMGVKSHhlRUh5WlQyQ2dJdkd1?=
 =?gb2312?B?VWxrVElHb0NqcVFxdlpOcy80UlZYdGl0dkIrRk5CT25ZWERVaUhva2tOdnR4?=
 =?gb2312?B?cjNHWWE2N2I5QkpFQ204MUg3ZWM4T1BJMDRVTitWWmRMNXRQSFNVelphTVVy?=
 =?gb2312?B?cmE5ZHlSN1lnVlIwdGhmeXYvdjBueWJrek5hWHlwOWIrb2hadW5HaDRDV0FP?=
 =?gb2312?Q?8iE0=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352cb56d-a20c-4b5d-b59d-08dbbe3a5110
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 02:43:08.0307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AcTnulD2LO1Uk434SBGpphbNdTFwNgbJBT4ikC9vpLG6IGsNO7wIZPazeL4p+KX0H0O6SVpca/3PH2AShTHoog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9522
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCj5TZW50OiAyMDIz
xOo51MIyNcjVIDE4OjA4DQo+VG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+DQo+Q2M6
IG1pbmdvQHJlZGhhdC5jb207IGp1cmkubGVsbGlAcmVkaGF0LmNvbTsgdmluY2VudC5ndWl0dG90
QGxpbmFyby5vcmc7DQo+ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tOyByb3N0ZWR0QGdvb2RtaXMu
b3JnOyBic2VnYWxsQGdvb2dsZS5jb207DQo+bWdvcm1hbkBzdXNlLmRlOyBicmlzdG90QHJlZGhh
dC5jb207IHZzY2huZWlkQHJlZGhhdC5jb207IEVhZ2xlIFpob3UNCj48ZWFnbGUuemhvdUBueHAu
Y29tPjsgVGFvIEppYW5nIDx0YW8uamlhbmdfMkBueHAuY29tPjsgZGwtbGludXgtaW14DQo+PGxp
bnV4LWlteEBueHAuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LQ0KPmtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+U3ViamVjdDogW0VYVF0gUmU6IFtQQVRD
SF0gd2FpdDogZG9uJ3Qgd2FrZSB1cCBmcmVlemFibGUgd2FpdCBieSBmcmVlemluZyBmYWtlDQo+
c2lnbmFsDQo+DQo+Q2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRh
a2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+b3BlbmluZyBhdHRhY2htZW50cy4gV2hl
biBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+dGhpcyBl
bWFpbCcgYnV0dG9uDQo+DQo+DQo+T24gVHVlLCBBdWcgMjIsIDIwMjMgYXQgMDM6NDU6NDdQTSAr
MDgwMCwgTWluZyBRaWFuIHdyb3RlOg0KPj4ga2VybmVsIG1heSB0cnkgdG8gd2FrZSB1cCB0YXNr
IHdpdGggZmFrZSBzaWduYWwgd2hlbiBmcmVlemluZyB0YXNrLCBpZg0KPj4gdGhlIHRhc2sgaXMg
d2FpdGluZyBldmVudCB1c2luZyB3YWl0X2V2ZW50X2ZyZWV6YWJsZSwgaXQncyBiZXR0ZXIgdG8N
Cj4+IGZyZWV6ZSB0aGUgd2FpdCwgaW5zdGVhZCBvZiBicmVha2luZyBpdC4NCj4+DQo+PiBvdGhl
cndpc2UgdGhlIGNhbGxlciBtYXkgbmVlZCB0byByZXRyeSB0aGUgd2FpdCwgbWF5YmUgbGlrZSBi
ZWxvdw0KPj4gY29kZToNCj4+DQo+PiAgICAgICBpZiAocmMgPT0gLUVSRVNUQVJUU1lTICYmIGZy
ZWV6aW5nKGN1cnJlbnQpKSB7DQo+PiAgICAgICAgICAgICAgIGNsZWFyX3RocmVhZF9mbGFnKFRJ
Rl9TSUdQRU5ESU5HKTsNCj4+ICAgICAgICAgICAgICAgZ290byBhZ2FpbjsNCj4+ICAgICAgIH0N
Cj4NCj5JJ20gbm90IHN1cmUgSSBnZXQgaXQgLS0gaXMgdGhlcmUgYW4gYWN0dWFsIHByb2JsZW0s
IG9yIGFyZSB5b3UgdHJ5aW5nIHRvIG9wdGltaXplDQo+c29tZXRoaW5nPw0KDQpIaSBQZXRlciwN
CiAgICBXZSBoYXZlIGEgZHJpdmVyIHRoYXQgbmVlZHMgdG8gaW50ZXJhY3Qgd2l0aCB0aGUgZGFl
bW9uIG9uIG54cCBJTVg4TVAtRVZLLCAgSW5pdGlhbGx5IHdlIHVzZSB3YWl0X2V2ZW50X2ludGVy
cnVwdGlibGUgdG8gd2FpdCBmb3IgYSByZXNwb25zZSBmcm9tIHRoZSBkYWVtb24sIGJ1dCBpbiBv
dXIgc3VzcGVuZCB0ZXN0LCBzb21ldGltZXMgd2UgbWV0IGZhaWx1cmUgd2hpY2ggd2FzIGNhdXNl
ZCBieSB0aGUgd2FpdGluZyBpbnRlcnJ1cHRlZC4NCiAgICBUaGVuIHdlIHVzZSB3YWl0X2V2ZW50
X2ZyZWV6YWJsZSBpbnN0ZWFkLCBidXQgdGhlIHByb2JsZW0gcmVtYWlucy4gIFRoZSBhYm92ZSBy
ZXRyeSAgY29kZSBzaG91bGQgZml4IHRoZSBwcm9ibGVtLCBidXQgd2UgdGhpbmsgaXQgbWF5IGJl
IGEgY29tbW9uIGlzc3VlLg0KICAgIFNvIHdlIHRyeSB0byBpbXByb3ZlIHRoZSB3YWl0X2V2ZW50
X2ZyZWV6YWJsZSwgdGhlbiB3ZSBjYW4gcGFzcyBvdXIgc3VzcGVuZCB0ZXN0IHdpdGhvdXQgYW55
IHJldHkuDQoNCk1pbmcNCg==
