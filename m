Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC847FDD79
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjK2Qmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjK2Qms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:42:48 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ED3A8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:42:55 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cd573c2cccso8903377b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701276174; x=1701880974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w6FX0CURCIc5lUI0TKDm4VLrqOeB/l4oPqjqbRob5JI=;
        b=0qtm/rwqKLTmg0uBNQ9djLMO6ApmdUrjMGiRlrpLewmfrf3TZZUqhWrJ63TpMrYpLv
         8jk82dh0sU0R+h2DBJMDlKkm/SM+DpZh89w37LUl5HhqyE3BvBG/ycaq+yrRgpTqL6P9
         bdHrJd6+VWH5ykdRlJLW97xm5zDsRLPzhC5rC5Asz+KL8Yk79mVTC/cQ9wbw0tcBvUxP
         vqoINIY2SxecDWX5l2I/aV/TSmRcQidN2Ytvi9gWIKZntlFUvsKTP54kZXUjzNgZK8DB
         gXhKlJj0cSD7y3Z43c9DAesajp2xZkc9lX1I2qoqy42jOSE0Wg2JjKgiOyaw4hQLZdzx
         a8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701276174; x=1701880974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w6FX0CURCIc5lUI0TKDm4VLrqOeB/l4oPqjqbRob5JI=;
        b=TebVWONFPQqmZVuoFJPqzkcr0q3MviBS4Cw4lid0XCOcNponyhY5G0MW2TFgLS6nz2
         1JyX7GYVCk8kUUfAIfoBEb8EIroPSs8N4GiXfzoY354F+0QdY3YdP8oAlzM4rY5pv+Je
         lkgeY3LrGFTT7MjhAUaRrt+PT2BgtkhAyvRCUywz+M8GNww4eqj7vhzyWk1BKJc+KHwh
         cETD/x4wLVdq/5xK+BfulzuVEBrEP1h61P/BhXh8UN9LLUpvETULm3TPzrd0KWWDG1mr
         31AY3FZ7E1Q3UP+K+0nBErBADO3bwleCHy47kPRVgIXDf2s/SdJI7FWRhKJGb0cjuxUg
         VWYg==
X-Gm-Message-State: AOJu0YzeUSIsAWq8cy7+BISKtU1sEq4iF51yE9v0IEekgXpJjYeqjibl
        gk4TGeo8hWvVd0nGPzWcGBmiIzWJJsSxCmA=
X-Google-Smtp-Source: AGHT+IG9EmNIc3OuwDA74YbdStAfXrBUfbJ95Q586QG4aQVL4yTAR1zwO9YqpQL6NoY8TPSZ1RUBLbuCg1uwCvE=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:2b82:b0:5cb:ed68:a256 with SMTP
 id en2-20020a05690c2b8200b005cbed68a256mr609870ywb.4.1701276174047; Wed, 29
 Nov 2023 08:42:54 -0800 (PST)
Date:   Wed, 29 Nov 2023 16:42:51 +0000
In-Reply-To: <ZWdVEk4QjbpTfnbn@casper.infradead.org>
Mime-Version: 1.0
References: <ZWdVEk4QjbpTfnbn@casper.infradead.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129164251.3475162-1-aliceryhl@google.com>
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
From:   Alice Ryhl <aliceryhl@google.com>
To:     willy@infradead.org
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, arve@android.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org,
        cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz,
        gary@garyguo.net, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@android.com, ojeda@kernel.org, peterz@infradead.org,
        rust-for-linux@vger.kernel.org, surenb@google.com,
        tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
        wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org>
> I haven't looked at how Rust-for-Linux handles errors yet, but it's
> disappointing to see that it doesn't do something like the PTR_ERR /
> ERR_PTR / IS_ERR C thing under the hood.

It would be cool to do that, but we haven't written the infrastructure
to do that yet. (Note that in this particular case, the C function also
returns the error as a null pointer.)

>> @@ -157,6 +158,12 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
>>  }
>>  EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
>>  
>> +struct file *rust_helper_get_file(struct file *f)
>> +{
>> +	return get_file(f);
>> +}
>> +EXPORT_SYMBOL_GPL(rust_helper_get_file);
> 
> This is ridiculous.  A function call instead of doing the
> atomic_long_inc() in Rust?

I think there are two factors to consider here:

First, doing the atomic increment from Rust currently runs into the
memory model split between the C++ and LKMM memory models. It would be
like using the C11 atomic_fetch_add instead of the one that the Kernel
defines for LKMM using inline assembly. When I discussed this with Paul
McKenney, we were advised that its best to avoid mixing the memory
models.

Avoiding this would require that we replicate the inline assembly that C
uses to define its atomic operations on the Rust side. This is something
that I think should be done, but it hasn't been done yet.


Second, there's potentially an increased maintenance burden when C
methods are reimplemented in Rust. Any change to the implementation on
the C side would have to be reflected on the Rust side.

Alice
