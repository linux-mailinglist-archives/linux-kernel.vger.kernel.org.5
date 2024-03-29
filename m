Return-Path: <linux-kernel+bounces-123874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E759C890F1F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736311F2397B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2869DEDB;
	Fri, 29 Mar 2024 00:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L1GzmKb0"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA007A29;
	Fri, 29 Mar 2024 00:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671695; cv=fail; b=TtpZSHlDNascsdyneXiq+AOCfJjaloMS8WyTlvFuESxv1rg1fVfBABAJ0BxdhtotXkDxGWlG5p1CDYIZOdcKn6m3AMZeZQvYe/hZEzyd6V6zDSHk9bL7slMg8RAsIhkhWdKyXzTe3ODucpEqnKaxvt4scfhhkxkmoeSNuOIcVp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671695; c=relaxed/simple;
	bh=CMWlX6ggq/Y4OG2n21ie3Y4fEHFNiJ+58eeQ0mGyooE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FZg7hKJ1CCGQXqd7N34C7cMQRkyuWeep+v903pbMWQ5hn9kYlizy6cd9v2qjYBLAX6iJcMog+/wmaJ+f9LWQv0fsM462MF0nq1lOVXEfHgKB/P0RoXmw7h0j8GId76C2AQwAiCOD0FRiIkWxxcpYffNhyFjtTeY16Z+iSBkUWSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L1GzmKb0; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhAx+PZUqUCUz8VwXoKVRcoIa2OmkhG3haagySdzFZobEnBOl6Bchy1P8p2yoWYg09ogu3NdPp8RsUFw6hKPhEO0BKX+3DMiaF1msUAi63WUYQBsMryZeDA4TMaQPE552MDW0+3US8lSPB/XKyh+7J8bD3aFUS6yPcmnjPpi0r1ekW7QJaX9F6X8i2iYt9huNhrz/eFNYJd4zHRoNEluww4mgZ79Dz+X+Z/pzgYMQz99Cpn1lhqJOJ9ULRGrtit5jZtHXdSeF4VbSkq8Vx96u+8oWSG7zdJ76b9gVlqHa9FwG7o88kCUWyS7MllPuprEw7iZlZaBZ+QyZ4QiFgrLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pt3HyP9TCf4nKMK5NCoRbWztU6Hps4wE5gxTGSe2PLo=;
 b=S5oY6WNIXCOJki8pKd4P3LSx/T8arqxKmAkwTyJSJ43dh9nYl/lm2ewyifzaiqz3pfcStCPPOEXEXwjLmVrv+dHAOMmQ7zkl1VEqn3qKDTEUBoluZsUG96cmjvxBmpxxdYrtmkcMgap6xj4TqVq7IB0tZY6y5KmMTBcHGUu35JwgmGLeVBnRE80PWr4C/BgD9jdz6hxpec3xkiMWAOOgLOWkOd0nKxipCLfJ8Lynkl6nEI6UbAP39UdI+hqUuk/6a3BjpOlPa22AY6u5hrvXBPkVfmJrLJ92EbicM4gjSCncfMJiDPUiUEGPe6dtMbmyR/krt5HfDqgn2FKss6nNlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt3HyP9TCf4nKMK5NCoRbWztU6Hps4wE5gxTGSe2PLo=;
 b=L1GzmKb07f/4argWe9tvHJb1iQQ8Vx6ViMgTDp9i0FWGMJx/cwJYcE3hvE65N8eXgxgwtsxCzfpkM2hx1akg10euPMAwk5CBfZA03trZDHlyWtQhq0A/YZv/G38yizml/ixH6lmU8HgijLmUyNzGDE329whPgFG7r3eMyniqrNE=
Received: from SJ0PR05CA0110.namprd05.prod.outlook.com (2603:10b6:a03:334::25)
 by PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 00:21:29 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::69) by SJ0PR05CA0110.outlook.office365.com
 (2603:10b6:a03:334::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 29 Mar 2024 00:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 00:21:28 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 19:21:26 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <sohil.mehta@intel.com>, <linux-kernel@vger.kernel.org>,
	<yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [RESEND v5 0/2] Update mce_record tracepoint
Date: Thu, 28 Mar 2024 19:21:14 -0500
Message-ID: <20240329002116.436824-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 3295f5a9-be7d-4f5d-7bc1-08dc4f862d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3OSMUFX+WmIzdibtlDd5hJ6PrZtqi9scJ+DqPMwTELqhMCYpPTp26OTl+leSeqyB/JP35vqYAANiN+NHhgvF59pMRENdvVxt6QrTBtXGO7ImzcRhAJ8ZH68kSXa4B9p/HrifnzeXLYAij243PrsqBLBStNWNr9CnypIfivcID5qHE7jMbw+yLUiQpq23Mft5Mhe5/3+JIa0IfN/Fn/KPFIsCcXG+Z9RDDsI3OoWadhLneigUX4sEE8JTV5vF2ppvOk37+OFhaCxfkDhShC2+K3D+7ogWGzRvfUXvR/IzazAML1xIElHQjFxpqUXqM1kb7PyA0ONeSteWRWlMmGaGHLHj5lNqGDAnA2S5OuVab6Ovs495OUHA4vSpSm/jJ2XJv3XkLNGQHkhV/jI1NQ7W1rpukijgtxRymaNU47f4rV2lVnVU8fTX8HHYnfwYwTJAhgyUT8l6Y8UIcdqbnOtu/ExHR7x7fxG43Ukl9M31PQYbEa32Nrs5bxevsYuSG//MoCnUaWxJ+7Fzk5fu3Vo2qOtPGnoNynz3KlY5nDKC/K0yMbBZRBnUeRbgtQRIsPGekl1qKVvqcEUVS90g4MTvQCjgRO6s2Khf2q0A5BhMYKdUPEjW8QITP596ayxl0/sUmPH8vAz1njL25AHSOzCiqQeE3J9N/yeFldLx+bdhg8nLNFw4RD2eb3ij2uxj9FWKYAn6bEM8BKhydzrJLzB7TPkd3dr4ajfurXs3IKCs0AVFzCd+jixj21YKFKS2rZVE
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 00:21:28.0342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3295f5a9-be7d-4f5d-7bc1-08dc4f862d23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277

This patchset updates the mce_record tracepoint so that the recently added
fields of struct mce are exported through it to userspace.

The first patch adds PPIN (Protected Processor Inventory Number) field to
the tracepoint.

The second patch adds the microcode field (Microcode Revision) to the
tracepoint.

Changes in v2:
 - Export microcode field (Microcode Revision) through the tracepoiont in
   addition to PPIN.

Changes in v3:
 - Change format specifier for microcode revision from %u to %x
 - Fix tab alignments
 - Add Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

Changes in v4:
 - Update commit messages to reflect the reason for the fields being
   added to the tracepoint.
 - Add comment to explicitly state the type of information that should
   be added to the tracepoint.
 - Add Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Changes in v5:
 - Changed "MICROCODE REVISION" to just "MICROCODE".
 - Changed words which are not acronyms from ALL CAPS to no caps.
 - Added Reviewed-by: Tony Luck <tony.luck@intel.com>

[NOTE:

 - Since only caps of words which are not acronyms have been changed in
   this version and the word "REVISION" has been removed i.e. changes are
   very minor, have retained the the below tags received for previous
   versions:
    Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
    Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
    Reviewed-by: Tony Luck <tony.luck@intel.com>

 - Missed adding linux-kernel@vger.kernel.org with v5. Hence, resending.]

Avadhut Naik (2):
  tracing: Include PPIN in mce_record tracepoint
  tracing: Include Microcode Revision in mce_record tracepoint

 include/trace/events/mce.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)


base-commit: 9699768066a9b12db247d5ee9276cf298b67528d
-- 
2.34.1


