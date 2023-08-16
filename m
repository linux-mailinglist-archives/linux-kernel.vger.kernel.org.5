Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5752D77EDEC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 01:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347201AbjHPXox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 19:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347203AbjHPXoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 19:44:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8975410E9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 16:44:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAR1Y+fSfjPrymN54OiFFjl9TZENcvTujjBKomzWh/YEiw4Qlz1dyoz/NLwN+Er8XOUGBRr4fEJ2hdx92FrTs7qUXUsSCWRld/YnPwH/IULHvkbz5RgP/dt1vhDIMniTrs96e3QSFXd4BOaOHrgjQuJvxz/RSlOSFMtBzLi842vrEKs9tOeksknaWONba8RBDgtu48EROWAMyg5gp1aITyAZxpEtZLYZHREbJBODO1CVEthRJPknnEFqPc8fTEpTJbbX13z14nCrtB1s7wT947kJHa3KOpu24W9f7uJQXsG7LgnJUi6umgzcOpR60LMVrSKnBoiL5Xw0wvfWOckijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DoZCzM0Ju8ZpAaKND8GaFnjSDYV0SAocM9Fo9Sl7/I=;
 b=ECTnRQkZQ3s4+0PKlHJbulb2C4gFZV9v4rqxO0K6V9tIz0q86JUDI/AMA9SgXaOTLHi1F5dxQhpm8Jtxs8g8uK6BTlrEHL3HAQhYqcFY8eb+VE4B24DINvpR1atuXtK96tDlWM66iDm2J5QnVNiB0Q/Q4TzkQG/n/x4A4OPW/86SO8M2V7JmVShnI1D7UxcdN9f+wSHnPC1sqGojzoj0R89yO1FVIeXvbGAR/Zr0ONFi6BV3Y+4f+uwc0tdEFpsQNJB+gyIGXAuhv2OiyT7a2HhndPgTlwc9gvQtS68wf3QjHhmnSkV/xcUsexHjhEhYv3np/3cS9jMdnDNidYV/8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DoZCzM0Ju8ZpAaKND8GaFnjSDYV0SAocM9Fo9Sl7/I=;
 b=WNCSCVja0p/s7RZEPoL44rp3FxpSgG2uo+1DND/eH8ob0NDKNWbrsr1OV/vAeSUy6bcPzTVlgAN/938JJYP03dd0L/yZFOIkTjjx3cGGoWl9nvQeIJ2712kkaYYA2Sj4Wo3AHuEkwCWd7nlXinkDnY8nMwDbSz5PwIjT8WpdiXUMDlS2zhMZtuxstiiN1JKqkpiFnTT0EmE/sbnJQ/lu/FdEEmwjLK6csXO0Nd0gDmeepjxxq7D1vjvWeR+q3dSWrYIZv+Wz9Fe9fdZVo1qGJ2vRWlRCm9RB17k1W73zcO4xiGGW4nB5XN88KhGWWFdvs2GFcBYP9hPTYAKXln4sUQ==
Received: from CYZPR14CA0016.namprd14.prod.outlook.com (2603:10b6:930:8f::6)
 by CH0PR12MB5044.namprd12.prod.outlook.com (2603:10b6:610:e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 23:44:41 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:8f:cafe::74) by CYZPR14CA0016.outlook.office365.com
 (2603:10b6:930:8f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 23:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 23:44:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 16:44:30 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 16 Aug
 2023 16:44:30 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 16 Aug 2023 16:44:29 -0700
Date:   Wed, 16 Aug 2023 16:44:27 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
        <will@kernel.org>, <jean-philippe@linaro.org>, <jgg@nvidia.com>
Subject: Re: [PATCH v6 06/10] iommu/arm-smmu-v3: Move CD table to
 arm_smmu_master
Message-ID: <ZN1fW5CmgbxGTrmb@Asurada-Nvidia>
References: <20230816131925.2521220-1-mshavit@google.com>
 <20230816211849.v6.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816211849.v6.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|CH0PR12MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8c8959-8b6f-45a8-34ce-08db9eb2c2e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YldqRB5o2dMemGV0IC89gciEpGh3YMIHiAYakjkZfXpfRkxhv/DMygvnuCJ5uh3hnIejcnnX4nQ5+Sow5rv0rrqCCsIeUyrkCxVXboyIH/QIdtCz704K/IRbbdAWOJMHdyCPJJAiyzI5ageIoKQjpP7xZdHl7yRHL4qJiIqjXDhmIWeMdw0jx0bP57Oqsg4+Cs/UxMSrgILLoRZRJww/bumQTdr9lQRjE2vqChm2JCG/p4K70+Vw364wooik6jLg6Te6DS4Du0RsojG2qqWGElvEpf3LZ/tIemf2ixAL6GTh/TEbnpTJVFMXnF6AYUXfZc4ZiUPiDxiA8XSiySAgudVyBiwT0+zdsTuSuWOUtd7Puz7DP19MhGIpV5ssXF5wmlavBfjt8eC6SCzpxiTAAfWnhU46mC9c/wCNeZgPJG1lcrHPPNGVDBYcx2ZQgoZ/UnvyrbRT0BJ7BTwt5oiojlzUrtBxKhon+QGB46OdL+D3Xprx+/nE8xbO8yzNBnjiinSR8USGskdBiskVFH21OlXTKxr5Z/I1S9hx0CacqSLYAguFqvN7WIqic/KdXnhkaQENFmTf2fB6S9IUz2XhXHZkjPoYgmgYO8PFSHp6+1gFOETH0yRMoZsoMsqZbqzyE9cr+ftEYrJz/6+zCfNZn/DmZVxl9BrGu+tvRSYTaKICymvFkTrllSLke9Lt/9IPraPiznkbWGLuCLoWbH4jiLL9qarS3EJkPcUyJg0B7sB7S1zxLHvPk/7Pn0v+dfAQ
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(316002)(7636003)(54906003)(356005)(82740400003)(6916009)(70586007)(70206006)(5660300002)(41300700001)(36860700001)(47076005)(8676002)(4326008)(8936002)(33716001)(2906002)(40460700003)(83380400001)(26005)(55016003)(40480700001)(426003)(336012)(478600001)(86362001)(558084003)(9686003)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 23:44:41.2622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8c8959-8b6f-45a8-34ce-08db9eb2c2e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5044
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 09:18:46PM +0800, Michael Shavit wrote:

> Also add the device to the devices list before writing the CD to the
> table so that SVA is always aware of all the CD tables that need
> re-writing when it updates a CD.

Can you please elaborate this a bit more?

Thanks
Nicolin
