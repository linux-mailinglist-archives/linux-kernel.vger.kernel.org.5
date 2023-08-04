Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93190770415
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjHDPKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjHDPJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:09:55 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F324C05;
        Fri,  4 Aug 2023 08:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6ul/sbE9l4Zl7OpCJPpZQHpRrD066c1giEoumNYCYjk0Fr1wAa/YkQWTfUZSOWmE088QxmINlVfJOLak+JBP57S7q/VGNorXZhs+hfthwyGCvFkL4eXncUJlhXg1xEkyUeGLyY7VjBZVdwXse9vVbRNK6a78NXuvB6wsncD49kMxGeY8JbH8ZQ858iNN/xrgaDfRz60yF2529B85Per4RXiNfR8xtnbT+T+lxDjhsVS9gejOrJTO+HTshKPvCZ7RovJscgaNbsKXCgNWYyKgZR0RpV9YMhAZyyUZjj5CJRg0H8ZjvWO1a5FCPbJ2KyB6YLnrxi+EkAPOfaEjFMeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J76+y6Nww2N39iFBmfZQ7ChqR5jp/K3julaLCHkHVqE=;
 b=mnhTyL/vdxV2oWMyh+YjklalcF+eBpLE/SSXmIhPwTK7azfT6QCTZcjVeNFmur+HLMZpmkTCVRWPRRjJv9irFCBFw7q3w6kvKzeJI9ZC/O5a6taI71pBzg9MZP14M/0PgxtDXYncoT+xqxe8gh1DbOLLbFw2/PLrQzUeqfnx0ApSbIaDN3He6GLfsHEF0VKZU7Qh8540zjfoWZVsCYHJpH5/NsZro0I0f08INaX6p0Jw+sSed6D3PWlU2zpRR73TUpo/HyjvYj1o1ietL3+mW5azVZbFcIL/bq4eot5WfCCCLGM/rTzw+AVtLQKgRA91daxSiLVq2CvfslWkp/MRkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J76+y6Nww2N39iFBmfZQ7ChqR5jp/K3julaLCHkHVqE=;
 b=VLk8C42mOoDjhzKI6v28+AhMFFIhs5VmvwWcCVofg6554N2NG0BAXeFc3KCA6C8Jc9vINxQZIlXJnuuQetmz8vH7szTzVQqWN5HKUs9nWpMrw8ZupiodoPyDIya57NicW+rPQexZozY9Eekx992TCx3rdT2yLpiynTrqUudz4RQ=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM8PR04MB7763.eurprd04.prod.outlook.com (2603:10a6:20b:246::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 15:08:57 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 15:08:56 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Russell King <linux@armlinux.org.uk>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Simon Horman <simon.horman@corigine.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Wong Vee Khee <veekhee@apple.com>,
        Revanth Kumar Uppala <ruppala@nvidia.com>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Frank Li <frank.li@nxp.com>
Subject: RE: [EXT] Re: [PATCH v4 net-next 2/2] net: stmmac: dwmac-imx: pause
 the TXC clock in fixed-link
Thread-Topic: [EXT] Re: [PATCH v4 net-next 2/2] net: stmmac: dwmac-imx: pause
 the TXC clock in fixed-link
Thread-Index: AQHZxuKiZUs/AXOMS0qXmBpSCSPAEK/aOeGAgAACu7A=
Date:   Fri, 4 Aug 2023 15:08:56 +0000
Message-ID: <PAXPR04MB9185B0397B5C9C37F99CBF518909A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230804144629.358455-1-shenwei.wang@nxp.com>
 <20230804144629.358455-3-shenwei.wang@nxp.com>
 <ZM0Rk4paok5cAvp5@shell.armlinux.org.uk>
In-Reply-To: <ZM0Rk4paok5cAvp5@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AM8PR04MB7763:EE_
x-ms-office365-filtering-correlation-id: 4a4976ec-10ef-4058-f7f1-08db94fcb994
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TrwhU/m2Q1LWPrKGLZveoT90rRYce0C+b83jiDux+HU/3M9Q5ZlR1AnDp5nTGC7/wJUB40YqUv5576lbzwJsWjG491s3QkMQYZCjOeuTC5gavy+IJqnWDpPe0Ye8S5as8nkXpfQjHHX87MgKZSF1KcNFNLxDXwZzlGdMfqpGhPu29L/Wn2jmMYZoiJBaMj9Qotsn6F0HwnkdWTNc1ToXCOdu/l7U3qqKSjtd/3FMiJ+0N6xyqH7ZOFSxscKR3H5XsmIKNgluGBRZPy/CTruCKSFeX6V8IKZRjhBFO2EdVvDevOvR5a7HFHVxadFpI+dN74HvB0A25RKelpXYtuqaD/olr5cQsFivOWfZYQuKbFp5ew3hptrqcQhf4Nc3fjkJhWxvBJS/eaH8dK/xcUGXbsLM7VeaBSHUZREBjjDu2sZDsuvkwIvXZKfTFdZQ2s+TfCq2AOGrvDIxGj7i6hh+L25V11SRI8R2TRtQXpidaOsQsm5O8cdqw/FKcLBZwamO/i6MTl3hMQW0lGpfK+v3nuNYxUm24aA9+2b5qlfFfphSMuuX1r5YrXGNm9QW1qnZipPDYRGihpTYf/e/0HuXoD7FYLAI84BH+I043ZK2NGI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(1800799003)(186006)(451199021)(8936002)(8676002)(4744005)(26005)(45080400002)(478600001)(55016003)(966005)(86362001)(9686003)(7696005)(33656002)(71200400001)(316002)(41300700001)(5660300002)(64756008)(4326008)(66476007)(66556008)(66446008)(66946007)(6916009)(44832011)(52536014)(83380400001)(7416002)(7406005)(54906003)(2906002)(76116006)(6506007)(122000001)(38100700002)(55236004)(53546011)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LOtBrqsJSdLPY7vQJuzTmm2Ii/SaQPltCVsxCDYLIxVICUJZxla6n7sVt/ms?=
 =?us-ascii?Q?z6HDos4NZRqFoKVyLGh6P8MPl8W/By9ku3N2+y2jO5fTGzl+AjqikjmawfHA?=
 =?us-ascii?Q?OTVBdIaaNFnbWKcWgk3OypTcwkkoti5hQaxd57jNlMzbhE+++gMx+w2g82lr?=
 =?us-ascii?Q?ObTpWfB9eryr+2Q1qAcfNQTvOV5qAFl3SRVzqiymtwAsN6fO9SRa36IBu0eS?=
 =?us-ascii?Q?fY9M7D93x+6/49MKSvZJVAETeZFngZEib7v94XGwy+wfrMMicsq/x0PVT8MV?=
 =?us-ascii?Q?Iwfn5d8WvmpVwtDPBC+Kl6xIWF/fDJHQ0xsbv/1EMzlyh9SG4DxY2vi7xcJg?=
 =?us-ascii?Q?V9ysaszn7gVuZHKgqZ3RlL4MObjR90gxjF8FJVy9nYnxvRrtL9vCaI2jz/Rp?=
 =?us-ascii?Q?UcRkXysQfLcafs0MZ2tPlWh47gqtglDSwODHgKsS42myfISsqu4qwDbLnh9T?=
 =?us-ascii?Q?bAqu2KUx9bZkCfNS2t5hLwLRT1n3oLttbDvr0ZSSGbNRIDc6v8meLkSnOEY4?=
 =?us-ascii?Q?A2yOxhd9aEGjDKbJ54aSuuIq3T/Pyo6W4YwwTSZf1tQv0pCRXxIbnyIwlNUC?=
 =?us-ascii?Q?T5+oWWHBbjtCqEP2Ti4JvEmKk/9tTwfkuXk2ared9zzjVLrppFueaQ/IRPyR?=
 =?us-ascii?Q?38dxiEqDPkWS8t0ZEfZpm5kqpC8DSYZOVaM8WG3TORWgeFUKTx/zJKcFRUPN?=
 =?us-ascii?Q?kZ1A+O+I7JRnTVADkOE/XiMdXOgMqu9AhpEtYJ4hYeBDNi6HGMFHN3/L0zxp?=
 =?us-ascii?Q?AYiwiHU1VEERdMH2MjfTr97NINQJ2yw6zOqVTzh+Qbh05GiBCMBsgticUHYi?=
 =?us-ascii?Q?TCS7nQLsJw+kGFj882vk7S+Ai34sjADZ7395mPHZ2VZhIFqve5+z0v94Iw5W?=
 =?us-ascii?Q?vbIc6OTYTSiLhgXrix9QQnFnQV6mWa/pOd6psaj5Y3aEDuCe5rkvV98gb4K6?=
 =?us-ascii?Q?cycuBgSulAEcHpFvxPNjlLMPm/StwD7uinrLlU9Lcwlwc12SIDN4e6Tx6SQe?=
 =?us-ascii?Q?NjmT3VHrXXy71lk/9Y8wQ4uizP3ObGfEUJsJgTUxnFfBMtbfPyKnzVaqplzp?=
 =?us-ascii?Q?yj1eFqjZEAtu3tvXD6oZY+mw6uMSGw9fDc3E3CSkMG0znx9rBIZp3s2ZeWJ1?=
 =?us-ascii?Q?uuilSShgSYcUYwTRRPBbi+tIKPZ9+1q3ZVqwZufih6ndhnZBJtcLev2rHuNW?=
 =?us-ascii?Q?DQ42yZUmDQbAcBFzWgYDpBU3BLbl0xgozQoa0JFyMeJ358hzd7xpsYktnKlQ?=
 =?us-ascii?Q?Syzkrii2tybo16Rzoen4yVaPNTgvh8B1STF3XdopwJ5ciWtO5w6u0c31ENIU?=
 =?us-ascii?Q?2Im3n138uZ0O9vnEhoiX5XfHPQjN3de9KcTzD3mtxv5WPDtpcx7b9HecYv38?=
 =?us-ascii?Q?1gIu2teoi4OPgPJVTu9TC8isHmM/DgRMusi1hTWA8zeo2AWgc3X/j/aO23y1?=
 =?us-ascii?Q?C/Y29qsxuTKGrs/AcuQnI2GZ7IKi2Ifm8KHgtA+7phs8YqdFEDkHkiRuQMZm?=
 =?us-ascii?Q?G+9p4LgzNzDHUia68SkiJPJOaJ2ioQDy23YE46SHEsXFO4Iaxn1+dpqDhTxK?=
 =?us-ascii?Q?81lSasndv0nlfRuFjmFLT+TwAEiJIWHY3mKOrlDv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4976ec-10ef-4058-f7f1-08db94fcb994
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 15:08:56.9141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qciY6Um68e0zZJwucHKU11q8ox/WdHXW4t0uKdn5rYgbTJLgXneKccbSNS3yP6g8zqZgZlqQYfOuRQQRmn9WUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7763
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Friday, August 4, 2023 9:56 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> On Fri, Aug 04, 2023 at 09:46:29AM -0500, Shenwei Wang wrote:
> > +     if (dwmac->ops->fix_soc_reset)
> > +             plat_dat->fix_mac_speed =3D dwmac->ops->fix_mac_speed;
>
> The if() condition looks like a typo to me.
>

My bad. Thank you very much for pointing that out!

Thanks,
Shenwei

> --
> RMK's Patch system:
> https://www.ar/
> mlinux.org.uk%2Fdeveloper%2Fpatches%2F&data=3D05%7C01%7Cshenwei.wang
> %40nxp.com%7C893e89bfb80c46549b3c08db94fafd80%7C686ea1d3bc2b4c6fa
> 92cd99c5c301635%7C0%7C0%7C638267577931730269%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C3000%7C%7C%7C&sdata=3DxR58pNE5yNXCj6Fl8aWS1an5wgdDI%2F
> k1mv%2Fw%2BnLBhl0%3D&reserved=3D0
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
