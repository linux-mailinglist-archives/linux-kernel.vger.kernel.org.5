Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA0D807B64
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377262AbjLFWhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjLFWhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:37:03 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6133D5B;
        Wed,  6 Dec 2023 14:37:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etSfnl50lNDj9wxzUohjNm/BESHF2JBXUjALq0sGO3CkdBz95niNM9STzXVRv91u1jfKz+mbSq8MBZzyvOj8MeSOpJ0buDlDq1/fF8Yytw7mJH1zDgzuq1HXNVLJpYZHLE0X29DZBhX+a9yImL031GM7AuElRiSj54+D6mlXwj37Y5W0ZgDc25tUQ1JGA4TOsA9voGOyRUzBIhyDmnIyEK/4dEfZC3xmH00MVGS9i+xRZFa3vUSH2iuzg4PKZx6AuG+BupOQfAE7OPWzHlPlsvHCTNSWSVThcltQFLqDb+SazTE/wNGcVbXk/BlCIF9Da24kX/g92EhoaSJoMiieaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emkV2Ze9lvQUuPkJ3Nim4ocYL197W7N4WvUMBY6Nn0o=;
 b=eHEDWI/+1DxxKW2uvE+6Uv7AoOAiMQtlRKhlQQn22+AwD23KDbv+Vbhwjg6Sje4FoC2IOl3TQVlgQ+pbinGphXGr/IVoOu/wsGAVz93JmM/p1JlX4oZp2aIkOuLltuyUiLs7SD9Lfzg6LaySyFhJad8XlnLMSIqhOZJfU/XMKzua8DvGUsvQN+BUlA3lCCCveKEyXQIme8QPcirvzMj6xbDfghM5YJ9U18HRBMR9tOpEEm2w6VdB9GSOA87zzkvgnbaok472OoLu5EvC0ml5oXemxoCKS6Z9EIaqTPJkDuDj3AS8ywRwt8oRMPqavfN7U027gmRupiAdccuYGxNNVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emkV2Ze9lvQUuPkJ3Nim4ocYL197W7N4WvUMBY6Nn0o=;
 b=Bsy6ElbUIWGQG/h3B4qbzN0yLQvpq7gcNP/pFba1koTvYJW4llzM6ZBeXMTnP8kkOv5+x5nTFi0CBDOq8LpN4iLBurYPvIIeUtnDFCZPZH9e/5hQj08MajdX04TLWB33RRUUsXSmgDFslm4nlQlRmoiR18Z7OrUrusr1iOPPF/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB7506.eurprd04.prod.outlook.com (2603:10a6:20b:281::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.26; Wed, 6 Dec
 2023 22:37:06 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Wed, 6 Dec 2023
 22:37:06 +0000
Date:   Thu, 7 Dec 2023 00:37:00 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 2/3] net: dsa: microchip: Remove redundant
 optimization in ksz8_w_phy_bmcr
Message-ID: <20231206223700.45ta3kc45aac7pyp@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121152426.4188456-2-o.rempel@pengutronix.de>
 <20231121152426.4188456-2-o.rempel@pengutronix.de>
X-ClientProxiedBy: AM4PR07CA0013.eurprd07.prod.outlook.com
 (2603:10a6:205:1::26) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: cafc147d-4720-4e09-d693-08dbf6abdf50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fL5BLYxExeXe6RJ+JfnchtmitwkKq7AqcjPnk2lafU8sf4Q98UL+Z09gd4nmJJ0MUbDBI0VpPwVkte6omVJNZVgiRes4Nne/Z7gkkTeTCjtjz5Zz522AuoEhbmlX90BL1+24X+wrdRO8S001OEcdhey87SQMiUcEdOYIIcXD5zctJmZWA/Yv+pf4uV5qRfRXLdmzpIcQ3LIkulMta71bRMvMZUixwhW50l1tY8Vyec3g2hZrncdRVeiIYcMA7H3nhVCUppy91fSJLcNrMLEekeDYtCO3D/q/kFOKPbRgQLJX6JE4z17g2cUvIzygBiZ7wsRvWLhYdo3fyfNWgRZolRzTjU8SeSCAG8G17bPla6MMo6OBCyu9r4WSPkG/LfEJxU+5hucuhqP3v5UqurwmWJx8j95+5DlKne+n2UzdzirxHTr2wb8i7w6OYgMAH4HSdiBcKCg1h86IkEgVAsE5de4FC+mCuCTUiIOS3IgOmnFuLgMKbEbTCqVonMQet0Mc/MUGIJaaQZhxk9kX6kBV7Vb1DG+bny4k02M8TtqPv+yET1f4gVEetgOURgw/JEJw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(136003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(66946007)(66556008)(66476007)(54906003)(86362001)(38100700002)(6506007)(26005)(83380400001)(9686003)(6512007)(33716001)(1076003)(4744005)(2906002)(6486002)(7416002)(6916009)(316002)(478600001)(6666004)(5660300002)(4326008)(8936002)(8676002)(44832011)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r4LT+OR7svphHYj+1gg8+APWcOD0QR/3/icV1A30zIOvOhw6iGzsT5aI3lL9?=
 =?us-ascii?Q?cuS/OYAFS1mOWA2sEgvlJB26Rn1dW+h3V91qNEylTOid25NcC+PenD0S+2K1?=
 =?us-ascii?Q?PQ9cqLmVQmlzqioC9BLxSILnZJUShoMDge/86e9DcHYLQArrV/LjhAqlnatG?=
 =?us-ascii?Q?8nCI8nDE0ObPVVO8XxDl2IUd0QT6y9/XyuWK9fYVvU8pdG0HryTJrkkJKJxw?=
 =?us-ascii?Q?Q1djE7xWoIoqBPuF/Eh2jeLsjuLh7J0Zrui+S1OP8wtac8X4oczmhKXuw4vX?=
 =?us-ascii?Q?BTNYth5m8vCiETyrmwyvp0HsktehJNYUTc3kjVuhEA2i+/kqaJJzSuNCqp+1?=
 =?us-ascii?Q?cDSGZt1ol4v92vmwHBLB5DqGgG9booxwaM/zhnC1QAkZ84ecdan4+nMISRDa?=
 =?us-ascii?Q?bE31kC+1gtGUpaLr7E5+WcLUVRXOLHfVGelRexKWZUeF2MGB5gGj+tYxMorz?=
 =?us-ascii?Q?oykPiBDjtIwWI6ygyAnjaiefiMNHu0Ljii3lu6Hia3bJJ10wsMORdwDT+Y47?=
 =?us-ascii?Q?N0+9OLbEeEzYKUliSRk/zAJG5NjcXEfl/ZaGuWzjrqYcO4ARmRd5/MlayAK3?=
 =?us-ascii?Q?OCGWnhDjjUBgr0kF4n4iWUUaFqX+RBw0/1/VESSvZZMeenGKYbIXPFoDw8xk?=
 =?us-ascii?Q?fmt9YRV210narMI7tR427c3z19URvQIg+yzf9JAt1UyAylsTuUKkHk0SYs4c?=
 =?us-ascii?Q?ZvluRp4tqaTqJF6R+pzYE9Nu3Ij1y4ctIzl8/xEK6x1l94DasSBUw9FdV9e9?=
 =?us-ascii?Q?h1FgUBzsBC/E4IuV0AbSSCqZDaP/rPwSquvztyPq01vyTIChHhQycGczI4Eq?=
 =?us-ascii?Q?PlRviV9sgyObl57qodKYBurhDXfKHw8QUiV4aPsXdF8QlkhE41vxxa8677/D?=
 =?us-ascii?Q?U7RoKiGuJgBftlHvs1dEUPLkytRZZB3klZ+cepjZZw7cLBDvCYDudsa7avpo?=
 =?us-ascii?Q?yD+RlY/usOUUQeSRKrGunMO3FZEmeifLeekZV6B0yIiBM564TO+X7F7pNZZz?=
 =?us-ascii?Q?KX7toG9AEyDap7DG5PsGNBS7NAPTLcUtcr98pnfY86m26lfcznHL80a7CZoE?=
 =?us-ascii?Q?76UWdprkN7Y8PTJfhRRVdBQIIQyk6A0WqzQ1qT2Db7jnhUNhkZn/cCmfTZu4?=
 =?us-ascii?Q?2w/K2/LhmACVNMcMkgaEacRdBNQEYOfA1n2krRUCO/Ch3DTgNw/XF3UtloNT?=
 =?us-ascii?Q?jRe409JbcQitbA2evppmcHG1zNAJEmL5l7seGMlqmgn2o8QAQyHRNTnzPVXL?=
 =?us-ascii?Q?IcFzU+DEJhhs+Eh4/hjKEuIcaMCEPL3AokVQjA5IGjNFGBEGo4ZcxGcf1mk1?=
 =?us-ascii?Q?olFre+Mv9Dg3eIXQAGyHVFiqZduWe9aUmpbJkHfh1K2WaHUI4nmC6xhLYBe/?=
 =?us-ascii?Q?xX6mi67F1RHf923LtUo+S7lXt/NZgHyMIcQ6uVjXHZUJYctRtCSot7QzeDM/?=
 =?us-ascii?Q?S/Dz8I9ajxepfaH78WDnI6v6FraQNX+74vPqsmbESIHu+DzZk6/M7bkJC1qT?=
 =?us-ascii?Q?O9k9cwMHqHSLT+EwtjbkCR9wQ0qf6cB8l+wRhkZtHoHMUsAu7FNr5UyYnYKp?=
 =?us-ascii?Q?kbrtPm0OhHWM0n0t35uD6liagdbTr2+48bdtjVBBphGcGkKdkmO6GHoxQkvh?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafc147d-4720-4e09-d693-08dbf6abdf50
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 22:37:05.2222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEs/ByPJ1N4UX1yCAQZwYSR5zr9GE48q/ZlkWKI/+UBX17CWtW/BTz5TlYDgHd+vbQCGo/u6RpOi21Ow3Dgabg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7506
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 04:24:25PM +0100, Oleksij Rempel wrote:
> Remove the manual checks for register value changes in the
> ksz8_w_phy_bmcr function. Instead, rely on regmap_update_bits() for
> optimizing register updates.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/dsa/microchip/ksz8795.c | 95 +++++++++--------------------
>  1 file changed, 28 insertions(+), 67 deletions(-)

The diffstat is nice. It's good that we can benefit from the "(tmp != orig)"
check from _regmap_update_bits().

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
