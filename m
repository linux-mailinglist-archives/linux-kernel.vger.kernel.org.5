Return-Path: <linux-kernel+bounces-50059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A5D8473D1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141FA28D27B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B459D1474A0;
	Fri,  2 Feb 2024 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPvFaSbk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A091474C1;
	Fri,  2 Feb 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889511; cv=none; b=RzUNpUPOWp9nKEcUEuE3MWayQT1+cno82Y72HdKjY89SSasR5ixf5nN9RFVPz29U+H9DColAZN285Z6O4qBq6BMAXorPf8Agcxct1NARxzqf5SHxfkH561dVrIgTg7jDtKPlQy/fO1Ndq0CBeP2X93+zrh7td1odiJ0JoI3wpcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889511; c=relaxed/simple;
	bh=THdTZv21XZx2i61Uk13KVjH1FY7txkw6aueP1w2kwcI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sCnO2hrKdMGhJvLaWO3pX0w6d9AzlCp7iV3WcLamU+u3E1HDZW+HdIbQWUaiPVyN3Tnyi5jB9ABqbWyahuEkpcg9ULFcAf1SEoHYGgKmu84ODa0NnJHXpQ8ay5u6twE0IM8XQCYlwr2UrqJjJc+pHsxsmFk1Xi6o+NVPpqGR7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPvFaSbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FA8C433C7;
	Fri,  2 Feb 2024 15:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889510;
	bh=THdTZv21XZx2i61Uk13KVjH1FY7txkw6aueP1w2kwcI=;
	h=From:To:Cc:Subject:Date:From;
	b=gPvFaSbkOu1EVcR0LO3IDxDJRosfPHPMRL1ZpU5T1Whg3aHQRzcWeBA7MPq/VOnOR
	 XzoeMdtOkqJSO1A9rueHd3DGa1hSRxUjBlaPCOrJ2MHqquQAe8ksgpIVTunv6EmuXc
	 SfeqkZdTGBeGZ37BMahqX1FdLzwEDHKhImJrLFIoHr72WBZPDIkOsLa2ebwckAZL3F
	 w2JAjeY/pFewx0PEqqO970UAUfdoeymZUvOssQ3PKUDssE1oAaPlsdn+DzdpcfbW1P
	 JXvvLn5PhhHcVDoNVYnzKS5xMAaOUFL1+pUVl7xDGB7AqgS0Z1t8v9Z+jst2R9yOqY
	 0/PEgtbKDhJhg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 00/27] kconfig: refactor lexer and parser code
Date: Sat,  3 Feb 2024 00:57:58 +0900
Message-Id: <20240202155825.314567-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Random fixes, cleanups, etc.

Masahiro Yamada (27):
  kconfig: fix infinite loop when expanding a macro at the end of file
  kconfig: fix off-by-one in zconf_error()
  kconfig: remove orphan lookup_file() declaration
  kconfig: remove compat_getline()
  kconfig: remove unneeded sym_find() call in conf_parse()
  kconfig: write Kconfig files to autoconf.cmd in order
  kconfig: call env_write_dep() right after yyparse()
  kconfig: split preprocessor prototypes into preprocess.h
  kconfig: replace current_pos with separate cur_{filename,lineno}
  kconfig: remove zconf_curname() and zconf_lineno()
  kconfig: associate struct menu with file name directly
  kconfig: associate struct property with file name directly
  kconfig: replace file->name with name in zconf_nextfile()
  kconfig: do not delay the cur_filename update
  kconfig: replace remaining current_file->name with cur_filename
  kconfig: move the file and lineno in struct file to struct buffer
  kconfig: make file::name a flexible array member
  kconfig: change file_lookup() to return the file name
  kconfig: split list_head into a separate header
  kconfig: resync list.h
  kconfig: import more list macros and inline functions
  kconfig: add macros useful for hashtable
  kconfig: move ARRAY_SIZE to a header
  kconfig: move strhash() to a header
  kconfig: convert linked list of files to hash table
  kconfig: use generic macros to implement symbol hashtable
  kconfig: do not imply the type of choice value

 scripts/kconfig/array_size.h |  11 ++
 scripts/kconfig/conf.c       |  12 +-
 scripts/kconfig/confdata.c   |  91 +++----------
 scripts/kconfig/expr.h       |  24 +---
 scripts/kconfig/hashtable.h  |  48 +++++++
 scripts/kconfig/internal.h   |  12 ++
 scripts/kconfig/lexer.l      | 100 +++++++-------
 scripts/kconfig/list.h       | 254 ++++++++++++++++++++++++++---------
 scripts/kconfig/list_types.h |  17 +++
 scripts/kconfig/lkc.h        |   5 +-
 scripts/kconfig/lkc_proto.h  |  15 ---
 scripts/kconfig/mconf.c      |   1 +
 scripts/kconfig/menu.c       |  24 ++--
 scripts/kconfig/nconf.c      |   1 +
 scripts/kconfig/parser.y     |  92 +++++++------
 scripts/kconfig/preprocess.c |  23 ++--
 scripts/kconfig/preprocess.h |  19 +++
 scripts/kconfig/qconf.cc     |   2 +-
 scripts/kconfig/symbol.c     |  46 +++----
 scripts/kconfig/util.c       |  38 ++++--
 scripts/kconfig/util.h       |  15 +++
 21 files changed, 511 insertions(+), 339 deletions(-)
 create mode 100644 scripts/kconfig/array_size.h
 create mode 100644 scripts/kconfig/hashtable.h
 create mode 100644 scripts/kconfig/list_types.h
 create mode 100644 scripts/kconfig/preprocess.h
 create mode 100644 scripts/kconfig/util.h

-- 
2.40.1


