Return-Path: <linux-kernel+bounces-100473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B96879851
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5DC31C2190D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F337D06A;
	Tue, 12 Mar 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eSbI3iws"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C4B79B65;
	Tue, 12 Mar 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258594; cv=fail; b=mtkmCQebn/nzDRILRUf3mMKN50LYLVIsp8vbRxceETkxRj6DRIdxeHaNaTGIKr2H/Jgq98COMTzVNdMq42p6Wd2Jq6PR2U3JzmUooDzHsn55EDbPehnqdWV5a+GJ3xb7vfgCV+8n5mpxcv8Zr9uB+ltclYUmy5uSiFFA7b6d8vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258594; c=relaxed/simple;
	bh=tshOj8XgcqezQVERF1ePa8c5KHx/UUp9DSJrnoaWI7U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NdT4DMVrVsrUXERT6iXXUpBk+aedSEKZlbId+PdFA3JlpHSOpfFJBT0XUd+tPqvlIqs+oDR1czlY6lZCOr3QXmL346PNyMGBrRs1951D8fpX1nwfylwbUr5mC+9OFdLUrVoaksf7F2VdsjdGOUfX5I7OOT4ubaMmuJ6h3t+W9AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eSbI3iws; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TA/bfxYbPNMOBleb5wlkH9aNdcbhQmuSg29YRPsfyr6YP5lCGaoxJ4dvxVpX+6SMuNvFeuo4gyWVxcRd1S39l4hov2vOtgwTtjD+EH0vx04qVPM2s1gv5n9G+7Dz9NKM9ahKnwP9GnkHqfTPqFRQAXXQI2sE0FWFfU/fw8oczeerxjjCcejahm9jD7QLVt8cSHz5CCiPsWIxUxao6nf+IxMhY2obBbD9vc/XcvXIqUEhR+f9v3ifphcF4zw6KiTc2ZTrdKCihOZRPAHc49hsQoTBYmEfObRZoQ1jmhkmbh/+GpRzyWfloP9O/retiIMMft1VcHaE0/ZR4XYeyoABDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n99PwHryE9ncnAJojSZeN7E8V1GqfJF6AuA1f1oxV/8=;
 b=I0p+p9fHxvvIsxFXI4BiUHPdSPyYFQKXJZw69tzCbOPm/aL3IJJoaiCBL0xHy8eQmpaw00p0deiLxyWRMK2cFrY+QiR8rgMSYJL9IEJRMQQABTF9UAABwRWx8VfSRZ3PadFiupbOsuX5WCT8siFJDJqN0BzNWF4aSIp6TysnfsuaWdBtN9zQinxEN5HF1W4NtLNdZ78CZTZxf03mQ5O+4IfEj9RdazZlkmltk9EeYPGn3FkSP9PXDscSmoyGyO6HRQl9tuGEeUZ80HfgFAHJkBF3AOPlTXpVsCI6Ww0oXfoNCrUouMIvCz2/HDzn5qwaA5piSTocFgF0HhT8gCuM3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n99PwHryE9ncnAJojSZeN7E8V1GqfJF6AuA1f1oxV/8=;
 b=eSbI3iwsQ69U5PixZkUG5JTpFhj1DXbvJL8dSkDaJXKSpV9MmVnGCoN92EnnPmh4mGr05BT8IiYltsoT/52rwKlZT+ojt3xomeK5dZRFi5kk84mzGIyrZy3glJ3CWnYe1N0MphQgYepjcFM6xFMCdGfkIQ/PYLSdwO9f7rbaAIw=
Received: from CH0PR03CA0320.namprd03.prod.outlook.com (2603:10b6:610:118::25)
 by DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 15:49:49 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::43) by CH0PR03CA0320.outlook.office365.com
 (2603:10b6:610:118::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Tue, 12 Mar 2024 15:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 15:49:48 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 10:49:47 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <naveenkrishna.chatradhi@amd.com>,
	<muralidhara.mk@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] RAS/AMD/FMPM: Avoid NULL ptr deref in get_saved_records()
Date: Tue, 12 Mar 2024 10:49:37 -0500
Message-ID: <20240312154937.1102727-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DM6PR12MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: 86022b8b-42e6-4ec1-e806-08dc42ac0c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q97piGQ6XjGXgrPV+ecA8iTKBX7wKz544axs+ma/6J3rSre4LkpnV7msJYBy1TEXB47bA5N+KzpX+V8TsKPg1vOiBNgxgt1eXIr+YDYuLw8qQ5WzhugCJMczj6tX3VCy8mYm3+91zlMWoAIp+60c3qLfvNDvNIhMa6bhud4SabTuOBvQrdQpXI0LHY61s5TPLT1kgIuwgtngM3qXuwkrpHYeu6labZZ1ZWRvN7ZJSujlDTKZs74I42JJxqsaR0AvPcureX80NE69cFbRgPEthyXuU5ofuwA5LqwxwiscIJ6T6GeV6nCJrsBn/7oG/k5Cf4qUr4EONs/ZBCkbE4fH4Uxm4hDlWjNsPq1qspYkehHG9X2oGEQAJDhqTHgB7FvV3QZk2OhiuRgRlbPwivcPnMW5mQ0qn5I3zsXoseE7iI9QY55Ky6MNlFmpXghIjAN0TsJlfSlysJAs/G4FtgR3Ll93y3kSxOk8NVowqP6asVjm9ohI3+oz6sAgF2lMqZnXvsRVPCS6V+oSWi/M1gYCmdQ3JYV8GgY2BHsaXxcLedlhNImiw1YkgA8ExVcn8FjKiOLducziOi9sIBmGo1W4jCaFeKmZ52x3qq8tXPpy2OuAEOpSYALVPwuZQlwSvi45Rkq+ycjbTUEGQnMFCJZtndpjBuu3pGFmRq3kZfkIMvqBFhz3PaB5kd4qxDBJUPsAq4udnap0FD898Rl/6UV255oiUeM1ODZXjdPeAmCu9+r/bczlE7fmcWkqSc5ZhKxB
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:49:48.7988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86022b8b-42e6-4ec1-e806-08dc42ac0c5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218

An old, invalid record should be cleared and skipped.

Currently, the record is cleared in ERST, but it is not skipped. This
leads to a NULL pointer dereference when attempting to copy the old
record to the new record.

Continue the loop after clearing an old, invalid record to skip it.

Fixes: 6f15e617cc99 ("RAS: Introduce a FRU memory poison manager")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/ras/amd/fmpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 2f4ac9591c8f..9d25195b4538 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -676,8 +676,10 @@ static int get_saved_records(void)
 		}
 
 		new = get_valid_record(old);
-		if (!new)
+		if (!new) {
 			erst_clear(record_id);
+			continue;
+		}
 
 		/* Restore the record */
 		memcpy(new, old, len);

base-commit: 855684c7d938c2442f07eabc154e7532b4c1fbf9
-- 
2.34.1


