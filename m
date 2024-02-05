Return-Path: <linux-kernel+bounces-52245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566718495DA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77DEA1C20C9F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F7D12E6F;
	Mon,  5 Feb 2024 09:04:56 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2116.outbound.protection.partner.outlook.cn [139.219.17.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B3611CB7;
	Mon,  5 Feb 2024 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123895; cv=fail; b=BAwOCR1TkWpeh10svc4/l+36BwBQcbU0BgKRkdrbGxEhlDKQ3ZhKB0W5xt0cWOszya4apQkfN8sbcDa19yTlFxplPzZE54A1KShtItVXYCaUHk3p2Fz+e+NeecznnWj/Fs//pBbku3DhPtqCCudN2fXCXSf2TvF4I8ngjb12L1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123895; c=relaxed/simple;
	bh=fj6zsfb3UEE9/LcQLAdA9C3FFWPFB7D/D2mWuM9tQGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mre+EqGnJWyd4Y4qGc1kIrbR0lpSvM215vtIvKkReIgxaa6P9SBpYu4DVlRr/oLyA89Xuxwt1Lw1H4jxeR8X+ik853mL5erbV346COBMA95Yrds+glplNfKqdxtj+8sHhWi0fk8uWuaPZuupmhjAW8F5h9XB7P2BGJ/Sj9oSsjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1P3eWy5CB+xQcE0p64o+kAwxkMJdvtaFjPr3WZm2k1d2zE2f8kxouVKVDMvyWc1c2nIcxrqu0LkltSgpYquoYBtkUCCK8cr6sCUxPQ3Z/7/Bi6aqPGTg+OnvZ4rjs0XobhV8yEJHojwqaVZ7qKTgT5o3HEBhXq+aQnwUs2up8xl9xF5y3dOUm2S72LFwu9DVqJ/QEDRpLAly//fDZ4DswkZDThwNd+NJkVt4F6P2LQTfiILaPpV7goY5qBIuwVhy1mZi0mOPW1hkyyYuMR/X8eRO933N8FEMo1iETwJkQojKBW/NRN0BgiFnCk/Unjh5dXEMFOoMtYhTQjSQ1xV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myCz3x19pdBLyepP22aXlUVVrVPBvbaFTbiJbWyXl5U=;
 b=alRHJk/C3+V7RltpojOhOx6LoAaFnBdn6tmxUQO77NfQ6VfJPPU/ggvjZhboDMhuNjR1VJ3vbTi3Uxo8M2Y64i58UhaOWzDFeNk7r6GJM//jA0J+cfJSoJ/7UvXCY/YcorwQExnQxCdARBehn+4tShjZpJNvwkDwWf0jJkF6aBfLoXdbtgVr4I9UlSqhJQ+IJumWlta9pzmV1wta98xfzqbpe4zXf3cGOe0wQCxYZnYugPeJt81PsaRQeU+oH+Mf8IQj2UMfeueYDImRCRvgC5shKBvrptE9ptft7iGejHrPopFOybZ71Nr4rUBgeTM+4bwN4MiRh1JsWy/XnXKCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0815.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 09:04:40 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.025; Mon, 5 Feb 2024 09:04:40 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Ming Qian <ming.qian@nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	Mingjia Zhang <mingjia.zhang@mediatek.com>
Cc: Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v3 04/13] staging: media: starfive: Add a params sink pad and a scd source pad for ISP
Date: Mon,  5 Feb 2024 01:04:15 -0800
Message-Id: <20240205090424.40302-5-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205090424.40302-1-changhuang.liang@starfivetech.com>
References: <20240205090424.40302-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::23) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0815:EE_
X-MS-Office365-Filtering-Correlation-Id: ba654ca0-2123-48f9-43f8-08dc26297c4e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6mFkZGVl+VWXNsdOMHi+rj4oSJxgPungSfuq5fcdYcFITL6igViPzqkTAxtf6mv6qb2Sk2h5gHbfaoTxgHO9yDwH1P1oYQIl5i1NZeE50TUTtaEDcisVyUPJuvKKejxpbdHzeGJmbMt/SaizfdYExPyR+XOU0Kzxa0j4+yZZvWmb6TWz9EndIR0sa539rwpR4EzUQljg5n2BaEuToX7y/jwnDf4ZkJDM0YcB1QbsNlQNX6JWjMCrkzDd7aku8BnwD/1vS2+i8zP1NfNH3d+6C8FHYEMWsSpwQ9TxjDdQwHtoDkkYiRZaToX4UbNO6ziuv6diESOp10ATz0jfU+dUyK9kVPvvbwAjIB9Nz5cx1aKGZwmumEc4K/UxZBqM5eMOjaXP2iZpe/SA2LWMyf2x+QTqCaEDrhjKiwhn8qmKe3uRPBKdmV8R7d87aFaqcfEW3zEleJSNlGlMrYiDGU55Xt48PVR/Oz+bz8SadE4D+4QUI4J3qNHygKz7cJnV2w/brfOSKN2tbbQDF1EFJPPXvlUesQeuXWF7hSMyRDiV1CoXJl7hc32inSTffCauPAXtiXwLAfLhg/IPX7wwJXxJqA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41320700001)(6666004)(52116002)(36756003)(40180700001)(508600001)(38350700005)(40160700002)(38100700002)(2616005)(1076003)(26005)(83380400001)(86362001)(5660300002)(2906002)(7416002)(8936002)(8676002)(4326008)(110136005)(44832011)(54906003)(66946007)(66556008)(66476007)(41300700001)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?owG700HugPbqUI4xBMgcvbB6Ot9egBr79nTKt6HCur8wQXu6Q6+V2FBnklDr?=
 =?us-ascii?Q?JA4v0Hvvuu0KJmFducHLo9FKMakjOWYzRzqOFCiA6J1xcfG0wQa8/JDWK5ct?=
 =?us-ascii?Q?KBXgZ50IlMoQZWtaDVFt3yi6dnk1NYdX+sreXQwQKpOLTMBTLgTXaWTz/IWD?=
 =?us-ascii?Q?hhJ2w9qvsTtyrCLin7VBLqLpslnAj99/tQVzrLvSUDwfSmaH7lshL3WcC25x?=
 =?us-ascii?Q?DEhnQOFi2F63yhTwda+5Xxs35FGm6hfi+zNNTx+7wviH56NETNZ8oGt8TmBv?=
 =?us-ascii?Q?zbOAhYBVRt2LQEuFrL5CCFsUY7AbXQT3DtGQ3rS+mzIZZrdkY/tmCHjabVhX?=
 =?us-ascii?Q?+q3gqo8PS5WTxE1IBQ5PNEozbitA1Kwa7C7lRumVylOnu/PFC2c0Yu/FFt9R?=
 =?us-ascii?Q?u49ogieP5OrIXoUMuv1+J6d5aCe2uhRDvnTkzuJcx79yrcc66Q1KlQP5BU5R?=
 =?us-ascii?Q?pb4Bw8QTCEvIrUgDoi6ccC9CLI10sfmruTmQ+gTZ7yE9gOIrYMnShwK50Ei9?=
 =?us-ascii?Q?84D4SJdttTO+xiR4r3Cg5E6+miXNgBzidU+sZFHP+UGdflhZ4XCuiFIPxP78?=
 =?us-ascii?Q?MJJbVnHXZrwTCwiodQw4NmtMe2gABanw//8qHg4d3XI5JFeKeil/MER7g838?=
 =?us-ascii?Q?TnNjQRHrabJHkeZOKHiH+SGmwECxypmaS0t/avDyiXpCQEmKUqD6LVD006LM?=
 =?us-ascii?Q?3rkCZXOJaHNkgpA3RW3MtNdkmhTLOoQ8IRXXiG3jj0TwcZzoJI8Ea7LV5f4L?=
 =?us-ascii?Q?J9S7U2+sw/FlKNOK6klYrY54SQyF8tVFqXGjAXkmfjZKC5s2LYAWOhQGWwq9?=
 =?us-ascii?Q?mY69Iv88XCYXn5moJsznbARygRcEj8EBQuRTzSoQNzPV7kFfIZ+dm5TNvoxG?=
 =?us-ascii?Q?p+puaG4+eL84PY3K8FkP9Yn4apKG9qyA9pSDN/nCZZmfid15HuSRysWOzUqC?=
 =?us-ascii?Q?xTA2YcQ/bE8A9y/cGv75ZsIpfH5BWgLo8/34qveyRlqvMPbozi1NnGDH6r/K?=
 =?us-ascii?Q?bS+MIAeyHgmfe+EW7f3gQfoRIVchfaSbdoIab1QGLP9vNCUlQKw2Cx+TVhjg?=
 =?us-ascii?Q?HE/4QClO08ul0PtrF+f3cY0g6HVfHphcvMo7GI1SsNslmWuJeZMoQvltlNLs?=
 =?us-ascii?Q?YSawJ+SgjO4AaK+1wgVce8oNSTevZf6AIB+byPj5ykEpI2P/8PP1UYo8NNGb?=
 =?us-ascii?Q?Mciyj00hkLziJNhd57tfpgLGIFGKeSe9pIxu5JZo/Xy9NJ7BGtkVWrlZkZNK?=
 =?us-ascii?Q?JkmJan3uhRDJGPT9TcObhhftXGqOEalkMzeZZXziUCmgWvjh5LpqUJj1+OYR?=
 =?us-ascii?Q?VxJi2jCFfH/8y2Z34rcALf23LQLlwihRCZZoHcJrrfOSJIpZ+fSunrlsnvia?=
 =?us-ascii?Q?Gcc2j9XMXkMsELrK/iPkaz2FNdfjmLS1oAPn8Svh77qGbcxGq2BhIKR+WuIf?=
 =?us-ascii?Q?iCWWD4sdptqyFdF9LeRhjePfsstMrQUxbKB9onfATzUscC4OyehTBKWLr8a5?=
 =?us-ascii?Q?UY+gtd6k+vOsbkAuu6lnM9mlzgmElQF/qXyG/Gq9v8DDByY3AtDQR+0S+F0P?=
 =?us-ascii?Q?qqVoedm6bXxALogU10zfdIPh0G9CdXqVk5CAsxourJGZDjJM/VJk+ssqG/AL?=
 =?us-ascii?Q?WvMARpjhi2aI929W0QGhoRI=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba654ca0-2123-48f9-43f8-08dc26297c4e
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 09:04:40.2231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jx63e3h5QVpXswX+UekCCmiXXEheV9Jf6gOS5u90XoqFRgIRsnE4RnrWgDcwDn/a31ddyszCrJwnfbO0JEpMI4KYS2n3yy5/W8qabupRSJOnFNlfRMJDA6xJY4ff4GN0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0815

StarFive ISP can use params sink pad to transmit ISP parameters and use
scd source pad to capture statistics collection data.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../staging/media/starfive/camss/stf-isp.c    | 87 +++++++++++++++----
 .../staging/media/starfive/camss/stf-isp.h    |  2 +
 2 files changed, 73 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-isp.c b/drivers/staging/media/starfive/camss/stf-isp.c
index d50616ef351e..0ebffd09842a 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.c
+++ b/drivers/staging/media/starfive/camss/stf-isp.c
@@ -10,9 +10,6 @@
 
 #include "stf-camss.h"
 
-#define SINK_FORMATS_INDEX	0
-#define SOURCE_FORMATS_INDEX	1
-
 static int isp_set_selection(struct v4l2_subdev *sd,
 			     struct v4l2_subdev_state *state,
 			     struct v4l2_subdev_selection *sel);
@@ -24,13 +21,23 @@ static const struct stf_isp_format isp_formats_sink[] = {
 	{ MEDIA_BUS_FMT_SBGGR10_1X10, 10 },
 };
 
+static const struct stf_isp_format isp_formats_sink_params[] = {
+	{ MEDIA_BUS_FMT_METADATA_FIXED },
+};
+
 static const struct stf_isp_format isp_formats_source[] = {
 	{ MEDIA_BUS_FMT_YUYV8_1_5X8, 8 },
 };
 
+static const struct stf_isp_format isp_formats_source_scd[] = {
+	{ MEDIA_BUS_FMT_METADATA_FIXED },
+};
+
 static const struct stf_isp_format_table isp_formats_st7110[] = {
 	{ isp_formats_sink, ARRAY_SIZE(isp_formats_sink) },
+	{ isp_formats_sink_params, ARRAY_SIZE(isp_formats_sink_params) },
 	{ isp_formats_source, ARRAY_SIZE(isp_formats_source) },
+	{ isp_formats_source_scd, ARRAY_SIZE(isp_formats_source_scd) },
 };
 
 static const struct stf_isp_format *
@@ -94,18 +101,21 @@ static void isp_try_format(struct stf_isp_dev *isp_dev,
 		return;
 	}
 
-	if (pad == STF_ISP_PAD_SINK)
-		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
-	else if (pad == STF_ISP_PAD_SRC)
-		formats = &isp_dev->formats[SOURCE_FORMATS_INDEX];
+	formats = &isp_dev->formats[pad];
+
+	if (pad != STF_ISP_PAD_SRC_SCD && pad != STF_ISP_PAD_SINK_PARAMS) {
+		fmt->width = clamp_t(u32, fmt->width, STFCAMSS_FRAME_MIN_WIDTH,
+				     STFCAMSS_FRAME_MAX_WIDTH);
+		fmt->height = clamp_t(u32, fmt->height, STFCAMSS_FRAME_MIN_HEIGHT,
+				      STFCAMSS_FRAME_MAX_HEIGHT);
+		fmt->height &= ~0x1;
+		fmt->colorspace = V4L2_COLORSPACE_SRGB;
+	} else {
+		fmt->width = 1;
+		fmt->height = 1;
+	}
 
-	fmt->width = clamp_t(u32, fmt->width, STFCAMSS_FRAME_MIN_WIDTH,
-			     STFCAMSS_FRAME_MAX_WIDTH);
-	fmt->height = clamp_t(u32, fmt->height, STFCAMSS_FRAME_MIN_HEIGHT,
-			      STFCAMSS_FRAME_MAX_HEIGHT);
-	fmt->height &= ~0x1;
 	fmt->field = V4L2_FIELD_NONE;
-	fmt->colorspace = V4L2_COLORSPACE_SRGB;
 	fmt->flags = 0;
 
 	if (!stf_g_fmt_by_mcode(formats, fmt->code))
@@ -123,9 +133,9 @@ static int isp_enum_mbus_code(struct v4l2_subdev *sd,
 		if (code->index >= ARRAY_SIZE(isp_formats_sink))
 			return -EINVAL;
 
-		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
+		formats = &isp_dev->formats[code->pad];
 		code->code = formats->fmts[code->index].code;
-	} else {
+	} else if (code->pad == STF_ISP_PAD_SRC) {
 		struct v4l2_mbus_framefmt *sink_fmt;
 
 		if (code->index >= ARRAY_SIZE(isp_formats_source))
@@ -137,6 +147,10 @@ static int isp_enum_mbus_code(struct v4l2_subdev *sd,
 		code->code = sink_fmt->code;
 		if (!code->code)
 			return -EINVAL;
+	} else {
+		if (code->index > 0)
+			return -EINVAL;
+		code->code = MEDIA_BUS_FMT_METADATA_FIXED;
 	}
 	code->flags = 0;
 
@@ -157,6 +171,9 @@ static int isp_set_format(struct v4l2_subdev *sd,
 	isp_try_format(isp_dev, state, fmt->pad, &fmt->format);
 	*format = fmt->format;
 
+	if (fmt->pad == STF_ISP_PAD_SRC_SCD || fmt->pad == STF_ISP_PAD_SINK_PARAMS)
+		return 0;
+
 	isp_dev->current_fmt = stf_g_fmt_by_mcode(&isp_dev->formats[fmt->pad],
 						  fmt->format.code);
 
@@ -208,6 +225,9 @@ static int isp_get_selection(struct v4l2_subdev *sd,
 	struct v4l2_subdev_format fmt = { 0 };
 	struct v4l2_rect *rect;
 
+	if (sel->pad == STF_ISP_PAD_SRC_SCD || sel->pad == STF_ISP_PAD_SINK_PARAMS)
+		return -EINVAL;
+
 	switch (sel->target) {
 	case V4L2_SEL_TGT_CROP_BOUNDS:
 		if (sel->pad == STF_ISP_PAD_SINK) {
@@ -245,6 +265,9 @@ static int isp_set_selection(struct v4l2_subdev *sd,
 	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
 	struct v4l2_rect *rect;
 
+	if (sel->pad == STF_ISP_PAD_SRC_SCD || sel->pad == STF_ISP_PAD_SINK_PARAMS)
+		return -EINVAL;
+
 	if (sel->target != V4L2_SEL_TGT_CROP)
 		return -EINVAL;
 
@@ -302,8 +325,38 @@ static int isp_init_formats(struct v4l2_subdev *sd,
 			.height = 1080
 		}
 	};
+	struct v4l2_subdev_format format_params = {
+		.pad = STF_ISP_PAD_SINK_PARAMS,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.format = {
+			.code = MEDIA_BUS_FMT_METADATA_FIXED,
+			.width = 1,
+			.height = 1
+		}
+	};
+	struct v4l2_subdev_format format_scd = {
+		.pad = STF_ISP_PAD_SRC_SCD,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.format = {
+			.code = MEDIA_BUS_FMT_METADATA_FIXED,
+			.width = 1,
+			.height = 1
+		}
+	};
+	int ret;
+
+	/* Init for STF_ISP_PAD_SINK and STF_ISP_PAD_SRC pad */
+	ret = isp_set_format(sd, sd_state, &format);
+	if (ret < 0)
+		return ret;
+
+	/* Init for STF_ISP_PAD_SINK_PARAMS pad */
+	ret = isp_set_format(sd, sd_state, &format_params);
+	if (ret < 0)
+		return ret;
 
-	return isp_set_format(sd, sd_state, &format);
+	/* Init for STF_ISP_PAD_SRC_SCD pad */
+	return isp_set_format(sd, sd_state, &format_scd);
 }
 
 static const struct v4l2_subdev_video_ops isp_video_ops = {
@@ -344,7 +397,9 @@ int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev)
 	v4l2_set_subdevdata(sd, isp_dev);
 
 	pads[STF_ISP_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
+	pads[STF_ISP_PAD_SINK_PARAMS].flags = MEDIA_PAD_FL_SINK;
 	pads[STF_ISP_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
+	pads[STF_ISP_PAD_SRC_SCD].flags = MEDIA_PAD_FL_SOURCE;
 
 	sd->entity.function = MEDIA_ENT_F_PROC_VIDEO_ISP;
 	sd->entity.ops = &isp_media_ops;
diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
index 955cbb048363..bc7e7b0736fa 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.h
+++ b/drivers/staging/media/starfive/camss/stf-isp.h
@@ -392,7 +392,9 @@
 /* pad id for media framework */
 enum stf_isp_pad_id {
 	STF_ISP_PAD_SINK = 0,
+	STF_ISP_PAD_SINK_PARAMS,
 	STF_ISP_PAD_SRC,
+	STF_ISP_PAD_SRC_SCD,
 	STF_ISP_PAD_MAX
 };
 
-- 
2.25.1


