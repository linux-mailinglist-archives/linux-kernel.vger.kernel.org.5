Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD21F7C7821
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442780AbjJLUvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347407AbjJLUvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:51:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2090.outbound.protection.outlook.com [40.107.220.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B61DBB;
        Thu, 12 Oct 2023 13:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+TJxiJnRcwJqumzJtujrWfUrsuxcw9KU1b3KhQmBrPMLSw0oFuoI/UIvCntJIccJ+9+sJmDDpeAk93cInIxvjjM05EBWqchtRYAnGH0CKLTOVfEMHoxZxCNyv8eOiJgagcYQu42McWrC9oNPHOJLmfXgKqY3SmbCgDXAFRIHhA204Gm2OIfNoKumZdtL8+anNY2dZ6gJ7h74cnAhQDb8KJtH1m/4NCoHsTvTrhE7vi45RTdblwwhi7OZKroHRAT4qe/W8uoJ28j2/5qcGPxMhubAGuzCpijvEEQCl1BHXxoXDIAVvZxrCeZRtwtt2ReeTXMFDiJn6FluGOByjOn3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VxahNJvg1fevmOR8fte5obsPgGZZs2bgPIUgAUdt6I=;
 b=F+ko3ooxvEIa34pw7qiB7ugkBAHKAPUnjYDyBSUu81Lmlodso+ZGnB4Sly4X96hNXWkmE3PqHWr6kOcXKvhkoOLEoywASlXAXWIlC0+aAOZ5XPa98TKH1WrAHAO+bUGu+jKZoQNR8vv8DqXYrHaIVhtsmEATI4d8sqZ9xKIyM5BTwGCEmvj7kcRSTjoVzcG7zuGMkzBa1of9Y1XtbuXS6xB+Bx7gVZqPrdyk3V0dTPB19iRj93NJV3JcIZ4b0R/3PVuAag3fBKlibK1gba2dLNueGqIK1EqL4PvrxOB0wU/L9X4emraxeV5FZ+Hc/zvauzA7WEYKUmK7vWj+QQQerA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VxahNJvg1fevmOR8fte5obsPgGZZs2bgPIUgAUdt6I=;
 b=JQ4nOJgBtMdqCp8jWf2cBuGwG3tvyqhkfTewJ2wm2KumyjrpuPHDmaghCKFVOrL9OMFQvy919+bB3HigUHp+Lx3T93ewkKjO7QXsWd48mNqijB0HYetUxXwzZ617PG06MZv4+D9FWu27OEzlNXAJxKn5ytZ2ziDOaJie5tXwfhM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ni.com;
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by DM6PR04MB6608.namprd04.prod.outlook.com (2603:10b6:5:1b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30; Thu, 12 Oct
 2023 20:51:39 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::3205:e23b:425e:a57]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::3205:e23b:425e:a57%4]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 20:51:39 +0000
From:   Brenda Streiff <brenda.streiff@ni.com>
Cc:     Brenda Streiff <brenda.streiff@ni.com>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 tty-next 1/2] dt-bindings: serial: ni,ni16650: add bindings
Date:   Thu, 12 Oct 2023 15:51:10 -0500
Message-Id: <20231012205112.112261-2-brenda.streiff@ni.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231012205112.112261-1-brenda.streiff@ni.com>
References: <20231012205112.112261-1-brenda.streiff@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::32) To SN6PR04MB4973.namprd04.prod.outlook.com
 (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|DM6PR04MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 0901a7c7-313b-45d0-2ae7-08dbcb6507f1
x-ni-monitor: EOP Exclude NI Domains ETR True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZKKE9ErvsQX93ufOa9xeNJ5MZ4K5TBMzgO0FKVqLe36U8I7tLN2ExYGpDAryjWp1aV4jS5+RlVpYSK9r8CFHsI9QwaRHpiCEx5zhKztMxBdPxeGOtDWEKW1Sx4/1FKtd6Fmli6WSqckDGMgaFj0d8xeiZpckZCFZyIBhLVrZk0sHJqvreNtqV4AuDsDrS/FzPHzFf+ZHp1LRWLG9WJqEfzy95TU97f62vY0i2mn0va1tW8IJrRZtdBbc+wOb2L/BtjaSIolJrhM/43gW+N1LhZZSEpM1UGhdtSAw2hEWvGkvChJ1A3lPll9hALEknDmaOpS25mUPFHDhfvEeyc/gjzK4DW8QG1ERiXwvf3PlBs1fqFJ5KabRlnw94KpojCyd08ZqY1CRRok83t+Q1x9l5+uxxupbZddcLkAungUwKGxgL/hsR5DxO8jw1hJZDOGYcLD7qHxldN77I/SJuC/zBAK4PSxwlQsu+c243Jueyw0ydYCRfu+fV0wkg7QxLGrZvLxTOG+Gbl0YE+2tu3GH6nDP8NXpjrZ7mqnyqNpo5J5zmY2UGGUv/VYWsS4GzlAoBP+jHm8PBtLJGDWFR6HZP/6DM7qkMNs/IJzvYn30mds=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(109986022)(1800799009)(451199024)(26005)(6506007)(44832011)(36756003)(316002)(83380400001)(66476007)(54906003)(66556008)(66946007)(2616005)(38100700002)(1076003)(86362001)(6486002)(478600001)(2906002)(6666004)(966005)(6512007)(5660300002)(8936002)(8676002)(4326008)(41300700001)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ihOg+f4gvWRwDtl6djwkovzhnVev/JZq5hI6lgfLQxBdZhhqqJ7jDRiR/s0?=
 =?us-ascii?Q?lMI66HE86nTZI2twNvMwlX9Y84Y2g1vDOpHApfrF4a3oX0GNHtthZPV/v6ar?=
 =?us-ascii?Q?NMPlXtEB1kRxxmC+aqGp+EZYr6eb8HXZY9wjzRT6AvvhPbB5xlw6kXKMDaY+?=
 =?us-ascii?Q?vLvNy2HhNJkehXQ5GbVrhdF+qHKiUVsiYm8mDl1XfFWshji0e6HQqkjNs4ov?=
 =?us-ascii?Q?eVh+RoruIRyZNJk424FaS5RG0qHkbGqeKXAguQM+9wXaIpm8NZ6iwYZs/AEf?=
 =?us-ascii?Q?SuB3+Pu67+IFz/5qWHFAGXK69uNKTsIdY/A7Zt2U0BD3qDFXYuZKMNJfv8g9?=
 =?us-ascii?Q?2/kqVQdudF9Pud/o/IbunHXTKoLjZC0199I5rzupEcHlDRVnU3WgwyK3bhsW?=
 =?us-ascii?Q?M3M+a5e5UW4S+2D6Ki4AQqfq/JTswnR3crEg9mKV8Fu1mF39UkmaiJur01Nk?=
 =?us-ascii?Q?R/2Xoef0rhcTyp6n0Q/m5jyZPJPQdIF3YgEv2yAHjAo9LkhFqZJKDTDtcQ46?=
 =?us-ascii?Q?eItjhy0n4ZTmRwgTj5jHbLpYmzIxWfkb3bNyvv7FwCBjTC3BagiEd4JfB7jO?=
 =?us-ascii?Q?nl5QBoF6broiSacIGVlBAAWO3SH4N8Nebr3rNs1BTlg4n7v3hk2ZANfImtca?=
 =?us-ascii?Q?p7TMSN04HgwNaFY23n2J8W7YeUCUjfVYoGlOJBFKLIzvmRiCCiz42eZU7wGz?=
 =?us-ascii?Q?W1fzhKW4ViMuRtVIGnCmZfd4t+07xYj6QbkwiSIUQ0HeGTnutPKt0XrEY3h2?=
 =?us-ascii?Q?muEPkXI//XN+2vPPYO30iVzlF8RLEmicgkCLBlT/EY05n6qXuBmEEfKjsYl0?=
 =?us-ascii?Q?e2XtWGQdxNRqwiJk9QktjxFG8gfvwJ0KhkvFPogs26+huDduNEgLYnB6h7bF?=
 =?us-ascii?Q?6TfwW9r09/qPqlEgfC9m9HDgkVIlAemDLSEKmx8KD4bsiQAxZDHWQMjzbJh0?=
 =?us-ascii?Q?g8PNhbOF1yRdVBWuQcoyoY39yZ6r1GiU7ZR9rrBksdAgX/fYZsKynTPcqrc/?=
 =?us-ascii?Q?hYoRIkA2R0A4lA9P1uTo+viOe5RxLCCqPzGFZ+M3puE+OvfJhmMSh2y8ob3i?=
 =?us-ascii?Q?lw1iSaLKWu1ip1F6kaKXLRSUD5VPj5NhXQVePI/MHtlLPNKcqOvVaB0qNIcG?=
 =?us-ascii?Q?hsb3G+wE8sfcCKEvuhysKUO0jZpJ2VZhgsHkOIZChH+Xwg0ViOQnIWQzbBbK?=
 =?us-ascii?Q?PkIJpBUd+ja+WUPDP3c5J/qbnPP5LZsvB4lPMp3pf+C/xfjduQbb1NoXE9ut?=
 =?us-ascii?Q?4FONtVXRhWzXSYBdTV1dVurvy7wsocX9DJtJd/SIZpmANLKYfjhzNbDHrLrO?=
 =?us-ascii?Q?4U5sSyBjRIJsdrJeBh7kia+8VDrDJJTFV99GT+WWhrF1gcnSjp4+ZjEgv1qU?=
 =?us-ascii?Q?mdjRAb3YwMPDyp6RzVoO5TDdCAdJXOHdFVwFxcp/n3l6YyKEoAlIMYPak0x3?=
 =?us-ascii?Q?HpyWBtjuZ/RaVaqPXiPZf1Jj+Ucyz2R02DB75zAy2WiSK1fu2PLuxp+6MTyB?=
 =?us-ascii?Q?eSR+EtWqvWo1wD5Jv9K6mp36JR/i6nzkvGoQSdO++fdI0s3uZJi8G11xGo64?=
 =?us-ascii?Q?p1EU5QHJp1XRPZmRBy5uFMr9WI4Pc6eOMZqgLGk/?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0901a7c7-313b-45d0-2ae7-08dbcb6507f1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 20:51:38.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qx6nxn3qu9VCnD+VtxDImTOkGbt1gl/95CtF017zBlZCgY9balJW6I5JtTpp0/wGMIn5UlMCZ0g8lsuBIMHuBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6608
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the NI 16550 UART.

Signed-off-by: Brenda Streiff <brenda.streiff@ni.com>
Cc: Gratian Crisan <gratian.crisan@ni.com>
Cc: Jason Smith <jason.smith@ni.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/serial/ni,ni16550.yaml           | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ni,ni16550.yaml

diff --git a/Documentation/devicetree/bindings/serial/ni,ni16550.yaml b/Documentation/devicetree/bindings/serial/ni,ni16550.yaml
new file mode 100644
index 000000000000..72ab125dd892
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/ni,ni16550.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/ni,ni16550.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NI 16550 asynchronous serial interface (UART)
+
+maintainers:
+  - Brenda Streiff <brenda.streiff@ni.com>
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: ni,ni16550
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  ni,serial-port-mode:
+    description: Indicates whether this is an RS-232 or RS-485 serial port.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ RS-232, RS-485 ]
+    default: RS-485
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    serial@80000000 {
+      compatible = "ni,ni16550";
+      reg = <0x80000000 0x8>;
+      interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&clk_uart>;
+      ni,serial-port-mode = "RS-232";
+    };
+...
-- 
2.30.2

