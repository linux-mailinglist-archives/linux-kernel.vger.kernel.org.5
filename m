Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A96788F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 22:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjHYUAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 16:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjHYT7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:59:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B5A2686
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:59:44 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c0d5b16aacso8619225ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692993584; x=1693598384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hfXkR3py3xtzGZ5E6zKDB+YU9brHzHocVu0CVwLEnrY=;
        b=XNozGOYo4jJxuS0aorG33UfKcAc0XsA7KLZJCCnywdJilpUEr8P22OOiqTR9NkfCp0
         HMXK64rExV/OJPyjrj7HqLM07ScILWwI+ImqSCq1DVLoZH5UfFhi9Gm3pbRwzoesP16J
         NzQyxOAr3kkaLkmmQBjKoPTFODx0sd7a9Eb88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692993584; x=1693598384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfXkR3py3xtzGZ5E6zKDB+YU9brHzHocVu0CVwLEnrY=;
        b=Td/9xZ9Ag9qze56m++lkZPeSoPmfcHEMD09ZpN+hyDYpdr/rDOLJPoRWyy93SwOEfL
         HJF8ep/xoZiaHFDW6gUf+Q/s23WmI3yDGZ8wzlutmqgQad49IHgSdn3bqS/oMVEt8GFQ
         eSBwOhrwhivJ9WrGD8boC3bGKTvRPxKfNHtyXDynWVJy9QDsDtxJk9S7OzJh3j+kYa0Q
         GL4VLIaKUMamPJTTA5ul5EB6d6OCdOIAb6qlgqBKEGVd8szojttyJx2YF+N2ZZLQJtci
         Ot0in+EQiP1gTy70/Pm5esHSibk3JtIvWV6jc/l8knShiX7cFC6GlQqfy4B2tbegJ/lM
         rNoQ==
X-Gm-Message-State: AOJu0Yyok2WRlv7ZBXZPyIEdRLMmPhTZg5q20NzlHyGk//tBbRNkGSvL
        6XL4UTGBghQ6OkUHDleQqNEgRg==
X-Google-Smtp-Source: AGHT+IHrE71DLN0+PlhM/WsyQ3GYh0veF/xKKbQDdt0YBF3808HKNYhDMcKsZ4tObQHOn9pYcAOc1w==
X-Received: by 2002:a17:902:8c8a:b0:1b8:2537:541c with SMTP id t10-20020a1709028c8a00b001b82537541cmr14244038plo.32.1692993584299;
        Fri, 25 Aug 2023 12:59:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ja11-20020a170902efcb00b001c0a4146961sm2147539plb.19.2023.08.25.12.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 12:59:43 -0700 (PDT)
Date:   Fri, 25 Aug 2023 12:59:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Yonghong Song <yonghong.song@linux.dev>,
        Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com,
        Leizhen <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] kallsyms: Fix kallsyms_selftest failure
Message-ID: <202308251258.C6770EAA9@keescook>
References: <20230825034659.1037627-1-yonghong.song@linux.dev>
 <CAKwvOdk7knYxOzaeq4gWjTiy=zRk4wc1jgq0d6fyFS5x43Cv9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdk7knYxOzaeq4gWjTiy=zRk4wc1jgq0d6fyFS5x43Cv9g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 10:51:58AM -0700, Nick Desaulniers wrote:
> On Thu, Aug 24, 2023 at 8:49 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> >
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index 016d997131d4..e12d26c10dba 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -188,16 +188,13 @@ static bool cleanup_symbol_name(char *s)
> >
> >  static int compare_symbol_name(const char *name, char *namebuf)
> >  {
> > -       int ret;
> > -
> > -       ret = strcmp(name, namebuf);
> > -       if (!ret)
> > -               return ret;
> > -
> > -       if (cleanup_symbol_name(namebuf) && !strcmp(name, namebuf))
> > -               return 0;
> > -
> > -       return ret;
> > +       /* The kallsyms_seqs_of_names is sorted based on names after
> > +        * cleanup_symbol_name() (see scripts/kallsyms.c) if clang lto is enabled.
> > +        * To ensure correct bisection in kallsyms_lookup_names(), do
> > +        * cleanup_symbol_name(namebuf) before comparing name and namebuf.
> > +        */
> > +       cleanup_symbol_name(namebuf);
> 
> Hi Yonghong,
> Thanks for your work on this patch.
> So if this change is removing the last place where the return value of
> cleanup_symbol_name is checked, then perhaps this commit should
> additionally change the function signature of cleanup_symbol_name to
> have `void` return type.

I've landed this in -next as-is just because I want to make sure the bug
gets fixed ASAP, so if this gets adjusted, I can just include that
change on top.

-- 
Kees Cook
