Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F76774262
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjHHRnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbjHHRmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:42:43 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52EA5A79
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:18:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686e0213c0bso4220978b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691511503; x=1692116303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rt72qNtSF7rZ1Cnz4oyWX+TnZhjCs3AGVCD5IGIHOTA=;
        b=HlF7u+TRRAOC6ZOWCQEEbcAOgq79OjyJkxB1uvXTHsYI/9A8i4QoyE6NCLiGsEdY3N
         ZMf66NSg9L8WqVihdMR7eMyhdOcC+QStjcCA2L+qtM1S4VBvmreGbTwPvedze5IYDoC7
         19Iz9d1PsUu/sMUel6urdTW+nDioEQZNTU8nX10t/saywn4w/umcqCL/uXMhWYuSpz7J
         H+d7t+j+udD3OKFhtr2MSZHbwEIkjm6Q7A9T/nUmfE6PccINb5Jmb3W5JktjgzFqv18j
         EfhprPNOxO2+XvO/bacpg2IrzXqWiOBDcgTpS4mel58dlu6aLKaw6XRWWKAfszEpF7rn
         S3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511503; x=1692116303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rt72qNtSF7rZ1Cnz4oyWX+TnZhjCs3AGVCD5IGIHOTA=;
        b=YPNHcw6cT/fA/GrUC3cj2EJTu4KrBE5Mt6XLeGT9gJtwkCkp3KhN9LmxLbUMjJZhnu
         56Px60Wrq2IkBwyiZf+OyG+ApSJXvpUFssc7EvM6WqtByyb+7o7oOFjcJyg6cXVXJ5xn
         IANxAPxzW63sdqnZ/spVg789m5x/Vs1rtuk6HK1HNESnTCirMb/hCkrTbGUI+7i4x+pC
         RbbICOngyNT7InmYI9+MAxx6ClqVPr+M4yXCWQIotu8fA5OBB1sutBm03EtTvJ3y0FR8
         9uJ/EQ0IutcUPnhCDC8Bsq8KdN6cgqnXFIqfsyWihK3hu5BYCc4vlLtf0qPkNU3+Xaq4
         gv/Q==
X-Gm-Message-State: AOJu0YyRFW+w+zdKtUjYag9L5yxHqu5Mr40uaD/r2Vr944gugZaueWEI
        gnpow1r4/dBaok926vl3FCVzJOn8ZUxMLA==
X-Google-Smtp-Source: AGHT+IH8FrLarnBGrUuMl9KPJWo0+EVTzGmY8X5Xyia/GEJJ00nKOVDXm0Jc9HGRXYJPMCd95h2HmA==
X-Received: by 2002:a17:902:d48a:b0:1b8:9b17:f63d with SMTP id c10-20020a170902d48a00b001b89b17f63dmr11341555plg.23.1691484395759;
        Tue, 08 Aug 2023 01:46:35 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id kb14-20020a170903338e00b001bbbc655ca1sm8383487plb.219.2023.08.08.01.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:46:35 -0700 (PDT)
From:   alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH] writeback: remove redundant checks for root memcg
Date:   Tue,  8 Aug 2023 16:44:32 +0800
Message-Id: <20230808084431.1632934-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinliang Zheng <alexjlzheng@tencent.com>

The check for root memcg will be done in wb_get_lookup(), so remove the
redundant one to simplify the code.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 mm/backing-dev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 3ffc3cfa7a14..9076f3ad39de 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -733,9 +733,6 @@ struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
 
 	might_alloc(gfp);
 
-	if (!memcg_css->parent)
-		return &bdi->wb;
-
 	do {
 		wb = wb_get_lookup(bdi, memcg_css);
 	} while (!wb && !cgwb_create(bdi, memcg_css, gfp));
-- 
2.31.1

