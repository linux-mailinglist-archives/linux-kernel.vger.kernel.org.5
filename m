Return-Path: <linux-kernel+bounces-165090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9546F8B879E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F05D288989
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520515336F;
	Wed,  1 May 2024 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egLdHRxY"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5204F898;
	Wed,  1 May 2024 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555508; cv=none; b=M6v8CZNskQ+rBDxu50LgCiRFW5jbsknKoBAQdpm/KSz5nfKMsr798d6F5ymEg7EzdRssss8SZM/SOPEkPT7AAOO1S7PZk4CsfGghVw5fVz+lrYtqvB3wVq7U14aWPQJr6Tj00agZOXWOs2n5dgyd0AjFpCU7vWSURMHTF3QNEDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555508; c=relaxed/simple;
	bh=4VFbzCFBxWb2PGzLuUg2FvxCGZnk5h713KQ73Rh2Uek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7t67aD9luKwqJ7OeY+BBxdDWrZSpgkssWONwzc4AJQmDy5ataAsyftxpCGnCQC9MdSJHks5VTTkZbmxH7eopVejcbkLCjl8zk4hwFC1IZbz4YZnWx0TgDq3iRwAV71OBqVr2V/5Lhhy7PEKPKkZl47GxdGftUl/vkRPwNxN+7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egLdHRxY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5872b74c44so745575566b.3;
        Wed, 01 May 2024 02:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714555503; x=1715160303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4bmK+LvBN8rYiao5qrhdSSk79xwg2CMrJHbC4y4SSI=;
        b=egLdHRxY0Lmr2RThX7QXObTqWYykxDatawh6yzUIAIInHADYLHTDnM+n6iqRywKRuH
         XJnVRHklZrqvBDLO1jr/6QR7xRHxPT01cimUH3UMUwq40m4NFeFDQ2A6lcmKChLBbrwn
         KYVI+50tu3ompiG1vImIz1XczAj3CEfvf10vq62nQh/K0hO6I8b09H9YF3bkvFSNvUCx
         sW+4PvOx+54sU0WpXomOYW7W4u80tnONQMz0u6zS1CWZJQjRmJP73V/ia5ocWIHZ4sFO
         bMPo+lMwUBmDJMx/Z2mJlnmgYwCNXk5sn1b6dhnYreR/0Cfx3wCPakTgVy3LEA8oT2l/
         G8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714555503; x=1715160303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4bmK+LvBN8rYiao5qrhdSSk79xwg2CMrJHbC4y4SSI=;
        b=X36l/+Xmg6w5fUMIj6VGCGCDTHXEMgJ7MDjqx1s7u+mgSq+qUU1c+zyDOHdP9QnBYa
         9M9DGWdc6ro3wy1jt0UkwLiZoUqcZKDdGDu7YkigqJfv8WIYiQGzSxOli2EYGE30XGbm
         9KvonyS5a5AT/kcmzZWibVVXwgyd0a2Un/Ydifhb5D6R7CtZXt2ldovvp6PQ+1opguRL
         YGU/7YJtg8Tx3B1ubKhr3m5ljMal179vxRURM2cvgZiqJP6v9yASR4BuBLdvCPeRLTmj
         a0RY/BcpqnEVvV7UtxI4A/YB2wKayfW/gyP7Wrd/ySNDowIaWehJDVOjZkjqFhJLWHFD
         WTWA==
X-Forwarded-Encrypted: i=1; AJvYcCXBh+Td8B63DDweyl7piKZUhO4+KFl93xllEuzcTfdjhByfadf8nADcm79XLF3OC6RxszE2uVswASHN8+ksWj494ocbT5N8VIUQdK9O+CHaGU2/KE3yXjOsaaF9fF/9WSRlhUUC/ZsA
X-Gm-Message-State: AOJu0YyxuRdvuZHJPlGgNbtDPivQuGsKcEQatJ5d0ahJHyD/9HzELwjb
	ETRFQOAn3cj05lHmWv0Ehdn3IFE85nc/ubGhNnQlS69A4Tk232Xf
X-Google-Smtp-Source: AGHT+IEmGWW1NEhnCcHCm2nv4kIkziOnm5cw7jAbT6qEEiMep4qr/6phRX2iPk1iwWlUDffgpbKDQA==
X-Received: by 2002:a17:906:3a91:b0:a58:e71d:d24 with SMTP id y17-20020a1709063a9100b00a58e71d0d24mr1323327ejd.12.1714555502897;
        Wed, 01 May 2024 02:25:02 -0700 (PDT)
Received: from fedora.fritz.box (host-95-248-171-25.retail.telecomitalia.it. [95.248.171.25])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906434600b00a518c69c4e3sm16023678ejm.23.2024.05.01.02.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 02:25:02 -0700 (PDT)
From: Francesco Valla <valla.francesco@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	fabio@redaril.me,
	Francesco Valla <valla.francesco@gmail.com>
Subject: [PATCH] Documentation: networking: document ISO 15765-2
Date: Wed,  1 May 2024 11:24:13 +0200
Message-ID: <20240501092413.414700-2-valla.francesco@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501092413.414700-1-valla.francesco@gmail.com>
References: <20240501092413.414700-1-valla.francesco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document basic concepts, APIs and behaviour of the ISO 15675-2 (ISO-TP)
CAN stack.

Signed-off-by: Francesco Valla <valla.francesco@gmail.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 Documentation/networking/index.rst      |   1 +
 Documentation/networking/iso15765-2.rst | 386 ++++++++++++++++++++++++
 MAINTAINERS                             |   1 +
 3 files changed, 388 insertions(+)
 create mode 100644 Documentation/networking/iso15765-2.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 473d72c36d61..bbd9bf537793 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -19,6 +19,7 @@ Contents:
    caif/index
    ethtool-netlink
    ieee802154
+   iso15765-2
    j1939
    kapi
    msg_zerocopy
diff --git a/Documentation/networking/iso15765-2.rst b/Documentation/networking/iso15765-2.rst
new file mode 100644
index 000000000000..0e9d96074178
--- /dev/null
+++ b/Documentation/networking/iso15765-2.rst
@@ -0,0 +1,386 @@
+.. SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+
+====================
+ISO 15765-2 (ISO-TP)
+====================
+
+Overview
+========
+
+ISO 15765-2, also known as ISO-TP, is a transport protocol specifically defined
+for diagnostic communication on CAN. It is widely used in the automotive
+industry, for example as the transport protocol for UDSonCAN (ISO 14229-3) or
+emission-related diagnostic services (ISO 15031-5).
+
+ISO-TP can be used both on CAN CC (aka Classical CAN) and CAN FD (CAN with
+Flexible Datarate) based networks. It is also designed to be compatible with a
+CAN network using SAE J1939 as data link layer (however, this is not a
+requirement).
+
+Specifications used
+-------------------
+
+* ISO 15765-2:2024 : Road vehicles - Diagnostic communication over Controller
+  Area Network (DoCAN). Part 2: Transport protocol and network layer services.
+
+Addressing
+----------
+
+In its simplest form, ISO-TP is based on two kinds of addressing modes for the
+nodes connected to the same network:
+
+* physical addressing is implemented by two node-specific addresses and is used
+  in 1-to-1 communication.
+
+* functional addressing is implemented by one node-specific address and is used
+  in 1-to-N communication.
+
+Three different addressing formats can be employed:
+
+* "normal" : each address is represented simply by a CAN ID.
+
+* "extended": each address is represented by a CAN ID plus the first byte of
+  the CAN payload; both the CAN ID and the byte inside the payload shall be
+  different between two addresses.
+
+* "mixed": each address is represented by a CAN ID plus the first byte of
+  the CAN payload; the CAN ID is different between two addresses, but the
+  additional byte is the same.
+
+Transport protocol and associated frame types
+---------------------------------------------
+
+When transmitting data using the ISO-TP protocol, the payload can either fit
+inside one single CAN message or not, also considering the overhead the protocol
+is generating and the optional extended addressing. In the first case, the data
+is transmitted at once using a so-called Single Frame (SF). In the second case,
+ISO-TP defines a multi-frame protocol, in which the sender provides (through a
+First Frame - FF) the PDU length which is to be transmitted and also asks for a
+Flow Control (FC) frame, which provides the maximum supported size of a macro
+data block (``blocksize``) and the minimum time between the single CAN messages
+composing such block (``stmin``). Once this information has been received, the
+sender starts to send frames containing fragments of the data payload (called
+Consecutive Frames - CF), stopping after every ``blocksize``-sized block to wait
+confirmation from the receiver which should then send another Flow Control
+frame to inform the sender about its availability to receive more data.
+
+How to Use ISO-TP
+=================
+
+As with others CAN protocols, the ISO-TP stack support is built into the
+Linux network subsystem for the CAN bus, aka. Linux-CAN or SocketCAN, and
+thus follows the same socket API.
+
+Creation and basic usage of an ISO-TP socket
+--------------------------------------------
+
+To use the ISO-TP stack, ``#include <linux/can/isotp.h>`` shall be used. A
+socket can then be created using the ``PF_CAN`` protocol family, the
+``SOCK_DGRAM`` type (as the underlying protocol is datagram-based by design)
+and the ``CAN_ISOTP`` protocol:
+
+.. code-block:: C
+
+    s = socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP);
+
+After the socket has been successfully created, ``bind(2)`` shall be called to
+bind the socket to the desired CAN interface; to do so:
+
+* a TX CAN ID shall be specified as part of the sockaddr supplied to the call
+  itself.
+
+* a RX CAN ID shall also be specified, unless broadcast flags have been set
+  through socket option (explained below).
+
+Once bound to an interface, the socket can be read from and written to using
+the usual ``read(2)`` and ``write(2)`` system calls, as well as ``send(2)``,
+``sendmsg(2)``, ``recv(2)`` and ``recvmsg(2)``.
+Unlike the CAN_RAW socket API, only the ISO-TP data field (the actual payload)
+is sent and received by the userspace application using these calls. The address
+information and the protocol information are automatically filled by the ISO-TP
+stack using the configuration supplied during socket creation. In the same way,
+the stack will use the transport mechanism when required (i.e., when the size
+of the data payload exceeds the MTU of the underlying CAN bus).
+
+The sockaddr structure used for SocketCAN has extensions for use with ISO-TP,
+as specified below:
+
+.. code-block:: C
+
+    struct sockaddr_can {
+        sa_family_t can_family;
+        int         can_ifindex;
+        union {
+            struct { canid_t rx_id, tx_id; } tp;
+        ...
+        } can_addr;
+    }
+
+* ``can_family`` and ``can_ifindex`` serve the same purpose as for other
+  SocketCAN sockets.
+
+* ``can_addr.tp.rx_id`` specifies the receive (RX) CAN ID and will be used as
+  a RX filter.
+
+* ``can_addr.tp.tx_id`` specifies the transmit (TX) CAN ID
+
+ISO-TP socket options
+---------------------
+
+When creating an ISO-TP socket, reasonable defaults are set. Some options can
+be modified with ``setsockopt(2)`` and/or read back with ``getsockopt(2)``.
+
+General options
+~~~~~~~~~~~~~~~
+
+General socket options can be passed using the ``CAN_ISOTP_OPTS`` optname:
+
+.. code-block:: C
+
+    struct can_isotp_options opts;
+    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_OPTS, &opts, sizeof(opts))
+
+where the ``can_isotp_options`` structure has the following contents:
+
+.. code-block:: C
+
+    struct can_isotp_options {
+        u32 flags;
+        u32 frame_txtime;
+        u8  ext_address;
+        u8  txpad_content;
+        u8  rxpad_content;
+        u8  rx_ext_address;
+    };
+
+* ``flags``: modifiers to be applied to the default behaviour of the ISO-TP
+  stack. Following flags are available:
+
+  * ``CAN_ISOTP_LISTEN_MODE``: listen only (do not send FC frames); normally
+    used as a testing feature.
+
+  * ``CAN_ISOTP_EXTEND_ADDR``: use the byte specified in ``ext_address`` as an
+    additional address component. This enables the "mixed" addressing format if
+    used alone, or the "extended" addressing format if used in conjunction with
+    ``CAN_ISOTP_RX_EXT_ADDR``.
+
+  * ``CAN_ISOTP_TX_PADDING``: enable padding for transmitted frames, using
+    ``txpad_content`` as value for the padding bytes.
+
+  * ``CAN_ISOTP_RX_PADDING``: enable padding for the received frames, using
+    ``rxpad_content`` as value for the padding bytes.
+
+  * ``CAN_ISOTP_CHK_PAD_LEN``: check for correct padding length on the received
+    frames.
+
+  * ``CAN_ISOTP_CHK_PAD_DATA``: check padding bytes on the received frames
+    against ``rxpad_content``; if ``CAN_ISOTP_RX_PADDING`` is not specified,
+    this flag is ignored.
+
+  * ``CAN_ISOTP_HALF_DUPLEX``: force ISO-TP socket in half duplex mode
+    (that is, transport mechanism can only be incoming or outgoing at the same
+    time, not both).
+
+  * ``CAN_ISOTP_FORCE_TXSTMIN``: ignore stmin from received FC; normally
+    used as a testing feature.
+
+  * ``CAN_ISOTP_FORCE_RXSTMIN``: ignore CFs depending on rx stmin; normally
+    used as a testing feature.
+
+  * ``CAN_ISOTP_RX_EXT_ADDR``: use ``rx_ext_address`` instead of ``ext_address``
+    as extended addressing byte on the reception path. If used in conjunction
+    with ``CAN_ISOTP_EXTEND_ADDR``, this flag effectively enables the "extended"
+    addressing format.
+
+  * ``CAN_ISOTP_WAIT_TX_DONE``: wait until the frame is sent before returning
+    from ``write(2)`` and ``send(2)`` calls (i.e., blocking write operations).
+
+  * ``CAN_ISOTP_SF_BROADCAST``: use 1-to-N functional addressing (cannot be
+    specified alongside ``CAN_ISOTP_CF_BROADCAST``).
+
+  * ``CAN_ISOTP_CF_BROADCAST``: use 1-to-N transmission without flow control
+    (cannot be specified alongside ``CAN_ISOTP_SF_BROADCAST``).
+    NOTE: this is not covered by the ISO 15765-2 standard.
+
+  * ``CAN_ISOTP_DYN_FC_PARMS``: enable dynamic update of flow control
+    parameters.
+
+* ``frame_txtime``: frame transmission time (defined as N_As/N_Ar inside the
+  ISO standard); if ``0``, the default (or the last set value) is used.
+  To set the transmission time to ``0``, the ``CAN_ISOTP_FRAME_TXTIME_ZERO``
+  macro (equal to 0xFFFFFFFF) shall be used.
+
+* ``ext_address``: extended addressing byte, used if the
+  ``CAN_ISOTP_EXTEND_ADDR`` flag is specified.
+
+* ``txpad_content``: byte used as padding value for transmitted frames.
+
+* ``rxpad_content``: byte used as padding value for received frames.
+
+* ``rx_ext_address``: extended addressing byte for the reception path, used if
+  the ``CAN_ISOTP_RX_EXT_ADDR`` flag is specified.
+
+Flow Control options
+~~~~~~~~~~~~~~~~~~~~
+
+Flow Control (FC) options can be passed using the ``CAN_ISOTP_RECV_FC`` optname
+to provide the communication parameters for receiving ISO-TP PDUs.
+
+.. code-block:: C
+
+    struct can_isotp_fc_options fc_opts;
+    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_RECV_FC, &fc_opts, sizeof(fc_opts));
+
+where the ``can_isotp_fc_options`` structure has the following contents:
+
+.. code-block:: C
+
+    struct can_isotp_options {
+        u8 bs;
+        u8 stmin;
+        u8 wftmax;
+    };
+
+* ``bs``: blocksize provided in flow control frames.
+
+* ``stmin``: minimum separation time provided in flow control frames; can
+  have the following values (others are reserved):
+
+  * 0x00 - 0x7F : 0 - 127 ms
+
+  * 0xF1 - 0xF9 : 100 us - 900 us
+
+* ``wftmax``: maximum number of wait frames provided in flow control frames.
+
+Link Layer options
+~~~~~~~~~~~~~~~~~~
+
+Link Layer (LL) options can be passed using the ``CAN_ISOTP_LL_OPTS`` optname:
+
+.. code-block:: C
+
+    struct can_isotp_ll_options ll_opts;
+    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_LL_OPTS, &ll_opts, sizeof(ll_opts));
+
+where the ``can_isotp_ll_options`` structure has the following contents:
+
+.. code-block:: C
+
+    struct can_isotp_ll_options {
+        u8 mtu;
+        u8 tx_dl;
+        u8 tx_flags;
+    };
+
+* ``mtu``: generated and accepted CAN frame type, can be equal to ``CAN_MTU``
+  for classical CAN frames or ``CANFD_MTU`` for CAN FD frames.
+
+* ``tx_dl``: maximum payload length for transmitted frames, can have one value
+  among: 8, 12, 16, 20, 24, 32, 48, 64. Values above 8 only apply to CAN FD
+  traffic (i.e.: ``mtu = CANFD_MTU``).
+
+* ``tx_flags``: flags set into ``struct canfd_frame.flags`` at frame creation.
+  Only applies to CAN FD traffic (i.e.: ``mtu = CANFD_MTU``).
+
+Transmission stmin
+~~~~~~~~~~~~~~~~~~
+
+The transmission minimum separation time (stmin) can be forced using the
+``CAN_ISOTP_TX_STMIN`` optname and providing an stmin value in microseconds as
+a 32bit unsigned integer; this will overwrite the value sent by the receiver in
+flow control frames:
+
+.. code-block:: C
+
+    uint32_t stmin;
+    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_TX_STMIN, &stmin, sizeof(stmin));
+
+Reception stmin
+~~~~~~~~~~~~~~~
+
+The reception minimum separation time (stmin) can be forced using the
+``CAN_ISOTP_RX_STMIN`` optname and providing an stmin value in microseconds as
+a 32bit unsigned integer; received Consecutive Frames (CF) which timestamps
+differ less than this value will be ignored:
+
+.. code-block:: C
+
+    uint32_t stmin;
+    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_RX_STMIN, &stmin, sizeof(stmin));
+
+Multi-frame transport support
+-----------------------------
+
+The ISO-TP stack contained inside the Linux kernel supports the multi-frame
+transport mechanism defined by the standard, with the following constraints:
+
+* the maximum size of a PDU is defined by a module parameter, with an hard
+  limit imposed at build time.
+
+* when a transmission is in progress, subsequent calls to ``write(2)`` will
+  block, while calls to ``send(2)`` will either block or fail depending on the
+  presence of the ``MSG_DONTWAIT`` flag.
+
+* no support is present for sending "wait frames": whether a PDU can be fully
+  received or not is decided when the First Frame is received.
+
+Errors
+------
+
+Following errors are reported to userspace:
+
+RX path errors
+~~~~~~~~~~~~~~
+
+============ ===============================================================
+-ETIMEDOUT   timeout of data reception
+-EILSEQ      sequence number mismatch during a multi-frame reception
+-EBADMSG     data reception with wrong padding
+============ ===============================================================
+
+TX path errors
+~~~~~~~~~~~~~~
+
+========== =================================================================
+-ECOMM     flow control reception timeout
+-EMSGSIZE  flow control reception overflow
+-EBADMSG   flow control reception with wrong layout/padding
+========== =================================================================
+
+Examples
+========
+
+Basic node example
+------------------
+
+Following example implements a node using "normal" physical addressing, with
+RX ID equal to 0x18DAF142 and a TX ID equal to 0x18DA42F1. All options are left
+to their default.
+
+.. code-block:: C
+
+  int s;
+  struct sockaddr_can addr;
+  int ret;
+
+  s = socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP);
+  if (s < 0)
+      exit(1);
+
+  addr.can_family = AF_CAN;
+  addr.can_ifindex = if_nametoindex("can0");
+  addr.tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
+  addr.tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
+
+  ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
+  if (ret < 0)
+      exit(1);
+
+  /* Data can now be received using read(s, ...) and sent using write(s, ...) */
+
+Additional examples
+-------------------
+
+More complete (and complex) examples can be found inside the ``isotp*`` userland
+tools, distributed as part of the ``can-utils`` utilities at:
+https://github.com/linux-can/can-utils
diff --git a/MAINTAINERS b/MAINTAINERS
index 62b1a16b791b..e768c4ed349d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4695,6 +4695,7 @@ W:	https://github.com/linux-can
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
 F:	Documentation/networking/can.rst
+F:	Documentation/networking/iso15765-2.rst
 F:	include/linux/can/can-ml.h
 F:	include/linux/can/core.h
 F:	include/linux/can/skb.h
-- 
2.44.0


