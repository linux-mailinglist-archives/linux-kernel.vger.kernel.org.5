Return-Path: <linux-kernel+bounces-50097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331BF847431
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5755A1C24D41
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0145914AD23;
	Fri,  2 Feb 2024 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lr0pktfi"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934214AD02;
	Fri,  2 Feb 2024 16:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889991; cv=fail; b=Fj4ILIq1Njui5H9RH6M8LNWs37Wmhyg/Kp1dS5MKlp4oe7QpsZcHN+iDNTSt1GeFHEDfuR9vYTjZWB1XBkv6rjQwT29JvW1crmQ7JUqdW+xs9xC/ljHRVhrmO+0mJnnY4/4LPmjCoI3EdpcID7Xr2MNjflUzy4RkQJyu/dfDuXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889991; c=relaxed/simple;
	bh=MsNYoj6sxe+SfUFtH4QybfrFuLezXoGakiC2UjHPYQ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t4L8x+bpS2LKDHE/LkuJl82xSr7gTjSM0S6uUYw1E9ucMjyhRMB1kBpe5iHv8YR/uPytHCTQZQfQ9ejkY9qVjIEzkfypaCNed/KCO3djJP97ondGD3JPDoeb4R6R0eh3anmPnPKQiBwGKZpVGRcWFGTFimQdFNFAh5bTqRDyG3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lr0pktfi; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wo1Ht4SqPxVNEmYXnPVbEO+IjfYLxKrbLiD3YBg9gbkvPzT7ajfh6sfIs+kI/D9qCLfStYNIwslH4a83AJlhtQvEquY4JnB6cm04/GpQbHkEl/p7WY2MfkpbAwA6syPK3diQJfNSEZVtzNItJzD7YFqbI+Ur8hLO2KMYFdacIHA8i+0WHrMAUGcvKa5l3RualPYekqhlkHV8FRtFQvJS8XaufJMNec/INrABtZUp2tYSkvgtIAYOQSvifDVyzyRfY2uYJhdsVbV0KYjf1GS1R4Z5yucn5d36AglDkClLC+6s/BEoUZmezFd3df7R2KhODa2nA7t1MHl4N2O9fm49AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhzUggw8fnZiJ9w5rmA/Y9st0kiBXOVYyMOMpiaa6ag=;
 b=BFylWXlXI7J7amB5CP5DoiY4oeKk2AO6/xyJK+KJ2V48mCmKtiu4VakJJ1zFqEh3afxLQWzHfeBGhQhFR5vRQmO7nKWuwdttnVzJXvtbqKa0kFmYFbR2VeXk9bmyzc1Ntv4DjxDTi78+vrjJ5+kG44FaIG4b3qjPUQPBTICpcRgfpngMN7X+C/cTFfUKJj4zIuZ+Bmp4DV4Ax5XOQCQj2VTNwZ8ZhIT92xtvGGHFVQhhx6D0chsYCSusLWU74Wv/HFlBGiVfXVYQhR/6PGECFa1BsMJfLdhoHlNcjFO3Ai0q5jGwRVmHcsRhaKFbP3RLAo9ysCbPof7tZX9EIKAw3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhzUggw8fnZiJ9w5rmA/Y9st0kiBXOVYyMOMpiaa6ag=;
 b=Lr0pktfiEyyAJqSyvX/P2nOrHt1LSlWP+OqOSPlJ7faQ3q2/FczelzLBpmWq/RZZ4TPeb8Z/3VcbCoaHNIRTtoaGFccrXB1FUCpYJMzMXkpsARGe9caJJj1p5TwCP7+RnqQwifGOo2CkfeafQ1HADEtGEJA9s5x7nfAVp3iDuhs=
Received: from SJ0PR13CA0101.namprd13.prod.outlook.com (2603:10b6:a03:2c5::16)
 by DS0PR12MB7971.namprd12.prod.outlook.com (2603:10b6:8:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.28; Fri, 2 Feb
 2024 16:06:18 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::1c) by SJ0PR13CA0101.outlook.office365.com
 (2603:10b6:a03:2c5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Fri, 2 Feb 2024 16:06:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 16:06:18 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 2 Feb
 2024 10:06:18 -0600
From: Michael Roth <michael.roth@amd.com>
To: <x86@kernel.org>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bp@alien8.de>, <sfr@canb.auug.org.au>, <thomas.lendacky@amd.com>,
	<ashish.kalra@amd.com>
Subject: [PATCH] Documentation: virt: Fix up pre-formatted text block for SEV ioctls
Date: Fri, 2 Feb 2024 10:05:44 -0600
Message-ID: <20240202160544.2297320-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DS0PR12MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbf94b0-ec13-47de-18c9-08dc2408e42e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n5YYkH8583iWOu7Z9/QlomEWLySn2RaaUktviD1R9hfxZRiU6CyXHSf1USgH0gKva+5OVheSWa47PrAeO9CnGS+zOFYSjSvnSp2hc7Vi09wOTebyXXp2NSFM/ZjG6RabMXSnvECD74oDJhy/YtYZ9JWLHD9WjT/r7elrlfaAqn/tl8he87ElOJ3zulTtxEkwv37uwO14xcbFaex7uqWYhCogt6CL5GEwVDNYKPxEw9pnT5ME5WtiaLy4he9mu/G3dMWrl3U9/k2ppGzICXqFQYAHjm4O1gturPZM4DabyBoySKcibqFgSiDZfEFDHOgRJOgTaOpdZHk94BKs5vdsnjqjMJucPvefhXgqDAFnpyQfEfGcNedbbCm397zxWXTowCqa0EXRsC9f/yObh7+pK4kSBMcQ5+4A8XK/S1eMZK1UXd5uLoZhkSy1CM7ejAnkq9qRIlaHEi7Ar/dMXKmQLIAmwQOmOwouKrueGHxc7auea/DcJmy00JLdt7jpzFfK4Qe5KT3SGE+dtLziKO2t66D56QMDD6h2EfNkbhNklUqvt9CD74/rBemmmDWU241criOM3lzd55GHI5eTHy04ElqeCNMZTDBeOi86E0feD1+QclRU/t2ItlGzsSc5k9UNZlZyjV9paLdyOvru396B/KfnlyJDslqeZQWKQXoZH8pjzUgPHZZGuPWANtF/hy6cv7DoUOVJCzdO230afQtO2BDR2MAk2mv2yotgRfaUP9+KFP87nN3pU77ZEtAk/Kdd2UXhii8ObQecq64BnxXbQ8dx89EOB7qLKt+BTrYQH9OawvZOjetu7Q095qmNBfTY
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(230173577357003)(230273577357003)(186009)(451199024)(1800799012)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(83380400001)(36756003)(41300700001)(86362001)(82740400003)(81166007)(36860700001)(356005)(47076005)(1076003)(16526019)(26005)(426003)(336012)(2616005)(2906002)(966005)(8936002)(478600001)(70206006)(316002)(70586007)(6916009)(6666004)(54906003)(4326008)(5660300002)(8676002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 16:06:18.5551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbf94b0-ec13-47de-18c9-08dc2408e42e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7971

A missing newline after "::" resulted in the htmldocs build failing to
recognize the start of a pre-formatted block of text, resulting in
warnings being generated during the build. Fix this by adding in the
missing newline.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20240202145932.31c62fd6@canb.auug.org.au/
Fixes: f5db8841ebe5 ("crypto: ccp: Add the SNP_PLATFORM_STATUS command")
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 Documentation/virt/coco/sev-guest.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
index 14c9de997b7d..e1eaf6a830ce 100644
--- a/Documentation/virt/coco/sev-guest.rst
+++ b/Documentation/virt/coco/sev-guest.rst
@@ -71,6 +71,7 @@ The host ioctls are issued to a file descriptor of the /dev/sev device.
 The ioctl accepts the command ID/input structure documented below.
 
 ::
+
         struct sev_issue_cmd {
                 /* Command ID */
                 __u32 cmd;
-- 
2.25.1


