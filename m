Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA8F77B55E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbjHNJZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbjHNJYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:24:35 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F87E58;
        Mon, 14 Aug 2023 02:24:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5234f46c6f9so5420826a12.3;
        Mon, 14 Aug 2023 02:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692005070; x=1692609870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSuMTLIqOK8XQhnIPkVgfTRr/qLwInZFJV8fjiSPOQk=;
        b=P8n9xTYdBaZF+QFr+rs6LXf9ov7sIEIbEVU9MjF0SHrrA82S6OBV/r0XShUThmgVnk
         3oX+vZjNt1kny6Y9zHRL7dZjnEdPaiL6I2m7JnwQpPqZFI2gK1OSrdhUwMJzzfWVPtne
         nmgTzPlAmpi54Y+trMp6POss7jtihXgimbuFP8mIBa1+nr2JhUIenMAi4R8N/N3xp+lg
         YX8iVea0S3xxRMG5wvtC8VIL53vPzq7CBN5dZgqiMwPRaU5OFEi2Im/GmJkR9EWBbTMl
         cjVTlY7WA2oahcNvVBYhYCWC2YCT75zk3j7ctXJUqTqrkBNqo9n/C5wgFn5stki1WTsL
         gD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692005070; x=1692609870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSuMTLIqOK8XQhnIPkVgfTRr/qLwInZFJV8fjiSPOQk=;
        b=XFXmkYvzpk7uFs0JNeEMUZDaxZP4ap3pWDC2DX6dyTJzS2ffglMMqKxyv4IWcn4mQz
         aZQ59OVk4QwfU4jmquxwfpG1xtzpDCrk9/3YvJo1J53AA+wpbKwWZEJKg34Xro+3VokO
         vflhXYDem+QPKvEaZkbgikHStKa6HPs+6IfZUWXiEDloYeAV5PFnJjzDt7IPbtbUZDQH
         gSNIvdtfyuZb6lfCrZsfPSK1DegdNjA97cFux/4gJl4y/Oe4lHmm0QmN1kkifyCJi/Z+
         MRfQxoedhTlq3LlcIVfID5OpOjndgSkj/n8dXdSFjBOwVv6QGXSGnyl800qkQZ0p5wvP
         KqhA==
X-Gm-Message-State: AOJu0YyvSaMpOk+ICyFMLli5eGYDZMPwyO2fg5RyGQRyJqHtiqTLdbiF
        1nPHR+JW/OVY8U3hWOdO5ro=
X-Google-Smtp-Source: AGHT+IEHXloJ852GBi+ZQDurQkUMVO+cgPXpyIvz/6IooYdZ2bddvZZ+ybxZy/BMSNmgSHZZktEh4w==
X-Received: by 2002:aa7:de0d:0:b0:523:3ff6:dfc2 with SMTP id h13-20020aa7de0d000000b005233ff6dfc2mr6691154edv.29.1692005069615;
        Mon, 14 Aug 2023 02:24:29 -0700 (PDT)
Received: from micheledallerive.home ([2a02:1210:6051:ec00:61e9:3767:83a6:9bd9])
        by smtp.gmail.com with ESMTPSA id b5-20020aa7c6c5000000b005224d960e66sm5314879eds.96.2023.08.14.02.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 02:24:29 -0700 (PDT)
From:   Michele Dalle Rive <dallerivemichele@gmail.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Davide Rovelli <davide.rovelli@usi.ch>,
        rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Michele Dalle Rive <dallerivemichele@gmail.com>
Subject: [RFC PATCH 5/7] rust: net: implement socket options API.
Date:   Mon, 14 Aug 2023 11:23:00 +0200
Message-ID: <20230814092302.1903203-6-dallerivemichele@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814092302.1903203-1-dallerivemichele@gmail.com>
References: <20230814092302.1903203-1-dallerivemichele@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create socket `Option`s and `set_option` function in the `Socket`
abstraction.

These changes introduce wrappers and functions to handle socket options
in Rust, with compilation-time advantages compared to the C API:
- Type safety: A specific option accepts only a value of the correct
  type.
- Read/write safety: A read-only option cannot be set.
- Coherence safety: An option of, for example, IP level cannot be set by
  specifying another level.

The downside of using options in the kernel is the lack of functions to
get the value of an option. For this reason, in Rust, kernel options can
only be set, but not retrieved.

Everything that can be done by socket options can actually be done
through helper functions, or by accessing directly the specific fields.
However, since the Rust-wrapped structures are few, it can be useful to
have options in order to still be able to modify the behaviour of the
socket.

As specified in the documentation of `opts.rs`, options could (and
should) be removed when the Rust API will be developed enough.

Signed-off-by: Michele Dalle Rive <dallerivemichele@gmail.com>
---
Does this even make sense? I have been struggling figuring out whether
having socket options is reasonable.
As described in the message, I think that even if it just limited to
setting options, it could be useful: Rust support is very limited, and
having some freedom over the socket is better than having none.

Now, does the implementation make sense? If I had to implement options I
wanted to at least make the most out of Rust, trying to make them
type-safe and "read/write" safe. The result is effective for sure, but
the code might end up being a bit ugly. I preferred using a macro to 
implement the code, because implementing each trait for each option
would have been a huge amount of repeated code.

 rust/kernel/net/socket.rs      |   91 +++
 rust/kernel/net/socket/opts.rs | 1222 ++++++++++++++++++++++++++++++++
 2 files changed, 1313 insertions(+)
 create mode 100644 rust/kernel/net/socket/opts.rs

diff --git a/rust/kernel/net/socket.rs b/rust/kernel/net/socket.rs
index 8396ce4b83a8..1a7b3f7d8fc0 100644
--- a/rust/kernel/net/socket.rs
+++ b/rust/kernel/net/socket.rs
@@ -16,9 +16,14 @@
 use crate::error::{to_result, Result};
 use crate::net::addr::*;
 use crate::net::ip::IpProtocol;
+use crate::net::socket::opts::{OptionsLevel, WritableOption};
+use core::cmp::max;
+use core::marker::PhantomData;
 use flags::*;
+use kernel::net::socket::opts::SocketOption;
 
 pub mod flags;
+pub mod opts;
 
 /// The socket type.
 pub enum SockType {
@@ -470,6 +475,72 @@ pub fn send_to(
         };
         self.send_msg(bytes, message, flags)
     }
+
+    /// Sets an option on the socket.
+    ///
+    /// Wraps the `sock_setsockopt` function.
+    ///
+    /// The generic type `T` is the type of the option value.
+    /// See the [options module](opts) for the type and extra information about each option.
+    ///
+    /// Unfortunately, options can only be set but not retrieved.
+    /// This is because the kernel functions to retrieve options are not exported by the kernel.
+    /// The only exported functions accept user-space pointers, and are therefore not usable in the kernel.
+    ///
+    /// # Example
+    /// ```
+    /// use kernel::net::AddressFamily;
+    /// use kernel::net::ip::IpProtocol;use kernel::net::socket::{Socket, SockType};
+    /// use kernel::net::socket::opts;
+    ///
+    /// let socket = Socket::new(AddressFamily::Inet, SockType::Datagram, IpProtocol::Udp)?;
+    /// socket.set_option::<opts::ip::BindAddressNoPort>(true)?;
+    /// ```
+    pub fn set_option<O>(&self, value: impl Into<O::Type>) -> Result
+    where
+        O: SocketOption + WritableOption,
+    {
+        let value_ptr = SockPtr::new(&value);
+
+        // The minimum size is the size of an integer.
+        let min_size = core::mem::size_of::<core::ffi::c_int>();
+        let size = max(core::mem::size_of::<O::Type>(), min_size);
+
+        if O::level() == OptionsLevel::Socket && !self.has_flag(SocketFlag::CustomSockOpt) {
+            // SAFETY: FFI call;
+            // the address is valid for the lifetime of the wrapper;
+            // the size is at least the size of an integer;
+            // the level and name of the option are valid and coherent.
+            to_result(unsafe {
+                bindings::sock_setsockopt(
+                    self.0,
+                    O::level() as isize as _,
+                    O::value() as _,
+                    value_ptr.to_raw() as _,
+                    size as _,
+                )
+            })
+        } else {
+            // SAFETY: FFI call;
+            // the address is valid for the lifetime of the wrapper;
+            // the size is at least the size of an integer;
+            // the level and name of the option are valid and coherent.
+            to_result(unsafe {
+                (*(*self.0).ops)
+                    .setsockopt
+                    .map(|f| {
+                        f(
+                            self.0,
+                            O::level() as _,
+                            O::value() as _,
+                            value_ptr.to_raw() as _,
+                            size as _,
+                        )
+                    })
+                    .unwrap_or(-(bindings::EOPNOTSUPP as i32))
+            })
+        }
+    }
 }
 
 impl Drop for Socket {
@@ -548,3 +619,23 @@ fn from(hdr: MessageHeader) -> Self {
         hdr.0
     }
 }
+
+#[derive(Clone, Copy)]
+#[repr(transparent)]
+struct SockPtr<'a>(bindings::sockptr_t, PhantomData<&'a ()>);
+
+impl<'a> SockPtr<'a> {
+    fn new<T>(value: &'a T) -> Self
+    where
+        T: Sized,
+    {
+        let mut sockptr = bindings::sockptr_t::default();
+        sockptr.__bindgen_anon_1.kernel = value as *const T as _;
+        sockptr._bitfield_1 = bindings::__BindgenBitfieldUnit::new([1; 1usize]); // kernel ptr
+        SockPtr(sockptr, PhantomData)
+    }
+
+    fn to_raw(self) -> bindings::sockptr_t {
+        self.0
+    }
+}
diff --git a/rust/kernel/net/socket/opts.rs b/rust/kernel/net/socket/opts.rs
new file mode 100644
index 000000000000..6ca8ac35b305
--- /dev/null
+++ b/rust/kernel/net/socket/opts.rs
@@ -0,0 +1,1222 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Socket options.
+//!
+//! This module contains the types related to socket options.
+//! It is meant to be used together with the [`Socket`](kernel::net::socket::Socket) type.
+//!
+//! Socket options have more sense in the user space than in the kernel space: the kernel can
+//! directly access the socket data structures, so it does not need to use socket options.
+//! However, that level of freedom is currently not available in the Rust kernel API; therefore,
+//! having socket options is a good compromise.
+//!
+//! When Rust wrappers for the structures related to the socket (and required by the options,
+//! e.g. `tcp_sock`, `inet_sock`, etc.) are available, the socket options will be removed,
+//! and substituted by direct methods inside the socket types.
+
+use kernel::bindings;
+
+/// Options level to retrieve and set socket options.
+/// See `man 7 socket` for more information.
+#[derive(Debug, Copy, Clone, PartialEq, Eq, Hash)]
+pub enum OptionsLevel {
+    /// IP level socket options.
+    /// See `man 7 ip` for more information.
+    Ip = bindings::IPPROTO_IP as isize,
+
+    /// Socket level socket options.
+    /// See `man 7 socket` for more information.
+    Socket = bindings::SOL_SOCKET as isize,
+
+    /// IPv6 level socket options.
+    /// See `man 7 ipv6` for more information.
+    Ipv6 = bindings::IPPROTO_IPV6 as isize,
+
+    /// Raw level socket options.
+    /// See `man 7 raw` for more information.
+    Raw = bindings::IPPROTO_RAW as isize,
+
+    /// TCP level socket options.
+    /// See `man 7 tcp` for more information.
+    Tcp = bindings::IPPROTO_TCP as isize,
+}
+
+/// Generic socket option type.
+///
+/// This trait is implemented by each individual socket option.
+///
+/// Having socket options as structs instead of enums allows:
+/// - Type safety, making sure that the correct type is used for each option.
+/// - Read/write enforcement, making sure that only readable options
+/// are read and only writable options are written.
+pub trait SocketOption {
+    /// Rust type of the option value.
+    ///
+    /// This type is used to store the value of the option.
+    /// It is also used to enforce type safety.
+    ///
+    /// For example, the [`ip::Mtu`] option has a value of type `u32`.
+    type Type;
+
+    /// Retrieve the C value of the option.
+    ///
+    /// This value is used to pass the option to the kernel.
+    fn value() -> isize;
+
+    /// Retrieve the level of the option.
+    ///
+    /// This value is used to pass the option to the kernel.
+    fn level() -> OptionsLevel;
+}
+
+/// Generic readable socket option type.
+///
+/// This trait is implemented by each individual readable socket option.
+/// Can be combined with [`WritableOption`] to create a readable and writable socket option.
+pub trait WritableOption: SocketOption {}
+
+/// Generic writable socket option type.
+///
+/// This trait is implemented by each individual writable socket option.
+/// Can be combined with [`ReadableOption`] to create a readable and writable socket option.
+pub trait ReadableOption: SocketOption {}
+
+/// Generates the code for the implementation of a socket option.
+///
+/// # Parameters
+/// * `$opt`: Name of the socket option.
+/// * `$value`: C value of the socket option.
+/// * `$level`: Level of the socket option, like [`OptionsLevel::Ip`].
+/// * `$rtyp`: Rust type of the socket option.
+/// * `$($tr:ty),*`: Traits that the socket option implements, like [`WritableOption`].
+macro_rules! impl_opt {
+    ($(#[$meta:meta])*
+    $opt:ident = $value:expr,
+    $level:expr,
+    unimplemented,
+    $($tr:ty),*) => {};
+
+    ($(#[$meta:meta])*
+    $opt:ident = $value:expr,
+    $level:expr,
+    $rtyp:ty,
+    $($tr:ty),*) => {
+        $(#[$meta])*
+        #[repr(transparent)]
+        #[derive(Default)]
+        pub struct $opt;
+        impl SocketOption for $opt {
+            type Type = $rtyp;
+            fn value() -> isize {
+                $value as isize
+            }
+            fn level() -> OptionsLevel {
+                $level
+            }
+        }
+        $(
+            impl $tr for $opt {}
+        )*
+    };
+}
+
+pub mod ip {
+    //! IP socket options.
+    use super::{OptionsLevel, ReadableOption, SocketOption, WritableOption};
+    use crate::net::addr::Ipv4Addr;
+
+    macro_rules! impl_ip_opt {
+        ($(#[$meta:meta])*
+        $opt:ident = $value:expr,
+        unimplemented,
+        $($tr:ty),*) => {
+            impl_opt!(
+                $(#[$meta])*
+                $opt = $value,
+                OptionsLevel::Ip,
+                unimplemented,
+                $($tr),*
+            );
+        };
+
+        ($(#[$meta:meta])*
+        $opt:ident = $value:expr,
+        $rtyp:ty,
+        $($tr:ty),*) => {
+            impl_opt!(
+                $(#[$meta])*
+                $opt = $value,
+                OptionsLevel::Ip,
+                $rtyp,
+                $($tr),*
+            );
+        };
+    }
+
+    impl_ip_opt!(
+        /// Join a multicast group.
+        ///
+        /// C value type: `struct ip_mreqn`.
+        AddMembership = bindings::IP_ADD_MEMBERSHIP,
+        unimplemented,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Join a multicast group with source filtering.
+        ///
+        /// C value type: `struct ip_mreq_source`
+        AddSourceMembership = bindings::IP_ADD_SOURCE_MEMBERSHIP,
+        unimplemented,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Don't reserve a port when binding with port number 0.
+        ///
+        /// C value type: `int`
+        BindAddressNoPort = bindings::IP_BIND_ADDRESS_NO_PORT,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Block packets from a specific source.
+        ///
+        /// C value type: `struct ip_mreq_source`
+        BlockSource = bindings::IP_BLOCK_SOURCE,
+        unimplemented,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Leave a multicast group.
+        ///
+        /// C value type: `struct ip_mreqn`
+        DropMembership = bindings::IP_DROP_MEMBERSHIP,
+        unimplemented,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Stop receiving packets from a specific source.
+        ///
+        /// C value type: `struct ip_mreq_source`
+        DropSourceMembership = bindings::IP_DROP_SOURCE_MEMBERSHIP,
+        unimplemented,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Allow binding to a non-local address.
+        ///
+        /// C value type: `int`
+        FreeBind = bindings::IP_FREEBIND,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Receive the IP header with the packet.
+        ///
+        /// C value type: `int`
+        Header = bindings::IP_HDRINCL,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Full-state multicast filtering API.
+        ///
+        /// C value type: `struct ip_msfilter`
+        MsFilter = bindings::IP_MSFILTER,
+        unimplemented,
+        ReadableOption,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Retrieve the MTU of the socket.
+        ///
+        /// C value type: `int`
+        Mtu = bindings::IP_MTU,
+        u32,
+        ReadableOption
+    );
+    impl_ip_opt!(
+        /// Discover the MTU of the path to a destination.
+        ///
+        /// C value type: `int`
+        MtuDiscover = bindings::IP_MTU_DISCOVER,
+        unimplemented,
+        ReadableOption,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Modify delivery policy of messages.
+        ///
+        /// C value type: `int`
+        MulticastAll = bindings::IP_MULTICAST_ALL,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Set the interface for outgoing multicast packets.
+        ///
+        /// C value type: `struct in_addr`
+        MulticastInterface = bindings::IP_MULTICAST_IF,
+        Ipv4Addr,
+        ReadableOption,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Set whether multicast packets are looped back to the sender.
+        ///
+        /// C value type: `int`
+        MulticastLoop = bindings::IP_MULTICAST_LOOP,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Set the TTL of outgoing multicast packets.
+        ///
+        /// C value type: `int`
+        MulticastTtl = bindings::IP_MULTICAST_TTL,
+        u8,
+        ReadableOption,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Whether to disable reassembling of fragmented packets.
+        ///
+        /// C value type: `int`
+        NoDefrag = bindings::IP_NODEFRAG,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Set the options to be included in outgoing packets.
+        ///
+        /// C value type: `char *`
+        IpOptions = bindings::IP_OPTIONS,
+        unimplemented,
+        ReadableOption,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Enable receiving security context with the packet.
+        ///
+        /// C value type: `int`
+        PassSec = bindings::IP_PASSSEC,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Enable extended reliable error message passing.
+        ///
+        /// C value type: `int`
+        RecvErr = bindings::IP_RECVERR,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Pass all IP Router Alert messages to this socket.
+        ///
+        /// C value type: `int`
+        RouterAlert = bindings::IP_ROUTER_ALERT,
+        bool,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Set the TOS field of outgoing packets.
+        ///
+        /// C value type: `int`
+        Tos = bindings::IP_TOS,
+        u8,
+        ReadableOption,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Set transparent proxying.
+        ///
+        /// C value type: `int`
+        Transparent = bindings::IP_TRANSPARENT,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Set the TTL of outgoing packets.
+        ///
+        /// C value type: `int`
+        Ttl = bindings::IP_TTL,
+        u8,
+        ReadableOption,
+        WritableOption
+    );
+    impl_ip_opt!(
+        /// Unblock packets from a specific source.
+        ///
+        /// C value type: `struct ip_mreq_source`
+        UnblockSource = bindings::IP_UNBLOCK_SOURCE,
+        unimplemented,
+        WritableOption
+    );
+}
+
+pub mod sock {
+    //! Socket options.
+    use super::*;
+    use crate::net::ip::IpProtocol;
+    use crate::net::socket::SockType;
+    use crate::net::AddressFamily;
+    macro_rules! impl_sock_opt {
+        ($(#[$meta:meta])*
+        $opt:ident = $value:expr,
+        unimplemented,
+        $($tr:ty),*) => {
+            impl_opt!(
+                $(#[$meta])*
+                $opt = $value,
+                OptionsLevel::Socket,
+                unimplemented,
+                $($tr),*
+            );
+        };
+
+        ($(#[$meta:meta])*
+        $opt:ident = $value:expr,
+        $rtyp:ty,
+        $($tr:ty),*) => {
+            impl_opt!(
+                $(#[$meta])*
+                $opt = $value,
+                OptionsLevel::Socket,
+                $rtyp,
+                $($tr),*
+            );
+        };
+    }
+
+    impl_sock_opt!(
+        /// Get whether the socket is accepting connections.
+        ///
+        /// C value type: `int`
+        AcceptConn = bindings::SO_ACCEPTCONN,
+        bool,
+        ReadableOption
+    );
+
+    impl_sock_opt!(
+        /// Attach a filter to the socket.
+        ///
+        /// C value type: `struct sock_fprog`
+        AttachFilter = bindings::SO_ATTACH_FILTER,
+        unimplemented,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_sock_opt!(
+        /// Attach a eBPF program to the socket.
+        ///
+        /// C value type: `struct sock_fprog`
+        AttachBpf = bindings::SO_ATTACH_BPF,
+        unimplemented,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_sock_opt!(
+        /// Bind the socket to a specific network device.
+        ///
+        /// C value type: `char *`
+        BindToDevice = bindings::SO_BINDTODEVICE,
+        &'static str,
+        ReadableOption,
+        WritableOption
+    );
+    impl_sock_opt!(
+        /// Set the broadcast flag on the socket.
+        ///
+        /// Only valid for datagram sockets.
+        ///
+        /// C value type: `int`
+        Broadcast = bindings::SO_BROADCAST,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+    impl_sock_opt!(
+        /// Enable BSD compatibility.
+        ///
+        /// C value type: `int`
+        BsdCompatible = bindings::SO_BSDCOMPAT,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+    impl_sock_opt!(
+        /// Enable socket debugging.
+        ///
+        /// C value type: `int`
+        Debug = bindings::SO_DEBUG,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+    impl_sock_opt!(
+        /// Remove BPF or eBPF program from the socket.
+        ///
+        /// The argument is ignored.
+        ///
+        /// C value type: `int`
+        DetachFilter = bindings::SO_DETACH_FILTER,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+    impl_sock_opt!(
+        /// Get the domain of the socket.
+        ///
+        /// C value type: `int`
+        Domain = bindings::SO_DOMAIN,
+        AddressFamily,
+        ReadableOption
+    );
+    impl_sock_opt!(
+        /// Get and clear pending errors.
+        ///
+        /// C value type: `int`
+        Error = bindings::SO_ERROR,
+        u32,
+        ReadableOption,
+        WritableOption
+    );
+    impl_sock_opt!(
+        /// Only send packets to directly connected peers.
+        ///
+        /// C value type: `int`
+        DontRoute = bindings::SO_DONTROUTE,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+    impl_sock_opt!(
+        /// Set or get the CPU affinity of a socket.
+        ///
+        /// C value type: `int`
+        IncomingCpu = bindings::SO_INCOMING_CPU,
+        u32,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_sock_opt!(
+        /// Enable keep-alive packets.
+        ///
+        /// C value type: `int`
+        KeepAlive = bindings::SO_KEEPALIVE,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_sock_opt!(
+        /// Set or get the linger timeout.
+        ///
+        /// C value type: `struct linger`
+        Linger = bindings::SO_LINGER,
+        Linger,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_sock_opt!(
+        /// Prevent changing the filters attached to the socket.
+        ///
+        /// C value type: `int`
+        LockFilter = bindings::SO_LOCK_FILTER,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_sock_opt!(
+        /// Set or get the mark of the socket.
+        ///
+        /// C value type: `int`
+        Mark = bindings::SO_MARK,
+        u32,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_sock_opt!(
+        /// Set whether out-of-band data is received in the normal data stream.
+        ///
+        /// C value type: `int`
+        OobInline = bindings::SO_OOBINLINE,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_sock_opt!(
+        /// Enable the receiving of SCM credentials.
+        ///
+        /// C value type: `int`
+        PassCred = bindings::SO_PASSCRED,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_sock_opt!(
+        /// Set the peek offset for MSG_PEEK reads.
+        ///
+        /// Only valid for UNIX sockets.
+        ///
+        /// C value type: `int`
+        PeekOff = bindings::SO_PEEK_OFF,
+        i32,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_sock_opt!(
+        /// Set or get the protocol-defined priority for all packets.
+        ///
+        /// C value type: `int`
+        Priority = bindings::SO_PRIORITY,
+        u8,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_sock_opt!(
+        /// Retrieve the socket protocol
+        ///
+        /// C value type: `int`
+        Protocol = bindings::SO_PROTOCOL,
+        IpProtocol,
+        ReadableOption
+    );
+
+    impl_sock_opt!(
+        /// Set or get the receive buffer size.
+        ///
+        /// C value type: `int`
+        RcvBuf = bindings::SO_RCVBUF,
+        u32,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_sock_opt!(
+        /// Set or get the receive low watermark.
+        ///
+        /// C value type: `int`
+        RcvLowat = bindings::SO_RCVLOWAT,
+        u32,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_sock_opt!(
+        /// Set or get the receive timeout.
+        ///
+        /// C value type: `struct timeval`
+        RcvTimeo = bindings::SO_RCVTIMEO_NEW,
+        unimplemented,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_sock_opt!(
+        /// Set or get the reuse address flag.
+        ///
+        /// C value type: `int`
+        ReuseAddr = bindings::SO_REUSEADDR,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_sock_opt!(
+        /// Set or get the reuse port flag.
+        ///
+        /// C value type: `int`
+        ReusePort = bindings::SO_REUSEPORT,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_sock_opt!(
+        /// Set or get the send buffer size.
+        ///
+        /// C value type: `int`
+        SndBuf = bindings::SO_SNDBUF,
+        u32,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_sock_opt!(
+        /// Set or get the send timeout.
+        ///
+        /// C value type: `struct timeval`
+        SndTimeo = bindings::SO_SNDTIMEO_NEW,
+        unimplemented,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_sock_opt!(
+        /// Set whether the timestamp control messages are received.
+        ///
+        /// C value type: `int`
+        Timestamp = bindings::SO_TIMESTAMP_NEW,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_sock_opt!(
+        /// Set or get the socket type.
+        ///
+        /// C value type: `int`
+        Type = bindings::SO_TYPE,
+        SockType,
+        ReadableOption
+    );
+}
+
+pub mod ipv6 {
+    //! IPv6 socket options.
+    use super::*;
+    use crate::net::AddressFamily;
+    macro_rules! impl_ipv6_opt {
+        ($(#[$meta:meta])*
+        $opt:ident = $value:expr,
+        unimplemented,
+        $($tr:ty),*) => {
+            impl_opt!(
+                $(#[$meta])*
+                $opt = $value,
+                OptionsLevel::Ipv6,
+                unimplemented,
+                $($tr),*
+            );
+        };
+
+        ($(#[$meta:meta])*
+        $opt:ident = $value:expr,
+        $rtyp:ty,
+        $($tr:ty),*) => {
+            impl_opt!(
+                $(#[$meta])*
+                $opt = $value,
+                OptionsLevel::Ipv6,
+                $rtyp,
+                $($tr),*
+            );
+        };
+    }
+
+    impl_ipv6_opt!(
+        /// Modify the address family used by the socket.
+        ///
+        /// C value type: `int`
+        AddrForm = bindings::IPV6_ADDRFORM,
+        AddressFamily,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_ipv6_opt!(
+        /// Join a multicast group.
+        ///
+        /// C value type: `struct ipv6_mreq`
+        AddMembership = bindings::IPV6_ADD_MEMBERSHIP,
+        unimplemented,
+        WritableOption
+    );
+
+    impl_ipv6_opt!(
+        /// Leave a multicast group.
+        ///
+        /// C value type: `struct ipv6_mreq`
+        DropMembership = bindings::IPV6_DROP_MEMBERSHIP,
+        unimplemented,
+        WritableOption
+    );
+
+    impl_ipv6_opt!(
+        /// Set or get the MTU of the socket.
+        ///
+        /// C value type: `int`
+        Mtu = bindings::IPV6_MTU,
+        u32,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_ipv6_opt!(
+        /// Set or retrieve the MTU discovery settings.
+        ///
+        /// C value type: `int` (macros)
+        MtuDiscover = bindings::IPV6_MTU_DISCOVER,
+        unimplemented,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_ipv6_opt!(
+        /// Set or get the multicast hop limit.
+        ///
+        /// Range is -1 to 255.
+        ///
+        /// C value type: `int`
+        MulticastHops = bindings::IPV6_MULTICAST_HOPS,
+        i16,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_ipv6_opt!(
+        /// Set or get the multicast interface.
+        ///
+        /// Only valid for datagram and raw sockets.
+        ///
+        /// C value type: `int`
+        MulticastInterface = bindings::IPV6_MULTICAST_IF,
+        u32,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_ipv6_opt!(
+        /// Set or read whether multicast packets are looped back
+        ///
+        /// C value type: `int`
+        MulticastLoop = bindings::IPV6_MULTICAST_LOOP,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_ipv6_opt!(
+        /// Set or get whether IPV6_PKTINFO is enabled.
+        ///
+        /// Only valid for datagram and raw sockets.
+        ///
+        /// C value type: `int`
+        ReceivePktInfo = bindings::IPV6_PKTINFO,
+        bool,
+        WritableOption
+    );
+
+    impl_ipv6_opt!(
+        /// Set or get whether IPV6_RTHDR messages are delivered.
+        ///
+        /// Only valid for raw sockets.
+        ///
+        /// C value type: `int`
+        RouteHdr = bindings::IPV6_RTHDR,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_ipv6_opt!(
+        /// Set or get whether IPV6_DSTOPTS messages are delivered.
+        ///
+        /// Only valid for datagram and raw sockets.
+        ///
+        /// C value type: `int`
+        DestOptions = bindings::IPV6_DSTOPTS,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_ipv6_opt!(
+        /// Set or get whether IPV6_HOPOPTS messages are delivered.
+        ///
+        /// Only valid for datagram and raw sockets.
+        ///
+        /// C value type: `int`
+        HopOptions = bindings::IPV6_HOPOPTS,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_ipv6_opt!(
+        /// Set or get whether IPV6_FLOWINFO messages are delivered.
+        ///
+        /// Only valid for datagram and raw sockets.
+        ///
+        /// C value type: `int`
+        FlowInfo = bindings::IPV6_FLOWINFO,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_ipv6_opt!(
+        /// Enable extended reliable error message reporting.
+        ///
+        /// C value type: `int`
+        RecvErr = bindings::IPV6_RECVERR,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_ipv6_opt!(
+        /// Pass all Router Alert enabled messages to the socket.
+        ///
+        /// Only valid for raw sockets.
+        ///
+        /// C value type: `int`
+        RouterAlert = bindings::IPV6_ROUTER_ALERT,
+        bool,
+        WritableOption
+    );
+
+    impl_ipv6_opt!(
+        /// Set or get the unicast hop limit.
+        ///
+        /// Range is -1 to 255.
+        ///
+        /// C value type: `int`
+        UnicastHops = bindings::IPV6_UNICAST_HOPS,
+        i16,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_ipv6_opt!(
+        /// Set whether the socket can only send and receive IPv6 packets.
+        ///
+        /// C value type: `int`
+        V6Only = bindings::IPV6_V6ONLY,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+}
+
+pub mod raw {
+    //! Raw socket options.
+    //!
+    //! These options are only valid for sockets with type [`SockType::Raw`](kernel::net::socket::SockType::Raw).
+    macro_rules! impl_raw_opt {
+        ($(#[$meta:meta])*
+        $opt:ident = $value:expr,
+        unimplemented,
+        $($tr:ty),*) => {
+            impl_opt!(
+                $(#[$meta])*
+                $opt = $value,
+                OptionsLevel::Raw,
+                unimplemented,
+                $($tr),*
+            );
+        };
+
+        ($(#[$meta:meta])*
+        $opt:ident = $value:expr,
+        $rtyp:ty,
+        $($tr:ty),*) => {
+            impl_opt!(
+                $(#[$meta])*
+                $opt = $value,
+                OptionsLevel::Raw,
+                $rtyp,
+                $($tr),*
+            );
+        };
+    }
+
+    impl_raw_opt!(
+        /// Enable a filter for IPPROTO_ICMP raw sockets.
+        /// The filter has a bit set for each ICMP type to be filtered out.
+        ///
+        /// C value type: `struct icmp_filter`
+        Filter = bindings::ICMP_FILTER as isize,
+        unimplemented,
+        ReadableOption,
+        WritableOption
+    );
+}
+
+pub mod tcp {
+    //! TCP socket options.
+    //!
+    //! These options are only valid for sockets with type [`SockType::Stream`](kernel::net::socket::SockType::Stream)
+    //! and protocol [`IpProtocol::Tcp`](kernel::net::ip::IpProtocol::Tcp).
+    use super::*;
+    macro_rules! impl_tcp_opt {
+        ($(#[$meta:meta])*
+        $opt:ident = $value:expr,
+        unimplemented,
+        $($tr:ty),*) => {
+            impl_opt!(
+                $(#[$meta])*
+                $opt = $value,
+                OptionsLevel::Tcp,
+                unimplemented,
+                $($tr),*
+            );
+        };
+
+        ($(#[$meta:meta])*
+        $opt:ident = $value:expr,
+        $rtyp:ty,
+        $($tr:ty),*) => {
+            impl_opt!(
+                $(#[$meta])*
+                $opt = $value,
+                OptionsLevel::Tcp,
+                $rtyp,
+                $($tr),*
+            );
+        };
+    }
+
+    impl_tcp_opt!(
+        /// Set or get the congestion control algorithm to be used.
+        ///
+        /// C value type: `char *`
+        Congestion = bindings::TCP_CONGESTION,
+        unimplemented, // &[u8]? what about lifetime?
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_tcp_opt!(
+        /// If true, don't send partial frames.
+        ///
+        /// C value type: `int`
+        Cork = bindings::TCP_CORK,
+        bool,
+        WritableOption,
+        ReadableOption
+    );
+
+    impl_tcp_opt!(
+        /// Allow a listener to be awakened only when data arrives.
+        /// The value is the time to wait for data in milliseconds.
+        ///
+        /// C value type: `int`
+        DeferAccept = bindings::TCP_DEFER_ACCEPT,
+        i32,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_tcp_opt!(
+        /// Collect information about this socket.
+        ///
+        /// C value type: `struct tcp_info`
+        Info = bindings::TCP_INFO,
+        unimplemented,
+        ReadableOption
+    );
+
+    impl_tcp_opt!(
+        /// Set or get maximum number of keepalive probes to send.
+        ///
+        /// C value type: `int`
+        KeepCount = bindings::TCP_KEEPCNT,
+        i32,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_tcp_opt!(
+        /// Set or get the time in seconds to idle before sending keepalive probes.
+        ///
+        /// C value type: `int`
+        KeepIdle = bindings::TCP_KEEPIDLE,
+        i32,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_tcp_opt!(
+        /// Set or get the time in seconds between keepalive probes.
+        ///
+        /// C value type: `int`
+        KeepInterval = bindings::TCP_KEEPINTVL,
+        i32,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_tcp_opt!(
+        /// Set or get the lifetime or orphaned FIN_WAIT2 sockets.
+        ///
+        /// C value type: `int`
+        Linger2 = bindings::TCP_LINGER2,
+        i32,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_tcp_opt!(
+        /// Set or get the maximum segment size for outgoing TCP packets.
+        ///
+        /// C value type: `int`
+        MaxSeg = bindings::TCP_MAXSEG,
+        i32,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_tcp_opt!(
+        /// If true, Nagle algorithm is disabled, i.e. segments are send as soon as possible.
+        ///
+        /// C value type: `int`
+        NoDelay = bindings::TCP_NODELAY,
+        bool,
+        WritableOption,
+        ReadableOption
+    );
+
+    impl_tcp_opt!(
+        /// Set or get whether QuickAck mode is on.
+        /// If true, ACKs are sent immediately, rather than delayed.
+        ///
+        /// C value type: `int`
+        QuickAck = bindings::TCP_QUICKACK,
+        bool,
+        WritableOption,
+        ReadableOption
+    );
+
+    impl_tcp_opt!(
+        /// Set or get the number of SYN retransmits before the connection is dropped.
+        ///
+        /// C value type: `int`
+        SynCount = bindings::TCP_SYNCNT,
+        u8,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_tcp_opt!(
+        /// Set or get how long sent packets can remain unacknowledged before timing out.
+        /// The value is in milliseconds; 0 means to use the system default.
+        ///
+        /// C value type: `unsigned int`
+        UserTimeout = bindings::TCP_USER_TIMEOUT,
+        u32,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_tcp_opt!(
+        /// Set or get the maximum window size for TCP sockets.
+        ///
+        /// C value type: `int`
+        WindowClamp = bindings::TCP_WINDOW_CLAMP,
+        u32,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_tcp_opt!(
+        /// Enable Fast Open on the listener socket (RFC 7413).
+        /// The value is the maximum length of pending SYNs.
+        ///
+        /// C value type: `int`
+        FastOpen = bindings::TCP_FASTOPEN,
+        u32,
+        ReadableOption,
+        WritableOption
+    );
+
+    impl_tcp_opt!(
+        /// Enable Fast Open on the client socket (RFC 7413).
+        ///
+        /// C value type: `int`
+        FastOpenConnect = bindings::TCP_FASTOPEN_CONNECT,
+        bool,
+        ReadableOption,
+        WritableOption
+    );
+}
+
+/// Linger structure to set and get the [sock::Linger] option.
+/// This is a wrapper around the C struct `linger`.
+#[repr(transparent)]
+pub struct Linger(bindings::linger);
+
+impl Linger {
+    /// Create a "on" Linger object with the given linger time.
+    /// This is equivalent to `linger { l_onoff: 1, l_linger: linger_time }`.
+    /// The linger time is in seconds.
+    ///
+    /// # Example
+    /// ```
+    /// use kernel::net::socket::opts::Linger;
+    /// let linger = Linger::on(10);
+    /// assert!(linger.is_on());
+    /// assert_eq!(linger.linger_time(), 10);
+    pub fn on(linger: i32) -> Self {
+        Linger(bindings::linger {
+            l_onoff: 1 as _,
+            l_linger: linger as _,
+        })
+    }
+
+    /// Create an "off" Linger object.
+    /// This is equivalent to `linger { l_onoff: 0, l_linger: 0 }`.
+    ///
+    /// # Example
+    /// ```
+    /// use kernel::net::socket::opts::Linger;
+    /// let linger = Linger::off();
+    /// assert!(!linger.is_on());
+    pub fn off() -> Self {
+        Linger(bindings::linger {
+            l_onoff: 0 as _,
+            l_linger: 0 as _,
+        })
+    }
+
+    /// Get whether the linger option is on.
+    ///
+    /// # Example
+    /// ```
+    /// use kernel::net::socket::opts::Linger;
+    /// let linger = Linger::on(10);
+    /// assert!(linger.is_on());
+    /// ```
+    ///
+    /// ```
+    /// use kernel::net::socket::opts::Linger;
+    /// let linger = Linger::off();
+    /// assert!(!linger.is_on());
+    /// ```
+    pub fn is_on(&self) -> bool {
+        self.0.l_onoff != 0
+    }
+
+    /// Get the linger time in seconds.
+    /// If the linger option is off, this will return 0.
+    ///
+    /// # Example
+    /// ```
+    /// use kernel::net::socket::opts::Linger;
+    /// let linger = Linger::on(10);
+    /// assert_eq!(linger.linger_time(), 10);
+    /// ```
+    pub fn linger_time(&self) -> i32 {
+        self.0.l_linger as _
+    }
+}
-- 
2.41.0

