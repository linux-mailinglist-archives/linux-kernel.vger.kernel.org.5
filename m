Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A87976C0E5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjHAXa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjHAXay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:30:54 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720B02698
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 16:30:50 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bba54f7eefso2220165ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 16:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690932650; x=1691537450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=86m4GR9B2OpRjtzGq0slUUGfFWMp1qBl7r1sdnV44Zs=;
        b=oXOhuADoyGWQ0CpVMkCDvFuSa4MXFW5gBBca+inDX7DNEkDMKdcSKpP8pXSZcsbbO+
         EIOlo1oFFw1605QRbVWA9tfP9iBqWxz3Xu+rhDQw5/MNdKajZBtt3x5na7aGFaHYwOC5
         wrb8HxEp7OxMNzzJzwG4X/qfizVI2QJMmqjSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690932650; x=1691537450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86m4GR9B2OpRjtzGq0slUUGfFWMp1qBl7r1sdnV44Zs=;
        b=KcaG+AUm5eoU/L8PwDfXvM2lOqD/70irKrMNCMX+HPZd8ApuSrxW56NuRGIopPONu+
         RPneC9bNRgJDg4eu16uKJYQS4zduHPzeUxsdrq+9KIwoArJUjATK8Ltsp+oqSHqCnOr0
         NJvyKW1a682C+sDlFN2UwacNQW4WIWpCXQG4xEeFjx7uesLdmRow9yj70xDeaVMNB78O
         VynS8Fc2A0pdy0vyUdkgf8lB4m9+h+e0xlsYRgzwKtVdzCys8WuMxj2OGSzLjqT/Jopf
         tdgfmMp3+QbZ/YN8eXwAoFu74TIpvcBr0JexVb5SN8ZKJ/saStymEkESDJ8D9hkq3TKK
         myuA==
X-Gm-Message-State: ABy/qLb4NPWj4H95MzBBFFt9p1OVLXy3reQmD0WYUtQ3Tp8/NObNkr1/
        ItrKv6K4LglqlKkphNvbqqt39Q==
X-Google-Smtp-Source: APBJJlF+gVNSruf2vthO1DrYzubB+mB7El3VzV9i7PDZy0XViadbu4f6RZq+Mn8fxhqwRga5R1HwMQ==
X-Received: by 2002:a17:902:d4c3:b0:1b8:a936:1915 with SMTP id o3-20020a170902d4c300b001b8a9361915mr15677302plg.22.1690932649870;
        Tue, 01 Aug 2023 16:30:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jh3-20020a170903328300b001b8b6a19bd6sm11021366plb.63.2023.08.01.16.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 16:30:49 -0700 (PDT)
Date:   Tue, 1 Aug 2023 16:30:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RISC-V: cpu: refactor deprecated strncpy
Message-ID: <202308011630.913CE919@keescook>
References: <20230801-arch-riscv-kernel-v1-1-2b3f2dc0bc61@google.com>
 <61DD603A-3D86-462F-B795-7EDE3A59ABBE@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61DD603A-3D86-462F-B795-7EDE3A59ABBE@jrtc27.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 12:02:11AM +0100, Jessica Clarke wrote:
> On 1 Aug 2023, at 22:14, Justin Stitt <justinstitt@google.com> wrote:
> > 
> > `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> > 
> > A suitable replacement is `strscpy` [2] due to the fact that it
> > guarantees NUL-termination on its destination buffer argument which is
> > _not_ the case for `strncpy`!
> > 
> > The `sv_type` buffer is declared with a size of 16 which is then
> > followed by some `strncpy` calls to populate the buffer with one of:
> > "sv32", "sv57", "sv48", "sv39" or "none". Hard-coding the max length as 5 is
> > error-prone and involves counting the number of characters (and
> > hopefully not forgetting to count the NUL-byte) in the raw string.
> > 
> > Using a pre-determined max length in combination with `strscpy` provides
> > a cleaner, less error-prone as well as a less ambiguous implementation.
> > `strscpy` guarantees that it's destination buffer is NUL-terminated even
> > if it's source argument exceeds the max length as defined by the third
> > argument.
> 
> I would imagine you’d want a BUG_ON() rather than silent truncation if
> that ever happened (well, silent if you ignore it then printing the
> truncated string).
> 
> Though really you just want a static_strcpy that looks at sizeof* for
> source and destination and fails to build if it doesn’t fit; there’s no
> reason this needs to be found at run time.

FWIW, under CONFIG_FORTIFY_SOURCE, strscpy() does try to just fold away
to a static strcpy when sizes are provably safe, etc.

-- 
Kees Cook
