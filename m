Return-Path: <linux-kernel+bounces-52248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6958495E1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43BD0B2498E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6996E1400B;
	Mon,  5 Feb 2024 09:05:02 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2116.outbound.protection.partner.outlook.cn [139.219.17.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4D1134B6;
	Mon,  5 Feb 2024 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123900; cv=fail; b=iDh1QpxnqQdXeJPwDJoX67p9f8JjQabb6qdbFAi5cUh9PJjfB9Zh1E9XWqnfgyMugQNtvz0zKW7MU4OEVlPCgdY78NhnYzokUgmWZsLpVLb73HiTw3LEoaqV/7dmu1rqOroMr+1ZDSQIM7VezN/FqQDmLeNorrBKPs6K6LVFW0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123900; c=relaxed/simple;
	bh=7iQ118uYM6gWeVZz8zekH3q9b1HL0jt0ToRo3b4Y5/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dA5dTzCo6/Vh3DueujhBR9KCFA+aR874fKd9R4KOJydUJzoXgEdnkdK1fBsqHxU3kLb2qWjmPksxjTevzQQy/xIfdY6y8NSjyoVxUpyJe/lSVhR9ubZEXWiTdkGX1y+KYtH0AqEvWRDIlkmELO2h9L/4hsZkUvaY2a1FbL2WpHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSwsgni9C7PP280E9uVm2cCXTw5VjNV7a2di2mn66DBx1C2JdB6dVw+NcUD4O23e5tmZa3T/PfbBFpk43JO3l61TGfeatJfRdcxSX5m1OrWJ3MjCx37SJTHjCL1dGha6pdQc851bzzNDI9KUUJqdEHSU6XKK9e22ZXFcKHgNthaPd/CxL7ftCVp14Avoaz2l1IWhoJmZRDFc85+ZDe4NqrXuvzFN/r/awTxRcYFQNkNsOMViuTV4DciOteWAeSWlqMvsepg7Zu7m+iSg1yylv6bfX7O4vh729jCILZGb6R5XlgQJlcXNy1Idno/WI4OjQqn3sp4G5FP7dQNCFY4Zew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/+SgaIHb8ve1EJBK8xmQXM0Ol+XWQdwKYyTAGN6oPk=;
 b=lBs9fIhwBmxnMvcDfOmWWnyTc0z9eN2eB2C2MsPuE/wBsuV7UOcKnYk9zOQqzAC1wyfgZuybXr/GbnTCA2JZqdxy5K+SNVm/k5rSfv2OCLVkeP13DoBDlLqo/EBHC0oinKGFwZnxkWlYKBGUG8mDwygQiUn0Xjpy5NgfPS3TzNvlyg/cK9WTvbGngIe3MOSIF9dHW/ORG55BAMNVXdv384Jem6GjNnGUH3WaHkY0mErzQdEgcSbGMDD5UkP9lWyVhae/8Q+lhNtaENXo5+ly4xH8gjRPC+whZTo6Xa24n5rb8bCKSCXKlOU39j5Bae9uQR8krHDX8KSrUAv5SWTQnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0815.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 09:04:46 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.025; Mon, 5 Feb 2024 09:04:46 +0000
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
Subject: [PATCH v3 08/13] staging: media: starfive: Add for StarFive ISP 3A SC
Date: Mon,  5 Feb 2024 01:04:19 -0800
Message-Id: <20240205090424.40302-9-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: d741d319-d6b3-4f1b-c888-08dc26298032
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2apvJBPQ1sPVyD2za9qpiN8LSwhDDCrF75g7+AtXXHoD8dqp1BUXgHi+U8OirZ3nSKFrf7a3CddtisM99yO00fWIBjiKtIwjA9GajKfc9eyXI8AgVG6BBj+EzpDaMQuvot1zz/WDt/IqYdZFIpAnWxz1krJC1H2I/yDPcg0RtWess5+S6cKO0aX4MmL8r63U1N/vUd9NIU5fvqOXucKIG42BzoHaJYhokGQNOfhV/IwaL29qhPbFcmyM/jmUfmMDQXxhbf+OlAUE1MjoDSowd8k27pz+IGXW56rc6HE0FCtj6FMsFVvptNfVXF4BkCVoi6K7P5D0Tk4VCq3hqNU+eqzRtuEthnEgFogbfhKF7WTYNneWA3NBZFY4G59m59wYkcmfyh4TD0XpwCjvuBTOcTO2z6WvczuNLS3w5DQ3eRF1d7MULFva5EuQc1F5woNBRhQhG8QTJEqVc//R4GpQcVNG5hmOkUXlRQaDg6umRh3evFKlTnwaCw5Xbn/pGuM8n6vI0jWmWtiaIaXFFCdNg+MsJURTC1rwtLv9piyqrjf0kjXyFALC5OUyiqVwLaS7KYGvx/kkR9+j9sm2t3mztw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41320700001)(6666004)(52116002)(36756003)(40180700001)(508600001)(38350700005)(40160700002)(38100700002)(2616005)(1076003)(26005)(83380400001)(86362001)(5660300002)(2906002)(7416002)(30864003)(8936002)(8676002)(4326008)(110136005)(44832011)(54906003)(66946007)(66556008)(66476007)(41300700001)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JXSc9HJAjt5xRRnrcWQQmFbqFHac8t7qba48X5RaZ+dJpjwO3xOjBvl9VCfK?=
 =?us-ascii?Q?A7EhWn1JFZNDQjgd5dXhg1sISM+r5fdI7azvw9odPKySsyvEO4aZ4TM4W3mL?=
 =?us-ascii?Q?+2CSicPM3uvuDK26bqKeW629seKlD9XT4Rqd6Zpl8uGG/AD3yLe5JUDzAb2Z?=
 =?us-ascii?Q?a1gW83k7RkZn15+PQyeBHP4ch77jWLF0z+3FmuGCNQBOtJ9aA4ScXWDKAAJ5?=
 =?us-ascii?Q?UQfsYzY8vfexp6VnPv+Cu4HHo2HrN5IXmqtnd8aKC6L6kaT5BcySXiyBq6Tx?=
 =?us-ascii?Q?SK5dUz+DkqSrh7vGP0qHNsMogJxgvZTnq6RPFkgDkxifeunZbQLU0XwtOsyt?=
 =?us-ascii?Q?mvMte1COD3uLF0Mk/m8NGzkCnHw/OWuzdNlhyG4PAP9sQNVr2VcKWaiGQi0U?=
 =?us-ascii?Q?f/Ha9JeFsbnUI/5uh8WvRTmFqM37VY05TIdKbES/z/c8TYPcj2SUnKLVcdOc?=
 =?us-ascii?Q?s6VnwBVldq/h3delv/fosouzphzsWPXydhokj0rRY7XD7ebibQDp8GrsY+n8?=
 =?us-ascii?Q?R8dRFNMAgUM/8boF1ABIfne8fKwME4f8WafjPFl8BheHpyylQJUyPICZvJBv?=
 =?us-ascii?Q?mZbMSAWT6DUF3gubXyTGNfyus65bZ6ICLmrdshbueS0oizCehdxBcQgwPYHP?=
 =?us-ascii?Q?dQz+R1G1UQzDkbcUIZ0asDCoyxviQ+LXc0flhSq/A020KlmHU8ostdUJznHb?=
 =?us-ascii?Q?s1dXn8oZDasR4WWNUYGqR6CWsd+xclk8XdNxvLoEAbAd5OC+sJ/lV4lzqAz8?=
 =?us-ascii?Q?8WBXOkOkCc5pKwl+sHtHbcc4vWhFRHhXBUU7d6zHLQz8Rt4SAfNCbgUQUJSW?=
 =?us-ascii?Q?5TYFxNyLOI25TrdJYAOTBK3YnTklKfJulJ27JFeHQ+7YOKsHSr7zY4pUi2NN?=
 =?us-ascii?Q?0QtIGO8/380D2u9rBiP0lUoHUMsBZuy9l73zei1gsCQH3+zLzo1x8+SYuOto?=
 =?us-ascii?Q?DncmobdXXHvMQA43x/dIwbkeSQ0JLBxj9wWo17+RpYiPIiJOZ4Raftw0YmjD?=
 =?us-ascii?Q?BnpqKyY5hqcb9l1JRp8ywI3FLQ+aUloNA35EwREbasS6GwnT6Rb6jgGbLolo?=
 =?us-ascii?Q?P6lb0mC0pVBRoD98ybDEcjNiIT/66Dmp25G7ZIkQxWkOYIPRfuxDIY55bMyV?=
 =?us-ascii?Q?MVDxpD9SgTPPoF1++InkEMe9RQ9QhajPVtLJNot+7KW93nR34J36MOCmOzNa?=
 =?us-ascii?Q?D3xGEyUZOAwW7X1Dx4NtBdWNMKcL77i2X+C4QsRxS09UGtV73Ve8pUatq+9K?=
 =?us-ascii?Q?oEuT1gD5rMRM2Afi4MhLDC+9dJKBLqUljWEMjhGTyoP3eO62j0/naxwa6cSc?=
 =?us-ascii?Q?SKva8ZUWQAlD3clqWM8FfyPfKbAwwqjxtJgFw/RfW+NJrSBvDkGu2oTEgvYM?=
 =?us-ascii?Q?y91cTGWz2DfMXIe5+/EuPjRCUkSXqA6lTmLShBxgCBQwX9zA5DQTeei+Gt31?=
 =?us-ascii?Q?rq2V+47VX+WWLmgD0T+kmg+jE+CuZdoNBvir+JqDmmy771TuB6z54yuYePqY?=
 =?us-ascii?Q?waKL23NRwdaHyW76XWzewuIVpfmcC2/1qEIH5XYzkV39dzOHIb+QJ1B45pOZ?=
 =?us-ascii?Q?k3zdg7nWE9fX6W9/EtGGWUGbBJOX/KyWfeh/eLzf+KjtIHobZD1IWrfVRIKG?=
 =?us-ascii?Q?mdIKtQ6j3wQQ0LpMaOiPaa8=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d741d319-d6b3-4f1b-c888-08dc26298032
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 09:04:46.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dH6p4WALqCbjwr5l/tttiWvDj1OGsPy41XcxB4YqTsamqzU0cSVR6MZIpHkFUv6DLoIv4ui6f05y6AqzKGWpbnhTNpWss3VPQTKJYtw2LXXCOVBfY13o3CqU5xUP62Wa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0815

Register ISP 3A "capture_scd" video device to receive statistics
collection data.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../staging/media/starfive/camss/stf-buffer.h |   1 +
 .../staging/media/starfive/camss/stf-camss.c  |  18 +++
 .../media/starfive/camss/stf-capture.c        |  21 ++-
 .../media/starfive/camss/stf-isp-hw-ops.c     |  66 ++++++++
 .../staging/media/starfive/camss/stf-isp.h    |  23 +++
 .../staging/media/starfive/camss/stf-video.c  | 143 +++++++++++++++++-
 .../staging/media/starfive/camss/stf-video.h  |   1 +
 7 files changed, 264 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-buffer.h b/drivers/staging/media/starfive/camss/stf-buffer.h
index 9d1670fb05ed..727d00617448 100644
--- a/drivers/staging/media/starfive/camss/stf-buffer.h
+++ b/drivers/staging/media/starfive/camss/stf-buffer.h
@@ -23,6 +23,7 @@ enum stf_v_state {
 struct stfcamss_buffer {
 	struct vb2_v4l2_buffer vb;
 	dma_addr_t addr[2];
+	void *vaddr;
 	struct list_head queue;
 };
 
diff --git a/drivers/staging/media/starfive/camss/stf-camss.c b/drivers/staging/media/starfive/camss/stf-camss.c
index a587f860101a..04caa4dac2f7 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.c
+++ b/drivers/staging/media/starfive/camss/stf-camss.c
@@ -126,6 +126,7 @@ static int stfcamss_of_parse_ports(struct stfcamss *stfcamss)
 static int stfcamss_register_devs(struct stfcamss *stfcamss)
 {
 	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
 	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
 	int ret;
 
@@ -150,8 +151,18 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)
 
 	cap_yuv->video.source_subdev = &isp_dev->subdev;
 
+	ret = media_create_pad_link(&isp_dev->subdev.entity, STF_ISP_PAD_SRC_SCD,
+				    &cap_scd->video.vdev.entity, 0, 0);
+	if (ret)
+		goto err_rm_links0;
+
+	cap_scd->video.source_subdev = &isp_dev->subdev;
+
 	return ret;
 
+err_rm_links0:
+	media_entity_remove_links(&isp_dev->subdev.entity);
+	media_entity_remove_links(&cap_yuv->video.vdev.entity);
 err_cap_unregister:
 	stf_capture_unregister(stfcamss);
 err_isp_unregister:
@@ -162,6 +173,13 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)
 
 static void stfcamss_unregister_devs(struct stfcamss *stfcamss)
 {
+	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
+	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
+
+	media_entity_remove_links(&isp_dev->subdev.entity);
+	media_entity_remove_links(&cap_scd->video.vdev.entity);
+	media_entity_remove_links(&cap_yuv->video.vdev.entity);
 	stf_isp_unregister(&stfcamss->isp_dev);
 	stf_capture_unregister(stfcamss);
 }
diff --git a/drivers/staging/media/starfive/camss/stf-capture.c b/drivers/staging/media/starfive/camss/stf-capture.c
index e91e726a1462..20c43e3f9b08 100644
--- a/drivers/staging/media/starfive/camss/stf-capture.c
+++ b/drivers/staging/media/starfive/camss/stf-capture.c
@@ -12,6 +12,7 @@
 static const char * const stf_cap_names[] = {
 	"capture_raw",
 	"capture_yuv",
+	"capture_scd",
 };
 
 static const struct stfcamss_format_info stf_wr_fmts[] = {
@@ -55,6 +56,14 @@ static const struct stfcamss_format_info stf_isp_fmts[] = {
 	},
 };
 
+/* 3A Statistics Collection Data */
+static const struct stfcamss_format_info stf_isp_scd_fmts[] = {
+	{
+		.code = MEDIA_BUS_FMT_METADATA_FIXED,
+		.pixelformat = V4L2_META_FMT_STF_ISP_STAT_3A,
+	},
+};
+
 static inline struct stf_capture *to_stf_capture(struct stfcamss_video *video)
 {
 	return container_of(video, struct stf_capture, video);
@@ -84,6 +93,8 @@ static void stf_init_addrs(struct stfcamss_video *video)
 		stf_set_raw_addr(video->stfcamss, addr0);
 	else if (cap->type == STF_CAPTURE_YUV)
 		stf_set_yuv_addr(video->stfcamss, addr0, addr1);
+	else
+		stf_set_scd_addr(video->stfcamss, addr0, addr1, TYPE_AWB);
 }
 
 static void stf_cap_s_cfg(struct stfcamss_video *video)
@@ -227,18 +238,24 @@ static void stf_capture_init(struct stfcamss *stfcamss, struct stf_capture *cap)
 	INIT_LIST_HEAD(&cap->buffers.ready_bufs);
 	spin_lock_init(&cap->buffers.lock);
 
-	cap->video.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	cap->video.stfcamss = stfcamss;
 	cap->video.bpl_alignment = 16 * 8;
 
 	if (cap->type == STF_CAPTURE_RAW) {
+		cap->video.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 		cap->video.formats = stf_wr_fmts;
 		cap->video.nformats = ARRAY_SIZE(stf_wr_fmts);
 		cap->video.bpl_alignment = 8;
 	} else if (cap->type == STF_CAPTURE_YUV) {
+		cap->video.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 		cap->video.formats = stf_isp_fmts;
 		cap->video.nformats = ARRAY_SIZE(stf_isp_fmts);
 		cap->video.bpl_alignment = 1;
+	} else {
+		cap->video.type = V4L2_BUF_TYPE_META_CAPTURE;
+		cap->video.formats = stf_isp_scd_fmts;
+		cap->video.nformats = ARRAY_SIZE(stf_isp_scd_fmts);
+		cap->video.bpl_alignment = 16 * 8;
 	}
 }
 
@@ -362,9 +379,11 @@ void stf_capture_unregister(struct stfcamss *stfcamss)
 {
 	struct stf_capture *cap_raw = &stfcamss->captures[STF_CAPTURE_RAW];
 	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
 
 	stf_capture_unregister_one(cap_raw);
 	stf_capture_unregister_one(cap_yuv);
+	stf_capture_unregister_one(cap_scd);
 }
 
 int stf_capture_register(struct stfcamss *stfcamss,
diff --git a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
index 6b3966ca18bf..ae88668e5798 100644
--- a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
+++ b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
@@ -451,11 +451,57 @@ void stf_set_yuv_addr(struct stfcamss *stfcamss,
 	stf_isp_reg_write(stfcamss, ISP_REG_UV_PLANE_START_ADDR, uv_addr);
 }
 
+static enum stf_isp_type_scd stf_get_isp_scd_type(struct stfcamss *stfcamss)
+{
+	int val;
+
+	val = stf_isp_reg_read(stfcamss, ISP_REG_SC_CFG_1);
+	return (enum stf_isp_type_scd)(val & ISP_SC_SEL_MASK) >> 30;
+}
+
+void stf_set_scd_addr(struct stfcamss *stfcamss,
+		      dma_addr_t yhist_addr, dma_addr_t scd_addr,
+		      enum stf_isp_type_scd type_scd)
+{
+	stf_isp_reg_set_bit(stfcamss, ISP_REG_SC_CFG_1, ISP_SC_SEL_MASK,
+			    SEL_TYPE(type_scd));
+	stf_isp_reg_write(stfcamss, ISP_REG_SCD_CFG_0, scd_addr);
+	stf_isp_reg_write(stfcamss, ISP_REG_YHIST_CFG_4, yhist_addr);
+}
+
+static void stf_isp_fill_yhist(struct stfcamss *stfcamss, void *vaddr)
+{
+	struct jh7110_isp_sc_buffer *sc = (struct jh7110_isp_sc_buffer *)vaddr;
+	u32 reg_addr = ISP_REG_YHIST_ACC_0;
+	u32 i;
+
+	for (i = 0; i < 64; i++, reg_addr += 4)
+		sc->y_histogram[i] = stf_isp_reg_read(stfcamss, reg_addr);
+}
+
+static void stf_isp_fill_flag(struct stfcamss *stfcamss, void *vaddr,
+			      enum stf_isp_type_scd *type_scd)
+{
+	struct jh7110_isp_sc_buffer *sc = (struct jh7110_isp_sc_buffer *)vaddr;
+
+	*type_scd = stf_get_isp_scd_type(stfcamss);
+	if (*type_scd == TYPE_AWB) {
+		sc->flag = JH7110_ISP_SC_FALG_AWB;
+		*type_scd = TYPE_OECF;
+	} else {
+		sc->flag = JH7110_ISP_SC_FALG_AE_AF;
+		*type_scd = TYPE_AWB;
+	}
+}
+
 irqreturn_t stf_line_irq_handler(int irq, void *priv)
 {
 	struct stfcamss *stfcamss = priv;
 	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
 	struct stfcamss_buffer *change_buf;
+	enum stf_isp_type_scd type_scd;
+	u32 value;
 	u32 status;
 
 	status = stf_isp_reg_read(stfcamss, ISP_REG_ISP_CTRL_0);
@@ -467,6 +513,17 @@ irqreturn_t stf_line_irq_handler(int irq, void *priv)
 					stf_set_yuv_addr(stfcamss, change_buf->addr[0],
 							 change_buf->addr[1]);
 			}
+
+			value = stf_isp_reg_read(stfcamss, ISP_REG_CSI_MODULE_CFG);
+			if (value & CSI_SC_EN) {
+				change_buf = stf_change_buffer(&cap_scd->buffers);
+				if (change_buf) {
+					stf_isp_fill_flag(stfcamss, change_buf->vaddr,
+							  &type_scd);
+					stf_set_scd_addr(stfcamss, change_buf->addr[0],
+							 change_buf->addr[1], type_scd);
+				}
+			}
 		}
 
 		stf_isp_reg_set_bit(stfcamss, ISP_REG_CSIINTS,
@@ -485,6 +542,7 @@ irqreturn_t stf_isp_irq_handler(int irq, void *priv)
 {
 	struct stfcamss *stfcamss = priv;
 	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
 	struct stfcamss_buffer *ready_buf;
 	u32 status;
 
@@ -496,6 +554,14 @@ irqreturn_t stf_isp_irq_handler(int irq, void *priv)
 				vb2_buffer_done(&ready_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
 		}
 
+		if (status & ISPC_SC) {
+			ready_buf = stf_buf_done(&cap_scd->buffers);
+			if (ready_buf) {
+				stf_isp_fill_yhist(stfcamss, ready_buf->vaddr);
+				vb2_buffer_done(&ready_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+			}
+		}
+
 		stf_isp_reg_write(stfcamss, ISP_REG_ISP_CTRL_0,
 				  (status & ~ISPC_INT_ALL_MASK) |
 				  ISPC_ISP | ISPC_CSI | ISPC_SC);
diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
index fcda0502e3b0..0af7b367e57a 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.h
+++ b/drivers/staging/media/starfive/camss/stf-isp.h
@@ -10,6 +10,7 @@
 #ifndef STF_ISP_H
 #define STF_ISP_H
 
+#include <linux/jh7110-isp.h>
 #include <media/v4l2-subdev.h>
 
 #include "stf-video.h"
@@ -107,6 +108,12 @@
 #define Y_COOR(y)				((y) << 16)
 #define X_COOR(x)				((x) << 0)
 
+#define ISP_REG_SCD_CFG_0			0x098
+
+#define ISP_REG_SC_CFG_1			0x0bc
+#define ISP_SC_SEL_MASK				GENMASK(31, 30)
+#define SEL_TYPE(n)				((n) << 30)
+
 #define ISP_REG_LCCF_CFG_2			0x0e0
 #define ISP_REG_LCCF_CFG_3			0x0e4
 #define ISP_REG_LCCF_CFG_4			0x0e8
@@ -305,6 +312,10 @@
 #define DNRM_F(n)				((n) << 16)
 #define CCM_M_DAT(n)				((n) << 0)
 
+#define ISP_REG_YHIST_CFG_4			0xcd8
+
+#define ISP_REG_YHIST_ACC_0			0xd00
+
 #define ISP_REG_GAMMA_VAL0			0xe00
 #define ISP_REG_GAMMA_VAL1			0xe04
 #define ISP_REG_GAMMA_VAL2			0xe08
@@ -389,6 +400,15 @@
 #define IMAGE_MAX_WIDTH				1920
 #define IMAGE_MAX_HEIGH				1080
 
+#define ISP_YHIST_BUFFER_SIZE			(64 * sizeof(__u32))
+
+enum stf_isp_type_scd {
+	TYPE_DEC = 0,
+	TYPE_OBC,
+	TYPE_OECF,
+	TYPE_AWB,
+};
+
 /* pad id for media framework */
 enum stf_isp_pad_id {
 	STF_ISP_PAD_SINK = 0,
@@ -429,5 +449,8 @@ int stf_isp_unregister(struct stf_isp_dev *isp_dev);
 
 void stf_set_yuv_addr(struct stfcamss *stfcamss,
 		      dma_addr_t y_addr, dma_addr_t uv_addr);
+void stf_set_scd_addr(struct stfcamss *stfcamss,
+		      dma_addr_t yhist_addr, dma_addr_t scd_addr,
+		      enum stf_isp_type_scd type_scd);
 
 #endif /* STF_ISP_H */
diff --git a/drivers/staging/media/starfive/camss/stf-video.c b/drivers/staging/media/starfive/camss/stf-video.c
index 989b5e82bae9..d9e51d4e2004 100644
--- a/drivers/staging/media/starfive/camss/stf-video.c
+++ b/drivers/staging/media/starfive/camss/stf-video.c
@@ -125,6 +125,14 @@ static int stf_video_init_format(struct stfcamss_video *video)
 	return 0;
 }
 
+static int stf_video_scd_init_format(struct stfcamss_video *video)
+{
+	video->active_fmt.fmt.meta.dataformat = video->formats[0].pixelformat;
+	video->active_fmt.fmt.meta.buffersize = sizeof(struct jh7110_isp_sc_buffer);
+
+	return 0;
+}
+
 /* -----------------------------------------------------------------------------
  * Video queue operations
  */
@@ -330,6 +338,75 @@ static const struct vb2_ops stf_video_vb2_q_ops = {
 	.stop_streaming  = video_stop_streaming,
 };
 
+static int video_scd_queue_setup(struct vb2_queue *q,
+				 unsigned int *num_buffers,
+				 unsigned int *num_planes,
+				 unsigned int sizes[],
+				 struct device *alloc_devs[])
+{
+	*num_planes = 1;
+	sizes[0] = sizeof(struct jh7110_isp_sc_buffer);
+
+	return 0;
+}
+
+static int video_scd_buf_init(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct stfcamss_buffer *buffer = to_stfcamss_buffer(vbuf);
+	dma_addr_t *paddr;
+
+	paddr = vb2_plane_cookie(vb, 0);
+	buffer->addr[0] = *paddr;
+	buffer->addr[1] = buffer->addr[0] + ISP_YHIST_BUFFER_SIZE;
+	buffer->vaddr = vb2_plane_vaddr(vb, 0);
+
+	return 0;
+}
+
+static int video_scd_buf_prepare(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+
+	if (sizeof(struct jh7110_isp_sc_buffer) > vb2_plane_size(vb, 0))
+		return -EINVAL;
+
+	vb2_set_plane_payload(vb, 0, sizeof(struct jh7110_isp_sc_buffer));
+
+	vbuf->field = V4L2_FIELD_NONE;
+
+	return 0;
+}
+
+static int video_scd_start_streaming(struct vb2_queue *q, unsigned int count)
+{
+	struct stfcamss_video *video = vb2_get_drv_priv(q);
+
+	video->ops->start_streaming(video);
+
+	return 0;
+}
+
+static void video_scd_stop_streaming(struct vb2_queue *q)
+{
+	struct stfcamss_video *video = vb2_get_drv_priv(q);
+
+	video->ops->stop_streaming(video);
+
+	video->ops->flush_buffers(video, VB2_BUF_STATE_ERROR);
+}
+
+static const struct vb2_ops stf_video_scd_vb2_q_ops = {
+	.queue_setup     = video_scd_queue_setup,
+	.wait_prepare    = vb2_ops_wait_prepare,
+	.wait_finish     = vb2_ops_wait_finish,
+	.buf_init        = video_scd_buf_init,
+	.buf_prepare     = video_scd_buf_prepare,
+	.buf_queue       = video_buf_queue,
+	.start_streaming = video_scd_start_streaming,
+	.stop_streaming  = video_scd_stop_streaming,
+};
+
 /* -----------------------------------------------------------------------------
  * V4L2 ioctls
  */
@@ -448,6 +525,37 @@ static const struct v4l2_ioctl_ops stf_vid_ioctl_ops = {
 	.vidioc_streamoff               = vb2_ioctl_streamoff,
 };
 
+static int video_scd_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct stfcamss_video *video = video_drvdata(file);
+	struct v4l2_meta_format *meta = &f->fmt.meta;
+
+	if (f->type != video->type)
+		return -EINVAL;
+
+	meta->dataformat = video->active_fmt.fmt.meta.dataformat;
+	meta->buffersize = video->active_fmt.fmt.meta.buffersize;
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops stf_vid_scd_ioctl_ops = {
+	.vidioc_querycap                = video_querycap,
+	.vidioc_enum_fmt_meta_cap       = video_enum_fmt,
+	.vidioc_g_fmt_meta_cap          = video_scd_g_fmt,
+	.vidioc_s_fmt_meta_cap          = video_scd_g_fmt,
+	.vidioc_try_fmt_meta_cap        = video_scd_g_fmt,
+	.vidioc_reqbufs                 = vb2_ioctl_reqbufs,
+	.vidioc_querybuf                = vb2_ioctl_querybuf,
+	.vidioc_qbuf                    = vb2_ioctl_qbuf,
+	.vidioc_expbuf                  = vb2_ioctl_expbuf,
+	.vidioc_dqbuf                   = vb2_ioctl_dqbuf,
+	.vidioc_create_bufs             = vb2_ioctl_create_bufs,
+	.vidioc_prepare_buf             = vb2_ioctl_prepare_buf,
+	.vidioc_streamon                = vb2_ioctl_streamon,
+	.vidioc_streamoff               = vb2_ioctl_streamoff,
+};
+
 /* -----------------------------------------------------------------------------
  * V4L2 file operations
  */
@@ -473,6 +581,9 @@ static int stf_link_validate(struct media_link *link)
 	struct stfcamss_video *video = video_get_drvdata(vdev);
 	int ret;
 
+	if (video->type == V4L2_BUF_TYPE_META_CAPTURE)
+		return 0;
+
 	ret = stf_video_check_format(video);
 
 	return ret;
@@ -506,7 +617,11 @@ int stf_video_register(struct stfcamss_video *video,
 	q = &video->vb2_q;
 	q->drv_priv = video;
 	q->mem_ops = &vb2_dma_contig_memops;
-	q->ops = &stf_video_vb2_q_ops;
+
+	if (video->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		q->ops = &stf_video_vb2_q_ops;
+	else
+		q->ops = &stf_video_scd_vb2_q_ops;
 	q->type = video->type;
 	q->io_modes = VB2_DMABUF | VB2_MMAP;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
@@ -529,16 +644,28 @@ int stf_video_register(struct stfcamss_video *video,
 		goto err_mutex_destroy;
 	}
 
-	ret = stf_video_init_format(video);
-	if (ret < 0) {
-		dev_err(video->stfcamss->dev,
-			"Failed to init format: %d\n", ret);
-		goto err_media_cleanup;
+	if (video->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
+		ret = stf_video_init_format(video);
+		if (ret < 0) {
+			dev_err(video->stfcamss->dev,
+				"Failed to init format: %d\n", ret);
+			goto err_media_cleanup;
+		}
+		vdev->ioctl_ops = &stf_vid_ioctl_ops;
+		vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE;
+	} else {
+		ret = stf_video_scd_init_format(video);
+		if (ret < 0) {
+			dev_err(video->stfcamss->dev,
+				"Failed to init format: %d\n", ret);
+			goto err_media_cleanup;
+		}
+		vdev->ioctl_ops = &stf_vid_scd_ioctl_ops;
+		vdev->device_caps = V4L2_CAP_META_CAPTURE;
 	}
 
 	vdev->fops = &stf_vid_fops;
-	vdev->ioctl_ops = &stf_vid_ioctl_ops;
-	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
+	vdev->device_caps |= V4L2_CAP_STREAMING;
 	vdev->entity.ops = &stf_media_ops;
 	vdev->vfl_dir = VFL_DIR_RX;
 	vdev->release = stf_video_release;
diff --git a/drivers/staging/media/starfive/camss/stf-video.h b/drivers/staging/media/starfive/camss/stf-video.h
index 59799b65cbe5..53a1cf4e59b7 100644
--- a/drivers/staging/media/starfive/camss/stf-video.h
+++ b/drivers/staging/media/starfive/camss/stf-video.h
@@ -37,6 +37,7 @@ enum stf_v_line_id {
 enum stf_capture_type {
 	STF_CAPTURE_RAW = 0,
 	STF_CAPTURE_YUV,
+	STF_CAPTURE_SCD,
 	STF_CAPTURE_NUM,
 };
 
-- 
2.25.1


