Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412777A9663
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjIURDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjIURCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:02:38 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFD4135;
        Thu, 21 Sep 2023 10:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LROj0Ga4PiG3DWKL6NKhtYBdJtzMsg7q9iXJyW8fBAHuE62vZEx5ba5r2wVR24yg4O/s1lHJzUj0W7OgcOgwCRw/VbXWJJDSnVnJIOZ7uTp8o5cZavqQoQsubwnZWS9WBz9pNQnom55yn3gZOGewUtUpPxyHYnAbptDfSkYf9v3UmT5eilzFDKoR8pHl1T2mvvSWD3OWlr4Seo9FPVUNtiy7rxSNJMSPxT7+5jbvmKYcGMehaf86/5fpjsH++NCxVdk4yOR6lu2nzdPGnn1QKCHDPd4xNFzWgX8rEaGLcaX9BObksZszAzM0609i3qGajSiGdbac+xtmUm94ZIpv3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G14s8fO8SRq8NrLzLRromACgnm+58kzDlWcaYwUYKqY=;
 b=MB1FaowPJ5d86ADveSDNC3mSR98zJUfUgpycInPPaBcOffkMzSRK/0WoCNe0goD/i5A0qYK7/LRqtQynWN2ZSU8M7L/o5rvnJLDnVEYzcRbedP3Fa3/he323aBBbzK+rCkawzd4fA+rRk6ssCeOI5W2X4MQbBSgiH9S9jrNySqDty2/vACjmdufEOpQtstTh7Mp2+TTugJ134N65LI4qAWwFr/KdxwpzZCBkN1zRdBCTtaueUZRcl/j8u90EvWMZR8UdXq6/uTrUPH44ulLdQnUkRLvw2D7roRnx95BUmtHSlZmwFm/EE2Gn1WHxBimnJef5H42n8WBhWTKPqZki6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G14s8fO8SRq8NrLzLRromACgnm+58kzDlWcaYwUYKqY=;
 b=bUzr3h+kKXTAFsSsW7VLsyLPUJOs6WEQfl4vbBmziRoXBjwA4Ahtsx81vhRXHZ4etk+lRwME/VaKZloJ2Dn+zi0g7tiW5z5LTVHVcVt/MLYpLvGJ1tN1zpkGeENSYqT2n+zecC7iVHSqo1csUP1yEGOD+PUdPiIVTxrThBZhVPw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8488.eurprd04.prod.outlook.com (2603:10a6:20b:41b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 10:46:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 10:46:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@linaro.org>, Abel Vesa <abelvesa@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
CC:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: RE: [PATCH] clk: imx: Select MXC_CLK for CLK_IMX8QXP
Thread-Topic: [PATCH] clk: imx: Select MXC_CLK for CLK_IMX8QXP
Thread-Index: AQHZ7G8tgJ9cnWQkzUmrwNRV+pF1L7AlGLJA
Date:   Thu, 21 Sep 2023 10:46:20 +0000
Message-ID: <DU0PR04MB9417A049C029E7AE4C44F81E88F8A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230921093647.3901752-1-abel.vesa@linaro.org>
In-Reply-To: <20230921093647.3901752-1-abel.vesa@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8488:EE_
x-ms-office365-filtering-correlation-id: 4fb4d04f-25e8-486d-b20a-08dbba8ffdd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TzHO0z3I27m6aS1RF4C7cWAu7MVVxhHn+IfsH7YPAPo5sVFikdO4KSQYBxQ5T5GUlleFoj43SeJVEtkhvqom1Ozs8GTi11ucaCVQ+sICnr/k726oKSBvD5h4EHddDyRjzp4L9cxEkFcPJ2GNJoZobOBveDNCUmXfqCvx5pqETYaOCLbD4qTuKmKbyrD65DxlNAQ5ZA/FoYg182UXvQM055+s7AkFTdYO5OCQnPjg9UDNbIjglz435OZbkbc/1SL+0/jKuH0eh15U38MSxkQ45NsgcAm17/RkG5dwW1K87O3pe6ExrFa20ZU/tESLuRwUBvA7t1lYl2TUGu9/DXh+E+H3zJbNkKuLitVj364RIKSDQkq0wj6EW0r61H0fPDb34PEr+xnYklBM+PID6t//Tqj4uI/YDGebx9OTF0xTe4M+IcKOkWB0DCIQHiQmX80/5E7WUA5uAMk3qG6GwbdKRL+L1ibhcujpAaYz3VmO3BEmtXGpGkY+iYYvwn9V2qnr2lRiKjjjoFBINVO/CRSeAIvyZlWW0iFLDkMnQxpvkjrkEN1QOe/lp6do5Gix+RPzvU9z6QWsngypCbX5CfUYRHTpPxo9Ku16HRmNZL568Bc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199024)(186009)(1800799009)(52536014)(8936002)(8676002)(38100700002)(122000001)(4326008)(38070700005)(44832011)(5660300002)(9686003)(6506007)(7696005)(71200400001)(83380400001)(26005)(2906002)(7416002)(33656002)(478600001)(316002)(45080400002)(64756008)(966005)(41300700001)(66476007)(66446008)(66946007)(76116006)(110136005)(66556008)(54906003)(55016003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XSp0AmwE1l/H1YnZCfbjcWs2DgVo+oSz3k985k5h5TBpRh/PMy0DnWgmimcq?=
 =?us-ascii?Q?2vNjhPrXLHicpaz7cKf57D0LI8/JiZ2+UDEUaXIhwExfDUIvmdxDn+zujOjF?=
 =?us-ascii?Q?3ZHgQGllkjJq69knEFHYPmZ/HXx76VdJS4A1AuJPf0WHp6bxWYBu89LQUNee?=
 =?us-ascii?Q?Y2Cm1BvX6k3w7i3NwFWGTbFZqwYL/M0PUEJdndUipuZVwXUyoTYFwSPuxwqS?=
 =?us-ascii?Q?b5GzOS02oSsBKqlJYCqYSGzxW0Dy1/rfx/JOuajGGNmiYU8tv2Y+1N2pkVZS?=
 =?us-ascii?Q?Z+5+hZXawJNCRzQMSPR+rGZQ97r1GBaCSB12gOg9fvFYyxY1sEdkj0Q5XNnB?=
 =?us-ascii?Q?6XROhjT5PabozfhXmIcz5dzi45LXOF4qTFKsneyZPaF6OUYYKe99eSjy06N5?=
 =?us-ascii?Q?i9CTB+UBDk6TCcCobdOQFjaieby+mM6PRPEcG9Oc/mLWbmwQMy6N+Q6YhTz9?=
 =?us-ascii?Q?Y47mcc9lUw4e73XfcCGuQAoUm957k/n80HkBQMngAWMBDaJ67o8f/N7s1B/M?=
 =?us-ascii?Q?+MCQQO7CloC+vjiFNc8+eXkW4H0zxMLp9VDvOtwVHeADbpTqZtWTzkPb2Z5A?=
 =?us-ascii?Q?90sLvEIfsqUfxAcyb+UpWAC7zashJCMgJYTajgN8LT9pG57PbvuWrbMjkCaM?=
 =?us-ascii?Q?kO560JqIEULpJdNuKtnvzL/mfJNRwh78NRzKUnp+yY4zI1CmBKpQnEnrhJbF?=
 =?us-ascii?Q?Mi9ClZ+4cuhD3hq+f1SiI4bZFrxkTB5fMMF/Shq6B+2ul65KbhGD93IvvfcH?=
 =?us-ascii?Q?fSmHFDiXAe5gANTF++1yugJmJ1LhYAL1IHW+gmEb8XsLZE9QQQuaz70+ius0?=
 =?us-ascii?Q?ng9vsY+NE2b5W7fL1OjJS5uRVGm+7cNJnuNhteB3fgbX/T97V3KpCpy5mghw?=
 =?us-ascii?Q?cJg4zZ1jYUUywLpTbVm8OyipMCd20Wz6Lk66NS1niAfbGq5KJ87Gl9TjyczQ?=
 =?us-ascii?Q?fcTy9AQLXYcROKHxyug/Xo1wp7F0DC+pZs0WLSmTiSIP/QxdV3P9RZPKS7ml?=
 =?us-ascii?Q?C3ZqQ6sR1iRCb60vNiiBlFacPccHxWJLGRnuYJsXVJ9WVX5yW0vAoKjYwVAv?=
 =?us-ascii?Q?m+6OJIp5zS3d/sXsqIHye7OvrlY+2NMl2eNdCzDpfY76b7gzEr+oA6FXmFte?=
 =?us-ascii?Q?FKYlsAM3d3l5UC/pbdDl96plbttYz/hdBNLbyWKHWzlRMnlpuOaQkhRqElhu?=
 =?us-ascii?Q?411MNYsBXiwlGyQ0er2x8ZDaj1Q9ltaomuqL8WYZCgJAHR8fInFM7C5a+//X?=
 =?us-ascii?Q?wFSDriN7mM7sSvLQuME/QmAdxS6KVzeDMI1Wo9/L2bD/bVu/peN7YnMT0uR8?=
 =?us-ascii?Q?F0OHwUEZsB3enA3q1Zd//z4c3e1GtWNDzmq0O3vzANM81B9U5dO6JkiUdEy2?=
 =?us-ascii?Q?LiqyHyEUPhXx+ZjP2k0iYuDgvDLV5DmAqfvsrMbnRMIq2vt/fhi7oHsed2np?=
 =?us-ascii?Q?gWPhRnOaXGOkTKmEagX4pBYYmBIr+mpnAJzFgdXxgObhYNwj9kuShcCrTODZ?=
 =?us-ascii?Q?jnWtrdU8vrAbeFWK3xqgNJKK6dvB+7U77Tql1W/YNZWRxzh+DW0TIudSBN2D?=
 =?us-ascii?Q?vAHX7Fx/5GYDV91jTB4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb4d04f-25e8-486d-b20a-08dbba8ffdd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 10:46:20.3983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ErArSiLBQeAFjS7Xtxv0VVnWzCEeek1o8mVWm8Q9MVKNseyraoW2+74eFvwZXhQGTL6U+WGmDliuaHk/swWFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8488
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] clk: imx: Select MXC_CLK for CLK_IMX8QXP
>
> If the i.MX8QXP clock provider is built-in but the MXC_CLK is built as mo=
dule,
> build fails:
>
> aarch64-linux-ld: drivers/clk/imx/clk-imx8-acm.o: in function
> `imx8_acm_clk_probe':
> clk-imx8-acm.c:(.text+0x3d0): undefined reference to `imx_check_clk_hws'
>
> Fix that by selecting MXC_CLK in case of CLK_IMX8QXP.
>
> Fixes: c2cccb6d0b33 ("clk: imx: add imx8qxp clk driver")
> Closes:
> https://lore.ke/
> rnel.org%2Fall%2F8b77219e-b59e-40f1-96f1-
> 980a0b2debcf%40infradead.org%2F&data=3D05%7C01%7Cpeng.fan%40nxp.co
> m%7Ca2722eb731c04b7547cf08dbba864e80%7C686ea1d3bc2b4c6fa92cd9
> 9c5c301635%7C0%7C0%7C638308858240019022%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C3000%7C%7C%7C&sdata=3DB1ItP%2B%2FYZyet73i8CHu31xRisK
> DMewhqSchemxEwzLY%3D&reserved=3D0
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
