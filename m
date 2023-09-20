Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC4D7A709F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjITCh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjITCh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:37:58 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2097.outbound.protection.outlook.com [40.107.113.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F474C6;
        Tue, 19 Sep 2023 19:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+eHDfXgR86DemesGDklE+qlzSWbyNkHNpzM2eH2/rwN7ofSW1QfVe+UKwZWTPOcuWtIe69ky0XPRQt0Jja1Qtmci14BvefWN9hbTjx3ptfG06fMHE/31dd4WW6kEW72i3CNbLu2rq1l9wpv7ayMftt5t4wV/C7wGydkrAMDekbvHRhE15+3nc0sdK0q9PqeGVTn/+LXId/cD7T7jS9/tQnoDBjOK5hAsBIVgmIEnjeC59QL3fp+w/abH4EjTMdzOcGriEyWtrcPMJbWdnQZ/lqB9KFbGqwOnw/PeQNPhUXmuRhscDyk7ZG/e01fAQVnUU3FnkUuzmgr4vHxXmN9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiJq/9UjnJMq6AzPTDbbKtAHKBhWjahCvVqkuWN44ws=;
 b=DxiPsCJ1vL/Q0EeOh5mpdkYMu4i0O3nafxR3Dh2OOUzwid5C3mA4OT7/y7H3U+o5HXzRGfOsvIptfxiXn9ZmBqszb7+uNc5LZLEYMbyYqbva54USEZE2hxdv2q5ouDQcpaSeetVYNdHNuZlgNJhnXo3mrubaf6+WZh5rMpTC4FLiB1Pt2udXZfVvJFQPRMAJA4BwnjpjFylDHaNrNU+/vgW8rok8eHB9Xcwq8FZcv9bp1RdFm8SndBX1JYbL1JChR8NwCf8nC1vI7pX3COhIInOjyFOZOsGBXpz+oXNQToXoZwNbL9hZxYzSZ90p8ZuAuJEhnqIZ6BK0zeovZ5BHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiJq/9UjnJMq6AzPTDbbKtAHKBhWjahCvVqkuWN44ws=;
 b=CrICzsrcF7rFJom/Uwhh9SGbFw3T5bstcHZHy6wAwurlglmXp9moR6yukFmrzp4362ASKnOB9Y8J/z0u9kD4GeJKe0XKimp8BaIlgf9MAuN+kYi6feQVOYOWDlC+RtVG3td5/DoH5xCjymfx6BbCmClGFVrOrO7zEK9qqPy+K84=
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com (2603:1096:604:8a::15)
 by TYCPR01MB6318.jpnprd01.prod.outlook.com (2603:1096:400:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 02:37:47 +0000
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::fe8:f613:9823:4075]) by OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::fe8:f613:9823:4075%7]) with mapi id 15.20.6813.018; Wed, 20 Sep 2023
 02:37:47 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Zheng Wang <zyytlz.wz@163.com>
CC:     "lee@kernel.org" <lee@kernel.org>,
        "linyunsheng@huawei.com" <linyunsheng@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hackerzheng666@gmail.com" <hackerzheng666@gmail.com>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>
Subject: RE: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
Thread-Topic: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
Thread-Index: AQHZvqRVuDoCAQ7YqEiPPoP/ALhCca/LYswAgAHmgICAAK9XgIBVS6xQ
Date:   Wed, 20 Sep 2023 02:37:47 +0000
Message-ID: <OSYPR01MB53341CFDBB49A3BA41A6752CD8F9A@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
 <20230725201952.2f23bb3b@kernel.org>
 <9cfa70cca3cb1dd20bb2cab70a213e5a4dd28f89.camel@redhat.com>
 <607f4fe4-5a59-39dd-71c2-0cf769b48187@omp.ru>
In-Reply-To: <607f4fe4-5a59-39dd-71c2-0cf769b48187@omp.ru>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5334:EE_|TYCPR01MB6318:EE_
x-ms-office365-filtering-correlation-id: ed1fecbf-129b-4e2a-0e36-08dbb9829377
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hQ/XurwRsyAJ3lxFqEpQqwQPN3kFhvGqLEqXjboJKSpJPBTkHSb+HXo5IEUV5r9o4rcCCji6eoRIRcFiRzB30rx0rcO+OOIq9JEsy6LXp72k6UzqVaifxcFfnb1ayLxhhe4JMTV82yoPRSneUSAp+R2ZHdmSagLHjToXH7P74PxWU31SUb0OsV2L3G+j0li6rJ7yYiCPdS+GbouXrU5WOAD7xBzEKVwt9cIkprvIhp/n0ylq2b8Fb0cFkbHejsJ/0nt9EcxCubhWJZG3eBGeINe0Ykhyc5Fo+1gQUPPbtggDaVLxWgFFDH2M03U95LRcN7na1QNB+QADTyg5GLBOxgrg309Kjskgh/0hIKaWzHI9UTW4NA016wo8jTCg633m531J8ehLhWmVJVnzMPIPoPs9JYkiVR72cMlUpvvyWPCoL9FA9nUYchcWy3XyAX8Mr3K42YvqCLQgecOKxRqu6drMzt9bciLkEZm29WT1/KLM4jE7Sfxg994RqrQysA54ru5Ohj2vd1f9mTsrbKXk+z7EVBIbFYWjylkfsvgQwenyJWhtKdykDrWBK3fv67A0bE75GJ9lXxRxZ9z8+chC+D8DSPt2IkWOwiq79mFHUBY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5334.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(1800799009)(186009)(451199024)(7696005)(53546011)(9686003)(71200400001)(6506007)(478600001)(966005)(4326008)(83380400001)(7416002)(2906002)(8676002)(76116006)(8936002)(66946007)(66556008)(54906003)(64756008)(66446008)(110136005)(5660300002)(316002)(66476007)(41300700001)(52536014)(33656002)(86362001)(55016003)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HVJToZybbjqUk3ugTt1QMsW1pNQQx28BQx5xMPmu60ZgjV0n7T1FfYXX7waQ?=
 =?us-ascii?Q?MeQFfb9bckxxl7kOjHgP1EAO5DmJBXYuNfR3TLTxy1Je02czcP2Yzt0LdwAt?=
 =?us-ascii?Q?UcHR5KPoyOLBvmYcnsKy+Zzkxh1Bt/IW36AwJSepvRwdtCOzOtyazYoMnGZ3?=
 =?us-ascii?Q?3yKXatx5pfMbCNaJd0rzTvjcVUAStx0D7dEmItr6+VxNUEOGc5r+0oSe7Dpl?=
 =?us-ascii?Q?40ZVE9MBtaGpba33WbzSNwDxnQXYDclktuDYLs26uyd3JzqmTlpfPBr7FAVG?=
 =?us-ascii?Q?gLnQe2xeEQhULSwnAgCictr28mA9lRh6j/6aRxoDk/0sfu/QldAGk0QoJzbB?=
 =?us-ascii?Q?PcJnz/pflxzgNRIntFgZJ22BDkETP1oRKLo4eoa0XTLBuIQZ/bgERY9tHFnK?=
 =?us-ascii?Q?f2UdytkOHYKDY1d7HRxpVXrCbYA9PBpBRr9IE5zDt1tBXwGjgLm8vU68u33C?=
 =?us-ascii?Q?TS8z8FK4k7ha1Kt3MlwOgj4O1p7aTtf747Md64/dOCJp33QU5Wq1+U944Y32?=
 =?us-ascii?Q?yRN7Y+JDkhhePeruH9qfC67oh/qvfpOoX6v9LanVm7k12tPO3ve67UtPtXqW?=
 =?us-ascii?Q?QRS0xuuPBjolZji7vLIIxc0vKlLXxO3WaXQy9VI+tUs/gssBaD+AWIqXgrV4?=
 =?us-ascii?Q?7xdXU2JjgQchQJZxq2q6MhfA/WatHc0s8hQmy/j7GwyCS/nbdBzptXkjFV5i?=
 =?us-ascii?Q?4sVPY2jROXLgxUQVmJjoesPpauh3L8ob6NtzPdmP+ZitiJ4X4mC2sFM2E6v4?=
 =?us-ascii?Q?98dLvRFPTN/B8yj3XfEZ3aIvlMxYfuURYgGPobnHV5VngtmlpaaaroDPiBZm?=
 =?us-ascii?Q?Vv+doEQq8Kmi4aIt7SYRgxeSPVj5JLfcHybn120lLygG3vY62YEcWHr/xP6z?=
 =?us-ascii?Q?vIIG1SEGAjw+iHGSy/DRBjOdMuBUxSlq2cCrlxjh0YuvBIWhxBD0iYLnRQ02?=
 =?us-ascii?Q?82j2nkOgqvAAGefaUHiAd+ddkTZxW/IK+A65TSa5WoYYNav2ujpUJTbOmkkM?=
 =?us-ascii?Q?8HyuCWlCiRcTuV913OPRg977u7pp4dcqHOTyIfrW1WfFxzHUOo4iUeBp0gjC?=
 =?us-ascii?Q?6y5dDGk/qr7l8FXupqGL1p7TAe4OvbSiuGnal/kiE2uY7Zwk5zhWmEGiBFZH?=
 =?us-ascii?Q?zmVGmfBwhBnRMN0lb+e6LOWYFf4QpIJrxXM/yf3qsadmojLFTTM1n/hPQCpA?=
 =?us-ascii?Q?Lw26wBKPLzjs9JHz5JMr3DzXRRONbOPaqaEzjWR6Zx2YH9QXHOVsiZhx+y6A?=
 =?us-ascii?Q?W6mNQYbKT9wiiZaKt2JVx1NnJHSCBHfsFWxEzH/LsUgzWNC0c27DDjD5+Lyt?=
 =?us-ascii?Q?7uW02pbXAilKsA105UTwR4ygNw2NYTZrdTFYEjYjBMoyPTuE/j4X4yrv+acm?=
 =?us-ascii?Q?AJafz7TsSb5c+J41Tln2YBnEH8NlfeVoG7c3N3z4r2WiaXKaAPHQeknl3Xho?=
 =?us-ascii?Q?UIBbk5Op1N4YYN9tT8l7N3CNmqQTP2RBNqumWrzDLruCLL23usd+XVfWXYl0?=
 =?us-ascii?Q?dhQLEjY/gxfm6uBvo0f1RR5kFv9ZtPn4sX7SmhuXtXY09rR6NRit4WfajM4O?=
 =?us-ascii?Q?xZG9pZVsFVrCidhmrjfXErbMq4DDZiLt/qLHd8cwql227DGEJFpv77Z2L5sG?=
 =?us-ascii?Q?5E/mFU1/C2iiBAWbgjuR1X0P1EUFBNkp7UEmFbn9zSj3nbc2OcvRxECWkO4M?=
 =?us-ascii?Q?kSKJ5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5334.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1fecbf-129b-4e2a-0e36-08dbb9829377
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 02:37:47.3920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JdrYat0TPPfbHcW5jMgs+OBgzMKYjH6vuvOoKLoH7uUYwMoIUoAIY3hq5temnGewdclNC1GikbaObi6+37A3pgg6wv/C1rAhsV9t58aJ3i8b8IAP/imy9sg16lcrO61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6318
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sergey!

> From: Sergey Shtylyov, Sent: Friday, July 28, 2023 3:49 AM
>=20
> Hello!
>=20
> On 7/27/23 11:21 AM, Paolo Abeni wrote:
> [...]
> >>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/e=
thernet/renesas/ravb_main.c
> >>> index 4d6b3b7d6abb..ce2da5101e51 100644
> >>> --- a/drivers/net/ethernet/renesas/ravb_main.c
> >>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> >>> @@ -2885,6 +2885,9 @@ static int ravb_remove(struct platform_device *=
pdev)
> >>>  	struct ravb_private *priv =3D netdev_priv(ndev);
> >>>  	const struct ravb_hw_info *info =3D priv->info;
> >>>
> >>> +	netif_carrier_off(ndev);
> >>> +	netif_tx_disable(ndev);
> >>> +	cancel_work_sync(&priv->work);
> >>
> >> Still racy, the carrier can come back up after canceling the work.
> >
> > I must admit I don't see how/when this driver sets the carrier on ?!?
>=20
>    The phylib code does it for this MAC driver, see the call tree of
> phy_link_change(), on e.g.
> https://elixir.bootlin.com/linux/v6.5-rc3/source
>=20
> >> But whatever, this is a non-issue in the first place.
> >
> > Do you mean the UaF can't happen? I think that is real.
>=20
>    Looks possible to me, at least now... and anyway, shouldn't we clean u=
p
> after ourselves if we call schedule_work()?However my current impression =
is
> that cancel_work_sync() should be called from ravb_close(), after calling
> phy_{stop|disconnect}()...

I also think so.

ravb_remove() calls unregister_netdev().
 -> unregister_netdev() calls rtnl_lock() and unregister_netdevice().
 --> unregiter_netdevice_queue()
 ---> unregiter_netdevice_many()
 ----> unregiter_netdevice_many_notify().
 -----> dev_close_many()
 ------> __dev_close_many()
 -------> ops->ndo_stop()

ravb_close() calls phy_stop()
 -> phy_state_machine() with PHY_HALTED
 --> phy_link_down()
 ---> phy_link_change()
 ----> netif_carrier_off()

The patch will be the following:
---
 drivers/net/ethernet/renesas/ravb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/etherne=
t/renesas/ravb_main.c
index 7df9f9f8e134..e452d90de7c2 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2167,6 +2167,8 @@ static int ravb_close(struct net_device *ndev)
 			of_phy_deregister_fixed_link(np);
 	}
=20
+	cancel_work_sync(&priv->work);
+
 	if (info->multi_irqs) {
 		free_irq(priv->tx_irqs[RAVB_NC], ndev);
 		free_irq(priv->rx_irqs[RAVB_NC], ndev);
---

If this patch is acceptable, I'll submit it. But, what do you think?

Best regards,
Yoshihiro Shimoda

> >> The fact that ravb_tx_timeout_work doesn't take any locks seems much
> >> more suspicious.
> >
> > Indeed! But that should be a different patch, right?
>=20
>    Yes.
>=20
> > Waiting a little more for feedback from renesas.
>=20
>    Renesas historically hasn't shown much interest to reviewing the sh_et=
h/ravb
> driver patches, so I took that task upon myself. I also happen to be a no=
minal
> author of this driver... :-)
>=20
> > /P
>=20
> MBR, Sergey
