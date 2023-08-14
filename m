Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DF977B55A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbjHNJY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbjHNJYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:24:31 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222EF113;
        Mon, 14 Aug 2023 02:24:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe8c16c1b4so6202757e87.2;
        Mon, 14 Aug 2023 02:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692005067; x=1692609867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2m3J5YuXv3z/VvSeyWTquGoeXd8RIuDyRxPA7kzxTo=;
        b=IY0ohCBws1qO/0dWq5lbWz8IJakewuiiPV3XgvHOJOmIRxUW8XhHARQggnhkrm4g+E
         2baMLNKzAo1uudnt/Vxsu1r3fFvlqhuNQvaTlPgDb+oo7YIg0s4X4Wzu/DHPDpjYlMjx
         bZVWon88ywi6UdespsG+KuzmmlkHKs7GnrsufzLuAt1P2vjrQpAxzGbcxwN5/F4Ycjoe
         SSRaY7PHZAmz8cJ31HcOxJzT7SBj7FMaVTXrKzhTppmpmZ0O4Iq//avOXIWrQDMT3UKR
         gN6GnssguIW8HXRp7UtPvhw3uNcfbRmC3JSrsB/atzN/MnfAjErwHDEOoTzXoi2vyHEv
         1bFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692005067; x=1692609867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2m3J5YuXv3z/VvSeyWTquGoeXd8RIuDyRxPA7kzxTo=;
        b=AHZEz2apILJ+4bX8wv5Q03Bq59a2Ilby51UhFlBaT+OObOChywv0yDRLeqN9N4RQcW
         86Fme/VdMi8hif9gRPM8ere9TcB/Dcz4MMZbhVnHOtKsgaaM8JjYN9QCLzYUn9EP3NTF
         CPmhleZDoXkoSqneBDeoJ0O2ga77XeCrrP2dLgq9g6LKvfXTJJ60JnB67+8+CItY4B6f
         uxM3Vry0//Hf/9yLL68mVTABPsry4MwIP8B19kTChaPNWNivxfULDefaxZkb5xIhQ7Xb
         QODBB0OSnsWv+1gFHq0jl2RgOVpKmw44IoPcGFOuKrOX0ZHeoM2LHlkju90k94MKiNH4
         uZ1w==
X-Gm-Message-State: AOJu0Yz/7SdtZ1XQdjDKug1xZDggr+YuTxycnk5EEuThE48O1XsuXBcm
        McLk2mHCvMPYl0SuRzlC8Uk=
X-Google-Smtp-Source: AGHT+IHMaHmrq3gyGiJvzqu2VUdj1mHeSLKz1xAh6HxtD/w3kror0wHO5eRjKZQp5IB5tf7U3RHLIw==
X-Received: by 2002:a05:6512:3090:b0:4fd:fadb:e6e4 with SMTP id z16-20020a056512309000b004fdfadbe6e4mr6890880lfd.69.1692005067116;
        Mon, 14 Aug 2023 02:24:27 -0700 (PDT)
Received: from micheledallerive.home ([2a02:1210:6051:ec00:61e9:3767:83a6:9bd9])
        by smtp.gmail.com with ESMTPSA id b5-20020aa7c6c5000000b005224d960e66sm5314879eds.96.2023.08.14.02.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 02:24:26 -0700 (PDT)
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
Subject: [RFC PATCH 3/7] rust: net: add socket-related flags and flagset.
Date:   Mon, 14 Aug 2023 11:22:58 +0200
Message-ID: <20230814092302.1903203-4-dallerivemichele@gmail.com>
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

Add enums representing flags related to sockets:
- `ReceiveFlag` to modify the behaviour of the socket receive operation.
- `SendFlag` to modify the behaviour of the socket send operation.
- `MessageFlag` to represent the flags in a `msghdr`.
- `SocketFlag` to represent the flags in the `socket` struct.

Introduce a `FlagSet` structure to offer a convenient way to handle the
flags.
Having an abstraction over the "raw" numerical value of the flags offers
many advantages:
- A `FlagSet` can be created in different ways: from an `IntoIterator`,
  a value, a single flag or using the defined macro `flag_set!(...)`.
- Custom operations can be defined, such as the bitwise or.
- Flags in the set can be set, tested, unset through functions instead
  of using bitwise operations.
- FlagSet implements the IntoIterator trait, allowing for iteration over
  the flags contained.

Signed-off-by: Michele Dalle Rive <dallerivemichele@gmail.com>
---
Opinions on FlagSet? I think it might be a convenient structure, for any
kind of "bitmask flag", not necessarily limited to the socket ones,
since it provides methods to easily create and access the flags.
However, it might be cumbersome to use to just obtain the same result of
a simple bitwise OR.

 rust/kernel/net/socket/flags.rs | 467 ++++++++++++++++++++++++++++++++
 1 file changed, 467 insertions(+)
 create mode 100644 rust/kernel/net/socket/flags.rs

diff --git a/rust/kernel/net/socket/flags.rs b/rust/kernel/net/socket/flags.rs
new file mode 100644
index 000000000000..fe98e09a8d46
--- /dev/null
+++ b/rust/kernel/net/socket/flags.rs
@@ -0,0 +1,467 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Socket-related flags and utilities.
+use crate::bindings;
+use core::fmt::Debug;
+use core::ops::{BitOr, BitOrAssign};
+
+/// Generic socket flag trait.
+///
+/// This trait represents any kind of flag with "bitmask" values (i.e. 0x1, 0x2, 0x4, 0x8, etc.)
+pub trait Flag:
+    Into<isize> + TryFrom<isize> + Debug + Copy + Clone + Send + Sync + 'static
+{
+}
+
+/// Socket send operation flags.
+///
+/// See <https://linux.die.net/man/2/sendmsg> for more.
+#[derive(Debug, Copy, Clone)]
+pub enum SendFlag {
+    /// Got a successful reply.
+    ///
+    /// Only valid for datagram and raw sockets.
+    /// Only valid for IPv4 and IPv6.
+    Confirm = bindings::MSG_CONFIRM as isize,
+
+    /// Don't use a gateway to send out the packet.
+    DontRoute = bindings::MSG_DONTROUTE as isize,
+
+    /// Enables nonblocking operation.
+    ///
+    /// If the operation would block, return immediately with an error.
+    DontWait = bindings::MSG_DONTWAIT as isize,
+
+    /// Terminates a record.
+    EOR = bindings::MSG_EOR as isize,
+
+    /// More data will be sent.
+    ///
+    /// Only valid for TCP and UDP sockets.
+    More = bindings::MSG_MORE as isize,
+
+    /// Don't send SIGPIPE error if the socket is shut down.
+    NoSignal = bindings::MSG_NOSIGNAL as isize,
+
+    /// Send out-of-band data on supported sockets.
+    OOB = bindings::MSG_OOB as isize,
+}
+
+impl From<SendFlag> for isize {
+    fn from(value: SendFlag) -> Self {
+        value as isize
+    }
+}
+
+impl TryFrom<isize> for SendFlag {
+    type Error = ();
+
+    fn try_from(value: isize) -> Result<SendFlag, Self::Error> {
+        let val = value as u32;
+        match val {
+            bindings::MSG_CONFIRM => Ok(SendFlag::Confirm),
+            bindings::MSG_DONTROUTE => Ok(SendFlag::DontRoute),
+            bindings::MSG_DONTWAIT => Ok(SendFlag::DontWait),
+            bindings::MSG_EOR => Ok(SendFlag::EOR),
+            bindings::MSG_MORE => Ok(SendFlag::More),
+            bindings::MSG_NOSIGNAL => Ok(SendFlag::NoSignal),
+            bindings::MSG_OOB => Ok(SendFlag::OOB),
+            _ => Err(()),
+        }
+    }
+}
+
+impl Flag for SendFlag {}
+
+/// Socket receive operation flags.
+///
+/// See <https://linux.die.net/man/2/recvmsg> for more.
+#[derive(Debug, Copy, Clone)]
+pub enum ReceiveFlag {
+    /// Enables nonblocking operation.
+    ///
+    /// If the operation would block, return immediately with an error.
+    DontWait = bindings::MSG_DONTWAIT as isize,
+
+    /// Specifies that queued errors should be received from the socket error queue.
+    ErrQueue = bindings::MSG_ERRQUEUE as isize,
+
+    /// Enables out-of-band reception.
+    OOB = bindings::MSG_OOB as isize,
+
+    /// Peeks at an incoming message.
+    ///
+    /// The data is treated as unread and the next recv() or similar function shall still return this data.
+    Peek = bindings::MSG_PEEK as isize,
+
+    /// Returns the real length of the packet, even when it was longer than the passed buffer.
+    ///
+    /// Only valid for raw, datagram, netlink and UNIX datagram sockets.
+    Trunc = bindings::MSG_TRUNC as isize,
+
+    /// Waits for the full request to be satisfied.
+    WaitAll = bindings::MSG_WAITALL as isize,
+}
+
+impl From<ReceiveFlag> for isize {
+    fn from(value: ReceiveFlag) -> Self {
+        value as isize
+    }
+}
+
+impl TryFrom<isize> for ReceiveFlag {
+    type Error = ();
+
+    fn try_from(value: isize) -> Result<Self, Self::Error> {
+        let val = value as u32;
+        match val {
+            bindings::MSG_DONTWAIT => Ok(ReceiveFlag::DontWait),
+            bindings::MSG_ERRQUEUE => Ok(ReceiveFlag::ErrQueue),
+            bindings::MSG_OOB => Ok(ReceiveFlag::OOB),
+            bindings::MSG_PEEK => Ok(ReceiveFlag::Peek),
+            bindings::MSG_TRUNC => Ok(ReceiveFlag::Trunc),
+            bindings::MSG_WAITALL => Ok(ReceiveFlag::WaitAll),
+            _ => Err(()),
+        }
+    }
+}
+
+impl Flag for ReceiveFlag {}
+
+/// Socket `flags` field flags.
+///
+/// These flags are used internally by the kernel.
+/// However, they are exposed here for completeness.
+///
+/// This enum does not implement the `Flag` trait, since it is not actually a flag.
+/// Flags are often defined as a mask that can be used to retrieve the flag value; the socket flags,
+/// instead, are defined as the index of the bit that they occupy in the `flags` field.
+/// This means that they cannot be used as a mask, just like all the other flags that implement `Flag` do.
+///
+/// For example, SOCK_PASSCRED has value 3, meaning that it is represented by the 3rd bit of the `flags` field;
+/// a normal flag would represent it as a mask, i.e. 1 << 3 = 0b1000.
+///
+/// See [include/linux/net.h](../../../../include/linux/net.h) for more.
+pub enum SocketFlag {
+    /// Undocumented.
+    NoSpace = bindings::SOCK_NOSPACE as isize,
+    /// Undocumented.
+    PassCred = bindings::SOCK_PASSCRED as isize,
+    /// Undocumented.
+    PassSecurity = bindings::SOCK_PASSSEC as isize,
+    /// Undocumented.
+    SupportZeroCopy = bindings::SOCK_SUPPORT_ZC as isize,
+    /// Undocumented.
+    CustomSockOpt = bindings::SOCK_CUSTOM_SOCKOPT as isize,
+    /// Undocumented.
+    PassPidFd = bindings::SOCK_PASSPIDFD as isize,
+}
+
+impl From<SocketFlag> for isize {
+    fn from(value: SocketFlag) -> Self {
+        value as isize
+    }
+}
+
+impl TryFrom<isize> for SocketFlag {
+    type Error = ();
+
+    fn try_from(value: isize) -> Result<Self, Self::Error> {
+        let val = value as u32;
+        match val {
+            bindings::SOCK_NOSPACE => Ok(SocketFlag::NoSpace),
+            bindings::SOCK_PASSCRED => Ok(SocketFlag::PassCred),
+            bindings::SOCK_PASSSEC => Ok(SocketFlag::PassSecurity),
+            bindings::SOCK_SUPPORT_ZC => Ok(SocketFlag::SupportZeroCopy),
+            bindings::SOCK_CUSTOM_SOCKOPT => Ok(SocketFlag::CustomSockOpt),
+            bindings::SOCK_PASSPIDFD => Ok(SocketFlag::PassPidFd),
+            _ => Err(()),
+        }
+    }
+}
+
+/// Flags associated with a received message.
+///
+/// Represents the flag contained in the `msg_flags` field of a `msghdr` struct.
+#[derive(Debug, Copy, Clone)]
+pub enum MessageFlag {
+    /// End of record.
+    Eor = bindings::MSG_EOR as isize,
+    /// Trailing portion of the message is discarded.
+    Trunc = bindings::MSG_TRUNC as isize,
+    /// Control data was discarded due to lack of space.
+    Ctrunc = bindings::MSG_CTRUNC as isize,
+    /// Out-of-band data was received.
+    Oob = bindings::MSG_OOB as isize,
+    /// An error was received instead of data.
+    ErrQueue = bindings::MSG_ERRQUEUE as isize,
+}
+
+impl From<MessageFlag> for isize {
+    fn from(value: MessageFlag) -> Self {
+        value as isize
+    }
+}
+
+impl TryFrom<isize> for MessageFlag {
+    type Error = ();
+
+    fn try_from(value: isize) -> Result<Self, Self::Error> {
+        let val = value as u32;
+        match val {
+            bindings::MSG_EOR => Ok(MessageFlag::Eor),
+            bindings::MSG_TRUNC => Ok(MessageFlag::Trunc),
+            bindings::MSG_CTRUNC => Ok(MessageFlag::Ctrunc),
+            bindings::MSG_OOB => Ok(MessageFlag::Oob),
+            bindings::MSG_ERRQUEUE => Ok(MessageFlag::ErrQueue),
+            _ => Err(()),
+        }
+    }
+}
+
+impl Flag for MessageFlag {}
+
+/// Structure representing a set of flags.
+///
+/// This structure is used to represent a set of flags, such as the flags passed to `send` or `recv`.
+/// It is generic over the type of flag that it contains.
+///
+/// # Invariants
+/// The value of the flags must be a valid combination of the flags that it contains.
+///
+/// This means that the value must be the bitwise OR of the values of the flags, and that it
+/// must be possible to retrieve the value of the flags from the value.
+///
+/// # Example
+/// ```
+/// use kernel::net::socket::flags::{SendFlag, FlagSet};
+///
+/// let mut flags = FlagSet::<SendFlag>::empty();
+/// flags.insert(SendFlag::DontWait);
+/// flags.insert(SendFlag::More);
+/// assert!(flags.contains(SendFlag::DontWait));
+/// assert!(flags.contains(SendFlag::More));
+/// flags.clear();
+/// assert_eq!(flags.value(), 0);
+///
+/// flags = FlagSet::<SendFlag>::from(SendFlag::More);
+/// flags |= SendFlag::DontWait;
+/// assert!(flags.contains(SendFlag::DontWait));
+/// ```
+#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
+pub struct FlagSet<T: Flag> {
+    value: isize,
+    _phantom: core::marker::PhantomData<T>,
+}
+
+impl<T: Flag> FlagSet<T> {
+    /// Create a new empty set of flags.
+    ///
+    /// # Example
+    /// ```
+    /// use kernel::net::socket::flags::{SendFlag, FlagSet};
+    ///
+    /// let flags = FlagSet::<SendFlag>::empty();
+    /// assert_eq!(flags.value(), 0);
+    /// ```
+    pub fn empty() -> Self {
+        FlagSet {
+            value: 0,
+            _phantom: core::marker::PhantomData,
+        }
+    }
+
+    /// Clear all the flags set.
+    ///
+    /// # Example
+    /// ```
+    /// use kernel::net::socket::flags::{SendFlag, FlagSet};
+    ///
+    /// let mut flags = FlagSet::<SendFlag>::from(SendFlag::More);
+    /// assert!(flags.contains(SendFlag::More));
+    /// flags.clear();
+    /// assert_eq!(flags.value(), 0);
+    /// ```
+    pub fn clear(&mut self) {
+        self.value = 0;
+    }
+
+    /// Add a flag to the set.
+    ///
+    /// # Example
+    /// ```
+    /// use kernel::net::socket::flags::{SendFlag, FlagSet};
+    ///
+    /// let mut flags = FlagSet::<SendFlag>::empty();
+    /// assert!(!flags.contains(SendFlag::DontWait));
+    /// flags.insert(SendFlag::DontWait);
+    /// assert!(flags.contains(SendFlag::DontWait));
+    /// ```
+    pub fn insert(&mut self, flag: T) {
+        self.value |= flag.into();
+    }
+
+    /// Remove a flag from the set.
+    ///
+    /// # Example
+    /// ```
+    /// use kernel::net::socket::flags::{SendFlag, FlagSet};
+    ///
+    /// let mut flags = FlagSet::<SendFlag>::from(SendFlag::DontWait);
+    /// assert!(flags.contains(SendFlag::DontWait));
+    /// flags.remove(SendFlag::DontWait);
+    /// assert!(!flags.contains(SendFlag::DontWait));
+    /// ```
+    pub fn remove(&mut self, flag: T) {
+        self.value &= !flag.into();
+    }
+
+    /// Check if a flag is set.
+    ///
+    /// # Example
+    /// ```
+    /// use kernel::net::socket::flags::{SendFlag, FlagSet};
+    ///
+    /// let mut flags = FlagSet::<SendFlag>::from(SendFlag::DontWait);
+    /// assert!(flags.contains(SendFlag::DontWait));
+    /// ```
+    pub fn contains(&self, flag: T) -> bool {
+        self.value & flag.into() != 0
+    }
+
+    /// Get the integer value of the flags set.
+    ///
+    /// # Example
+    /// ```
+    /// use kernel::net::socket::flags::{SendFlag, FlagSet};
+    ///
+    /// let flags = FlagSet::<SendFlag>::from(SendFlag::DontWait);
+    /// assert_eq!(flags.value(), SendFlag::DontWait as isize);
+    /// ```
+    pub fn value(&self) -> isize {
+        self.value
+    }
+}
+
+impl<T: Flag> BitOr<T> for FlagSet<T> {
+    type Output = FlagSet<T>;
+
+    fn bitor(self, rhs: T) -> Self::Output {
+        FlagSet {
+            value: self.value | rhs.into(),
+            _phantom: core::marker::PhantomData,
+        }
+    }
+}
+
+impl<T: Flag> BitOrAssign<T> for FlagSet<T> {
+    fn bitor_assign(&mut self, rhs: T) {
+        self.value |= rhs.into();
+    }
+}
+
+// impl from isize for any flags<T>
+impl<T: Flag> From<isize> for FlagSet<T> {
+    fn from(value: isize) -> Self {
+        FlagSet {
+            value,
+            _phantom: core::marker::PhantomData,
+        }
+    }
+}
+
+impl<T: Flag> From<T> for FlagSet<T> {
+    fn from(value: T) -> Self {
+        Self::from(value.into())
+    }
+}
+
+impl<T: Flag> FromIterator<T> for FlagSet<T> {
+    fn from_iter<I: IntoIterator<Item = T>>(iter: I) -> Self {
+        let mut flags = FlagSet::empty();
+        for flag in iter {
+            flags.insert(flag);
+        }
+        flags
+    }
+}
+
+impl<T: Flag> From<FlagSet<T>> for isize {
+    fn from(value: FlagSet<T>) -> Self {
+        value.value
+    }
+}
+
+impl<T: Flag> IntoIterator for FlagSet<T> {
+    type Item = T;
+    type IntoIter = FlagSetIterator<T>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        FlagSetIterator {
+            flags: self,
+            current: 0,
+        }
+    }
+}
+
+/// Iterator over the flags in a set.
+///
+/// This iterator iterates over the flags in a set, in order of increasing value.
+///
+/// # Example
+/// ```
+/// use kernel::net::socket::flags::{SendFlag, FlagSet};
+///
+/// let mut flags = FlagSet::from_iter([SendFlag::DontWait, SendFlag::More]);
+/// for flag in flags.into_iter() {
+///    println!("Flag: {:?}", flag);
+/// }
+/// ```
+pub struct FlagSetIterator<T: Flag> {
+    flags: FlagSet<T>,
+    current: usize,
+}
+
+impl<T: Flag> Iterator for FlagSetIterator<T> {
+    type Item = T;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        let mut value = 1 << self.current;
+        while value <= self.flags.value {
+            self.current += 1;
+            if self.flags.value & value != 0 {
+                if let Ok(flag) = T::try_from(value) {
+                    return Some(flag);
+                }
+            }
+            value = 1 << self.current;
+        }
+        None
+    }
+}
+
+/// Create a set of flags from a list of flags.
+///
+/// This macro provides a compact way to create empty sets and sets from a list of flags.
+///
+/// # Example
+/// ```
+/// use kernel::net::socket::flags::SendFlag;
+/// use kernel::flag_set;
+///
+/// let mut flags = flag_set!(SendFlag::DontWait, SendFlag::More);
+/// assert!(flags.contains(SendFlag::DontWait));
+/// assert!(flags.contains(SendFlag::More));
+///
+/// let mut empty_flags = flag_set!();
+/// assert_eq!(empty_flags.value(), 0);
+/// ```
+#[macro_export]
+macro_rules! flag_set {
+    () => {
+        $crate::net::socket::flags::FlagSet::empty()
+    };
+    ($($flag:expr),+) => {
+        $crate::net::socket::flags::FlagSet::from_iter([$($flag),+])
+    };
+}
-- 
2.41.0

