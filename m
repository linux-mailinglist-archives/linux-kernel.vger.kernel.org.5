Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7828A7ACBC7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 22:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjIXUCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 16:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXUCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 16:02:14 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2079.outbound.protection.outlook.com [40.92.75.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39BFE3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 13:02:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXBWGW/Od8cfuFEuSuoX0I0GjvP345zMNYJsQhVbVuG5//VG//VCn3DB75QU0wQQMDaeXHGc0lLHaNjdUjRmC14b5YyGHmREO3crIUCzQds0Wtd1ds0qYD/MDcitsOtQvXTOv8grbQHF2+ZUhFYE+86dGoXPdrdb+3Fw4maS15GRa0nCLSptnetEsv+v5uENBabkSadEKt45IUgsSg0h0k5fRmSKcZgTh409sict9rRUGbATyflfksfZSrdtFalY5L7ywcFPcJIDgAWGXEQgflySGTF5AdRTY2mNUhlf47kqBo49UHF5PtgiG9lB9BQdxu6CJPhjRBHVu06OFAgcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zMmPpm2/LNk1iw1/POJSD0lpPE8/UMTzHPTuSJM3J0=;
 b=SLIyjiug+7zYcc7XXWjVHG5mrdKZoTFxyBFMd0xaQqj6XjIGanIfY9xFMyIzfk7N7C9Jn3yXvvSGQJVB3pa6ZwK51ZiU1QjhtKp9dscttEMwpHWqMOe8ktQIy4iHgb5P3gQRptAliZR1trutzZ6p99ULc4ZdVEezYVXXNF+YlIdEFpt1fsnbSFVSjxvjg0VmoUkt+lsSca0YN0X0I+VeqKmKTfeJeWV1Zl17C1q8ZBsnC77YXFUYseoVF/zW8JQCzfHeNHAXhsgzFrwJaBzqAe4mTlNcE4zaYb2CawVaNaNAyT2Ig3ZfBCoTbH4Lu/I3vGNTanHNhQI/LYokCfEJ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zMmPpm2/LNk1iw1/POJSD0lpPE8/UMTzHPTuSJM3J0=;
 b=JW4ah0qIq25j6OCaIC/xGji34Yb41PAe0S+3Ywsx3hBgThx2fdigu6g8LAwlJNK1/VgDAUvmiZ0HL4jDH8nD1cikNoHZk42mRcfMkUmuJnu2FXI2X0uQRe7KX/lWncZtE1+70zphUkhQ8O3ih0JxGkVlrfttOhGi87sNtK6Z2v640C9kga1D6AYtXprZY/k0qLmsEDsVd8oEUdl0c/Gp6nXZl64wt6m+5mW/yRxhAZojNLU6dfxbfXmJ7xQz6SFws+xu7fVkmDm/n7dzaos4GJfSaZNqIDUvizl/YTlX37aHDAN8fDZCgYtfdwmOMbs/zNVh9iSZZxMmcVkk5MOHQQ==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by AS8P193MB1366.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:38f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 24 Sep
 2023 20:02:05 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::3164:ae5c:78f7:23ad]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::3164:ae5c:78f7:23ad%4]) with mapi id 15.20.6813.024; Sun, 24 Sep 2023
 20:02:05 +0000
From:   Juntong Deng <juntong.deng@outlook.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        aurabindo.pillai@amd.com, shiwu.zhang@amd.com,
        Bhawanpreet.Lakha@amd.com, harry.wentland@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] drm/amdgpu: Add description for AMD_IP_BLOCK_TYPE_VPE
Date:   Sun, 24 Sep 2023 21:00:26 +0100
Message-ID: <VI1P193MB07528C2081A3A8BBDFAF2BED99FDA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [loXNGlZAU5T5/pnQdg+ieH53r9I31buu]
X-ClientProxiedBy: AM0PR04CA0041.eurprd04.prod.outlook.com
 (2603:10a6:208:1::18) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <20230924200026.27339-1-juntong.deng@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|AS8P193MB1366:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9e450b-25b3-414a-6cb7-08dbbd392001
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5gDLV2k1poijLEDBCV7+ho/mM94DXXeut7MZ3NVNs2bMdpvps4JkyLSwLc96mhiQn+GYAWCow316rXwQ1fqRSZwZ0oHgrZl39NuRrNrOZv5Y7olRJlaRmi/N25QJpLDEuvhb2wFT8/N0j/+TDbZWZkyqGHVyU9Qqro7DsNd5a8YdqLojJFN22SJ/m+F2jjIKHd4kyXsEajMe15IThN5sHG3kbNBUb1NaJOxGvOiqkEdnHBHcMT/uMMwoo1LuG7+wkXRTtz7zXvTUInGPZIPNu7ABz5y8fllMeNoHFAg7AH+3WzGyMIdJNwhD7Me+Bxw/yU7QKJutZL9SchhtfpOIHbAiQWwpVbl65ZRAAtYMWWWUFgSYEhSN9WZsAVZApRsY9vqSSszEurDmoPshkfs9FE5UtLOkSW2JqwG/KZDtINLyZb7ANMTo1PBUPCmdMtHftMb2TYe01lXn2DpHXmR2xfn7aFitwObgaqpVhoUUJo/HoNbPOMo93GJ/4RruYnogPSZYS+q/LMKrZ7g0/HTY5e9VdIj0LDvA/EcpElQu2kSJss3t9sqHzVVKT8cxKg4m
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WD5QN7OtJ2URoB+U3k/cK2FHRCAXYLGGYf6RfbdpIqRP0AFghlAFmda+JEYM?=
 =?us-ascii?Q?bvnllo0GMr0UAjkQsEoT1wSzYpc/BkfpULJBE1YY1CQ3bu4hpljtmNAa/vpU?=
 =?us-ascii?Q?zF89HGIQBKKVTCPBr+Jc4AX9foLDiTz8mr6/NJRg+sibC8kZB+TrwgKVYCEd?=
 =?us-ascii?Q?3+oL256AxzPa3sLw8XWA2HKq4yx2SEIhyZphB5nSfe1/e1GAagKy9HucWs06?=
 =?us-ascii?Q?faR/2JE3pS+uRWjEP86mcB9mHHjXlmyxoWwciMt/kbw3J9c/FDd6ndblueQH?=
 =?us-ascii?Q?IJj5eD3PQaN675w8vshUGmGPJuOk82wHHxyqrMlth/9lf+GDWeuHqUtxV/IN?=
 =?us-ascii?Q?lVV9wGYg3PlANt5i7ijwhB2fbQhvn2hA8QMWst8ZeQOQDbkkaKAsh6kP6qt0?=
 =?us-ascii?Q?9ZAzyXrTaUoi95YzXxVoQ2O9ao5hlxgS8YkHKYqeF+GlaLfCVZkOau9X2a99?=
 =?us-ascii?Q?sW6hrE0hA08bsN2yZCDqrLOLPJiL06qMlHMHzlB/706bSJn57iCNbr2ddzxB?=
 =?us-ascii?Q?3pXhgLzizpLtBs/MT2YjC6lYITljZTc3ywbCbVk2g8gZap4m/Nf5QQGExZU/?=
 =?us-ascii?Q?3dZfF71RFY7afR0Icu/n0sY7l5v0T5dVpSrmOO8JpD3rCbmKjCGEUGZxqU9+?=
 =?us-ascii?Q?CEF1OBQhQU5k3y9LAc2cHiQ/1UDtqpFadSsGm23dFYKWQGsh6Mp78W2FIO//?=
 =?us-ascii?Q?WOFGXwW9U0/qRRPtwOYDu8FZKn0dYCs8pO+7IGGBVEyG4wyyEb56ddoMznm6?=
 =?us-ascii?Q?E09ZzvqNbknMA+CHdlpCVwWCoNBABPEB9ktkdS7jzZF0WnZ0eRSqnyM7UXcG?=
 =?us-ascii?Q?XrKYwku1PSvU3QmHZMmz6N4TevDR8fo9TKFdR678woHzr4riZNm67ySdX2vD?=
 =?us-ascii?Q?0N9EerHLfYYKplfTXSFMjwAnQbSxntsAGbTco1Aj3RsYGUT8LmYqtstKErGe?=
 =?us-ascii?Q?W9XKn0iLzA9fxrvZi1v6XBVouXTijGYiNISWLlgaxnngFfAe01Qz+vj/C+KL?=
 =?us-ascii?Q?8j/9fTSEWeAou0GtA3qEa01fLZD+xcL4f6CWXbe//bS9lutZSyL67fanJmDx?=
 =?us-ascii?Q?Xy2PL8UG1Rar0MfoPCD4fIVkwi7l/ZRzw+I+6G8sQz2TUTb9FcNBdM0xEROC?=
 =?us-ascii?Q?r/ijYkICblwbwW4I5W9AMSMQ7QJ2TNJQUr7I3uieifr40Bg7jP+WmrLku/zx?=
 =?us-ascii?Q?07TXKxdXC1AIY08hCAA2GUixwPoXEWLK6NafYWfs4uLs7buXsYewJMwD4j0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9e450b-25b3-414a-6cb7-08dbbd392001
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2023 20:02:05.3671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1366
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD_IP_BLOCK_TYPE_VPE is a new IP BLOCK type for Video Processing Engine,
but currently lacks description.

Fix the documentation warning:
warning: Enum value 'AMD_IP_BLOCK_TYPE_VPE' not described in
enum 'amd_ip_block_type'

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 63e2153c00c4..314fd44ec018 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -83,6 +83,7 @@ enum amd_apu_flags {
 * @AMD_IP_BLOCK_TYPE_VCN: Video Core/Codec Next
 * @AMD_IP_BLOCK_TYPE_MES: Micro-Engine Scheduler
 * @AMD_IP_BLOCK_TYPE_JPEG: JPEG Engine
+* @AMD_IP_BLOCK_TYPE_VPE: Video Processing Engine
 * @AMD_IP_BLOCK_TYPE_UMSCH_MM: User Mode Schduler for Multimedia
 * @AMD_IP_BLOCK_TYPE_NUM: Total number of IP block types
 */
-- 
2.39.2

