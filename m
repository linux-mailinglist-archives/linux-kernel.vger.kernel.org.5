Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDD47C613D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376546AbjJKXs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjJKXsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:48:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4026A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNfWEawMD8gd5FQWhj0RdUWxbQ3hrbvWxTG+gGW2WDSn1DvNz3BnZ/tZROufBwsx3sqxjoigiJZpsplHSuUE1adkCgUReFzJetwD6rOar1ygOzNfvDdEc4bboJajV3OkDgIakVREFaZi0+i39KkiNBxz+DrGm5Jb52PuFQzMBgFmwyniic9PLep5YIayNLhNGzTjXJ2VdOJarELi8QOWer/eX6sdvoIuDRvQmHc0K7tN3QGt5OP6y7w4nlGVGswQyJ3xe/o9giqwAmi1dcxezvW10ZtJ4BVxvP5ETD3XMTZCbEE5b0dD79bQH4PDZGVMawpNMOqcpiWiRgjcfzStkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPpbqTk+R6W8CypwNfkvvAypqzvopNqmn7QcrJ01RpI=;
 b=Dw9j/PzkPayd4XKjEQ9fmsr6nmtBmmXaM4kkuph9kLYCOzuEHfdYXDaA7Gmfgu1N2R9yHqv8nJk+4hMMNfFDsOK1e6aqi3oiGaKq6MXPx87L1m6Lvu28kL9swhu99z75W2sQXAU3U72tiRCWJYFICxJGAMLus6uzcCpOISwJBmNU3dj0TicVb2N2+TwuTCEX6J4EL6QNXxMDJux/SJsrhgmFQ1ZoPOEYuvK43SEpOkT7CQDxPT47eTANm1iCeR6+/5fOObh9r4YzkSiahywrKwJPjrHKxR2flHp9d20LX/IvTBuvRJbAROj+EDu4FgQCfn9ZagKQH3fZ+2CV+/PU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPpbqTk+R6W8CypwNfkvvAypqzvopNqmn7QcrJ01RpI=;
 b=BNi5zY3DwpNS3maOhA3Rqcl/Jy/nv6WXwNTVAOC1QoCyKsDYMubdbsK8/t1jjeDU1IFthLuxpRU0bF77y97gu/33lQwLcaph/uzPb0LH82pnLfWVELGQd64nw463p5qTGQrqkYSgPAOJ6njSav3fJ/zjh/38vx11Ry6Rfcrx7Sei8yWr/oHTdTwfuvX9E5rlXAGMBNuBobXVGiVBYrmF67bU0sgzoEh6uwC++R1xFuf7pyx6zrrdGRp69HXdoCvpx8kpkKEhFosx0r1/UW1TQx1fHTbpYO7O31JztoRxQgXxIkdMm9uPHmIfrroRoyJuXl6CyvkP1l1W7mc2H0OiGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 23:48:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:48:49 +0000
Date:   Wed, 11 Oct 2023 20:48:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>, will@kernel.org,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolinc@nvidia.com,
        jean-philippe@linaro.org, robin.murphy@arm.com,
        Alistair Popple <apopple@nvidia.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tomas Krcka <krckatom@amazon.de>
Subject: Re: [PATCH v8 0/9] Refactor the SMMU's CD table ownership
Message-ID: <20231011234848.GA257246@nvidia.com>
References: <20230915132051.2646055-1-mshavit@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915132051.2646055-1-mshavit@google.com>
X-ClientProxiedBy: MN2PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:208:160::46) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: e989655e-ad76-4bf3-c0a4-08dbcab49d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLUm82GPSQ2Qjg0HhH5A4ftS++wNDxfeGailtbyhN5WEnnRdFZJrQc22UKUd/Fgx5BcA1RIje2/Px8lzg+gjm/KXxhcQQwO4vcYXIwF/7DLE2GB1XMY2yVWP9S6mM4K9+A6Un3AGFNU24J5fuzxAqF1mXuXdsKrGACf6hOX+Ek5PCjWRsYVAqXOI8pSqeyrfFApQuNPHbiC8kRJqiONsagikvmh45qv1diXTP/vtF4lG0vMYBUuRji25adaYJqoysJbCV93e8TlLYlB3q8YmI6y6FwMZro2GKhodEBJh545DF8wEGHsZiqGU3VuHHPfxH05kUEQ1s+BHE17MJpBAxxrlcbh9CEORYf6T0I5soObYuGWmIYT23LYhuuH2Rs/ft7W57guZAj5ksZ9DUBrkoVgJRVW2M4zwHWzZkNC4OEQacDtIyX1wPJUuKutK4NMbwm4662Ytyhubgl4yTvzNoFnKEA+NlN4oR63pR9ZxhmqC2fwNmwiwHpp19E/Xjap0uPipimJUli6n49bjx7bJnRbucxEwqmYR0tHlhJA5B2BNuI2mY6uvsjFI5AccFBQZfLlDHKAeYj+V5/opEzwGLo/0S1d1+VcPIevGaZAbtLsmXsUx1SFxIE44uIHujSi+JuTnu/3cy8UdOqCVPaAGdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(26005)(54906003)(8676002)(1076003)(2616005)(966005)(5660300002)(6486002)(478600001)(36756003)(6512007)(6506007)(86362001)(33656002)(66946007)(38100700002)(66476007)(110136005)(316002)(7416002)(41300700001)(8936002)(2906002)(4326008)(66556008)(83380400001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gSCP8MesWhlKxc1BFlDvgEq7/d+NRQm+8hsZ9xyPInxH9J1Wv7wa/n30ZCf+?=
 =?us-ascii?Q?QY8UleyXeebg0J8wb1dJ1/Sx/aTn7wiWZrnRQCr7F9/nZTvdhQozvJFVuYXd?=
 =?us-ascii?Q?YjDl1tUWM7yclEhtyDmvTelp3NvPhRReoa0aqc5Dv/RhvIv3A0llz/+byznc?=
 =?us-ascii?Q?q4jy2vMzNvzktnnVf+oIXRozRByJwminUTPBISIq0UxbbMDyObVRDJmMgGnK?=
 =?us-ascii?Q?c1avq9ig3xb8WwEY/9BfPejUj/A5qLp4ti9Zi8mCbTUJuvT7Y/JdAxpiwi/i?=
 =?us-ascii?Q?WOKbLXzy0KBmZJA7iXO8q5yaajqtqehTppvus6AEzMG9oXHDfia8BdEX5a3J?=
 =?us-ascii?Q?nbId3j55S0fw1XHsKEElOf7IMLAGpqkYSAF9BG0qRqMl6OnEdlGmZNiEfIwY?=
 =?us-ascii?Q?AjRGlhA2I2FzElMdl/Px4d4/XcNm6xgwqJ5L25rIxhnxKYbNDnmsv5vsaKii?=
 =?us-ascii?Q?CI1PcXP4s8VHWz66yD8rr9zbZDtp+6P5t6GakbzUyZ5FiitAsnel3ek/j9+Y?=
 =?us-ascii?Q?BE1YvZ6lddn5DXmeQIpBngrI6ZsoAxyouG2AfvkIayPZgx51cgh8NGdYjPTh?=
 =?us-ascii?Q?OXu5KEczv2S1e9zFzCPib/rTFlG7skfHmvuHIw+xIsPUF+groyhUCC04U66T?=
 =?us-ascii?Q?ovM1/JdT4mToQBCQktLEFbXNAyo9WNk97Ur+OkxPhOoTRM2I975S6le67Eva?=
 =?us-ascii?Q?p34nCWSr71T+6BXpzvPyDwrc6YFj5x0fOwXkvLWdQ+99UuxA5plCTLPyURM+?=
 =?us-ascii?Q?/ly6M+c/gsjHah+sYJDLy4nogKTlJ/G3b1q/ivuSH2ZUAFu53APKnXzfmTGA?=
 =?us-ascii?Q?Kf3WcXHwkol14XTM6XrxGsv0X1AGjCUTiCosktIcO/8caM8FmVH7GR+nMaAv?=
 =?us-ascii?Q?+661sMib9qZfpVbuY5Spwv/5Hsxa0T+zOTAQruIfhBEU6cXJGXCa+uoIeVto?=
 =?us-ascii?Q?wnUhxSKrXkIkgr1GagMhLfze5Lh+2WO4azZO2KBP/qs046rNtBvETWked8V9?=
 =?us-ascii?Q?MvAoGCj50hZ+jrfPLNuBSAGMAvfEzRTiJf+xtlMsZW31kEB37TVEcoS6oEaa?=
 =?us-ascii?Q?HGPkWTN8VdE2fiScVkHh8yddOSfdLDKHu9cvPFNqBuJS/UOFv7zVxVFQq23C?=
 =?us-ascii?Q?yYbHl2Hve2bKNPKo/2lxkDwMkHStMbdZ2Yt9TXA5/KaSZbB+dSq5YiFAXwG/?=
 =?us-ascii?Q?Qt1+BWQeXR+Z3wyt3iLdZWNhWj4+Reh7vo5FD20Za+aUeyhLFY23xtoBx6eR?=
 =?us-ascii?Q?fqWh0uSFjJvXn8m+AO058j0sFBTJb/+c/aWTaF8py2Ch3g+N8du30voVnfdR?=
 =?us-ascii?Q?5O30Jw7TdYl4P+ekIxIZZMiX6HppTCzx24fMlwgHnzZTwXaD5GVeDL7JuoaF?=
 =?us-ascii?Q?/x+kgQc2gJthUFmQAOujJF5DTfhoBFXlTLb2SrIIkK1lloasjCXbDa4fRTl7?=
 =?us-ascii?Q?LTNK6KUcJ1VwHmIeEuozcZ3TOnCkV3OBCvRkU9Ocg6X9B0+aonHw2+Qg9H3Z?=
 =?us-ascii?Q?1U29QAgY7p5Zs6HTpAacfS2rWoxf96vBnRscp1ZZxAlKSIknJzqpRLpc3uOm?=
 =?us-ascii?Q?TdygsCoFv24bTcpHWUNe4aSp6zGhyeCauYQQ5sX3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e989655e-ad76-4bf3-c0a4-08dbcab49d93
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:48:49.0854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TV4nQPN7rbTTZuNDT0EDGj8YjdHhbQ/6rjb0giRYpN2ZjNyVTYAi7HwuFdcm651u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 09:17:31PM +0800, Michael Shavit wrote:
> 
> Hi all,
> 
> This series refactors stage 1 domains so that they describe a single CD
> entry. These entries are now inserted into a CD table that is owned by
> the arm_smmu_master instead of the domain.
> This is conceptually cleaner and unblocks other features, such as
> attaching domains with PASID (for unmanaged/dma domains).
> 
> This patch series was originally part of a larger patch series that
> implemented the set_dev_pasid callback for non-SVA domains but is now
> split into a distinct series.
> 
> This patch series is also available on gerrit with Jean's SMMU test
> engine patches cherry-picked on top for testing:
> https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24742/16
> 
> Thanks,
> Michael Shavit
> 
> Michael Shavit (9):
>   iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
>   iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
>   iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
>   iommu/arm-smmu-v3: move stall_enabled to the cd table
>   iommu/arm-smmu-v3: Refactor write_ctx_desc
>   iommu/arm-smmu-v3: Move CD table to arm_smmu_master
>   iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
>   iommu/arm-smmu-v3: Update comment about STE liveness
>   iommu/arm-smmu-v3: Rename cdcfg to cd_table

Will, can you take this please?

Thanks,
Jason
