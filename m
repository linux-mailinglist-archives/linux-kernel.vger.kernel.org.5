Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0775A774519
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjHHSgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjHHSgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:36:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8C8347F7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:34:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9014A2001A;
        Tue,  8 Aug 2023 08:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691482515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RB1vfBNcKo1SzgnEhdC16EESN0w4j0uD5BJHCDr0ghs=;
        b=bcgCin70bsM2EI1zUa2zNT6mkPVbEvk71R21tBo0ypflNUOCe8XfUjNumUuQvTIwiXdfwl
        QUyTr7GebJMAyfQ3aKYHwKCo0ShfgVSxtfI4nSPh+lxegI9U+JWp+jr8vn1Y4zWhiliLpv
        pOoy39AkVp7kApnN2CLqHJKt/0LVGxg=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 094292C142;
        Tue,  8 Aug 2023 08:15:14 +0000 (UTC)
Date:   Tue, 8 Aug 2023 10:15:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: pstore/ram: printk: NULL characters in pstore ramoops area
Message-ID: <ZNH5kSl-I_goJw2H@alley>
References: <f28990eb-03bc-2259-54d0-9f2254abfe62@linux.microsoft.com>
 <d8bb1ec7-a4c5-43a2-9de0-9643a70b899f@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8bb1ec7-a4c5-43a2-9de0-9643a70b899f@linux.microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-08-07 10:19:07, Vijay Balakrishna wrote:
> I'm including my earlier email as it didn't deliver to
> linux-kernel@vger.kernel.org due to HTML subpart.  Also sharing new findings
> --
> 
> Limiting the size of buffer exposed to record_print_text() and
> prb_for_each_record() in kmsg_dump_get_buffer() also resolves this issue [5]
> -- no NULL characters in pstore/ramoops memory.  The advantage is no memory
> allocation (as done in previously shared changes [4]) which could be
> problematic during kernel shutdown/reboot or during kexec reboot.
> 
> [5]
> 
> Author: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Date:   Sat Aug 5 18:47:27 2023 +0000
> 
>     printk: limit the size of buffer exposed to record_print_text() by
> kmsg_dump_get_buffer()
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index b82e4c3b52f4..8feec932aa35 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3453,9 +3453,9 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper,
> bool syslog,
>          */
>         next_seq = seq;
> 
> -       prb_rec_init_rd(&r, &info, buf, size);
> 
>         len = 0;
> +       prb_rec_init_rd(&r, &info, buf + len, (size - len) >= LOG_LINE_MAX +
> PREFIX_MAX ? LOG_LINE_MAX + PREFIX_MAX : size - len);
>         prb_for_each_record(seq, prb, seq, &r) {
>                 if (r.info->seq >= dumper->next_seq)
>                         break;
> @@ -3463,7 +3463,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper,
> bool syslog,
>                 len += record_print_text(&r, syslog, time);
> 
>                 /* Adjust record to store to remaining buffer space. */
> -               prb_rec_init_rd(&r, &info, buf + len, size - len);
> +               prb_rec_init_rd(&r, &info, buf + len, (size - len) >=
> LOG_LINE_MAX + PREFIX_MAX ? LOG_LINE_MAX + PREFIX_MAX : size - len);
>         }
> 
>         dumper->next_seq = next_seq;


I looks like some problems with counting data that fit into the
buffer. I see that several fixes were added after 5.10 release.
I wonder if they help to solve this:

commit 89ccf18f032f26946 ("printk: fix kmsg_dump_get_buffer length calulations")
commit f0e386ee0c0b71ea6 ("printk: fix buffer overflow potential for print_text()")
commit 08d60e59995401105 ("printk: fix string termination for record_print_text()")

All 3 commits were backported into 5.10 stable.

The 2nd commit without the 3rd one might cause writing an extra "\0"
into a wrong place.


> On 8/3/23 16:34, Vijay Balakrishna wrote:
> > 
> > Hello,
> > 
> > We are noticing NULL characters in ramoops/pstore memory after a warm or
> > a kexec reboot [1] in our 5.10 ARM64 product kernel after moving from
> > 5.4 kernel.  I ruled out fs/pstore/* as the source from where NULL
> > characters originate by adding debug code [2] and confirming from
> > collected output [3].  Then isolated further to printk log/ring buffer
> > area, the NULL characters were already present in buffer in
> > kmsg_dump_get_buffer() when kmsg log lines are read.  After looking at
> > printk merges in mainline kernel, I cherry-picked following which looked
> > related to our 5.10 kernel and still see NULL characters.
> > 
> >     4260e0e5510158d704898603331e5365ebe957de printk: consolidate
> >     kmsg_dump_get_buffer/syslog_print_all code
> >     726b5097701a8d46f5354be780e1a11fc4ca1187 printk: refactor
> >     kmsg_dump_get_buffer()
> >     bb07b16c44b2c6ddbafa44bb06454719002e828e printk: limit second loop
> >     of syslog_print_all

These commits tried to reduce a code duplication between kmsg_dump
and syslog API.

> > Looking at syslog_print_all() I notice it uses a local buffer unlike
> > kmsg_dump_get_buffer() which manipulates buffer in-place to add syslog
> > and timestamp prefix data.

syslog_print_all() gets a buffer from userspace. It can be written
only by copy_to_user(). It allocates an extra buffer so that it could
do all the message formatting in the kernel space.

> I made changes [4] to kmsg_dump_get_buffer()
> > to use a local buffer similar to syslog_print_all() after which I don't
> > see NULL characters in ramoops area.  I couldn't spot any suspicious
> > code in record_print_text() where prefix data added in-place.  I'm
> > reaching out to both pstore/ram and printk folks for comments. I can
> > investigate/debug further with assistance and input from you.

It is more safe with the extra buffer. It is always used only
for one message. It is possible that the NULL character was
also written in a wrong place there. But it did not affect
the buffer passed to kmsg_dump_get_buffer().

I hope that the above three commit fixing the length calculation
and potential buffer overflow will fix this.

Anyway, thanks a lot for debugging this and providing all the details.

Best Regards,
Petr
