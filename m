Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEBB812057
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 22:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442697AbjLMVEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 16:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLMVEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 16:04:08 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2128.outbound.protection.outlook.com [40.107.114.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751FBA7;
        Wed, 13 Dec 2023 13:04:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddVuEpyRO4jZdY92gKp0cqaQOchkDl+ov4FPOtzcxQh6zKFHZcSmKPO/0I3BlfTz/h6APEPbvNVwtO1pRjC7vGuyCwWzo0tmiD/vzfy+oEP6aWKqVfuUbme7a3uzpNiob+O0/QzhOsVjRIR9PHsckHSlgXIJi04cXx7I3hN9CEUQQKZTtwe2nIYek6qT2F38fUSfyZP00nbvLuDkl+n/MxM6Wcyp7Xjhd2YnO4qUjjMag2dhSPSj/jnnyBpeH+4vHdEDMvPOUqXddCsXHHrcr+/rGCNV8PLotd9PS8+nPbuoeeAytR7PIXeGjzfPe2KxGkOOOfbvMHsoNX6n8VExsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnduVvoISTHjcZMqhuBa4VFkWWfSHk10Axqy7oHHyJ0=;
 b=kpbE9PdyS1c0tyXjpd5NrRzYA+A03qHGQZJh2aZzv6JD4vTGQUQdgWHSKv1oCzO0/iGVUBdG6eSt6TkDzJW9rfSI2uN/E+0gWZ3KEO7OPnjd5OW9sU8lvXJ96V33l/g6yEtM+IE10tO4Ff5CNAv6Kf1qB45sSsGRC6X69ch/8WYsQgOulFlqQz9OszKoxAC0owoo9IU8Zu7APo5Q6cg4WzN4X4NqqKXgl6kk5CJcjV7KYJYse5TmYWm4LCeq46a80H7gJaf6tGZHY03dQ7/L38PKaK5Qk8vAYYiSdBFgzZstWTuzLnneqeET1hXISsBE7P4raDIbgQxlJQQz1rknOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnduVvoISTHjcZMqhuBa4VFkWWfSHk10Axqy7oHHyJ0=;
 b=CLzu1xAX3CtE3PS4bMrct4TkHL1z0cZcj2BSUkgVZaqJRJtiiHMMBoAGBvxMYEZerLLpmPNww1riqVQ6EJBWljbFIK4aKt1LqSbbZBLXbO6gDsPKBrOxV2ePk94mQV3K6t1P2Tkae2FGlJ2zCXdely57DAu84fF8+4Liwg55fg4=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OS3PR01MB7851.jpnprd01.prod.outlook.com (2603:1096:604:160::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.8; Wed, 13 Dec
 2023 21:04:11 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::15f6:e7cb:d89d:7926]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::15f6:e7cb:d89d:7926%4]) with mapi id 15.20.7113.008; Wed, 13 Dec 2023
 21:04:07 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Simon Horman <horms@kernel.org>
CC:     Paolo Abeni <pabeni@redhat.com>, Min Li <lnimi@hotmail.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v6 1/6] ptp: clockmatrix: support 32-bit address
 space
Thread-Topic: [PATCH net-next v6 1/6] ptp: clockmatrix: support 32-bit address
 space
Thread-Index: AQHaI72WxBSXocJ/XESZT6513Vz+TbCacjaAgAABPgCAAgSWEIABPJKAgAoTE5A=
Date:   Wed, 13 Dec 2023 21:04:07 +0000
Message-ID: <OS3PR01MB65932B78E4262609241101F2BA8DA@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <PH7PR03MB70644CE21E835B48799F3EB3A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
 <20231205092429.GS50400@kernel.org>
 <d657f059d384419fe4df02580a4af9cf69e0e9c2.camel@redhat.com>
 <OS3PR01MB6593B50F4C5BF3687EE3FA97BA84A@OS3PR01MB6593.jpnprd01.prod.outlook.com>
 <20231207111055.GF50400@kernel.org>
In-Reply-To: <20231207111055.GF50400@kernel.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6593:EE_|OS3PR01MB7851:EE_
x-ms-office365-filtering-correlation-id: 055c265f-df41-474b-4b00-08dbfc1f0be8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PICbBMEA9dCca8KGsCe8vS5ZevdstWMSgCOZZHE8kMeUdUEYwcz4MihR7HFiYObLtL+hAozeUYqRDJglUFaBJX0/3iHCbKaDksu8rUM4KcyF4vmw3dbfQmvGi/Eh02iblbLx/ZjGW7f/aenOXcg6YNmo7qFGjcmxF/pFQUrY5D+/TmW/lVEdJD67TNpyJz3huRB5k8+Qjdf9SWf2ZEzyFFmj9tXJgFOigHR4p3dExUDwm+/tHynSMml/w9z5JGRNFmm00p6Zrzgs1DREMLHu8oJf4nN/fK6hyhVGrw7MNxKU3w8nZ/iPgKc2WbvIzHqtn4L1F764BeVke0Pa1LUWg5fYZWGkxCcC79oNur8JShw5J95rgLIGi8IgdJbgNMRj1/FEsP+2wSDM6k2RtJ0DvwkUfX/f4QgmJ3dhMfX5RD4uNMUyOHm7T4zDOwIe0bQIG7BVqIdGoa4WwDtM8DMJr0WOaFJ59xhSGJ3k6FEGsuuRVBuzfRiCeqd83E8cuzkgTVP6ngZ6WYaml5y8ynJ/MwbXjKJLiCgyqn8UOmQuzwKa/V7f8bIIzFXb2JaUH3wVdtpK93T5qZQnXbVzF1fZ21ZObTOGcVH1NG9JNiOK9+gth9798IQ1DMMeh/yBBdAy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(26005)(7696005)(6506007)(33656002)(38070700009)(86362001)(38100700002)(122000001)(5660300002)(4326008)(52536014)(55236004)(71200400001)(9686003)(76116006)(66946007)(6916009)(316002)(8676002)(8936002)(64756008)(54906003)(66556008)(66476007)(66446008)(2906002)(4744005)(41300700001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i/w7MjxcHPKlBuZbpPAvfwQ/yGfm4WX40kxEQhY7+FbK+1y0mddUXGV3HzVC?=
 =?us-ascii?Q?Qm4+02Bi3XkU56uPP9U2OeHhw7Hctw1fT8ydy8mxfk1ajXqw8cZ/sc8NIgPg?=
 =?us-ascii?Q?NFzQPmPttdQCzlY0JwswlF7rz9gA/BHxnpTed3xiiw2VER1e8wwb+1dfkjSj?=
 =?us-ascii?Q?ZC5fGdMbJmJylOMlDzDnevTSW8I4XwfV15NOA1gjB1NNk+RqApAE91aPkjsO?=
 =?us-ascii?Q?uJ+Jx8LNeoyp7A2EgudOV9bJFiFLEP1O1Zll/P4MqQsFWpyPiJFGuFiZptnK?=
 =?us-ascii?Q?istYnXMR/jNogoUP0LS01TlxLOpMfDAY76+7gpAAtuirMey1wcJ962Clar3K?=
 =?us-ascii?Q?vYa0FnOqjLW+kV8Hc6dkh55hdUhSWxA+TFvpnQFEPohx6QmHZl0dyp218rec?=
 =?us-ascii?Q?ig8jK3aOVXtSn5I9Jnpt4G+KAuzSMyqnIW1UyGGFRaDKerxHGqIkAl1XTzHw?=
 =?us-ascii?Q?CGpNRl0Kh4yLWS2Iu2LiX51xUIiZh+PVLBGIoXgIi32Umi38OeNIUn6wi88T?=
 =?us-ascii?Q?SqHnHZ0pfYr1K3F1R0ldn1GoBei4J0Bo25RkRkJMY8uRa5UcNH9kWqP96gIo?=
 =?us-ascii?Q?9ioP6xpj+OJud6HcFvGgmBbhcebSn1NZie/i/TyDfDXbzAvi2pQ4NZpcWpjx?=
 =?us-ascii?Q?HjcJ3d62ltuo2RB5YPPGOXGtCzPF1rinh5FtOuHv1VcSblPrWauJRKxgHsMR?=
 =?us-ascii?Q?+MDRLvGWsTsSMYWgxuL/5c8vqcu6y3qeN9bmCn1F7+aLmvF4x0uvR9/9sh3f?=
 =?us-ascii?Q?bKRrUn6+StTR0DooE198FD7jxiEJhs784st/ipBZIkbLX7+r+enbpKgNtV1E?=
 =?us-ascii?Q?LaMcaBy/Bn5VvWL+XF7uN806vCFGYl/SpFSlY1+sFJtoW4RTJLd6RNOP2u76?=
 =?us-ascii?Q?3ocOdQ+e1oMa5lBE1rlWOE+xruai8gI4FXT+PZlFgA/yzpLLvl9a/Z5ciHtB?=
 =?us-ascii?Q?hJ+PWQfWi0UAfhEnEgpIlc8AUN44fiBVh2ZmOBxT6AkW67ti9ItBgwjPqyuY?=
 =?us-ascii?Q?bEYKJL527uPQ+JJqCgHUvYeRfbVhg9/CRHi9Y6ecYTQ6ld3yBJSaGEGsu3WI?=
 =?us-ascii?Q?2pDF7UnGrK1cNtGCq4dNh2bljdS5zXoLZx1HhSX1/Mkca8Agy95dVPuoaMZH?=
 =?us-ascii?Q?c0SSlALDnUVQf7DNVupgAZOBGmnu35Q8/hkMNZTSQFIJlfzT7v5+vFvMm7rY?=
 =?us-ascii?Q?Eu9XLPZVk0KUIx4YpnFXezwpiUxYF1S56JDhEVTJTAGVNVFPlNX9hKGXP65V?=
 =?us-ascii?Q?xYu/GVNeAGcCDSCPXI4LmhrGvqO05UmSIvMGVflCe30lE7BUnGUVupo8v/PG?=
 =?us-ascii?Q?iMJmfFsFnpXfdJN7knTb4Xb1Rkp9WwTfWMFQPNqavfYwn5alpuAL1app40iA?=
 =?us-ascii?Q?M3WF7VddW8e5dlHqLLyX+CKzXNuVfw5+ETgsjBkRU0Td9HloXBTgybe++zXm?=
 =?us-ascii?Q?/PsC0b6oEqVEd5ZzpVAQnsD3kh0WEYED+L0U0wL1Bqa05ZzrVpw0S/Krvoxz?=
 =?us-ascii?Q?U8NMXXN+ZxCqQFALH/NvvqlyDqcSeqqg7Ef0seQjN0m7RLC9fvWhj2NgoJgF?=
 =?us-ascii?Q?W0Tp4ZRyWEjVq2E5YYARU5AXl0cewJsu0AC9EYwT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055c265f-df41-474b-4b00-08dbfc1f0be8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 21:04:07.6564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Pq9SsLPaZRhMCElK7SmURCikwblmk0sCBk9iU93eNvoOWMCtpdDlhLN80lIXX5uDqCUudUtZenCd21jZDn7EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7851
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> My reading is that this patch reverses the usage of module and regaddr.
> F.e. the following hunk:
>=20
> @@ -553,11 +554,11 @@ static int _sync_pll_output(struct idtcm *idtcm,
> 	val =3D SYNCTRL1_MASTER_SYNC_RST;
>=20
> 	/* Place master sync in reset */
> 	err =3D idtcm_write(idtcm, 0, sync_ctrl1, &val, sizeof(val));
> 	err =3D idtcm_write(idtcm, sync_ctrl1, 0, &val, sizeof(val));
> 	if (err)
> 		return err;
>=20
> 	err =3D idtcm_write(idtcm, 0, sync_ctrl0, &sync_src, sizeof(sync_src));
> 	err =3D idtcm_write(idtcm, sync_ctrl0, 0, &sync_src, sizeof(sync_src));
> 	if (err)
> 		return err;
>=20
> If that is really intended I think it needs to be explained, or possibly =
a
> separate patch.

Hi Simon

sync_ctrl0/1 was meant to be a module and it was in a wrong place. And this=
 patch is just correcting it.
