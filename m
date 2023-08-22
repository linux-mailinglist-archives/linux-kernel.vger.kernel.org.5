Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEFF78482B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjHVRDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjHVRDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:03:47 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B9E133
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:03:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfMYvOB6Ez7gjrzwuoElErbJV2RyfIV6+OqLy0fqF5/TrjhfcglYdK2oIN0QnzCi4UPnpSpFrdlqlQaaKx16iW/KQsaMF6cdz5I+aIMncHkC3XTTAoJTIVMxXge/cj9c7J2OpyGQlbgAVodz7Q1ZCHMTxnoUXU8Ba/8wkeDBMGK/GxzQJFPirByr4KVAm5pn3p41qVUTZF9jW8nbjd2wtfsQknW+tj9GLDZNvpEwoUbSetZUnhW9G1CSkl518crzcfVcrVGRMEufbzj/Y538ZGLKPPN7DNZP+YnRpGwtc2IFz04nnq5sUJV790RcbwRYGy2+wR6lzEZa1F84QD2Xwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mr5p+NucmYlwPFDtnXdZJnvO4TwdTZyPw15/03hBIbo=;
 b=g9OvKUuEVE72Ow5UBRlc4/2bYPgXztcGhwsApe8uK/VbLCwQmJziSzZto0K153TXqup/DnxfQlGJ0ypcNA8AdjoOrQuzJ9aSH4pk0BaYggUDAE4D14ex+0N1TzGtAHIk2meBUiVuMt9fD7QT6FB3PmfmReYHPMoXtJit7wZGApzDrVmazPP8ES8Qct3yAkDFNeWfDo+pdFSBMAQDfX31AC/JxhzBxKWP2d1iRXlhJ/bi6K/QBsjV2uV5D1BU+xtjsqr0VBssXnXiJD59GkqIJNDpTQ+cK4DxaLwAwZL23DJq1n5gF4W5eS6w75grVCRBXX4mkkBe7x7F3hHBaZ/fWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mr5p+NucmYlwPFDtnXdZJnvO4TwdTZyPw15/03hBIbo=;
 b=LXlt0z29uZf55G8MytFiPFM0jQ/nZVd4qi9MEjMYoix6VvQs5BYB+8I8ZNtXOS0bBJD25J0XxUnEnCkRL4/B1K1LAmyXYc+t1tR19GWD6S6YccnBsGJez5TBN2Vug/Slt70Mc/g3FVxKWHFIMsNwDS8HpYKaCyN0HF5Wcv4w9ibzBrAoZr0QHneZ1iVXfqNbWYS69h6ohx0z/A9CdHlRziLoW7Bpuy3bGYZenppw0Ut7dzP5+EQ4Qi2lVb97OQYdAZPmEpaPymbwvLTI04fVYeYY2xuAhhNnVFIxScQkUyf3zheg+ttetxFAlrBGqUiQReOgf+3n/766xh/9j4bTeA==
Received: from DM6PR13CA0040.namprd13.prod.outlook.com (2603:10b6:5:134::17)
 by DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.25; Tue, 22 Aug 2023 17:03:42 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:5:134:cafe::a9) by DM6PR13CA0040.outlook.office365.com
 (2603:10b6:5:134::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Tue, 22 Aug 2023 17:03:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Tue, 22 Aug 2023 17:03:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 22 Aug 2023
 10:03:28 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 22 Aug
 2023 10:03:28 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 22 Aug 2023 10:03:27 -0700
Date:   Tue, 22 Aug 2023 10:03:26 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <will@kernel.org>, <jgg@nvidia.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 2/3] iommu/arm-smmu-v3: Add an arm_smmu_tlb_inv_domain
 helper
Message-ID: <ZOTqXmzs/wqgI1s6@Asurada-Nvidia>
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <854e2b3f2d4f1b76f916fcfc288b34526d4d4162.1692693557.git.nicolinc@nvidia.com>
 <7e97b5a5-6be0-87a8-aaf7-89980b0a35d1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7e97b5a5-6be0-87a8-aaf7-89980b0a35d1@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 738ca48c-80b0-48ca-529c-08dba331bd35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /fGovevJv6KvnAVSIn60DlKg85IfggXqZWPTiSj5XeCtXqatjqvaMdac43KKXAI3esHSEw2RTd+MZiHucbZqNdxoR41vu9S9b9w2nz5IAs2YTwrIr/1cUnwmpKo47/xVuMM3SzkhjFqJ8Inu/vLk5hVPpqiAsG/RgqeIBOmnxq0zzo3t1uirXr8WyCM9ecAyADZA+3fhE2aHxrQHe6fNzLIqTDI0rwJRXeznQIcxvQqNSBIRo9qvqZ8nH7Pbr75/hzLmjQhGjrf9yjD9VrCV1z8TjpsWu6teEHpsaWJbqup4C6c0sAWyeFHGhs3U++aIrY8+gzP/NGIuynd5WBkKeowzca/SNeZys4h3MUvUtaokdrbbjtxr36UWedLeVRbaBZ2UA+cYiYOWK3WSFlxYZh/CKQO+CEVm9tM5BYdlcFrSboaJ0HLZw3j+Ulvt+RIPoDTOygxkLlIpbgHyOIpBnjZC04QoJvOBuh9WbxfvjbukznjnJsDYjsmoklgw346VMKYm1tZZX7E0y9K9uij7Ci45pfAXnp6NmI7t7qz8XMMSSYJqqGhU3/VJpjI3UCQO+XnouKSFYfE6YRrZEUMDjpAkjIYe4j/+R3aY64Jo55Hh/NQyEGkutPdkEIgfbxsd1bD8y+rlBFUpkSDDq4uZsfnu0c7u6yU3d1ho1Hzrfr5tgjyQ2AhELBIBCbXNF/5Sp+ex2kON21vtWQvwNTiH+QbmlOq3i2eiuTlBeGQQIaHVeApFCXPKHbDqvdQRRe/u
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(70586007)(70206006)(54906003)(8676002)(4326008)(8936002)(53546011)(36860700001)(26005)(478600001)(41300700001)(316002)(6916009)(9686003)(5660300002)(426003)(336012)(83380400001)(2906002)(40460700003)(86362001)(33716001)(55016003)(47076005)(40480700001)(356005)(82740400003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 17:03:42.5076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 738ca48c-80b0-48ca-529c-08dba331bd35
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 10:40:18AM +0100, Robin Murphy wrote:
 
> On 2023-08-22 09:45, Nicolin Chen wrote:
> > Move the part of per-asid or per-vmid invalidation command issuing into a
> > new helper function, which will be used in the following change.
> 
> Why? This achieves nothing except make the code harder to follow and
> disconnect the rather important comment even further from the code it is

We need the same if-else routine to issue a per-asid or per-vmid
TLBI command. If making a copy of this same routine feels better
to you, yea, I can change that.

> significant to. It's not like we need a specific prototype to take a
> function pointer from, it's just another internal call - see
> arm_smmu_flush_iotlb_all() for instance. We know the cookie is an
> arm_smmu_domain pointer because we put it there, and converting it back
> from a void pointer is exactly the same *at* the function call boundary
> as immediately afterwards.

Hmm, I am not quite following this. What do you suggest here?

Thanks
Nic

> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 +++++++++++++--------
> >   1 file changed, 15 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 9b0dc3505601..d6c647e1eb01 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -1854,12 +1854,24 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
> >       return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
> >   }
> > 
> > +static void arm_smmu_tlb_inv_domain(struct arm_smmu_domain *smmu_domain)
> > +{
> > +     struct arm_smmu_device *smmu = smmu_domain->smmu;
> > +     struct arm_smmu_cmdq_ent cmd;
> > +
> > +     if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> > +             arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg.cd.asid);
> > +     } else {
> > +             cmd.opcode      = CMDQ_OP_TLBI_S12_VMALL;
> > +             cmd.tlbi.vmid   = smmu_domain->s2_cfg.vmid;
> > +             arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
> > +     }
> > +}
> > +
> >   /* IO_PGTABLE API */
> >   static void arm_smmu_tlb_inv_context(void *cookie)
> >   {
> >       struct arm_smmu_domain *smmu_domain = cookie;
> > -     struct arm_smmu_device *smmu = smmu_domain->smmu;
> > -     struct arm_smmu_cmdq_ent cmd;
> > 
> >       /*
> >        * NOTE: when io-pgtable is in non-strict mode, we may get here with
> > @@ -1868,13 +1880,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
> >        * insertion to guarantee those are observed before the TLBI. Do be
> >        * careful, 007.
> >        */
> > -     if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> > -             arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg.cd.asid);
> > -     } else {
> > -             cmd.opcode      = CMDQ_OP_TLBI_S12_VMALL;
> > -             cmd.tlbi.vmid   = smmu_domain->s2_cfg.vmid;
> > -             arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
> > -     }
> > +     arm_smmu_tlb_inv_domain(smmu_domain);
> >       arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
> >   }
> > 
