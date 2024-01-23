Return-Path: <linux-kernel+bounces-34699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E836883864A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39FA6B21DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033BF1FB2;
	Tue, 23 Jan 2024 04:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ezwNYi7S"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520001851;
	Tue, 23 Jan 2024 04:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705983347; cv=fail; b=ajsxRbsUQ05qpDWrYubcW4cBwTtVFmVnf7fKZdo2P/HSoTuq5qJQ7hyiRbX+3PtG+QGgnyO2DOBrE9IM+omtPnHOE+EHjdbuNm3VejQjTBQk1N2rDb/RrwccocPqz9eaPBz+IwjrHrvgznEhWUJTK3KJ27RjnVcknZm32FL3TnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705983347; c=relaxed/simple;
	bh=31lhhI293ehkn19lDWSnDHr/axDpsZ/VwaDUq8EmYH0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P/YdmTutQ+P7qT6Jdrayy4l35CMySwMYudpq0opoORPK2ZaL1WI0JsEv7H8UaI2fkHzwva85Jxrn5j1qWikiV2AImfhScFlVJVKeMPx0KXN6UQLp0v8l6WyU2JyrTuqiZH4YZTgNcZa+xVWd2xJV5xzVPtsFQv2QPvK0GXbPFts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ezwNYi7S; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dasgu6lJBHNJ1qOn87AReDGz5YEQ6O8XOp6jGtbnMlP6jbQkGQxAvZrfPGZk8hvy2LCLsnz7fvOtFpXHg61MoU8qPhqns7AsvBNU7qCauVfJiMvAnk7BtB6Uw/oL8bivQsfR0PdhS13TG3YRx8uXv2Jmh49JHfxEBz5nms2j10sRf1anvaMeV7MnH9780OkhN6VhBTkNnLgTBaFO9loCjCW9Lftjrr2/ORp/E4Rf8jLSvijPwnLxzTsmLQtP1Mw/y3rDNXZdg7/LK7UeQ8TCpX6hTAyE4i2kwNQgQ2dGMDyU+mR3PFO2E8A9Dac6ZEydwonN2WSVCPuy1t5Jcyp5zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aezIl+bDvGPCz0CSokz9uDlyq3PfzUyZ6jdReLfXdg=;
 b=RwZ3PSbyMDjmd6G+q4HHnBgbgrw18rPgF3hDV9jnLPqytcu8JqW4r/ZyiCSte3cSrZ+oZBbetlescJ6LDxcZ6BpjkF9KkftMpPirG2uYnl3VBPpIHwWT3eXYs6UDe7ya//SLf/vfJlEN53G/hNvcU5zJXr5zeGOvQCDeSbIvv52xXHmjuBJ+wITkhhEbXHMwNXujFIJ3hxQSOwW+gsqbtCwe5ZEUQpTUWiKmeUokwKcpfUJrtbCpuM2NYR4DstXa1TdBGwTF9ZgTGq43/T/dLvfkQVyjF0DLgLPLuL/EWiZqLk6adlqncPhGtxFt3hC48ZF8lUBKEXeQu+M8j+r1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aezIl+bDvGPCz0CSokz9uDlyq3PfzUyZ6jdReLfXdg=;
 b=ezwNYi7S1wV1QiLmdr8Ia/vPa1gPTkhUiLQnVzKmz7S6UZE1CGs10/udt0sCSYqtOQXo3ZlnxLR8Qmd3Il0auYrke32X6ezB5GJgr9a2wGQl4Ruuv7inl9dbE/+bbQJlZDS3ItGhtbM2lPW7TjQW/6vc1qwIy6/UCwrDFhCfx/E=
Received: from BYAPR02CA0063.namprd02.prod.outlook.com (2603:10b6:a03:54::40)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 04:15:41 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::cd) by BYAPR02CA0063.outlook.office365.com
 (2603:10b6:a03:54::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34 via Frontend
 Transport; Tue, 23 Jan 2024 04:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 04:15:39 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 22:15:38 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <muralidhara.mk@amd.com>, <william.roche@oracle.com>,
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<christophe.jaillet@wanadoo.fr>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v5 0/3] AMD Address Translation Library
Date: Mon, 22 Jan 2024 22:13:58 -0600
Message-ID: <20240123041401.79812-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b734bd-f536-471d-aa5b-08dc1bc9f55d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eKaTKJeoFNwE4ZJPGk152zvWCL7mHw7cQqAStuDSTieZ1QoFeP7lcixXM2eODlcPDCjt0/MqquSxtvEY0hFEcjUh05jSgUvemapaCJi3AKPbp0cbb6fk///Ua2Fs89EGgZruzeYGLDyYVhAbmVH6Y7SOxG1rzuOI/RUZzWzNRSTllK4aXSMhdJHuRVhLn8s0fsG7J1SaVu1+oQq5xgnptMIP4tcCste+leiz44SYAqZ1BxTAFpvqoqfAj/Vm8w7kJZ6kgfxBPiqPsucvpPITUlVxwnv7qI8gZGoiiv6WNj2cRx7zUM7Cu+mqcvgJXNE0/+GozXIDeIjBro9GpI7sukEP/Gs2nkxt44127YkfYGa5EpzLeymjCHzkEm9bVAuha4Z7wn7PZpUSlRPodFbGgivoVuFHogI/M4ogTVR6P+XCyD2EzIunw1q4fxZb8sIzL4UfzHLh2WaKdSDxrP1ROk2zIBjlocDs6slaGsCerJOiDGgRU5yuyQodWyZ7cEIso5RVoJ16k6KRujrdO2MFtTwDR0XCpqULq0DO5fqwnGosH3pLBAZYcpvQxgrYA2RgkkHlz2kKdlJt6mPtoUQIwgl7plzupcoVw3R/HFVEE+3KjFxXmWBiXEEf8+L0L+2H2/5WwOBQWB0sjkQ+HFqZE8/j8yFxX3ih4r3J25jtOtFN7hX+VGC9BC7J8B2JryysdvK2El9QyAps+lylVZDyCWJ/TE5GACAl3mppgbzR8rAHGASD0LTvFq1L775VEGCUZEQuKxn0+eo8vI9gO60RXg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(40470700004)(46966006)(36840700001)(16526019)(47076005)(36860700001)(36756003)(41300700001)(86362001)(82740400003)(81166007)(356005)(83380400001)(478600001)(8676002)(6666004)(7696005)(8936002)(4326008)(316002)(70586007)(70206006)(5660300002)(110136005)(54906003)(2906002)(26005)(2616005)(336012)(44832011)(1076003)(426003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 04:15:39.7294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b734bd-f536-471d-aa5b-08dc1bc9f55d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358

Hi all,

This revision includes a few minor fixups from Boris, Christophe, and
John.

Also, it includes the definition and use of a new "struct atl_err" in
order to avoid build dependencies on x86 MCE.

Thanks,
Yazen

Yazen Ghannam (3):
  RAS: Introduce AMD Address Translation Library
  EDAC/amd64: Use new AMD Address Translation Library
  Documentation: RAS: Add index and address translation section

 Documentation/RAS/address-translation.rst     |  24 +
 .../RAS/{ras.rst => error-decoding.rst}       |  11 +-
 Documentation/RAS/index.rst                   |  14 +
 Documentation/index.rst                       |   2 +-
 MAINTAINERS                                   |   7 +
 drivers/edac/Kconfig                          |   1 +
 drivers/edac/amd64_edac.c                     | 287 +-------
 drivers/ras/Kconfig                           |   1 +
 drivers/ras/Makefile                          |   2 +
 drivers/ras/amd/atl/Kconfig                   |  20 +
 drivers/ras/amd/atl/Makefile                  |  18 +
 drivers/ras/amd/atl/access.c                  | 106 +++
 drivers/ras/amd/atl/core.c                    | 225 ++++++
 drivers/ras/amd/atl/dehash.c                  | 407 +++++++++++
 drivers/ras/amd/atl/denormalize.c             | 617 ++++++++++++++++
 drivers/ras/amd/atl/internal.h                | 297 ++++++++
 drivers/ras/amd/atl/map.c                     | 665 ++++++++++++++++++
 drivers/ras/amd/atl/reg_fields.h              | 603 ++++++++++++++++
 drivers/ras/amd/atl/system.c                  | 281 ++++++++
 drivers/ras/amd/atl/umc.c                     |  41 ++
 drivers/ras/ras.c                             |  31 +
 include/linux/ras.h                           |  16 +
 22 files changed, 3390 insertions(+), 286 deletions(-)
 create mode 100644 Documentation/RAS/address-translation.rst
 rename Documentation/RAS/{ras.rst => error-decoding.rst} (73%)
 create mode 100644 Documentation/RAS/index.rst
 create mode 100644 drivers/ras/amd/atl/Kconfig
 create mode 100644 drivers/ras/amd/atl/Makefile
 create mode 100644 drivers/ras/amd/atl/access.c
 create mode 100644 drivers/ras/amd/atl/core.c
 create mode 100644 drivers/ras/amd/atl/dehash.c
 create mode 100644 drivers/ras/amd/atl/denormalize.c
 create mode 100644 drivers/ras/amd/atl/internal.h
 create mode 100644 drivers/ras/amd/atl/map.c
 create mode 100644 drivers/ras/amd/atl/reg_fields.h
 create mode 100644 drivers/ras/amd/atl/system.c
 create mode 100644 drivers/ras/amd/atl/umc.c

-- 
2.34.1


