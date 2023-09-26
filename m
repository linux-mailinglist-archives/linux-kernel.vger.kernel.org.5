Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5847AF38D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbjIZTAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbjIZTAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:00:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47B11A5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:00:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so1140195466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695754824; x=1696359624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s173qssf1hSEtheDxpw+ukvaF+2Io1KlydoI9zAe+yM=;
        b=NdB0fWLWqvnDRGVXRW45jYQQWDHubZLk3lIgLI4HStAfFV1nqNd2X2NckC/MZB0e1/
         Hh6erFWTvdrj+rxRunraPdGflV4Qrfs2OusWlceFgMYjffV4z0iiyP6IuCahbV7vo0F9
         GGoGdvwxIZVf3rLG/AcHTuLDl3+aShR3l1TBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695754824; x=1696359624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s173qssf1hSEtheDxpw+ukvaF+2Io1KlydoI9zAe+yM=;
        b=Lcx67Yx435UEEzvWQ+IIaRigU4B2X5NZJ08+2Zg1HLRSolRN9LYoKnQQlbTJr7zIhh
         TrUa73J4QPe4fsWLDRZy4gGz9Zv4Blrzc9iyA+VUIOAFE0uiCNvyOq6WrVVR9pmnCJUg
         ZD9rsBhLygj6uICq1ro5pTjjBTmsyUld/CaSmjqaFyDkUv3MXQzFCaJd/f2uehzihpYX
         R5A5wkemee298fBj5om79elj0mLsxGFVe/RQDK0WsFOl7Oym/O/GUwk2NAiu0lNIGTwJ
         w1Ciy1TxMZXF1oBM56mw0v00L4xZ5JPoUUC1QYG1sk/sq/0mFPQZ+in8+N6M4saIfYUg
         HV1A==
X-Gm-Message-State: AOJu0YzrUFG00IgLy5NP39RcB3KxLvroRg1E2qBkg6GXWWJXWWTxDhZv
        8gq8LHQm41R4XTwwCr1uOLFbaQi69Kt5iAN533gJpw==
X-Google-Smtp-Source: AGHT+IGxuhS85yoAO47RTwAE+DRJ7pV9uVPvn3M2cLLwGQbcSLf9qxEbdiwio2JVdKWr6J61kGCP3w==
X-Received: by 2002:a17:907:86a1:b0:9a5:a701:2b90 with SMTP id qa33-20020a17090786a100b009a5a7012b90mr11041996ejc.40.1695754823901;
        Tue, 26 Sep 2023 12:00:23 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906165300b009a1c05bd672sm8029499ejd.127.2023.09.26.12.00.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 12:00:23 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-52fe27898e9so11449661a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:00:23 -0700 (PDT)
X-Received: by 2002:a05:6402:22cd:b0:534:5e2a:d443 with SMTP id
 dm13-20020a05640222cd00b005345e2ad443mr2604911edb.29.1695754822856; Tue, 26
 Sep 2023 12:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230926162228.68666-1-mjguzik@gmail.com>
In-Reply-To: <20230926162228.68666-1-mjguzik@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Sep 2023 12:00:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
Message-ID: <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     brauner@kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sept 2023 at 09:22, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> +void fput_badopen(struct file *file)
> +{
> +       if (unlikely(file->f_mode & (FMODE_BACKING | FMODE_OPENED))) {
> +               fput(file);
> +               return;
> +       }

I don't understand.

Why the FMODE_BACKING test?

The only thing that sets FMODE_BACKING is alloc_empty_backing_file(),
and we know that isn't involved, because the file that is free'd is

        file = alloc_empty_file(op->open_flag, current_cred());

so that test makes no sense.

It might make sense as another WARN_ON_ONCE(), but honestly, why even
that?  Why worry about FMODE_BACKING?

Now, the FMODE_OPENED check makes sense to me, in that it most
definitely can be set, and means we need to call the ->release()
callback and a lot more. Although I get the feeling that this test
would make more sense in the caller, since path_openat() _already_
checks for FMODE_OPENED in the non-error path too.

> +       if (WARN_ON_ONCE(atomic_long_cmpxchg(&file->f_count, 1, 0) != 1)) {
> +               fput(file);
> +               return;
> +       }

Ok, I kind of see why you'd want this safety check.  I don't see how
f_count could be validly anything else, but that's what the
WARN_ON_ONCE is all about.

Anyway, I think I'd be happier about this if it was more of a "just
the reverse of alloc_empty_file()", and path_openat() literally did
just

        if (likely(file->f_mode & FMODE_OPENED))
                release_empty_file(file);
        else
                fput(file);

instead of having this fput_badopen() helper that feels like it needs
to care about other cases than alloc_empty_file().

Don't take this email as a NAK, though. I don't hate the patch. I just
feel it could be more targeted, and more clearly "this is explicitly
avoiding the cost of 'fput()' in just path_openat() if we never
actually filled things in".

                   Linus
