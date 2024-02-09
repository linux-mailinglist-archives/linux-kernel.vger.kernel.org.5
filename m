Return-Path: <linux-kernel+bounces-59874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C30584FCCE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCCD1F22013
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E3883CA2;
	Fri,  9 Feb 2024 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VEwRyFIx"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A2880BF2;
	Fri,  9 Feb 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506844; cv=fail; b=r5PkuIqMTet3nhXyvus7YY9XgX3+6n2bH1tHbqcayLp5NUBC/wKjzcBx0GknvkUuxHsJUas6kEN4oSwydKjafxILjBdSYE2qyTfRMCp+uvmJbMtezYBY8jleoKszJFdvc63x6S4/EHtQYuzg962HXestJHtxEhbpWdBOD+u81Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506844; c=relaxed/simple;
	bh=wz7P8kPKqdje7zUYjr8bN1xKtPvHTjkpSrNvqAoSSlA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AMLqursYgFy7A+Bg49drm/aujO9AsUD7rJ995AoUK59cGWGi54wXUOhXx4wW1+a+A7D7nRojOCG1hZY5ccnmyKCPK5jMTjXxTwZLPLqJDCzrSWsgs3TsXDZB4OOronVHrtnusspJxiQuzR/6jw8UkjxBjek0BlCqpS73FP3ZZJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VEwRyFIx; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OToSv4c2uxdlanz+nehpAwtYEDKKcvQiKovD6Tnu2nR22nS/t3SM9njLtXnwElht4zs8K2qP46do6ovyzhz3/6YBxZAIjllvRma8mupuzsc+YXF0W3PPafV3i+i/ResuNwIPLahT2Tgl0bEbY675/MIRIa3qprbPzJSSUwdFo4ImmyWzoCatZm8YaQR+TFU/RveBtpVz4dc64JLmn1ehqD8vLn7H/W3Ei4PpCUWfXHTHHKeHa8m4ZFEyqsJ8LvHnbbahBVWH2tM5QY13YEITtQtBxaVyGv3yBi81fjCKvXbnNOUGPlY8tONztauliaHy5mly6VMLvdZFrlWUxXe/Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsVVQUf9d0lHKkXn0GcEOFkLnkhB225LDg6KQ05Wmvs=;
 b=lvILH0gK4dGI9o4vrIib6erC1ldSLeVnBGwdIDA6CtxtUhLPBu9zUsy5X2ZYzOgS3NKETxjGOWJn2O2pQBAUowbxU89Q2XPQ2TNe0NzVLUya6Wx7YEm4+A2QXqiviWdIadWi6o0u6uDW/o7YgLN1ChzjCIdmrmdA1UGGhhLdl5S1a4mEiC5PQPzAKxzgMa/qw2rWhX5kPBDCB9g6ifp/z5Jgy3S/QUyLkrOtAweAWzU1RYItDEoqmlc0G4pQDdHvI3eCRcSXaBNvrW7LOhhP8FMMvM/p6+MxB1CekTqqhqlUMCvgzAOq+8Sl9EKWIL+qWakUv4gXi29LsnU5juqAIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsVVQUf9d0lHKkXn0GcEOFkLnkhB225LDg6KQ05Wmvs=;
 b=VEwRyFIxbToTeYTL3c/DeCMN6q19XgLjUybOqa9kDF0OWxTkd4N1NW9UJ9TQzYz37V697icfqJ4KecEVUYFYIeFhKBPdjLCNf0QdTbqvd2Ny67+ifg3ibYvSudJRqtIHeqyVy8y3UGT3N3e4GpdopCghRA7zW2zzcweKMAUVvBA=
Received: from DS7PR06CA0002.namprd06.prod.outlook.com (2603:10b6:8:2a::16) by
 CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.17; Fri, 9 Feb 2024 19:27:19 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::25) by DS7PR06CA0002.outlook.office365.com
 (2603:10b6:8:2a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.44 via Frontend
 Transport; Fri, 9 Feb 2024 19:27:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 19:27:18 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 13:27:15 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Richter
	<rrichter@amd.com>
Subject: [PATCH v3 0/3] CDAT updates and fixes
Date: Fri, 9 Feb 2024 20:26:44 +0100
Message-ID: <20240209192647.163042-1-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 8602a04f-e91a-4bb2-51bc-08dc29a521a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YOUkBp8hDHZ4L6vbYJlM9LdVLkFSOQDLChvDJjfX7e3N+e4YmpRls4FscAEUeAeSXveC9VCgYqpbN0eRGmRD8/sVwYBE7uQfaZYYzsluRnLYN8T62qfCsrf5rJ1EEG9NVnXu8PMc/WQgsA8Spq6vvqOv4xOuqHkYlHCxcsmoK0/XbI1eHW1eVvHRqyThfxdBrbUJ1trEZgJ9zhKHAn0ee8Ez8UheXh6HEfieh7IH7XqFl8vN0K9KKez3TE2jcEyIqypABUDL0vo5Ya4G2P0bKpM0myOBpW1wIMo8zC9lHfPIlFi1tEnoUfgbDQEVZWoL4yvdTXdMt1DdRjqdgvx4x2drkyvXSbv6P4ZGnBRljpnlDWEl9yZ9yMII9kd/dgUghq67x/l0gYEjNV3nypvD6kWE1DWP7p29ZLMqV/OEwOZU+aJhzl+MaWV5YzeF9LMKRtmgkkHELuTo05+w+2Q92uQEOnX2o50674FTPLw/1JmPxuFc7YlUCJrUKYl37T98S4+4895goUvExFgbZzr2TmKn1zw/FJfCZm35t2g1T+MX9HsQPuDd49DyAHjI/9zCM2pk29XPy662NsidG/WVfDJqP63A0YQUbKgeX8z3QZo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(1800799012)(186009)(451199024)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(70206006)(41300700001)(83380400001)(4326008)(6666004)(2906002)(110136005)(316002)(478600001)(8936002)(54906003)(7416002)(15650500001)(70586007)(8676002)(5660300002)(336012)(426003)(1076003)(26005)(2616005)(36756003)(16526019)(82740400003)(81166007)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 19:27:18.9786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8602a04f-e91a-4bb2-51bc-08dc29a521a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940

Some CDAT related updates and fixes. Patch #3 does not depend on the
previous patches and could be applied separately.

Changelog:

v3 (Jonathan's review comments):
 * added Reviewed-by tags
 * made entry_handle unsigned
 * updated patch decriptions for #2 and #3
 * removed zero-sized arrays, use variable size arrays as data buffer,
   introduced union cdat_data for parsing CDAT structs

v2:
 * rebased onto cxl/next (e16bf7e015d7)
 * renamed struct cdat_doe to struct cdat_doe_rsp and also local pointers
   accordingly to buf/rsp.
 * added comment that the CDAT table has space for a DOE header at the
   beginning
 * use DECLARE_FLEX_ARRAY() macro in struct cdat_doe_rsp
 * moved the rename to doe_mb variable into separate patch
 * added Reviewed-by tag
 * added patch: lib/firmware_table: Provide buffer length argument to cdat_table_parse()

Robert Richter (3):
  cxl/pci: Rename DOE mailbox handle to doe_mb
  cxl/pci: Get rid of pointer arithmetic reading CDAT table
  lib/firmware_table: Provide buffer length argument to
    cdat_table_parse()

 drivers/acpi/tables.c    |  2 +-
 drivers/cxl/core/cdat.c  |  6 +--
 drivers/cxl/core/pci.c   | 91 +++++++++++++++++++++-------------------
 drivers/cxl/cxlpci.h     | 20 +++++++++
 include/linux/fw_table.h |  4 +-
 lib/fw_table.c           | 15 ++++---
 6 files changed, 84 insertions(+), 54 deletions(-)


base-commit: 6be99530c92c6b8ff7a01903edc42393575ad63b
-- 
2.39.2

