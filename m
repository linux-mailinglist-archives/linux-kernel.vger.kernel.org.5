Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE68B7D752C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjJYUIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYUIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:08:43 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2128.outbound.protection.outlook.com [40.107.223.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F364183
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:08:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHmgMaXuLBUdlzm4JXazdAKUVDVTWqnRo1v0OKltUvuWjZG/mqien1y9Pmgg6MCtmkw8lMw6bfGPt/nGlZLTyGCJ9HpxcpfBBrKxt666cDxl1J3D3Sy4nbMpUL/O/rFt2O3FMmjOPHWhxySPebpYB9prRKhUeoJxTgzY7E6cK4fglJKcc2dgyd+blTPiTSplJekntOm9TPeoDgcp/JvRu/Wz2ZHDs9mDxZqzrF3J6tNt7Zq7oxejLbIK+N+PgO8hU426kxaY3fZe/HY2VeC8jRnzKdIO3IJRZhXbnFC0gImvUphNBozu9FysCeGzkK0XHippWU8PK2nAmnuDhNHAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VF92Gu+bsHYurF5m1ieE8BleJa0LFpgfkNUhDPm3Vo=;
 b=katxf9adiJU2u76PRC62kEiZhjQJb4OBmAjHdBO6Pf0ms5v7fvanawxAkoJwnez7/XQPI+wWdFNzBtiD0DpJITMfaCjIRB/3RJwQIb+/BGvOIuBuwcPQfjPT3qKCgzMn2QlstukMa+pehkN6VzZlsvnQQL7IX7JKn+Du/oWFfcwImpiSTDNGQbw/eJGUlY6npA2achqopyI2z/XxavaUT+9cXV8zXmPWQ9cthzC6TrWuJI+R73dya3+sKyiUc8cf76nQ2527Bc1SOMTFBUdbntlKequZMNjeNm+gecyXGMCPy1fU4BbFvHuiJY0ne9VZldwgcsgRafyq7vmzNjVW5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VF92Gu+bsHYurF5m1ieE8BleJa0LFpgfkNUhDPm3Vo=;
 b=Zi49ZPuAproDQnqkm+Su77A4h9jQ+i7s7KPWPzaPTnHmEDT7d2MeQb3g2JpEikkryMy0WQvX0u6OwkhLMtt6ya48VMXeB3S5WMzrSqbKyo0u9/cHf6ptSnbgK/VJv8MDTA2b2cFWAgh+V4ro8ac02NWCENfuIIz5h1RkHo9IGlw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW2PR0102MB3595.prod.exchangelabs.com (2603:10b6:302:13::25) by
 SJ0PR01MB6189.prod.exchangelabs.com (2603:10b6:a03:29c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Wed, 25 Oct 2023 20:08:37 +0000
Received: from MW2PR0102MB3595.prod.exchangelabs.com
 ([fe80::bfe2:cf53:9a23:f07a]) by MW2PR0102MB3595.prod.exchangelabs.com
 ([fe80::bfe2:cf53:9a23:f07a%6]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 20:08:37 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Zaid Al-Bassam <zalbassam@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: perf: Don't disgard upper 32 bits from PMCEID0/1 registers
Date:   Wed, 25 Oct 2023 13:08:15 -0700
Message-ID: <20231025200815.104017-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR15CA0013.namprd15.prod.outlook.com
 (2603:10b6:610:51::23) To MW2PR0102MB3595.prod.exchangelabs.com
 (2603:10b6:302:13::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR0102MB3595:EE_|SJ0PR01MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a10d392-0d18-4d3e-7d85-08dbd5962c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vbtM/4S/FkZRVB8zHMa90CcX09MwPsfcWYAWvWL/zWpsPaLu6uJ7EBWh10Sdf/wQIUd8JUVijX2PZBD6f2rkzxaTZYlDCunP8IXuFrHSpvXv+DjIovRPkAlFMTYJAP8dxzkCNyDQ1g4MqUKU88ebvPZusUZnhqAoUg+FYME585vUfbOMVES8EDvxLu3kGxTV1c1X1yIZfSZxwyk6Zw6W6EpmfAKq89uyZD+WC+Kk3ApPKbNaY2bRyT57OxkrOgI3oZrp7c2IB6eTV2FiIE0lUGPl9HirY60FTDnm1sZxTLUKXgzl4eXDMEIg26uNyfxd+aJMGLk7mkPCEP7c5+u3x1JlEre71l6azyA0qGNoyU2cYvAZpmGFRf1plUAo8l8dj9STIkCSD3wF0GHxNTHRtwUzrqfkAonG5UXgxNZFLA+YPpzw/Vy5DVRUwJEOaX10hCXkhurQeu+ILp+0Sdh3JLTNF/QEcHjq897CyeL1xguQDHXORj9ZHOmCUudQPSKIgRbPNkib6YMG0Gr0W45g2mt1xIIiJcEC6kkYMYW203VuSWuIxqcKkclsgEH239LtR2S9v7meuaVoDr1CvaNOCIoxfA9cGC6hXd3VkELqlPmWIpKx1ITzSNJk1yNi2MV/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR0102MB3595.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39850400004)(376002)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6486002)(38350700005)(41300700001)(66476007)(83380400001)(6666004)(6512007)(52116002)(7049001)(478600001)(6506007)(1076003)(2616005)(26005)(66556008)(66946007)(110136005)(38100700002)(2906002)(316002)(86362001)(5660300002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TIg5pyrq+VsN9+v1fmoTzKRDCwOfu/C4jI6l9jheTuODwMcMf7o+QJn0b+nV?=
 =?us-ascii?Q?diIQHZmQX10gxZO0KgkEAXcVohEiJzVm7YN81dawBxewz4fW6+5HL5Qolz8U?=
 =?us-ascii?Q?SQHXJeH4/YuRtiBRVCll6cnD3az7u/TchSmVL5mXT0e0esWRMEouRWu3kFeB?=
 =?us-ascii?Q?Y6+KqdA8K1gSMwtEeZK9e+A3xwzye9Rtp5UbWBEqVq3jNF21XXxMcmVMXfSn?=
 =?us-ascii?Q?EkBQUY7aBpcijvLucvwCkgmhdkjHdo4xBPReDr58SXUrlWomCs6O8k9URbIy?=
 =?us-ascii?Q?Xcu0DMXNTQEpag4Hkqd1Q7PmCtyUS3ZRX5Yoq715xy7ucv0yKLMs24FTfzKl?=
 =?us-ascii?Q?QX9dtoM2hwRJSYQKFBP46lSl4pjA6zHmwDs8diGwk71Nr3HMnSvWOLSuZNaR?=
 =?us-ascii?Q?/sfwEFLDWUQhT4iKUVosvQtFF7Isvxz+M6f2A6V1xGtIUK0GSZ0Q1bgGbdBH?=
 =?us-ascii?Q?Y/6T6t9VaSTSFywaVheayFR5ko7kEtGtuMNiYSWXV633g27D3xPADtI8t0ZM?=
 =?us-ascii?Q?Z25rF7bFvUuW02/tZ8tbMDCksKKMnRBiJ9j6aUfjPwNbhI7LCOHF9uwPLbis?=
 =?us-ascii?Q?mZ7tow+sqKa9Ccf5BmJTI5soOBv42dGTIYg8yjdOgWFcyu/BWjZsX3r2yq5f?=
 =?us-ascii?Q?rcTFyOJh1fybBe5escLOeXGKUZBM3p1x5wR/tinTT+yID4IQdk9lTzmvfm67?=
 =?us-ascii?Q?tm4MwIKIY49vIxe3HSpaLwQHaYmlNjZfey65g1aiUPbvbLwlPAMpZdbdj3eK?=
 =?us-ascii?Q?IOLJvffuuhQrCZR3BZabBEaHHaSww+VLcQw6utzb8RQg1XGd9Qm8YOGL+uwJ?=
 =?us-ascii?Q?+jyQsee8s5ZT9Pu9rs65Npfp1RlugPVhuTZOQlYRgfxJjXW7XiAnADkC9mUI?=
 =?us-ascii?Q?MJ0NNu4V31YKmANl1qZ6/N3h7/9Yj7/doUpmoF6+4OG18CCXBh/iltmAa2rQ?=
 =?us-ascii?Q?24FUWzB3OoOiP7c3c2CPFiu846DCjTAdp38JaumFj5OIDw7rAMfh8/0WFm9Z?=
 =?us-ascii?Q?FYIodKkRTSIFU3j0M++a5xGLMsU1Eho5F1bs/o+cQQOGOn03RkZVT9wl1iDZ?=
 =?us-ascii?Q?cbmitFid3gE+OWnZTDXHusWZ18FQyioH2LgsDiOLgbLsVI8O4pko5Fgn3Vay?=
 =?us-ascii?Q?zQTyP2nIJmpGZBh4A328RFexxJ8/cM8yXzoLgR59Jcp9tdH4ArjRSfQ14Tjj?=
 =?us-ascii?Q?wDUYs1c0ghIR00xHKGQLZYS3aqg/NbOe/kUHRHHn1GY/j+uclEXHtpHKTq9A?=
 =?us-ascii?Q?x8uzh1WLBH6Am1r0OkBBZ0UKFDULWoo37i0zuTnDRR+0Y6wZ/dk5Tns6fK7a?=
 =?us-ascii?Q?UsDpMV3S5/XmkUv3ac456w6OtFE7IKqKoZAqHniU9U41+eo6ckcadZ5AaNl9?=
 =?us-ascii?Q?Y34YDqCN+UVQeGdWofr0ufvmNOYbFpUOxyOMEOSKsk9ID4x7EihHv19o9pxS?=
 =?us-ascii?Q?anL346YcG5W90SbQ+Yr0P4AVS/aWMJekOdVJiVF4Arx8wTpQkWYoo7Cd8nAx?=
 =?us-ascii?Q?oHd9pvNg1Pavkghm93PYbJCueZkL5CdxWf/Jzh9baYDjsmRwavUZZFvZCcgC?=
 =?us-ascii?Q?OtNI+GEtqKF/Qwrc1wFqr5JoutdlUhzLthUMcWCWJsTwLutd9fm3N49LBak7?=
 =?us-ascii?Q?+yUYu+YgCLplIt1B9wmodMg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a10d392-0d18-4d3e-7d85-08dbd5962c9b
X-MS-Exchange-CrossTenant-AuthSource: MW2PR0102MB3595.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 20:08:37.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UojYTR2LZOGd0F6mTGepaIimAY2DPRGw9nOfvhOOePuyybWODLhrfJFx8WLzkzn1qPAl6GevXVejLRTWZWCN94VSeskSmiY5ABhBgWlMRCBN1tvRPIJruJ5Fr1N4apQO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6189
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper 32 bits of PMCEID[n] registers are used to describe whether
architectural and microarchitectural events in range 0x4000-0x401f
exist. Due to disgarding the bits, the driver made the events invisible,
even if they existed.

Fixes: df29ddf4f04b ("arm64: perf: Abstract system register accesses away")
Reported-by: Carl Worth <carl@os.amperecomputing.com>
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 arch/arm64/include/asm/arm_pmuv3.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index 18dc2fb3d7b7..3e92b7cb57a4 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -126,12 +126,12 @@ static inline void write_pmuserenr(u32 val)
 	write_sysreg(val, pmuserenr_el0);
 }
 
-static inline u32 read_pmceid0(void)
+static inline u64 read_pmceid0(void)
 {
 	return read_sysreg(pmceid0_el0);
 }
 
-static inline u32 read_pmceid1(void)
+static inline u64 read_pmceid1(void)
 {
 	return read_sysreg(pmceid1_el0);
 }
-- 
2.41.0

