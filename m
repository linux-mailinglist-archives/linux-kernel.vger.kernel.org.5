Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3201A767187
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjG1QJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjG1QJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:09:11 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B9E3C31
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:09:10 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34642952736so9594425ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690560549; x=1691165349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jm+S60Tfcv7dUGtSL3EZSXu0wC+3ZSyjYJF/PJfzkQs=;
        b=dy3I6U/Wh/mLg8N6WgBoCV0cotOrS0ecFDbXoa3kgzOysXy3OzDiib/avqAWr973RX
         sJX13QmNnsc3WfzyqD9Rp0+GYnyzenECtcAaF4gwNv5Vl+sFXrnGHoaNa7nOE1+3Q2zJ
         vgAc9/8GwSN3ui0TEnP3Je2Zuzd6L+qqQWSQ0TrfIddfNQN5BGCLEeNfDd3WAeaVUQrB
         Hejod2KRVaw7OnVIPGDyZIm6vpkSRWdudFX1SIJzyzD7NJtJaEtDHZaio9l5HFO/Uf1h
         aCSDqIVxLsx7wboQvyapUEFHhGO1vhE7Eaa2mnF+EEUyr4GRJGl32dzy535SixnHEbfy
         Sp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690560549; x=1691165349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jm+S60Tfcv7dUGtSL3EZSXu0wC+3ZSyjYJF/PJfzkQs=;
        b=bq2J4w+CT0gbXZcXKc5+B1OyCr80F6f80TwSCv3cC1CQ0vrYviqigRgrFpzuZ6VPtg
         L6woik+ZFlGrE66KA9SR3HsooVAzUbtXdJHSF2PtDJvyI8k4rUloQq8W5hQK+jyoMu/A
         KobC3FqGiWxe9eYXuG0Vq7G6CEDLW15Cl48lMrK1/jG5gTbkxpXH6QqpP/8S+epG1DQ1
         wUgTCMIeRho5B4kZJAyvU41P0D8hm2KGjD49EYE3sgM9hSa8ud4PuBnrdT40EWUFUV4r
         JnGADdcBgdgUR/VKmnUOG7gebPSMbXee0mY1Ii+yn98YAplhtyw8IF1GxUglD7iizRBj
         p9MQ==
X-Gm-Message-State: ABy/qLZ2dTc4CV2QhmKWaorqgI3+yRpN8NY1tGEcYALC+uXH07fbAYvN
        6JOsQxyQ1yc6pVh2bSqF2GA=
X-Google-Smtp-Source: APBJJlEeo9xzx7BJ+oPAADHYicSTr5juwZCJHvu4N/2gFTaIVZuNkpqtBpZhaHP9yHzKR8WU+U7mAw==
X-Received: by 2002:a05:6e02:df2:b0:348:7c4e:2959 with SMTP id m18-20020a056e020df200b003487c4e2959mr3184587ilj.23.1690560549258;
        Fri, 28 Jul 2023 09:09:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t4-20020a92d144000000b00348abdfad8esm1230523ilg.32.2023.07.28.09.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 09:09:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 28 Jul 2023 09:09:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rik van Riel <riel@surriel.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm,memblock: reset memblock.reserved to system init
 state to  prevent UAF
Message-ID: <8a48adce-3ad5-4793-8ca6-0b9f59e14665@roeck-us.net>
References: <20230719154137.732d8525@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719154137.732d8525@imladris.surriel.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 19, 2023 at 03:41:37PM -0400, Rik van Riel wrote:
> The memblock_discard function frees the memblock.reserved.regions
> array, which is good.
> 
> However, if a subsequent memblock_free (or memblock_phys_free) comes
> in later, from for example ima_free_kexec_buffer, that will result in
> a use after free bug in memblock_isolate_range.
> 
> When running a kernel with CONFIG_KASAN enabled, this will cause a
> kernel panic very early in boot. Without CONFIG_KASAN, there is
> a chance that memblock_isolate_range might scribble on memory
> that is now in use by somebody else.
> 
> Avoid those issues by making sure that memblock_discard points
> memblock.reserved.regions back at the static buffer.
> 
> If memblock_discard is called while there is still memory
> in the memblock.reserved type, that will print a warning
> in memblock_remove_region.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>

This patch results in the following WARNING backtrace when booting sparc
or sparc64 images in qemu. Bisect log is attached.

sparc:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at mm/memblock.c:352 memblock_remove_region+0x80/0xb0
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 6.5.0-rc3-00350-gb917f578dc45 #1
[f0022af8 : __warn+0x9c/0xe4 ]
[f0022b84 : warn_slowpath_fmt+0x44/0x54 ]
[f07a16a0 : memblock_remove_region+0x80/0xb0 ]
[f0787240 : memblock_discard+0x84/0x100 ]
[f0784e00 : page_alloc_init_late+0xc/0x5c ]
[f07782fc : kernel_init_freeable+0xb8/0x208 ]
[f05ad41c : kernel_init+0x10/0x120 ]
[f0007ed0 : ret_from_kernel_thread+0xc/0x38 ]
[00000000 : 0x0 ]
---[ end trace 0000000000000000 ]---

sparc64:

[    1.876345] ------------[ cut here ]------------
[    1.876852] WARNING: CPU: 0 PID: 1 at mm/memblock.c:352 memblock_remove_region+0x78/0xb4
[    1.877912] Modules linked in:
[    1.880783] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc3+ #1
[    1.881473] Call Trace:
[    1.881935] [<0000000000467c30>] __warn+0xf0/0x1a0
[    1.882515] [<0000000000467d98>] warn_slowpath_fmt+0xb8/0x100
[    1.883128] [<0000000001b8d83c>] memblock_remove_region+0x78/0xb4
[    1.883564] [<0000000001b6df50>] memblock_discard+0x88/0x108
[    1.883987] [<0000000001b6abc0>] page_alloc_init_late+0xc/0x94
[    1.884594] [<0000000001b56e44>] kernel_init_freeable+0xcc/0x228
[    1.885181] [<0000000000f673c4>] kernel_init+0x18/0x134
[    1.885612] [<00000000004060e8>] ret_from_fork+0x1c/0x2c
[    1.886035] [<0000000000000000>] 0x0
[    1.886697] irq event stamp: 1013
[    1.887293] hardirqs last  enabled at (1021): [<00000000004e1534>] __up_console_sem+0x74/0xa0
[    1.887786] hardirqs last disabled at (1028): [<00000000004e1510>] __up_console_sem+0x50/0xa0
[    1.888273] softirqs last  enabled at (1004): [<0000000000f76ae4>] __do_softirq+0x4c4/0x5a0
[    1.888760] softirqs last disabled at (997): [<000000000042b94c>] do_softirq_own_stack+0x2c/0x40
[    1.889610] ---[ end trace 0000000000000000 ]---

Guenter

---
# bad: [57012c57536f8814dec92e74197ee96c3498d24e] Merge tag 'net-6.5-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
# good: [18b44bc5a67275641fb26f2c54ba7eef80ac5950] ovl: Always reevaluate the file signature for IMA
git bisect start 'HEAD' '18b44bc5a672'
# good: [6c58c8816abb7b93b21fa3b1d0c1726402e5e568] net/sched: mqprio: Add length check for TCA_MQPRIO_{MAX/MIN}_RATE64
git bisect good 6c58c8816abb7b93b21fa3b1d0c1726402e5e568
# bad: [379e66711b33f9fdc0513daee6cf3dd8d2f6f435] Merge tag 'fixes-2023-07-27' of git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
git bisect bad 379e66711b33f9fdc0513daee6cf3dd8d2f6f435
# good: [c21733754cd6ecbca346f2adf9b17d4cfa50504f] platform/x86: huawei-wmi: Silence ambient light sensor
git bisect good c21733754cd6ecbca346f2adf9b17d4cfa50504f
# good: [536bb492d39bb6c080c92f31e8a55fe9934f452b] ksmbd: fix out of bounds in init_smb2_rsp_hdr()
git bisect good 536bb492d39bb6c080c92f31e8a55fe9934f452b
# good: [0a8db05b571ad5b8d5c8774a004c0424260a90bd] Merge tag 'platform-drivers-x86-v6.5-3' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
git bisect good 0a8db05b571ad5b8d5c8774a004c0424260a90bd
# bad: [9e46e4dcd9d6cd88342b028dbfa5f4fb7483d39c] mm,memblock: reset memblock.reserved to system init state to prevent UAF
git bisect bad 9e46e4dcd9d6cd88342b028dbfa5f4fb7483d39c
# first bad commit: [9e46e4dcd9d6cd88342b028dbfa5f4fb7483d39c] mm,memblock: reset memblock.reserved to system init state to prevent UAF
