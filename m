Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F30C807513
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379341AbjLFQd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378350AbjLFQdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:33:51 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72503D62;
        Wed,  6 Dec 2023 08:33:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWdO5lc+BpYfblok938ad8GSDSDTL0hJhDtJgZPiWr6t6S51mBcvP2QLjRnNueALg2Y/fu5cR4I45DFoT07ooItb4xbIwijylr4Y64OvI6tOMugUSshWKoFWZ8ZPY86kNPscHrjRop+gEYRutiSvkRiSEQTUluj4enLmHPpi/HjTZlLz0KdKWDI9nZHciWy+1cfvSZmT7jPcb8wRlTNHUsClb6aW9qyI1xHJmAVVBMtK02e2xFF1Wq+6ypcfGsSYvZCcQO3woVAADxlmLcdDfzaq2Z6pdkcDot4YmYMU4fpPVAZZ/D3G1aMyv2S5PIKyBhvR4xV6L9g8xxFUb32aXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICjt0nl2heXJxLrfQ/1nxwHWQpfrieMigj9JAiXbeG4=;
 b=RINKjFk82SJ1SNo5L70pYEl+SLHlx/5DFMJe+5iLibN9DYL0ZtejCiNU+5Chw01sZsx8cvApwY+GUuMCCp1CEiJRbttln+8kpWtKv4sGga4y+PsZwluwbtDNwD9bN0cpN+ujkTU4c4kG+DVK6qvWzmqvAP9w1qVmLAS/xK49V3cq/sNUz/yllhTeSpjUdSrGptTE+Yvj3XwJ3i5b2kU1i9gXWlWSCjXOTw9ciCpMVPayZEzTiklR+aGWR0QM4h622nmm/B7jAnYX3nG02Wz1tj2+Lu6qDhWbNC2uvckVopYWDeVi4WDzUUCxVu3IjoMdSYCF7z2afF7NG2KWNrEL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICjt0nl2heXJxLrfQ/1nxwHWQpfrieMigj9JAiXbeG4=;
 b=s2Rv5NLvBWRw6iSoo9m2mJ/39hCgF1BF9uuJR3yAI8B0pISPVv4vxbtfZbUhjEaIeDS5PjOo7TxTd6ZPT3M7x9vqbRMRloxj7maqkae1vKTiAqw3EPiVSI/ZJ46pZUpjIxIA6B0mlfZNb4mY2OSEJMHq3EdPZIT4j6Ag2184uto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by GVXPR04MB10023.eurprd04.prod.outlook.com (2603:10a6:150:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Wed, 6 Dec
 2023 16:33:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 16:33:54 +0000
Date:   Wed, 6 Dec 2023 11:33:44 -0500
From:   Frank Li <Frank.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, robh+dt@kernel.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        alexander.stein@ew.tq-group.com, alexandre.belloni@bootlin.com,
        conor+dt@kernel.org, conor.culhane@silvaco.com, conor@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, haibo.chen@nxp.com,
        imx@lists.linux.dev, joe@perches.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-i3c@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, ping.bai@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, sherry.sun@nxp.com,
        xiaoning.wang@nxp.com
Subject: Re: [PATCH v2 2/2] arm64: dts: freescale: imx93: add i3c1 and i3c2
Message-ID: <ZXCiaKfMYYShoiXK@lizhi-Precision-Tower-5810>
References: <20231017194657.3199749-1-Frank.Li@nxp.com>
 <20231017194657.3199749-2-Frank.Li@nxp.com>
 <ZUz/8fBWtnwdSW9w@lizhi-Precision-Tower-5810>
 <20231127022140.GJ87953@dragon>
 <20231127-cherisher-falsify-8193656e8872@wendy>
 <ZXAKp1WS97cAI5X2@lizhi-Precision-Tower-5810>
 <20231206093106.GE270430@dragon>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206093106.GE270430@dragon>
X-ClientProxiedBy: PH8PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::22) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|GVXPR04MB10023:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5596d8-5adb-4fda-d326-08dbf67922cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: toQsftUOk4pN2O3UHttwynxbav59r4wnlUUjvMtAqgqIlf/NT6tEVrG+Ew8HsfiI0zr6S8shZxk4P5FvnRBUBDVuvMhspm0M287g+USCmOAh3F/BUTHstnQ9RE6HQ94QMt2zAL2m/bgBxxOqnMwFGCPXzHypelxr5v9nAgqszrzHLZwTzbGb+26LG78rEVVC02JzrSzbQkUxrsjOC+wZXT/OOVKpA6RFuhXXg3lCe4ac95q0jSQUhsR8iS9ikFnUwDJ8PiIUOas/2C2CUIyA7cRStvzuO+E2gGqlUqXcJa3dc/e0B3nqk52b3wBcBYx5n8Yf3g2arq+Z4Fvk22iSitPVxKdtAVvKhMJv4EXisg441Ms5gxgF8MOUu+FYlWswokT11Gs/R1N6lmI7Y/b/VZ9/CkeEEAnhTaiweq0+Hey1m4HucrH1owARDbXzAqs2fk/H448k5bQsM7z/XIwlqj+gnshndueE8JbHs3xsgcAHIHv1O5SMbxkZ7ezCqZm0en0IurH+QsKi21/XTR/WH4j4itQGyN1nUzAUwv5N9Zby6JgC6NUfd3D/I6aaC2rkCiKBcG2rWeQHomav31hkBg8N5rizIXbg6bBl50B7kF5GmyitWsIALGYOWCf3zQbb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(346002)(396003)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38100700002)(7416002)(2906002)(5660300002)(86362001)(41300700001)(33716001)(6486002)(966005)(26005)(6666004)(6506007)(6512007)(478600001)(9686003)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(83380400001)(316002)(38350700005)(52116002)(138113003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nYfrRwhGJhza8d0TJDgtD4JhzVhxh2u17xfw/t2TQhSW/Xz5FO0bKZXN0aPm?=
 =?us-ascii?Q?SzT6v30mqMpEAypBarsdKy418z8e/6D6lq2xwCH7wijEJQNHCtuiNeX/Ufv9?=
 =?us-ascii?Q?hAm0vsPYbicvM2lJ688uJ0pbIR8jv6gH++Vovtgpi67KIO1hbLpp+EB3qzxp?=
 =?us-ascii?Q?Iyp+3CZUALLqPduWaj5Mw2/sIqCRx8+AaLMs0j0mpfopB9MUpwkg1wpf8vXU?=
 =?us-ascii?Q?umzlWEGwvke+BRot9J0bWuQAHKxtSS6vkYDvZddmddXMhKHnQLK5frpSU1Zq?=
 =?us-ascii?Q?qiV3dn9GpxTb6fowpKZ8MVQce1rcErLp6XRlj2/HIo+c8dgiJy7TqDeX1L3V?=
 =?us-ascii?Q?kIDVZLHvGwNkrxUK6/drbuQNBb1tmALPY6ZXTb+hSB0msOeyuPY9H9kBR4nj?=
 =?us-ascii?Q?eUgPB+Fdl584oGkO77V6tJUzSgI4A00VaectMSwba0O8L7Az4YWcqz0ahrdI?=
 =?us-ascii?Q?QjmPnFiMBeR+FrGusuOB8Q9xZ9ebofaqRWrxHVrvqsgwCyu5ZmZFRqAP3PzD?=
 =?us-ascii?Q?Xl6Rej6nNYBV39zzW7+fVefpJL+QTRPr+6LZYzjNbVZ5A/8TduWYkwx8W99w?=
 =?us-ascii?Q?X8LlzdT8advRnakzBwIJhPL57/m2oSa4WkZOxZjGIgT0skwDRbx3Re3qM91c?=
 =?us-ascii?Q?d5bBRq74if1Le5crk3qefhiBqLUCFP6N/i18P8uB2YFudSmzR1YRbobclWRf?=
 =?us-ascii?Q?r2yhuUr56dNuaPYe9JytfOU/Qn6KiwYei2TJS4ktZyPFDliGk5UryEJOzSne?=
 =?us-ascii?Q?V1MUBtpo6jEjvjepZ+GPpTL3GmUVoJlA2quqvwfUtXmykAPgOMIXrTk8SbIN?=
 =?us-ascii?Q?Nl2P/qhg22QJs1cpdapSDfgZ0cNmqYGc8ZNWF0khDKnpuekzIa9c414QY2GB?=
 =?us-ascii?Q?kMJro0LWmqX1fU4vHpACYOAEHEJZCuM1UO3buzvLfZdj//WkYjMw0Gu9nYUR?=
 =?us-ascii?Q?RbcDAA1e0VOhIG3/XlKYRB1wuadrdtB2t0eJaMEBoEnPiuwdSWeTJ1BTWeRA?=
 =?us-ascii?Q?yVHZwp4Wl/30o5O4stA+LlcUXMur1Rhd3iF0jaJjynGxaifs0o1d3iXqnIaT?=
 =?us-ascii?Q?ZcvZKqExncEPjraY8Akwnc+DSodeGQSMNnA6PuEHGf6Gic+B7d7RgBT8FDc3?=
 =?us-ascii?Q?7zEA9U+Gw5m6S10mASmO+tunQxmLN9YjAK3OYK47CQYDxUNTkA9PYiMY2BEY?=
 =?us-ascii?Q?+zN769evjGKDm3yuP18lMofk+edm5S9pBcVLJcKyXhWlOFgq2EcoNwvn9nlV?=
 =?us-ascii?Q?fIPm6iemmh3EX4ZQgBFjJrSnuZbrLpLmbgVTwK3sNi10ToRKB1Lg/lgQCO6U?=
 =?us-ascii?Q?LALYmabyvNlebf/2c3NHEstlVdM/LajV06kVzjISCx+UI6XkxBgpH1syr/9O?=
 =?us-ascii?Q?JTKKCxrtN0V3YChSxRFHN9ZVZUAEmfol7kILnBDW0duK1ll1aYOzGCZZ8m+g?=
 =?us-ascii?Q?E1JLvkix1VN929L3L6xYkqVcluT6klu0YuU8EA12CsPwlv0EMX61CE3CuIFD?=
 =?us-ascii?Q?z9bT3pwh4D8Qva778x2ThaRF6f22MTO1Yj1TpwYnoShsNvqg02P2jvhIoKwI?=
 =?us-ascii?Q?o82qjICrad17xXKyKbA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5596d8-5adb-4fda-d326-08dbf67922cd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 16:33:54.0640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKx1VWak+oTjAO+G4HPGDuFiUFvASbLTouLO3r+P1uebV+awBBZ+vRuKZZ7mGp2woa5ZPYL4wZmMgaFWDQmU/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10023
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URI_DOTEDU autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:31:06PM +0800, Shawn Guo wrote:
> On Wed, Dec 06, 2023 at 12:46:15AM -0500, Frank Li wrote:
> > On Mon, Nov 27, 2023 at 09:35:39AM +0000, Conor Dooley wrote:
> > > On Mon, Nov 27, 2023 at 10:21:40AM +0800, Shawn Guo wrote:
> > > > On Thu, Nov 09, 2023 at 10:51:13AM -0500, Frank Li wrote:
> > > > > On Tue, Oct 17, 2023 at 03:46:57PM -0400, Frank Li wrote:
> > > > > > Add I3C1 and I3C2.
> > > > > > 
> > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > ---
> > > > > 
> > > > > @Guo Shawn:
> > > > > 
> > > > > Driver part already merged. 
> > > > > 
> > > > > Please pick up dts part
> > > > 
> > > > Rob had a comment [1] about SoC specific compatible.  That's not what we
> > > > want?
> > > > 
> > > > Shawn
> > > > 
> > > > [1] https://lkml.iu.edu/hypermail/linux/kernel/2310.2/03035.html
> > > 
> > > Yeah, Rob's request here looks valid to me. Should just be a bindings
> > > change Frank & fall back to the "silvaco,i3c-master-v1" compatible.
> > > 
> > > Cheers,
> > > Conor.
> > 
> > @shawn:
> > 	rob agree on "silvaco,i3c-master-v1" compatible.
> 
> Hmm, not sure I have seen that.  Here is what I saw from Rob:
> 
> "
> The real problem here is not whether we have "v1" or not, but you need
> an SoC specific compatible. Unless there's a public spec where we can
> know exactly how many resets, clocks, interrupts, etc.
> "

@Rob:
	Previous existed binding doc is "silvaco,i3c-master-v1". So far
this IP in our difference SOC have the same resets and clocks, and only one
interrrupts.
	current existed i3c controller compatible string is

	snps,dw-i3c-master-1.00a
	cdns,i3c-master
	mipi-i3c-hci

	mipi-i3c-hci is standard. "snps", "cdns" are similar as prefix
"silivaco".
	I think the same IP vendor and same IP version should have same
resets, clocks, and interrupts. So far still not met exception yet.

Frank


> 
> Shawn
