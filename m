Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5880D78B223
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjH1Nkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjH1NkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:40:21 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2027.outbound.protection.outlook.com [40.92.19.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37968B0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:40:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGu99Q2CKjIPFCkO3JttSO87Fg0BJQz7rd4TpV6De2pcH0OC8TcORAD1R7tWdsr4rBPmHiE2jm/bPHM8FQdrRGvmh/nL639z3qbv57tME3DySp+NPg48E6+mhxzRzz/UJzXD6sXHk2Fdc/ENLVpEDWTvEpOkUNP7ie4EDgiNwFn9W/KDGizP3iWIpcpqzVVsOa+yi+AUefjV+oa9tHcRzFJBLzh5nWltPabASgGnbiVxtzhG4hQbYG641PIg1FTGvP//H4i+LOgpcbKreLy0EfT1GOnYaiiLbqN/y/NL94Ecgze2v0ojSpySfP2e00FDB68wjXcPG5ItNyoDIqsR/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3y9ERjETTcdrjUz3wkwuYJBs5lWfZVacx4Y7LM4v6gc=;
 b=KgIFSBPmRrTZJRyTM8boBihGtnVRZv92e44YM6amvjYBPk6S/v4lU2ndp9NzG3hIeGBqt8JafBGXTeDVkaS1RT1rc434hrmt046GiWzsIafL0RNGZaqYIzCz7xXexdf49OdzL6Fo4hYEjeQM6TwvephICXsI7jXy4+hpYqGEHpSQa8+GL9Geg/Vzpzn8Gf5MTI8U/xsrsD9oR/q//AvZcAld4Y1G5s8p2irofTd5RE0RxZtGECBRT2+GgeVcuK4oNlnBfRgug65YF6QDIKJOzvJfewCNu9TwtRN8yeG1hNjOcmiYNUjEHW/PpBq7XutZLWQcKbWZg5cZayMm65G2YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3y9ERjETTcdrjUz3wkwuYJBs5lWfZVacx4Y7LM4v6gc=;
 b=lBcw5COdhannskE8K3NLbaBaPxVdjrFEQtFOGOIx0XmMdNbtRJrHguCdwTEGHmL5l3M8TenUSZvAmOkMAfVDNAc658bsNvTCRDep2Lw8bwNHc7gYeyOg/kXXFLWNOxHPEhZKgyXbGLVBMDWAN/YcW0hlcnjIJ/u1ZXPiAvHZRWo6kvAOj6v2jt67F549mIIRXIpz7WiEzf5EoHYOpwc/5Zyx3rv5Gwq3sOAtfn7RdQvvGcu2dQleGlV/WbsBMnsAJ3Ff4y7PPjKL6dC9UZL63mCSwFKrg9xy/aakbn3c1AbmEswgFd3/tI98FvQQww8X5ibWg2TPUSgcMWwkG1AO+A==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by CH3PR11MB8773.namprd11.prod.outlook.com (2603:10b6:610:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 13:40:16 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 13:40:16 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v4 5/6] staging: octeon: clean up the octeon ethernet driver
Date:   Mon, 28 Aug 2023 09:39:18 -0400
Message-ID: <PH7PR11MB7643341F2A303FA46CEF0E44BCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693229582.git.ozlinux@hotmail.com>
References: <cover.1693229582.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [SB7wC4poit7RY0CZ7It3duVxHi+KxoRn/LwiWguTqS+qDHD0u+5dxR6qRTZ+OXDc]
X-ClientProxiedBy: MN2PR17CA0033.namprd17.prod.outlook.com
 (2603:10b6:208:15e::46) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <e9630d0489b3a584284affb7a4a26b59d8213d36.1693229582.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|CH3PR11MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7af89a-4fbd-438f-0aec-08dba7cc4ff4
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrG3vTz6Q+SuP6RiQs1os6r8wdTtAegVXL0Qu2JOMfKIoyGz2+893OrUWAqhgza8qSV7CKTsujmtJHKe46fBj6VQN28s9mUSnULGd6eDCawzZdniXiIVNMqKYIqLeaU43geCFGj2HCDZX9l4QxBF5wTGqqWpNoA4E7UomsqzCPkiPnasjzr4rT1tomhufftgcNKb0N8h54cJQEBsFLIG7RynO9Hx3dYdok3RLyf+cMbkNubqwplAcrx9NSwYlKAdTF1H+BqHDCoR88Udnu0LZ6VcUWNeEZANMrN0ggaRpuW1IofWOUxZsTt0xFXt5xzQFz1AFn1KRtPSQ1T/aYYLEzqwsTbUumPfp58nYyombjEufLr9Bv4dxZ/ikJzi3n0TzsVbLseV/g/T42zO6A/zzxl7kuCAVQgUlqvZHMDd77l8iop/FSyJEFeV/ZwhmczrpTr13Hx5BdO+NssJDzhITL0rJj0jvs0jNyViUgAwU670EaQSmNYjWbNarHfqK4wiNXXZP/QNAObJLRtGDdmPOxLsjH2E/U3ELm1ECTLBkDERbL1qms+k7Y3Af8ZHjCtCz/WUxHVsvlaBK3tQGA178JIJuQdOMnz/fFdmdiDMyeI8QkexhjLYXb9pXsXLKF46jM3XeX5V1UhzZJCO2beimHj7nObYRmN/SejUnM3xiCK3z+pW38ocoKwni2+v8LNQKppuWExwQiltYK//pyZ6mQA/qhJn78o7Uqepo8KUm5XyqZqiqPX4hQlTvKEaaETvg0=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XTUrm+cpQ16DHsnz5l1O2S7tBcqWfwaGhFoH53A1XcaMnvPR1nckWTlnGueXHuUyKBfFsZtwZWQs+5BVWh1Pkzf/Zpmc3feklqsMQTsEMZwFP6DRLh6ZEu48e1GD+OttNqP+CNODK88K3cLjj3Zb8K6iL7ObqCl4N28dCyI0OY7TarRDWypJGtuByTkTUSlp/zhkYud39OyX5RpQayUmhJO65tEV84KwUTvqt8T1ngAR/hdJ1MUhrs5eCd1vL4XYkD6UBrRXvZVi2fzpqPduzfWTw26Z1h+sL1UgxV+yZA4nN4JZr31CTg8rrPlDSIgZfTzbGJYpjkkdEnbt0SDPy2P0+bXBcFqyDPEYkzw3EKJYSKFfBCOMOF/Nx52JrLcZkCDrKt2x24XfcYYNVBlXIAEuKDgVJTGZVzj22ezpb7cmFO2hOd1eAG1ipfwW5lMKGhPoxxFzqsrLASwXC7IP5zxvv2tl8moGkVuYqtDJ+3IFS0lM5x1Eguc3EB5RQA+IjJAaX3IW1ozcotkeEgNf0TqsGtKyABEb/OY6TNxZx+pW/xCy+C1QmqGYuiNgEPBIfKzcTMdhX4bOnJ+idtJwoezhcuzPcAX55rfz6pxOcwHZfrzrXXB1BhU9rNqCNBcf
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yOS1/iZgFSXsHtg4ceAPND6dKp7DpXzfu7M4GwTDZo9NSxfq5ZJUMBb5UBLW?=
 =?us-ascii?Q?5Fg3UEtptneiDbAXGMjNWE5Z96iJLRMJPSZrbnw5UJR5+080s5DY8J89YBkw?=
 =?us-ascii?Q?Vn95axpACgB3WtPVRFNoJ4B1FyM+M4JbAByLuC55e1Q/BkwxoBta1Vz0UzCf?=
 =?us-ascii?Q?HcF314S/QVDnnE0yK13AD3upJP7+YKM6mtirS8rAxAEgiQGZcDiHPGcF90lG?=
 =?us-ascii?Q?eCHXlP3Rst6aOCYdrsNFiCLI9F1yXDJQJWwgEfmIUOw3nohphqvMCmtRtiWZ?=
 =?us-ascii?Q?yUUvjJHNU+vOIPQ6DlSzh/H7jsR5GPlVcL24kFJHIKbotIOUcPRfG5LuCq1L?=
 =?us-ascii?Q?b0vexAtdA9ECAkQ5OcxFleLDLNZdhwpuTzqJbxefMonWY2xt94J1aR0t5rJM?=
 =?us-ascii?Q?WYMFN4jxvvevEHSrqZWzYTBWUbj0N6JAbaiDHMNRCKu9CfyM+4TccmPwGkBr?=
 =?us-ascii?Q?MN1i/0nSInh0L40zsRzu/DtML6npHILrPZdKjt4FO0MKpez55igD++tKm6hq?=
 =?us-ascii?Q?LHYNXIMGcc3p13ZKk68D4DDRhAqFRYoxattHZAo8wT8P/gOZ7J3jcx0h9M2G?=
 =?us-ascii?Q?SoZFoMyR4MMYplcFibtiG9KCOwGw/KTHZAYGktIZhJ3Wpg29MGBVQTIllCWV?=
 =?us-ascii?Q?8t8Bqb8wby5s8soo5xC1XCczc8pj4bg0xwq74LRDFr6sJC6D9AQ/5OrE75cD?=
 =?us-ascii?Q?uIK8Zd92C+nA1zrCTpbN9mT9FiMj6+xbEwaCayPW/neC217aPqgyIFCHtOX3?=
 =?us-ascii?Q?esAUqUNj4kyNhINwwUxSkS4UbJw3E5vygbM8EXz5AbRAQ7SItK0B5TjAv5ob?=
 =?us-ascii?Q?vQEbqtASVrLjoNOC2vw9b8E8YlERph/KcxHYmeeptuxpiJTwEMSZwW6fUSgw?=
 =?us-ascii?Q?xvWuke/0aLQo8NS9BP1fCExOsdFrMDn9WyGR9HAPMnVVz1To7YaPh1FbmzOi?=
 =?us-ascii?Q?bzCXhq0zfarGT9regZs5KmEXzuh6Xpnw3jghjL4SXBg1xydcvnXeWUWe+Q1u?=
 =?us-ascii?Q?ZP3kse0y0n9vdf++Bs0NJzMjNdnaPr4E186Rfm82jxMl+FXL8xDLJFXdHitj?=
 =?us-ascii?Q?+VfTRbTzOqv4l1NREmifWsnvFG+ApUUU7whuFGNPrRjPCA6A9Ya4TRhQ6DVW?=
 =?us-ascii?Q?wupMdKjUkjKlGIuaQ8LVdbnNqlGsWOlkH0YQpg8l/ThI4oZ+ItbJM2L0+Opa?=
 =?us-ascii?Q?cvAU3h7Lma9gcIgREo03gPFJ6dUdhgq7/sFwz5lm5LdX6NERlHedSyPQga7s?=
 =?us-ascii?Q?K4TvhI+0qGqNAX2bQUG7V0XoMgPi9SOkRsPwq4Gpxw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7af89a-4fbd-438f-0aec-08dba7cc4ff4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 13:40:16.2889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8773
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the octeon ethernet driver better adhere to the
kernel coding standard

Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
---
v2: Actually send the patch set properly
v3: Fixed a bug where I forgot to change all instances of a struct
v4: Actually fix that bug (this is my first patch, give me a break)

 drivers/staging/octeon/octeon-stubs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 2cdbcbd8a97b..b9852994882b 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -244,7 +244,7 @@ enum cvmx_pko_lock {
 	CVMX_PKO_LOCK_CMD_QUEUE = 2,
 };
 
-typedef enum {
+enum cvmx_pko_status {
 	CVMX_PKO_SUCCESS,
 	CVMX_PKO_INVALID_PORT,
 	CVMX_PKO_INVALID_QUEUE,
@@ -252,7 +252,7 @@ typedef enum {
 	CVMX_PKO_NO_MEMORY,
 	CVMX_PKO_PORT_ALREADY_SETUP,
 	CVMX_PKO_CMD_QUEUE_INIT_ERROR
-} cvmx_pko_status_t;
+};
 
 enum cvmx_pow_tag_type {
 	CVMX_POW_TAG_TYPE_ORDERED   = 0L,
@@ -1384,7 +1384,7 @@ static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
 						enum cvmx_pko_lock use_locking)
 { }
 
-static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
+static inline enum cvmx_pko_status cvmx_pko_send_packet_finish(uint64_t port,
 		uint64_t queue, union cvmx_pko_command_word0 pko_command,
 		union cvmx_buf_ptr packet, enum cvmx_pko_lock use_locking)
 {
-- 
2.39.3

