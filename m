Return-Path: <linux-kernel+bounces-67069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49188565B4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73551C21D83
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C0E131E31;
	Thu, 15 Feb 2024 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES6orXwm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C12B12CD98;
	Thu, 15 Feb 2024 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006540; cv=none; b=iPw6VLAs76Ny6M9rgXoKdH4a+4iJ+znM1a1dOkCaI5bPX+y3wvQCkYbuWvmykViOd3SzxB0dLbLYKUCntS3Bcs1c/WopJw+u0IH5/d4/A18+HgIPc1+zxrcPUsMTPPR4ilRsnghcqYGpPARzpxpRURL5CFhF1CES2ayZjbpocFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006540; c=relaxed/simple;
	bh=wLMxSv93mDKkvte+a+sn4g8mROkVAPqpgv+OwkJJ3v8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HcmGsV4B517qNZS0dDyGqiSnCUHB0MEVhBnXyV0FHDXnxzZh3nVx6ivZamvpG10B0sxVdpfrRCYnMlZpnN5CE+94gCj1VXscgEYS6UM5Vo7FfT9U9cSP/XZmfDJq++b4jGL9yUfRnI12J8FOlDbgQTS3PdbwsDqZYJJitrX7xIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES6orXwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F59BC433C7;
	Thu, 15 Feb 2024 14:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708006539;
	bh=wLMxSv93mDKkvte+a+sn4g8mROkVAPqpgv+OwkJJ3v8=;
	h=From:To:Cc:Subject:Date:From;
	b=ES6orXwmzWlo5VTAQyJhtm08NQ+Hd/RAw7H973POmzzls6fcA7So5/FD9c7DDEvWg
	 X/ntXXftI7Q8YueZubXNnkLDYP3HWGy11M8QH4nsLeYUg7qZSK1n8wwk/QmrNEOuXm
	 V7pJ4vaPC5kt1I7xurc+cJ8FsFBeE8E9WqCnfIuK/wpynb/oEX2g3CK60bwZnc3Rb/
	 zsHRf7UVxHU0eHxRio9tT9W0f46vO+lkO+Yw+AlJO6ABiaXgH0YbpJyHbTY2Pa1hIz
	 tmEfegfAdlhK8UQt/rJ1nBhAe0DRKjaiFxWVP3/kRQDhruGX+WlkV0UbJ3LzcxXbOf
	 P3p0XgYnE7rVg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: [PATCH] kbuild: remove EXPERT and !COMPILE_TEST guarding from TRIM_UNUSED_KSYMS
Date: Thu, 15 Feb 2024 23:15:01 +0900
Message-Id: <20240215141502.1911726-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts the following two commits:

  - a555bdd0c58c ("Kbuild: enable TRIM_UNUSED_KSYMS again, with some guarding")
  - 5cf0fd591f2e ("Kbuild: disable TRIM_UNUSED_KSYMS option")

Commit 5e9e95cc9148 ("kbuild: implement CONFIG_TRIM_UNUSED_KSYMS without
recursion") solved the build time issue.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 kernel/module/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 0ea1b2970a23..c3ced519e14b 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -362,8 +362,7 @@ config MODPROBE_PATH
 	  userspace can still load modules explicitly).
 
 config TRIM_UNUSED_KSYMS
-	bool "Trim unused exported kernel symbols" if EXPERT
-	depends on !COMPILE_TEST
+	bool "Trim unused exported kernel symbols"
 	help
 	  The kernel and some modules make many symbols available for
 	  other modules to use via EXPORT_SYMBOL() and variants. Depending
-- 
2.40.1


