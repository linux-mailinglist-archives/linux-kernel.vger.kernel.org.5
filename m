Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49958775047
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjHIBVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHIBVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:21:49 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12886E5E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 18:21:48 -0700 (PDT)
Received: from [192.168.5.48] (cpe-70-95-196-11.san.res.rr.com [70.95.196.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id E220F20FC0E6;
        Tue,  8 Aug 2023 18:21:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E220F20FC0E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691544107;
        bh=GtonJvaVyZwHdX4nIWcqLDvYu2OYb4d6PmuAovkSQCg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fH9zQl3C/BCxWVlGllu7SD/itYM5hsrHox8nryC045taooQiB3NV1yk/4ZNhetkwj
         DKnMlM3fUa6ZWEHlLR0pFSWAqcwr3cjybSSIR1OVZChj9oRbBen5Y0TJ4AEBNfKlGz
         eOBEJPZl7Fab5DSI09CZkqq1DbIWI3KqPchAWqm8=
Message-ID: <3f62313a-438e-b65c-0a8b-f4cdadda4571@linux.microsoft.com>
Date:   Tue, 8 Aug 2023 18:21:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: pstore/ram: printk: NULL characters in pstore ramoops area
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        linux-kernel@vger.kernel.org
References: <f28990eb-03bc-2259-54d0-9f2254abfe62@linux.microsoft.com>
 <d8bb1ec7-a4c5-43a2-9de0-9643a70b899f@linux.microsoft.com>
 <ZNH5kSl-I_goJw2H@alley>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
In-Reply-To: <ZNH5kSl-I_goJw2H@alley>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply Petr.

See inline.

On 8/8/23 01:15, Petr Mladek wrote:
> On Mon 2023-08-07 10:19:07, Vijay Balakrishna wrote:
>> I'm including my earlier email as it didn't deliver to
>> linux-kernel@vger.kernel.org due to HTML subpart.  Also sharing new findings
>> --
>>
>> Limiting the size of buffer exposed to record_print_text() and
>> prb_for_each_record() in kmsg_dump_get_buffer() also resolves this issue [5]
>> -- no NULL characters in pstore/ramoops memory.  The advantage is no memory
>> allocation (as done in previously shared changes [4]) which could be
>> problematic during kernel shutdown/reboot or during kexec reboot.
>>
>> [5]
>>
>> Author: Vijay Balakrishna <vijayb@linux.microsoft.com>
>> Date:   Sat Aug 5 18:47:27 2023 +0000
>>
>>      printk: limit the size of buffer exposed to record_print_text() by
>> kmsg_dump_get_buffer()
>>
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index b82e4c3b52f4..8feec932aa35 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -3453,9 +3453,9 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper,
>> bool syslog,
>>           */
>>          next_seq = seq;
>>
>> -       prb_rec_init_rd(&r, &info, buf, size);
>>
>>          len = 0;
>> +       prb_rec_init_rd(&r, &info, buf + len, (size - len) >= LOG_LINE_MAX +
>> PREFIX_MAX ? LOG_LINE_MAX + PREFIX_MAX : size - len);
>>          prb_for_each_record(seq, prb, seq, &r) {
>>                  if (r.info->seq >= dumper->next_seq)
>>                          break;
>> @@ -3463,7 +3463,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper,
>> bool syslog,
>>                  len += record_print_text(&r, syslog, time);
>>
>>                  /* Adjust record to store to remaining buffer space. */
>> -               prb_rec_init_rd(&r, &info, buf + len, size - len);
>> +               prb_rec_init_rd(&r, &info, buf + len, (size - len) >=
>> LOG_LINE_MAX + PREFIX_MAX ? LOG_LINE_MAX + PREFIX_MAX : size - len);
>>          }
>>
>>          dumper->next_seq = next_seq;

Any comments on above change to limit buffer size/range exposed?

The buffer passed to kmsg_dump_get_buffer() is kzalloc()'ed in 
fs/pstore/ram.c: ramoops_probe()

                 cxt->pstore.buf = kzalloc(cxt->pstore.bufsize, GFP_KERNEL);

that may explain NULL characters in buffer.

Output seen after adding NULL character check before calling 
record_print_text() suggest the issue may not be in record_print_text().

(diffs below are from v5.10.178)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 17a310dcb6d9..4cbb845424f5 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3431,10 +3431,17 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper 
*dumper, bool syslog,
         /* actually read text into the buffer now */
         l = 0;
         while (prb_read_valid(prb, seq, &r)) {
+               size_t pr_len;
                 if (r.info->seq >= dumper->next_seq)
                         break;

-               l += record_print_text(&r, syslog, time);
+               if (null_char(r.text_buf, r.info->text_len))
+                       pr_crit("%s: pre record_print_text() a NULL char 
in record text_buf, l %zu, textlen %zu\n", __func__, l, r.info->text_len);
+               pr_len = record_print_text(&r, syslog, time);
+               l += pr_len;
+
+               if (null_char(r.text_buf, pr_len))
+                       pr_crit("%s: post record_print_text() a NULL 
char in record text_buf, l %zu, pr_len %zu\n", __func__, l, pr_len);

                 /* adjust record to store to remaining buffer space */
                 prb_rec_init_rd(&r, &info, buf + l, size - l);

(output during warm reboot)

[   12.400817] ramoops: ramoops_pstore_write: A NULL char in record buf, 
size 70648
[   12.408217] printk: kmsg_dump_get_buffer: pre record_print_text() a 
NULL char in record text_buf, l 65505, textlen 53
[   12.408219] printk: kmsg_dump_get_buffer: post record_print_text() a 
NULL char in record text_buf, l 65578, pr_len 73

As I replied to Kees last week, we will try to repro with 
modern/mainline kernel hopefully soon.

>
> I looks like some problems with counting data that fit into the
> buffer. I see that several fixes were added after 5.10 release.
> I wonder if they help to solve this:
>
> commit 89ccf18f032f26946 ("printk: fix kmsg_dump_get_buffer length calulations")
> commit f0e386ee0c0b71ea6 ("printk: fix buffer overflow potential for print_text()")
> commit 08d60e59995401105 ("printk: fix string termination for record_print_text()")

Above commit changes are already in v5.10.187 kernel where we are seeing 
the NULL characters in ramoops.

>
> All 3 commits were backported into 5.10 stable.
>
> The 2nd commit without the 3rd one might cause writing an extra "\0"
> into a wrong place.
>
>
>> On 8/3/23 16:34, Vijay Balakrishna wrote:
>>> Hello,
>>>
>>> We are noticing NULL characters in ramoops/pstore memory after a warm or
>>> a kexec reboot [1] in our 5.10 ARM64 product kernel after moving from
>>> 5.4 kernel.  I ruled out fs/pstore/* as the source from where NULL
>>> characters originate by adding debug code [2] and confirming from
>>> collected output [3].  Then isolated further to printk log/ring buffer
>>> area, the NULL characters were already present in buffer in
>>> kmsg_dump_get_buffer() when kmsg log lines are read.  After looking at
>>> printk merges in mainline kernel, I cherry-picked following which looked
>>> related to our 5.10 kernel and still see NULL characters.
>>>
>>>      4260e0e5510158d704898603331e5365ebe957de printk: consolidate
>>>      kmsg_dump_get_buffer/syslog_print_all code
>>>      726b5097701a8d46f5354be780e1a11fc4ca1187 printk: refactor
>>>      kmsg_dump_get_buffer()
>>>      bb07b16c44b2c6ddbafa44bb06454719002e828e printk: limit second loop
>>>      of syslog_print_all
> These commits tried to reduce a code duplication between kmsg_dump
> and syslog API.
>
>>> Looking at syslog_print_all() I notice it uses a local buffer unlike
>>> kmsg_dump_get_buffer() which manipulates buffer in-place to add syslog
>>> and timestamp prefix data.
> syslog_print_all() gets a buffer from userspace. It can be written
> only by copy_to_user(). It allocates an extra buffer so that it could
> do all the message formatting in the kernel space.
>
>> I made changes [4] to kmsg_dump_get_buffer()
>>> to use a local buffer similar to syslog_print_all() after which I don't
>>> see NULL characters in ramoops area.  I couldn't spot any suspicious
>>> code in record_print_text() where prefix data added in-place.  I'm
>>> reaching out to both pstore/ram and printk folks for comments. I can
>>> investigate/debug further with assistance and input from you.
> It is more safe with the extra buffer. It is always used only
> for one message. It is possible that the NULL character was
> also written in a wrong place there. But it did not affect
> the buffer passed to kmsg_dump_get_buffer().
>
> I hope that the above three commit fixing the length calculation
> and potential buffer overflow will fix this.
>
> Anyway, thanks a lot for debugging this and providing all the details.
Thanks,
VIjay
>
> Best Regards,
> Petr
