Return-Path: <linux-kernel+bounces-160998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E153B8B4599
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 12:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A661C20F2A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B40482C3;
	Sat, 27 Apr 2024 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjxSAXVp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24474C619;
	Sat, 27 Apr 2024 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714214593; cv=none; b=V51de9v3AzoYxKk5WBpURHQuR5vF5DvWWxRQLmjhTxtpwmUb7JS14Xdhj7e8pPJQvck86b9hyPw85qdo5YQmm3W+IXmzzZ3XLnuvfLJF/cHo8emeNYWOw5+dvZT3Ron2sdr3DZGkBk3z5joMZIr6/ajCMWVU+6pRSdgzHrxFjL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714214593; c=relaxed/simple;
	bh=OYJqdjW3rXoj3fRazQzcMwYfheGMCtZdq6OYTVY06Y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L3hzr9TVUgiD1Ml7tlEk8oaua9mNtX83zAN5DWPyh0bUpDnX5FkVFz5wdhi0R6YpNeC1vnr+Q53UojktKRFUS1mo/rAafaI53mqrClfKz6eb9Xy3iOb/zZjdxEpe8rv9rWTnQ+QfEt0k/45FHrYOCugN1FPJGqaNBhH4aOgBp6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjxSAXVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3726CC113CE;
	Sat, 27 Apr 2024 10:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714214593;
	bh=OYJqdjW3rXoj3fRazQzcMwYfheGMCtZdq6OYTVY06Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RjxSAXVpXQ9JQKFzA8rOsQDV9GWCfacFItigw4e87nQqeK/rMyQcpp7exULz2ud5l
	 YNedVGRnZBzcVUUHjzfchy0Zr/2xefWpQ/3Hf1i7L9lqrYX7sqWuqWhhDFFhysZX4d
	 t8qooOW5RxbcnXagWW+LLCqb43Otv82MkgpVaJz0CAB4lAIy8dwV5UJr7eG5zKHZTe
	 /KD6wRtTvhqbzeu7f2Ta5E75ORA5Qv30I9/UGhWGciaCgwkPJv1fbC8g++7p5KDUIc
	 Zp/dHgDryJI9NxwxM5vIFlZJrr/djcXds51EGfr7uc8//ElVp5GlCyfExbOhIjaX0r
	 3QfyWkbwQCqgA==
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
Subject: [PATCH 2/2] kconfig: do not imply the type of choice from the first entry
Date: Sat, 27 Apr 2024 19:42:31 +0900
Message-Id: <20240427104231.2728905-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240427104231.2728905-1-masahiroy@kernel.org>
References: <20240427104231.2728905-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The followng two test cases are very similar, but the latter does not
work.

[test case 1]

    choice
            prompt "choose"

    config A
            bool "A"

    if y
    config B
            bool "B"
    endif

    endchoice

[test case 2]

    choice
            prompt "choose"

    if y
    config A
            bool "A"

    config B
            bool "B"
    endif

    endchoice

Since 'if y' is always true, both of them should be equivalent to:

    choice
            prompt "choose"

    config A
            bool "A"

    config B
            bool "B"

    endchoice

However, the test case 2 warns:
  Kconfig:1:warning: config symbol defined without type

If the type of choice is not specified, it is implied from the first
entry within the choice block.

When inferring the choice type, menu_finalize() checks only direct
children of the choice. At this point, the menu entries still exist
under the 'if' entry:

  choice
  \-- if y
      |-- A
      \-- B

Later, menu_finalize() re-parents the menu, so A and B will be lifted up
right under the choice:

  choice
  |-- if y
  |-- A
  \-- B

This is complex because menu_finalize() sets attributes, restructures
the menu tree, and checks the sanity at the same time, leading to some
bugs.

It would be possible to resolve it by setting the choice type after
re-parenting, but the current mechanism looks questionable to me.

Let's default all choices to 'bool' unless the type is specified.
This change makes sense because 99% of choice use cases are bool.

There exists only one 'tristate' choice in drivers/rapidio/Kconfig.
Another (much cleaner) approach would be to remove the tristate choice
support entirely, but I have not yet made up my mind.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/kbuild/kconfig-language.rst             |  4 +---
 scripts/kconfig/menu.c                                | 11 -----------
 scripts/kconfig/parser.y                              |  3 +++
 scripts/kconfig/tests/choice/Kconfig                  |  2 +-
 scripts/kconfig/tests/choice_value_with_m_dep/Kconfig |  2 +-
 5 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
index 555c2f839969..42b975b8e0cf 100644
--- a/Documentation/kbuild/kconfig-language.rst
+++ b/Documentation/kbuild/kconfig-language.rst
@@ -400,9 +400,7 @@ choices::
 
 This defines a choice group and accepts any of the above attributes as
 options. A choice can only be of type bool or tristate.  If no type is
-specified for a choice, its type will be determined by the type of
-the first choice element in the group or remain unknown if none of the
-choice elements have a type specified, as well.
+specified for a choice, its type will be the default 'bool'.
 
 While a boolean choice only allows a single config entry to be
 selected, a tristate choice also allows any number of config entries
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index e01b9ee87c05..134ef120ad08 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -323,17 +323,6 @@ static void _menu_finalize(struct menu *parent, bool inside_choice)
 			is_choice = true;
 
 		if (is_choice) {
-			if (sym->type == S_UNKNOWN) {
-				/* find the first choice value to find out choice type */
-				current_entry = parent;
-				for (menu = parent->list; menu; menu = menu->next) {
-					if (menu->sym && menu->sym->type != S_UNKNOWN) {
-						menu_set_type(menu->sym->type);
-						break;
-					}
-				}
-			}
-
 			/*
 			 * Use the choice itself as the parent dependency of
 			 * the contained items. This turns the mode of the
diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index 613fa8c9c2d0..70ea3152d9b8 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -230,6 +230,9 @@ choice: T_CHOICE T_EOL
 
 choice_entry: choice choice_option_list
 {
+	if (current_entry->sym->type == S_UNKNOWN)
+		menu_set_type(S_BOOLEAN);
+
 	if (!current_entry->prompt) {
 		fprintf(stderr, "%s:%d: error: choice must have a prompt\n",
 			current_entry->filename, current_entry->lineno);
diff --git a/scripts/kconfig/tests/choice/Kconfig b/scripts/kconfig/tests/choice/Kconfig
index 8cdda40868a1..4dc0d3a1e089 100644
--- a/scripts/kconfig/tests/choice/Kconfig
+++ b/scripts/kconfig/tests/choice/Kconfig
@@ -18,7 +18,7 @@ config BOOL_CHOICE1
 endchoice
 
 choice
-	prompt "tristate choice"
+	tristate "tristate choice"
 	default TRI_CHOICE1
 
 config TRI_CHOICE0
diff --git a/scripts/kconfig/tests/choice_value_with_m_dep/Kconfig b/scripts/kconfig/tests/choice_value_with_m_dep/Kconfig
index bd970cec07d6..3e600c83279a 100644
--- a/scripts/kconfig/tests/choice_value_with_m_dep/Kconfig
+++ b/scripts/kconfig/tests/choice_value_with_m_dep/Kconfig
@@ -9,7 +9,7 @@ config DEP
 	default m
 
 choice
-	prompt "Tristate Choice"
+	tristate "Tristate Choice"
 
 config CHOICE0
 	tristate "Choice 0"
-- 
2.40.1


