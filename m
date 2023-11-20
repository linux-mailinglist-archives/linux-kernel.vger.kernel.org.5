Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9B57F0EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjKTJUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjKTJUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:20:31 -0500
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52D2E5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1700471576; bh=0IyZUppRFC+kRXK+uWTlA6BA5d71MB5eJgI2v8JSo8g=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=ngGfutKlG4UMoqOY1w9qK0d3x1YrvjuZvo/ni40ibMWGkH/Lb4CELoCYuGc2BFF7a
         zcXHrXDcB/1MwknG30WASwWYOirtpC/kvUmvBMmXJjmaRD2CYpO8k7GXLdtlBloFhS
         rXWorM09Ix6kedh3weEOi6UKdHBwWp/9E0p9lA2l4oznrFu+QotAEzay8AeMxo5eoT
         5Ha1YQpY1qw/USNShuXvCGcO/u3xXpR2+dXhrYNjI6+x961mu2M67GPyDLssxiE45h
         eUCRKTWgBk0CwfUKPnD/YQ7A/x0CsqQ+vp1APxR/yLihctQ+K+TiXDuttpo2RShfvv
         EmGXoZs3dXQYQ==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 90878680224;
        Mon, 20 Nov 2023 09:12:51 +0000 (UTC)
From:   sxwjean@me.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com
Cc:     corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mm/slab: make calculate_alignment() public
Date:   Mon, 20 Nov 2023 17:12:13 +0800
Message-Id: <20231120091214.150502-4-sxwjean@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120091214.150502-1-sxwjean@me.com>
References: <20231120091214.150502-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oX7Qs8WfInCPZ2wL3ryBnCYP_MfDMAaM
X-Proofpoint-ORIG-GUID: oX7Qs8WfInCPZ2wL3ryBnCYP_MfDMAaM
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=833 suspectscore=0
 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2311200061
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <xiongwei.song@windriver.com>

We are going to move slab merge from slab_common.c to slub.c, there is a
call with it in find_mergeable(), so make it public.

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 mm/slab.h        | 2 ++
 mm/slab_common.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/slab.h b/mm/slab.h
index eb04c8a5dbd1..8d20f8c6269d 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -427,6 +427,8 @@ extern void create_boot_cache(struct kmem_cache *, const char *name,
 			unsigned int size, slab_flags_t flags,
 			unsigned int useroffset, unsigned int usersize);
 
+unsigned int calculate_alignment(slab_flags_t flags,
+		unsigned int align, unsigned int size);
 int slab_unmergeable(struct kmem_cache *s);
 struct kmem_cache *find_mergeable(unsigned size, unsigned align,
 		slab_flags_t flags, const char *name, void (*ctor)(void *));
diff --git a/mm/slab_common.c b/mm/slab_common.c
index d707abd31926..62eb77fdedf2 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -106,7 +106,7 @@ static inline int kmem_cache_sanity_check(const char *name, unsigned int size)
  * Figure out what the alignment of the objects will be given a set of
  * flags, a user specified alignment and the size of the objects.
  */
-static unsigned int calculate_alignment(slab_flags_t flags,
+unsigned int calculate_alignment(slab_flags_t flags,
 		unsigned int align, unsigned int size)
 {
 	/*
-- 
2.34.1

