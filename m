Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D670C7B991C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 02:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244166AbjJEAIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 20:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbjJEAIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 20:08:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CEF90
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 17:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJsELwURYehNj6phD4WBc1gvZXW5rdPKXoPymH0yBPVBMO7vVAnDj5amenFH6apZ8mtoq2qq41NK+NPvJe4AaEXUJ6tHwwzJGIWaOdk1tg0saHeqyDc0CIPV1WjZ4XMyBkbeBf1h5VFYpq31fppGdaskJUNH0BUPF3UtN4Aqidy4zJXIN/1j0buzLUvOGicKnQCWWKdj8PvhVR/JnD0URNFR8U8GQ7jptzdlmU6iyiyH9SCQC7BVpGoLpESsJJ3U+1DJdm5LujRZN54Gxppe6okHfAyAWaTkkOiduyq6LgdHeOropItq6kkaKaWvYfSpDPPTkxYL8xP1BjA9+LKc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3XMef5MGKg3oDOzSMsYK6S8JZDtf7jPEKFtWOPMClY=;
 b=mU8w2M6LuSqvNvviq0S8A8YOChG5IPpwEKMHHQMjTxlurSCeE8wOnp5tHd1o2d2fHluabGMvrt4a5ojAvYj/7RmE/eA4/5iWiLv/L8AOG0YSDAcCrO49cVdb+wWF+w0iuElgh2VhwdlrBft+f6COCBwA8NJ60I4IJ4JKIAK+++vnLMCPfPlxdtBxfuWJbHfsAkXF0RPe/otzBYVAvqWtH6hok80dy834MDrk7tJMeu9rwNeZ2OuxqB4nbv1bMOJYRQHAnhp0bxiL9nMMVnTk+MZy6o0SwDlv6ihgt5/N2PMg+Qp06xhBw+xEbvIFyYhYZxQdllYHLcm/UeS99ZQT0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3XMef5MGKg3oDOzSMsYK6S8JZDtf7jPEKFtWOPMClY=;
 b=ZRdBs9lEOeZxHGEl2ejEt1dcJNfnFLOpC6c3+ItcexREnX/WQVEiXhI9A+tXwNIuNV7N1DcBo3O2i+u7Qc1bIbTPkMdAOWuvTrNCjwtR+hBaRz/v2/cN4BgJxZHjAkUkDKWNltnVvqwXyPxN55+YLWkqBIRFqUvQN/eZxpEf99zLgHolh/exIWjdXZK2Dda7kfaRdBZl2YuBwZ/ud05GsIXH83Xn528b1rLXR4JAWpkfvEcVt08xvFL5xG8uHFLnimT2VxNj/iwQ24pN/+HZBFENQNFwRMVTxGar1Vh23rf+Q7W+/jyL1eKrgsOIvSYfUs8OMGcJdiZZYl3ZvG+24w==
Received: from BLAPR03CA0122.namprd03.prod.outlook.com (2603:10b6:208:32e::7)
 by DM4PR12MB5102.namprd12.prod.outlook.com (2603:10b6:5:391::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 00:08:47 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:32e:cafe::8e) by BLAPR03CA0122.outlook.office365.com
 (2603:10b6:208:32e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Thu, 5 Oct 2023 00:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 00:08:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 4 Oct 2023
 17:08:37 -0700
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
Subject: [PATCH 0/2] Fix objtool error reporting and handling of very long symbol names
Date:   Wed, 4 Oct 2023 17:08:17 -0700
Message-ID: <cover.1696355111.git.aplattner@nvidia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|DM4PR12MB5102:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b6ad56-1364-45cb-8748-08dbc5373ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bS3onDkAVX6LgGz/v8ZGRTT5Fa6+ke4DLT4q7RmD0yrboiRdvpTxDVhiDy+hruaN/ZM09gXH5HKA8//FTVu2ZUNTMwMR5qmk0PoVtlEjgqWJ0g8WegxBRsRDLwMUqtIwajzNAMnVnc/4qyt9InJ+jDfPD9f1mBIH1der2RIM/WBNeRgbM47M4jj3T3h1v5la78yYfYrWmRFTmgwp0iszxYqTficzaMzAVrgsY739osulgmf8dTlVg7t0mkZ52FdZa5W+qGjiIQekqzJEPezsvf6mROFwzgTnLKQh6HW0ZRsgqbIzNJyrw7ZLzYe4mZAsaEbbxL4ud+wbq1IWbDBxZxECqrBuYLec9lyHCCLXljFZAgd449gBBzxIvYuVThbiC8JVu/U1OLI9nV0Y6IMwp7SEB3CytlvVWZgXRsC1vRp5dYc8FXTV6SEr7HDx++QGGT/ArAYlVetSJxeCo0h74K/GpkfROx/55pA4cQQuIN8wQLabeTZ7uiFdmxzm6jYgSRVPmWC+RdeVXa5sf36gLr61shDMGx3DSHV9p0Y6aQw1YcUSJAoHxF0AVvjxXMaAOJ1SGg4fkDnnwyRagmKpzwXwq1Iw5CobWyBJ67f48LB3Gua0adLCGWql6tNLNmqUygrPBnOM74gctYfdjnfu9xEN3RtJDtg+KZMljx1xmZzuvxLn0NFvJQur1JJxs+pMIk+e4UwIHsYpd9ex+/S3Z1zs7T8eIiY/EIdbO3/bWwI/PIckPjb3QfmRvLq9/B7iJt8gmeEr08wch+hP4zglnA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(47076005)(2906002)(83380400001)(40460700003)(86362001)(36756003)(82740400003)(356005)(7636003)(40480700001)(36860700001)(316002)(6916009)(70586007)(54906003)(70206006)(966005)(107886003)(2616005)(41300700001)(6666004)(478600001)(336012)(426003)(8676002)(5660300002)(26005)(8936002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 00:08:46.7835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b6ad56-1364-45cb-8748-08dbc5373ec2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5102
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two patches in this series:

First, when objtool encounters an error, it carefully propagates the return
code all the way up to main(), which proceeds to ignore it and return 0 no
matter what. This can cause problems with objtool to be missed because the
overall build succeeds. This appears to be a regression in commit
b51277eb9775c, which dropped a call to exit(ret) when a subcommand fails.

Fix that by returning the status code from main().


Second, very long symbol names with .cold variants cause objtool to fail.
This is due to using a small max length, which in turn is due to allocating
on the stack. However, there is not actually a requirement to allocate on
the stack in this (user space) code path, and in fact, the code is cleaner
with this fix: MAX_NAME_LEN is gone and the ugly manual NULL termination
is also removed.

The net result is a more capable objtool and slightly cleaner code.


Although this fix technically only applies to drivers that generate
unusually long symbol names, typically due to using C++ (and these cases
only appear to exist outside of the kernel tree so far), I think it's still
worth applying. That's because the net result is a more capable objtool:
one that lacks an arbitrary length limit for symbol names.

For example, Rust support is being added, and drivers will be the first
users of that support. And like C++, Rust also needs to mangle names [1].
So getting rid of the name length constraint is just good hygiene.

[1] https://rust-lang.github.io/rfcs/2603-rust-symbol-name-mangling-v0.html 


Aaron Plattner (2):
  objtool: return the result of objtool_run() so the build fails if
    objtool doesn't work
  objtool: use strndup() to avoid the need for a maximum symbol name
    length

 tools/objtool/elf.c     | 14 ++++++--------
 tools/objtool/objtool.c |  4 +---
 2 files changed, 7 insertions(+), 11 deletions(-)

-- 
2.42.0

