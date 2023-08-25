Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C087878844A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242315AbjHYKJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238658AbjHYKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:09:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A682109
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:08:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so6488295e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692958137; x=1693562937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X39hjYGQZiphQhJuSEMSrg3Fd7NFZIUBYgDNPheRLwc=;
        b=bA86dZHg6cFCB1+hH960h9uNuGqB/X9HFaVR8ljDLDll88vfl/QbA/IVt2Lrh4R5uT
         LkCAJHbuAHmfrnc46u3vboqnC67+K80E+o2y1wSEeQCv0Eo4kQ6N/d7XsPDMPZwvDS18
         mNwvfR/3PgQ5JN60phdOd9bZcKlctw2RxectvSmagqLzfODXGlVHtdBy+IdvpbxShO+O
         2YezZbr+ecGVH32ehu4Jw41gr5wiO++1KZ2PR2KbIYl1p87c6XsYLJTAKHMOplq1px88
         loRLHAzKYQ27RNKqxcQ3MNjeOHBMcedz7l2eued6FTl1LltZjq+brx/UleO2fQq3YXnV
         NSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692958137; x=1693562937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X39hjYGQZiphQhJuSEMSrg3Fd7NFZIUBYgDNPheRLwc=;
        b=bJwMlYbyRNVJ4zr/L1q/w3u9UKlICJv/TULaK8WMsK9jt3NwLcAdx+KybsnYDDpJrz
         RsNwqgW9L/PN1A/RH7+BmMJVR2dpPvIjxT2JhYzggJ1s0tBwoUcts+NplePy4H4Bq9Nl
         vMkQ+zMw5OyBpXlVsBDlpfKa8BltFOxknIxQvV+zSrDuq+UrkSK2aT6Jt67IQmwRby0l
         X3T63H82T8xV2AR2p2ZVNgGagRU5K+akyi2uI7dzekldVV6TIw71O9lBC7tgXK3eJr3+
         HKabedNLXW1laOMW3Czxdl0JiWqixBwgD5zveHYh+UtEXDzOrfYv4pfdwwXkFzLc53ut
         qukA==
X-Gm-Message-State: AOJu0Yx4N//4o0hzdwCS1tPujjHcX0M3XrHlNL8nSyLb7IlW/VZzv4o0
        fIjvPh+jhOmW29agBIDRoeZlEA==
X-Google-Smtp-Source: AGHT+IGXyrKogolarLlNUu27kYfQR3pxPgmDC0X6xU00Qt8KV3p5L3wTg/5Vj+6jFFBEtGBA3XJ6tQ==
X-Received: by 2002:a05:600c:2141:b0:400:57d1:4914 with SMTP id v1-20020a05600c214100b0040057d14914mr5030406wml.5.1692958136844;
        Fri, 25 Aug 2023 03:08:56 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id p24-20020a1c7418000000b003fef60005b5sm1760204wmc.9.2023.08.25.03.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 03:08:56 -0700 (PDT)
Date:   Fri, 25 Aug 2023 11:08:54 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdb: Flush console before entering kgdb on panic
Message-ID: <20230825100854.GC270740@aspen.lan>
References: <20230822131945.1.I5b460ae8f954e4c4f628a373d6e74713c06dd26f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822131945.1.I5b460ae8f954e4c4f628a373d6e74713c06dd26f@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 01:19:46PM -0700, Douglas Anderson wrote:
> When entering kdb/kgdb on a kernel panic, it was be observed that the
> console isn't flushed before the `kdb` prompt came up. Specifically,
> when using the buddy lockup detector on arm64 and running:
>   echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
>
> I could see:
>   [   26.161099] lkdtm: Performing direct entry HARDLOCKUP
>   [   32.499881] watchdog: Watchdog detected hard LOCKUP on cpu 6
>   [   32.552865] Sending NMI from CPU 5 to CPUs 6:
>   [   32.557359] NMI backtrace for cpu 6
>   ... [backtrace for cpu 6] ...
>   [   32.558353] NMI backtrace for cpu 5
>   ... [backtrace for cpu 5] ...
>   [   32.867471] Sending NMI from CPU 5 to CPUs 0-4,7:
>   [   32.872321] NMI backtrace forP cpuANC: Hard LOCKUP
>
>   Entering kdb (current=..., pid 0) on processor 5 due to Keyboard Entry
>   [5]kdb>
>
> As you can see, backtraces for the other CPUs start printing and get
> interleaved with the kdb PANIC print.
>
> Let's replicate the commands to flush the console in the kdb panic
> entry point to avoid this.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  kernel/debug/debug_core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index d5e9ccde3ab8..3a904d8697c8 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -1006,6 +1006,9 @@ void kgdb_panic(const char *msg)
>  	if (panic_timeout)
>  		return;
>
> +	debug_locks_off();
> +	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> +
>  	if (dbg_kdb_mode)
>  		kdb_printf("PANIC: %s\n", msg);

I'm somewhat included to say *this* (calling kdb_printf() when not
actually in the debugger) is the cause of the problem. kdb_printf()
does some pretty horid things to the console and isn't intended to
run while the system is active.

I'd therefore be more tempted to defer the print to the b.p. trap
handler itself and make this part of kgdb_panic() look more like:

	kgdb_panic_msg = msg;
	kgdb_breakpoint();
	kgdb_panic_msg = NULL;


Daniel.
