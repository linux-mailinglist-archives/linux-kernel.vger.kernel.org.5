Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5F278BA13
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjH1VOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbjH1VOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:14:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E67C3;
        Mon, 28 Aug 2023 14:14:34 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C504F6607236;
        Mon, 28 Aug 2023 22:14:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693257273;
        bh=HrjOwWou5bAWqPfAighj4CIIJaWFRIbl2UCKh60cGsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SkRu8AMjrjJsiCpKZt3Ni7d7AjsF8JlblFWZRUq0e4IX99Grkm3SYeE7GgLiDiuMY
         Oq4K82i5vsdQes+sNT2OWAC0rnd1C/lQF3iketax1JyvtQNghfd93l2l5HWMu9V6Cb
         5+CICrRcZ+nZOl1nQR1CVz1gGKb2TLCqgWCPnK9e/Z3QTkSqrk64Ayt6+gs4qL8uvP
         aQlZ68kztotwO+h1YyRsAMSoACl7UkTSE38qLmepHEus7OLnNS5zLq/Aq8QLXOopRZ
         ixtkubp4CKNshsBQjxuVm8x5RquJ6BsUobfCPxPiaHmwTZvDK0B15uGrxdRoPL/+io
         hlLocXHj5u3LQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, kernelci@lists.linux.dev,
        kernel@collabora.com, Guenter Roeck <groeck@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt: dt-extract-compatibles: Add flag for driver matching compatibles
Date:   Mon, 28 Aug 2023 17:13:11 -0400
Message-ID: <20230828211424.2964562-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828211424.2964562-1-nfraprado@collabora.com>
References: <20230828211424.2964562-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new flag, '--driver-match', to the dt-extract-compatibles script
that causes it to only print out compatibles that are expected to match
a driver. This output can then be used by tests to detect device probe
failures.

In order to filter the compatibles down to only ones that will match to
a driver, the following is considered:
- A compatible needs to show up in a driver's of_match_table for it to
  be matched to a driver
- Compatibles that are used in both of_match_table and OF_DECLARE type
  macros can't be expected to match to a driver and so are ignored.
  One exception is CLK_OF_DECLARE_DRIVER, since it indicates that a
  driver will also later probe, so compatibles in this macro are not
  ignored.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

(no changes since v2)

Changes in v2:
- Added this commit

 scripts/dtc/dt-extract-compatibles | 57 +++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/scripts/dtc/dt-extract-compatibles b/scripts/dtc/dt-extract-compatibles
index 2b6d228602e8..bd07477dd144 100755
--- a/scripts/dtc/dt-extract-compatibles
+++ b/scripts/dtc/dt-extract-compatibles
@@ -7,11 +7,15 @@ import re
 import argparse
 
 
-def parse_of_declare_macros(data):
+def parse_of_declare_macros(data, include_driver_macros=True):
 	""" Find all compatible strings in OF_DECLARE() style macros """
 	compat_list = []
 	# CPU_METHOD_OF_DECLARE does not have a compatible string
-	for m in re.finditer(r'(?<!CPU_METHOD_)(IRQCHIP|OF)_(DECLARE|MATCH)(_DRIVER)?\(.*?\)', data):
+	if include_driver_macros:
+		re_macros = r'(?<!CPU_METHOD_)(IRQCHIP|OF)_(DECLARE|MATCH)(_DRIVER)?\(.*?\)'
+	else:
+		re_macros = r'(?<!CPU_METHOD_)(IRQCHIP|OF)_(DECLARE|MATCH)\(.*?\)'
+	for m in re.finditer(re_macros, data):
 		try:
 			compat = re.search(r'"(.*?)"', m[0])[1]
 		except:
@@ -22,24 +26,52 @@ def parse_of_declare_macros(data):
 	return compat_list
 
 
-def parse_of_device_id(data):
+def parse_of_device_id(data, match_table_list=None):
 	""" Find all compatible strings in of_device_id structs """
 	compat_list = []
-	for m in re.finditer(r'of_device_id(\s+\S+)?\s+\S+\[\](\s+\S+)?\s*=\s*({.*?);', data):
-		compat_list += re.findall(r'\.compatible\s+=\s+"(\S+)"', m[3])
+	for m in re.finditer(r'of_device_id(\s+\S+)?\s+(\S+)\[\](\s+\S+)?\s*=\s*({.*?);', data):
+		if match_table_list is not None and m[2] not in match_table_list:
+			continue
+		compat_list += re.findall(r'\.compatible\s+=\s+"(\S+)"', m[4])
 
 	return compat_list
 
 
-def parse_compatibles(file):
+def parse_of_match_table(data):
+	""" Find all driver's of_match_table """
+	match_table_list = []
+	for m in re.finditer(r'\.of_match_table\s+=\s+(of_match_ptr\()?([a-zA-Z0-9_-]+)', data):
+		match_table_list.append(m[2])
+
+	return match_table_list
+
+
+def parse_compatibles(file, compat_ignore_list):
 	with open(file, 'r', encoding='utf-8') as f:
 		data = f.read().replace('\n', '')
 
-	compat_list = parse_of_declare_macros(data)
-	compat_list += parse_of_device_id(data)
+	if compat_ignore_list is not None:
+		# For a compatible in the DT to be matched to a driver it needs to show
+		# up in a driver's of_match_table
+		match_table_list = parse_of_match_table(data)
+		compat_list = parse_of_device_id(data, match_table_list)
+
+		compat_list = [compat for compat in compat_list if compat not in compat_ignore_list]
+	else:
+		compat_list = parse_of_declare_macros(data)
+		compat_list += parse_of_device_id(data)
 
 	return compat_list
 
+def parse_compatibles_to_ignore(file):
+	with open(file, 'r', encoding='utf-8') as f:
+		data = f.read().replace('\n', '')
+
+	# Compatibles that show up in OF_DECLARE macros can't be expected to
+	# match a driver, except for the _DRIVER ones.
+	return parse_of_declare_macros(data, include_driver_macros=False)
+
+
 def print_compat(filename, compatibles):
 	if not compatibles:
 		return
@@ -63,10 +95,17 @@ if __name__ == "__main__":
 	ap = argparse.ArgumentParser()
 	ap.add_argument("cfile", type=str, nargs='*', help="C source files or directories to parse")
 	ap.add_argument('-H', '--with-filename', help="Print filename with compatibles", action="store_true")
+	ap.add_argument('-d', '--driver-match', help="Only print compatibles that should match to a driver", action="store_true")
 	args = ap.parse_args()
 
 	show_filename = args.with_filename
+	compat_ignore_list = None
+
+	if args.driver_match:
+		compat_ignore_list = []
+		for f in files_to_parse(args.cfile):
+			compat_ignore_list.extend(parse_compatibles_to_ignore(f))
 
 	for f in files_to_parse(args.cfile):
-		compat_list = parse_compatibles(f)
+		compat_list = parse_compatibles(f, compat_ignore_list)
 		print_compat(f, compat_list)
-- 
2.42.0

