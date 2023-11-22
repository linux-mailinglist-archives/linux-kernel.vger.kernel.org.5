Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DA17F41AE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343520AbjKVJaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbjKVJ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:29:57 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2130.outbound.protection.outlook.com [40.107.244.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD123D5D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:29:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnHI9ph2qoiZ73ZxRc4pKB49m2ttJbAKfYDTOGDgE+0j69ywZCo7WoSnuD1s94JatM7EU67ZMTujqeY3faowWYEUcy1ST74HQeraB6KIRNosVhpC8VwcU1ju3DJmbmEBUoaOt2WZK4FpwqShIEaixE8m1qsLYmCBhNLx/ahHHE5RtwAeCK/N3PeSAc8xJJzlKhv0iAMGN6gUrYzjYYvRZDXthcPMwp4P+OMg9Mm9emLyZoiQ2BMi/1XOKuDkqE0wTwjJyvCJVnAAH1Ub7LymrLzsOZIerc8lIT2QaQ635Af1f51kpyyWudI3E1l/7NcLshG3NJWkt0Z0Ddirh+VDzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtkB6JlqAx6Ig7BPg1WUx9jtZreCP+mVpAxMP6FHeHQ=;
 b=XRq0OZi4zUMtNIqP8YEjhJyPEFXyikK9/PfkV+qMzuAOxRzcsW2RKi66zpbk1Reewaga/lt4U7skqBlQyxkGqil+P1lRl6arVvit3S+FfHWrvhnugP5PhMewesf8c1kuxD4vdTNvaLL7UpDKJ0Wl5hEVK1MFEH+hYem7gy3GdNF7zSPrJWd/Uz3Bd/ghjnlhyA116qUtraalvQqA5CWGDlAXlmCaVt8rJYbRNDvaOY5RLHlaJOxzrK7fS9l1vZj5Qk/1vdRUsrppRvAxrV+E+W8omQV7k0p1pW1iI79QHLu0c780n9AEljHWz/uV0Dcu6VJVdvOUB8Ga58MpwvBcIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtkB6JlqAx6Ig7BPg1WUx9jtZreCP+mVpAxMP6FHeHQ=;
 b=cl9wSKf81PxAZ9hd3qtGyp+Q6rsScpnOzePzc+qpQyuGnfXv1JyA6xxp08CoVOgSYE+dG6sVLHUFuiDNNMjT9p5ImdysKB02i+m1EFpRm/rHkK1rjXzGrI06iu1TCB47b7BjTAOWLWGa3r3i3ghsx5+dBY+mVUso8WiXp5A7yYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 CO1PR01MB6760.prod.exchangelabs.com (2603:10b6:303:f2::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.18; Wed, 22 Nov 2023 09:29:48 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77%7]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 09:29:48 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     catalin.marinas@arm.com
Cc:     will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        robh@kernel.org, oliver.upton@linux.dev, maz@kernel.org,
        patches@amperecomputing.com,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH 3/4] arm64: copy_template.S: add loop_for_copy_128_bytes macro
Date:   Wed, 22 Nov 2023 17:28:54 +0800
Message-Id: <20231122092855.4440-4-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231122092855.4440-1-shijie@os.amperecomputing.com>
References: <20231122092855.4440-1-shijie@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:610:e5::12) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|CO1PR01MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de6066c-1b17-4f10-9f1b-08dbeb3d9254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2+YSYKB8XofwUlyfPO/EVNGLciuj4D8+pYStyj5RvPu350rzVw7Yx6V4p042+fNfCf63DcGjgcb0MLd7GGYCNMuopYDyljsWhkU0urJT6rwu0n1q1UUk/yYKohUOwga38qkNqDvL7zh3l4XvrRExvj1VOk6NHwQEHlbqv0xcQTiyKkHJiuuZ8xy6rcb8LEdCj/ySMNDD2FDfsYdLGjGeNVHKFduqcpz4rHxfZ4Q1lkrjCsIzrmEfMA8mLRjWgLCwuZxr54JYPfSHdfEwYgKJlBeJVaTCPujXjEq+L4VxUTaOBWBAGwjR8irlb9vIMggRpk8sCqe3l5yXsoRyf3YYhn8LUU3WqpoGtjBD2zQ+FA/rX9Ap9JVn9W7r7B81f8mvF30L2hEJ6mZ4udc+oBT2K3j6jRdlcQiQNXcOJP8cXbtgloOtagzAVS7ut6lMMkhKq76fOMyn1YMs47s0W3HQGsQnjcaHdg/W530w3tDuYDRfB7u74zU1rKKK8kZQuV+gIw49DbuHdJ0PSV1SvxIqDrfsZatJ4Qd6RcZ5GeZUTHcU7tGhrBQN/sd7JzyDBsergz5jN0uWLG88xmcFyO1K3ir0GjgwzN/P8UmvGDnjhAREAZ1ppRf5y+AFY62muJJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(2906002)(86362001)(7416002)(5660300002)(38350700005)(6512007)(2616005)(1076003)(26005)(478600001)(83380400001)(6486002)(107886003)(6506007)(52116002)(6666004)(38100700002)(66946007)(316002)(4326008)(8676002)(66556008)(8936002)(6916009)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8MNkqwJJbfzyWUnWwcSMDBgv79lVeVSEYAiANMIPiypHto8alOaf/wdYNqeV?=
 =?us-ascii?Q?ZknBlBJJ5YHsZsmyLn22Sxo9nLJkSfxZkKOd+vIOjgnQz1DIGuouEN1ULDxQ?=
 =?us-ascii?Q?tLMoM4GvrdGmU7/nTqAnzNHmFhDhU+48pzYcoGv8RCdCgCbY1eZiKdYjewoy?=
 =?us-ascii?Q?g8oOtdsKFI1DtJBZOs6c+9703yPmcUCB0FiDcJ+k9Z0Trb6iU7SEwSlEDOY8?=
 =?us-ascii?Q?pjjZN2Zf5257+xzbzpuSlxbHVGSuXKOBIT+b79vYKs6JDNNZ0xorGtgh8Wm2?=
 =?us-ascii?Q?p2UOQQx2Uz6T2M6+CVgzf2mUH1HkWXd+b4izKCStcCNzTkaNG8S65cBhNYk6?=
 =?us-ascii?Q?FB6Ni9l6lWwpkkhqrFflTfyQcWA4nWMvcvFHTLQIhYrqCFWdPDDJ4WLAKAcM?=
 =?us-ascii?Q?KC6lbDKZhSgVkwL6lqS73dezRJJnvjRFo/d1v0AU6x7CyINKA/cGmaDmS5yK?=
 =?us-ascii?Q?A7GnC79hw+zJIzyGWgoQQqqyf+3+CJ8gwv/PgXFOGGMzRn6uV+dPutczU+Oq?=
 =?us-ascii?Q?SXduaS3YE4EnKAmhVSJh0HFhcYMdg8+vwPYeZp6HHIvlCQChbfSSo2UaNsgP?=
 =?us-ascii?Q?gkZWozCA9sRmKwXVCKRQW30blSPuZsmcsVl1Px78mu0D6+3mrv+1ZvhbZ0aU?=
 =?us-ascii?Q?Gc65pfgt49LL4vZKgPBFMPm62cgjtJ8LeVO5uhAnwpicg7hOnkiFZVMd9z6R?=
 =?us-ascii?Q?d43dM4/L4Pz+wSNKpvXiB3YWKzKa6k6765waO8jyaerV9D/oJLuyNmMUUdjg?=
 =?us-ascii?Q?bt4TwKP37PKuYaDSu+0Jdza2ahk0j9cZAsKScpjiVFa/VFhqozVLjMmHNPS0?=
 =?us-ascii?Q?/pCp9RBAk+7z+G5H3ifPBYzFi2nHfSo1WzDfzbAIWmV1aNJFaiXXHgRd1TEa?=
 =?us-ascii?Q?KfpSaY/BCqTRPqC3UkN9dcgjNDXfqAaI8u8dhjc8DC2+n42nPHE8IXNwEkho?=
 =?us-ascii?Q?tJbSMMRlPHJSGXGMZ4DuehBuHZyeUB+6nf3lJtkgAR3han8Kz8hmq6PyME7c?=
 =?us-ascii?Q?kt+jl5DVQS/wyYyvWHFkUUgzeY9PGswHH/FrrZR53lkH8Rk509cp4byNLbf6?=
 =?us-ascii?Q?elCmwtfVzYgce5CAZ8rE+tKKMTUcAZObU8tftz5JseyxDHRA8tsI0FOTcHR3?=
 =?us-ascii?Q?HO5MfQpE8EpMS8q3b1IMMPJCgsN+9+6Ax46cHlvkElcZB4L1OACb2iu9tE8R?=
 =?us-ascii?Q?Ssy6bpeRju+QsT1f6jbqzNhVvN8Ci40IgM9WJ58Tgf3/TN+bFGTORBdsgnDo?=
 =?us-ascii?Q?6+85PWn9uEv0XlXaw/UECrgeNC1jQYhhWZndGIVUyp3th4QkuQI1t+rbeEpt?=
 =?us-ascii?Q?KkUHfZme8Eok6oxcff58vSyDErh1SLM1t1K/ZrMvTo9moKT6TLvXTSsS3qED?=
 =?us-ascii?Q?GVW9rF+EWmiEa66LHUd5gQnIqOmh28GjmSDW6nCnhGzK4EY6+KGzwrMQJQsM?=
 =?us-ascii?Q?0b9K1g/QJ37B81UNksiObcg7c3v4PtokJj27m9W6zv9ma3MB87VRo7/7QhYc?=
 =?us-ascii?Q?MyYwcY+nuKtMkWumRgbnebjrqDlPeYkzN3r0w1ZczwCi5BPT07pREKlq5Qib?=
 =?us-ascii?Q?gVfv8A1WwZKL7a9IYmigFCtbwh9pUqE5pueNI+LhKJM4usA6RpcALLz9OHbj?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de6066c-1b17-4f10-9f1b-08dbeb3d9254
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:29:48.7083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WOACMTPFMsr1ZRP3NMuIddXCHOyDZdS7HnpFUDbsufymSDzIGZjwsSqhKfMLlBK3jb2Kd6g8m+wvB3S1mNoqZnnE9f+IAtmCahJQ4FE1YVkw60qbSxbD9XKLAgqbRsi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6760
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the loop_for_copy_128_bytes macro, to make the code clean.
And make preparation for the next patch.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 arch/arm64/lib/copy_template.S | 58 ++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/lib/copy_template.S b/arch/arm64/lib/copy_template.S
index 488df234c49a..79b32569260c 100644
--- a/arch/arm64/lib/copy_template.S
+++ b/arch/arm64/lib/copy_template.S
@@ -10,6 +10,36 @@
  * files/head:/src/aarch64/
  */
 
+.macro loop_for_copy_128_bytes	extra_ops
+	/* pre-get 64 bytes data. */
+	ldp1	A_l, A_h, src, #16
+	ldp1	B_l, B_h, src, #16
+	ldp1	C_l, C_h, src, #16
+	ldp1	D_l, D_h, src, #16
+1:
+	\extra_ops
+	/*
+	* interlace the load of next 64 bytes data block with store of the last
+	* loaded 64 bytes data.
+	*/
+	stp1	A_l, A_h, dst, #16
+	ldp1	A_l, A_h, src, #16
+	stp1	B_l, B_h, dst, #16
+	ldp1	B_l, B_h, src, #16
+	stp1	C_l, C_h, dst, #16
+	ldp1	C_l, C_h, src, #16
+	stp1	D_l, D_h, dst, #16
+	ldp1	D_l, D_h, src, #16
+	subs	count, count, #64
+	b.ge	1b
+	stp1	A_l, A_h, dst, #16
+	stp1	B_l, B_h, dst, #16
+	stp1	C_l, C_h, dst, #16
+	stp1	D_l, D_h, dst, #16
+
+	tst	count, #0x3f
+	b.ne	.Ltail63
+.endm
 
 /*
  * Copy a buffer from src to dest (alignment handled by the hardware)
@@ -151,31 +181,5 @@ D_h	.req	x14
 	*/
 	.p2align	L1_CACHE_SHIFT
 .Lcpy_body_large:
-	/* pre-get 64 bytes data. */
-	ldp1	A_l, A_h, src, #16
-	ldp1	B_l, B_h, src, #16
-	ldp1	C_l, C_h, src, #16
-	ldp1	D_l, D_h, src, #16
-1:
-	/*
-	* interlace the load of next 64 bytes data block with store of the last
-	* loaded 64 bytes data.
-	*/
-	stp1	A_l, A_h, dst, #16
-	ldp1	A_l, A_h, src, #16
-	stp1	B_l, B_h, dst, #16
-	ldp1	B_l, B_h, src, #16
-	stp1	C_l, C_h, dst, #16
-	ldp1	C_l, C_h, src, #16
-	stp1	D_l, D_h, dst, #16
-	ldp1	D_l, D_h, src, #16
-	subs	count, count, #64
-	b.ge	1b
-	stp1	A_l, A_h, dst, #16
-	stp1	B_l, B_h, dst, #16
-	stp1	C_l, C_h, dst, #16
-	stp1	D_l, D_h, dst, #16
-
-	tst	count, #0x3f
-	b.ne	.Ltail63
+	loop_for_copy_128_bytes
 .Lexitfunc:
-- 
2.40.1

