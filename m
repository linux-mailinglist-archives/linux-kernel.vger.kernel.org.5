Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9357CB841
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 04:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjJQCNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 22:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQCNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 22:13:51 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2133.outbound.protection.outlook.com [40.107.113.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94279B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 19:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aY5BviUH0agEne/89W9E/vzpqodp0Vxb+3DOjWoEznRQfX3rgdIGmROKzLe2WNN78BJstbunzEU/L9Qyx5f6DWdaJS358ZZRMvi+FjaLEqvMVLk545IifYFbJ4+DqOR/wvIpzVMz2Y7HQ87/jLRPI9R6DvK5S7rHGXVIzcqSu1Oj2XkuIQouY5q0nk2fxzHG1gONNsboBNY+Gcatn3bdRnhAXLxYorCcgfRmcuwlwj726iuQUxrNh6lKKxN9iUVsgzc14NjVYj7QdelUaKBdGkKtkm4PEjD1Ahaa+wyc848q8jzY5Bn6NMBysyj7GLnznRmUr+R2O8Fz7pJk/4q4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXErV5f9JUHJbdriCKeJBzfvArRxBnbpG+8beFGrYqo=;
 b=kGBLGcAOT+lzMFBPZp4eE3DHiNjN2ukyPDr3xW5x8Us5kIbkLYT25Qo7A3tEglLo7jv08EfRV6Q06Ceh77OsKKEjBvLY/DKRO6yU+EnrXacbonTPBjm0tlgKAdjGzgy3LUPvg7SkVKfYrwAIiohxAGSLUJ7VXyZW1LMtcma5xaXvNqFB92LUOrK5ydB/H1YR1ltLx0hQR4u+cV2spYjGhHvMX8m5NMPc0+oaIGrS9pNTO/Tua61gOrRUwDLyboXZomlHERjVqnSsUYwGQmqdcOfqmFV5FmQJmgR3ZSad+mjf/ilNVxshCxsQCwTnGilcCDjDc6AdpCQpUgJwu4FHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXErV5f9JUHJbdriCKeJBzfvArRxBnbpG+8beFGrYqo=;
 b=N5f+sODt7NfIcR6saX/BO58rckMsuXK3F2IjvxOXR7jp0IP1fCQguxTtC6687mw8df9R9r1q5T1sk+at7JROZv6cWDRLwFm34JBqnpLr+/tkKbDPlyhyxnSItwjIby6vkytd1gIWulzv3uvtCZjNMfkfKMypjD/5aZfAOoCiXNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by TYWPR01MB11062.jpnprd01.prod.outlook.com (2603:1096:400:396::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 17 Oct
 2023 02:13:46 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::fb92:32d0:d0f6:a589]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::fb92:32d0:d0f6:a589%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 02:13:46 +0000
From:   David Rau <David.Rau.opensource@dm.renesas.com>
To:     broonie@kernel.org
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        David Rau <David.Rau.opensource@dm.renesas.com>
Subject: [PATCH] ASoC: da7219: Correct the process of setting up Gnd switch in AAD
Date:   Tue, 17 Oct 2023 10:12:58 +0800
Message-Id: <20231017021258.5929-1-David.Rau.opensource@dm.renesas.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0203.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::12) To OS3PR01MB6641.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6641:EE_|TYWPR01MB11062:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ee7de2-1ea9-4c85-9d76-08dbceb6b1a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1fVOlv/B9Xicmd3hprl6ATVyMmm6BGYJLfNooPXA95zkpgpH06e98cM4vcENMvZmhm2B53useZWuhT7Gtbp/z7e841s9A9gZ9TBebxFqGiLgyPbGbOHHmXtGZrzxozBsNl3sv/4cJYuusj/IgnluHuQFkdqQcryCWFRLw9HL3PgU+9PlmSdZKoFv1od5l6+C2rHCIGu+oUIDbprHwWglUCEu2gjbaqDIKr5H0LIyruhKFsCgfWoPFJyeqVDlCpmNHNpRQcB4kbPW6qnqWY8U407G4oDSkCV46jq9pqSUm9PxyNkSqi6WBVfBwWgqMbydW8RN7xPX+C2GLf+9Xwu8fuW0I1/HXMLmmNQXRJX7j4dpn/d6f/PF1QfbU71So7LXkN4+I7WGntd4LrhH0BHFs2ZVy2EAZ+pr08W/Zth2ZaMEaiZqZHisNunSWbOvhR+RjfZdkfYMX9VASU0jk701YWEHRLq8oKPR9d1vri3GEMnaSbax4K9yzDYNjEXamSZzrTl9nEFEU68TwpxGLLNTLnIJbXre7sylw/Jn0tbQ+XE+ienGjhjpXauBOeCduoof21Vtf+0aNQoXdzy94OLOW08wCHx2lciw83VeK5zi9A3k2CJ5d37PZ0TzEXvh3aS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(83380400001)(107886003)(316002)(1076003)(2616005)(38350700005)(26005)(103116003)(8676002)(66946007)(41300700001)(52116002)(66476007)(2906002)(8936002)(5660300002)(4326008)(6916009)(66556008)(6512007)(478600001)(6666004)(38100700002)(86362001)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LDO0u2own5hDQHeCGQwpVJCjNMkE7y5Gvy8j9NfSqfGLZS7hxhgi5BEtdudl?=
 =?us-ascii?Q?DNouE1muSufCGk8SUfgcvpx8e6zbEB/LPG34HQO22t3gSW8DrNc/byIb4o0U?=
 =?us-ascii?Q?9qauNcEiQckgsXaicNv1v8A+XsPc5WlfkaTIsSXBsK9ACq2uyinZCPLZnVHv?=
 =?us-ascii?Q?HKUx9UeTmf+j5nDy9RpmApAnr8hkm/P3UUnmQH/VS5CmE3YdAi9/qFwzEUSw?=
 =?us-ascii?Q?QQdrcyFg/lmY4DDYVF0oLSf0DxzK4UkT33jTARJYIvXYX+mWbA7O2bneUE+E?=
 =?us-ascii?Q?ujK/w/v6BvZKdJ4tT+oOHEhJr7tNkix87t4zU9llfMyMG/c43EVcetowxH2x?=
 =?us-ascii?Q?0yiZaUPSeEKsfCHqagNvifh9me7bbekBV+J06xgkALzuLX51Msade8gT+ALG?=
 =?us-ascii?Q?yutDErGWPe2mIvibdFurHAoePNdnBfoyj2El05hrZM6EbMpGwXBLb8U0ozj7?=
 =?us-ascii?Q?BXJzcN2a9D55z/6yC7eu9Qscbw1wF6XJwAFaPJik8CWOUXCOYqZoTHSQ//+E?=
 =?us-ascii?Q?19tseQOv06byxOrpIHosmnVW+t5IFU8nc6cM5ZQvEFNW8r47gZsnRQ1d9kMQ?=
 =?us-ascii?Q?WZh/Mih23qKGU3rRJ6TQuxAn0grAjL4EmX5e1bcquxYLahCejrfrVEnSz3BI?=
 =?us-ascii?Q?y24Py++wv3FyB7iLt4buizIx3/b/GFbg6b0kGAl8W2grTf2EZ570pXmc7NZm?=
 =?us-ascii?Q?KTiEa8Y2kzfogbwEy3tn4UhINu+HWwLYy6uOrL2sRCqTcYz/xEx1J7vVxAZD?=
 =?us-ascii?Q?TQ9bLw9b2Wkv66EyFLfb/8SqGNFiNOtU3UBrK5Hb9Tt0RCs9tlzypUQJMFZ5?=
 =?us-ascii?Q?kUINJJpnV46tkeJRucRgfnS4h7bdy4rbPFeoboLZfzdQFFta2FsuAer7HIsW?=
 =?us-ascii?Q?JmvYT+ktY7opO69NVZp2skIAulK7Z3e/e0VAEJQuwBsI92jGhTn+umnVTx+1?=
 =?us-ascii?Q?7nJnTegRdsw9jnutWG5t/ySngWYnkLhUNwdQNf09dOl/cIiMKrunfqYJcdt1?=
 =?us-ascii?Q?inBhH7iV9ADfGLxK+aDkDvFnCbmDaETMyzJ7gaP594One0rXMtgb347X44sj?=
 =?us-ascii?Q?a/eYEpUoGb2J88N3jXYH9MWskMMtp0rjZt+L3UDL9xgqb0L0tQ+4zeULuMJE?=
 =?us-ascii?Q?as+ZouzZgrxqIxkzdKod0cO2WDEMVxi++UGmT3rWz2j1tmxfeUmUrUgkkAaT?=
 =?us-ascii?Q?iWa5x7QdSMu04COB8/OBXeKwdUFxgkydgODHC2jNvc7ktbmX9BHa4/hnlzrO?=
 =?us-ascii?Q?jCGpts7jr4YdCElzHVyWHQsRC/VqBdyMEAr5boJpC7lhv3QVeY6+f9AHzoP0?=
 =?us-ascii?Q?ChKg1x+u+b0G92E7wFO7DD2LppVVuiDgWxoAKKpe5XMk71U3MCZYbr/EUe0h?=
 =?us-ascii?Q?Qt0HeePN6aE3pH63DwZ6Gqx5aXGRBnQe0H4cF0ws1K6IyBRVfXgE5jsBo696?=
 =?us-ascii?Q?kmvk7FeMwFiG8DVOaVeAjN36VsDy1WMsjODad/qeQBd5NJRtxbGRwY4qE4/0?=
 =?us-ascii?Q?jVcnI1llPeduCQJ2mCta+gzTlWsBo8LkFxNP8GN3FdJYbfiQc93A6Id9D3kx?=
 =?us-ascii?Q?kBxy4CFewhzIX1aJp73zgwS3e+X7+XkYsivAO/LltN+PFNSHEzJUnbXVLF6y?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ee7de2-1ea9-4c85-9d76-08dbceb6b1a5
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 02:13:46.4291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHO3dVPH36JvZ/dZ9MIDWlT21uImj6YSexf8RMjOpABWkHa0ji5h0obsGjpJDRDbsdOhAukIuc1iP2CwPGyLYJ8vPLO7+NtdfXSrVvzVy3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11062
X-Spam-Status: No, score=1.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Gnd switch to improve stability when Jack insert event
occurs, and then disable Gnd switch after Jack type detection
is finished.

Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
---
 sound/soc/codecs/da7219-aad.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 581b334a6631..3bbe85091649 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -59,9 +59,6 @@ static void da7219_aad_btn_det_work(struct work_struct *work)
 	bool micbias_up = false;
 	int retries = 0;
 
-	/* Disable ground switch */
-	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x00);
-
 	/* Drive headphones/lineout */
 	snd_soc_component_update_bits(component, DA7219_HP_L_CTRL,
 			    DA7219_HP_L_AMP_OE_MASK,
@@ -155,9 +152,6 @@ static void da7219_aad_hptest_work(struct work_struct *work)
 		tonegen_freq_hptest = cpu_to_le16(DA7219_AAD_HPTEST_RAMP_FREQ_INT_OSC);
 	}
 
-	/* Disable ground switch */
-	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x00);
-
 	/* Ensure gain ramping at fastest rate */
 	gain_ramp_ctrl = snd_soc_component_read(component, DA7219_GAIN_RAMP_CTRL);
 	snd_soc_component_write(component, DA7219_GAIN_RAMP_CTRL, DA7219_GAIN_RAMP_RATE_X8);
@@ -421,6 +415,11 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 			 * handle a removal, and we can check at the end of
 			 * hptest if we have a valid result or not.
 			 */
+
+			cancel_delayed_work_sync(&da7219_aad->jack_det_work);
+			/* Disable ground switch */
+			snd_soc_component_update_bits(component, 0xFB, 0x01, 0x00);
+
 			if (statusa & DA7219_JACK_TYPE_STS_MASK) {
 				report |= SND_JACK_HEADSET;
 				mask |=	SND_JACK_HEADSET | SND_JACK_LINEOUT;
-- 
2.17.1

