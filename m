Return-Path: <linux-kernel+bounces-81544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4EB867755
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628811F24DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DE31292EC;
	Mon, 26 Feb 2024 13:56:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2303E1292E5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955781; cv=none; b=XYWA4bRub9mwW9X6uFgs/BoOz8gq6UgkGUKS5rL46fMh9mmggyiAPKM1/DINlnwr0+V9qwD9bfFbcrnj7gyJGIrnDSmyD8cF8qUh2kjD/Q3r3uTR82g6SVPxxr/i7MLX0DrI+5LzwAnoVOFZ7HlSvQPrhJvyLy1l+huCdsoGux0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955781; c=relaxed/simple;
	bh=XIkSHf9MuD6TQyL63b+wRC/40nq8CMEr5zZm2/qaYHA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D9Kyo6JyDui/DhRLlaD8LXiNtHf9CHnA42MTeXEUoB4y1CYhLv45oP/++M1wrZ342oSZhzJ/4ePHufDZDE2IBx5DjaV89/57bNKsKVht5AgEUWeP5gtIao5n8T3ER9ErB+ChhFgHy7vIFI70jwYCptycKsDBLCUJCLHLNPiSSlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rebSh-00047B-FK; Mon, 26 Feb 2024 14:56:07 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rebSg-0030Qd-Bf; Mon, 26 Feb 2024 14:56:06 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rebSg-009FzF-0y;
	Mon, 26 Feb 2024 14:56:06 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH v3 0/3] usb: gadget: 9pfs transport
Date: Mon, 26 Feb 2024 14:56:03 +0100
Message-Id: <20240116-ml-topic-u9p-v3-0-c62a36eccda1@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHOY3GUC/32NQQ6DIBREr2JYlwqIVrrqPZouAL9KomBAjY3x7
 gW3Tbt8k5k3OwrgDQR0z3bkYTXBOBuhuGRI99J2gE0TGTHCOKG0wuOAZzcZjRcx4VqU7MbLgoC
 iKE6UDICVl1b3aTQO45Cf7Ty2U2Hy0Jrt/Hu+IvcmzM6/z/uVpvTH00oxwbKpdUGqVkgOjwlst
 8zeWbNdG0DJtrJ/BhYNildataVgomJfhuM4Pg4hBI4QAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4095;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=XIkSHf9MuD6TQyL63b+wRC/40nq8CMEr5zZm2/qaYHA=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBl3Jh0xW1GHNjv9zrehCmAqI3J3gtUlO/kNkvGa
 8MMworIHiSJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZdyYdAAKCRC/aVhE+XH0
 q39DD/0UD8bDJxrAVL8hAIgxDzidf9NPpn7eQr96MiptN/HDVLo+7zJbK0BqGG7Vej6GmU1jrHp
 Ssz5SC+iJrIGq4Ol51hgUD5boGJvbR+x7Dqtvlvqth11BzpvZKhtu8tSnyMFD+LPNudMedAEo0J
 hPC7P+7oFWi/DfpbJeA32Q6QhL8qj6rKLJqRHuIsEMT4K1g6Yf+gicpWVtt7zVDC/RU7Pi+9VWQ
 XPERD6DnBvkWTYK1Sx9a/7Zq90/9DEXRwTSZeY23ULHpAOEZF5C5zEyh2cbFsbuZgJhpQ2FmMWQ
 v+ho5ZfDnvKfsHuw983iB62bhPwEAkTgX6JX9wPk25UmgYSbw4I2889C0tow5USY9QK2vvIVNj7
 OItyI4QzUCRCiacYNYECf7RqIzVANjUudDsocY4kuyDLfmyYRbYEj/3TdBh35nVqkqAtpMmlMsj
 UqqL5mr40RFNCGbbsZLSy9u2u6+jUPQiaiuLYaBHjd6icf4423wOGSifTNkTBqbFMSwNXucK14t
 EJaQMe2paLYqoCVCidHnwSouvpUIce6r+ZE/Gieck+EyHsTHF4B2YnzRDb9d/T3/F6cEAYDUR29
 tATUBfeIK8OHf97OXw/kFCIKrw5aG0SS/iyzp+NDKr1PcltS1psELyI/m1FRvVrmsdvz0j0Bk2A
 0n1rP4tsko6TA8g==
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
Changes in v3:
- dropped patch "usb: gadget: legacy: add 9pfs multi gadget" as discussed with gregkh
- Link to v2: https://lore.kernel.org/r/20240116-ml-topic-u9p-v2-0-b46cbf592962@pengutronix.de

Changes in v2:
- improved the commit messages
- introduced an patch to move the header u_f.h to include/linux/usb to compile usb gadget functions treewide
- moved usbg gadget function to net/9p/
- adderessed several comments in function driver, like the cleanup path and kbuild errors
- improved the documentation in Documentation/filesystems/9p.rst
- Link to v1: https://lore.kernel.org/r/20240116-ml-topic-u9p-v1-0-ad8c306f9a4e@pengutronix.de

---
Michael Grzeschik (3):
      usb: gadget: function: move u_f.h to include/linux/usb/
      net/9p/usbg: Add new usb gadget function transport
      tools: usb: p9_fwd: add usb gadget packet forwarder script

 Documentation/filesystems/9p.rst                |  47 ++
 drivers/usb/gadget/configfs.c                   |   2 +-
 drivers/usb/gadget/function/f_fs.c              |   2 +-
 drivers/usb/gadget/function/f_hid.c             |   2 +-
 drivers/usb/gadget/function/f_loopback.c        |   2 +-
 drivers/usb/gadget/function/f_midi.c            |   2 +-
 drivers/usb/gadget/function/f_midi2.c           |   2 +-
 drivers/usb/gadget/function/f_sourcesink.c      |   2 +-
 drivers/usb/gadget/u_f.c                        |   2 +-
 {drivers/usb/gadget => include/linux/usb}/u_f.h |   0
 net/9p/Kconfig                                  |   6 +
 net/9p/Makefile                                 |   4 +
 net/9p/trans_usbg.c                             | 871 ++++++++++++++++++++++++
 tools/usb/p9_fwd.py                             | 194 ++++++
 14 files changed, 1130 insertions(+), 8 deletions(-)
---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20240116-ml-topic-u9p-895274530eb1

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


