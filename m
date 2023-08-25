Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B948278815C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243313AbjHYH6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243400AbjHYH5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:57:50 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5EBE66
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:57:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68c0d886ea0so105037b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692950264; x=1693555064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mNzwiuXw8ww7Tgg8L1At+Efsiu2g5C2rsrp9SVMMlyA=;
        b=aW2scWEMIKHaTPiFyTrA00uU2t17XCKPrqMuDZZPXfnIguagG470iIOhdVCmDotvoX
         UovPp/6ESdTj529+Hko9k0sHkKNqFHybLGAONtIfa6sGVF0NaU2kVdshMepzkJNMBYk1
         XTcRI0IJpsT2RHRWQX6Rg0rBYJuzGCB83yVklEUB7IqxYO/qJ+l8Dfy4Y/5aZ+cHMoTp
         lMq0bsGFE+hkp/62qIeVcacd7KKC9+S0Pdy6UtM/GkLcS00amz+N4PD64JgWu2W/q9XX
         9kBsTv39BxEGHq8C3YTZ0giPl9XFb7FtbYPkQJ8u/RNKCQxHI0QRXoiP7W+E/V8JpLUT
         gxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692950264; x=1693555064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNzwiuXw8ww7Tgg8L1At+Efsiu2g5C2rsrp9SVMMlyA=;
        b=ZfddxCxP3eb1IJGpTf4Vk5Us50r9hqHVdj9YX7Mw86Pq81P9fwifeNXFITf+6SigCa
         8FDWrMzpE3wjf4QAuD5212iOAbO2KA5YhOMdnRwaKInFE5ziyI7DQAB/pliPHEmayc9J
         TggLpav4ERzeVDzm9K3nh6gf7f8dvos8xdPZwxwdTbanMODOozRMyO6vmN3MFpKFGRSf
         p1WhY/Fam5bfGPzA7RvjFIF8TjbUKnBybMZAP/qCJcIcJ/FI4gIePmPAm4EfkH5XmshI
         WjuP5Vth9MDurMLQSQ6soovK9DnPldG0AhO8B5y0JlZopLK1Lg1l2VwsuDBw01LIpXx5
         e6AA==
X-Gm-Message-State: AOJu0YwFAn9WLkBBMX8bUNE+ljj8nUz7PsAHTdCB2SkuchnFOJmaMvtz
        EqEbMl9MBL3QdpHOrAGn81A=
X-Google-Smtp-Source: AGHT+IH4cUfc2vN2dQggpCHGcuAPCG+gIXdezDAxInnDRESvZBy3BYOTZaqSwpu2dXrj2aZGB9Rf/Q==
X-Received: by 2002:a05:6a00:b55:b0:68c:dcc:3578 with SMTP id p21-20020a056a000b5500b0068c0dcc3578mr332738pfo.25.1692950264408;
        Fri, 25 Aug 2023 00:57:44 -0700 (PDT)
Received: from VERNHAO-MC1.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id x3-20020a62fb03000000b0063b8ddf77f7sm928714pfm.211.2023.08.25.00.57.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Aug 2023 00:57:44 -0700 (PDT)
From:   Vern Hao <haoxing990@gmail.com>
X-Google-Original-From: Vern Hao <haoxing990gmail.com>
To:     akpm@linux-foundation.org
Cc:     zhaoyang.huang@unisoc.com, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, haoxing990@gmail.com,
        Vern Hao <vernhao@tencent.com>
Subject: [PATCH v2] mm/vmscan: Use folio_migratetype() instead of get_pageblock_migratetype()
Date:   Fri, 25 Aug 2023 15:57:34 +0800
Message-ID: <20230825075735.52436-1-user@VERNHAO-MC1>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vern Hao <vernhao@tencent.com>

In skip_cma(), we can use folio_migratetype() to replace get_pageblock_migratetype().

Signed-off-by: Vern Hao <vernhao@tencent.com>
---
v1 -> v2
	- remove "Fixs:xxx" as David Hildenbrand suggestion.

 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2b5d61eeb039..850811bb5699 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2271,7 +2271,7 @@ static bool skip_cma(struct folio *folio, struct scan_control *sc)
 {
 	return !current_is_kswapd() &&
 			gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE &&
-			get_pageblock_migratetype(&folio->page) == MIGRATE_CMA;
+			folio_migratetype(folio) == MIGRATE_CMA;
 }
 #else
 static bool skip_cma(struct folio *folio, struct scan_control *sc)
-- 
2.41.0

