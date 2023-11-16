Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7517EE307
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344087AbjKPOjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjKPOjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:39:22 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2048.outbound.protection.outlook.com [40.107.241.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7C1C4;
        Thu, 16 Nov 2023 06:39:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dac6oB6XbsEzgP5UYzOKs8/gVpDIE2HWG4Bc1netRZfP+IxdyW5SwPya8klIFkpRMcCzx3Rp9Gb2eSO7wg/3aYzV/zREmSSs3094vfsJ7hdzIrsLdf6FRlh/vnbCAr99oq3oq4kT8xVwX7pYVtHDM4g2HsT2kKF8APlsnNksD31q11cSRsNZmSwmzNDSM0pAUHLW2Hb2hhcYU5pTXuQ04EnviZQ4lnTzkVj82VXie2+rvxAxUN8c2K6rGQJKDL34K8SL6SfgXd1RMVUs0BVe5iLxLOGrVAegdWxBO/RS/uYLK7v3t5T4plWaUE1ClY0QdjeaKssuAF7ZZ5wmHFnUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqRoIkmRqBso5fRfq/80W7PUrao3Mm9xEwTtC30ov8Y=;
 b=LIfJccGklxELDsjX7443riNJepYr0GHYNYAzU2FLbIHg/HuzerHQs9egSO3kdLlGuhoVyCjpo2AAk2+le0y6HI7eOmDgSxHEma9DsmIORXky2RZGemUhFuEbslllIgKt9ZnD+JuEB8WzRZhfYyQ25UrQrF1AzJ4U1K0Pv3jQTazQx7jlAdvqscqL0Lg5svnIgINimNQGEV/BE36tPq2cqTIVmlk+cKnyKXnw3qBYnuZihpTeVSPl4Jve8Se7vBSjP3F55YWS2YNMlpyW/VQBNRbJFm7beQi050UJznL2tcKrdo5XpuSs81J1E+OYce/1EBuAAsd5IeMxUfWR7zcNGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqRoIkmRqBso5fRfq/80W7PUrao3Mm9xEwTtC30ov8Y=;
 b=YwDOT95BmI4V32Ef9W5AKSSDMD2Ph4Ff8wcZSWMhJi6Micl78nlS+nh5nLidB3X+hecRvY9Tto21496KJWeg6k0Ssu7hl+dk56uykL1X4QGxH6zAv8IphtRFV+rKPxnr4zJhqXs0aIP+qD7Pr4+TZHYqEBFT6bA6ph+dteS5nls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB7070.eurprd04.prod.outlook.com (2603:10a6:800:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8; Thu, 16 Nov
 2023 14:39:12 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7025.007; Thu, 16 Nov 2023
 14:39:12 +0000
Date:   Thu, 16 Nov 2023 16:39:05 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Wojciech Drewek <wojciech.drewek@intel.com>
Cc:     Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH net-next v3 3/8] net: qualcomm: ipqess: introduce the
 Qualcomm IPQESS driver
Message-ID: <20231116143905.fovty5c5qqfo7inq@skbuf>
References: <20231114105600.1012056-1-romain.gantois@bootlin.com>
 <20231114105600.1012056-4-romain.gantois@bootlin.com>
 <59e1edc3-2ebc-40a9-a05b-cab02e8b0c10@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59e1edc3-2ebc-40a9-a05b-cab02e8b0c10@intel.com>
X-ClientProxiedBy: AS4PR09CA0007.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::8) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f0b436-79ea-407e-731c-08dbe6b1ccd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ma1zhqhK5GwCPmM3Sknz2FOYRYl4yTGZ1AxiE3nVKHrmG2n55WjNWEl6MtEUob3e/TDko1pfoc6DW2hV7uqfOZmCGDMHnJmkqcxzKJzyGuTGpguCgYYVmTIV0gOKLgR+06jNNSfU6Oktu5GOKyd95fIADyEkFX/ysKKCa2hYQ2nYw9aceoZWmbl2hlVj5Jxtf9LD4b2YULQElmFuKDhQd1+Gcx3oZAhxU6lfMo+kZpC40APW+GknTjsln6iwwJzoyJyd/uQrYLXNQT8ii7KbCdYqdf93O6ybmLoEY0yq+CLFE2h3aopZvvgLnyT8d1OiCwQ9MDyFLbK0rpbClyUCWj6g6wndVkbnkQnZ+Z7zmtYYJX4KoFnNyfCW0rQXuhcu40kX7Zj+nu17RCnz+xE3a8bvi7t0BHG68bdGWNT0/pufFQk9Fxd5z8tcDQNUMRPvyL7vjOSROp0F6OMVgoZQQmmL+LN3tV4H4PzPWYGW/YkMj+dh2me2RORUmca8vXwkNmFXKpzQs9QkK8l+d76jJTPFS0v2fa1KlRwE6YJKm9wYv13Fg5UJKuBVlHeOMpX7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(230922051799003)(186009)(1800799009)(451199024)(7416002)(4744005)(5660300002)(2906002)(44832011)(4326008)(8676002)(8936002)(6916009)(54906003)(66476007)(66556008)(66946007)(508600001)(6666004)(6486002)(6512007)(6506007)(9686003)(1076003)(33716001)(26005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cIJxVeyJJcXqkAP2+mVKPvOln/9EogRbXwiGOdsPJKpyjRmTGWiIESvllnde?=
 =?us-ascii?Q?i/EvlpZo5bXLpx5k51d0tmv73X/B8zxtceqOGrvxpJn+aCF+wpY4/IjdXpbw?=
 =?us-ascii?Q?LayRnJ1EePytcQuW4LUPfy4QTadIFox7LvEz7aB8l+sk4FCbNAxNV7dipRcl?=
 =?us-ascii?Q?FU+ZVRCx4iyxw9DunmFEbsOIp43/69BWEmne/iCq591zCf2mc7SDGrXVFYlb?=
 =?us-ascii?Q?UDvkcYG6fLuexHb+JhwzbB+DfIek3xWAVAh+yPXE1lsCzSAixY9RXUuJpeF0?=
 =?us-ascii?Q?9eOGf85tCh5Cp+MCxJDRAiyF0e5mdtue96BaCH5ZwkHyo6wyuBOFvWAqQL08?=
 =?us-ascii?Q?gai5hoIsuE+X2r9ySGk5VnZR0HWKcSp545B4Ov/i2qBH8ui+wYHwA9oI6hgN?=
 =?us-ascii?Q?xUhSDz1mnRVNyBRGCFJjlT4VxbYb6Fkfk1wKHFCsjCYakn0DNoPXlD0FqA5Q?=
 =?us-ascii?Q?QZ7og7976ABECkClRxGCtCFuu0BPWFji4vpj6LWYLS5LVZ8SbjVI4XMkxMYl?=
 =?us-ascii?Q?9JSM/+kepoLFgusU60evbR6fgHimg9gyBFb1e82sK848Of5RFB6Pb6JZ2+xV?=
 =?us-ascii?Q?9dkhIp4ifVyerQ3lvWLp53YkKb8LNFhz2V8XeL8fkEMx2H+H34dGx0EvdWt/?=
 =?us-ascii?Q?kdEUpwj1EuRJieWT3zgxZlkla/gyicfh2aw89u9XM8KQeeq+NvjUNRrP3fTY?=
 =?us-ascii?Q?HgXtZhZrlIVBZLH52DE+hKgjVkZJDNFcGOm1SPUy7HUI/Am0puCx6EpRR5Qm?=
 =?us-ascii?Q?srFmdt6Lbus8lb0knRNfV4m1QT+JA4NarFm3p4dTPPaetwr4vWxNXbb2PmwW?=
 =?us-ascii?Q?OksM584AYVzJ2axMBiqjkQPnrg2lA+CpsZRrRDOUcEKTKXO93AJYhnenoqXg?=
 =?us-ascii?Q?ci17xzY5c14x8hUmyIYCCsyCuXc+c2zWs2tcF71OLs1NYwPghFZnT/68ojdn?=
 =?us-ascii?Q?/2jV+IK+4GNPW6rvmFH43FGNUZVRLREqy2FNnBKcrcdjCt6HmHMb8yKBYjl6?=
 =?us-ascii?Q?Zvs8pKf3OfeyzMEksNgcbKyB0bPGixk4o1l3u0OgWvN2iMTEWSwEcZweKzqV?=
 =?us-ascii?Q?i1zlnRO59K1VAPeSt1x3s2eV2n7FHquG1H2mu2yc4bU5itlaUEo7QqCnWuHR?=
 =?us-ascii?Q?nCq4NzWF9tUsMaTUz4uX3Wl0W+iYw/q+79C2TFV6m6z19fbed5hU9sEh3DHk?=
 =?us-ascii?Q?ynJtmc+09VpwdeWRPicw96AO3NXFu0znkQVrWcSZtHWJ8rjFUJnayTxo5zEO?=
 =?us-ascii?Q?660/woBRDi3Gb0Z1xHSeFaGy1uqQn7DN24Q+j4ISsrS8W8/d3Kf4OTOzAkHw?=
 =?us-ascii?Q?k5ep0y8boVPlCiMSCGs8dd392vkrFmLicC/T09NruRxoPd7USbhvms+rccl4?=
 =?us-ascii?Q?H7f5fKS2GQIiktQNtXYUO5A2dqzDHmF4srOwRRTCShH1+pSh05e7dZaoK+ee?=
 =?us-ascii?Q?BczX0TUFzZtR3Kuo2XT7gfcR1cXVRyX/2NzsUMicSYmSWWLIQ9Kcb9bSm/fr?=
 =?us-ascii?Q?g8suLa1UvmjNseyE7jHUAT9F4IW53H95lmQ1LqZOVUfnj/5iHboCCSiWSYki?=
 =?us-ascii?Q?iP0djEsADBWaO8mb3hUrz6OZDqRhdmmoAX1i1m7i2enQM952DktJibsdgiAN?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f0b436-79ea-407e-731c-08dbe6b1ccd3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 14:39:12.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+m+JUvYiBgv+gOCsG4LHmoN38eI5C4nSUU1WT6TWF9mO4wNGav+5h18Eu/pPw4BUDunwuoEbIJly/BuvsYL7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 01:55:07PM +0100, Wojciech Drewek wrote:
> Hi Romain,
> I see that you splitted the patch, thanks for that.
> However it's still too big IMHO, edma ipqess_edma could be introduced in seperate file e.g.

I agree that it's way too much code in one go (also too much code in
general). It doesn't help that much of it is blindly copied from DSA or
duplicated from the qca8k driver from the without much thought. It looks
like the EDMA portion could be separated from the switch portion.
