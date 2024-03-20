Return-Path: <linux-kernel+bounces-109189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C57E68815EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDD7281136
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076B56A034;
	Wed, 20 Mar 2024 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdIoDaO2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B21D6A00C;
	Wed, 20 Mar 2024 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710953538; cv=none; b=QH4g46qsH8vMvP97KI98MzySLqiRZ9Ydb4YMYo7nIOxtF/Vok8QBFOwV/yOSJIXLecpEPKojkzABwGTotvxycUYLF/mZVQJoW5FB/ksCYbjARiu5vY8l7s1htTccGkT441iuwbvd1Iq4tScCcpb0WPon4FC6avMYvcXuI+dmd2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710953538; c=relaxed/simple;
	bh=oH45crn/4yGs/ur5w7wZpa4kx7+grNNIEqXM5CcoE7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j93ad2mcGgBpwwWnEd/97E0A8I206+aBQ+6n7Hp8pO4OlHqnXKhlKVCBYyUJFhejJ2bPDY9uaS+8JlySkeLUL9fCOUWtyh24AHJx3j3xK/RxL7/gbrxWInNQz5fmWgEx1wbzTmBCQLRCiruxb12URbcbXjCH7BZwXYdgeVYU5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdIoDaO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E191C433C7;
	Wed, 20 Mar 2024 16:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710953537;
	bh=oH45crn/4yGs/ur5w7wZpa4kx7+grNNIEqXM5CcoE7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DdIoDaO2PwVD0nbFM9RA7zE4uWmIJNFVwjOycSnxHZqBt0sWms7zcIvojWgk789Pw
	 0DaGpBgR3vPY1myLHQZ+MGdwOmCXkQELe+Si7p4Yal2aaLwf2Epaj1qJ5D6EO+iGIE
	 2wFuIdY6Tof4Th4KAt+4etowD8hoBk+u69MviMu27dBU0yOq/5grYOHC4x/776C6qW
	 bwHxTMHgBFK3OJAHd/TWtA3hgMKVmabMM6LY+jNd9tZ+lPMH2gVoAZXg0JsVYVodWl
	 uFhtSTl2QPKlUOTlmGwhJDfwzWjPPAJVozeoA3pnQx0X4lEsDUNRBIHFP3wmwbAeLX
	 jQrnTe4HhC8fg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/3] kconfig: tests: test dependency after shuffling choices
Date: Thu, 21 Mar 2024 01:52:11 +0900
Message-Id: <20240320165211.697584-3-masahiroy@kernel.org>
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

Commit c8fb7d7e48d1 ("kconfig: fix broken dependency in randconfig-
generated .config") fixed the issue, but I did not add a test case.

This commit adds a test case that emulates the reported situation.
The test would fail without c8fb7d7e48d1.

To handle the choice "choose X", FOO must be calculated beforehand.
FOO depends on A, which is a member of another choice "choose A or B".
Kconfig _temporarily_ assumes the value of A to proceed. The choice
"choose A or B" will be shuffled later, but the result may or may not
meet "FOO depends on A". Kconfig should invalidate the symbol values
and recompute them.

In the real example for ARCH=arm64, the choice "Instrumentation type"
needs the value of CPU_BIG_ENDIAN. The choice "Endianness" will be
shuffled later.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 .../kconfig/tests/choice_randomize2/Kconfig   | 32 +++++++++++++++++++
 .../tests/choice_randomize2/__init__.py       | 18 +++++++++++
 .../tests/choice_randomize2/expected_config0  |  8 +++++
 .../tests/choice_randomize2/expected_config1  |  7 ++++
 .../tests/choice_randomize2/expected_config2  |  6 ++++
 5 files changed, 71 insertions(+)
 create mode 100644 scripts/kconfig/tests/choice_randomize2/Kconfig
 create mode 100644 scripts/kconfig/tests/choice_randomize2/__init__.py
 create mode 100644 scripts/kconfig/tests/choice_randomize2/expected_config0
 create mode 100644 scripts/kconfig/tests/choice_randomize2/expected_config1
 create mode 100644 scripts/kconfig/tests/choice_randomize2/expected_config2

diff --git a/scripts/kconfig/tests/choice_randomize2/Kconfig b/scripts/kconfig/tests/choice_randomize2/Kconfig
new file mode 100644
index 000000000000..530cf2ef7f47
--- /dev/null
+++ b/scripts/kconfig/tests/choice_randomize2/Kconfig
@@ -0,0 +1,32 @@
+choice
+	prompt "This is always invisible"
+	depends on n
+
+config DUMMY
+	bool "DUMMY"
+
+endchoice
+
+choice
+	prompt "Choose A or B"
+
+config A
+	bool "A"
+
+config B
+	bool "B"
+
+endchoice
+
+config FOO
+	bool "FOO"
+	depends on A
+
+choice
+	prompt "Choose X"
+	depends on FOO
+
+config X
+	bool "X"
+
+endchoice
diff --git a/scripts/kconfig/tests/choice_randomize2/__init__.py b/scripts/kconfig/tests/choice_randomize2/__init__.py
new file mode 100644
index 000000000000..2066757b80b9
--- /dev/null
+++ b/scripts/kconfig/tests/choice_randomize2/__init__.py
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+"""
+Randomize choices with correct dependencies
+
+When shuffling a choice may potentially disrupt certain dependencies, symbol
+values must be recalculated.
+
+Related Linux commits:
+  - c8fb7d7e48d11520ad24808cfce7afb7b9c9f798
+"""
+
+
+def test(conf):
+    for i in range(20):
+        assert conf.randconfig(seed=i) == 0
+        assert (conf.config_matches('expected_config0') or
+                conf.config_matches('expected_config1') or
+                conf.config_matches('expected_config2'))
diff --git a/scripts/kconfig/tests/choice_randomize2/expected_config0 b/scripts/kconfig/tests/choice_randomize2/expected_config0
new file mode 100644
index 000000000000..5c9e1c172c15
--- /dev/null
+++ b/scripts/kconfig/tests/choice_randomize2/expected_config0
@@ -0,0 +1,8 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# Main menu
+#
+CONFIG_A=y
+# CONFIG_B is not set
+CONFIG_FOO=y
+CONFIG_X=y
diff --git a/scripts/kconfig/tests/choice_randomize2/expected_config1 b/scripts/kconfig/tests/choice_randomize2/expected_config1
new file mode 100644
index 000000000000..5b975d91bef1
--- /dev/null
+++ b/scripts/kconfig/tests/choice_randomize2/expected_config1
@@ -0,0 +1,7 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# Main menu
+#
+CONFIG_A=y
+# CONFIG_B is not set
+# CONFIG_FOO is not set
diff --git a/scripts/kconfig/tests/choice_randomize2/expected_config2 b/scripts/kconfig/tests/choice_randomize2/expected_config2
new file mode 100644
index 000000000000..5a5ebb90d1d7
--- /dev/null
+++ b/scripts/kconfig/tests/choice_randomize2/expected_config2
@@ -0,0 +1,6 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# Main menu
+#
+# CONFIG_A is not set
+CONFIG_B=y
-- 
2.40.1


