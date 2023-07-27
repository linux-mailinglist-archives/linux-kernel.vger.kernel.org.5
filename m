Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89042764582
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjG0FdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjG0FdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:33:12 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745AC2D68;
        Wed, 26 Jul 2023 22:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnqGqPUPvTgmQrKV47ZgeKnp250ZBt5grCZf57UTG8lWZX27OFifZ068wFqL0wMaXEiW6dVNO6LubBXp9AebFnLcs0cBmK4+Nqs/iIgs1CXBj11SrldOmKePhoTG9YOGh0MF8DOgQBxoOXSSM5RZjVC7gnZPWcmQUcLnHM2A1ZpCieklFeN7bffkY3x7271Ux0HWAQm7tYWSzV72S67Rq/jBBJCOtosjSyWsIW3NzJuPqlvpOZuZEtyoD6aT/5RwneMwg5RVucPGgb/BjnfNthrxzbL20M0ruur7CP2yKNcbTGnzhapTDBrdYQyXP9JsPY5hjlWHYD/2YalCRgI2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYwyd2JlW9YUGACCKH3OOGy+8vBeEUAEJD4RL+rZ0AA=;
 b=lk44+ZWBvT7ylpf4QQzPeM+0Yq8Tvb540Aibmz92OFuoSl0M3F9SDCaJwyhzYdFQPfNKaM9LFy59rQeo7kPgAufYiz0yOMtNNZ+6hHRYEI9uiZ3Szg/hllZpQsPDuEvtcIMUesg1v2Km61UhLzF5byXzwj7vkEhSYwPho0e4cG2aMAELQWN/HnXun4CrUCc7C8IqE6m0uxrop+/ZGLa+RMsGvqjpq0Oq+iazBzST4vNusXu0yEKL3iPbw3Ln/P8Yr4En2IxiJxu2MeUhLqZCq11UT52K6O5K92RX8lZDfRHKSal0k5WPzPO/L9/ccuVqAVGWFPdmcjweVkoMUpCI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYwyd2JlW9YUGACCKH3OOGy+8vBeEUAEJD4RL+rZ0AA=;
 b=lPFL6deq7c9mgwPXBDNXcHxgrY4WH4PXSUXQMCaxA3B+CCvNnaJFnhcn4XZJ3Sb/tk1ktSpTAlbk9LjKd1D4BYT6U6FR5Ro/f5mYuOwkgP/40AnVYPN2lBij6jOppAXSEPsCnceM3uS1XlTFH+nLeVv4Ghf5aa/uEE38qQZLgfo=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by PA4PR04MB7823.eurprd04.prod.outlook.com (2603:10a6:102:c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 05:32:51 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 05:32:51 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Alexander Duyck <alexander.duyck@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] net: fec: tx processing does not call XDP APIs if
 budget is 0
Thread-Topic: [PATCH net] net: fec: tx processing does not call XDP APIs if
 budget is 0
Thread-Index: AQHZvsxwawoZvXvGy0ONq5DghKmkjq/KsvwAgACtTTCAANTXgIAAoH7ggAAujgCAABV/0A==
Date:   Thu, 27 Jul 2023 05:32:51 +0000
Message-ID: <AM5PR04MB313925B5EF7F4A1ABFBFFB5A8801A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230725074148.2936402-1-wei.fang@nxp.com>
        <70b71e7bb8a7dff2dacab99b0746e7bf2bee9344.camel@gmail.com>
        <AM5PR04MB31390FCD7DB9F905FCB599108800A@AM5PR04MB3139.eurprd04.prod.outlook.com>
        <CAKgT0Ufo8exTv1783Ud7EUg_1ei90Eb4ZoiHFd49zAbfhLgAsQ@mail.gmail.com>
        <AM5PR04MB3139FC9C3FED1759E1160EAE8801A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230726211450.209efe35@kernel.org>
In-Reply-To: <20230726211450.209efe35@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|PA4PR04MB7823:EE_
x-ms-office365-filtering-correlation-id: 8f2b3a39-638e-4623-a9a2-08db8e62ebab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hsz7ivuqDPrwsUq17QFY70vki0owINn++4z8jcqHc51vseWfEB6qmyLiGT/1p+BR04d9Depj4sM6ZtnkABABoSnXqEk6raac1CrfhgkE9VdmV9qoUO/IuVg3EQ9+q0sAop3YUGT8JUFLhTE+JuWko42rHA8gN0KzKZHbHoaNejOJ+r1iv0M/4v82PtykZrQpMcesn9bXeQOoR8Cg5qGDSYT7yD36RHJFOeIa/X57ItKLPjXmlzE435Jc+InD2rskrdL7y+1r9/q/mj10He2xmk2P6CZ1RKvxEvuYvCF6eCxaHKHlTrdX7i3+KGqCjV4SQCJnsMvhI3nyIMgbWhj1zXUEkufmLE7G56HhabC3/TUTvEG3laQMuiZSmaaVSM9eEzaZ9FCfDHYl+uoiMiILIX7y3WJpD+7NYJxufFybW83JcOncVSzbpdfE/j286e0+hQrDXBy8HpwAXbd3Vl5Fhl6Qks5xGkkZlSzWxq2JCPbxmvXqTGKAxisAA83Hy2puCXCCRXzhFTpDzbAZFsD7nVEZlsCAQNZwZ/o4iuavu+cJaXYjiuXnuoK3Pezju9rmB4ye7ZXIyWls1wx2n96ytArfqQSX4DYAkUT/F0UrZ4L6X99yKeW80XwdLmVf1CQZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(86362001)(186003)(6506007)(26005)(76116006)(38070700005)(6916009)(4326008)(66946007)(44832011)(66476007)(64756008)(66446008)(66556008)(33656002)(9686003)(83380400001)(2906002)(7696005)(122000001)(66899021)(478600001)(54906003)(71200400001)(41300700001)(38100700002)(55016003)(316002)(52536014)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+lpNEiftRXqbWID0Kale0kkOYpeTKjUA0UeGi+qjEvJPCkcsIHBsqjK7XyII?=
 =?us-ascii?Q?O+AEQtjOHS4iHWYpCtUbhhL4XPdK/YjnRZcRaniWZk4UwWr3YxyhkaIu/YUC?=
 =?us-ascii?Q?K8GQCzBRlBPfoG79ylbcww0X9EDeugPQK7E1V55FXlldrlxHPCa1CVx6FzqD?=
 =?us-ascii?Q?15nxaoy/ka48YA+h5M1fJ55zURtS4O5xbZ3Mx/xv01rUkSS9IHfWS/co7rpY?=
 =?us-ascii?Q?iGYN3k3eOhketAJAlozXQQXTMlFg3/GZTbfw+v9CLaeYg4peXGP5YpUXXwvg?=
 =?us-ascii?Q?gvhE6QboS0h2TgXZDwFTds6QInOCJKMF7OK9OcvqYUmhHqK8hcID4TJMRhqJ?=
 =?us-ascii?Q?fxUBy/M23iVJ0ejMZq6S0zx2Tk+Pmi5YOLoJmRwNzAyZjN+Cuz+CUv4YbBJf?=
 =?us-ascii?Q?bmvdOAXomlWhQnRRFqTwnxySH/naLrClQ/KU6cdk1bQoGLquwLdQuXxLEUqB?=
 =?us-ascii?Q?vX/e78x5qmG/tKbaqSz0ywT/4ZfS7C3HTYsFmQc7Zz2p03p/Ph0bQtwRItZJ?=
 =?us-ascii?Q?V4xbh4V7kSC59cElFxGiIv/Av5JvEZ/wS86X9Xa2alcG370yZnyLL5jcz5P7?=
 =?us-ascii?Q?06KCotcONLZNIrAYi4q7V8gypL383A5DNAkiQSJq+jM3M5UUy9sCkNLOby2o?=
 =?us-ascii?Q?iPq1GeWpt233MhE/PSAFLKykFTvtPdIiDJfWoc9qbaYYFn8lrghUjt0lUyzQ?=
 =?us-ascii?Q?SVY0jSkr+4JFT8JFAhJ0ozFYSoe+JZV6eX39u5k6DgzEDSaA/9K9kewmP0Kr?=
 =?us-ascii?Q?1QllB3j9dYPap+sBlzlP6N8LaeiJJbNXdvkL2Cejtdfp+3WdwlVZlLRdQwDE?=
 =?us-ascii?Q?YDVPrdffEmS9EFobZvb2+JYESPqLAiO0bSbHoviGW3rwNG0EDc/eKgJ+4EmP?=
 =?us-ascii?Q?4elO7niLWmwpFVGxHclJeORpXe6r8P25BmahIg/4/5ys3Q/67QniuZtiYZTY?=
 =?us-ascii?Q?TE/3S7+1td+889pCkxsEiEVjZZ4N6j1mwbC4IjCZkdrUnZSIXBW25En22tZ8?=
 =?us-ascii?Q?0ZrdFcxxBAC5/Aa+iyzeJA/0nv3bEbcBcychiaONsBmbKjROyn+W4wKETdZA?=
 =?us-ascii?Q?+5ehVRiKhV1OWQkcnxqoPgy5z/xhaOusd9dvP+lQ4Ebif8aWpRjnx2qXDUhq?=
 =?us-ascii?Q?3p+ejcg3ICfzcqvJtpeDn8esqfeMiZDHu1ox1OmkZn+AJLi042OsjE4gXpd/?=
 =?us-ascii?Q?/P8CLxPmRRPk87+Lpyl4IfKuHDnMnx+0y+NRNWAMn4qJ4rZjsiaBeP+uwf1h?=
 =?us-ascii?Q?HqDd/YEddMrPtozzh+ZegSrXBU6Jla67pfkBggz8YsVxRxZcmndEmAx/q2aa?=
 =?us-ascii?Q?4P/I9MjFjcEaZ5bD4luBVyZ4o1mnHXpXc3k5xp/5PC0AE3TGq2LNQJnJaoW8?=
 =?us-ascii?Q?cDYX4yljhlsYp/jGYq8HIQef4KyBaKbildnjqPOLujkcjqwMGyUOIUJALWfT?=
 =?us-ascii?Q?hySWSHbBrSZypgwcrYoc/zdKAsynoty0XVEtDtUiMKWy8W4FlkZ1pehhhfb/?=
 =?us-ascii?Q?hRPX07Z1nu/UoUYg3LlhktQTprKfLWLKV2ucrnTIuwrattg/byhavt27ra6S?=
 =?us-ascii?Q?7KET99dDEpeMyQAWvvQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2b3a39-638e-4623-a9a2-08db8e62ebab
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 05:32:51.4378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jKS6dPm4xMbT+eBWLRoYwdpQmjsGLtDUW8V7FEw83v1RbvWMNxwFUuzMAPWgjVkxAULl/qUG2HjRjJTQGOn5VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7823
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 27 Jul 2023 02:08:32 +0000 Wei Fang wrote:
> > > Actually after talking with Jakub a bit more there is an issue here,
> > > but not freeing the frames isn't the solution. We likely need to
> > > just fix the page pool code so that it doesn't attempt to recycle
> > > the frames if operating in IRQ context.
> > >
> > > The way this is dealt with for skbs is that we queue skbs if we are
> > > in IRQ context so that it can be deferred to be freed by the
> > > net_tx_action. We likely need to look at doing something similar for
> > > page_pool pages or XDP frames.
> > >
> > After reading your discussion with Jakub, I understand this issue a bit=
 more.
> > But we are not sure when this issue will be fixed in page pool,
> > currently we can only tolerate a delay in sending of a netpoll
> > message. So I think this patch is necessary, and I will refine it in
> > the future when the page pool has fixed the issue. In addition, as you
> > mentioned before, napi_consume_skb should be used to instead of
> dev_kfree_skb_any, so I will improve this patch in version 2.
>=20
> I think so too, since the patch can only help, you already wrote it and i=
t won't
> be extra backporting work since the code is only present in
> 6.5 - I think it's worth applying. And we can refine things as page pool
> limitations get listed (the napi_consume_skb() is net-next material, anyw=
ay).
Okay, thank you. :)
