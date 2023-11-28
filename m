Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CF67FC842
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346424AbjK1VWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjK1VW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:22:26 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAC3702D;
        Tue, 28 Nov 2023 13:15:26 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d8481094f9so462173a34.3;
        Tue, 28 Nov 2023 13:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701206125; x=1701810925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYGeGxwvP4zgewWY4tPSKkyU/J+6cz2JzDo98pXJQOU=;
        b=joBAZ4ANHhPYcp9N8nXAEzVwzCEps/9U/xSjaa63oGPYnecHvfqU2t7E+fP0AMk+We
         uLai1bNexJmKeKHGgEoXfgeKmP2SadAkOWuMHodKTSn3ipLU4izZuP+ZsgbLvCmXA9g1
         XDQxc5dezjvnl6NhfyR0UW+MSOCtD4KcoW1dZSgfUJeshyLF3KGQOoa/Xp3v84QLfaA/
         gZgUoYI8cbQlzva7PMILtq3Nj294ydTYCWmMzMy6+rVAPchYFPN/pKE2wLartaf3v1hr
         7uPTY6WTmQ44Exr9l0GtU6LDs1yp+srE/sLpLxkUDpHYKOPVic7ksKOfx6ULqI88piKN
         Z1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701206125; x=1701810925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYGeGxwvP4zgewWY4tPSKkyU/J+6cz2JzDo98pXJQOU=;
        b=TsD+CIiBups34Ut/EU/t6yczdBWPyMaIUBO2SkqL7/tKEBsw5sPHqiz+FQhSiBCh1h
         xW6+J6oFxqIxmMhQC1I7o1Bo4cLYLZOi5h91Ts9BcSLnnx3Jb/TRMfGHYqc5/z4zvd1k
         hSHi6/8IfBA/YUwgi9OPmXP5TPA3Xmnomtxe7H3/7PRf76UtCVSvfa4R8SPKQQSqhcJw
         ZDSrdbupcT4FxhlO139nEJ5VkBofCfmldo6U8wBMZWXfL2qh2cEU9CJDderm8p0DRzG5
         ndY3eHmAa6sJYKHV3roWVNC72v474wV5Mqc58JYtrQgKXw1uWbX47+5K3gQCGRQH642l
         6ZEQ==
X-Gm-Message-State: AOJu0YyVmSZ8zkLa2sDNawmfy5UI8xVLmtvlRSPUboDUmpCEC0a9p80F
        77A7GaZL1Mas3DrF/Bu7UpKreuGaCxY=
X-Google-Smtp-Source: AGHT+IGm8IcuZk20HQ42Qa8i4nfFsIlF43BqKv5opH8D4U7d/F/Cq5gGn2o1mSxRMIAgXzvTRDC7Sw==
X-Received: by 2002:a05:6830:1ce:b0:6b9:14bf:7097 with SMTP id r14-20020a05683001ce00b006b914bf7097mr18863142ota.9.1701206125520;
        Tue, 28 Nov 2023 13:15:25 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id e9-20020a0562140d8900b0067a5e43fc98sm641464qve.137.2023.11.28.13.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:15:25 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4A3B027C0054;
        Tue, 28 Nov 2023 16:15:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 28 Nov 2023 16:15:24 -0500
X-ME-Sender: <xms:a1hmZceyFUkaWUPVG0KkcM_UNcODPOCMbljTheyrLmzzokZtQopVLA>
    <xme:a1hmZeMERkYID30r9akKorbcmZ9qXkFMvJsrVMQACUtfrlgyMGG99pVfvTSNpCFan
    i_bh3j-rMKiIOgCvA>
X-ME-Received: <xmr:a1hmZdhe2CZ5f4O24sg5Q2MfapXy3xYabXMO9vP_e0QtKtGRk2gsv8ueuvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepjeffgeeijedvtdfgkeekhfejgeejveeuudfgheeftdekffejtdelieeu
    hfdvfeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:a1hmZR_eWfNIORddNq3LA-eNjl6Dlw5KeJu0l-ViQQbfHgzc-S7mWg>
    <xmx:a1hmZYsxqz1ra2ILQk8qGZJKwDI8uZ1Zvjo6WIMNLUnvNYe_uYHeEA>
    <xmx:a1hmZYGWcccqTGZmgKKVHYC0EULyN2WCR24-M2_0KIgOmahHaVDbXw>
    <xmx:bFhmZTnIaZxxgQMId9nYlILQgI6geqhy_qUWWPxPhYWD3XwZ79tZwQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 16:15:23 -0500 (EST)
Date:   Tue, 28 Nov 2023 13:14:41 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Jamie.Cunliffe@arm.com, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>, will@kernel.org,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] rust: Suppress searching builtin sysroot
Message-ID: <ZWZYQbxWmLdwAska@boqun-archlinux>
References: <20231031201752.1189213-1-mmaurer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031201752.1189213-1-mmaurer@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Catalin as well]

On Tue, Oct 31, 2023 at 08:10:14PM +0000, Matthew Maurer wrote:
> By default, if Rust is passed `--target=foo` rather than a target.json
> file, it will infer a default sysroot if that component is installed. As
> the proposed aarch64 support uses `aarch64-unknown-none` rather than a
> target.json file, this is needed to prevent rustc from being confused
> between the custom kernel sysroot and the pre-installed one.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
> 
> This patch is prompted by the issue I encountered at
> https://lore.kernel.org/all/CAGSQo01pOixiPXkW867h4vPUaAjtKtHGKhkV-rpifJvKxAf4Ww@mail.gmail.com/
> but should be generically more hermetic even if we don't end up landing
> that patch.
> 

I'm able to reproduce the issue you mentioned here after
`rustup target add aarch64-unknown-none`, and your patch fixed that.

Tested-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

>  rust/Makefile          | 1 +
>  scripts/Makefile.build | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/rust/Makefile b/rust/Makefile
> index a27f35f924ec..0403e88e19fd 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -400,6 +400,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
>  		--emit=metadata=$(dir $@)$(patsubst %.o,lib%.rmeta,$(notdir $@)) \
>  		--crate-type rlib -L$(objtree)/$(obj) \
>  		--crate-name $(patsubst %.o,%,$(notdir $@)) $< \
> +		--sysroot=/dev/null \
>  	$(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@)
>  
>  rust-analyzer:
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 82e3fb19fdaf..6e4ee513cc3c 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -275,6 +275,7 @@ rust_common_cmd = \
>  	--extern alloc --extern kernel \
>  	--crate-type rlib -L $(objtree)/rust/ \
>  	--crate-name $(basename $(notdir $@)) \
> +	--sysroot=/dev/null \
>  	--out-dir $(dir $@) --emit=dep-info=$(depfile)
>  
>  # `--emit=obj`, `--emit=asm` and `--emit=llvm-ir` imply a single codegen unit
> -- 
> 2.42.0.820.g83a721a137-goog
> 
