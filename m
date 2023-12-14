Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3718124F4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443025AbjLNCGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443001AbjLNCFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:05:47 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C16106;
        Wed, 13 Dec 2023 18:05:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGUHhnXBNAyw13Q/GSvKOdbqQ1K+RAR8BkjnpZRJdKmSgs+YfmMO5FZzUZ0/LTQ6tZdpnSF1BvFHhzN7084XqgbEMxvf4QISTT7bfZkH4+0eS1xv0+aqbczAtWkFyJt3w/qmRfw2v5A/ZnLpnjO22yyrI/KqrDguuYDp6PWyw33qFzdmfiGtjxyDYhMPKryxRn/q4QAVSTmU8KH/6igRVD8GaGr+TWO8Aj6QYAJHCP8ANuOKCjb3ZZ+nVPD23vq1MEbuuvYTiSv9//++Gh/m+uZeMdnckUbRxDUoi0RQo/0g+K+CbrR91PZvu0WcO4JZI9NU53urQJZaCqSWsCV7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3YdpU7zBmWuYQ20iLAxw/fWkY41h8EOZxJt19sx1yI=;
 b=EJbijpas1pNTc5cbjXN/2vJtt93B5c0BXQJzwS4cks4EuibjoP9adJWO8FRBhYfEQ24CWKI13i4MIHfs24YdJXTGlV8AWgNoIZbsTJR9XX2/uRJef2VCpjUBpCkHP8N7WHrPrs/3hUH0Qbzn1zoTZfockZZrbHVW5p35Ng2plyvbrri13FNaD18KeD9qHBYaLt7wtz+3mxbUA9P/+RBvKHnat+Pu8+q4VYKm8uP+zmTOfWiQ6tna2nGZhJZHckKxVSnhatTCgJnJTIV+5pE6tLryQWVuHBMCo/GYh4EJgnZttua9yHKEMXMj3RxoSdu9P5OfzSuSMWYEJyKTzpGY9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3YdpU7zBmWuYQ20iLAxw/fWkY41h8EOZxJt19sx1yI=;
 b=k7mn5qrnJrhGRPkPwhYzzovLeDCeM3eFn+uIUpXuK8xcFtr715nzp9JRQA0XRq0GA5LqQQVgX/SwdcUvD/FV90v0nnHBeETBsDXgeWTJOQREjQZdlCilnbUTgC424NuDylvGwmLOUuyuAkdH0PCjDQWgOHtJqZBJMO+ELCLJDSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by DB9PR04MB8380.eurprd04.prod.outlook.com (2603:10a6:10:243::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 02:05:49 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5%7]) with mapi id 15.20.7091.022; Thu, 14 Dec 2023
 02:05:48 +0000
Date:   Wed, 13 Dec 2023 21:05:39 -0500
From:   Frank Li <Frank.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     imx@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8qm: Fix edma3 power-domains and
 interrupt numbery
Message-ID: <ZXpi8/asoBMBAtmz@lizhi-Precision-Tower-5810>
References: <20231206201256.1113800-1-Frank.Li@nxp.com>
 <20231214020053.GQ270430@dragon>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214020053.GQ270430@dragon>
X-ClientProxiedBy: SA0PR11CA0032.namprd11.prod.outlook.com
 (2603:10b6:806:d0::7) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|DB9PR04MB8380:EE_
X-MS-Office365-Filtering-Correlation-Id: 78483b64-01b2-480b-0d49-08dbfc493063
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1gPX8MQxkxpYYG7R6sej4yqlP33pe5CB2xdC6HziakHI5c0S8z/SgUt6A7Gq3pXa18fgxZ5JZuk942hfa7jo6N9tg6StgyniPUjsuWBlFlM4BRsywGymFTzrcUIUeCUPlATZ1MNIimou7jUPu1zbxBnkzbcGfO/KQkSeZjeQSAx1k0SKLb+j3+W6Frg7L/QSUfMF6c9UGFpdR+t/4/VO/OcKydCxksNh3+cXO5ranhgqLo2alAw+NyHCqWIoYFc/c35szRrW5Pbcp5fHrciKu2UEh1C2BP/bY1mDORp0/6zKM2iEGAhFV9PKL7UsikksucJDeg1l5AHMVhNN25zCj0NF38yRLbvaiNe6YBbFNpSA4uM1q4YWlLvsBREtTnqsQvkFUkEz2LjsVduZ/bgExRr7nezhyxZsvuiEuFNZWrdLXCiXzpZkd4w7dOZOvDhj1idrSgQnbi6oyZpTbDEUCC0XKluvUtwKaVwsq25IseYTnWUa7/40y+zW6Q1vKWj7Z6YrQ8HrbNVEiFYnadthCFtC7kciQQ4ANP7Rfzj7p94TXQ/GnWdtcTJNNBYtik1Xb4nDKRNU8ItPYQY71YarG8vBNu1zkizknmFAlvyI8YNXS78fJMCXvkGq9HgXDi3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8676002)(4326008)(8936002)(7416002)(2906002)(5660300002)(966005)(6486002)(6506007)(478600001)(6512007)(6666004)(9686003)(52116002)(54906003)(66476007)(66946007)(66556008)(316002)(6916009)(33716001)(41300700001)(38100700002)(86362001)(38350700005)(83380400001)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oC+g2FNZUwCBha1EqPLXTO4NU14Yl1Xsv55OnkN/oWq56ekgtUd+BZF2MrIS?=
 =?us-ascii?Q?yYdwkE1S5oOrMtVgAnoWtcYc3NstmubcpFtp2O7yREBe5E3/7FkEVOlkx7BQ?=
 =?us-ascii?Q?7KaoyPMKjt84qaSk4MJckfjf6Zbvwqmsp8CtDBiAoDOKnoK91e9Dz0ZFaTHl?=
 =?us-ascii?Q?pndgYh2M3meZmy0CvyxsLafAH8wJfATYAHgrf13QUB8KO6dfZke4qd+wxs6p?=
 =?us-ascii?Q?xcVC1OfVhInobm5aJGu8c8U4QbPWyIrRvv+xYSTRSFCm0Rx2lj13dd0AN/RE?=
 =?us-ascii?Q?5PL8KeWKkRacHY8NSe6D9SFxNzboHwoktClaqcdacq/ESs3txYpI3VIt9oJt?=
 =?us-ascii?Q?5qCbKKS8hu82vR9gxTh1wIBge44qnQxvU32GvIqkLZ08imEDMzj6i5dIuKMM?=
 =?us-ascii?Q?9Um+k77WWsg1OTljqi6NZd5LGGhQp1zfpqaPd2aXQtDqsv7NbbWfr1pNAPYT?=
 =?us-ascii?Q?ntrNBdWzkjM5mjl5IjkO/LVMExEEnvaBj0F45f0nh5Rgg18eRtmOlKC7WHHX?=
 =?us-ascii?Q?luvgDgO7pYIa3PJdfdnxSrOZryh3VMqV+Vdj8TJ8rKG0pSoPmjV+hd4KhdKX?=
 =?us-ascii?Q?XZ0StNJdRUhVEsfyD9gcfdKfxoiXRxzhVm08RpDHXeNjjohStM5nkMhtGScY?=
 =?us-ascii?Q?JKDbJylq+nxSSq5eKf3S6YjUacvbHFEsR0IdkpoS1hM4j6iFjdl4i8D9wFaQ?=
 =?us-ascii?Q?0Hmf0XK01x8pkaeNGj4XvOkiZ0IUXEcO/xeC3OQ1Hdf43N6fMObnoCDKFw31?=
 =?us-ascii?Q?zaNf8iQoOy3fmNvt9fmit1APjIuV4yaa9HaCWN/a9q6y13ansHwoV8doYq2J?=
 =?us-ascii?Q?GqDPtdlRyURNzbSTxqQBVa5KG8mdJNCJP8Vmnt2fX21WyhsokQbstEQkcXjT?=
 =?us-ascii?Q?6c8mzePYbylM62TNXv2Knj4OfJzuI+HLZxVEwcNZ/V/+ndC2ZRwajymPYXUH?=
 =?us-ascii?Q?rRFbp6TDL8SJ8ul3P86C/kkS6YuLAy/Fm2rKELw8VRi2vTlDmovbuURJeGwo?=
 =?us-ascii?Q?2ZHhOsZQfyLluVl/dMFf1o/mQcPgfMtLIbxGw8QBtR4ovdEgFoRMk8imHOWl?=
 =?us-ascii?Q?5IYrkeiIeuas/sBm5WxLxurkqqchiRxHsfh0SgE1NTLLWYMwXJK+YiC1s8bh?=
 =?us-ascii?Q?AG2GVD5WOKQX2fHy8GZxf1cdSysC8ruN/5sLMK6cbWFwNjyuWcQlQb1o8BPQ?=
 =?us-ascii?Q?a7+HNlGXbURW2qSZ7p2DNxU4ZP5Hah12x8fEE1u9SLJOrXC0iuhwyWIXitDQ?=
 =?us-ascii?Q?vMInBndb/jsXz0OOAT+Qn/tGzxu91tpdmmlASdh2Z5FuqAPN1mWnimYfa61W?=
 =?us-ascii?Q?3AqL1WAQttdvio+6KESGY4RK3jnSt7YwKsgY3iIzwqbswdn53o8KEiL7WzC9?=
 =?us-ascii?Q?PAzfy/0j/uZzTr5fJiDuLkoiq6mkZMnvLiYR66Rth6gRJzkp+btd17PBnbrK?=
 =?us-ascii?Q?aNtdwtjHpw2aq45L1g76c/0l2DQU8NkeO9N+AgAG1R84zCxqbMJDKQ4XUtQt?=
 =?us-ascii?Q?HjZGFJsCXL4ROODn3uk8ftUNBcfMROV5zOOCER/R+aFWLwDQf3ZY7RWgjImB?=
 =?us-ascii?Q?wQQ62BNNTxdMsWd9esw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78483b64-01b2-480b-0d49-08dbfc493063
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 02:05:48.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YhWtIzDFrhHbretSeRaEfAwa+vM2yq7xbm6KjkVAFn/3V7bm+E0EMlZczejYrwGCpPn06mjOkpJFutcIo5E5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8380
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 10:00:53AM +0800, Shawn Guo wrote:
> On Wed, Dec 06, 2023 at 03:12:55PM -0500, Frank Li wrote:
> > Fixed a kernel dump when access edma3 registers.
> > 
> > [    1.517547] SError Interrupt on CPU1, code 0x00000000bf000002 -- SError
> > [    1.517556] CPU: 1 PID: 59 Comm: kworker/u8:2 Not tainted 6.7.0-rc3-next-20231129-dirty #3
> > [    1.517564] Hardware name: Freescale i.MX8QM MEK (DT)
> > [    1.517570] Workqueue: events_unbound deferred_probe_work_func
> > [    1.517593] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    1.517601] pc : vsnprintf+0x60/0x770
> > [    1.517612] lr : snprintf+0x58/0x80
> > [    1.517619] sp : ffff800082f0b9e0
> > [    1.517622] x29: ffff800082f0b9e0 x28: ffff8000819a8af8 x27: ffff000801f90080
> > [    1.517632] x26: ffff000801f90510 x25: 0000000000000001 x24: 0000000000000020
> > [    1.517640] x23: 00000000ffffffd8 x22: ffff000800114800 x21: ffff800082f0baf0
> > [    1.517650] x20: ffff000801f90698 x19: ffff000801f906b8 x18: ffffffffffffffff
> > [    1.517659] x17: 6e6f632d616d642e x16: 3030303066396135 x15: ffff800102f0b687
> > [    1.517668] x14: 0000000000000000 x13: 30206e6168632065 x12: 74697277203a7265
> > [    1.517677] x11: 6c6c6f72746e6f63 x10: 2d616d642e303030 x9 : 72656c6c6f72746e
> > [    1.517686] x8 : ffff000800396740 x7 : 205d333337383035 x6 : ffff800082f0baf0
> > [    1.517694] x5 : 00000000ffffffd8 x4 : ffff000800396740 x3 : ffff800082f0ba70
> > [    1.517703] x2 : ffff8000819a8af8 x1 : ffff800082f0baf0 x0 : 0000000000000025
> > [    1.517713] Kernel panic - not syncing: Asynchronous SError Interrupt
> > [    1.517718] CPU: 1 PID: 59 Comm: kworker/u8:2 Not tainted 6.7.0-rc3-next-20231129-dirty #3
> > [    1.517724] Hardware name: Freescale i.MX8QM MEK (DT)
> > [    1.517727] Workqueue: events_unbound deferred_probe_work_func
> > [    1.517736] Call trace:
> > [    1.517739]  dump_backtrace+0x90/0xe8
> > [    1.517752]  show_stack+0x18/0x24
> > [    1.517761]  dump_stack_lvl+0x48/0x60
> > [    1.517771]  dump_stack+0x18/0x24
> > [    1.517780]  panic+0x36c/0x3ac
> > [    1.517789]  nmi_panic+0x48/0x94
> > [    1.517796]  arm64_serror_panic+0x6c/0x78
> > [    1.517801]  do_serror+0x3c/0x78
> > [    1.517806]  el1h_64_error_handler+0x30/0x48
> > [    1.517813]  el1h_64_error+0x64/0x68
> > [    1.517819]  vsnprintf+0x60/0x770
> > [    1.517827]  snprintf+0x58/0x80
> > [    1.517834]  fsl_edma_probe+0x2ac/0x830
> > 
> > It is eDMA1 at QM, which have the same register with eDMA3 at qxp.
> > 
> > Fixes: e4d7a330fb7a ("arm64: dts: imx8: add edma[0..3]")
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Hi Frank,
> 
> Did you see the fix [1] from Xiaolei?  It has landed on Linus' tree.

Sorry, not yet!. He have not fixed irq numbers. 
Let me do addition fix.

Frank

> 
> Shawn
> 
> [1] https://lore.kernel.org/all/20231110072531.1957891-1-xiaolei.wang@windriver.com/
> 
> > ---
> >  .../boot/dts/freescale/imx8qm-ss-dma.dtsi     | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
> > index 01539df335f8c..5d76b4dee4cef 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
> > @@ -44,6 +44,33 @@ can2_lpcg: clock-controller@5acf0000 {
> >  	};
> >  };
> >  
> > +/* It is eDMA1 in 8QM RM, but 8QXP it is eDMA3 */
> > +&edma3 {
> > +	reg = <0x5a9f0000 0x210000>;
> > +	dma-channels = <10>;
> > +	interrupts = <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
> > +		     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
> > +		     <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
> > +		     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
> > +		     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
> > +		     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
> > +		     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>,
> > +		     <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>,
> > +		     <GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
> > +		     <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH>;
> > +	power-domains = <&pd IMX_SC_R_DMA_1_CH0>,
> > +			<&pd IMX_SC_R_DMA_1_CH1>,
> > +			<&pd IMX_SC_R_DMA_1_CH2>,
> > +			<&pd IMX_SC_R_DMA_1_CH3>,
> > +			<&pd IMX_SC_R_DMA_1_CH4>,
> > +			<&pd IMX_SC_R_DMA_1_CH5>,
> > +			<&pd IMX_SC_R_DMA_1_CH6>,
> > +			<&pd IMX_SC_R_DMA_1_CH7>,
> > +			<&pd IMX_SC_R_DMA_1_CH8>,
> > +			<&pd IMX_SC_R_DMA_1_CH9>;
> > +};
> > +
> > +/* It is edma0 in 8QM RM, but it is eDMA2 at 8QXP */
> >  &edma2 {
> >  	reg = <0x5a1f0000 0x170000>;
> >  	#dma-cells = <3>;
> > -- 
> > 2.34.1
> > 
