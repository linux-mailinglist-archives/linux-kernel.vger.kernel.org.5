Return-Path: <linux-kernel+bounces-125783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBB2892C0A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E941F22BF2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D3031A66;
	Sat, 30 Mar 2024 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SqpdaoP5"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2057.outbound.protection.outlook.com [40.92.74.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A851E878;
	Sat, 30 Mar 2024 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.74.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711816516; cv=fail; b=b69rv26DMaRcVjbYw4bdlNeMc6PzdIrZA89/7H0RBL4721U1dTcgCP4DtVbOTsrx4RRIFrTXnd0QPxbuMVZRNT1aGU2MO7FIJC268lGydRCKF25aTqLieTpP4lT0eGdnK9IY4eOByGj7HLGdXn0tUxdXfvlPdJTvtEIIzJxBBnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711816516; c=relaxed/simple;
	bh=VdzvQmAICSZ29WbYZ9+rlSYW2KmpJLTwUX2K9EE+Kn4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sj3Qvokqt7cVXb5PdNHlS9TpBQTRe4o3bFn6uPg4UNjW/rGukZIAuFfTZq/91lXxB2LkJ1CC0+da0kk5xwFvDmrHDTkbz64va/5SKHqfze5ph5avjiwmkxbii6ceK8jubqkd7dHNaY1IxsDv1JHQbGdV8ZOszvcE0Yhww8WF+fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SqpdaoP5; arc=fail smtp.client-ip=40.92.74.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gX8wtlpmnw23sMdsJ8WOWYW3ScJXbWmAQLvGIu2/6X9Urn/pUcuWXYuXgisEk3GHGuuA/pG591Kw3j4rdUKmZ65okK4xuDTGNSCjeKcC3yBJiddFexQ6m00v0H4lMDzWPa4eG0qjGHeDJ9yHac1xqdK6rmlYMExru3scWrDBmRBusmHkJsPvjtHZ+d8omEL+ugdBqx+4C2T935xqkOjlmqSa30DO444PIvHxA8r+KXNeKYQ1M9FxdB7xhslQNnVie3oBn0pzVyOOYuNonKoRMbdkR3gSR+xCVMs+iY7exSu8cQ0QrXBXwKIHfgJWJxtwJExg53Ib0dPnGX6ZWEClgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZN8tft0hq98f6J07/bNT5fdSxXERJq8lr2qv7F8FdbE=;
 b=BACbACj5DJPJZwQrmPK/XXXqlCHOaKbAHf5pfUQFlTyt2OYqNe98FLzoTYqD7cO6gf9t0VQhg5ZSL/WpAU49hW27QpPAZV2+tyOfGI1eCy1HARiVOcU99DcWdVLrAZGZsH3xhVYv9LnO8SFDRiWTaKTcsD9gUa2VjNYKO95XPZvJ/73Ih/YsSNuSzdmaTfSX1wwDL4pb2QwUARYRCqdFzpYgh06X1yk64hD1xSy6bg1WX7DP5IVXLEBSmWMvCiLP6jbjm2J4M3yPph2aVPICXGyVoR/0rmPqIykV+uylBuY9/ejN/4UA6nVi6r1WQkddMpOZOPQ4VP4gIIKOFc5G6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZN8tft0hq98f6J07/bNT5fdSxXERJq8lr2qv7F8FdbE=;
 b=SqpdaoP5B3U1LCKl30OjUbTUCP3a3wpK5xmzYIu2e8NLX01keOsv+apIxcMt1pLguXtjKb5RNqRR278YxE4pzI/pT9yozzoZ/+GU/DKtGebyJqp6WBpuEpRIutcFfNVflaEh6Lvxzp06asL40fXAtS70RzjYSfmxknYmWyeDU7EQlMmdYLXBDoDbgrt+d58nGR/QaxMs5sKk6me2eN/uhLgXXF5Di9TZVlGbxVKG3Yvqt5tmerxU8jvm+WnmNf76MDG2uT1XcjrLMKxRqqdXncbk2+BUiGnxRd3o8y4xdFCjSJk9+foK2V0TiWjlb5T6UDh+ZtzaG2HMAqNZL9FROQ==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AM9PR02MB6804.eurprd02.prod.outlook.com (2603:10a6:20b:2c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.42; Sat, 30 Mar
 2024 16:35:12 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486%4]) with mapi id 15.20.7409.042; Sat, 30 Mar 2024
 16:35:12 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] drm/radeon/radeon_display: Decrease the size of allocated memory
Date: Sat, 30 Mar 2024 17:34:47 +0100
Message-ID:
 <AS8PR02MB723799AFF24E7524364F66708B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [udE1yCGk+kyixDinNhbF5wr7HQOChlOW]
X-ClientProxiedBy: MA4P292CA0006.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::16) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240330163447.10688-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AM9PR02MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 238f528d-c2d5-4729-3f14-08dc50d75f20
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QSuRjmnIH9Uj0ilCV5GOZAJpwovuoemVyOCK08SE9LlbKzBsI2uhyV8Wdzxb7RuzNzH2/DLIvXhgpk6Dz5GgHdX8QlLyUg4T29iMwUlsdJV4ThMAxfX4Ao0Z+R5VvcanYy2ruCMfccx5/c8Iw39ttOeLmYy0h17yRXUMqURGF6kaym0TASwFBhiTfFLrcimWUONz2CvYF+0UWOY8lMJ4ManGxoriYETLrlmKE19WXHuCTAIfpYgXGvlxEYXEjL/3TR/zymTgu1bZaLRg5x/CT4IYN4iknb/084WGXCL/b/65I2ut3JLeyvtJe/zPmvEdKNRyRzP16wJAi8wnIjvvh4APu+eVm9MZp13qAfhNgxCqX4nFzNlqZXtPlF0UCoevVb8ARHHGGIoX+9q8SouVZYrD9rN3b/4dlSEdCf+7J39yG2XqclupYBLM05dzlXey9Dlawqf7Xu/PguDM1mx6SQkj7PDaGW6aA8Wi9o5gwRAJv2eKrnkV/94ni7W1D7mygQ1Y6q1JR1Cv5G6dbdvQ/qh+t5bbpbMWo5lJQEKWMZ2pIFKYxuYN7BDhTVll/LUCOycj6GdCZFPhOV9/B3veOtCDaGDfCbqPLTiDYft+TbTQntAFrY+mUCNtaKNMJmoudI9Z+PGcX3X8Ihw4sGTI2p3zoo0LBpNwNm8+p65b/u0pxQ8nh9h5/BoXZCU44LLjIuZEEIHAKMauEhaHAq9qdQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4NJclBQVdsKx0sCFFCebi1WuCsj8ESu1O1q+hwUCQmYfk3742ZFAm3BOSfT4?=
 =?us-ascii?Q?1QW7CgUKGaRVcQPJq8MJpMs6L2MFtY55rc2tJrgTffJ3T2EHR4bXlQE6rXWi?=
 =?us-ascii?Q?nj4zL+RztS5cKrCCAEMhoDXFNRL0Te6ish3DqH3pzXIz+3ABOPLMfUp3t5CN?=
 =?us-ascii?Q?V7vLx3Abus/HAqDpEn/xzVV1KEst5JIJdJr0Gs4umTLnC7rESIE9hQxdrF/j?=
 =?us-ascii?Q?BbDi34SdF7B3/YmvYqdPTTuEljTM1TJ2aa09NP6+TKLBt69ckAUwNq5IL3Fm?=
 =?us-ascii?Q?6DsLoOwybOuaICzsAkTQhzK6eI/MxbkTiARJQk0WJNRRbp+/ZEPacNFTmlkT?=
 =?us-ascii?Q?L9WSDnpIL0IU47QN5c66xw971FQiXg73NG5yG5FVSgWo4K+EeV0GcDlbcisx?=
 =?us-ascii?Q?E5b7FDWw7OKLHOvRC3Fzm2jf/clllcfRwV5AiHczCvkwuwmLVn18V4xSMIXD?=
 =?us-ascii?Q?45bxjT4X+TPtUXdNUd8w7IpmvdNhHBYFddJpl73YpQUfe0lHHuc6IDoTxK4a?=
 =?us-ascii?Q?LyJPF534TmK9OVNivUZnXIcSrknYS/LjkkIUM3kpBdOaLEy92lVZW4iZNGyP?=
 =?us-ascii?Q?CJYqNc+YnAbs+xR5qG0809FZaYBIqOjRkNqSfk4p8hqFk+5VPiJWzB2oMpbH?=
 =?us-ascii?Q?D3YWgDRFBtddtzHxiequRc2Ga8zhGHRPuzo/IhUrXj+/KyK2bx/s0Zupltc/?=
 =?us-ascii?Q?O/lSb6YxJ1apZgz+cmMavd49oL5feZTfZVoKFyD+TTRqyDawJfFIJVfqJcnJ?=
 =?us-ascii?Q?kTiSMaKg5MiJZnEbmo/iV8s/Q5msYUtWfg3wg5DuxW5qt33vGjqSNw6pLptu?=
 =?us-ascii?Q?4SpL8yjIT2w5vXGdic9+ABpEwRuawKppq/sJ4eZrayUcH5qbv/E9gbtGKU3A?=
 =?us-ascii?Q?VQN5pFHgyij/zYe7u78oc5+iieV3mKh46vdEzuAqcsdSs/SjacXGpVfnGpi8?=
 =?us-ascii?Q?Mneb6IJiTQddoJjxaBY2qz7bqe5NwkAJ2bfFtDKDIyCbGugO4tuHTmczJ+o0?=
 =?us-ascii?Q?2Kza+noQeOMnCDtyK8OXOwr7qP0jTzSrusvipCcsf2qAGMu9b6qyO7Wo11wn?=
 =?us-ascii?Q?HZKnpFehJJZs1jVKTQ7iee5OxZgt+uP+jBRAZljgc1iMV3Rc6eVJZTFl2B1r?=
 =?us-ascii?Q?H7uSZSUfrL4XJkyy7jAHcE3/jBWQoevePBWA8TujaEv4QnV6folpADXbHKE+?=
 =?us-ascii?Q?B6rHLZqPAfI56pfC1QTwijd2Fni+0cYbxEfsphlYbneIGeljo3PZK3TFRMBr?=
 =?us-ascii?Q?ezNGy7vPeSVumK1sgCmp?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238f528d-c2d5-4729-3f14-08dc50d75f20
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2024 16:35:12.5244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6804

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1] [2].

In this case, the memory allocated to store RADEONFB_CONN_LIMIT pointers
to "drm_connector" structures can be avoided. This is because this
memory area is never accessed.

Also, in the kzalloc function, it is preferred to use sizeof(*pointer)
instead of sizeof(type) due to the type of the variable can change and
one needs not change the former (unlike the latter).

At the same time take advantage to remove the "#if 0" block, the code
where the removed memory area was accessed, and the RADEONFB_CONN_LIMIT
constant due to now is never used.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Changes in v2:
- Rebase against linux-next.

Previous versions:
v1 -> https://lore.kernel.org/linux-hardening/20240222180431.7451-1-erick.archer@gmx.com/

Hi everyone,

Any comments would be greatly appreciated. The first version was
not commented.

Thanks,
Erick
---
 drivers/gpu/drm/radeon/radeon.h         | 1 -
 drivers/gpu/drm/radeon/radeon_display.c | 8 +-------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 3e5ff17e3caf..0999c8eaae94 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -132,7 +132,6 @@ extern int radeon_cik_support;
 /* RADEON_IB_POOL_SIZE must be a power of 2 */
 #define RADEON_IB_POOL_SIZE			16
 #define RADEON_DEBUGFS_MAX_COMPONENTS		32
-#define RADEONFB_CONN_LIMIT			4
 #define RADEON_BIOS_NUM_SCRATCH			8
 
 /* internal ring indices */
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index efd18c8d84c8..5f1d24d3120c 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -683,7 +683,7 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 	struct radeon_device *rdev = dev->dev_private;
 	struct radeon_crtc *radeon_crtc;
 
-	radeon_crtc = kzalloc(sizeof(struct radeon_crtc) + (RADEONFB_CONN_LIMIT * sizeof(struct drm_connector *)), GFP_KERNEL);
+	radeon_crtc = kzalloc(sizeof(*radeon_crtc), GFP_KERNEL);
 	if (radeon_crtc == NULL)
 		return;
 
@@ -709,12 +709,6 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 	dev->mode_config.cursor_width = radeon_crtc->max_cursor_width;
 	dev->mode_config.cursor_height = radeon_crtc->max_cursor_height;
 
-#if 0
-	radeon_crtc->mode_set.crtc = &radeon_crtc->base;
-	radeon_crtc->mode_set.connectors = (struct drm_connector **)(radeon_crtc + 1);
-	radeon_crtc->mode_set.num_connectors = 0;
-#endif
-
 	if (rdev->is_atom_bios && (ASIC_IS_AVIVO(rdev) || radeon_r4xx_atom))
 		radeon_atombios_init_crtc(dev, radeon_crtc);
 	else
-- 
2.25.1


