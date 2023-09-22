Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7548E7AADE4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjIVJ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjIVJ2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:28:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB06197;
        Fri, 22 Sep 2023 02:28:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Og7FCtTDN4qn8rG9qOAzhATAIhS+HbH19dMr+E5+eEGIwpbB2oc5qZ1ryPfAN29bJao5HXKgjERQqe8wY4MlRfDw55OF6M1p5GMfBMgrX41X5XliOYJB68UmV8bkaJ7lp/D/4VGaU0zVqopKytm775MMmrHibXuwKou1Ab3QXK39klssMs7ife8rDA39DPT7dvIWhQdNduM17NItPLodH2DrTVeR16QVpgvYtpN1o23ORHDJpTyNNZAiUm9s6ewsF5yeIhOm5mwvBZndxxBCuRsgCOxvduTCpqVozPNF3sLyaalWHF63AmlWvJDBhdNr3ucQoMceolWfDTGnpBd00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HXVE6751pthjZl8sjFlGMm8tVlHrgSQ9/x3gpD5sOQ=;
 b=K5WWJVaD6A0dI9PTAoxJHRNypUqW2EYOvFo4coHbPSJVu/2R0gxkk+kHQYSlFuYWmTIvWL9VcMJi48lt8XdaiRTecUZCVdmTK0fW9M+/3mJkw+iS8yPsXhmCa4hwZZevL+Ycxx6hmbJ/NJOC9QfLRsP9GPrzJloNbEVXb1KIGFPXnxbh6FAtFVIjm5uJ2JNHTkdbQSe39T6hNYbfs49SHBg61iYefneSgrGHgx5G7bzuoMiU+wcmdegjZN1Wf2QqxXkljGlnSvdHT2BRu0/O1K5CjpxUvcH0LUdrAuW2T4KH8L7WUxL1lrzRusd8Cu9DXty04a8Z4d3rAItq6KA7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HXVE6751pthjZl8sjFlGMm8tVlHrgSQ9/x3gpD5sOQ=;
 b=G2iEq7llvevR8fDJf1VvpwAMTI+AiwxqqAkDKe/r3M1MC78pZ1AYpo4p3SWqcuROfYRkot9tgaCZt04r0vE9KDQE9eJ8a6q3pczbFEEzC+RmKedwB0DBOFB3wo7P4/6bPX0ljGbl7IMEK7lnQOyCzzBR4cgJla0qHrKPz4viSAs=
Received: from MN2PR04CA0014.namprd04.prod.outlook.com (2603:10b6:208:d4::27)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.28; Fri, 22 Sep 2023 09:28:39 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:d4:cafe::a9) by MN2PR04CA0014.outlook.office365.com
 (2603:10b6:208:d4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 09:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 09:28:38 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 04:28:36 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <lenb@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH] tools/power turbostat: Increase the limit for fd opened
Date:   Fri, 22 Sep 2023 09:28:23 +0000
Message-ID: <20230922092823.478042-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc895ab-dde7-454e-ad0e-08dbbb4e4da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdvDzuSF0D/q8i0ZFUfjMbx+S2WPmyCv2RrdLuhCmi3AcQP0e/CrTtn6IYkmURm/s6K4GeYGf6Ho3QpF4EX3eUI4aGBouutd5Rmff56xbsAe4S6/II7nMBVwLoGQuzdQHm97FMpd5aw/1JJdIKDRtJTpQCxnaAoAniX/U41h0HTbR22cP0gWdvP8CAvAKeVRiPsnqGmkvZJDLMoVD4N1Fwsue3TCXvH8dZJR+aO+WVSrswvgQhrZGvNWBDjh3mm+WD6RBUFS90mLweY+tdYNxNZZ476FdZUuzyPaq6xT0ykAcY0AwNmlcqMRqseMedRHX0baKdbOL7u1OlKR91Q+crihguygvIHBTVL/14CaUTO+DIMM0CnUGvGBLEVY8zT2nqo6doAPvqCsf91yq9NbhGHBwXuN452ubF27lGYs/PUm3eEIFLHFmTFaI3m4BrByBUvrEw0sa6DCKwB5SFlm+0/rPvZQrlnl51EYMgZw2DSLrBc57VbYyNIieUSC2eveqnFDBYy9dQtEj5S4szKKlL0S54LLRHdsEHKRgaZcQnWr0Jwq0JFZMSXPyRPsVm6W5ZC8kVO+7NuH4sKlbyXA8wi0lRJh8jgHPk1aUsNWQN0PfjJSiJjkF+5uJwS3L5OgWqMBk444inOSHN80WwU0erpLiHkoLdg+lr4Ks6XIOLLi+eF5hDG/PJAONbFCNCtmo6ZzXNZBu5lfaMQ52jCJH6vAx5Z330jI4mdYlCwPB8/9QFqTsUgFQbDtaGrHy36yvukEdRPFI/1ZWFolVBb6DbZWkYzeQL1Lr5qLIgrr/LHdsyet95eINYb2iLGJd5EW
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199024)(1800799009)(186009)(230921699003)(82310400011)(36840700001)(40470700004)(46966006)(6666004)(7696005)(426003)(40480700001)(40460700003)(36756003)(356005)(82740400003)(26005)(36860700001)(86362001)(40140700001)(2906002)(478600001)(83380400001)(47076005)(41300700001)(70206006)(6916009)(70586007)(16526019)(4326008)(8936002)(5660300002)(2616005)(1076003)(316002)(8676002)(54906003)(81166007)(44832011)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 09:28:38.7200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc895ab-dde7-454e-ad0e-08dbbb4e4da6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running turbostat, a system with 512 cpus reaches the limit for
maximum number of file descriptors that can be opened. To solve this
problem, the limit is raised to 2^15, which is a large enough number.

Below data is collected from AMD server systems while running turbostat:

|-----------+-------------------------------|
| # of cpus | # of opened fds for turbostat |
|-----------+-------------------------------|
| 128       | 260                           |
|-----------+-------------------------------|
| 192       | 388                           |
|-----------+-------------------------------|
| 512       | 1028                          |
|-----------+-------------------------------|

So, the new max limit would be sufficient up to 2^14 cpus.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 tools/power/x86/turbostat/turbostat.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9a10512e3407..23f1fe58289a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -6717,6 +6717,18 @@ void cmdline(int argc, char **argv)
 	}
 }
 
+void set_rlimit(void)
+{
+	struct rlimit limit;
+
+	limit.rlim_cur = 0x8000;
+	limit.rlim_max = 0x8000;
+
+	if (setrlimit(RLIMIT_NOFILE, &limit) < 0) {
+		err(1, "Failed to set rlimit");
+	}
+}
+
 int main(int argc, char **argv)
 {
 	outf = stderr;
@@ -6729,6 +6741,9 @@ int main(int argc, char **argv)
 
 	probe_sysfs();
 
+	if (!getuid())
+		set_rlimit();
+
 	turbostat_init();
 
 	msr_sum_record();
-- 
2.34.1

