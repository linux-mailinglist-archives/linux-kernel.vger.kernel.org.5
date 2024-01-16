Return-Path: <linux-kernel+bounces-28384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8925982FDD2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29991F271EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A225867C65;
	Tue, 16 Jan 2024 23:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHlGjOc9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5567C5E;
	Tue, 16 Jan 2024 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705448796; cv=none; b=DJNkqaLub+tIv4MAIBP56HDY7TP0Tj2ApbCf0SXCuzt47xW0KJdmrwpu0Y+5YBCPRqdmmZOah4I7h0DIPXDhP55/PIWSkqgL52OXQ4h91nZ6dPnGdvdKlbUbEq78A8TKpckvrU2/s5IGsgeHy0cItspw1+6OGOKswTFFsjKWoNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705448796; c=relaxed/simple;
	bh=/V0jWuMqMaJCEhmN2SQuPUJxonZx+hc3zr88NbwgJXM=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=sl4Wr2/TeO1RkQKAYjGKDnpYXGjvMJ23iKmuIbZVtL0qCd3kcKE6x+HW8TRD0gPFtKK5FDjM4b+ouK68cuAJzzS7G63cNEAxIRt4zl80DATKGv0Ag+LY3T6GJbhdnl0RakP6Rq1i41LprQY9wnoOw/3LUNMm04vhi3PMtokdrf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHlGjOc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D48C433F1;
	Tue, 16 Jan 2024 23:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705448796;
	bh=/V0jWuMqMaJCEhmN2SQuPUJxonZx+hc3zr88NbwgJXM=;
	h=From:Date:Subject:To:Cc:From;
	b=gHlGjOc99xrUZ3Ysgaj72pe53+ybwq0pFf9qzo3Nl/UZT4V2Y5UGCoQK1uruEMvg8
	 5ol/LyNUA9qQixPydGIxG/TalColXhuLmg1tww2uJKpUI3wcCv3PGx/QyX2BNk4FBm
	 sipuynHgPYyuJ7kol5o8x/zji9mVJlk1Mh5MjVK4aMi/+Z5vKoUQStiPTKV6OKqO7b
	 Jh8tAbuLuGShUCPe17mveW/u58k+Po05Hte94cdeJyEBNA8Ui9cc5LyMIXpz+t/92o
	 0G4A7j5pgwL3q7rQrybuXg0afYH8A7QZL7Fn4UXPh6yPTOVxkkimnIS1uUpGsF70q4
	 NWcb0Pi5RJCWg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2046b2cd2d3so7613468fac.0;
        Tue, 16 Jan 2024 15:46:36 -0800 (PST)
X-Gm-Message-State: AOJu0Yw8CWEfJ1AJIXpkL3CHaX8yH/zHr9xoMm7SyYk9yy2cwwo2hmok
	hnJ9OCBjclfPjtNlzh4/emHiXKg5un7Ky3uz2JE=
X-Google-Smtp-Source: AGHT+IGPim5jCNuXS6hiBuH5EiyielqrpLdF5gnMR2Xu4v9FUQnJhX1zzaEiYyL68SEcljcRzq120qrc+uA9QQF3RTE=
X-Received: by 2002:a05:6870:2cc:b0:1fb:75c:3fdf with SMTP id
 r12-20020a05687002cc00b001fb075c3fdfmr12995755oaf.63.1705448795453; Tue, 16
 Jan 2024 15:46:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 17 Jan 2024 08:45:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNARUOCnNNH3s4XigT7-nDMHv0gWUQnk9H7ZVov0GrvAfRQ@mail.gmail.com>
Message-ID: <CAK7LNARUOCnNNH3s4XigT7-nDMHv0gWUQnk9H7ZVov0GrvAfRQ@mail.gmail.com>
Subject: [GIT PULL] Kbuild updates for v6.8-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Linus,


Please pull Kbuild updates for v6.8.
Thanks.




The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab=
:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v6.8

for you to fetch changes up to 6185d32170b683abadddf1e68be998e24f3cc5de:

  kbuild: deb-pkg: use debian/<package> for tmpdir (2024-01-10 20:39:47 +09=
00)

----------------------------------------------------------------
Kbuild updates for v6.8

 - Make Kconfig parse the input .config more precisely

 - Support W=3Dc and W=3De options for Kconfig

 - Set Kconfig int/hex symbols to zero if the 'default' property is
   missing

 - Add .editorconfig

 - Add scripts/git.orderFile

 - Add a script to detect backward-incompatible changes in UAPI headers

 - Resolve the symlink passed to O=3D option properly

 - Use the user-supplied mtime for all files in the builtin initramfs,
   which provides better reproducible builds

 - Fix the direct execution of debian/rules for Debian package builds

 - Use build ID instead of the .gnu_debuglink section for the Debian dbg
   package

----------------------------------------------------------------
Dmitrii Bundin (1):
      kbuild: deb-pkg: apply short -R and -j options

Dmitry Safonov (1):
      gen_init_cpio: Apply mtime supplied by user to all file types

John Moon (2):
      check-uapi: Introduce check-uapi.sh
      docs: dev-tools: Add UAPI checker documentation

Leonardo Bras (1):
      scripts: Introduce a default git.orderFile

Markus Schneider-Pargmann (1):
      kconfig: Use KCONFIG_CONFIG instead of .config

Masahiro Yamada (43):
      genksyms: remove the remnant of the -s option
      genksyms: use getopt_long() unconditionally
      kconfig: do not clear SYMBOL_DEF_USER when the value is out of range
      kconfig: remove error check for xrealloc()
      kconfig: require a space after '#' for valid input
      kconfig: remove unused code for S_DEF_AUTO in conf_read_simple()
      kconfig: deduplicate code in conf_read_simple()
      kconfig: introduce getline_stripped() helper
      kconfig: require an exact match for "is not set" to disable CONFIG op=
tion
      kconfig: massage the loop in conf_read_simple()
      kbuild: remove the last use of old cmd_src_tar rule in packaging
      kbuild: support W=3Dc and W=3De shorthands for Kconfig
      scripts: clean up IA-64 code
      kconfig: remove unneeded symbol_empty variable
      kconfig: default to zero if int/hex symbol lacks default property
      init: move THIS_MODULE from <linux/export.h> to <linux/init.h>
      kbuild: deb-pkg: remove the fakeroot builds support
      kbuild: determine base DTB by suffix
      modpost: move __attribute__((format(printf, 2, 3))) to modpost.h
      modpost: inform compilers that fatal() never returns
      modpost: remove unneeded initializer in section_rel()
      modpost: remove unreachable code after fatal()
      sparc: vdso: clean up build artifacts in arch/sparc/vdso/
      sparc: vdso: simplify obj-y addition
      sparc: vdso: use $(addprefix ) instead of $(foreach )
      kconfig: factor out common code shared by mconf and nconf
      kconfig: squash menu_has_help() and menu_get_help()
      kconfig: add include guard to lkc_proto.h
      kconfig: remove unreachable printf()
      kconfig: remove redundant NULL pointer check before free()
      kbuild: resolve symlinks for O=3D properly
      kbuild: deb-pkg: split debian/copyright from the mkdebian script
      kbuild: deb-pkg: hard-code Build-Depends
      kbuild: deb-pkg: factor out common Make options in debian/rules
      kbuild: deb-pkg: squash scripts/package/deb-build-option to debian/ru=
les
      kbuild: deb-pkg: set DEB_* variables if debian/rules is directly exec=
uted
      kbuild: deb-pkg: allow to run debian/rules from output directory
      kbuild: deb-pkg: remove unneeded '-f $srctree/Makefile' in debian/rul=
es
      kbuild: deb-pkg: use more debhelper commands in builddeb
      kbuild: deb-pkg: use build ID instead of debug link for dbg package
      kbuild: deb-pkg: do not search for 'scripts' directory under arch/
      kbuild: deb-pkg: move 'make headers' to build-arch
      kbuild: deb-pkg: use debian/<package> for tmpdir

Petr Vorel (2):
      kbuild: buildtar: Remove unused $dirs
      kbuild: buildtar: always make modules_install

Sergey Senozhatsky (1):
      kconfig: WERROR unmet symbol dependency

=C3=8D=C3=B1igo Huguet (1):
      Add .editorconfig file for basic formatting

 .editorconfig                          |  32 +++
 .gitignore                             |   1 +
 Documentation/dev-tools/checkuapi.rst  | 477
+++++++++++++++++++++++++++++++++++++++
 Documentation/dev-tools/index.rst      |   1 +
 Documentation/process/4.Coding.rst     |   4 +
 Documentation/process/coding-style.rst |   4 +
 Makefile                               |  23 +-
 arch/sparc/vdso/Makefile               |  18 +-
 include/linux/export.h                 |  18 --
 include/linux/init.h                   |   7 +
 scripts/Makefile.extrawarn             |   9 -
 scripts/Makefile.lib                   |   4 +-
 scripts/Makefile.package               |  28 +--
 scripts/check-uapi.sh                  | 573
+++++++++++++++++++++++++++++++++++++++++++++++
 scripts/checkstack.pl                  |   3 -
 scripts/gdb/linux/tasks.py             |  15 +-
 scripts/genksyms/genksyms.c            |  22 +-
 scripts/git.orderFile                  |  42 ++++
 scripts/head-object-list.txt           |   1 -
 scripts/kconfig/Makefile               |  14 +-
 scripts/kconfig/conf.c                 |   6 +
 scripts/kconfig/confdata.c             | 169 +++++++-------
 scripts/kconfig/expr.c                 |   1 -
 scripts/kconfig/lkc.h                  |   2 -
 scripts/kconfig/lkc_proto.h            |   7 +
 scripts/kconfig/mconf.c                |  56 +----
 scripts/kconfig/menu.c                 |  17 +-
 scripts/kconfig/mnconf-common.c        |  53 +++++
 scripts/kconfig/mnconf-common.h        |  18 ++
 scripts/kconfig/nconf.c                |  55 +----
 scripts/kconfig/symbol.c               |  37 +--
 scripts/kconfig/util.c                 |   3 +-
 scripts/mod/modpost.c                  |  17 +-
 scripts/mod/modpost.h                  |   8 +-
 scripts/package/builddeb               | 104 +++------
 scripts/package/buildtar               |   8 +-
 scripts/package/deb-build-option       |  14 --
 scripts/package/debian/copyright       |  16 ++
 scripts/package/debian/rules           |  35 ++-
 scripts/package/install-extmod-build   |   2 +-
 scripts/package/kernel.spec            |   6 -
 scripts/package/mkdebian               |  28 +--
 scripts/package/snapcraft.template     |   2 +-
 scripts/recordmcount.c                 |   1 -
 scripts/recordmcount.pl                |   7 -
 scripts/xz_wrap.sh                     |   1 -
 usr/gen_init_cpio.c                    |  33 ++-
 47 files changed, 1490 insertions(+), 512 deletions(-)
 create mode 100644 .editorconfig
 create mode 100644 Documentation/dev-tools/checkuapi.rst
 create mode 100755 scripts/check-uapi.sh
 create mode 100644 scripts/git.orderFile
 create mode 100644 scripts/kconfig/mnconf-common.c
 create mode 100644 scripts/kconfig/mnconf-common.h
 delete mode 100755 scripts/package/deb-build-option
 create mode 100644 scripts/package/debian/copyright



Best Regards
Masahiro Yamada

