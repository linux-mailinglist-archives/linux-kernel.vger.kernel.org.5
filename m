Return-Path: <linux-kernel+bounces-160996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC6A8B4594
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 12:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744871F21BFC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBB144C94;
	Sat, 27 Apr 2024 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsnFewS0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E33C383B2;
	Sat, 27 Apr 2024 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714214589; cv=none; b=TrNJoiHK1TCd6gFMzPCJu34ydoopCAtViH0DidJ/xtijVXiHTsTbZ468LE4AC15fKn6Ki/GufbkqatqLrUe+tOwdTxh2ORfCmC5ecnP/sGaCKiSgT0b1ztb66ol4y1/gJW2xeEhLqD5lhb+iCwZ7Mlc69yzpPBN6EkPMa/UG8zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714214589; c=relaxed/simple;
	bh=yXENlZl/r+zrHsbm7JYiplM9HzFo663usaZ7tCpedTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YfAdWmndWAKKqYNyYOQP8kX5p/RrJ/TmvizHlvHeZUSeWvf+zVoKpOErcUH5HONk6pQ7++yFSZqNd+QjXaw5peL8YacbybdoHo/IENp7lpb7fgmnvN0FIq2rS1G/KJ8RZyTekb+eKhkZkwnREqfn4PBbrC5AJcVzcc6wGEGYETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsnFewS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16541C113CE;
	Sat, 27 Apr 2024 10:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714214589;
	bh=yXENlZl/r+zrHsbm7JYiplM9HzFo663usaZ7tCpedTQ=;
	h=From:To:Cc:Subject:Date:From;
	b=BsnFewS02DuNgUww69Y9ZuSeu1vk2yOL/Da4Wm63rWglc8X8AMGT3t7iPxLFhAUG4
	 wumsrDz6RJAwZ6MBHaR3U2jEe72YQCYDsaNgaty6YlXWLlpM1p9PQ4vW6dk6URmfrc
	 l79K1EeFHIEAXbBvlndW5Zon55Tc46204ZGucIeUEg8zYudIMcys2K7+3yTc0Pv/vj
	 F+T1JumyQ/uRCp5bvltzmD8kZR9up0829haS6a06/NJWUylAvneNB6CdJ2+L6A85Jv
	 sOVYU8axQmZhp2JnxazoFoTi9AMMnz6APSrDr270KEBq6WLP4nnBcH6MWlnqHtOkPY
	 YM758Ph5B2dlQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Matt Porter <mporter@kernel.crashing.org>,
	Alexandre Bounine <alex.bou9@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-doc@vger.kernel.org
Subject: [PATCH 0/2] kconfig: stop implification of choice type
Date: Sat, 27 Apr 2024 19:42:29 +0900
Message-Id: <20240427104231.2728905-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


There are two types supported for the choice statement,
"bool" and "tristate".

There is no ambiguity if you explicitly specifiy the type of the
choice.

For example

    choice
            bool "choose"

       ...

    endchoice

Or,

    choice
            tristate "choose"

       ...

    endchoice

Those are valid code, and clear about the behavior.

However, if you see the reality in the kernel code, most of people
omit the type definition.

Usually, the choice is written like this:

    choice
            prompt "choose"

       ...

    endchoice

The "prompt" does not specify the type at all.

You may wonder how Kconfig knows the choice type then.

When the choice type is not specified, Kconfig infers it from the first
entry within the choice block.

In the following, the choice type is bool because the first entry,
CONFIG_A, is bool.

    choice
            prompt "choose"

    config A
            bool "A"

    config B
            bool "B"

    endchoice

As described in 2/2, this has a bug when "if" ... "endif" exists
within a "choice" ... "endchoice".

Of course, I can fix this bug, but the value of this feature is
questionable.

This patch set stop the type implification. Instead, make the
default type of the choice "bool".

This is reasonable because 99% of choice blocks are bool.

The only user of tristate choice is drivers/rapidio/Kconfig.
(although that choice is unneeded because it cotains a single
entry, RAPIDIO_ENUM_BASIC)

It changed it to specify "tristate" explicitly.



Masahiro Yamada (2):
  rapidio: specify the type for tristate choice explicitly
  kconfig: do not imply the type of choice from the first entry

 Documentation/kbuild/kconfig-language.rst             |  4 +---
 drivers/rapidio/Kconfig                               |  2 +-
 scripts/kconfig/menu.c                                | 11 -----------
 scripts/kconfig/parser.y                              |  3 +++
 scripts/kconfig/tests/choice/Kconfig                  |  2 +-
 scripts/kconfig/tests/choice_value_with_m_dep/Kconfig |  2 +-
 6 files changed, 7 insertions(+), 17 deletions(-)

-- 
2.40.1


