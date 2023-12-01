Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2CB800486
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377721AbjLAHQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjLAHQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:16:31 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2047.outbound.protection.outlook.com [40.107.117.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C71D171B;
        Thu, 30 Nov 2023 23:16:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWDqxYTGwRELfFowCK9f5YFiRd3j/KBCeiPMVQkhW/bcUdSTu8+9YshfyRX7ycT01GFU0KpCXWfbSO+cK/sEpf3ny19DIvyUopirnDkr5cmIK7eBIUJJVMLyqMDELgDmYkral1ZLefeVw2L8kgmlaGAzTB0ItT904vIgKJcXY+Nu4ZllwOkxWYEOxm69ZG0wtkBGTDCZmAyMf8qcQM8A7N7v0dRssdOuxKkyD/Bq0gEFNXKJ1jdd0XBB7xE6gVruugB9qK0aTXHKBU5aM1yuQdTXmTvxntp9lM0HCS+hSJPsoHJca7HPc73hqD/DJ/8tYyY0ES8AKNEtgvWAYUXmRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dtg3Sb7WUeORxnfTa6IxBZVTwoHGiLFCIT9cX3ofiak=;
 b=UXMuWmaCw1SJy3LrB5nhOoJ0XFGQFD/L26qDO0xnm6ORiRfn+QVkwwhq32+Gi3iAr0cIOHyZKq5QDNxcc9SjtWA13hT+dM2YdnU2ev1mf7DGTpRQxxnxRl3ICk736TVIPi8EJFtV6RNbveeMjjcoRiRKUOXhDlfcJUvaDrLVIOiWaOxwNWChTN+k8+3ctvcBny7JUDaYK8hMSxy6jVO2jRk2F856O0p3IQqpyBO9I/bS2OmFaub6tWbODlGc3awduiDuQcWR8yDpON7NbYZa1ckOSRfu9npEBE9v5NmBKmuWUt0M2g2T6f2jTjQEHd52eh0EzL06igfG5E9O1pAb6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dtg3Sb7WUeORxnfTa6IxBZVTwoHGiLFCIT9cX3ofiak=;
 b=IPLJJ5eNjlNINzkvFrjOG/d2Htm43WZVYG0HuWcyecVof8g9wdVXqVMxwCBpl4cC3s0nAeWlUu8NFT56ihnOodHTdU6wvfGOiQjKLG8lx1T331bxDq4psNBsbLNOcbtt8OGXA4IPMEhNnMUshL9lPUOiiKXSibeSQVH1/6HIKrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KL1PR01MB6537.apcprd01.prod.exchangelabs.com
 (2603:1096:820:13d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.26; Fri, 1 Dec
 2023 07:16:30 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::1023:2132:c05e:ea6b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::1023:2132:c05e:ea6b%2]) with mapi id 15.20.7046.015; Fri, 1 Dec 2023
 07:16:30 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v6 1/2] tty: serial: Cleanup the bit shift with macro
Date:   Fri,  1 Dec 2023 15:15:53 +0800
Message-Id: <20231201071554.258607-2-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201071554.258607-1-crescentcy.hsieh@moxa.com>
References: <20231201071554.258607-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0255.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::15) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KL1PR01MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 28be55b2-ec7e-4a02-db91-08dbf23d709b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9u3/JEsslOfY6neJ++ljyx4XHddiZZdxnvyIwXLrva6wHQE20PVkHQ4GN/VHpFAi2n6G7qo6n0qbGWMO6qey5lBo7jSpA3/j9GKEpOchOcDweE+dJo6szieyJgsYFiPMpqrKpmpdQFvVEKKOLh9twU3qglSTL/9q4rvLLi633LxezSlnQ0+bnmzLIaRFE1610XCkBwqAzmJ3BEcEb4QRIdyO5s2K8moHxT0Ec3sxbHs9oJSDIu/ZjjyDL0ljOKhlAHeeNrtrpbBE2aoT0X6C2bV3njKAPSGuNHPd/DB7BcfF0mMbKwNb3xzf9CEXimXJJIlDgIrKRrLSI1UeTViuq3GvFAoJJ4cl2yACemFZlrlB3Op+POn3/g/6CBt+UPjzf3zTB2SUhgruW3R4vv/IJ17Ux/ZwCkVfQnggOJOcP25KTZpJYcQ7cRas9GybBhLwHKViTY3XgnsWKUuiYB+fXPhaZoZuEaFjdiHah6TKVLfREzl0e1lP5iX7s18FJmdBrXsZ3D06Jq0lTjkFBEMvn2tqU3WccUYiJjZSEtKDJY4yNfhUkpe3LHVC2t6khwjIaqxjhzN+7wXXufyzHdOzKzLlXzI2jF5jz/oGj2JCp9vKKPWEhWNrm66mcvY8vRK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39850400004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(5660300002)(2906002)(8936002)(8676002)(316002)(66476007)(66556008)(66946007)(4326008)(110136005)(41300700001)(6666004)(107886003)(6506007)(478600001)(6486002)(52116002)(2616005)(26005)(1076003)(6512007)(36756003)(83380400001)(86362001)(38350700005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?An7yLVzfDfjeomynMI0yFiDItkK0qyGSPS7JOhIVX5YlyiYv7GwapQclolvq?=
 =?us-ascii?Q?UiACCiucMgezIA0daqhflVz1WnAionbJP8iYzAhj3aoOwhN83ZMyG6HRvM7m?=
 =?us-ascii?Q?G6ubzyz6g7yT6QjPTPV8brSDJMzwpgE0LrLL03wHiQScva8WZs9BIfREWyVl?=
 =?us-ascii?Q?PF3fIp5/poLIUbZWufaWcS2V9Nb6ACVD4xwM4tuiglfWxMDWth3EobD4nWwH?=
 =?us-ascii?Q?wVb4rC5kNQi2WgIXL6PPW/k6UNIsqgDnnxo3Azt9FXEB9xp1x4QsxkN9WGuq?=
 =?us-ascii?Q?V4LgF/FG25TEUW2surNdmyS/MRnii+p5VaEXkXxBgv0kLY4diW6LY1dxdILh?=
 =?us-ascii?Q?c5c2oVOsT24LYait9EPJfUqw/s3Xl8oGNLrWOZqlCXDYeYz9RicO7je2AKbf?=
 =?us-ascii?Q?sm2nn5qzTkpnlUCy4455uq3AzllphcCJgyhc/eU/d8iX+6Ef85aR/Dadyubr?=
 =?us-ascii?Q?oZskjGiKrj5IAqajOoDTnF30X88/60V5uP0QbShjWVvIyPZYvDYzOJfFSpnz?=
 =?us-ascii?Q?wJzHUoFtXJWZ1UdkGLExglDZBAevRM7kcUhgl/EQT5jph8JTR46vKUwRfKdo?=
 =?us-ascii?Q?XHs/vdPvHu8byGXuVdPOKqdBTjL5B6TJvhEReKVZNfFlcLsrItr5nZpYgb0H?=
 =?us-ascii?Q?3AHVv74nGUEfKv6L5mRdi773OUJIvMO5m1eFWAJ54P+gGUQSy80d9hHFvDiJ?=
 =?us-ascii?Q?jq5S01E6DCi9yXkSZPYr/qqH9PVPALe82CJtOeG5EXgLQ1GRsxwhMjNLtNM0?=
 =?us-ascii?Q?FfVieiCaa6ENt6cP05NQVjYuZBIt6So4ZC55OW8vLj3co1QhU+LWizSqjqGi?=
 =?us-ascii?Q?lTBPgmeGbaCq81OH+7DTq39GBbnwqGK8PowpJWcP4v32KxlAqu1ZcaArgjzy?=
 =?us-ascii?Q?Y8+68liri7DgN76RMfSX5rIUP5ZJycqfqkfEl+Ju9AOB9m94vzrHWuKWHFTB?=
 =?us-ascii?Q?BArIHgWZKKkxSt9GCkdmHVg7cl1BfPJM9Omdz10qP0nzAs95lhyTpA1hdVYt?=
 =?us-ascii?Q?WN3x8QdAJ96ATS76lluaF4Mce5gHYLTWdNRWzoBQj6MW5dEgg+nLPCCGqr0D?=
 =?us-ascii?Q?KblITWgpw/9HBC7gPuXGR/N/wYrs+ac5akXKp4/HP5dwxFhY0794Xcs4PVsG?=
 =?us-ascii?Q?gia6YkuxXOnxhSlML6jx1uDTLly7UKCpz+MIUbLkEZLzUC3nnuKGxJrcetUv?=
 =?us-ascii?Q?qlmGk7cwyW2c3UqVmTDDKPwMjpU1TLKdgnC2xP43wAvvdfG7wMgKts/PTb25?=
 =?us-ascii?Q?zPZC96juXKKQs1zo8BGuPdaFj4pzODeWsKPb/9tLI7WOekUydIyAhDMbl/rz?=
 =?us-ascii?Q?O7F4Fr3MLioxynNQF8sxZkdlttmAjtYheDR4flKcvbZPf9SBCyvPDZwWYWAJ?=
 =?us-ascii?Q?86TvoVVjiVtd4pz4+6fVVaZfr8W/71z5NtDOZCObX7h+0wHxbueasKHNZw55?=
 =?us-ascii?Q?NcMzvkXVMWVpJSoEMfbIrpPwedwEsnLGSDtQCWjn+KLFytBZdTzH6V5Ou4RV?=
 =?us-ascii?Q?YDQA6t95rG/tFo0yeGgqKj1p/Ipoo3C7N00xJjVosuzWsH1Qr2u29FYrNTwW?=
 =?us-ascii?Q?GjhzCT3eTHovtnXJm+dmSVdMdl79xZEiIK00vJKx5prUODvLl4dLcfp7dd9T?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28be55b2-ec7e-4a02-db91-08dbf23d709b
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 07:16:30.0887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuxZIjYiAuztGSeWWFhp3fwwaV+1A7gJqjCaldYKDBKVpHUWEfuUFz1eWl7A376XZVMzc+/yP5kzLCdL73+kyp4I5aEzAY5oFtS9wMlbxY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB6537
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces the bit shift code with "_BITUL()" macro inside
"serial_rs485" struct.

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
---
 include/uapi/linux/serial.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
index 53bc1af67..6c75ebdd7 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -11,6 +11,7 @@
 #ifndef _UAPI_LINUX_SERIAL_H
 #define _UAPI_LINUX_SERIAL_H
 
+#include <linux/const.h>
 #include <linux/types.h>
 
 #include <linux/tty_flags.h>
@@ -140,14 +141,14 @@ struct serial_icounter_struct {
  */
 struct serial_rs485 {
 	__u32	flags;
-#define SER_RS485_ENABLED		(1 << 0)
-#define SER_RS485_RTS_ON_SEND		(1 << 1)
-#define SER_RS485_RTS_AFTER_SEND	(1 << 2)
-#define SER_RS485_RX_DURING_TX		(1 << 4)
-#define SER_RS485_TERMINATE_BUS		(1 << 5)
-#define SER_RS485_ADDRB			(1 << 6)
-#define SER_RS485_ADDR_RECV		(1 << 7)
-#define SER_RS485_ADDR_DEST		(1 << 8)
+#define SER_RS485_ENABLED		_BITUL(0)
+#define SER_RS485_RTS_ON_SEND		_BITUL(1)
+#define SER_RS485_RTS_AFTER_SEND	_BITUL(2)
+#define SER_RS485_RX_DURING_TX		_BITUL(3)
+#define SER_RS485_TERMINATE_BUS		_BITUL(4)
+#define SER_RS485_ADDRB			_BITUL(5)
+#define SER_RS485_ADDR_RECV		_BITUL(6)
+#define SER_RS485_ADDR_DEST		_BITUL(7)
 
 	__u32	delay_rts_before_send;
 	__u32	delay_rts_after_send;
-- 
2.34.1

