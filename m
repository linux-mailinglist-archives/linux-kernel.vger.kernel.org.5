Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4661E7B9E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjJEN4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239402AbjJENyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:54:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ABC2754F;
        Thu,  5 Oct 2023 06:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5b6eztBteRFk2gLdDBby21QYumbahNHbs9RbkwryQ2Ep54mafMHd7yajxafCQiPnooZ5UI2S/Yq3mHAz/9SmVw4/uHfNMJU8ccMHrODtqsZUa0DADw+Mzq4kEssSjJnAoBeWfTEtJl3+VYYtJXieG29E0XaOKD84fYxyuYLjLhTxyGHPKYd61xKJNKFR0gl77HWTNYGsYBN/d4JWQ4kDLdWOgNEomLODpQrJNypml1AaxEOCHPOrNVpcOvsABIz8Evr4peNnjwMmyKxT+Xiw9nqMXDncskg/fua+36dQhpgja9S/MB1lLS/bW2EoOZqDf+WcEL/qlipmkustOWKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsItqGfbZlmXKdPKH7AN8O/yBMzbiD671dzok1U55bU=;
 b=HW+uLQBBs2MNg2+PfHI+4SiUKvZTmeSwIpmHt9NB2E/n+ZKqrwn/9SpjaB5TNB9HHbMzyWtukrYiQEWeKYOj5anIqrm46RrT+J1rnPANai5c9wyl9DRo8NA9/IdPoTzBi4sNs2eQy4giMyRob91Xyh+EnRULln5RTsZSkPBB4YfoICjmlwpNoKkj4SvEm9NuL5Pr843oukDI0oqF13WaBlgb3PY4THdgl73JG0b1eUbWx0ra8O1lw3kKdaR+g6H584RBXf6CgOKZmskho0UjHmxEBuJk4AccUQwqITHpsWYu/hG9Kw+B2zn5aRZCF927yaTsh8PhN7RiFdk2mynZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsItqGfbZlmXKdPKH7AN8O/yBMzbiD671dzok1U55bU=;
 b=sZfpmHzWB0XdJ4b/jBcXrary5wWffvqNepqrNa8f8M1EkT/x9KJSK7q5SCdADl1qEKBzwLmyKMaR8OqRJgdrVdY9IAfosfglwf31aQAOYxAEfvXb/Bn4+IdOY6gEbCPMyeycfJNkCcyPywmc+RS9WiQYOFwlj6Z/Gjj5k1EDHeU=
Received: from BYAPR12MB4773.namprd12.prod.outlook.com (2603:10b6:a03:109::17)
 by SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 13:12:41 +0000
Received: from BYAPR12MB4773.namprd12.prod.outlook.com
 ([fe80::be44:31c5:714a:21f3]) by BYAPR12MB4773.namprd12.prod.outlook.com
 ([fe80::be44:31c5:714a:21f3%7]) with mapi id 15.20.6813.027; Thu, 5 Oct 2023
 13:12:41 +0000
From:   "Katakam, Harini" <harini.katakam@amd.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>
CC:     "esben@geanix.com" <esben@geanix.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jsc@umbraculum.org" <jsc@umbraculum.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "harinikatakamlinux@gmail.com" <harinikatakamlinux@gmail.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Subject: RE: [PATCH net-next] MAINTAINERS: Add an obsolete entry for LL TEMAC
 driver
Thread-Topic: [PATCH net-next] MAINTAINERS: Add an obsolete entry for LL TEMAC
 driver
Thread-Index: AQHZ67jCoWGQypOkt0SHyr1GDsfuRLAwXaZmgAEBKQCACGzxAIABdiug
Date:   Thu, 5 Oct 2023 13:12:41 +0000
Message-ID: <BYAPR12MB4773E02EE47B56F20A544D269ECAA@BYAPR12MB4773.namprd12.prod.outlook.com>
References: <20230920115047.31345-1-harini.katakam@amd.com>
        <878r8qxsnf.fsf@geanix.com>     <4b8361e5-08f8-4cf8-a277-769647fb9c4c@amd.com>
 <20231004074646.6fd564a6@kernel.org>
In-Reply-To: <20231004074646.6fd564a6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4773:EE_|SJ2PR12MB7918:EE_
x-ms-office365-filtering-correlation-id: 8c70dfe6-c200-498a-9a57-08dbc5a4c16b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a4IdefDe5xR3ms6QNQ7gjQRJF7D/G6/eN2YqNkzysnM8GL6fzYKu4UsWbm4leaPntaWlf1n5ksR44h2kKcJR+1uh2Y3h4BlPlaV7fjQEKOXkF4z3Pxi0nmlUpKtx92HXeBDGcx0OALYaOr7/sVfFL7RanGV27W0aoZtIEenmhUjeiJOrFhxhySY3B4wgjp3x/kU6BYD/6iVJw/FdUzbzba1/jA/JbO/Z+9J7vaKxld05GBfrTMlXaLk5MsCivlmg2kC4qC/TcAq9TgeGmZVg2ar1Iap3sspVKvZZ9UpcJTav2LeWrk1u0xcHEO/g+S0hoyI34AhqfreifnQqDH4zBlM9Driwo6g4wInigLhauAVZZjySz6uxDMIpyjSp/Ftf99R2W6Y67xdKIMfSBzggyZi1NMxkl84MnImvsMrzcsTqFWKvdufI+oefgKoFXf87FXPDZRn0tcwj2Mum5ZVWtBL0gdGA+vppAu5L52lcq0e1gE2elPXElkcRYto/bi5ToGawar/y8xiChqEN5L+OBlTjlsIuOH4EwqNdZAU73Fs9ZVlXsYjvbVDdZm+WayidCFteSSjJzeRsglniguzLw7yFMQkwfeAAHZum5KDVILASPmeiDIt+sxedwunNSMgM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4773.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(376002)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(83380400001)(7416002)(38100700002)(86362001)(33656002)(122000001)(55016003)(38070700005)(53546011)(76116006)(6636002)(66446008)(9686003)(66476007)(66556008)(54906003)(64756008)(66946007)(6506007)(7696005)(316002)(110136005)(41300700001)(52536014)(478600001)(8676002)(8936002)(5660300002)(71200400001)(26005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fIbY4lrtgzUyVO2kejo/+dtDksv/bfjPottnEcXi/AkJtADHXpBVHud6RXvg?=
 =?us-ascii?Q?AuZfc9n489lPLDZPjaAiU43iM28G6WW62WdjAigPoJfiLwsN1qfWnpfDb0lG?=
 =?us-ascii?Q?pgVLn0AW7+up3cEO9FBvqDO1hMKv9XLv0oz1KKRjhTlv+R/wHyDFmb7eO2I4?=
 =?us-ascii?Q?8ve8Ny1lUdDA7thlD/SWS2FDA1C6Dw7wX0E1lBwD+yRv3dGi7yiSvpqW5ZZv?=
 =?us-ascii?Q?kS7BG1Vhp+pR7rZQmjlPfdE0CIIeiojohOjbsqFzJVas90p/KLdA44q8KDn0?=
 =?us-ascii?Q?BCJYf9l+sXM+Kyrdh60SvU2S058ofCfunaR8v6crFtokqWZ/1TBIDo3wyJ9j?=
 =?us-ascii?Q?8MbJFSTiuyH53CpeG+59OAH2+D1YuSwgfNed4bMDcg/MIzLqOduNf7e1e4Pg?=
 =?us-ascii?Q?dB6XqpBojx0+M17nUAe0sjcVjEXMyN6nDGX0ALlZFznqVu193E6s0Nsgwx/m?=
 =?us-ascii?Q?oH916jelyMg1wvTEZDta/9xGpHHvFINf3iZKOqlzMhQzv/3nDOhd/OIgUZt1?=
 =?us-ascii?Q?Q3B06GqWJ090wLYuuLtW2nlp+gpKj2Yh8grAhG+DmGDzi46WUCdpElpLwZyg?=
 =?us-ascii?Q?Vy/2MxZ72Z89zEttFrkoRla9XVYzqKgojW3+FU6SqOlDL0U57B6Oy5/HUxNS?=
 =?us-ascii?Q?u6FB4tSoNQQ7FDgV3Obn2rN7iNbgiSMEUP8i191sLuS7YxcBQxsTX0XrzF0p?=
 =?us-ascii?Q?ewEh8giFhadTR1IGploIB2F9PF0bzJ97SIIg5cfjMKvO8HdY5fA+K6/sngOZ?=
 =?us-ascii?Q?mEhGMJsJPW6DREsLCntWGtzM11H4nUgGYGj7u+S1BhnotZqSWYOHqZFRO2rF?=
 =?us-ascii?Q?9YW3ExRrsOMwkjh6xSiR29Fjng4ziyMUR0IjmVjc4aCFD1QFx+CbG+XsNsLu?=
 =?us-ascii?Q?Sc+4dO7mn/w/fQl6ZVRoYv7W/CXHPlXqGdqMcW5DsNzxQabYl+VtZM4DWbx7?=
 =?us-ascii?Q?WKZw7EJ3dilVpeTrpzIg7N63/OBY4+pNhkcy/BInvpnh2xrs33m6DMxfjMuF?=
 =?us-ascii?Q?4yRB4N11F/tLUbuYZ9LPRgKlH8sM8ClSFv9aI2O9Zp8ktdx2hRpba5hUV49i?=
 =?us-ascii?Q?XMhDrB76A7pVMeRA+oxAwWsWC4A3z5XJdcLyBmwo3draKad8t3ut1xGbkmXF?=
 =?us-ascii?Q?/x5DqPZv+SxxgWJBNDusfVAMUSTx+XoPDkHW3DBvEwYOhXBUrWReD2Cxwq8R?=
 =?us-ascii?Q?exUZ3SpdOdR05dOLuLDUleCLD2Z4wNS5l3L2Zdgdo/7QG/aIk6eW6++kp6SI?=
 =?us-ascii?Q?Kxhr3HyHNuy5E8HS+kAtVlfhKf/hz5rNoMqKIdOZfysjYRHBmQq4bAGyk1oj?=
 =?us-ascii?Q?JiDcR0blDRWuwBoe63QQpEZN8HDJb6bT2RcyTQK97purFwspcgkLELfz2zXY?=
 =?us-ascii?Q?DWEva9jFFQly+Rd7TcZpDYcTJYtRcLewtSuZPI5wq/FFWY4xuYZsyfd3C4yH?=
 =?us-ascii?Q?sQ32LXT0ND8W6o8PDIeB5i/qvw2jNZnR486rKMOVdSjsmMWB3ExSILScHaEC?=
 =?us-ascii?Q?XUCYj9p2uUw2m1TyWQ4zziRMMOrttETfpU9B5yD9lzGZNMBnGdSyD1xbU8Jo?=
 =?us-ascii?Q?PXwfcZuvr7Q92UnYPpk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c70dfe6-c200-498a-9a57-08dbc5a4c16b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 13:12:41.3368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mUYjYOAJYeZ27Ey2o1ZPen+DNXDpWueWnQrOA+fu8gqddPTVfJw1PWixquTOHNhG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, October 4, 2023 8:17 PM
> To: Simek, Michal <michal.simek@amd.com>
> Cc: esben@geanix.com; Katakam, Harini <harini.katakam@amd.com>;
> davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> jsc@umbraculum.org; christophe.jaillet@wanadoo.fr;
> netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; harinikatakamlinux@gmail.com; Pandey, Radhey
> Shyam <radhey.shyam.pandey@amd.com>
> Subject: Re: [PATCH net-next] MAINTAINERS: Add an obsolete entry for LL
> TEMAC driver
>=20
> On Fri, 29 Sep 2023 08:06:46 +0200 Michal Simek wrote:
> > > Ok. But while that might mean that no new designs should use LL TEMAC
> > > IP, why do we need to declare the driver for it obsolete?
> > >
> > > Existing designs using LL TEMAC IP might need to upgrade Linux kernel
> > > also.
> >
> > If you want to take responsibility for keeping that driver alive then f=
eel free
> > to send a patch on the top and declare it publicly. We are not able to =
test it
> > on these old platforms that's why we are publicly saying that it is end=
 of us.
>=20
> Why Obsolete tho? There's no other driver for this IP, so Orphan sounds
> more accurate. Please change it to Orphan.

I just noticed that this patch was already applied on net-next. So, I sent =
a patch
on top updating it from Obsolete to Orphan.

Regards,
Harini
