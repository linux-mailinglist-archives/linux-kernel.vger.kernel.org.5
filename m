Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF2D75ED90
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjGXI3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjGXI2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:28:52 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB3AE67
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:28:41 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3fbc6ab5ff5so31410295e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690187320; x=1690792120;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qh7biXRh+AvTp8Ymk75koxyMXQzyMvIyabTNh2G2pq0=;
        b=fZYHlWqjHHXhGIsS6IEqH4lhynm8Gt/mytlbm81jdN+7wUZlr1MeKp9A4iNzDzrUe0
         6dNkTXuZgV9dHRwjm7N8jRNdHdSUMtbslqFE0yJ5qxRMOccuuZtkzAtr/Z6FJv+7jFZH
         hO7ll9nvM2NUy+DU+zeHH0jjskHRh4zIXcTZnArZ4OkOI/lE2NWiZPAfItaVkCYj3kLt
         4VIHlUl3tu+eJaZ0snwwyBwlJ+stFOpW/T8HOjVBXD8LQHU5voPu6Is6CQZ2dqFp1hAE
         S4rMidEVEzC5ezdGXNy0Mv/0wLwGwxmCyZXzg9nB3MlzHM3HoRFPa/O5/CBTOl+75mP3
         GrHA==
X-Gm-Message-State: ABy/qLb6KKXkOum3a4RRpUrM7OPT0AjLV4RETD+NgIoNt/WUqhq8T7qL
        K0IGHvO+noEDpDkondS8ENo=
X-Google-Smtp-Source: APBJJlGNzdbMX9mEUxY5MO8yt4xTladuPfHLqPdBiEEZSlu3lyjf/wfsW8lLe7K7ZvOn6aW14VTw+Q==
X-Received: by 2002:a05:600c:2316:b0:3fc:5a3:367c with SMTP id 22-20020a05600c231600b003fc05a3367cmr7026493wmo.32.1690187319846;
        Mon, 24 Jul 2023 01:28:39 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003fc07e1908csm9588233wml.43.2023.07.24.01.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 01:28:39 -0700 (PDT)
Message-ID: <cd1019d0-55b8-6276-dd5e-3a7a9264fe06@kernel.org>
Date:   Mon, 24 Jul 2023 10:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Yi Yang <yiyang13@huawei.com>, gregkh@linuxfoundation.org
Cc:     jannh@google.com, linux-kernel@vger.kernel.org, guozihua@huawei.com
References: <20230724033714.175340-1-yiyang13@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2] tty: tty_jobctrl: fix pid memleak in
 disassociate_ctty()
In-Reply-To: <20230724033714.175340-1-yiyang13@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 07. 23, 5:37, Yi Yang wrote:
> There is a pid leakage:
> ------------------------------
> unreferenced object 0xffff88810c181940 (size 224):
>    comm "sshd", pid 8191, jiffies 4294946950 (age 524.570s)
>    hex dump (first 32 bytes):
>      01 00 00 00 00 00 00 00 00 00 00 00 ad 4e ad de  .............N..
>      ff ff ff ff 6b 6b 6b 6b ff ff ff ff ff ff ff ff  ....kkkk........
>    backtrace:
>      [<ffffffff814774e6>] kmem_cache_alloc+0x5c6/0x9b0
>      [<ffffffff81177342>] alloc_pid+0x72/0x570
>      [<ffffffff81140ac4>] copy_process+0x1374/0x2470
>      [<ffffffff81141d77>] kernel_clone+0xb7/0x900
>      [<ffffffff81142645>] __se_sys_clone+0x85/0xb0
>      [<ffffffff8114269b>] __x64_sys_clone+0x2b/0x30
>      [<ffffffff83965a72>] do_syscall_64+0x32/0x80
>      [<ffffffff83a00085>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
> 
> It turns out that there is a race condition between disassociate_ctty() and
> tty_signal_session_leader(), which caused this leakage.
> 
> The pid memleak is triggered by the following race:
> task[sshd]                     task[bash]
> -----------------------        -----------------------
>                                 disassociate_ctty();
>                                 spin_lock_irq(&current->sighand->siglock);
>                                 put_pid(current->signal->tty_old_pgrp);
>                                 current->signal->tty_old_pgrp = NULL;
>                                 tty = tty_kref_get(current->signal->tty);
>                                 spin_unlock_irq(&current->sighand->siglock);
> tty_vhangup();
> tty_lock(tty);
> ...
> tty_signal_session_leader();
> spin_lock_irq(&p->sighand->siglock);
> ...
> if (tty->pgrp) //tty->pgrp is not NULL
> p->signal->tty_old_pgrp = get_pid(tty->pgrp); //An extra get
> spin_unlock_irq(&p->sighand->siglock);
> ...
> tty_unlock(tty);
>                                 if (tty) {
>                                     tty_lock(tty);
>                                     ...
>                                     put_pid(tty->pgrp);
>                                     tty->pgrp = NULL; // It's too late
>                                     ...
>                                     tty_unlock(tty);
>                                 }
> 
> The issue is believed to be introduced by commit c8bcd9c5be24 ("tty:
> Fix ->session locking") who moves the unlock of siglock in
> disassociate_ctty() above "if (tty)", making a small window allowing
> tty_signal_session_leader() to kick in. It can be easily reproduced by
> adding a delay before "if (tty)" and at the entrance of
> tty_signal_session_leader() "tty_signal_session_leader()".

Funny, the commit effectively reverted c70dbb1e79a1 ("tty: fix memleak 
in alloc_pid") which appears to be fixing exactly what you are reporting 
now again.

> To fix this issue, we move put_pid() after "if (tty)".
> 
> Fixes: c8bcd9c5be24 ("tty: Fix ->session locking")
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> Co-developed-by: GUO Zihua <guozihua@huawei.com>
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> ---
> v2:Completely refactor the solution, avoid the use of PF_EXITING flag and
> do put_pid() in disassociate_ctty() again instead.
> ---
>   drivers/tty/tty_jobctrl.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
> index 0d04287da098..17a6565f428b 100644
> --- a/drivers/tty/tty_jobctrl.c
> +++ b/drivers/tty/tty_jobctrl.c
> @@ -300,12 +300,7 @@ void disassociate_ctty(int on_exit)
>   		return;
>   	}
>   
> -	spin_lock_irq(&current->sighand->siglock);
> -	put_pid(current->signal->tty_old_pgrp);
> -	current->signal->tty_old_pgrp = NULL;
> -	tty = tty_kref_get(current->signal->tty);
> -	spin_unlock_irq(&current->sighand->siglock);
> -
> +	tty = get_current_tty();
>   	if (tty) {
>   		unsigned long flags;
>   
> @@ -320,6 +315,11 @@ void disassociate_ctty(int on_exit)
>   		tty_kref_put(tty);
>   	}
>   
> +	spin_lock_irq(&current->sighand->siglock);
> +	put_pid(current->signal->tty_old_pgrp);
> +	current->signal->tty_old_pgrp = NULL;
> +	spin_unlock_irq(&current->sighand->siglock);

It _appears_ to be correct (the locking of all this is quite hairy). But 
at the very least, this block deserves a comment why we do it the second 
time.

thanks,
-- 
js
suse labs

