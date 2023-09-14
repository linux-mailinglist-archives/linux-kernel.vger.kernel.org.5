Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EAE7A01A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbjINK05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjINK04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:26:56 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2AB1BE9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=is0q8LeCKEYf84Fjhv2e+mbWBAqyHK4jlABhSrXn+84adXFiBPoF2e9jLcF4ZG9l/0GLZ5T3lZCa6AAEO3N1b5ZksyxndP064Ku6xlng2SXYzeP1jYcu9KzXcgin/90TrbMxBMCfeoB8ATF+Zt12s1X9VRBjn2s9dFfdvrfMFreUtr3jimFoEPbDZicn6m/hHUgYSndYx346FIv2Qer404zlQefBJ/LaAvYMRLb5DFxshg5sdyTfQ8bQ6SXgkoOJPWdtI+XsQPM3X/s1UoCyuyJvcneDMfZDcaqMlNx5VpXwT/T61K5uaLcGJSWkjqAM3QAOBDTBz1aOWbvsgIPkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQs9DQGtNEwGyMiW5mJiarQOkzlF+E62D0Fcmysr7I8=;
 b=msr5F8C3JhiFsDa0CzYF8MHV3fX+aF+s91drWEic6gJAFcD3hYa4c9v7HTzmMhTH9bAHBEZ2QQMx5W5GQ6dn7uFNxa+M/YqGpYRyvnmTAUMCAhpQmuwKWh6wtvGyaM3pcYOOazUjhr2FdSDxXqL2KLiosb/i5/hT5Lyl6SeQSyIiBhwJ6eh6yjiHDzpH5kPQKVEK/7ukbOx1YfVBIemeB4QxrsepTO7XtlKDLrJq4GivaKurRMNhe16idHNBUA/Qh59+15onmW+gPelQxRI3rlusF5y52lYKZyeN1KXzwD2FnmdiESaTViOfjL3Di7W97yS8rwgNzUHXwEys+T0qDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQs9DQGtNEwGyMiW5mJiarQOkzlF+E62D0Fcmysr7I8=;
 b=QjkgrS7/pAfjhypTOKEDLgnBQciGm7FT/U2/E6SpCPXg3/4VBGOXuR9Pt38pHmaoa5oFH3+rKFxc3JWAXmhzzdPihsc98TQhpCoe2lv8ECQdFJMw3tt3sGHzfaZ7MDrbbjozF5laS8owZ4IbGArljPTaUiXHFBmDasYU94XttVKS04t+v2AIzRcmrpbgWxwoUtuPEN43WinYpIAS8IlPhYduXI5OCPp1yC208bPpw/O5M5O/SU1WkrJGmA3tIPdZnfHnYKXF4AhnQbwu0Llgs4Kr/9d7yJodl1PGJQqaf5Rt1F8obcwFh9krVvEfbELbzaKXUcK0zZKCopt9IyLZUQ==
Received: from BYAPR02CA0006.namprd02.prod.outlook.com (2603:10b6:a02:ee::19)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 10:26:49 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::81) by BYAPR02CA0006.outlook.office365.com
 (2603:10b6:a02:ee::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Thu, 14 Sep 2023 10:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19 via Frontend Transport; Thu, 14 Sep 2023 10:26:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Sep
 2023 03:26:44 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Sep
 2023 03:26:44 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 14 Sep 2023 03:26:43 -0700
Date:   Thu, 14 Sep 2023 03:26:42 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     Aahil Awatramani <aahila@google.com>, <robin.murphy@arm.com>,
        <will@kernel.org>, <jgg@nvidia.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <yangyicong@hisilicon.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] iommu/arm-smmu-v3: Allow default substream bypass
 with a pasid support
Message-ID: <ZQLf4uNNQ2YSnD4L@Asurada-Nvidia>
References: <20230627033326.5236-1-nicolinc@nvidia.com>
 <CAGfWUPziSWNMc_px4E-i+_V_Jxdb_WSwOLXHZ+PANz2Tv5pFPA@mail.gmail.com>
 <ZQJbunPj6Q8XRcpV@Asurada-Nvidia>
 <CAKHBV25dfy2q73DmU7X6j_2XNTfgk8kbstanMczy8oZo_WFxrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV25dfy2q73DmU7X6j_2XNTfgk8kbstanMczy8oZo_WFxrA@mail.gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a35649-922b-43e7-02bb-08dbb50d1aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jgz1cbxHG5f9cr6dXn346lJxgcHfX+a+tBJ5aGZRizdY/NUp+UJOecWgDKZ1pK9rqP5m80XDUWI8CbFEjLODGHVBnZUK13K+dehyy4OfKzeQ5KVNCvtgcXHa2N6Avg7dOk/iYFSUfI0GQWInrvOPMzZqcza+d2oJWU8lRzMQNnPnVFmNwI/vZq/N2YzA2GU0x4x4IEEK369p0WozqxMPuGMxWuUF6KFpjI3c++4MW3OXdma4i3Tt3JYsnUAyxZsSqakYS66IpBcFWsGU5T62E7pDtwxPjKlDhVMyXdrxWfn/qKppTkKHJNUx4q2i64F1ioRoF9tQIE/5HpU1S0Jpr94EqLtGA46OqwaSwIKaC3Rf/uJRmS+MxLj46xmWk12wdrxV46O/veBRvx+Bu6YafelJjfD+8T6rb9lezWfR0eysrvJh7zC4qyisgYAadY4nqwmxPvc+mI2qNv/auI2gmt1FyYjzdyRoBMStCfLI3CTQQwaTumudj/QO8lp17lteXRiEQgbjFkoKj+MbL7XwQmUZAlxStgXDABPGFJU5bxW8a3hw4Nf0JvurxS3xe/Ww0YZtMmjqcWKSa1DUo3Ln9fz7lNrogEZ2ZFX0KxT5/LREFiuWhUgqkOEB8GVcn9gbCxnUPLAYAUFHQeVlYXvXPs5kI76R+LlzKZeHvbZWY59JBKtan3xLJvPQrbk+f3NPAiSaZjFCUIEZmZJc+OMAsPjeySbmAFg2ah+lAo645uaM2PvqVCq48esLhe4U1Osr
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(53546011)(41300700001)(70206006)(40460700003)(7416002)(6916009)(7636003)(33716001)(316002)(82740400003)(2906002)(4744005)(478600001)(86362001)(356005)(70586007)(54906003)(40480700001)(5660300002)(8936002)(4326008)(8676002)(26005)(47076005)(336012)(426003)(55016003)(36860700001)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:26:49.2865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a35649-922b-43e7-02bb-08dbb50d1aea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 05:01:58PM +0800, Michael Shavit wrote:
> On Thu, Sep 14, 2023 at 9:03 AM Nicolin Chen <nicolinc@nvidia.com> wrote:
> >
> > This has another version [1] rebased on top of Michael's refactor
> > series [2]. We'd need Michael to respin the refactor sereis and I
> > will resend mine.
> 
> Just to clarify, you'd like me to rebase off master and re-send? Or do
> you mean something else by respin?

Usually we resend patches that were not accepted in the previous
cycle, rebasing on top of the new rc1. So, I would checkout the
6.6-rc1 branch and rebase the series with necessary editing, and
then send another version.

That refactor series is quite crucial for other feature series.
So, it'd be nicer to merge it as early as possible.

Thanks
Nicolin
