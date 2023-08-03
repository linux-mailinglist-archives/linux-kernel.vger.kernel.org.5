Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B5E76DC81
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 02:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjHCASp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 20:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHCASk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 20:18:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356781722
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 17:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mz8aj4XAbkghCnicfMjnLV5f4CJAC4kiVakj61d0cKyASItaT+eGBMJBGwZ2im4bG26sV8RrlaoBpV//eXCDyqZ1cb3qloOCzmdQB+8Bv1SPdbdDaeswhAc1QWTka65TPj9ZtALaxYtAzhRwoWtN+xNQZXiqDNCaN7x5aC9UNeFEknbYJ+MiEg0VrpsNqtODpQxxs8RYCW/pXttKnHQZa1aA7e9ujlDO7axkLUv7//FHPonN89EGnSptSZu5da38O/PEOWDfiWtIxnwHPVKhuky5LUZzBBcxUIWMp/nYNq+xLmmDHDSNWeD0NRHLxeuZEAj1Iag/7ZoLECj2+d+jPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBDw9w/qf2P3eJ3SdwSaHSXS/Zb6kpRN3nbyXAapX90=;
 b=dYsDu+obfM+nqfYRMPxSrNkoXQPnIP8vcWSv0HySYGNrzLi+vKZn/EqV+xCjWu9GWNgrzD6s0LiP7zDZD0dKhXLP5OtqVDfBjWmTKgIQaXDF/iIshVumk6ywKCmvgRYUVVLV6UbP1z5RhdxcM4kpsz+4guL5SgI9dD0ZlfDnxqC4dhDuTKM10EFf/Ck+f+AgpiuyVIQz3Q8Od35rLpj9sXEjqzKVHSpzjW5+FMCwL8a9nVqWo53AJVpgB8KfM4bHim0+giIGqge27y/h8h9y3Bw07W2c8MeNN/jvvXaq8kodfMxOkCmCavfwO4y1XzoFAzDYGnqfps3Q/va1LUpIvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBDw9w/qf2P3eJ3SdwSaHSXS/Zb6kpRN3nbyXAapX90=;
 b=sHZZa6TQ12B76oRX5AQuhGma/6oP79tDiKvnwTYeW0oxFRa+5rYnKWlxb5sRyAnOsXv3xZAKgrAKBO4qtJF7Nke+KP6Pgvp/rSwg9i8u5+/L3wDGfugoNVVOoEs9d0YB3cOQiPrQnkXnTQelMNrOrh3OWybrA7PlcN9+LdZ+KpX/emkWIP31CgBSzhAXAxkRtq5V3rr4dFwk3K3WzQvYcLRILGp5PPLaT+iMYuU+I98SkV6UwpqVLMT7hddxWdNFfKvnz655yJzGVXi9eVyHR4DFJ8AkyPFIhqEhw+2bPdCjlaOqg6DTDuJYfhdzxc4FkV3+OuJFCuOS2g6/DvKb2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 00:18:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 00:18:36 +0000
Date:   Wed, 2 Aug 2023 21:18:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tomasz Jeznach <tjeznach@rivosinc.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Subject: Re: [PATCH 01/11] RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu
 support.
Message-ID: <ZMryW/krEWLEyaq+@nvidia.com>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
X-ClientProxiedBy: BL1PR13CA0285.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 645765bf-7015-4787-b3ef-08db93b72e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qs+uNN0hTMZ74Mhq8KULFmSaIBDpmEVNtGiZdvSLesrHbc4RP5MG6+IIV1VUl+4Ydiz/doPoYmKwDHUm5uAIpztdYrSLKU1YMztJHIUinB4wTizLdTYEkN4IaCoalrlzhzjxN5Mjiq6kdMPxYYycyem3DzpuXDxdcNS9+K5l9AP1HcUEvwbxUnlf+z1ZWOBNGCMfDERZWGa6nKWUqDPlyy9aqKL33QLnVYVsuOgXDlyaKML5O7ytzFZHFEIwvkhmctUJNEf7xwAdS4kv4mLKkdd/MfabVUzdp1NMLkd+PvDm3eGVGA0fJnkEpiShgozbpYWhf9R9OeXtTLQKRyPaM+P2/ktGYnIQa51/qq5k1V8cOxzolMNxVioTzJKdiQtDKvjl5lhqKnDEAYFJrnnFiRbY8AplMNJBLVxX0ijoLdm1gs+9WudfKzeNXjcJ2GndBjRGjD3FqkEC/kIAdx8EuYJ8j4Kz91BPwxqERR8ijHU+AQ2xhmlUe2tkU1ZqSWpHwh0ojZY6OyQnrorSOVKHf7gtTH49FIRhnDU5BQAGy8GMLH2SgnvxE4x6cq6guo9C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(66946007)(2906002)(4326008)(6916009)(66556008)(66476007)(478600001)(6512007)(86362001)(83380400001)(6486002)(186003)(36756003)(6506007)(38100700002)(2616005)(26005)(54906003)(41300700001)(8936002)(8676002)(5660300002)(7416002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O3pPsSpZ0kMEBeMGsIqHGeHBx9KFvZTMwkFMRSXjNwGlBtn/sMFm6NegzUcb?=
 =?us-ascii?Q?Tn1IQp+myfXXLHBmWa+k87QP28H70kwohiI1vrD7/Mh6Y7z4iU0YnT42cVsg?=
 =?us-ascii?Q?a+ZaQq9JqwaNxN/+wcIBEZTwp6AQ2nAZUB6ksQrsW02lADaSzD1VWVIdQE4k?=
 =?us-ascii?Q?h0F6lKeIuSDxppuQ1Au71jqAALc2/7abWs0CNVEWTRKBBZ/ZezGkFdkRtmbv?=
 =?us-ascii?Q?77DGobBFlXyn9m772Qkp79fbIa5k4CW2eq/M/XU9kaQiyxXPGd1sheF2lkol?=
 =?us-ascii?Q?MnvOAtmbF29TdqWlZmsU1H7OAmdN/j6REBsP4sYwpHhqJLIHULQtqug/PDbn?=
 =?us-ascii?Q?EqpTn8/OaNKMGwXjujjhGOQB1VbnnkPkCSND3dj3TZKKM56GCP9c5HGTHRY6?=
 =?us-ascii?Q?NsZ6G6nDYd4aco5cx5K7+gvG4FKs6yLQYC4H2vr0ZZ5/CBAn1jbFcyis1WzF?=
 =?us-ascii?Q?ar7swFl0EoXgDD9RwqnH0HiIcS5zcQJt9beUWxaxePdO+/XlTstBHfDX9Rcs?=
 =?us-ascii?Q?Oxd2uijz8xamhqb59liPRbVcSoPz78Z3w0LQ8bLVPIGwQBXFfUWbF2d1g9pI?=
 =?us-ascii?Q?B5zld0pE6DVTWWcw2/9lHOCdEwshyqW3/zwgZIRM0aVBVIpXrIC+jQcmFcSg?=
 =?us-ascii?Q?p/dfxTKbeHiDltmZ5Hl1jSaUc3TpRYsFfuippFxc5qv9Zr8WUz6zIiYHceVv?=
 =?us-ascii?Q?eHJoHLroXs3YUag0p3mNrBRDvH7LHH/hMe2L0Ptmn9MCNkjIbT0f9F+9J2JW?=
 =?us-ascii?Q?s5Ivtl7MbpOG2ivW8ZziD/BK1/RARC4zvLzx45YhLo44DkCvEfgxyy1+VsBT?=
 =?us-ascii?Q?5JQyb4vzdivTKurcbZNPXj8nu2bAEA3PlPN6PoyoDo07fZRm69oPHonpd3SQ?=
 =?us-ascii?Q?FPmvPiAWDi174JbKH8ULl7RX5oIgthI9044rRTx0h24nzjW9ixY7tRt8gyGL?=
 =?us-ascii?Q?fh4z79Tl3A4zClNf6hPuIwkCSgk4J/t8agwqdWgxukDcUEEI0jTZuobwt+B6?=
 =?us-ascii?Q?LTQSOoc8IvUT99hlX2wykqNzRFulK3Jl41bux1wEDZ/rx2YaKE5jLMBbQntk?=
 =?us-ascii?Q?bwhYzsK8ijFwHHqZ4k390SuMoCdDk/2DqUpdJjv67JWlxlG1KMBvXl+uItSF?=
 =?us-ascii?Q?F6r3ru/abFL4evl6IaSwYiccUw/K1oJV4MIv20BMgk6o9qFGDjxDEWvxsoZw?=
 =?us-ascii?Q?b8KxNfgk1aiH5W7srDZ5/36ac2YcG2jlf0eGYiT8OX358Zj0IlKNQ4/iAj+Y?=
 =?us-ascii?Q?XZx1JM0GH91D54qKkkwDBEOYBG+GSG5tIb4ldsxGNssqLmomxy74JOCa0h6p?=
 =?us-ascii?Q?9aHPbkiCipRmktgNYVTuxHzCD3LUiJSWJiNPza226cpygQsgZjKooNb+znyg?=
 =?us-ascii?Q?9W/qBwDM56u2Sbr1YqIIZngQejJ94G5zGqm9oht2bgfEB4kFST2V+loQYZMA?=
 =?us-ascii?Q?/PTkulG1nDLDdbX3w0CtNwapPBDfwIdPIhNMMx8wLKzkFNGyowFf0uT9YxjU?=
 =?us-ascii?Q?vuJtr9wSax/avZDr5Qlt1GKQKx4wFm1MN7eeF64mvvAx+v3eRnSomtn4tAbI?=
 =?us-ascii?Q?bIE7N8pZlofw2bZ07Ds6ZWFmlwfwjW9iEbzt/kME?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645765bf-7015-4787-b3ef-08db93b72e05
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 00:18:36.7477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UGQNosFV/8RjXD0WflvxX8/AMAP7wAj2ALJtNCJwoaycaIoNfZKmHSMMy3B97G7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 12:33:45PM -0700, Tomasz Jeznach wrote:

> +static int riscv_iommu_domain_finalize(struct riscv_iommu_domain *domain,
> +				       struct riscv_iommu_device *iommu)
> +{

Do not introduce this finalize pattern into new drivers. We are trying
to get rid of it. I don't see anything here that suggest you need it.

Do all of this when you allocate the domain.

> +	struct iommu_domain_geometry *geometry;
> +
> +	/* Domain assigned to another iommu */
> +	if (domain->iommu && domain->iommu != iommu)
> +		return -EINVAL;
> +	/* Domain already initialized */
> +	else if (domain->iommu)
> +		return 0;

These tests are not good, the domain should be able to be associated
with as many iommu instances as it likes.

> +static int riscv_iommu_attach_dev(struct iommu_domain *iommu_domain, struct device *dev)
> +{
> +	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
> +	struct riscv_iommu_endpoint *ep = dev_iommu_priv_get(dev);
> +	int ret;
> +
> +	/* PSCID not valid */
> +	if ((int)domain->pscid < 0)
> +		return -ENOMEM;
> +
> +	mutex_lock(&domain->lock);
> +	mutex_lock(&ep->lock);
> +
> +	if (!list_empty(&ep->domain)) {
> +		dev_warn(dev, "endpoint already attached to a domain. dropping\n");

This is legitimate, it means the driver has to replace the domain, and
drivers have to implement this.

> +/*
> + * Common I/O MMU driver probe/teardown
> + */
> +
> +static const struct iommu_domain_ops riscv_iommu_domain_ops = {
> +	.free = riscv_iommu_domain_free,
> +	.attach_dev = riscv_iommu_attach_dev,
> +	.map_pages = riscv_iommu_map_pages,
> +	.unmap_pages = riscv_iommu_unmap_pages,
> +	.iova_to_phys = riscv_iommu_iova_to_phys,
> +	.iotlb_sync = riscv_iommu_iotlb_sync,
> +	.iotlb_sync_map = riscv_iommu_iotlb_sync_map,
> +	.flush_iotlb_all = riscv_iommu_flush_iotlb_all,
> +};

Please split the ops by domain type, eg identity, paging, sva, etc.

> +int riscv_iommu_init(struct riscv_iommu_device *iommu)
> +{
> +	struct device *dev = iommu->dev;
> +	u32 fctl = 0;
> +	int ret;
> +
> +	iommu->eps = RB_ROOT;
> +
> +	fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
> +
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +	if (!(cap & RISCV_IOMMU_CAP_END)) {
> +		dev_err(dev, "IOMMU doesn't support Big Endian\n");

Why not?

> +		return -EIO;
> +	} else if (!(fctl & RISCV_IOMMU_FCTL_BE)) {
> +		fctl |= FIELD_PREP(RISCV_IOMMU_FCTL_BE, 1);
> +		riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, fctl);
> +	}
> +#endif
> +
> +	/* Clear any pending interrupt flag. */
> +	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR,
> +			   RISCV_IOMMU_IPSR_CIP |
> +			   RISCV_IOMMU_IPSR_FIP |
> +			   RISCV_IOMMU_IPSR_PMIP | RISCV_IOMMU_IPSR_PIP);
> +	spin_lock_init(&iommu->cq_lock);
> +	mutex_init(&iommu->eps_mutex);
> +
> +	ret = riscv_iommu_enable(iommu, RISCV_IOMMU_DDTP_MODE_BARE);
> +
> +	if (ret) {
> +		dev_err(dev, "cannot enable iommu device (%d)\n", ret);
> +		goto fail;
> +	}
> +
> +	ret = iommu_device_register(&iommu->iommu, &riscv_iommu_ops, dev);
> +	if (ret) {
> +		dev_err(dev, "cannot register iommu interface (%d)\n", ret);
> +		iommu_device_sysfs_remove(&iommu->iommu);
> +		goto fail;
> +	}

The calls to iommu_device_sysfs_add() are missing, this is mandatory..

Jason
