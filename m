Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C091280545F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345102AbjLEMh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjLEMhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:37:19 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74761D5F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:37:22 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40838915cecso57654655e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 04:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701779841; x=1702384641; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xEQ0nPJK2l6MEItIcOUo+Cj1aUU6b9K1G/w+FexHPQM=;
        b=BA/GDjsTIHpykQtRNDowRNmaQIXe2g0tGNJL54hfknz0eL9S2PfnNQTruDPPjnBO70
         kEd3d7lgJh6Al8YKhCdoF0Cb8Ah2Ue+7QzO5nzlBy8P1ly91C9ApOnLwt6vVIEPBDUG9
         6O+OD5Qf0hnRwKMVdVt3HmJpY66TUonkjFYJ9koHk5R7LUgEquR79GDZ5AWyWYt6whzm
         1wGHhpsbs9CcrgSHKPmiSbVobu5cU0qflq1sKmkhmpkgpRhcuo0oKEw9sPstV9FU9ety
         0wKNtu9JpcGcaeoFBWlhcjv+9mcVBGMHXIIXvpvWUkqxO1VSGgkzfAGYIFYiT1SN5rFQ
         M5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701779841; x=1702384641;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEQ0nPJK2l6MEItIcOUo+Cj1aUU6b9K1G/w+FexHPQM=;
        b=XUIYlBaIAg7lxWwbXaUkjtiuQZ/jeRUHQ3SP4U13X12qGUWaXuMIVA+Edqdax55C6Y
         GM+4s1M2h75qUbCMvJDWKm35w3AqEDyfN+aVjh1UvPX8A10ogdJlk48h5VdNI7houb6e
         rJo0iDqJL4Nv+92/sxxw8ityY9FKGGy/xNbpqCgPtJte6M9wukIh5T8dgrZcEtkP/TG6
         NGO0brCUdlV/So2hI7QI73yGIuZDiIRCm689/qmIELeAovw0/lEz5mBEkOlE4nIRqYZz
         o2LlR+SCqgWlCuYJbyvoG5l1S8xf2YxgxZ+meCPzLYzyNYa7bAWPgofDT0Wnwhk9VRpL
         x7dg==
X-Gm-Message-State: AOJu0Yz9MS8qYnFap+9RVcg+W064ikR8NAjE0NBBZAhynxfIUC/8jRlH
        10J64LOzNvxctK0agghVWyxUTw==
X-Google-Smtp-Source: AGHT+IHGwMratcq3hVnhryBa3837VxHeTKKs/Jd/i8LMX25Dk+Chk0tB18TP0Xcjd5ROraLCl/4gNQ==
X-Received: by 2002:a05:600c:2199:b0:40b:5e21:e281 with SMTP id e25-20020a05600c219900b0040b5e21e281mr375751wme.110.1701779840967;
        Tue, 05 Dec 2023 04:37:20 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b0040b43da0bbasm18511650wmq.30.2023.12.05.04.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 04:37:20 -0800 (PST)
Date:   Tue, 5 Dec 2023 15:37:17 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] io_uring/kbuf: Fix an NULL vs IS_ERR() bug in
 io_alloc_pbuf_ring()
Message-ID: <5ed268d3-a997-4f64-bd71-47faa92101ab@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The io_mem_alloc() function returns error pointers, not NULL.  Update
the check accordingly.

Fixes: b10b73c102a2 ("io_uring/kbuf: recycle freed mapped buffer ring entries")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 io_uring/kbuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 268788305b61..bd25bc2deeaf 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -636,8 +636,8 @@ static int io_alloc_pbuf_ring(struct io_ring_ctx *ctx,
 	ibf = io_lookup_buf_free_entry(ctx, ring_size);
 	if (!ibf) {
 		ptr = io_mem_alloc(ring_size);
-		if (!ptr)
-			return -ENOMEM;
+		if (IS_ERR(ptr))
+			return PTR_ERR(ptr);
 
 		/* Allocate and store deferred free entry */
 		ibf = kmalloc(sizeof(*ibf), GFP_KERNEL_ACCOUNT);
-- 
2.42.0

