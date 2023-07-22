Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D846875DE15
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 20:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjGVSYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 14:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGVSYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 14:24:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D4C26B8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 11:24:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51ff0e3d8c1so4122711a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690050241; x=1690655041;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jLlpX4ximjQ8EiWaYEdqr90sGKj83EdXmDgZ/NkCSBw=;
        b=CH4gI2Dn9VA0UYtGTEIDdEKc/9szPsG5SqZxR+tnlfRASw9ZYFLo/VNbon1ya4NUc/
         4JaavY+6jh2vbmjBP2Jvk9OK660Jyie/4osr8GivHZFE6q52hNnx1JSm59m0UH1V6DNV
         qdXV5FutW8A7J8IKo7IIi9M9y4dQvUfl/qdQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690050241; x=1690655041;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLlpX4ximjQ8EiWaYEdqr90sGKj83EdXmDgZ/NkCSBw=;
        b=f3YQdkIUiezs7rku827S+8nluKQu7PZNYT9LR12N5OF0eKNeds/e73LxBt+J+8zpgt
         jsYV3fhGLWAdVoL7zr5CIIXggIYZZgJG/yOex+mcnxb8mXDBJgmCjuFRIiAHwyGrAET2
         5uXDmoUCN/yDW3tFjJ0y1d8Ge06JDiz6KTewzW/Eh0qrvd+DuRfjucvX09ykxE+C33OP
         MNGr6Dro5h86nnLR9+PsJ/J4icG5i6l4bSbIoE9QOwobhtTkbyf7+QxLrKZI0hQm/tlT
         Gl12fjmh8zhd5BRfc+ojYjImnmpQ8QPrzyhNDkzprK03nPwnr/oKleR+sNEFin2hWIHf
         6HSA==
X-Gm-Message-State: ABy/qLbyB88/pefyWgg8fHRVWoNPlzP3Dar/IdNArXbqCIxb+ac3jPyb
        o4xFVW8fa9ilSFa7HFEXzXdWzGjCBdPT79d2pB3k2Q==
X-Google-Smtp-Source: APBJJlFH7M4b/PuzcPXZZ5E43ticLy7LqEeu1pw6OZ6XPeiC0fbUtzYueWg5qurtSkEuecwkos0SdQ==
X-Received: by 2002:aa7:cd69:0:b0:51e:126a:403a with SMTP id ca9-20020aa7cd69000000b0051e126a403amr4493267edb.13.1690050241058;
        Sat, 22 Jul 2023 11:24:01 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id i5-20020aa7c9c5000000b005219de74217sm3637654edt.43.2023.07.22.11.24.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 11:24:00 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51e6113437cso4101504a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 11:24:00 -0700 (PDT)
X-Received: by 2002:a05:6402:2025:b0:522:206a:d6d2 with SMTP id
 ay5-20020a056402202500b00522206ad6d2mr374604edb.26.1690050240086; Sat, 22 Jul
 2023 11:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msCqEDv1mUMMVTg8t7K+CO82Ha_xQoYJ-FkQ9h83By5wA@mail.gmail.com>
In-Reply-To: <CAH2r5msCqEDv1mUMMVTg8t7K+CO82Ha_xQoYJ-FkQ9h83By5wA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Jul 2023 11:23:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTnOWaYxG2sU8ikFZsowUPApWgHxf0jM77ELUb39SuAw@mail.gmail.com>
Message-ID: <CAHk-=whTnOWaYxG2sU8ikFZsowUPApWgHxf0jM77ELUb39SuAw@mail.gmail.com>
Subject: Re: [GIT PULL] smb3 client minor debugging fix
To:     Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2023 at 07:19, Steve French <smfrench@gmail.com> wrote:
>
> add small debugging improvement
> - it is helpful for network debugging of smb3 problems to be able to
> use directory not just file (e.g. access to empty share)
> ----------------------------------------------------------------
> Shyam Prasad N (1):
>       cifs: allow dumping keys for directories too
>
> Steve French (1):
>       cifs: update internal module version number for cifs.ko

Bah. I pulled, and then unpulled, because that module version number
change was obviously garbage.

That versioning has been problematic before too, and honestly seems to
be just completely broken and pointless random numbers that mostly -
but not always - are in sync.

This pull wasn't really a "fix" anyway, but then when I see nonsense
like that I just decide it's entirely bogus.

             Linus
