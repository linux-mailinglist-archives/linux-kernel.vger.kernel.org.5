Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DA977E746
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbjHPRJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345076AbjHPRJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:09:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EAE1FF3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KV/tuGO5wR2EROxgxptdLrXlh6ZbvXrhdS3Jq6+F8ToI9DLoZI7Ll4hIuL/i851LKO+kYhfgciqapvqn+0iQjJSz/revUqN0B++xeh30beOuw/PidJrH8a1LBWNNf3v2rkMFycUOVkpAC/tHAgIIEUPPOJgR9i7oQSFJFoK9KlQ0+r4DOtGfNyEl0jXymU2xkkYQ6tm0dZFfJSM+sdL9B08y0hy/dNLRXxUttnlt0fqZJXwaE0qttzoFRsDYT/vgKwxduXhMyqyGWKxaZIKBycY7PPNlpICUHxT3RzEr2xXFQbw6U4physM0OCb5p1SXLP0BOAQQLjJ6pA3K7Zf0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufUaEEMAWsqkMgZKw0ekH3wre3hBxP+nIsNCCXgu8AA=;
 b=A8VSXmWcwFQ1kG8fe8zjWok9lsXhv/Iv8b5C94YCTam7BujZITww/Fv+d+neThCJN4TvvRN8gELL5LXdbgBurwMp+K3xncxmZqjZFkqHEumWOGUc2rVTy9KT8FV1SKD6H9vL7IDvJlQUfcT/JQu8haFhmDmdSvA0Chixy9mIJwKuMl792dVCvmJdqsZc1gHuuQn4kC7AIue6wj/P0MVgzoZsr3cfm0oLf14+KGGaQEzpVY6lzpjQA19J9X5TIEz2LPcDV6PrJaZ6mywiDAAKF7CIxSZWspwjM6iDyInH7nm+qbL1GqFQsjmb+b5qC1EhDESGHaLMpJN98BIVA/TyiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufUaEEMAWsqkMgZKw0ekH3wre3hBxP+nIsNCCXgu8AA=;
 b=p+eqOwIS58ia/tR5a8l3i72VIsqszHbY76OIFPLMf2CPxnQQ2M7SGnwQrbS3UG8js1rex8pwPd35DSvo6IY7/Vimn/bRkLxnSurEDTRtjqGGCl3MQUmI5ihPAwknb4rLMAJMgDR61oKOIJRA7B8GJ5E+QqCixJlk5Gw1HRXENSYpytfQuOKiyds1y76dnS6qQdOa3jIPfcOILiwd7QTRp73OqiRalN1Ubqhv7G7FoVaU9Ru7Z9WzSD1BRjSeqYEIOkdHlFMcRkUKkvyVmYatcZDq3gKo9n0hF9PcPSixb278m7t2vsMM+mdostMRNf+Fru2itHmkzpdlSLGWcp0t6A==
Received: from DS7PR05CA0071.namprd05.prod.outlook.com (2603:10b6:8:57::14) by
 CYYPR12MB9014.namprd12.prod.outlook.com (2603:10b6:930:bf::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Wed, 16 Aug 2023 17:09:35 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::ff) by DS7PR05CA0071.outlook.office365.com
 (2603:10b6:8:57::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Wed, 16 Aug 2023 17:09:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 17:09:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 10:09:23 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 16 Aug
 2023 10:09:22 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 16 Aug 2023 10:09:22 -0700
Date:   Wed, 16 Aug 2023 10:09:20 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add a configurable
 tlbi_range_max_n_shift for TLBI
Message-ID: <ZN0CciT2hBISXxoJ@Asurada-Nvidia>
References: <20230814215701.5455-1-nicolinc@nvidia.com>
 <ZNy6Pw/Jxn6jsIxl@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZNy6Pw/Jxn6jsIxl@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CYYPR12MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: c19fee00-0cfc-4a8d-d1a6-08db9e7b9132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDJcs3UdUme3OAGp86dDbO3ShAb1RCMT6WLQ6Wcsuq8anE7CG61BOiiNTt1rGcKbTlt3NnNY2IVmYnlH4szA9XCX45q9pARVUWXAznH/AgfoS6ggNAuLbA7rvD00gQvOE1UFbqAqFB4JtCpM9+JMBgNr6QvP2Zo41nt5I9SvzUlLZZzQsujJg/3p6SyrUWOeHADq0SJZRfw8f4hqoeBTrQnqBpD9hN+E0F/idfXikeg6scxyZTr4b5pOCFaD6kodTAkF3QN2t7UUX1x3BZuSqq62WGSzLihctKpu/Z/yYHzus0qhH98dFqaZ6ljUJU7FFRyPjry2LmYM9k8xWERel/RljNjDZd4hjuz9OPVcijba9ynMBJX1VqZq5B7nFO3cUt/TqpKSinOs/3penDb4necb0XXvdWCmACU5j8l6foBTpHoARwUQWECRvm+JxAxvzamgtg7TE4rdTQugklIbwau6PaBHB1XIK+Ue7zRi3xai3ezZoJozUGJbwKus1Ilxt0sH5XBLFHD2dH79id59syfeADT7043YIh2UIMrL+S9phFChxK3WskNJR0ZFJQeAzbMcKXiC/BUav/aN1bTLLJ7Wf26LhyPbQ3fEXCrIDBiFueQjnRv4bEoMID+ngg7W+pi5tMEWohdi2xvynLEx+26eXVGWtz8lvdXMXkT9Y0l6UsCR6I///goTmabCdzzemIin6Bu9eW9SZtWxgq/aReoh+jPE2ftrhG0xC0tDuehKjb2zUkFlJ3XGQDUDSiJD
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(7636003)(316002)(54906003)(356005)(82740400003)(6636002)(70586007)(70206006)(36860700001)(41300700001)(5660300002)(47076005)(8676002)(4326008)(8936002)(6862004)(33716001)(2906002)(40460700003)(83380400001)(26005)(55016003)(40480700001)(478600001)(426003)(336012)(86362001)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:09:35.6156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c19fee00-0cfc-4a8d-d1a6-08db9e7b9132
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9014
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 08:59:59AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 14, 2023 at 02:57:01PM -0700, Nicolin Chen wrote:
> > +static ssize_t tlbi_range_max_n_shift_show(struct device *dev,
> > +					   struct device_attribute *attr,
> > +					   char *buf)
> > +{
> > +	struct arm_smmu_device *smmu = dev_get_drvdata(dev->parent);
> > +
> > +	return sprintf(buf, "%u\n", smmu->tlbi_range_max_n_shift);
> > +}
> 
> sysfs_emit and missing newline

Will replace and add a new line.

> > +static ssize_t tlbi_range_max_n_shift_store(struct device *dev,
> > +					    struct device_attribute *attr,
> > +					    const char *buf, size_t size)
> > +{
> > +	struct arm_smmu_device *smmu = dev_get_drvdata(dev->parent);
> > +	unsigned int max_n_shift;
> > +	int ret;
> > +
> > +	ret = kstrtou32(buf, 0, &max_n_shift);
> > +	if (ret)
> > +		return ret;
> > +	if (max_n_shift > VA_BITS || max_n_shift < PAGE_SHIFT)
> > +		return -EINVAL;
> > +	smmu->tlbi_range_max_n_shift = max_n_shift;
> > +	return size;
> 
> This seems convoluted for a uapi, you should just make it
> 'invalidate_threshold' in bytes or something simpler.

Hmm. That'd be a direct 64-bit size configuration, and very likely
to be at upper 32-bit range, so I feel the value would be very big
that might be hard to read.

With that said, I can rename the uAPI, yet still keep the bitshift
configuration.

> > +static struct attribute_group arm_smmu_group = {
> > +	.name = "arm-smmu-v3",
> > +	.attrs = arm_smmu_attrs,
> > +};
> 
> Do we really need the subdirectory?

OK. Let me try unfolding it.

Thanks!
Nicolin
