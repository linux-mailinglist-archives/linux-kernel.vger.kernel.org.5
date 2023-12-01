Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26C280164A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441846AbjLAW0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441843AbjLAWZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:25:58 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20556D54
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:26:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gI7dXhz+mYKhvnBa3ybrOW3r+AYM4CJIEfDUfaB2FdkdzJQparT5uepCVsTvOeQi76ZKEqlKcSYDJhO6nLsFYLPT2Ui307k0H292HYsv3E423koDQSTtMciPfCNFGpQcia2JCvTARfjCwTAEM/53EpXc7vbT0cip6i11C9zDSmbj3dw/n/Aigu9g25w8X/RknflevVynsqe7nmrEGRW1THmA8DhwAbgDutbrjugrS7Qi3p6z5aSkeqUY/oTyQeO0UjSg2nl4s2wcHH6Bfj/iTEpywGkZbfl9cPfTWwFV9BmsBYbhxLppjLBmCxWzWmA8pNIUGHGJUfyBSxMnKEOyFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytSmslj5oOfXj/kvlZ0mw3AYP7VbssW1sje4uneG+bA=;
 b=OOu7NicjXo4y4sfIACOBfyQ9K18eeIXJmF6Gn21M92G1L22u/e23kPXT1VSy37Lq3/OpBY53XgbXVaSOd7HFikztr6DgacLArCUd2uqQhxws01efNcPll7FUhX/PL9wtWdZRPuc1TOd+6HaoP4L9drdMiPx1+VBJux++gz/jFbUweGMgfn20zTjzSty2sg9CFYhPLabOkczCqgCIpzdDWSDhwIDnfjkm9eYeBZCQnMWPxG8SF4I72UtTc2VFAhqfrt6oeeCpqq2zUAYlj70cPeDrV9YvKUYeVe4P5o/rfMVtaYWewCwcHEMwBC5+og0E7L1Jpl+cPRU9Zj7uF4JO8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytSmslj5oOfXj/kvlZ0mw3AYP7VbssW1sje4uneG+bA=;
 b=JOunq7HbhLZHE+jT2FjBvJBXU8XQmL6FcuzAAtaNuJk1NgJMykpNoWKpj7DafQZ8vB982rtRWNwmXdW3XcKxJ/ZVx11Yo6Dv3SSmJ5m73KtyauzRwJNrOtgidbFy2Z1bR1qlCneWLIhyK2bUKIFire7aURyG82h2a6eVI41l2qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS4PR04MB9573.eurprd04.prod.outlook.com (2603:10a6:20b:4fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Fri, 1 Dec
 2023 22:26:03 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.016; Fri, 1 Dec 2023
 22:26:02 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com
Subject: [v5 resend 3/6] i3c: add actual_len in i3c_priv_xfer
Date:   Fri,  1 Dec 2023 17:25:29 -0500
Message-Id: <20231201222532.2431484-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201222532.2431484-1-Frank.Li@nxp.com>
References: <20231201222532.2431484-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS4PR04MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad3cd6b-5a01-4d9c-85fd-08dbf2bc808c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vKP/NnJ07gyG4MTJe2TvXhceAzuQsoxkj80mFiMAnF8jJu3dq1mXdNfEDMvnwBHZSJVNUGZAIwMajlKheXIN7dbRjhJ73S8RzPvolTceunNFOhWdsjlmJA8BgOLtnvNv1lUdcLtUoeJ8ZHaJ4MfurJ3viwnIF3g8pRjHe00TVBVXNv4WXYz4PB20LrFa6Ew6EQaMv03/N2ASke5I905P1+G08izwV/FpOCqRZ35mZ/xiUn5oBwZi8ZeksSs79ClcJuCnF7HxNvZf2JbnxylJ3Jo3ji9HRGQIk2EQj+2IPMDC6vmOe4gxGIxOMZU825xa3Asgq4cqlurTSwVWZRw2meETwbhsxEn6U4n6KKpNdeHcgCDgI7woK9u6z9mdyUF4PxiY3zMlg3BtU2F1GdGsGdAndNMOgudecJNklqffDk7Hu3twF/goyykqimkgKIpVljLoFqoA9M6LlipjNUY3uKKNuHcoGnfb/Y5Gqjp1SNdF5BTRClYGjtG5gck/cJhraXLYzFPqeeCWqvrhmDYaTPdkPw5E+sepz2Rp7eHl4zht6Vxa/2TbCbYdkRt3tOfbI1tQsZTRJx7vsfvkObIU1mqXtoBeZFkpDJUtym2T67yp5elfOFgH6g8CMw56f90s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(86362001)(6506007)(26005)(1076003)(6666004)(52116002)(2616005)(6512007)(41300700001)(5660300002)(8936002)(8676002)(6486002)(478600001)(2906002)(4326008)(316002)(66556008)(6916009)(66476007)(36756003)(38100700002)(66946007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHlEMVpzUkgyVU0zN2hIY0lqMjk0Z2FSRGhWSVV0U1NITGsxZXU0RmMzWW90?=
 =?utf-8?B?WWh4TmtwQmt4eVltVVoxVCt3dEs1MDlMaFQybmw5KzFZakpvbTc1elBjMm12?=
 =?utf-8?B?OWd5MEd4c2taSnNGbFl3MWNoMUgwTXY0QkpYRW1TRGFlR1lUUXZDOTZCRC9x?=
 =?utf-8?B?Z0hMaFNxZG4ycU9uRnQ3UlRvN0JnbmJKVnNWLy9oVGdkRHprdm8wRHpxZ1FC?=
 =?utf-8?B?b2UzYVo0SEx5ekZER3JjL295SWdpVmVJL09QbjY4UWpaWmtyOXkwSnRSS3BZ?=
 =?utf-8?B?dytBQzF5TFR6UXZjMUZybVVJaEtIdHJVWHhsZHFvam5jMEJZNG1OeDJwMFRr?=
 =?utf-8?B?M0J5aTJGR1lMWmxUa3k5ekZwRU0yY2hHMkcwaFh4TFgrT1F6eldYamprVVdl?=
 =?utf-8?B?Tzgvbjh2MG9pQWVweTF5TG1nZ3EwSk1QcVJseHBVZnpWS3d3WDk2VGo1NkNB?=
 =?utf-8?B?NjdPNE9ibUhyZXBuRFFPZmxIZWRwZUVkQnFWbHZBUStvRThXTzlxUzR3UEp4?=
 =?utf-8?B?SmNXVTNJR0FTU283MGJ3R29VY2xUZDhWM3Q4RnhsclpNLzNHRHRObTl5OHlY?=
 =?utf-8?B?cC9kT0pUdklCbE4vNjBOcXViclVFSndVc1hNdGpBY1BqcXdGUGVqZXFNNVFF?=
 =?utf-8?B?NUNVRUhRZXRNalZLOFNTRzVIQnB3VGZzamEzQVNsTHZwdGZCa0h0NmloY2E1?=
 =?utf-8?B?UmpVRFpVNjlGTTdBSGowS0RtOGZyT3U5UTBVM3pEdGI5N2t2YzBXamxVdmho?=
 =?utf-8?B?YUt0dCtOeUhiZWtQcWZtdWZqOFdtNUdOSUZmRTV3MWlQTGxNd09henNMZzF4?=
 =?utf-8?B?ZWJlTUY1UW1IbUFhZk90Zlh5T3dVT29kcDNBcndnVlZXd3pmaGJKejRLMEFq?=
 =?utf-8?B?T0F4N3IrdkpkZFFFVXdaNE9WN3VLNlZ6UkJoV1RjRU4xODZtZDdzc1Y3dzN3?=
 =?utf-8?B?VDBsRUdGeFVUcUNSZTh6NDF3aWt1RDBSMWoreHVlM3hkZEYrTFlpQWlYbDM1?=
 =?utf-8?B?Ymt5K2hkMVJBQ200QkpiME1aOVI2dDh0bXgyaFk1VVRpTklXcVlubURFTnRs?=
 =?utf-8?B?dUhQR01oanhCR2YxZEJleW4ybDRmMDBHaXlaQzA3SUVLNHBNWEhnNExLM256?=
 =?utf-8?B?R0VDT3FmS05OcDd6amovdFRKY1pZdHB4UDNXWG9BUlBEN0tVdzZWSldwRmU4?=
 =?utf-8?B?aHYxZzZYU3ZkTTVpV00xY3VjZER6cHRkRmpRc3MvNllsVjc2TzdVK29TdjdX?=
 =?utf-8?B?ZEtvQXI4cmtpZ0ppdERhdi9KV2o1aUlpeENYdktXdkVzYmN0by9jZzFKNlNR?=
 =?utf-8?B?R2ZCNjA2dmJFc3IvaGQ2RWRHU0g3ellvRTNFWEx4d3plTENpTG5VMUUyZVdp?=
 =?utf-8?B?ZHpnN0VHYlloKzFPNTZDZWdWY09uMVYrSXdGRW5NUkE0MDhvZ21oS1ZBVnJl?=
 =?utf-8?B?SlJEeFN2TERVTHpjNFYxKzk5akpoMm9WenZrMVdUN0xQbDhsdGlxaW8vaEJ2?=
 =?utf-8?B?SnpkYzlXZEcrdncrTktTVXRZWEZjd3kwSlhWbEcvRnQvZTR6YVdaeW9uSTRU?=
 =?utf-8?B?c09xYlJuaHl4Y1gvcjgzS3dnRVkxOWFNNWVHNk1LdVlzOWdKbzRnekR3YlB3?=
 =?utf-8?B?b0JoSStiOStuWVhWd2owbmtLZlV5emE2ekFEWlNZNkFiWjBWNXFkRWdNU2d4?=
 =?utf-8?B?UWRPbUxNd2hnaEZMZENxZjNMMlZzZjFRelJUMlRqZTZRbGVQYlRVTDZIZnli?=
 =?utf-8?B?eEVPb2U0bWRrMkQ1MFY1SEFnc2NodFdrWm15UFd5dEhBTTFEdUw1bHR4TEZ0?=
 =?utf-8?B?eDVGV3JHMG9POE9FelJaQkJ6bUtGc3hVcmdMVktKM3M3UDR4Y2RVRnkxWnd4?=
 =?utf-8?B?UlZmUzNycXN4Y2ZCNTdpeWhhODdBYVdQbVdETHJYdFUyVXRxNFVEbGVyUXh0?=
 =?utf-8?B?MUFsQk5GRjVvZTMzU3FZQk9LeGNmWjBiSFQ2cFN3S1h3aVkvamd3ei9JOXky?=
 =?utf-8?B?TngxTTBHVitSZGp0R3ZRTng5YUVWUEE4clJveDZHcjc4UVd3R1RBNGl6a1ZG?=
 =?utf-8?B?Zmp2WFdIKzRmbWdjaWtsakUwNTcrcnlLc3lCZi8wNkEyY0RDUlVxNzJPU21q?=
 =?utf-8?Q?Ysa/mhk1aQpPOfceX7qCQxfo8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad3cd6b-5a01-4d9c-85fd-08dbf2bc808c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 22:26:02.9291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7m/GcAvMDmJACM0jynTnXT43VoZZzdffftkZpGQ1NZrlIVHGLynb+jb92++UVN9jXtJtcE4m7n+h1zXPl7qOAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9573
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In MIPI I3C Specification:

"Ninth Bit of SDR Target Returned (Read) Data as End-of-Data: In I2C, the
ninth Data bit from Target to Controller is an ACK by the Controller. By
contrast, in I3C this bit allows the Target to end a Read, and allows the
Controller to Abort a Read. In SDR terms, the ninth bit of Read data is
referred to as the T-Bit (for ‘Transition’)"

I3C allow devices early terminate data transfer. So need "actual_len" field
to indicate how much get by i3c_priv_xfer.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    change from v4 to v5
    - Add Miquel review tag

 include/linux/i3c/device.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 90fa83464f003..ef6217da8253b 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -54,6 +54,7 @@ enum i3c_hdr_mode {
  * struct i3c_priv_xfer - I3C SDR private transfer
  * @rnw: encodes the transfer direction. true for a read, false for a write
  * @len: transfer length in bytes of the transfer
+ * @actual_len: actual length in bytes are transferred by the controller
  * @data: input/output buffer
  * @data.in: input buffer. Must point to a DMA-able buffer
  * @data.out: output buffer. Must point to a DMA-able buffer
@@ -62,6 +63,7 @@ enum i3c_hdr_mode {
 struct i3c_priv_xfer {
 	u8 rnw;
 	u16 len;
+	u16 actual_len;
 	union {
 		void *in;
 		const void *out;
-- 
2.34.1

