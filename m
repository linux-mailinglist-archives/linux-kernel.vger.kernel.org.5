Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EAD7C6538
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377203AbjJLGOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbjJLGOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:14:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086E9A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:14:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oxo9xmvdfuXxgmPGiY4rVj3vp6t7uQunkVUG7Z+JtMSUD6GHCwqBAtkvaUx7Wzs9dBXpd9qnyxi3A0Dy9prefeNFWp3se4JBswRwmVzVEf5ytxD7JRDiVXqR5tJDk4vncf+cFnU83b5oehWJOk8J24TYbF5UDAz2oq3Im75OlxNj+R3XzVsqJq1gLuToS1Kbq3r7fDuPYn0tv/v9fWDCaxSyd+b47g7swVnsQduaKaGz10KOMQf6/hzP0pRF63MbCRTlfWo/kJu4qhMuDpE8e+lo4AMpIcU7742UFWknYvei3UuyrwmDYRQ3vQ6BkiGZAwmc8om4BNEXnH1fHj4Qig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rdbtkYurJz5aCed2Q5JlAKFdj+KC/r6vwI0uhTk4z8=;
 b=N/TfJm2CURB3IhbERxVCpwAb6ploFLWPTacmP5G3ZgQr15EQ4sQdMePVS2SaqGSMH3ZIgI9SBjOE1WSkRMAVVYqWkewoYECnfMkPnZ8z4BgR3ggs9cAjIHcI0yHBfGNrGZ8x7XleOZ5JdQ5BUegYoMFQ0QxbOld9UakYM4PXO0/47DxUvsACFMxwwXb1FZPBiKqakVL2OAWogHxtTWwGiUdfki0quNr8PzuCgO9Vr/XixU1vKbXtWEAVvNNHVaSdZS5zAVeucCEhqvJ+iodkD7MTZtdMz7HMHKeUQ5CGKxF2qfo5EaCjEDgxzt/i6fxLDuLaFyZJ5BFK0V8TuPLiVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rdbtkYurJz5aCed2Q5JlAKFdj+KC/r6vwI0uhTk4z8=;
 b=aplzLE/BLiWlqB7jk2AltPopM9DmvF3yRh4TSsrgjoFyk+WsL27Dtdgk4yQNL6J6QudFJVq+RBSTKQRfYR9GjIQyUYfp4jtnf5A/JRV0vd4dqI9beQrvml8c/2momuQR2EbzJifn7v4BxktSkmoJGvpyAcVnRembNsM71MDiduQX7s7rLYp2RuU7DMqxqgxDo1vhlrXz2//J/8WK54zMYi5lVKVl0OJcuNrYiUGW7f/cOms8OnASw0zmrQoQlsCtge59yjOsp2tgG63gi6h9jwYDgj9v5oCsCp+Y1EvODV6Eo8/+jMRDvCakGOKMVG8oJK1dYN+3vYreXtOoXmZWbg==
Received: from SN6PR2101CA0005.namprd21.prod.outlook.com
 (2603:10b6:805:106::15) by DM4PR12MB5358.namprd12.prod.outlook.com
 (2603:10b6:5:39c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 06:14:36 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::3b) by SN6PR2101CA0005.outlook.office365.com
 (2603:10b6:805:106::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.12 via Frontend
 Transport; Thu, 12 Oct 2023 06:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 06:14:35 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 23:14:20 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 11 Oct 2023 23:14:19 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 11 Oct 2023 23:14:19 -0700
Date:   Wed, 11 Oct 2023 23:14:18 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Tina Zhang <tina.zhang@intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        "Vasant Hegde" <vasant.hegde@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/5] Share sva domains with all devices bound to a mm
Message-ID: <ZSeOujvhyr8Rr8LY@Asurada-Nvidia>
References: <20231012030112.82270-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231012030112.82270-1-tina.zhang@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DM4PR12MB5358:EE_
X-MS-Office365-Filtering-Correlation-Id: c737f45a-1322-47dc-1b73-08dbcaea823f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4lZ5CiWzweYeY5F6hESNXJC4SKS2sb7jo/OTGPtZ3bWTpzrgZhGAsqhgjU6+qTt4zf5B8KzwH6Js2YwJhKbuo5Y7PWB245r/Qn2j/U/ZwFijcvuH6DTp6R4iXOJ85sGhPXikxi9qpPr5XcSwPB1gkUnrIeXB/7ep4oEFrWFIlcCpZ+OnygV0OpJJjXJnF/Vt30fC+XfFW6USxuHMtflWJJz2YbDC3LNny6fEPK2rasID6RL99EnWS/CXSzxQl1UsFDvgFB9SI6dD4sIIiycRvfdxl0j9ZLSmB5cAN9YUSPl9l6N+lprPUgJ7pD1HGZaX9pSgDw4oaNPXS/I4yISuU2EqOtsncRAZIzC2Q3vBeSeNr/AXt0/v7OPI427el+B3IOBGq5LQyM5QxXB+tvt+bS3w7gyLXbrGl8+j9bc5C/AZxdG5qr0XyQJ8hRLNBP6wxeL453B9PIA/jzK8neV2VCj5jIQ0d3JDF/HENDKixGQut28Kyc8KPTPxiTJvUoo1qnZ84JS4IhZoiXwfSP6Sf87ycJhs/ze1Cv8gAGO2DF/4Kbbv02ODfhUbkgJR0jHIYeLXtxRfgKNJ6o4LJl7cXSbrrerm+LtglEKRAbv+WyPK6SuqiS4g9rASQMlxlSA0HKjnEaymGSmPHtD7bqzq9Xr4yaXk5p4BG9S313UUXwyHQMz8LJ9/UixvwtYdxn7doTV9ysSk//XFU747rmPxtJEOTaIGHZhvbXe8IOLBo8hUePoJdTZUvutybzDs6gC
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(9686003)(70586007)(316002)(70206006)(54906003)(6916009)(478600001)(26005)(55016003)(8936002)(8676002)(426003)(336012)(4326008)(2906002)(36860700001)(86362001)(7636003)(356005)(83380400001)(41300700001)(5660300002)(40480700001)(40460700003)(47076005)(82740400003)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 06:14:35.7982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c737f45a-1322-47dc-1b73-08dbcaea823f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5358
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 11:01:07AM +0800, Tina Zhang wrote:

> This series is to share sva(shared virtual addressing) domains with all
> devices bound to one mm.
> 
> Problem
> -------
> In the current iommu core code, sva domain is allocated per IOMMU group,
> when device driver is binding a process address space to a device (which is
> handled in iommu_sva_bind_device()). If one than more device is bound to
> the same process address space, there must be more than one sva domain
> instance, with each device having one. In other words, the sva domain
> doesn't share between those devices bound to the same process address
> space, and that leads to two problems:
> 1) device driver has to duplicate sva domains with enqcmd, as those sva
> domains have the same PASID and are relevant to one virtual address space.
> This makes the sva domain handling complex in device drivers.
> 2) IOMMU driver cannot get sufficient info of the IOMMUs that have
> devices behind them bound to the same virtual address space, when handling
> mmu_notifier_ops callbacks. As a result, IOMMU IOTLB invalidation is
> performed per device instead of per IOMMU, and that may lead to
> superfluous IOTLB invalidation issue, especially in a virtualization
> environment where all devices may be behind one virtual IOMMU.
> 
> Solution
> --------
> This patch-set tries to fix those two problems by allowing sharing sva
> domains with all devices bound to a mm. To achieve this, a new structure
> pointer is introduced to mm to replace the old PASID field, which can keep
> the info of PASID as well as the corresponding shared sva domains.
> Besides, function iommu_sva_bind_device() is updated to ensure a new sva
> domain can only be allocated when the old ones cannot work for the IOMMU.
> With these changes, a device driver can expect one sva domain could work
> for per PASID instance(e.g., enqcmd PASID instance), and therefore may get
> rid of handling sva domain duplication. Besides, IOMMU driver (e.g., intel
> vt-d driver) can get sufficient info (e.g., the info of the IOMMUs having
> their devices bound to one virtual address space) when handling
> mmu_notifier_ops callbacks, to remove the redundant IOTLB invalidations.
> 
> Arguably there shouldn't be more than one sva_domain with the same PASID,
> and in any sane configuration there should be only 1 type of IOMMU driver
> that needs only 1 SVA domain. However, in reality, IOMMUs on one platform
> may not be identical to each other. Thus, attaching a sva domain that has
> been successfully bound to device A behind a IOMMU A, to device B behind
> IOMMU B may get failed due to the difference between IOMMU A and IOMMU
> B. In this case, a new sva domain with the same PASID needs to be
> allocated to work with IOMMU B. That's why we need a list to keep sva
> domains of one PASID. For the platform where IOMMUs are compatible to each
> other, there should be one sva domain in the list.
> 
> v7:
>   - Add mm_pasid_init() back and do zeroing mm->iommu_mm pointer in
>     mm_pasid_init() to avoid the use-after-free/double-free problem.
>   - Update the commit message of patch "iommu: Add mm_get_enqcmd_pasid()
>     helper function".

Tested this v7 running some SVA cases with SMMUv3:

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
