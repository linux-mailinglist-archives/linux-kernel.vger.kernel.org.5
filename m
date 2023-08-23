Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5140178557F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjHWKgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjHWKfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:35:32 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C87CFE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:35:02 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-99388334de6so382848666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692786901; x=1693391701;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OBSXO6qqgmHuKqh6bzP0tT7XEbpao57yrY6B+MWzUYg=;
        b=imZbjfBgPXvWMOgaH+hUcStjhZBiu6fzZipiqROt6F+8KEpdtPXQIWs+WEqdH3+aTI
         BgRDsVt5CQmUVGFWV3IER7szc7NKjgWyw1WfVZxefRjcONdn+t4XFHg3GUKTvwPqg9jd
         I94I7/tGXnqD5NTi2d5dIo72eDBJ59N+aG3KNcWnOq3SxT36VLOFObWUXdhOO+OX8UnV
         DFCvoBfq8MS+HCWsPjeOhmaB5TPtiv4YhjJBMyCKJFzUjE25STn0KfvfeG+uPJ2wcVFD
         uJHRg+hOquSGFE1DHd5ku0rjl3GCuDnpUNtu/BDpV152II0xibXMeyp5OfiUzaQk0JE3
         3Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692786901; x=1693391701;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBSXO6qqgmHuKqh6bzP0tT7XEbpao57yrY6B+MWzUYg=;
        b=S241b4KLIJ8pp/yi+WP55MO7WLBAjapZz/gEvjwmVSykXThTV8faEit0Zm6567vEVW
         Jguo4sUFFA319J3DQO+1hYWUOmSjmhatw2AI8hGK+W6+lAW4ecLnTCxxvc7j6/thn5ij
         +wYpONcgZ39UDW2S25fakpRzJuGQUTzYevKi1MEgIlmN/a6YmvDZSPgqoHeI8xYt05bi
         sL7pQx+ycwJeMWiMvhjzpFpTXdt1UmDUqlBEE3J05Iv87pZNgK8EmVbtlZ3XxFyy2t5s
         IVqwVzd4wYiyb8YgdBr64N40a72VMnJJs5aVDYrvaVMLnGQ1DAnOwOrPKNhZqrvbTTar
         xU+g==
X-Gm-Message-State: AOJu0YyrAnc7cuWoJVGfhLuV1EG5lSjI5Una2kCRLEzzE5WRy2GBPs4U
        y1yVAOPQyY+LjzsLpFK2Qa4hs2aSIgb0rWw=
X-Google-Smtp-Source: AGHT+IHl5FcW1ZIDTb421nTXT/COFWJ7T+NTcJyQsV3MlUrkt79HVnSpJOzK3M/a4awKmbc1LYiRMFB3GGHK4Rs=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:cb11:b0:9a1:cbc2:e442 with SMTP
 id um17-20020a170907cb1100b009a1cbc2e442mr17162ejc.10.1692786901028; Wed, 23
 Aug 2023 03:35:01 -0700 (PDT)
Date:   Wed, 23 Aug 2023 10:34:58 +0000
In-Reply-To: <87msyi406u.fsf@metaspace.dk>
Mime-Version: 1.0
References: <87msyi406u.fsf@metaspace.dk>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230823103458.243871-1-aliceryhl@google.com>
Subject: Re: [PATCH v1] rust: add improved version of `ForeignOwnable::borrow_mut`
From:   Alice Ryhl <aliceryhl@google.com>
To:     nmi@metaspace.dk
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hindborg <nmi@metaspace.dk> writes:
>>> I am not sure this makes sense. How about splitting the trait in two,
>>> immutable and mutable and only implementing the immutable one or Arc?
>>
>> I used this design based on what would make sense for a linked list. The
>> idea is that we can have two different types of cursors for a linked
>> list: immutable and mutable. The immutable cursor lets you:
>>
>>  * move around the linked list
>>  * access the values using `borrow`
>>
>> The mutable cursor lets you:
>>
>>  * move around the linked list
>>  * delete or add items to the list
>>  * access the values using `borrow_mut`
>>
>> The mutable cursor gives you extra abilities beyond the `borrow` vs
>> `borrow_mut` distinction, so we want to provide both types of cursors
>> even if the pointer type is Arc. To do that, we need a trait that
>> defines what it means to have mutable access to an Arc.
> 
> I don't see how that prevents this trait from being split in two?

Well, you could split the trait, but if you make the mutable iterator
require the `borrow_mut` trait, then you have to implement the mutable
trait for `Arc` too if you want the mutable iterator to work with `Arc`.

And if you're always going to implement both traits, then maybe it
makes more sense to not split the traits?

Alice
