Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB357C58EC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjJKQOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjJKQOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:14:31 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C5CB0;
        Wed, 11 Oct 2023 09:14:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHE2HzGWq4IKZAp9wpMoE+PH6V39kqAvcSqEkwUoix1qbyS4IfSEOTec7Urf7bHtBbg3ivRSspbp0jdmICQiUEYJFLqyxJ3pZplvzl5UTiO2JjqzHvTTyBN1No3YuvRuKFefpimVU5d50ZkIz02gGzx7Z03vGA0zs+m540siHQeVmmPpz00r44NiStWxLhwUp3YFna+lQmn29QOY7BLMJwzctnL8ufKh6o8H37XnhmzeoKVvSbNtuslNqF1IcuzOk5WWOQFB1DD6Gj8uzwwbfCpEOrvRafVFWDWUSszsv56nvv++PncWOUhHELSugxGK/vCrrun0uaPBeNomjL4Zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxAr48jZWSkVW5eya7hY1V7YgwubjvBsjmNdEpK6cL8=;
 b=nx0JSRlEQRJ0qgMJFw/D7KulhhaV/K7eh2e9XP1INWlecIiZBQTUgmD0TB9EC3np3KWWtjfFnHaTjUoHfGjAal/5hL3k5d54wgSUOMp0FOHz1GPt6+hinKw6dQYUoAo4ngQ6t6kI8nSiiwh1kpZlJtpJlTMvbRdbuRc2g7SviLEVFmIyB2bQr+FF0W26hmowBdrALD3YuIJcXt2Ic/28wTK3mUyL9VHWu9hJC/5yxGViAtnirqQkBsYWpi8ucQNoOMWvxW0U9VBp69/X8rsR55qn0fMDrmVisq3VnJve4UCQvsE7hDQhvVnKgKm5N3fgmB2ZZxrW4S7X/ujOj9Bp8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxAr48jZWSkVW5eya7hY1V7YgwubjvBsjmNdEpK6cL8=;
 b=kSqrEGZ9KjFWRnA6Y9Ei5qUBgUteRwNEkm2VZ8oc2aI78QE2fI780QsMLJeDv+e5qPd+JuzqK57+KDA5+XGhLvswzUHOP43pGp1R4aUBUJxbWJoMdyZsl8icHiUrLeAMqUaG8EewA3Bz7z2kAmv2Il6wqo97P4lBom/SCByhjKVQJ/CeI9HtzeE1SSWrve4SMj9s3Q3hS78gaog5qhunJDGGoTRh067M5jPGlZGHNNwCr3M6G8hfPRQn16k14LRKrRZRRxEkWNm5Q4Dm8X4N/BolrJc4xjAzfvzO+VfjwTST90DxmOvZHFFPHeTxTqC4rCWCWclCsYvkbgil2dt4Cg==
Received: from BL0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:208:2d::43)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 16:14:25 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::6f) by BL0PR03CA0030.outlook.office365.com
 (2603:10b6:208:2d::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Wed, 11 Oct 2023 16:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 16:14:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 09:14:10 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 09:14:09 -0700
Received: from localhost.localdomain (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 11 Oct 2023 09:14:03 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <andy.shevchenko@gmail.com>
CC:     <akpm@linux-foundation.org>, <andy@kernel.org>, <arnd@arndb.de>,
        <frank.li@vivo.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <kkartik@nvidia.com>,
        <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-tegra@vger.kernel.org>,
        <pdeschrijver@nvidia.com>, <petlozup@nvidia.com>,
        <pshete@nvidia.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <thierry.reding@gmail.com>, <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 1/8] mm/util: Introduce kmemdup_array() to duplicate an array
Date:   Wed, 11 Oct 2023 21:43:59 +0530
Message-ID: <20231011161359.1368-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHp75VdBh0k_XU3GG99EvgLOztOFWn87QXknpokcDy=29yu=Aw@mail.gmail.com>
References: <CAHp75VdBh0k_XU3GG99EvgLOztOFWn87QXknpokcDy=29yu=Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: 15bf3596-9416-450e-7a91-08dbca752328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WSGWuG7PN5iPck+UH+SeUUhs1vsv4Tm7LECToTuhFu46e5E8aJZjmaVIPF4v+q3OzldgJFxl9ErEQdlWIEOU8y6Ka6VPL4GmCEzVrCQSJqCNe0oS/9fQGHi51aVKnlZfHlD/RtY0w5PBUQbidz6/jzDmMrqxAVg2ZKJqib30VnlLxpmQXuTqGon/+QAHftlMUDXnOmzw+F7DYX6+R1CPl9BqjAAyfVptLZKkv1XQ1cDNToJsgkmgG41iO4r4VYlK+TkwGr20sH/hoiSLXlkCmobw5lghJlMjLR/bZ6vUnjzUmjJQ8fcmsNM87PZ13e90FLQ5WPoDKTnMwepXOXuGuUYIpzytZLwJ/rs03kEKV+Zf5YsQAdUNfhxywgZ2aNCWlNcuZOodSCQM5Mqp60qxRNBGPRzAoN7l7/9cpLuJsc73KgdMmPlLBccp6+jYdNsJWCG2havEgs8BP/Qt/MTIvwx1Bod0Z80MEpj7k+6p9pK3VqpUY/AptEr4cr8K8rK4uFkjeqhW1JjAkFOV0ib6gpgWDuosBTN6LJag0Io2Vxs0f9+nYOiVP/DfgdHUANxsyhZJw3qhk334jvGnivQoSgYZCBgVfjvSFv1f89nrjUXD7vbp8WNiydWQ1Vdgvb6eTA4cLmUzIsqIiPF7yHOTNeTzot21hR2+wjcOOVdYz0kFvwYOWzbkjIr/FWOsVK9BZreoKajMr3DF9y+hkBaYGdINjRzi9wSZ6AbqC+2YrJo+HchaBYfn42r1NlZcq7lO
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(4001150100001)(478600001)(40460700003)(426003)(336012)(2616005)(83380400001)(36860700001)(47076005)(1076003)(26005)(70586007)(54906003)(316002)(6916009)(70206006)(7416002)(4326008)(8676002)(5660300002)(41300700001)(53546011)(2906002)(4744005)(8936002)(6666004)(36756003)(356005)(7636003)(86362001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 16:14:25.0709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bf3596-9416-450e-7a91-08dbca752328
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-11 at 18:36:11 +0300, Andy Shevchenko wrote:
> On Wed, Oct 11, 2023 at 2:17 PM Kartik <kkartik@nvidia.com> wrote:
> >
> > Introduce function kmemdup_array(), that will copy `n` number of
> > elements from a given array `src` to `dst`.
> >
> > On success, kmemdup_array() returns 0 and copy the elements from `src`
> > to newly allocated array `dst`, it also stores number of elements
> > copied from `src` array to `dst_count` parameter. On failure, this
> > returns a negative integer value containing the error value.
> 
> Hmm... Why is it so complicated?
> 
> Can it be as simple as
> 
>   return kmemdup(size_mul());
> 
> ?
> 
> --
> With Best Regards,
> Andy Shevchenko

The idea was to validate the arguments that are passed to kmemdup_array().
But I agree doing so complicates things here.

I will update this in the next patchset.

Thanks & Regards,
Kartik
