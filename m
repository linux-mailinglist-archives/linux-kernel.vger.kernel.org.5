Return-Path: <linux-kernel+bounces-125916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE423892E2A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 03:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723371F21723
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 01:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51583110A;
	Sun, 31 Mar 2024 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkvlUhWD"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7221E384;
	Sun, 31 Mar 2024 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711846827; cv=none; b=aePs3M5bKj5OEcNhSTSZK+f/+CkbzPXgHTCYKT3Nubp62FcaZ+dHvI11gu/q7s0wg0KCarrM4qnUXufULigeKupRrErmfJxkq9HcVoUfhuyE33RQWxjL0qIzHloU0tA3R+bTtYYRJD950IVO7zIErmDdFDeNf/mGka7e/n1oL5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711846827; c=relaxed/simple;
	bh=agGyqSp8yNTG1GAE1CtKHLCY7aRSMpm/uPMzneJbDVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbNeU8P2ve6Pnydp8bmXXn5KlUb2+vMN/CWL6L+jCIVYMzuA7g5OUJ7HvxTT3cRNY6fcLOsKit7pzBE+xLNpPlQRJcIcYsNaTFDUzZxCu6S60k2GG/zRNxThTNYReKSS1/l5qiM1PUPavytn+0NvSwK5bXSpvZlZBX8+JjaBuys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkvlUhWD; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso2680872276.1;
        Sat, 30 Mar 2024 18:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711846824; x=1712451624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6MqME2XQgc4Qut7Iip84kiqfVPG2RkgjI8rYdmVwJQ=;
        b=mkvlUhWDfxJzyyEMEHMthlWnYUawsEeBSUE5CBrmHykTwwfq7OjBxUVX2e77t5Z4P9
         62fKI4lmu/E0vc3EkSWBWPkArHmfNCZwAUl1OLszgWqAVOfB9ngXRpT52VV8vNAalE7+
         nXuWbL/gz9R+aDP+7aNrGp9W/C7sOouF5HPTqEG8iS92uhKa9jDIQEvRUwM9lTbkJLF1
         mb2zdv2fkdhfsCgP62HLRvgv2peAS2BM6tto5BmTIkDDhniAcvmCg74PqSUvjroQtMdT
         ZoJV8Y95VId77DUeX8XW+K138lgvQvLmP1dGbtnchE/13EXIzMQ51yQo3dGMaqEeOxQU
         2X9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711846824; x=1712451624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6MqME2XQgc4Qut7Iip84kiqfVPG2RkgjI8rYdmVwJQ=;
        b=tvE3uJKKi+4ByXKdwBoPXxLonNhM6RXWhZsu3VNEivO+JOlVeRCGddYZ3It1Bchx9v
         BnikvMgYWhIP87Xys2wqnn8BKpjNNDb/Igalg92RV5HsqRibv2iGnO4yEgMKRVeIF91b
         A6x2FaPljDNtFlILmY+IgKcZpdBoAMT0BJRKT9/ztlFa2agQgSh7GtPG+BPeziGcJATv
         xBU8sGFmBxIKOFm8CeUVLg+AeSznPyhybA4ucISwzZ5nsBwhZhwvJgKaGpfv/nKM49x7
         UYhgErL9u0Vfjz6tobaEBdUF8xmkmk9rhhmI4hFz8EZspJgQLJHgWnb/nR4+wz4P+Xjn
         1ukA==
X-Forwarded-Encrypted: i=1; AJvYcCUKcZlrMZjI5ay4ZO2WoY/7KX1DGi5J1iHvYZN2LAMkGEMQ7QKfB4Km5cc0vlkIJSLtVK6eEgqOEg8nIHOwE4dqWWtNO69cPTFufyHq0PGprjXc+O5CjydtMJpcRsYNPRw11FGxI/iCYbjKQVjL172Xh0dRYcEeBuj28CPVzsiL997fxi0=
X-Gm-Message-State: AOJu0YxZBvvRSVJqIOZ3TR0m6q3OehzuphbiwKycfsIC6QzP/lqg3+w/
	l2E4iMCWPubifgbVCjt0y1FbhtbfSasDszeOmkFJUh/KLyJmWwo//MbG+tJRleeE3KJGsibwUea
	M93U0nEhjriVRYrRsi4SgNX/sXToJeQd7
X-Google-Smtp-Source: AGHT+IHpQBJCDqSri8CkfiD6udztDu5P7bvJb0iY32W77uyQHseHeCE29KXJTy5YW56EyX/BbGi9rpidXlu8UvNep9c=
X-Received: by 2002:a25:6642:0:b0:dc7:4546:d107 with SMTP id
 z2-20020a256642000000b00dc74546d107mr5209624ybm.23.1711846824294; Sat, 30 Mar
 2024 18:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327160346.22442-1-benno.lossin@proton.me>
In-Reply-To: <20240327160346.22442-1-benno.lossin@proton.me>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Sat, 30 Mar 2024 22:00:13 -0300
Message-ID: <CANeycqp0o-HKBx6nuGCy9DD6mAwoGWzTR6bm5ceajsUhKcZuQg@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: fix soundness issue in `module!` macro
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, 
	Eric Curtin <ecurtin@redhat.com>, Neal Gompa <neal@gompa.dev>, 
	Thomas Bertschinger <tahbertschinger@gmail.com>, Andrea Righi <andrea.righi@canonical.com>, 
	Sumera Priyadarsini <sylphrenadin@gmail.com>, Finn Behrens <me@kloenk.dev>, 
	Adam Bratschi-Kaye <ark.email@gmail.com>, stable@vger.kernel.org, Daniel Xu <dxu@dxuuu.xyz>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 13:04, Benno Lossin <benno.lossin@proton.me> wrote:
>
> The `module!` macro creates glue code that are called by C to initialize
> the Rust modules using the `Module::init` function. Part of this glue
> code are the local functions `__init` and `__exit` that are used to
> initialize/destroy the Rust module.
> These functions are safe and also visible to the Rust mod in which the
> `module!` macro is invoked. This means that they can be called by other
> safe Rust code. But since they contain `unsafe` blocks that rely on only
> being called at the right time, this is a soundness issue.
>
> Wrap these generated functions inside of two private modules, this
> guarantees that the public functions cannot be called from the outside.
> Make the safe functions `unsafe` and add SAFETY comments.
>
> Cc: stable@vger.kernel.org
> Closes: https://github.com/Rust-for-Linux/linux/issues/629
> Fixes: 1fbde52bde73 ("rust: add `macros` crate")
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> This patch is best viewed with `git show --ignore-space-change`, since I
> also adjusted the indentation.
>
>  rust/macros/module.rs | 198 ++++++++++++++++++++++++------------------
>  1 file changed, 112 insertions(+), 86 deletions(-)
>
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 27979e582e4b..16c4921a08f2 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -199,103 +199,129 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
>              /// Used by the printing macros, e.g. [`info!`].
>              const __LOG_PREFIX: &[u8] = b\"{name}\\0\";
>
> -            /// The \"Rust loadable module\" mark.
> -            //
> -            // This may be best done another way later on, e.g. as a new modinfo
> -            // key or a new section. For the moment, keep it simple.
> -            #[cfg(MODULE)]
> -            #[doc(hidden)]
> -            #[used]
> -            static __IS_RUST_MODULE: () = ();
> -
> -            static mut __MOD: Option<{type_}> = None;
> -
> -            // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
> -            // freed until the module is unloaded.
> -            #[cfg(MODULE)]
> -            static THIS_MODULE: kernel::ThisModule = unsafe {{
> -                kernel::ThisModule::from_ptr(&kernel::bindings::__this_module as *const _ as *mut _)
> -            }};
> -            #[cfg(not(MODULE))]
> -            static THIS_MODULE: kernel::ThisModule = unsafe {{
> -                kernel::ThisModule::from_ptr(core::ptr::null_mut())
> -            }};
> -
> -            // Loadable modules need to export the `{{init,cleanup}}_module` identifiers.
> -            /// # Safety
> -            ///
> -            /// This function must not be called after module initialization, because it may be
> -            /// freed after that completes.
> -            #[cfg(MODULE)]
> -            #[doc(hidden)]
> -            #[no_mangle]
> -            #[link_section = \".init.text\"]
> -            pub unsafe extern \"C\" fn init_module() -> core::ffi::c_int {{
> -                __init()
> -            }}
> +            // Double nested modules, since then nobody can access the public items inside.
> +            mod __module_init {{
> +                mod __module_init {{
> +                    use super::super::{type_};
> +
> +                    /// The \"Rust loadable module\" mark.
> +                    //
> +                    // This may be best done another way later on, e.g. as a new modinfo
> +                    // key or a new section. For the moment, keep it simple.
> +                    #[cfg(MODULE)]
> +                    #[doc(hidden)]
> +                    #[used]
> +                    static __IS_RUST_MODULE: () = ();
> +
> +                    static mut __MOD: Option<{type_}> = None;
> +
> +                    // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
> +                    // freed until the module is unloaded.
> +                    #[cfg(MODULE)]
> +                    static THIS_MODULE: kernel::ThisModule = unsafe {{
> +                        kernel::ThisModule::from_ptr(&kernel::bindings::__this_module as *const _ as *mut _)
> +                    }};
> +                    #[cfg(not(MODULE))]
> +                    static THIS_MODULE: kernel::ThisModule = unsafe {{
> +                        kernel::ThisModule::from_ptr(core::ptr::null_mut())
> +                    }};
> +
> +                    // Loadable modules need to export the `{{init,cleanup}}_module` identifiers.
> +                    /// # Safety
> +                    ///
> +                    /// This function must not be called after module initialization, because it may be
> +                    /// freed after that completes.
> +                    #[cfg(MODULE)]
> +                    #[doc(hidden)]
> +                    #[no_mangle]
> +                    #[link_section = \".init.text\"]
> +                    pub unsafe extern \"C\" fn init_module() -> core::ffi::c_int {{
> +                        __init()
> +                    }}
>
> -            #[cfg(MODULE)]
> -            #[doc(hidden)]
> -            #[no_mangle]
> -            pub extern \"C\" fn cleanup_module() {{
> -                __exit()
> -            }}
> +                    #[cfg(MODULE)]
> +                    #[doc(hidden)]
> +                    #[no_mangle]
> +                    pub extern \"C\" fn cleanup_module() {{
> +                        __exit()
> +                    }}
>
> -            // Built-in modules are initialized through an initcall pointer
> -            // and the identifiers need to be unique.
> -            #[cfg(not(MODULE))]
> -            #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
> -            #[doc(hidden)]
> -            #[link_section = \"{initcall_section}\"]
> -            #[used]
> -            pub static __{name}_initcall: extern \"C\" fn() -> core::ffi::c_int = __{name}_init;
> -
> -            #[cfg(not(MODULE))]
> -            #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
> -            core::arch::global_asm!(
> -                r#\".section \"{initcall_section}\", \"a\"
> -                __{name}_initcall:
> -                    .long   __{name}_init - .
> -                    .previous
> -                \"#
> -            );
> +                    // Built-in modules are initialized through an initcall pointer
> +                    // and the identifiers need to be unique.
> +                    #[cfg(not(MODULE))]
> +                    #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
> +                    #[doc(hidden)]
> +                    #[link_section = \"{initcall_section}\"]
> +                    #[used]
> +                    pub static __{name}_initcall: extern \"C\" fn() -> core::ffi::c_int = __{name}_init;
> +
> +                    #[cfg(not(MODULE))]
> +                    #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
> +                    core::arch::global_asm!(
> +                        r#\".section \"{initcall_section}\", \"a\"
> +                        __{name}_initcall:
> +                            .long   __{name}_init - .
> +                            .previous
> +                        \"#
> +                    );
> +
> +                    #[cfg(not(MODULE))]
> +                    #[doc(hidden)]
> +                    #[no_mangle]
> +                    pub extern \"C\" fn __{name}_init() -> core::ffi::c_int {{
> +                        __init()
> +                    }}
>
> -            #[cfg(not(MODULE))]
> -            #[doc(hidden)]
> -            #[no_mangle]
> -            pub extern \"C\" fn __{name}_init() -> core::ffi::c_int {{
> -                __init()
> -            }}
> +                    #[cfg(not(MODULE))]
> +                    #[doc(hidden)]
> +                    #[no_mangle]
> +                    pub extern \"C\" fn __{name}_exit() {{
> +                        __exit()
> +                    }}
>
> -            #[cfg(not(MODULE))]
> -            #[doc(hidden)]
> -            #[no_mangle]
> -            pub extern \"C\" fn __{name}_exit() {{
> -                __exit()
> -            }}
> +                    /// # Safety
> +                    ///
> +                    /// This function must
> +                    /// - only be called once,
> +                    /// - not be called concurrently with `__exit`.

I don't think the second item is needed here, it really is a
requirement on `__exit`.

> +                    unsafe fn __init() -> core::ffi::c_int {{
> +                        match <{type_} as kernel::Module>::init(&THIS_MODULE) {{
> +                            Ok(m) => {{
> +                                // SAFETY:
> +                                // no data race, since `__MOD` can only be accessed by this module and
> +                                // there only `__init` and `__exit` access it. These functions are only
> +                                // called once and `__exit` cannot be called before or during `__init`.
> +                                unsafe {{
> +                                    __MOD = Some(m);
> +                                }}
> +                                return 0;
> +                            }}
> +                            Err(e) => {{
> +                                return e.to_errno();
> +                            }}
> +                        }}
> +                    }}
>
> -            fn __init() -> core::ffi::c_int {{
> -                match <{type_} as kernel::Module>::init(&THIS_MODULE) {{
> -                    Ok(m) => {{
> +                    /// # Safety
> +                    ///
> +                    /// This function must
> +                    /// - only be called once,
> +                    /// - be called after `__init`,
> +                    /// - not be called concurrently with `__init`.

The second item is incomplete: it must be called after `__init` *succeeds*.

With that added (which is a different precondition), I think the third
item can be dropped because if you have to wait to see whether
`__init` succeeded or failed before you can call `__exit`, then
certainly you cannot call it concurrently with `__init`.

> +                    unsafe fn __exit() {{
> +                        // SAFETY:
> +                        // no data race, since `__MOD` can only be accessed by this module and there
> +                        // only `__init` and `__exit` access it. These functions are only called once
> +                        // and `__init` was already called.
>                          unsafe {{
> -                            __MOD = Some(m);
> +                            // Invokes `drop()` on `__MOD`, which should be used for cleanup.
> +                            __MOD = None;
>                          }}
> -                        return 0;
>                      }}
> -                    Err(e) => {{
> -                        return e.to_errno();
> -                    }}
> -                }}
> -            }}
>
> -            fn __exit() {{
> -                unsafe {{
> -                    // Invokes `drop()` on `__MOD`, which should be used for cleanup.
> -                    __MOD = None;
> +                    {modinfo}
>                  }}
>              }}
> -
> -            {modinfo}
>          ",
>          type_ = info.type_,
>          name = info.name,
>
> base-commit: 4cece764965020c22cff7665b18a012006359095
> --
> 2.44.0
>
>

