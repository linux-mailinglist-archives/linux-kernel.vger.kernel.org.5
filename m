Return-Path: <linux-kernel+bounces-139046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEA389FE07
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015BEB2E52B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F9617F361;
	Wed, 10 Apr 2024 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JS3nAa2e"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B117BB0A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768918; cv=fail; b=Hz0s2MmUXhdMenqTu2xGy/HPx4pBZDalndOXjAr0YfeaQhgvs8J8OIzBpqDtK5SBQoY7Qpim6W4MB9y/KkZrjmNgwuPAt4aaR997/fJviEk6mMlwm7X9TmSj1cw5I2bAf+2WSQu7PVVVhAcS82K8Gji4wGCF1/Nd/RJit7hROcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768918; c=relaxed/simple;
	bh=6z7OKj1VuB82QLw4TfFHLu5TjAceYaPMCIzfdcmaHBs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fPtuUPKhK17YwjFPiKYUDAcdK92vfsfShMuv8Krz25EsosvnrrsOmbqCr47QeA8ym0tQgq5OwYMddux4LILqNy7m48XgfdpjpzPKPX7Y3vyK/yZ8Rs5/eEg+H+jKZDUPrdZhY1+EsHLLW5M6sCklzzS/N9MD3mAAvr5LbZK8hLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JS3nAa2e; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Io14OhtmU18k74alJuWpwS0ymX2nWk9T+CwJsnDKphCy0zInarC2RgA2pIxvLhCToB1n2FpshvWJTjmoT/0JDi0uQaDgcsKu89jT+waR+oayXo/LKAeNsA/MSc5t2b2J/GJro7QKEtLiufl+QsNdedDqnrsRbfIYxdwPovs/0znaQNyxahDjvbsChJ+L5odxxwqb+doV0tbua4ck3/bD8INujgrjN/yCJS0kyhAa/3VWGflMGp5YjoDR0fJdHgQOtjmp+Zh0CxkOKoqRvx16sqsdvLFBMJll6ewXOxWLdw0CjCBvOUbYk87RFwvswLnCGm6r+I+6K6OcbycgsW6R3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGPV0kEKGJoQWOmH0hmgcw8c6/T2CK0l16VnUjvJnW4=;
 b=I43ZtG4qgTZE6xJrhwfbdUqPkMJVakV8WBRGkuTBF2lSYl/hqmofjWYeLBLoAnCOCEZNZZpFwGtRihqHTpPaOt3OKY8wG/OTf/f4FB5D42wribXFVxy3D1hetqlJ8I4HBSRIop+IQ9MpVIrV3SEi1vm8miEIqCQIcZ79LwOEyi1voRGfvOymz1tKjKLPvTlhifiBEq9c9v7xBUcbsRj+XkPPGoVnTa4iBhLirGeAYNHEOgRHrZ6hkC39RHXFFG0JlnbZIaJ6cIMxkA5rcFgBzPG5tHXHki6YXeRbOgRD+hsBVDTylNUQXjvE0WyXLAw496O21vO/dKgpM+6TdaDTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGPV0kEKGJoQWOmH0hmgcw8c6/T2CK0l16VnUjvJnW4=;
 b=JS3nAa2eNHagQQh0hD+ZaL8vacgkaaHC5cQGOyXgmI2oLnh9bD2wlShhwoQpgR5Mso6YpVIx61JK0e3B6Del1k/nqKMqoWdbPUx3O/DcbVpeB57JjR7XFCtZdsYTjIzSeOe0PhgN4Vn/kRqf9+JNCG1cvtdtS/D4BVaUPfWdoME=
Received: from MN2PR14CA0028.namprd14.prod.outlook.com (2603:10b6:208:23e::33)
 by IA0PR12MB7673.namprd12.prod.outlook.com (2603:10b6:208:435::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 17:08:30 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::f2) by MN2PR14CA0028.outlook.office365.com
 (2603:10b6:208:23e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.35 via Frontend
 Transport; Wed, 10 Apr 2024 17:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 17:08:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 12:08:26 -0500
Received: from xsjblevinsk50.xilinx.com (172.19.2.206) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 10 Apr 2024 12:08:26 -0500
From: Ben Levinsky <ben.levinsky@amd.com>
To: <jassisinghbrar@gmail.com>, <michal.simek@amd.com>,
	<shubhrajyoti.datta@amd.com>, <tanmay.shah@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/3] mailbox: zynqmp: Enable Bufferless IPIs for Versal based SOCs
Date: Wed, 10 Apr 2024 10:08:22 -0700
Message-ID: <20240410170825.1132324-1-ben.levinsky@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ben.levinsky@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|IA0PR12MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: 011aff1f-0f42-4688-3bbc-08dc5980d6cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ihOZtZ7h2jkJ3YSy5xea1QNoKVpZzpGxYA4vzk29L+9r2Sj89lwlKP73ccFfmy1qV9Noo5PVeXPTzkz0WKReGSa9dMOrs/0eQOwObnnz1o1djrCw/ODX1xfFVBa0Yn4Dmbqu1figUoIEio86DKSGnX8HrD2XRCwn8AvA66y9aUEKgvFsQAuwZlkx77LBF2A76EQHr4a+0qHLv3lvB7fcK6+pzVpfCbdAZPlaPw9QmFIVsOdhVN7v2UGjXxdNy+9gVCdhf7CIj9iL4d0aGHyTgZsT5iHlNghsMtDg/NrFX+K9BYmPgD5AeAFJYXoBze9o55L0wuwTRD7L4YmGYPeV/Pxh8Vm6rdnK8MnZgDuJjH2V1SFcL5h+rjUSQB+Q1WZKizxG7YQdMgEZQnpxSzoxrhvbyZ2n00RwhqvzYM8vY7qIEtpyIh/Pjgfq8jA7w8rc7XHgSXnF9z1c35yVAhn3CXgXjp8es7yIrkJQQwcDI1/rldt+663wXq+M9UhMtQLRjTPF7tDz8i6/mbObXFKPXoeUUcTzDkd7jYQyavypr3yczBHjyLMtwH0IxfZcwCUQJ1yeNtqZHN3H5/0SVSS2uGnOePUeaRBcR0Ch7GNFHl0xeN4Aqlb/YgHT3LsRTrvdNTjO+ZuL7WjgUDm77GlCsrp52pEI0t5GTR8itoaNKQOFN+fMW/wZ0hO7364waleyMoCGxJxZtoJqzpYldMp6N3VrXzWY19I3u73JQeMe84MGn1dobftKdPdYKeS/eePy
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 17:08:27.3265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 011aff1f-0f42-4688-3bbc-08dc5980d6cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7673

For Xilinx-AMD Versal and Versal NET SOC's there exist also
inter-processor-interrupts (IPIs) without IPI Message Buffers. For these
enable use of IPI Mailbox driver for send/receive as well.

This is enabled with new compatible string: "xlnx,versal-ipi-mailbox"

Original, buffered usage for ZynqMP based SOC is still supported.

Note that Versal bindings are already present in xlnx,zynqmp-ipi-mailbox.yaml

v2:
- formatting in 2/3 patch
- remove extra handling in 3/3 versal_ipi_setup()
v3:
1/3 - removed additional newline to avoid
/scripts/checkpatch.pl --strict -f drivers/mailbox/zynqmp-ipi-mailbox.c
CHECK: Please don't use multiple blank lines
#434: FILE: drivers/mailbox/zynqmp-ipi-mailbox.c:434:
+
+
2/3 - remove unused variable dev
drivers/mailbox/zynqmp-ipi-mailbox.c:565:24: warning: variable 'dev' set but not 
used [-Wunused-but-set-variable]
         struct device *mdev, *dev;
3/3 - remove unused variable dev
                               ^
drivers/mailbox/zynqmp-ipi-mailbox.c:666:24: warning: variable 'dev' set but not 
used [-Wunused-but-set-variable]
         struct device *mdev, *dev;
                               ^

Ben Levinsky (3):
  mailbox: zynqmp: Move of_match structure closer to usage
  mailbox: zynqmp: Move buffered IPI setup to of_match selected routine
  mailbox: zynqmp: Enable Bufferless IPI usage on Versal-based SOC's

 drivers/mailbox/zynqmp-ipi-mailbox.c | 257 ++++++++++++++++++++++-----
 1 file changed, 212 insertions(+), 45 deletions(-)

-- 
2.25.1


