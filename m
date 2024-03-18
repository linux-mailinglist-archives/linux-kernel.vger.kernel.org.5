Return-Path: <linux-kernel+bounces-105971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7C987E6F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB26281581
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF8E3BBF8;
	Mon, 18 Mar 2024 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ckMufI6/"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F33BBC5;
	Mon, 18 Mar 2024 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756711; cv=fail; b=P/A62MsMeYKW6Aq9X8fxl5roPyoicfPZDBx8bQ8WnFe5GThhL8GYKep1ZrOBZzLzFP/MoGWQZHALFAz3pjbX/v0rCvcqilfNMSKl3d+zu3Kt9lJ34ebjZ0AaMQ6PGw4oTt1BB3G3Y+831v9c0ZzFWuo4D0kikcLwGkL9PL0YrQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756711; c=relaxed/simple;
	bh=xEj6liAj6IMhbWAhkHuDsMO4hCwxjqNXMN9NlrsX8rk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6RIahDDBvfrdJ5S+uK8zf1LTL5xFXQU86mueGyzYEFDPZPQ1bDwLIbh544k1L3x/qsvM+Z4QAE4rG2xOz4wBqGM+G93XPOVJxFm2zZstF5taIF8ojlxyHV4HBv4szpPblld3pXWCfXOuFTIS13Q+FLrhlemFU0bDgiF7iGgTBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ckMufI6/; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJL8C4PCwzmDPZTKnvtPqe1W1ZoPvpCX0Q6VD2ynarPWv9BWlf0hLyTTWI1JVcQzRN6NwYPB0QDdzocdoP79l7ijX8kL8kQfBYKV4wnsENoCYmEJNkmbW7AfhhK6y+vrEUXUUD9X4wSv5DgsRqE0G+fnpXR9U9SwM2dMarfZ4HTBbuEEikP++nzzaxMBO/lwa59O4Pew4/qF06bPeJxcN3iATjPV1BN1tywfbv9576nYXtm4Wd+W8UpJjadkEYJiHUsaX1om2LYkqJJLLIchHNwUTBkyATBkGLge106k9QbnMXpFoyq6jdQuphBatK0qNBGSxi8Wq6iSyVhdJOjdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27ao4J8fzUAMRbFzpm1S5an7Hi17ByoMGWcavVPwhww=;
 b=Nxp1pL7Zv6HSOBTnknrAmoRSoPaQs1fuFBsHv50a5tF+raC/DVr3dC3Tu1LcWAdUFEjtXYODRl/SVKGOFitkJuFfivg0zCgpepTbdtE4EXD9TXI5j/bIdTFYoYHtGSCxHMXas3EneWPJEHmo7MwF9IjbobhcAnxUbU0CdiAn0mZNIPe6DCjbo64faYGBfgHqYArlitf8GMNZJDgz7EGJCMJUIsuMbOAx9fJ2mBZnU1mIoIuYICl7W1I0U5kliuh4IFy+gOMwQIJtFLxzrd1Jqo0gkOIEpm3DkfZwOuBlL7MgBuVvueMGsDTczUiSP/bm7OaezAqixJFq8fW67/+6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27ao4J8fzUAMRbFzpm1S5an7Hi17ByoMGWcavVPwhww=;
 b=ckMufI6/7N94onKhtVna8JfteUYiVu4SHV/P4mTRvDbIBz6ATZ/viOHO2sF99cuhBmnRG8jyApY8U1C09CHBHlQ68OYcmvU6pXFGWRVUV0Vsm+Irt0R23Pm0FIo+2hSPjUOkHImy8Hb86wVf1JelH06LmBMV8Q0ZM86tVmEK18I=
Received: from CY5PR19CA0076.namprd19.prod.outlook.com (2603:10b6:930:69::22)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 10:11:47 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::57) by CY5PR19CA0076.outlook.office365.com
 (2603:10b6:930:69::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 10:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 10:11:46 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 05:11:43 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 5/6] Documentation: cpufreq: amd-pstate: introduce the new cpu boost control method
Date: Mon, 18 Mar 2024 18:11:12 +0800
Message-ID: <7058c6a5001d021d00c0a27f05e598d32ff1dfe8.1710754236.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710754236.git.perry.yuan@amd.com>
References: <cover.1710754236.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c5c90b-de58-4ad2-dacb-08dc4733d1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DaDb82jAJXWWUnQvkrNlJRuqfS1y3q6LrHFxD3lS9yn2L1qqPMMtieRAxcg/GcEZ7qwq5NPlsR9HciPTlfJLOCEbGH+KkVgnAjgs2sWLmW0kl8+cCOoct1KC77fcSptypFMVpqyk0Pe67ShpB7YydQiZ2S7V352AW9z/oosKwCurtH046E/4S+g6m3Dvk/sJ50zJXP/MR279cnzkWksvegAe6imrBO7Qp6Si/pAcsD7b3w4x429HNAFxK2zuTzoMwD2uHc7GXldx7oln34tc9t/tLWAlQqqFJ9sWCmLtZVPCGGwo9o1ikw+uOfl14cQxFnaghC6g5XoDFD4/+jm51qpfwduEYyECchjuq3/FEVjM41/VGySz8hFUcbJ0qhzAZJXAHbUO6N/x03ipzqg6xdZ+NPfW7FrfRRoT2fGbdsbTul6lrmxsu5j+rQas8qxEvBVAL8ULNBGMA/09y0VJ9gdkWCIP67BCOe4yDKfXiCYqj23d1Wg8pfYuEqCHU1UnVARNgjglih2XKPeilI+dBj/AD4AOEzfNFTC4T/ApEei/0M2mKYOuLlekxChEHbd1/FxuxRrogS7QltABzmJnOKSg+ojtSvCr5gQa7LatV6vPLSduanI8yOvj8pXJmeV46nMZs0at9CVK9yxu9MPBAIXfZBvVl+ElBw08EBA5xRGNAhAFNztH2u63Jkq8sAOua0THorR0yTqg6sDs+OI60gbn8E+XlPd3LiuLLcLALi2Xtkd4pvUVosIakX1/h/yk
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 10:11:46.9669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c5c90b-de58-4ad2-dacb-08dc4733d1ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194

From: Perry Yuan <Perry.Yuan@amd.com>

Introduce AMD CPU frequency boosting control sysfs entry which used for
switching boost on and boost off.

If core performance boost is disabled while a core is in a boosted P-state,
the core automatically transitions to the highest performance non-boosted P-state
The highest perf and frequency will be limited by the setting value.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1e0d101b020a..82fbd01da658 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -440,6 +440,17 @@ control its functionality at the system level.  They are located in the
         This attribute is read-only to check the state of preferred core set
         by the kernel parameter.
 
+``cpb_boost``
+        Specifies whether core performance boost is requested to be enabled or disabled
+        If core performance boost is disabled while a core is in a boosted P-state, the
+        core automatically transitions to the highest performance non-boosted P-state.
+        AMD Core Performance Boost(CPB) is controlled by this new attribute file which
+        allow user to change all cores frequency boosting state. It supports both
+        ``active``, ``passive`` and ``guided`` mode control with below value write to it.
+
+        "0" Disable Core Performance Boosting
+        "1" Enable  Core Performance Boosting
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1


