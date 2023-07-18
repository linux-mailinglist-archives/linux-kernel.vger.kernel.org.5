Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE6275726A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGRDjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjGRDjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:39:40 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA501F1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:39:38 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666e97fcc60so3350988b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689651578; x=1692243578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E6wWYRTghnvkR9SvhZXPoD7HqsxJ9W440qofcKq6n3I=;
        b=GgbgC5ACCBPpfoT01EftoaKQD8cis+/uGswTTmSOOkBdnIeksx1bPPTUttq29NaHKg
         Czqqwp9i6oB1nU81BCFC4FQmbz7a9rj+aVsTPtEFrXrthxeCV64botSVXAYn+qrjOVU0
         /FnogPPfofqyOhHnNrAOhVEdxg64Zh3gAzE2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689651578; x=1692243578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6wWYRTghnvkR9SvhZXPoD7HqsxJ9W440qofcKq6n3I=;
        b=acrs6xq62ZJ2jYqJCCXcaURUKhm/umkJM8OEv8qV+rWV/6HO3Zhib6e5Rle4aLgYB4
         C0cWeiCuaXnCGsugsqD/v1ciM63vdfwdphZV5zOuRAmr3AXnb1fFlT1+0ECdwbRpG+rv
         CG6RrqZFQVaxCg34vDcctIJE07itApCW1VALJtPyt9L3LC4ZbR94FAyqR8QJZkbJeIXK
         ikPMZsI1SyojvAnkpsreDf0Q5MP/gnpzyHrp1T/z9CwsEp2s1VxjRDiPFXVTAMSQ9ARV
         ug7GFDCYXjT5jD7IBrvggSFW+5YtUx5t7Cn+rHrf9edv+e/G3oqKH27l+U38A30jtLIR
         Ucbg==
X-Gm-Message-State: ABy/qLayhN25fhs9nGm9CfGxEWIGh4ImaY5rbXgLChJ1viW8IBN5eLJm
        af6jsnsmKixAxfpX30mqF/Manw==
X-Google-Smtp-Source: APBJJlHPKfX4HyR7hkCnyyDobeInredTgw+ZywD1R8KNR/oUOQB27w+klRQWt9Lv4VZ+OoWdwHb0BA==
X-Received: by 2002:a05:6a00:1410:b0:67a:8fc7:1b4e with SMTP id l16-20020a056a00141000b0067a8fc71b4emr14457188pfu.4.1689651578342;
        Mon, 17 Jul 2023 20:39:38 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:49d1:35f7:f76f:e7b1])
        by smtp.gmail.com with ESMTPSA id a12-20020aa7864c000000b0067acbc74977sm514604pfo.96.2023.07.17.20.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 20:39:37 -0700 (PDT)
Date:   Tue, 18 Jul 2023 12:39:33 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 2/7] printk: Reduce console_unblank() usage in
 unsafe scenarios
Message-ID: <20230718033933.GC955071@google.com>
References: <20230717194607.145135-1-john.ogness@linutronix.de>
 <20230717194607.145135-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717194607.145135-3-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/17 21:52), John Ogness wrote:
> 
> A semaphore is not NMI-safe, even when using down_trylock(). Both
> down_trylock() and up() are using internal spinlocks and up()
> might even call wake_up_process().
> 
> In the panic() code path it gets even worse because the internal
> spinlocks of the semaphore may have been taken by a CPU that has
> been stopped.
> 
> To reduce the risk of deadlocks caused by the console semaphore in
> the panic path, make the following changes:
> 
> - First check if any consoles have implemented the unblank()
>   callback. If not, then there is no reason to take the console
>   semaphore anyway. (This check is also useful for the non-panic
>   path since the locking/unlocking of the console lock can be
>   quite expensive due to console printing.)
> 
> - If the panic path is in NMI context, bail out without attempting
>   to take the console semaphore or calling any unblank() callbacks.
>   Bailing out is acceptable because console_unblank() would already
>   bail out if the console semaphore is contended. The alternative of
>   ignoring the console semaphore and calling the unblank() callbacks
>   anyway is a bad idea because these callbacks are also not NMI-safe.
> 
> If consoles with unblank() callbacks exist and console_unblank() is
> called from a non-NMI panic context, it will still attempt a
> down_trylock(). This could still result in a deadlock if one of the
> stopped CPUs is holding the semaphore internal spinlock. But this
> is a risk that the kernel has been (and continues to be) willing
> to take.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
