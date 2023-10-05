Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4437BA2FE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjJEPuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbjJEPtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:49:12 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2090.outbound.protection.outlook.com [40.107.113.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9133E2703;
        Thu,  5 Oct 2023 08:08:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIpyoEXDVRCtePVgSA3oD3auDJlPDYquYgexQ7cGR+IIphFPYQnPp33naZHe3kRs7GHXmyMnFfWlI/pBBfKUyajIGuTeVDRGSqp8M6GUKr0Z9ACkk2YOztWLcaNHQYGWhfI7NCPEORKDX0oogmqiKbjNLLrNxaCnTedfo3O+ZyBC1dpFBH9P88DvBFXOQ7GmjgL4us33J042MjefwpGWamIEtBCu3MYPiRLU3IcLWSwuCO6lMkfei0tah+yaW+y1+e+a4X3+XycrMuHI4AoNZSNNaX65dWcmO7XYqwWaAcjT0ZS681ySgOpzWxwUxLHXnOFAh1So9/GXu+1Xur1K/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQYl2TxUMVDE5a2aSiVyIujJkIK54K7bZWn0c8nU5Sk=;
 b=cNkbaumXTAw3pljgOkx1M5krQq+8Z/rSHxSaUfmyvowPwEe+Y2eH1W6oGylFNY2h4A44+uJbhW/daVNOOgSRUkY9gbi7zA5B95ERHTAOxKImbXAJW7RntnNlsg8UE/tZdMBPV0baqhvO4qbHoF7dgejYIkxAggrYK4dE/p++ugkutxSBsMVpSau9O3nem0FRUJrB++lJ03OzD8oqYofndGHAbYIMWT005+iFkhisfKeSgmKTiX6JJvfuq7iCHkuqQFwtW8389ovDSq4tykxTAClIUhpbhIcuz0vtKR+ggI/cj2rI67junf/eGM2zU+u899yg/P6EhskOO+RgOa4ZOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQYl2TxUMVDE5a2aSiVyIujJkIK54K7bZWn0c8nU5Sk=;
 b=n+WDdBsuLSquH4h9KN2Z9xLTf7SFqFAOZJtvwBjouXN9IN7dl1W4K3Dx7VA6cHrTfRqZ7NnOHTUAtZYkOntxjdY4cOv4Y36o+OHbLLuPfuOXwMU5ib9C5uZUxnipjF+q1hYAPNchtvlF8AKXfmny69qJf3XtRJBCRNSQ2gWh1FE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5491.jpnprd01.prod.outlook.com (2603:1096:604:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 15:08:40 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 15:08:36 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "bsegall@google.com" <bsegall@google.com>,
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
Thread-Index: AQHZ950NDu+uQ14YiUiCYnTsYxjU8LA7SzkQ
Date:   Thu, 5 Oct 2023 15:08:36 +0000
Message-ID: <OS0PR01MB592295E06AD01CAEFBA83BF386CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <OS0PR01MB59220AF3959BDC5FEFC0340F86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20231005150258.GA36277@noisy.programming.kicks-ass.net>
In-Reply-To: <20231005150258.GA36277@noisy.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS0PR01MB5491:EE_
x-ms-office365-filtering-correlation-id: 292416d7-1813-4cfb-3f35-08dbc5b4f334
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +KNjSoLRUVhzWHLJNw5VIPyUd68QvIqXHzn6594alxFjw8UQ2pa0aoDAcP/5ntrtK87nozk0dHIpKhREJQT5YpTiPaSkJNr40uL3NCGttjXxW2Bfw/I4YeC7PsePJxwZLfdj4HWtJXRnyzNZaK6ktsaC26MnjuZ3HIYdMsxtvnLIP5SzkZ/6cfzs9wEL9SjP58cSCiPBXFA5Yd6kGy3JKs0NvLsoIju/RqqJ4lo/bD/FEDg4RLlOC06q9tDrmkTzUqNOhKH2cUq0X8ONAwB+/pvQAkEreiews/iSGBhrfeoBM7W3rPnetIpEo99fpndxMj3d3T2zj7npYDbILUO7czZCAwS1HWzKby+YpWEgVnHuPtWm6CTLqkI2D//4M20/v85JpVI9vUClWu9dkaV3ekEz/M5MWojNXsD7R1lOQyqszv7k8H/50As63M1jmvlFXXljydgaXGO6aI23RInp/CelezN1ZLMmq76Hl6XnK4w37kkAuiCgIis5VYXFg8HKYOPGBf1HAPORwMCZd1TJw6V7Thdq7ofgExJvoFxwX/8jl/+oBaso3lL7SRQP610EySggxQCf1iuNbWT0x3wHsRHctV2SXiZ3VdI41Y1c1mXD9FZynaNx869zjwrmWg7V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(7696005)(9686003)(6506007)(86362001)(38070700005)(33656002)(38100700002)(122000001)(55016003)(2906002)(4744005)(7416002)(66556008)(71200400001)(478600001)(26005)(83380400001)(4326008)(8676002)(8936002)(66946007)(41300700001)(316002)(52536014)(6916009)(5660300002)(64756008)(54906003)(66476007)(66446008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6HN+wYv3h3trT+Hq82hcBBrdU4fwFJaufsEFAdfKJavU3UWYjwg7/RjJRkmF?=
 =?us-ascii?Q?GGA95hZhYxMJLC9Mpte/QbgAfau/fcYIDrtgcw0dy6Hx5XDnquJ4YTDFT8AA?=
 =?us-ascii?Q?g12OEnJ6hgLGQDBWC9Ked+xcQyHERGS6YnLtu+464mYE/eVbuQkS5GjcPGGt?=
 =?us-ascii?Q?QRkQINS2shvkPJUKeoE+6cECKTieV2udpLad1oYtk+DDov/XGz/3GpXje9Ys?=
 =?us-ascii?Q?krDwHkVr/WaorZTBNgR5oMcjPoOz3faoPkxFwyCniybZt5m3W5OCIOlGvFY4?=
 =?us-ascii?Q?blDT+JuMWmZgaJxsKI8YObH6XBeUpR7l5MQikxkis8RCg2LrY19Xkq/Wo6kN?=
 =?us-ascii?Q?ZZxy2DN4OuflBghxEeilIJt4VHq6qYePyecL60AJ8DfdHeQhSsx7kKQDvkLy?=
 =?us-ascii?Q?5ieNEviKC6caqoptPAZ07V1dUTm4K7cNvG/nmWsl1O7HDwHV3edJgN++EuUp?=
 =?us-ascii?Q?Y5HE8Mw3ZkTl+Yvv2TpIZAwp1bu9aoJSChLeVYEsIGje63UtIWPN0oaXSDMX?=
 =?us-ascii?Q?DRjxmD/3oGzQ7naU0+90Njht7royxAi0PcONZWzaNROhp2JGJpji7tpGcQ+J?=
 =?us-ascii?Q?Yp9o5tubUdiEVgVztJusUInCnfhdY0ITYi18BgPZT8CsEzQoEadAmL5/Mi4u?=
 =?us-ascii?Q?1h/OuUeHg9VxO7Aqvj8pCyrMLDaUx0oYNk77rhpEfeDWj3qM0sI0nizhkAnK?=
 =?us-ascii?Q?wjOul1rV7olcSdDVCLZdCxfqBCVhQU9e6cyrWpMGfKTgJYC3RQlQUcslEiVQ?=
 =?us-ascii?Q?JC6c51dcYicO6Rmz+J+vOdE2jmVgmUTLNl6KENU1abnOa3+KwKQeen64+p+8?=
 =?us-ascii?Q?zNskRo4xckNeWeKL826CgOWyNc3dyozUvTR1qvFbWIJYiY46mDz4gpNUvh+w?=
 =?us-ascii?Q?UqLZ8KzrEWFe8fsAbNsHwSmT89REkIWFTOwBSePqlmzNEP5uKpjAtFB05gvi?=
 =?us-ascii?Q?1YB2z3br+uskDSC7y1j1MSMDncTReu8Az2wZ3B6p0TXZ11O5MhRCP4sRPiXA?=
 =?us-ascii?Q?Ewj+zZN7ya03jkglHmkzP/QnFFFNjkM/TcwsdA/l2cHKmVke0e1paGTIg7nY?=
 =?us-ascii?Q?FeoX5CdvWFvm8Xln4A9QwcxyqbMlqrC0kAQBTMvt5i+XFewnS96y7OTGyDmK?=
 =?us-ascii?Q?IKOtV6OXzYJMJSunkuMVW/drkW5hK6iQegR1tjQaRsGEd3fl1I4IOkSwB43U?=
 =?us-ascii?Q?a4FuBjh4Bgqxvv/RVgUCFsPNb1b2+faB2r2TVtpt+qIMJF79JXt1TaPDDmz0?=
 =?us-ascii?Q?7YahtF3AH+l1BjVj2ktuXVKi2j82iDKTNFcD7WLWYzDUl++7V1sQsZx2w4I1?=
 =?us-ascii?Q?JGN4RPb2IGXKNTJWOvyJXlMMRKewYIGUocB2ZhxNylj5yLf11iWEl5pjnakb?=
 =?us-ascii?Q?Z4yGXL7/CzsVjOt/zBr5Pa64l5cU74otyZdpdc93xWSXg7p0O7jyAuy0koiZ?=
 =?us-ascii?Q?jiPewUEgKwGVp07HT0cMMZz9W0WbQ6pqFvukNlv594KL5C2vyKBS8mP598Ot?=
 =?us-ascii?Q?dTAfBif2zubMuDlKzHOaBQCCu9gIH2+VwQ6dxO2QLW2hjBhA4vq4f4FB8ZR8?=
 =?us-ascii?Q?4BLleUPrpud0YpX8UeUWe0enpEC25rz6HBIpCAiKx+Wpq8eKra8U8yeshjVg?=
 =?us-ascii?Q?iA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292416d7-1813-4cfb-3f35-08dbc5b4f334
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 15:08:36.8114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NCS+l5gkcoiwhS7PikBRHYL8HvSTnfHkyXBr4Uw6uUhU06+3tKVTmPp1+LgxDqBZjsHT3EV1J7UjJSreCJiynxmpPGYRAxgo/FqlNRJqEEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5491
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter Zijlstra,

> Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correc=
t
> se
>=20
> On Thu, Oct 05, 2023 at 07:31:34AM +0000, Biju Das wrote:
>=20
> > [   26.099203] EEVDF scheduling fail, picking leftmost
>=20
> This, that the problem.. the rest is just noise because printk stinks.
>=20
> Weirdly have not seen that trigger, and I've been running with this patch
> on for a few days now :/

I agree Original issue is "EEVDF scheduling fail, picking leftmost"
Which is triggering noisy lock warning messages during boot.

2 platforms are affected both ARM platforms(Renesas and Samsung)
Maybe other platforms affected too.

I am happy to test if there is a fix available for this issue.

Cheers,
Biju
