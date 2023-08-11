Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B9677911A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbjHKN47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbjHKN4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:56:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFD11994
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:56:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 519FD21868;
        Fri, 11 Aug 2023 13:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691762211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CIn4C/snRwmsrZzRBrMmnOMriB49c4u4rK0tB8B/js4=;
        b=mHTvaOiOD157XYAc+TmvHXwBeZAbq+BtvHvjS4t5hMZwPgmPdQViRHiWtW4h0Q0y/Th0nO
        RLuQo7lpkhEUtR8o4ygXLXPw6kjQdr+UncE3grsmFgY98Ezk6rdw4+G6Xa9gguuqb6bWKV
        GwuPODSv474PoqDNEOwfQhP4aROMFAY=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 14A662C142;
        Fri, 11 Aug 2023 13:56:51 +0000 (UTC)
Date:   Fri, 11 Aug 2023 15:56:50 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 0/8] wire up nbcon consoles
Message-ID: <ZNY-IhuJJMZuFAHz@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728000233.50887-1-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-07-28 02:08:25, John Ogness wrote:
> Hi,
> 
> This is v2 of a series to introduce the new non-BKL (nbcon)
> consoles. This series is only a subset of the original
> v1 [0]. In particular, this series represents patches 5-10 of
> the v1 series. For information about the motivation of the
> atomic consoles, please read the cover letter of v1.
> 
> This series focuses on wiring up the printk subsystem to
> be able to use the nbcon consoles and implement their ownership
> interfaces and rules. This series does _not_ include threaded
> printing, atomic printing regions, or nbcon drivers. Those
> features will be added in separate follow-up series.
> 
> 
>  include/linux/console.h      | 132 +++++
>  kernel/printk/Makefile       |   2 +-
>  kernel/printk/internal.h     |  29 ++
>  kernel/printk/printk.c       | 156 ++++--
>  kernel/printk/printk_nbcon.c | 955 +++++++++++++++++++++++++++++++++++

Nit: Is there still any chance to rename this to kernel/printk/nbcon.c ?

I am sorry that I did not suggested this earlier. I think that
we should have omitted the "printk_" prefix even for
the "ringbuffer.*" files.

I think that it came from "printk_safe.c". But it made some sense.
"printk_safe_*" was also an API.

But in general, "printk_" prefix is superfluous in "printk" directory.

Best Regards,
Petr
