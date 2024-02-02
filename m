Return-Path: <linux-kernel+bounces-49345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCB48468FC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F70B1C20968
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C58F18B15;
	Fri,  2 Feb 2024 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b="NykyLqtQ"
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (mail-ps2kor01on2109.outbound.protection.outlook.com [40.107.128.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE917C95;
	Fri,  2 Feb 2024 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.128.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706857467; cv=fail; b=e/GoxiM3nEX4wUedTJnh5ANzMoOvp2pgdnwG7YLp/e068P3z2zNsFNeVuTE2LjrUDUTob3QkDDMucFP7f4SHlDNw8dDTlZvTJasQQY2EYMliOwxPgnRxMLLd8rKtjpXeUL6EBS7io+E/GLQd+nFQgdy4GKiTYRIEJCjBDujbwVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706857467; c=relaxed/simple;
	bh=wPur5CDK+GPfnsOvrUL4OeptQ9WQk73AZtzI19NVtIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MdlCxavYrXUjPuKo6WbigD8Zle/ZeInlP9S9fjxCoJ7RXnu5W4Ue/WLfL0EnXamQACRN0aCT8zL5MTApaZHJXsjSzIjgFGUUQLoR+eQ5Hci7jfksJdTmQtvr5P8r8lxCPq+BzjEQ1W/30prAfl9u91lqF7q/LR2I1I4ldsULft0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b=NykyLqtQ; arc=fail smtp.client-ip=40.107.128.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loBdTxYbt3+4QhNS2b5XVkoROwce+94pkabKV5b6PcOkI324oTdPQpPl4ueEBsTdoygPX71bihYlX1uZPwsnJPd0zmJFkyHolwn0Iz3S4NIJuCjhG110zlLWMa3obLdA5MYnrHT5AXRF7AZqSyIcQjMQUZb74r68/1UBGzn51XO0tIG5DODsiMN1VRtG2/PUsdb/lb1X8K8vz2ZdBJi3uXO+o9mOqVCVS6+lXJKf1JsIRBTNLMCk5IbEE/weClYIecMkGtPJ2xXrpUGV4APV62gwDu5MXJ9xO+eHXE5dPm2n1zH2kIUL0CEMTjmD+XkKQhVX3H3aH/vEHJ7R7HzMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JL0/9A/M7Ksa1POnOCBelPf77EX94Zu9n7Sy+IcOEtQ=;
 b=B4XBp8DgKYQQSS1Rwawt4HeDArKT+5Exl6V7MEgeHlnmFyWQJI3jWidoDUsqZTH+Z6z0VPXtYdT2xgF0Ic6t6MBEsHkkcpg3PmhOgrVdr95RqmLzHlh3y7NLm5YqAo/r0UFHWl3EjAIl1vbi+Jvn3iFFcW2MZcTChOtwOps8ZJjjA4oGU5U+1TbYiq2HMruU3qa0KeXZu+xFd4HWlTyJSX8hLWV524nDtk3512a67y2tUyOVSgLLnQqZmwBaVZk8HD1en8nRQLt8egLPQhd5Yl+eRu2vKIjAJNW5ehIfHqKWDMcQ6gQBClqE/deTw+qY/+B8YEvQnTguiBdsEsoByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chipsnmedia.onmicrosoft.com; s=selector2-chipsnmedia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL0/9A/M7Ksa1POnOCBelPf77EX94Zu9n7Sy+IcOEtQ=;
 b=NykyLqtQro80/XHjNb0Q2Cv4qRLjpXJOWDmhYuitfABUsZDxmgsn6jx8hdRzQtXgTP+27nEXY19K19g4DFFmzS9p3mOXdaCaqLIAscO8HCses42KEfhdqVVIWE+BdFRbq6oiF+umeXH6eOuDGu905tAGqc0BhTeYdh8+i2foV2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 SE2P216MB1425.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.26; Fri, 2 Feb 2024 07:04:16 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c%4]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 07:04:16 +0000
From: "jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jackson.lee@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com
Subject: [PATCH v1 5/5] wave5 : Fixed the wrong buffer size formula.
Date: Fri,  2 Feb 2024 16:03:52 +0900
Message-Id: <20240202070352.14307-6-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240202070352.14307-1-jackson.lee@chipsnmedia.com>
References: <20240202070352.14307-1-jackson.lee@chipsnmedia.com>
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0112.KORP216.PROD.OUTLOOK.COM (2603:1096:101::9)
 To SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE1P216MB1303:EE_|SE2P216MB1425:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d4100d-58e2-45f5-9cec-08dc23bd2b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6pvgXWu9hnc5rviT/w3TpDcdJZE1ZinD8heB0OgphWHE+IO3S5biRD8QtPOf3mToKeoTsAqr72oliM5DaWhfc53LT67lRK4R62+Xzngf/Yc3LGRYBaBQjdeX+Fh1BCpT6vRkYxfkFlT1KH14z5eDE2Q74XcFBUKUJUimSMtGSaxr3lVlDEeB4RfFjhjjayjYbDCVZhBzUPx5xalRIclvKry16ei8XSxcErPlMFno+AbV3UZ9zEzuUc4zx2RV2Kvt/nUI3uOUa5PvSTVurVTmE3Y9tTcu/sSvJvgOhZ3hX4UuXMT7n8MpreOGjSzClj0qaBRQO+fzUxm7s87MjNQrADsKMIC5qERXYVr6/2olIlrbO2ZOTfjGYI2WKw+07R6mUFhbf7p2yWSj7qvoYeoThgWBrbdJBT2oORI9YNTTDiRUKgY+/kq0V7kHklaH6F4jQiamv15D1u6u7T3vCjMlRt7nsAZjfwnU/ozuPNTG98TNYPsGUgSs5RXMWQyQKBD19oZ8dFnj8h/qYNSFdgshRjqGe/q9dFAvIZHRMi+2cuTj4JlquYfl0efkfz61bvRiY7HL1Lfz+iGGhM+yo0vnWFnhHZ0iGft8UKFvC21G2OGJOL1Cqh6b80iFtbIOqaQn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39850400004)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66476007)(41300700001)(66946007)(8936002)(8676002)(4326008)(30864003)(5660300002)(2906002)(86362001)(6916009)(478600001)(38350700005)(36756003)(316002)(66556008)(6512007)(6506007)(52116002)(38100700002)(83380400001)(6486002)(6666004)(2616005)(107886003)(26005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mFthY0yGJ+diePbwQwclFWxNH4qqY3V4GOxAhZPIJ8DHTfJg4dP27gHPqb7X?=
 =?us-ascii?Q?ggLf9Zt1xGwfoWA1gYlflFZSJBZyepsQx8lPe7UUstmt74D01g75MGg3gKV6?=
 =?us-ascii?Q?J2F0M8jmrme+Mi7RtTemDo78MV2OhC5ND8y8BvmJWsTxCHrPcKKfVy/NbqvY?=
 =?us-ascii?Q?jtgnAOapdcrHU7AjF724C83iDruidBoNV8dp5fe09onX6gnakpXLJ0IIZGLz?=
 =?us-ascii?Q?2k5lsdZd2wIe2eWtI55gQE4fQblrcPbeXcWDYRixw9osajhZVJX86p9GlNK9?=
 =?us-ascii?Q?cwzxqujDqijEEd42cRMi4k0zgOMT06cBCb0fo0HM4UwSVjXFlFyDeonG93QJ?=
 =?us-ascii?Q?5TWZTLVXGr3qCqdSMO1gnYbRJKXvJpz5JM0zoHbfPkUO25opjpUEzMH0fs4r?=
 =?us-ascii?Q?JWfsPl1egf6JAb5UjAHihBYhg0js/N7AD2xbh9r0ZVPS5e9CclMuJAiMvZYv?=
 =?us-ascii?Q?ef+85/4xmaejGOPJQ1hHhuIOLS4k3/5xWvsFIq0HLMa8xWjSjx+3mLP3xLZF?=
 =?us-ascii?Q?JuXSfy/gmu1J26bDxV0trZ/gKSI8BEayL9eI9lXxpJ9tTHIYoA5e8vykqDpH?=
 =?us-ascii?Q?Jw62aRe018TcjxQEnHgTzEAM80nMgeJItWSHi0nBOpae9L/myeuRYEJR9Lkb?=
 =?us-ascii?Q?vpBc5F7U9MMq5C9qqM7H/2T+Qr979nzU4HPZIeKNY+60FiHVoxQafANJkPuU?=
 =?us-ascii?Q?D/yai+V+n7Orx9vRoqKHqwpfTUmQP1eX3qcWobwKxUWMp+GnYzoKtErMuXNV?=
 =?us-ascii?Q?7ktMBRcJRrsHYADZScMcj8vWFHeJHxD38XtALdviWkdYH+pemD2W5jlokWjo?=
 =?us-ascii?Q?jniNxdFq9MULeMQKKXzd3IYfSC2/N18u0z8iII+ho20RJBOBDje6Ds0+Zf0j?=
 =?us-ascii?Q?Cd2ha/gsYfpc/DxwkdbMMIeXaYf3XDWjmNeraUDKl61EKCjDdrlHdc45u1nq?=
 =?us-ascii?Q?asPW3pqhoE923K3fQE3Ybt/wvdQfS2sMlEGiUQMOwvIjtdhKtEg3/6vDgraB?=
 =?us-ascii?Q?LjAUPBZwRIWU8vkwbmwVV7kwo9ejQD5Sy5mkX/x+zf0mBC1ZYs+bTWpwf22u?=
 =?us-ascii?Q?xi4vopJTzQFZjxMeTzbxZkoBIZmmWheaLSQ2a9ccc1mY/+/r61LghZT2j1vO?=
 =?us-ascii?Q?oNzmidO5tpbEkhThFFqhNeiIQsYWWW4Y1UMJrvfxCuxmnL3XxEgVVEm1irA+?=
 =?us-ascii?Q?shvAjvv44yaRQ2h7uPfgK0nMH7yR4Nnz+TeETWEQCr2Cba/GoZv//8WcAEFA?=
 =?us-ascii?Q?/Fl5K6apOuXzDMPleCIcLqTJX6yUKKAvIAebNh7Sf8gTt3TC47BrTtvgrsJ6?=
 =?us-ascii?Q?bGATp4yb3pWy2UFKbro7KMFBBubUNx+ceb9OKip8KOS70HLws2Y952lScvJd?=
 =?us-ascii?Q?Rly6T3jhoUcVGmjVrUmkZ4kH/WWovlvDMbvW+af97ozOD1JiV1FiFQM8Ogoh?=
 =?us-ascii?Q?PWydcuq+1UapxSyw2QySZLRFF1elgIw8q7PJI7MoitZa2HqwsxHtHXQ5hJvK?=
 =?us-ascii?Q?jgi8UejErCrk0wbP3t7wg1RS9YNwHCQg/Lt4uI3rmwoCNbqxt32/tbDeC+Gt?=
 =?us-ascii?Q?DLdYBqQKgcGhRiP8tr/ikhfATsJXqcNg8C1o1Yr0WuME+Fye/cB8ARi+GVZn?=
 =?us-ascii?Q?ov32HI2uWsUrLyMpA0g3t54=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d4100d-58e2-45f5-9cec-08dc23bd2b0c
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 07:04:15.8903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdIp8a8BGlohRCYbJLd9pCjYl6byMPBcqPYF8PsQpUfBwFUZHMkVVEHd071Oma3dap0sxIzjszrPXqM7BGkLsF+/CeYQRssnqEZXkORLZsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB1425

S_FMT/G_FMT should report the buffer size based on aligned width and height.
And, Host can set the real encoding size through s_selection and g_selection.
So, Driver should use the conf_win information for encoding size instead of size of S_FMT/G_FMT.

Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
---
 .../chips-media/wave5/wave5-vpu-dec.c         | 77 +++++++------------
 .../chips-media/wave5/wave5-vpu-enc.c         | 77 +++++++++++--------
 2 files changed, 72 insertions(+), 82 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 328a7a8f26c5..fb9449908ebd 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -243,54 +243,54 @@ static void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp, unsigned
 	case V4L2_PIX_FMT_NV21:
 		pix_mp->width = round_up(width, 32);
 		pix_mp->height = round_up(height, 16);
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = width * height * 3 / 2;
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height * 3 / 2;
 		break;
 	case V4L2_PIX_FMT_YUV422P:
 	case V4L2_PIX_FMT_NV16:
 	case V4L2_PIX_FMT_NV61:
 		pix_mp->width = round_up(width, 32);
 		pix_mp->height = round_up(height, 16);
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = width * height * 2;
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height * 2;
 		break;
 	case V4L2_PIX_FMT_YUV420M:
 		pix_mp->width = round_up(width, 32);
 		pix_mp->height = round_up(height, 16);
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = width * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32) / 2;
-		pix_mp->plane_fmt[1].sizeimage = width * height / 4;
-		pix_mp->plane_fmt[2].bytesperline = round_up(width, 32) / 2;
-		pix_mp->plane_fmt[2].sizeimage = width * height / 4;
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height;
+		pix_mp->plane_fmt[1].bytesperline = pix_mp->width / 2;
+		pix_mp->plane_fmt[1].sizeimage = pix_mp->width * pix_mp->height / 4;
+		pix_mp->plane_fmt[2].bytesperline = pix_mp->width / 2;
+		pix_mp->plane_fmt[2].sizeimage = pix_mp->width * pix_mp->height / 4;
 		break;
 	case V4L2_PIX_FMT_NV12M:
 	case V4L2_PIX_FMT_NV21M:
 		pix_mp->width = round_up(width, 32);
 		pix_mp->height = round_up(height, 16);
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = width * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[1].sizeimage = width * height / 2;
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height;
+		pix_mp->plane_fmt[1].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[1].sizeimage = pix_mp->width * pix_mp->height / 2;
 		break;
 	case V4L2_PIX_FMT_YUV422M:
 		pix_mp->width = round_up(width, 32);
 		pix_mp->height = round_up(height, 16);
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = width * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32) / 2;
-		pix_mp->plane_fmt[1].sizeimage = width * height / 2;
-		pix_mp->plane_fmt[2].bytesperline = round_up(width, 32) / 2;
-		pix_mp->plane_fmt[2].sizeimage = width * height / 2;
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height;
+		pix_mp->plane_fmt[1].bytesperline = pix_mp->width / 2;
+		pix_mp->plane_fmt[1].sizeimage = pix_mp->width * pix_mp->height / 2;
+		pix_mp->plane_fmt[2].bytesperline = pix_mp->width / 2;
+		pix_mp->plane_fmt[2].sizeimage = pix_mp->width * pix_mp->height / 2;
 		break;
 	case V4L2_PIX_FMT_NV16M:
 	case V4L2_PIX_FMT_NV61M:
 		pix_mp->width = round_up(width, 32);
 		pix_mp->height = round_up(height, 16);
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = width * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[1].sizeimage = width * height;
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height;
+		pix_mp->plane_fmt[1].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[1].sizeimage = pix_mp->width * pix_mp->height;
 		break;
 	default:
 		pix_mp->width = width;
@@ -1003,6 +1003,7 @@ static int wave5_vpu_dec_queue_setup(struct vb2_queue *q, unsigned int *num_buff
 	struct vpu_instance *inst = vb2_get_drv_priv(q);
 	struct v4l2_pix_format_mplane inst_format =
 		(q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) ? inst->src_fmt : inst->dst_fmt;
+	unsigned int i;
 
 	dev_dbg(inst->dev->dev, "%s: num_buffers: %u | num_planes: %u | type: %u\n", __func__,
 		*num_buffers, *num_planes, q->type);
@@ -1016,31 +1017,9 @@ static int wave5_vpu_dec_queue_setup(struct vb2_queue *q, unsigned int *num_buff
 		if (*num_buffers < inst->fbc_buf_count)
 			*num_buffers = inst->fbc_buf_count;
 
-		if (*num_planes == 1) {
-			if (inst->output_format == FORMAT_422)
-				sizes[0] = inst_format.width * inst_format.height * 2;
-			else
-				sizes[0] = inst_format.width * inst_format.height * 3 / 2;
-			dev_dbg(inst->dev->dev, "%s: size[0]: %u\n", __func__, sizes[0]);
-		} else if (*num_planes == 2) {
-			sizes[0] = inst_format.width * inst_format.height;
-			if (inst->output_format == FORMAT_422)
-				sizes[1] = inst_format.width * inst_format.height;
-			else
-				sizes[1] = inst_format.width * inst_format.height / 2;
-			dev_dbg(inst->dev->dev, "%s: size[0]: %u | size[1]: %u\n",
-				__func__, sizes[0], sizes[1]);
-		} else if (*num_planes == 3) {
-			sizes[0] = inst_format.width * inst_format.height;
-			if (inst->output_format == FORMAT_422) {
-				sizes[1] = inst_format.width * inst_format.height / 2;
-				sizes[2] = inst_format.width * inst_format.height / 2;
-			} else {
-				sizes[1] = inst_format.width * inst_format.height / 4;
-				sizes[2] = inst_format.width * inst_format.height / 4;
-			}
-			dev_dbg(inst->dev->dev, "%s: size[0]: %u | size[1]: %u | size[2]: %u\n",
-				__func__, sizes[0], sizes[1], sizes[2]);
+		for (i = 0; i < *num_planes; i++) {
+			sizes[i] = inst_format.plane_fmt[i].sizeimage;
+			dev_dbg(inst->dev->dev, "%s: size[%u]: %u\n", __func__, i, sizes[i]);
 		}
 	}
 
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index 62be7cdfccd8..6898d1513f11 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -150,46 +150,46 @@ static void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp, unsigned
 	case V4L2_PIX_FMT_YUV420:
 	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV21:
-		pix_mp->width = width;
-		pix_mp->height = height;
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height * 3 / 2;
+		pix_mp->width = round_up(width, 32);
+		pix_mp->height = round_up(height, 16);
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height * 3 / 2;
 		break;
 	case V4L2_PIX_FMT_YUV420M:
-		pix_mp->width = width;
-		pix_mp->height = height;
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32) / 2;
-		pix_mp->plane_fmt[1].sizeimage = round_up(width, 32) * height / 4;
-		pix_mp->plane_fmt[2].bytesperline = round_up(width, 32) / 2;
-		pix_mp->plane_fmt[2].sizeimage = round_up(width, 32) * height / 4;
+		pix_mp->width = round_up(width, 32);
+		pix_mp->height = round_up(height, 16);
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height;
+		pix_mp->plane_fmt[1].bytesperline = pix_mp->width / 2;
+		pix_mp->plane_fmt[1].sizeimage = pix_mp->width * pix_mp->height / 4;
+		pix_mp->plane_fmt[2].bytesperline = pix_mp->width / 2;
+		pix_mp->plane_fmt[2].sizeimage = pix_mp->width * pix_mp->height / 4;
 		break;
 	case V4L2_PIX_FMT_NV12M:
 	case V4L2_PIX_FMT_NV21M:
-		pix_mp->width = width;
-		pix_mp->height = height;
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[1].sizeimage = round_up(width, 32) * height / 2;
+		pix_mp->width = round_up(width, 32);
+		pix_mp->height = round_up(height, 16);
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height;
+		pix_mp->plane_fmt[1].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[1].sizeimage = pix_mp->width * pix_mp->height / 2;
 		break;
 	case V4L2_PIX_FMT_YUV422P:
 	case V4L2_PIX_FMT_NV16:
 	case V4L2_PIX_FMT_NV61:
-		pix_mp->width = width;
-		pix_mp->height = height;
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height * 2;
+		pix_mp->width = round_up(width, 32);
+		pix_mp->height = round_up(height, 16);
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height * 2;
 		break;
 	case V4L2_PIX_FMT_NV16M:
 	case V4L2_PIX_FMT_NV61M:
-		pix_mp->width = width;
-		pix_mp->height = height;
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[1].sizeimage = round_up(width, 32) * height;
+		pix_mp->width = round_up(width, 32);
+		pix_mp->height = round_up(height, 16);
+		pix_mp->plane_fmt[0].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[0].sizeimage = pix_mp->width * pix_mp->height;
+		pix_mp->plane_fmt[1].bytesperline = pix_mp->width;
+		pix_mp->plane_fmt[1].sizeimage = pix_mp->width * pix_mp->height;
 		break;
 	default:
 		pix_mp->width = width;
@@ -636,6 +636,8 @@ static int wave5_vpu_enc_s_fmt_out(struct file *file, void *fh, struct v4l2_form
 	inst->xfer_func = f->fmt.pix_mp.xfer_func;
 
 	wave5_update_pix_fmt(&inst->dst_fmt, f->fmt.pix_mp.width, f->fmt.pix_mp.height);
+	inst->conf_win.width = inst->dst_fmt.width;
+	inst->conf_win.height = inst->dst_fmt.height;
 
 	return 0;
 }
@@ -651,12 +653,17 @@ static int wave5_vpu_enc_g_selection(struct file *file, void *fh, struct v4l2_se
 	switch (s->target) {
 	case V4L2_SEL_TGT_CROP_DEFAULT:
 	case V4L2_SEL_TGT_CROP_BOUNDS:
-	case V4L2_SEL_TGT_CROP:
 		s->r.left = 0;
 		s->r.top = 0;
 		s->r.width = inst->dst_fmt.width;
 		s->r.height = inst->dst_fmt.height;
 		break;
+	case V4L2_SEL_TGT_CROP:
+		s->r.left = 0;
+		s->r.top = 0;
+		s->r.width = inst->conf_win.width;
+		s->r.height = inst->conf_win.height;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -679,8 +686,10 @@ static int wave5_vpu_enc_s_selection(struct file *file, void *fh, struct v4l2_se
 
 	s->r.left = 0;
 	s->r.top = 0;
-	s->r.width = inst->src_fmt.width;
-	s->r.height = inst->src_fmt.height;
+	s->r.width = min(s->r.width, inst->dst_fmt.width);
+	s->r.height = min(s->r.height, inst->dst_fmt.height);
+
+	inst->conf_win = s->r;
 
 	return 0;
 }
@@ -1227,8 +1236,8 @@ static void wave5_set_enc_openparam(struct enc_open_param *open_param,
 	open_param->wave_param.lambda_scaling_enable = 1;
 
 	open_param->line_buf_int_en = true;
-	open_param->pic_width = inst->dst_fmt.width;
-	open_param->pic_height = inst->dst_fmt.height;
+	open_param->pic_width = inst->conf_win.width;
+	open_param->pic_height = inst->conf_win.height;
 	open_param->frame_rate_info = inst->frame_rate;
 	open_param->rc_enable = inst->rc_enable;
 	if (inst->rc_enable) {
@@ -1804,6 +1813,8 @@ static int wave5_vpu_open_enc(struct file *filp)
 	v4l2_ctrl_handler_setup(v4l2_ctrl_hdl);
 
 	wave5_set_default_format(&inst->src_fmt, &inst->dst_fmt);
+	inst->conf_win.width = inst->dst_fmt.width;
+	inst->conf_win.height = inst->dst_fmt.height;
 	inst->colorspace = V4L2_COLORSPACE_REC709;
 	inst->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
 	inst->quantization = V4L2_QUANTIZATION_DEFAULT;
-- 
2.43.0


