Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89087A1BCA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjIOKKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbjIOKKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:10:16 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF39DBB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:09:39 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59bc956b029so20583717b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694772579; x=1695377379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v4KfpQzja2bZ8y8lL4LNkQMrLo3G1cILj6bkpeLJFqE=;
        b=zOi+IuJCvMJ99kwCxjwp/A6Xgr013ZlRdTDwiDq+bIpncgFAJHA5mjti016GSn8Kfv
         EJNcR4ZaqTN5eE6Wm/EFKRoafBvdGt9G7fyLXioI0iJOXTm01TZwKVhaJ+2avxqid5kg
         9u1hw8LhdUcFtF37HYOKBd6sHUaw4ZiUH3WGdEF944SOnSm5CirTDxl61OLA1SKT+yMp
         XlrbqbLmTwxgtxIMCWm308cxSmbM8fo09S19ciDKrsNug/dkDVKo15h0Id5rAs5HLu97
         9W9YMhLCXHlpH9/A+ojIUzcCifaGCzAJArfI8XlStik+SPopFDq3aRtZCJkU1T4uaBNG
         IaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694772579; x=1695377379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4KfpQzja2bZ8y8lL4LNkQMrLo3G1cILj6bkpeLJFqE=;
        b=bMh3TZaKXD4rRY5fQPFYu+rLG1QpRdh8pyr1uxIPVW2cFI7zp4OkAmSWHCZ6fHaNoO
         ZMt7fhxyLCgJW4z4iHsWZM0t6fs0QQgnGrUg0dl2Z0doWePta7Mht13aShfLMxVJc4SP
         85ZgKFyJSNhV8P0XT3uvGb3Xk+gD5KCAjO+OpIx/JYk8KnUlvFokaT3JAKixDAMSfJj6
         6EbbLUGcaTE2oEZTNBdAkNkFcyPu5HWL1xAlHc6CPvdYdCMxYLpb8NWSNvEZ9fAG3dZo
         2lz/ls2beeMEZM0fHb7kIQ2OJZKx5ikaI3lCpd1icpKX7TCmXNrqDsETvfn1IqKze8Uf
         fPVA==
X-Gm-Message-State: AOJu0YynWmExKmU9NyGSHcQ63J1WP6gh5CRuMgPpLlI3ovmiDWbyXRdP
        TRyuf+qPZ5fwXbtC4zP3QXxFpGEuxApfbxTdvHqurA==
X-Google-Smtp-Source: AGHT+IFZQJDXMgDKZjK6p6cQN4paCQlm6x7Ii+qiPr5B4nkU/0jgpYr8U9VAyRmKFjuOBv7bG64YdavpdrQjY1gKfPA=
X-Received: by 2002:a81:6cd8:0:b0:586:9c4b:95fb with SMTP id
 h207-20020a816cd8000000b005869c4b95fbmr1242141ywc.19.1694772579165; Fri, 15
 Sep 2023 03:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <07c32bf1-6c1a-49d9-b97d-f0ae4a2b42ab@p183>
In-Reply-To: <07c32bf1-6c1a-49d9-b97d-f0ae4a2b42ab@p183>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Fri, 15 Sep 2023 12:09:28 +0200
Message-ID: <CACMJSeu1NYNbQkiZC1BOs4QKhR4+VwYRrpDgq8gczRujt13zEQ@mail.gmail.com>
Subject: Re: Buggy __free(kfree) usage pattern already in tree
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 11:56, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> __free() got some usage and some of the usage is buggy:
>
>    832  static struct fwnode_handle *
>    833  gpio_sim_make_bank_swnode(struct gpio_sim_bank *bank,
>    834                            struct fwnode_handle *parent)
>    835  {
>    838          char **line_names __free(kfree) = NULL;
>                 // returns NULL or ERR_PTR(-E)
>    848          line_names = gpio_sim_make_line_names(bank, &line_names_size);
>    849          if (IS_ERR(line_names))
>    850                  return ERR_CAST(line_names);
>

Thanks for the report, I'll send a fix.

Bart

>
> This pattern will result in calling kfree() on error value.
> And there are no compiler or sparse checking these things.
>
> This test module demonstrates the landmine:
>
> [  812.981089] ------------[ cut here ]------------
> [  812.981597] WARNING: CPU: 0 PID: 1326 at mm/slab_common.c:991 free_large_kmalloc+0x50/0x80
> [  813.013266] ---[ end trace 0000000000000000 ]---
> [  813.013800] object pointer: 0xfffffffffffffff4
>
> #include <linux/module.h>
> #include <linux/slab.h>
> #include <linux/cleanup.h>
>
> struct S {
>         int x;
> };
>
> static struct S* f(void)
> {
>         struct S* s = kmalloc(sizeof(struct S), GFP_KERNEL);
>         s = NULL;
>         return s ?: ERR_PTR(-ENOMEM);
> }
>
> static int __init xxx_module_init(void)
> {
>         struct S *s __free(kfree) = NULL;
>         s = f();
>         if (IS_ERR(s)) {
>                 return PTR_ERR(s);
>         }
>         return 0;
> }
>
> static void __exit xxx_module_exit(void)
> {
> }
> module_init(xxx_module_init);
> module_exit(xxx_module_exit);
> MODULE_LICENSE("GPL");
