Return-Path: <linux-kernel+bounces-42678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9B48404D5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F680284561
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226DA604C6;
	Mon, 29 Jan 2024 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V+ZTDA1C"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B406027C;
	Mon, 29 Jan 2024 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530745; cv=fail; b=Y+yn2ihFjlhSgd+iUuEeG9TrI6lG4wGf1Ya8tFEnFjIiRCEMbl92Tsx6g9PAw1ILO/GyMT5QcQdvSqj2pkiWXtcvjnfmJaNJaZhQ6fY4ERh/ayOY8Omjk2Lk+5dS6G6c9e1Knw5lgVeHDUrEOI45fvahjQDmsVlrp19SThmQPLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530745; c=relaxed/simple;
	bh=sTxWHSbyH+rt6abaJ7o+J2HRq+TRG2WDnBdXT2JuQVA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=emrLxQxJybXjsMRg4jtLlqQHfjfv697mBTvDm2lNyKYg+nT51r+I0r/Idt3rLLN1avAG56/lNVV8aOZJs32GrOu6CKWOEdZec+WvdZQmItq6yQ3JxPu/z0A9mGIrEf5cEU44IctVa/ZuaA2Xd1na6v52vPlt613txkGOF688y5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V+ZTDA1C; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CO+Spom9Dr23aTjiOORGd8fBTlkrMv6VbTBAkg2gV8GhP6K4VEVvuSywlYYQXA+Yt/apVOYDA2YDjVTY9qe1EFR2Jr1F9yi/m6RozyGEfBSqlrlfbskguGWaXD++/07XftF41+yn3qYNn4FLXBPdMjCL+fxZ2FFpyvHvRlWJFUYW+bTHnA2cdaSj/sDpGqyQwwpD6wJVyIg46Ii2Jl0wFbcz15UL6NjwpSSMCO1QfPQo3gGGCGIMvTBzTkiz2H6hEdOI7QDzb0E4N+KZCPB21Xhu9ld1+Nzttalo3mxycxcLC2FsyzONJt/mdE+NTCIn+k3wZKI6HPPRryXYdvowKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBzIj9IJf2fszpRytBN1jn4MpSPoPBibBqOdI4cYBho=;
 b=fISP5vYW2TkbUq73sPE9M9FZnYo4st0jjPLrlT5rRlIMBHRgqEs9nEj2Vyb8jVVnj6v4/XFvVStF+pdmdtYYHCnxA+XvHhii1JR8c/UbpUp+3Yb08hpHxoKrKUvdl4x0o3etWLZChcXETNzV7PDz2HPDAWsmkpV0SUt5ZyymddYRor07T8Q6lifl+cbqPa8OVS8NV96GDCozCxde3UHGvUUxUuenKDY+L7aIZYVFFvCYfnocqjf7N5KfNETYNho1fVLbces0c57JfNYvso+xLqH10Zy5G2yQAxun70oGGloqEsXt0FgW3CZBMHdefe7wzHTjyLoYc4dBps04/aE/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBzIj9IJf2fszpRytBN1jn4MpSPoPBibBqOdI4cYBho=;
 b=V+ZTDA1CFTalJbih7oUGtWD23DfsNu6JybnEfZRJcmPYfckvz7H9VrO5Ktqaf+rOsE9S0LB8qEuRtS0cI48189kouL2VaU2McZHJOFp+hQTtp8IZWiJWc3PiMScznIG1ZOUN/PDCoSfZ3nCIPlhb0UAa0rl8pnPMCU+ScHiVKog=
Received: from DM6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:5:174::20)
 by SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 12:18:58 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::6a) by DM6PR21CA0010.outlook.office365.com
 (2603:10b6:5:174::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.15 via Frontend
 Transport; Mon, 29 Jan 2024 12:18:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 12:18:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 06:18:55 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Moritz Fischer <mdf@kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, Tom Rix <trix@redhat.com>, Wu Hao
	<hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open
 list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
Subject: [PATCH v4] dt-bindings: fpga: Convert fpga-region binding to yaml
Date: Mon, 29 Jan 2024 13:18:53 +0100
Message-ID: <37b107d86b39ef4bc9c482b57b27de8b92c3fa43.1706530726.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=34859; i=michal.simek@amd.com; h=from:subject:message-id; bh=sTxWHSbyH+rt6abaJ7o+J2HRq+TRG2WDnBdXT2JuQVA=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTt05e/LBJxkPZ65yzD+unhzdgup6iVSrctTpnZznuy4 t+RzalMHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiU1gY5ufeCTu0YFHpM5Hf RVsdOm/wqebxazDMz+O4Z/ZBoEfkX/rLm7885s52u15/EAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|SN7PR12MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab5084c-1a2b-481a-3202-08dc20c47860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EPoleo1ok6HWDv+kxVKjLez1suaEUPgxEiN0g3V1MwK/P7Ti4oTsjKNKBGvsZIO7NXO/X4J8YvyU2kRRUh2wpZMWcHUKXKsbKBsJpY2r2LcpvhBiqxLTFbm3xAWt34nFPhod+8Z/43A6ePteYZ/6iGFSATNtE/zmoBErD+TwTjlKLk1Dn5qPm66Zlr33Da8fzxBQLleaH2Lgjn4fhrO3Qc1ha+saM+ybtKVvl/c5VvpFfWnR0XUju8QmfUm/sZjZ5ceuO7D8mW8IiatFnMRVs9zsawxsBfdcwPtu29bsfKmTarX7mJTV8C2g2NWAulJYdombJL0mMSWYqI9SL4wvtxq4YZvh7nIhq8IPp2yYZUahCb32kgZhLHZvExlW9jglO0rScawdcMyEfNeezR5mAyw5pQPAErrSxfVIm6h24kf2mp+zuhdJjJcKtIfh05esK17jrKbrsUEu14+GfiDRqelmjWn+GpG71O3S8JhWSWmHRU7tmioDa+kZhrwK82QfeyWtfK2DL8SMz7dN3l/x1fwp1YPgxnKsrNgfDaU2JOCULld3dwV7h1tDfk+i4uAq9lKNvTOqVc4YabS+DXXlRGZbQVsdjfELDV1Uvm/8aT9iNXf0Uw4WukSO4MD5sN5o6o8UglIF4jFjeVcpah8WSOXvUwgF/uymRqAv/or5xdy04Hej7ZiNluV5EQ/oZjN7BTNkY1p0RyUTcU0A2js6VDZxj7K+8GPW2lwjlhrx/iEQdcGD/K2RZez902C7qCo75Lh3iPvbS6THr8wnmaINuEfJvrVxXGU2cnCmVc0JcukeS3EC820AIR9OGCRgL1d+
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230173577357003)(230922051799003)(230273577357003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(36860700001)(47076005)(83380400001)(36756003)(54906003)(316002)(70206006)(110136005)(70586007)(86362001)(15974865002)(8936002)(8676002)(966005)(478600001)(4326008)(26005)(16526019)(30864003)(2906002)(336012)(426003)(44832011)(7416002)(5660300002)(2616005)(41300700001)(356005)(40460700003)(84970400001)(40480700001)(81166007)(82740400003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 12:18:58.3141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab5084c-1a2b-481a-3202-08dc20c47860
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148

Convert the generic fpga region DT binding to json-schema.
There are some differences compare to txt version.
1. DT overlay can't be described in example that's why directly include
information from overlay to node which was referenced. It is visible in
example with /* DT Overlay contains: &... */

2. All example have been rewritten to be simpler and describe only full
reconfiguration and partial reconfiguration with one bridge.
Completely drop the case where fpga region can inside partial
reconfiguration region which is already described in description

3. Fixed some typos in descriptions compare to txt version but most of it
is just c&p from txt file.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v4:
- permit only object type as additionalProperties
- describe also optional reg/ranges properties and remove required
  #address/size-cells properties

Changes in v3:
- drop fpga bridge and mgr descriptions in example
- use additionalProperties: true
- use fixed-factor-clock instead
- fixed matching pattern

Changes in v2:
- Fix typo in subject
- Fix comment in bridge example
- Change license back to gpl-2.0 only
- Do not define firware-name type and add maxItems 1
- Make fpga-bridge phandle-array
- Drop ranges property because of missing reg property of fpga-region
- Also describe case with fixed clock node and axi bus
- Fix fpga-region names in example

Please let me know if there is a way to describe overlays to dt root to be
able to reference fpga region back.

fpga-region without MMIO access is also permitted that's why there is no
need to describe reg/ranges and #.*cells properties for these cases.

---
 .../devicetree/bindings/fpga/fpga-region.txt  | 479 ------------------
 .../devicetree/bindings/fpga/fpga-region.yaml | 358 +++++++++++++
 2 files changed, 358 insertions(+), 479 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/fpga/fpga-region.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/fpga-region.yaml

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
deleted file mode 100644
index 528df8a0e6d8..000000000000
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ /dev/null
@@ -1,479 +0,0 @@
-FPGA Region Device Tree Binding
-
-Alan Tull 2016
-
- CONTENTS
- - Introduction
- - Terminology
- - Sequence
- - FPGA Region
- - Supported Use Models
- - Device Tree Examples
- - Constraints
-
-
-Introduction
-============
-
-FPGA Regions represent FPGA's and partial reconfiguration regions of FPGA's in
-the Device Tree.  FPGA Regions provide a way to program FPGAs under device tree
-control.
-
-This device tree binding document hits some of the high points of FPGA usage and
-attempts to include terminology used by both major FPGA manufacturers.  This
-document isn't a replacement for any manufacturers specifications for FPGA
-usage.
-
-
-Terminology
-===========
-
-Full Reconfiguration
- * The entire FPGA is programmed.
-
-Partial Reconfiguration (PR)
- * A section of an FPGA is reprogrammed while the rest of the FPGA is not
-   affected.
- * Not all FPGA's support PR.
-
-Partial Reconfiguration Region (PRR)
- * Also called a "reconfigurable partition"
- * A PRR is a specific section of an FPGA reserved for reconfiguration.
- * A base (or static) FPGA image may create a set of PRR's that later may
-   be independently reprogrammed many times.
- * The size and specific location of each PRR is fixed.
- * The connections at the edge of each PRR are fixed.  The image that is loaded
-   into a PRR must fit and must use a subset of the region's connections.
- * The busses within the FPGA are split such that each region gets its own
-   branch that may be gated independently.
-
-Persona
- * Also called a "partial bit stream"
- * An FPGA image that is designed to be loaded into a PRR.  There may be
-   any number of personas designed to fit into a PRR, but only one at at time
-   may be loaded.
- * A persona may create more regions.
-
-FPGA Bridge
- * FPGA Bridges gate bus signals between a host and FPGA.
- * FPGA Bridges should be disabled while the FPGA is being programmed to
-   prevent spurious signals on the cpu bus and to the soft logic.
- * FPGA bridges may be actual hardware or soft logic on an FPGA.
- * During Full Reconfiguration, hardware bridges between the host and FPGA
-   will be disabled.
- * During Partial Reconfiguration of a specific region, that region's bridge
-   will be used to gate the busses.  Traffic to other regions is not affected.
- * In some implementations, the FPGA Manager transparently handles gating the
-   buses, eliminating the need to show the hardware FPGA bridges in the
-   device tree.
- * An FPGA image may create a set of reprogrammable regions, each having its
-   own bridge and its own split of the busses in the FPGA.
-
-FPGA Manager
- * An FPGA Manager is a hardware block that programs an FPGA under the control
-   of a host processor.
-
-Base Image
- * Also called the "static image"
- * An FPGA image that is designed to do full reconfiguration of the FPGA.
- * A base image may set up a set of partial reconfiguration regions that may
-   later be reprogrammed.
-
-    ----------------       ----------------------------------
-    |  Host CPU    |       |             FPGA               |
-    |              |       |                                |
-    |          ----|       |       -----------    --------  |
-    |          | H |       |   |==>| Bridge0 |<==>| PRR0 |  |
-    |          | W |       |   |   -----------    --------  |
-    |          |   |       |   |                            |
-    |          | B |<=====>|<==|   -----------    --------  |
-    |          | R |       |   |==>| Bridge1 |<==>| PRR1 |  |
-    |          | I |       |   |   -----------    --------  |
-    |          | D |       |   |                            |
-    |          | G |       |   |   -----------    --------  |
-    |          | E |       |   |==>| Bridge2 |<==>| PRR2 |  |
-    |          ----|       |       -----------    --------  |
-    |              |       |                                |
-    ----------------       ----------------------------------
-
-Figure 1: An FPGA set up with a base image that created three regions.  Each
-region (PRR0-2) gets its own split of the busses that is independently gated by
-a soft logic bridge (Bridge0-2) in the FPGA.  The contents of each PRR can be
-reprogrammed independently while the rest of the system continues to function.
-
-
-Sequence
-========
-
-When a DT overlay that targets an FPGA Region is applied, the FPGA Region will
-do the following:
-
- 1. Disable appropriate FPGA bridges.
- 2. Program the FPGA using the FPGA manager.
- 3. Enable the FPGA bridges.
- 4. The Device Tree overlay is accepted into the live tree.
- 5. Child devices are populated.
-
-When the overlay is removed, the child nodes will be removed and the FPGA Region
-will disable the bridges.
-
-
-FPGA Region
-===========
-
-FPGA Regions represent FPGA's and FPGA PR regions in the device tree.  An FPGA
-Region brings together the elements needed to program on a running system and
-add the child devices:
-
- * FPGA Manager
- * FPGA Bridges
- * image-specific information needed to to the programming.
- * child nodes
-
-The intended use is that a Device Tree overlay (DTO) can be used to reprogram an
-FPGA while an operating system is running.
-
-An FPGA Region that exists in the live Device Tree reflects the current state.
-If the live tree shows a "firmware-name" property or child nodes under an FPGA
-Region, the FPGA already has been programmed.  A DTO that targets an FPGA Region
-and adds the "firmware-name" property is taken as a request to reprogram the
-FPGA.  After reprogramming is successful, the overlay is accepted into the live
-tree.
-
-The base FPGA Region in the device tree represents the FPGA and supports full
-reconfiguration.  It must include a phandle to an FPGA Manager.  The base
-FPGA region will be the child of one of the hardware bridges (the bridge that
-allows register access) between the cpu and the FPGA.  If there are more than
-one bridge to control during FPGA programming, the region will also contain a
-list of phandles to the additional hardware FPGA Bridges.
-
-For partial reconfiguration (PR), each PR region will have an FPGA Region.
-These FPGA regions are children of FPGA bridges which are then children of the
-base FPGA region.  The "Full Reconfiguration to add PRR's" example below shows
-this.
-
-If an FPGA Region does not specify an FPGA Manager, it will inherit the FPGA
-Manager specified by its ancestor FPGA Region.  This supports both the case
-where the same FPGA Manager is used for all of an FPGA as well the case where
-a different FPGA Manager is used for each region.
-
-FPGA Regions do not inherit their ancestor FPGA regions' bridges.  This prevents
-shutting down bridges that are upstream from the other active regions while one
-region is getting reconfigured (see Figure 1 above).  During PR, the FPGA's
-hardware bridges remain enabled.  The PR regions' bridges will be FPGA bridges
-within the static image of the FPGA.
-
-Required properties:
-- compatible : should contain "fpga-region"
-- fpga-mgr : should contain a phandle to an FPGA Manager.  Child FPGA Regions
-	inherit this property from their ancestor regions.  An fpga-mgr property
-	in a region will override any inherited FPGA manager.
-- #address-cells, #size-cells, ranges : must be present to handle address space
-	mapping for child nodes.
-
-Optional properties:
-- firmware-name : should contain the name of an FPGA image file located on the
-	firmware search path.  If this property shows up in a live device tree
-	it indicates that the FPGA has already been programmed with this image.
-	If this property is in an overlay targeting an FPGA region, it is a
-	request to program the FPGA with that image.
-- fpga-bridges : should contain a list of phandles to FPGA Bridges that must be
-	controlled during FPGA programming along with the parent FPGA bridge.
-	This property is optional if the FPGA Manager handles the bridges.
-        If the fpga-region is  the child of an fpga-bridge, the list should not
-        contain the parent bridge.
-- partial-fpga-config : boolean, set if partial reconfiguration is to be done,
-	otherwise full reconfiguration is done.
-- external-fpga-config : boolean, set if the FPGA has already been configured
-	prior to OS boot up.
-- encrypted-fpga-config : boolean, set if the bitstream is encrypted
-- region-unfreeze-timeout-us : The maximum time in microseconds to wait for
-	bridges to successfully become enabled after the region has been
-	programmed.
-- region-freeze-timeout-us : The maximum time in microseconds to wait for
-	bridges to successfully become disabled before the region has been
-	programmed.
-- config-complete-timeout-us : The maximum time in microseconds time for the
-	FPGA to go to operating mode after the region has been programmed.
-- child nodes : devices in the FPGA after programming.
-
-In the example below, when an overlay is applied targeting fpga-region0,
-fpga_mgr is used to program the FPGA.  Two bridges are controlled during
-programming: the parent fpga_bridge0 and fpga_bridge1.  Because the region is
-the child of fpga_bridge0, only fpga_bridge1 needs to be specified in the
-fpga-bridges property.  During programming, these bridges are disabled, the
-firmware specified in the overlay is loaded to the FPGA using the FPGA manager
-specified in the region.  If FPGA programming succeeds, the bridges are
-reenabled and the overlay makes it into the live device tree.  The child devices
-are then populated.  If FPGA programming fails, the bridges are left disabled
-and the overlay is rejected.  The overlay's ranges property maps the lwhps
-bridge's region (0xff200000) and the hps bridge's region (0xc0000000) for use by
-the two child devices.
-
-Example:
-Base tree contains:
-
-	fpga_mgr: fpga-mgr@ff706000 {
-		compatible = "altr,socfpga-fpga-mgr";
-		reg = <0xff706000 0x1000
-		       0xffb90000 0x20>;
-		interrupts = <0 175 4>;
-	};
-
-	fpga_bridge0: fpga-bridge@ff400000 {
-		compatible = "altr,socfpga-lwhps2fpga-bridge";
-		reg = <0xff400000 0x100000>;
-		resets = <&rst LWHPS2FPGA_RESET>;
-		clocks = <&l4_main_clk>;
-
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		fpga_region0: fpga-region0 {
-			compatible = "fpga-region";
-			fpga-mgr = <&fpga_mgr>;
-		};
-	};
-
-	fpga_bridge1: fpga-bridge@ff500000 {
-		compatible = "altr,socfpga-hps2fpga-bridge";
-		reg = <0xff500000 0x10000>;
-		resets = <&rst HPS2FPGA_RESET>;
-		clocks = <&l4_main_clk>;
-	};
-
-Overlay contains:
-
-/dts-v1/;
-/plugin/;
-
-&fpga_region0 {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	firmware-name = "soc_system.rbf";
-	fpga-bridges = <&fpga_bridge1>;
-	ranges = <0x20000 0xff200000 0x100000>,
-		 <0x0 0xc0000000 0x20000000>;
-
-	gpio@10040 {
-		compatible = "altr,pio-1.0";
-		reg = <0x10040 0x20>;
-		altr,ngpio = <4>;
-		#gpio-cells = <2>;
-		clocks = <2>;
-		gpio-controller;
-	};
-
-	onchip-memory {
-		device_type = "memory";
-		compatible = "altr,onchipmem-15.1";
-		reg = <0x0 0x10000>;
-	};
-};
-
-
-Supported Use Models
-====================
-
-In all cases the live DT must have the FPGA Manager, FPGA Bridges (if any), and
-a FPGA Region.  The target of the Device Tree Overlay is the FPGA Region.  Some
-uses are specific to an FPGA device.
-
- * No FPGA Bridges
-   In this case, the FPGA Manager which programs the FPGA also handles the
-   bridges behind the scenes.  No FPGA Bridge devices are needed for full
-   reconfiguration.
-
- * Full reconfiguration with hardware bridges
-   In this case, there are hardware bridges between the processor and FPGA that
-   need to be controlled during full reconfiguration.  Before the overlay is
-   applied, the live DT must include the FPGA Manager, FPGA Bridges, and a
-   FPGA Region.  The FPGA Region is the child of the bridge that allows
-   register access to the FPGA.  Additional bridges may be listed in a
-   fpga-bridges property in the FPGA region or in the device tree overlay.
-
- * Partial reconfiguration with bridges in the FPGA
-   In this case, the FPGA will have one or more PRR's that may be programmed
-   separately while the rest of the FPGA can remain active.  To manage this,
-   bridges need to exist in the FPGA that can gate the buses going to each FPGA
-   region while the buses are enabled for other sections.  Before any partial
-   reconfiguration can be done, a base FPGA image must be loaded which includes
-   PRR's with FPGA bridges.  The device tree should have an FPGA region for each
-   PRR.
-
-Device Tree Examples
-====================
-
-The intention of this section is to give some simple examples, focusing on
-the placement of the elements detailed above, especially:
- * FPGA Manager
- * FPGA Bridges
- * FPGA Region
- * ranges
- * target-path or target
-
-For the purposes of this section, I'm dividing the Device Tree into two parts,
-each with its own requirements.  The two parts are:
- * The live DT prior to the overlay being added
- * The DT overlay
-
-The live Device Tree must contain an FPGA Region, an FPGA Manager, and any FPGA
-Bridges.  The FPGA Region's "fpga-mgr" property specifies the manager by phandle
-to handle programming the FPGA.  If the FPGA Region is the child of another FPGA
-Region, the parent's FPGA Manager is used.  If FPGA Bridges need to be involved,
-they are specified in the FPGA Region by the "fpga-bridges" property.  During
-FPGA programming, the FPGA Region will disable the bridges that are in its
-"fpga-bridges" list and will re-enable them after FPGA programming has
-succeeded.
-
-The Device Tree Overlay will contain:
- * "target-path" or "target"
-   The insertion point where the contents of the overlay will go into the
-   live tree.  target-path is a full path, while target is a phandle.
- * "ranges"
-    The address space mapping from processor to FPGA bus(ses).
- * "firmware-name"
-   Specifies the name of the FPGA image file on the firmware search
-   path.  The search path is described in the firmware class documentation.
- * "partial-fpga-config"
-   This binding is a boolean and should be present if partial reconfiguration
-   is to be done.
- * child nodes corresponding to hardware that will be loaded in this region of
-   the FPGA.
-
-Device Tree Example: Full Reconfiguration without Bridges
-=========================================================
-
-Live Device Tree contains:
-	fpga_mgr0: fpga-mgr@f8007000 {
-		compatible = "xlnx,zynq-devcfg-1.0";
-		reg = <0xf8007000 0x100>;
-		interrupt-parent = <&intc>;
-		interrupts = <0 8 4>;
-		clocks = <&clkc 12>;
-		clock-names = "ref_clk";
-		syscon = <&slcr>;
-	};
-
-	fpga_region0: fpga-region0 {
-		compatible = "fpga-region";
-		fpga-mgr = <&fpga_mgr0>;
-		#address-cells = <0x1>;
-		#size-cells = <0x1>;
-		ranges;
-	};
-
-DT Overlay contains:
-
-/dts-v1/;
-/plugin/;
-
-&fpga_region0 {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	firmware-name = "zynq-gpio.bin";
-
-	gpio1: gpio@40000000 {
-		compatible = "xlnx,xps-gpio-1.00.a";
-		reg = <0x40000000 0x10000>;
-		gpio-controller;
-		#gpio-cells = <0x2>;
-		xlnx,gpio-width= <0x6>;
-	};
-};
-
-Device Tree Example: Full Reconfiguration to add PRR's
-======================================================
-
-The base FPGA Region is specified similar to the first example above.
-
-This example programs the FPGA to have two regions that can later be partially
-configured.  Each region has its own bridge in the FPGA fabric.
-
-DT Overlay contains:
-
-/dts-v1/;
-/plugin/;
-
-&fpga_region0 {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	firmware-name = "base.rbf";
-
-	fpga-bridge@4400 {
-		compatible = "altr,freeze-bridge-controller";
-		reg = <0x4400 0x10>;
-
-		fpga_region1: fpga-region1 {
-			compatible = "fpga-region";
-			#address-cells = <0x1>;
-			#size-cells = <0x1>;
-			ranges;
-		};
-	};
-
-	fpga-bridge@4420 {
-		compatible = "altr,freeze-bridge-controller";
-		reg = <0x4420 0x10>;
-
-		fpga_region2: fpga-region2 {
-			compatible = "fpga-region";
-			#address-cells = <0x1>;
-			#size-cells = <0x1>;
-			ranges;
-		};
-	};
-};
-
-Device Tree Example: Partial Reconfiguration
-============================================
-
-This example reprograms one of the PRR's set up in the previous example.
-
-The sequence that occurs when this overlay is similar to the above, the only
-differences are that the FPGA is partially reconfigured due to the
-"partial-fpga-config" boolean and the only bridge that is controlled during
-programming is the FPGA based bridge of fpga_region1.
-
-/dts-v1/;
-/plugin/;
-
-&fpga_region1 {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	firmware-name = "soc_image2.rbf";
-	partial-fpga-config;
-
-	gpio@10040 {
-		compatible = "altr,pio-1.0";
-		reg = <0x10040 0x20>;
-		clocks = <0x2>;
-		altr,ngpio = <0x4>;
-		#gpio-cells = <0x2>;
-		gpio-controller;
-	};
-};
-
-Constraints
-===========
-
-It is beyond the scope of this document to fully describe all the FPGA design
-constraints required to make partial reconfiguration work[1] [2] [3], but a few
-deserve quick mention.
-
-A persona must have boundary connections that line up with those of the partition
-or region it is designed to go into.
-
-During programming, transactions through those connections must be stopped and
-the connections must be held at a fixed logic level.  This can be achieved by
-FPGA Bridges that exist on the FPGA fabric prior to the partial reconfiguration.
-
---
-[1] www.altera.com/content/dam/altera-www/global/en_US/pdfs/literature/ug/ug_partrecon.pdf
-[2] tspace.library.utoronto.ca/bitstream/1807/67932/1/Byma_Stuart_A_201411_MAS_thesis.pdf
-[3] https://www.xilinx.com/support/documentation/sw_manuals/xilinx14_1/ug702.pdf
diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.yaml b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
new file mode 100644
index 000000000000..77554885a6c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
@@ -0,0 +1,358 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/fpga-region.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: FPGA Region
+
+maintainers:
+  - Michal Simek <michal.simek@amd.com>
+
+description: |
+  CONTENTS
+   - Introduction
+   - Terminology
+   - Sequence
+   - FPGA Region
+   - Supported Use Models
+   - Constraints
+
+
+  Introduction
+  ============
+
+  FPGA Regions represent FPGA's and partial reconfiguration regions of FPGA's in
+  the Device Tree.  FPGA Regions provide a way to program FPGAs under device tree
+  control.
+
+  The documentation hits some of the high points of FPGA usage and
+  attempts to include terminology used by both major FPGA manufacturers.  This
+  document isn't a replacement for any manufacturers specifications for FPGA
+  usage.
+
+
+  Terminology
+  ===========
+
+  Full Reconfiguration
+   * The entire FPGA is programmed.
+
+  Partial Reconfiguration (PR)
+   * A section of an FPGA is reprogrammed while the rest of the FPGA is not
+     affected.
+   * Not all FPGA's support PR.
+
+  Partial Reconfiguration Region (PRR)
+   * Also called a "reconfigurable partition"
+   * A PRR is a specific section of an FPGA reserved for reconfiguration.
+   * A base (or static) FPGA image may create a set of PRR's that later may
+     be independently reprogrammed many times.
+   * The size and specific location of each PRR is fixed.
+   * The connections at the edge of each PRR are fixed.  The image that is loaded
+     into a PRR must fit and must use a subset of the region's connections.
+   * The busses within the FPGA are split such that each region gets its own
+     branch that may be gated independently.
+
+  Persona
+   * Also called a "partial bit stream"
+   * An FPGA image that is designed to be loaded into a PRR.  There may be
+     any number of personas designed to fit into a PRR, but only one at a time
+     may be loaded.
+   * A persona may create more regions.
+
+  FPGA Bridge
+   * FPGA Bridges gate bus signals between a host and FPGA.
+   * FPGA Bridges should be disabled while the FPGA is being programmed to
+     prevent spurious signals on the cpu bus and to the soft logic.
+   * FPGA bridges may be actual hardware or soft logic on an FPGA.
+   * During Full Reconfiguration, hardware bridges between the host and FPGA
+     will be disabled.
+   * During Partial Reconfiguration of a specific region, that region's bridge
+     will be used to gate the busses.  Traffic to other regions is not affected.
+   * In some implementations, the FPGA Manager transparently handles gating the
+     buses, eliminating the need to show the hardware FPGA bridges in the
+     device tree.
+   * An FPGA image may create a set of reprogrammable regions, each having its
+     own bridge and its own split of the busses in the FPGA.
+
+  FPGA Manager
+   * An FPGA Manager is a hardware block that programs an FPGA under the control
+     of a host processor.
+
+  Base Image
+   * Also called the "static image"
+   * An FPGA image that is designed to do full reconfiguration of the FPGA.
+   * A base image may set up a set of partial reconfiguration regions that may
+     later be reprogrammed.
+
+      ----------------       ----------------------------------
+      |  Host CPU    |       |             FPGA               |
+      |              |       |                                |
+      |          ----|       |       -----------    --------  |
+      |          | H |       |   |==>| Bridge0 |<==>| PRR0 |  |
+      |          | W |       |   |   -----------    --------  |
+      |          |   |       |   |                            |
+      |          | B |<=====>|<==|   -----------    --------  |
+      |          | R |       |   |==>| Bridge1 |<==>| PRR1 |  |
+      |          | I |       |   |   -----------    --------  |
+      |          | D |       |   |                            |
+      |          | G |       |   |   -----------    --------  |
+      |          | E |       |   |==>| Bridge2 |<==>| PRR2 |  |
+      |          ----|       |       -----------    --------  |
+      |              |       |                                |
+      ----------------       ----------------------------------
+
+  Figure 1: An FPGA set up with a base image that created three regions.  Each
+  region (PRR0-2) gets its own split of the busses that is independently gated by
+  a soft logic bridge (Bridge0-2) in the FPGA.  The contents of each PRR can be
+  reprogrammed independently while the rest of the system continues to function.
+
+
+  Sequence
+  ========
+
+  When a DT overlay that targets an FPGA Region is applied, the FPGA Region will
+  do the following:
+
+   1. Disable appropriate FPGA bridges.
+   2. Program the FPGA using the FPGA manager.
+   3. Enable the FPGA bridges.
+   4. The Device Tree overlay is accepted into the live tree.
+   5. Child devices are populated.
+
+  When the overlay is removed, the child nodes will be removed and the FPGA Region
+  will disable the bridges.
+
+
+  FPGA Region
+  ===========
+
+  FPGA Regions represent FPGA's and FPGA PR regions in the device tree.  An FPGA
+  Region brings together the elements needed to program on a running system and
+  add the child devices:
+
+   * FPGA Manager
+   * FPGA Bridges
+   * image-specific information needed to the programming.
+   * child nodes
+
+  The intended use is that a Device Tree overlay (DTO) can be used to reprogram an
+  FPGA while an operating system is running.
+
+  An FPGA Region that exists in the live Device Tree reflects the current state.
+  If the live tree shows a "firmware-name" property or child nodes under an FPGA
+  Region, the FPGA already has been programmed.  A DTO that targets an FPGA Region
+  and adds the "firmware-name" property is taken as a request to reprogram the
+  FPGA.  After reprogramming is successful, the overlay is accepted into the live
+  tree.
+
+  The base FPGA Region in the device tree represents the FPGA and supports full
+  reconfiguration.  It must include a phandle to an FPGA Manager.  The base
+  FPGA region will be the child of one of the hardware bridges (the bridge that
+  allows register access) between the cpu and the FPGA.  If there are more than
+  one bridge to control during FPGA programming, the region will also contain a
+  list of phandles to the additional hardware FPGA Bridges.
+
+  For partial reconfiguration (PR), each PR region will have an FPGA Region.
+  These FPGA regions are children of FPGA bridges which are then children of the
+  base FPGA region.  The "Full Reconfiguration to add PRR's" example below shows
+  this.
+
+  If an FPGA Region does not specify an FPGA Manager, it will inherit the FPGA
+  Manager specified by its ancestor FPGA Region.  This supports both the case
+  where the same FPGA Manager is used for all of an FPGA as well the case where
+  a different FPGA Manager is used for each region.
+
+  FPGA Regions do not inherit their ancestor FPGA regions' bridges.  This prevents
+  shutting down bridges that are upstream from the other active regions while one
+  region is getting reconfigured (see Figure 1 above).  During PR, the FPGA's
+  hardware bridges remain enabled.  The PR regions' bridges will be FPGA bridges
+  within the static image of the FPGA.
+
+
+  Supported Use Models
+  ====================
+
+  In all cases the live DT must have the FPGA Manager, FPGA Bridges (if any), and
+  a FPGA Region.  The target of the Device Tree Overlay is the FPGA Region.  Some
+  uses are specific to an FPGA device.
+
+   * No FPGA Bridges
+     In this case, the FPGA Manager which programs the FPGA also handles the
+     bridges behind the scenes.  No FPGA Bridge devices are needed for full
+     reconfiguration.
+
+   * Full reconfiguration with hardware bridges
+     In this case, there are hardware bridges between the processor and FPGA that
+     need to be controlled during full reconfiguration.  Before the overlay is
+     applied, the live DT must include the FPGA Manager, FPGA Bridges, and a
+     FPGA Region.  The FPGA Region is the child of the bridge that allows
+     register access to the FPGA.  Additional bridges may be listed in a
+     fpga-bridges property in the FPGA region or in the device tree overlay.
+
+   * Partial reconfiguration with bridges in the FPGA
+     In this case, the FPGA will have one or more PRR's that may be programmed
+     separately while the rest of the FPGA can remain active.  To manage this,
+     bridges need to exist in the FPGA that can gate the buses going to each FPGA
+     region while the buses are enabled for other sections.  Before any partial
+     reconfiguration can be done, a base FPGA image must be loaded which includes
+     PRR's with FPGA bridges.  The device tree should have an FPGA region for each
+     PRR.
+
+  Constraints
+  ===========
+
+  It is beyond the scope of this document to fully describe all the FPGA design
+  constraints required to make partial reconfiguration work[1] [2] [3], but a few
+  deserve quick mention.
+
+  A persona must have boundary connections that line up with those of the partition
+  or region it is designed to go into.
+
+  During programming, transactions through those connections must be stopped and
+  the connections must be held at a fixed logic level.  This can be achieved by
+  FPGA Bridges that exist on the FPGA fabric prior to the partial reconfiguration.
+
+  --
+  [1] www.altera.com/content/dam/altera-www/global/en_US/pdfs/literature/ug/ug_partrecon.pdf
+  [2] tspace.library.utoronto.ca/bitstream/1807/67932/1/Byma_Stuart_A_201411_MAS_thesis.pdf
+  [3] https://www.xilinx.com/support/documentation/sw_manuals/xilinx14_1/ug702.pdf
+
+properties:
+  $nodename:
+    pattern: "^fpga-region(@.*|-([0-9]|[1-9][0-9]+))?$"
+
+  compatible:
+    const: fpga-region
+
+  reg:
+    maxItems: 1
+
+  ranges: true
+  "#address-cells": true
+  "#size-cells": true
+
+  config-complete-timeout-us:
+    description:
+      The maximum time in microseconds time for the FPGA to go to operating
+      mode after the region has been programmed.
+
+  encrypted-fpga-config:
+    type: boolean
+    description:
+      Set if the bitstream is encrypted.
+
+  external-fpga-config:
+    type: boolean
+    description:
+      Set if the FPGA has already been configured prior to OS boot up.
+
+  firmware-name:
+    maxItems: 1
+    description:
+      Should contain the name of an FPGA image file located on the firmware
+      search path. If this property shows up in a live device tree it indicates
+      that the FPGA has already been programmed with this image.
+      If this property is in an overlay targeting an FPGA region, it is
+      a request to program the FPGA with that image.
+
+  fpga-bridges:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Should contain a list of phandles to FPGA Bridges that must be
+      controlled during FPGA programming along with the parent FPGA bridge.
+      This property is optional if the FPGA Manager handles the bridges.
+      If the fpga-region is  the child of an fpga-bridge, the list should not
+      contain the parent bridge.
+
+  fpga-mgr:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Should contain a phandle to an FPGA Manager.  Child FPGA Regions
+      inherit this property from their ancestor regions.  An fpga-mgr property
+      in a region will override any inherited FPGA manager.
+
+  partial-fpga-config:
+    type: boolean
+    description:
+      Set if partial reconfiguration is to be done, otherwise full
+      reconfiguration is done.
+
+  region-freeze-timeout-us:
+    description:
+      The maximum time in microseconds to wait for bridges to successfully
+      become disabled before the region has been programmed.
+
+  region-unfreeze-timeout-us:
+    description:
+      The maximum time in microseconds to wait for bridges to successfully
+      become enabled after the region has been programmed.
+
+required:
+  - compatible
+  - fpga-mgr
+
+additionalProperties:
+  type: object
+
+examples:
+  - |
+    /*
+     * Full Reconfiguration without Bridges with DT overlay
+     */
+    fpga_region0: fpga-region@0 {
+      compatible = "fpga-region";
+      reg = <0 0>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      fpga-mgr = <&fpga_mgr0>;
+      ranges = <0x10000000 0x20000000 0x10000000>;
+
+      /* DT Overlay contains: &fpga_region0 */
+      firmware-name = "zynq-gpio.bin";
+      gpio@40000000 {
+        compatible = "xlnx,xps-gpio-1.00.a";
+        reg = <0x40000000 0x10000>;
+        gpio-controller;
+        #gpio-cells = <2>;
+      };
+    };
+
+  - |
+    /*
+     * Partial reconfiguration with bridge
+     */
+    fpga_region1: fpga-region@0 {
+      compatible = "fpga-region";
+      reg = <0 0>;
+      ranges;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      fpga-mgr = <&fpga_mgr1>;
+      fpga-bridges = <&fpga_bridge1>;
+      partial-fpga-config;
+
+      /* DT Overlay contains: &fpga_region1 */
+      firmware-name = "zynq-gpio-partial.bin";
+      clk: clock {
+        compatible = "fixed-factor-clock";
+        clocks = <&parentclk>;
+        #clock-cells = <0>;
+        clock-div = <2>;
+        clock-mult = <1>;
+      };
+      axi {
+        compatible = "simple-bus";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+        gpio@40000000 {
+          compatible = "xlnx,xps-gpio-1.00.a";
+          reg = <0x40000000 0x10000>;
+          #gpio-cells = <2>;
+          gpio-controller;
+          clocks = <&clk>;
+        };
+      };
+    };
-- 
2.36.1


