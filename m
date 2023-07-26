Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9CA762963
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjGZDlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGZDlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:41:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B018F268E;
        Tue, 25 Jul 2023 20:40:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuNkBCkowKUbCaxIPPqPhp7NY/bL7PC472w2v5i4LGO9eiwnEFyxsVziaP0i1g85pjaE1gZJkmu2A5xtHXUcepDRVbqG0VC0YGPBGc+I9imNDJBuq9hvaF3mSTJ00BI0aSg/bugc0rB0/jmDx0DEe5OA0QetKtpyo+1eci7wJTjxcjhKCgLDPl5R2XR6xwoqiWjQaiFwds4XHX/AQasUGo4C4u5q7C2yvB+6HGqJBI6VhMJZu6rwHKZtaZB/ehLwlFfnvGUXvx2UyQxJPGL5J61iuRdcYLan88wGxKhye79chIwXIDtsqtom1EM6GsDjRploxhhEa2c7udAclTKABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4/nqhh2aO1zlqEXQrnskCyqOOXhPFISL9EbNZa8tTQ=;
 b=banT6fejG5JRZdZDZkfGXxfPPfwJuBMNpvOkE+b3HEbyRmjTWk55VH6G4abmAENaxXi8Mq5BocHJLvVLYgBRt1ucCDwSVlEL082ZsrHsIm9N18fAvVNiVxPDvaipj7d+oxTSMwgl+gP7AYiJquHeE1i+Z/xvFvMaJ4BUH5KrQhcuUfrZUWjnneWjwLa3vxHraMIlbxaXHOEztuxSr9IU381KoQVU7cNl4RMZDe2QTKeWQ7kPThJ6OpjPR2LNeCtR7iOR9F/PERXp6y8PCdnBcOYMcIHC+o4pHfyVPqSAqHHiiwtojq3ctTB6A/JX3mUiO4Qdeyie3A3dDOz9GjIX9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4/nqhh2aO1zlqEXQrnskCyqOOXhPFISL9EbNZa8tTQ=;
 b=KQyqQRs36JV/K5qiGCoTsWcj65PbBNyIJRULXhWdvCaWs2a3cs6uuWjNbtnbAynDIl+Ps3td7F9OxawuuFch9yTIjioJpfTSmg0bcdTZKIUK050CJlJtw2Njyh9J/OzaGKSGw+SQKz5btHzdpzo2Hiuw3yF4WUXHwoNllQcgd9c=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DB9PR04MB9843.eurprd04.prod.outlook.com (2603:10a6:10:4c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 03:40:55 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 03:40:55 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     Alexander H Duyck <alexander.duyck@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] net: fec: tx processing does not call XDP APIs if
 budget is 0
Thread-Topic: [PATCH net] net: fec: tx processing does not call XDP APIs if
 budget is 0
Thread-Index: AQHZvsxwawoZvXvGy0ONq5DghKmkjq/KsvwAgACtTTA=
Date:   Wed, 26 Jul 2023 03:40:54 +0000
Message-ID: <AM5PR04MB31390FCD7DB9F905FCB599108800A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230725074148.2936402-1-wei.fang@nxp.com>
 <70b71e7bb8a7dff2dacab99b0746e7bf2bee9344.camel@gmail.com>
In-Reply-To: <70b71e7bb8a7dff2dacab99b0746e7bf2bee9344.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|DB9PR04MB9843:EE_
x-ms-office365-filtering-correlation-id: 674237d7-684a-4232-3f0a-08db8d8a1dd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PKsjWps7kSN454hzk6Pq0d6iXmJnKb6L9AwzAPTs+8bWD/aVrjG/0IzBJUVRb0Y8Obr/o2PEGXKnZssEILdSnpD1HN96v1KR6i3z4sP5JBDUOdSHTbF+MpOxmA7417NuxRthmI22Gg+cMuFelJwkV+WcP7TeYy6Jr/NbwYJzIPW51w5ARSLhRkqc6wxR9UxWHgoIcyj/3sKOZ3qT01sfVf64OMNGevvb3Xll0deWiLC624O4qiOjOfICgH10UZplyaS31yFQRYqGrtaVZ8bnhAWTApgFLmIoR8gDKB6+x+5MMXiCBCZOoHidSNU4FbhzBehNHFLA/vNDUobnxUiRR9k/VoYHMHnCm0fegI5+IqsMLmFYmsVgrCmIiam4StR/a5rZotr4K5OhayU+PEtJZCH/2ujsXATTAIhuJCZMFhVG2YiOaHzq0ydg5SdBcOL5hHWXPTxqEUBdhDurfbqCVUWvyQjgi2ZRaB/t+cEYWmLCY2SwTxUo5EbJuqmzBi0eP9hf15KZ9S2fAXaDDYuIRa1FhQtUYCy/wrJzwOhwMnlkQCezytcB129dpfNZsGQRT/v8PCll64yw7mSEiaLlB/evvV/cJUHQ4gh72HYrZqEIH8x1gZGvWlVioM8CCH5G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(71200400001)(7696005)(478600001)(83380400001)(6506007)(9686003)(26005)(6916009)(66446008)(4326008)(64756008)(66476007)(122000001)(54906003)(66946007)(66556008)(38100700002)(76116006)(186003)(5660300002)(52536014)(33656002)(41300700001)(44832011)(38070700005)(316002)(2906002)(8936002)(8676002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6XfGLqPrISQ/QSjP3S0Eoi3OxKpQOi6ww/9AdwKXG63xg0yY7jzM8SsOKchi?=
 =?us-ascii?Q?nf+LGu5pF0xKXSiyZzlFnE+x76F+8b6QKcJVLEJhJKC0lHseGJmIyBv+Cbgh?=
 =?us-ascii?Q?Ki3O9wTNUxozqxUPLCCMVjaP+43JK0YGW9Y1KJqE32Il8Dv4uBG+/db9R8pb?=
 =?us-ascii?Q?iI/oM0X29e1Q3qVhfYaXFr+z3bOjTxBwElSc56ddbziTSOMTdI+rQrmKC8MW?=
 =?us-ascii?Q?Xj8jAFVpW6EKbT2rZlk6uGqmgVxFHOUzu8XyjDUMmE+0ZLJS+b4BijcGT1TJ?=
 =?us-ascii?Q?CWVAo1/qHJ1h6qgXZAeRAFD2gKJwm+gL5ugoNqz1VEDcEMFcmis4wQq5YbJE?=
 =?us-ascii?Q?2MPoWuBqQYqXaXBwqWZ6zaj2A+Fs/1whmmDen8tw7sGl76e2RcW6ez9vbBEh?=
 =?us-ascii?Q?G5X8FuOSm+h0gkZBrAVZs54otoaE0N5Z21GVHlmkTAEIB/vWVhHVQg8xsQYj?=
 =?us-ascii?Q?YV2XRSdheEmFamux3ku06TTqLSJEvvFWoA4LrgOD9bLcd5mwy5LOvptmTxwY?=
 =?us-ascii?Q?msAHhKiIhFqO4TKfZs2GSBRCTJ1I3eZ5ts8785VVxisTIutKeJFdQ9rq7c3i?=
 =?us-ascii?Q?AKB//QIPd45p3riihYcYif2JHxw+ouf96qWn3Zx4hk4wMv3lYr3AVYf9Ogkv?=
 =?us-ascii?Q?QAd2rVS5TjOwhns0B/P9eLbTuxRcuxTIo+cSMy9CzRLX6il6fePpv6tU7WjM?=
 =?us-ascii?Q?NqMp4slXzYA7odqAII9yUyNMTDj5zojfIalMYdC4LHT3rok9R4bNa9WdBh65?=
 =?us-ascii?Q?AIpgawdgUkXs4beuKborBlwV/V+L6uQh/owx19QSm/suFfj46Mvlp5Bo6u6A?=
 =?us-ascii?Q?lQ17TQgwIhb2G/R094IXdSJmF4hw0bIyZSeA7RHM6r2QsbjE/anD4hSSQun0?=
 =?us-ascii?Q?69WLd98Ez/479Q3wvydHfDzUBTn/xA6y2gFIBlB3FsJtdlZyflQJvW7ROpkX?=
 =?us-ascii?Q?JgBkyi2oegYkpdjVXj8ZzgEDw/1kK+UOLT385bXYj+YaLS6URLs2+X/uUxQ2?=
 =?us-ascii?Q?cWBOA+zizKrVhK0I4HWBZNLbNQHa6qi2cr2KSsqFmwVMs5T7k77+AMnq/BTF?=
 =?us-ascii?Q?5xvq6geroqJ09Z+lJVKq3HPhKjvZoKF0MsMYDe4bSEx8S9jJ1i7j5kuUbG2y?=
 =?us-ascii?Q?KosV3891Unz3wWOxLH6pxZIlJRFOcCJJD0mFlBRN/oi4kCXKSuR7/RhF3Q/S?=
 =?us-ascii?Q?hmS2MIe29Lrpe176IdKyw4kjRDQT9oNEJiG5MX2Ox+Egsrz7E3SId0d4Yaow?=
 =?us-ascii?Q?3AsH0HKnsd+glDdLWjfW9OTMFhWFrnpwAUZTlFZJNxgRIwV99ag4vcARsbst?=
 =?us-ascii?Q?8Da+bd8PTzRK3lbw7UJJTAsfb7n2sA5r+9DUNZPEX3AsBcooBEInnEKz0xqy?=
 =?us-ascii?Q?QmJwB5yadVS8Jrgthl8tdXJsU++ko9B3DsSF+wFtOoxR12obo56vboKR5+AU?=
 =?us-ascii?Q?A3GVgnrl/Gr+kyEqYeGHhNoqwTZRYGfWxWLBwlZqa45FD0lXvjf/lbJNlHk/?=
 =?us-ascii?Q?iBpOsy1hJK7KYWI/3TTbEL6ybUSVjiEHyfi1sO7Mo2KCuQ5Z8dEY55KtZPHU?=
 =?us-ascii?Q?9n28ZmopnwpVxt5xt6I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 674237d7-684a-4232-3f0a-08db8d8a1dd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 03:40:54.8253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 72ltYTxMomlHTEJvrl0Eh8I4LcFvmx9MQfTtEo8Xt/iz4iMhABpyW7IXUnldiLsEmOjiPnfBoicFlOCFRd8IAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9843
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

> > @@ -1416,6 +1416,14 @@ fec_enet_tx_queue(struct net_device *ndev,
> u16 queue_id)
> >  			if (!skb)
> >  				goto tx_buf_done;
> >  		} else {
> > +			/* Tx processing cannot call any XDP (or page pool) APIs if
> > +			 * the "budget" is 0. Because NAPI is called with budget of
> > +			 * 0 (such as netpoll) indicates we may be in an IRQ context,
> > +			 * however, we can't use the page pool from IRQ context.
> > +			 */
> > +			if (unlikely(!budget))
> > +				break;
> > +
> >  			xdpf =3D txq->tx_buf[index].xdp;
> >  			if (bdp->cbd_bufaddr)
> >  				dma_unmap_single(&fep->pdev->dev,
>=20
> This statement isn't correct. There are napi enabled and non-napi
> versions of these calls. This is the reason for things like the
> "allow_direct" parameter in page_pool_put_full_page and the
> "napi_direct" parameter in __xdp_return.
>=20
> By blocking on these cases you can end up hanging the Tx queue which is
> going to break netpoll as you are going to stall the ring on XDP
> packets if they are already in the queue.
>=20
> From what I can tell your driver is using xdp_return_frame in the case
> of an XDP frame which doesn't make use of the NAPI optimizations in
> freeing from what I can tell. The NAPI optimized version is
> xdp_return_frame_rx.
>=20
So you mean it is safe to use xdp_return_frame no matter in NAPI context
or non-NAPI context? And xdp_return_frame_rx_napi must be used in NAPI
context? If so, I think I must have misunderstood, then this patch is not n=
ecessary.

> > @@ -1508,14 +1516,14 @@ fec_enet_tx_queue(struct net_device *ndev,
> u16 queue_id)
> >  		writel(0, txq->bd.reg_desc_active);
> >  }
> >
> > -static void fec_enet_tx(struct net_device *ndev)
> > +static void fec_enet_tx(struct net_device *ndev, int budget)
> >  {
> >  	struct fec_enet_private *fep =3D netdev_priv(ndev);
> >  	int i;
> >
> >  	/* Make sure that AVB queues are processed first. */
> >  	for (i =3D fep->num_tx_queues - 1; i >=3D 0; i--)
> > -		fec_enet_tx_queue(ndev, i);
> > +		fec_enet_tx_queue(ndev, i, budget);
> >  }
> >
> >  static void fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
> > @@ -1858,7 +1866,7 @@ static int fec_enet_rx_napi(struct napi_struct
> *napi, int budget)
> >
> >  	do {
> >  		done +=3D fec_enet_rx(ndev, budget - done);
> > -		fec_enet_tx(ndev);
> > +		fec_enet_tx(ndev, budget);
> >  	} while ((done < budget) && fec_enet_collect_events(fep));
> >
> >  	if (done < budget) {
>=20
> Since you are passing budget, one optimization you could make use of
> would be napi_consume_skb in your Tx path instead of dev_kfree_skb_any.
That's good suggestion, I think I can add this optimization in my XDP_TX su=
pport
patch. Thanks!
