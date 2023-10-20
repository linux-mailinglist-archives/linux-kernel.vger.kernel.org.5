Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA2C7D154B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377953AbjJTR45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjJTR4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:56:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9082FD6A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:56:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9adb9fa7200so239590666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697824610; x=1698429410; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F4wi3imaHP2uII6OBg2l5IRaJiEg3OU2WqP11N/v4Ns=;
        b=X9zutY/WqM+3WkhDKJkViI85FZ152N62zf9ss+VcnGp0DFn5nA55hjr1JxUl++E7BV
         r0EDy3dWgbG4hl74Z+Qt3P0Kf/zj4vlDraNns4iZBT4SnQcR/wbxUEFQJ8VboJuc9/PF
         CS6lbBs2M15DsGalnWkqYZ96wNwKbFyDebev8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697824610; x=1698429410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4wi3imaHP2uII6OBg2l5IRaJiEg3OU2WqP11N/v4Ns=;
        b=nEQ2OhijS/jSkjN4kJvZL+4zme5o/L8C28PqjgrqaeYqtZEVQzvxk9e4aNFpeEP0fL
         i1lRDD+wSwIv8nRUnJB8N7Ggdxut7ZMcr/T7e7I1xhCxh2w8mGnLz1u7qUsuBACTbQpq
         metbbNc0HOQioyj24xwgTEU3iC2ZSJEgEL16vMAHlh1+wxDDtSVKJl7TmfX9NACN8wjf
         Igyii8mx6w0+Ll+zWQXP6DQ6J1eSmjcPLyhAmc2XBo0JnQCyuB9K37DIXQY+Zu4bGg2e
         X7K6zVv7XNHsFMBRlYbVdOXkcwKEULAsK/eW35yDxaS3j9Svzv0SFA4kYb8nhSzK5D/1
         2kmQ==
X-Gm-Message-State: AOJu0Yw4Po/Cy7fAankQL/uyxuwaWqhpORJiUqRhPBCo8quRPiIInCWE
        6lLw75Uvf4PzCYoZnZ5XLZI5PmTqO/Qk7dNEtK7PO8Zh
X-Google-Smtp-Source: AGHT+IHInM3hmPP/jNkH1QZqhSimRq0koLJNcojFcvBp9uhYWimW39tEeoAtHWUiPU9WjslL6GXPCg==
X-Received: by 2002:a17:907:2da7:b0:9c3:97d7:2c67 with SMTP id gt39-20020a1709072da700b009c397d72c67mr2349289ejc.25.1697824609726;
        Fri, 20 Oct 2023 10:56:49 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id jl24-20020a17090775d800b0099315454e76sm1881788ejc.211.2023.10.20.10.56.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 10:56:49 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-53fc7c67a41so2124040a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:56:49 -0700 (PDT)
X-Received: by 2002:a17:907:94d0:b0:9ae:65d6:a51f with SMTP id
 dn16-20020a17090794d000b009ae65d6a51fmr5921646ejc.18.1697824608915; Fri, 20
 Oct 2023 10:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook>
 <20231020044645.GC11984@lst.de> <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
In-Reply-To: <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Oct 2023 10:56:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4BZei4JTiX9qsAwk8PEKnPrvkG5FU0i_HNkcDpy7NGQ@mail.gmail.com>
Message-ID: <CAHk-=wj4BZei4JTiX9qsAwk8PEKnPrvkG5FU0i_HNkcDpy7NGQ@mail.gmail.com>
Subject: Re: the nul-terminated string helper desk chair rearrangement
To:     Justin Stitt <justinstitt@google.com>
Cc:     Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023 at 10:40, Justin Stitt <justinstitt@google.com> wrote:
>
> There's some docs at [1]. Perhaps there could be more?
>
> [1]: https://elixir.bootlin.com/linux/v6.6-rc6/source/include/linux/fortify-string.h#L292

Note that we have so few 'strlcpy()' calls that we really should
remove that horrid horrid interface. It's a buggy piece of sh*t.

'strlcpy()' is fundamentally unsafe BY DESIGN if you don't trust the
source string - which is one of the alleged reasons to use it.

That said, while 'strscpy()' fixes the fundamental conceptual bugs of
strlcpy(), it's worth noting that it has *two* differences wrt
strlcpy:

 - it doesn't have the broken return value

 - it copies things in word-size chunks to be more efficient

And because of that word-size thing it will possibly insert more than
one NUL character at the end of the result.

To give an example, if you have

   dst[64] = "abcdefghijklmnopqrstuvwxyz";
   src[64] = "123\0........";
   strlcpy(dst, src, 64);

then the strlcpy() will return 3 (the size of the copy), but the
destination will end up looking like

   dst[64] = "123\0\0\0\0\0ijklmnopqrstuvwxyz...";

This odd "possibly word padding" is basically never relevant (and it's
obviously always also limited by the size you gave it), but *if* you
are doing something really odd, and you expect the end of the
destination string to not be modified at all past the final NUL of the
copy, you need to be aware of this.

It does mean that if you used to have

    dst[4];
    strlcpy(dst, "abc", 8);

then that *used* to work (because it would copy four bytes: "abc\0"
and that fits in 'dst[]'). But

   dst[4];
   strscpy(dst, "abc", 8);

will overflow dst[], because it will do a word-copy and you told
'strscpy()' that you had a 8-byte buffer, and it will try to write
"abc\0\0\0\0\0" into the destination.

The above is insane code, but it's an example of why a blind
strlcpy->strscpy conversion might change semantics.

            Linus
