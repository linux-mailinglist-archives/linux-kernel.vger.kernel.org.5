Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F28578FD22
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239734AbjIAMZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349403AbjIAMZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:25:26 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2107.outbound.protection.outlook.com [40.107.113.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980EA10D7;
        Fri,  1 Sep 2023 05:25:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDuTRRfkWs2+0D/SvZGVJN2P2ZyB6LRTel2EaL5tDkD3otjbYsE3Ei3nz8PVo6YXcMsCWWT+vdoF7vJKWCEnDfcIwd6Cfl7o1ZdOcyIqYTmoy4RNTyLI7GJqVNsd5qTEHYqp3TzOkNayMDQ/RXCda3h6dbAySC4HPNVX27IW85G7Zk/D5iaz+A6IjH2oTnilp0+BTMMsHk5QrCP2UvcS3sxmy8AmRnFffPsDLcvUZmX9d0UOaHshdG3xIxi+x/aToKDm+0J1FThzITg+KBi6P8tIF6+akaneRheay8MnEpHQ54bO06LJ0ZS/qLAmo2eOF94vOeHzRAR8Dd6FL54Cnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLB2lCKySglDsK1UulxtGCYFiyKDZuHG6PhPewRgq7I=;
 b=T2s9x8pPv3rztWTjfUCNcMOfJc7kVkRiDcP0dSA/KOVB+4/dVUqK/JKHpRy/JW84n7eTnx3pB0/yS6QS4ahlX9PbGIk0wtSeQEz/S1ItA59PdAT8fjye2PePXYawxYqtbFzAkMQJSRuhK+9jTL5PzXbz/htBhEcxfatjSFLuxIPvmgsq8uofxxbS/Fs1duMNyTyXxO3IKpDugSZ39uFgdq6tFNdWRYyfSPG76jhJmZokkRuD//tzRgIcJi7zOiB9qG5Y7nXBig3EBxolnONS3opuJtZtSjq017LbICC17pZsWCieEHpZ52iyLuju70IEhJQDCt5g6FoKzA28vmiumQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLB2lCKySglDsK1UulxtGCYFiyKDZuHG6PhPewRgq7I=;
 b=EQvWAKn9vRC5JZfnd7tQNTcC2QtBJ+ZsJFhUMybul5o9r5cdGRviWmmdmlfnhpbxM6FILKyWKi9RvxQDMuT7vDgr78RFwQvERIZz1LoJgmeUrAqrhv6fEPpEwp3wlPq+6vK1HH0XxyIixfSMqlJMVYuCX/DNSwe2R1Ta5aonMYY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB12023.jpnprd01.prod.outlook.com (2603:1096:400:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 12:25:13 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 12:25:13 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v15 0/4] Add support for RZ/G2L GPT
Thread-Topic: [PATCH v15 0/4] Add support for RZ/G2L GPT
Thread-Index: AQHZu5nRS9UEj1xjhEKw73iL/YoZtq/e00cAgBfcz4CAD3bw0A==
Date:   Fri, 1 Sep 2023 12:25:13 +0000
Message-ID: <OS0PR01MB592230E78168D2C2D032AD1786E4A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230721060840.8546-1-biju.das.jz@bp.renesas.com>
 <OS0PR01MB5922774DA08EBD836460BAC8860CA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922300A2784C863C4276D2E861FA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922300A2784C863C4276D2E861FA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB12023:EE_
x-ms-office365-filtering-correlation-id: afce34c6-ef67-4f5e-4bb5-08dbaae67dbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iQCWOxe5B8hFm9r0KvlpkU7eQL1rvAq09fYLwh3Qp4h+8kxjTJKG83MS5ZcGTWhu+lK52MfG8SPxlJBoMokZksNWYGZ8q5l/UlwFJblCb9SbDWPKXMelgrHhPqZAihCbVmT1wU0lLt0d9bSRHjdJb3qyJs4OYJxb3bY5CGKDBlpNYdJDsjA+r9PKiD7VNGg8qJ/ZXLaJxuretA8lFgK0eSiVK2xBiVrKBBEdF0RuxQ281DHDMWU7n025kyJzu1N7O9Wnlek3CsQt24HO52a7qdF1pEtHrSZWvNrokbDlu2DfmA6v5EKLJWZfOWYqlfcddRJqNk2oQaiUyPPXYt6N+reHDGuOtddVqEovUn/gB445KMHPRuCef25yxyHEySxPC5PgaG0vLOZrlKXN8zWiEJz697tOs0y5Jdi8XAvtgNVb6OEV+3+CraWgTm2zTRYFIFkSTXxQUkp2C0htwKcM8yxB/yJXlQVzUfzhD3HoB+YgCxEMXGr8uWfPFLYhBK4eNlpAFBxRqmYVSa3byRJfUid3E9Z4jsQUB0Bn319DR3E1VDPphmwM6WQsfNKZichu7Du0EB1xXTJ80jqxYiy3uAe1r7hmDleC0WD9+stsO6A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(186009)(451199024)(1800799009)(30864003)(7696005)(6506007)(71200400001)(9686003)(45080400002)(53546011)(966005)(478600001)(83380400001)(2906002)(26005)(7416002)(66476007)(316002)(66446008)(54906003)(64756008)(110136005)(76116006)(52536014)(41300700001)(66556008)(8676002)(66946007)(5660300002)(4326008)(8936002)(33656002)(122000001)(86362001)(55016003)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JxcLur3Tsc2kJDt6SKE4ewsl+KZ1XtvutJgBzvCmIu4UCZEaZdl+WzB59t?=
 =?iso-8859-1?Q?FsSXdwWwShb9r/HMcuFeilgnRwkCoI1fkSJWmpMMbSvswzUH5iduAYGFKx?=
 =?iso-8859-1?Q?V6jFsPEDYLfvxjViXxdohatH5Usu3Q+Uew0bJQmw8G7ghqMIrBcwaDC/OQ?=
 =?iso-8859-1?Q?BbAq5lz3HSrrBKOIj+N0yMq1vKVlnE3YM9QHyMHHfpui303oOSl5678wlC?=
 =?iso-8859-1?Q?le7v3vDz70sHTb27FecVvLQ0vIMV43FmkfKfGLcfWLA5MJ4QvPCU4yZwZY?=
 =?iso-8859-1?Q?EkUQbD4+wSr6LLn1b0V+EYqHdY09jK1GZpnKyVBK9qOx7nNmv/KS9KOaP9?=
 =?iso-8859-1?Q?zzqs76Ijlnl58RFjPevbMgRN9LgCZtlN4SzoseJjgAitAnv6CZNx9Lda8t?=
 =?iso-8859-1?Q?HbAOAnggjByrgMRI3WQV9Xm6K2c5cNg+18QOWbP4ca/TA+4Dm8yrOopZJ2?=
 =?iso-8859-1?Q?Hl/451+ewBEuW81ik4cGjzIk3IqwDJU59Jtnuq45SGnVgFbbMBFJK9NT7a?=
 =?iso-8859-1?Q?TFXrE+VtqBNIz025VnCmeHxNKLgZAWBS2roj1rpQbjq/gchYcURcsizOPO?=
 =?iso-8859-1?Q?aAXKUT1yA1pClliQwKb62w2q+53IWPPbmNwUqihGRNwsyljsPt49aVYdah?=
 =?iso-8859-1?Q?RP5TQInIPYfFF04uoVrHk5QC1p94CuNLhlMVu+0kmmIuZUcZsvIg1PCPsc?=
 =?iso-8859-1?Q?r8X6s0ojk8F+30KmpslmnUFCSxLXURFfFaLQCbWi8SjHWZraDV6GUqCY1E?=
 =?iso-8859-1?Q?234OnAupL1B9/yz2d11A3aBbuZvG+aaPEcsPvkKwWsEX2B+C5xuyfM3lQz?=
 =?iso-8859-1?Q?EQfcqzIm30HidLADFIVfZ+kc+hTJNfT5ExmUy7D9/ZcV3UXGJNrKbx/Io0?=
 =?iso-8859-1?Q?/o+UpGDrtVAN3qKAIiNxeGdRS2vHdFgDTJEhhVRFnZaB5xZ26FhD08HfoO?=
 =?iso-8859-1?Q?KoY+pz2T5LU0GiYcwOc6GsPbySWewjooAXdQ3GkhMv29wwwPHJWEGD96HA?=
 =?iso-8859-1?Q?EXzn0xMhm+60SRoIkeZc2N2e2e3szw8NdYjpwYrihUO+XjHoYtz+XymS6C?=
 =?iso-8859-1?Q?uoYjiLuQvtIiOP0YEqB+dgoxeGdeyziiQ31XWZ3dAXexSLcH1PeiEb10Ub?=
 =?iso-8859-1?Q?My86IhftXb+rDqNC4LUmMXWdOWCFgNb/g3fTPAAXd7VNK8ESR9aJAxDhlW?=
 =?iso-8859-1?Q?k9oce3N5gxkvLwtf5HWy7GQGVVFL9H8UC4sZh30Klmbyf7XAwhN3+Wy/9f?=
 =?iso-8859-1?Q?21XtItQMRDk7WiWL2m7DKNqAIDROy2094Q5JRTAnOGO8eYj6aBL73s8K0E?=
 =?iso-8859-1?Q?pTav8nlZg6vHmjCmgkQwCEvkStjeFDIpK5DwnpRWQARUhr6PPtZlq96JuC?=
 =?iso-8859-1?Q?XvKARPyKkxepJJULvOTcayt+tS8EdoSlZ/v7CgPI2IyeTwSHeQ1x66LjL4?=
 =?iso-8859-1?Q?7W05YSooRgE4S06jVGF14GTG9/E6A3q8jZwyjeYj29SeLtMT26Jj+CPgyd?=
 =?iso-8859-1?Q?xopAKsCIXcQGjGapyXVOyJZa404pSSJVSVTgPGHlLmVxBmk+8tz9dkYkIl?=
 =?iso-8859-1?Q?bY13Gxpea+xI5xQjTUSh01RRjfwVHTZNwyeHaUHwN41ADBGZjtCoZl0CHc?=
 =?iso-8859-1?Q?e/CndlYSllWcovgNX3PIJWZ1dK42A3CwwBxr7aTrrL+gy66cMTJ5jfIg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afce34c6-ef67-4f5e-4bb5-08dbaae67dbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 12:25:13.1527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a78NDMMrPEMDEDf6UnCMmNp6tUl8XNih3m+6cnA8tI+hxz6Cq0/14HnhnlTrxzF8BDRdoDCFasIM3C+mxBSozfJB2TKRtbseNFoE91v239o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12023
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry/Uwe,

Are you happy with this patch series[1]?

[1] https://lore.kernel.org/all/20230721060840.8546-1-biju.das.jz@bp.renesa=
s.com/

Cheers,
Biju

> -----Original Message-----
> From: Biju Das
> Sent: Tuesday, August 22, 2023 5:14 PM
> Subject: RE: [PATCH v15 0/4] Add support for RZ/G2L GPT
>=20
> Hi Uwe,
>=20
> Gentle ping.
>=20
> Cheers,
> Biju
>=20
> > Subject: RE: [PATCH v15 0/4] Add support for RZ/G2L GPT
> >
> > Hi Uwe,
> >
> > Gentle ping.
> >
> > Cheers,
> > Biju
> >
> > > Subject: [PATCH v15 0/4] Add support for RZ/G2L GPT
> > >
> > > RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit
> > > timer (GPT32E). It supports the following functions
> > >  * 32 bits =D7 8 channels
> > >  * Up-counting or down-counting (saw waves) or up/down-counting
> > >    (triangle waves) for each counter.
> > >  * Clock sources independently selectable for each channel
> > >  * Two I/O pins per channel
> > >  * Two output compare/input capture registers per channel
> > >  * For the two output compare/input capture registers of each channel=
,
> > >    four registers are provided as buffer registers and are capable of
> > >    operating as comparison registers when buffering is not in use.
> > >  * In output compare operation, buffer switching can be at crests or
> > >    troughs, enabling the generation of laterally asymmetric PWM
> > waveforms.
> > >  * Registers for setting up frame cycles in each channel (with
> capability
> > >    for generating interrupts at overflow or underflow)
> > >  * Generation of dead times in PWM operation
> > >  * Synchronous starting, stopping and clearing counters for arbitrary
> > >    channels
> > >  * Starting, stopping, clearing and up/down counters in response to
> input
> > >    level comparison
> > >  * Starting, clearing, stopping and up/down counters in response to a
> > >    maximum of four external triggers
> > >  * Output pin disable function by dead time error and detected
> > >    short-circuits between output pins
> > >  * A/D converter start triggers can be generated (GPT32E0 to
> > > GPT32E3)
> > >  * Enables the noise filter for input capture and external trigger
> > >    operation
> > >
> > > This patch series aims to add basic pwm support for RZ/G2L GPT
> > > driver by creating separate logical channels for each IOs.
> > >
> > > v14->v15:
> > > * Added enable_count and ch_en_bits variables to struct rzg2l_gpt_chi=
p
> > >   based on feedback for pwm_mtu3 driver.
> > > * Updated copyright header and commit description by replacing "This
> > patch
> > >   adds"-> "Add"
> > > * Replaced macro RZG2L_GET_CH_INDEX->RZG2L_GET_CH and replaced
> > > ch_index-
> > > >ch
> > >   throughout
> > > * rzg2l_gpt_{enable,disable}() enables/disables PWM based on the
> > >   enable_count.
> > > * Replaced pm_runtime_get_sync->pm_runtime_resume_and_get and
> propogated
> > >   the error in rzg2l_gpt_get_state() and rzg2l_gpt_config()
> > > * Reduced variable scope in rzg2l_gpt_get_state() by moving most of
> > > variables
> > >   inside the if statement.
> > > * Updated rzg2l_gpt_get_state() by moving duty > period check
> > >   inside the top if block.
> > > * Added helper functions rzg2l_gpt_calculate_pv_or_dc()to simplify
> > config.
> > >   Also Improved the logic in rzg2l_gpt_calculate_pv_or_dc() by using
> > >   min(period_or_duty_cycle >> (2 * prescale), (u64)U32_MAX);
> > > * Updated rzg2l_gpt_get_state() by moving duty > period check
> > >   inside the top if block.
> > > * Simplified rzg2l_gpt_config() for updating registers
> > > * Dropped pm_runtime_get_sync() and used bitmap variable "ch_en_bits"
> > >   to make balanced PM usage count in
> rzg2l_gpt_reset_assert_pm_disable()
> > >   For case were unbind is called before apply where pwm is enabled by
> > >   bootloader.
> > > * Added error check for clk_rate_exclusive_get() and clk_get_rate() i=
n
> > >   probe().
> > > * Dropped prescale from struct rzg2l_gpt_chip.
> > > * Replaced of_match_ptr(rzg2l_gpt_of_table)->rzg2l_gpt_of_table in
> struct
> > >   rzg2l_gpt_driver
> > > * Updated commit description of patch#4 by replacing "This patch add"=
->
> > >   "Add".
> > > v13->v14:
> > > * Moved the patch from series[1] to here.
> > >  [1]
> > > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
o
> > > re
> > > .ker
> > > nel.org%2Flinux-renesas-soc%2F20221215205843.4074504-1-
> > > biju.das.jz%40bp.renesas.com%2FT%2F%23t&data=3D05%7C01%7Cbiju.das.jz%=
4
> > > 0b
> > > p.re
> > > nesas.com%7C5e49c1dce57a4fb65f8008db89b0f2bc%7C53d82571da1947e49cb46
> > > 25
> > > a166
> > > a4a2a%7C0%7C0%7C638255165297945656%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
> > > C4
> > > wLjA
> > > wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&
> > > sd
> > > ata=3D
> > > zS%2FQnDta9svTRgCKwNQzxIZnK7ie8QOQufDZ6K18hc0%3D&reserved=3D0
> > >  * Add Rb tag from Rob for patch#2
> > >  * Removed parenthesis for RZG2L_MAX_HW_CHANNELS and
> > > RZG2L_CHANNELS_PER_IO
> > >  * Removed duty_cycle variable from struct rzg2l_gpt_chip and added
> > > comment
> > >    for cache for prescale variable.
> > >  * Fixed a bug in rzg2l_gpt_cntr_need_stop().
> > >  * Reordered rzg2l_gpt_config() just above apply()
> > >  * Replaced pwm_is_enabled()->pwm->state.enabled in config
> > >  * Replaced pm_runtime_resume_and_get with unconditional
> > > pm_runtime_get_sync()
> > >    in config().
> > >  * Restored duty_cycle > period check in rzg2l_gpt_get_state().
> > >  * Added error check for clk_prepare_enable() in probe() and
> > > propagating error
> > >    to the caller for pm_runtime_resume()
> > >  * clk_get_rate() is called after enabling the clock and
> > > clk_rate_exclusive_get()
> > >  * Simplified rzg2l_gpt_probe() by removing bitmap variables.
> > >  * Added pm_runtime_idle() to suspend the device during probe.
> > >  * Moved overflow condition check from config->probe().
> > >  * Simplified rzg2l_gpt_reset_assert_pm_disable().
> > >  * Removed the parenthesis for RZG2L_MAX_POEG_GROUPS.
> > >  * Renamed rzg2l_gpt_parse_properties()->rzg2l_gpt_poeg_init() as it
> > > not only parse
> > >    the properties but also implements the needed register writes.
> > >  * Added acomment here about the purpose of the function
> > > rzg2l_gpt_poeg_init()
> > >  * Removed magic numbers from rzg2l_gpt_poeg_init()
> > >  * Fixed resource leak in rzg2l_gpt_poeg_init().
> > > v12->v13:
> > >  * Added test logs in [1] below
> > >  * Replaced Kconfig dependency from ARCH_RENESAS->ARCH_RZG2L
> > >  * Sorted #include <linux/limits.h> alphabetically
> > >  * Added a comment for mutex_lock to fix check patch warning
> > >  * Replaced data type of duty_cycle from unsigned int->u32 as
> > >    the maximum value stored is U32_MAX.
> > >  * Improved rzg2l_gpt_config() by removing unwanted duty_cycle
> > > related code.
> > >  * Improved rzg2l_gpt_get_state() by setting "val =3D rzg2l_gpt-
> > > >duty_cycle[pwm->hwpwm];",
> > >    and factor "tmp =3D NSEC_PER_SEC * (u64)val;" out of the if-statem=
ent.
> > >  * Started using DEFINE_RUNTIME_DEV_PM_OPS(), and dropped
> __maybe_unused
> > >    from the callbacks.
> > > v11->v12:
> > >  * Added return code for get_state()
> > >  * Cache duty cycle/prescale as the driver cannot read the current du=
ty
> > >    cycle/prescale from the hardware if the hardware is disabled.
> > > Cache
> > the
> > >    last programmed duty cycle/prescale value to return in that case.
> > >  * Updated rzg2l_gpt_enable to enable the clocks.
> > >  * Updated rzg2l_gpt_disable to disable the clocks.
> > >  * Updated rzg2l_gpt_config() to cache duty cucle/prescale value
> > >  * Updated rzg2l_gpt_get_state to use cached value of duty
> > > cycle/prescale,If the PWM
> > >    is disabled.
> > >  * Simplified rzg2l_gpt_apply()
> > >  * Added comments in rzg2l_gpt_reset_assert_pm_disable()
> > > v10->v11:
> > >  * Used bitmap_zero for initializing bitmap varable.
> > >  * Fixed clock imbalance during remove for the case bootloader turnin=
g
> > >    on PWM and module unload is called just after the boot.
> > >  * Fixed over flow condition in get_state() for a prescale value of
> > > 2 & more.
> > >  * Improved rzg2l_gpt_cntr_need_stop() based on prescale as it is the
> > >    only runtime variable.
> > >  * Added array for Cache variables state_period and prescale
> > >  * Probe caches the prescale value set by the bootloader.
> > >  * Updated rzg2l_gpt_config() to make use of array variables.
> > > v9->v10:
> > >  * Updated the example gpt4: pwm@10048400-> gpt: pwm@10048000
> > >  * Keep Rb tag from Rob as the above change is trivial one.
> > >  * Updated the error handling in probe(), clk_disable_unprepare calle=
d
> > >    on the error path.
> > >  * Removed ch_en array and started using bitmask instead.
> > > v8->v9:
> > >  * Added Rb tag from Rob.
> > >  * deassert after devm_clk_get() to avoid reset stays deasserted,in
> case
> > >    clk_get() fails.
> > >  * Removed ch_offs from struct rzg2l_gpt_chip and use macro instead.
> > >  * Updated error handling in probe()
> > > v7->v8:
> > >  * Removed Rb tags from Rob and Geert as it modelled as single GPT
> > >    device handling multiple channels.
> > >  * Updated description
> > >  * Updated interrupts and interrupt-names properties
> > >  * Updated binding example
> > >  * Modelled as single PWM device handling multiple channels
> > >  * Replaced shared reset->devm_reset_control_get_exclusive()
> > >  * Added PM runtime callbacks
> > >  * Updated PM handling and removed "pwm_enabled_by_bootloader"
> > > variable
> > >  * Replaced iowrite32->writel and ioread32->readl
> > >  * Updated prescale calculation
> > >  * Introduced rzg2l_gpt_is_ch_enabled for checking enable status on
> both
> > >    IO's
> > >  * Moved enable/disable output pins from config->enable/disable.
> > >  * Added rzg2l_gpt_cntr_need_stop() for caching prescalar/mode values=
.
> > > v6->v7:
> > >  * Added the comment for cacheing rzg2l_gpt->state_period.
> > >  * Fixed boundary values for pv and dc.
> > >  * Added comment for modifying mode, prescaler, timer counter and
> > > buffer enable
> > >    registers.
> > >  * Fixed buffer overflow in get_state()
> > >  * Removed unnecessary assignment of state->period value in
> get_state().
> > >  * Fixed state->duty_cycle value in get_state().
> > >  * Added a limitation for disabling the channels, when both channels
> > > used
> > > v5->v6:
> > >  * Updated macros RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH and
> > >    RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH with computation
> > >    involving FIELD_PREP macro.
> > >  * Removed struct rzg2l_gpt_phase and started using RZG2L_GTCCR macro
> > >    for duty_offset.
> > >  * replaced misnomer real_period->state_period.
> > >  * Added handling for values >=3D (1024 << 32) for both period
> > >    and duty cycle.
> > >  * Added comments for pwm {en,dis}abled by bootloader during probe.
> > > v4->v5:
> > >  * Added Hardware manual details
> > >  * Replaced the comment GTCNT->Counter
> > >  * Removed the macros RZG2L_GPT_IO_PER_CHANNEL and chip.npwm directly
> > >    used in probe.
> > >  * Removed the unsed macro RZG2L_GTPR_MAX_VALUE
> > >  * Added driver prefix for the type name and the variable.
> > >  * Initialization of per_channel data moved from request->probe.
> > >  * Updated clr parameter for rzg2l_gpt_modify for Start count.
> > >  * Started using mutex and usage_count for handling shared
> > >    period and prescalar for the 2 channels.
> > >  * Updated the comment cycle->period.
> > >  * Removed clk_disable from rzg2l_gpt_reset_assert_pm_disable()
> > >  * Replaced pc->rzg2l_gpt.
> > >  * Updated prescale calculation.
> > >  * Moved pm_runtime_{get_sync,put} from
> > > {request,free}->{enable,disable}
> > >  * Removed platform_set_drvdata as it is unused
> > >  * Removed the variable pwm_enabled_by_bootloader
> > >  * Added dev_err_probe in various probe error path.
> > >  * Added an error message, if devm_pwmchip_add fails.
> > > v3->v4:
> > >  * Changed the local variable type i from u16->u8 and prescaled_perio=
d_
> > >    cycles from u64->u32 in calculate_prescale().
> > >  * Replaced mul_u64_u64_div_u64()->mul_u64_u32_div()
> > >  * Dropped the comma after the sentinel.
> > >  * Add a variable to track pwm enabled by bootloader and added commen=
ts
> > >    in probe().
> > >  * Removed unnecessary rzg2l_gpt_reset_assert_pm_disable() from probe=
.
> > >  * Replaced devm_clk_get()->devm_clk_get_prepared()
> > >  * Removed devm_clk_get_optional_enabled()
> > > v2->v3:
> > >  * Added Rb tag from Rob for the bindings.
> > >  * Updated limitation section
> > >  * Added prefix "RZG2L_" for all macros
> > >  * Modified prescale calculation
> > >  * Removed pwm_set_chip_data
> > >  * Updated comment related to modifying Mode and Prescaler
> > >  * Updated setting of prescale value in rzg2l_gpt_config()
> > >  * Removed else branch from rzg2l_gpt_get_state()
> > >  * removed the err label from rzg2l_gpt_apply()
> > >  * Added devm_clk_get_optional_enabled() to retain clk on status,
> > >    in case bootloader turns on the clk of pwm.
> > >  * Replaced devm_reset_control_get_exclusive-
> > > >devm_reset_control_get_shared
> > >    as single reset shared between 8 channels.
> > > v1->v2:
> > >  * Added '|' after 'description:' to preserve formatting.
> > >  * Removed description for pwm_cells as it is common property.
> > >  * Changed the reg size in example from 0xa4->0x100
> > >  * Added Rb tag from Geert for bindings.
> > >  * Added Limitations section
> > >  * dropped "_MASK" from the define names.
> > >  * used named initializer for struct phase
> > >  * Added gpt_pwm_device into a flexible array member in
> > > rzg2l_gpt_chip
> > >  * Revised the logic for prescale
> > >  * Added .get_state callback
> > >  * Improved error handling in rzg2l_gpt_apply
> > >  * Removed .remove callback
> > >  * Tested the driver with PWM_DEBUG enabled.
> > >
> > > RFC->v1:
> > >  * Added Description in binding patch
> > >  * Removed comments from reg and clock
> > >  * replaced rzg2l_gpt_write_mask()->rzg2l_gpt_modify()
> > >  * Added rzg2l_gpt_read() and updated macros
> > >  * Removed dtsi patches, will send it separately
> > >
> > > RFC:
> > >  *
> > > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
o
> > > re
> > > .ker
> > > nel.org%2Flinux-renesas-soc%2F20220430075915.5036-1-
> > > biju.das.jz%40bp.renesas.com%2FT%2F%23t&data=3D05%7C01%7Cbiju.das.jz%=
4
> > > 0b
> > > p.re
> > > nesas.com%7C5e49c1dce57a4fb65f8008db89b0f2bc%7C53d82571da1947e49cb46
> > > 25
> > > a166
> > > a4a2a%7C0%7C0%7C638255165297945656%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
> > > C4
> > > wLjA
> > > wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&
> > > sd
> > > ata=3D
> > > 8Z2uXHblS94d1zundM01wgdT3pmasWhLuMlmPrSZAAQ%3D&reserved=3D0
> > >
> > > Biju Das (4):
> > >   dt-bindings: pwm: Add RZ/G2L GPT binding
> > >   dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs property
> > >   pwm: Add support for RZ/G2L GPT
> > >   pwm: rzg2l-gpt: Add support for gpt linking with poeg
> > >
> > >  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 401 +++++++++++
> > >  drivers/pwm/Kconfig                           |  11 +
> > >  drivers/pwm/Makefile                          |   1 +
> > >  drivers/pwm/pwm-rzg2l-gpt.c                   | 640 ++++++++++++++++=
++
> > >  4 files changed, 1053 insertions(+)  create mode 100644
> > > Documentation/devicetree/bindings/pwm/renesas,rzg2l-
> > > gpt.yaml
> > >  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
> > >
> > >
> > > base-commit: 92554cdd428fce212d2a71a06939e7cab90f7c77
> > > --
> > > 2.25.1

