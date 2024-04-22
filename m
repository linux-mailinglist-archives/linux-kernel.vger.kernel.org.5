Return-Path: <linux-kernel+bounces-153732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322098AD273
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44001F21B45
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5E3153BDB;
	Mon, 22 Apr 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bP8QxXft"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B90E1514CA;
	Mon, 22 Apr 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804103; cv=none; b=cIFEKxZFdZWAgirqgaV747R1gCxvHr73JVzp37BQB59yOdQEHQT2DI68HbxMGPgCpJ6QlumyB3IwEbg7aETEbVfxZCrypD5PqAdFajy5fyIjZMcbFA/+9HE2b5iw7oMJDOY4Dqo/1u65RsrLrKjxDssBXtTwoQQ+osQLrfyrxWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804103; c=relaxed/simple;
	bh=l/KYJencBm4IeGc/cTZjFX/c/6NXNc/MSc7Iy1VR6nw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qMWl5HlgaWvYkK7hAJ00FIGYp1aoBJcdxOIJ622qt1zQOTOAJj2AvHbAkyFXb8Jy0X3ve1FNj659nHJWY1+OmYkUaXQQ8D4WfgX7kXKWpv0SKRA0wuhwikVkMyXuOsIrVBaPM1pEWwWdiQnr1N2st+PPfHx792Hxp5UMxLwrBZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bP8QxXft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B749C113CC;
	Mon, 22 Apr 2024 16:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713804102;
	bh=l/KYJencBm4IeGc/cTZjFX/c/6NXNc/MSc7Iy1VR6nw=;
	h=From:To:Cc:Subject:Date:From;
	b=bP8QxXftlH5gMk6g0Tpgc587k2Ylr0PCo0igPgoBJmp9iPgSWawPIAPX4foU3dUIA
	 Hde0LHU28N3JtaGpjR/r1pxu0saXHv/ioyPeVmCMlAb5fk1MojFQGadmz6kR1zYLBn
	 zQyQMtW1CjP7mDQ4uA6HnO+SalcGkHSvRQSn974Gq1Ek36NX6HoWuzgjlaMNA87LM8
	 OI4YVjCtjdG4/E6r1CQL05csEqgCkmQ9aBMTdDjqf4OWcr5k4ZesrqnHk/a5TlU/Qk
	 /pU83/t/zE1bLv3Ev0rewLs0BaV85idXXSCu863CwsRq//7pbOf2J+LGEzyYN0wCgD
	 moE6sv3feGVww==
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
Subject: [PATCH v2 0/2] kconfig: remove unneeded 'optional' property support
Date: Tue, 23 Apr 2024 01:41:02 +0900
Message-Id: <20240422164104.2869507-1-masahiroy@kernel.org>
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
  sh: Convert the last use of 'optional' property in Kconfig
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


