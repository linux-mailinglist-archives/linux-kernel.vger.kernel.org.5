Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD617AABB4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjIVIFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjIVIFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:05:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1C6CD7;
        Fri, 22 Sep 2023 01:03:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 753DE21AB9;
        Fri, 22 Sep 2023 08:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695369828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZGIZ1SL3XOn4v/k/jfc0V/Kx2cFAQpv1ro3HElGvJKI=;
        b=VVAadmS3V5n9yqHi52W+JiUysLV4LVQylZ3Rd+HLfeQes6xs5GDZhRvzzNSdIEyuAon763
        SCGpgRLdY4W+L+srgUlGbWANiHrRpKVZNXJ/gxgDYSgrjJJ5IHLH+upiO2SLwwxkIQh8lk
        1a18tDDLcqAcbIELxJHR9b3H2uXIuwg=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EED312C142;
        Fri, 22 Sep 2023 08:03:47 +0000 (UTC)
Date:   Fri, 22 Sep 2023 10:03:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Enlin Mu <enlinmu@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Enlin Mu <enlin.mu@outlook.com>, rostedt@goodmis.org,
        senozhatsky@chromium.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com, enlin.mu@unisoc.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] printk: add cpu id information to printk() output
Message-ID: <ZQ1KYyJfZjd33fqL@alley>
References: <JH0PR04MB7072A4B6946EAEEB1EB8B0BE8AF6A@JH0PR04MB7072.apcprd04.prod.outlook.com>
 <8734zfx2bo.fsf@jogness.linutronix.de>
 <CAAfh-jPc+UWMcLPFbYy6rYUh4OU36frkVYVbkhNPNX4L6RG5sA@mail.gmail.com>
 <2023091547-mug-unlikable-571f@gregkh>
 <ZQSHJ_786kZNjEDX@alley>
 <CAAfh-jMvgYfDrgcbj7o4bv83syAhL2d+1r2vn1Yz+FY_Ws81Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAfh-jMvgYfDrgcbj7o4bv83syAhL2d+1r2vn1Yz+FY_Ws81Pw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-09-22 15:20:37, Enlin Mu wrote:
> Petr Mladek <pmladek@suse.com> 于2023年9月16日周六 00:34写道：
> >
> > On Fri 2023-09-15 11:53:13, Greg KH wrote:
> > > On Fri, Sep 15, 2023 at 04:46:02PM +0800, Enlin Mu wrote:
> > > > John Ogness <john.ogness@linutronix.de> 于2023年9月15日周五 16:34写道：
> > > > >
> > > > > On 2023-09-15, Enlin Mu <enlin.mu@outlook.com> wrote:
> > > > > > Sometimes we want to print cpu id of printk() messages to consoles
> > > > > >
> > > > > > diff --git a/include/linux/threads.h b/include/linux/threads.h
> > > > > > index c34173e6c5f1..6700bd9a174f 100644
> > > > > > --- a/include/linux/threads.h
> > > > > > +++ b/include/linux/threads.h
> > > > > > @@ -34,6 +34,9 @@
> > > > > >  #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
> > > > > >       (sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
> > > > > >
> > > > > > +#define CPU_ID_SHIFT 23
> > > > > > +#define CPU_ID_MASK  0xff800000
> > > > >
> > > > > This only supports 256 CPUs. I think it doesn't make sense to try to
> > > > > squish CPU and Task IDs into 32 bits.
> > > > Yes, it is not good way,
> > > > >
> > > > > What about introducing a caller_id option to always only print the CPU
> > > > > ID? Or do you really need Task _and_ CPU?
> > > >    Yes, I need it.Because I need to know which CPU is printing the
> > > > log, so that I can identify the current system operation, such as load
> > > > situation and CPU busy/idle status
> > >
> > > The cpu that is printing the log isn't the one that added the log
> > > message, so I think you will have incorrect data here, right?
> >
> > We already store some metadata about the caller:
> >
> >  * All fields are set by the printk code except for @seq, which is
> >  * set by the ringbuffer code.
> >  */
> > struct printk_info {
> >         u64     seq;            /* sequence number */
> >         u64     ts_nsec;        /* timestamp in nanoseconds */
> >         u16     text_len;       /* length of text message */
> >         u8      facility;       /* syslog facility */
> >         u8      flags:5;        /* internal record flags */
> >         u8      level:3;        /* syslog level */
> >         u32     caller_id;      /* thread id or processor id */
> >
> >         struct dev_printk_info  dev_info;
> > };
> >
> > The 32-bit caller ID is generated using:
> >
> > static inline u32 printk_caller_id(void)
> > {
> >         return in_task() ? task_pid_nr(current) :
> >                 0x80000000 + smp_processor_id();
> > }
> >
> > We could add more metadata and always store the CPU ID and something
> > like:
> >
> >    [CTXT][ Tpid][  Ccpu]
> >
> > for example
> >
> >    [TASK][  T234][    C4]
> >    [ IRQ][ T4567][   C17]
> >    [SIRQ][    T5][    C0]
> >    [ NMI][  T356][  C128]
> >
> Greate!
> Do you have a plan to push it to linus?

No. It was just a POC. It would require much more effort to make
it ready for upstream, see below.

> > The biggest problem is that it would change the format of the
> > ringbuffer so that it would require updating external tools,
> > working with crashdump, especially crash but there are also
> > alternative python extensions for gdb.

It would require patches for the crash tool,
./scripts/gdb/linux/dmesg.py,
Documentation/admin-guide/kdump/gdbmacros.txt

> > See below POC of the kernel part. It is not even compile tested. The size
> > of the buffers is updated by a guess. Comments are not updated, ...

And of course, make the POC working, update comments, ...

I am sorry but I do not have enough time and motivation to do so.
But I could answer questions, review the patches, ... when any
interested person start working on it.

Best Regards,
Petr
