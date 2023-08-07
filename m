Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CB9772C9F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjHGRTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjHGRTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:19:18 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D512D1FFD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:19:09 -0700 (PDT)
Received: from [192.168.5.46] (cpe-70-95-196-11.san.res.rr.com [70.95.196.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id B45F22086958;
        Mon,  7 Aug 2023 10:19:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B45F22086958
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691428749;
        bh=P2zcDbRssAQel0I945bJZHWxOtzGWyvCUw0XG6yGctI=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=OX6DTaAJevnQitYVPmJi0DY0a8dZM7vTxDgIMsXLa6R1JrAkEPGf4vexxZZwPFxJV
         qy9Kyq33ikteuoaAXHxyJqal/J3oJeE82Led+UXDpgDMAFncbU6dzjH0SBOh2rMEKe
         gQTkWzqYbC2iEzSsv10GR76A/UGtbcqI6czABDQA=
Message-ID: <d8bb1ec7-a4c5-43a2-9de0-9643a70b899f@linux.microsoft.com>
Date:   Mon, 7 Aug 2023 10:19:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: pstore/ram: printk: NULL characters in pstore ramoops area
Content-Language: en-US
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>
Cc:     linux-kernel@vger.kernel.org
References: <f28990eb-03bc-2259-54d0-9f2254abfe62@linux.microsoft.com>
In-Reply-To: <f28990eb-03bc-2259-54d0-9f2254abfe62@linux.microsoft.com>
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

I'm including my earlier email as it didn't deliver to 
linux-kernel@vger.kernel.org due to HTML subpart.  Also sharing new 
findings --

Limiting the size of buffer exposed to record_print_text() and 
prb_for_each_record() in kmsg_dump_get_buffer() also resolves this issue 
[5] -- no NULL characters in pstore/ramoops memory.  The advantage is no 
memory allocation (as done in previously shared changes [4]) which could 
be problematic during kernel shutdown/reboot or during kexec reboot.

[5]

Author: Vijay Balakrishna <vijayb@linux.microsoft.com>
Date:   Sat Aug 5 18:47:27 2023 +0000

     printk: limit the size of buffer exposed to record_print_text() by 
kmsg_dump_get_buffer()

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b82e4c3b52f4..8feec932aa35 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3453,9 +3453,9 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper 
*dumper, bool syslog,
          */
         next_seq = seq;

-       prb_rec_init_rd(&r, &info, buf, size);

         len = 0;
+       prb_rec_init_rd(&r, &info, buf + len, (size - len) >= 
LOG_LINE_MAX + PREFIX_MAX ? LOG_LINE_MAX + PREFIX_MAX : size - len);
         prb_for_each_record(seq, prb, seq, &r) {
                 if (r.info->seq >= dumper->next_seq)
                         break;
@@ -3463,7 +3463,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper 
*dumper, bool syslog,
                 len += record_print_text(&r, syslog, time);

                 /* Adjust record to store to remaining buffer space. */
-               prb_rec_init_rd(&r, &info, buf + len, size - len);
+               prb_rec_init_rd(&r, &info, buf + len, (size - len) >= 
LOG_LINE_MAX + PREFIX_MAX ? LOG_LINE_MAX + PREFIX_MAX : size - len);
         }

         dumper->next_seq = next_seq;

On 8/3/23 16:34, Vijay Balakrishna wrote:
>
> Hello,
>
> We are noticing NULL characters in ramoops/pstore memory after a warm 
> or a kexec reboot [1] in our 5.10 ARM64 product kernel after moving 
> from 5.4 kernel.  I ruled out fs/pstore/* as the source from where 
> NULL characters originate by adding debug code [2] and confirming from 
> collected output [3].  Then isolated further to printk log/ring buffer 
> area, the NULL characters were already present in buffer in 
> kmsg_dump_get_buffer() when kmsg log lines are read.  After looking at 
> printk merges in mainline kernel, I cherry-picked following which 
> looked related to our 5.10 kernel and still see NULL characters.
>
>     4260e0e5510158d704898603331e5365ebe957de printk: consolidate
>     kmsg_dump_get_buffer/syslog_print_all code
>     726b5097701a8d46f5354be780e1a11fc4ca1187 printk: refactor
>     kmsg_dump_get_buffer()
>     bb07b16c44b2c6ddbafa44bb06454719002e828e printk: limit second loop
>     of syslog_print_all
>
> Looking at syslog_print_all() I notice it uses a local buffer unlike 
> kmsg_dump_get_buffer() which manipulates buffer in-place to add syslog 
> and timestamp prefix data.  I made changes [4] to 
> kmsg_dump_get_buffer() to use a local buffer similar to 
> syslog_print_all() after which I don't see NULL characters in ramoops 
> area.  I couldn't spot any suspicious code in record_print_text() 
> where prefix data added in-place.  I'm reaching out to both pstore/ram 
> and printk folks for comments. I can investigate/debug further with 
> assistance and input from you.
>
> Note:
>
> - NULL characters show up starting at same offset 0x00010006, but #of 
> NULL characters varies between reboots
>
> - I have removed pstore compression related kernel configs and using 
> dyndbg config for investigation
>
> - NULL characters are replacing some actual data
>
> Thanks for your time.
>
> Vijay
>
> ++++++++++++++++++++++++++++++++++++++++++
>
> [1]
>
> root@localhost:~# od -c /var/lib/systemd/pstore/dmesg-ramoops-0
> 0000000    S   h   u   t   d   o   w   n   #   1       P   a r   t   1
> 0000020   \n   <   6   >   [                   0   . 0   0   0   0   0
> ..
> 0177520    .  \n   <   5   >   [       2   1   8   7 .   1   1   1   7
> 0177540    1   8   ]       a   u   d   i   t   :       t   y p   e   =
> 0177560    1   1   3   1       a   u   d   i   t   (   1   6 9   0   9
> 0177600    1   1   0   4   4   .   5   6   0   :   1   7   3 )   :
> 0177620    p   i   d   =   1       u   i   d   =   0       a u   i   d
> 0177640    =   4   2   9   4   9   6   7   2   9   5       s e   s   =
> 0177660    4   2   9   4   9   6   7   2   9   5       s   u b   j   =
> 0177700    s   y   s   t   e   m   _   u   :   s   y   s   t e   m   _
> 0177720    r   :   i   n   i   t   _   t       m   s   g   = '   u   n
> 0177740    i   t   =   x   x   x   x   x   x   x   x   -   e n   m   d
> 0177760    -   o   w   n   e   r   s   h   i   p       c   o m   m   =
> 0200000    "   s   y   s   t   e  \0  \0  \0  \0  \0  \0  \0 \0  \0  \0
> 0200020   \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0 \0  \0  \0
> *
> 0200120   \0  \0  \n   <   3   0   >   [       2   1 8   7   .   1   1
> 0200140    1   9   0   5   ]       s   y   s   t   e   m   d [   1   ]
> ..
> root@localhost:~#
>
> root@localhost:~# hexdump -C /var/lib/systemd/pstore/dmesg-ramoops-0
> 00000000  53 68 75 74 64 6f 77 6e  23 31 20 50 61 72 74 31 |Shutdown#1 
> Part1|
> 00000010  0a 3c 36 3e 5b 20 20 20  20 30 2e 30 30 30 30 30 |.<6>[    
> 0.00000|
> ..
> 0000ff50  2e 0a 3c 35 3e 5b 20 32  31 38 37 2e 31 31 31 37 |..<5>[ 
> 2187.1117|
> 0000ff60  31 38 5d 20 61 75 64 69  74 3a 20 74 79 70 65 3d |18] audit: 
> type=|
> 0000ff70  31 31 33 31 20 61 75 64  69 74 28 31 36 39 30 39 |1131 
> audit(16909|
> 0000ff80  31 31 30 34 34 2e 35 36  30 3a 31 37 33 29 3a 20 
> |11044.560:173): |
> 0000ff90  70 69 64 3d 31 20 75 69  64 3d 30 20 61 75 69 64 |pid=1 
> uid=0 auid|
> 0000ffa0  3d 34 32 39 34 39 36 37  32 39 35 20 73 65 73 3d 
> |=4294967295 ses=|
> 0000ffb0  34 32 39 34 39 36 37 32  39 35 20 73 75 62 6a 3d |4294967295 
> subj=|
> 0000ffc0  73 79 73 74 65 6d 5f 75  3a 73 79 73 74 65 6d 5f 
> |system_u:system_|
> 0000ffd0  72 3a 69 6e 69 74 5f 74  20 6d 73 67 3d 27 75 6e |r:init_t 
> msg='un|
> 0000ffe0  69 74 3d xx xx xx xx xx  xx xx xx 2d 65 6e 6d 64 
> |it=xxxxxxxx-enmd|
> 0000fff0  2d 6f 77 6e 65 72 73 68  69 70 20 63 6f 6d 6d 3d |-ownership 
> comm=|
> 00010000  22 73 79 73 74 65 00 00  00 00 00 00 00 00 00 00 
> |"syste..........|
> 00010010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 
> |................|
> *
> 00010050  00 00 0a 3c 33 30 3e 5b  20 32 31 38 37 2e 31 31 |...<30>[ 
> 2187.11|
> ..
> root@localhost:~#
>
> ++++++++++++++++++++++++++++++++++++++++++
>
> [2]
>
>     ramoops: pstore: detect NULL char
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index ade66dbe5f39..1825972151b2 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -383,6 +383,10 @@ static int notrace ramoops_pstore_write(struct 
> pstore_record *record)
>      size = record->size;
>      if (size + hlen > prz->buffer_size)
>          size = prz->buffer_size - hlen;
> +    if (null_char(record->buf, size))
> +        pr_crit("%s: A NULL char in record buf, size %zu\n", 
> __func__, size);
> +    else
> +        pr_crit("%s: No NULL char in record buf, size %zu\n", 
> __func__, size);
>      persistent_ram_write(prz, record->buf, size);
>
>      cxt->dump_write_cnt = (cxt->dump_write_cnt + 1) % cxt->max_dump_cnt;
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index a7630c2fea18..fafbccbfceea 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -272,10 +272,22 @@ ssize_t persistent_ram_ecc_string(struct 
> persistent_ram_zone *prz,
>      return ret;
>  }
>
> +bool null_char(const void *s, size_t count)
> +{
> +    char *p = (char *)s;
> +
> +    while (count--) {
> +        if (*p++ == '\0')
> +            return true;
> +    }
> +    return false;
> +}
> +
>  static void notrace persistent_ram_update(struct persistent_ram_zone 
> *prz,
>      const void *s, unsigned int start, unsigned int count)
>  {
>      struct persistent_ram_buffer *buffer = prz->buffer;
> +
>      memcpy_toio(buffer->data + start, s, count);
>      persistent_ram_update_ecc(prz, start, count);
>  }
> @@ -309,6 +321,11 @@ void persistent_ram_save_old(struct 
> persistent_ram_zone *prz)
>      }
>
>      prz->old_log_size = size;
> +
> +    if (null_char(&buffer->data[start], size - start) ||
> +        null_char(&buffer->data[0], start))
> +        pr_debug("%s: A NULL char in prz buffer\n", __func__);
> +
>      memcpy_fromio(prz->old_log, &buffer->data[start], size - start);
>      memcpy_fromio(prz->old_log + size - start, &buffer->data[0], start);
>  }
> diff --git a/fs/pstore/ram_internal.h b/fs/pstore/ram_internal.h
> index 5f694698351f..d0fd15a6f7af 100644
> --- a/fs/pstore/ram_internal.h
> +++ b/fs/pstore/ram_internal.h
> @@ -96,3 +96,4 @@ void *persistent_ram_old(struct persistent_ram_zone 
> *prz);
>  void persistent_ram_free_old(struct persistent_ram_zone *prz);
>  ssize_t persistent_ram_ecc_string(struct persistent_ram_zone *prz,
>      char *str, size_t len);
> +bool null_char(const void *s, size_t count);
>
> ++++++++++++++++++++++++++++++++++++++++++
>
> [3]
>
> root@localhost:~# reboot
> [ 2188.073362] systemd-shutdown[1]: Could not detach loopback 
> /dev/loop1: Device or resource busy
> [ 2188.082272] systemd-shutdown[1]: Could not detach loopback 
> /dev/loop0: Device or resource busy
> [ 2188.091873] watchdog: watchdog0: watchdog did not stop!
> [ 2188.099227] systemd-shutdown[1]: Failed to finalize loop devices, 
> DM devices, ignoring.
> [ 2188.306671] reboot: Restarting system
> [ 2188.316932] ramoops: ramoops_pstore_write: A NULL char in record 
> buf, size 88190
>
> (post reboot)
>
> root@localhost:~# dmesg | grep -e ramoops -e pstore
> ..
> [    0.331540] ramoops 22b4000000.ramoops: using Device Tree
> [    0.331560] ramoops: found existing buffer, size 88214, start 88214
> [    0.339972] ramoops: persistent_ram_save_old: A NULL char in prz buffer
> [    0.340775] ramoops: attached ramoops:dmesg(0/7) 
> 0x80000@0x22b4000000: 12 header, 524276 data, 0 ecc (0/0)
> [    0.340789] ramoops: found existing empty buffer
> [    0.340792] ramoops: attached ramoops:dmesg(1/7) 
> 0x80000@0x22b4080000: 12 header, 524276 data, 0 ecc (0/0)
> ..
> [    0.340880] ramoops: found existing empty buffer
> [    0.340882] ramoops: attached ramoops:dmesg(7/7) 
> 0x80000@0x22b4380000: 12 header, 524276 data, 0 ecc (0/0)
> [    0.341012] pstore: Registered ramoops as persistent store backend
> [    0.341014] ramoops: using 0x400000@0x22b4000000, ecc: 0
> [    1.164640]     dyndbg=file fs/pstore/* +p
> [    1.488770] ramoops: persistent_ram_save_old: A NULL char in prz buffer
> root@localhost:~#
>
> root@localhost:~# ls -l /var/lib/systemd/pstore/dmesg-ramoops-0
> -rw-------    1 root     root         88190 Aug  1 17:30 
> /var/lib/systemd/pstore/dmesg-ramoops-0
> root@localhost:~#
>
> (copy and paste of the line with NULL characters from dmesg-ramoops-o 
> file from a vi session)
> <5>[ 2187.111718] audit: type=1131 audit(1690911044.560:173): pid=1 
> uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t 
> msg='unit=xxxxxxxx-enmd-ownership 
> comm="syste^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
>
> ++++++++++++++++++++++++++++++++++++++++++
>
> [4]
>
> Author: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Date:   Thu Aug 3 17:23:32 2023 +0000
>
>     printk: use local buffer in kmsg_dump_get_buffer()
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index b82e4c3b52f4..19080cb6c557 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3420,6 +3420,11 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper 
> *dumper, bool syslog,
>         size_t len = 0;
>         bool ret = false;
>         bool time = printk_time;
> +       char *text;
> +
> +       text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
> +       if (!text)
> +               return ret;
>
>         if (!dumper->active || !buf || !size)
>                 goto out;
> @@ -3453,17 +3458,18 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper 
> *dumper, bool syslog,
>          */
>         next_seq = seq;
>
> -       prb_rec_init_rd(&r, &info, buf, size);
> +       prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX);
>
>         len = 0;
>         prb_for_each_record(seq, prb, seq, &r) {
> +               size_t textlen;
> +
>                 if (r.info->seq >= dumper->next_seq)
>                         break;
>
> -               len += record_print_text(&r, syslog, time);
> -
> -               /* Adjust record to store to remaining buffer space. */
> -               prb_rec_init_rd(&r, &info, buf + len, size - len);
> +               textlen = record_print_text(&r, syslog, time);
> +               memcpy(buf + len, text, textlen);
> +               len += textlen;
>         }
>
>         dumper->next_seq = next_seq;
> @@ -3472,6 +3478,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper 
> *dumper, bool syslog,
>  out:
>         if (len_out)
>                 *len_out = len;
> +       kfree(text);
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
>
