Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8BF7BE4C1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376741AbjJIPaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376641AbjJIPaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:30:12 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2137.outbound.protection.outlook.com [40.107.114.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A85B7;
        Mon,  9 Oct 2023 08:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzrQ8fTBWuQMnlGlO1DJchymQMPZvEaxTQo2yaX532EGMobIvU12G691exvk3NLnmAEq8X2mYQURDgrVOZcghsh1CuA2Z5e8mQpxwE7RoI/IdKiTuhjjz/f+QAy8lxkSAf6Ujb/CYJUVIz8ZYuaiO75rJJIySOXmbD0gWFbv9YsoL4lmSiO5GKM82jO6jl44YcyIL3FxuzORzKAKKu/bnrU0hyM80TdkjxQgYgjJ4CXlmacAIMVliU+u/k3438KeGXBKlJvnGIHhjsn5BEl526kwI9e0fUuUA4aDmyBFy7LskDNC+1bEFO/eVpMvFqpiYG29DR+n83EyRdpFHbhrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xCzP4DEqyxSlMWP1lEQwfc6RM4i5qeFlMf6+kmpXNI=;
 b=Jjg+amQs1QC2TswPSZooQn4TVL+gvA4TuOHHwjXu1q+B6X1qK+JWWoKUmvf/MlsSZ+LFSldzoObCbX2rrSKG84PUgkTlX+cjKWA52E6fdOZRqCk45SYQRqpRzjtwAdYdUdp7n/kWlqhGnVjXe/TcYq2WkdIe4xIzwNrvSp4za7Kx8oBe2qm9D97PbpBoCkM8lgmOV9yziwQyHytny14aZBuc//wF+2stfMxx9rDR4M2BR9tuNJ0uq1rtyDDBQCR2AWcMm2k946FGakuWT83l55A/7ybgdtoom/MY3KXgwl0MuV6g5sXWB+y9h1TmjyxUiYos3muoBYUtjjxvWYAHeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xCzP4DEqyxSlMWP1lEQwfc6RM4i5qeFlMf6+kmpXNI=;
 b=UXdaw5yBGbOoSO1wrg1LkEuYCwUTTNoJr5kMmHi5j2g+xICM+g13YX8HTlJ2ipIwC3FLylrUrsuuUEnDbwzV9cNUOmZz38yXJpoo/0vml9H8ohqnS0ibitYPZqo4WsaAqxGd+hcerAAgyxJa7179/V/Kh5GsdDTcby+L3I/G65c=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYCPR01MB5935.jpnprd01.prod.outlook.com
 (2603:1096:400:41::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 15:30:07 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::db75:e192:bbfa:78a2]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::db75:e192:bbfa:78a2%3]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 15:30:05 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] alarmtimer: Fix rebind failure
Thread-Topic: [PATCH v2] alarmtimer: Fix rebind failure
Thread-Index: AQHZ7SyA4lmrPv0tQ0OIkUBZ8XwsyrBBqzEAgAAC0jA=
Date:   Mon, 9 Oct 2023 15:30:04 +0000
Message-ID: <TYCPR01MB112697A5D4B57101CDE27C88D86CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20230922081208.26334-1-biju.das.jz@bp.renesas.com>
 <87il7fq1al.ffs@tglx>
In-Reply-To: <87il7fq1al.ffs@tglx>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYCPR01MB5935:EE_
x-ms-office365-filtering-correlation-id: 6cd84f4b-b65a-4554-da71-08dbc8dc9caf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fF5QfKOteL0YVeNP7UcRnbR+QBmrA2SmMunDTevZ9+cTtDihGzK9YXjqzOipQdtmQQg4IJ/JE/T3NEtGr3JI3dN80Q+jvXz5hRlBxoNBcARwCdUrUSOFgKF3jE6KLp7HFWcBwtYxyUpu1ajyLl80V92UyJDI/jAiVghVN2GSZi6+S0X7xYyNcFCB+9eqV1UBD4zckYu7kg8w+9uQvg+2pD6ThZ0dbXPwqhXoEQQB+wt4F6848EPL11O+gq9+IvDxAe4tsw3xFQYWCslaCS+KwKlD/s/lQ77ebwJg51wi4WpRiAIcb97y86B/6FOnRASBZFr5uvY6Tum5F9RALNWMOWFUp3gkMOx037HUUyJVfs1eP5mzUSpM1t4EyTXGhLgTqvhT2J7THUPaWozrhbJKGErzxF0eKau/+MUNtlrDzmDWeyDB95QcwBqsfx/b+YGSwA7MFMAEiglBPVvM7eWb3f3n0dVcLQB30c2VKK1vtO3Q9/6YZhOTCphqOMVtnwMPgzDUaiuJ/wLpRJnU22Qqkud29TZnIkZBST4qn3GCLw5UZqxOHUg8o9FzjUemT2KY9rIGhkVgX5XCNyZP+5W2rKO53A1kTc6dVG3cJvmEzxo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(71200400001)(52536014)(26005)(110136005)(54906003)(64756008)(316002)(966005)(7696005)(6506007)(9686003)(66946007)(76116006)(66446008)(66556008)(66476007)(478600001)(55016003)(83380400001)(41300700001)(5660300002)(4744005)(2906002)(7416002)(38100700002)(86362001)(38070700005)(8676002)(8936002)(4326008)(122000001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QS6Mbx/Qsq5jAfLCttPxfyNHAilRZ6/3hOFkrgNvc7Yj6yuhXMxHWiVopqC7?=
 =?us-ascii?Q?kpK8aoqFahWCGlBqlCsxQ7rcXy3Q+bDpuSLUP6fW3c+iniKZOf+XUbbkgnTB?=
 =?us-ascii?Q?cRBHaIPr7ALKlwMzED4SPjXuRbkOxlKOh1EsJ486VpAxtD6yp30FQtbbbSml?=
 =?us-ascii?Q?G3DhxBY/BBF8usdmGMtbZWmCV2kprZNgpWoA3rhoXg6c/vOTtY/eZ09+e2bw?=
 =?us-ascii?Q?LMDR/u/QjnJZbLtE7YL8eL85Y+hk6MprEf68eZVPApybyihUvEMq5Di1YFFC?=
 =?us-ascii?Q?diWaicd0H3aYk/+JXgq88PrPIb21ZT4lV441Io7iugk7dG0p62qqpECGzqV6?=
 =?us-ascii?Q?YAGLL6uw7XOlxO4ccPeeMDrnnWpENNGZwCWm80VC4JgEV8m4pYpAEPNDPxBf?=
 =?us-ascii?Q?EM8vBq0vMKTiO2TvJdCuQK277SF2SWJxzOujaA7HkH6gdqwLv21R7OpHsGc4?=
 =?us-ascii?Q?al/KRhQlImAP9CmlVvL0HaYnK32D7nYU6Gbla0lTUHa7GVODG3+0oQr3YIgZ?=
 =?us-ascii?Q?2kggI5u4Os3XdmwAQs2kX1Wj8pxLug24/gYudSwjSFyx0hdwep7IHUfpqEB9?=
 =?us-ascii?Q?7HVufkfvIS8Qb+zYIkj1xhfZNTNfZwGEfnb0k9akBptSxa25RtN04+bvqaQ3?=
 =?us-ascii?Q?Cw27l1SoYyXECvjiH2Q0GWVLwWID0JSnW9r1ZlF1GURoBtddb8HQ47pX3RQG?=
 =?us-ascii?Q?qOerwOlWsz9GKDlA/QKA3DfwifoKSN2VNGwB6u0OrRBBFBc/t6eeElT9ib96?=
 =?us-ascii?Q?+RXNHlm7oAcPiE57/8+5JKOm7P/+T9jqFmxl8C1UH7EeWTk7mkT4L7w4grZd?=
 =?us-ascii?Q?6hhNHLWzsCt7xJnb0V6+7elf2d9EGeUlGs52sDZglmB2r9Qhe2q2WkpaWqP5?=
 =?us-ascii?Q?GbCkl13TXskWv8MpKYjY/rSi02ccvmH9zCOFiTXtLeyJD7+j5m8yB84jOA+Z?=
 =?us-ascii?Q?XAUWfqbmT+N42kMMD8fqjB2rqtXHUGj/gaoPCcrzsozJ0cBgt+BoMf5VE8Ud?=
 =?us-ascii?Q?hw14teIb3Us5hMVb23DtzD4t1t2igL2ETwCJDyCaXfX81znSo9eX66uZmNku?=
 =?us-ascii?Q?6c06SlT9GUzZEcPiJUNTBZ9VNa2t0Elf0tmZz8dYhp4ku8UPHPmSopUS1BX9?=
 =?us-ascii?Q?m9UtI2ZA6c+Kal9MTuIiTP6t7i4MI69K+QMcI+R7hiIeyCvkDqkTuzH5Rl1W?=
 =?us-ascii?Q?j0BJqEVTnbsbCnkcPmkjhgD3rxYLvQdkdkfIjxR5WxeAI3npwlR+ZVBb7HZe?=
 =?us-ascii?Q?ezH/O5XuGukBH6I+Y7diGRHxhBC03ow2gkSPUCbWhrCN5A9W5Ykbys7tQsis?=
 =?us-ascii?Q?+5LcR3j8ZstYot8T7mXJoZrnVcfLsztsRheNFsPgw1+iNq7VGy336VC3UjDy?=
 =?us-ascii?Q?uVriY4Z9Vfp4q95me8mfhT3GwmxGXywbh/zitjCXF6IDpgExt5/9V4hPoWlJ?=
 =?us-ascii?Q?Ce3p0CUucnt+WMiVn/uPiIhI/13eayuUa79go+4WLGdKEO9OqhSMK7E30zEy?=
 =?us-ascii?Q?GhchFB+xxbjX3bi62LLfRbXnmXxQTiF2IAROHbZAei92AJbaWwRF3Mwttnko?=
 =?us-ascii?Q?RBDR5V6mijAqWfYJC89mbaZz4tTxRpCGtzTDz9tlJWnSqS01sdwbK2a2JEnq?=
 =?us-ascii?Q?hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd84f4b-b65a-4554-da71-08dbc8dc9caf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 15:30:04.9727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xuTpYhGPz+AgDwp5ETiKz7MnE3DYsi3nhoXC39vuvc2doQHD69nl5HBlaTbsByA+VbH9fY4ZsX+n/MlFtUG8Se+zRcDgYY3SfEEOudeHejk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5935
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas Gleixner,

> Subject: Re: [PATCH v2] alarmtimer: Fix rebind failure
>=20
> On Fri, Sep 22 2023 at 09:12, Biju Das wrote:
> > +static void alarmtimer_rtc_remove_device(struct device *dev) {
> > +	struct rtc_device *rtc =3D to_rtc_device(dev);
> > +
> > +	if (rtcdev =3D=3D rtc) {
> > +		module_put(rtc->owner);
> > +		if (device_may_wakeup(rtc->dev.parent))
> > +			device_init_wakeup(&alarmtimer_pdev->dev, false);
> > +
> > +		platform_device_unregister(alarmtimer_pdev);
> > +		put_device(dev);
> > +		alarmtimer_pdev =3D NULL;
> > +		rtcdev =3D NULL;
> > +	}
>=20
> That's broken versus alarmtimer_get_rtcdev() and any user of it.

You mean we should update[1] (charger-manager driver)as it is the one using=
 alarmtimer_get_rtcdev()??

[1] https://elixir.bootlin.com/linux/v6.6-rc5/source/drivers/power/supply/c=
harger-manager.c#L1447

Cheers,
Biju
