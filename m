Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242167D6A93
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343659AbjJYL5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjJYL5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:57:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E380113A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:57:15 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4079ed65582so43556995e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698235034; x=1698839834; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Svgsq/AnbjJxNk7jNBD8VRF+Bt+Kn7+Y3XI8iU9eztQ=;
        b=vUlwHCgCCCdw2X0tNdXYkisy6XFt+e3S1dvHq+stYKsMTp9r6+mQShoiSgCdhkDipb
         sw8SiT5at93WvdeniWMrR+pB2ERs0383imTFtPpqKKLi5WLU6re2FehjP4y3CpsAntlJ
         QSlWlxzOGDfjIJOFFm17lDEhIDNMvClWdFhhFmrtSvEWAzSnpoUkSLcVNLi7S48YQFD/
         c9FwhCP/wl+289DoJDzUW0eNOeJRxpVPsnwqs0HBMNL7PgUBET3o7F+rmZt+p/eoyVho
         HGIwBM1u8IBcWOs2R2Nz0WWNl0ONRU/i50xSonWeUrSW3lwdajRxCqbe1abskSIqJXeP
         Z7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698235034; x=1698839834;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Svgsq/AnbjJxNk7jNBD8VRF+Bt+Kn7+Y3XI8iU9eztQ=;
        b=fHfbJpByAjyHslih7xtFTOWN4uQos90c76f4sY7cjOWb+qzzD8M2llLXndL+fXBC7j
         9SWJgarkocip+QbdPE5Ev/q9Gy+nNBruIkuX3efDiFfrzhYmGwQ3OjUSymuw+7t4KKbX
         QJ7Dsrjoc0yPecey9Ja14hKq+Lwz4t7JyQHcoJ6k6JD/lG3xyyF2Sh8PXPJfsJBMrd/F
         aObvQBPK4x7RowhR/05qXE9yZPMvT/vGaudKpaVqQqrBHkfAwUcRM6fuBko+Z2CEt6gr
         BSya6snRezMNPZxk0pPLDiMsJxQcCoTWrHI9e8lerP49d1u8l+kungAeGvOqtAbamQAq
         e/hw==
X-Gm-Message-State: AOJu0YxNMwVg/9RDPJFbpWrWL0qNfwM3k+ixlUJ0KxMinLPKIo1w62Ov
        jmAaqpRD3pSaj4vZrdJtqk8PYg==
X-Google-Smtp-Source: AGHT+IG7r3dLAwdLNcAlseIa0fKBtN898ETmhV+sCzsSFjW27iIRaLWoI4YCTr60PRsoelQHtsEmkA==
X-Received: by 2002:a5d:6310:0:b0:32d:84c7:2f56 with SMTP id i16-20020a5d6310000000b0032d84c72f56mr11957241wru.21.1698235034491;
        Wed, 25 Oct 2023 04:57:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d6b87000000b003140f47224csm11843971wrx.15.2023.10.25.04.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 04:57:14 -0700 (PDT)
Date:   Wed, 25 Oct 2023 14:57:10 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Bob Peterson <rpeterso@redhat.com>, gfs2@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] gfs2: uninitialized variable in __gfs2_iomap_get()
Message-ID: <0b9cb1ea-4656-4802-b7a7-811c1e9e118a@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "ret" variable is uninitialized when we goto out because
gfs2_is_stuffed(ip).

Fixes: 2cd225820b91 ("gfs2: Initialize metapaths outside of __gfs2_iomap_get")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/gfs2/bmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index cef57d87c24d..12d7651e15e9 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -866,7 +866,7 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 	__be64 *ptr;
 	sector_t lblock;
 	sector_t lblock_stop;
-	int ret;
+	int ret = 0;
 	int eob;
 	u64 len;
 	struct buffer_head *bh;
-- 
2.42.0

