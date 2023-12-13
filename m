Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D62A81140E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441821AbjLMOEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379212AbjLMOEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:04:39 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EF8468F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:53:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUEzgMHFNg1F1vZgCSC4k1VakCARcvsASaAHGErlKO8OekzsS1fL0CyzKwHXHbMZ8WpqIw604UEz5Enz6sRDwmvhPCHKM2j4PAu6w0d3MM+fEUcLEZo4nIuQIZb9gXW/VgL4oepkpt9XEbi5OLriCkhaIqyw2hxA5oyGNulVlf1rrwyJCwhdEP2H5kR9X0Nfgkh+tjPWTUnNBktBXNHYQgIjyP3JLhUu9NmX2bzFn3mcMsflouhA5DUMiSC8XmxP9WyOi6PQxvYBH7bb9eFDrzi/W8zGjHvZHVEmmTv+KeC03/PCv6zEmm75Y6hicTfCmqNGrtq/4iSnC0xi3+2obQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXu2FVibUotzujbEMyEUdg13yowk93ohNTZie76UJz4=;
 b=N2vKhawvY4EpNzF9Hk3BI3D/EXpk4jn7cmNaaXtPfFueWUzSndIbdkkF769wP4XcBHDIU4dZ8BBPQyiSWoYIsiKis7wE6VMwl66lg1DTWFFOdiUDGmYN1JyG5jSJ8u6jOY3FZ1Dw5dYZ7nvjJLDvJfgSaAjebdOLgXh2POTa/GIc7A7kRWeKHS2sMqhuOnWU7+/n+MHi6/4Lk9F99HRoCNdaR7c+/BbSKwbbfKNEVFu2wviWW9J+ve6S339p0j6Qx0xz5Mtd3uB+eBDXl97QwE44oWppLOC3mtqzUtdtfSePkkAqSn95av4nhJxg9TUKoxgMONjj5pUC81r5ueIvfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXu2FVibUotzujbEMyEUdg13yowk93ohNTZie76UJz4=;
 b=c9THP7H9RWI2zQ4W22Fs6/TIvmAmZnRUYW5ZnDsXNctT1C1nU1y8I9bmAWGI3L34NF/ED6uJhsV6hpkacvVKdo6j0m2PtlSDQ9/+qAzfSoh3i/UEvth0L0Jj24H3Gp1p3XaI+GNcdgzY3Brt8pFr5N6RgPKWq3fENLRpLYcsW/WX/G+trLp8WTOPHHwHj67x9Vtai69eEEFR4QzlwOLv51BilfZtXK54pbhiG0aF7+4BwBXNWrq9hijzAZIipT1IIPekPCT61xAllvXNcalJ2uqvITMOpSUznFAO+NWZtHHXeTFHoS7vVjTH2ChJIhlUNKMmFnvuncd2TLZaw/msiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 13:53:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 13:53:13 +0000
Date:   Wed, 13 Dec 2023 09:53:13 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, yi.l.liu@intel.com, kevin.tian@intel.com,
        nicolinc@nvidia.com, eric.auger@redhat.com, vasant.hegde@amd.com,
        jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
        pandoh@google.com, loganodell@google.com
Subject: Re: [RFC PATCH 5/6] iommu/amd: Introduce helper functions to setup
 GCR3TRPMode
Message-ID: <20231213135313.GE3259566@nvidia.com>
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
 <20231212160139.174229-6-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212160139.174229-6-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BLAPR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:32b::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 400142c0-dfad-4c06-e403-08dbfbe2d9a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0MoNebHTaz36GUH7YHhDD+1gOX1uNU+IHQOdoJBLfLp6GOYrI3BezswENpjTjF/ppw14FinwZI/U+GgsWSVaAYrcr8gqx377ycx9x8AH/aTro1yLgkeqdYkhrHXplX1vpTbutcVFNt+g+Y8Lc39EehE1O52MgM3kyl+i2vkLHxvErI+qwdy3IJ2crscTixN6YycCU61Nh+h3aNLvdRqCHVKlA3f9tb48fJq2pk+jpBoykrV+WcSJvrp5bmk+muWUrvHpsm/LFyF4HNrQJcwFWPTwHRaSoAYvzge/KwsHYs0qlwP8TG6McdEDTD3LdsYRrp7v6BGcSc/vmD49mOJBRaWht2nGoxQz57os7dPD4q7/DVIj1zfhVcsS4+uf3zdhhZXlsVP+SwxFlPtXBUKL2C3mCQba0wPTZ6HuMfWotVm+nXpKbZtvCm6ALoWemID6JTf0jyQ/ojoxA1zEWspi6Cktd8/vAIGcpgL/W/HEOAbH9f1CevTnyZfxoL++G2GU3TVUvYa1Z6GbWNZgjJNCV7J1WmvonPu9U7UQ01jfI3zdnLAzhM+qDVhqW93rMMYaDqGGsSZh4UDQJtvTP7x/NClMOdVRqTvvAjmF7KMBeA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66556008)(66946007)(66476007)(38100700002)(33656002)(36756003)(86362001)(26005)(1076003)(6506007)(6512007)(2616005)(2906002)(4744005)(7416002)(6486002)(6916009)(316002)(478600001)(5660300002)(8936002)(8676002)(4326008)(41300700001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mcmhv+p2JbTpoVY5AcKPM1Mz0KcFs9VsnGdH//MuKK1HrcHinl7iCkv7Na80?=
 =?us-ascii?Q?Z9rdANYlK5qWXgRx4V7IsGedvjiU8GSIkHW+yqDiUbWrd889rX9AHVS9+1UZ?=
 =?us-ascii?Q?EVjavjf5vH7SJFzRG/SE9/s+csY0bBk8DdmJfmNmZbV0ZyImr3ANbjfLCJ78?=
 =?us-ascii?Q?VZCsnLJegkaa2ggpxrVQWN8yrrgHUIiMUwP4NFouRLc+17Y+zu8uscQOmqBF?=
 =?us-ascii?Q?bcNcwxp6VukC8aO3WoPIesXNM1TbpC6nUtIvgnEk6TuTZ4Lmj3YdArlPjC4S?=
 =?us-ascii?Q?NgPzvLx3Je6rYDveJG47v3HxCUp30hMzQ30alxrzxqVhbGlzSU1qdBcIcCFi?=
 =?us-ascii?Q?euhVRBMUBvsujwrF3MY70mQ7Ab0DPynOJW0G+ERYtoHvRimwYTqMY3YVUQ1K?=
 =?us-ascii?Q?98XvhSxdXm+f4RmN34yOzgS89vwcbU2vF0KzYWUpzOGJWFv2pYcjJq1nI23y?=
 =?us-ascii?Q?QkO7EOB9wVbgWzjSE1QXd6JzdlxDD+vVRMADTy8HK/ND4UpEqAj+f+9D9fCa?=
 =?us-ascii?Q?8BYWmkKl9E7po1/WBF11IcZwJeAKtfKZUA++4YzlvG4m3ZUfoLL5ixxE1St7?=
 =?us-ascii?Q?cTe+xSaoLNgHw0aVm8ED3uwV7OU2k0Z8QMZ75cgLGBGl8+mxVxH8VeXK15ic?=
 =?us-ascii?Q?iAeIQr1j/f3XuKocp1vcLlhrIwGnrAKG6sNU1ty+IUmgELFVOTXypxrP8EDL?=
 =?us-ascii?Q?hyNy9VnL2RwWlCiVKZmRbiHadBj5AaamZxQzx3JdiNV+NnT2WGc5okbF42IV?=
 =?us-ascii?Q?5QAyOpsHS1r2O8SA4+ung3G9s9LInmLlUXPiTc+hSm8Db2jREucL9Q62xCRD?=
 =?us-ascii?Q?uL19UT6fKFvtXQylnlGiIBRfGV27uxIFhby1orcPhPfLifJBzJYIlkB5rAp6?=
 =?us-ascii?Q?JLC+Dqr55Q6FO5m3OxOXGE609krBwlKDZkKqrogx8CWqKUp5ss+U/rvObP9y?=
 =?us-ascii?Q?hF+QP1xRu9cWhVfpTFk8YE1vVnR/l0kZzwh5y3Duj2GoCZaCx0kgkZUlzyrI?=
 =?us-ascii?Q?I0p6/uQYCYOa0WViyoDgkCiE90IkbHbqu6xKKfJp78Tr6eMqZlFYMJfvDfc/?=
 =?us-ascii?Q?ID6LCie/mnMJOnyivNAk1LcD09aBJhLEv9SYgo5xvWgM3N6z+6VANLoTSK8C?=
 =?us-ascii?Q?m20vEbx04ZjUTW85mkq4BacCJISQCJ/m0ja1HY2EHJt0Nnm43SdBCsSQcMR/?=
 =?us-ascii?Q?yQoE0Jd7a25hhURTz/rPGC8Jxtb+UPHLAJk60FhbeisvKbLwHIjrVBGSfHip?=
 =?us-ascii?Q?2VcTyOUpzb3idhmWkFanpYLbll4uNmpQGfOuTOO4SD7Ykz2g10p8v0FZCgpe?=
 =?us-ascii?Q?FC6HujPAkqPkbJhU79XoELqPEwjh2Yi0K1TDJg4RwShpT78k8C2khxt8afD7?=
 =?us-ascii?Q?Ppbd1jzL9RD5iDI2u0b9ASmd3H7130v5Ia9XDJI4se19WDemzy5Umfeu+Lr2?=
 =?us-ascii?Q?NJjbhT/EnF0iJQdC57biORmpy8xz810iRK4s5w2UHvEeF4R3KOPaHTLek6Xl?=
 =?us-ascii?Q?VfHcaRjUtCkMjttBgrKDf2nG0s9ucx3lSKJzJDu74RwwciGpZsIn8EY64cKT?=
 =?us-ascii?Q?/LgsyG5iNZYStMimjBPD/9yoWLATlh5IKuwr4z7Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400142c0-dfad-4c06-e403-08dbfbe2d9a8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:53:13.7128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9BMmowDZN1qs7XhtuR+MCTBNIDRVhZPab8lhMZhCSOtG/Bc6cf2jNJENX5VWDMr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 10:01:38AM -0600, Suravee Suthikulpanit wrote:
> +/*
> + * For GCR3TRPMode, user-space provides GPA for the GCR3 Root Pointer Table.
> + */
> +int amd_iommu_set_gcr3tbl_trp(struct amd_iommu *iommu, struct pci_dev *pdev,
> +			      u64 gcr3_tbl, u16 glx, u16 guest_paging_mode)
> +{
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
> +	struct dev_table_entry *dev_table = get_dev_table(iommu);
> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
> +	int devid = pci_dev_id(pdev);
> +	u64 data0 = dev_table[devid].data[0];
> +	u64 data1 = dev_table[devid].data[1];
> +	u64 data2 = dev_table[devid].data[2];
> +	u64 tmp;

Like I said in my other email, this whole function is conceptually
wrong - you can't read the DTE to learn the parent domain's
contribution to the nesting DTE and you can't write to the DTE during
allocation of a domain!

Jason
