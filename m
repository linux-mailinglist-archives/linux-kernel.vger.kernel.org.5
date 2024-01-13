Return-Path: <linux-kernel+bounces-25263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4C182CBFA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 11:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3AE1C21C67
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD3B20DDB;
	Sat, 13 Jan 2024 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqIrmR+i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434A79F3;
	Sat, 13 Jan 2024 10:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A393C433F1;
	Sat, 13 Jan 2024 10:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705142628;
	bh=7QTEqiII/ATcIcuXjYpHlYvEtuflKe0mzeo9AghBfD8=;
	h=From:To:Cc:Subject:Date:From;
	b=lqIrmR+i9CuvBidK8icPurOxo5FokvxXoCpnMakaVxtd5Kns7VuC9pt2cY46M6X0D
	 2JPzIGax10xZD6WP+idfo5l5YbYH5XUelk1KsKJn6bwkLHdrLcnXpFt6HOd2Mh2g1q
	 BlR35CVBRLHz4JHXSu9eM2aC/Dblnt8M/aNAYZXb+KnL212+kElR99H+aCKPGL5jwG
	 wNWNI6Y5h+6iNj4WyS+XeTbF7L4dc+DtZLqrl0xsDGqR0O0NurMr32SaZTx/aOfJmf
	 ussp6DdZ8s50gSa19tsR30RCg4y946VoM50JZtHVWrFrP+CbHCfXkiLTC6rCFErQnS
	 OLofs/M/rz2gA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] kbuild: deb-pkg: show verbose log for direct package builds
Date: Sat, 13 Jan 2024 19:43:36 +0900
Message-Id: <20240113104339.16131-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the Debian package build is initiated by Kbuild ('make deb-pkg'
or 'make bindeb-pkg'), the log messages are displayed in the short
form, which is the Kbuild default.

Otherwise, let's show verbose messages (unless the 'terse' tag is set
in DEB_BUILD_OPTION), as suggested by Debian Policy: "The package build
should be as verbose as reasonably possible, except where the terse tag
is included in DEB_BUILD_OPTIONS." [1]

This is what the Debian kernel also does. [2]

[1]: https://www.debian.org/doc/debian-policy/ch-source.html#main-building-script-debian-rules
[2]: https://salsa.debian.org/kernel-team/linux/-/blob/debian/6.7-1_exp1/debian/rules.real#L36

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - New patch

 scripts/package/debian/rules | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index 098307780062..697fbfa7595f 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -11,6 +11,14 @@ ifneq (,$(filter-out parallel=1,$(filter parallel=%,$(DEB_BUILD_OPTIONS))))
     MAKEFLAGS += -j$(NUMJOBS)
 endif
 
+# When KBUILD_VERBOSE is undefined (presumably you are directly working with
+# the debianized tree), show verbose logs unless DEB_BUILD_OPTION=terse is set.
+ifeq ($(origin KBUILD_VERBOSE),undefined)
+    ifeq (,$(filter terse,$(DEB_BUILD_OPTIONS)))
+        export KBUILD_VERBOSE := 1
+    endif
+endif
+
 revision = $(lastword $(subst -, ,$(shell dpkg-parsechangelog -S Version)))
 CROSS_COMPILE ?= $(filter-out $(DEB_BUILD_GNU_TYPE)-, $(DEB_HOST_GNU_TYPE)-)
 make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE) KBUILD_BUILD_VERSION=$(revision) $(addprefix CROSS_COMPILE=,$(CROSS_COMPILE))
-- 
2.40.1


