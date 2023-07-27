Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0539876543C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjG0Mn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjG0Mny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:43:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2122.outbound.protection.outlook.com [40.107.237.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2311AD;
        Thu, 27 Jul 2023 05:43:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coW2Bbgpxd79zdLma2D0twxmrNrSYGnlFDwtCtgs7i/MFL0FjPY6hzpHjFNxLGLin3KCzqmv5IJ/Ym+aDQ6mmcyrKTN1nsnG7UGqPv0NQYeIipIoTwv6ZcxB7BGoXT6ajR/unVsaMazeq9629R5A5xZI51Ltavm8wSak3sPhOAJVgMAkFWSnzvjMMtUVjBUCk7b0uVpnOJmLwzSrPCYIEszARv4e7y/MFAPPouxWHNDXtErFKaekLekG7ZX+5TOk9pOIGfVHlT3RA2aAb3THhIS7c4zI2HVQrHYTe77D4jnNOsahHtqoFhW4QFbNuQJk+TDU2L4hx8CZtrJBwFCslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFQR1C8HIw9UW6vxPAOXeDBpgvNbva1nWs2Qlp9yTEM=;
 b=e4nEFihBQxvCziKSccBvrhJBxNUYdoPjKkIitguWLp4ypnmvIX2CFTPoJpk2SEznC/80KPh+YrmdhlZQMeiDLmpf7EK3/3c6/n9XcfhLrIourvcZLGXLs6hdhVf3MNe9fQ5JZNAaoAHpyL6cpFRLiklSDk4OLxE2uo244PS4/Xy82oVo4Hv+KCS5jK0x+3Izs0WrdZjZ24rkIoi6TVJl7fAh29WdPvFoc/cdNEghsdHtALUagkEEiryII7k1qOPaAm88DdWs0uKEZYV7ToycDkEHgvRKd+KnCjBB35XH+V690wbmGu0o00KscUqI9G7KdypyVIrdRJLnP2+xo8frUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFQR1C8HIw9UW6vxPAOXeDBpgvNbva1nWs2Qlp9yTEM=;
 b=qDrs1kMXn+Qp/xY0ulZ/0zekwIAHtHPEZQ/4bKNzshV7WGFBbdRBV5yvOnWtL9EIETAVA3h72cT2OtFw69eNuDdT4QfmeIbXd4nJHU6Kifd7Pa6aAgFT9xxT7SwNjRYncHw2K7Vx/vgkOFh35YM9/ofPJb2/ioBjK+exDtDmrZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BL3PR13MB5092.namprd13.prod.outlook.com (2603:10b6:208:33f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 12:43:49 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 12:43:49 +0000
Date:   Thu, 27 Jul 2023 14:43:41 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     patchwork-bot+netdevbpf@kernel.org
Cc:     Daniel Golle <daniel@makrotopia.org>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nbd@nbd.name, john@phrozen.org,
        sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
        lorenzo@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, linux@armlinux.org.uk,
        gerg@kernel.org, bjorn@mork.no, f.fainelli@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v6 0/8] net: ethernet: mtk_eth_soc: add basic
 support for MT7988 SoC
Message-ID: <ZMJmffbj+K22BgIq@corigine.com>
References: <cover.1690246066.git.daniel@makrotopia.org>
 <169043462350.30073.405534761855593169.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169043462350.30073.405534761855593169.git-patchwork-notify@kernel.org>
X-ClientProxiedBy: AM0PR02CA0021.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::34) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BL3PR13MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: b99b99f4-42c4-4946-85b8-08db8e9f2003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: apo+keHueSfRGpwXajOhobwRBoANKln/gCjo5dfppZGkaEuS2b2l8uaZ6ZmO6kMsVqSej8gAROybtXYA2qQ6KPCns/6MQzLxtJhqJFXTJga8hp6OULh3bxM0RG9vjA+oiVQJqexMjVJUxuMSBQUmPy1HdjqrnRW5NYnRh6V7v2hyvItoL3kCkopBZx8TzMdOE07qJvNphYSUuqgeH0Y86wl5cMOXdWNnNpmwhvZfKW8Y4Q1aHG7CtqNk0r77pcCpndNQFuINj9RDLjz4CY7EJ20T6W01FEbyn1nTp8qSy+KU/imJtekQZdLpYYdqTos62aDnqCtaXE+H7NhVRmq42OH42h9LKN2D7766p8oNt7LcWWV9kiW21Lmfye3nqanQ167G8M2nya03KCXbgdrph5UO9AwFLiOcSwhLdRjJkmzfEM7I0dWTElZCLO5pzzUvMFVxvnVuXJeZehBJSiMhUrgEG0DVK3buC2tBsrvRqpDMTkRJb2OUx5jcOTsCPuNKvLlpD7T/lEQ6SLksDCXm7aXFMNRXarrIBMhHJ6pOx6QkJrJk/FfFOspgDQdVYm3XW8E+iP/YNgP1kFzgfk9uxbY5E/MIoIqcCLU9bDaiZ7/XhoxvtkdCiLRMlqYomFB014uWGkRmr2/72hC55PX+Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(136003)(366004)(346002)(396003)(451199021)(6666004)(6486002)(478600001)(83380400001)(6506007)(6512007)(966005)(66946007)(66476007)(66556008)(4326008)(186003)(2616005)(38100700002)(5660300002)(7416002)(44832011)(8676002)(8936002)(2906002)(41300700001)(316002)(86362001)(36756003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9n9TjB5oTBQzkQr/Buo0Bs304zaBfTXHhikxb9IO9fC5ye2589s8IVCo41QG?=
 =?us-ascii?Q?jZ9dKg+686+WspK8GefPtQdzJ0bbxpGn3qjCCflke/qVDwgh64BP9gJXWEOa?=
 =?us-ascii?Q?DuFzqvP7pj0fVYDsE+o344yBbeAOmjXEZefLd/LOUN89IyaH3pWwe5Jk+d1x?=
 =?us-ascii?Q?2cjIOZdZRHD4uIye7yz0Nsk2XJCXm06C8TfoW5D/SC5E+YvSV2lJ4OiwC2bY?=
 =?us-ascii?Q?yPW8yDhxrDIOuicny8b7uWefEvP84Opa5OaQuYXMAe8yhR+vIjRMsv2NGfPa?=
 =?us-ascii?Q?rFAghgc4zHT6VNjdLNnaVZjozoTqo2/kEu8pFFTYCHvPRWANm7xDr+QK9Y/W?=
 =?us-ascii?Q?oBFqT3ug6iaZ9FxJTv+nXF+4HaS1h1RVkOwgU91SCR6XeuzBT8zLUPt38OOs?=
 =?us-ascii?Q?F21er7nOPDDEsV4y+oY5GTh8DItVuHEGFXGlrrE00lMN+4QafrOX0ePQ8YMK?=
 =?us-ascii?Q?FxC3V0j4B5uWukIM/AclGW8k6Q7ruR2fpfLv5ijvIsx1viAUinXPP8UjUJ3S?=
 =?us-ascii?Q?w4oBP23DgyYILuB6Ih12dWKsmv3pEHfpZqlCkfJuEhsOhns8Tb3QG0R3Yvtc?=
 =?us-ascii?Q?T+wBsfzD255v7AGmBj6TCQ1ETVxokt3kOlwRzvbCXAKhAMUmMd2KZfT7vib9?=
 =?us-ascii?Q?ID8Zi1Gj7lMH4pKpoY3qAduJML9hUKmfDzoKVAFedk4neBjHzToW5lfYIas/?=
 =?us-ascii?Q?U8KFtf95IhHVMkqUjsCksLUqS8hZc4ljb00qru4g03Uh0yOYJEdVuzbzkO6M?=
 =?us-ascii?Q?Z7yjK/4DZ5oTqgoUgLuXPQJkyRvd0h/vuK6NxHZQP+CSilADIraEG6Z51IUn?=
 =?us-ascii?Q?FtGFF5XlDU0loM6EpUrw2zH/UcXXnWFWAyz6Dtv2vzEOaHMN7ifG7Y7hKVwU?=
 =?us-ascii?Q?7pSHKtrlKVmMqY+0KsVNnSOFvXYBj7cGkK9ZIuCMTOgUBi/yuHZI9URDGIp4?=
 =?us-ascii?Q?6A6ffqIkCh8eNSf83YOwxV4WHCkO44CeIllbLzR+4wbskutgJ4sknm+/Zkry?=
 =?us-ascii?Q?F6/E68fNbBMkEJi8JColaESfcv/ZsYQ09zvTwWqPAVdl5AF8vHpA46ceuB7a?=
 =?us-ascii?Q?q5fNTFUYeFCHRQ5wcKAEJGUYR348buoi1t8WPrzt0mC66MQCxhnreTQK0DVC?=
 =?us-ascii?Q?HgPSYSHFO+efqdSNFSB0swdPPqxRtPXp2V484vItfJ24jKHPj88Vx4r1qLTl?=
 =?us-ascii?Q?oXvUVGfBpszbMUEp+deT8OBcplqAf4AkTG6eu2ZLAqnUIZdCbeait6wtVvVS?=
 =?us-ascii?Q?e4TNxgwgN5dLiTSoRVtM5HKphTyKKGAdPxnqOiYn7l10s5uwfVGBRZg/H86Q?=
 =?us-ascii?Q?9TKUKaHwMU961X0XzZYpRwDF5eWKwX1rgANdTNbrYV/NpcHLjLfQv34N6F1x?=
 =?us-ascii?Q?+PwCTQfULSy9QkIjLE5Ii3OuAlydQ55dl5fPOkWZdmoxSe3tDFEChN8RLuMc?=
 =?us-ascii?Q?Jp86Chq1fRYhoYz66Uz0BSH+ra9btjTFNJ5VB1J87p25fxQ0QXKPMht0D1mD?=
 =?us-ascii?Q?VzyJSxIz/4QAui1bF9NX6CnZjv0DPtB7A47FycUAsna2IhbKOUWAzjmt/7G2?=
 =?us-ascii?Q?csQLERGGJrPkEAsMYIO8vENCQjc+ThoylViE6wTEPf9wzOloqxnIjf/WpJGc?=
 =?us-ascii?Q?EuWO+dttIekE/wByWiAldyHlxMsRyfT63sOzZj/K+9+HPZZwx9Ppal8kawHS?=
 =?us-ascii?Q?PXrB6w=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99b99f4-42c4-4946-85b8-08db8e9f2003
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 12:43:49.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6GCpvm2B2eY8wSg8wbSIPn8lyPI9kcwkMoroSkE6lK2mUGDXgHVxVMJql+sBE1MngKy9MyLW47FPmpLbWT3GiTs1UjQ5WKlRx2CHdY7oag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5092
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 05:10:23AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Tue, 25 Jul 2023 01:51:00 +0100 you wrote:
> > The MediaTek MT7988 SoC introduces a new version (3) of the NETSYS
> > block and comes with three instead of two MACs.
> > 
> > The first MAC can be internally connected to a built-in Gigabit
> > Ethernet switch with four 1000M/100M/10M twisted pair user ports.
> > 
> > The second MAC can be internally connected to a built-in 2500Base-T
> > Ethernet PHY.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [net-next,v6,1/8] dt-bindings: net: mediatek,net: add missing mediatek,mt7621-eth
>     https://git.kernel.org/netdev/net-next/c/1cbf487d7d3a
>   - [net-next,v6,2/8] dt-bindings: net: mediatek,net: add mt7988-eth binding
>     https://git.kernel.org/netdev/net-next/c/c94a9aabec36
>   - [net-next,v6,3/8] net: ethernet: mtk_eth_soc: add version in mtk_soc_data
>     https://git.kernel.org/netdev/net-next/c/a008e2a84e6b
>   - [net-next,v6,4/8] net: ethernet: mtk_eth_soc: increase MAX_DEVS to 3
>     https://git.kernel.org/netdev/net-next/c/6ca265571b9e
>   - [net-next,v6,5/8] net: ethernet: mtk_eth_soc: rely on MTK_MAX_DEVS and remove MTK_MAC_COUNT
>     https://git.kernel.org/netdev/net-next/c/e05fd6274ee6
>   - [net-next,v6,6/8] net: ethernet: mtk_eth_soc: add NETSYS_V3 version support
>     https://git.kernel.org/netdev/net-next/c/1953f134a1a8
>   - [net-next,v6,7/8] net: ethernet: mtk_eth_soc: convert caps in mtk_soc_data struct to u64
>     https://git.kernel.org/netdev/net-next/c/51a4df60db5c
>   - [net-next,v6,8/8] net: ethernet: mtk_eth_soc: convert clock bitmap to u64
>     https://git.kernel.org/netdev/net-next/c/c75e416ccfd2
>   - [v6,net-next,9/9] net: ethernet: mtk_eth_soc: add basic support for MT7988 SoC
>     (no matching commit)

This last one seems to be:
	https://git.kernel.org/netdev/net-next/c/445eb6448ed3

> You are awesome, thank you!
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 
> 
> 
