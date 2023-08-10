Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DECD7773F5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbjHJJOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjHJJOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:14:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8AE2735
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:14:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A7A741F749;
        Thu, 10 Aug 2023 09:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691658846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9F4abpTeewGZCpVSZpTwp3yBfCQMCsnC5Je7HGJzw/k=;
        b=qgkDvoUPa/FG2TWRdI8D8lkVWbgBn7vtljeTluBo2bR6lnZ7chX8biiWbbwrfBKsxUvCyO
        4J8aa639BSrJlbTFR7knZ7NKTsFAhI9F86Tkpgkdo5hCq6WQ5CPGsJRSA0TqDguO+1Q769
        vwAZtAUlFxQR0OA7Py+rnuClROIVPR8=
Received: from suse.cz (dhcp108.suse.cz [10.100.51.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0C1D82C143;
        Thu, 10 Aug 2023 09:14:06 +0000 (UTC)
Date:   Thu, 10 Aug 2023 11:14:05 +0200
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
Message-ID: <ZNSqXXNL4NtIOoZp@alley>
References: <f28990eb-03bc-2259-54d0-9f2254abfe62@linux.microsoft.com>
 <d8bb1ec7-a4c5-43a2-9de0-9643a70b899f@linux.microsoft.com>
 <ZNH5kSl-I_goJw2H@alley>
 <3f62313a-438e-b65c-0a8b-f4cdadda4571@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f62313a-438e-b65c-0a8b-f4cdadda4571@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-08-08 18:21:46, Vijay Balakrishna wrote:
> Thanks for your reply Petr.
> 
> See inline.
> 
> On 8/8/23 01:15, Petr Mladek wrote:
> > On Mon 2023-08-07 10:19:07, Vijay Balakrishna wrote:
> > > I'm including my earlier email as it didn't deliver to
> > > linux-kernel@vger.kernel.org due to HTML subpart.  Also sharing new findings
> > > --
> > > 
> > > Limiting the size of buffer exposed to record_print_text() and
> > > prb_for_each_record() in kmsg_dump_get_buffer() also resolves this issue [5]
> > > -- no NULL characters in pstore/ramoops memory.  The advantage is no memory
> > > allocation (as done in previously shared changes [4]) which could be
> > > problematic during kernel shutdown/reboot or during kexec reboot.
> > > 
> > > [5]
> > > 
> > > Author: Vijay Balakrishna <vijayb@linux.microsoft.com>
> > > Date:   Sat Aug 5 18:47:27 2023 +0000
> > > 
> > >      printk: limit the size of buffer exposed to record_print_text() by
> > > kmsg_dump_get_buffer()
> > > 
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > index b82e4c3b52f4..8feec932aa35 100644
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -3453,9 +3453,9 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper,
> > > bool syslog,
> > >           */
> > >          next_seq = seq;
> > > 
> > > -       prb_rec_init_rd(&r, &info, buf, size);
> > > 
> > >          len = 0;
> > > +       prb_rec_init_rd(&r, &info, buf + len, (size - len) >= LOG_LINE_MAX +
> > > PREFIX_MAX ? LOG_LINE_MAX + PREFIX_MAX : size - len);
> > >          prb_for_each_record(seq, prb, seq, &r) {
> > >                  if (r.info->seq >= dumper->next_seq)
> > >                          break;
> > > @@ -3463,7 +3463,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper,
> > > bool syslog,
> > >                  len += record_print_text(&r, syslog, time);
> > > 
> > >                  /* Adjust record to store to remaining buffer space. */
> > > -               prb_rec_init_rd(&r, &info, buf + len, size - len);
> > > +               prb_rec_init_rd(&r, &info, buf + len, (size - len) >=
> > > LOG_LINE_MAX + PREFIX_MAX ? LOG_LINE_MAX + PREFIX_MAX : size - len);
> > >          }
> > > 
> > >          dumper->next_seq = next_seq;
> 
> Any comments on above change to limit buffer size/range exposed?

I have the feeling that this is just a workaround. I would like to
understand what exactly happens there. I want to be sure that
there is no buffer overflow or other problems.

> The buffer passed to kmsg_dump_get_buffer() is kzalloc()'ed in
> fs/pstore/ram.c: ramoops_probe()
> 
>                 cxt->pstore.buf = kzalloc(cxt->pstore.bufsize, GFP_KERNEL);
> 
> that may explain NULL characters in buffer.

Yeah, it might explain why there are so many '\0' in a row. Here is
the dump from the initial mail:.

root@localhost:~# hexdump -C /var/lib/systemd/pstore/dmesg-ramoops-0
00000000  53 68 75 74 64 6f 77 6e  23 31 20 50 61 72 74 31 |Shutdown#1 Part1|
00000010  0a 3c 36 3e 5b 20 20 20  20 30 2e 30 30 30 30 30 |.<6>[    0.00000|
..
0000ff50  2e 0a 3c 35 3e 5b 20 32  31 38 37 2e 31 31 31 37 |..<5>[ 2187.1117|
0000ff60  31 38 5d 20 61 75 64 69  74 3a 20 74 79 70 65 3d |18] audit: type=|
0000ff70  31 31 33 31 20 61 75 64  69 74 28 31 36 39 30 39 |1131 audit(16909|
0000ff80  31 31 30 34 34 2e 35 36  30 3a 31 37 33 29 3a 20 |11044.560:173): |
0000ff90  70 69 64 3d 31 20 75 69  64 3d 30 20 61 75 69 64 |pid=1 uid=0 auid|
0000ffa0  3d 34 32 39 34 39 36 37  32 39 35 20 73 65 73 3d |=4294967295 ses=|
0000ffb0  34 32 39 34 39 36 37 32  39 35 20 73 75 62 6a 3d |4294967295 subj=|
0000ffc0  73 79 73 74 65 6d 5f 75  3a 73 79 73 74 65 6d 5f |system_u:system_|
0000ffd0  72 3a 69 6e 69 74 5f 74  20 6d 73 67 3d 27 75 6e |r:init_t msg='un|
0000ffe0  69 74 3d xx xx xx xx xx  xx xx xx 2d 65 6e 6d 64 |it=xxxxxxxx-enmd|
0000fff0  2d 6f 77 6e 65 72 73 68  69 70 20 63 6f 6d 6d 3d |-ownership comm=|
00010000  22 73 79 73 74 65 00 00  00 00 00 00 00 00 00 00 |"syste..........|
00010010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 |................|
*
00010050  00 00 0a 3c 33 30 3e 5b  20 32 31 38 37 2e 31 31 |...<30>[ 2187.11|
..
root@localhost:~#

If I count correctly, there are 76 '\0' characters. It can't be easily
explained by writing '\0' into a wrong position. But copying zeroed
buffer might explain it.

Another interesting thing is that the message is interrupted in
the middle of a word "syste...". I expect that it was "systemd"
because there is pid=1 earlier.

It looks like the message was not read completely.

> Output seen after adding NULL character check before calling
> record_print_text() suggest the issue may not be in record_print_text().

Maybe, this check is not enough. Maybe the problem is the other way
that the the message was not read completely.

It might be interesting to check if there are '\0' characters before
the end of the message. It should not happen. The length of the
stored message is defined by vsnprintf() in vprintk_store().
And it should not count the trailing '\0' character.


> (diffs below are from v5.10.178)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 17a310dcb6d9..4cbb845424f5 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3431,10 +3431,17 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper
> *dumper, bool syslog,
>         /* actually read text into the buffer now */
>         l = 0;
>         while (prb_read_valid(prb, seq, &r)) {
> +               size_t pr_len;
>                 if (r.info->seq >= dumper->next_seq)
>                         break;
> 
> -               l += record_print_text(&r, syslog, time);
> +               if (null_char(r.text_buf, r.info->text_len))
> +                       pr_crit("%s: pre record_print_text() a NULL char in
> record text_buf, l %zu, textlen %zu\n", __func__, l, r.info->text_len);

Please, try to check:

	if (r.info->text_len && r.info->text_len - 1)
		pr_crit(....

> +               pr_len = record_print_text(&r, syslog, time);
> +               l += pr_len;
> +
> +               if (null_char(r.text_buf, pr_len))
> +                       pr_crit("%s: post record_print_text() a NULL char in
> record text_buf, l %zu, pr_len %zu\n", __func__, l, pr_len);
> 
>                 /* adjust record to store to remaining buffer space */
>                 prb_rec_init_rd(&r, &info, buf + l, size - l);
> 
> (output during warm reboot)
> 
> [   12.400817] ramoops: ramoops_pstore_write: A NULL char in record buf,
> size 70648
> [   12.408217] printk: kmsg_dump_get_buffer: pre record_print_text() a NULL
> char in record text_buf, l 65505, textlen 53
> [   12.408219] printk: kmsg_dump_get_buffer: post record_print_text() a NULL
> char in record text_buf, l 65578, pr_len 73
> 
> As I replied to Kees last week, we will try to repro with modern/mainline
> kernel hopefully soon.

Yeah, that would be great as well.

Best Regards,
Petr

PS: Please, do not send .html mails. It breaks formatting and
    diff could not be applied.

    Also top-posting is not ideal. It is always easier when
    the comments are written right after the commented text.

    The interleave posting also allows to keep only the important
    parts of the original message in the reply. It helps to
    keep each reply small while keeping the needed context.

    See "interleaved posting" at https://en.wikipedia.org/wiki/Posting_style
