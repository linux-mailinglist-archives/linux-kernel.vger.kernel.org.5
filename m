Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9130976FB8B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjHDH77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjHDH75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:59:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380051702
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 00:59:56 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bbff6b2679so12995245ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 00:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691135995; x=1691740795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O9Gcb+QDtSTT+tNrxhCWxJPsPV30mS5AUZDQJsHHC4s=;
        b=IoAZjC00BnFRG2TxI/YGBXZM+XqqgZ3hnKWejZgHB7aNAWjwo186hocmF7jX+4l8er
         xj9Gkp/TeSZTsslK3dAyVjqzkSgnZ/IVeENgShXd9QCgzE91ErIcTQNndiumXAtJQgOr
         +vrXWNgdAy+MVf/Pp2ZqhiLSBUrSV1LJzpHfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691135996; x=1691740796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9Gcb+QDtSTT+tNrxhCWxJPsPV30mS5AUZDQJsHHC4s=;
        b=IqtXKL2QXgTwwN3EIEN7e/ir87OrO388TLiWgG7KAACK7AEFNwqguT6K4iPpea8hBE
         dFd9urKNzG80+3YmPiDYZtzIw/6lxNrWS7mvBpOkc34DZT8Hrf3mh9r6y8M0sIxYR0OM
         5m7n4G4KX9RRgF7hLZDwNq8ziY+vVYjgczHJjq6zXE2uQ57WsFyS8OnBS/gUCY3W4+20
         2CbSNECnVSz+EGYf0Xa1RFlyq3NEhvzmjCstl75xDwJshNKdHHm0v/8+ExeT35mrqUcR
         1YT+CA/HThfGGRzBxkxaYDL9/VKtVhvwqbeBbZtNQ6p93XbpfvJHFU6ZzkDBggdeROn4
         fpEg==
X-Gm-Message-State: AOJu0YxtLsRxl6auycay4OZ8curtWmZqWCsBbOeAcbs14Z2DNtZNghIh
        Lfy4wUo/GujfW/jyZg28BYKPHw==
X-Google-Smtp-Source: AGHT+IHQU8oawqqvi5y8u+MMjLWlbxUnrI9mvTQCGsv987U85hgsaxgLUeltMRH9QKy6jGgwxbloJw==
X-Received: by 2002:a17:902:c103:b0:1b1:753a:49ce with SMTP id 3-20020a170902c10300b001b1753a49cemr741796pli.53.1691135995649;
        Fri, 04 Aug 2023 00:59:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a2-20020a1709027d8200b001bc39aa63ebsm1102101plm.121.2023.08.04.00.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 00:59:54 -0700 (PDT)
Date:   Fri, 4 Aug 2023 00:59:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: pstore/ram: printk: NULL characters in pstore ramoops area
Message-ID: <202308040053.7F38C6D@keescook>
References: <f28990eb-03bc-2259-54d0-9f2254abfe62@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f28990eb-03bc-2259-54d0-9f2254abfe62@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 04:34:09PM -0700, Vijay Balakrishna wrote:
> Hello,
> 
> We are noticing NULL characters in ramoops/pstore memory after a warm or a
> kexec reboot [1] in our 5.10 ARM64 product kernel after moving from 5.4
> kernel.  I ruled out fs/pstore/* as the source from where NULL characters
> originate by adding debug code [2] and confirming from collected output
> [3].  Then isolated further to printk log/ring buffer area, the NULL
> characters were already present in buffer in kmsg_dump_get_buffer() when
> kmsg log lines are read.  After looking at printk merges in mainline kernel,
> I cherry-picked following which looked related to our 5.10 kernel and still
> see NULL characters.
> 
>    4260e0e5510158d704898603331e5365ebe957de printk: consolidate
>    kmsg_dump_get_buffer/syslog_print_all code
>    726b5097701a8d46f5354be780e1a11fc4ca1187 printk: refactor
>    kmsg_dump_get_buffer()
>    bb07b16c44b2c6ddbafa44bb06454719002e828e printk: limit second loop
>    of syslog_print_all

Do you mean that you took a working v5.4 kernel and backported the above
3 commits and it starting showing the %NUL characters?

> [...]
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
> +        pr_crit("%s: A NULL char in record buf, size %zu\n", __func__,
> size);
> +    else
> +        pr_crit("%s: No NULL char in record buf, size %zu\n", __func__,
> size);
>      persistent_ram_write(prz, record->buf, size);
> [...]
> root@localhost:~# reboot
> [ 2188.073362] systemd-shutdown[1]: Could not detach loopback /dev/loop1: Device or resource busy
> [ 2188.082272] systemd-shutdown[1]: Could not detach loopback /dev/loop0: Device or resource busy
> [ 2188.091873] watchdog: watchdog0: watchdog did not stop!
> [ 2188.099227] systemd-shutdown[1]: Failed to finalize loop devices, DM devices, ignoring.
> [ 2188.306671] reboot: Restarting system
> [ 2188.316932] ramoops: ramoops_pstore_write: A NULL char in record buf, size 88190

Well that does seem pretty definitive that it's a problem with the
printk/kmsg infrastructure: the %NULs are present in the buffer being
handed to pstore. :(

I have had a growing suspicion that there is a hard-to-find memory
corruption issue with recent printk work (seen during early-boot UBSAN
reporting), but v5.10 is pretty old, so it's probably not related.

Is the issue present in modern kernels?

-Kees

-- 
Kees Cook
