Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6887781D77
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 12:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjHTKr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 06:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjHTKrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 06:47:24 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6EC188
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 03:43:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so2835635a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 03:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692528218; x=1693133018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mLa1opvhFmdS+3Ar+DtCPBJjkZRGUovvLN46nFS2xDQ=;
        b=QbTJ5h+vvDFrFUsYrN2LUn/QLXRindM9ppsLruB6QB9BgFezRCE5oqtthSFWXZ17UA
         xCCRDsHUYbPwsOOUTfq+outeFlE6lDnyYKFMZCb3OXFXq/qaGEU1rU1JIlkasABGDjAP
         b2geQ+BnlOtN3uEwcpAMVlbdcVsNic2r46r8+XnUy7Ol4YMncoc5V7qb3fCxczvbNLi1
         jbM75ICW4LhQCUwrpHR7cv4AymI9vPtLOj0niENTp8Ksmni2iPynU5cSqo56T11Q1ut3
         hGrgXACWrC5XSQkZjCyqPO4O3iNI6Sj1nSNTZvp7VztoAj/dBUA2c+5NJfIGzZrwEa/p
         euYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692528218; x=1693133018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLa1opvhFmdS+3Ar+DtCPBJjkZRGUovvLN46nFS2xDQ=;
        b=fjNzy0a4R6I45Grhw/QULaOGicNorJxTrVhGf6ALaoFbYcadWyYVnKxS6xRxBDgz9p
         PSHmO4FXkz+x//SriBgNJbx9wQSnBmT0zpMs7cD8E/P/PspOLw7XHWvApi+pX8Po4sHV
         AT/Y0o2RILKAM76TO9Psbg8mYOeTkQrdKaLSbJlfiFsNsDeQU3Onu7jmQp8NxMzkGt18
         xPpwFt6AcIwclG4EJfAPH97x8ERzsGP8xJmMu6nrAxd6Dj4GEuT3rXdc9k6DuRAo1pKH
         LmVJRkv7Z//CgyLxNW4IC3U349IcXAPE+SDM1QpRXsW09hj0BS5zeYuojs8cwgjm92Ys
         hesQ==
X-Gm-Message-State: AOJu0YzcQHF2mp+lYwKY3QGGDNxJ1+Mw/ZcpuTKevsrNfA/ww/+ESLtY
        UCu4rWDtrpJxHBDnN8dJWr3mCS4DPh5TmA==
X-Google-Smtp-Source: AGHT+IE6vsmzVQpniQf7+4/guhXFWuG1MtLhMr92CviWvcDc/PobjZm3ZldWxDgXtmbFKyJnXQIySg==
X-Received: by 2002:aa7:d9d8:0:b0:525:734a:bf30 with SMTP id v24-20020aa7d9d8000000b00525734abf30mr3330858eds.36.1692528218131;
        Sun, 20 Aug 2023 03:43:38 -0700 (PDT)
Received: from f.. (cst-prg-27-89.cust.vodafone.cz. [46.135.27.89])
        by smtp.gmail.com with ESMTPSA id d19-20020a056402517300b005272523b162sm4007146ede.69.2023.08.20.03.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 03:43:37 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] mm: remove unintentional voluntary preemption in get_mmap_lock_carefully
Date:   Sun, 20 Aug 2023 12:43:03 +0200
Message-Id: <20230820104303.2083444-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Should the trylock succeed (and thus blocking was avoided), the routine
wants to ensure blocking was still legal to do. However, the method
used ends up calling __cond_resched injecting a voluntary preemption
point with the freshly acquired lock.

One can hack around it using __might_sleep instead of mere might_sleep,
but since threads keep going off CPU here, I figured it is better to
accomodate it.

Drop the trylock, do the read lock which does the job prior to lock
acquire.

Found by checking off-CPU time during kernel build (like so:
"offcputime-bpfcc -Ku"), sample backtrace:
    finish_task_switch.isra.0
    __schedule
    __cond_resched
    lock_mm_and_find_vma
    do_user_addr_fault
    exc_page_fault
    asm_exc_page_fault
    -                sh (4502)
        10

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 mm/memory.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1ec1ef3418bf..f31d5243272b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5257,12 +5257,6 @@ EXPORT_SYMBOL_GPL(handle_mm_fault);
 
 static inline bool get_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs *regs)
 {
-	/* Even if this succeeds, make it clear we *might* have slept */
-	if (likely(mmap_read_trylock(mm))) {
-		might_sleep();
-		return true;
-	}
-
 	if (regs && !user_mode(regs)) {
 		unsigned long ip = instruction_pointer(regs);
 		if (!search_exception_tables(ip))
-- 
2.39.2

