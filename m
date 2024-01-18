Return-Path: <linux-kernel+bounces-30492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1C5831F74
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2221C230EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA632E403;
	Thu, 18 Jan 2024 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EPeahfnS"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A45E2E3E8;
	Thu, 18 Jan 2024 19:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705604915; cv=fail; b=t5deTRzp94Uw/Q9JkFXURHulfvVLf4wwLPJPI8gGtHVgpSBaI9AREX0q44PZ0clT8Re2M06cj/L51e/Fx0UtHaW8J1EVO5Sgy2bIE0oQAlExOEQVmkxbe3k2/pVj07vBqSUwkYQmojnfb47Wb0+n8PrC4A/T6oOh7EN5ucTlP7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705604915; c=relaxed/simple;
	bh=cKk1ZTqWu80wDJ/y2SvXOJMJK1BtAnZ1qInvbcK7Vqc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e7ILUgjcmc18ccBB06aTWXovxPaLvDltSy7LyhHpE4OFkWrGpe5DSZlqK0O7BBQbby3OESTR/Yays23fsAyE2nplGb1Yj9j0t2xz1RQDOAJkFgYJ3031Lyj1N6JgnMVNXlabGdBCZsBYjOASLSNkhxU0rtCr7y/+49fpS98RObE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EPeahfnS; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZQOENt25avcbVUnzXLDNtLpxt2Wry19vCrFnheujIwPqGz9mts+hlxevZ8QXgnDPefM0GcL525fzLbmu2taDEMS5Dq/J+ZTwyBRXmyNbZh04Q70mgfprTHDqp0lMKTCzUaurthFAdIHEolSb18YruzPusz7u05ijhjkB8zoEiVNGYoYene4WyHYZZj04JLVr+wGHQPtEsglpUI1gQPj3wIs1qJUFKkF6X5kkjBdbLzVUHPZFh6n1IY3PjMZWCNDqmr5DmfwE0APZHyzms5ChzZMbvjTHnWvkV1k5WL+psBBmUjqZcR6++UPoCIw1aaq//ZLIBRHV2BEc/+dz4jiVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85BkfMIqMDCwUUw/uSV+o+GbkSvQTm9Yr1oBA5mJDZg=;
 b=gzN14Zi8tC7nTIh1xkE6Ys8bqzNs9glhRmC7GQrzJnUnNWVd5flr3dcQ3McJa3GDXktiO/DAn747zzXQS9v6e9lXc+e6RM35RVQnFJoW5rpqViqKvY/HFqN5WnZvtCIZ/DDSgJaWEGaYyCwXDN7P5CiLNd4O+esFR9xKzB0RWvrvW10LodGnPfD1F+8034wQpZCoZyZUr1FEvslVxOzWKp+SaaMQD09wEvFS3aP9m1LUn5nqM2vsDTJQP0Zmt6WgnMVrx/CpmdQLggOQWcrsVlQCqXyAuWMYS6rm4W/Vp6CHGSRAycS/gGiczl/+LyEZa324RxxzhpLC0ixBjLHgpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85BkfMIqMDCwUUw/uSV+o+GbkSvQTm9Yr1oBA5mJDZg=;
 b=EPeahfnSak8XdXBHYHyMSa7MhvBrCYdye1ypfQ5FVO548gKcEL9C045066SYUIiyapBM79UPelZgMc/+EkuA6aQCA0djw7LdcVkFu3w+csbwpXZI0HQZDgpIugU4feylaI7Jx7bVD68qRyXB4FAiT8HA7L0Nz4ykzbqd5r8laVc=
Received: from CH0PR03CA0300.namprd03.prod.outlook.com (2603:10b6:610:e6::35)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 19:08:30 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::3b) by CH0PR03CA0300.outlook.office365.com
 (2603:10b6:610:e6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 19:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 19:08:30 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 13:08:30 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 18 Jan
 2024 11:08:29 -0800
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 13:08:27 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <richardcochran@gmail.com>,
	<piyush.mehta@xilinx.com>, <axboe@kernel.dk>, <michal.simek@amd.com>
CC: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH 0/2] ata: ahci_ceva: fix xilinx GT PHY support
Date: Fri, 19 Jan 2024 00:38:22 +0530
Message-ID: <1705604904-471889-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DM6PR12MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: 2719bf31-44b8-4779-2427-08dc1858dbfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lWFks5tA6vGxHvsiG2hWJ/xntXBLdN2P7jPF7AB7RLJZGV1y/Zkd4TV3PPX1WWZLundleR9N1Zt3ZTBK9b73XtoAcrTYPcWQ2JU2Y+wPCjyzVDfaRgASWuSVMrN7flmrTCFXVIkiYaPgJ0CdLIYVn5UsXwTYqg8WK9PV+fu5CJrLcVV1NnRwbICOzq/edxDer/bbx4kBpIcFYYa3n0pWBN0N2eq+xe5VXFJ3z0nFkwPmQ01YIBPx8175t0GynUlIETJmA4cgabY0TSpy7sfZ7EehlTMKPI+r8AizZXjT/YxZJLpgqYB7EID9u4JzcUlk2uG8Kkeojt6gJukQD9TQnzVNFrwNVRi7DpoR6BTLU6r49JkTZ00ENU4Q2+vH4DUUnECglMxL7lZmcPwjuNAGYRi+1XTV5MsUUfmtkehL7q2vnIlADhrJDeE+mb0axJZwW1VDHAQDQxyds26YhvFlMBQoPH18yBTnpEWrFf3SVAAB1kgK7j41cv/3C55JXO4x2quD6UTnZObwgWXnNwHLptscK96FYF9BYmtztFNbE9qckfAkaa9QmBQoP/8C7YvtoBaDGp6qej8CY6dNunR3Opy+4ayRZz5HMxZIrLkFbxkSPJ3h4caDaj5c733ETimvzGpj0N+PghaIOcihhaxX+EbImhV3zHKaDWgI52FRM9h9kUFSfYVORMpakJNsai3LWAbGq5ZupYwGoo/w55wqEoH4ruCizwD1W6sfNowDRkMAXiKoROJAe2cS2n+P5dlZQ+3tMcLAViBi8+35j7vJ5f+DiDSNpFmiR7d3qRooOEv1vaWax5KWUxSJ8LMAczcd
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230173577357003)(230273577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(5660300002)(81166007)(356005)(4744005)(2906002)(4326008)(8936002)(8676002)(82740400003)(86362001)(41300700001)(36756003)(54906003)(70206006)(70586007)(316002)(6636002)(110136005)(40460700003)(40480700001)(47076005)(6666004)(426003)(2616005)(83380400001)(478600001)(26005)(36860700001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 19:08:30.5844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2719bf31-44b8-4779-2427-08dc1858dbfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219

This patchset add error handling for Xilinx GT PHY support.
It also fixes suspend warning 'Underflow of regulator enable count'. 

xilinx-zcu102-20232:/home/petalinux# echo mem > /sys/power/state
[  481.335785] PM: suspend entry (deep)
<snip>
[  481.483682] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[  481.517440] macb ff0e0000.ethernet eth0: Link is Down
[  481.523041] macb ff0e0000.ethernet: gem-ptp-timer ptp clock unregistered.
[  481.530018] ata2.00: Entering standby power mode
[  481.583873] regulator-dummy: Underflow of regulator enable count
[  481.589876] regulator-dummy: Underflow of regulator enable count
[  481.595883] regulator-dummy: Underflow of regulator enable count


Piyush Mehta (2):
  ata: ahci_ceva: fix error handling for Xilinx GT PHY support
  ata: ahci_ceva: add missing enable regulator API for Xilinx GT PHY
    support

 drivers/ata/ahci_ceva.c | 55 ++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 14 deletions(-)

-- 
2.34.1


