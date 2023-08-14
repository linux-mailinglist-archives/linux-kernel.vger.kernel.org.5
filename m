Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3172777B55C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjHNJZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbjHNJYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:24:33 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED793130;
        Mon, 14 Aug 2023 02:24:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so5259247a12.1;
        Mon, 14 Aug 2023 02:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692005068; x=1692609868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJ7xEeTsfzsK2Sj+HhPXkqE70FTyJ3LgvM+nfAM6twU=;
        b=hM0dyvSDLtX0Dq7BE6YJqSGHWh4y2nIGG/aI0ny+nsd6iBYOdcgVr7c5O0pR7knelK
         TkCjkJr8pshvdPllcTofVguGpjqaqa9/iIomRhV8/sxPcv/BLGk6ePJvtO4nNIsxkB9P
         WPbrdMFa+FOI1okQQ3kFdq1bZNgbVFmR1b75cwvUEgU0UqmgBAWFBWJeOBeheKAW3s7i
         zT/eKBnbR02LHc51Pyyj9lT/Z8dRRaChetaXf9tTiD9pRbWPejY1B7l32UkptcdCHxzt
         VkBp72e6l5dqfhCMkDEHkywdcdbN1EaHzKeabCuQ/35BgMr9EFA5ioIwZCfedLbTXhOq
         ojyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692005068; x=1692609868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJ7xEeTsfzsK2Sj+HhPXkqE70FTyJ3LgvM+nfAM6twU=;
        b=TBV7GWwSMwBIeOHAc9RO3lH1izoPq+kyJmlWX+g0/zlVTvRIQLQrm4nsJxoGsL5eoX
         ari5m8mAqpTezyWa6tNZKH84qWLpmYENzLzAl9oIBsGtuL85NnfwXatjHjKkrSlPTtcM
         ds3QwRN7DgLg3qFJlUqUAx9jTWYNVtbq1wzfcXOQi4Als5863G69k1rA8mRMDkxI7y3q
         fYv3YS2GVeaaNy9b2Rx6SOhfMBFDMKZ8y2WUuT64Ijse9QGfF3yVc+9snTGXZnUtnixz
         YNjWC/3UJJZH7l/7mkAE2oCuIsBzzLzqq3pDXuHhhOMqlmA5darNIwq5InpSOa0xrmEq
         3P2w==
X-Gm-Message-State: AOJu0Yzuu3iNffhVsCkIUwytTHTfqWrfQi8yQMijJdR1vpEGnbrBg6cG
        ZzWocjefEjHy9YZPXNbXvdU=
X-Google-Smtp-Source: AGHT+IG5yO5VujQspYhzAWD6vRpCJiumtT77HplkVprI5NxHY9kfOrjm6iRiKmkA34JHMvH3yL9a8A==
X-Received: by 2002:aa7:c950:0:b0:523:ae0a:a447 with SMTP id h16-20020aa7c950000000b00523ae0aa447mr7016018edt.13.1692005068229;
        Mon, 14 Aug 2023 02:24:28 -0700 (PDT)
Received: from micheledallerive.home ([2a02:1210:6051:ec00:61e9:3767:83a6:9bd9])
        by smtp.gmail.com with ESMTPSA id b5-20020aa7c6c5000000b005224d960e66sm5314879eds.96.2023.08.14.02.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 02:24:28 -0700 (PDT)
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
Subject: [RFC PATCH 4/7] rust: net: add socket wrapper.
Date:   Mon, 14 Aug 2023 11:22:59 +0200
Message-ID: <20230814092302.1903203-5-dallerivemichele@gmail.com>
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

Create a `Socket` abstraction, which provides a Rust API to the kernel
socket functionalities.

The Socket structures tries to keep the same function signatures of the
Rust standard library; at the same time, functions are added or modified
in order to provide as much as possible of the C kernel functionalities.

Most of the internals of the C socket is not accessible by Rust, because
those structures are still to be wrapped. However, sockets are mainly
managed through the functions provided by the kernel; thus, even if some
fields are not accessible, since the functions are wrapped, most of the 
kernel functionality should be available in Rust as well.

Specifically, the usage of `msghdr` is mostly abstracted away in the
Rust interface, because using it would mean having to deal, both in the
kernel and in modules, with Pinned instances (msghdr is self-referencing),
which would be a struggle that provides no particular advantage.
A `MessageHeader` object is actually created and returned when a message
is received, because at that point the structure is not really
self-referencing, as long as the source address is copied. The wrapper
is not used when a message is sent.
Anyways, some useful functionalities of `msghdr`, like `cmsghdr`s, are 
missing and should be implemented in the future to provide a complete API.

Signed-off-by: Michele Dalle Rive <dallerivemichele@gmail.com>
---
Few questions here as well:
- What about `MessageHeader`? Does it make sense to only have it on a
  receive? My reasoning was that, AFAIK, when sending a message, the
  `msghdr` structure is used for the flags and for eventually the
  destination address. Does it make sense having to handle a pinned
  object just to avoid having flags and destination address as arguments
  of the send function? When a message is received, instead, there is no
  pinning problem (as long as the address is saved), so the message
  header can be freely returned and handled. As of now, the
  `MessageHeader` only contains sender address and flags, but in the
  future more `msghdr` fields could be wrapped.
- In `has_flag` and `set_flag`, does it make sense to use the
  bindgen-provided `__BindgenBitfieldUnit`? It is particularly
  convenient, as it handles the big/little endianness. However, I
  noticed that it changes between different bindgen version, and keeping
  the code up to date could take more time than manually handle the
  endianness.

 rust/kernel/net.rs        |   1 +
 rust/kernel/net/socket.rs | 550 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 551 insertions(+)
 create mode 100644 rust/kernel/net/socket.rs

diff --git a/rust/kernel/net.rs b/rust/kernel/net.rs
index 346e7374e614..7d58ebb0324f 100644
--- a/rust/kernel/net.rs
+++ b/rust/kernel/net.rs
@@ -12,6 +12,7 @@
 
 pub mod addr;
 pub mod ip;
+pub mod socket;
 
 /// The address family.
 ///
diff --git a/rust/kernel/net/socket.rs b/rust/kernel/net/socket.rs
new file mode 100644
index 000000000000..8396ce4b83a8
--- /dev/null
+++ b/rust/kernel/net/socket.rs
@@ -0,0 +1,550 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Socket API.
+//!
+//! This module contains the Socket layer kernel APIs that have been wrapped for usage by Rust code
+//! in the kernel.
+//!
+//! C header: [`include/linux/socket.h`](../../../../include/linux/socket.h)
+//!
+//! This API is inspired by the Rust std::net Socket API, but is not a direct port.
+//! The main difference is that the Rust std::net API is designed for user-space, while this API
+//! is designed for kernel-space.
+//! Rust net API: <https://doc.rust-lang.org/std/net/index.html>
+
+use super::*;
+use crate::error::{to_result, Result};
+use crate::net::addr::*;
+use crate::net::ip::IpProtocol;
+use flags::*;
+
+pub mod flags;
+
+/// The socket type.
+pub enum SockType {
+    /// Stream socket (e.g. TCP)
+    Stream = bindings::sock_type_SOCK_STREAM as isize,
+    /// Connectionless socket (e.g. UDP)
+    Datagram = bindings::sock_type_SOCK_DGRAM as isize,
+    /// Raw socket
+    Raw = bindings::sock_type_SOCK_RAW as isize,
+    /// Reliably-delivered message
+    Rdm = bindings::sock_type_SOCK_RDM as isize,
+    /// Sequenced packet stream
+    Seqpacket = bindings::sock_type_SOCK_SEQPACKET as isize,
+    /// Datagram Congestion Control Protocol socket
+    Dccp = bindings::sock_type_SOCK_DCCP as isize,
+    /// Packet socket
+    Packet = bindings::sock_type_SOCK_PACKET as isize,
+}
+
+/// The socket shutdown command.
+pub enum ShutdownCmd {
+    /// Disallow further receive operations.
+    Read = bindings::sock_shutdown_cmd_SHUT_RD as isize,
+    /// Disallow further send operations.
+    Write = bindings::sock_shutdown_cmd_SHUT_WR as isize,
+    /// Disallow further send and receive operations.
+    Both = bindings::sock_shutdown_cmd_SHUT_RDWR as isize,
+}
+
+/// A generic socket.
+///
+/// Wraps a `struct socket` from the kernel.
+/// See [include/linux/socket.h](../../../../include/linux/socket.h) for more information.
+///
+/// The wrapper offers high-level methods for common operations on the socket.
+/// More fine-grained control is possible by using the C bindings directly.
+///
+/// # Example
+/// A simple TCP echo server:
+/// ```rust
+/// use kernel::flag_set;
+/// use kernel::net::addr::{Ipv4Addr, SocketAddr, SocketAddrV4};
+/// use kernel::net::{AddressFamily, init_net};
+/// use kernel::net::ip::IpProtocol;
+/// use kernel::net::socket::{Socket, SockType};
+///
+/// let socket = Socket::new_kern(
+///     init_net(),
+///     AddressFamily::Inet,
+///     SockType::Stream,
+///     IpProtocol::Tcp,
+/// )?;
+/// socket.bind(SocketAddr::V4(SocketAddrV4::new(Ipv4Addr::LOOPBACK, 8000)))?;
+/// socket.listen(10)?;
+/// while let Ok(peer) = socket.accept(true) {
+///     let mut buf = [0u8; 1024];
+///     peer.receive(&mut buf, flag_set!())?;
+///     peer.send(&buf, flag_set!())?;
+/// }
+/// ```
+/// A simple UDP echo server:
+/// ```rust
+/// use kernel::net::addr::{Ipv4Addr, SocketAddr, SocketAddrV4};
+/// use kernel::net::{AddressFamily, init_net};
+/// use kernel::net::ip::IpProtocol;
+/// use kernel::net::socket::{Socket, SockType};
+/// use kernel::flag_set;
+///
+/// let socket = Socket::new_kern(init_net(), AddressFamily::Inet, SockType::Datagram, IpProtocol::Udp)?;///
+/// socket.bind(SocketAddr::V4(SocketAddrV4::new(Ipv4Addr::LOOPBACK, 8000)))?;
+/// let mut buf = [0u8; 1024];
+/// while let Ok((len, sender_opt)) = socket.receive_from(&mut buf, flag_set!()) {
+///     let sender: SocketAddr = sender_opt.expect("Sender address is always available for UDP");
+///     socket.send_to(&buf[..len], &sender, flag_set!())?;
+/// }
+/// ```
+///
+/// # Invariants
+///
+/// The socket pointer is valid for the lifetime of the wrapper.
+#[repr(transparent)]
+pub struct Socket(*mut bindings::socket);
+
+/// Getters and setters of socket internal fields.
+///
+/// Not all fields are currently supported: hopefully, this will be improved in the future.
+impl Socket {
+    /// Retrieve the flags associated with the socket.
+    ///
+    /// Unfortunately, these flags cannot be represented as a [`FlagSet`], since [`SocketFlag`]s
+    /// are not represented as masks but as the index of the bit they represent.
+    ///
+    /// An enum could be created, containing masks instead of indexes, but this could create
+    /// confusion with the C side.
+    ///
+    /// The methods [`Socket::has_flag`] and [`Socket::set_flags`] can be used to check and set individual flags.
+    pub fn flags(&self) -> u64 {
+        unsafe { (*self.0).flags }
+    }
+
+    /// Set the flags associated with the socket.
+    pub fn set_flags(&self, flags: u64) {
+        unsafe {
+            (*self.0).flags = flags;
+        }
+    }
+
+    /// Checks if the socket has a specific flag.
+    ///
+    /// # Example
+    /// ```
+    /// use kernel::net::socket::{Socket, flags::SocketFlag, SockType};
+    /// use kernel::net::AddressFamily;
+    /// use kernel::net::ip::IpProtocol;
+    ///
+    /// let socket = Socket::new(AddressFamily::Inet, SockType::Datagram, IpProtocol::Udp)?;
+    /// assert_eq!(socket.has_flag(SocketFlag::CustomSockOpt), false);
+    /// ```
+    pub fn has_flag(&self, flag: SocketFlag) -> bool {
+        bindings::__BindgenBitfieldUnit::<[u8; 8], u8>::new(self.flags().to_be_bytes())
+            .get_bit(flag as _)
+    }
+
+    /// Sets a flag on the socket.
+    ///
+    /// # Example
+    /// ```
+    /// use kernel::net::socket::{Socket, flags::SocketFlag, SockType};
+    /// use kernel::net::AddressFamily;
+    /// use kernel::net::ip::IpProtocol;
+    ///
+    /// let socket = Socket::new(AddressFamily::Inet, SockType::Datagram, IpProtocol::Udp)?;
+    /// assert_eq!(socket.has_flag(SocketFlag::CustomSockOpt), false);
+    /// socket.set_flag(SocketFlag::CustomSockOpt, true);
+    /// assert_eq!(socket.has_flag(SocketFlag::CustomSockOpt), true);
+    /// ```
+    pub fn set_flag(&self, flag: SocketFlag, value: bool) {
+        let flags_width = core::mem::size_of_val(&self.flags()) * 8;
+        let mut flags =
+            bindings::__BindgenBitfieldUnit::<[u8; 8], u8>::new(self.flags().to_be_bytes());
+        flags.set_bit(flag as _, value);
+        self.set_flags(flags.get(0, flags_width as _));
+    }
+
+    /// Consumes the socket and returns the underlying pointer.
+    ///
+    /// The pointer is valid for the lifetime of the wrapper.
+    ///
+    /// # Safety
+    /// The caller must ensure that the pointer is not used after the wrapper is dropped.
+    pub unsafe fn into_inner(self) -> *mut bindings::socket {
+        self.0
+    }
+
+    /// Returns the underlying pointer.
+    ///
+    /// The pointer is valid for the lifetime of the wrapper.
+    ///
+    /// # Safety
+    /// The caller must ensure that the pointer is not used after the wrapper is dropped.
+    pub unsafe fn as_inner(&self) -> *mut bindings::socket {
+        self.0
+    }
+}
+
+/// Socket API implementation
+impl Socket {
+    /// Private utility function to create a new socket by calling a function.
+    /// The function is generic over the creation function.
+    ///
+    /// # Arguments
+    /// * `create_fn`: A function that initiates the socket given as parameter.
+    ///                The function must return 0 on success and a negative error code on failure.
+    fn base_new<T>(create_fn: T) -> Result<Self>
+    where
+        T: (FnOnce(*mut *mut bindings::socket) -> core::ffi::c_int),
+    {
+        let mut socket_ptr: *mut bindings::socket = core::ptr::null_mut();
+        to_result(create_fn(&mut socket_ptr))?;
+        Ok(Self(socket_ptr))
+    }
+
+    /// Create a new socket.
+    ///
+    /// Wraps the `sock_create` function.
+    pub fn new(family: AddressFamily, type_: SockType, proto: IpProtocol) -> Result<Self> {
+        // SAFETY: FFI call; the address is valid for the lifetime of the wrapper.
+        Self::base_new(|socket_ptr| unsafe {
+            bindings::sock_create(family as _, type_ as _, proto as _, socket_ptr)
+        })
+    }
+
+    /// Create a new socket in a specific namespace.
+    ///
+    /// Wraps the `sock_create_kern` function.
+    pub fn new_kern(
+        ns: &Namespace,
+        family: AddressFamily,
+        type_: SockType,
+        proto: IpProtocol,
+    ) -> Result<Self> {
+        // SAFETY: FFI call; the address is valid for the lifetime of the wrapper.
+        Self::base_new(|socket_ptr| unsafe {
+            bindings::sock_create_kern(ns.0.get(), family as _, type_ as _, proto as _, socket_ptr)
+        })
+    }
+
+    /// Creates a new "lite" socket.
+    ///
+    /// Wraps the `sock_create_lite` function.
+    ///
+    /// This is a lighter version of `sock_create` that does not perform any sanity check.
+    pub fn new_lite(family: AddressFamily, type_: SockType, proto: IpProtocol) -> Result<Self> {
+        // SAFETY: FFI call; the address is valid for the lifetime of the wrapper.
+        Self::base_new(|socket_ptr| unsafe {
+            bindings::sock_create_lite(family as _, type_ as _, proto as _, socket_ptr)
+        })
+    }
+
+    /// Binds the socket to a specific address.
+    ///
+    /// Wraps the `kernel_bind` function.
+    pub fn bind(&self, address: SocketAddr) -> Result {
+        // SAFETY: FFI call; the address is valid for the lifetime of the wrapper.
+        to_result(unsafe {
+            bindings::kernel_bind(self.0, address.as_ptr() as _, address.size() as i32)
+        })
+    }
+
+    /// Connects the socket to a specific address.
+    ///
+    /// Wraps the `kernel_connect` function.
+    ///
+    /// The socket must be a connection-oriented socket.
+    /// If the socket is not bound, it will be bound to a random local address.
+    ///
+    /// # Example
+    /// ```rust
+    /// use kernel::net::{AddressFamily, init_net};
+    /// use kernel::net::addr::{Ipv4Addr, SocketAddr, SocketAddrV4};
+    /// use kernel::net::ip::IpProtocol;
+    /// use kernel::net::socket::{Socket, SockType};
+    ///
+    /// let socket = Socket::new_kern(init_net(), AddressFamily::Inet, SockType::Stream, IpProtocol::Tcp)?;
+    /// socket.bind(SocketAddr::V4(SocketAddrV4::new(Ipv4Addr::LOOPBACK, 8000)))?;
+    /// socket.listen(10)?;
+    pub fn listen(&self, backlog: i32) -> Result {
+        // SAFETY: FFI call; the address is valid for the lifetime of the wrapper.
+        to_result(unsafe { bindings::kernel_listen(self.0, backlog) })
+    }
+
+    /// Accepts a connection on a socket.
+    ///
+    /// Wraps the `kernel_accept` function.
+    pub fn accept(&self, block: bool) -> Result<Socket> {
+        let mut new_sock = core::ptr::null_mut();
+        let flags: i32 = if block { 0 } else { bindings::O_NONBLOCK as _ };
+
+        // SAFETY: FFI call; the address is valid for the lifetime of the wrapper.
+        to_result(unsafe { bindings::kernel_accept(self.0, &mut new_sock, flags as _) })?;
+
+        Ok(Self(new_sock))
+    }
+
+    /// Returns the address the socket is bound to.
+    ///
+    /// Wraps the `kernel_getsockname` function.
+    pub fn sockname(&self) -> Result<SocketAddr> {
+        let mut addr: SocketAddrStorage = SocketAddrStorage::default();
+
+        // SAFETY: FFI call; the address is valid for the lifetime of the wrapper.
+        unsafe {
+            to_result(bindings::kernel_getsockname(
+                self.0,
+                &mut addr as *mut _ as _,
+            ))
+        }
+        .and_then(|_| SocketAddr::try_from_raw(addr))
+    }
+
+    /// Returns the address the socket is connected to.
+    ///
+    /// Wraps the `kernel_getpeername` function.
+    ///
+    /// The socket must be connected.
+    pub fn peername(&self) -> Result<SocketAddr> {
+        let mut addr: SocketAddrStorage = SocketAddrStorage::default();
+
+        // SAFETY: FFI call; the address is valid for the lifetime of the wrapper.
+        unsafe {
+            to_result(bindings::kernel_getpeername(
+                self.0,
+                &mut addr as *mut _ as _,
+            ))
+        }
+        .and_then(|_| SocketAddr::try_from_raw(addr))
+    }
+
+    /// Connects the socket to a specific address.
+    ///
+    /// Wraps the `kernel_connect` function.
+    pub fn connect(&self, address: &SocketAddr, flags: i32) -> Result {
+        // SAFETY: FFI call; the address is valid for the lifetime of the wrapper.
+        unsafe {
+            to_result(bindings::kernel_connect(
+                self.0,
+                address.as_ptr() as _,
+                address.size() as _,
+                flags,
+            ))
+        }
+    }
+
+    /// Shuts down the socket.
+    ///
+    /// Wraps the `kernel_sock_shutdown` function.
+    pub fn shutdown(&self, how: ShutdownCmd) -> Result {
+        // SAFETY: FFI call; the address is valid for the lifetime of the wrapper.
+        unsafe { to_result(bindings::kernel_sock_shutdown(self.0, how as _)) }
+    }
+
+    /// Receive a message from the socket.
+    ///
+    /// This function is the lowest-level receive function. It is used by the other receive functions.
+    ///
+    /// The `flags` parameter is a set of flags that control the behavior of the function.
+    /// The flags are described in the [`ReceiveFlag`] enum.
+    ///
+    /// The returned Message is a wrapper for `msghdr` and it contains the header information about the message,
+    /// including the sender address (if present) and the flags.
+    ///
+    /// The data message is written to the provided buffer and the number of bytes written is returned together with the header.
+    ///
+    /// Wraps the `kernel_recvmsg` function.
+    pub fn receive_msg(
+        &self,
+        bytes: &mut [u8],
+        flags: FlagSet<ReceiveFlag>,
+    ) -> Result<(usize, MessageHeader)> {
+        let addr = SocketAddrStorage::default();
+
+        let mut msg = bindings::msghdr {
+            msg_name: &addr as *const _ as _,
+            ..Default::default()
+        };
+
+        let mut vec = bindings::kvec {
+            iov_base: bytes.as_mut_ptr() as _,
+            iov_len: bytes.len() as _,
+        };
+
+        // SAFETY: FFI call; the socket address is valid for the lifetime of the wrapper.
+        let size = unsafe {
+            bindings::kernel_recvmsg(
+                self.0,
+                &mut msg as _,
+                &mut vec,
+                1,
+                bytes.len() as _,
+                flags.value() as _,
+            )
+        };
+        to_result(size)?;
+
+        let addr: Option<SocketAddr> = SocketAddr::try_from_raw(addr).ok();
+
+        Ok((size as _, MessageHeader::new(msg, addr)))
+    }
+
+    /// Receives data from a remote socket and returns the bytes read and the sender address.
+    ///
+    /// Used by connectionless sockets to retrieve the sender of the message.
+    /// If the socket is connection-oriented, the sender address will be `None`.
+    ///
+    /// The function abstracts the usage of the `struct msghdr` type.
+    /// See [Socket::receive_msg] for more information.
+    pub fn receive_from(
+        &self,
+        bytes: &mut [u8],
+        flags: FlagSet<ReceiveFlag>,
+    ) -> Result<(usize, Option<SocketAddr>)> {
+        self.receive_msg(bytes, flags)
+            .map(|(size, hdr)| (size, hdr.into()))
+    }
+
+    /// Receives data from a remote socket and returns only the bytes read.
+    ///
+    /// Used by connection-oriented sockets, where the sender address is the connected peer.
+    pub fn receive(&self, bytes: &mut [u8], flags: FlagSet<ReceiveFlag>) -> Result<usize> {
+        let (size, _) = self.receive_from(bytes, flags)?;
+        Ok(size)
+    }
+
+    /// Sends a message to a remote socket.
+    ///
+    /// Wraps the `kernel_sendmsg` function.
+    ///
+    /// Crate-public to allow its usage only in the kernel crate.
+    /// In the future, this function could be made public, accepting a [`Message`] as input,
+    /// but with the current API, it does not give any advantage.
+    pub(crate) fn send_msg(
+        &self,
+        bytes: &[u8],
+        mut message: bindings::msghdr,
+        flags: FlagSet<SendFlag>,
+    ) -> Result<usize> {
+        let mut vec = bindings::kvec {
+            iov_base: bytes.as_ptr() as _,
+            iov_len: bytes.len() as _,
+        };
+        message.msg_flags = flags.value() as _;
+
+        // SAFETY: FFI call; the address is valid for the lifetime of the wrapper.
+        let size = unsafe {
+            bindings::kernel_sendmsg(
+                self.0,
+                &message as *const _ as _,
+                &mut vec,
+                1,
+                bytes.len() as _,
+            )
+        };
+        to_result(size)?;
+        Ok(size as _)
+    }
+
+    /// Sends a message to a remote socket and returns the bytes sent.
+    ///
+    /// The `flags` parameter is a set of flags that control the behavior of the function.
+    /// The flags are described in the [`SendFlag`] enum.
+    pub fn send(&self, bytes: &[u8], flags: FlagSet<SendFlag>) -> Result<usize> {
+        self.send_msg(bytes, bindings::msghdr::default(), flags)
+    }
+
+    /// Sends a message to a specific remote socket address and returns the bytes sent.
+    ///
+    /// The `flags` parameter is a set of flags that control the behavior of the function.
+    /// The flags are described in the [`SendFlag`] enum.
+    pub fn send_to(
+        &self,
+        bytes: &[u8],
+        address: &SocketAddr,
+        flags: FlagSet<SendFlag>,
+    ) -> Result<usize> {
+        let message = bindings::msghdr {
+            msg_name: address.as_ptr() as _,
+            msg_namelen: address.size() as _,
+            ..Default::default()
+        };
+        self.send_msg(bytes, message, flags)
+    }
+}
+
+impl Drop for Socket {
+    /// Closes and releases the socket.
+    ///
+    /// Wraps the `sock_release` function.
+    fn drop(&mut self) {
+        // SAFETY: FFI call; the address is valid for the lifetime of the wrapper.
+        unsafe {
+            bindings::sock_release(self.0);
+        }
+    }
+}
+
+// SAFETY: sockets are thread-safe; synchronization is handled by the kernel.
+unsafe impl Send for Socket {}
+unsafe impl Sync for Socket {}
+
+/// Socket header message.
+///
+/// Wraps the `msghdr` structure.
+/// This struct provides a safe interface to the `msghdr` structure.
+///
+/// The instances of this struct are only created by the `receive` methods of the [`Socket`] struct.
+///
+/// # Invariants
+/// The `msg_name` in the wrapped `msghdr` object is always null; the address is stored in the `MessageHeader` object
+/// and can be retrieved with the [`MessageHeader::address`] method.
+#[derive(Clone, Copy)]
+pub struct MessageHeader(pub(crate) bindings::msghdr, pub(crate) Option<SocketAddr>);
+
+impl MessageHeader {
+    /// Returns the address of the message.
+    pub fn address(&self) -> Option<&SocketAddr> {
+        self.1.as_ref()
+    }
+
+    /// Returns the flags of the message.
+    pub fn flags(&self) -> FlagSet<MessageFlag> {
+        FlagSet::from(self.0.msg_flags as isize)
+    }
+
+    /// Consumes the message header and returns the underlying `msghdr` structure.
+    ///
+    /// The returned msghdr will have a null pointer for the address.
+    pub fn into_raw(self) -> bindings::msghdr {
+        self.0
+    }
+
+    /// Creates a new message header.
+    ///
+    /// The `msg_name` of the field gets replaced with a NULL pointer.
+    pub(crate) fn new(mut hdr: bindings::msghdr, addr: Option<SocketAddr>) -> Self {
+        hdr.msg_name = core::ptr::null_mut();
+        Self(hdr, addr)
+    }
+}
+
+impl From<MessageHeader> for Option<SocketAddr> {
+    /// Consumes the message header and returns the contained address.
+    fn from(hdr: MessageHeader) -> Self {
+        hdr.1
+    }
+}
+
+impl From<MessageHeader> for bindings::msghdr {
+    /// Consumes the message header and returns the underlying `msghdr` structure.
+    ///
+    /// The returned msghdr will have a null pointer for the address.
+    ///
+    /// This function is actually supposed to be crate-public, since bindings are not supposed to be
+    /// used outside the kernel library.
+    /// However, until the support for `msghdr` is not complete, specific needs might be satisfied
+    /// only by using directly the underlying `msghdr` structure.
+    fn from(hdr: MessageHeader) -> Self {
+        hdr.0
+    }
+}
-- 
2.41.0

