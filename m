Return-Path: <linux-kernel+bounces-109188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D386D8815E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5C21C20F88
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12CC69E0F;
	Wed, 20 Mar 2024 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qco+60JJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B8369DFA;
	Wed, 20 Mar 2024 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710953537; cv=none; b=h0r/3UX9/eriq4V55HfI9Ai98XnHIES/PuyxEVH+Dlv5byok12SAMxmyq+nyXoqZzj4Xzn1j/3R7ueEG763ePsZGHOF2E0ncCxgsMWY7hztuhLCRh1YVh9jNPE+PaTYFIP+4fhoN03S6PVwQlAOZAgrhau9cOqQ9gKwCz23/AYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710953537; c=relaxed/simple;
	bh=3XG2pYGXkbO1NNRb5gyk8bO2cOKjk6ghc6qKHY09iDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N1okaVcOvS7Z7vnvsdU95WSH74ZRYbrZ82IMu+u/SlaUilZRKQsN5ZfKsh5Wn/OZfGjRi++W6r43xKRNrM2AVJIKPk/x6UsrvBTc988kKiqsVVWjWO/JlVxTBEu1pYCEKSf5B0Vp76f3V6hb8d5WBCQ7NNsXys65w7oHw1+8mu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qco+60JJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028F0C43390;
	Wed, 20 Mar 2024 16:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710953536;
	bh=3XG2pYGXkbO1NNRb5gyk8bO2cOKjk6ghc6qKHY09iDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qco+60JJc9PsvJFPkg02B+v/2PD8QBUdM7N/uxUBj8Hz5uq7Nti508Z4O25JCDz7D
	 skEvOr7gsELsMwOAyg0X8gDTRdB/Gvkq6h2rp+ObZds34pMax4IbdRZfCl5cGWlQMV
	 661T0cnZXqyJ5woPqNT+QgZNUwV4y1xp0j+IUiuFeKt4kh9HgwyaRfKkcQwBGPOk80
	 Aa2SZwdD8ocxVtgdaTnAAPbNOpWQ42bQmJNBGJn2HClBhHxPwK4myFQPDmfEztvRvb
	 yBpHpmbiY4HLvOJN6b8Ebvumf4CPy1zTdi7osv+RIVWEVSm79BOf/08v5EpM9BFtvK
	 bfDIsvkE2ppPA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/3] kconfig: tests: add a test for randconfig with dependent choices
Date: Thu, 21 Mar 2024 01:52:10 +0900
Message-Id: <20240320165211.697584-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240320165211.697584-1-masahiroy@kernel.org>
References: <20240320165211.697584-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 3b9a19e08960 ("kconfig: loop as long as we changed some
symbols in randconfig"), conf_set_all_new_symbols() is repeated until
there is no more choice left to be shuffled. The motivation was to
shuffle a choice nested in another choice.

Although commit 09d5873e4d1f ("kconfig: allow only 'config', 'comment',
and 'if' inside 'choice'") disallowed the nested choice structure,
we must still keep 3b9a19e08960 because there are still cases where
conf_set_all_new_symbols() must iterate.

scripts/kconfig/tests/choice_randomize/Kconfig is the test case.
The second choice depends on 'B', which is the member of the first
choice.

With 3b9a19e08960 reverted, we would never get the pattern specified by
scripts/kconfig/tests/choice_randomize/expected_config2.

A real example can be found in lib/Kconfig.debug. Without 3b9a19e08960,
the randconfig would not shuffle the "Compressed Debug information"
choice, which depends on DEBUG_INFO, which is derived from another
choice "Debug information".

My goal is to refactor Kconfig so that randconfig will work more
simply, without using the loop.

For now, let's add a test case to ensure all dependent choices are
shuffled, as it is a somewhat tricky case for the current Kconfig.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 .../kconfig/tests/choice_randomize/Kconfig    | 22 ++++++++++++
 .../tests/choice_randomize/__init__.py        | 34 +++++++++++++++++++
 .../tests/choice_randomize/expected_config0   |  6 ++++
 .../tests/choice_randomize/expected_config1   |  8 +++++
 .../tests/choice_randomize/expected_config2   |  8 +++++
 5 files changed, 78 insertions(+)
 create mode 100644 scripts/kconfig/tests/choice_randomize/Kconfig
 create mode 100644 scripts/kconfig/tests/choice_randomize/__init__.py
 create mode 100644 scripts/kconfig/tests/choice_randomize/expected_config0
 create mode 100644 scripts/kconfig/tests/choice_randomize/expected_config1
 create mode 100644 scripts/kconfig/tests/choice_randomize/expected_config2

diff --git a/scripts/kconfig/tests/choice_randomize/Kconfig b/scripts/kconfig/tests/choice_randomize/Kconfig
new file mode 100644
index 000000000000..93a1699ce3cb
--- /dev/null
+++ b/scripts/kconfig/tests/choice_randomize/Kconfig
@@ -0,0 +1,22 @@
+choice
+	prompt "choose A or B"
+
+config A
+	bool "A"
+
+config B
+	bool "B"
+
+endchoice
+
+choice
+	prompt "choose X or Y"
+	depends on B
+
+config X
+	bool "X"
+
+config Y
+	bool "Y"
+
+endchoice
diff --git a/scripts/kconfig/tests/choice_randomize/__init__.py b/scripts/kconfig/tests/choice_randomize/__init__.py
new file mode 100644
index 000000000000..d380045be79c
--- /dev/null
+++ b/scripts/kconfig/tests/choice_randomize/__init__.py
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-only
+"""
+Randomize all dependent choices
+
+This is a somewhat tricky case for randconfig; the visibility of one choice is
+determined by a member of another choice. Randconfig should be able to generate
+all possible patterns.
+"""
+
+
+def test(conf):
+
+    expected0 = False
+    expected1 = False
+    expected2 = False
+
+    for i in range(100):
+        assert conf.randconfig(seed=i) == 0
+
+        if conf.config_matches('expected_config0'):
+            expected0 = True
+        elif conf.config_matches('expected_config1'):
+            expected1 = True
+        elif conf.config_matches('expected_config2'):
+            expected2 = True
+        else:
+            assert False
+
+        if expected0 and expected1 and expected2:
+            break
+
+    assert expected0
+    assert expected1
+    assert expected2
diff --git a/scripts/kconfig/tests/choice_randomize/expected_config0 b/scripts/kconfig/tests/choice_randomize/expected_config0
new file mode 100644
index 000000000000..f69227323759
--- /dev/null
+++ b/scripts/kconfig/tests/choice_randomize/expected_config0
@@ -0,0 +1,6 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# Main menu
+#
+CONFIG_A=y
+# CONFIG_B is not set
diff --git a/scripts/kconfig/tests/choice_randomize/expected_config1 b/scripts/kconfig/tests/choice_randomize/expected_config1
new file mode 100644
index 000000000000..bf83784c9b2a
--- /dev/null
+++ b/scripts/kconfig/tests/choice_randomize/expected_config1
@@ -0,0 +1,8 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# Main menu
+#
+# CONFIG_A is not set
+CONFIG_B=y
+CONFIG_X=y
+# CONFIG_Y is not set
diff --git a/scripts/kconfig/tests/choice_randomize/expected_config2 b/scripts/kconfig/tests/choice_randomize/expected_config2
new file mode 100644
index 000000000000..38f93a8f37bd
--- /dev/null
+++ b/scripts/kconfig/tests/choice_randomize/expected_config2
@@ -0,0 +1,8 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# Main menu
+#
+# CONFIG_A is not set
+CONFIG_B=y
+# CONFIG_X is not set
+CONFIG_Y=y
-- 
2.40.1


