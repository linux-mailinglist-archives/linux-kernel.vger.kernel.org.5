Return-Path: <linux-kernel+bounces-109187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7686B8815E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF42C1C212C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E4B69DF1;
	Wed, 20 Mar 2024 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgZmBreY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F8769DE6;
	Wed, 20 Mar 2024 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710953536; cv=none; b=i0a7/8WJvFueVQeDo4oTQAQh2xUbu4uh2Sq012yibIlFuE9y4O+V0a6g71D4SWLge4Aw5onWjB+ovVmQxyvNY+pxWkp4WyevO0pGRsNkmzja/V0E1fKjk3KzWwdzD/xPrxfamYhNihgD2tTTHALJwNrL8eZhIg6q+9mXBDk4tWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710953536; c=relaxed/simple;
	bh=NR9sR85xAHzVG2coKJ4Iltba6VffU0YEvzAwFcIjHWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n0dCU42xCq8hiuYlLze3PG+yXmEBNpPr9MVUNpGZJvo5I+DLQXIBJEmB9mcp2TlxJCL+5givKQvlWlUCxX5XW6/sB382nLsEeuONDxppsskWhG31BACMYFG4sNELlONg7SrEcJZtwMJB744Xhvk5WMgZTb5lRYB6/TEQcRMCCoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgZmBreY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DCCC433F1;
	Wed, 20 Mar 2024 16:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710953535;
	bh=NR9sR85xAHzVG2coKJ4Iltba6VffU0YEvzAwFcIjHWc=;
	h=From:To:Cc:Subject:Date:From;
	b=YgZmBreYRE7m98v1KM/B01ectHsmH12QI3mmlwiGA7v+pLyLzaQtfJUD30qV51z1J
	 38t3lYNfPJjfyD/NcyFu1Xc4JMyQcF+Sb1A2qv0JwqhAFWPktUhCx0N7Tr36xbqz46
	 K+ezG3ePOdijFH20nwlDDYEY3k1v9A79DJFs+t4PtfTpSQ3YRiXsnt/89r2Cq8mVY9
	 33fFL1DxYyo28MsfL6oCAUzVoBZQRcsk3SbnVhS//RFUJAMF/lTq1xpQYmUaAfVpN0
	 JVaC5AIZJT8V9jWhQZKLRpse1abcq+g4QX5RHY5j5WLuTQ/4BcOxob9JGL44OCE43i
	 b2aqJrDD4luAQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/3] kconfig: tests: support KCONFIG_SEED for the randconfig runner
Date: Thu, 21 Mar 2024 01:52:09 +0900
Message-Id: <20240320165211.697584-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will help get consistent results for randconfig tests.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/tests/conftest.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/scripts/kconfig/tests/conftest.py b/scripts/kconfig/tests/conftest.py
index af8774a5697c..2a2a7e2da060 100644
--- a/scripts/kconfig/tests/conftest.py
+++ b/scripts/kconfig/tests/conftest.py
@@ -154,12 +154,10 @@ class Conf:
         defconfig_path = os.path.join(self._test_dir, defconfig)
         return self._run_conf('--defconfig={}'.format(defconfig_path))
 
-    def _allconfig(self, mode, all_config):
+    def _allconfig(self, mode, all_config, extra_env={}):
         if all_config:
             all_config_path = os.path.join(self._test_dir, all_config)
-            extra_env = {'KCONFIG_ALLCONFIG': all_config_path}
-        else:
-            extra_env = {}
+            extra_env['KCONFIG_ALLCONFIG'] = all_config_path
 
         return self._run_conf('--{}config'.format(mode), extra_env=extra_env)
 
@@ -195,13 +193,19 @@ class Conf:
         """
         return self._allconfig('alldef', all_config)
 
-    def randconfig(self, all_config=None):
+    def randconfig(self, all_config=None, seed=None):
         """Run randconfig.
 
         all_config: fragment config file for KCONFIG_ALLCONFIG (optional)
+        seed: the seed for randconfig (optional)
         returncode: exit status of the Kconfig executable
         """
-        return self._allconfig('rand', all_config)
+        if seed is not None:
+            extra_env = {'KCONFIG_SEED': hex(seed)}
+        else:
+            extra_env = {}
+
+        return self._allconfig('rand', all_config, extra_env=extra_env)
 
     def savedefconfig(self, dot_config):
         """Run savedefconfig.
-- 
2.40.1


