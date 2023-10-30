Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031457DB713
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjJ3KAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjJ3KAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:00:05 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2089.outbound.protection.outlook.com [40.107.15.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8BB10DE;
        Mon, 30 Oct 2023 02:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXEk5emtCANSm/GQFZzFecoDBbL7OrfQKPtxM/9tgcfD8LBIKP5Zvnu2BqQb/ZkACiHhTozpAifvQFSnhgJOKql+KhDJta80RVLNNpgUs51jL2XW3WBjYjBofMZWlWpNjrtDZ/oILmhNK/+YUejyEFiykuQABxo7rEyPaN0nLNNeqk5YqWOt/s6RqlL9vVq0z+s05lgTlBzb3q1GMdjqRbet9pN3nne4U68C+OE+cTD+rLJvujcMjFik26etMt/p+qrRaaYHsZS/drxFP3h/L+jrKobHyu1VBrtawCC7tctPnCIlsdjqpy+q9qGfZkePYZouZOhZSZzCrnYn+3Xf+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4Qg/nbJczaWykdnPsCprrI5TVjM058N/677FUPGEhU=;
 b=If2mqbR015EsVROkB90PJkimzcX7EixobjwA8gdLL2Yuyri90Vm84VL3e6WmIb3++s3Uen7BJgigU6b2t6tNuDoOXax1EHI9YBUQxkWAktWho6FEnSmJK6IAJxmOOmz9yvMoEuPLUaT0LJoNG9au91qHeLUSc3okXpfBMezTrWhzztoM9tzVUFOaEbqP8u5YfmEqf1OwYz0K/+J1S/NsTWxAkFpnEV0Btk9bw88oMCYONzi6CbUXJLkoZOY64ss7f+FoKj3ux3Ytr1VtSeQSwJqq7AA8/psZ4jQ5+wNAKJd31g15sVKogiolGQRYpCKKWudzFDy/MOVoRJC3rlS0mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4Qg/nbJczaWykdnPsCprrI5TVjM058N/677FUPGEhU=;
 b=S/mPxkRJ/9RAqP2196VOphhtoS0TVPK8pD9uJkRJVHMNqqgf1NlRaYwzSEyL3y8QQvhcgEmfLO3WDPwtZekB+BWKP8AQA7S6Wz2cWk9igSXXHOazyCBaMxWvUYBgjOyhZPXFsH0c2/vQ5OBo2vv07Z4/4aMsgft+i28oKE17wCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Mon, 30 Oct
 2023 09:59:33 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351%4]) with mapi id 15.20.6954.016; Mon, 30 Oct 2023
 09:59:33 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v7 01/11] Documentation/firmware: added imx/se-fw to other_interfaces
Date:   Mon, 30 Oct 2023 15:28:39 +0530
Message-Id: <20231030095849.3456820-2-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030095849.3456820-1-pankaj.gupta@nxp.com>
References: <20231030095849.3456820-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS8PR04MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b115ca-6c50-4a36-6ad9-08dbd92eeae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BpffQoUJgjg5PEsGLsAWqBG9Lr5vV8WGKipRKVv8aPWxbErWpKug7DxU6kc91TAMAA5Z4KAfRDs/lYR+XnqJ7BzQ1/DI0TYVrTheZkOFv7lvxtBUJsW0tZzEC36wn0A1Sn1bwZxff4jpuLul9BaEubueiObkYM+v2Qsn3su3Cmdd/AzFw84KrT4jod8fkA2fhIcKv0zRHVG6ogqYsCz47VjdgISwdrcEF0i5PIT3FJIOrL122kb1lpF0T3xgJRZb6KvYYWVq1+mERAYhGIj/SO8Bss4xr2MTg5TUjbcD4/QLae830JaSMgrPdVZzOF3k98Jkbz91JxUMwxCIjxPtiqR4hn9FP0hyjcYr/Nl5a9j+nrVABMg+2c8rtNwCf8ogXUznjbjphJDCCckqYJ7Y0+bu0NHZh5s+2Xexhjv8fsVg2O+JIEwSFwxVfk7CURzzbzAxmWDD9L5ERvThvo/sZqQhVMl4HRTjATUEBweJzdCHe5bKC5YF4QmklSpxn5RH6GAjcn4AJGTBiT8py7kJZk6EoA9vKRAEcWXM9u/Kx1KLfUzdpL+IcvcZ3/YxEa4W4JaUnvNPg8adngj5XGWtcFlsw8I0V2EDMELw1RfQvOP1lEyhleq+8ZbHjpQykjAIjiJ0IwFBRJw1qayTf94VzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(478600001)(66946007)(6486002)(6506007)(83380400001)(36756003)(38100700002)(66556008)(1076003)(2616005)(66476007)(2906002)(41300700001)(26005)(52116002)(6512007)(44832011)(86362001)(38350700005)(921008)(6636002)(8676002)(4326008)(5660300002)(8936002)(316002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0UKeSRMtVnI8ldhlJzyEnPfm3fKES/GOPwEY9MVj40MXOGwsk2RecPIC/AcS?=
 =?us-ascii?Q?YHmXtsaNkEh9LAhxn68zJzFcLB3GHM8tbEEnEUSeHp+J9d4BOcUKEoyaH69B?=
 =?us-ascii?Q?gNzPYaEnXy5uCRhxq8H6rkTpokbXMA8+gsLeHCh9+Eov0AdNJbm/OYo7ILBt?=
 =?us-ascii?Q?etWxnnHpn1e5ItlXry1qLkjad+/nMz/Ozqt+EEYgRIcEL6O4jIqD0ty/7zZG?=
 =?us-ascii?Q?Fxgst+XWg2MTwfKn8Oeb34Q2g+X2IVAjUq30VS7APTkEWhfRUbROFWHl2e8U?=
 =?us-ascii?Q?ZzKrdR3TQ6Wb8bwwi5z8kgtLpPRYEqj6DiMh2myo+ougULLrJDAuRmN4/min?=
 =?us-ascii?Q?7CmehauDInbL7YbYTMpwukF+EBG+yGocHMLvue2bP0NFZpBrB8uZUyVp6iNl?=
 =?us-ascii?Q?z9yj0aZkc2jaupeM01kEx8MVhgDbFB0UWWadjuSsyb96X1Hg2E1nLDa3dG8Q?=
 =?us-ascii?Q?4TsOkw81OCf2flF071EqR+D8lxbsQhbovP+aHPsDd867lSkI/4BA0WQngKLV?=
 =?us-ascii?Q?MBOrEY6IZMItbKaD9ieBrdqSIny1cT49fMp938vQ6cJ+jUFQzx5PM6LFfZ2K?=
 =?us-ascii?Q?QuPru8/DQMHSkIHo+Wdas1MSxKCIy5ndxPM25spVpgAIixCti4kaBYeWJzWe?=
 =?us-ascii?Q?NFN0wGcPZ+neEu4KQRl8ddU5ul2Ephaii7A2zcQt0qmHxtY2r/4s6HWLKhCT?=
 =?us-ascii?Q?slIk7l13vw9C0RKvA89I7rtMJFwRILjWCOpZmZRC/b3Mmv3A3gv4Dporigd8?=
 =?us-ascii?Q?UAyAcof2OgvQe6hsF/TWmtfPRgfeB/BM4WSKbZTUg9Eyx9WNpvdV4Eqon6zl?=
 =?us-ascii?Q?WNDsGAHEIjTRz0O3QwdZJADHLQLVAf7qnCa4JnHTwtXNa2o/J91bY2TpUW0E?=
 =?us-ascii?Q?jMIdBcf2H/u7Ze8PgxFz2/Dskq72mwPs7WKSCrjMTCqeUuYrLvgJfp2osuvX?=
 =?us-ascii?Q?+gGxG7Vw+rbJco3N0Jt17sMSOK2EbJJSoqMSmhjdpB/y5G3vXjZy1d8xp04Y?=
 =?us-ascii?Q?5rhbZFOZdat1jzJCGtaS7A/+kfITOYZfKUsfyw6ArcQl6rjH24aubDE1jJ9l?=
 =?us-ascii?Q?3bF80ScNXtgmKuYlDCd3dcAIv7OrDJ3tln4uFj+s85c4CN9GATFXmlZgUrDZ?=
 =?us-ascii?Q?61xvXD82Zisv91rf5lqnpcLXE3BObYs3JBj8Vr2mn8pZ2rJTDyGxYNfsLv/a?=
 =?us-ascii?Q?rWcKrRmzMdwLuZP27lLymOFHvq34DMHenpHHf7+W2A/FWxGupLXvCvn9NnRH?=
 =?us-ascii?Q?Ce1GMd2zY5Yrty2eRAHPCfnW8cWl8Wy982nrZzwkgeEmP/fImIyko8mpBcQo?=
 =?us-ascii?Q?l2CTcsMkNSxa21E1PS7nvcgmHVuAEcdSG5neXrNcxxIrX6aAVq+PLif1R8rD?=
 =?us-ascii?Q?tC9JI/hjluaSXESNaB+wNKe4zAWiEfdFxOctnQR7WB7WBvbMJXQapsOMdFfP?=
 =?us-ascii?Q?gQb34qE4dur+mFDQHXfPWSBpHXEo3CAD/C3fzJHifVD52F9QImFyC7BEvgHk?=
 =?us-ascii?Q?56A5JyG9PH39x5iwMewGryDrud68Yt7AXgt040Nt1OqTyNXWzF0lsvviLeTy?=
 =?us-ascii?Q?8EC1C6IfxvY93Tcfx+OGm9YRPkwWiRsasqJWMhi/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b115ca-6c50-4a36-6ad9-08dbd92eeae6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 09:59:33.7683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoBg5LCOtPkQr08EUsiYEsoj3Y/yokmrFSd9j9uNQu/zlzZn7rqTjgjXkWMm5n03d5h2nBJcLRy71WkhQqgIHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

