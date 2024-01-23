Return-Path: <linux-kernel+bounces-34758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9144683872F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41533286368
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53295024B;
	Tue, 23 Jan 2024 06:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xh7oJ3Ju"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4316DF9D0;
	Tue, 23 Jan 2024 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990638; cv=fail; b=sgvEruXUQutMqWYrFo8RYNF6aNyK2Wh87pa1s21ya/5Up0LFsueL71A8TaO5H/51UqFfhb9Tf3VGuBJvpF6Fec1L2gB7MxpgKZzW1iuQjZnjimYiuIZeR8uDHQ5Fl4pzmsU1J3qs1sLOf5FLS5v9STGcs4YqpVvnDwuMiiGnW0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990638; c=relaxed/simple;
	bh=4OwkiFTKfXtmoq8NqEuQJVyRxvP9s2jA2pL7wSOqEXA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DwxYk+HGpyAxnZ4WvD285GsklTX7v3Azb3JMi2GNA7vkMxMOA1EPq+yWEuSIo7MfHaNA2aqqX/xWMPkqWCOXD7xb/pcw70zsoIAgqGiROqFf6bRInk/Dg4OTxb5ePgMYBcqI3gYmoYC9UPjrInTFrD6NPSV4xJ1dSf7D/GmjHnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xh7oJ3Ju; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9Amo8rRRLbkbYBRRnP0dikPXg1gMKxJVRsRWX28cwgTqWW5LZ1YqnOdtUZbKjAS+KiZvmWT5FXmz3cbkqmSW5YNUSiF2oPduaHEiMRghkUyCu4tqZbrKdnD9xLBWad+wDNTxEredkUu2crvD/ekiSf46KEwgemvQI6yqr9engMHZI9SM8ww9Ygm2MjT5kJM1+65dbtZy1+/y7fNVWA9yhwcpShhjkk7dz4/m6RFr8BWBGoti8JgidciaYF1g4aq8p+q5bfpkAVgK2XksT84WMosINwvZSFrkhpJcHRUans7VhvRAr3TjJpdNmNNS8FIF3O7ZuAumq98hOCAS0L2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PA1aD0YJw7u7j3pNRPPmolxS1yT7nZYzZ3gDtHEmY+8=;
 b=f1tZGjmFGNOQV6/S8us5VFft3EXyF/YcZldl+3zlmA0A4G2K57f+X0MBERTxPlFEDMkaxrNZIUgIaeWNVPoy8kJQ9dqQkRhXtxdoljgzHVkjQ0X35SS2Oo8MauOOPlZ3k2VgbLSRCWEmXFEKcuFB8xJHZJ2Pki2OnYleUyIW192G/60/22+yoIzgcBgNiXjhCGGIsl0wckp5T6jzu7Xrl8c3usTsxLfp0WwTRc2LbVqqiQ/dPUJy5s/Vq/n+ixbf/484srkArvwBVZkHhV+yDGEj09g3bFvfMQ6qJ64g+Nz7WFZBEoT0uHWu5uCFQ042kRkNKY0praIOaMAUBhbVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PA1aD0YJw7u7j3pNRPPmolxS1yT7nZYzZ3gDtHEmY+8=;
 b=Xh7oJ3JuaDxtMe5oVDYpDOIJi0M79upk6/yutEjhqepOO7k0Aoo9xNow/8T3bjMXqDYBGuRg3538j53+FMzZ7rq6QKD3fa4A963DPjf8j+wa+UK5Ka4K0FR7sm9AOcHHL9Ggn0xGPwcG3AV1XaC3lxnsiJZNzwFslkL4jxnqp5E=
Received: from PH0P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::9) by
 DS0PR12MB8766.namprd12.prod.outlook.com (2603:10b6:8:14e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.32; Tue, 23 Jan 2024 06:17:14 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::b4) by PH0P220CA0021.outlook.office365.com
 (2603:10b6:510:d3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Tue, 23 Jan 2024 06:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 06:17:13 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 23 Jan
 2024 00:17:12 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 22 Jan
 2024 22:17:11 -0800
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 23 Jan 2024 00:17:07 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>
Subject: [PATCH V10 0/3] Add rs485 support to uartps driver
Date: Tue, 23 Jan 2024 11:46:52 +0530
Message-ID: <20240123061655.2150946-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DS0PR12MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: aa51a590-652a-404e-ed5c-08dc1bdaf0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cmSAlzg0hPGJI0UDJT+CYL1zTrZqMwDMaP4wM6BQB/f1dEwK9qECt/Wr7Z7V3zATr6t6DoJZSxvHvLIFKTyOfllrXeCzE3G3Hel4WaRtA1oRS9pbMhBdmbqKif9R+8j61Gm1TwCl8KsrLRZchWUZeaxHcsk0mR/RB4rU7z3afo8z3zv3BSCCHLpPw91w0bY+8KLdfgVrq97KYhg6j8j/6/seZi6cW7p4308hDjMdeL0NTw70330kzwrxuYLuC45oWSiqB4YQAF4+LzJfrA/9D4KvbUxSHDdwsLLEnd7aT590Fkg13tUvS2GRgmisMZ/gJxrYmYx/r52sUxVLcXlQLeVzqZmHBwoO6/A5TLMru6Df9emHpaJaxjxqU0MqWqOkoZdLKVWjv9wSnv+U1DiClHrN1B1fV7fkrIpbbF84W8ML1xK0OhjQ4FHrwiaWzOG7yhMkJ7wX/mMr/wTAs4SnfLsm/N9/MYA93h9ysIhLskIf8qkzFFFsPQmEeY2oj756q00OIYsw8yCg3k5QmileAOQqwMV+ynssz/zAnqfoSuh1wNbteBmrMstXt6tsJ5dUiJ5nKx2IMF8TNwi0AE6vEpy0JBeChDXguFJP85Nr21/iPN4U6g8R9i0FaK6R+UZ0weyeOE7xLeEc02K8zDac0ZlvcF28jSOcE0XUHufZshJoZMb1ONQr7SsYalhxO7K4ACNM78tx/A8CQZN3xJVeDzy9W9TvUsSo9P0LTmV+mEvNJFSBhaKGjZH/vkhymldjVdLpwIzOpkLmixm+nfK2i0UvLK0KntIF/jmLSl2v+00=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(40470700004)(36840700001)(46966006)(8936002)(8676002)(4326008)(44832011)(7416002)(2906002)(70206006)(70586007)(26005)(110136005)(316002)(5660300002)(2616005)(336012)(426003)(1076003)(54906003)(36756003)(86362001)(921011)(40480700001)(40460700003)(6666004)(478600001)(41300700001)(356005)(82740400003)(81166007)(83380400001)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 06:17:13.4548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa51a590-652a-404e-ed5c-08dc1bdaf0b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8766

Add reference to rs485.yaml.
Add rs485 support to uartps driver.
---
Changes for V2:
Modify optional gpio name to xlnx,phy-ctrl-gpios.
Update commit description.
Add support for RTS, delay_rts_before_send and delay_rts_after_send in RS485 mode.

Changes for V3:
Modify optional gpio name to rts-gpios.
Update commit description.
Move cdns_uart_tx_empty function to avoid prototype statement.
Remove assignment of struct serial_rs485 to port->rs485 as
serial core performs that.
Switch to native RTS in non GPIO case.
Handle rs485 during stop tx.
Remove explicit calls to configure gpio direction and value,
as devm_gpiod_get_optional performs that by using GPIOD_OUT_LOW argument.
Update implementation to support configuration of GPIO/RTS value
based on user configuration of SER_RS485_RTS_ON_SEND and
SER_RS485_RTS_AFTER_SEND. Move implementation to start_tx from handle_tx.

Changes for V4:
Update rts-gpios description.
Create separate patch for cdns_uart_tx_empty relocation.
Call cdns_rs485_rx_setup() before uart_add_one_port() in probe.
Update gpio descriptor name to gpiod_rts.
Instead of cdns_rs485_config_gpio_rts_high() and
cdns_rs485_config_gpio_rts_low() functions for RTS/GPIO value
configuration implement cdns_rts_gpio_enable().
Disable auto rts and call cdns_uart_stop_tx() from cdns_rs485_config.
Use timer instead of mdelay for delay_rts_before_send and delay_rts_after_send.
Update cdns_uart_set_mctrl to support GPIO/RTS.

Changes for V5:
Remove rts-gpios description.
Update commit message and description.

Changes for V6:
Update commit description.
Disable the TX and RX in cdns_rs485_config() when rs485 disabled.
Hold lock for cdns_uart_handle_tx() in cdns_rs485_tx_callback().

Changes for V7:
Update commit description.

Changes for V8:
Use hrtimer instead of timer list.
Simplify cdns_rs485_tx_setup() and cdns_rs485_rx_setup().
Update argument of cdns_rts_gpio_enable() in cdns_uart_set_mctrl().
Add cdns_calc_after_tx_delay() to calculate required delay after tx.
Add hrtimer setup in cdns_rs485_config().
Move enable TX Empty interrupt and rs485 rx callback scheduling part to
cdns_uart_handle_tx().

Changes for V9:
Update return check with uart_tx_stopped() in cdns_uart_handle_tx().
Update description of cdns_uart_handle_tx() and add clear TX Empty interrupt
comment cdns_uart_start_tx().
Remove stop tx timer.
Remove hrtimer_cancel() call from cdns_uart_start_tx().
Handle gpio case separately in cdns_uart_set_mctrl().
Move hrtimer_cancel() call from below to above in cdns_uart_shutdown().

Changes for V10:
Add disable the TX Empty interrupt comment in cdns_uart_handle_tx().

Manikanta Guntupalli (3):
  dt-bindings: Add reference to rs485.yaml
  tty: serial: uartps: Relocate cdns_uart_tx_empty to facilitate rs485
  tty: serial: uartps: Add rs485 support to uartps driver

 .../devicetree/bindings/serial/cdns,uart.yaml |   1 +
 drivers/tty/serial/xilinx_uartps.c            | 236 ++++++++++++++++--
 2 files changed, 216 insertions(+), 21 deletions(-)

-- 
2.25.1


