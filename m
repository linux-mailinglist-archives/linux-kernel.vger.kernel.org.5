Return-Path: <linux-kernel+bounces-29787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5321831380
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7FB28469D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0E61170E;
	Thu, 18 Jan 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQRS0jA0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E791125A1;
	Thu, 18 Jan 2024 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564683; cv=none; b=L36zVdeENew+jXY/lhMbeqskpFBWEXT+w/Jae5KgvWms1tCU5MKcIOMfDDsDpF/a4qpUXdeHs43ldFEjpIxixmMQMUiYzrzqLFC36Zp6VAYt62PCWxhXFRc4AWeWMYaAFVWG0HgWMp12fTD85ToE8XkrSvE6+hP3hj5W8BqaCOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564683; c=relaxed/simple;
	bh=oQ9cSYYWIYoTtIDUE2vPJkWnOqd7aXp34/3pmH6YSnI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=PK7IoNqdWVtl/v1d3h1tAL4PbU7r4Q014lv4YOyZoBZ02i5Z8gzZMKC3Gsc0OhVupiKPnU1F9HAf8E8OYy99FzWGEOJl1PJ5r8tCErnEai+8z0YxR/nOtctRmX36VydpV0dwjrMAcQ4MVrmSchVy7ioguOxL1vIwF8ntZAbpAlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQRS0jA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7386EC433F1;
	Thu, 18 Jan 2024 07:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564682;
	bh=oQ9cSYYWIYoTtIDUE2vPJkWnOqd7aXp34/3pmH6YSnI=;
	h=From:To:Cc:Subject:Date:From;
	b=lQRS0jA0ah6MATrSuq6IuypGBN12aslrn/fMEm6OEU97UfGpNmBwpt/sMmPXwmRES
	 IvbFnyoEudEARF/+ZxxZMzOFHZRlFy5hYOpuvqWyysYe0cz/AqxUQ+v8PC1081mep8
	 2uNYjZKyZddi8+jlju13jRu4Qwn57I97FxgsJymOzcfdAYNhX+fUlzq1NOziZOlFtZ
	 bnZlWE5mwKwgSY9PBcBtPzmzsCvfrWDrmxCSLFyl9DCRV/5dhljpLXg0AozUgHaWge
	 nitA/6KF2zHMkRA6Em3DZJLftCaZyTRBnmT8xKq1pbdal/6EVhP48xxFcSm36W4Hum
	 7H/YfJqPRvwmQ==
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
	Martin Hostettler <textshell@uchuujin.de>
Subject: [PATCH 00/45] tty: vt: cleanup and documentation
Date: Thu, 18 Jan 2024 08:57:11 +0100
Message-ID: <20240118075756.10541-1-jirislaby@kernel.org>
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

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: Helge Deller <deller@gmx.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: Martin Hostettler <textshell@uchuujin.de>

Jiri Slaby (SUSE) (45):
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
  tty: vt: define an enum for CSI+K codes
  tty: vt: reflow csi_K()
  tty: vt: pass vpar as unsigned to csi_J() and csi_K()
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
  tty: vt: use VESA blanking constants
  tty: vt: use enum for VESA blanking modes
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
 drivers/tty/vt/vt.c                      | 587 +++++++++++------------
 drivers/tty/vt/vt_ioctl.c                |   6 +-
 drivers/video/console/dummycon.c         |  38 +-
 drivers/video/console/mdacon.c           |  43 +-
 drivers/video/console/newport_con.c      |  69 +--
 drivers/video/console/sticon.c           |  79 ++-
 drivers/video/console/vgacon.c           | 150 +++---
 drivers/video/fbdev/core/bitblit.c       |  13 +-
 drivers/video/fbdev/core/fbcon.c         | 123 ++---
 drivers/video/fbdev/core/fbcon.h         |   4 +-
 drivers/video/fbdev/core/fbcon_ccw.c     |  13 +-
 drivers/video/fbdev/core/fbcon_cw.c      |  13 +-
 drivers/video/fbdev/core/fbcon_ud.c      |  13 +-
 drivers/video/fbdev/core/tileblit.c      |   4 +-
 include/linux/console.h                  | 132 ++---
 include/linux/console_struct.h           |   1 -
 include/linux/selection.h                |  56 +--
 include/linux/vt_kern.h                  |  12 +-
 include/uapi/linux/fb.h                  |   5 +-
 22 files changed, 725 insertions(+), 725 deletions(-)
 create mode 100644 Documentation/driver-api/tty/console.rst

-- 
2.43.0


