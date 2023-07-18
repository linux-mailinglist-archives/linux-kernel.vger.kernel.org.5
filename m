Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AE775812D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjGRPlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjGRPlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:41:49 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D5E10FC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:41:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-992ca792065so808448266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689694907; x=1692286907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+CPO/v8M4GFwJzPVXmt4GfXqNZOaLpVYfQFAttEtcwU=;
        b=L1OKjzOlywwemsIlTRcHhhSv79NsrwhcA5QqfXQX7oWpKGaxXF0japNHAXAiSJbOJ5
         QZx3H4vr0C55j3d2QUL/JdY4Fdg7QGGF+b5R39yJa1/CnVVUFpc7JdR8vnQxllFpOgOn
         QVuO/wSsf8pLJ/DsEy7XFyj9tX96hH+bPzHs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689694907; x=1692286907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CPO/v8M4GFwJzPVXmt4GfXqNZOaLpVYfQFAttEtcwU=;
        b=e4MoHquH0HVD4TyR11mVJUxQ/2XwiT5z340tIbfiZEfPS3hwnvRMaHZ5GxyI4FDiKO
         svtWHCxbO8mrvWVCQegTj8d8iDvBJjU/IUjiwkgOlLlVjHmDqFVF67IvJZAzT6ceazqp
         jTRA89flV32TGt5luxhyWee62dZFqV2GNZmIZZJRtaU/QbRZLC+CNPEqAziLvToLV4w3
         VQRJJoOK81U/u+ppaR6t0E40JoYxFcxAoDUhdJZzdcPZejjzL/+pUjdFJL5veBFhxa1V
         ExkX5h8KZNu97kQ8weUL9e2ObrbFzTUEqTf/RQlER8br8aUo5TIJMsqK5tUciM4DoU1C
         g2iQ==
X-Gm-Message-State: ABy/qLYdVNT7HtzGYzr3rVXsdzBi3P7r/LXRYgY15EmFqeMaJlMf3/aU
        MT4Lo7B3Kagt4LIaA5kmd7NqowFuoBKgVW3TqN4tBmxq
X-Google-Smtp-Source: APBJJlHevgmxDsVik+ZUKPiXCz21LCheIJgKWK9+BYUOHfUvMa9rcnhX181231f9IXN4BpEy39xMvQ==
X-Received: by 2002:a17:906:13:b0:993:f996:52d4 with SMTP id 19-20020a170906001300b00993f99652d4mr154231eja.22.1689694906733;
        Tue, 18 Jul 2023 08:41:46 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id o22-20020a1709062e9600b009937dbabbd5sm1130201eji.220.2023.07.18.08.41.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 08:41:46 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-521662a6c9cso6452503a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:41:46 -0700 (PDT)
X-Received: by 2002:aa7:da4a:0:b0:51e:342c:25e0 with SMTP id
 w10-20020aa7da4a000000b0051e342c25e0mr71394eds.41.1689694905819; Tue, 18 Jul
 2023 08:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230716184204.GFZLQ5/DJ1+q8vpuuN@fat_crate.local>
 <CAHk-=wiXp9YLB6wHOmc4rBJbd7j0gHgHZPHhUSPe-SAjJgmABQ@mail.gmail.com> <d11eea99-6e93-6af4-87aa-2e7f1c6ae83e@oracle.com>
In-Reply-To: <d11eea99-6e93-6af4-87aa-2e7f1c6ae83e@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Jul 2023 08:41:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4Ajeu-Ju4TsZ+Y83ksb+Z=VMyy--gf1uZzj7Vc5D1ag@mail.gmail.com>
Message-ID: <CAHk-=wg4Ajeu-Ju4TsZ+Y83ksb+Z=VMyy--gf1uZzj7Vc5D1ag@mail.gmail.com>
Subject: Re: [GIT PULL] objtool/urgent for v6.5-rc2
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 at 04:02, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> If you are willing to add another helper function that also takes the
> label argument, you could do something like this:

Ugh. That's a bit uglier than I was hoping for.

I was hoping more like "use this special attribute to mark this asm as
being something that cannot be moved across function boundaries".

Now a "we have to make up horrible games and pass in labels that are
not used and use a completely different API".

Oh well.

I guess in the end we can just continue to work around this.

After all, in many ways this isn't about the code - the AC setting and
clearing is fine - it's about objtool not doing the analysis across
function boundaries.

I guess we could have just marked these iovec copy functions
"always_inline" too, and avoided it that way.

              Linus
