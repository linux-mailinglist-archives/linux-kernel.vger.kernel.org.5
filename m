Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20727517AB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjGMEpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjGMEpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:45:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF30E1FC9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:45:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fg+oyJatApsBWRk+PFkdKKrhtgsiygR+gMLDtdThbJXsa3Ag9wn4GG7ORJy0jtnhsJzH8YWtkTcKryZ6Luj22AjzuoDqrZWL/1YGpZeJ8uLuBnlTyfmu9OAPLWnA6sWmWclJtgDaiAqZMs9N5tk3FsuNJa01todQJ+UPFXq2qYK5mxJt/DXmgUTQDv3w+cnnGbaCpIEwZXHib3Wse49Rs4tERyA8ueAJIrJvO3vJjUUI2MasZFljMXPCKIuWvCHa/E563K28uXD4SDZe0Qd8MZ97sc8256oSMOMVKAEa/JUAr02nxwkhx7xhvJtneJxd2goCxnrFE9sYR303HCgtBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBna/mP+DBbTKTY09KfvSsXmz2PzLsEWPPoHWesl0ug=;
 b=e64BY4tkataOTa2myYaFO4B6+A6IirUqXTy+Gq7yDqovCRKBN+vAAftACUmL4OL+PXjRFicFxHRXT+ly2pCSCc1HR03BXCC4UhV/Es39Fc5ac5SyDaadXC/tpYvoi0Nqu64cnS51UJJWoWfexiWYrzRV9QQJ28L1qoaJ8B0c0Zan7MhlCtP0NMCE0IsQfGsz9DvT4IqKUyWC72uRSUKmXx2ArjNqTg+80WSFm06eFc/lB8l0tr8MTOR9YhOQCVGNPHqeX+xJk5LwkPphJCGre4tuD478bDfdwv4TYDVZb7IW8SCQsfg7SNLzNmMJKZhe2/BmCKB/eiTRh7XMm35nyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBna/mP+DBbTKTY09KfvSsXmz2PzLsEWPPoHWesl0ug=;
 b=qX2B3isClRbrRrNZMR/FjhURLqI0Zhz3237fUUI7Dnj9+dcFW/FUVAcbCMZWcg5JXqNLjwTgFu2hYf973WjpO9aYxny1yZZmUWkpcwDcLWNb+5h4LtpsnottClx8WZPohe6n6K1lA8kxfs1Q1X4HW9mJII5pSGNFg5frU/tlfLuU+mbsiVZawJ9/fJ7o0j3E9fB2KJlXmjUNFcnIdNQKRFPqzLTltnWqBnqYx9n5IVW9gs+SYA2pqsMXnXLmLMl0uHshvgzJEssdsn/s9RUZX2G6c4fSqAAhaw0IqRktJF4xhYAcYwFeyVZvyDp2GCf6mQ6jRNBxVdQT6RV0oSF5lw==
Received: from SJ0PR13CA0240.namprd13.prod.outlook.com (2603:10b6:a03:2c1::35)
 by DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 04:45:47 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c1:cafe::9d) by SJ0PR13CA0240.outlook.office365.com
 (2603:10b6:a03:2c1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 13 Jul 2023 04:45:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Thu, 13 Jul 2023 04:45:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 12 Jul 2023
 21:45:29 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 12 Jul 2023 21:45:28 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 12 Jul 2023 21:45:28 -0700
Date:   Wed, 12 Jul 2023 21:45:26 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <baolu.lu@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 07/13] iommu/arm-smmu-v3: Keep track of attached ssids
Message-ID: <ZK+BZhwbo8JLMPI2@Asurada-Nvidia>
References: <20230621063825.268890-1-mshavit@google.com>
 <20230621063825.268890-8-mshavit@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230621063825.268890-8-mshavit@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|DS7PR12MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: 036e7633-d91a-4794-8a0e-08db835c05fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHydVRYULKjk1CM4toGJXc3zR321pUf/a5D//bc725DNY9zmauhViU712XWf7VGDIlVZYMigf9O2xhU9+//L9AYX/VESONo0sATrLGIMOt0BaXKxd94b3UxP2Lv6Lzglr61sPp/tBGHAiB5SOHZRjgByTJ3IAxyxeVzxLupEMHE0IH8wL6RhhsWw0+5EJbapPu7HjDors9C3NslvQAVz6Mw1OU8f0In3C35S6eMvlcAMdd6DeRACHRqUGlio/qObmqbJ3sVYW2mGKZ7+YNPwKIvSelfq4m2E0c2AR7NPlE+oUDEjV/zwuNbLzppLLyYQpk92CpCUgzP6VRl6RS+eBhn125PBnMxXMYqPbNhNqQS5JOlE3Va3D22OibnoUbzi6r025mXGVR46O2QlKA+l86oJNMIQVxLAUsH11KC43r+xAbtM2z61ntjKkqwWEwW0hxKO9jzwNob9t3DZe6qBM7rzpZWQpJJ//toFzIcj9sJg2fmVVdGXICvnowExPAAImJql2MIG/cMuMI9bEcQi2hYifu2XYxKDDq51nOcLppQhDoL98clSRwU9dcQ+/T0VYpmjD1SvgyW0UTsILPOM1mjYbYIPnovE5RelB+Z1qJsRtl00oZLmptv8SBfxLjOe1hUxaYjfh45+L1phOAQ0s7ewi5dTREx8NwzQNVdIjTVk9IDhf9IsZQhs/Gr1JEBoVARku0I1nWM3aLWwWNAmzSQYmWsWnG54IOHvQqz3d0MkdZgv8XPLBba+jjFOaVoKUwzff7ybkVQcfR3kT9AI6A==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(2906002)(83380400001)(426003)(36860700001)(47076005)(8676002)(70586007)(33716001)(82740400003)(356005)(7636003)(8936002)(40460700003)(70206006)(6916009)(40480700001)(186003)(41300700001)(336012)(55016003)(4326008)(9686003)(316002)(86362001)(26005)(82310400005)(54906003)(478600001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 04:45:46.2473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 036e7633-d91a-4794-8a0e-08db835c05fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838
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

> -int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
> -                           unsigned long iova, size_t size)
> +/*
> + * If ssid is non-zero, issue atc invalidations with the given ssid instead of
> + * the one the domain is attached to. This is used by SVA since it's pasid
> + * attachments aren't recorded in smmu_domain yet.
> + */
> +int arm_smmu_atc_inv_domain_ssid(struct arm_smmu_domain *smmu_domain, int ssid,
> +                                unsigned long iova, size_t size)
[..]
> @@ -1823,25 +1835,37 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
>         if (!atomic_read(&smmu_domain->nr_ats_masters))
>                 return 0;
> 
> -       arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
> +       arm_smmu_atc_inv_to_cmd(iova, size, &cmd);
> 
>         cmds.num = 0;
> 
> -       spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> -       list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> +       spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
> +       list_for_each_entry(attached_domain, &smmu_domain->attached_domains,
> +                           domain_head) {
> +               master = attached_domain->master;
>                 if (!master->ats_enabled)
>                         continue;
> +               if (ssid != 0)
> +                       arm_smmu_atc_inv_cmd_set_ssid(ssid, &cmd);
> +               else
> +                       arm_smmu_atc_inv_cmd_set_ssid(attached_domain->ssid, &cmd);
> 
>                 for (i = 0; i < master->num_streams; i++) {
>                         cmd.atc.sid = master->streams[i].id;
>                         arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
>                 }
>         }

And I don't quite get this part. Prior to this change, it issues
one ATC_INV command covering all ATC entries per comments inside
arm_smmu_atc_inv_to_cmd(). But now we replace that single command
with all attached subdomains in the list? Any reason for such a
change here?

Thanks
Nicolin
