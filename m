Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B657B53C3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbjJBNL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjJBNLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:11:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B897EB0;
        Mon,  2 Oct 2023 06:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6K2IXUpNGg2j1r/iBl362B9zP212ecD0jgmoAlQWaya8mTg7Sww0xREtAERiAOszJRcU35w2I02i7TAYj1lyHTwJ48d0Sn5daDdPikkUGhPpJ9U0s108XWxtqQQPEDtBw1/qVxHojmrT7TYFDvLHkenYMpFOkDedeE5jGdm4OI8dpjHgksQRRLcDqWOzIVzEek+Eouyqh3USQoq6q8YP4XGJKEuv9jJkmjTuIl3s8LuoZBKQhG0S2M5XuoxJO1KwMAvA94Khe3toXVXtqDlCzefZI+5nBe2QO0kp0Ut0PNT+SIttOLIxzIWKe2wtJNSHuz1aalLdctwikw2CpBgww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VrFUZhFXyPR4hIjgtY0cHd2Mcjy3483MCHW9uouLYk=;
 b=G5VydtPYlauh5RTykETXWsSpTZyptROecOhFlJZQj33XOXcXcc+97yRXYMn70qL/t+Z0y6pH7k4fNdriyWtOOd4i31T5Z/PQeXRBpVO79oWf6Atfl6pvDYYOoFskXNRRJPZSqJ8Z6sNHkageU460vuWhezXU97lIJ9d/qkwRRqP+zTu+Is6L4L8UPBEUddNiG51AERA3Ke8V1fZBXb54+0hYKZFBAYzCGaBXpUaCeqFAzgFlAin/hc2Ea+GIcCAnAxoYPfjpqEbQbIe6m5KqG2ZeHsNFqlPCMIRaaxwnMA67ZkBQLHFX6ArM5E0PSiy0yi0IC4fjw2Qc3CDnlqLJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VrFUZhFXyPR4hIjgtY0cHd2Mcjy3483MCHW9uouLYk=;
 b=fvbO47aXXH9ZRw9IIpx0S9SiJ9ATJIEfb+TlvX/JWnPiMLkIOPT/uFt7iPRYS16QHf/8rusvK6QXPapV6VcBCISrlM2XmOqKrt/e0JZ59X1fF7jxwOdd76qeIDvTMrPtd3M+MqeaLlf9rjh9SNXuGw2eg98uPCjZKpF6qW5dQjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM8PR04MB7329.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.37; Mon, 2 Oct
 2023 13:11:14 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 13:11:14 +0000
Date:   Mon, 2 Oct 2023 16:11:10 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Simon Horman <horms@kernel.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH v2 net-next 03/15] phy: ethernet: add configuration
 interface for copper backplane Ethernet PHYs
Message-ID: <20231002131110.4kjkinc2xyxtdwbv@skbuf>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-4-vladimir.oltean@nxp.com>
 <20230928190536.GO24230@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928190536.GO24230@kernel.org>
X-ClientProxiedBy: VI1PR04CA0131.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::29) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM8PR04MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: 5290f201-f662-4de1-ce34-08dbc3490e6a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kL8LOMOxs4IdNIDSHHW5Mqm/LNMpfileZ7mkdj4vD0XKpPTRCRAsGENwEa4qdPit2cGdaSdUjBIJPUEDryeq1gVj4ZGwfXJg3DSpygYdrAr8tMICujBd7W71UIiBTdO2UglV+4UpaGZ0iqBwhOv17Rcsuz/jBU4+ogSGx9hBmst1DYjzzhgy9LGTMbWCUY+c9XkaY6ahe0ruD4NJ4vrfiVqjDT1Ep9CbpVFmPRolXCvD/R14+9t1wIA/d/ox92RrdV5OdwZ7OAJ3IT/cL+29OCprMeJ3A56hMTvpp5gWZeMGSkoKvcJpWqKl8MWP077yybDMbp9Li5E6nYLf5pr6ctLjroAYnVQ4RkXWyo3EtI7JpipAdJmmH6WK6IJq5SBPWuc4Pg3r1hiswUJAhb4Ro9Tgv6N/oYrzDUUDhPu9VRlSBikmtIvT5gCYnLsWBG63In5ksRec1ZG0BzkR1j/7z7Bf3D007r7boIwlIJyKW77HhI8BkiKAWFneeRD+WvQx4cXadxNR3EgPN7t/BzQjmJssFIHayG+JeWARlCbnZyDbDHzi4v9H+RWXrbwndOxn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6506007)(6512007)(478600001)(86362001)(26005)(8936002)(38100700002)(1076003)(2906002)(7416002)(6666004)(9686003)(83380400001)(6486002)(44832011)(8676002)(4326008)(41300700001)(33716001)(316002)(6916009)(66946007)(66476007)(5660300002)(54906003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?85CkgoUJl32dgQ4hDhxKg/X6UIjXYgDuopLYKekGLrKF6oR+POOEeexH+8Jh?=
 =?us-ascii?Q?w1nFyhfjlQiOpSzT8WmyePnp+SlHNfWOyMeh/km1TfE69gPlI0HEH1KCfLFT?=
 =?us-ascii?Q?/JDwvDBDJK0S1rPg+Hl4XuU+gnq492zODbJXBcpGVI94nwZkO7izxJ+r9Whq?=
 =?us-ascii?Q?L3c2SnXboMjH+AOPaXQPNLGyVBVDF/Q9pXhQk20ADjmQBVkDPngCl1lpVOlb?=
 =?us-ascii?Q?w/6+yyOU/iIhhwyKV/x83mzIqZ+HuYVbifc2D5LIPCH3Nwdqqb+2pfQ5pLMP?=
 =?us-ascii?Q?VkvKDwdD6v7JzTTgXwVEFB1FjYf7aaTfmTe3/A3YpovYWte76oJ3h1pBxqe5?=
 =?us-ascii?Q?12Jf/RZyAwRMD8tyMtbXXyRWTZbgtKTnCH27gUUUR0zG9cWScFEQBqP1JDO9?=
 =?us-ascii?Q?gq8pJQOHF1AKTb7zx40sjDwbYYGjsGov8J9B4UH86yy+lbTKlxoyixQS5p7G?=
 =?us-ascii?Q?ZoShlDCwKnaypba/aRg80TGCUAB2Go/SFRcmuJdWEr9UHETbtynDcPrgZAeI?=
 =?us-ascii?Q?Oo8kY1RqIT/67FrI4Sn8rDtuv+oXt3TieVxef+/PU/NHsX+Q+Hm0qr3iBc3A?=
 =?us-ascii?Q?+y4vRsT48MFcbZsvBmY1Rj7tx5qOxLKQB88a1BPQG6n+nuyGGEfpnGA/s/7T?=
 =?us-ascii?Q?5rvJgeY5UxpZlTDTnL6pHn6P6sDmauTo4F1UE/Hmm7EnYSpqY2xubodOPnAR?=
 =?us-ascii?Q?x9wM1HbPXtImBOfqKsTWeyIZKx4St46oR06A6CE2iGp5RIxPDfQHBYanGE0e?=
 =?us-ascii?Q?4Njf2wlukznsuXBDSi488FJCfTq5wFRlXw3DwZ9W/NTdA0/BHvqw3tHQEhXH?=
 =?us-ascii?Q?OKwKiFiKi9CJ21UdSWHvDS8xc3u7Gnw6eOkRVmHwN8hoDaYI8Ye3TRJBzCxG?=
 =?us-ascii?Q?7oAFME30ilxwKg6gc7Q1iGigL1eNFj3lR9as6ASwcqNlkIiBQD5jRPhLqTXs?=
 =?us-ascii?Q?ptPKt3A814QFPWGoC2WmtpO0mrwp52fTJx7GGEwbZOufUnvkT8HOAYjmDIjc?=
 =?us-ascii?Q?MG+7d9v3oPMOSJCRJdrxEwOM3OreA39+rj78kwytnHgV1xnbggs3SfHmi8Cw?=
 =?us-ascii?Q?LX+Fe+gEyONYthfQkxWQ2dVwcP8sN2gM4Auya9QuMb1ufTxXfom0YAFXAs5Q?=
 =?us-ascii?Q?qjk1DDKT5ihEa9rRhdrv2qOyofZem4vzm2nw5dxTL29DB6ctUh0NRGNka6Vf?=
 =?us-ascii?Q?8ytjtHJjE83ceMy3wJVuR3B/iWapT8n2Pb+ajEfKaFkYAmrlZ15ldJDR4SYt?=
 =?us-ascii?Q?injjuBhL/sv+6dSeCixEjCDNZ8M9euBYX1dnnELudlBTf0TN9dIwZW59cl8h?=
 =?us-ascii?Q?s7n9GTJz0cOHL4QbjyBGx/gsOgqR+6IOWveI75TecEjTcvmnLT/rHsa/uDr3?=
 =?us-ascii?Q?48+CrafbbtHDQLYtDW6eDMqbZPduR6y5kJDvLV0Ls0QNxvFI2N0V0TE5iZ3v?=
 =?us-ascii?Q?9yXIPiy5HZA9y/+rqQW7wMdyJ/MIBXwXJ0G6LSg6j/QxOG3gZmpLKZUDhE5O?=
 =?us-ascii?Q?UVsb+zodHl1WazxtpelB0fDpoX+TsleTKvUnRVjY9JWhoLaO50S8vKCI4QaJ?=
 =?us-ascii?Q?mHuQZi0xUIMyrqNWybtWxta5EpNA+YYzBen5U0Skjxae7xv29UeLBITY/Dmi?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5290f201-f662-4de1-ce34-08dbc3490e6a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 13:11:14.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVrGd9YchViSDDN36wGHWbkEMhACSUEcDw78aEqKgaHWUvBPKRt8Pk4TdZCAZFGCSXd7kD8YPXdjhC+Uws7OOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7329
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Thu, Sep 28, 2023 at 09:05:36PM +0200, Simon Horman wrote:
> On Sat, Sep 23, 2023 at 04:48:52PM +0300, Vladimir Oltean wrote:
> 
> ...
> 
> > +/**
> > + * coef_update_opposite - return the opposite of one C72 coefficient update
> > + *			  request
> > + *
> > + * @update:	original coefficient update
> > + *
> > + * Helper to transform the update request of one equalization tap into a
> > + * request of the same tap in the opposite direction. May be used by C72
> > + * phy remote TX link training algorithms.
> > + */
> > +static inline enum coef_update coef_update_opposite(enum coef_update update)
> 
> Hi Vladimir,
> 
> another nit from me.
> 
> Please put the inline keyword first.
> Likewise elsewhere in this patch.
> 
> Tooling, including gcc-13 with W=1, complains about this.

Thanks for pointing this out. I guess you are talking about the c72_coef_update_print()
function, whose prototype is mistakenly "static void inline" instead of
"static inline void". I cannot find the problem with the quoted coef_update_opposite().
