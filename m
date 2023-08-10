Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71737778455
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 01:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjHJXvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 19:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjHJXu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:50:59 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921B82D44
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 16:50:58 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bd0a0a6766so1387036a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 16:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691711458; x=1692316258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rO91v1L5zVqib+kgCRHzjT4CNKvDtWiSPUCnvDO3S/A=;
        b=lgyGE6ND2X1IGhX/u/6LrBFy7BycIdNkU02JJSUKJJoKvB2IIgruuKL9VQtx14w3G8
         rb+sWitXVuIwibZ1o+5nMm0+ALjB2GROf9jvsHPDQ3JeCmbWMnTWRqn/8+uHX9bY5Mex
         5mMQdRvaxhI5HPtANedjHZnXCQDgQaz83nXHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691711458; x=1692316258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rO91v1L5zVqib+kgCRHzjT4CNKvDtWiSPUCnvDO3S/A=;
        b=i9g5y5e4IE/Vbhdca+5QVeB5gUoCvRSdyjARIv+vmzpC3DnZGQBq13loM1XFh1ciG5
         J6uXvgNBne6Ug7SAfTjShaJ41AjVv8mM0MAxQpXs5+0DPxSkYIqdQYFfbLbDjVhv+4ih
         NkRIKgAtoTBz38UPIPqWNLBJ/ESnh8jqOE7O+VikNbjYJIY5EClgu/5IS9in5B1OFfSJ
         jxrPkXW9TXzWEjD/lUpLyoQdrWU1s+GOHvXWlpNh7gAFkXcE9oMi+P3yP+A3DxHf5EHp
         CxbA6X+2Aupn3rsLNb21QIRv3Fd/aBkEONDSP5dnUHYEpp48NpL0lc544gWoBtsYByuP
         DigA==
X-Gm-Message-State: AOJu0Yyt1/PENyltwZhnR61fSvR+QoeCEwxZfJ9Q21xChFI6UV9DDCFF
        ZyyhUCH3Ml0WXlU9331FBwbTaQ==
X-Google-Smtp-Source: AGHT+IHH4S2YCPPYvUVbQFieD3KNRGqhs9FtN12XMLqvDHcyG7If44pmkj1XFdiZMh6RkifD67l5dA==
X-Received: by 2002:a9d:6a96:0:b0:6bd:314:3e0b with SMTP id l22-20020a9d6a96000000b006bd03143e0bmr266509otq.27.1691711457910;
        Thu, 10 Aug 2023 16:50:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b001b0358848b0sm2359919plh.161.2023.08.10.16.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 16:50:57 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:50:56 -0700
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
Message-ID: <202308101649.337F4D8@keescook>
References: <f28990eb-03bc-2259-54d0-9f2254abfe62@linux.microsoft.com>
 <202308040053.7F38C6D@keescook>
 <0220f601-14f8-1dda-f057-73a608fbe62b@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0220f601-14f8-1dda-f057-73a608fbe62b@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 04:32:58PM -0700, Vijay Balakrishna wrote:
> On 8/4/23 00:59, Kees Cook wrote:
> > Is the issue present in modern kernels?
> 
> Yes, the issue present in mainline kernel, I can repro on a x86_64 VM with v6.5.0-rc5 kernel.
> 
> $ uname -a
> Linux vijay-vm3 6.5.0-rc5-ramoops #10 SMP PREEMPT_DYNAMIC Thu Aug 10 17:24:39 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
> $ cat /proc/cmdline
> BOOT_IMAGE=/boot/vmlinuz-6.5.0-rc5-ramoops root=UUID=xx ro mem=8188M ramoops.mem_address=0x2BFC00000 ramoops.mem_size=0x400000 ramoops.max_reason=5 ramoops.record_size=0x80000 console=tty1 console=ttyS0 earlyprintk=ttyS0 rootdelay=300
> 
> (excerpt from /var/lib/systemd/pstore/dmesg-ramoops-0 after warm reboot)
> <5>[    0.000000] Linux version 6.5.0-rc5-ramoops (vijay@vijay-vm1) (gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #10 SMP PREEMPT_DYNAMIC Thu Aug 10 17:24:39 UTC 2023
> ..
> <6>[    0.463984] Calibrating delay loop (skipped), value calculated using timer frequency.. ^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
> 
> (hex dump output)
> 
> 00003160  61 6c 63 75 6c 61 74 65  64 20 75 73 69 6e 67 20  |alculated using |
> 00003170  74 69 6d 65 72 20 66 72  65 71 75 65 6e 63 79 2e  |timer frequency.|
> 00003180  2e 20 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |. ..............|
> 00003190  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> 000031a0  00 0a 3c 36 3e 5b 20 20  20 20 30 2e 34 36 37 39  |..<6>[    0.4679|

Can you share the .config you're building with? And what are you using
to trigger an Oops? I will see if I can reproduce this...

-- 
Kees Cook
