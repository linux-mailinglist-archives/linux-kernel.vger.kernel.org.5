Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C07175A2C5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjGSXXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjGSXXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:23:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288742708;
        Wed, 19 Jul 2023 16:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaIXTEyDdlNvyFRL8GJQuAeihiQ6SgjN418fgkdCgN8ABD+nJuQ1e5LD0KEEERlUdMIA1tLZRf3eoWrybrsozlVvOVbls/11/XgWxiSbypMewk1M7AY6xxeSxbehdp+y1kSnruj9TFsRIWwBROAnZnyFjlbECu7C9QW0Ui46y7HwSzgKsHF12CHDEduY7040p+yQWb8F/jwlB5l5lmkDF3ztdn9gqOUTkii3ChZ8lklvz9RFB7cTQyjJJw7UKTs2IGoIXRN5aDmr2VkYIWruQ7ugNeNFI6OhgnmBa6h0U1gZsmo9OozBufoLuZnq2IYBf89FN17hDLXe5HCauHgI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6dT+F33syFlQ2/KFTWohshO77y0qLiFpqKxl8jvpp4=;
 b=V3dhp1bwuk/mKFH53mBqytNp96jwco/mXHCVe8W/erXm6k5+EpPSMJDlAhnCMUDFOVGIVGh4chex8Qt/T/lGMXctKdsk1wcR2btI31uLWwwFn1eKfCi/Dg9G6tTeTjjvnR2+//vDo1n5Ofm4NUO2fMBTtGF7kQB0Pi20gvhbO+rnF8B7Z/gmG5PJtOSqh4HY8LxKRPnU5D5aMQhashkR48gaBc7RxWm5H8rPxl1KKDdgg8OAEYkmsSw3tXyBVbQkshwU9UeYQnNnxFmUrnMqH5+gkBlwMHFyS5/aL0pHEy3FCNkEZd8KvXFIGmDQlimX52Ge2YSme3Cnn83i+95HhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6dT+F33syFlQ2/KFTWohshO77y0qLiFpqKxl8jvpp4=;
 b=fbELrNnkNdLBnY4Rjf4kx2Ke1gAqewrKcVNmIHDl3OFJSZenFn0LR0zIKBkjvXQ1svSMMhZmJGpQk1azIBZR7L6eN9rkIhRshIY8cm+wyptabl3v33tr5zaC1Oi80P9WDpVJ9AxQfCDIdQ+JZMjucFfAbQzSSZicL452wFYOblE=
Received: from DM6PR06CA0053.namprd06.prod.outlook.com (2603:10b6:5:54::30) by
 MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.23; Wed, 19 Jul 2023 23:22:29 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::25) by DM6PR06CA0053.outlook.office365.com
 (2603:10b6:5:54::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 23:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.25 via Frontend Transport; Wed, 19 Jul 2023 23:22:28 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 18:22:26 -0500
Subject: [PATCH v6 7/8] x86/resctrl: Introduce "-o debug" mount option
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
Date:   Wed, 19 Jul 2023 18:22:19 -0500
Message-ID: <168980893967.1619861.7249871216790436466.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d9abe14-372a-42c1-e62a-08db88af04dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mmDWzIM/sgigR++mULfOJfVO4MOiRW6O4pgzpsu/lDv8uXs89B1DhnC50B4y1U8nkSo0Wn9qTzOr+jG9GrvOkum/vRK1ZyNhgXBU48Jyw2qvCaQUJv+VdG/T12KCEbbzPk9sLavQum2FgsqPK4fsAiHv9bGvZBW1VCF9kYCLQF47H3nrPNE0WaVXxHCV1jcleI5ArlIRuHY3Z8cFdTpNPj1rh4XsBqkxtr5i6SOru5aWPSOvpMTf1ardRRqyHUPulawCSKvL09HaypY+uTMdGXVMiQbD78ZRJODaqJBhMyW2ovfUpqVlGJ9OuNCXInQRxlhZSEl3oqDiOQij3CtuuKw+fFVDBNhaXBiJ0qsshw28p3WpsGCgVlzOAuPY/YDviBD/IIc0LqYZmTITerUPFI39sHJmhqVnmrertzsx0/Lr5ErW6NXvGqO6/Al7mVUQwMuWCS9UPgCA+WaCprNslFD3hGloOom71RqNkkMqm6JEgIEiwhy4NfWKCe04XlprLkAfiH8wFg0jNUIZx6k6B/v5fiL6949PKsfiGOJxM63hGA9TAu2iLaaapIi2dVLd8VRymj5GItnzycZtlGAnvTaMsH9qVMSI4uUF58d7EyqzBzmbjIczxoofRuQc7pc+pJcN5fpbYbNtPHj1/kO6LuyDlOmaWx8Hki50Qt3cA15azfsLitCudrTIG1kSdzze7QURp08SsgvwqZ7l7VmdnhnkocpRSLYrYgL/zSgoZTZi5V/26Mi5a1qGDsW3SKstd9AJ7bNqmScNIyBMWEgEGW7GrHjyKiphH73wrwkQLFA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(376002)(396003)(39860400002)(136003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(186003)(336012)(16526019)(103116003)(86362001)(40460700003)(40480700001)(81166007)(82740400003)(356005)(2906002)(47076005)(9686003)(110136005)(26005)(44832011)(7416002)(7406005)(426003)(36860700001)(478600001)(33716001)(54906003)(4326008)(8936002)(8676002)(83380400001)(16576012)(316002)(70206006)(41300700001)(70586007)(5660300002)(6666004)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 23:22:28.4516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9abe14-372a-42c1-e62a-08db88af04dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "-o debug" option to mount resctrl filesystem in debug mode. This=0A=
option is used for adding extra files to help resctrl debugging.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/arch/x86/resctrl.rst     |    5 ++++-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    2 ++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   20 ++++++++++++++++++++=0A=
 3 files changed, 26 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/re=
sctrl.rst=0A=
index af234681756e..5a2346d2c561 100644=0A=
--- a/Documentation/arch/x86/resctrl.rst=0A=
+++ b/Documentation/arch/x86/resctrl.rst=0A=
@@ -35,7 +35,7 @@ about the feature from resctrl's info directory.=0A=
 =0A=
 To use the feature mount the file system::=0A=
 =0A=
- # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps]] /sys/fs/resctrl=0A=
+ # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps][,debug]] /sys/fs/re=
sctrl=0A=
 =0A=
 mount options are:=0A=
 =0A=
@@ -46,6 +46,9 @@ mount options are:=0A=
 "mba_MBps":=0A=
 	Enable the MBA Software Controller(mba_sc) to specify MBA=0A=
 	bandwidth in MBps=0A=
+"debug":=0A=
+	Make debug files accessible. Available debug files are annotated with=0A=
+	"Available only with debug option".=0A=
 =0A=
 L2 and L3 CDP are controlled separately.=0A=
 =0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 885b656d1088..5bc18accb887 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -59,6 +59,7 @@ struct rdt_fs_context {=0A=
 	bool				enable_cdpl2;=0A=
 	bool				enable_cdpl3;=0A=
 	bool				enable_mba_mbps;=0A=
+	bool				enable_debug;=0A=
 };=0A=
 =0A=
 static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)=
=0A=
@@ -296,6 +297,7 @@ struct rdtgroup {=0A=
 #define RFTYPE_TOP			BIT(6)=0A=
 #define RFTYPE_RES_CACHE		BIT(8)=0A=
 #define RFTYPE_RES_MB			BIT(9)=0A=
+#define RFTYPE_DEBUG			BIT(10)=0A=
 #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)=0A=
 #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)=0A=
 #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index e0570bce76a2..058c1dedb2d7 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -56,6 +56,8 @@ static char last_cmd_status_buf[512];=0A=
 =0A=
 struct dentry *debugfs_resctrl;=0A=
 =0A=
+static bool resctrl_debug;=0A=
+=0A=
 void rdt_last_cmd_clear(void)=0A=
 {=0A=
 	lockdep_assert_held(&rdtgroup_mutex);=0A=
@@ -1871,6 +1873,9 @@ static int rdtgroup_add_files(struct kernfs_node *kn,=
 unsigned long fflags)=0A=
 =0A=
 	lockdep_assert_held(&rdtgroup_mutex);=0A=
 =0A=
+	if (resctrl_debug)=0A=
+		fflags |=3D RFTYPE_DEBUG;=0A=
+=0A=
 	for (rft =3D rfts; rft < rfts + len; rft++) {=0A=
 		if (rft->fflags && ((fflags & rft->fflags) =3D=3D rft->fflags)) {=0A=
 			ret =3D rdtgroup_add_file(kn, rft);=0A=
@@ -2399,6 +2404,9 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)=
=0A=
 			goto out_cdpl3;=0A=
 	}=0A=
 =0A=
+	if (ctx->enable_debug)=0A=
+		resctrl_debug =3D true;=0A=
+=0A=
 	return 0;=0A=
 =0A=
 out_cdpl3:=0A=
@@ -2591,6 +2599,8 @@ static int rdt_get_tree(struct fs_context *fc)=0A=
 out_schemata_free:=0A=
 	schemata_list_destroy();=0A=
 out_ctx:=0A=
+	if (ctx->enable_debug)=0A=
+		resctrl_debug =3D false;=0A=
 	if (ctx->enable_mba_mbps)=0A=
 		set_mba_sc(false);=0A=
 	cdp_disable_all();=0A=
@@ -2608,6 +2618,7 @@ enum rdt_param {=0A=
 	Opt_cdp,=0A=
 	Opt_cdpl2,=0A=
 	Opt_mba_mbps,=0A=
+	Opt_debug,=0A=
 	nr__rdt_params=0A=
 };=0A=
 =0A=
@@ -2615,6 +2626,7 @@ static const struct fs_parameter_spec rdt_fs_paramete=
rs[] =3D {=0A=
 	fsparam_flag("cdp",		Opt_cdp),=0A=
 	fsparam_flag("cdpl2",		Opt_cdpl2),=0A=
 	fsparam_flag("mba_MBps",	Opt_mba_mbps),=0A=
+	fsparam_flag("debug",		Opt_debug),=0A=
 	{}=0A=
 };=0A=
 =0A=
@@ -2640,6 +2652,9 @@ static int rdt_parse_param(struct fs_context *fc, str=
uct fs_parameter *param)=0A=
 			return -EINVAL;=0A=
 		ctx->enable_mba_mbps =3D true;=0A=
 		return 0;=0A=
+	case Opt_debug:=0A=
+		ctx->enable_debug =3D true;=0A=
+		return 0;=0A=
 	}=0A=
 =0A=
 	return -EINVAL;=0A=
@@ -2829,6 +2844,8 @@ static void rdt_kill_sb(struct super_block *sb)=0A=
 =0A=
 	set_mba_sc(false);=0A=
 =0A=
+	resctrl_debug =3D false;=0A=
+=0A=
 	/*Put everything back to default values. */=0A=
 	for_each_alloc_capable_rdt_resource(r)=0A=
 		reset_all_ctrls(r);=0A=
@@ -3710,6 +3727,9 @@ static int rdtgroup_show_options(struct seq_file *seq=
, struct kernfs_root *kf)=0A=
 	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))=0A=
 		seq_puts(seq, ",mba_MBps");=0A=
 =0A=
+	if (resctrl_debug)=0A=
+		seq_puts(seq, ",debug");=0A=
+=0A=
 	return 0;=0A=
 }=0A=
 =0A=
=0A=

