Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A17B778429
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 01:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjHJXdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 19:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjHJXdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:33:00 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AD1A270F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 16:33:00 -0700 (PDT)
Received: from [192.168.5.50] (cpe-70-95-196-11.san.res.rr.com [70.95.196.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id 43F5720FD033;
        Thu, 10 Aug 2023 16:32:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 43F5720FD033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691710379;
        bh=ov3NO3yrqYr7MU/l8ey9b+fjUsUIWDCGKGu98X/flZg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nOGj6L0sfl/pkGsiCmKEZHnaaoiDE0LFGAzBVOGUww/HrZFFWimxCdGnF7IgW7782
         txihertVBXFqdxfelbA5A8Ic8Fg3cJp8J9iBKg2ZG7Slk9G8pG5bfZAkX6R1dj3del
         KxWjO9MkNJFTybp9XjA08gHSsPw91t+xCu07AB/I=
Message-ID: <0220f601-14f8-1dda-f057-73a608fbe62b@linux.microsoft.com>
Date:   Thu, 10 Aug 2023 16:32:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: pstore/ram: printk: NULL characters in pstore ramoops area
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        linux-kernel@vger.kernel.org
References: <f28990eb-03bc-2259-54d0-9f2254abfe62@linux.microsoft.com>
 <202308040053.7F38C6D@keescook>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
In-Reply-To: <202308040053.7F38C6D@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/23 00:59, Kees Cook wrote:
> Is the issue present in modern kernels?

Yes, the issue present in mainline kernel, I can repro on a x86_64 VM with v6.5.0-rc5 kernel.

$ uname -a
Linux vijay-vm3 6.5.0-rc5-ramoops #10 SMP PREEMPT_DYNAMIC Thu Aug 10 17:24:39 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
$ cat /proc/cmdline
BOOT_IMAGE=/boot/vmlinuz-6.5.0-rc5-ramoops root=UUID=xx ro mem=8188M ramoops.mem_address=0x2BFC00000 ramoops.mem_size=0x400000 ramoops.max_reason=5 ramoops.record_size=0x80000 console=tty1 console=ttyS0 earlyprintk=ttyS0 rootdelay=300

(excerpt from /var/lib/systemd/pstore/dmesg-ramoops-0 after warm reboot)
<5>[    0.000000] Linux version 6.5.0-rc5-ramoops (vijay@vijay-vm1) (gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #10 SMP PREEMPT_DYNAMIC Thu Aug 10 17:24:39 UTC 2023
..
<6>[    0.463984] Calibrating delay loop (skipped), value calculated using timer frequency.. ^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@

(hex dump output)

00003160  61 6c 63 75 6c 61 74 65  64 20 75 73 69 6e 67 20  |alculated using |
00003170  74 69 6d 65 72 20 66 72  65 71 75 65 6e 63 79 2e  |timer frequency.|
00003180  2e 20 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |. ..............|
00003190  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
000031a0  00 0a 3c 36 3e 5b 20 20  20 20 30 2e 34 36 37 39  |..<6>[    0.4679|
