Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF2B77B55B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbjHNJZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbjHNJYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:24:34 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BABCD7;
        Mon, 14 Aug 2023 02:24:32 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-523d0fab783so3393873a12.2;
        Mon, 14 Aug 2023 02:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692005071; x=1692609871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGJFz/kZfK8TC+IMfmkiVkLeybb1P+BYtZwOfhN+JxY=;
        b=MVHDfbVGNWloigTfg8DMCVjWLzA7g4y4G3Y2Ei5NcraB2Ay47TWfuuHHIlpOxg6ICd
         yAlzaL2rfDPakLMQQqYEShsDdz8D5VpqVWvC7S0oL6jUGzJHrm7akKx17X1MrWgqI0lb
         qzHPMQ02a1EWLcX5Rfa+Wqpa1z0KqRxHvdbgn+DxTJjVsxWW2YhsifzcNdJNZWDt5v7L
         oHIj8vawXFODiETAUaaGAyEP3nB/Ow1DpSFSdE/EbU0lnsyogma/LvCYHJRV6ld27DrP
         3AwoedgjC00XhWOMMNmHtxjO3BjGQjZFARhSrhHTwpi78c07D9/3sXfKBWBOht+mT/Qv
         kiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692005071; x=1692609871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGJFz/kZfK8TC+IMfmkiVkLeybb1P+BYtZwOfhN+JxY=;
        b=inUCMoJeqd16Ax+c6ZejkXaYbnZhAyVx5qNnFa39/DHjbIN6LtlSMt7aXDRLNbuHQB
         dAvRvS8C4WiHpRitlI74MxzHhMb+DzBDJbVh02MvUpraiWIZ18cTRGxKwIN7NhXsvYcz
         ge5tqDUZIrxoCwQk8oeMyjH86pGReOsF21JGxHCVlC62mMfH0B/o5uNYpM7Wv2XtmTNO
         N4WX/wXcydTpsonDCCcZO1Jp9DYp+PrbtEYtMO9nWxWxhXWapXfFfGRWXsBznesrmvKW
         HBF+GV/5r+JRBh9dz/0+x7S8NZGBy6NMjlzl14oSAyrQ/RyJKosLKyAj6aGrgu57qCfA
         HbXA==
X-Gm-Message-State: AOJu0Yz214JdizLnQ77lvPpNoPSiy05QeTcB9B8SzQ9hG7LwXLgwBoSl
        2HNrroo6ibkS73shn4D1FlE=
X-Google-Smtp-Source: AGHT+IHneK7ICFfdfFl4QH4pdwU2VHv7B3JQN2jRjmZ6z2yvspOSD6EL/lJD4e7TBQ7a39d2CUTfQg==
X-Received: by 2002:aa7:dd55:0:b0:51e:309:2e12 with SMTP id o21-20020aa7dd55000000b0051e03092e12mr3134953edw.28.1692005070782;
        Mon, 14 Aug 2023 02:24:30 -0700 (PDT)
Received: from micheledallerive.home ([2a02:1210:6051:ec00:61e9:3767:83a6:9bd9])
        by smtp.gmail.com with ESMTPSA id b5-20020aa7c6c5000000b005224d960e66sm5314879eds.96.2023.08.14.02.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 02:24:30 -0700 (PDT)
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
Subject: [RFC PATCH 6/7] rust: net: add socket TCP wrappers.
Date:   Mon, 14 Aug 2023 11:23:01 +0200
Message-ID: <20230814092302.1903203-7-dallerivemichele@gmail.com>
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

Add `TcpListener` and `TcpStream` wrappers around the Rust Socket.
They provide a convenient way to handle TCP sockets.

This interface is intended to be as close as possible to the one in `std::net`.

Signed-off-by: Michele Dalle Rive <dallerivemichele@gmail.com>
---
 rust/kernel/net.rs     |   1 +
 rust/kernel/net/tcp.rs | 252 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 253 insertions(+)
 create mode 100644 rust/kernel/net/tcp.rs

diff --git a/rust/kernel/net.rs b/rust/kernel/net.rs
index 7d58ebb0324f..c7d9d4b0bcab 100644
--- a/rust/kernel/net.rs
+++ b/rust/kernel/net.rs
@@ -13,6 +13,7 @@
 pub mod addr;
 pub mod ip;
 pub mod socket;
+pub mod tcp;
 
 /// The address family.
 ///
diff --git a/rust/kernel/net/tcp.rs b/rust/kernel/net/tcp.rs
new file mode 100644
index 000000000000..86a42ac3e367
--- /dev/null
+++ b/rust/kernel/net/tcp.rs
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! TCP socket wrapper.
+//!
+//! This module contains wrappers for a TCP Socket ([`TcpListener`]) and an active
+//! TCP connection ([`TcpStream`]).
+//! The wrappers are just convenience structs around the generic [`Socket`] type.
+//!
+//! The API is inspired by the Rust standard library's [`TcpListener`](https://doc.rust-lang.org/std/net/struct.TcpListener.html) and [`TcpStream`](https://doc.rust-lang.org/std/net/struct.TcpStream.html).
+
+use crate::error::Result;
+use crate::net::addr::SocketAddr;
+use crate::net::ip::IpProtocol;
+use crate::net::socket::flags::{FlagSet, ReceiveFlag, SendFlag};
+use crate::net::socket::opts::{SocketOption, WritableOption};
+use crate::net::socket::{ShutdownCmd, SockType, Socket};
+use crate::net::AddressFamily;
+use kernel::net::socket::MessageHeader;
+
+/// A TCP listener.
+///
+/// Wraps the [`Socket`] type to create a TCP-specific interface.
+///
+/// The wrapper abstracts away the generic Socket methods that a connection-oriented
+/// protocol like TCP does not need.
+///
+/// # Examples
+/// ```rust
+/// use kernel::net::tcp::TcpListener;
+/// use kernel::net::addr::*;
+///
+/// let listener = TcpListener::new(SocketAddr::V4(SocketAddrV4::new(Ipv4Addr::LOOPBACK, 8000))).unwrap();
+/// while let Ok(stream) = listener.accept() {
+///   // ...
+/// }
+pub struct TcpListener(pub(crate) Socket);
+
+impl TcpListener {
+    /// Create a new TCP listener bound to the given address.
+    ///
+    /// The listener will be ready to accept connections.
+    pub fn new(address: SocketAddr) -> Result<Self> {
+        let socket = Socket::new(AddressFamily::Inet, SockType::Stream, IpProtocol::Tcp)?;
+        socket.bind(address)?;
+        socket.listen(128)?;
+        Ok(Self(socket))
+    }
+
+    /// Returns the local address that this listener is bound to.
+    ///
+    /// See [`Socket::sockname()`] for more.
+    pub fn sockname(&self) -> Result<SocketAddr> {
+        self.0.sockname()
+    }
+
+    /// Returns an iterator over incoming connections.
+    ///
+    /// Each iteration will return a [`Result`] containing a [`TcpStream`] on success.
+    /// See [`TcpIncoming`] for more.
+    ///
+    /// # Examples
+    /// ```rust
+    /// use kernel::net::tcp::TcpListener;
+    /// use kernel::net::addr::*;
+    ///
+    /// let listener = TcpListener::new(SocketAddr::V4(SocketAddrV4::new(Ipv4Addr::LOOPBACK, 8000))).unwrap();
+    /// for stream in listener.incoming() {
+    ///    // ...
+    /// }
+    /// ```
+    pub fn incoming(&self) -> TcpIncoming<'_> {
+        TcpIncoming { listener: self }
+    }
+
+    /// Accepts an incoming connection.
+    ///
+    /// Returns a [`TcpStream`] on success.
+    pub fn accept(&self) -> Result<TcpStream> {
+        Ok(TcpStream(self.0.accept(true)?))
+    }
+
+    /// Sets the value of the given option.
+    ///
+    /// See [`Socket::set_option()`](Socket::set_option) for more.
+    pub fn set_option<O>(&self, value: impl Into<O::Type>) -> Result
+    where
+        O: SocketOption + WritableOption,
+    {
+        self.0.set_option::<O>(value)
+    }
+}
+
+/// An iterator over incoming connections from a [`TcpListener`].
+///
+/// Each iteration will return a [`Result`] containing a [`TcpStream`] on success.
+/// The iterator will never return [`None`].
+///
+/// This struct is created by the [`TcpListener::incoming()`] method.
+pub struct TcpIncoming<'a> {
+    listener: &'a TcpListener,
+}
+
+impl Iterator for TcpIncoming<'_> {
+    /// The item type of the iterator.
+    type Item = Result<TcpStream>;
+
+    /// Get the next connection from the listener.
+    fn next(&mut self) -> Option<Self::Item> {
+        Some(self.listener.accept())
+    }
+}
+
+/// A TCP stream.
+///
+/// Represents an active TCP connection between two sockets.
+/// The stream can be opened by the listener, with [`TcpListener::accept()`], or by
+/// connecting to a remote address with [`TcpStream::connect()`].
+/// The stream can be used to send and receive data.
+///
+/// See [`TcpListener`] for an example of how to create a [`TcpStream`].
+pub struct TcpStream(pub(crate) Socket);
+
+impl TcpStream {
+    /// Opens a TCP stream by connecting to the given address.
+    ///
+    /// Returns a [`TcpStream`] on success.
+    ///
+    /// # Examples
+    /// ```rust
+    /// use kernel::net::tcp::TcpStream;
+    /// use kernel::net::addr::*;
+    ///
+    /// let peer_addr = SocketAddr::V4(SocketAddrV4::new(Ipv4Addr::LOOPBACK, 8000));
+    /// let stream = TcpStream::connect(&peer_addr).unwrap();
+    /// ```
+    pub fn connect(address: &SocketAddr) -> Result<Self> {
+        let socket = Socket::new(AddressFamily::Inet, SockType::Stream, IpProtocol::Tcp)?;
+        socket.connect(address, 0)?;
+        Ok(Self(socket))
+    }
+
+    /// Returns the address of the remote peer of this connection.
+    ///
+    /// See [`Socket::peername()`] for more.
+    pub fn peername(&self) -> Result<SocketAddr> {
+        self.0.peername()
+    }
+
+    /// Returns the address of the local socket of this connection.
+    ///
+    /// See [`Socket::sockname()`] for more.
+    pub fn sockname(&self) -> Result<SocketAddr> {
+        self.0.sockname()
+    }
+
+    /// Receive data from the stream.
+    /// The given flags are used to modify the behavior of the receive operation.
+    /// See [`ReceiveFlag`] for more.
+    ///
+    /// Returns the number of bytes received.
+    ///
+    /// # Examples
+    /// ```rust
+    /// use kernel::flag_set;
+    /// use kernel::net::tcp::TcpListener;
+    /// use kernel::net::addr::*;
+    ///
+    /// let listener = TcpListener::new(SocketAddr::V4(SocketAddrV4::new(Ipv4Addr::LOOPBACK, 8000))).unwrap();
+    /// while let Ok(stream) = listener.accept() {
+    ///     let mut buf = [0u8; 1024];
+    ///     while let Ok(len) = stream.receive(&mut buf, flag_set!()) {
+    ///         // ...
+    ///     }
+    /// }
+    /// ```
+    pub fn receive(&self, buf: &mut [u8], flags: FlagSet<ReceiveFlag>) -> Result<usize> {
+        self.0.receive(buf, flags)
+    }
+
+    /// Receive data from the stream and return the message header.
+    ///
+    /// The given flags are used to modify the behavior of the receive operation.
+    ///
+    /// Returns the number of bytes received and the message header, which contains
+    /// information about the sender and the message.
+    ///
+    /// See [`Socket::receive_msg()`] for more.
+    pub fn receive_msg(
+        &self,
+        buf: &mut [u8],
+        flags: FlagSet<ReceiveFlag>,
+    ) -> Result<(usize, MessageHeader)> {
+        self.0.receive_msg(buf, flags)
+    }
+
+    /// Send data to the stream.
+    ///
+    /// The given flags are used to modify the behavior of the send operation.
+    /// See [`SendFlag`] for more.
+    ///
+    /// Returns the number of bytes sent.
+    ///
+    /// # Examples
+    /// ```rust
+    /// use kernel::flag_set;
+    /// use kernel::net::tcp::TcpListener;
+    /// use kernel::net::addr::*;
+    ///
+    /// let listener = TcpListener::new(SocketAddr::V4(SocketAddrV4::new(Ipv4Addr::LOOPBACK, 8000))).unwrap();
+    /// while let Ok(stream) = listener.accept() {
+    ///     let mut buf = [0u8; 1024];
+    ///     while let Ok(len) = stream.receive(&mut buf, flag_set!()) {
+    ///         stream.send(&buf[..len], flag_set!())?;
+    ///     }
+    /// }
+    /// ```
+    pub fn send(&self, buf: &[u8], flags: FlagSet<SendFlag>) -> Result<usize> {
+        self.0.send(buf, flags)
+    }
+
+    /// Manually shutdown some portion of the stream.
+    /// See [`ShutdownCmd`] for more.
+    ///
+    /// This method is not required to be called, as the stream will be shutdown
+    /// automatically when it is dropped.
+    ///
+    /// # Examples
+    /// ```rust
+    /// use kernel::net::tcp::TcpListener;
+    /// use kernel::net::addr::*;
+    /// use kernel::net::socket::ShutdownCmd;
+    ///
+    /// let listener = TcpListener::new(SocketAddr::V4(SocketAddrV4::new(Ipv4Addr::LOOPBACK, 8000))).unwrap();
+    /// while let Ok(stream) = listener.accept() {
+    ///    // ...
+    ///    stream.shutdown(ShutdownCmd::Both)?;
+    /// }
+    /// ```
+    pub fn shutdown(&self, how: ShutdownCmd) -> Result {
+        self.0.shutdown(how)
+    }
+}
+
+impl Drop for TcpStream {
+    /// Shutdown the stream.
+    ///
+    /// This method ignores the outcome of the shutdown operation: whether the stream
+    /// is successfully shutdown or not, the stream will be dropped anyways.
+    fn drop(&mut self) {
+        self.0.shutdown(ShutdownCmd::Both).ok();
+    }
+}
-- 
2.41.0

