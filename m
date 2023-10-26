Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403BF7D841F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345179AbjJZN7v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Oct 2023 09:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjJZN7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:59:47 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4EF1BD;
        Thu, 26 Oct 2023 06:59:44 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so666359276.0;
        Thu, 26 Oct 2023 06:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698328784; x=1698933584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20XxON5XilTKGJ9SIc8r5pwdKYtKKocsfNkQqf5x/4c=;
        b=cbmERCUbJVAVwi7Zw09fZCKC41emrIJ/q6zEkjNd4AB7WPBx1p3JIJE0aLPtKu1NmW
         CIBOkcXtYmSqQV7lcK7yrvgn8R9HPVZfFgpp+dVJEA+dhVnhMQ9fJ7csAUFmdduyUp9O
         28snVZO5SfJ5THEurfjZFDd7AT5joFTKipM125LNECLi1a/xtOp7TXPdc4M1+MBTfe8A
         16atRoT/0hegulgTStUFBgZ9aEfG/Rmbt1R/2DfzD+ecOotyJ+ep68d8W7vDCSDXd3GV
         Vz5AurDEbIQDoKA8Xh6kSlzdIpsEbo7PVzbGhKz3qTaAGc5qpxZ77yIE1qXJVueURly+
         OkbQ==
X-Gm-Message-State: AOJu0Yw32FjCGRyzxinJ3wCRqw0F/WmDRU8GvAWQKJNi5eo7H/VT7np2
        jjZhmHnM6r0V5OmfsdJ4By2DHVMeB+1/uA==
X-Google-Smtp-Source: AGHT+IFmIlZ9QCTk6uE4so3wg2spv6XHyYnYWc+a9V3sH9yScBc4exiHpBUBtVsE0xn1biQ1nmy+uA==
X-Received: by 2002:a25:cad6:0:b0:da0:4ee7:bd44 with SMTP id a205-20020a25cad6000000b00da04ee7bd44mr7847988ybg.5.1698328783738;
        Thu, 26 Oct 2023 06:59:43 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id u98-20020a25ab6b000000b00da0501b497asm2010057ybi.18.2023.10.26.06.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 06:59:42 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d9beb863816so654398276.1;
        Thu, 26 Oct 2023 06:59:41 -0700 (PDT)
X-Received: by 2002:a25:ef48:0:b0:d9b:4f28:4f7a with SMTP id
 w8-20020a25ef48000000b00d9b4f284f7amr19582865ybm.55.1698328781289; Thu, 26
 Oct 2023 06:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook>
 <20231020044645.GC11984@lst.de> <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
 <202310201127.DA7EDAFE4D@keescook> <20231026100148.GA26941@lst.de>
 <710149630eb010b18b69e161d02502bc3b648173.camel@HansenPartnership.com> <20231026095235.760f5546@gandalf.local.home>
In-Reply-To: <20231026095235.760f5546@gandalf.local.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Oct 2023 15:59:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV9CcjGkpF=FGe_U5XtbF08bKTEYkPSxArO1zBwnug0Wg@mail.gmail.com>
Message-ID: <CAMuHMdV9CcjGkpF=FGe_U5XtbF08bKTEYkPSxArO1zBwnug0Wg@mail.gmail.com>
Subject: Re: the nul-terminated string helper desk chair rearrangement
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Thu, Oct 26, 2023 at 3:52 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 26 Oct 2023 07:39:44 -0400
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>
> > While it's nice in theory to have everything documented, it's not much
> > use if no one can actually find the information ...
>
> Does kerneldoc provide an automated index? That is, if we had a single file
> that had every function in the kernel that is documented, with the path to
> the file that documents it, it would make finding documentation much
> simpler.
>
> Maybe it already does? Which would mean we need a way to find the index too!

ctags?

Although "git grep" is faster (assumed you use the "correct" search
pattern, which can sometimes be challenging, indeed).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
