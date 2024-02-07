Return-Path: <linux-kernel+bounces-57287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C66D84D628
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502C31C23AC7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D352535CA;
	Wed,  7 Feb 2024 22:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yfQ4RGiB"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A06535D2;
	Wed,  7 Feb 2024 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707346625; cv=fail; b=NI6NN7d04aU1RWa3zygJBd39Zq2GFXpErsnC7BEx+TcLPaUcPcGD2Bdvfe8YFl5Oeq99sEsQ17gF2rtRIbXR06fh1UMrP6b+1Jr4+BjuUb7l3ZurUO/I6wj902G0npgqoHPjjDqqyH1Zu+DR7ja4qjW5DoDc3RtClDGPmi5faHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707346625; c=relaxed/simple;
	bh=Y0I1AhQRVjXM/RIaecgawzrVGPZqUnbcrtQJ0b3hFiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1RNCIeXqGUOZ2hV1NgHS353fVDFAtvSSY0A7uCbrKXikRdcJyh8TquzLYje4PN/bl4ZBaSgMJB8wIKXr9fethXujNl9HkfdISHh4uA374K/Bj+xM6iAaFu1IHDincZvM1sg9leGuZocH3CW05jYkl69zkCuIQ0z+UBDUDpfbD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yfQ4RGiB; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIp7JDkf9G6eDV6zNnsfhf1seoq9BIe085GmgO2o3i7P2qx7nm1rohKAyyQIYajW0PngJfTGX6oTRvE2enQRd079FO74zaTOVjsrnJuH8YkMoXI+lMEbQkhbct5XYcYnDmP3/pHn62+Rk+0HEzEcTPD5ODarq7WDBm6tYecbmYkm6jriaLHgrAtxqPo3ivmHsQDNzsheA9r/dhzmadQ2wb8RQXysc26M4dUzizckWVVNUw881JH2sO/hI51QofZrOfrhY8Tc8OVNx+z1VOG2Z9QteNNwo/vKqcOJXso0UBzs104YzivVSpPjFXRsISx+tF7+dcjg9+cA0ot7EDKMvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQkoJWbdayBfEtsgw6k9ijmojUFSO2Ic22H5uELhThE=;
 b=bLfHZwtMB1Xv75fjxVy6nj6AMbUZraZZ6EGiqAc3x0m5E48gLcjSxlW+56Z4UdpA34iCnjQHColZ5fA3Oni4KQeWd9SyCvmYhPKCFHSxDlvNWIqBOrEdJm5s92Yp26QlkkdyNg6fkCUaPi66Mng4/HQ3aIfwF4xqe3dsCFE+L6hp06fA0Rmdj/AD98eLYVo98xIV+DSoq9r0TEzpd864/daGroxHyuOck/2N8HylOSb0lHlSZyhwJQDvfrFZEUKdZeduYuytD0bD+qotqEzkKdZfHLo8FvsfxK4aesOtKv9bEhoEAiQF3QHMz+exdjdaryrs9FQM/4VZMsnZ3Us8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQkoJWbdayBfEtsgw6k9ijmojUFSO2Ic22H5uELhThE=;
 b=yfQ4RGiBV4xssO9vUazYZKNGUslGTahgoS0rRHCYduxqE9VWVaoS6C9rkGABC9xEJasDtrloxrk7jYQtC/xIRnnj8MaR4W+BleBN4oVHMGj2DxBkDppRnY9hYvnZb8dWBnGLXlDLQXTBjWWFe6O837RZi6VHJOoTc93rEd5XhRk=
Received: from BN9PR03CA0380.namprd03.prod.outlook.com (2603:10b6:408:f7::25)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 22:57:01 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:f7:cafe::39) by BN9PR03CA0380.outlook.office365.com
 (2603:10b6:408:f7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 22:57:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 22:57:00 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 7 Feb 2024 16:57:00 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH 2/2] x86/MCE: Add command line option to extend MCE Records pool
Date: Wed, 7 Feb 2024 16:56:32 -0600
Message-ID: <20240207225632.159276-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207225632.159276-1-avadhut.naik@amd.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: cb51bfc5-e3dd-43fd-8e61-08dc2830182b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YM8wpl+RRX7fe2lWq+Z6sNvx7IMa25DyTl8KyUi5/0MNi5hPlfKrVSrzcmGOxfyoQxD+ahclWlIJxoGiOZMgbRXht1ieSQKFaI+q1yQlRjb/C51T5dtqSBrEeAz54e/JFS7XfCtP62+G+SmDtcmQNU382G5mXt5GwysNzJodjITU7KOxwJteTjbpYex9yH6k6c0dBaE2P7cVX3sirTyEXpjGx+QCWiKaAcljh+/aPr2slvlHrMB/Yi83zv0ikK7i65XId0o4GhdWuDHbcrfrrXwbxariCARl3r3TW4v/+l0weVDTVkx+2HdN1MRZPctMxTfKd871r9kwxpGZWPZkH80PJ99DhQ6c7B75+DhwozCxceFF4e2s0VeWtmGU53OgT6vWcNHwxob4V27WN7qM67z6HaBfEyOOQnU27lh9T+l+osXgY/UY9MvZzLwcX8rPIboOhkYDKMViAHxhzrx0/16Ch0pOq6va8MFh1ZyOQN7QbsUx1NeiDdnWGz+Da/Y7mous7cpcOryjEMJ2kVi4VnDvAWbhYNeAnaqcejeHH92Zikws7LJisX6AyTW9jYyjgkspeciYVu7oj7A1wfy9cV3IF6mg7qg9i0Wk7VXVZ8s=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(82740400003)(41300700001)(44832011)(5660300002)(4326008)(316002)(8936002)(36756003)(70206006)(70586007)(6666004)(110136005)(54906003)(7696005)(2906002)(8676002)(81166007)(356005)(2616005)(478600001)(86362001)(336012)(426003)(16526019)(1076003)(26005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 22:57:00.8035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb51bfc5-e3dd-43fd-8e61-08dc2830182b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748

Extension of MCE Records pool, based on system's CPU count, was undertaken
through the previous patch (x86/MCE: Extend size of the MCE Records pool).

Add a new command line parameter "mce-genpool-extend" to set the size of
MCE Records pool to a predetermined number of pages instead of system's
CPU count.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  2 ++
 arch/x86/kernel/cpu/mce/genpool.c             | 22 ++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3a1fa1f81d9d..62e7da4d9fda 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3135,6 +3135,8 @@
 
 	mce=option	[X86-64] See Documentation/arch/x86/x86_64/boot-options.rst
 
+	mce-genpool-extend=	[X86-64] Number of pages to add to MCE Records pool.
+
 	md=		[HW] RAID subsystems devices and level
 			See Documentation/admin-guide/md.rst.
 
diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
index aed01612d342..d6e04fa5ee07 100644
--- a/arch/x86/kernel/cpu/mce/genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -22,6 +22,7 @@
 #define MCE_POOLSZ	(2 * PAGE_SIZE)
 #define CPU_GEN_MEMSZ	256
 
+static unsigned int mce_genpool_extend;
 static struct gen_pool *mce_evt_pool;
 static LLIST_HEAD(mce_event_llist);
 static char gen_pool_buf[MCE_POOLSZ];
@@ -123,10 +124,14 @@ int mce_gen_pool_extend(void)
 	int ret = -ENOMEM;
 	u32 num_threads;
 
-	num_threads = num_present_cpus();
-	len = PAGE_ALIGN(num_threads * CPU_GEN_MEMSZ);
-	addr = (unsigned long)kzalloc(len, GFP_KERNEL);
+	if (mce_genpool_extend) {
+		len = mce_genpool_extend * PAGE_SIZE;
+	} else {
+		num_threads = num_present_cpus();
+		len = PAGE_ALIGN(num_threads * CPU_GEN_MEMSZ);
+	}
 
+	addr = (unsigned long)kzalloc(len, GFP_KERNEL);
 	if (!addr)
 		goto out;
 
@@ -159,6 +164,17 @@ static int mce_gen_pool_create(void)
 	return ret;
 }
 
+static int __init parse_mce_genpool_extend(char *str)
+{
+	if (*str == '=')
+		str++;
+
+	get_option(&str, &mce_genpool_extend);
+	return 1;
+}
+
+__setup("mce-genpool-extend", parse_mce_genpool_extend);
+
 int mce_gen_pool_init(void)
 {
 	/* Just init mce_gen_pool once. */
-- 
2.34.1


