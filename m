Return-Path: <linux-kernel+bounces-69979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7C4859134
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A08A1F21EAF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91B97D409;
	Sat, 17 Feb 2024 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2iM66rRM"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584957D3F1;
	Sat, 17 Feb 2024 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708188768; cv=fail; b=ewpB588JrEzgZhUL93mkFZVbJD9z1CtpTrzFZmXtM7UwOWgZXi3mdyrg5R5vXnTRor+BLJHmgc1bDTFL/jSNwFetXLPn/+knD4KPIuGud5bJRwkYSXFhOBxaNBWRyDOe1pyb+AjdnNtjeHPuhS5jWo0+wkSQJpTbK6qzUZygscE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708188768; c=relaxed/simple;
	bh=FEMSSVq+9HJUayCtCi7TSXQpeecIvo9nR+7fbknpdTw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YUYnQ7DwhFag0eauKAzRbYszL6mk2QS+vhJVop2mvIxxFRU3j+q2kM4sG8LofFaFfCJXmsh0M34+X5sQk93KUKJWhOPbaNAE1MnNWSzx79b+iZuVtX3syH60VFoHYN0FS8BIs8mREHUvNsSyr5UMdq3Z58pnycxOXbl8R0UmF/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2iM66rRM; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4Ksh2sy2cM5W/vrIzXjfw+31pWpMpV99QTeSctAKNiz4m3XqxuWOKleXePyxfqGDH7SGicYL5MV53VmEq0iID7qv199ULi5uiCw4YRE9YY7F2X0nhgEoz/lcJ8BzrTxTlX1U/e/PLl00zP1O87jH80v6uQryhWr9ulhcfEivmoo9JDgWGxnTZl7FdVA/Jwfx7DHMUnTF1OlOL/A7z3cjDNpjvY4JwjUKVGn5+a2OrzGn1xQe0NychlgCWej0Jk15Ope/zSloBonKN3qY+NGUG2sHnbxyZ/fGwKPPtQhx5bwLlGdo/JnT7WUR6aQn6YPvy/KtlfTDbqfIz5C13OqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMpROuTEsSoXq0N/X1DjTRvcJIggV7EIRXNI9AwYzhk=;
 b=Ql6qOu/21rW6HDg57dVrfVgCnW1zHowj4v/ruH0XEz7jdhZjZoEoXu4wmoGF6t8gMTSMGxPVUjqVRAyMWYyh1aOYohxRhNUx4C8qr8EWh7qTfTQZ/LMZJdCkHcHo2rO64+Aed6ZmyN3uKQsb0yS0P4nOd9FuL8Jyv4HRuSoqWy89CJ97H9dieLSBM5JfoiPDyqBtuHeNZlP9vxUgpwjIUgy5crBaSsUCdanoRDc24/HVWYLIqwY5RICV2gnY+0pxGGhQhbsdWPSmC8YlovHju/6u2TKNHQLJFazYT+3MlyS3JZjf0GWg6vhKDDZF0UhxvzJBqmdmFTMei9NNLMoKkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMpROuTEsSoXq0N/X1DjTRvcJIggV7EIRXNI9AwYzhk=;
 b=2iM66rRMigRL1y9zaBYNrpbrhAu3LxN1wFDbEMrKNWfpaIg9rF5Y0EIuoh6lc6CqixbfHhwNqqsyQUTjK9drQZmS9NrSGNf2sQguyHfz+yIVrzPEhkN1UIUVEgnUchrHOQ0OgBdQWdZeQWvO3q/0BFbUku6JotK0f/DIjbnuVPk=
Received: from CH0PR04CA0115.namprd04.prod.outlook.com (2603:10b6:610:75::30)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Sat, 17 Feb
 2024 16:52:42 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::b) by CH0PR04CA0115.outlook.office365.com
 (2603:10b6:610:75::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Sat, 17 Feb 2024 16:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Sat, 17 Feb 2024 16:52:41 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 17 Feb
 2024 10:52:40 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Trolli Schmittlauch
	<t.schmittlauch@orlives.de>
Subject: [PATCH] platform/x86/amd/pmf: Fix a suspend hang on Framework 13
Date: Fri, 16 Feb 2024 18:52:16 -0600
Message-ID: <20240217005216.113408-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: 909d0ddb-d595-4591-d51b-08dc2fd8db3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ffawztEB82Xwx4Kb9d4rUhj7OTHjHUTY5r2SfINroHblG3S/2TAf1DF1J9C3JAZSs6Ut0ms6ELzyoA5CA25+wxqQU5Lh4KR00DiukI8t74zVifdUsIwFr3sfqOnYm3Bn64OZRUcp1RURKb2gpNpWPP1tnR2Gg+KsY7nzQaFj7ux649e+JEEHks4XHvCkVI0ks9KqJgfLtyIp417bB3hA4gAcqSslGcm1mCHk1pYYyS4KjACI7r2qX0Jw8Ek9v6aj828qi/oqXr+D7sG5Zd8pTTqGbEM/FYOqnTIPLf4ysbrr1D0RWKhbPynzczALsigKN/wsy0w3EdJFyurLLkRKXK4tds1pXAwxtRqGn6sC086IND0YGh3JAg4oVbeFJvoXqYV6cZucHC1Ap9ryxKrci9yoMoDAs7opQdjZ43BdNRov7D96qzD44gfOa/CwcRrG179ANrrE/oimvmpLtJx+JJWxiXytm+N5HDbHzp802HUMxWyoDssu1fCGUU+azBhmABU02P8DeBsqpOZg+/p+PqA1aH5aSQnyud5TNLyxG5oh5F1b7gc5j813LTgdQOAyFUuge3TuXjvZRbTOFT2njNA6Go591anBilPnYhGnRKexpToqsxljPgOI883xieBjOb5fawiXwMspTMncoFR1zA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(36860700004)(186009)(82310400011)(64100799003)(451199024)(1800799012)(46966006)(40470700004)(478600001)(966005)(41300700001)(8676002)(5660300002)(8936002)(4326008)(2906002)(15650500001)(44832011)(7696005)(316002)(6666004)(54906003)(110136005)(70206006)(70586007)(81166007)(2616005)(36756003)(336012)(83380400001)(426003)(356005)(86362001)(16526019)(82740400003)(26005)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 16:52:41.6977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 909d0ddb-d595-4591-d51b-08dc2fd8db3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941

The buffer is cleared in the suspend handler but used in
the delayed work for amd_pmf_get_metrics().

Stop clearing it to fix the hang.

Reported-by: Trolli Schmittlauch <t.schmittlauch@orlives.de>
Closes: https://lore.kernel.org/regressions/ed2226ff-257b-4cfd-afd6-bf3be9785474@localhost/
Closes: https://community.frame.work/t/kernel-6-8-rc-system-freezes-after-resuming-from-suspend-reproducers-wanted/45381
Fixes: 2b3a7f06caaf ("platform/x86/amd/pmf: Change return type of amd_pmf_set_dram_addr()")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmf/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index 853158933510..4f734e049f4a 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -299,8 +299,6 @@ static int amd_pmf_suspend_handler(struct device *dev)
 	if (pdev->smart_pc_enabled)
 		cancel_delayed_work_sync(&pdev->pb_work);
 
-	kfree(pdev->buf);
-
 	return 0;
 }
 
-- 
2.34.1


