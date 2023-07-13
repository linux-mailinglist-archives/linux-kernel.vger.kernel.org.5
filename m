Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A61175160A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 04:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjGMCJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 22:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjGMCJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 22:09:30 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C2512D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 19:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfn79/bmgLjteglkgcR5sTfwi4uiXztTQ9TatqATexBc52DFiQn86auHz0FOo7SkPowffOtD0QT2qs6OX59s1w7yqmHTPmX07xRn/LGVuNYVjaWkT0+kNhx1Tn3A4IOjL3heDuYYEoRWXUAjWQWLyVgn3rW87L90zrGzFEZnMFwBJOZR6T+KY8QxAY8C84agjjDnJSliaKPQvrGUusup6cxwt1jeP6FQZb0DxQIkHxLlW5YTKm8sC4LT8YPjX9/ZoKJiOtIY8NQfeEykff0RoD+Z7UmWSnbIcKcesqL4U1Zl6AavlCAdmmSV98B0VF+UA/T0RpWiBS/GVhF8/O0kMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WG+M00cuYTYhWZkt41iBENQAnpdQaCmoSywoD1j5/oI=;
 b=bjOfsRdQ1KWoUScYTJ2bwIHV4adMlmwMlgQgHLqNeRM7ycnKzD4JoTqaWjRiLBmO7R6sYx3km312X334cRdUHg+2vB0sUK0rHxwrXJz21QAi4mGkOmX578UspTQa7FPVP+aTOjEUJqg7YUzGC8InEH/RkB9Ack2B/6cNyi3YXa73hp6SBZariGI89WQVXgqhR4/9kscujJlY1zQWzjPaSMRZMXQFLHYfhylKFAz84eSexg2Gkll/M9O5c2QEPymD5T0XoWSO1JrM9Unym6SHIta9Pq/wtl1OSjdOvworFhAHS/Jf/7p72lUEv0mclBxKsN18cvEusgoxNW91qZzasw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WG+M00cuYTYhWZkt41iBENQAnpdQaCmoSywoD1j5/oI=;
 b=icck2EeKhKqm39yeODWhDOKg7bV3C0TpwK1uPYLFoI3RbjdPylyDmQlUttW5X1/RZHpgxLNLfGcyKeg5nlcUawwgXLyGkwZ2MrgEm0hT925O9jDxBJ7IL14y7BZWobc/38dZeLt3eRj2kZkfroSqj98T+9FlfOagYTccoGAnShdk7SudZyAavbn2ABmWDQnfIXtwQij2z7j/jm7E5Rro3Q+/5hhh+Y8SXcvmtWtiaUAEQ4tlTgd0S5AOKnBzqtEsCdmTlNRNg4V1JsEw9pEERZrsHBcXpiOkyzM3qijCHGh6KP+MA5eYBDmxEmxJNqXEHgDUO8hOJqQ/Y1DarJdthA==
Received: from MW4PR03CA0148.namprd03.prod.outlook.com (2603:10b6:303:8c::33)
 by SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 02:09:26 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::e4) by MW4PR03CA0148.outlook.office365.com
 (2603:10b6:303:8c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Thu, 13 Jul 2023 02:09:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 02:09:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 12 Jul 2023
 19:09:15 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 12 Jul 2023 19:09:14 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 12 Jul 2023 19:09:14 -0700
Date:   Wed, 12 Jul 2023 19:09:12 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <baolu.lu@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 07/13] iommu/arm-smmu-v3: Keep track of attached ssids
Message-ID: <ZK9cyDaFkAKc1SvJ@Asurada-Nvidia>
References: <20230621063825.268890-1-mshavit@google.com>
 <20230621063825.268890-8-mshavit@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230621063825.268890-8-mshavit@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|SA1PR12MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: ee681e05-32e3-4550-97c0-08db83462f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWz0nr5qg5hf+edUDo5JKfX0kMCj7i/CnAl9R7lZX1AO0D3dGg8d7VRq9WtmuypVDOcDETsEEJNvf2ahccR8Axi3pQvryG99WsMwiMzeXK+BnBqO4vMExknVdm0H9m/T5TVK7yUuyr9jFBHQhQIVguTQv8lb4symUD2kicTkwDGtoOc2vXzzkLAkKYMuGgCa9HGua3bk9JtWbkBkcA7+e0UUhZMDy+fE///iuEizGrZsctMzFVv9UP0vOYW/MGuFX8iRqgVe7TmM6pk7aBkZi9Wsj6LxHcAaGnHjJzJvdDPsPxsJy4flWNIFVqu8PJSTQ0ValZeNJEFKzYUICmoE6as1ZoQhpvjorK6boHsSk1PZXBHMOMxJXH9DczjUAJWWvB62XkiJ5IVIbn9PDFZaWKv7hm/JpKL0eWRdhVWtx485CrDBCFlkpMZxiKd0qJjljkk4GhJi94+T1GfpNjIcatnKZBt8FsdXHtYIK2zJ90bM4Pcn6BTcvataJjIK47LpjAfr5X35fCgUKwCJSGebyjbgVhAXXQuhjvhz9Al3I78EVXv2T29dLqLgx1lvZUaSC+0V82Oia+/RMqZaA+9glvBVg/UKLwQiP30n49rVb/S4idgaXT0KkdmE+sO9XYEFfr9OMgltxRFC2zrlEF1JtdvxXsfUedf15/DKURTLAJgF/W00+3LIk39V26pAlLgIyBAMIwCFv2QKFQwyEwG+ZzQ6XJceMBMuJCeBbemzn4Vd26gpaJChoPj8w4ApqLNR
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(86362001)(40460700003)(82310400005)(8676002)(8936002)(5660300002)(186003)(36860700001)(426003)(336012)(47076005)(2906002)(9686003)(26005)(40480700001)(356005)(7636003)(55016003)(33716001)(82740400003)(54906003)(70586007)(70206006)(6916009)(4326008)(478600001)(41300700001)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 02:09:26.4193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee681e05-32e3-4550-97c0-08db83462f27
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 02:37:19PM +0800, Michael Shavit wrote:
 
> +/* List of {masters, ssid} that a domain is attached to */
> +struct arm_smmu_attached_domain {
> +       struct list_head        domain_head;
> +       struct arm_smmu_domain  *domain;
> +       struct arm_smmu_master  *master;
> +       int                     ssid;
> +};
> +
>  /* SMMU private data for each master */
>  struct arm_smmu_master {
>         struct arm_smmu_device          *smmu;
>         struct device                   *dev;
> -       struct arm_smmu_domain          *domain;
> +       struct arm_smmu_attached_domain non_pasid_domain;
>         struct list_head                domain_head;
>         struct arm_smmu_stream          *streams;
>         struct arm_smmu_s1_cfg          owned_s1_cfg;
> @@ -724,8 +732,8 @@ struct arm_smmu_domain {
> 
>         struct iommu_domain                     domain;
> 
> -       struct list_head                        devices;
> -       spinlock_t                              devices_lock;
> +       struct list_head                        attached_domains;
> +       spinlock_t                              attached_domains_lock;

Yea, I think that this arm_smmu_attached_domain is similar to
the "subdomain" that I was talking about in the previous reply,
though having a list of attached domains under a domain doesn't
feel very clear.

Perhaps it would be good to have some renaming and kdoc too.

And since we have a group of subdomains that are simply indexed
by ssids, perhaps we can add an xarray to store a subdomain ptr
along with an ssid, replacing the list?

Thanks
Nicolin
