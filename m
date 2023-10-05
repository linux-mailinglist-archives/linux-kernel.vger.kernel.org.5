Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ADF7B991B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 02:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244185AbjJEAI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 20:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244175AbjJEAIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 20:08:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BC390
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 17:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I66ma2Bn+M3wMCvowoEKamwxTeBmvxOV0SCEerN19/B6Cl4AQEPFh+3PLa/UBWcyV3o9GyYD+Y5oZqQfJlTEUcdQYzBZgTlKi4Y43IU2NQ5q9fIzovJYG7+e0bls4EuD9vSG/cdtmATFupglQyD0iqDcNGXPMAU9FTajQ4ySP4YVut/9GAAG1yJJnGZSCq2zPvZHHUYVTueWtgrdGaGDa9wzCEAjax5yXuBQqavjy3ciop7GvaD/i6n1itVrQUNkCf/oNFgbdC78yPofu0yzyCEYiYI74xbkbOun5w7Gn/RHPNW+fNE/RcGmzB80d1+dKSlunSFIUGMyxsP2Axf0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXc+CodfEsl+eJeoemzNTAyECejBEBpiBSs82xbR/oQ=;
 b=Kj+3cYEZPWw/Eame/1IHpgvoT730YhSIk96Jultv8ra91okGfq3eJksWZsqWVLe5/qg2royZGkDfBvCRB1yffVxkW2eThhW7K1nEL5JYuZ1PHJT8g/hO7TkQlZfsmjsQuh0jtVwYRl6+9SEq5QE8VpUBjSDHdvACkk/xtBRt9AQEQyZXI9xtdxK+F91RNBhob1a4CD6NyURQ1Y36TvAdEH40AnBQu7oZBltyVYoE4h6/b6Rnyv+BcOlRBsVosUBcYvxM4KNwERMkYt6G2cAKTuycW8GFzSYwUwe78i7ZXJzbXQ1wxhssPyABXChTXgXmW5/eupSxZ9s91EWSEH9VZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXc+CodfEsl+eJeoemzNTAyECejBEBpiBSs82xbR/oQ=;
 b=bJ1HE0Vz7WE+KyH7Z0sfkAFmCcS7Zn9BGKK5uE+MUn5aWcP07hynj+ZZHKpmFTGCoLzw4R4Gcl/twHsHEBpNcxI+FcTCW5vIWw5NOfrfKPP+I5IQm/vBj7Z815/qXxOxSZ2/X51Gxh/8XWHLM7FsZ+4Bhj3p1W5Z4ydLJMkXtEikDt0fte+p+2l699C9Cj7CLlTCBbidfviUq0VUdWa0q0dgFbiuCDuaEKJLaof4QvFYG6ahnbZL6uHXRAxVxnAfn43YWZrkR9/GB0xxG4JIQ5kd2pCXxnUeMvfJNTETugAVrYpxqAhMgzd+LXVPGPwglhR+etOzayqpJ3L7vi+iDA==
Received: from CH2PR19CA0008.namprd19.prod.outlook.com (2603:10b6:610:4d::18)
 by DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 00:08:50 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::7a) by CH2PR19CA0008.outlook.office365.com
 (2603:10b6:610:4d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Thu, 5 Oct 2023 00:08:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 00:08:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 4 Oct 2023
 17:08:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 4 Oct 2023 17:08:37 -0700
Received: from treble.fun (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Wed, 4 Oct
 2023 17:08:37 -0700
From:   Aaron Plattner <aplattner@nvidia.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Aaron Plattner <aplattner@nvidia.com>
Subject: [PATCH 1/2] objtool: return the result of objtool_run() so the build fails if objtool doesn't work
Date:   Wed, 4 Oct 2023 17:08:18 -0700
Message-ID: <cb6a28832d24b2ebfafd26da9abb95f874c83045.1696355111.git.aplattner@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696355111.git.aplattner@nvidia.com>
References: <cover.1696355111.git.aplattner@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DM4PR12MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ff7fa2d-7010-4beb-8b26-08dbc5374091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: myBQYVi5pYC2FtcGDNt0RF5xzd7VzuCHBZlzUmCvCGvg5dTG8BcmP6UzzysfR+lPTOnSrxRaNar20/CGCH83ob/W7MBqC2AlciBmJqoPboCkzOP+B3P8x5HHvkkxh56x5FFpPcRCdQgbiCMktPvQf/g7bqcoHXLMwjNecuDzRy7huVRHexrTvkECJECTMJgIcO55jNTu33KOHClwSdi3cj47SILJNxnvpjDr3bSVGAJTvRALSAb5OQzaQPzCl9vctnHtE/o5QcCdQ98dI4nD6qFMMlnJlQiRjykXQ8rhGFtk55GcWCxOa6tWNnQif86fmNmR0Na2ZeEXnZfBufUFc1nT0X//WefQw/GdW1Yksh3wVK0B7Pf5oRQ4qBbs7DrbBs3VU84tYlNEgyE8BQDrtb9ABL57Uw0IhoT1gFGqz6cbvV7cw3xijK53x5Fug9e3/3ix4TrzXNfkqwl/65ygcHnSjt/ZqsDNsMcApzWTAaFOVVjQ7s6WO1m/Bbv+q6RRDBum/fvxf7hjzJuM+RIuKm89pG2VFzPsSkqk+WM5iI9l6rJ/pu8Lx40YDM7q2W8dU+HP8xL4gcgeA3J8mgAZMrheimMFijq5BSXbOIYSosolhH2XH7wK83Tu4m28cnwYiMQpF/xU7QXTM9F5nPXA8/R8wCzCx5lXLKcjdqYS8Sj89dvPaNwfpsh4Xkatu/a4KE4Mcd+0y+3uzIkxowGfSY2LKJXpYNvr93tKCNZ4Lv6U2ZJqT7xu/56RGkUf/o/b
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799009)(46966006)(40470700004)(36840700001)(2616005)(70206006)(70586007)(54906003)(40460700003)(6916009)(316002)(41300700001)(107886003)(26005)(426003)(336012)(6666004)(36756003)(478600001)(82740400003)(7636003)(356005)(86362001)(47076005)(83380400001)(36860700001)(40480700001)(4744005)(2906002)(4326008)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 00:08:49.8647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff7fa2d-7010-4beb-8b26-08dbc5374091
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5167
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If objtool runs into a problem that causes it to exit early, the overall
tool still returns a status code of 0, which causes the build to
continue as if nothing went wrong.

Fixes: b51277eb9775 ("objtool: Ditch subcommands")
Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 tools/objtool/objtool.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index c54f7235c5d94..f40febdd6e36a 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -146,7 +146,5 @@ int main(int argc, const char **argv)
 	exec_cmd_init("objtool", UNUSED, UNUSED, UNUSED);
 	pager_init(UNUSED);
 
-	objtool_run(argc, argv);
-
-	return 0;
+	return objtool_run(argc, argv);
 }
-- 
2.42.0

