Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28D77CC151
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343726AbjJQLAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbjJQLAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:00:21 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEE7EA;
        Tue, 17 Oct 2023 04:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sy1olJNOhmDHRBOhus44YvgfCURDJ8BkBmXgF5EyUwn05arVsyDHwZVQf5qTGcfNveYe3dWV9BcjT5SWFufnyVGL58sv/jDcy2vaoDSR36rlB56iGmxXiaMDhSgEc6kwfDrD7CprQ4sfv99Map6oOUFe8W2stgP6ptHMKzHFxr/aUAZ0CuW0Osv0cIVzpN/2ezFuqwNhWcWuzAfIypkPgXCa9Cft+xOLd8FFdoVqFbBWLsslqUY8v5JgTvMuho6LGAe+X+98ZV4FzACbg1yHB3evvED8ksIB5MSk86oJAxYhmQQZbBwsqTw4PZ3rElE9RJ6nC6aXDh+396cUq/Xezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJEi3vJTduqpwezb9xJhU4ifPF+ITuUK8LQovSBDtjI=;
 b=h6zi0FlKCBmQpU1KBuQ6OiIqS7JIINA3sT4Os/aYdv1Nh+E9ckAcclvUgYhgCHlZj3uAkLc1PwFs91mKSaxA/Cf3iPjFLhvgUSgfYa6qSd0I2myjZhowaOLzfQptF5sHn4ZFVaSvY69rWd3rg8LJh873CclEG+MBylyxV6duh0KW8ak2hUvjATA/QwA8aA56oviG8C5f9Qb+DILac/B2Sj8xZJDZI8iL7AgJoM5qaadKdF8MXcg3XGhTU35bRsPwVvtQr8FBa1nxXP6KCrAccKxvP4r4wjwpPZ/YFzAdYhDRo/clDpxUSqc24zYcxHdeSfSOItg9VcvK16euokf5NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJEi3vJTduqpwezb9xJhU4ifPF+ITuUK8LQovSBDtjI=;
 b=nBYptv/IjX+ZInccxbjyVS1XcywJEfJSC79fxvlYFQfl+J97PCtKrT7VmqPGmB1+E8SA0vEZHsbXfJpZEMTBm+gTxuLXKwvZLopsLoDMsCDBZWO+urA3i91eaR/jIjZ6LSQgLyVHW2QMEVlGBrDRVlNe9U2A1/XURr1toFSbuGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB6295.eurprd08.prod.outlook.com (2603:10a6:20b:295::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 11:00:14 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 11:00:14 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Tue, 17 Oct 2023 13:00:07 +0200
Subject: [PATCH v5 1/4] Input: touch-overlay - Add touchscreen overlay
 object handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-feature-ts_virtobj_patch-v5-1-ff6b5c4db693@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v5-0-ff6b5c4db693@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v5-0-ff6b5c4db693@wolfvision.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697540413; l=13918;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=qqwR/kVL/sYBH0UecdndEJ2NdLb3YcmcKBDR3n9upRE=;
 b=x37HELZ1xdHJkxwJd6Atm9hDaBs3yJWMpyRpcia9Yz1XStauFQqcc0A1QrqNeg1he36APZDg/
 ZyVFcebCV1nAIlKguXz7Z7oxcCPgR1OhsK6ovF8DPCQbhhlh8Qv75Nl
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR07CA0250.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::17) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce8f732-03d9-45e6-e69a-08dbcf003d81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJdf0Hkaftpq/D3rwJLoFPwnLFyQY6koaFvJPYdLXv8G2k7RpaQdfnOiENzn7A2Cxy38GkEoG601+UUM660pzQa7vBEp+90101jnFMfNmKyL1BUBLCKu46LezitrO5/lk1pCZspk77ooSXMU2uWdy3BC6EFrleSE41Y5/sik4paY/Di46D264VKrbX9eDAqLT8Ak3OxsUvz3FnwUkn6hQtF8hTLIL8zb8ICN+KlrXhexZYl3zzWhdD3mVDdTvb+tulx169zyP0i9VjSpqfzhbNvb5yFf9Ow0XwaiKolGM9ZPlNj030KwJM8lAqd+G/vOVwe4C7UU6ZAgTIuFZ7qoxvPCakkFoy/27JxtnlX4hLxfh3QAxe/BK0Gzpvi7Owy5mkBZHSdwKi1SOWmha+tcFlUtt4jBIJQUbZUv46aO6VAFLRXcl71pjE00QzjLDjb6gsf6pluWx4A5Y4WKsn3WkkJKX8MQjOrwr4+4QFUxbPD3hCgw4yeNsY2HEGuJAkG5Xol7Q9wHjiJSVb84c0K+7Pkm/2ny1rDrqXVl9M0v1wu6BdsiEV9LPNm1sAc34WRwzatJT+J9RrAgKMMUdI8kbQrbIqQ8tpVo14B5gm5ZfbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39840400004)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(107886003)(478600001)(38100700002)(52116002)(6506007)(2616005)(6486002)(38350700005)(83380400001)(26005)(966005)(6512007)(6666004)(41300700001)(44832011)(5660300002)(4326008)(8936002)(8676002)(316002)(66946007)(30864003)(86362001)(110136005)(2906002)(66556008)(66476007)(6636002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qi9HU3UvQ0ozUmRXQkdtMitmb1dtWkFhK0hLc3pGeEZadXUxaWxYdGNxWWxY?=
 =?utf-8?B?TWdidzF4N0VTdFFXQWtuRGhwekJvQXB1R3FOempCbFpiS0g0QldmZjNXNnZa?=
 =?utf-8?B?NXp5cCtQZmxZb1lIaVZrRUhZRFRVRGwxTnhtWm1ncWdpcnRJZGRqNkxiUUFy?=
 =?utf-8?B?TUEwUkJmTTVxbm5xRHQyU2pyUzN3NHhKYnZRZmxPM0JZNFYydG9ZKytGYkpH?=
 =?utf-8?B?eHNHd3ViRXM1dytvcmUvcjNJRiswRU1XN3lPa2NnaEZyNXNRN2s0Y2tMaEdy?=
 =?utf-8?B?MlRld2ZadXN4WlA5d2luSGNwT016YU45WC96STBTaGtTMTJtQVBPUFVTWFlR?=
 =?utf-8?B?QnE3QkVjcVhwdi91T3QvNHJkZlNkWDF1aG5iNktHZE40ODJ3UjVrRW5DV2x6?=
 =?utf-8?B?cWxHZjk3TjV0VVZnU0pkU2NlOFlMMUlDTVgvbDU4N3VSK0ZsMDZmbTBQdGVu?=
 =?utf-8?B?VURDTkM5WXFPdENXKzk4ZEZvakhrWGdTM1N4NkIxOWE1THFEV0txa0EyQ256?=
 =?utf-8?B?MThUdFA5SWNxWEVSR25yNDVXSUZQdXNaQ0IvcnRMT0p5TVdORjNneURxaTBL?=
 =?utf-8?B?Z2RKVFM1NVVtN09KdkhMWUFIQXNRdjRBcExiUGl6c01tNUloTVdHL0JPQkNs?=
 =?utf-8?B?alVIZFUvSnpJZEdYM3VsMmlrUElZTlJ2Q3h2ZUY5V1R1TGJYdlVCcnpmTGpw?=
 =?utf-8?B?Z0Z3VCtTY1hxRy9NSURGNmIyNjJybUF1eVU2TGVBYkJMcDdUeDJlU1RlWFFM?=
 =?utf-8?B?SG5jY0h2cmlrYU90bzF2ZEwvUnNXUDhHQ1Zyd09qZ2FHYjdjK0cyT1k2SzJw?=
 =?utf-8?B?K3U3MmFGeW9DMjVaTlRaanhSWGt3bFZXQW91UlA3VzlpTW1sWWZrRHNydjV1?=
 =?utf-8?B?b2VXWTFlcWpTY2ZjRFFUcVFiS09RcW80dnJ3UytjNSt3Ulh2Y0NWZE1NZDR0?=
 =?utf-8?B?ZmZYV0xyeG5qd1R3dlZwYzhHN0NNM3VUNzV2YmlSczhmTkxtNjdFQ3RscS92?=
 =?utf-8?B?akZNSGIxNHZaM2lDN2puajhJN3pWdk9mdzRDcFFYN3JhcmowZ3ZhR3NjR2FB?=
 =?utf-8?B?VXRvazZ6cmhxYUwyV0tUOEc4YnJWVnVkRHJZM0dVWG1pSTNNZ0cvblRWanRK?=
 =?utf-8?B?VVR3L3lXVEtPc0dNVmU0ZUxkUXEzU2ZLYldJS2Vhbk9SYW4vbVowa1VtUzJG?=
 =?utf-8?B?dnVOYVlETXlPamg2b0NPQWw4dDhNN0pjVWJncyt1MmcyN3h2dHNqTWxSZ2wy?=
 =?utf-8?B?MUNpZHhxTDVSMFdETFZTMXBvZGR6blovbm1OazMvdzdDRjZoZFhJcGlFTHNH?=
 =?utf-8?B?aEYwQ3Vsb05uZzN5aXl5cGJXdEVYa3ZaZUVGSFhmNmwxSnl6dkg3di9qTlNY?=
 =?utf-8?B?VVlrcXNXUSs2aWExZWszZmNLSnlZa093R1QxalFyZkhYWldxbjZhVTFXR3RP?=
 =?utf-8?B?ZGhCNUVOK3I4MnlTQWV3OXAwWXl5VHRLKzdmbFdhRXhVSHkvOWVuQ3crQnFH?=
 =?utf-8?B?cFd2R2VUVDZIVUN1QWNBcVY5alFoOHVQckkveS9XZGVqN0RFTGJlRHo5Vmpw?=
 =?utf-8?B?SkNZQUtldVBDa2FKNzhSS0ZQbnhpVW1URnNyNnNMeXJPay9uV3hIN094em11?=
 =?utf-8?B?b2RYTXc2ajRnbHVsb3NZaGY1VkR0cnZJUXlScFJVdnUwbmZzaEJoK2plbWox?=
 =?utf-8?B?WXpvaktiZVZubHVPaWN3RnF1TndIUlk2MVhOL29Yak9iaFdYSjQwUFFlWDhV?=
 =?utf-8?B?YVhJcDhhZmExM1RzN1VjdVV2NHo0eTg0VklOdHoxaThaakJaSEtnWEJScU93?=
 =?utf-8?B?cDRQUDIrcFVQdmZwR0hmMVVpOG9XUi85ZzVqY2FsejRMTEI2QmRvWWRmSFZQ?=
 =?utf-8?B?UWZyTWM1M0JFRkpXbTRFakViMjc2bEgwVExlMmV2NFc3dXZ0aWtNM0tDV2Ry?=
 =?utf-8?B?K21WSkdIT0FHUlhWUUF1d2JieVE3UG94MkIvR09EcW5abC9GMmw4c2xxaE9V?=
 =?utf-8?B?TDVCM29GclgrSzdyZDdtZjRVSDhtL0UzTGh5QkJ1VythVEV3SUxHcW5peFJy?=
 =?utf-8?B?U0JucjJ2RlVRdjN2Y1JocGZsVEcvSHpvVVlXVnBCeis1a3RPaUIyTUlTcWl2?=
 =?utf-8?B?TjU5UHQrdG1TdzM5SW9KZVdxcFhpK2NzWDY4OWt2Qk9MZEh3ZXZzSDY0d3BJ?=
 =?utf-8?Q?sx/HlXGpyc61jDiNb97RNw8=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce8f732-03d9-45e6-e69a-08dbcf003d81
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 11:00:14.3346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sp/yNjIl2+KKHBb0kwFSlZDQSvsSuPeMtRMoDHcdppRPPskU5/LSfUoa5Hn+yGcMvcXvmcWmuQaCPxyBX2cad0kN7H20LbI1CCnvKNoXbS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6295
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some touch devices provide mechanical overlays with different objects
like buttons or clipped touchscreen surfaces.

In order to support these objects, add a series of helper functions
to the input subsystem to transform them into overlay objects via
device tree nodes.

These overlay objects consume the raw touch events and report the
expected input events depending on the object properties.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 MAINTAINERS                         |   7 +
 drivers/input/Makefile              |   2 +-
 drivers/input/touch-overlay.c       | 399 ++++++++++++++++++++++++++++++++++++
 include/linux/input/touch-overlay.h |  34 +++
 4 files changed, 441 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a7bd8bd80e9..00c03824c3ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21884,6 +21884,13 @@ W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
+TOUCH OVERLAY OBJECTS
+M:	Javier Carrasco <javier.carrasco@wolfvision.net>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/input/touch-overlay.c
+F:	include/linux/input/touch-overlay.h
+
 TTY LAYER AND SERIAL DRIVERS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Jiri Slaby <jirislaby@kernel.org>
diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index c78753274921..393e9f4d00dc 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -7,7 +7,7 @@
 
 obj-$(CONFIG_INPUT)		+= input-core.o
 input-core-y := input.o input-compat.o input-mt.o input-poller.o ff-core.o
-input-core-y += touchscreen.o
+input-core-y += touchscreen.o touch-overlay.o
 
 obj-$(CONFIG_INPUT_FF_MEMLESS)	+= ff-memless.o
 obj-$(CONFIG_INPUT_SPARSEKMAP)	+= sparse-keymap.o
diff --git a/drivers/input/touch-overlay.c b/drivers/input/touch-overlay.c
new file mode 100644
index 000000000000..007dbd994474
--- /dev/null
+++ b/drivers/input/touch-overlay.c
@@ -0,0 +1,399 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Helper functions for overlay objects on touchscreens
+ *
+ *  Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
+ */
+
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touch-overlay.h>
+#include <linux/module.h>
+#include <linux/property.h>
+
+enum touch_overlay_valid_objects {
+	TOUCH_OVERLAY_TS,
+	TOUCH_OVERLAY_BTN,
+};
+
+static const char *const object_names[] = {
+	[TOUCH_OVERLAY_TS] = "overlay-touchscreen",
+	[TOUCH_OVERLAY_BTN] = "overlay-buttons",
+};
+
+struct touch_overlay_segment {
+	u32 x_origin;
+	u32 y_origin;
+	u32 x_size;
+	u32 y_size;
+};
+
+struct touch_overlay_button {
+	struct touch_overlay_segment segment;
+	u32 key;
+	bool pressed;
+	int slot;
+};
+
+static int touch_overlay_get_segment_props(struct fwnode_handle *segment_node,
+					   struct touch_overlay_segment *segment)
+{
+	int error;
+
+	error = fwnode_property_read_u32(segment_node, "x-origin",
+					 &segment->x_origin);
+	if (error < 0)
+		return error;
+
+	error = fwnode_property_read_u32(segment_node, "y-origin",
+					 &segment->y_origin);
+	if (error < 0)
+		return error;
+
+	error = fwnode_property_read_u32(segment_node, "x-size",
+					 &segment->x_size);
+	if (error < 0)
+		return error;
+
+	error = fwnode_property_read_u32(segment_node, "y-size",
+					 &segment->y_size);
+	if (error < 0)
+		return error;
+
+	return 0;
+}
+
+static int
+touch_overlay_get_button_properties(struct device *dev,
+				    struct fwnode_handle *overlay_node,
+				    struct touch_overlay_button *btn)
+{
+	struct fwnode_handle *btn_node;
+	int error;
+	int j = 0;
+
+	fwnode_for_each_child_node(overlay_node, btn_node) {
+		error = touch_overlay_get_segment_props(btn_node,
+							&btn[j].segment);
+		if (error < 0)
+			goto button_put;
+
+		error = fwnode_property_read_u32(btn_node, "linux,code",
+						 &btn[j].key);
+		if (error < 0)
+			goto button_put;
+
+		dev_dbg(dev, "Added button at (%u, %u), size %ux%u, code=%u\n",
+			btn[j].segment.x_origin, btn[j].segment.y_origin,
+			btn[j].segment.x_size, btn[j].segment.y_size, btn[j].key);
+		j++;
+	}
+
+	return 0;
+
+button_put:
+	fwnode_handle_put(btn_node);
+	return error;
+}
+
+static void touch_overlay_set_button_caps(struct touch_overlay_map *map,
+					  struct input_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < map->button_count; i++)
+		input_set_capability(dev, EV_KEY, map->buttons[i].key);
+}
+
+static int touch_overlay_count_buttons(struct device *dev)
+{
+	struct fwnode_handle *overlay;
+	struct fwnode_handle *button;
+	int count = 0;
+
+	overlay = device_get_named_child_node(dev,
+					      object_names[TOUCH_OVERLAY_BTN]);
+	if (!overlay)
+		return 0;
+
+	fwnode_for_each_child_node(overlay, button)
+		count++;
+	fwnode_handle_put(overlay);
+
+	return count;
+}
+
+static int touch_overlay_map_touchscreen(struct device *dev,
+					 struct touch_overlay_map *map)
+{
+	struct fwnode_handle *ts_node;
+	int error = 0;
+
+	ts_node = device_get_named_child_node(dev,
+					      object_names[TOUCH_OVERLAY_TS]);
+	if (!ts_node)
+		return 0;
+
+	map->touchscreen =
+		devm_kzalloc(dev, sizeof(*map->touchscreen), GFP_KERNEL);
+	if (!map->touchscreen) {
+		error = -ENOMEM;
+		goto handle_put;
+	}
+	error = touch_overlay_get_segment_props(ts_node, map->touchscreen);
+	if (error < 0)
+		goto handle_put;
+
+	map->overlay_touchscreen = true;
+	dev_dbg(dev, "Added overlay touchscreen at (%u, %u), size %u x %u\n",
+		map->touchscreen->x_origin, map->touchscreen->y_origin,
+		map->touchscreen->x_size, map->touchscreen->y_size);
+
+handle_put:
+	fwnode_handle_put(ts_node);
+
+	return error;
+}
+
+static int touch_overlay_map_buttons(struct device *dev,
+				     struct touch_overlay_map *map)
+{
+	struct fwnode_handle *button;
+	u32 count;
+	int error = 0;
+
+	count = touch_overlay_count_buttons(dev);
+	if (!count)
+		return 0;
+
+	map->buttons = devm_kcalloc(dev, count,
+				    sizeof(*map->buttons), GFP_KERNEL);
+	if (!map->buttons) {
+		error = -ENOMEM;
+		goto map_buttons_ret;
+	}
+	button = device_get_named_child_node(dev,
+					     object_names[TOUCH_OVERLAY_BTN]);
+	if (unlikely(!button)) {
+		error = -ENODEV;
+		goto map_buttons_ret;
+	}
+
+	error = touch_overlay_get_button_properties(dev, button,
+						    map->buttons);
+
+	if (error < 0)
+		goto map_buttons_put;
+
+	map->button_count = count;
+
+map_buttons_put:
+	fwnode_handle_put(button);
+map_buttons_ret:
+	return error;
+}
+
+static bool touch_overlay_defined_objects(struct device *dev)
+{
+	struct fwnode_handle *obj_node;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(object_names); i++) {
+		obj_node = device_get_named_child_node(dev, object_names[i]);
+		if (obj_node) {
+			fwnode_handle_put(obj_node);
+			return true;
+		}
+		fwnode_handle_put(obj_node);
+	}
+
+	return false;
+}
+
+/**
+ * touch_overlay_map_overlay - map overlay objects from the device tree and set
+ * key capabilities if buttons are defined.
+ * @keypad: pointer to the already allocated input_dev.
+ *
+ * Returns a pointer to the object mapping struct.
+ *
+ * If a keypad input device is provided and overlay buttons are defined,
+ * its button capabilities are set accordingly.
+ */
+struct touch_overlay_map *touch_overlay_map_overlay(struct input_dev *keypad)
+{
+	struct device *dev = keypad->dev.parent;
+	struct touch_overlay_map *map = NULL;
+	int error;
+
+	if (!touch_overlay_defined_objects(dev))
+		return NULL;
+
+	map = devm_kzalloc(dev, sizeof(*map), GFP_KERNEL);
+	if (!map) {
+		error = -ENOMEM;
+		goto map_error;
+	}
+	error = touch_overlay_map_touchscreen(dev, map);
+	if (error < 0)
+		goto map_error;
+
+	error = touch_overlay_map_buttons(dev, map);
+	if (error < 0)
+		goto map_error;
+
+	touch_overlay_set_button_caps(map, keypad);
+
+	return map;
+
+map_error:
+	return ERR_PTR(error);
+}
+EXPORT_SYMBOL(touch_overlay_map_overlay);
+
+/**
+ * touch_overlay_get_touchscreen_abs - get abs size from the overlay node
+ * @map: pointer to the struct that holds the object mapping
+ * @x: horizontal abs
+ * @y: vertical abs
+ *
+ */
+void touch_overlay_get_touchscreen_abs(struct touch_overlay_map *map, u16 *x,
+				       u16 *y)
+{
+	*x = map->touchscreen->x_size - 1;
+	*y = map->touchscreen->y_size - 1;
+}
+EXPORT_SYMBOL(touch_overlay_get_touchscreen_abs);
+
+static bool touch_overlay_segment_event(struct touch_overlay_segment *seg,
+					u32 x, u32 y)
+{
+	if (!seg)
+		return false;
+
+	if (x >= seg->x_origin && x < (seg->x_origin + seg->x_size) &&
+	    y >= seg->y_origin && y < (seg->y_origin + seg->y_size))
+		return true;
+
+	return false;
+}
+
+/**
+ * touch_overlay_mapped_touchscreen - check if an overlay touchscreen is mapped
+ * @map: pointer to the struct that holds the object mapping
+ *
+ * Returns true if an overlay touchscreen is mapped or false otherwise.
+ */
+bool touch_overlay_mapped_touchscreen(struct touch_overlay_map *map)
+{
+	if (!map || !map->overlay_touchscreen)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(touch_overlay_mapped_touchscreen);
+
+/**
+ * touch_overlay_mapped_buttons - check if overlay buttons are mapped
+ * @map: pointer to the struct that holds the object mapping
+ *
+ * Returns true if overlay buttons mapped or false otherwise.
+ */
+bool touch_overlay_mapped_buttons(struct touch_overlay_map *map)
+{
+	if (!map || !map->button_count)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(touch_overlay_mapped_buttons);
+
+static bool touch_overlay_mt_on_touchscreen(struct touch_overlay_map *map,
+					    u32 *x, u32 *y)
+{
+	bool contact = x && y;
+
+	if (!touch_overlay_mapped_touchscreen(map))
+		return true;
+
+	/* Let the caller handle events with no coordinates (release) */
+	if (!contact)
+		return false;
+
+	if (touch_overlay_segment_event(map->touchscreen, *x, *y)) {
+		*x -= map->touchscreen->x_origin;
+		*y -= map->touchscreen->y_origin;
+		return true;
+	}
+
+	return false;
+}
+
+static bool touch_overlay_button_event(struct input_dev *input,
+				       struct touch_overlay_button *button,
+				       const u32 *x, const u32 *y, u32 slot)
+{
+	bool contact = x && y;
+
+	if (!contact && button->pressed && button->slot == slot) {
+		button->pressed = false;
+		input_report_key(input, button->key, false);
+		input_sync(input);
+		return true;
+	} else if (contact && touch_overlay_segment_event(&button->segment,
+							  *x, *y)) {
+		button->pressed = true;
+		button->slot = slot;
+		input_report_key(input, button->key, true);
+		input_sync(input);
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * touch_overlay_process_event - process input events according to the overlay
+ * mapping. This function acts as a filter to release the calling driver from
+ * the events that are either related to overlay buttons or out of the overlay
+ * touchscreen area if defined.
+ * @map: pointer to the struct that holds the object mapping
+ * @input: pointer to the input device associated to the event
+ * @x: pointer to the x coordinate (NULL if not available - no contact)
+ * @y: pointer to the y coordinate (NULL if not available - no contact)
+ * @slot: slot associated to the event
+ *
+ * Returns true if the event was processed (reported for valid key events
+ * and dropped for events outside the overlay touchscreen area) or false
+ * if the event must be processed by the caller. In that case this function
+ * shifts the (x,y) coordinates to the overlay touchscreen axis if required
+ */
+bool touch_overlay_process_event(struct touch_overlay_map *map,
+				 struct input_dev *input,
+				 u32 *x, u32 *y, u32 slot)
+{
+	int i;
+
+	if (!map)
+		return false;
+
+	/* buttons must be prioritized over overlay touchscreens to account for
+	 * overlappings e.g. a button inside the touchscreen area
+	 */
+	if (touch_overlay_mapped_buttons(map)) {
+		for (i = 0; i < map->button_count; i++) {
+			if (touch_overlay_button_event(input, &map->buttons[i],
+						       x, y, slot))
+				return true;
+		}
+	}
+	/* valid touch events on the overlay touchscreen are left for the client
+	 * to be processed/reported according to its (possibly) unique features
+	 */
+	return !touch_overlay_mt_on_touchscreen(map, x, y);
+}
+EXPORT_SYMBOL(touch_overlay_process_event);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Helper functions for overlay objects on touch devices");
diff --git a/include/linux/input/touch-overlay.h b/include/linux/input/touch-overlay.h
new file mode 100644
index 000000000000..3e0db813dc34
--- /dev/null
+++ b/include/linux/input/touch-overlay.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
+ */
+
+#ifndef _TOUCH_OVERLAY
+#define _TOUCH_OVERLAY
+
+#include <linux/types.h>
+
+struct input_dev;
+struct device;
+
+struct touch_overlay_map {
+	struct touch_overlay_segment *touchscreen;
+	bool overlay_touchscreen;
+	struct touch_overlay_button *buttons;
+	u32 button_count;
+};
+
+struct touch_overlay_map *touch_overlay_map_overlay(struct input_dev *keypad);
+
+void touch_overlay_get_touchscreen_abs(struct touch_overlay_map *map,
+				       u16 *x, u16 *y);
+
+bool touch_overlay_mapped_touchscreen(struct touch_overlay_map *map);
+
+bool touch_overlay_mapped_buttons(struct touch_overlay_map *map);
+
+bool touch_overlay_process_event(struct touch_overlay_map *map,
+				 struct input_dev *input,
+				 u32 *x, u32 *y, u32 slot);
+
+#endif

-- 
2.39.2

