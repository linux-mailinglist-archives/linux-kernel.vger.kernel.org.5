Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94766787012
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbjHXNSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240994AbjHXNRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:17:51 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22181B0;
        Thu, 24 Aug 2023 06:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oP6y9qMCZLbduX0vQ/4UMTcBRQbFtfZiX4q6unRzBeehh5SbAEOk+4yyEjQRh7tWnmSF0cQkaZ7iNAlBEaEURTH4rU34UAq6OTi/emh1sUZZUHujP2k5UKW8DqQAU2+FSymaiCFSaXeXnxP3MKd0q+d2M/chsXfOdNCOweUI5h24bMuCVvjiicU/Tdlr0gaG0zXBXuCRpnnxKtuLNL+tfkVH7Wr+HZ2DHsApFuwV2Gx9hLZO1N9lq632HV7SeBzuVDwALqLeI1n2BmIu+N5YbnWazZdZX1QU0NmYN4zxLkgQEEoSN+2ukeeH2LNxnYqglhFGVWZAWiRABof57h5oEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqazVur3+oyuyZKRcL1W+LO0K7QxW9KJEE88Bn/Fh5o=;
 b=BRwvoSNTAA4aDkUTbQZZd2XoT9K/D+QfsdCjuhmAVYyCN4PZtsUOytRmWNHR/eokuXKNQtL7uyGW4a+DF+pLjwR6u8kgleeVq0mJ8sWRtBWmajrFcxsYi8w0rTC+koICcc/Ri+jub1i3w7xttfmPGEYDEdV6qGuXEoHz4yATNufoTIw/qn/V8St497Y90uYH9FIbeVg2IwK4ZOlQDvzoKsoY964uQI9gam7xC+XAeW38maM0qc15MdyP3yFhzBla7y1gMfVaAjSQW03a8aJQvUkYbfnVYIb3M9iatQ+o5GlUAnTbDNSR24q3zrR8usOZXCDQCFdABvYkk40QBaGQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqazVur3+oyuyZKRcL1W+LO0K7QxW9KJEE88Bn/Fh5o=;
 b=dWQXa8Gi0yFfWtqy4OEejJJ6BifKoc95BCjAvsAUHI/5rEs4a3HVigCjzupn0KNushKBHHzonD1rdNfocM4pGZ+AgKCpGXgXWFlyelgX9ckVvk0lFD0SziCGVH5qDQVT8ZrgDY12+SVqUJKCMEvbgTmpLbaKiUG1oqQssRm8l/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM6PR08MB4966.eurprd08.prod.outlook.com (2603:10a6:20b:d4::23)
 by AM7PR08MB5397.eurprd08.prod.outlook.com (2603:10a6:20b:dd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 13:17:45 +0000
Received: from AM6PR08MB4966.eurprd08.prod.outlook.com
 ([fe80::f7b3:4adb:c638:d8c7]) by AM6PR08MB4966.eurprd08.prod.outlook.com
 ([fe80::f7b3:4adb:c638:d8c7%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 13:17:45 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Thu, 24 Aug 2023 15:17:09 +0200
Subject: [PATCH v4 1/4] Input: touch-overlay - Add touchscreen overlay
 object handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-feature-ts_virtobj_patch-v4-1-5c6c0fc1eed6@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v4-0-5c6c0fc1eed6@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v4-0-5c6c0fc1eed6@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692883063; l=13899;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=JL3dP0O0DqFxMnYjj9dQs6fIBWPOaEgzUZcZU6ZZguM=;
 b=FPkTzo+0yM0Gt9uoR2bSQpyErmk33BNIRe1l4WAQxStttbUWWHyye76VJZwPPuS8iwJ0Sl2yH
 fEKTmkeaizTC2aP8toakb4JN4JEdRTxckfh0FoCW/EdTCl3Ve6M+6CD
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR07CA0301.eurprd07.prod.outlook.com
 (2603:10a6:800:130::29) To AM6PR08MB4966.eurprd08.prod.outlook.com
 (2603:10a6:20b:d4::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4966:EE_|AM7PR08MB5397:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e8615b-a5d5-4de1-6b6f-08dba4a4810c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m5rW+dEK4vVmZnZP6LnXO+IOs3jcbntBs2HZb3ZkJ3n2zTVsWFzUmIit61e9hwFhkVphPvach5s7wnF0gmOgldFf4OXbvidEWU10fggy7YImahLzmnsvRHbcUpjkb8dzAjxhRL/5Mw5QFSLkX+uKMHurVwbK54xs+Yx5kD2eknMzU61HfQ6+umxPdnPBYKAbWzageEMPxpkHp4GQ9AH/DnMtWcPTLHRtjcEx41iaNTcamuoCU7jDCxJP6iGIVo+J3LaMTXMe5+zo70VuAW+RLqx2L2vVQ6CS2Ixc74pJHzvjdzmvaErx5YrxcfzhM/FDO9NpUWc2V6P61NemeLzxVaQPkFHs6O+Fq7Jz9+EFH1wXmgUeEB/874dR32bn0R2PVBYewCnn5XTrRHJwtLUPy6G7CTGb46pCpYm9vinhIRefstG8uMmiBN2Fg3/pQ6VryriHbmmeTycOpPkKYbOwkMDXN/xJ4XKUWse+1NXp+h9NAGatKWGbbVzqVgctFKKKevTF199cd+9Qk+6WfFW5crXokVcglBdKUrnvbq2aGP2IRSO7vZKsYDFG0lVE7c/D5hko3PoHrxzOQ5auTNfHf2UMyd/J79+K6dP3L22FqdQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4966.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(366004)(376002)(136003)(396003)(451199024)(1800799009)(186009)(2906002)(30864003)(38350700002)(52116002)(6506007)(6486002)(5660300002)(83380400001)(44832011)(26005)(86362001)(38100700002)(8676002)(107886003)(8936002)(4326008)(2616005)(966005)(66946007)(6512007)(66556008)(316002)(66476007)(110136005)(6636002)(478600001)(6666004)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T01SdFlZQlprdWpodVVSNmI0UC9JdDRMN28wTnNiVGFVZFhvb2xSS0JxU05O?=
 =?utf-8?B?bGpkQlc1THMvTkxGMFdQakQ3Y3RlbVYrakN4NHVOZjNHKzJaQ29uSlpDR0NE?=
 =?utf-8?B?MGNGelZXd2hwdjJ0bC9aMFBWbmdDQjlUYndjMVBBRHJ2czlsbXhENTJqNitL?=
 =?utf-8?B?SmdRNHkvV1QzWVR2Q3QwT1BweWxlMU5FakJ1dEJnWGlYbXU0a1VVUEpRZ1oz?=
 =?utf-8?B?ZnJTVDA1S1JSbCsreWNWb1I1and1M2RsWWFMSXJEU0VWNmp1NlFtNlNRdlV6?=
 =?utf-8?B?YnVGbSswV2J4WHFWK2tJUkRTRXAzY2lYMFpLS01IaC9MTXMwV09VMTdpQWVi?=
 =?utf-8?B?ZHg0aFJvRWErQm1ndDVGYjRNNDRpSVJPZmlvQ3ZiaFJiaVUzMGs0YjdCZjlG?=
 =?utf-8?B?N3FVTkhGakZhMGFPSDlRU3JobFlqNkh4VVFPKzQ0WWlPVDNaekdKZkR1cmNN?=
 =?utf-8?B?b2c2VytNbUVlWmZobnJ0QUdDa3c4UzhiT0psdkJUNENzeUI1MmFMVjdUZ05J?=
 =?utf-8?B?RGt2TXdVYjNmSlI3dzZCMzAvMU8rYkMyWFBHcTRYamVFeW93TUxQYkVzYytO?=
 =?utf-8?B?N0xEZGZ4WFpKdXZxTk5qR1RadEZYTklpeURYUUNoV3FBWkt0elYrL3Jjclli?=
 =?utf-8?B?VzNFZVJWN3lyRllSeUdtQitPRDdOS2lBcHdKM21mOWRmT0oxYWtZV2NPQy81?=
 =?utf-8?B?ZHROWlhMWnRQSGJkcDU2RXJsR0czZ1BBZ2p3UHJrVW5rNGdiUUhsYXRpMjl6?=
 =?utf-8?B?SXpISEZGVVUzTXFwQ3ExdDBsRVUwdXZzQm5pTEdENk1ERnh3NVdrTVc4Q3d4?=
 =?utf-8?B?VHQwL1lYdzJoTFV1NmtDS0xNZFoxSTA3ZjVkZ25PaU9kZnFPK3VrdUtrVTlD?=
 =?utf-8?B?RWdPbE9QN0hSTUw2ekIvNUZZWUx6emorQ3oxRG9iZU1nOEtQOW9lWjFsRisz?=
 =?utf-8?B?N05laXlXQVVtK0x5aTEvdUNyLzdqUStQRXM2ekRHM0tiZXA2ZkxMcnJIRXNx?=
 =?utf-8?B?TzJoYnQ3RDhORlhnam1pcEpRTldaaFNaOEpBNXVPWGZseXdPa2w0cGswODVu?=
 =?utf-8?B?NTdqa3dtK2pXUWpnWWgzSENlbEpQQjJRcnJxTVJqVUNIcnFoM2RTQlljYlhZ?=
 =?utf-8?B?WkxSTTNaaUFOcG4xZEYycXRhY2h6aTJwbkkrZHhXVFZ2OXlOZ21XUzhvTFlj?=
 =?utf-8?B?QTY1WUg2SkFTZE9ZYnRIYTgzdXJyMEhlNWYzTXIvSzZYTkdRZi9OS1FkTXNC?=
 =?utf-8?B?a3B6Z0ViWG5HbkFNZFpaOGhnb0s5bTUwMm1IdjUyQkZSRUhUQnBheWlobHJG?=
 =?utf-8?B?OUxEK0pIWGZWQ0pOUm9LTTBsMHpwOENyWWNIc0NwTllOaWkyYlBWc2pxc2xr?=
 =?utf-8?B?R1phMjVBank0anl2UU0reTJDRGJob2VxQjNNalZUQjAvZGtadVRqMDNZY1c2?=
 =?utf-8?B?Y2s0b0l6N21WcnlxdHlINFBtZ3BjTWl3WmxQaXhOQkdkZzNmVEt2ek82dmNz?=
 =?utf-8?B?dmVvb2ZxWEVDMHhHWFVkaCtobzB3YVRhSWRoZHdtbUFJdmptZjEyTXpqRmRL?=
 =?utf-8?B?Tnk0UFordU5ibTgrekd0MHF5YXVnOXNJUUswMUpsWlFkQU5pdnlVaHNZOVNZ?=
 =?utf-8?B?djlnQ3hCbEtrejI1ME5yR0dicTN6WHlVbXVCS3hCQmFENXhGWnY4U2lYblAr?=
 =?utf-8?B?b0hBNUNnY21WS2Mxb1htVW84b1F6WitXRnVvTnB3STA1TjJzbUllMmRCb215?=
 =?utf-8?B?VVFJOVBrdlRpVzhxbVVrM25BMmFKa0VnMGpLak9sMkNxWm9sblB3NnNkWkZX?=
 =?utf-8?B?QVNuOTVieVYzck54YWpIYzlYN1BpN0RFZm8wczNSYjMrV2doRHVqWlNYdlBD?=
 =?utf-8?B?Szhub0xQaE1tMk1TV3VQMjlsRFd2QjN0YzN4WkU5TSt5R290allWMXBScTBM?=
 =?utf-8?B?WE4xWHpvY1dmY3FhUFc0T25tb1ltMVJRWDJIZll4NWV0L2F0SW5hRzFLdWda?=
 =?utf-8?B?eTRtb0ZHQmhEdFdwaklSRWpPQ0JRT0lheDV3Q3MvU3laRmtKUlBFTi94M3hp?=
 =?utf-8?B?bm9VUjlxZnF2a2E0SWI1OWdTWWxBTjFvQ1JxVWFVZ1U5MTN2Nm1uNlpERHg1?=
 =?utf-8?B?TWgvNE55Mkg0WTcvajB3OFRHQ01pdDRId1pmeXJRczd4Nkx2aEV1US9Oa0tF?=
 =?utf-8?Q?QHME71Fy4HiRbMyWVftQHjA=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e8615b-a5d5-4de1-6b6f-08dba4a4810c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4966.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 13:17:45.0925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGaR3FFGAeThvNBtq2M9K9ysYKcZtnQOGqk9jGAQ/xh+bNCdFpnnl00FyJ+fSt8ZhgtiFQZHD+IvYL4Ga0zHmryHbWQzYxVbI0OB4frNgII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5397
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
index 3be1bdfe8ecc..dbc0d315d3d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21625,6 +21625,13 @@ W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
+TOUCH OVERLAY OBJECTS
+M:	Javier Carrasco <javier.carrasco@wolfvision.net>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/input/touch-overlay.c
+F:	include/linux/input/touch-overlay.h
+
 TTY LAYER
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

