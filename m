Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E567A6129
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjISL2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjISL2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:28:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FC1F5;
        Tue, 19 Sep 2023 04:28:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCUataMwejxprwjD5ektB+4r5xdsYSrnO8tCwSMz/F4CzKRa5eoHP3uU3gLvabvle7bBN5C/nIX9dxRmiJCVaw9fnTNwjK+kOamU7CuDdaXtLs1OMTZPjgfXjriTx+QQ5TGX+oM+JNTMntqBdWoD89ytnGY/UfS4fFe10Q+Wa7+7+E6J+1VTaWgmSMJ5aRkU0OX7D4qJ+/ikugEKq/83nJbABVicWLg3LEQtD+Jye2T0B3iZGvBS9C6PBrAyq17JNC/kC/KpFTzBfuZlNUXKR8N5aRNLex+Lw/7FlvSpsiGlUzoGESJ3YCV8cPk+IA3PwQR6gIcHB3F03lXdLyEt7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7R75y0ASBsxBBnlVAMLkLmxf4yRqBy6611LtS4QAl0=;
 b=koeg+ZyceR4jgwnhSLxZcqknJgQijz1SEvIrUifqn3b8NUKmQtBRUZfram4HCXE7NPCrrviDGPICHwJj5F7shksT5T2/lXeAAvfqgQZGqMmNIc9eIYzN09w+8wHiyXf6V7iLGCAKx4kGhv+qYP6060Aw9kcK5yQPwC/8bWBCV8nJe+oKDRz+8TXUtcmeC1kKCQ2HGQSv1ti7T/X9k592cWX9isGpTwakODGc3wxzZ9tceoUfBWe9HvGYHgqB+C9HtROJae2zNhgOhbxk45mlEudq54DTy27rg1fSYO8tS/1eNVAMLZJBm5EcWMSvDwajdcIvL6q//ZxEI5fI/4HpFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7R75y0ASBsxBBnlVAMLkLmxf4yRqBy6611LtS4QAl0=;
 b=LLhcrE1XCO6MpbN5+eaStDcQ79Q2OeFxiECyfuUnmMOPoxi8XCCFiI+4vEyTrirsS3uLJdP6IBLqcmVsAdGhd0x4DNZ0LkQiVELuwpfCig2NVPUsz30Y+pIfPh4NFS+ATz8p28qJswJUrsnG4a1U6J3xhvp4AuMmMICIj2Na1sK0w/cw1UuDP2/NnQ2LNe7Adkq0gzqO+vye8op63xVz/lRcEdBKjvkP1hF1qxYTvYEIH6Vs/UiHM8sDG8MdpGaCpxsxxpSzUNPMAlJP6aWKUH8xZQUmhoUotqBh3dRhDbVdRJK+vxJyZki5v9HVWEI1/kk9dcpr5xcq5ANQUfQ7bg==
Received: from MW4PR04CA0375.namprd04.prod.outlook.com (2603:10b6:303:81::20)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 11:28:29 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:81:cafe::b3) by MW4PR04CA0375.outlook.office365.com
 (2603:10b6:303:81::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Tue, 19 Sep 2023 11:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 11:28:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Sep
 2023 04:28:15 -0700
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Sep
 2023 04:28:10 -0700
Message-ID: <961ffcb4-a9c6-2916-7b90-4a38b0ad465c@nvidia.com>
Date:   Tue, 19 Sep 2023 16:58:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v2 0/2] Improvements to the Tegra CPUFREQ driver
Content-Language: en-US
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <amiettinen@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20230901164113.29139-1-sumitg@nvidia.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20230901164113.29139-1-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e490d4a-c5f3-4df5-8505-08dbb9038bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ubIxyKRk9GjHCs4PJBitRBhxBBlCO8KeY+mNa/90YXrCv81VAVBjE0H6/2J7gk6PMqzZvfyOTxSQGHs3bvvdolWIMHkt64BrFmqEkYi5/scmjzIi+STFORO4qoypu1l0kWUpzFGq/uedN8SVNu/HzrUM+4ixJpavp95zDnfBZyTCoLJDOjdRhSs171IIa9+fzhmGQ+oaUx2RAeW3IE2A7LBKmtqsNbaDTjUkz6COouYax06Hm0lTKT8S5CR0lw9vQuoP0zHmUh/0W5qgWPoAoRjlYAt9fmEPK68a6yqwe0/OWAaT/SS+VEOqZYP3SaHn3B9FaQQaYKDk6qVY3Egf77iROfaHB0hUutqlW2x6UyxkbuNDKUSIasK2nYb2+zUPP83dnDSctaQ+FdsNOIW1QaS+23gtoXPR9UpP4beHgkuED9u3l8FryY++AASAW+TR9GiG3+TzhHTsOUNST4z6pcHYhGJAKxn7YxpOQXwTDP7cEkU7snpK3oaKDxicrO+qoINifxoa+ZC9Tw5+gu5O2VjI5p+RHBy7fIrGSHcxn1SRgO2YTRns/+T3Q6cAImsCIImbrOjKVqJI7/Uvp3M/qRdKkKcumssUTpUJFDmkV2M3cJNxK6zcu8GqYh4387nDDsgqKVGQ5++vSKuoLw4KXyTNsgEF+/Ilc6srkwB83WcJUe0FGGpUaGsoiRn0Ypyl06KsSsQsIvrPSdeMiPnRNy10rKNBYCCZGgml9ZU1vH9pxHdMQ9dHVz7P3VGXagla+6wmjKqEzDVxcfen957aQg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(186009)(82310400011)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(16526019)(2616005)(26005)(107886003)(53546011)(36860700001)(47076005)(356005)(82740400003)(86362001)(7636003)(36756003)(31696002)(426003)(336012)(40480700001)(83380400001)(5660300002)(478600001)(4744005)(41300700001)(31686004)(16576012)(70206006)(110136005)(54906003)(4326008)(70586007)(316002)(8676002)(8936002)(6666004)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 11:28:28.6283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e490d4a-c5f3-4df5-8505-08dbb9038bf5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle Ping.

Thank you,
Sumit Gupta


On 01/09/23 22:11, Sumit Gupta wrote:
> This patch set adds below improvements to the Tegra194 CPUFREQ driver.
> They are applicable to all the Tegra SoC's supported by the driver.
> 
> 1) Patch 1: Avoid making SMP call on every frequency request to reduce
>     the time for frequency set and get calls.
> 
> 2) Patch 2: Use reference clock count based loop instead of udelay()
>     to improve the accuracy of re-generated CPU frequency.
> 
> The patches are not related but have minor conflict. So, need to be
> applied in order of patch numbers. If 'Patch 2' is to be applied first
> then will rebase that and send separately.
> 
> Sumit Gupta (2):
>    cpufreq: tegra194: save CPU data to avoid repeated SMP calls
>    cpufreq: tegra194: use refclk delta based loop instead of udelay
> 
>   drivers/cpufreq/tegra194-cpufreq.c | 151 ++++++++++++++++++++---------
>   1 file changed, 106 insertions(+), 45 deletions(-)
> 
