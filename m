Return-Path: <linux-kernel+bounces-49017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF488464D7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536F61F26C4B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A181F4401;
	Fri,  2 Feb 2024 00:05:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465AA1FBE
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706832338; cv=none; b=nOnecD1y8llpvex3L6Xacax6h3vU3oMOkSBNtv0yLVQ16QFRhkqhNiS+0+l4xHpVZylhF1ZfMbEoto02kXTSXApR58vudau4X5zfc85pOmm84hXWwWAciGIG5D+NdRlCERQ7V5kSllYQWNo9/PuNEamNUCtbhgFpL2iQtHfB0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706832338; c=relaxed/simple;
	bh=IdiYYWpzmr9RPusGSBqszbMgZq+ap0BptPduyKLTtUQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YWvYR98h0JekOvBniZwSXaMgOmsrFaz0gLi40m4eAGwvc6Ap8q19q2OvLKZVdRm8q5mUrss8uX6fgzf9Tu3TGx8F5FNd36zW2ly4dikeZ3iYdbaKkSCm/HWPFElUlglguIJHc+9XIFJqdryTy37NDqeUWTCJEKOHl3eeDgDZITg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rVh3Z-0000cz-Rd; Fri, 02 Feb 2024 01:05:21 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rVh3W-003xQ5-2P; Fri, 02 Feb 2024 01:05:18 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rVh3V-00AFlM-1h;
	Fri, 02 Feb 2024 01:05:18 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH v2 0/4] usb: gadget: 9pfs transport
Date: Fri, 02 Feb 2024 01:05:09 +0100
Message-Id: <20240116-ml-topic-u9p-v2-0-b46cbf592962@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALUxvGUC/3WNyw6DIBBFf6Vh3amAj2pX/Y/GBeKokygQUGNj/
 Pei+y7Pzbk5OwvoCQN73XbmcaVA1kSQ9xvTgzI9ArWRmeQy40IUMI0wW0calspBWeXymeUpx0a
 weGlUQGi8Mno4T9M4jcllJ9E+Beexo+3qferIA4XZ+u+VX8W5/imtAjiottQpL7pKZfh2aPpl9
 tbQ9miR1cdx/AAoAvyKzgAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4125;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=IdiYYWpzmr9RPusGSBqszbMgZq+ap0BptPduyKLTtUQ=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBlvDG3xC0tz0b2twuAdUyIaYaJ4coWj3Icx3NeB
 ifEniisW+2JAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZbwxtwAKCRC/aVhE+XH0
 q/VwEAClVZxlYo9pt5R9IA48qsaUIdVtnj9CEnWtFWRUZPbZvJWnrdkHIB315nssDgIJtxBaACf
 IodfZ0EyaqO4CTxGmw92QO+h9awNG3YztU3BCQMeUEn0KGaejkDgApCZt/pjlIQMkspKyxw01D6
 FHCPEvvw5y840MEN0Vxe4OLfwTUCNroyRHf8kXoeTjY7Vu+KQ/ZOU4a8tWVG5HBEg74iGQ/l/3B
 V7irmYXy1ji6T9y+o9eyN8Q8uYEU6b1SBVEkNVopW3qJ119xVKqj29t+EENLL9Fktt0607xYLip
 3iCwXi7CRM7xawRMaKaXq1nxW2fH57cL6XxXnlDTKDf3vy2GShwKFenCSKttmaWLEwMZTlJdrzR
 8HrHBvAIBWAVhH4ijtkTYPeTui4AIHT8G3X/f2WFSf2ORj/XaP7/3hYvLto23Z5SSkydA9DRYNB
 oDfKemkAfpocnon4LUML3rSgtUtcR1vqtVKXObidbloxFZdnSijb41ygpgVg/zo35pdlzucFnqG
 gJcQGHfayZ1l/6u66p+gkauKYB+EmPZLdKRHoN5SRA/TT+2VtFdM5AIgveXCjGmXWIvmdcuIo8m
 2z+x4YbEGlJKRQ0fD9lFukcFSEjrpQq28bQOLNibrmKXn78DLUcGKsdt73vMAQsVDWoob3CgjQa
 f995mmHE7u1FQKg==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series is adding support to mount usb hostside exported 9pfs
filesystems via the usb gadget interface. It also includes a simple tool
(p9_fwd.py) to translate an tcp 9pfs transport and reuse it via the usb
interface.

    +--------------------------+    |    +--------------------------+
    |  9PFS mounting client    |    |    |  9PFS exporting server   |
 SW |                          |    |    |                          |
    |   (this:trans_usbg)      |    |    |(e.g. diod or nfs-ganesha)|
    +-------------^------------+    |    +-------------^------------+
                  |                 |                  |
                  |                 |           +------v------+
                  |                 |           |  p9_fwd.py  |
                  |                 |           +------^------+
                  |                 |                  |
------------------|------------------------------------|-------------
                  |                 |                  |
    +-------------v------------+    |    +-------------v------------+
    |                          |    |    |                          |
 HW |   USB Device Controller  <--------->   USB Host Controller    |
    |                          |    |    |                          |
    +--------------------------+    |    +--------------------------+

The USB host exports a filesystem, while the gadget on the USB device
side makes it mountable.

Diod (9pfs server) and the forwarder are on the development host, where
the root filesystem is actually stored. The gadget is initialized during
boot (or later) on the embedded board. Then the forwarder will find it
on the USB bus and start forwarding requests.

In this case the 9p requests come from the device and are handled by the
host. The reason is that USB device ports are normally not available on
PCs, so a connection in the other direction would not work.

One use-case is to use it as an alternative to NFS root booting during
the development of embedded Linux devices.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Changes in v2:
- improved the commit messages
- introduced an patch to move the header u_f.h to include/linux/usb to compile usb gadget functions treewide
- moved usbg gadget function to net/9p/
- adderessed several comments in function driver, like the cleanup path and kbuild errors
- improved the documentation in Documentation/filesystems/9p.rst
- Link to v1: https://lore.kernel.org/r/20240116-ml-topic-u9p-v1-0-ad8c306f9a4e@pengutronix.de

---
Michael Grzeschik (4):
      usb: gadget: function: move u_f.h to include/linux/usb/
      net/9p/usbg: Add new usb gadget function transport
      usb: gadget: legacy: add 9pfs multi gadget
      tools: usb: p9_fwd: add usb gadget packet forwarder script

 Documentation/filesystems/9p.rst                |  47 ++
 drivers/usb/gadget/configfs.c                   |   2 +-
 drivers/usb/gadget/function/f_fs.c              |   2 +-
 drivers/usb/gadget/function/f_hid.c             |   2 +-
 drivers/usb/gadget/function/f_loopback.c        |   2 +-
 drivers/usb/gadget/function/f_midi.c            |   2 +-
 drivers/usb/gadget/function/f_midi2.c           |   2 +-
 drivers/usb/gadget/function/f_sourcesink.c      |   2 +-
 drivers/usb/gadget/legacy/9pfs.c                | 268 ++++++++
 drivers/usb/gadget/legacy/Kconfig               |  16 +
 drivers/usb/gadget/legacy/Makefile              |   2 +
 drivers/usb/gadget/u_f.c                        |   2 +-
 {drivers/usb/gadget => include/linux/usb}/u_f.h |   0
 net/9p/Kconfig                                  |   6 +
 net/9p/Makefile                                 |   4 +
 net/9p/trans_usbg.c                             | 871 ++++++++++++++++++++++++
 tools/usb/p9_fwd.py                             | 194 ++++++
 17 files changed, 1416 insertions(+), 8 deletions(-)
---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20240116-ml-topic-u9p-895274530eb1

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


