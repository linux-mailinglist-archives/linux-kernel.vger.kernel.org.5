Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A462A7ECB0D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjKOTQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjKOTQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:16:09 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0575719E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:16:06 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53ed4688b9fso67116a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700075764; x=1700680564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ASZLC/ODVoT1N8Pjpom0HFAzc3MgwAYR1S4lEQGUD4=;
        b=QV/S2q+otJeftflGUe656F5D89Cd2cGH1AvFgnenpatSk6TadPHAbEgiV/pdB1X4v/
         NUEOywr4xSMgs05WmS/MLgNKd7Svt2rwfzs7ek1xjOMwzV4xak+1WvjiPSx0BvF/1yOQ
         Ec136mZPYjXx49dPZpZv9sct+rCej1MifkfcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700075764; x=1700680564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ASZLC/ODVoT1N8Pjpom0HFAzc3MgwAYR1S4lEQGUD4=;
        b=mku2M+arIQVFS83iUJt5Ujr/o+ci15Gv3dioGjZuv6QA5wj9dACeb7Q48SOa3pxedd
         7/qEVLq/o0nddD3S6wsrcStORlm4Z+SaiuDliaAOTM6CY+YrgDT4qc2wQEOSZ9aT+x1Y
         o3pchiQG5K719stNSTxt7lSqblmKgLGC2d8EafTQKgZQftjPWDx5AmN96hCXUDNjT2GZ
         8bzJafIYQ+r4RvQ17J+ZPggMHJuoIFjwwD2PKGPMBVEBaGxv5UKpMoevKPPQaaRjNEXN
         N/01SgWrU8SUa04TS8b+bddxEkYNTxtIe5aIVT9wd7wTAnmGpTKcY13WOSjX/kzWDAYq
         TXtw==
X-Gm-Message-State: AOJu0YwFmx8V33grzX4wBVUflIUFPaR093LSdGPKxs69yVkmnvFsI+cJ
        xtsSrZxQinkxQhegjsGWAM2cIBBkcz0CBpKtB7jJkv9O
X-Google-Smtp-Source: AGHT+IE04FF5zSGInYSXw61bIFfrkkByzmzr2+ow1NXxEdQMalnlcopzimZ5fqotvnlDRoETBlFv3A==
X-Received: by 2002:aa7:d059:0:b0:540:b0ec:bcc7 with SMTP id n25-20020aa7d059000000b00540b0ecbcc7mr217477edo.5.1700075764144;
        Wed, 15 Nov 2023 11:16:04 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id z9-20020a50cd09000000b00543b2d6f88asm6941321edi.15.2023.11.15.11.16.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 11:16:03 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5441ba3e53cso54078a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:16:03 -0800 (PST)
X-Received: by 2002:a05:6402:5193:b0:543:5789:4d6c with SMTP id
 q19-20020a056402519300b0054357894d6cmr292256edd.2.1700075763431; Wed, 15 Nov
 2023 11:16:03 -0800 (PST)
MIME-Version: 1.0
References: <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com> <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local>
In-Reply-To: <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Nov 2023 14:15:46 -0500
X-Gmail-Original-Message-ID: <CAHk-=whFW+uWOmOtRNh0What_fu8Xo8KF2+EeUH1kn4qFxGAhA@mail.gmail.com>
Message-ID: <CAHk-=whFW+uWOmOtRNh0What_fu8Xo8KF2+EeUH1kn4qFxGAhA@mail.gmail.com>
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
To:     Borislav Petkov <bp@alien8.de>
Cc:     David Howells <dhowells@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 14:10, Borislav Petkov <bp@alien8.de> wrote:
>
> Should we define an alternative_memcpy() which is used *only* during
> rewriting so that this becomes a non-issue?

Yeah, I think the instruction rewriting should use something that
explicitly cannot possibility itself need rewriting, and a plain
'memcpy()' is obviously that.

The good news is that at least things like structure copies would
*not* trigger that alternative, so it's only explicit memcpy() calls
that my patch changes. But I would not be surprised if instruction
rewriting does that. I didn't actually check.

> Yours looks simple enough and makes sense. Lemme poke at it a bit in the
> coming days and see what happens.

Note that it has a nasty interaction with fortify-source, which is why
it has that hacky "#undef memcpy" in that unrelated header.

Also note that I was being very very lazy in how I re-used the
"rep_movs_alternative" function that we already have. And it's
actually a bad laziness, because our existing rep_movs_alternative
does the exception handling for user mode faults.

We don't actually want exception handling for 'memcpy()', because it
could hide bugs. If a memcpy() gets a bad pointer, we want the oops,
not a partial copy.

So my patch really is broken. It might happen to work when everything
else goes right, and it's small, but it is very much a "proof of
concept" rather than something that is actually acceptable.

               Linus
