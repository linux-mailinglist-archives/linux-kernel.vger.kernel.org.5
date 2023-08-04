Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C7077065A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjHDQxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjHDQxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:53:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9907149EF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:53:13 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-26825239890so1548281a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691167993; x=1691772793;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+lD1WVEjbJSJyr+7Zg5cIw3J9zEU5PIJwcQkpCZjT6w=;
        b=dOn2TGercKKPlikUlMZx/Ju0+fsu4kYgNIVVFl0Ltbqal4d3VCRenYTlWv9Q09pMOI
         AFNfdbe3vz0UpQffi6hjv/T94Mwn9r6aR8XM19yd9NnrMXDUKz4jkKdj0i2/MPtFiEgE
         MeR1DZOd9InisscoQ+mcxozV8I6m4pp8ryaco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691167993; x=1691772793;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+lD1WVEjbJSJyr+7Zg5cIw3J9zEU5PIJwcQkpCZjT6w=;
        b=LFAkA3J5iKpFdhD9FrgEc6asBTypLoYqEJrcrSgrJjObuhRjFgbpb96wHIbCCcWFgs
         xZywrndpu5P/NqWIGlLCi3A3+r/mvp+bpQdZhZeX0Ml1EqfmLcf2SsgBQsemMOvzFjRa
         mLIEparqIMrP8rl6oH1pwwdWc7ht/2ghycnqHl7BA+CyH2j79o/r213H0TIBq69Kv6Fk
         kOpTYsWZWS3dQb1i8xJ0s2540aatpHym7qAqVJpsy1gS03+2NQYvFk7aqCG5rwnWD3gX
         PJ5IF1zj7oa6brvJZDdh1Sj8b5tzxubRana/Lz6fEEGT+imJTzK6irBf4fIoTUaG1Bco
         wubQ==
X-Gm-Message-State: AOJu0YwVSCwwvmUM8sX8d0CzH1xRFwkqax90U1jLb70zkiq4tUa9Erhe
        rTeXnoRTAhUpUEJLfuRSu/MLBQ==
X-Google-Smtp-Source: AGHT+IHeFWhSUA9TJ9b4SmzlK4Rl7RtxhX7PWfc6fXIq/EmL/6ufVS/v2JdRETL/EJsge8HzyS5grA==
X-Received: by 2002:a17:90a:3de5:b0:268:2621:6a41 with SMTP id i92-20020a17090a3de500b0026826216a41mr2404703pjc.45.1691167992984;
        Fri, 04 Aug 2023 09:53:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902da8700b001bb889530adsm1972313plx.217.2023.08.04.09.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 09:53:12 -0700 (PDT)
Date:   Fri, 4 Aug 2023 09:53:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     yunlong xing <yunlongxing23@gmail.com>
Cc:     Yunlong Xing <yunlong.xing@unisoc.com>, tony.luck@intel.com,
        gpiccoli@igalia.com, joel@joelfernandes.org, enlin.mu@unisoc.com,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        enlinmu@gmail.com
Subject: Re: [PATCH 1/1] pstore/ram: Check member of buffers during the
 initialization phase of the pstore
Message-ID: <202308040948.ABF3EBDAEF@keescook>
References: <20230801060432.1307717-1-yunlong.xing@unisoc.com>
 <202308040103.1514A8C3CB@keescook>
 <CA+3AYtRYNQKuM9-99LvZYZqraLokKV4bjuvYKyEPB3MG7+VevA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+3AYtRYNQKuM9-99LvZYZqraLokKV4bjuvYKyEPB3MG7+VevA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 04:59:07PM +0800, yunlong xing wrote:
> On Fri, Aug 4, 2023 at 4:10 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Aug 01, 2023 at 02:04:32PM +0800, Yunlong Xing wrote:
> > > From: Enlin Mu <enlin.mu@unisoc.com>
> > >
> > > The commit 30696378f68a("pstore/ram: Do not treat empty buffers as valid")
> > > would introduce the following issue:
> > >
> > > When finding the buffer_size is zero, it would return directly.However, at
> > > the same time, if the buffer's start is a illegal value, the others would
> > > panic if access the buffer.
> >
> > Which "others" do you mean?
> 
> About “others", You can refer to the following panic call stack:
>  sysdump_panic_event+0x720/0xd38
>  atomic_notifier_call_chain+0x58/0xc0
>  panic+0x1c4/0x6e4
>  die+0x3c0/0x428
>  bug_handler+0x4c/0x9c
>  brk_handler+0x98/0x14c
>  do_debug_exception+0x114/0x2ec
>  el1_dbg+0x18/0xbc
>  usercopy_abort+0x90/0x94
>  __check_object_size+0x17c/0x2c4
>  persistent_ram_update_user+0x50/0x220
>  persistent_ram_write_user+0x354/0x428
>  ramoops_pstore_write_user+0x34/0x50
>  write_pmsg+0x14c/0x26c

I see -- the "start" is corrupted and out of bounds, which leads to
these accesses.

>  do_iter_write+0x1cc/0x2cc
>  vfs_writev+0xf4/0x168
>  do_writev+0xa4/0x200
>  __arm64_sys_writev+0x20/0x2c
>  el0_svc_common+0xc8/0x22c
>  el0_svc_handler+0x1c/0x28
>  el0_svc+0x8/0x100
> >
> > > To avoid these happenning, check if the members are legal during the
> > > initialization phase of the pstore.
> > >
> > > Fixes: 30696378f68a ("pstore/ram: Do not treat empty buffers as valid")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
> > > ---
> > >  fs/pstore/ram_core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> > > index 85aaf0fc6d7d..eb6df190d752 100644
> > > --- a/fs/pstore/ram_core.c
> > > +++ b/fs/pstore/ram_core.c
> > > @@ -519,7 +519,7 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
> > >       sig ^= PERSISTENT_RAM_SIG;
> > >
> > >       if (prz->buffer->sig == sig) {
> > > -             if (buffer_size(prz) == 0) {
> > > +             if (buffer_size(prz) == 0 && buffer_start(prz) == 0) {
> > >                       pr_debug("found existing empty buffer\n");
> > >                       return 0;
> > >               }
> >
> > And in the case of "buffer_size(prz) == 0" but "buffer_start(prz) != 0",
> > this will be caught by:
> >
> >                 if (buffer_size(prz) > prz->buffer_size ||
> >                     buffer_start(prz) > buffer_size(prz)) {
> >                         pr_info("found existing invalid buffer, size %zu, start %zu\n",
> >                                 buffer_size(prz), buffer_start(prz));
> >                         zap = true;
> >                 }
> >
> > i.e. it will be detected and zapped back to a sane state.
> No,This code has no chance of execution because there was a return 0 before it

Right, I meant the behavior with your patch -- with your patch the case
of "size == 0 && start != 0" would be caught by the above check ("start > size")
and zapped back to sanity. (Which is the correct result.)

> >
> > That sounds correct to me, though I wonder if reporting it as an
> > "invalid buffer" is inaccurate? Perhaps we should have a separate case:
> >
> >                 if (buffer_size(prz) == 0) {
> >                         if (buffer_start(prz) == 0)
> >                                 pr_debug("found existing empty buffer\n");
> >                         else {
> >                                 pr_debug("found existing empty buffer with non-zero start\n");
> >                                 zap = true;
> >                         }
> >                 } else if ...
> >
> > What do you think?
> Good, I gree it. For me, it should not return directly while finding
> the buffer_size is zero, We need Check others case.

Right. The only question I have is: how did the "start" get corrupted,
and is that a notable condition? Right now we don't (info-level) log
a size==0 prz since that's an expected state for a regular initialized
prz. So maybe your patch is correct as-is since we'd want to report the
"found existing invalid buffer" case.

> So does the modification method you mentioned require me to resubmit a
> patch or do you need to modify and merge it

I think I'll update the commit log and take this as-is. If the logging
becomes too noisy, we can adjust the case later.

Thanks!

-- 
Kees Cook
