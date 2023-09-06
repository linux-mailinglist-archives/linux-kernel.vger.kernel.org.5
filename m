Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62346793DAF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240012AbjIFNbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbjIFNbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:31:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BD110E2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:31:12 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4e6so5296009a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1694007070; x=1694611870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQEKqe3bDH27s4AsrbKUQCFmR3pSzTgTwp308wc1fxo=;
        b=TpPAb2WZoync7bkj+W8asv1tvuYlocWNvHOO95MypyoyFX/1mUOkh0uG3vk/R1CFkr
         bHWwfMnZGmpusMuV5QoG9cTWT5Awu9AQxrPUsmeGLrszO6/fmvco7+EMY53zli95p2kp
         +3BKaOC1ywWm5+NqAAkeIYkiTfrAVzpwLwylfFDN2XxY6i5sfTAekA/Ha8qWXeNKAD6j
         W/ocAfgR8RDcShVCi59SIyhWL9PYsjiIMNjtScOVeVyS8vYsIwmlwb+j5cCNnPBEjfwn
         NmQ3twANGAUPa69tPs87TSMu9E2dNd4VK2GkuXwvvGSViSt7+N7YB/Oa7HnoHih9cxC5
         rtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694007070; x=1694611870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQEKqe3bDH27s4AsrbKUQCFmR3pSzTgTwp308wc1fxo=;
        b=dVjsnPGBznrcEkC1KhmWMPEyZ6XR7juERYMo/cNTu/BLrOSi8UO89BwueW9KOSUgkw
         v5UrvV5Xe7wa6uiU1qSp4hyuXCStBVaub3RhVGbf1ZUyS506JOezKD1WxM0wxW5qpZJ9
         7YaPWW/kyTJlvNoBIirzu1ZT3GDH9b9SizxbkiKmfFpI2gYVmKMQmMvhDUdgaC/Ddc5O
         O1Of4XTmJTbG+y6VtANIdoDBLO6/GapUJzcWGOHT13sDdyaFx7tTltWAytI8gYXvMrZz
         /216WDWN7XtwmzN722CuLjmcJWOsuUp8/ZaogsWclgCObk1DiwWXUM1MVtLdfjSplPHM
         OFhw==
X-Gm-Message-State: AOJu0YwVXzg9u/38vTBVWIpjkb/VJNb5oK1/MZ9s7ddbCl176Y3zQPZW
        uJ6FWgfXp5O+G4g8MjjMfo+fGw==
X-Google-Smtp-Source: AGHT+IHxQ1RmQuQHmgQQmnWbUnYbPKmInDa2Y2sq1quXXuZPSayEmNlnZxowArje3NTqDDs5B/wckw==
X-Received: by 2002:a17:906:1044:b0:99b:c86b:1d25 with SMTP id j4-20020a170906104400b0099bc86b1d25mr2395858ejj.26.1694007070656;
        Wed, 06 Sep 2023 06:31:10 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id gh4-20020a170906e08400b009875a6d28b0sm8983369ejb.51.2023.09.06.06.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:31:10 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Linux regression tracking <regressions@leemhuis.info>,
        Serguei Ivantsov <manowar@gsc-game.com>,
        David Howells <dhowells@redhat.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, stable@vger.kernel.org
Subject: [PATCH] drbd: swap bvec_set_page len and offset
Date:   Wed,  6 Sep 2023 15:30:34 +0200
Message-ID: <20230906133034.948817-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bvec_set_page has the following signature:

static inline void bvec_set_page(struct bio_vec *bv, struct page *page,
		unsigned int len, unsigned int offset)

However, the usage in DRBD swaps the len and offset parameters. This
leads to a bvec with length=0 instead of the intended length=4096, which
causes sock_sendmsg to return -EIO.

This leaves DRBD unable to transmit any pages and thus completely
broken.

Swapping the parameters fixes the regression.

Fixes: eeac7405c735 ("drbd: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage()")
Reported-by: Serguei Ivantsov <manowar@gsc-game.com>
Link: https://lore.kernel.org/regressions/CAKH+VT3YLmAn0Y8=q37UTDShqxDLsqPcQ4hBMzY7HPn7zNx+RQ@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 79ab532aabaf..6bc86106c7b2 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1557,7 +1557,7 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
 	do {
 		int sent;
 
-		bvec_set_page(&bvec, page, offset, len);
+		bvec_set_page(&bvec, page, len, offset);
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
 
 		sent = sock_sendmsg(socket, &msg);
-- 
2.41.0

