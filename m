Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0AB778708
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjHKFpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjHKFph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:45:37 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC78B2700
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:45:36 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5656a5c6721so552799a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691732736; x=1692337536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vTeKxa1864hX9Aw51WCVjkQ2Cm0F4fAMm4BvD1X8A/w=;
        b=ZFniN104HNYjmigZFPtbzk4Zw6qS9pf+Et2Pd10K+5vMDpWBP3veR3Utp7cRCTxVye
         GHR1TldZa+oirz7lT/KUkE55d3Tm0rbRSOjtDd0fdKfW47vFhrLw6f5uvH86KSCmWRuh
         zpVojA9PpH9BiqcZXC6EnWZZ8IPEfHVp9CJVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691732736; x=1692337536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTeKxa1864hX9Aw51WCVjkQ2Cm0F4fAMm4BvD1X8A/w=;
        b=Nb774BpVpm2fxQrsqDkFoPdolQStvfqBhXnU5cU8ihR0M83a9E3EfR8JSLNvvGoaoy
         dpCzIvnMkd6TXkGjh79SVopTZbMe2ND5QCYa8xiOWw0SvWOba1A8YUbjtRu50oWfRj9v
         Zh7hFx6a4a9vp5bG84MgUNTkubbMW9EhogsyeJzF/9+TFzlfDZXYbsm8OeYCzu2xiPfF
         UdX3SJKHhBeEb1f4jUyhCXyhQ8udNgBXv1kYTXWosn6sZHGN/eaTU2OlD+JIFpmaBGnI
         fL2tg7XyFEFWMthW8uPhEmo9o2Jnw/OK+BwON1e/TRJq5TzrBlH0xJRYtxPw+D+aGC85
         8DAg==
X-Gm-Message-State: AOJu0YyCnPsN0t0s1R0XMkL8xwIBSFyirfd+Yxs/qApWIiFfptOjnZqw
        Ylnv/c17bTAK8gmXFdNWbn5voQ==
X-Google-Smtp-Source: AGHT+IF9+U8OjOK5KoXzKGySLXY1qbvcfQq3c2iovSWz7+fLk0IBTCzM5rt/V+M3MdKgKIjctublJA==
X-Received: by 2002:a05:6a20:be1b:b0:133:3682:3cdf with SMTP id ge27-20020a056a20be1b00b0013336823cdfmr785320pzb.11.1691732736198;
        Thu, 10 Aug 2023 22:45:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c2-20020aa78802000000b00687087d8bc3sm2557075pfo.141.2023.08.10.22.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 22:45:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Vijay Balakrishna <vijayb@linux.microsoft.com>,
        stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] printk: ringbuffer: Fix truncating buffer size min_t cast
Date:   Thu, 10 Aug 2023 22:45:32 -0700
Message-Id: <20230811054528.never.165-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1390; i=keescook@chromium.org;
 h=from:subject:message-id; bh=LSsQlfVwJGANZC4BMOlstWxt7EAJ8V19cSaVUMG+hnA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk1cr8i9Tw8GnNz3kTm1mkiIrZuI7bebooN5tFQ
 YTs1cel/WeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZNXK/AAKCRCJcvTf3G3A
 JqK9D/4hSDCX6PHtUGQaGrmuI0S5HitVkvLsSFBNe+yoYZStF8nq/g9woA7dMsmU3ypkEM+DRLO
 l9dXpbwr6JTWsjkCECKWqZjA29PjXGG8bkgkQrpVWWQWuy0Rg4h8EnsfuuVJEGtbU8U4Vlmlv2w
 DTytv5P8uyalfVbyF1UaEAt/PhCvZpu/UJo5xyYwO2IXSG68ouUHeN+8kCKCnlu/a3Sd66lR4Fp
 PEYJAG9WkSVfQ8i4vM4c7I5eke7YNosDJ0umAuPgZ2oOQlABn0ZeDmjPVbYCqfzUseB9ycnmkBa
 7yVK8LPcupe+IcUA8sS0VBNN3pZQrb/2mE/PwX/0e+ZVTu/ROfugMBfGqNJwSqim44ROSFJeUek
 gslo9slDbwJt5EixSB4xtPWfs3AHEG3GQkzp/sIBNMHHzjJRT5GFk65/qWpnQhzlG5IMe57xFHM
 xOVdwl+VeevpJAAly9QrGDl7tR6xyC4Pia+sgvlIKATvpmPTziSBt/X32h8/vtOpbyvli9O/idy
 LJzwBKtdr9dI2ynun4ZQHr5QvD2j9w0NGmojOIJ0OTXBCZ45ZDF32r/qqjXwd06jtK70FlApiUX
 Wy9/1LA5N8VsjPT2HqFYXTpxS6BTHSD5VSvYhCEYhkeNcFHjkx5EzKdQyN/sv+vbDNh7MO0Nzjp
 RpC5fZy dRA1n43A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an output buffer size exceeded U16_MAX, the min_t(u16, ...) cast in
copy_data() was causing writes to truncate. This manifested as output
bytes being skipped, seen as %NUL bytes in pstore dumps when the available
record size was larger than 65536. Fix the cast to no longer truncate
the calculation.

Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>
Reported-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
Closes: https://lore.kernel.org/lkml/d8bb1ec7-a4c5-43a2-9de0-9643a70b899f@linux.microsoft.com/
Fixes: b6cf8b3f3312 ("printk: add lockless ringbuffer")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/printk/printk_ringbuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 2dc4d5a1f1ff..fde338606ce8 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1735,7 +1735,7 @@ static bool copy_data(struct prb_data_ring *data_ring,
 	if (!buf || !buf_size)
 		return true;
 
-	data_size = min_t(u16, buf_size, len);
+	data_size = min_t(unsigned int, buf_size, len);
 
 	memcpy(&buf[0], data, data_size); /* LMM(copy_data:A) */
 	return true;
-- 
2.34.1

