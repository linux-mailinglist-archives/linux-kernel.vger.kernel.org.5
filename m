Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F9F7BC4FB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 08:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbjJGGZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 02:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343532AbjJGGZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 02:25:07 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2100.outbound.protection.outlook.com [40.107.113.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C465BBD;
        Fri,  6 Oct 2023 23:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcGFdVN4nZ5VqhTyfT3mkSket8L0fizkr5aO6cYj5ViuBw/aoUpqpARTqxYW1yVNNFVMIbHbR0Sfsi9u8QczlyLyU+T9AKjEleT6qzoTs3aqG0tinuCOVCrOz9JmvgBRF0YsPrVKIqv79hHfbRYCVnF339VmElrUfX0+RKI+H0qKaVJVhG0kxPkrvzU6H+XNneTxqSL+j2vCpkbXJDo9J7rzZ/Mko180QpUWjI14b9p3C1u86osH2SfG7UTxYQ0A/JFFDP4wYbuKT9cTE+nsPZwnzAJj3iyAch9qFI931nbJr26hrO/QzLOkCc3Vmb4osfvOgdGiikqlcByj/aPUsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XikXAME4wRrFLhoJxEOW5hzCLn2cP9vIyOUkamgAmI=;
 b=h+W3qpy7GvYGKvX0phBHddNW8Oipmc0hEOzM/TVDzknJE70t6wvTOdpalkF3LU7UvLmKHqLdOOpWhJkOpatXSJUuFHBP1Wo/l9OVROtq7G2pnhiXOJ9w2P4/qXbDZn2iPcbnkIvKcUcETFGapRxAD5Wk6bZwj6BWf3y1nr4JIHuLLZ+0DifneaxT764Me6+dC79/DuTmrK17fWmH7x9tJieLzyEREGiIo7F9mcKrvv4bnu2ygOkaDC7VITyEsQoOsIVC2wlV/l6j3LjUok0JIgDegRzM9m9LYBsDrkXLmH/woLq99NZL4vFXX6f1y6Lii27U0Gme0airMndQJjGVog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XikXAME4wRrFLhoJxEOW5hzCLn2cP9vIyOUkamgAmI=;
 b=fpIhoPPZOPn2Ve4GJlhs1DV7EN4ue7jyZNwSa3ChqNnzOHPc2hWSH3S+QicocT/QTEE9M0UEqLT75vv7L7Q8OIoml6jHwTHtV1MU7idH1s4r+R4e4fPPcXWL6N8Rps4Zsrn8fnunV2VLSTdmb92x06BDQcwVyw7TSxVAXn4NmW0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB5613.jpnprd01.prod.outlook.com (2603:1096:400:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 06:25:00 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 06:24:56 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
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
Thread-Index: AQHZ950NDu+uQ14YiUiCYnTsYxjU8LA7SzkQgAEloICAACB0AIAAOnUAgAAKvoCAABUzgIAAOpmAgAC3xjA=
Date:   Sat, 7 Oct 2023 06:24:56 +0000
Message-ID: <OS0PR01MB5922B797C0FF3ED3C3A8FB7786C8A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <OS0PR01MB59220AF3959BDC5FEFC0340F86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20231005150258.GA36277@noisy.programming.kicks-ass.net>
 <CGME20231005150845eucas1p1ed3aae6b90c411b5c26a5dfadf7e0733@eucas1p1.samsung.com>
 <OS0PR01MB592295E06AD01CAEFBA83BF386CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <553e2ee4-ab3a-4635-a74f-0ba4cc03f3f9@samsung.com>
 <867f5121d7d010cacf938c293f862b0cea560ec2.camel@gmx.de>
 <20231006140042.GG36277@noisy.programming.kicks-ass.net>
 <e2645a659b6fc1c592e2f2dc45273c361a2d2f47.camel@gmx.de>
 <20231006155501.GH36277@noisy.programming.kicks-ass.net>
 <20231006192445.GE743@noisy.programming.kicks-ass.net>
In-Reply-To: <20231006192445.GE743@noisy.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB5613:EE_
x-ms-office365-filtering-correlation-id: 19b84f90-a4bd-4705-ec33-08dbc6fe1fdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pKguHp3LtOBrhdNP1jr0y3/KHhgP76IHX9j4WYgvemkRMW18t2g/rFN2nUIpjytlr1KycrrSOf1JJ41LpoTSclT98KCCjTCtVmA81NlloiJgeaTdNB8Y5WDa+lJSWPgAkPxmNCChrMQ/E4m1Re9IisSIZU1ceEYbj/Gd2esPPanUZqyaD1vg6PntvLcVneWj9wDAkmzdzhFdOF0izxnsy3try5eIta2H+p80D42TnITJHJBjqtqTD+h6QhhjUq1C1H8xJWrDHO7EJMAJkYYBKjtHgI5n2pZ5GYlxGjxbYwIUbXDzcuQXmWBJBWdvozjjeyFCmQPn1mMrhTy+l7yNW9vcTKkBdaRFlVk5UsjDVNRfqg1BroBvljbOU4RojwZGOiiYSOUOgS8WV8D6FfG+lUfuBqBLny5dQiM88V+9O7G/bn2DfzuVbWCU+BKoRoVAyR0eBeKI+toPrkzvZ1vPBpsJZLNUr3TvAq6Hm0gxJdBuR8TDiXJaFq8LpeOqBc2Kc086iZCa0eRIool+dVseInDMjlMMb47e+A8xnRwdH19ZHM+WsAr1pUeWo69ia+9Yp014jqww6RHwpVLSwnbKdp58NvBAhoKxgzlQgw+guC5TlUQ1NRgw0irwmPOVoF7w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(55016003)(316002)(110136005)(66946007)(66556008)(66476007)(41300700001)(64756008)(54906003)(76116006)(66446008)(83380400001)(5660300002)(4326008)(52536014)(9686003)(122000001)(26005)(8936002)(478600001)(38100700002)(6506007)(38070700005)(71200400001)(33656002)(8676002)(2906002)(7696005)(7416002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UZxlj5w2vEF6zHp/xXJTQIzwAi8N2Tm9hUViGi3em1n7WCrczPJgZMVktIy8?=
 =?us-ascii?Q?Y0HG7BHr8fMy6Qp33bndHrvsnMe1q4nVkSvRFrDQxa4u8YHy2g41BPMzPBo+?=
 =?us-ascii?Q?I0mp8PeqiCvHIRjAiIgxLE/SXqUIW240OEOG1JX48Xf/vz830YgQufiRSG4K?=
 =?us-ascii?Q?bwUSWsjzAUD+8JJO7df0bAhHxskV7loEiD3tXEO53paK8QnLDyDSN7U2neUq?=
 =?us-ascii?Q?eUyoJ29vtfLK060vGzWYvwTaSezz4gFUWjfzj0DfqZJnF+FuGfIRk5I3MlWA?=
 =?us-ascii?Q?La7h1pe6ZaUXauB4bI7Z0dtYM/2hKD6FQxFipHbPKumWJ97hqDjvaQ8HEp2J?=
 =?us-ascii?Q?Sr9EDekCrsSGE1HDGEj7lO/is4c256se9vcWc+MH9zLeGTa8E9A6MIGDIfzv?=
 =?us-ascii?Q?YMRaLQTMQ7uh+2DWtqUN2zKbIJ8eyYbafMx7kILWM9rsrSDQ+ispXIQPBQk9?=
 =?us-ascii?Q?foJva4Tt9oq17H6/xDQ6TkpMauPxExkBRoBAUhcHLH4yz7t/uVRnOQ8kX0v4?=
 =?us-ascii?Q?kmIRixCTB+oxLLPAEiokywYp5XspZSb1R6bLLG+GoaX3ibWGpBL2IuIVshGI?=
 =?us-ascii?Q?XIduX9sUTCPTR/34lH9fuzlDfhPYq4R4UTwzyXfqUuv0/1RV5l7ojSTA3sgO?=
 =?us-ascii?Q?5LlS5Cmq/SwLNSnACAwzxkveLBX6tLPPsrFDHGCKacf0x9+bUfaNNulqrZAt?=
 =?us-ascii?Q?OTTHOgauPhP/L4CAwA/CGVD/g6IKx98M4i3+huyMRbUxr9/KIcX4aEF6okTI?=
 =?us-ascii?Q?PSlbCpTPS58PaXNF/U06iZN9E5G+BqFxladG6USX7hBIpMb5CW2HVJNomUOl?=
 =?us-ascii?Q?kxM1lGkHFSVojnNUEHkCfOACSYfhwThMoW3YEW11WihPu+QE5wFVsuccaJPm?=
 =?us-ascii?Q?kN+76JOtAPJajasUlsd4gMTEmNeGFmqj/xzLbJ1LDWtPytb5fLcV4ZewH4xs?=
 =?us-ascii?Q?JVfZWTvKVWy5YircNvf0DGrhPvczpQukrsAp1fzVIsDdxIQhsJ6pPF3rSymk?=
 =?us-ascii?Q?HuQMUAadN57TyNyhY1aqtTZqchILOT34KkvKnP6NCHXU7gem3WXU1I6XPCCJ?=
 =?us-ascii?Q?egHdrQLV8rcaGtE064YxxGv3dJAEVo1ArqZLNV+smSCO0SZEmUmiJEhTMQNi?=
 =?us-ascii?Q?D4a/kk9CmYJSx/mMfn8mG+SLCCr1IB/BfWJdlztV5CFp4PcsY+4zIEqc4NSW?=
 =?us-ascii?Q?phIJDXejGA6Sp8R6/JyCdwiasbffagr/wQ8CkeRY7bpaPCXTCI3p3pp6j6q4?=
 =?us-ascii?Q?nHv5NiUd5f+HtVKWZP2m5c0SZwOFdBOaXxI9m7zkt6YnzHKtgzu29263znif?=
 =?us-ascii?Q?vi3LSgD0Tc/U5oM8tRfP0KOrnJ8ZRnxeJ3ArYKVKBlHvuKoR3PHgPJi5wD/8?=
 =?us-ascii?Q?1jGfWxr5817rz7XBYurEg/xZJfXVe7Dq9yQRrtydjDuKqOvzsPYJ/MkhwiEQ?=
 =?us-ascii?Q?avifpkvk0YiDfYrIJ0LGQx82A2ikaoVinDbfZEutAJxl9xsZV5HJrqvJCsKG?=
 =?us-ascii?Q?UtGko8HR25+V5YZWW9c7ZevQ2JmncrqbHHjvtov0uzLi38LXq7YQGJ1uIyq7?=
 =?us-ascii?Q?+JkJaS4o7Tnu3JELr5jNa/2W7Cez3FXTVNB2yGhDGZd0L52MUHutznf8qfb9?=
 =?us-ascii?Q?Sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b84f90-a4bd-4705-ec33-08dbc6fe1fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2023 06:24:56.1269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQOXL3w8dfZYsBzDF/H+QyhxsQGhytW7Alpivaq+pi0rEE07/qMWaiRqxHlN9YQ9ynG7pncbdqLHuP7zqSjZ2IKMzSZ0k+aEDWoBqOclo1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5613
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
> On Fri, Oct 06, 2023 at 05:55:01PM +0200, Peter Zijlstra wrote:
>=20
> > And yeah, min_deadline is hosed somehow.
> >
> > migration/28-185     [028] d..2.    70.264274: validate_cfs_rq: --- /
> > migration/28-185     [028] d..2.    70.264277: __print_se:
> ffff88845cf48080 w: 1024 ve: -58857638 lag: 870381 vd: -55861854 vmd: -
> 66302085 E (11372/tr)
> > migration/28-185     [028] d..2.    70.264280: __print_se:
> ffff88810d165800 w: 25 ve: -80323686 lag: 22336429 vd: -41496434 vmd: -
> 66302085 E (-1//autogroup-31)
> > migration/28-185     [028] d..2.    70.264282: __print_se:
> ffff888108379000 w: 25 ve: 0 lag: -57987257 vd: 114632828 vmd: 114632828 =
N
> (-1//autogroup-33)
> > migration/28-185     [028] d..2.    70.264283: validate_cfs_rq:
> min_deadline: -55861854 avg_vruntime: -62278313462 / 1074 =3D -57987256
> >
> > I need to go make dinner (kids hungry), but I'll see if I can figure
> > out how this happens...
>=20
> *sigh*, does the below help?

I confirm the message "EEVDF scheduling fail, picking leftmost" is not appe=
aring with this patch.

Cheers,
Biju
>=20
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c index
> 04fbcbda97d5..6a670f119efa 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3632,6 +3747,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq,
> struct sched_entity *se,
>  		 */
>  		deadline =3D div_s64(deadline * old_weight, weight);
>  		se->deadline =3D se->vruntime + deadline;
> +		min_deadline_cb_propagate(&se->run_node, NULL);
>  	}
>=20
>  #ifdef CONFIG_SMP
