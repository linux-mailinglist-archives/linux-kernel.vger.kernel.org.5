Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C637AD8AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjIYNN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjIYNN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:13:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C0783
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:13:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a64619d8fbso803651166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695647628; x=1696252428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1lwODLqUWlwVEvdiGIdLnyDf2x4p+uZT2UEpf4goid8=;
        b=Ov6jBBUGS6sz7LIqW+HTOsWvi1ubbU4C/zz0wJGiS4PxDxnqtvQBnolIAjMqZdueE3
         7KI8s6lSR2AdOiFjEre4JxlqvSFSEV4no+/v0i09WT1mPggR5PrhQExV/h1dliJG/l8m
         MlqI9w8OsrteEwbHMptTLxnAQaV6RltTbyobk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647628; x=1696252428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lwODLqUWlwVEvdiGIdLnyDf2x4p+uZT2UEpf4goid8=;
        b=obMD0FPtSOBeLetR6uJV7/5l9Lyn8XyV3W0JbcAmCG0aK4kX2U33WgA5ATLtvqDX2f
         G0/yEt0L/yvpI5BZLnrU4xTjaw8Tv7spVJJ9CkU4/sP7Nzdr2Shcyu8M3HvGxgsTjhY7
         kkz5eA+3mOfum+fDYYEmF9wksohDw+XoBVtc/1wSrYDIfFqBtVIyLfHxPJPOJh6PxZxd
         dOtoXlZ5vguch+pLHBU5iROZrqZK/Md0h8sqma5HC0i5HPavQzOg4k8kotgRPbWq0KN1
         ZWtGLfDH/S6VlCrKPezn3F13q9LBAIvC2hzzc8+bqNe+/BTx8tPQRZuf07Fny5fqARtZ
         bGWw==
X-Gm-Message-State: AOJu0YzIYEQlLEfaZWEBE/IAqlOpmVbKsyFxwLxntPKU2ZbL5nm8qSOY
        omWVOj9FdCnvpv0NsreWUE9sX5dignpLKTaqy37PYw==
X-Google-Smtp-Source: AGHT+IEaXC/MYFZc4Bs5n3km4WhW9nw/fElld1jUd7ViCoEE1UUfeMqKg4Zf45Aei2NXQvMUI8enGkZMqnsqJil51lg=
X-Received: by 2002:a17:906:97:b0:9a9:f042:dec0 with SMTP id
 23-20020a170906009700b009a9f042dec0mr5718418ejc.38.1695647628061; Mon, 25 Sep
 2023 06:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
 <44631c05-6b8a-42dc-b37e-df6776baa5d4@app.fastmail.com> <20230925-total-debatten-2a1f839fde5a@brauner>
In-Reply-To: <20230925-total-debatten-2a1f839fde5a@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 25 Sep 2023 15:13:36 +0200
Message-ID: <CAJfpegvUCoKebYS=_3eZtCH49nObotuWc=_khFcHshKjRG8h6Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sept 2023 at 15:04, Christian Brauner <brauner@kernel.org> wrote:
>
> On Mon, Sep 25, 2023 at 02:57:31PM +0200, Arnd Bergmann wrote:
> > On Wed, Sep 13, 2023, at 17:22, Miklos Szeredi wrote:
> >
> > >  asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz,
> > >                             struct statfs64 __user *buf);
> > > +asmlinkage long sys_statmnt(u64 mnt_id, u64 mask,
> > > +                       struct statmnt __user *buf, size_t bufsize,
> > > +                       unsigned int flags);
> >
> > This definition is problematic on 32-bit architectures for two
> > reasons:
> >
> > - 64-bit register arguments are passed in pairs of registers
> >   on two architectures, so anything passing those needs to
> >   have a separate entry point for compat syscalls on 64-bit
> >   architectures. I would suggest also using the same one on
> >   32-bit ones, so you don't rely on the compiler splitting
> >   up the long arguments into pairs.
> >
> > - There is a limit of six argument registers for system call
> >   entry points, but with two pairs and three single registers
> >   you end up with seven of them.
> >
> > The listmnt syscall in patch 3 also has the first problem,
> > but not the second.
>
> Both fields could also just be moved into the struct itself just like we
> did for clone3() and others.

Let's not mix in and out args, please.

How about passing u64 *?

Thanks,
Miklos
