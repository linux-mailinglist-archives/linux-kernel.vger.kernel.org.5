Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5825C7B6E59
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjJCQYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240418AbjJCQYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:24:21 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17B6C4;
        Tue,  3 Oct 2023 09:24:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGRS4cHmVTLcjrwZV59JVF/c4Tj0MiYVnz7tVD12w5+q0pVYSMtIR3Vxdga7+Faep3VYnyjDtELqwlBAUP3K39Fzyem+J4Q44YeGfQsDrr4D3MAs58BqZ8IOZ5CG4pErIwnWZZkWRPfnCNyw2+t+554xfkACP3XULPtN56mVDR7i/hZC37ZswbYFS9+V7lKsNgr1eGBZ+kOzEdQviz5XvsqHmElMTHmPOdersYrFZecLkgg7lermC7bw8P2m0gHhzkpbipJpyp1yYB9nmQQweYKJFplfWQz7Jhs9ZrNoxPklCPbBUi2kwdyLRwvchwml4zEyepc4RgYdmVNQRMM6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0P8jYZGDPZ8G/D0sJ0KJUt1cJiYPX1b7OrSJgTHbN9g=;
 b=lHFMtf30NRv17HqJetO1R7anTbEi8Egcy/Z4utP4QVA302KENdVydjDmQnp5Sy5RtrCIXUAb0x5TQq16nICwXf6mA6qd2WdpDJjYT8YADyTO9f9+M/Wv7Pbbp2XXBb7nfAhG+3i4E6BQpkv2zueDtBPaIeqIc3BEDMOeYXVYA1PS/HbVLv+ImUgWaLpQ6N4WD5SoJZfb9NXyz4P1V104qhKGqs3OOQHr36KynBngMCdfXSzlbEvg4F1Hp/wwkSszBPsxq3Q3Etd8L/pUWNF6Yue3ELdaIrnrpGCfZIAAu3lLjjdMnUyYHpdGFo0g6E94fIB+5GFd2kyZgqxWJnatog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0P8jYZGDPZ8G/D0sJ0KJUt1cJiYPX1b7OrSJgTHbN9g=;
 b=hvY01SBiks9zyXx9WO2PJHAzPXyZnyLJiwQDJr7K4XBNlw2xaI9KWcN+1yRyjWkBi6QiAhYhnbPiRQDl5E0C2xnCulceGhsAS9p+lFsECqPobjsP/QCmpReKoVKoJT8EMP2/aRt8txGU6Rcho8RStqvrz5+jk+Wa9eNEeQwXupI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB6815.eurprd04.prod.outlook.com (2603:10a6:803:130::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 3 Oct
 2023 16:24:15 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 16:24:14 +0000
Date:   Tue, 3 Oct 2023 19:24:10 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
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
Subject: Re: [RFC PATCH v2 net-next 11/15] net: phylink: support the
 25GBase-KR-S and 25GBase-CR-S link modes too
Message-ID: <20231003162410.lnugwuooxd25o4ax@skbuf>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-12-vladimir.oltean@nxp.com>
 <ZRv7oicdAgyzZYPi@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRv7oicdAgyzZYPi@shell.armlinux.org.uk>
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 121e5db6-dbd9-42df-dc48-08dbc42d2f1b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTBTh2wxwEwnGjsRkMiNXuMwGA9Toj9t4+/o/rVlYt/nRUJAotUSxve7zxVxdoFb/zdYbrT4OxXBfPx2i0Jj24vtsfzdRfMT0w7XNk+5fUFzsgR21zmFSA6mvodMD1DgYPKjGw3ia5eoiqtXOpexOpVLLMCBYQ8bSKaGtu+jFze33NeYM7VYhgfpBioAhSFQmypafc3BLmlk+U4hP6r4iWGiZgXZ0gavbhNbpJ0gvO8XMEnMYQPsO1MR2vO/J/ZvXz2YqKF7Tt10KmGFEUGSrVsLNLuVnwg2SrO2u+4uO40dRuM9//Rg1M63Igax0EkSJnD8IoNXIIHNg+AO1VHByVt51AzvfhS1Gjncf+4VtQ4sVv2H3T7nGGZEeHPrkAMNDOaXtzIuRrJojRUaG88J/2jOR73CvC5BxHm0kJ+ljqGO+RAQ4STVBrYWkofEg+BnyBn8ldANDWjXi+/SaPtC5DwoZhaJ/ijWrdFoGvilEtgWW5i6t8HB2gC7jR04nO4DUfF9r4uBTXGpXQxdn2ydNmCZ0TgtYQcEl0EXUdHxv2+qRpxmeAOSMF0HlRPhUos3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(39860400002)(366004)(396003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(2906002)(86362001)(4744005)(33716001)(6486002)(6506007)(6666004)(6512007)(478600001)(9686003)(38100700002)(41300700001)(8676002)(5660300002)(4326008)(1076003)(8936002)(44832011)(26005)(66476007)(7416002)(54906003)(6916009)(66556008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ItA9V5l47LeSUlfGF8h0F+5zGOQUuOJLKmVdwn3U+YH3fa+5836PWE12Ukgj?=
 =?us-ascii?Q?aT0k9O0HZ0Sigv3TOgDcv67yffhEMTI4aYxS2WOOA+KiG2bNCpg4tnX7m1Aw?=
 =?us-ascii?Q?anLvjK45xNa5QGzlU9tdB/IqRq43Pzw1g0RBCrQ47BxCutKHqDA6f94ccpvH?=
 =?us-ascii?Q?2fIBAydz8LxLpmVaCmXPQiUNrD26e5jfuQUb3MnTnCMU03pSJOLCml6s91UB?=
 =?us-ascii?Q?FjTyL8KXaL0hot2ik9op82rRa060dndoxaLJMkJH1/MQEeoK46WuXv/LXDe7?=
 =?us-ascii?Q?6GwML3BKw1yTAjPX1RrzyzhQcOHqf9f0gi814xoWN/oYoZM9TicErOQ2RXMM?=
 =?us-ascii?Q?sfpT15FNZfbAKa0vUWf+xkFpEEd+VsghN0MwiDh/nhnCsoEoWrWOKsRYv8a3?=
 =?us-ascii?Q?G3QwmTeJNZY7m5UPO78kdvV1tfWwKYa9JTnyJAkgdE7U2l2VHIcc6nyzd6C1?=
 =?us-ascii?Q?6QGu12PLGdODMeneCL8jn0fSuLtR9nd1FulKCebgxtrM4UL2dJAtC64m4iM4?=
 =?us-ascii?Q?hptk350fU+jlYS3hrQlDSfbuHckI4SS4eDG4t5PbkXzWQXMBTxT+v1iXbJH4?=
 =?us-ascii?Q?qzWjizfYXvS6Qq0yYlP/k0BmwtrzhNjUJ75gWuDqQVcs3DmEB2hqsCfGVsUs?=
 =?us-ascii?Q?igN8VCqH2XYaiYExUFnGZVJFz9RoxqQoAxCwpCwrOUs/eUjPtBzxnaLB35H4?=
 =?us-ascii?Q?zEPiXVUnXVcmFzbH127mmGbYVtwtGT95tr1tW+XSRn29I4efhRoXxAHkV4VV?=
 =?us-ascii?Q?uHeybpYYHXtmEg3S2cPBcLtqsLk0aEiGPxsstsFvmR1Pedo6+lPCNqNZ9F8j?=
 =?us-ascii?Q?ZCSSETDgFlEn8y2xTA/rkFO9jCfhyCH6y5Fm/dNA3LzzkXErwll3061+xccy?=
 =?us-ascii?Q?mnBvnQ7jDCzjnH/QU17J/pnFDXIGfi8A4u+mLcNvAg2OHhYAwUNEunx5qJUO?=
 =?us-ascii?Q?vJ/VEbz5oEqmRDApsVv3sBbyRc3htKRMvUq4Ev84A6cT0TXwC4ZlIBbqrPxC?=
 =?us-ascii?Q?3nTuVgcKUn/6agqtMoKzvsxNpuDeXRvUSZV0EzuBAGybHyCTXfhQqbAbr5Vq?=
 =?us-ascii?Q?nX3gvm6+gFw246DhxByWXsSeMAEtp5QgrrKIyRUMMkyZI8Lq5LzSgAwDXkWv?=
 =?us-ascii?Q?EmOSfacdRpOVhTCVzVqWbeftuXWvlpukyJSsy+k+KzkxLa2epNYM/jwOUutV?=
 =?us-ascii?Q?V38WwrqK301+hhqnhqf3COqP2RFLb2AtKQ7qdZ16Q1YFwZ/Fbh/1hhPMi7KF?=
 =?us-ascii?Q?NKir0tBn90o2rIafJJT/+EGO/WBxUVbz69aWPhrzzmVEBwdlHTBn4Vn8X5+4?=
 =?us-ascii?Q?f0rSjSbwauhvmmhbFPlzb/662/+cXx5fon3vIHwEGAAo21gtKG+zVicR5Xms?=
 =?us-ascii?Q?GXX8K4a6f9q31LL6ROnkRy4YtnzKmyqX5cADxTQVyrAXbzuOWt+RS+JPJi91?=
 =?us-ascii?Q?MNLcJLd5dIFnml5d4YzKN8kIUJtPDE6N3lUi66NlHK9TkBXPW7H5yaBOyzpP?=
 =?us-ascii?Q?T8L1pcV1VkSFU0hHFNOBDTlnUTnkIwkiHWvF1qOyHa0C2yXvBbFAopOZBFxy?=
 =?us-ascii?Q?ufPXnsNNp5GsGHgdyleumZLfmq+tb//aTHb/Yf/hB73TV9qXtPOEYBEzUgfs?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121e5db6-dbd9-42df-dc48-08dbc42d2f1b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 16:24:14.9467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWx0YSynUU1rwXnqn28ydfkxE1Y+vNWP64ZJ1hwNKt+HOFN7K8XkducfKtuKo7O54ioO2TNag35gV8ziGRSF5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6815
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Tue, Oct 03, 2023 at 12:31:46PM +0100, Russell King (Oracle) wrote:
> On Sat, Sep 23, 2023 at 04:49:00PM +0300, Vladimir Oltean wrote:
> > Treat the newly introduced subsets of 25GBase-KR and 25GBase-CR the same
> > way as the fully-featured link modes. The difference only consists in
> > RS-FEC support.
> 
> As mentioned in the patch adding these new linkmodes, I wonder whether
> this should be part of that patch. Is there a reason to keep it
> separate?

I can squash this into the other CR-S/KR-S patch.
