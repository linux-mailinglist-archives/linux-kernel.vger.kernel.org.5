Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C9E7709A5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjHDUW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjHDUWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:22:50 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BF74ED8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:22:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/wD8YFt6AH6uzObibalS5sIpE6lZ1Alc1ySsRrgIjOPl0vov6blI6dbBn369264Cwz36SjVCDWf01hsQs3GsYoZcku2efHoxbDtBThLRqToqapHG6ZYLkK/E7kDnT2YI4WuIGf4cwq6Z86PClcYZ2F8oXvn0szdEvc0SFBOWfrVaPRMl7kISg++woWcVclctbBfRsmY2nCyvoFWbTevYSx/HCuEyz5ODgw4LrijZ/kAuoI9Xhf3rWzrrlGA7NUUUiSRAqjTBDYDtPxAfo2FFrL+O9erfRf8MW3EM0oDrpsLpzWSibhNswAIaIpYNEEluVoHZD8MNEFOqZfH0oSHjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wii0QHXFHw59+er7SiayxPPSywnun5W3QlyL4AI0a3M=;
 b=QD2H8cJ6WETvHP7CNxchGARop90apQkSoKHChchtsowtOf5SmiKT23NmoN2O3L/VPF5KKlQDSHE8bU1FH+20EKq/K+1sc0C/mUPBh8mShXQzii3ifo/cSovV0FjDcsMzIOG63i/9EH59rLuxR1v8dWV7xXWt/z0UNsIEU/QjA7j40IqcxxhxEPuyw9sYaP1hngUyZXCllj7W86bcyLfD+dpuUQyIjnpamZgMGMptM8RxfTzpGo0QkMgS6vbblfJg9i/5SLjTqKXjPyyfAQUF7Hr9UBAChxg/ATsQWn7+xzjbtIet9C98xoO3vyZiI/BJ4ADf8Kh/EoQDSB5N47RgFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wii0QHXFHw59+er7SiayxPPSywnun5W3QlyL4AI0a3M=;
 b=TcABy6GAs9pORdB1cbbR77OlXKfcmxnIumr5SrRkC3RjWqq826Rwb5YVB6FixZWvtkELTt7lQOuX5bMjbC3TvoPajdeXGlJhrDhETCqfwvr6ydnVMXEXuxx7gTVE04e+s/Ky+C/CZ3Ma/2gwBf5d2ylknZPYqDlcLJaNrA7oqy4OXEcGLe7LG9fAcyHB+uKMMmlBqqClEKfHpWHx6Q4i5+SUWP1wTNMwuNl5GS/Ghm//tQKdKmrskqv6o05yhtPr2hETnipriv4A9qaQwbo5IBuzpiUgaI6njlYj9Glbmi9v82HJTjskR4c51xkUs75DdyZPj6fVES2JTvxmp60WmA==
Received: from SJ0PR05CA0124.namprd05.prod.outlook.com (2603:10b6:a03:33d::9)
 by PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 20:22:38 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::b0) by SJ0PR05CA0124.outlook.office365.com
 (2603:10b6:a03:33d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.10 via Frontend
 Transport; Fri, 4 Aug 2023 20:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 20:22:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 4 Aug 2023
 13:22:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 4 Aug 2023
 13:22:26 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 4 Aug 2023 13:22:25 -0700
Date:   Fri, 4 Aug 2023 13:22:24 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 5/8] iommu/arm-smmu-v3: Refactor write_ctx_desc
Message-ID: <ZM1eAGMxLwZWjt96@Asurada-Nvidia>
References: <20230802163328.2623773-1-mshavit@google.com>
 <20230803003234.v4.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230803003234.v4.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 281feca8-51f4-452a-3d75-08db95288c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sac+6y4M0Hwfsa4ddV5LSaYtqRHMle5bHjGXHfxF/vJwn+xjg5AKvBS1e6g67xRits8xvFpjOE41MskPZKdLV5regBVvXn3G0cHqtw/UEM6dkGKyEPMA2ZlyCsr88vN2e0QFXOFFYbqA3wPWAYNfI8/PZ9+jeCb7wG8MesMKoWf1xzDY+RPiNDQUAM35mTQYQpe2Ya2DVFjVdBQl+7jhT4zIeU9mm26W/gtgzZe41v9/FgHK0Y5+8efiPbOf04eCxEWMVx2ezjWCwYJI4poyXITy8FrKC1j0vjdjzSMIQ8ZCOZMloxy+XGgl/hUGP9YcWRhYbJ1T5/ydVDzBbJtlLhzPAFQgojUO1j5UD24r4qnhThWTj1bZ9rcNHUriesB4QGhdoi97Yh4nTkyEdhSPmNr+ouk5xpi2iL0F+Ee0M1l12u39Vkfe47DCpboK/AlHUk2G0FwgVp6v9UZWSpYLdyq/KEQWBPae45+2atgcYM66dm3SsDYpp/G0iO6zwvnX2cBZpIb7Mu0fL6JEqLP0eVv1F9kkduBbYuf9ge6BAJQeJEVTbS5qt/Zs7YdtKjvJFggxeOmQjlNtcVVlrDUrE3cO/sYNrea86WtFlbZilh73NHUz15teCXEcn8YQeFMUg43J8MgpbYrGHMgS6E2Q2oZ/YyTg4u/OK5Fj61XJ/j8n6E6B3QHlUgpec4HUtOC+S22n93Gnf7lFPl82B4X3OVaxUJr1tojzUyvpMm1hBhkjS+YlX0daxVnQvE5iusPp
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(1800799003)(186006)(82310400008)(46966006)(40470700004)(36840700001)(40460700003)(426003)(336012)(26005)(47076005)(8676002)(36860700001)(2906002)(316002)(70206006)(70586007)(5660300002)(4326008)(6916009)(7636003)(41300700001)(8936002)(4744005)(9686003)(54906003)(478600001)(40480700001)(55016003)(356005)(33716001)(86362001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 20:22:38.3844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 281feca8-51f4-452a-3d75-08db95288c23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:32:33AM +0800, Michael Shavit wrote:

> -       ret = arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, cd);
> -       if (ret)
> +       ret = arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, cd);
> +       if (ret) {
> +               arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, NULL);
>                 goto err_put_notifier;

There are a couple of places calling this helper but they don't
check the return code. Not sure if they should check too and do
a fallback like this: if so, this fallback can be squashed into
the helper; otherwise, this should be fine. Anyway, if there is
a need of change for those, it would need another patch I think.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
