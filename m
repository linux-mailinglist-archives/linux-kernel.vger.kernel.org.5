Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D157A18ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjIOIeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjIOIeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:34:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BB9E6;
        Fri, 15 Sep 2023 01:34:09 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694766848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+PrVXAjSakOMQW1FarSUl/Pr6tS8YcjazDcdX87cHIM=;
        b=NnfLyMkEFotgLsXyA15QLmtt7y/gWInRZ/a1ogANjuQ3Fwkl8j9nNNpzhUKttLcmrnZSth
        CAL1PwpczWB+TH1Ibl6zTzwWD2EGo7gGKGXGguLpQ6oyUZOlNdQ/EM16Ij3r8p1UuF9mXF
        YqtCXRHPc+DIdirN9Nphnn4P2rQUGIMPoTQ8UpKkmr9AA9dqtDnVgvMTameWQDt4A9Guy7
        wfCZ2YIg3KOAf8HsmM6BzMjJG44uXI3Gd5xJDmDCNAEXBi9Z/Vw/bQCQi8GSX57jaC3dYa
        mS8X3FghBkVsqZWbDAnPL2SETjfzxMwocgc6m7w9OP0Fkg1qxwHb6sQeM8UvYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694766848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+PrVXAjSakOMQW1FarSUl/Pr6tS8YcjazDcdX87cHIM=;
        b=BXcq5/WlhxM9wInIlFk8dlJlwM1o8FtvZ9wkfHMb7Hs6q8Kb7nOBP0K/mcwOkolQkysqIG
        B/XvYvyDf3AXSKDA==
To:     Enlin Mu <enlin.mu@outlook.com>, pmladek@suse.com,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        enlin.mu@unisoc.com, enlinmu@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] printk: add cpu id information to printk() output
In-Reply-To: <JH0PR04MB7072A4B6946EAEEB1EB8B0BE8AF6A@JH0PR04MB7072.apcprd04.prod.outlook.com>
References: <JH0PR04MB7072A4B6946EAEEB1EB8B0BE8AF6A@JH0PR04MB7072.apcprd04.prod.outlook.com>
Date:   Fri, 15 Sep 2023 10:40:03 +0206
Message-ID: <8734zfx2bo.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-15, Enlin Mu <enlin.mu@outlook.com> wrote:
> Sometimes we want to print cpu id of printk() messages to consoles
>
> diff --git a/include/linux/threads.h b/include/linux/threads.h
> index c34173e6c5f1..6700bd9a174f 100644
> --- a/include/linux/threads.h
> +++ b/include/linux/threads.h
> @@ -34,6 +34,9 @@
>  #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
>  	(sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
>  
> +#define CPU_ID_SHIFT 23
> +#define CPU_ID_MASK  0xff800000

This only supports 256 CPUs. I think it doesn't make sense to try to
squish CPU and Task IDs into 32 bits.

What about introducing a caller_id option to always only print the CPU
ID? Or do you really need Task _and_ CPU?

John Ogness
