Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6CF7F80BE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345837AbjKXSwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345599AbjKXSwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:52:14 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1D91BC5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:52:20 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54b07ba599eso803956a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700851939; x=1701456739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xNuT9aL+BwgSK0CDB2p5O/f4j3yWkDx7/avEVjUORwE=;
        b=KaFhgw901uMP/WZeK80owvvztEER7hkKZgU0AhxYKDuahHhtq1iKufu/KE3+0TXOxj
         O/8jURia+Rupe+wT5hXOHv4Prwj9wTkidoHIMqB4tEvZunX8YMoazv3JskUuhM8yquwI
         cazY6zYGvVbS7+xfAGTAiI5NSrPHOTIsuCkD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700851939; x=1701456739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNuT9aL+BwgSK0CDB2p5O/f4j3yWkDx7/avEVjUORwE=;
        b=hIC1n+vEEdoO2jT8M3P0OSmcCuw3HJfdavEuq2eLl4CmAymjUNH7Nj1PMtVko9jNo5
         FqSS3m0DVIlpzIcnBivfJJXWRRCWiKwQM31DECnucZG7DA/KjMQIXUA7pD3eFVGOvG3X
         xTybGgYkitbAswUv/Rexef3RUSloAOUT1zQx68S4OLtbXjdHm0KRHS1oW93CmjccjFOi
         Fg4wA2iU/ubudvHQpWuUoDSx0xzkEm6exkecxXocK28LdG8FZ+3SFWSUI5TdqRu0HilM
         9VmRjvIp5cKzu+oQE488Z5vWHCte0f5n0e8POKoQ2T2ij4Oh8xJbdTLqpUBBap+uuoOD
         HeKQ==
X-Gm-Message-State: AOJu0YzbRhGZjoDpe3zHMgvQ4zHImLV21XTPRKxu3mvqa1j4oYmqflbM
        p5/shXDBVKFCAbtXEZ4q9uSFnnkzDC/JHpgZA3+ICIpI
X-Google-Smtp-Source: AGHT+IFsFqqCyGawhFPbnvqj+e86XC7C4PD000fe4B1KN5CvUNxH/QIY1kTg5AiAv1/KRJdO9riaEw==
X-Received: by 2002:a50:c04a:0:b0:54a:9fcd:2561 with SMTP id u10-20020a50c04a000000b0054a9fcd2561mr2976265edd.29.1700851939206;
        Fri, 24 Nov 2023 10:52:19 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id i7-20020aa7c9c7000000b0054855988fedsm2045162edt.37.2023.11.24.10.52.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 10:52:18 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a02d91ab199so312914366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:52:17 -0800 (PST)
X-Received: by 2002:a17:907:c18:b0:a02:9c3d:6de7 with SMTP id
 ga24-20020a1709070c1800b00a029c3d6de7mr3372036ejc.13.1700851937678; Fri, 24
 Nov 2023 10:52:17 -0800 (PST)
MIME-Version: 1.0
References: <20231124-vfs-fixes-3420a81c0abe@brauner> <CAHk-=wiJFsu70BqrgxtoAfMHeJVJMfsWzQ42PXFduGNhFSVGDA@mail.gmail.com>
In-Reply-To: <CAHk-=wiJFsu70BqrgxtoAfMHeJVJMfsWzQ42PXFduGNhFSVGDA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Nov 2023 10:52:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg0oDAKb6Qip-KtA5iFViy6EPWHt2DfCcG8LCXTb7i00w@mail.gmail.com>
Message-ID: <CAHk-=wg0oDAKb6Qip-KtA5iFViy6EPWHt2DfCcG8LCXTb7i00w@mail.gmail.com>
Subject: Re: [GIT PULL] vfs fixes
To:     Christian Brauner <brauner@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, 24 Nov 2023 at 10:25, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I just like how the patch looks:
>
>  6 files changed, 1 insertion(+), 368 deletions(-)
>
> and those 350+ deleted lines really looked disgusting to me.

Gaah. I guess it's the VM_IOREMAP case that is the cause of all this horridness.

So we'd have to know not to mess with IO mappings. Annoying.

But I think my patch could still act as a starting point, except that

                case KCORE_VMALLOC:

would have to have some kind of  "if this is not a regular vmalloc,
just skip it" logic.

So I guess we can't remove all those lines, but we *could* replace all
the vread_iter() code with a "bool can_I_vread_this()" instead. So the
fallback would still be to just do the bounce buffer copy.

Or something.

Oh well.

               Linus
