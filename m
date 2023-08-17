Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C9E7801C0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 01:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356127AbjHQXgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356190AbjHQXgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:36:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2235535A1;
        Thu, 17 Aug 2023 16:36:46 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 479FC66071BC;
        Fri, 18 Aug 2023 00:36:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692315404;
        bh=mdghRnapbwiBDXVpqAB4UF70tuq5m/OlI6HU1thB/Lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kw36Htn5bVIF2wW+vHzegBZm3btM0Y8OIyv6MBQH15Tmb3IATsAFf8OHTGRTwVYDD
         ksl7/vOvFSZf30P0KbklkodINQ02RaJby/8SXtFRRG8Dd4335ERobVOKWeCcjnoXBP
         nGkTtkuUMnN41PHfMjpvrNAIPHBj/IOsCmpKSCXV52trG6KfYih+R6qnz7gJwlXKZK
         YicVD1MyNmTnX5j/Xu5amh+nYHMs7nJmxwISgIOBB65g/y6k9aDCFWRHY/QfuYJLel
         jI+2+gtMFC3TUK8AdbKREC++9d0N8qqM59U75CkvtJYlX4QHID3oLsaEG0sqoQQ7og
         ksPPXrQdBCAYA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, kernelci@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Bjorn Andersson <andersson@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt: dt-extract-compatibles: Handle cfile arguments in generator function
Date:   Thu, 17 Aug 2023 19:35:25 -0400
Message-ID: <20230817233635.2306377-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817233635.2306377-1-nfraprado@collabora.com>
References: <20230817233635.2306377-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the handling of the cfile arguments to a separate generator
function to avoid redundancy.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Added this commit

 scripts/dtc/dt-extract-compatibles | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/scripts/dtc/dt-extract-compatibles b/scripts/dtc/dt-extract-compatibles
index 9df9f1face83..2b6d228602e8 100755
--- a/scripts/dtc/dt-extract-compatibles
+++ b/scripts/dtc/dt-extract-compatibles
@@ -49,6 +49,14 @@ def print_compat(filename, compatibles):
 	else:
 		print(*compatibles, sep='\n')
 
+def files_to_parse(path_args):
+	for f in path_args:
+		if os.path.isdir(f):
+			for filename in glob.iglob(f + "/**/*.c", recursive=True):
+				yield filename
+		else:
+			yield f
+
 show_filename = False
 
 if __name__ == "__main__":
@@ -59,11 +67,6 @@ if __name__ == "__main__":
 
 	show_filename = args.with_filename
 
-	for f in args.cfile:
-		if os.path.isdir(f):
-			for filename in glob.iglob(f + "/**/*.c", recursive=True):
-				compat_list = parse_compatibles(filename)
-				print_compat(filename, compat_list)
-		else:
-			compat_list = parse_compatibles(f)
-			print_compat(f, compat_list)
+	for f in files_to_parse(args.cfile):
+		compat_list = parse_compatibles(f)
+		print_compat(f, compat_list)
-- 
2.41.0

