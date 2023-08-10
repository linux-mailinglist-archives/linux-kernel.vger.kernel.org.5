Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817017781E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbjHJT7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjHJT7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:59:12 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E57E2112
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFkUGCAb/sK5TNcQgKUVXmOk0NMBbUlhsYIRsi8ja6aQ1oVvRmrFTvgKKkx7JgNv9VgaURWOjDZ3VdKTTv6oOLIk3cwNDljg1t+50fvQMNtIbXyoEtacdf3LOWUTkd+rtYHGrFv7jO7fFw5Bz0+UPvJWEgpP284pGJnUF3OHHz2hqLgBRMP+oTvXpJtb2gedWRd8tqhRF3Z49EjPoxU33qC8hw8Lt+kAVWvzzLv6hpkTtn+2uyl/djFDiH3ZS/D7Sef8+eyj/HtiFsMCSn4PW3cU8/wDLJyG1xZkWjrzVCcmS9MD6/gKcB20kgKRH2eM6E8ruX9PqgMiD9lfkYBZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqbD74dDFFuEZ70Ohle1rseR7zAyo+q7HCZQRcDQnKc=;
 b=ScZbzM1UrnxHxvvzD3KiX/KOeDNPH5h/RWpquYgPoKimpFH3qNmuM3mZ/571aqXoUT0Jda8thIMVQL16KmYW9tIFIuG5CgDButtF2tTwy6pJaNkuXtHF6RZeOJ+aC1SCz0/4E1rvy7IWc4txpojbPLrYaPmhJncec5BZM+NaOrMuei0vg0x4OMo0kdFvwTy8HdohN3JDfhLVyrs796tLeMINWN8l/FGO89OjZaPXPvoI2JSg0dqCmRATy+xfIcZJuGyi9lNVTAEeO+P1jfGli6xEpXlIOUa6L+50jk14fN/cw9YAkLWBfVX735MiOwfdbYNt3euXtTgDbzzBwfmotg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huaweicloud.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqbD74dDFFuEZ70Ohle1rseR7zAyo+q7HCZQRcDQnKc=;
 b=ez0umGkkkLf9ZtasjioxyP9zAAW/Dgo38nJ/xwVc6PNCkm5KfHIjjJLfzCCC1YJrOWu8qa/cHDRQVp7vCELMLbinH66JC6Qx9SK5SYL7jxhS2zfJJpfb2v6VvBuECr2HUnmYUzTii61oveQ7dP1LoDSp62T/JvRpqgaRGSZtJ6029MI6aIAJToJDfpw7cO6IyUr/KaiuIa2taAWLGYsIMjeWGrWKtIrVPDg0Fd86mJIfA07ERssuI1A9lLVVxxzEtY8yUQHlLGMfFTmAKFvkXbobRugxPDtPkxbqwCTXcZyW9oV7dfJ45V575bllwmIf71khDG0KiUIPbQpE5y9vXQ==
Received: from DM6PR12CA0012.namprd12.prod.outlook.com (2603:10b6:5:1c0::25)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 19:59:09 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::97) by DM6PR12CA0012.outlook.office365.com
 (2603:10b6:5:1c0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 19:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Thu, 10 Aug 2023 19:59:08 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 10 Aug 2023
 12:58:59 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 10 Aug
 2023 12:58:59 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 10 Aug 2023 12:58:58 -0700
Date:   Thu, 10 Aug 2023 12:58:56 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "thunder.leizhen@huaweicloud.com" <thunder.leizhen@huaweicloud.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Add support for ECMDQ register
 mode
Message-ID: <ZNVBgCb5w0daExIL@Asurada-Nvidia>
References: <20230809131303.1355-1-thunder.leizhen@huaweicloud.com>
 <20230809131303.1355-2-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809131303.1355-2-thunder.leizhen@huaweicloud.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa97e5a-3d5c-4214-8127-08db99dc4276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVovRlDF1rqc5svDevpb6YwcNWzrCHuCucHU0pQcDJZ5CwzcGFWJ44R2ZjSWuHaLczAVab8AYn57YyiqtRokjEMLM79ZUJlnJYqvHHqIJAua07rwYmKzG5FDUq3r73MEsiqhURWiWZpgpj0iZPmOGirql9NGEjHWF8aJM8MyyOv2kzV8ezTCmNmZZRibcNMCsRA3ois+UV3kg5dIaWQEkzRKIBsflWeOWsv3jMYAGA+EYUN0aW8ngCORtsjRnSUoGRwJv84LCBwNXxN6mgxPtIKrg7dlh4GwwZZt5KdDqs9YYWin48/f32FHWCfDLPKOlggQKERLc+tVTHTTfZRqV3j6a2HHep3uQQ9O7jed4s2vd8jVjmmjIL8w6ydVDV9tZea0MQJikUcKZbB/iAR8tVzp8SBMtkHsDZO+v1CJYM9D3GMnTTeJkh4m2aWUaZcVyU8g79NKafdrtNzyI1ZZjetneFTtxKLmsdPb6vk6vsu/zf1wjIYsPM0dtUAcymMV7UZS8SMcmyRDe9j1hHwrk9gjsGsWHnW7LMJuhws5cql1FL2QuTCULwGvsgr6dpioqlubRma4MO5/TAEAIeEUFfyzAhXOs9ZqZZCXAy1qLIbUDODjgtBDrsKdGpR7AY6Bt4clDI3XKzpaDy5MwccVHq6PwOsx7bt93R4z/WQCRXcPlnpLFfoEyeHE8b2ulGr5mA/4Xx+Y5GUj8MDvefoJKL3T3c3hLc3Q8miPMPeXAlTIDImhuYHi7kiZxdK8okxw
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(186006)(1800799006)(82310400008)(40470700004)(46966006)(36840700001)(7636003)(356005)(82740400003)(86362001)(33716001)(40460700003)(55016003)(40480700001)(26005)(8676002)(8936002)(336012)(5660300002)(41300700001)(316002)(70586007)(2906002)(83380400001)(426003)(47076005)(54906003)(478600001)(70206006)(9686003)(6916009)(4326008)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 19:59:08.8567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa97e5a-3d5c-4214-8127-08db99dc4276
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen,

On Wed, Aug 09, 2023 at 06:13:02AM -0700, thunder.leizhen@huaweicloud.com wrote:
> +static int arm_smmu_ecmdq_layout(struct arm_smmu_device *smmu)
> +{
> +       int cpu;
> +       struct arm_smmu_ecmdq __percpu *ecmdq;
> +
> +       if (num_possible_cpus() <= smmu->nr_ecmdq) {

Does the nr_ecmdq always physically match with the number of CPUs?
I saw the spec saying "up to 256 pages", but not sure if they are
always physically present, even if CPU number is smaller i.e. some
of them would be unassigned/wasted.

> +               ecmdq = devm_alloc_percpu(smmu->dev, *ecmdq);
> +               if (!ecmdq)
> +                       return -ENOMEM;
> +
> +               for_each_possible_cpu(cpu)
> +                       *per_cpu_ptr(smmu->ecmdqs, cpu) = per_cpu_ptr(ecmdq, cpu);
> +
> +               /* A core requires at most one ECMDQ */
> +               smmu->nr_ecmdq = num_possible_cpus();
> +
> +               return 0;
> +       }
> +
> +       return -ENOSPC;

This ENOSPC is a software limitation, isn't it? How about using
"smp_processor_id() % smmu->nr_ecmdq" to select a queue?

> +       shift_increment = order_base_2(num_possible_cpus() / smmu->nr_ecmdq);
> +
> +       offset = 0;
> +       for_each_possible_cpu(cpu) {
> +               struct arm_smmu_ecmdq *ecmdq;
> +               struct arm_smmu_queue *q;
> +
> +               ecmdq = *per_cpu_ptr(smmu->ecmdqs, cpu);
> +               ecmdq->base = cp_base + offset;
> +
> +               q = &ecmdq->cmdq.q;
> +
> +               q->llq.max_n_shift = ECMDQ_MAX_SZ_SHIFT + shift_increment;
> +               ret = arm_smmu_init_one_queue(smmu, q, ecmdq->base, ARM_SMMU_ECMDQ_PROD,
> +                               ARM_SMMU_ECMDQ_CONS, CMDQ_ENT_DWORDS, "ecmdq");

Not getting why max_n_shift increases by shift_increment. Mind
elaborating?

Thanks
Nicolin
