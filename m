Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DC877B560
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbjHNJY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbjHNJY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:24:28 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66136113;
        Mon, 14 Aug 2023 02:24:26 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe9f226cdbso2387495e87.0;
        Mon, 14 Aug 2023 02:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692005065; x=1692609865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKwBqPEgaF7GGJd1uZ0G836C9Z+tCMwn3BXMzLPwzdM=;
        b=EPCmrUAqbNfcwXjEIIWR5/2CJFasKFl4syMWkPF3FZuE8cWFVzU7C2keep9qhC1Gm3
         LEIYXayrlLTjmhmk7BUMYah7XOt02nQSYMzr0mzubOW3lBNpnCPFcc44Px0hDcyZg9I9
         ca5Cg1Wa5cqdV+DWu/EZmV3GeAZ5Yz9VUyRHAD4ovB1NwMt+XkhcRR9/7Jr5K9dztGbg
         OdUnE6lk7/XlfLauNU1Ot8Ij6yIyc+VnZ5uI7EIGbu0LvVCKkX8UY0pugl7iYhFOWtiE
         ef0LolAiUJaYasQD+zkbM8IxlNdqGnnte2XIKh/xVq2AamAtP0Uxn655GZH8c+UJc6mf
         syMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692005065; x=1692609865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKwBqPEgaF7GGJd1uZ0G836C9Z+tCMwn3BXMzLPwzdM=;
        b=U7hp2znHnealmQuK5q2lJuhEUTEp8ZQuQoAwMn81SseSK7Qn1eklUkkRPBJCcTDJxI
         GDvl4ji6kXcyhoijZ+0NUki+HmOSbTFdyPKhIHKTSmfT+Go0dTPj9XYwh6EUBDF4cAJt
         FO3sKP7dCGr4O3XpLagAmpeAwKEgtAA9NfU6SRw4rUYE0vIPUQZNTYlUgXwQWEl4BzGQ
         rwLf96XAjLeItnJDWO5xvCCGW86UxykwpPGWoqSTaH2p1aD7ImA1UE/PfBG9oPiUjtJK
         Jq9K67AEdDJ+4tJ8daPqyyZVr/WsStFjFpynx8GFyop2B6o0cMNdjBLxiEADo8JEOemF
         sOJQ==
X-Gm-Message-State: AOJu0Ywf+GHEBH6P9ciI6rHN4NtnY1puobq6oBUUqsmfAOORVHnguJd7
        9VXa35h8xHlcfKMQjw1wseM=
X-Google-Smtp-Source: AGHT+IGpwp+ZyqfMY5B/+RRrjUgb101LBbd5850Ez4yGUlneGmQzeFNZbbwE46GHa/FFBh0DpJtlUA==
X-Received: by 2002:a05:6512:48da:b0:4fe:61f:3025 with SMTP id er26-20020a05651248da00b004fe061f3025mr5557600lfb.61.1692005064559;
        Mon, 14 Aug 2023 02:24:24 -0700 (PDT)
Received: from micheledallerive.home ([2a02:1210:6051:ec00:61e9:3767:83a6:9bd9])
        by smtp.gmail.com with ESMTPSA id b5-20020aa7c6c5000000b005224d960e66sm5314879eds.96.2023.08.14.02.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 02:24:24 -0700 (PDT)
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
Subject: [RFC PATCH 1/7] rust: net: add net module files and shared enums.
Date:   Mon, 14 Aug 2023 11:22:56 +0200
Message-ID: <20230814092302.1903203-2-dallerivemichele@gmail.com>
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

Create `net` module files and network headers in `bindings_helper.h`.
Add `IpProtocol`, `AddressFamily` and `Namespace`.

The wrappers added with this patch are shared across the whole network
subsystem. For this reason, they are placed in the `net.rs` module file.

The enum `IpProtocol`, however, is placed in an individual `ip.rs`
submodule, allowing to place together all the ip-related structures,
such as wrappers for `iphdr`, `ip_auth_hdr`, etc.

Signed-off-by: Michele Dalle Rive <dallerivemichele@gmail.com>
---
 rust/bindings/bindings_helper.h |   3 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/net.rs              | 180 ++++++++++++++++++++++++++++++++
 rust/kernel/net/ip.rs           |  73 +++++++++++++
 4 files changed, 258 insertions(+)
 create mode 100644 rust/kernel/net.rs
 create mode 100644 rust/kernel/net/ip.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 058954961bfc..7cc1bd73c77a 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,9 @@
  */
 
 #include <linux/errname.h>
+#include <linux/netfilter.h>
+#include <linux/inet.h>
+#include <linux/tcp.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
 #include <linux/wait.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 85b261209977..8e6926d965e1 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -34,6 +34,8 @@
 pub mod error;
 pub mod init;
 pub mod ioctl;
+#[cfg(CONFIG_NET)]
+pub mod net;
 pub mod prelude;
 pub mod print;
 mod static_assert;
diff --git a/rust/kernel/net.rs b/rust/kernel/net.rs
new file mode 100644
index 000000000000..1eda336b48e4
--- /dev/null
+++ b/rust/kernel/net.rs
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Network subsystem.
+//!
+//! This module contains the kernel APIs related to networking that have been ported or wrapped for
+//! usage by Rust code in the kernel.
+//!
+//! C header: [`include/linux/net.h`](../../../../include/linux/net.h) and related
+
+use crate::error::{code, Error};
+use core::cell::UnsafeCell;
+pub mod ip;
+
+/// The address family.
+///
+/// See [`man 7 address families`](https://man7.org/linux/man-pages/man7/address_families.7.html) for more information.
+#[derive(Debug, Copy, Clone, PartialEq, Eq, Hash)]
+pub enum AddressFamily {
+    /// Unspecified address family.
+    Unspec = bindings::AF_UNSPEC as isize,
+    /// Local to host (pipes and file-domain).
+    Unix = bindings::AF_UNIX as isize,
+    /// Internetwork: UDP, TCP, etc.
+    Inet = bindings::AF_INET as isize,
+    /// Amateur radio AX.25.
+    Ax25 = bindings::AF_AX25 as isize,
+    /// IPX.
+    Ipx = bindings::AF_IPX as isize,
+    /// Appletalk DDP.
+    Appletalk = bindings::AF_APPLETALK as isize,
+    /// AX.25 packet layer protocol.
+    Netrom = bindings::AF_NETROM as isize,
+    /// Bridge link.
+    Bridge = bindings::AF_BRIDGE as isize,
+    /// ATM PVCs.
+    Atmpvc = bindings::AF_ATMPVC as isize,
+    /// X.25 (ISO-8208).
+    X25 = bindings::AF_X25 as isize,
+    /// IPv6.
+    Inet6 = bindings::AF_INET6 as isize,
+    /// ROSE protocol.
+    Rose = bindings::AF_ROSE as isize,
+    /// DECnet protocol.
+    Decnet = bindings::AF_DECnet as isize,
+    /// 802.2LLC project.
+    Netbeui = bindings::AF_NETBEUI as isize,
+    /// Firewall hooks.
+    Security = bindings::AF_SECURITY as isize,
+    /// Key management protocol.
+    Key = bindings::AF_KEY as isize,
+    /// Netlink.
+    Netlink = bindings::AF_NETLINK as isize,
+    /// Low-level packet interface.
+    Packet = bindings::AF_PACKET as isize,
+    /// Acorn Econet protocol.
+    Econet = bindings::AF_ECONET as isize,
+    /// ATM SVCs.
+    Atmsvc = bindings::AF_ATMSVC as isize,
+    /// RDS sockets.
+    Rds = bindings::AF_RDS as isize,
+    /// IRDA sockets.
+    Irda = bindings::AF_IRDA as isize,
+    /// Generic PPP.
+    Pppox = bindings::AF_PPPOX as isize,
+    /// Legacy WAN networks protocol.
+    Wanpipe = bindings::AF_WANPIPE as isize,
+    /// LLC protocol.
+    Llc = bindings::AF_LLC as isize,
+    /// Infiniband.
+    Ib = bindings::AF_IB as isize,
+    /// Multiprotocol label switching.
+    Mpls = bindings::AF_MPLS as isize,
+    /// Controller Area Network.
+    Can = bindings::AF_CAN as isize,
+    /// TIPC sockets.
+    Tipc = bindings::AF_TIPC as isize,
+    /// Bluetooth sockets.
+    Bluetooth = bindings::AF_BLUETOOTH as isize,
+    /// IUCV sockets.
+    Iucv = bindings::AF_IUCV as isize,
+    /// RxRPC sockets.
+    Rxrpc = bindings::AF_RXRPC as isize,
+    /// Modular ISDN protocol.
+    Isdn = bindings::AF_ISDN as isize,
+    /// Nokia cellular modem interface.
+    Phonet = bindings::AF_PHONET as isize,
+    /// IEEE 802.15.4 sockets.
+    Ieee802154 = bindings::AF_IEEE802154 as isize,
+    /// CAIF sockets.
+    Caif = bindings::AF_CAIF as isize,
+    /// Kernel crypto API
+    Alg = bindings::AF_ALG as isize,
+    /// VMware VSockets.
+    Vsock = bindings::AF_VSOCK as isize,
+    /// KCM sockets.
+    Kcm = bindings::AF_KCM as isize,
+    /// Qualcomm IPC router protocol.
+    Qipcrtr = bindings::AF_QIPCRTR as isize,
+    /// SMC sockets.
+    Smc = bindings::AF_SMC as isize,
+    /// Express Data Path sockets.
+    Xdp = bindings::AF_XDP as isize,
+}
+
+impl From<AddressFamily> for isize {
+    fn from(family: AddressFamily) -> Self {
+        family as isize
+    }
+}
+
+impl TryFrom<isize> for AddressFamily {
+    type Error = Error;
+
+    fn try_from(value: isize) -> Result<Self, Self::Error> {
+        let val = value as u32;
+        match val {
+            bindings::AF_UNSPEC => Ok(Self::Unspec),
+            bindings::AF_UNIX => Ok(Self::Unix),
+            bindings::AF_INET => Ok(Self::Inet),
+            bindings::AF_AX25 => Ok(Self::Ax25),
+            bindings::AF_IPX => Ok(Self::Ipx),
+            bindings::AF_APPLETALK => Ok(Self::Appletalk),
+            bindings::AF_NETROM => Ok(Self::Netrom),
+            bindings::AF_BRIDGE => Ok(Self::Bridge),
+            bindings::AF_ATMPVC => Ok(Self::Atmpvc),
+            bindings::AF_X25 => Ok(Self::X25),
+            bindings::AF_INET6 => Ok(Self::Inet6),
+            bindings::AF_ROSE => Ok(Self::Rose),
+            bindings::AF_DECnet => Ok(Self::Decnet),
+            bindings::AF_NETBEUI => Ok(Self::Netbeui),
+            bindings::AF_SECURITY => Ok(Self::Security),
+            bindings::AF_KEY => Ok(Self::Key),
+            bindings::AF_NETLINK => Ok(Self::Netlink),
+            bindings::AF_PACKET => Ok(Self::Packet),
+            bindings::AF_ECONET => Ok(Self::Econet),
+            bindings::AF_ATMSVC => Ok(Self::Atmsvc),
+            bindings::AF_RDS => Ok(Self::Rds),
+            bindings::AF_IRDA => Ok(Self::Irda),
+            bindings::AF_PPPOX => Ok(Self::Pppox),
+            bindings::AF_WANPIPE => Ok(Self::Wanpipe),
+            bindings::AF_LLC => Ok(Self::Llc),
+            bindings::AF_IB => Ok(Self::Ib),
+            bindings::AF_MPLS => Ok(Self::Mpls),
+            bindings::AF_CAN => Ok(Self::Can),
+            bindings::AF_TIPC => Ok(Self::Tipc),
+            bindings::AF_BLUETOOTH => Ok(Self::Bluetooth),
+            bindings::AF_IUCV => Ok(Self::Iucv),
+            bindings::AF_RXRPC => Ok(Self::Rxrpc),
+            bindings::AF_ISDN => Ok(Self::Isdn),
+            bindings::AF_PHONET => Ok(Self::Phonet),
+            bindings::AF_IEEE802154 => Ok(Self::Ieee802154),
+            bindings::AF_CAIF => Ok(Self::Caif),
+            bindings::AF_ALG => Ok(Self::Alg),
+            bindings::AF_VSOCK => Ok(Self::Vsock),
+            bindings::AF_KCM => Ok(Self::Kcm),
+            bindings::AF_QIPCRTR => Ok(Self::Qipcrtr),
+            bindings::AF_SMC => Ok(Self::Smc),
+            bindings::AF_XDP => Ok(Self::Xdp),
+            _ => Err(code::EINVAL),
+        }
+    }
+}
+
+/// Network namespace.
+///
+/// Wraps the `net` struct.
+#[repr(transparent)]
+pub struct Namespace(UnsafeCell<bindings::net>);
+
+/// The global network namespace.
+///
+/// This is the default and initial namespace.
+/// This function replaces the C `init_net` global variable.
+pub fn init_net() -> &'static Namespace {
+    // SAFETY: `init_net` is a global variable and is always valid.
+    let ptr = unsafe { core::ptr::addr_of!(bindings::init_net) };
+    // SAFETY: the address of `init_net` is always valid, always points to initialized memory,
+    // and is always aligned.
+    unsafe { &*(ptr.cast()) }
+}
diff --git a/rust/kernel/net/ip.rs b/rust/kernel/net/ip.rs
new file mode 100644
index 000000000000..84f98d356137
--- /dev/null
+++ b/rust/kernel/net/ip.rs
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! IP protocol definitions.
+//!
+//! This module contains the kernel structures and functions related to IP protocols.
+//!
+//! C headers:
+//! - [`include/linux/in.h`](../../../../include/linux/in.h)
+//! - [`include/linux/ip.h`](../../../../include/linux/ip.h)
+//! - [`include/uapi/linux/ip.h`](../../../../include/uapi/linux/ip.h)
+
+/// The Ip protocol.
+///
+/// See [`tools/include/uapi/linux/in.h`](../../../../tools/include/uapi/linux/in.h)
+#[derive(Debug, Copy, Clone, PartialEq, Eq, Hash)]
+pub enum IpProtocol {
+    /// Dummy protocol for TCP
+    Ip = bindings::IPPROTO_IP as isize,
+    /// Internet Control Message Protocol
+    Icmp = bindings::IPPROTO_ICMP as isize,
+    /// Internet Group Management Protocol
+    Igmp = bindings::IPPROTO_IGMP as isize,
+    /// IPIP tunnels (older KA9Q tunnels use 94)
+    IpIp = bindings::IPPROTO_IPIP as isize,
+    /// Transmission Control Protocol
+    Tcp = bindings::IPPROTO_TCP as isize,
+    /// Exterior Gateway Protocol
+    Egp = bindings::IPPROTO_EGP as isize,
+    /// PUP protocol
+    Pup = bindings::IPPROTO_PUP as isize,
+    /// User Datagram Protocol
+    Udp = bindings::IPPROTO_UDP as isize,
+    /// XNS Idp protocol
+    Idp = bindings::IPPROTO_IDP as isize,
+    /// SO Transport Protocol Class 4
+    Tp = bindings::IPPROTO_TP as isize,
+    /// Datagram Congestion Control Protocol
+    Dccp = bindings::IPPROTO_DCCP as isize,
+    /// Ipv6-in-Ipv4 tunnelling
+    Ipv6 = bindings::IPPROTO_IPV6 as isize,
+    /// Rsvp Protocol
+    Rsvp = bindings::IPPROTO_RSVP as isize,
+    /// Cisco GRE tunnels (rfc 1701,1702)
+    Gre = bindings::IPPROTO_GRE as isize,
+    /// Encapsulation Security Payload protocol
+    Esp = bindings::IPPROTO_ESP as isize,
+    /// Authentication Header protocol
+    Ah = bindings::IPPROTO_AH as isize,
+    /// Multicast Transport Protocol
+    Mtp = bindings::IPPROTO_MTP as isize,
+    /// Ip option pseudo header for BEET
+    Beetph = bindings::IPPROTO_BEETPH as isize,
+    /// Encapsulation Header
+    Encap = bindings::IPPROTO_ENCAP as isize,
+    /// Protocol Independent Multicast
+    Pim = bindings::IPPROTO_PIM as isize,
+    /// Compression Header Protocol
+    Comp = bindings::IPPROTO_COMP as isize,
+    /// Layer 2 Tunnelling Protocol
+    L2Tp = bindings::IPPROTO_L2TP as isize,
+    /// Stream Control Transport Protocol
+    Sctp = bindings::IPPROTO_SCTP as isize,
+    /// Udp-Lite (Rfc 3828)
+    UdpLite = bindings::IPPROTO_UDPLITE as isize,
+    /// Mpls in Ip (Rfc 4023)
+    Mpls = bindings::IPPROTO_MPLS as isize,
+    /// Ethernet-within-Ipv6 Encapsulation
+    Ethernet = bindings::IPPROTO_ETHERNET as isize,
+    /// Raw Ip packets
+    Raw = bindings::IPPROTO_RAW as isize,
+    /// Multipath Tcp connection
+    Mptcp = bindings::IPPROTO_MPTCP as isize,
+}
-- 
2.41.0

