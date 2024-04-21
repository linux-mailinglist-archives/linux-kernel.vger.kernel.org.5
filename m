Return-Path: <linux-kernel+bounces-152485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5C68ABF21
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 14:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0831F20F4D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 12:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6902812E47;
	Sun, 21 Apr 2024 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqSUuQpK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EA610A0C;
	Sun, 21 Apr 2024 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713701311; cv=none; b=Fwa1uFb1AYHWA/x7aoa52+h609zQqVQPRLl6Ro9lQkeGFhWty66VONCgzuixraeuYxfo1mFiEna6Q70dJBR98iebyBzkDVwuefWuJC9BxY505waN9ihCxHM3mJIbKCrEJLwIXEBb1FdqAHgo5OA7o37nHwRIoWttn2/x5uMGUPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713701311; c=relaxed/simple;
	bh=nsnyM7iDeXKSHIowtiCZl5ToaOYTW3mkGiIfj5zbErE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A3ylPY4SqjlIEXZBnUkiIOVSCEeHet8aYpPUtURPe5qJzodjPhBh7QXzxfgMj7zyTLWeOhyjUcsBxxOZ2tfybMMG1Lr17SXsPUQShxbOgVYfhoD45fNgMP4dv54nQMRdGxR7eXzoxKzR9vcg9E9bVqp68yrdgTcD6VtXN04VqVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqSUuQpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C72C113CE;
	Sun, 21 Apr 2024 12:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713701310;
	bh=nsnyM7iDeXKSHIowtiCZl5ToaOYTW3mkGiIfj5zbErE=;
	h=From:To:Cc:Subject:Date:From;
	b=UqSUuQpKfeiDZSLfCpS/tEZcpoS5vngSA1EdPIuAIVT++I3jWUa5EyRwpqmNrXvsV
	 4HTgiPxl5Q53qod098itWjb9YCnN8pM/N4EMb7Si1RqMrp34AUm3n7CgZsuN3UvOFj
	 OlSkJRyb13O7KBOTSA3TdyCSivjFlmuXqq7Nx+luEVP7QAl5Ze86acZjHKCIsVJbNx
	 +A4BvHaDqOSe+80OJosM7Phr1WlacgtbvCdMlySEHMIG9xQPRVWsHlFMZsM7gMKqOC
	 QyAe4mfH14g+Iw9qqM7IyzY/IiYXVR+rgLoF+Fb/cN8qKDEM+4qlRFAJ2xBSBJ0jeZ
	 HsJwI7B1nJPUw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-doc@vger.kernel.org
Subject: [PATCH 0/2] kconfig: remove unneeded 'optional' property support
Date: Sun, 21 Apr 2024 21:08:22 +0900
Message-Id: <20240421120824.2713923-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Kconfig support 'optional' for choice blocks, but it is unneeded.

Currently, it is only used in arch/sh/Kconfig.

Covert it (add a place-holder option, CONFIG_CMDLINE_NO_MODIFY) and
clean up the Kconfig code.

(Ack from the sh maintainer is appreciated)



Masahiro Yamada (2):
  sh: convert the last use of 'optional' property in Kconfig
  kconfig: remove 'optional' property support

 Documentation/kbuild/kconfig-language.rst     |  3 ---
 arch/sh/Kconfig                               |  6 ++++-
 arch/sh/configs/apsh4a3a_defconfig            |  1 +
 arch/sh/configs/apsh4ad0a_defconfig           |  1 +
 arch/sh/configs/edosk7705_defconfig           |  1 +
 arch/sh/configs/hp6xx_defconfig               |  1 +
 arch/sh/configs/landisk_defconfig             |  1 +
 arch/sh/configs/magicpanelr2_defconfig        |  1 +
 arch/sh/configs/rsk7264_defconfig             |  1 +
 arch/sh/configs/rsk7269_defconfig             |  1 +
 arch/sh/configs/se7619_defconfig              |  1 +
 arch/sh/configs/se7705_defconfig              |  1 +
 arch/sh/configs/se7722_defconfig              |  1 +
 arch/sh/configs/se7750_defconfig              |  1 +
 arch/sh/configs/secureedge5410_defconfig      |  1 +
 arch/sh/configs/sh7710voipgw_defconfig        |  1 +
 arch/sh/configs/sh7724_generic_defconfig      |  1 +
 arch/sh/configs/sh7770_generic_defconfig      |  1 +
 arch/sh/configs/sh7785lcr_32bit_defconfig     |  1 +
 arch/sh/configs/sh7785lcr_defconfig           |  1 +
 arch/sh/configs/urquell_defconfig             |  1 +
 scripts/kconfig/confdata.c                    |  5 +---
 scripts/kconfig/expr.h                        |  1 -
 scripts/kconfig/gconf.c                       |  2 --
 scripts/kconfig/lexer.l                       |  1 -
 scripts/kconfig/lkc.h                         |  5 ----
 scripts/kconfig/menu.c                        | 12 +++------
 scripts/kconfig/parser.y                      |  9 -------
 scripts/kconfig/tests/choice/Kconfig          | 26 -------------------
 .../tests/choice/allmod_expected_config       |  4 ---
 .../tests/choice/allyes_expected_config       |  4 ---
 .../tests/choice/oldask0_expected_stdout      |  2 --
 scripts/kconfig/tests/choice/oldask1_config   |  1 -
 .../tests/choice/oldask1_expected_stdout      |  6 -----
 34 files changed, 29 insertions(+), 77 deletions(-)

-- 
2.40.1


