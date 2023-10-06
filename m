Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4A17BB459
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjJFJiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjJFJiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:38:13 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2135.outbound.protection.outlook.com [40.107.114.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B61BE;
        Fri,  6 Oct 2023 02:38:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ed9e40Z+QD/bmZWCaZXZjJ1lfPkhuM9/cH0M86wEsH0Mf90w6YeU5iNIrBiH1MDgsVa8BsdVmsqhNRAiSLCztABv1W3xZKjs/tG0K+symdnn6lG9my0FK6SYeJY42Ugusxw5w61w/kENB2B4pxCtIjWd26bUmq1HkDNXO7+KRKQw3HAVwDxNUrba++XqKhC2z093tcNkHen8L4VFpnnoAlXukaoHH7V4OXKFwRXD68vDweYiii2av3EsumDXnGoYkLT2SZfDzk/OxcHQfe6D+OlSA/BsBkyj1/bWx60GQpp/aoGqrk7rXmCzVw7CQewMoG4XYaKwDiaxerXa/GATaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZ1/JS1kBd3rPW8lfP0L5gdGKMOOHr5wMjrL8I9aBVo=;
 b=cBgEhOHFcGfyDdbcpvxUNb9jb5C7PIWhQVD9Ew1n/mhIuskKSWn1gybXgQAaEip4A9Oe3LzUlbU2oKsbmGvhvoyAH/hRp0dHeHTH8YCw3y6cC/jjwG3wEt/GAQ/ncv1j7An0e5Mk8n7Uopi43hjGHLSeZAUnRUnyWEWVKa6N59eFoG/jumSiZVuElui1btvvTsv/vnChoOJJ75o/Pu/LMSF06AVQpaMI+ip3CRfaQRD1Cejp4wePwYD1uazO0K1HU9+0ETZoEDkynpLEP2Njv/Y0LQVqevxrWZXizSB7EmjrGdgFv3CVYqpy4FFp1CzO3B7GjrSxtx88pZRU5TaskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZ1/JS1kBd3rPW8lfP0L5gdGKMOOHr5wMjrL8I9aBVo=;
 b=Dx0emZMhBTR/99xGVyrYY4rKLyzbhlN/UGBRvpHjedXxLyTH9wHt5pR7yemoYTP5jilv+fLcbbszqJJg0cgDvSlPiirieKqM/qvgyVXpigb/qiib7aowDr2hr/0/EYWuy3UB6VDz5fr6n4WC8u5n2fEVjVLiJOxZ7mtQB59Hy1o=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10347.jpnprd01.prod.outlook.com (2603:1096:400:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 09:38:07 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 09:38:04 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "bsegall@google.com" <bsegall@google.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "efault@gmx.de" <efault@gmx.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "joshdon@google.com" <joshdon@google.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        Pavel Machek <pavel@ucw.cz>, "pjt@google.com" <pjt@google.com>,
        "qperret@google.com" <qperret@google.com>,
        "qyousef@layalina.io" <qyousef@layalina.io>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "timj@gnu.org" <timj@gnu.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "youssefesmat@chromium.org" <youssefesmat@chromium.org>,
        "yu.c.chen@intel.com" <yu.c.chen@intel.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] sched/fair: fix pick_eevdf to always find the correct se
Thread-Topic: [PATCH] sched/fair: fix pick_eevdf to always find the correct se
Thread-Index: AQHZ950NDu+uQ14YiUiCYnTsYxjU8LA7SzkQgAEl8YCAAA4+oA==
Date:   Fri, 6 Oct 2023 09:38:03 +0000
Message-ID: <OS0PR01MB5922C4CF327492EE2A0B2BA586C9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <OS0PR01MB59220AF3959BDC5FEFC0340F86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
        <20231005150258.GA36277@noisy.programming.kicks-ass.net>
        <CGME20231005150845eucas1p1ed3aae6b90c411b5c26a5dfadf7e0733@eucas1p1.samsung.com>
        <OS0PR01MB592295E06AD01CAEFBA83BF386CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <62ca6115-cf0d-427d-92c5-3539a361b476@samsung.com>
In-Reply-To: <62ca6115-cf0d-427d-92c5-3539a361b476@samsung.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10347:EE_
x-ms-office365-filtering-correlation-id: e6783751-9f03-46d6-4f59-08dbc64ff05a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rNPc9VJHv7gqog4we/G9EWnL9/bBNJ87UuFZWUQQDiqEXLp9nLEN8SXzBQCC/Sossy+y6q7awAXbgd60e+sg0R5HtgF/5LoQt+0nxV09gxwUFSHQE+Bxe/5oj0tqzLttSLuytiyaVO6JFTbyuq49OZX1hKEzuz9emOGI1XUkuvg2TfGObxU+45dxX+RZEeDZoHPbqYruwAowtuqf0EohjiyIi/2mTypexP6PHhvpW9ZV8xSzaoJyDapz19tfT9BQd1Lx+Sqk/4JA0YFXimEC+S1DQO+jbZbsy7n17l54h+UIEG1NRT5Zy+bF0hcnHHemh7NYVTuzJA4youTgIwiC2JJoB7VK14jMrSj3r8daZZgALlLOxvwWlSxkfhOkWkJ5BGq8Hnq9H1358EfPb7EclHyFkEQqcqOwgMIFQ+INkKpt7ZksVWZBL++R7DaquH7uq0sZax1t0dWCXgJg3X/4sx8LzQUdQbtkJJTBobq5dQhD5W06rx+wt4gyeO9taQ0XHRk/JiQZu0ghdGX7gRGPI2x1btvmCrPv9sQd5Xth6v6DdkE0V0Gg2AgfUW5MAomLPqzoQnSfcUGtiv6aZD71GJQmKbTrDQmktbqnpYw6HczCK/Dr4l2upQIK7TIiYpSv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(7416002)(2906002)(76116006)(66946007)(66556008)(66476007)(83380400001)(110136005)(33656002)(86362001)(55016003)(122000001)(41300700001)(54906003)(52536014)(5660300002)(316002)(8936002)(9686003)(478600001)(66446008)(53546011)(7696005)(64756008)(6506007)(26005)(8676002)(38070700005)(4326008)(38100700002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Oyxn9jgQER3KstYLxQYiNetUilRNF0w+nm89iUy4Sfo14a51o8j9cAMiiA7t?=
 =?us-ascii?Q?1P8aiHI2Sg6XuRlFLQG8h0KPR783MC/B8ae/RClrvCHOA/YU/obxsg7bS2+B?=
 =?us-ascii?Q?mlqa0rhokcS+Lj1WRQBW8Stydyd6uE3BOyWBb3sbHyJe6xOuLUIRCBL7Qhgh?=
 =?us-ascii?Q?DaXXISJOikfRuecqJ2KYAJz1ZjMUHWLd7fTumyAHaWmoPFCEDrbxK4lYaqlp?=
 =?us-ascii?Q?v9rWPM0dgcG9WuE34QYpKPdioKw8Q+b3Ymw2zhJUgskJVLuIGHljk8FS6WGd?=
 =?us-ascii?Q?XumHerxUdudAYJaonJWcXGwzkKPQV4fn7uLAqIWQw+KM8FuxuvsBNzCOSUki?=
 =?us-ascii?Q?WPNaj1hZfe9m0MflaDEKorOv3im9UDURj8ByWkMVNPF0RTZd6aJut7i2l3la?=
 =?us-ascii?Q?89x3YkPj7pVF39ufHngWOm8HtvAfo6/6kJYSYvL8nKK/yHQblyIGPilbLncY?=
 =?us-ascii?Q?0TXSFbVGHhBKdCCL7jlB4izV1pMKAUS5h+VIZtvM54VGmSLQa7xIUVhmt6xu?=
 =?us-ascii?Q?lvKOe8k2sPMnbvQglDo41NYDoQ5KjPy8uHKk0QxYPW/QngQ8f4W5tewa/1Ls?=
 =?us-ascii?Q?Ba8/HTVuhBaGsLGIKq4H62IU3FpJZl65oyq1WN2nsrfw709aPS0w4ol4Omua?=
 =?us-ascii?Q?l2xF6KgA/2vKONvxYH5/OhhpnLZ0qkS6D6IxfaUpTjuzaTC7xorczhyP+0A0?=
 =?us-ascii?Q?2IiUrseo3gfIzPJyaHXPumoowjU8yprzg/aIfMOpGKLpDDiiqBWsuZSXJtVp?=
 =?us-ascii?Q?iuwFWP3IsraJA0movHCJYuGbplZd2kAh8Db6MNL/DJmLMVh9vlK/4A7rCsS2?=
 =?us-ascii?Q?LQvfkEuXfPp7r8hbWyyHBBYB5GALpfMx3Ylmg2WBLaI54Sb8aOzhu8/xwapV?=
 =?us-ascii?Q?xgg/5zqFnijxRtTE1an5JKfUpjaLhUF+Uphs3hSofUcIihTMXCtloZ7Yp19K?=
 =?us-ascii?Q?N3gGRCydrsPbibmQ7PG2Bn0DDxQWxM0/QeEyUpaGp3kBgX3Gm2ngWhEQT1xh?=
 =?us-ascii?Q?TM4WqvgmqSm/mc4Xk8wFz517uCQOMAtsMF2u7/1YMVgJpSlBzBTJdMRLeyqP?=
 =?us-ascii?Q?87XGgPNZr3YkSQD9q0y8XmY5EjrJ6oL37yM7br4xfHqI/+FP7Gzf6zBX0R6S?=
 =?us-ascii?Q?VJuDsVYJD94sGfr/QfAYqlwV7jcHmE9JjT6u1sPG5stpXyL+yVuu2uF8hHOb?=
 =?us-ascii?Q?lIROZi+dUxVflwCsMNmSbAjf8y3xOOSo8IM0G9/ea++IiE2CrD0ZplfPQkum?=
 =?us-ascii?Q?JMBqw3tz23wTc8BPPe0zFE23pliYe3FhBEnU/6JzDt2MjqhkDUgbVruPnZLM?=
 =?us-ascii?Q?1a99fPb/uak+1BRWbWY5R+jGT8zjj7jVcWEv3OQXu6gNamjlvTPqUfKv0Yw7?=
 =?us-ascii?Q?NgYkS7jgalB1AdIoXRWTPVS49uayf4QbyeUadBIbzGkKKKmZCCVzlw4ihGvg?=
 =?us-ascii?Q?pWRM334RhJdHO780JjQcF3apanXzknA6nE9vKoxEFfZ7l9QPbnSd1GDf2E3l?=
 =?us-ascii?Q?LlAlORIlZ+eYpEcjSafFBxS/Lt4q4CDogSPxrYMQTuYi1ydfK73GGMAVhMaO?=
 =?us-ascii?Q?Lj1wqCQUcK7lU1aXy9bv4D0aPxQobHJ+3J4jWGvGSH1w7nTQH00C3MaRvGAC?=
 =?us-ascii?Q?xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6783751-9f03-46d6-4f59-08dbc64ff05a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 09:38:03.9835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A0+TWKqHk5XPNEVflADlgLq2p+L9wxJVol9OdclP7F+r15hWavHgGjTFrYJf/hPLzgNHD8xc8DlfoQCSOQPv2KFMa5UNJNjH8IRZ4Ca3ukc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10347
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correc=
t
> se
>=20
> On 05.10.2023 17:08, Biju Das wrote:
> > Hi Peter Zijlstra,
> >
> >> Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the
> >> correct se
> >>
> >> On Thu, Oct 05, 2023 at 07:31:34AM +0000, Biju Das wrote:
> >>
> >>> [   26.099203] EEVDF scheduling fail, picking leftmost
> >> This, that the problem.. the rest is just noise because printk stinks.
> >>
> >> Weirdly have not seen that trigger, and I've been running with this
> >> patch on for a few days now :/
> > I agree Original issue is "EEVDF scheduling fail, picking leftmost"
> > Which is triggering noisy lock warning messages during boot.
> >
> > 2 platforms are affected both ARM platforms(Renesas and Samsung) Maybe
> > other platforms affected too.
>=20
>=20
> Just to note, I've run into this issue on the QEmu's 'arm64/virt'
> platform, not on the Samsung specific hardware.

OK, if needed I am happy to test on the real hardware, if a fix found for t=
his issue. It is 100% reproducible Renesas RZ/g2L SMARC EVK platform.

Cheers,
Biju
