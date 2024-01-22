Return-Path: <linux-kernel+bounces-32808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF0A836058
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DA61F23C30
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA223A8CC;
	Mon, 22 Jan 2024 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuV6cvDj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A653A8C0;
	Mon, 22 Jan 2024 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921448; cv=none; b=m1HWafvl2kke2E1HImwzgQvB08zkf7ep46yz5EgkR33b4PgO4rpk2mIBPPVEuAji1VlA++gjhiQHxptMY6v8lo6cscURE++keKWfnbH8G0+YGGR98l/KpDZ3gTEX3i2CLySIxNAzKrkdl9Lj6GIZyzqlLDrGw5b9n9TFYtYZgzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921448; c=relaxed/simple;
	bh=6WGGhf/BTgLnnKlxdbNPCXyuwYCekxPpegnJq4vX000=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jkGE9vmFaBeFO9sQxtrB7c8K2JxA3AJIGpnc3HfSjbmA7KF6ih3ZNmFQT6NTjZ94ExnQtSexu6s1GzMJuKiPVu9sKF9mkkm/8exDPVYlF281KD06eSrdXXcNh/JCJaI66UT0EOYN3j2ETaNE0XAQyoFoX+VbqPcEeVxMnPoF5SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuV6cvDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC00C433F1;
	Mon, 22 Jan 2024 11:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921447;
	bh=6WGGhf/BTgLnnKlxdbNPCXyuwYCekxPpegnJq4vX000=;
	h=From:To:Cc:Subject:Date:From;
	b=WuV6cvDj37O15oSjTHGuaol6bCLP78ejj/Qqj1SW7SBKckvvka5v+47PF1FXP7ypE
	 z8bPKsEWzCACA0JC2QjeWs5bx4hHkyPxxpf2/rOeSXpfpDwA4EToI+diq8ckf2NpRQ
	 gT3IDlQYVaCkI8ue4DJEhWrjdt4UClq0ZCqZv34eAaDCNgBrnhDszRFT/ajus6C8Pq
	 IXAl0s6zN0bR928g3H2mCH46U7WbujMk9bSlgl97yrRcnon3yzPubDbl8y8xv7/78B
	 DzHXQS7rE/VOJKvdmiuPb+5XWlbzGPmKIB/MRaftvwXs3cqCHcSMTXn4tikwKLJlvP
	 LUNtsz4+7e+QA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Helge Deller <deller@gmx.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	Martin Hostettler <textshell@uchuujin.de>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 00/47] tty: vt: cleanup and documentation
Date: Mon, 22 Jan 2024 12:03:14 +0100
Message-ID: <20240122110401.7289-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Push the console code (vt.c, vt.h, console.h, ...) into a bit more
maintainable state. Especially all around consw structure and document
it.

CSI parser is also a bit cleaned up. More to follow some time in the
next round.

[v2] See respective patches for changes. The major changes:
 * vesa.h introduced
 * parameters of csi*() simplified

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: Helge Deller <deller@gmx.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: Martin Hostettler <textshell@uchuujin.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>

Jiri Slaby (SUSE) (47):

  vgacon: inline vc_scrolldelta_helper() into vgacon_scrolldelta()
  fbcon: make display_desc a static array in fbcon_startup()
  tty: vt: fix 20 vs 0x20 typo in EScsiignore
  tty: vt: expect valid vc when in tty ops
  tty: vt: pass proper pointers from tioclinux()
  tty: vt: push console lock from tioclinux() down to 2 functions
  tty: vt: pass vc_resize_user as a parameter
  tty: vt: make vc_is_sel()'s vc const
  tty: vt: define an enum for CSI+m codes
  tty: vt: use case ranges for CSI+m fg/bg colors
  tty: vt: define an enum for CSI+J codes
  tty: vt: reflow csi_J()
  use clamp() for counts in csi_?() handlers
  don't pass vc->vc_par[0] to csi_?() handlers
  tty: vt: define an enum for CSI+K codes
  tty: vt: reflow csi_K()
  tty: vt: define an enum for ascii characters
  tty: vt: remove extern from functions in selection.h
  tty: vt: make consw::con_debug_*() return void
  tty: vt: make init parameter of consw::con_init() a bool
  tty: vt: sanitize arguments of consw::con_clear()
  tty: vt: remove checks for count in consw::con_clear() implementations
  tty: vt: add con_putc() helper
  tty: vt: eliminate unneeded consw::con_putc() implementations
  tty: vt: sanitize consw::con_putc() parameters
  tty: vt: sanitize consw::con_putcs() parameters
  consoles: use if instead of switch-case in consw::con_cursor()
  fbdev/core: simplify cursor_state setting in fbcon_ops::cursor()
  tty: vt: remove CM_* constants
  tty: vt: make consw::con_switch() return a bool
  tty: vt: stop using -1 for blank mode in consw::con_blank()
  tty: vt: define a common enum for VESA blanking constants
  tty: vt: use VESA blanking constants
  tty: vt: use enum constants for VESA blanking modes
  tty: vt: make types around consw::con_blank() bool
  tty: vt: make font of consw::con_font_set() const
  tty: vt: make consw::con_font_default()'s name const
  tty: vt: change consw::con_set_origin() return type
  fbcon: remove consw::con_screen_pos()
  tty: vt: remove consw::con_screen_pos()
  tty: vt: make types of screenpos() more consistent
  fbcon: remove fbcon_getxy()
  tty: vt: remove consw::con_getxy()
  tty: vt: remove unused consw::con_flush_scrollback()
  tty: vt: document the rest of struct consw
  tty: vt: fix up kernel-doc
  Documentation: add console.rst

 Documentation/driver-api/tty/console.rst |  45 ++
 Documentation/driver-api/tty/index.rst   |   1 +
 drivers/tty/vt/selection.c               |  43 +-
 drivers/tty/vt/vt.c                      | 645 +++++++++++------------
 drivers/tty/vt/vt_ioctl.c                |   6 +-
 drivers/video/console/dummycon.c         |  38 +-
 drivers/video/console/mdacon.c           |  43 +-
 drivers/video/console/newport_con.c      |  69 +--
 drivers/video/console/sticon.c           |  79 ++-
 drivers/video/console/vgacon.c           | 152 +++---
 drivers/video/fbdev/core/bitblit.c       |  13 +-
 drivers/video/fbdev/core/fbcon.c         | 123 ++---
 drivers/video/fbdev/core/fbcon.h         |   4 +-
 drivers/video/fbdev/core/fbcon_ccw.c     |  13 +-
 drivers/video/fbdev/core/fbcon_cw.c      |  13 +-
 drivers/video/fbdev/core/fbcon_ud.c      |  13 +-
 drivers/video/fbdev/core/tileblit.c      |   4 +-
 include/linux/console.h                  | 124 +++--
 include/linux/console_struct.h           |   1 -
 include/linux/selection.h                |  56 +-
 include/linux/vt_kern.h                  |  12 +-
 include/uapi/linux/fb.h                  |   8 +-
 include/uapi/linux/vesa.h                |  18 +
 23 files changed, 755 insertions(+), 768 deletions(-)
 create mode 100644 Documentation/driver-api/tty/console.rst
 create mode 100644 include/uapi/linux/vesa.h

-- 
2.43.0


