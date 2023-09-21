Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23FE7A90D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjIUCTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIUCTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:19:10 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5852DAC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:19:04 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c44a25bd0bso10739865ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695262744; x=1695867544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7QWcQ2h6Fw58l2vD8cmILL2QYzm24hRo+bt6z0nA9pA=;
        b=aGGp6pEJXIytDCC2wCTaYALwWbZCQoGxD3I4wLx8D9bql6Fad2Il72SP0qY+bmcows
         l1O4pTb7XCFlD929DAsduFgJY5Vhndu/CsOp0Q1uue5KgIVjcGTcaSc2DlS+m0zPdLhO
         fZBkgaYxysZdL2kHlN42n0BN3CQFUk/GC7ccA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695262744; x=1695867544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QWcQ2h6Fw58l2vD8cmILL2QYzm24hRo+bt6z0nA9pA=;
        b=hy58J/YF0+vtwtSqPnJ+jpJtw0M2qkwUJERUfYs/yS7UOtJZ7OUncQaURYkVtGUKNp
         6oPtKiURRzMaAmMFujD2XMJgXLMjzs2Rkrdw/fWeySxjY5R+3GU7BZctccl43VU7ghXM
         /ptO/u6QWYVDhmC37TNhHb9UbLfUGHJ2/poIyBg5bGKdhL3bkZ5YB1j0uopjeq2ywnoX
         c9MRZ7vCj5ww7SB7CpQwiAEbuV865AB9rOyqJhj7oTceuLxuCHuyZdzBNj2Zezx/kuZf
         fM085JK2TmzXDdi0cslqy4SNaUQrYXvEZ7z4vWf9Hz+KoTpuak2fkCnRk9OmMJa3u6f8
         Y6KA==
X-Gm-Message-State: AOJu0YwMdmmIuEVwFAzbn50UktcF7aT+sjUOSoEyLXRXfDCDbilQAaLL
        mLycrVM4UYZYkXqhTbFeOyTq9A==
X-Google-Smtp-Source: AGHT+IHR2bDEIpeoXw96Uouy4kfsSmBawsUaN5fxDCgfgJUjEWc1jE8nvZBTBm3ocqQKbVtQQpOYoA==
X-Received: by 2002:a17:902:d506:b0:1c1:d5d1:a364 with SMTP id b6-20020a170902d50600b001c1d5d1a364mr5646179plg.33.1695262743607;
        Wed, 20 Sep 2023 19:19:03 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:9dd3:363a:be52:b271])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902e99500b001c55db80b14sm173881plb.221.2023.09.20.19.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 19:19:02 -0700 (PDT)
Date:   Thu, 21 Sep 2023 11:18:59 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH printk v1] printk: fix illegal pbufs access for
 !CONFIG_PRINTK
Message-ID: <20230921021859.GA14418@google.com>
References: <20230920155238.670439-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920155238.670439-1-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/09/20 17:58), John Ogness wrote:
> When CONFIG_PRINTK is not set, PRINTK_MESSAGE_MAX is 0. This
> leads to a zero-sized array @outbuf in @printk_shared_pbufs. In
> console_flush_all() a pointer to the first element of the array
> is assigned with:
> 
>    char *outbuf = &printk_shared_pbufs.outbuf[0];
> 
> For !CONFIG_PRINTK this leads to a compiler warning:
> 
>    warning: array subscript 0 is outside array bounds of
>    'char[0]' [-Warray-bounds]
> 
> This is not really dangerous because printk_get_next_message()
> always returns false for !CONFIG_PRINTK, which leads to @outbuf
> never being used. However, it makes no sense to even compile
> these functions for !CONFIG_PRINTK.

I wonder if anyone really use !PRINTK kernels. Can we get rid
of CONFIG_PRINTK?

> Extend the existing '#ifdef CONFIG_PRINTK' block to contain
> the formatting and emitting functions since these have no
> purpose in !CONFIG_PRINTK. This also allows removing several
> more !CONFIG_PRINTK dummies as well as moving
> @suppress_panic_printk into a CONFIG_PRINTK block.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309201724.M9BMAQIh-lkp@intel.com/
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

FWIW,
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
