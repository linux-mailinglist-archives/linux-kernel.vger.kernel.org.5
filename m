Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE00375A2C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjGSXX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjGSXX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:23:27 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C955172D;
        Wed, 19 Jul 2023 16:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mr3PsYlPJPT40QGh1Q5+tWdo3tJZ6wTcxQFIgQzjQVHRd3+Pa/JdUkTidfAKFwnehm7JaeIbAM24xZJgmi8RwCZLZg1JsrJsv4EtOIT1MnQK/U3NiA8y+Y7pocuEZdvENgty3OpKQOJajFVwc+WCwcUez/XheXaUlvQbLzE6Hv7kN91p3YDkQTTFg+5KWwDVZcLJNBwq79IKh1xp6gZuF9e+8+bMBtJcYyu6z6Iy8m2nKTcxbZYGAPRaOPgCM7RjK74CmXorshn8HgldN5B2qbevnNtR0vZITeEBEQZA9JY9RFWo90iI/0pErAYRHyme8gCYA3TVTiAdcih/e1Vm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gu5Gez9IRORAZnbCM+m/XoNo0yjYDKKAX9wsPEbpSUk=;
 b=d/UIwHGLS0GZ3wgt+DHJmpEE8A+yX8gG8KfKyybU5pKLfXOieHRN/P812+q8CAVKAlOfRp7wn7hgDm49InrioAQtL1No6J93Hwc2e2RqSkTgw1ayHputnFu8zXsqO3YcdT2DNUxxRfqvldDrQ3dDE9eDm6++DwypkNE/iN8RrQpGXd6MigiwTLAGQqPZLyaL1RnmB3VDDcKIas/zdO+soofX/jy3pzQchazuXGXSMs+ES1vmdb8VugOym8+p0jDByO3s/mRNFOQpRBdsjx3CvfdiMoyT12H60vtaGTmQ5LiHLv8PXS1QefL6CvHsj2onDnZEh5WdX+y96AFghitSUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gu5Gez9IRORAZnbCM+m/XoNo0yjYDKKAX9wsPEbpSUk=;
 b=uuDtBnO53EgLY0lAUFuNHQf6EETNGxPCxDxs7UZF//1d7YNmHbtSuULt14hQTecRsJQVMa9KR+CPJmtSMSKwRUGAKsmlMJa1HqikQ+CCOa2Pl9UVscpUNFkMFvYbp8Q9x1m4hcZWftxIbc3RyOjbMtwQYv9A31KuYqAtY+QDZh0=
Received: from BY3PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:39a::30)
 by BL1PR12MB5826.namprd12.prod.outlook.com (2603:10b6:208:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 23:22:42 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39a:cafe::2) by BY3PR03CA0025.outlook.office365.com
 (2603:10b6:a03:39a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Wed, 19 Jul 2023 23:22:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 23:22:41 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 18:22:39 -0500
Subject: [PATCH v6 8/8] x86/resctrl: Display hardware ids of resource groups
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
Date:   Wed, 19 Jul 2023 18:22:33 -0500
Message-ID: <168980895303.1619861.15190945847281698454.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|BL1PR12MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 7861284d-c289-4c43-babc-08db88af0cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXlzLOBc4zRU6lr/SNxddMN4wqJPvLEFBcP5nYtOLqc8K3dS5WbmWFIHHwFAtAxdVKtoMC4FG0XNPIwXSiWb5dmWYwph6RduWJlvRTcjXtUw+I1Usm3QKng/7hcjrcHkyfXV2ZYgc29OSstcUKxqQ0m4llVD2pvIGxW8NKPnaarvJcKry3/g6W113YEJT0OoHiObU/FmrmCxkbXVot30yjx/inlxtgxW5TZSGZtSDtOzw1B6FHY2RaTJZ4bM59tkTrnwoUgsLEpC56EdGo6kloU41u+K9Pmm9ok9AOP8OGvavYTKOgEIgS+A6ZXR8iUvxcBLiG4CnBkBYoMypUAlkvWdBvh0rcfthR6fVLVDysiPSSJfm3+KwmOMlzLsNjYISK33a0FsMcp6shzwmMp3K6BiXCjubXWZxt85n8M58QqaaZRodca6XHW0as9HTqzLCN9aHmpSn9/qgq/aq1znaTqRG+Exrvei3pkJ0gktiMG82BCwfcTzyHVRfGmdrGUtRvicQJJouOQyQGBMW9gz9e8RVyFPglREXVOiLO2/NILBCam4q7FpkagQtMBbwkM38DIb2vUFsNq2D/0iIhDNxVCH5nq5Lk6HG8DBDf9Izs6VbnUajzj9og/9nOTlyTJvkMqBSYeZ1UL5VFfh6jXM/AAeDOMV4IeumbutLzdPsCfdYYb4qBdMtC2oxtLTZy9b53S1vuu3yfnfdv08ydjm6CoJXx4LY4LxdiIUTjSCQhVb5yooQigJo9FE+7+B3R7E+1q7ikG+dnMDhVHBmfATLjygMiJilab8eeE51ox/xuE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(136003)(346002)(39860400002)(396003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(8676002)(40460700003)(8936002)(47076005)(83380400001)(2906002)(103116003)(82740400003)(426003)(81166007)(33716001)(356005)(86362001)(7416002)(7406005)(40480700001)(5660300002)(26005)(44832011)(16526019)(336012)(70586007)(6666004)(186003)(316002)(16576012)(70206006)(4326008)(478600001)(41300700001)(9686003)(110136005)(54906003)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 23:22:41.8919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7861284d-c289-4c43-babc-08db88af0cdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5826
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In x86, hardware uses CLOSID and an RMID to identify a control group and=0A=
a monitoring group respectively. When a user creates a control or monitor=
=0A=
group these details are not visible to the user. These details can help=0A=
debugging.=0A=
=0A=
Add CLOSID(ctrl_hw_id) and RMID(mon_hw_id) to the control/monitor groups=0A=
display in resctrl interface. Users can see these details when resctrl=0A=
is mounted with "-o debug" option.=0A=
=0A=
Other architectures do not use "CLOSID" and "RMID". Use the names=0A=
ctrl_hw_id and mon_hw_id to refer "CLOSID" and "RMID" respectively in an=0A=
effort to keep the naming generic.=0A=
=0A=
For example:=0A=
 $cat /sys/fs/resctrl/ctrl_grp1/ctrl_hw_id=0A=
 1=0A=
 $cat /sys/fs/resctrl/mon_groups/mon_grp1/mon_hw_id=0A=
 3=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/arch/x86/resctrl.rst     |    8 ++++++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   46 ++++++++++++++++++++++++++++=
++++=0A=
 2 files changed, 54 insertions(+)=0A=
=0A=
diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/re=
sctrl.rst=0A=
index 5a2346d2c561..41ad9b1f0c6a 100644=0A=
--- a/Documentation/arch/x86/resctrl.rst=0A=
+++ b/Documentation/arch/x86/resctrl.rst=0A=
@@ -351,6 +351,10 @@ When control is enabled all CTRL_MON groups will also =
contain:=0A=
 	file. On successful pseudo-locked region creation the mode will=0A=
 	automatically change to "pseudo-locked".=0A=
 =0A=
+"ctrl_hw_id":=0A=
+	Available only with debug option. The identifier used by hardware=0A=
+	for the control group. On x86 this is the CLOSID.=0A=
+=0A=
 When monitoring is enabled all MON groups will also contain:=0A=
 =0A=
 "mon_data":=0A=
@@ -364,6 +368,10 @@ When monitoring is enabled all MON groups will also co=
ntain:=0A=
 	the sum for all tasks in the CTRL_MON group and all tasks in=0A=
 	MON groups. Please see example section for more details on usage.=0A=
 =0A=
+"mon_hw_id":=0A=
+	Available only with debug option. The identifier used by hardware=0A=
+	for the monitor group. On x86 this is the RMID.=0A=
+=0A=
 Resource allocation rules=0A=
 -------------------------=0A=
 =0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 058c1dedb2d7..e8b35013d7c1 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -776,6 +776,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file=
 *of,=0A=
 	return ret;=0A=
 }=0A=
 =0A=
+static int rdtgroup_closid_show(struct kernfs_open_file *of,=0A=
+				struct seq_file *s, void *v)=0A=
+{=0A=
+	struct rdtgroup *rdtgrp;=0A=
+	int ret =3D 0;=0A=
+=0A=
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);=0A=
+	if (rdtgrp)=0A=
+		seq_printf(s, "%u\n", rdtgrp->closid);=0A=
+	else=0A=
+		ret =3D -ENOENT;=0A=
+	rdtgroup_kn_unlock(of->kn);=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+static int rdtgroup_rmid_show(struct kernfs_open_file *of,=0A=
+			      struct seq_file *s, void *v)=0A=
+{=0A=
+	struct rdtgroup *rdtgrp;=0A=
+	int ret =3D 0;=0A=
+=0A=
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);=0A=
+	if (rdtgrp)=0A=
+		seq_printf(s, "%u\n", rdtgrp->mon.rmid);=0A=
+	else=0A=
+		ret =3D -ENOENT;=0A=
+	rdtgroup_kn_unlock(of->kn);=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+=0A=
 #ifdef CONFIG_PROC_CPU_RESCTRL=0A=
 =0A=
 /*=0A=
@@ -1837,6 +1869,13 @@ static struct rftype res_common_files[] =3D {=0A=
 		.seq_show	=3D rdtgroup_tasks_show,=0A=
 		.fflags		=3D RFTYPE_BASE,=0A=
 	},=0A=
+	{=0A=
+		.name		=3D "mon_hw_id",=0A=
+		.mode		=3D 0444,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D rdtgroup_rmid_show,=0A=
+		.fflags		=3D RFTYPE_BASE | RFTYPE_DEBUG,=0A=
+	},=0A=
 	{=0A=
 		.name		=3D "schemata",=0A=
 		.mode		=3D 0644,=0A=
@@ -1860,6 +1899,13 @@ static struct rftype res_common_files[] =3D {=0A=
 		.seq_show	=3D rdtgroup_size_show,=0A=
 		.fflags		=3D RFTYPE_CTRL_BASE,=0A=
 	},=0A=
+	{=0A=
+		.name		=3D "ctrl_hw_id",=0A=
+		.mode		=3D 0444,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D rdtgroup_closid_show,=0A=
+		.fflags		=3D RFTYPE_CTRL_BASE | RFTYPE_DEBUG,=0A=
+	},=0A=
 =0A=
 };=0A=
 =0A=
=0A=

