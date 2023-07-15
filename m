Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125B77545A4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 02:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjGOAf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 20:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGOAfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 20:35:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968703A95
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 17:35:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGDz6Fjt1p9FsTJk179bzMVLgN9dlvwllIdYtwierWJeCOY7SX80Zc8L2e4A87mfX13XEYaqVenTwK0/25DkJZ4zLskz0/hmxrHFYerYKFb4Nzrrmzi7P8yniqaRnnxek0C2ICRBkdJjS4HNdklpdbghhOUodxGTzjkk87zc4nTRhcEb+2dzzLlMGPRqsYzqaK8TPUDcm95srHFH7YERqCiCgYJ2bkL62oSvCZ0tUXHbj+ueM9wrM7peYypw0s5s3r0zqnWkHR7pISRYTvYnDb71wMvrSYfNeH371PRUQs3WVpw1O0t8r+c9n2uNiDpJ+UsIMO+vrjGKGSNxt1x6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzoGl0N6KVOxGFauCUz/zRB+q6KFSHGa1YU6/prPehk=;
 b=IMfkHgzKeG9ZRTj3HmbS+x2d0UPMLADyXmCw9/OkkOS1xMHr3CPzelyhquzIIc9M/PxhJhUT4vi3lFJ3H5rPR5Y5WMwmQSVaJ0LxiWBnz/2GpUd0+VnS87n1Tgqizlh0/gi3gL/QvumHXYdsbcSOF8CsklzXJ+Dpsm7ESZJf7ZrdhKzvG0L0ps+qQ3y6XHNP+HiLjqB5etRW8Nlu7eIYkxSnOTam8mDWfCxSqqBskMTCGc8kusizf4EpjQEtD3oR4PPJWKaNr+J3MEt1hw+8icvvLlZJa/FFGcF8g0dAipFoPCOahTInJb/AiCLyz8Frw+KEw2Ix129eYNfX+1wT4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzoGl0N6KVOxGFauCUz/zRB+q6KFSHGa1YU6/prPehk=;
 b=TozAtZa5ZLwGk7VlF9oRvUXQpNSSVSdvUQs1gXS7AjgXIsrLIE82Ln9JmYmnhKU4OnGu7faTWgMK1aVtG+ixeUmKAEHFy0QOXFG1jsVxtOWFXVlsB4TXcTFG0WrGUyRjbykqeFfTROgvXgAhvJyoRZ8xDzS3MshBuGjZhflTjckgzNq8xGu70nlSCSeOczfg++eMEX5/9uKq35+EEwIlX826/N/fw4WnhgIary5Yc+Oa9nHiEwBT+SGAW8UbVUnU0WxTsPZkOSK26V0Tk20auyFpTbzFPmC+VvhUZNs/vqUZEBtudsPcZXogARucUTCZB/8SNpDnRBrC9BnQeg0m9g==
Received: from MW4PR04CA0286.namprd04.prod.outlook.com (2603:10b6:303:89::21)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Sat, 15 Jul
 2023 00:35:50 +0000
Received: from CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::44) by MW4PR04CA0286.outlook.office365.com
 (2603:10b6:303:89::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27 via Frontend
 Transport; Sat, 15 Jul 2023 00:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT110.mail.protection.outlook.com (10.13.175.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.27 via Frontend Transport; Sat, 15 Jul 2023 00:35:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 14 Jul 2023
 17:35:32 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 14 Jul
 2023 17:35:32 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 14 Jul 2023 17:35:31 -0700
Date:   Fri, 14 Jul 2023 17:35:30 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <baolu.lu@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 07/13] iommu/arm-smmu-v3: Keep track of attached ssids
Message-ID: <ZLHp0r1g1lroGYlN@Asurada-Nvidia>
References: <20230621063825.268890-1-mshavit@google.com>
 <20230621063825.268890-8-mshavit@google.com>
 <ZK+BZhwbo8JLMPI2@Asurada-Nvidia>
 <CAKHBV27idVJ-8YgpekezaQP2n+Oz6OpKnDmYiu_cSOFh6z1S+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKHBV27idVJ-8YgpekezaQP2n+Oz6OpKnDmYiu_cSOFh6z1S+Q@mail.gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT110:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: 027fecd2-93d6-4e9a-9901-08db84cb705b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CgUK8ksEeoUzyGmhKhqC5WQDvPML7KZYZvdBYu/BUwUiFCG8/oAhbdbkqoYLJfDZlsysPuK3vgL2WJJk9kLdOlyBaxYGZp+8eI8vlWuyERXetn2Brd05xYtnWo8AmRMzfEUA/gmgQuFB3/ZUHeNVcEX+9CzZsT6veZf526GTo/V3qFSXQBSrRfwZidkdbP+vWPTuJrF52EP7+92DPaaa6ZUZFQxPeJECtFeskLQYUnjtBQVvmph5mFVieynzwPF08hzihy+979CIL1RsFlAVtWaQO9OpbkjwXiAYZ4x537sduYCMSJcjscp+Ez7CDQAiVwjSRYs+8/hyNmrOVtFe79nbFzc1ceze/1LcoMCxlVKSF5A3f9jw5yekfl4U3uRdktm9CPdrN4HXm2E6Fe/ohoSZJaYHSaV8m2+iw0Pseb6LWffecFgXCt4hHBMRoHdHGayVUdxsZC8rNw3JJaGhb1YqG5CH5aDUbXhZ7uIy1qKdJGYXzqf3gkXx0YmGqjy+CQ2qmc2aOxcbwwycA+QHzs1qzpQ2cO4VrZv95NA9wsibZGUtta23rYDTyzd07/Yu66NTgzxlHGwq8BztQKEHepaQXOxVGYPmoXUeJEVtSKGfc5E564xQ/hxLr1KjxCZSPgq56d949+iondP5ZhMsKw8LnSdIlAC9jc6H5mVuzN8KhdYJssZczbY2LgbHbJyLq9h3SisVwPNbExipdN5qOPj14Xua7d/0CMyfmO3VAFaxW1YhUqUkjPXvBkglOYYN
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(82310400007)(46966006)(36840700001)(40470700004)(86362001)(8936002)(5660300002)(8676002)(41300700001)(4326008)(7636003)(316002)(2906002)(356005)(6916009)(70206006)(70586007)(82740400003)(54906003)(83380400001)(478600001)(47076005)(9686003)(33716001)(36860700001)(186003)(26005)(40460700003)(336012)(40480700001)(426003)(55016003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 00:35:49.9617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 027fecd2-93d6-4e9a-9901-08db84cb705b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 05:30:42PM +0800, Michael Shavit wrote:
 
> > And I don't quite get this part. Prior to this change, it issues
> > one ATC_INV command covering all ATC entries per comments inside
> > arm_smmu_atc_inv_to_cmd(). But now we replace that single command
> > with all attached subdomains in the list? Any reason for such a
> > change here?
> 
> Because we don't necessarily want to invalidate all PASID-domains
> attached to a master. If arm_smmu_atc_inv_domain() is called on a
> domain that is only attached with Pasid, we can restrict the
> invalidations to those specific PASID by looping over them.
>
> But yeah,
> you're right that we could potentially optimize this?
> * Skip the per-pasid invalidations if the domain is also attached to
> this master without PASID as we have to invalidate all its pasids in
> that case anyways. It's hard to imagine clients attaching a domain
> both with pasid and without pasid to the same device but could be
> possible.
> * Always invalidate all pasids by issuing atc invalidations on SSID 0.
> This sounds like the wrong trade-off??

Well, firstly it's kinda odd to have this optimization hidden in
a big rework patch. And I am not sure if it alone would work for
all use cases, as it impacts the arm_smmu_atc_inv_domain() that
passes in a zero ssid, in which case the affected function is not
used by a pasid case all the time:
	/*
	 * ATS and PASID:
...
	 * When using STRTAB_STE_1_S1DSS_SSID0 (reserving CD 0 for non-PASID
	 * traffic), translation requests without PASID create ATC entries
	 * without PASID, which must be invalidated with substream_valid clear.
	 * This has the unpleasant side-effect of invalidating all PASID-tagged
	 * ATC entries within the address range.
	 */

Thanks
Nicolin
