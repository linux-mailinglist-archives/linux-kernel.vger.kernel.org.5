Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2E7782CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbjHUOyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjHUOyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:54:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3681E2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:54:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52683b68c2fso4219117a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692629648; x=1693234448;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1m4RaE6ydVAkfq5tQathmIX+lrXlCmyz18jHgZNKKQY=;
        b=KabWw+c8I/Tfq6iy6Zw3BpMsiMFZwZrFmreE5dDHMYb8wrNg6SCzun9yMXT8AAbhgM
         S+tq4B6wtpbjfRf8YNNmDYY2AIgdD+gqfHIC534t4mCLQMPNRBypFa+rrhTeg7mnwkSB
         SBEqZOuSy8MhRwypoLkahvPPbYxDH3+uYLjWFUTuUcO6M5W+QIBDNOY23TNcyD1IsxM9
         tin5wbvulFUqn5PnwgVjSCNe6U1/qkMo7tiICLucMr63kjRrthazkYoyoC/POK6wmulz
         nMSAaak56NQVjJ+PegyMHAeqXQHqIym/pe5LMrWYhcn/OyhCQ2a7Vu3iAaJSKDOF/F2p
         Rsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692629648; x=1693234448;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1m4RaE6ydVAkfq5tQathmIX+lrXlCmyz18jHgZNKKQY=;
        b=iLI8pG2703EBnnhHYmDnrSo8wT8ZXyJQZqlxc4ppRIU3zdtFAaM1KM0evEN6lPSV7j
         3kg6TxS6tcBqT0TQ6Ooy3+hvjK1bsgnLXN8TXnSVFZZEn/KfxZ8Eif97UIfW/NJQYJ7F
         C2QDNEtBo9Z4K/mW7fm/PTJT4HJDT/UO+eXoTaLXkosBFurF9jUMgTLlyOTn74HYB4LH
         gl/d5SHNjmzVWqcsMhWtHhi0jqwqOF2tVgT95YWOG9wVj5+xq4i9zxMh8TT1mkUUm0EL
         FNPEx2PhAQtSo85iwzkMCyZm5HMwRGvGz63suN5MJgJ/9c1WHSjZlxSj452esh26Jmvo
         mKMw==
X-Gm-Message-State: AOJu0YxZIvC2I67UxHT7fsX1RuV1/0QjAx0IyLwkqcnH2sgbBJ0/VQxR
        TfNMHpl0beNeC4G+T7LEgQ==
X-Google-Smtp-Source: AGHT+IGwcMsZq3QyLINzHNOhNAuWUzP47fCQ77jFcE3ZqHqyZbnOKFVCdtlaiN3k5dvR9/FMtd8GwA==
X-Received: by 2002:aa7:d492:0:b0:523:cfa4:5c3d with SMTP id b18-20020aa7d492000000b00523cfa45c3dmr5479978edr.13.1692629648126;
        Mon, 21 Aug 2023 07:54:08 -0700 (PDT)
Received: from p183 ([46.53.250.251])
        by smtp.gmail.com with ESMTPSA id w9-20020a056402070900b00525683f9b2fsm6057227edx.5.2023.08.21.07.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 07:54:07 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:54:05 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] char: shrink character device's devlist[] array
Message-ID: <fe4d62ab-2427-4635-b9f4-467853fb63e3@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge padding, shrinking "struct memdev" from 32 bytes to 24 bytes
on 64-bit.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/char/mem.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -692,23 +692,23 @@ static const struct file_operations full_fops = {
 
 static const struct memdev {
 	const char *name;
-	umode_t mode;
 	const struct file_operations *fops;
 	fmode_t fmode;
+	umode_t mode;
 } devlist[] = {
 #ifdef CONFIG_DEVMEM
-	 [DEVMEM_MINOR] = { "mem", 0, &mem_fops, FMODE_UNSIGNED_OFFSET },
+	[DEVMEM_MINOR] = { "mem", &mem_fops, FMODE_UNSIGNED_OFFSET, 0 },
 #endif
-	 [3] = { "null", 0666, &null_fops, FMODE_NOWAIT },
+	[3] = { "null", &null_fops, FMODE_NOWAIT, 0666 },
 #ifdef CONFIG_DEVPORT
-	 [4] = { "port", 0, &port_fops, 0 },
+	[4] = { "port", &port_fops, 0, 0 },
 #endif
-	 [5] = { "zero", 0666, &zero_fops, FMODE_NOWAIT },
-	 [7] = { "full", 0666, &full_fops, 0 },
-	 [8] = { "random", 0666, &random_fops, FMODE_NOWAIT },
-	 [9] = { "urandom", 0666, &urandom_fops, FMODE_NOWAIT },
+	[5] = { "zero", &zero_fops, FMODE_NOWAIT, 0666 },
+	[7] = { "full", &full_fops, 0, 0666 },
+	[8] = { "random", &random_fops, FMODE_NOWAIT, 0666 },
+	[9] = { "urandom", &urandom_fops, FMODE_NOWAIT, 0666 },
 #ifdef CONFIG_PRINTK
-	[11] = { "kmsg", 0644, &kmsg_fops, 0 },
+	[11] = { "kmsg", &kmsg_fops, 0, 0644 },
 #endif
 };
 
