Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEE17BC079
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjJFUiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjJFUiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:38:02 -0400
X-Greylist: delayed 425 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Oct 2023 13:38:00 PDT
Received: from st43p00im-ztdg10061801.me.com (st43p00im-ztdg10061801.me.com [17.58.63.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FEFBD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1696624254;
        bh=jpgWkkgEKfUsXrA2ZQG7eE1vYyPJC5fkNDGWTc4YXIQ=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=psPfLxkMILPBNjNiOlvQhtW0hS756ZA8mNS0cpmMfj/YiymTPuUHIWc29ZBy6jggP
         O+UjIj/2N8DdxspCme9P/Mf0uS1RHgFf4nDQeiKc6IibN9tMG//O6F5fcw0lA/+Lls
         JYbnwV3LN349HM0kCeU9jXXafFifs4GDuzVPYnvcTFHX2rG/uUwUKSAAR+PmlIAw5+
         BPqvHfSU4PiZwaniAUArZ9XoQraNoIX9Blf4hyyum/nC//vl6VU2mEC0kw5shshI/e
         iFxB4f61cD1lXl4sDRMevsb9u2oEU+rzSIm9wUPe/iJQoMhU4C5OQtp2n+as65+ZC1
         wAjzSp8YEjUig==
Received: from mainframe (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-ztdg10061801.me.com (Postfix) with ESMTPSA id E3A4E600486;
        Fri,  6 Oct 2023 20:30:53 +0000 (UTC)
Date:   Fri, 6 Oct 2023 22:30:51 +0200
From:   Lucy Mielke <lucymielke@icloud.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mm: add printf attribute to shrinker_debugfs_name_alloc
Message-ID: <ZSBue-3kM6gI6jCr@mainframe>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VAw--NUYFuVX3GYwAM3zW3KwZcEog9e-
X-Proofpoint-ORIG-GUID: VAw--NUYFuVX3GYwAM3zW3KwZcEog9e-
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.957,17.11.170.22.0000000_definitions?=
 =?UTF-8?Q?=3D2023-05-18=5F15:2020-02-14=5F02,2023-05-18=5F15,2023-02-09?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=753 suspectscore=0 bulkscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2310060156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a compiler warning when compiling an allyesconfig with W=1:

mm/internal.h:1235:9: error: function might be a candidate for ‘gnu_printf’
format attribute [-Werror=suggest-attribute=format]

Signed-off-by: Lucy Mielke <lucymielke@icloud.com>
---
 mm/internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 18e360fa53bc..e23f1ea55a8e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1229,8 +1229,8 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 			  int priority);
 
 #ifdef CONFIG_SHRINKER_DEBUG
-static inline int shrinker_debugfs_name_alloc(struct shrinker *shrinker,
-					      const char *fmt, va_list ap)
+static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
+			struct shrinker *shrinker, const char *fmt, va_list ap)
 {
 	shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
 
-- 
2.42.0

