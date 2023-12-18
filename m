Return-Path: <linux-kernel+bounces-3212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2665C816941
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2FB1C225EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745E111714;
	Mon, 18 Dec 2023 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zMG0zVEd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1411170F;
	Mon, 18 Dec 2023 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8iY6Uw5mLb29NH8m4yTEmk/w5pRLpUwALLJG5a2BOd6HIuJEW70UUzgQVAkMqmpbxHFmHrzvl2w7ZlBdrKQJekvtFTlJjYg20kUdoXGLvoXuuBrXnU9ucmZXufj9BV/WNihNM9prvLXjDsGtC0inTf7IwdEqp4BDUYKjhZc0pEJmw02KZcr+JcFZ5RR6hRBC/YYSA6WKFyVnrh90MfpTXSzhbU0eboYCKTAYEPY7VWutp+ZPalZ0fsl28/kKnO3b6SYuFWVW9HkR4SHbB4zLQ7WEXvG1+6Yjx6+a+pEjnxVXx8Om8Qh/oP4GgebKM2jw3p/Md5eDNDKeO+uTrkD/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2L3iYSoyytIXcGGqlRberBcB5NLpDkD4/HyjqSwjJ0=;
 b=Gez/eGohs03Os/LYpk5XihDihCQeVTjLpL6cQ1ruwEncdRT6jFtBHPJU3k8816mncwClm7CCKbK3eAuGvKq0x35TF7BsM/hVhuKEPWDvALpzm4kycqvwrzHK4cObqG5gXIgT7KBX7MLYlQoA13Nc+NKBI/eqvBEpxp2q5vj6QGFmOtTAf7clSCqPphYj5kx0U3yCAPwybTlHoPKbYtI48G++mrPdT9+qKoFLybUG6Bv+viM0XlHg2/MZr6EniN8I3SNiR5yWYepbdu37gS40+FcTHAq814A2Xi1b9QcFaTA8TfIoiKDAqpq7hgFgXYdLI9//gvQSr/Yas5cy2IXrMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2L3iYSoyytIXcGGqlRberBcB5NLpDkD4/HyjqSwjJ0=;
 b=zMG0zVEdiOh+TRhAf7mKspO3LOe85pMyqtdDd9nVQ5uawesdR7/mBFGAPnjBIZ33/Sd+i1LubCl980MRWBWtpWjniWqEtrQ8S7Ex5nhHOv5yZdeBhk4ImXG83vVaJRZI6doaY0meVqvnKBLoUJ7W1P3NHSOnj2g3LD3tfuaL33c=
Received: from PR1P264CA0165.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:347::15)
 by DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 09:07:02 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10a6:102:347:cafe::63) by PR1P264CA0165.outlook.office365.com
 (2603:10a6:102:347::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37 via Frontend
 Transport; Mon, 18 Dec 2023 09:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 09:07:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 03:06:55 -0600
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Mon, 18 Dec 2023 03:06:54 -0600
From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH] spi: spi-cadence: Reverse the order of interleaved write and read operations
Date: Mon, 18 Dec 2023 14:36:52 +0530
Message-ID: <20231218090652.18403-1-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|DS0PR12MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 64805e53-6301-4437-4a57-08dbffa8b215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L/WPCCmWYj17NCJpd00XhRBeo8m87MERG0vF8rjP8YGH9Bn5h0N6BsYbmHOCMVukjaASZj7PMF7gq8YZMIkkE+rLhdRr+sCW43d6nNdaCdEYMGqGeTmg9hs6bwv34+bQUfmb2aPm1RtUHZ3/Bjsd3bTgMH66GaUobb0/grDOR1NSRLBn8xtBwUizXTrDFr7VnoprqWx1O2eBVOQ9GviesReZ1yhwuy2sj55AyyjfqwHLIJwwLdrO/JmeTaG2eopIf3J512MMiG9PkHo9/foKWp6qyBn56Vc4BO6VR5OBNMt4BqWQSFxb2arZEFUbyxVrow9nHZ32JOirp7lj7pMr6vXlyjMe1J/p5JCxzLNUUoHjdjGgvWGUfuGg7IScMnc9zIpwlnnHOUkiEkOH2eyXmD6wVlpQ93bmIIQsBAgkjIjzYnIC8TWLm7ngE/SazDnONJXu8ASg8tyvzHQSL5NkPkt1JyH6vkEeWs7FHUGLq2Op6Bj4HJK00w6gG3nyBCBX0rtS8/6YGvs2REVFfLIayqih/hjJnvdFnPInR9BszqiQSsqJHt0UHPN/djePaHamS1NJwlQ3lNn/DpX9R0Odmrtxkk8/s8Gb9ow5yDCwafALXREmwIohI7ZuEKadXxiRi/lH5kLT+FMyHpi8i1OFaFg02T/E/0YpVXTUyi7U5ebDfn4xBiSt2aOY9a+7NOpn6IFyVEsQ/6zwwGAUSTB5rzK7qdl9U71Tzb8EdgzOhFciScnUGdp6ro/ok7WWSuEV59XbVhFvB3k6I9Ipd8Fy+Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(1076003)(426003)(336012)(26005)(2616005)(40460700003)(82740400003)(81166007)(356005)(36756003)(86362001)(47076005)(83380400001)(5660300002)(36860700001)(8936002)(8676002)(4326008)(70586007)(70206006)(316002)(6916009)(54906003)(41300700001)(2906002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 09:07:00.9916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64805e53-6301-4437-4a57-08dbffa8b215
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825

In the existing implementation, when executing interleaved write and read
operations in the ISR for a transfer length greater than the FIFO size,
the TXFIFO write precedes the RXFIFO read. Consequently, the initially
received data in the RXFIFO is pushed out and lost, leading to a failure
in data integrity. To address this issue, reverse the order of interleaved
operations and conduct the RXFIFO read followed by the TXFIFO write.

Fixes: 6afe2ae8dc48 ("spi: spi-cadence: Interleave write of TX and read of RX FIFO")
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
BRANCH: for-next
---
 drivers/spi/spi-cadence.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index a50eb4db79de..e5140532071d 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -317,6 +317,15 @@ static void cdns_spi_process_fifo(struct cdns_spi *xspi, int ntx, int nrx)
 	xspi->rx_bytes -= nrx;
 
 	while (ntx || nrx) {
+		if (nrx) {
+			u8 data = cdns_spi_read(xspi, CDNS_SPI_RXD);
+
+			if (xspi->rxbuf)
+				*xspi->rxbuf++ = data;
+
+			nrx--;
+		}
+
 		if (ntx) {
 			if (xspi->txbuf)
 				cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);
@@ -326,14 +335,6 @@ static void cdns_spi_process_fifo(struct cdns_spi *xspi, int ntx, int nrx)
 			ntx--;
 		}
 
-		if (nrx) {
-			u8 data = cdns_spi_read(xspi, CDNS_SPI_RXD);
-
-			if (xspi->rxbuf)
-				*xspi->rxbuf++ = data;
-
-			nrx--;
-		}
 	}
 }
 
-- 
2.17.1


