Return-Path: <linux-kernel+bounces-151394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C088AAE0E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2473B1F219C0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BED84A5E;
	Fri, 19 Apr 2024 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aLe47f7U"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DB67F49A;
	Fri, 19 Apr 2024 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713528358; cv=fail; b=OgSOkb7J36daUecvlf+hbmxhEcVZw3Tps3kbDSuddSXzgaDEbyq6zyTEh4Lwt+fP+xuR+jvM/qx4ZJdkOBH0ANkwZk+3z60rvnzyJbpRxoy6j/b52ZPvJQXmmPr1JptP7vYNCQ0IKwO8OQ6WzvYByXINvdVZOAFMtBIMGPuLbkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713528358; c=relaxed/simple;
	bh=YOoimxnrmOmT5utXcu3b82K7hDymYuF3WwTQlf8ML+4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IhBEx2ZNZCt/GumYyOyd1A6+9BlrncWEV/m6BS/41hDgwWZuJIUTr+sixav3tVqLI/KKskMk5PsLWclpUxiA0BKiCgp0ullzIEcGoyhbMyhTccKIH71exx0xHBzTMcj0XwIeWinuGxS4suWHGGDdOvqWFzhwNlZz2zW74R+u9s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aLe47f7U; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQjM/oalSws//rKNo0bVPzZMWh8ct8wmAnM1uvDFpiJajckdc9YNpQhNWC68viIGX+IotqwOFz7mQ7ZHN2ainAf7q+U0WjxmuWCZs0YZ0nip6ICQD1KdVGyYCbd4oDZgFT2bQg9WlcohuWod6tKOwzaUHCefTy7fAH3qzXEbSmnAiitoZgURpreK2TEWsjw1xUS+NQxwS6bXbvbJkp0dXT+PY/ICbeqxY3OnMr78G5YdQztL6yDT/IhDBn4ohg3YYt/b/Cki9Jtjh76cux3holu4jeILjlJ8UQ52yf67ttELBozvdUTCQuan7/ZGI96RYQZz7+t7wFfFh+OHKohLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MiY6ZvIpFk8RK1YVJr5KZrW4OtKtJo/c84nK26TEeg=;
 b=cW0zimoWjmOKctXNrc60BZL5AORWRaVPsuLrAsnxr29l41JB8vK4eCu9nlO4goGbA9auA2oxG4p8yUX9mYXOtjTY+n1LM8LsP690jJy6Q0FvBwViyL9DBuv+wWOIxX60K3revFIK9vaER5Yy5oOW9tZetokM8Uv7uzh1unhCStflTohzEwONkyqSrQUIG8CEu9ztnnnaBRlpMYPptkbDkwz/CPYcWjVGvn24ANJvTHmHFEaYO1aapBI6MzKcUhcXS9Ci2yoe3rWMMi08UNFziQJ5jstWcJb5cVUqHxwQh+J56x5xCgEkfzpW4MNXMIRno9JPGmuh8qNhZ2TXi7wtRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MiY6ZvIpFk8RK1YVJr5KZrW4OtKtJo/c84nK26TEeg=;
 b=aLe47f7UoH4KCkz+jE5e2OQrAGADvjXkqKiG6OLEwXh5VSLAR7EqnHakGS7ZnBDseaYDBego8ExpHw8u0BjNdihygh974dRpoWeD7nNC7osW+jFFZ6/sVK6xsOBtoIS+Y3d4IpwEeeq6TlCMcV6SqTRBHjWnWwdVjtMqJIXjYaM=
Received: from DM6PR02CA0104.namprd02.prod.outlook.com (2603:10b6:5:1f4::45)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Fri, 19 Apr
 2024 12:05:52 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:1f4:cafe::1) by DM6PR02CA0104.outlook.office365.com
 (2603:10b6:5:1f4::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.30 via Frontend
 Transport; Fri, 19 Apr 2024 12:05:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 12:05:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Apr
 2024 07:05:50 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 19 Apr 2024 07:05:45 -0500
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <p.zabel@pengutronix.de>,
	<laurent.pinchart@ideasonboard.com>, <radhey.shyam.pandey@amd.com>,
	<parth.gajjar@amd.com>, <u.kleine-koenig@pengutronix.de>,
	<tglx@linutronix.de>, <julien.malik@unseenlabs.fr>, <ruanjinjie@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <srinivas.goud@amd.com>, <shubhrajyoti.datta@amd.com>,
	<manion05gk@gmail.com>, Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH 0/3] Add support for uartps controller reset
Date: Fri, 19 Apr 2024 17:35:28 +0530
Message-ID: <20240419120531.3775919-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: manikanta.guntupalli@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: da9222e8-ffcf-4738-9aca-08dc60690f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4Je+1AxbBEPxUB1W/IWJlA8Y9TR5jh+ugvCFkJ7tFWOgyy+cLJoOKn0OIrqBabEuF/PRmm2Gayeoo6XDoVugcgBZ1zKVA8dqKW6lisR717qwXnt8wXwPYlM6tSO9uasgoAQpJvyr1FXNcsflYYP85hrexWOOPp1FX3ZwU+xniYqQbalzPetpAc9oDYEDjQAIwMzX8vh6HqO78Kyl4RyVTSn+Rz+0PMC25rcd8yuUWslVDIYL16gEojTyvY6dGfXvIa43bIS/uktCCsiJoxXuUZx9MNSkfRZlwciwDk7tQgAzVkG3N47wybTlSlDMkmbyvKSlv5+oFqGh6j0m80BwO0xZvNKH7Az54WdvYB8c3SslN7g3S14HsYnVmknNC7Z3v8HukwEDA5OVWy0FYs0uV4JGGJpftIFE8xC9zO2qLpivTYC6PZ0DdYQ8d2oX/l9DRYkS9Qmb7s9KyL/onmAsIRI0qKtz1jMIuR++mQXE7BjtNpw4EYgHhtWtui60Tofb6B2CLN+yRT4d23GDlHN3HxCWhyizuDWkKioWnw44RXHpUQ3qr1jVIkS9mnG0kncvzzndSbC3VI0w+3Kgt5+7JTZtnGAz68AamBQor0SJDSymhgK0Dw8nsWBzTELFcXmPOAi77Ptcu0WkbfiX4TDHmJXRUTVZktlzH+tjXwNjDa/OjY3D48xeLuXKjsd/iZkO6uyDq/XgJYpzxC/gYp96Xdiq3dyK4d71zDY/VjUgHov/vmyo5ndUqnFF6+cN3vuV+IzejNP+/GtTgdK/Emw8hg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014)(7416005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 12:05:52.1950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da9222e8-ffcf-4738-9aca-08dc60690f51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160

Add optional resets property for UART nodes.
Add support for uartps controller reset.

Manikanta Guntupalli (3):
  dt-bindings: serial: cdsn,uart: Add optional reset property
  arm64: zynqmp: Add resets property for UART nodes
  tty: serial: uartps: Add support for uartps controller reset

 .../devicetree/bindings/serial/cdns,uart.yaml   |  3 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi          |  2 ++
 drivers/tty/serial/xilinx_uartps.c              | 17 +++++++++++++++++
 3 files changed, 22 insertions(+)

-- 
2.25.1


