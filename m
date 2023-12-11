Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499BC80C3E6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjLKJBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbjLKJBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:01:04 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A773D116;
        Mon, 11 Dec 2023 01:01:05 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7b3a8366e13so185616839f.1;
        Mon, 11 Dec 2023 01:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702285264; x=1702890064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imqsqSeoCG7iiefqcy/059zT5ygF+aA0rzXCKWGVYeM=;
        b=d+b+STacr4OADxY5G1+HFNa2arpSrTwfEX8oPrUokrBJyFPinATho1limh+0D1dI+O
         kuRaNSka6jkIwge4utkxUXcg8IGyZBP9zwtBJfqAWnphATjWd0Rrqj6gNHiXeKCi+TA/
         PZ84gD/5dFIkz2D1vSQvNgcHL7JboVXMn9Qn4uwkwA2CqdhzA554bKzHB5OYj9Zipuzh
         C+sZwfIawpiH60V1fMkSQDWTDEEBp87lmgm+xuTSipNpDRbUN1nwAAxy4w7BpMzwjrjv
         /7w7osf4SiLDJw2pjChRJCEaAUnLnJbD4XP28gdFdYUSKmQKSn7cC2YOb33sI76llAMD
         vItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702285264; x=1702890064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imqsqSeoCG7iiefqcy/059zT5ygF+aA0rzXCKWGVYeM=;
        b=qrKdkrxWs2IcV8Z9t77xa0iFeXrjbo6XchSZQIA20LtGf5fTkZz/uWDGf6Wzv3BQQ6
         /rt/hdIo31othCm0FMfXhhP/IiLTHnMCmbU0Wpon8PfFensGwtwDqcxGcua81Wo0jy3R
         n0aspVtz2yp5QzlQ11IctcvWafpoYbKB0tIse94gVtfVN9nz4Bs9Y8bjgPWAxTX8INkf
         FHdP8b1IT6ZUQ6vvhyNaVcTJNSXC8zsHtXF9QH9CaY/ZD/XHwr0MWaleA9Dq+URZWjJe
         noN6q26Z9EZG+qKRt2txI+VS9If5hFExgliN/Nm0SoBOKnDs7z5Utc8Pwfr9FkspBWew
         OHvA==
X-Gm-Message-State: AOJu0YwuQcA3UT6dMkNKg4CKy+XxMcKt72BWyjQrECQUuP7MzDIwLLFW
        wpCcqOSCmQs8erdV+z1MH04Aj0z3ugg=
X-Google-Smtp-Source: AGHT+IGLCG8im5lLD3WEgqK1syGR1Nyf2Q+dj/rBbukrCX6r/qUF7cEgvaRF1uPm4mONhDN/QIwBbw==
X-Received: by 2002:a92:ca48:0:b0:35d:59a2:3329 with SMTP id q8-20020a92ca48000000b0035d59a23329mr7723508ilo.45.1702285263896;
        Mon, 11 Dec 2023 01:01:03 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id f14-20020a056e020b4e00b0035b0b05189bsm2211216ilu.38.2023.12.11.01.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:01:03 -0800 (PST)
From:   Hongyu Jin <hongyu.jin.cn@gmail.com>
To:     agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        axboe@kernel.dk, ebiggers@kernel.org
Cc:     zhiguo.niu@unisoc.com, ke.wang@unisoc.com, yibin.ding@unisoc.com,
        hongyu.jin@unisoc.com, linux-kernel@vger.kernel.org,
        dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Subject: [PATCH v3 5/5] dm-crypt: Fix lost ioprio when queuing write bios
Date:   Mon, 11 Dec 2023 17:00:00 +0800
Message-Id: <20231211090000.9578-6-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211090000.9578-1-hongyu.jin.cn@gmail.com>
References: <df68c38e-3e38-eaf1-5c32-66e43d68cae3@ewheeler.net>
 <20231211090000.9578-1-hongyu.jin.cn@gmail.com>
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

Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
---
 drivers/md/dm-crypt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 6de107aff331..b67fec865f00 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1683,6 +1683,7 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
 				 GFP_NOIO, &cc->bs);
 	clone->bi_private = io;
 	clone->bi_end_io = crypt_endio;
+	clone->bi_ioprio = bio_prio(io->base_bio);
 
 	remaining_size = size;
 
-- 
2.34.1

