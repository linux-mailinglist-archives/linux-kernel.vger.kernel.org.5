Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3F375A2BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjGSXWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjGSXWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:22:13 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEAD2123;
        Wed, 19 Jul 2023 16:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZY7Xc5bLQiS+lSBnCtR21Y+qpo+r2yyVTh7rKtxsMn8HapYX8CejZTmp6qGit+MUHVDfXLMJ9Epefl6B2iNSseGwvHTFvYTprTMj4IGpEEnLJuirMGgM+0kuZ+wtoABoT361EdF/mGaTSZUNokssn5OueEK9RBawUXnVtAfJO/NkGWqVci9vdP+P/3Onxv7YVqbUdBn5j0Z7DPRvADYvJ42L7qNJqVAvzenxuFAl6poGitK1xa/CVwS2Gk+BSZMCLU1JWMEZrjY1G6ruj7xom93/bwQ8wrL0CytKdeoBIz//H/d/JUJbfzA7d2fSAqsdAvMn+92hKwDTFtdlT1RToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sb12peGDFs/wQKrqWuRnsyseXFMg7ZiqzMWBfgnQtXw=;
 b=kMzmQzL1VUjgFfsadZ6EDJUwgCRHY85lfc7NbsxYTux7JypaD+77kL2EG0UgXRrgxAkWAc3LCnm6GWCkJiISMkM6f2tIY4VlFtkNLJ4zHUnUwIXgXZSYg1mq4KPDZPhAjlDr2IImD02o1WpxZGNqeL/ATWqrv4j/OxU2DwQqFA8v3NZK0q+R1IN1GCUOkmPwKcFK5HvzNpyvaIVIVeChPEze1SUW/CD28To5CuKhvqEwmSP5Vqn40HjFImpaTff965T2HJ8rbxAcme7tkWDG7UjTaheffdk6//HrDJ1ZKilznQvD3JU+8FSGpFtlE9EQ3Z2xNw6bYWVbXZV/BOgJNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sb12peGDFs/wQKrqWuRnsyseXFMg7ZiqzMWBfgnQtXw=;
 b=1RWuwZ5oH040weJW5dpTLmoO5XJcIW5cUT5yJRIege4KHSamHKyNgdPfjx1kYm58xGxL8ng8GuQjDd19wvsEOnejceqSSuRLJqne3Rc570YyNQ8gpUpXkSzfDZLSZnVG/+HJpwR0ZREyqq5kjsP1g+2AW647ZTPb1CahvZJCWzs=
Received: from DS7PR05CA0107.namprd05.prod.outlook.com (2603:10b6:8:56::25) by
 DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Wed, 19 Jul 2023 23:21:58 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::c5) by DS7PR05CA0107.outlook.office365.com
 (2603:10b6:8:56::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 23:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 23:21:58 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 18:21:56 -0500
Subject: [PATCH v6 4/8] x86/resctrl: Add comments on RFTYPE flags hierarchy
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <pawan.kumar.gupta@linux.intel.com>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>, <babu.moger@amd.com>
Date:   Wed, 19 Jul 2023 18:21:55 -0500
Message-ID: <168980891501.1619861.11056885467637617879.stgit@bmoger-ubuntu>
In-Reply-To: <168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu>
References: <168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT064:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: fb15e83a-b1c1-4c00-3f71-08db88aef318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: flZ1IBDDmBEY+p+kjZGitUdeMLtoRBvda7xQYFgZ03Ax5eWX9cPthPuvTPc1F4bggEiQQFamXgIHdvIv+j1g0Xm1OEveVG+SEn9IccHqO5B/uHTlAwAfPxEdu+bYfPTCftiOpVeCWGBBvWyG+BBYxvuUkpVktbC3GdYa+eLTHsO6zmw6Nd9G+DJ0LaqNUFRNahhHi0P3j4pqBl1PzZ32QFP02/u7I7b2RtjRvgN6IrIcYKwXBlPd11eStT/x0blXPNbm35PutETKhGs47toCMsip2Yrvae78Gu9NleMtsw3cE/eDQZQuYxWmNUueSjKDk1qYoPzBVwGol2ywDlMHDYb0EJR0c2jy62DSR8KLU8ThfHSPOdBadbPXxmHjsgMqcVOHnAjx5fPhF7gKq4AGzQs8ARIGrvLaN+gTLr9Uu4PXlJxAgT0FrtH2Wm4G2BgxZuMamxEIcNWjA1wuAbtUTeVqgeaMPLvJxRMupa4+3f/KOdVBUrBWtqCbD5uZX8tD8ntPjFanvp7WxNQIC7XqdiBfbqq4r+AT02nGvVICtj0r5nEF4q+bJAep6dTGhvri2dHRYjKAzkUfRqAsiCXy7deUQxAjtGHq0Rg5UeqJoPuPih3rQ8FrtuerxZBzYMjrOL7tR5Gud8EfixX+QkbswKIUM9ODsAfE005t8y+mI0xHDkeUCHfTnHl5F296B5F2XEyjoqqgXzAjHpYQ+fVTPT+YRTcTGKDi08EAgOAVDvKUrS81Lmq7zbE5Pu0wIxhUwCmGFX0f3vzpfSFSKXsQfAKz+dOxp0TAl+l6ypC7qcY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(346002)(39860400002)(376002)(136003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(33716001)(2906002)(478600001)(54906003)(7416002)(44832011)(7406005)(40460700003)(316002)(16576012)(8676002)(70206006)(41300700001)(70586007)(4326008)(110136005)(336012)(47076005)(86362001)(81166007)(36860700001)(8936002)(426003)(82740400003)(356005)(9686003)(5660300002)(103116003)(16526019)(186003)(26005)(40480700001)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 23:21:58.6415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb15e83a-b1c1-4c00-3f71-08db88aef318
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl uses RFTYPE flags for creating resctrl directory structure.=0A=
=0A=
Definitions and directory structures are not documented. Add=0A=
comments to improve the readability and help future additions.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |   48 ++++++++++++++++++++++++++++=
++++=0A=
 1 file changed, 48 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 2051179a3b91..783c3e36633c 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -240,6 +240,54 @@ struct rdtgroup {=0A=
 =0A=
 /*=0A=
  * Define the file type flags for base and info directories.=0A=
+ *=0A=
+ * RESCTRL filesystem has two main components=0A=
+ *	a. info=0A=
+ *	b. base=0A=
+ *=0A=
+ * /sys/fs/resctrl/=0A=
+ *	|=0A=
+ *	--> info (Top level directory named "info". Contains files that=0A=
+ *	|	  provide details on control and monitoring resources.)=0A=
+ *	|=0A=
+ *	--> base (Root directory associated with default resource group=0A=
+ *		  as well as directories created by user for MON and CTRL=0A=
+ *		  groups. Contains files to interact with MON and CTRL=0A=
+ *		  groups.)=0A=
+ *=0A=
+ *	info directory structure=0A=
+ *	------------------------------------------------------------------=0A=
+ *	--> RFTYPE_INFO=0A=
+ *	--> <info> directory=0A=
+ *		--> RFTYPE_TOP_INFO=0A=
+ *		    Files: last_cmd_status=0A=
+ *=0A=
+ *		--> RFTYPE_MON_INFO=0A=
+ *		--> <L3_MON> directory=0A=
+ *		    Files: max_threshold_occupancy, mon_features,=0A=
+ *		           num_rmids, mbm_total_bytes_config,=0A=
+ *		           mbm_locat_bytes_config=0A=
+ *=0A=
+ *		--> RFTYPE_CTRL_INFO=0A=
+ *			--> RFTYPE_RES_CACHE=0A=
+ *			--> <L2,L3> directory=0A=
+ *			    Files: bit_usage, cbm_mask, min_cbm_bits,=0A=
+ *			           num_closids, shareable_bits=0A=
+ *=0A=
+ *			--> RFTYPE_RES_MB=0A=
+ *			--> <MB,SMBA> directory=0A=
+ *			    Files: bandwidth_gran, delay_linear,=0A=
+ * 			           min_bandwidth, num_closids,=0A=
+ *			           thread_throttle_mode=0A=
+ *=0A=
+ *	base (root) directory structure=0A=
+ *	------------------------------------------------------------------=0A=
+ *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)=0A=
+ *	    Files: cpus, cpus_list, tasks=0A=
+ *=0A=
+ *	--> RFTYPE_CTRL_BASE (Files only for CTRL group)=0A=
+ *	    Files: mode, schemata, size=0A=
+ *=0A=
  */=0A=
 #define RFTYPE_INFO			BIT(0)=0A=
 #define RFTYPE_BASE			BIT(1)=0A=
=0A=

