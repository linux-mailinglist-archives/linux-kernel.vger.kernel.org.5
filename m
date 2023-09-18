Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB1C7A4BAC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbjIRPU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjIRPUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:20:19 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F11619BC;
        Mon, 18 Sep 2023 08:18:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpJovo5p/5cmdk/KbTVUikLjSmUJyCbWW7T0EDzyUb/VMc5IlhXe9nqfIVVCdtMigEmKXcF70P9qoKTcrD0MXzaUzvAXxiNtNKGNd8FhIfGJnYLyUOJzA8OlWWnzDXKqcpIAzQEW0bPKu74/KVIuUaUgO4PS3DPjJUtn5kF7CyeO4xDburJzI6zQ4yElGosSLuDf5S/6jnLBoad7wNSLz2NxidacsR353ssaixayHwaECMYQgQ34uoHhxFnzXINX2pqn0sq85OidypyupVx5FC9BJ3NWOFvi3HcbaKXNPg5UzRBdsEpTOejEuedTZyhXYm4Z/+7FOd/XNmKe1qQIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nCzCmilvp3Su1FcnK3u++hsUeUE9frZQ5nt1rg3F8k=;
 b=hgepvnpqltMNvkfMxdq7MnF3pR9HGGpgaZ1CIxzvObFI7urM0iEVqctthy0MCm0iaRJaMbsiKOfNV+wzD3WT+rs/Ya723EMvwtUcF/pWyfsNQUy1e5dM0RrrqVF7ud4UYDynCbpMPYIfCTUWMUkR0JamV7RK4xtU8pMkdjDheW1mTpnJnRu7TRREZSWbbU8dQg5kwgAzSskbhJx4+YbgGOrz+eU74Q8NQ0BL/3hFdjxtBUILIc0URGXK4/J551WDXYR7g5lp9fz5g4zDFSuaRiZk8HxQdxqSSR7A02cb46C4OByvyrSUv0DuZLw6b0ylsfjEdPztcBehVEadLWIHFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nCzCmilvp3Su1FcnK3u++hsUeUE9frZQ5nt1rg3F8k=;
 b=KWi4jU020GUmhoDZ6cbhG6j7G7/Yp3WHtFYxzBIUCeUwGf3OBPkf47mpTV9SkOfykRD4HBizfKJJiinXWZxhArrspxWuyf7Ebz61qb8jqGhCOhINK/Uy5zNKzH4q2oGKZa4uzDGoWXdKHpVZNpDF60hynf3J9SmJb5wv9iwG5dh4zRODNDGXBmwG8GDio0B9zV/U7bQEKDzQm4lF/8K2Nes7xh+D1/8NYqYazdsdvIyFVg8di+c+zIVxQ10c6+sjV8g8E4bCbUQkFan5fpmC4nkbN0TMElo0n6ZuDqdKhQEEGBMZ71IeneACiO0or5uoIyrOd2NFzkEemoQoWFS0OA==
Received: from DM6PR14CA0071.namprd14.prod.outlook.com (2603:10b6:5:18f::48)
 by CYYPR12MB8653.namprd12.prod.outlook.com (2603:10b6:930:c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 14:58:51 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::c7) by DM6PR14CA0071.outlook.office365.com
 (2603:10b6:5:18f::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 14:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19 via Frontend Transport; Mon, 18 Sep 2023 14:58:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Sep
 2023 07:58:41 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Sep
 2023 07:58:41 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 18 Sep 2023 07:58:41 -0700
Date:   Mon, 18 Sep 2023 07:58:39 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>
CC:     <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
        <jean-philippe@linaro.org>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix soft lockup triggered by
 arm_smmu_mm_invalidate_range
Message-ID: <ZQhln3EQ5DeXhfEU@Asurada-Nvidia>
References: <20230901203904.4073-1-nicolinc@nvidia.com>
 <ZQQLNmmAOsNmvtDs@Asurada-Nvidia>
 <9334dfcd-7749-6ae1-1170-b4952f2b8181@linux.intel.com>
 <20230918092341.GB17341@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230918092341.GB17341@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|CYYPR12MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b086e0-55b6-4c60-377d-08dbb857c53f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d4xzwbFXRdpu6/qOj1aajcXbCnN2iHqp6MVewkMVxiZ52esvOdbO10np35Vp33pg0C5S3QYnKZQKZlKkm9bYoFv7P6zWngq/cTcvt/7ldYW+Bl+TWaEFR+P/ExOP3zibFBVl6Ke4oyMvmGfsp3D8/oHQzDxA6t5Bfk49SYCOBGc0k9XjWkFHQwEneHSDxtM8vbNAIsNWVBGikh7E6X5k8Bo92AltpBRRRgcToOSxanLl217Tu3fOlQrYKZadF1wc5tpdHIHjQW/0ev2LuK95goUsf9D1aRKxVZGgpIu6kz14/bY2yIsiINsZ9oZ06m6DWe6mXQYM9U6XpgjiMsZl5mGPwKgnwCHmd89wfR9/99TavWFvQj1GIS0o7oXC1s4IokmRtYfdhWSWN8BMZHtovS4M2BATI3jwxc7ykpEnqDV49LwHqpGeNR4YuXp41NmdRhYiJfl560+pyJ6XAzVdWqttRUPZuFNGY21151ZOBSQTmK7tn7lnGum2vyPi+KQ+ZJM7mLGSrpmxrbK9Sz3kOGj+DQoBQ9gsF3PJEaaE+tgjMdsx8wmfOsOPNBAmmTGq1qv1NcUFjCugGclnWS/wlYrKr1xgG6wF/bwvkP4g5VWEk63I3OpjHQ0J26ar8hIbjfQrTjMHB91YYJwjBOV7h8EhLO7aAl4yrlr9oeUikOV7Q+0XKvaf2C61d+k01+QhgLkSFBQYFEUZ8xAISm6Y8Gy/UYzutm5ePVu2oPcuiGmkB26S7ehQqvAqaL+DBe9r
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(9686003)(478600001)(26005)(4744005)(336012)(426003)(47076005)(2906002)(33716001)(70206006)(54906003)(70586007)(316002)(110136005)(8676002)(5660300002)(4326008)(8936002)(41300700001)(40460700003)(40480700001)(36860700001)(7636003)(356005)(82740400003)(86362001)(55016003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 14:58:51.2414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b086e0-55b6-4c60-377d-08dbb857c53f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8653
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 10:23:42AM +0100, Will Deacon wrote:

> > If the patch does not apply to any stable kernel that you want it to be
> > there, you can then post a back-ported patch to the stable mailing list.
> >
> > When doing so, it's better to include the following information:
> >
> > - The mainline commit ID of the back-ported patch.
> > - The versions of the stable kernel(s) to which you want the back-ported
> >   patch to be applied.
> >
> > Hope this helps.

Yes! Thanks :)

> Yup, please send a version against -rc1 so we can land that first.

Yea, will send a new version.

Thank you
Nicolin
