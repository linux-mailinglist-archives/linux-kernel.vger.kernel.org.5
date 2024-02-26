Return-Path: <linux-kernel+bounces-81546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB2186775B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BDA1F2228A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2995212B141;
	Mon, 26 Feb 2024 13:56:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1606F1292ED
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955784; cv=none; b=GZjAYYLNPwyp2+U1s2o31Mrp+89HVhtae7OxuUzb8C3YV+HpoC++1SCrnjaH3pkCKEM+0NGAJ6OHRJ/Q5Ilvl2Yt/VreUJYMgjkFywWmxaOAEcVhVyYdAnqdwq+/L4DjqWgavcvqntXsYEqe+Tibd/8XDoPFtzJbQzrLPzH8TDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955784; c=relaxed/simple;
	bh=GjTUn3rzqEKa8k5rOoBLJBFDa2D/5/zkrFgjRl51uVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p6BR1LkDJKRyd8kt2lBok+5Q+w4L7q+fKDswSFxWloVLqSSSbxqc3slloblcBXGc3Wv3w5zf+r5WI+gxH0ju8AQwJlMtZV6b0yu+qMgO/7VS7s91wJwU5pw7E3srkWF1dmDYHAQXHF9jB26oo/M32k8mayGm4wSNELNvhiGzlu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rebSh-00047D-FK; Mon, 26 Feb 2024 14:56:07 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rebSg-0030Qg-Cb; Mon, 26 Feb 2024 14:56:06 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rebSg-009FzF-11;
	Mon, 26 Feb 2024 14:56:06 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Mon, 26 Feb 2024 14:56:06 +0100
Subject: [PATCH v3 3/3] tools: usb: p9_fwd: add usb gadget packet forwarder
 script
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-ml-topic-u9p-v3-3-c62a36eccda1@pengutronix.de>
References: <20240116-ml-topic-u9p-v3-0-c62a36eccda1@pengutronix.de>
In-Reply-To: <20240116-ml-topic-u9p-v3-0-c62a36eccda1@pengutronix.de>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: v9fs@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9220;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=GjTUn3rzqEKa8k5rOoBLJBFDa2D/5/zkrFgjRl51uVQ=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBl3Jh1KL7TeqPlL9J0tcVnipUVl9N0l35XrS0cc
 O1KIl3NxXGJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZdyYdQAKCRC/aVhE+XH0
 q0dUD/0WJ1wjn/JHPmVSQcPPG2y3XouCoip0NZuYYspuYcJbKlgDTBvemuH8Em7qD9VLk3e1jXc
 kq9ltj8h/hdt2RRmRaYV/YwSaKOu4FjDdKQ+vFssJBFPDzl1HehawYBfaKr0jn5RjvZk1qiaTQe
 hGXmZKgaEe0RnjJbktNkD931i6Rz5rYEFTgv7kN8dXh8T6/Ey2YRKAbKK6AjrjYwcoGwXanbuyU
 SgC2nCYZJjL1Xcq2P7P+Cdjp4Z8r2IXlhaUb9CkxMy32Wzxoys5FO/WTqiKBeNgIIvp9JZJdZCI
 5KadGA0QJlC7M/znbgC7GTaj4G52z1r+Kk/wAgK2VEaeDsBbwy6aF23IGglNYIqwYTugIAanuWa
 ujAm4Jb7yBXFCEUI60r/NSECABgZR0l5MZ+u0veICEyqF9wfDeCmrta4YccxSqiShz0/e81M5oB
 Ws+GVjlkQD04ba5o8LLxx9Yh38tda7YhwCLIDxh9aAaJZoga2PR9VeAZizDkpcbVG1mu4jQm2dS
 WGFBgxyWlticUvE104h3yr0NS0LGo+YUkZfztIdad1U1AKVpVtDqy+khLEjGlg9v5hh77bQYP5H
 GVuLZrHO8GNYxa/lq4qu9dgB1prnP1PXm/QXlyyBk8ZRGSZqiYVrlFKw7K0yUH9HfcERdJ8PW79
 89RKsMTSZ8dbdGA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This patch is adding an small python tool to forward 9pfs requests
from the USB gadget to an existing 9pfs TCP server. Since currently all
9pfs servers lack support for the usb transport this tool is an useful
helper to get started.

Refer the Documentation section "USBG Example" in
Documentation/filesystems/9p.rst on how to use it.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v2 -> v3: -
v1 -> v2:
  - added usbg 9pfs detailed instructions to 9p.rst doc
---
 Documentation/filesystems/9p.rst |  32 +++++++
 tools/usb/p9_fwd.py              | 194 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 226 insertions(+)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index 64439068a8fc5..264265c72ba67 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -67,6 +67,38 @@ To mount a 9p FS on a USB Host accessible via the gadget as root filesystem::
 where mount_tag is the tag associated by the usb gadget transport. The
 pattern is usb9pfs0, usb9pfs1, ...
 
+USBG Example
+============
+
+The USB host exports a filesystem, while the gadget on the USB device
+side makes it mountable.
+
+Diod (9pfs server) and the forwarder are on the development host, where
+the root filesystem is actually stored. The gadget is initialized during
+boot (or later) on the embedded board. Then the forwarder will find it
+on the USB bus and start forwarding requests.
+
+In this case the 9p requests come from the device and are handled by the
+host. The reason is that USB device ports are normally not available on
+PCs, so a connection in the other direction would not work.
+
+When using the usbg transport, for now there is no native usb host
+service capable to handle the requests from the gadget driver. For
+this we have to use the extra python tool p9_fwd.py from tools/usb.
+
+Just start the 9pfs capable network server like diod/nfs-ganesha e.g.:
+
+	$ diod -f -n -d 0 -S -l 0.0.0.0:9999 -e $PWD
+
+Then start the python transport:
+
+	$ python $kernel_dir/tools/usb/p9_fwd.py -p 9999
+
+After that the gadget driver can be used as described above.
+
+One use-case is to use it as an alternative to NFS root booting during
+the development of embedded Linux devices.
+
 Options
 =======
 
diff --git a/tools/usb/p9_fwd.py b/tools/usb/p9_fwd.py
new file mode 100755
index 0000000000000..95208df11abef
--- /dev/null
+++ b/tools/usb/p9_fwd.py
@@ -0,0 +1,194 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import argparse
+import errno
+import logging
+import socket
+import struct
+import sys
+import time
+
+import usb.core
+import usb.util
+
+
+class Forwarder:
+    HEXDUMP_FILTER = (
+        "".join(chr(x).isprintable() and chr(x) or "." for x in range(128)) + "." * 128
+    )
+
+    @staticmethod
+    def _log_hexdump(data):
+        if not logging.root.isEnabledFor(logging.TRACE):
+            return
+        L = 16
+        for c in range(0, len(data), L):
+            chars = data[c : c + L]
+            dump = " ".join(f"{x:02x}" for x in chars)
+            printable = "".join(HEXDUMP_FILTER[x] for x in chars)
+            line = f"{c:08x}  {dump:{L*3}s} |{printable:{L}s}|"
+            logging.root.log(logging.TRACE, "%s", line)
+
+    def __init__(self, server):
+        self.stats = {
+            "c2s packets": 0,
+            "c2s bytes": 0,
+            "s2c packets": 0,
+            "s2c bytes": 0,
+        }
+        self.stats_logged = time.monotonic()
+
+        dev = usb.core.find(idVendor=0x1D6B, idProduct=0x0109)
+        if dev is None:
+            raise ValueError("Device not found")
+
+        logging.info(f"found device: {dev.bus}/{dev.address}")
+
+        # dev.set_configuration() is not necessary since g_multi has only one
+        usb9pfs = None
+        # g_multi adds 9pfs as last interface
+        cfg = dev.get_active_configuration()
+        for intf in cfg:
+            # we have to detach the usb-storage driver from multi gadget since
+            # stall option could be set, which will lead to spontaneous port
+            # resets and our transfers will run dead
+            if intf.bInterfaceClass == 0x08:
+                if dev.is_kernel_driver_active(intf.bInterfaceNumber):
+                    dev.detach_kernel_driver(intf.bInterfaceNumber)
+
+            if (
+                intf.bInterfaceClass == 0xFF
+                and intf.bInterfaceSubClass == 0xFF
+                and intf.bInterfaceProtocol == 0x09
+            ):
+                usb9pfs = intf
+        if usb9pfs is None:
+            raise ValueError("Interface not found")
+
+        logging.info(f"claiming interface:\n{usb9pfs}")
+        usb.util.claim_interface(dev, usb9pfs.bInterfaceNumber)
+        ep_out = usb.util.find_descriptor(
+            usb9pfs,
+            custom_match=lambda e: usb.util.endpoint_direction(e.bEndpointAddress)
+            == usb.util.ENDPOINT_OUT,
+        )
+        assert ep_out is not None
+        ep_in = usb.util.find_descriptor(
+            usb9pfs,
+            custom_match=lambda e: usb.util.endpoint_direction(e.bEndpointAddress)
+            == usb.util.ENDPOINT_IN,
+        )
+        assert ep_in is not None
+        logging.info(f"interface claimed")
+
+        self.ep_out = ep_out
+        self.ep_in = ep_in
+        self.dev = dev
+
+        # create and connect socket
+        self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
+        self.s.connect(server)
+
+        logging.info(f"connected to server")
+
+    def c2s(self):
+        """forward a request from the USB client to the TCP server"""
+        data = None
+        while data is None:
+            try:
+                logging.log(logging.TRACE, "c2s: reading")
+                data = self.ep_in.read(self.ep_in.wMaxPacketSize)
+            except usb.core.USBTimeoutError:
+                logging.log(logging.TRACE, "c2s: reading timed out")
+                continue
+            except usb.core.USBError as e:
+                if e.errno == errno.EIO:
+                    logging.debug("c2s: reading failed with %s, retrying", repr(e))
+                    time.sleep(0.5)
+                    continue
+                else:
+                    logging.error("c2s: reading failed with %s, aborting", repr(e))
+                    raise
+        size = struct.unpack("<I", data[:4])[0]
+        while len(data) < size:
+            data += self.ep_in.read(size - len(data))
+        logging.log(logging.TRACE, "c2s: writing")
+        self._log_hexdump(data)
+        self.s.send(data)
+        logging.debug("c2s: forwarded %i bytes", size)
+        self.stats["c2s packets"] += 1
+        self.stats["c2s bytes"] += size
+
+    def s2c(self):
+        """forward a response from the TCP server to the USB client"""
+        logging.log(logging.TRACE, "s2c: reading")
+        data = self.s.recv(4)
+        size = struct.unpack("<I", data[:4])[0]
+        while len(data) < size:
+            data += self.s.recv(size - len(data))
+        logging.log(logging.TRACE, "s2c: writing")
+        self._log_hexdump(data)
+        while data:
+            written = self.ep_out.write(data)
+            assert written > 0
+            data = data[written:]
+        if size % self.ep_out.wMaxPacketSize == 0:
+            logging.log(logging.TRACE, "sending zero length packet")
+            self.ep_out.write(b"")
+        logging.debug("s2c: forwarded %i bytes", size)
+        self.stats["s2c packets"] += 1
+        self.stats["s2c bytes"] += size
+
+    def log_stats(self):
+        logging.info("statistics:")
+        for k, v in self.stats.items():
+            logging.info(f"  {k+':':14s} {v}")
+
+    def log_stats_interval(self, interval=5):
+        if (time.monotonic() - self.stats_logged) < interval:
+            return
+
+        self.log_stats()
+        self.stats_logged = time.monotonic()
+
+
+def main():
+    parser = argparse.ArgumentParser(
+        description="Forward 9PFS requests from USB to TCP",
+    )
+
+    parser.add_argument(
+        "-s", "--server", type=str, default="127.0.0.1", help="server hostname"
+    )
+    parser.add_argument("-p", "--port", type=int, default=564, help="server port")
+    parser.add_argument("-v", "--verbose", action="count", default=0)
+
+    args = parser.parse_args()
+
+    logging.TRACE = logging.DEBUG - 5
+    logging.addLevelName(logging.TRACE, "TRACE")
+
+    if args.verbose >= 2:
+        level = logging.TRACE
+    elif args.verbose:
+        level = logging.DEBUG
+    else:
+        level = logging.INFO
+    logging.basicConfig(
+        level=level, format="%(asctime)-15s %(levelname)-8s %(message)s"
+    )
+
+    f = Forwarder(server=(args.server, args.port))
+
+    try:
+        while True:
+            f.c2s()
+            f.s2c()
+            f.log_stats_interval()
+    finally:
+        f.log_stats()
+
+
+if __name__ == "__main__":
+    main()

-- 
2.39.2


