Return-Path: <linux-kernel+bounces-154643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF268ADF0E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31DF1C22AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C1D5491E;
	Tue, 23 Apr 2024 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nqE9nwLU"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FA2548E0;
	Tue, 23 Apr 2024 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859133; cv=fail; b=BpYrJmOxjJ8vha7kAgdgCNjjeEE1RXy+hpwbq3UIezp10L8RGIbE++Jpma7XWWq4+IERUmQLsUibeKQhgD3IuO0RGBvSTlN+gJLHtBiLpw7bwaQ2LcEM0sJfYGw8GM0rQn73lZVx1QuhWc/L1aPqfJvyIZ4v7dfJOZTk40OEFdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859133; c=relaxed/simple;
	bh=XND/4DrRvnxXSuCo9VLOeYfmAdUCI9xOj/tgHRyLNFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=doJQHXmDg63cvo0KMJT8vWOgl5MDubBfzz4YpFFWBjfHEBrDWvkhvOuhxP2WEN16O7AGfnwdqlZRauueyq9RsZLMuumVBjuEqPo6zQfNM8Ut80wfI97WToKcTlYY80Vs7nMhrL2phjJoAnNAaxLOah6nrztdiLs5YJxwkdkrKvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nqE9nwLU; arc=fail smtp.client-ip=40.107.96.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyYjJiyROw6LFCowhidW6MSmcLWB83s9EgbWJBaUJ7hFk+MjzjVDmjNeMrmOZ8jTReYGjkB6cgPcrG05HUFKiX2mlqBwZsgFz9XJlvln6hYxtO7aCKej0tRPYIqcEO3IRqXqRFCW2Q1yK6GijnYhNWscneWKmQ67k4bU0F+vLIES60NR75rnJ0l9xqzZqYBjENPo8wv1PwfwhLQ/poi8hIR0pswSd0Exklc2BFjyf+9Xk4F9k1CHKYgCAD6oZpk+jD106z2Bme3Ec3EO1MDOevDwZV3XdpGoy1W9w3hAQ9QTuPB27S+Sq74w841uoCZLPjqEZurQJY47nPLxi/xnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rACBeBy1UTX6WaxVN1vDPYnPhWdoyKM4IaNY38r6jZg=;
 b=UFdqYgbGx4LNkgMzT67BHXlyTS5/oJXrcttNktw0D24OjS+OHIriuwO/KW+uNgVXJe1bSJfWx11kNDuwhL+ToT3P9rIVfPObFoYZbZBcHYxorxO2wN4zXLKtmoO1xR2ltyFET2HeFRQbzqagy4p16OoFGU+xLRtOL389YbV8Ptjyt9ULHNyU8EAMg1wOMSfoIcyPe7XlfzjyzbURtzwY6f5atJr0VI0eyqDgtzEefvYJlbhRZy/14t16MBrpwUouUcEuaic4IQod/beJ9uyzcltPmXT/lk8ZVxE3GU9LgKAnv7w1WtGUlSrWK5bxcAFQ1SURKJpq43EHwA4NqS/EKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rACBeBy1UTX6WaxVN1vDPYnPhWdoyKM4IaNY38r6jZg=;
 b=nqE9nwLUCKuDvb7Z0079nz9jvl8nkhPC/mQowEftodLtj1Ug9OIff14Tuipks5dycEKKOxevbIAl1z7qShUFgqoGTEJZqnRqI6xs/h4q6zvGARn1FoPKo6oElNev90mXAOAtSIwstiG6deZaPPfgLNi/vQUG+vGHbkoeW2YAd28=
Received: from CH2PR03CA0004.namprd03.prod.outlook.com (2603:10b6:610:59::14)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 07:58:49 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::d) by CH2PR03CA0004.outlook.office365.com
 (2603:10b6:610:59::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 07:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 07:58:48 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 02:58:45 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 2/8] cpufreq: amd-pstate: Document the units for freq variables in amd_cpudata
Date: Tue, 23 Apr 2024 15:58:18 +0800
Message-ID: <72cbda63659fbe05878320c70f09e4a2b4d1b27a.1713858800.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713858800.git.perry.yuan@amd.com>
References: <cover.1713858800.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ae4301-4f99-4eac-2a1f-08dc636b356c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0+/v1FKMh6wZMovf6R8LkJTaEdXFLfuAJ2Y5fKzG3RYDY2qLy8LpU2qAtyAr?=
 =?us-ascii?Q?V+UuLifYHFiwav+mhtjbevE5i1S2iY6kEq7YSmwamPWHTiQYrVDoYXOrQ+bO?=
 =?us-ascii?Q?gBiUnlOBNxUIX8fewGmBuITllsiZY2q87Rj6b3DLHpz/+6+toCxzFmR0QS7J?=
 =?us-ascii?Q?wO5dmxgJGAiy2CVNUmSTEgnuC03cWF7R1tChRYay3IWYzR6LtogJ6TZhK/yA?=
 =?us-ascii?Q?gSsxygi647Ii5uTVubH74jD1k8RnS7aH7vm8jp0PA/vv0kCFRsPqzsBBRqDh?=
 =?us-ascii?Q?1Lw/6UGrcY5bUf7CVA5fi3UDI/Bj8v2FtRydBiPgUWoMBv8f+5zIplW5WgMf?=
 =?us-ascii?Q?WsobnMKEPhCshlUB74nHSmMqH0DHNwzuB5Qwv//hHJPnTg0d7+2wmj3QAFix?=
 =?us-ascii?Q?VMBtrtW6NbjDhCZLaFSy9y0EkVzEC5zbHH6xKJU9OYDyxuqcfo1SXcsfFE16?=
 =?us-ascii?Q?l0BQcp0hH3jFsArOwy8D3dOOmq6z9mUhobfLdgdTJcSiYjUvZF/cRr7lQLuh?=
 =?us-ascii?Q?zyuVaXLdN+1VeST1i5ISiovzJS3eE/7ExZM0mCgBiWvptaw6U/LDrI9OqB2L?=
 =?us-ascii?Q?HC1+08noLChrTWfz0PNsmEYXt2LX0oJ7IUECt3r9pNBmsEy+TxOEhybcdLjo?=
 =?us-ascii?Q?MCoCKwcRabTQTIWpVO4bSv6ynsG5AQWmFxtyzY+pHjORQ00JmHW2n0RrIAEr?=
 =?us-ascii?Q?IlNprI6KlD+MDCI8RA+mul7bbN7seYjYASBY1mogNT5lkApK3QPKrEqBcNdy?=
 =?us-ascii?Q?ibUSY9rl4mhtpk0zXIEzqU8HA5CMmrXv2TWKnEtMeXY2/a3HYNtB57tc6h9a?=
 =?us-ascii?Q?iyqer8JuJDikZpcTvetnh/99xAIrkH+4VBd44zYCqCOLun+cwQVlTTLyGrBW?=
 =?us-ascii?Q?a0JTfGo7mejeDuXvAaJkwl9SVd1f5aG1k3S7G0nr8f4m081jv7sl1KAEHqMM?=
 =?us-ascii?Q?+oEfX7jupIXKkWl45WsexAdG10dN3mIgAdM3hCBBCPUKtX52/Fx+bdSs5+ZA?=
 =?us-ascii?Q?MNrPzHrcuaNIoNdRqtOl3PdCc8PUrJk391lC/fd7xYhFOzlVmZ2mMfwMZTyp?=
 =?us-ascii?Q?ct9HTNfyFflh2oRrHjvqSon4T4D6pOixl7V4SsK64ApAB0WOeAWBavzI8gon?=
 =?us-ascii?Q?ZLKqvecPT4qchgP5AliHI8zzX17qFtu10JJuBfHerZFyAhG/UEhNalnAvivv?=
 =?us-ascii?Q?M50J97zVzn/xQ1jlPf1RZpzIPbf+R6W5A1ngrZxA49TfO73dALrg/EkzkJ0T?=
 =?us-ascii?Q?pYof3kjksgY11426oqN0yoBaNz/xgLkeGvnx44MbDibjnTUWxKJtk+OVs7jM?=
 =?us-ascii?Q?NMmDZcqjR1lIn+c7vUj75a+qgIxIZxJNBAv98JZVI4qa6f9TFnOg2myL62G9?=
 =?us-ascii?Q?Kqby4z3llVB22a6cYk0+VtIY0nQ5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 07:58:48.8074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ae4301-4f99-4eac-2a1f-08dc636b356c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

The min_limit_freq, max_limit_freq, min_freq, max_freq, nominal_freq
and the lowest_nominal_freq members of struct cpudata store the
frequency value in khz to be consistent with the cpufreq
core. Update the comment to document this.

Reviewed-by: Li Meng <li.meng@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 include/linux/amd-pstate.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 212f377d615b..ab7e82533718 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -51,15 +51,15 @@ struct amd_aperf_mperf {
  * 		  priority.
  * @min_limit_perf: Cached value of the perf corresponding to policy->min
  * @max_limit_perf: Cached value of the perf corresponding to policy->max
- * @min_limit_freq: Cached value of policy->min
- * @max_limit_freq: Cached value of policy->max
- * @max_freq: the frequency that mapped to highest_perf
- * @min_freq: the frequency that mapped to lowest_perf
- * @nominal_freq: the frequency that mapped to nominal_perf
- * @lowest_nonlinear_freq: the frequency that mapped to lowest_nonlinear_perf
+ * @min_limit_freq: Cached value of policy->min (in khz)
+ * @max_limit_freq: Cached value of policy->max (in khz)
+ * @max_freq: the frequency (in khz) that mapped to highest_perf
+ * @min_freq: the frequency (in khz) that mapped to lowest_perf
+ * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
+ * @lowest_nonlinear_freq: the frequency (in khz) that mapped to lowest_nonlinear_perf
  * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
  * @prev: Last Aperf/Mperf/tsc count value read from register
- * @freq: current cpu frequency value
+ * @freq: current cpu frequency value (in khz)
  * @boost_supported: check whether the Processor or SBIOS supports boost mode
  * @hw_prefcore: check whether HW supports preferred core featue.
  * 		  Only when hw_prefcore and early prefcore param are true,
-- 
2.34.1


