Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041537B0DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjI0VS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjI0VSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:18:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA9211D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:18:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5334f9a56f6so14176813a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695849530; x=1696454330; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G8V+lk3a6Cym1PJ0mfiXsEqz7twyU2MgEXEYS1WTIfQ=;
        b=T9wMVK3bnjWmJO7M4kwiaAOm2VnWwbW9DXDejoQgfkvRvF/v80XY7LBZu4zJBwYnvA
         xri9lI7g/PYEk+OtcMavgWDlxkKriXtUDoBKmpIVBhf9EgSVV9RuhHKR6Q4WR1SFiQE2
         VtCC0PP4JAkGz0/6Q4XTi56sxmxOl7yWSTKCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695849530; x=1696454330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8V+lk3a6Cym1PJ0mfiXsEqz7twyU2MgEXEYS1WTIfQ=;
        b=TJEfYFzaRonpslFIZCCjEhYesEYbXeNKSlSusEhlxTAC9sGtthyADK6dJ849cxIdUQ
         ELV4/T9U4bX/1L+S0UHujrXRmBM1QhZ15+4eZTLtwnf/yPIqkTwEoQ52HSIoZM/SU0nk
         03xPBfrxoqhQiemE2kykUsrLmXfATyT/Py4+ApW9KEWcjYrIFRZNYa2pf/4I6x/u9ecb
         sTGjcZmD9d2xgicoYcF0r/qZ71gFEw8WqQMYRlI9YBmUVFdmpLou6OCAd/OrirHsNElV
         mmHLoEyygbb1JLHa8j/oO44UrywsiE/MsUIrzlntdw/sN8KNh/UsuxZGt9PGU7tiBJfa
         5LAQ==
X-Gm-Message-State: AOJu0YyLIrleUcsUgkNTcKvlnJBJSAO+i3jH7oFogHyKKaZSU9YkGN7I
        jCBqN+Rx4+WXftXQv9BPViGS2R2lbMLfvQMKMqVl+w==
X-Google-Smtp-Source: AGHT+IECgh66swATVw2dVabLRT5D0tXa35gjunJ/dwrHoUrVxBgMsRoRTlqUDHHXBum3dVfWEs2ArQ==
X-Received: by 2002:a05:6402:1251:b0:51d:9399:4707 with SMTP id l17-20020a056402125100b0051d93994707mr2701851edw.26.1695849530460;
        Wed, 27 Sep 2023 14:18:50 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id dm20-20020a05640222d400b0053414427690sm4416962edb.41.2023.09.27.14.18.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 14:18:50 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5334d78c5f6so14279843a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:18:49 -0700 (PDT)
X-Received: by 2002:a05:6402:1652:b0:533:f1c4:5424 with SMTP id
 s18-20020a056402165200b00533f1c45424mr2803713edx.35.1695849528832; Wed, 27
 Sep 2023 14:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230926162228.68666-1-mjguzik@gmail.com> <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
 <CAGudoHGej+gmmv0OOoep2ENkf7hMBib-KL44Fu=Ym46j=r6VEA@mail.gmail.com>
 <20230927-kosmetik-babypuppen-75bee530b9f0@brauner> <CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com>
 <CAGudoHH2mvfjfKt+nOCEOfvOrQ+o1pqX63tN2r_1+bLZ4OqHNA@mail.gmail.com>
 <CAHk-=wjmgord99A-Gwy3dsiG1YNeXTCbt+z6=3RH_je5PP41Zw@mail.gmail.com>
 <ZRR1Kc/dvhya7ME4@f> <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
 <CAGudoHH20JVecjRQEPa3q=k8ax3hqt-LGA3P1S-xFFZYxisL6Q@mail.gmail.com>
In-Reply-To: <CAGudoHH20JVecjRQEPa3q=k8ax3hqt-LGA3P1S-xFFZYxisL6Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Sep 2023 14:18:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLX7-waQ+RX6DBF_ybzpEpneCkBSkBCeHKtmEYWaLOTg@mail.gmail.com>
Message-ID: <CAHk-=whLX7-waQ+RX6DBF_ybzpEpneCkBSkBCeHKtmEYWaLOTg@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
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

On Wed, 27 Sept 2023 at 14:06, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I think you attached the wrong file, it has next to no changes and in
> particular nothing for fd lookup.

The fd lookup is already safe.

It already does the whole "double-check the file pointer after doing
the increment" for other reasons - namely the whole "oh, the file
table can be re-allocated under us" thing.

So the fd lookup needs rcu, but it does all the checks to make it all
work with SLAB_TYPESAFE_BY_RCU.

> You may find it interesting that both NetBSD and FreeBSD have been
> doing something to that extent for years now in order to provide
> lockless fd lookup despite not having an equivalent to RCU (what they
> did have at the time is "type stable" -- objs can get reused but the
> memory can *never* get freed. utterly gross, but that's old Unix for
> you).

That kind of "never free'd" thing is indeed gross, but the
type-stability is useful.

Our SLAB_TYPESAFE_BY_RCU is somewhat widely used, exactly because it's
much cheaper than an *actual* RCU delayed free.

Of course, it also requires more care, but it so happens that we
already have that for other reasons for 'struct file'.

> It does work, but I always found it dodgy because it backpedals in a
> way which is not free of side effects.

Grep around for SLAB_TYPESAFE_BY_RCU and you'll see that we actually
have it in multiple places, most notably the sighand_struct.

> Note that validating you got the right file bare minimum requires
> reloading the fd table pointer because you might have been racing
> against close *and* resize.

Exactly. See __fget_files_rcu().

          Linus
