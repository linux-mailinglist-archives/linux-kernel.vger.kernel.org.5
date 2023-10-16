Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDD67CAD96
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjJPPdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbjJPPdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:33:01 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CE9107
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:32:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZ2bdahQ2GbI2sH9R6/h3dYO9x5BxVgcX4uA3AIB2P5+w9iFDZolcLp7ctDbD/DWsEY44Q5o3MDEHjEYibSsyU4RUKhoqvIg64aNvHimxfRhydoM/LIZ/WEI8oyYJfiXh0L+Nb87SQpz7DSUQhvHn2w8bBI5PEAHDvLiLpZsiphR8OKf9ZO+A9hDISuW1EBKwdpo+wd6WAGGgFIWmY+9AHEZ+CUL+1bB0yQh3UDt92YsDBwXxIrJKhlYtB088umbaZiR1oE5jIH2D7hHfJurDIzHZk7YdQK+qcr9sCia6EpUJxUC+sez9AIit4m/RqJcwFrxUALVTzl1qPyBh/NoDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svPLmeygmo1OLpXLFU3spLAsG1jWt+ncndklexvqqX0=;
 b=Z3F/6phuuM6k+hRgdNSiBHjnfYJ3InB3dtLk2qsoIfGDHypwjXswBmL85d4TUZ+Rk4n99ZSkTVHrPW2sQG39ONd5nVGiwqH3LyXSfWGrPq3V/HgXf77J6ikvy3ZuR0TBPqfSabmCEhTp3iABQQfxKvL6eF2mt29UKRKdngv3cCyknUlPkhdrpL4A2HbzYdQAOsTlHoxss2lKVNswp/v9LT0TEndf7/rR77Xc3IIJ8Ik6AOln38kVtm8+wMWrZBwKSriaHu0R2f4I8ThCp0Qi+mORV1XpS+Zgl9cAnMGi7OwNAG1EiuXZ9JRAdkFVHV1LdXm4NgoP7Wc2Rc5mPVMKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svPLmeygmo1OLpXLFU3spLAsG1jWt+ncndklexvqqX0=;
 b=OUX0Kp8xqvuISFgcW1UVssKNzuf1wVVU8FvGEHsNJRTLxClkkjieM1fdOFeQLXd4ZOvL2eFv0EhzMsSXCykj/jIGDJk/FEdSA7TQFYyDxq1n7OMmH3GuDrD+iNyQaaJJ0P+OGh6ZNqU8D07v2/7U3rkmOU1/llDltD9c6ioSX3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 15:32:57 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 15:32:57 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH 5/6] i3c: master: svc: fix SDA keep low when polling IBIWON timeout happen
Date:   Mon, 16 Oct 2023 11:32:31 -0400
Message-Id: <20231016153232.2851095-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016153232.2851095-1-Frank.Li@nxp.com>
References: <20231016153232.2851095-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::13) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 464e0d18-8fe8-4836-fecb-08dbce5d2c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6QJeyyzmuZngP6gKTxj1zFp92WRrkPGCj4lpf02I7a54XfIGalYNrhwCtBe+TnOsCeKBXvJPRNz2IRCLfSLLMQmJESws8cx3haxgBfMPLLmrpk3WpDnYpGtSJWyd8p1VVzg8ys9bv8J9KW7dtJg6kpUU7UllnWwYP+UTIkCMAPAXnFVaquMlg46foCM8h0+dV4bD3MP/ARqgZLMMCc67Rnyx9JXtHVQpgx04S7I/eadkuiwvipsm2biY6xkPRH2XXzSzD0TDNJ3mCCN7RsIC45yCQTRwGu/XuDiiY/mk9gHIAGDqbdZ+ptl2vTzmaP3TUJfNfALgWFPv8BGYSMR21UpofXelwymaKaI1qzySa6/EQ3B+H/9PB3rE4+q1hKyNSlazoySBfdSOPc2AFu2LqPbkFkCiIxma7QZHUiepI66e6YdPqfWWydiHIKlUd8LAvg0geuJFo+8KVp2vHjhjRZg1jXhq0XRkB38Att+95C/0f7c8hs7i14/kcA/dejzxqjNp5iG9gdJCuF3/q5UNTScoUyFSYEUsRXnsHGt2gyTf56kSOS7ekrSBS/+dWxCkDWffcR2pZsaKl2kxVQLrDmsU2hZV0gd+qpZ2mlcPaV9F8t/ByPfreIqPYJBN9V6O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(38350700005)(36756003)(38100700002)(6666004)(6512007)(26005)(6506007)(316002)(66946007)(66556008)(66476007)(478600001)(1076003)(2616005)(52116002)(2906002)(41300700001)(4744005)(86362001)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iVMOCfBqIgTPFY+kplyiKwf9lfS3BopNOSlqXaX7itXKUNLsgWHawI7LNYiI?=
 =?us-ascii?Q?7lYxkdd1PH+Ta0v1fpXYQVxG2HacfxQe9+/BrVDodwM5jENRogJ9/tbjUJkR?=
 =?us-ascii?Q?d1Qa0xnVb1MWAynjQc/Uv2njqipWad7z/CqfVraRSh/eNd73Butm6UaFQeWx?=
 =?us-ascii?Q?Q7KJV191D+C9I0T7ZEt8Oy9XQQhcpgV8rOZqS57JD7P3FSQ1JetbkwvfRdXK?=
 =?us-ascii?Q?R/6zjviG5meCVaVkGslTS/qFoeyreM1PNMVClmW/MW1sMrbGUm/E07fUTA22?=
 =?us-ascii?Q?VKmnZ+2Uo2BiS2XVTmYC49MCeL0T2f16iga56AkBVElratGJe2Qs5Zw/EVVj?=
 =?us-ascii?Q?EjFKCyiuFcQrZwoXx2ocjgP5isHEobwecX4bTdemH7gTIyk7+yglG8IpGlkZ?=
 =?us-ascii?Q?RnMtzY4c4z1KOe3a8G0A1+mSI1Ngh4MfOTNVvZDbGWk87ZNc9rLRB9R7B90V?=
 =?us-ascii?Q?lOrFYnfQTifepoDmLs/uEnNfNjwxDSEue58PBb/N49oxTqy9Tw9MiI3K3cAp?=
 =?us-ascii?Q?2Q0AGXEzhoepg2CRIEEOgJ0tq1hjt3chznyz5r/OSu4QfUX22vM86iJc+Taa?=
 =?us-ascii?Q?51UaUtDjRGL7nSxJNfqdoUTUl1puIKwnxZjXZMsaOHqnYh/SRtj9hx9i8MsW?=
 =?us-ascii?Q?i3wDyKmbIiNnUi5kFCUhI+E5AmAi1FgNh6kmp0HyO2Xbo4tlivDXvwOMIM+M?=
 =?us-ascii?Q?uDqfstnc0QPKW3ikIpWuyvaCUm/dnR30u+xFGiY2RFF6sx4bVBv3hq93rTCC?=
 =?us-ascii?Q?+WhgJ9I1nFxcUa1KUxKABFhhtNuD9R3tgBn8fzOOyO1E8mP00cehdyo3B410?=
 =?us-ascii?Q?RtDRV3oMAAexC/CEXHvY/wI6D1rYNxUNIRkM2PznCBK+3RY/UEYsQdBR2vG0?=
 =?us-ascii?Q?UT2TgzRikscp/HEMwiJefY+3CvbaNcLTKaEQrqd0+/4U27TjdhYxzvnmcp5w?=
 =?us-ascii?Q?yfnYcW5vFfzWG/2MoOuTs+sCPkfpzkU+XtOzZpCgLTDpWPUW1kvaIOaJdZv6?=
 =?us-ascii?Q?fSvFnVrtOW9cHsIgqkJlKdD6VzZV9meseBNxK1q/dzpFIFjNsS0p3ZknfDAI?=
 =?us-ascii?Q?CR3XQQsSRGGJ6NDUg+UUCa1Az+EAQDLvqD7KZLtfOmZNnxUtMa6Nnegfkt7S?=
 =?us-ascii?Q?7yAFx2rS7ONsQktYPGDBcG9AtaLas1orBYuOpiNlfO2Le17nSXzN2hO9XOFR?=
 =?us-ascii?Q?2Zq3GRxxvfuvjaZhnm5NcGt1ZZVOArQq+WaVHKViGcS9+kBIRUy4VkShiXda?=
 =?us-ascii?Q?a3u018GxTsA4Lx4tw/zP4THM4h92Ck7iKr9FO4kVg9xoPBzcm4xjopsxCBl/?=
 =?us-ascii?Q?D6qubfWNjSKyL6DiwfnBpqjBX4cG+qU7SakoeUISiiKTEZ9MYQjSH/FJA1zM?=
 =?us-ascii?Q?fwwwlxXPMWCuSy4g3c3hWhA7SvlcSJjD39MIpyULe6fdmC+q4LCCisviLdQH?=
 =?us-ascii?Q?wcGfNJUelqCjcLzKPXua4MHBFUT/4msZZudE5r2mQjL+wJ5IffjG1JQbNut8?=
 =?us-ascii?Q?TiovAQGGolp87bANLyCaThGVHrk6iLijv8diHYUf/XKMyusr0xc26mg5qYW5?=
 =?us-ascii?Q?hWKaPpzycZwmRQwiGxA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464e0d18-8fe8-4836-fecb-08dbce5d2c5f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:32:57.7975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M21CludxDsazxwvfhFlclz32ywvU4G/QQi753Gu1SQzsXMIuNtHRbAcykadlrg2IPPIgjRoUiG0pMU/LcmUrQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need call svc_i3c_master_emit_stop() release bus.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 5ab68d6e439d..5bca369d6912 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -403,6 +403,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 					 SVC_I3C_MSTATUS_IBIWON(val), 0, 1000);
 	if (ret) {
 		dev_err(master->dev, "Timeout when polling for IBIWON\n");
+		svc_i3c_master_emit_stop(master);
 		goto reenable_ibis;
 	}
 
-- 
2.34.1

