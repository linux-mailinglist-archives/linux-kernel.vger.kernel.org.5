Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C947E4C12
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343704AbjKGW4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjKGW4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:56:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE0918C;
        Tue,  7 Nov 2023 14:56:33 -0800 (PST)
Received: from notapiano.myfiosgateway.com (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F2FAD66074D4;
        Tue,  7 Nov 2023 22:56:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699397791;
        bh=+pDcPxfGlA0dL3Lp3d6m5ZR8VLuzhaRJSUxxc7deZkY=;
        h=From:To:Cc:Subject:Date:From;
        b=TSRwOKldf9y0mBtzI4DQa9H5Sut50EXy9J5zVXmcBHeE+8v9iL2TsLhtRXbyzPOJ4
         Gz5rkIQ9WpHc5J0adUZmoxuwzgOZzpTq7pFP5oHy0qJd2sv2yA4pa/cJ7sFgr00OiC
         hFLkg/yXTFxij0m3cg3wGm8y1LBV88LfpMMZveYtdH7Ys2rC6L62Rq5X2Swhw7iu47
         1iXwOwUXoIM5l+nWmexqJQZsQqhCC0cak6RWYMwDeqCisQbjYv4DoRCKGWqkUDCw7d
         EbtVsZUwEeQb8rPlKE5r7U86lpfq2xu57iRagX5HxtzhbkThlVJ0Q6XX8ZmupfBDEm
         2Y9Mdr98cAH0w==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Aishwarya TCV <aishwarya.tcv@arm.com>,
        Mark Brown <broonie@kernel.org>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt: dt-extract-compatibles: Don't follow symlinks when walking tree
Date:   Tue,  7 Nov 2023 17:55:28 -0500
Message-ID: <20231107225624.9811-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iglob function, which we use to find C source files in the kernel
tree, always follows symbolic links. This can cause unintentional
recursions whenever a symbolic link points to a parent directory. A
common scenario is building the kernel with the output set to a
directory inside the kernel tree, which will contain such a symlink.

Instead of using the iglob function, use os.walk to traverse the
directory tree, which by default doesn't follow symbolic links. fnmatch
is then used to match the glob on the filename, as well as ignore hidden
files (which were ignored by default with iglob).

This approach runs just as fast as using iglob.

Fixes: b6acf8073517 ("dt: Add a check for undocumented compatible strings in kernel")
Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Closes: https://lore.kernel.org/all/e90cb52f-d55b-d3ba-3933-6cc7b43fcfbc@arm.com
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 scripts/dtc/dt-extract-compatibles | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/scripts/dtc/dt-extract-compatibles b/scripts/dtc/dt-extract-compatibles
index bd07477dd144..5ffb2364409b 100755
--- a/scripts/dtc/dt-extract-compatibles
+++ b/scripts/dtc/dt-extract-compatibles
@@ -1,8 +1,8 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0-only
 
+import fnmatch
 import os
-import glob
 import re
 import argparse
 
@@ -81,10 +81,20 @@ def print_compat(filename, compatibles):
 	else:
 		print(*compatibles, sep='\n')
 
+def glob_without_symlinks(root, glob):
+	for path, dirs, files in os.walk(root):
+		# Ignore hidden directories
+		for d in dirs:
+			if fnmatch.fnmatch(d, ".*"):
+				dirs.remove(d)
+		for f in files:
+			if fnmatch.fnmatch(f, glob):
+				yield os.path.join(path, f)
+
 def files_to_parse(path_args):
 	for f in path_args:
 		if os.path.isdir(f):
-			for filename in glob.iglob(f + "/**/*.c", recursive=True):
+			for filename in glob_without_symlinks(f, "*.c"):
 				yield filename
 		else:
 			yield f
-- 
2.42.0

