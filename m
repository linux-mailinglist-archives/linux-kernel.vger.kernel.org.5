Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0607F3878
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjKUVmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKUVmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:42:33 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2087.outbound.protection.outlook.com [40.92.91.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C5F100
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:42:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7DdMUeaeXMK7dydA1E2tkw6tj05plq38ElmULzPln/FGbGMgkXeHFF2MWYxm1HkLbOP+lwHKXw0E8i/y9na+pmnDdUBNcTV9Na9+iOs8Ctdll+Tc1VEmgTydFRWDbFm18TE4hvQ196avKNdaKHTDT0DQMXrxPNdGM43DVs6W+nCXV+B2rWiNasq7i+VHSInFyTQ8mH8U4+trrJvjl2MOaKblkIOPSAMYeyAq6UwEYT9UTXZ2qlyspxOf6HZ53ghh9dk0LcQw51Y2MMaZngUbHl3Dl1SMVwN1ox1E6wsMN/ZtMk9I/s4V79CkQ3glJ9UQK1a0WwC3CEl0d3OpH1uaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29jcc8/33Wt3un8RLmiE4c7QrGd7B8cnl+cNOftp/PY=;
 b=TABwSwKo5RzKQ3H++98WCVJswhlmyKKvfa10bA4xZMWJbbbkmat6E4HQYNK7f/uUwNYhZhDXnGgwMFxvn/gYWwSLXb9u88i4vNQa8YJxzT1V3H/Q1w5ClW7N8GO7/O0slwlkpmBkba02ntX1Uzdzz4nZTbNMKNWVf5+6vFXqLW658vWw8lljKPVgHbqBSNcrsmONRb9gP+uy1IwgXCLJpmy7YyK49sCVNcZrUbeDM/gdOgsL/oK979SUbnwm7NYB5cQjMxA+LahX6o3LmpUIHYDkqyZm8NSkiAppDKwSnlSkEs1G8HH4rZ1ybKLOIdLDTqcFx2Ye9uL7FVyQgr1CYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29jcc8/33Wt3un8RLmiE4c7QrGd7B8cnl+cNOftp/PY=;
 b=kfT4MzbLckMdViso8oT72SL8dJWhfmEgIPIAE26RpKFCjLKQpJy1U9VCKqZsx2DkI3oxdI9YGFOJ33wrUYLaLdS0NpiNGQnoSPaVQFxGZVXUgk5JwxP7gErH6ONY1wvJxLF3iihEvC/mGman5e/xi46LJUxEiruaNhZqA4CQO3TClNTM5LR9NcL52m5+Jwfo0c1+i1th6b84DBvy/FkNVgZvhzsExYLmiUMJO7fXdR60/xX+NrjnABorexoZzReIR/DNMRW7LB/E+Lbb0kSziqacRFezdEd8a7l+kBw0ROH3OF6LhHr76Pbfd+AyyuPbulZ3luAfqlbsdWZUk/ghzg==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by PAXP193MB1503.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:13f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 21:42:27 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 21:42:27 +0000
From:   Juntong Deng <juntong.deng@outlook.com>
To:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com,
        akpm@linux-foundation.org
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] kasan: Improve free meta storage in Generic KASAN
Date:   Wed, 22 Nov 2023 05:41:26 +0800
Message-ID: <VI1P193MB0752C0ADCF4F90AE8368C0B399BBA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [aBStXIVnfS+GP4EU6rrNTwppYbpfxVCc]
X-ClientProxiedBy: LO4P123CA0568.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::18) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <20231121214126.53528-1-juntong.deng@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|PAXP193MB1503:EE_
X-MS-Office365-Filtering-Correlation-Id: 690f3537-efd0-4c59-dea4-08dbeadac14b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3HPfTPT0ur8NWreQU5zYm+w3m1DIR2Z8jGAxOyYCSUQTSp3oNWFyMlfM+Ns6If44pkzMEdD/lxL0f1BMomF+VLxZJqmvFo31wufUahRDJEpJKMdB6+FHNW3fiAj9JIJUPiGn9OJJMljkIdkaRvfrCjVZrUdMprhusgseI8X2LB+gWq69da16eiktbL4sQcYOisCVcnDzXMpECjqCxZCKBvrLCZqEv8DR/JUhBe43CezOdRwgolzHnyNNZlKs32lYJgUK/9jIfxCBgF/ui0rdei6uk/5MtwsZ8iQG8KwUr73+6GMKOzV7yAIRMmywoAkmef3kuz4sVmxWbWoPuvraY6f2KsVQJdlWtjGecuS/NSn/ae4K06FxnHjQyvd1a3+Vwh7Eg5hv8ztaAa+R+9NEGXWrID9vsuNk7KpIVqKJRkDO0nxOeMsRibgVN7fJTmLrU0JU6EG0hw1b6XjSQDYAAyUT8/Fpb7cQ/5OQn+uVXgu6MoNamFxX1qnFnY7DhoCbYSAv7eKdcWHSMf9JpiBTb+UABRie4DR+WEM/x7JHKEQI2nnYKYSYLFr6l8kZXDWq
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RJ32V+mru7FobK8CEA2A+P1u2wj/tbSLUNbI1AHLGDTvqnldw2ByW3zf+xy0?=
 =?us-ascii?Q?uoMn3vy1Fl00gTgrz1FrSap+SXToLJLKuFb2IiOSpN6sf3Laur8X+Jh2+AX+?=
 =?us-ascii?Q?QZ4cO3lKobuG23zsJBjm6wz6LsudtacvSvebbcVXZAF61lNRiZ1ngRAlZ8rn?=
 =?us-ascii?Q?BZ0ZhpDB75bmvcrTR+IneRpNK7MT4CqQCtOViBjHWj9CVbwtgHI7PfTFzy82?=
 =?us-ascii?Q?4/VijxQcdhPer/qnizDcW63JQvl/fSYNXCEtu2gY/drowxYZdelWVa9PfFAW?=
 =?us-ascii?Q?3GQyhw4KT056qnkFULxEqkTqMClu7mtR4Ker2/bjP0+fVB6caOuUSuNZ8NCj?=
 =?us-ascii?Q?SZrgGaxgVRC8HknbzSx97EmVULeQDVgGvkFh0tQHytH99Ffe3AdfEptUauML?=
 =?us-ascii?Q?0NQqLEizi64rcPfKv/whS6rqDpmiT8Fnk4Et03ph3+OxrUwsyGqa5e6ksYYE?=
 =?us-ascii?Q?fz8tsIc+31Wp6K64Hh6/q5si/tn+fpTK0qFep4H3afm2vFCMJSN7vJqtFcTT?=
 =?us-ascii?Q?hA2yFp1zJctpPT7gviu9h6bxYuTJCBSZwiUcV4QyAxsiMW/p1DrgEaDHGwlh?=
 =?us-ascii?Q?SdrFzUq+JdraEwtJTbBubOY4vSpsq/kUs0DBnDHMH7u1V+0wgr+gMea+6VTP?=
 =?us-ascii?Q?YwHqkbLS/Rb7kxho2iuJ3SJWMoyvuC7Fcg/Ctkc8xdYvc2Zfe0O7yaqI2TUq?=
 =?us-ascii?Q?0zs1+stTqyXW3KymMjqi0DNqWAxFl6pc2OkFF8svjJBhx/g2bT7QtzqVXJyQ?=
 =?us-ascii?Q?/MzX3IbchXPB7kxvxROApLZPb52wMzipg6crM8I8QYxWzNOqvpet5zTTDRYq?=
 =?us-ascii?Q?YIQcgWXUoyviC08qyf3Dzn6WbUb6csqQwG3YAFUsIf7H577rmmkddnLrbJm4?=
 =?us-ascii?Q?ArfPKscqVm6NOK3xnXW81EewoPSbKuN2JrHGHsriuSsDcI2R6HgeWVP+Ey+J?=
 =?us-ascii?Q?pWAuS0LA2W+pt78zIav/Y5zE7aEDXTBH5x/tIp3OCTdbIOjloz6qSVdZ8eEe?=
 =?us-ascii?Q?EtkHAwZCYEegLGmchkVVafM/jFtUBwBLi7azGQOl3rLgUtLt6fFdVPzK216v?=
 =?us-ascii?Q?SxBf1K2RuIG/BHmq5cC9ZML9xjT6/48Bt0kLK720t/RRzNXWTITiM43lfIDJ?=
 =?us-ascii?Q?+DuVLp++g2HAxn/EB3oO5rUoQEQi4g06N8MLIjoHUNw/zCweDMnMcRQDfhUW?=
 =?us-ascii?Q?GgAqs6U6Yq4Gd9Vvf8WWa6zY1i0f/kd6Nz82FGmlyzwy938ijvxNmeMMGAw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690f3537-efd0-4c59-dea4-08dbeadac14b
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 21:42:27.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1503
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently free meta can only be stored in object if the object is
not smaller than free meta.

After the improvement, even when the object is smaller than free meta,
it is still possible to store part of the free meta in the object,
reducing the increased size of the redzone.

Example:

free meta size: 16 bytes
alloc meta size: 16 bytes
object size: 8 bytes
optimal redzone size (object_size <= 64): 16 bytes

Before improvement:
actual redzone size = alloc meta size + free meta size = 32 bytes

After improvement:
actual redzone size = alloc meta size + (free meta size - object size)
                    = 24 bytes

Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
V1 -> V2: Make kasan_metadata_size() adapt to the improved
free meta storage

 mm/kasan/generic.c | 50 +++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 4d837ab83f08..802c738738d7 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -361,6 +361,8 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 {
 	unsigned int ok_size;
 	unsigned int optimal_size;
+	unsigned int rem_free_meta_size;
+	unsigned int orig_alloc_meta_offset;
 
 	if (!kasan_requires_meta())
 		return;
@@ -394,6 +396,9 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 		/* Continue, since free meta might still fit. */
 	}
 
+	ok_size = *size;
+	orig_alloc_meta_offset = cache->kasan_info.alloc_meta_offset;
+
 	/*
 	 * Add free meta into redzone when it's not possible to store
 	 * it in the object. This is the case when:
@@ -401,21 +406,26 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 	 *    be touched after it was freed, or
 	 * 2. Object has a constructor, which means it's expected to
 	 *    retain its content until the next allocation, or
-	 * 3. Object is too small.
 	 * Otherwise cache->kasan_info.free_meta_offset = 0 is implied.
+	 * Even if the object is smaller than free meta, it is still
+	 * possible to store part of the free meta in the object.
 	 */
-	if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor ||
-	    cache->object_size < sizeof(struct kasan_free_meta)) {
-		ok_size = *size;
-
+	if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor) {
 		cache->kasan_info.free_meta_offset = *size;
 		*size += sizeof(struct kasan_free_meta);
+	} else if (cache->object_size < sizeof(struct kasan_free_meta)) {
+		rem_free_meta_size = sizeof(struct kasan_free_meta) -
+								cache->object_size;
+		*size += rem_free_meta_size;
+		if (cache->kasan_info.alloc_meta_offset != 0)
+			cache->kasan_info.alloc_meta_offset += rem_free_meta_size;
+	}
 
-		/* If free meta doesn't fit, don't add it. */
-		if (*size > KMALLOC_MAX_SIZE) {
-			cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
-			*size = ok_size;
-		}
+	/* If free meta doesn't fit, don't add it. */
+	if (*size > KMALLOC_MAX_SIZE) {
+		cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
+		cache->kasan_info.alloc_meta_offset = orig_alloc_meta_offset;
+		*size = ok_size;
 	}
 
 	/* Calculate size with optimal redzone. */
@@ -464,12 +474,20 @@ size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
 	if (in_object)
 		return (info->free_meta_offset ?
 			0 : sizeof(struct kasan_free_meta));
-	else
-		return (info->alloc_meta_offset ?
-			sizeof(struct kasan_alloc_meta) : 0) +
-			((info->free_meta_offset &&
-			info->free_meta_offset != KASAN_NO_FREE_META) ?
-			sizeof(struct kasan_free_meta) : 0);
+	else {
+		size_t alloc_meta_size = info->alloc_meta_offset ?
+								sizeof(struct kasan_alloc_meta) : 0;
+		size_t free_meta_size = 0;
+
+		if (info->free_meta_offset != KASAN_NO_FREE_META) {
+			if (info->free_meta_offset)
+				free_meta_size = sizeof(struct kasan_free_meta);
+			else if (cache->object_size < sizeof(struct kasan_free_meta))
+				free_meta_size = sizeof(struct kasan_free_meta) -
+									cache->object_size;
+		}
+		return alloc_meta_size + free_meta_size;
+	}
 }
 
 static void __kasan_record_aux_stack(void *addr, bool can_alloc)
-- 
2.39.2

