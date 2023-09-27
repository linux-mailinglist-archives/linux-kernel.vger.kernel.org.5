Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E88E7B03FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjI0M0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjI0M0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:26:36 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2042.outbound.protection.outlook.com [40.107.241.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CDFC0;
        Wed, 27 Sep 2023 05:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULo6z070lhQg1G6xx/NLn9QrGyFZu4P9BYao+pl4B1YvUfw/IMr59VSUAd4rSZdWUHn392TLXGtfjGH2+GxyaeQM0H0AZ7smd8TER/s6f9TncmAIH8Ncr0AlvAQbtvLpJn+JxLWptHPUcTFPwauwgRh2cExmAAXMzzcnLJ1bOC0OfcdInqUZr17YEh5ufRXP0msEZlEVJycT1qTdEysNcrONYKlgz2KZoT2gJj0hAjhVneb8RDUsYuy3Rg6DVyZdwtS9K1RkO9KAI9hm4IN4aWvidsiapBve/zdnmN0FEw8tTcUU9sma7tACC9BVGa+GlhR4dm4GPa3R4GkkiZ4VIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4Qg/nbJczaWykdnPsCprrI5TVjM058N/677FUPGEhU=;
 b=VEF4io4uCzOYIMRk9VBozN1mXIbk3hMzBMhs2e/yixNkp538nRiIA2Kw5zdQM0EfHX3GfZROrkvhSdlnt1Tm6OdiPFMzhPvlBjCPscIS1lnWd9y/ugThL5lQ57qF6hAlUuCf7B7uQKLPQ1qw2SssEXareACYt7zDOlMtL9sBwAFiVB71s/+KrDT4MM96/nY93Klp7YtStvpMX45uypsUIgtMT5u8mPqlpzz7MN6C4/i1dMm0PH7t1D+lSFU7NBhu1PMqD2t91fZWlxqaUc1J7EsIhPin01VEUoUZMFqHF/LsQuHOMp5K45/ykCqiQTTXg7rpPLMQUDBQ2EJFLTd9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4Qg/nbJczaWykdnPsCprrI5TVjM058N/677FUPGEhU=;
 b=LlS7T70ZzeE6nqh4Zl38xSQJeeTuIMxK5YNfbKyE0aYWUTX9YoPgPurybOJu7HWofIhS6FvZFyUWnGCcLHzmNhU00MhftQ4fwKxYf6vJoOB4aV/tkXh8X0q/rOtM7eQmMmiJWz5DozJpmyWLrdnP65y8nYWQcUiW9Kq7xUsObnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB7704.eurprd04.prod.outlook.com (2603:10a6:20b:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Wed, 27 Sep
 2023 12:26:32 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 12:26:32 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v6 01/11] Documentation/firmware: added imx/se-fw to other_interfaces
Date:   Wed, 27 Sep 2023 23:23:51 +0530
Message-Id: <20230927175401.1962733-2-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
References: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS8PR04MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: c946d3d6-b7a1-4f07-9be2-08dbbf54fb87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQOKg38X1S7iVACD5Cn8S8lnS9oh380e2+DRTXbenj55bIzCgCm+39vuDdH0cOWGQy1RFKm03Op4SyeCNfQxxPrAdvwsfdbd/sw+V2x0aMvXs8cSUXoYiIMsJPz92+ec+TyyYZf6R4lRR/ek2mALzwE3TKHXmp4JPdhoikzv2TnmlqhsC4GHUkW2sB5Y6Td9276JxQ1khySdYKcK8c4FIQrwum5Tpwc7mgMfDgLXvHNwqooQ7U3bAljuTp98mrEpQKItDErhbk1spd1crabSMhnkVyd6n9dbXoyD7lFz6EIO+rIGvhbcn9oyvM9A5knJQhw6TDzcKTjSVw+5/aPCwu2/Tj2W7+uY3yrzAHN07o92qlHhY5Qu8h69/g+bhbn555IFPy/xnr6N1V7tHmGv/bMYg79lJZdBfvLEXn3IvUt+JANozqc889L0Fde9dd3HivQYNs90UOLhhx3EHZZTX7SAttFUgg6Qv3V6IhjmbsnkmN5xRv6Nhh65fZlzwYXmJ9apRV0Gz6W/uzvwDA06K9kZF8RY8PtI5R/cP3VoAvk9gBErP+STrhHhgKgqHPJCcEYsG6PQvRwr4SeXseAhPXiqEKAOcMJQCrulfhjmdZx1XJbjiFyh9YsitpwNtctOkLJnAcOJIX6psTnWleBpXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(396003)(376002)(230922051799003)(1800799009)(186009)(451199024)(1076003)(2616005)(6506007)(52116002)(6512007)(44832011)(26005)(8936002)(478600001)(921005)(5660300002)(6666004)(36756003)(4326008)(2906002)(316002)(6636002)(86362001)(66556008)(66946007)(8676002)(41300700001)(38100700002)(38350700002)(66476007)(6486002)(7416002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t6IYxPdF9AF7Ym/iTHWb+96TZFCNS0EOuz6FkIN7W2IDMzT1mqngw8Q8DTbQ?=
 =?us-ascii?Q?yIUyRX2pNJO9CDlukWAuz3QeHmkdJFLjYp3jobJULIbbEsqjxZxv+nhtQRrF?=
 =?us-ascii?Q?n8968FXMAWq0bXHJ7jt1+QWOqynGJ6C9cY5JhZjNZXJ7HelQRMlJ1FPevs7j?=
 =?us-ascii?Q?7yG3xKTBJde259IhrVr/WWWzZJPxZNN7ZJcIxtLjAf5tXtzBwxIeZi94bLaP?=
 =?us-ascii?Q?KyxEPHeZ8ZjlyyvI9hooHEhpjAScjEJaj/0/N5TZi+Fg95mR5Rmf7ceIgeHJ?=
 =?us-ascii?Q?9ReDJqI8XKaPtZ5Bi14pJQmdT6OyqRID+6M3OhKTguyDARBgqCHE+B23D7yK?=
 =?us-ascii?Q?SFo6lIyHNasK+VrQ9pzUiJ8eI9Bwek1OXUGX+uJwd8GPdT/moYJtbL5D0A+F?=
 =?us-ascii?Q?Xzb5PA3I4GJxNiYVz+3gmqWEa61mVDPJw3oRVGpsIf7+OnxJfUZNt9mycoR2?=
 =?us-ascii?Q?Bz1u6DZKWY0jCKV4lxiOKrRE/bntjaqej3cQOryl4mKrdMF3pF8gElBgKNzT?=
 =?us-ascii?Q?sFW6nShz7H7CfJoHZK7LDz9+vQ5a/nQVcvZMre0EHks8exCMwS8f5iccsP2D?=
 =?us-ascii?Q?SNDjpQhj0J+pQg5DNULaIni1vkR+MiI5HR6WeApnDMLPy2bxErN2luHW15rj?=
 =?us-ascii?Q?2gAMgehyGqb9Ed30+2q0Ak+pzZi17iVCW+MZll2UI3lyRlz5+1ZhqY12Wh1V?=
 =?us-ascii?Q?rgPVTcD2nvt9/Bd61LO6nG30NUbaPYPXeUa4dfSqYFngOSMCNhBn5NR9VGKO?=
 =?us-ascii?Q?Pa0Dy3PbTRAK25ufxOasIk4NzAOPjUKxpgXgWb0DFMbrjoBPldalNyc7FpGo?=
 =?us-ascii?Q?lHvSWJZZCRwr9Ppdx724rJndBOYNE/IlN/eRdtA7o2v7vtkoupcIUT3TPQcY?=
 =?us-ascii?Q?8V+vob8aIuh9ldhV5muce2UAuIUcj4Ebfmdi2Hbxg+dDlUr/XtJFDsd2vJl8?=
 =?us-ascii?Q?edX6zIJ3oha+qRrMtPRubuCFB+23FFY8uKTiFgW19ZqwRu71Ul/1EBFcdUf7?=
 =?us-ascii?Q?JNVArzgpLdxpLMBWbVEQFqkdn9P7Tal8RM1PLXk+DNqWRUmr4lE2vafCWqTq?=
 =?us-ascii?Q?EM3hqtyP6ppqhAIpFZpT4J/wzOAlEAc/zEOR/hHkx0P4qU3Hf1D/SvoyOTFG?=
 =?us-ascii?Q?ismvxkpirp2B1mhp6POtZ7N0P6QslhOh0LOCmPgrLGAkfQ5oId+gIXaIor6+?=
 =?us-ascii?Q?CghWBTtkl8uETgILGYLCMDpF7xSxXToxh3Irtpb5vaSr0gH09YE8XI2liKe7?=
 =?us-ascii?Q?CkB0mCd+n3ad3ig4kbCQD58wa3AIGaJlO2LHMlnxt4wuv6GTaxISipktYiP+?=
 =?us-ascii?Q?jl8SHK9v0aCZaA/8lhfLQlU2AyuSd3P8yEWYPJOC0s8KoUNDjK/GR4TbSgtF?=
 =?us-ascii?Q?ZiNjPsbg8/I6PgEwvVSaC/88mGZoNUfSacF80d/4tksRIx4WvCy4CpiHMe9P?=
 =?us-ascii?Q?iYA/g0xSHz0pBQEQZPLJhgFNZa7ak868k2DAtXx3pPu3Mgu9VA4ruFblId5V?=
 =?us-ascii?Q?8/51wobBxT6eUIg3KZrSKDz9b/f12/VxYWP+7IyGxzGb4lEhSX26BANWEfBO?=
 =?us-ascii?Q?NoxMJDz2EtLNNS/mIKL9fVLz9iXBVMDyM5BayEiA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c946d3d6-b7a1-4f07-9be2-08dbbf54fb87
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 12:26:32.3347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhlkK3LvVXCn/vu8rrKkc4CyOsq7dtlnBnJMUxop/aAFQoF9ZJx0QQjywDQFcHfBrJHDDkSdJyuYZpAti8H26Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7704
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documented i.MX SoC's Service layer and C_DEV driver for SoC(s)
enabled with hardware IP for secure-enclaves like:
- edgelock enclave on i.MX93 & i.MX8ULP

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../driver-api/firmware/other_interfaces.rst  | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
index 06ac89adaafb..1d21b88ef20e 100644
--- a/Documentation/driver-api/firmware/other_interfaces.rst
+++ b/Documentation/driver-api/firmware/other_interfaces.rst
@@ -49,3 +49,70 @@ of the requests on to a secure monitor (EL3).
 
 .. kernel-doc:: drivers/firmware/stratix10-svc.c
    :export:
+
+NXP i.MX Secure Enclave Enabled SoC Service layer and C_DEV driver
+------------------------------------------------------------------
+The NXP's i.MX HW IP like EdgeLock-Enclave, creating an embedded secure
+enclave within the SoC boundary to enable features like
+ - HSM
+ - SHE
+ - V2X
+
+SoC enabled with the NXP i.MX secure enclave IP(s) like EdgeLock-Enclave(ELE),
+are: i.MX93, i.MX8ULP.
+
+This driver exposes two interfaces:
+- service layer: This layer takes the two mutex locks:
+  "mu_cmd_lock" is taken to ensure one service is processed at a time. This
+  lock is not unlocked, till one service processing is complete. Multiple
+  messages can be exchanged with FW as part of one service processing.
+  "mu_lock" is taken to ensure one message is sent over MU at a time. This
+  lock is unlocked, post sending the message.
+
+- c_dev:
+  This driver configures multiple misc-devices on the MU, to exchange
+  messages from User-space application and NXP's Edgelocke Enclave firmware.
+  The driver ensures that the messages must follow the following protocol
+  defined.
+
+                                Non-Secure               +   Secure
+                                                         |
+                                                         |
+                  +---------+      +-------------+       |
+                  | se_fw.c +<---->+imx-mailbox.c|       |
+                  |         |      |  mailbox.c  +<-->+------+    +------+
+                  +---+-----+      +-------------+    | MU X +<-->+ ELE |
+                      |                               +------+    +------+
+                      +----------------+                 |
+                      |                |                 |
+                      v                v                 |
+                  logical           logical              |
+                  receiver          waiter               |
+                     +                 +                 |
+                     |                 |                 |
+                     |                 |                 |
+                     |            +----+------+          |
+                     |            |           |          |
+                     |            |           |          |
+              device_ctx     device_ctx     device_ctx   |
+                                                         |
+                User 0        User 1       User Y        |
+                +------+      +------+     +------+      |
+                |misc.c|      |misc.c|     |misc.c|      |
+ kernel space   +------+      +------+     +------+      |
+                                                         |
+ +------------------------------------------------------ |
+                    |             |           |          |
+ userspace     /dev/ele_muXch0    |           |          |
+                          /dev/ele_muXch1     |          |
+                                        /dev/ele_muXchY  |
+                                                         |
+
+When a user sends a command to the firmware, it registers its device_ctx
+as waiter of a response from firmware.
+
+Enclave's Firmware owns the storage management, over linux filesystem.
+For this c_dev provisions a dedicated slave device called "receiver".
+
+.. kernel-doc:: drivers/firmware/imx/se_fw.c
+   :export:
-- 
2.34.1

