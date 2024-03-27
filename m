Return-Path: <linux-kernel+bounces-121600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE03F88EAB8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575FE1F329D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E9C1442F0;
	Wed, 27 Mar 2024 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NZF/48Dz"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D6113C9B9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555454; cv=none; b=O2JzqA/GQPxkJ2w+lgwqpKlerDjjSQIY7w5FSTPgKF36xVzAt1EBOrpKK39l/lZ+mKunpG4ZvaMqljSFb8QTofwUjW0CrptFkDnx5Y6EFSCzAY8GlZog9xlZYtE37h+8zPpq76WeJxTqqdKH0DIdxLr01HtwEOyWNwsH53sdlCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555454; c=relaxed/simple;
	bh=EdLNzX8uuiq2CjNBfiXznOjIDyfPc5MSkqemwj47Fxc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Uvli65DF/5OomxNkr27+CHo1sQbR+d/GBTzXAn5iOha30/5VdthzyOwW2Vwi4lT+88yzydnXK5lw+kYafKXKtlPJtc8wmmDEmjXPSxe89bX+cnzsP/0XTo2WEXyTL+MlmM+Jbk4OYUtCXYLCpYa+sbYfVNR7kv2IpaJM0jQLejU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NZF/48Dz; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711555449; x=1711814649;
	bh=Ka2xa47AQ5Q73+6JzpnFAcof+BAgDh2tkVUlnUr2JVE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NZF/48Dzz7IZFkHGpV08pk9cJ7GI15CSkz6G7ljNb8L0GFu0DXubC+dd4sdTcXM3H
	 Xj1rhsJcVFBzolFWgok7ZIe0B05tC3TPi0SKfNy6W3AAqjJ5ygJg7e9TLl+y/gUGoB
	 fcOo4Blj81axwFF1KJ1btZKNtSy+DycpIeyFa5YlYpwu3NZKYqHV7aHFMTJESDbjDG
	 aLYPXQSnoT1//TjkkGBa7i43YDx3/yCsspZU62HNLzS7xhxXlFbs4YipRArvC7QJfd
	 R7pGm6y9hFfmem6wli+vHzpyKKqo0mz/s7tc4UwJPkV6s83FKmo2/SlogR/sX1Wkg2
	 2Ux5GFZ+Q3pww==
Date: Wed, 27 Mar 2024 16:04:03 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, Eric Curtin <ecurtin@redhat.com>, Neal Gompa <neal@gompa.dev>, Thomas Bertschinger <tahbertschinger@gmail.com>, Andrea Righi <andrea.righi@canonical.com>, Sumera Priyadarsini <sylphrenadin@gmail.com>, Finn Behrens <me@kloenk.dev>, Adam Bratschi-Kaye <ark.email@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: stable@vger.kernel.org, Daniel Xu <dxu@dxuuu.xyz>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rust: macros: fix soundness issue in `module!` macro
Message-ID: <20240327160346.22442-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The `module!` macro creates glue code that are called by C to initialize
the Rust modules using the `Module::init` function. Part of this glue
code are the local functions `__init` and `__exit` that are used to
initialize/destroy the Rust module.
These functions are safe and also visible to the Rust mod in which the
`module!` macro is invoked. This means that they can be called by other
safe Rust code. But since they contain `unsafe` blocks that rely on only
being called at the right time, this is a soundness issue.

Wrap these generated functions inside of two private modules, this
guarantees that the public functions cannot be called from the outside.
Make the safe functions `unsafe` and add SAFETY comments.

Cc: stable@vger.kernel.org
Closes: https://github.com/Rust-for-Linux/linux/issues/629
Fixes: 1fbde52bde73 ("rust: add `macros` crate")
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
This patch is best viewed with `git show --ignore-space-change`, since I
also adjusted the indentation.

 rust/macros/module.rs | 198 ++++++++++++++++++++++++------------------
 1 file changed, 112 insertions(+), 86 deletions(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 27979e582e4b..16c4921a08f2 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -199,103 +199,129 @@ pub(crate) fn module(ts: TokenStream) -> TokenStrea=
m {
             /// Used by the printing macros, e.g. [`info!`].
             const __LOG_PREFIX: &[u8] =3D b\"{name}\\0\";
=20
-            /// The \"Rust loadable module\" mark.
-            //
-            // This may be best done another way later on, e.g. as a new m=
odinfo
-            // key or a new section. For the moment, keep it simple.
-            #[cfg(MODULE)]
-            #[doc(hidden)]
-            #[used]
-            static __IS_RUST_MODULE: () =3D ();
-
-            static mut __MOD: Option<{type_}> =3D None;
-
-            // SAFETY: `__this_module` is constructed by the kernel at loa=
d time and will not be
-            // freed until the module is unloaded.
-            #[cfg(MODULE)]
-            static THIS_MODULE: kernel::ThisModule =3D unsafe {{
-                kernel::ThisModule::from_ptr(&kernel::bindings::__this_mod=
ule as *const _ as *mut _)
-            }};
-            #[cfg(not(MODULE))]
-            static THIS_MODULE: kernel::ThisModule =3D unsafe {{
-                kernel::ThisModule::from_ptr(core::ptr::null_mut())
-            }};
-
-            // Loadable modules need to export the `{{init,cleanup}}_modul=
e` identifiers.
-            /// # Safety
-            ///
-            /// This function must not be called after module initializati=
on, because it may be
-            /// freed after that completes.
-            #[cfg(MODULE)]
-            #[doc(hidden)]
-            #[no_mangle]
-            #[link_section =3D \".init.text\"]
-            pub unsafe extern \"C\" fn init_module() -> core::ffi::c_int {=
{
-                __init()
-            }}
+            // Double nested modules, since then nobody can access the pub=
lic items inside.
+            mod __module_init {{
+                mod __module_init {{
+                    use super::super::{type_};
+
+                    /// The \"Rust loadable module\" mark.
+                    //
+                    // This may be best done another way later on, e.g. as=
 a new modinfo
+                    // key or a new section. For the moment, keep it simpl=
e.
+                    #[cfg(MODULE)]
+                    #[doc(hidden)]
+                    #[used]
+                    static __IS_RUST_MODULE: () =3D ();
+
+                    static mut __MOD: Option<{type_}> =3D None;
+
+                    // SAFETY: `__this_module` is constructed by the kerne=
l at load time and will not be
+                    // freed until the module is unloaded.
+                    #[cfg(MODULE)]
+                    static THIS_MODULE: kernel::ThisModule =3D unsafe {{
+                        kernel::ThisModule::from_ptr(&kernel::bindings::__=
this_module as *const _ as *mut _)
+                    }};
+                    #[cfg(not(MODULE))]
+                    static THIS_MODULE: kernel::ThisModule =3D unsafe {{
+                        kernel::ThisModule::from_ptr(core::ptr::null_mut()=
)
+                    }};
+
+                    // Loadable modules need to export the `{{init,cleanup=
}}_module` identifiers.
+                    /// # Safety
+                    ///
+                    /// This function must not be called after module init=
ialization, because it may be
+                    /// freed after that completes.
+                    #[cfg(MODULE)]
+                    #[doc(hidden)]
+                    #[no_mangle]
+                    #[link_section =3D \".init.text\"]
+                    pub unsafe extern \"C\" fn init_module() -> core::ffi:=
:c_int {{
+                        __init()
+                    }}
=20
-            #[cfg(MODULE)]
-            #[doc(hidden)]
-            #[no_mangle]
-            pub extern \"C\" fn cleanup_module() {{
-                __exit()
-            }}
+                    #[cfg(MODULE)]
+                    #[doc(hidden)]
+                    #[no_mangle]
+                    pub extern \"C\" fn cleanup_module() {{
+                        __exit()
+                    }}
=20
-            // Built-in modules are initialized through an initcall pointe=
r
-            // and the identifiers need to be unique.
-            #[cfg(not(MODULE))]
-            #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
-            #[doc(hidden)]
-            #[link_section =3D \"{initcall_section}\"]
-            #[used]
-            pub static __{name}_initcall: extern \"C\" fn() -> core::ffi::=
c_int =3D __{name}_init;
-
-            #[cfg(not(MODULE))]
-            #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
-            core::arch::global_asm!(
-                r#\".section \"{initcall_section}\", \"a\"
-                __{name}_initcall:
-                    .long   __{name}_init - .
-                    .previous
-                \"#
-            );
+                    // Built-in modules are initialized through an initcal=
l pointer
+                    // and the identifiers need to be unique.
+                    #[cfg(not(MODULE))]
+                    #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
+                    #[doc(hidden)]
+                    #[link_section =3D \"{initcall_section}\"]
+                    #[used]
+                    pub static __{name}_initcall: extern \"C\" fn() -> cor=
e::ffi::c_int =3D __{name}_init;
+
+                    #[cfg(not(MODULE))]
+                    #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
+                    core::arch::global_asm!(
+                        r#\".section \"{initcall_section}\", \"a\"
+                        __{name}_initcall:
+                            .long   __{name}_init - .
+                            .previous
+                        \"#
+                    );
+
+                    #[cfg(not(MODULE))]
+                    #[doc(hidden)]
+                    #[no_mangle]
+                    pub extern \"C\" fn __{name}_init() -> core::ffi::c_in=
t {{
+                        __init()
+                    }}
=20
-            #[cfg(not(MODULE))]
-            #[doc(hidden)]
-            #[no_mangle]
-            pub extern \"C\" fn __{name}_init() -> core::ffi::c_int {{
-                __init()
-            }}
+                    #[cfg(not(MODULE))]
+                    #[doc(hidden)]
+                    #[no_mangle]
+                    pub extern \"C\" fn __{name}_exit() {{
+                        __exit()
+                    }}
=20
-            #[cfg(not(MODULE))]
-            #[doc(hidden)]
-            #[no_mangle]
-            pub extern \"C\" fn __{name}_exit() {{
-                __exit()
-            }}
+                    /// # Safety
+                    ///
+                    /// This function must
+                    /// - only be called once,
+                    /// - not be called concurrently with `__exit`.
+                    unsafe fn __init() -> core::ffi::c_int {{
+                        match <{type_} as kernel::Module>::init(&THIS_MODU=
LE) {{
+                            Ok(m) =3D> {{
+                                // SAFETY:
+                                // no data race, since `__MOD` can only be=
 accessed by this module and
+                                // there only `__init` and `__exit` access=
 it. These functions are only
+                                // called once and `__exit` cannot be call=
ed before or during `__init`.
+                                unsafe {{
+                                    __MOD =3D Some(m);
+                                }}
+                                return 0;
+                            }}
+                            Err(e) =3D> {{
+                                return e.to_errno();
+                            }}
+                        }}
+                    }}
=20
-            fn __init() -> core::ffi::c_int {{
-                match <{type_} as kernel::Module>::init(&THIS_MODULE) {{
-                    Ok(m) =3D> {{
+                    /// # Safety
+                    ///
+                    /// This function must
+                    /// - only be called once,
+                    /// - be called after `__init`,
+                    /// - not be called concurrently with `__init`.
+                    unsafe fn __exit() {{
+                        // SAFETY:
+                        // no data race, since `__MOD` can only be accesse=
d by this module and there
+                        // only `__init` and `__exit` access it. These fun=
ctions are only called once
+                        // and `__init` was already called.
                         unsafe {{
-                            __MOD =3D Some(m);
+                            // Invokes `drop()` on `__MOD`, which should b=
e used for cleanup.
+                            __MOD =3D None;
                         }}
-                        return 0;
                     }}
-                    Err(e) =3D> {{
-                        return e.to_errno();
-                    }}
-                }}
-            }}
=20
-            fn __exit() {{
-                unsafe {{
-                    // Invokes `drop()` on `__MOD`, which should be used f=
or cleanup.
-                    __MOD =3D None;
+                    {modinfo}
                 }}
             }}
-
-            {modinfo}
         ",
         type_ =3D info.type_,
         name =3D info.name,

base-commit: 4cece764965020c22cff7665b18a012006359095
--=20
2.44.0



