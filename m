Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723A7810EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377709AbjLMKnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbjLMKnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:43:02 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDBC194;
        Wed, 13 Dec 2023 02:43:00 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7b6f4330598so285262939f.1;
        Wed, 13 Dec 2023 02:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702464179; x=1703068979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRWJvmM8+hpVsGJoyvu2YuvVcQVJUfQcuTmMveSE8/s=;
        b=B9LcHToZ8Ua6JRQQuibqAqPFiUbCOyyoQYmttAMOf7T1DIqXlPfCjykPjuSLgetx9+
         XwHPGn6wjiBOZ3WK5Xxq6JS9APyZ7S/3v2gS31aBNVtNWLr+AKBH33rEmFaaMCnM3VBM
         0PU8gW92QEA3kazMGpcY9jMrPHpIxa9+8Pg3AOvCPa5qRqBTN9t5MyMihek/lwWEiNd0
         IJ1oGJC/X4yVmFqBQFvZHNwPOos8o3AQsiYKPSVAofSzHBZsoc3EOE4O7egkEfeywN3R
         wq/Cl8PMCQsVWDXaHBPCWzfjBeNCO4byiQk8w1zW1pQod7cvrq1bIGmrjbdnWEJH2CMh
         mbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702464179; x=1703068979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRWJvmM8+hpVsGJoyvu2YuvVcQVJUfQcuTmMveSE8/s=;
        b=RKnG/I6gndXdTtGpIn+1/wbhEG+/B/7SbGZUH6q4PJ9JSPIFLlsuFSflaXQ/c6NZOL
         wt2XCrQem8+cOEjqJP6UJOZts25oDvrxTBqfqAmJJnEkJp0SxYEDdIEzn3K4NUtsh0w2
         Ab4z0QJYAbosU7jof1ap8WPXyL9nqSCublNe7mTGdByBO5DB/K4zzU6HkAe/tgfytFvW
         zXSjZkVhxgnpTsSe2y8+EMb+XLhJuuSi05pNH/2Rm32EDROkGthaHlfJ1ihXSSyuIKdD
         eyI1q1TqEhsvC0BZtbNbzYd6vz0Q2T7JYZHXPFS2890MXdgUot2mOybyMCsbNZ5UswXA
         dz8w==
X-Gm-Message-State: AOJu0YxYD4ykxvSSUATzrw/v9dJqKKe+JYe1zD9n4O5Yv4ct+DJ4V5fX
        h51UKw25DxJir3QfG2PFW0I=
X-Google-Smtp-Source: AGHT+IFqnQH5xHRTW7lkDH3nUXotSoQk9CUeHU1CHahsXGxY0QsPY5pXBPOQ53OTwye2jv3CgtPipw==
X-Received: by 2002:a5e:c742:0:b0:7b7:1717:693f with SMTP id g2-20020a5ec742000000b007b71717693fmr8044235iop.10.1702464179355;
        Wed, 13 Dec 2023 02:42:59 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id c11-20020a6b4e0b000000b0078647b08ab0sm3058186iob.6.2023.12.13.02.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:42:59 -0800 (PST)
From:   Hongyu Jin <hongyu.jin.cn@gmail.com>
To:     agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        axboe@kernel.dk, ebiggers@kernel.org
Cc:     zhiguo.niu@unisoc.com, ke.wang@unisoc.com, yibin.ding@unisoc.com,
        hongyu.jin@unisoc.com, linux-kernel@vger.kernel.org,
        dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Subject: [PATCH v5 5/5] dm-crypt: Fix lost ioprio when queuing write bios
Date:   Wed, 13 Dec 2023 18:42:16 +0800
Message-Id: <20231213104216.27845-6-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213104216.27845-1-hongyu.jin.cn@gmail.com>
References: <CAMQnb4MQUJ0VnA5XO-enrXTJvHbo6FJCVPGszGaq-R34hfbeeg@mail.gmail.com>
 <20231213104216.27845-1-hongyu.jin.cn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongyu Jin <hongyu.jin@unisoc.com>

The original submitting bio->bi_ioprio setting can be retained by
struct dm_crypt_io::base_bio, we set the original bio's ioprio to
the cloned bio for write.

Link: https://lore.kernel.org/dm-devel/alpine.LRH.2.11.1612141049250.13402@mail.ewheeler.net

Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
---
 drivers/md/dm-crypt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 6de107aff331..7149da6555b8 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1683,6 +1683,7 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
 				 GFP_NOIO, &cc->bs);
 	clone->bi_private = io;
 	clone->bi_end_io = crypt_endio;
+	clone->bi_ioprio = io->base_bio->bi_ioprio;
 
 	remaining_size = size;
 
-- 
2.34.1

