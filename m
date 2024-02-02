Return-Path: <linux-kernel+bounces-50099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09328847439
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9EF1C24E75
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF82F14831E;
	Fri,  2 Feb 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mcBwD4YV"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4AA14C58A;
	Fri,  2 Feb 2024 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890014; cv=fail; b=A9vmIabgRCcq8+LsagYwCjVZDGB10feSXUqvTelrNrWVD+hXQHyNVCQ+nYmjXlr+zcsFwBsk0pnyB4WLtY+BIaUIM+mJ8GSM9jV1PaQN7YAK14HJmPuNOJIP8OI67TAeY8YGKSvhKQRGU6FPD7qB7emV9jIaGtgBZ74oXNolTpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890014; c=relaxed/simple;
	bh=qm0SlTyuvuRCAdFIV+4cHvmrDDmDgpaq/CIg99+jT6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EfIMA4eanmq8nJlaaUH5cbQnF3St56UB2hrID1AobcekOZvi+1e82hG2VSlk9fpeqZ1q3MQNsN4BFCgU8KSXCzkRhEG/DD7hJaLwihFrO6Ffl85mIzWwQwKZ2au4fbIY2x8u86rEju+XSazJ1Dwjka73QgM7iW+36xlNdOJtIGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mcBwD4YV; arc=fail smtp.client-ip=40.107.6.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0ic7WpvTW6DbB14dsaKqSAA3AOZBrr25pKGMZcL9KfBNTEpIs448Jz9+KZq0JN31+pN0gEQVlMdtJObz0YyPq8jtBbKt0pxWxNMmtwC9TukTTIx9sOsxAAbTvv79uN1zvDgoG8ARk66IzqN4h/kJMaj66HyimNitj6iyfU61vX/TuopRX/rfIhU/BYDzQXgliuRpyEoVQk0wovV4N4AWtEk96aSy1NRP6hweuKXN8jggLkK9whCWejVpyf3tZTPLXdJPn7/G7E3jhyg5UYDG8csCMF5vFq5yi26TfU6BCWOf3ZHdydwrHmSQ+X4ykyuI/fCGoItulGQSq8cZSPJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwImOeFqniJMkDDYpCK86D1P++gIQ1BdpJBUcrNgzhI=;
 b=cS+P+ugC4jnImFjxp1rPiVf0kGu1GMSSLwLTkq5/6AlOXsaiVPjUxIuLlxmuvwNPjDUacLnYgW0r/TrZRmcAs1Dubw85HA9GXkTTI9D9d1XB9gs86nc9ITrBRJ4vz+MrqHduLaiYxxMXPW1wEUL70xxj966EFpIyC6qrO5gJoCoDw3KpPUxdRZ6k2sEDiDRjhn8LS8P4Uix/3ZeAorqeiSQH148tNWPVPParlO9rtNWOqoe+Pz0FHkivJrXLSD1ogie9DT2eXD+62kGV0LmagJ39lW6kn6qUm1dqD+2a5yGYq0sqkGVGSb3ICqs/jPFxNS4j0Ja64v/Og0RPWzi4xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwImOeFqniJMkDDYpCK86D1P++gIQ1BdpJBUcrNgzhI=;
 b=mcBwD4YVms992yxe99WBornYJ3yCbJ3RYdNZkqa+ngL9vrbYD+LbvAWm8U0NiECwOF9aJOrExoJmAvOt5/B2wKhv4OpgimVVYQ+cecLAbjgXiZz8YKzkx3RB6DKCZvxXmBgo+5xhNiElI4Pz9u0qm3jx3qIyP1t9OPtywbva95o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by AM9PR04MB8572.eurprd04.prod.outlook.com (2603:10a6:20b:437::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 16:06:49 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 16:06:47 +0000
Date: Fri, 2 Feb 2024 18:06:44 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ocelot: update the MODULE_DESCRIPTION()
Message-ID: <20240202160644.yzvxhgonu7cj2u4v@skbuf>
References: <20240202160538.2139629-1-leitao@debian.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202160538.2139629-1-leitao@debian.org>
X-ClientProxiedBy: VI1P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::19) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|AM9PR04MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df2ad65-5a59-4c46-91b5-08dc2408f560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m+iYPGDkvTG9fyPE7aJOgdJeEeiBPfbE2ywCYBfBpx5g6pKJFNyAm0hwaUDGCMjMhG1x4QQQBoKroJ8F6hxp95+UP8kVXjV+lrLjecAPWFn0oCBhLcjnc00Mr91adlI1FwtEbqVa01xTz2FM7WQUgnN2SXXCmwCwkqOiUZsbr81fp68ckAvHYJdRTAkyYNYgDHvVCv1QkursFpPcpSiunH3jiTyfaj2SY3YJ4HxlRV18CcPd024tpPDzD1wAuV7PJk4IRSuayPro9M/4xd4cYQXXtD2czlwVUKeaCf/MCNi+LfgRJ6COaf+0Wv5/U6AmAxIEDhfmVhZu51HouHxxzhpHSv8hIEoZ+jgh+cnSvFkRYtQQeL0RBlfHaKQO6LdYflvTQKAz3r92s5M/D3bxA5v1fC+jnICLTC7kdmjzj9/q7FNnKxegZDupbffEwf32v19eKxN+c8tgLusKHl0babNh0dyKj1XYoxkb/s5bO0saZPIYOI00TTHeyhHDGIeKubUlenEVjPSogPwJUcS+iXYwEWChIYliOMD4pODm3cXBqUK2UnNGp4xIdWSNfpPO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(38100700002)(1076003)(9686003)(33716001)(26005)(6512007)(44832011)(5660300002)(8936002)(6916009)(8676002)(6666004)(4326008)(7416002)(6506007)(478600001)(316002)(6486002)(2906002)(54906003)(66556008)(66946007)(66476007)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NJFTSeibNoDFwU4vIhtF6aWO1gEdJKB+WnxcGEe/0sP5IJlbl7ECvxHDDkQt?=
 =?us-ascii?Q?7zacClCFeKC2eq0pIvLDZFexmL5UK1k597wHF73RMoy20NR5x985hFzuCs/y?=
 =?us-ascii?Q?AYnzyaFYwkNKAwle+SEjKe6rXhkY8C41dfrvMtK9n93j6pKmAkbOQCieT7xC?=
 =?us-ascii?Q?4R56Iudz+vlCf2H+35ec7suHGkE3MSL6abLNMTfKc7EAVl6iaC0oI1krcxiK?=
 =?us-ascii?Q?z8US5EbitG1DZ0I6SwjS0eCGe7i6lMQZixfejhwloutvGdJQw96koXRFbvpg?=
 =?us-ascii?Q?V1xoojn0c/tl/IxiTc9OLoPnZiwFEBu695rq2NWxbuGOeRwaaYy1cm5W9YSC?=
 =?us-ascii?Q?oftEAh1+sARWsaWyZST6/Ki+tU2Q7+QkCAtF/DL9rJZH4T9rHbux3C4Ht1mk?=
 =?us-ascii?Q?3xDKrSKckNNzPE/tnaUMokR9FmQv1NGnsTOHVTj1oj8mfuNrS1b13nvuBD1V?=
 =?us-ascii?Q?1I+awFqmfWCLE4LplPeTtAKAMpKxGtWbrTBEOXXFKYGOtRYsfVnMjpUz3pRF?=
 =?us-ascii?Q?R3c2x7Fm/Av6aoW4UkmvJ4SnVU9lYLRPIWltlcV0KG/rc9WEzjxsNHACBsYM?=
 =?us-ascii?Q?8mtkn7mQyXu2dCtiBGpRShEDdHOZl9SxZi10SY89kW+Q1YzpxFSfKGc/9puR?=
 =?us-ascii?Q?4yFewL29oORjk2YpRS8LjCNbahZNCYLM4dpg/17Yc3vkHsN66jEWpRWCDoq5?=
 =?us-ascii?Q?zk8r7jC649NE1vUVvTre6DrVUZ1SEnA5lf37E143E9ndHKZspph6RJp3+Rxp?=
 =?us-ascii?Q?/yLHlIiMwywF6tXiPO7YsPl4IJ13I5FE8ebh0GCXE42orBthldZhAnlsqgfm?=
 =?us-ascii?Q?eOO6Icnp2y0/D57WsNC4V3iaeXOtZH6DJC69CHOwAhdrpl/qC1OdNajAvviI?=
 =?us-ascii?Q?E+W+Seep9tpOWmC0VMBgUF8hVYyUE4cxSaKoEfTN3Y+OrpvImvT5dGF5lUMG?=
 =?us-ascii?Q?llZIDuMA27RhJrgvAhcPAnOrcCR5C2wPEcA2ztFwJ2/oS+rr/UVBGRVy4027?=
 =?us-ascii?Q?kB3S6IfZ/BZ5m5xx9mfR8EfPjfTuU5+eYVUkJni+YAx+Fthtsp8vtov6sTKh?=
 =?us-ascii?Q?Jop24A9b1iT6ExWzYs4KqNhor3HL5nC52vmVE8ax0h0Yi4AANcba0A3pa2YQ?=
 =?us-ascii?Q?f1iV9ZgKKxdCPS0sA43NLJBItiLFaJLKJFBAhHDndqNlTTTg10rUVno/1wWi?=
 =?us-ascii?Q?CZZpwJQ4/ua/NeAz3wdV3CLRFJycYKOJ2t/yV7gkCBs7FSznsy6+Ho83iL2Q?=
 =?us-ascii?Q?tFVrHmKU6z0dWXGgTL1V5BSK/hQjY3pQ0c7bIa0rY0onPjf0jBILsDVNfUea?=
 =?us-ascii?Q?eWOoziauSoEgo8vjyVg/4hnq5xS+dOtN4xs8RRSCyUfO5Jmlg6TxohiIKziv?=
 =?us-ascii?Q?pBfcxtESdPkpwM1NjCzBw7hfzdfSK2FLdv2SCeTM4wxr7/AfSkmxcInVfbY9?=
 =?us-ascii?Q?YC8CJj0tdS7HoBkCW/QFOhE/HDvvbtLYpOgfBnOYaaq8imP4zkUUclQVIoQY?=
 =?us-ascii?Q?KDMvuTH088sULkhRYkn6kSYujpuZA2/5XGS0lwEOWDM5T4rEPN0T9J3gZ7uC?=
 =?us-ascii?Q?AgRqypzgCXz257NKOHe2DHFnDU7WKX5Vd0qwIiGrygvMKcPB+Iv0aWEc4TdL?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df2ad65-5a59-4c46-91b5-08dc2408f560
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 16:06:47.6180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 624iXJS3kRHhIIcJu7xwuwGrdK4pgonLRXfwfQJG9ZBOxWASoK5biV8Wv/i8MPGdg9QpaYP5EuLjzWrf0ROyYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8572

On Fri, Feb 02, 2024 at 08:05:37AM -0800, Breno Leitao wrote:
> commit 1c870c63d7d2 ("net: fill in MODULE_DESCRIPTION()s for ocelot")
> got a suggestion from Vladimir Oltean after it had landed in net-next.
> 
> Rewrite the module description according to Vladimir's suggestion.
> 
> Fixes: 1c870c63d7d2 ("net: fill in MODULE_DESCRIPTION()s for ocelot")
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/ethernet/mscc/ocelot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
> index 2194f2a7ab27..ed2fb44500b0 100644
> --- a/drivers/net/ethernet/mscc/ocelot.c
> +++ b/drivers/net/ethernet/mscc/ocelot.c
> @@ -3078,5 +3078,5 @@ void ocelot_deinit_port(struct ocelot *ocelot, int port)
>  }
>  EXPORT_SYMBOL(ocelot_deinit_port);
>  
> -MODULE_DESCRIPTION("Microsemi Ocelot (VSC7514) Switch driver");
> +MODULE_DESCRIPTION("Microsemi Ocelot switch family library");
>  MODULE_LICENSE("Dual MIT/GPL");
> -- 
> 2.34.1
>

Thanks!

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

