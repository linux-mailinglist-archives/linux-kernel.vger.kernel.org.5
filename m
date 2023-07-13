Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4A3751C59
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjGMI4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbjGMI4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:56:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2127.outbound.protection.outlook.com [40.107.220.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE8710E2;
        Thu, 13 Jul 2023 01:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUlzjH0uVY141pdg283b7z1B3BfJfoU6PM6ELfkFyEmnRMeuxArattM0uupWuIh6Wm62BDy1uCOnZbD8c5mS0+I36r3xQn7nQ4eoh6fqxnye+MAQFv6otkAdrBXhG5BISvWRnvjyTzscSi2ZepprsqxmN6vgdyLxFjeYNz3UxvmCbdSNl5D6qU32D/wvPK2VeLK/qrcslWFv1ghZ0o7jN0qzuwCvwJL6LlKRI3bxUPGb0K8b2zF+K8WO+g8/XH6IXJOKv98vFVJ+qsap12Yi8co6rBFZ3ihOCVTYyLF6J87KwFJ2Wa8Zam5ggY28LIqetWyajvf5uC/2hNQnfdFBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZN9UPooukQ/6kA78MSgxrXOa4phBzOS3hrJQzQgrP94=;
 b=AEAEBHcNEHnDpUvQe2MyL4/anA4ae4emewpr7kKOwYO5hBjzsA7mSEYF21aWEgr8LnPpQ+LXo+iKR7rw22ZlIoRUN2ron4rMDmyEQMi5SB8TUopZV+9EOOsCS0QFYLBFDVvSfetCTttcQZj+2TtreeunacqJCIuNhVFkM6xqvzdNgvTJwRkbGMGk5UVjdTsxcJF2Ziisb1DyK0kxLhOcU9NkH85G4Ofksz8H5WtKuzAmTZzEBzCKZl8z9abTgSWyztjX5oYReaNqm96dRw4pFQPxr3cvGqZC6nOHGJ1HG5xjbE1lSPijEirt8k5TuPkmaNAY7M+yWj+NLQPvrjABXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZN9UPooukQ/6kA78MSgxrXOa4phBzOS3hrJQzQgrP94=;
 b=dyulk3e9Kfh3Jcro98TrM7km4ypCKJP6x7z7DN+DAnVj5piAeMHrGMOZf+ou2OZmVWA/z5B1ILnmHKys3i8YI+G0bcbcOyDUx4mMOzZSa2dhiXdDZjzVLEYA1AVMl0q6kH/d/KXZFQHPKVvHcjRLkQXheEnLRZb2w9FjecgY91U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BLAPR13MB4756.namprd13.prod.outlook.com (2603:10b6:208:320::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:56:28 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 08:56:27 +0000
Date:   Thu, 13 Jul 2023 09:56:19 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 08/11] net: phy: add support for C45-over-C22
 transfers
Message-ID: <ZK+8M+FxJxY7UIyt@corigine.com>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-8-9eb37edf7be0@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-feature-c45-over-c22-v3-8-9eb37edf7be0@kernel.org>
X-ClientProxiedBy: LO4P123CA0458.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::13) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BLAPR13MB4756:EE_
X-MS-Office365-Filtering-Correlation-Id: 877d285c-d824-4f3b-4041-08db837f0ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LkLoeWDmsBwJQAdRaam/q0gnG4udEpE9jskzEIJ38YBFxMHbqbL9einEA7caRaWqfip2hIjKOJfBbFykw0lL2JXJV3nQUxzd5rX8P89MhWJnUXtp5HRIRoPhmcEPvHJvKh3I2oDNX2RGr+dx2z4TLIjFRUILdM3eX/E6+JzpF/0VwXqKwDk3f+wOKMwEkuByVZ/Mr3Kd3hwzh/FRBEEjp1sS4zy9HSNn7f9FiaPh6TIJhJr+2d2/4UC7JsiQrjdjX0VjdAw4F83NngvL8E+N5x0VrGlf2rBhgYWPDbyLDag6TKioVO1PyiDJI17qKJWlEg+5al4zdlOIC7EpuPD2Mr82rNJcWi2S4YrJoIWzyZOSKnSRrQPQX1GVgkoeuDt65jefVLc8bpx9Hx/YH6dgSrwE3Glc1CiW3D9BGxYBbpJteoTIa3yjImfbvEiPr95897QG5u0/guSEsd1NKWIyEAFaQZ8rvufAlVdQiwuzCAmaqjXsKCsGyE6FIftUNi9Vh0b+C3Uf+3yncohE4mdVvsaazUYpLMBtoTGwfj6WUeU6Hn2hADD8vtqrCp8awaI9B4wPjgNDzmQpnGvNry0stqsKyz2E3x8pTQ6u8l/z+EA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39840400004)(136003)(396003)(376002)(346002)(451199021)(36756003)(38100700002)(86362001)(478600001)(6666004)(54906003)(6486002)(6512007)(8936002)(8676002)(44832011)(5660300002)(7416002)(316002)(66946007)(66476007)(2906002)(4326008)(66556008)(6916009)(4744005)(41300700001)(83380400001)(2616005)(6506007)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r8/SYRIPqf4ZyD+J3ILWgldLBBNPX871LRZPimof2JBEvCg/9zpqYMMHJw1R?=
 =?us-ascii?Q?gopSfqEr6ZOR8xsug7F6UOScPnRt+NsPBEXtgrd5COFelFflBsBRKuGeDO7G?=
 =?us-ascii?Q?qWb9K9stVnwH/R7LkLWCVHj2zmTRMy5rSADf+r2uevde/e3z1pM9lVoXpNrc?=
 =?us-ascii?Q?zBMiU5pZrexZ/3tB0h3NHCrg8OaBnW24cW9PZtYAA8bpGDmWeckRPfu0vCeT?=
 =?us-ascii?Q?8EJPvh4ObbFKowW/rv9isNqiaYuAnWi2wBKy+Cu9WuO9/X+03vRDLqMhML7u?=
 =?us-ascii?Q?wm76uENB4dgNf7LmI5wEL2N7Po9EtkuDsA7hoWbL0UZHTJxNef0wza39o2qW?=
 =?us-ascii?Q?0aLVXGnRCX1yUIanDKSPWTo+SlDRk25ezH8pNdP+hpU8Z4Gbto7D1a5/x/WF?=
 =?us-ascii?Q?E3EB0FU92DJNOLfgAh2jSmYKqyEy32iMbipzindLLoPvqNRNbyJvNvNHl9Or?=
 =?us-ascii?Q?gVIYJX0k9PgCpnTAUQVRUl2736I0TFbLoAmTQXOo61Iaq5EuG6HR2kPbzgMj?=
 =?us-ascii?Q?8CZ80qrM5KjBsZlkqPLZnENAcW8w/3OSsPtH7J6Jf19DxGoRkM7oY2gWo3f4?=
 =?us-ascii?Q?d+XSwPdz+uEdpV0GkzAODYxTBTjfoohUARXDO31M3ukMMhCLmJrN6p0d7zmh?=
 =?us-ascii?Q?zWi9NqjiKB3zviajcg/IHOz4w7d+DXifazKESvLGdqLx+LRylWGKPerK7ATq?=
 =?us-ascii?Q?TGEdPuLuy751d4co2qDzslQ+t0yHYocqcLY3m2YR/JMsELXAsLnIxDiiOcdh?=
 =?us-ascii?Q?l5guQiRWmpxki82GbSq9NAhUw2NscgLUutIzmEia+EbrKgDez/xR99vv+W9A?=
 =?us-ascii?Q?M4w1iwMnp7vp4cl81qwHzE3oX+v9XohtsvR2VYlzPm933c/93x/du9jzlP7G?=
 =?us-ascii?Q?HkvVy7w6dFsrRvYwAMaU2hKp2srkzvp49TXVb8czhURHrELHeuBEd7wdm/sx?=
 =?us-ascii?Q?DSak+Ss6n33Tmvc4lSQg5uma/S7ABz6lze5JaFux8Pu+X0s/uoNTn9NMNElv?=
 =?us-ascii?Q?bap+M4BZcdUKGObdxFpWhpUHZs47WoFCJuLiqoS4/lyziAWyaXYivhgUo6v/?=
 =?us-ascii?Q?UohcRydTHcdZTuZnubNE434j9PoR3FVBRs1AVY4EORVB0G99zF+h+TReZznE?=
 =?us-ascii?Q?iJmGpev+dg0eTfzkfla7Z0EVpTRVGM4bJ1tLWr3jtnB28g2/AKDXBK6qyrmJ?=
 =?us-ascii?Q?k3Lc0Ha48ZPbW2WeKaMRJxDoyFoQfPy2Wa0VCXduxMeIsySSn6qct2PLVdTF?=
 =?us-ascii?Q?5TuGm2FJgL8ycero+k8BDrBPIBlHB/008QOEkL+bVcDAWaIol9EK1jgwXMWI?=
 =?us-ascii?Q?IDg9IDz3glDd25Nf4WQHJuJXcvQtcf2zoFANJPPgAC3WFayDCyxZIXWahaIh?=
 =?us-ascii?Q?+AvFMjQgjsL4zV7BrpPCIcW8xzzwIe9j+zT5bgNgb+iGk8h5WQrhiIQY+XPL?=
 =?us-ascii?Q?5ljDqKmjl8CIn42T5JTjinrpW1FtZ/jAjXzka5OHpFVPQnm5H2N2C4QQ6b6C?=
 =?us-ascii?Q?xQV6Wi2LaUmMRZOp+RuA2IxhkJsATbBrISG6Nlif3kAcLCpzNt9Kg5ZkRCE+?=
 =?us-ascii?Q?XeoCOr9O2o0PpJ7fTFPxYBikyyM3CVLLaDuVmynB4nfUuGSnqzqcbTas8GrK?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877d285c-d824-4f3b-4041-08db837f0ab7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:56:26.8314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUgJI6wXnPzy6Oqiop6/55bDXh6iWufedZdIshQQKKz/vh66nJfS1HkjEQs7dnCYIoDU7UvI/xgqvTU4OnCJac7FslXiJdcjZDf+XJ39TqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4756
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 05:07:08PM +0200, Michael Walle wrote:

...

> @@ -780,6 +782,7 @@ static int get_phy_c45_devs_in_pkg(struct mii_bus *bus, int addr, int dev_addr,
>   * the "devices in package" is invalid.
>   */
>  static int get_phy_c45_ids(struct mii_bus *bus, int addr,
> +			   enum phy_access_mode mode,

Hi Michael,

Please add the new mode parameter to the kernel doc for this function,
which is in the lines preceding this hunk.

...
