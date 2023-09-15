Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A66F7A1B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbjIOJyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjIOJyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:54:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A955B2D43;
        Fri, 15 Sep 2023 02:53:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F8FC433C9;
        Fri, 15 Sep 2023 09:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694771596;
        bh=tRSYOs1YIvUKupCh/zQxAhrE6h+c8c1LmgwSRnPmf2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wce7jhmQefHvj4g2gcdB7vKdStzRg+v2LwFNwb4XqndNtPwoXtE90+SfTNIVjGsYv
         emjnT1EQPpXXvLaa9x3OoaHBlBz+ChsMZm2S5H7wQJWLDVkBmpk5MFJLUBkbuo/naW
         s7iXS+iEzDYwitQbSjAv58wsvN+Qkz56QpickoaY=
Date:   Fri, 15 Sep 2023 11:53:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Enlin Mu <enlinmu@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Enlin Mu <enlin.mu@outlook.com>, pmladek@suse.com,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        enlin.mu@unisoc.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] printk: add cpu id information to printk() output
Message-ID: <2023091547-mug-unlikable-571f@gregkh>
References: <JH0PR04MB7072A4B6946EAEEB1EB8B0BE8AF6A@JH0PR04MB7072.apcprd04.prod.outlook.com>
 <8734zfx2bo.fsf@jogness.linutronix.de>
 <CAAfh-jPc+UWMcLPFbYy6rYUh4OU36frkVYVbkhNPNX4L6RG5sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAfh-jPc+UWMcLPFbYy6rYUh4OU36frkVYVbkhNPNX4L6RG5sA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 04:46:02PM +0800, Enlin Mu wrote:
> John Ogness <john.ogness@linutronix.de> 于2023年9月15日周五 16:34写道：
> >
> > On 2023-09-15, Enlin Mu <enlin.mu@outlook.com> wrote:
> > > Sometimes we want to print cpu id of printk() messages to consoles
> > >
> > > diff --git a/include/linux/threads.h b/include/linux/threads.h
> > > index c34173e6c5f1..6700bd9a174f 100644
> > > --- a/include/linux/threads.h
> > > +++ b/include/linux/threads.h
> > > @@ -34,6 +34,9 @@
> > >  #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
> > >       (sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
> > >
> > > +#define CPU_ID_SHIFT 23
> > > +#define CPU_ID_MASK  0xff800000
> >
> > This only supports 256 CPUs. I think it doesn't make sense to try to
> > squish CPU and Task IDs into 32 bits.
> Yes, it is not good way,
> >
> > What about introducing a caller_id option to always only print the CPU
> > ID? Or do you really need Task _and_ CPU?
>    Yes, I need it.Because I need to know which CPU is printing the
> log, so that I can identify the current system operation, such as load
> situation and CPU busy/idle status

The cpu that is printing the log isn't the one that added the log
message, so I think you will have incorrect data here, right?

thanks,

greg k-h
