Return-Path: <linux-kernel+bounces-1256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF79814C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B561C2382A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7029D3A8E8;
	Fri, 15 Dec 2023 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSxq79aV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7723BB2E;
	Fri, 15 Dec 2023 16:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE743C433C8;
	Fri, 15 Dec 2023 16:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702656406;
	bh=bGtK0d0oGVloKhV2jX7EqKBQotgvfSWouc8MLPevJ8g=;
	h=From:To:Cc:Subject:Date:From;
	b=CSxq79aVTkHfAnmg4GRqhIqSUyMRhFOIotw6KZKB7Grp2lZuKrogdZ4Uf4yo1oNmz
	 wKH9ZExCzK+Q9E6MNhtjF3rOyubzPyzqEgOgWhmig5Bw84UGa2/B5McIx0lvLlNanN
	 fmya/2EplByqXShNMA5yE9lq1AUYef94gS8eG8dobCkAsAyzociRZnmwjRcvWYgysZ
	 UJnLz8ju0FhgmJ5IofXZyMyZKnpGSUeZOMwnksFBdrJ4ZQRDzJDA5DKf5QR3w6r95w
	 h4Xza+g+dt+kmORiNhg/pn9rsXT7Y7OMMLda0Fp2COHmgH67fU9ZSfIkQfE3kgPBAu
	 meMPLSGoBO7Jw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <n.schier@avm.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kbuild: resolve symlinks for O= properly
Date: Sat, 16 Dec 2023 01:06:37 +0900
Message-Id: <20231215160637.842748-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, Kbuild follows the logical chain of directories for the O=
option, just like 'cd' (or 'realpath --logical') does.

Example:

    $ mkdir -p /tmp/a /tmp/x/y
    $ ln -s /tmp/x/y /tmp/a/b
    $ realpath /tmp/a/b/..
    /tmp/x
    $ realpath --logical /tmp/a/b/..
    /tmp/a
    $ make O=/tmp/a/b/.. defconfig
    make[1]: Entering directory '/tmp/a'
      [snip]
    make[1]: Leaving directory '/tmp/a'

'make O=/tmp/a/b/.. defconfig' creates the kernel configuration in
/tmp/a instead of /tmp/x despite /tmp/a/b/.. resolves to the physical
directory path /tmp/x.

This is because Kbuild internally uses the 'cd ... && pwd' for the
path resolution, but this behavior is not predictable for users.
Additionally, it is not consistent with how the Kbuild handles the
M= option or GNU Make works with 'make -C /tmp/a/b/..'.

Using the physical directory structure for the O= option seems more
reasonable.

The comment says "expand a shell special character '~'", but it has
already been expanded to the home directory in the command line.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <n.schier@avm.de>
---

Changes in v2:
  - Quote $(KBUILD_OUTPUT). If ~ is contained in KBUILD_OUTPUT,
    it should not expanded any further.

 Makefile | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 04a86c81b5c0..5036edc40f46 100644
--- a/Makefile
+++ b/Makefile
@@ -190,14 +190,11 @@ ifeq ("$(origin O)", "command line")
 endif
 
 ifneq ($(KBUILD_OUTPUT),)
-# Make's built-in functions such as $(abspath ...), $(realpath ...) cannot
-# expand a shell special character '~'. We use a somewhat tedious way here.
-abs_objtree := $(shell mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT) && pwd)
-$(if $(abs_objtree),, \
-     $(error failed to create output directory "$(KBUILD_OUTPUT)"))
-
+# $(realpath ...) gets empty if the path does not exist. Run 'mkdir -p' first.
+$(shell mkdir -p "$(KBUILD_OUTPUT)")
 # $(realpath ...) resolves symlinks
-abs_objtree := $(realpath $(abs_objtree))
+abs_objtree := $(realpath $(KBUILD_OUTPUT))
+$(if $(abs_objtree),,$(error failed to create output directory "$(KBUILD_OUTPUT)"))
 endif # ifneq ($(KBUILD_OUTPUT),)
 
 ifneq ($(words $(subst :, ,$(abs_srctree))), 1)
-- 
2.40.1


