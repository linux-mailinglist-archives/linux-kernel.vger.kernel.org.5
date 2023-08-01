Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4AA76A7CE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 06:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjHAEPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 00:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjHAEO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 00:14:59 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBBDE49
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 21:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYR7E6+rI3qWny7IcpVYyT9Ep7ZdWssyc7fu8TgvIypDyPheYgO8PsIK8d6xCFXfAb30pu+vxJHlU7v7m/GAlO8XFgglL8TVgXg3MoL5gIbhRDtbo83yUW2TKaqOAuPKoG/y0uDQQhDTK5LeIDUyXnuKXzSNRnFacfewf9AKWbESQC6rGzdRC4q5bXeF8CwPWkLQCkasQyy3rnwJ3Op0BcQ0oMPCw5VKgSW9YworBR780tg03gxpwvEJKSz6FRTwFlOEkb737oq06/XcGFIeih6LZWfIIxIylAl5ZQdyj79JvQK4JDcQXqARc8CUa7d2OH4Z7lQXjdtz+M1NWvB0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LX54VxbeJT2rYFLFGBMTryxRdHyaVRPwOQ6RF6p631c=;
 b=YTxJIgK8PDgWk84UXavT0x1Dv0rXDX+qhuuZfzoMnRf95HDr/OCC3Ph46mqwahdJM/xXCC12uTCrwduHoPfGtFbUqQANi5yF+btnnkOI918DfmTr3rs6Yz9Xbyo/q0zvNaMtSI0boegYzBV0t+bng8N8JFRmRbb51k5hrOvyuOG9F7/HBdKcGMmHZoyLEveUy8lkUeEGjIPlhknl3raCQ+NsCG2AoD7adOpJ5iLHJgTx9Vp5FKiZF4km0u86oNPvz8Fc9sxbuhYD+DXmhBTtu4YOG7RQpd89mcctStnF6Gk0n6WDWTI7eO55ycXiXPQ789m1TZyywAz2RNMUNS8DXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LX54VxbeJT2rYFLFGBMTryxRdHyaVRPwOQ6RF6p631c=;
 b=V4e0902rdzAh5E3DhaXkq69XZU0/i8hshmdXogZYThL5EXIc6lPdLAPyt1vicy2XKw1VzPMU9bKsojIrVWkRfG50QqnjjXvj3SXbPJVsUQuCzHyK7PpYl65jQzcXCGsUDZnmDHLe6FziVlcx+oqrEy+CeArihjWNckoaTTer3kORtgj9D8mfzn0g/QT9wSyNvZfP9jlKLhGvkblLivH3cjGEUIDK1+sHZ8QJoikcy76BvzOddB//O2zMBuCAe4mE7lPzUDnQvaVpo6Y0DY/WGp6D2YoQh5c5h/lwlZkh1JJyz9qjft6Q8+35MrxO/IbjfdblQU87MAJJeM732UE3fQ==
Received: from MW2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:907:1::34)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 04:14:56 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::3e) by MW2PR16CA0057.outlook.office365.com
 (2603:10b6:907:1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42 via Frontend
 Transport; Tue, 1 Aug 2023 04:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.34 via Frontend Transport; Tue, 1 Aug 2023 04:14:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 21:14:45 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 31 Jul
 2023 21:14:45 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 31 Jul 2023 21:14:44 -0700
Date:   Mon, 31 Jul 2023 21:14:43 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 2/8] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
Message-ID: <ZMiGs5dR6IKF855y@Asurada-Nvidia>
References: <20230731104833.800114-1-mshavit@google.com>
 <20230731184817.v2.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230731184817.v2.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT059:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0c93eb-64df-4fdf-9279-08db9245dd03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJZcbfVH6gkgQxBcEIue0/vxQUuiAerKPqqlAXKkT2/gxrSEeG0WU+dw4E2sEhV61K/e9D0KKJ84DEJaxdNNu6oLlqx8po9dYhAGCNaCU3+OTFrEXKIwMvXSNqbu3YOK6ww/MhKwZE6DGNDYmR06TWPWWxSQmFTDuCrCLxaN9XgOnpHvR9aL8dR1AmX9eZ1SkKyKNQF57mF1MfjPFd9l8xgezAar25m8TDlnWhdxldGPZlXYh0tZUBjfVtdQDr/5zmWJDhk55LII2Dys5SQegukaPrQqn8Lgsael6n7w7aO56piEj8JPDdsz1FXnhiDTUOgr5kf6eNIgK8bdyBr4YDsKjoZSHUczD8L9aOuaEi21duqRcRKbK7+W+zqa/x+OFNZ6niJ2cHPwC6ux74jIKFrsogU+Uiaq7230+xQ+lz8BfzCaj4kBI0YsrmR9w/IOmww2pEWdYExePXHTf5ACssbP6xEmKqVZWIBe49cJLp4twqnba8TfS27FR/ryt0YeD0qLa/BhuZJxUaoimOO/T2U38nhZ6ZB/t6Ra3lC+IH29DyNMuw3moLACF//APzqei6mOnf5Ohf1UKD1ih4yyR1foMz1/HDv/A6mB+N5fbACk+UTqlTJiUu4L6NWh0kaKW/1/kTPQuyxssZoNUjocclaHjaSJgzl++AM02Vb7SawVX6pDY3+1SkBDBGtLW+MGz3uyBHTgfn0bEK5OprbPCsjzNrZGdXxPV0lITjZo0TtOn49y5fKkRdHbirOcghA1snrZhg/x3SapjWhKKCPCtw7e76OX2jPR7OZiymAvk+I=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(33716001)(82740400003)(356005)(7636003)(55016003)(40480700001)(86362001)(40460700003)(9686003)(478600001)(186003)(336012)(26005)(8676002)(8936002)(5660300002)(70586007)(70206006)(6916009)(54906003)(4326008)(41300700001)(316002)(2906002)(36860700001)(83380400001)(426003)(47076005)(473944003)(414714003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 04:14:55.9736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0c93eb-64df-4fdf-9279-08db9245dd03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 06:48:12PM +0800, Michael Shavit wrote:
 
> arm_smmu_ctx_desc_cfg is renamed to arm_smmu_cdtab_cfg to make it more

There seems to be no change of renaming "arm_smmu_ctx_desc_cfg" to
"arm_smmu_cdtab_cfg". Even PATCH-8 only renames the local variable
"cdcfg" to "cd_table". Also, we should not use PATCH-8 to justify
this change, because it makes this patch less convincing since the
PATCH-8 might not get applied at all.

> obvious that it represents a cd table. The max number of CDs that can be
> represented by the CD table is stored in this truct in its log2 form
> since it is more useful for users of the CD table, and replaces the
> s1cdmax field in s1_cfg. Instead of storing s1_cfg.s1fmt, it can also be
> trivially computed from the cdtab_cfg, and is therefore removed from
> s1_cfg.

The commit message does not quite well describe why "replace s1_cfg
with cd_table" in the subject. It could mention that the goal here
is to move cdtab to the master structure. And "unwrap s1_cfg" might
be more fitting in the subject, IMHO.

Thanks
Nicolin
