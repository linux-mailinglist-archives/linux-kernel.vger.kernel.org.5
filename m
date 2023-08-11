Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C327786F7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjHKFXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHKFXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:23:51 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79152717
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:23:50 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-564b6276941so1266683a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691731430; x=1692336230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gMyl0aElcVGBe+uMIQ0Kc/Hujce0tvgCp3zVAF2hoPM=;
        b=ncli/FmAPg6kDwkmHWSmvsZ+KliyHcaGnrLtPAVZmn2wcKoPLq7rGEuUF2Iwm5+47/
         sS8B9c/j4MfTyEQ5C1QN8t5DltcUGEqjyrV+A9vcyvu7aeNeprkI+xIpLy5hc7viu5ce
         hcWqmS/ZBdUSscJ+W20sh89jipE9nc1/8ja8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691731430; x=1692336230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMyl0aElcVGBe+uMIQ0Kc/Hujce0tvgCp3zVAF2hoPM=;
        b=RmGq6QG2KgZBkxktxiTLns2HEFrH7Fuy+2+50WEhmAd8Iti2euLZla7cr+MOy6KfD7
         GWlSLKgG0vrPx9byM9KrltvlSVYGD0QsUnzD71O7x/0Fa3IeM6P1nBNRO4vPDw+jjyam
         oUjC+RFlEtV80LQwAoE7jZcvDQgZ+pwN0uw1av+d6K+dpTsNBzHN2OU3Y1nKJnVtFtR0
         E16psBVwQdebdCbYEqdttV1bpgj37K6bmn9YIUBh1KbSUcXx8Iwn38pyoilsYiQCbqWF
         OsUFEFTd2SAYteRj86ofTF30HCAtml4epSIEe9jcYK59E1mqheSSHF/de/wXGYah3bOO
         z0Cg==
X-Gm-Message-State: AOJu0Yzn0dIm85NQv3oXYwHI4GkrECejsMKOL5h4I89TGHsjvApQT7tB
        azgwYrcjIzDIgG6aguSZ9Lpixv+3Of3B1ZYCd8s=
X-Google-Smtp-Source: AGHT+IF2whMHlIRe7/N2RBsmdPkqcTZqC+Ipf/9r7HWKwredENnM8cHak18Tror6e+OVar1d4hljLA==
X-Received: by 2002:a05:6a21:4847:b0:140:22b0:9ddd with SMTP id au7-20020a056a21484700b0014022b09dddmr1159580pzc.0.1691731430083;
        Thu, 10 Aug 2023 22:23:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902ee0300b001b9fef7f454sm2776123plb.73.2023.08.10.22.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 22:23:49 -0700 (PDT)
Date:   Thu, 10 Aug 2023 22:23:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: pstore/ram: printk: NULL characters in pstore ramoops area
Message-ID: <202308102116.0BE50F105@keescook>
References: <f28990eb-03bc-2259-54d0-9f2254abfe62@linux.microsoft.com>
 <d8bb1ec7-a4c5-43a2-9de0-9643a70b899f@linux.microsoft.com>
 <ZNH5kSl-I_goJw2H@alley>
 <3f62313a-438e-b65c-0a8b-f4cdadda4571@linux.microsoft.com>
 <ZNSqXXNL4NtIOoZp@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNSqXXNL4NtIOoZp@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:14:05AM +0200, Petr Mladek wrote:
> On Tue 2023-08-08 18:21:46, Vijay Balakrishna wrote:
> > Thanks for your reply Petr.
> > 
> > See inline.
> > 
> > On 8/8/23 01:15, Petr Mladek wrote:
> > > On Mon 2023-08-07 10:19:07, Vijay Balakrishna wrote:
> > > > I'm including my earlier email as it didn't deliver to
> > > > linux-kernel@vger.kernel.org due to HTML subpart.  Also sharing new findings
> > > > --
> > > > 
> > > > Limiting the size of buffer exposed to record_print_text() and
> > > > prb_for_each_record() in kmsg_dump_get_buffer() also resolves this issue [5]
> > > > -- no NULL characters in pstore/ramoops memory.  The advantage is no memory
> > > > allocation (as done in previously shared changes [4]) which could be
> > > > problematic during kernel shutdown/reboot or during kexec reboot.
> > > > 
> > > > [5]
> > > > 
> > > > Author: Vijay Balakrishna <vijayb@linux.microsoft.com>
> > > > Date:   Sat Aug 5 18:47:27 2023 +0000
> > > > 
> > > >      printk: limit the size of buffer exposed to record_print_text() by
> > > > kmsg_dump_get_buffer()
> > > > 
> > > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > > index b82e4c3b52f4..8feec932aa35 100644
> > > > --- a/kernel/printk/printk.c
> > > > +++ b/kernel/printk/printk.c
> > > > @@ -3453,9 +3453,9 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper,
> > > > bool syslog,
> > > >           */
> > > >          next_seq = seq;
> > > > 
> > > > -       prb_rec_init_rd(&r, &info, buf, size);
> > > > 
> > > >          len = 0;
> > > > +       prb_rec_init_rd(&r, &info, buf + len, (size - len) >= LOG_LINE_MAX +
> > > > PREFIX_MAX ? LOG_LINE_MAX + PREFIX_MAX : size - len);
> > > >          prb_for_each_record(seq, prb, seq, &r) {
> > > >                  if (r.info->seq >= dumper->next_seq)
> > > >                          break;
> > > > @@ -3463,7 +3463,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper,
> > > > bool syslog,
> > > >                  len += record_print_text(&r, syslog, time);
> > > > 
> > > >                  /* Adjust record to store to remaining buffer space. */
> > > > -               prb_rec_init_rd(&r, &info, buf + len, size - len);
> > > > +               prb_rec_init_rd(&r, &info, buf + len, (size - len) >=
> > > > LOG_LINE_MAX + PREFIX_MAX ? LOG_LINE_MAX + PREFIX_MAX : size - len);
> > > >          }
> > > > 
> > > >          dumper->next_seq = next_seq;
> > 
> > Any comments on above change to limit buffer size/range exposed?
> 
> I have the feeling that this is just a workaround. I would like to
> understand what exactly happens there. I want to be sure that
> there is no buffer overflow or other problems.
> 
> > The buffer passed to kmsg_dump_get_buffer() is kzalloc()'ed in
> > fs/pstore/ram.c: ramoops_probe()
> > 
> >                 cxt->pstore.buf = kzalloc(cxt->pstore.bufsize, GFP_KERNEL);
> > 
> > that may explain NULL characters in buffer.
> 
> Yeah, it might explain why there are so many '\0' in a row. Here is
> the dump from the initial mail:.

Okay, I think I'm caught up here in confirming what you've found
now that I'm able to reproduce it ("ramoops.record_size=0x80000
ramoops.max_reason=5"). Just for good measure (and to examine it
"externally") I disabled compression too ("pstore.compress=none").

If I do a "memset(dst, 'X', dst_size)" before calling
kmsg_dump_get_buffer(), the %NUL are now all 'X', so it's clear the kmsg
internals are skipping over bytes while writing: pstore makes a single
call to kmsg_dump_get_buffer() and performs no further buffer management
after this point.

On further investigation, I ultimately noticed the forced u16 cast for
buf_size in copy_data(). This was cast the wrong direction and any
buffer size larger than U16_MAX was getting wrapped/truncated. It should
be min_t for the larger type. I wonder how common this mistake is in the
kernel -- we should only ever GROW the type size when forcing a cast on
min_t() and max_t()...

This fixes it for me:


diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 2dc4d5a1f1ff..fde338606ce8 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1735,7 +1735,7 @@ static bool copy_data(struct prb_data_ring *data_ring,
 	if (!buf || !buf_size)
 		return true;
 
-	data_size = min_t(u16, buf_size, len);
+	data_size = min_t(unsigned int, buf_size, len);
 
 	memcpy(&buf[0], data, data_size); /* LMM(copy_data:A) */
 	return true;

-- 
Kees Cook
