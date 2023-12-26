Return-Path: <linux-kernel+bounces-11488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AF281E71F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 12:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED97F1C21D08
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 11:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C571B4E1D3;
	Tue, 26 Dec 2023 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="YjXj42CU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FCD4E1C9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1703590480;
	bh=IjVldST9wmzuoDkc/uKjDTattvtdRDpSrjV+wFQaAqk=;
	h=From:Date:Subject:To:Cc:From;
	b=YjXj42CU7AqY6+JqV96Avn2c/wZTiJv+xwQyQMA8X/k8EsPgMsXPufzGWYltxS/VG
	 qgEddtuin0uFw+evNtw/PjGi8bJKVrIE6EXEZe/i6y59/Z5lHlcXpensyQz8vUF82H
	 BFQ76elUq8vuEy85lRwYtihCIS4k1WbvXdcszQjw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 26 Dec 2023 12:34:38 +0100
Subject: [PATCH v2] scripts: check-sysctl-docs: adapt to new API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231226-sysctl-check-v2-1-2d4f50b30d34@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAE26imUC/3XMQQ6CMBCF4auQWVvTjoDgynsYFqQd7URTTKeih
 PTuVvYu/5e8bwWhyCRwqlaINLPwFErgrgLrx3Ajxa40oMaDQdRKFrHpoawne1ddp7FtjOvrxkG
 5PCNd+bNxl6G0Z0lTXDZ9Nr/1DzQbZVSN2pKrx7Z3x/ObWESsf/l9oARDzvkLnt5s3a0AAAA=
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703590479; l=4093;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=IjVldST9wmzuoDkc/uKjDTattvtdRDpSrjV+wFQaAqk=;
 b=X6yO+bhslli+/1O/kJu+ygceT5rJuVd4SiNTOUoL2C1Npi6eudaDZNFo2tjZtFuv99q4gicRQ
 DglDOwTGYbuCo0cJMZHM282Fm6AvY1gc5KQp9XE4hYGknIEXkn8WHqT
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The script expects the old sysctl_register_paths() API which was removed
some time ago. Adapt it to work with the new
sysctl_register()/sysctl_register_sz()/sysctl_register_init() APIs.

In its reference invocation the script won't be able to parse the tables
from ipc/ipc_sysctl.c as they are using dynamically built tables which
are to complex to parse.

Note that the script is already prepared for a potential constification
of the ctl_table structs.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Remove unused global variable "paths"
- Remove docs for deleted variables "children" and "paths"
- Link to v1: https://lore.kernel.org/r/20231220-sysctl-check-v1-1-420ced4a69d7@weissschuh.net
---
 scripts/check-sysctl-docs | 45 ++++++++++++---------------------------------
 1 file changed, 12 insertions(+), 33 deletions(-)

diff --git a/scripts/check-sysctl-docs b/scripts/check-sysctl-docs
index 4f163e0bf6a4..739afd766708 100755
--- a/scripts/check-sysctl-docs
+++ b/scripts/check-sysctl-docs
@@ -8,7 +8,7 @@
 # Example invocation:
 #	scripts/check-sysctl-docs -vtable="kernel" \
 #		Documentation/admin-guide/sysctl/kernel.rst \
-#		$(git grep -l register_sysctl_)
+#		$(git grep -l register_sysctl)
 #
 # Specify -vdebug=1 to see debugging information
 
@@ -20,14 +20,10 @@ BEGIN {
 }
 
 # The following globals are used:
-# children: maps ctl_table names and procnames to child ctl_table names
 # documented: maps documented entries (each key is an entry)
 # entries: maps ctl_table names and procnames to counts (so
 #          enumerating the subkeys for a given ctl_table lists its
 #          procnames)
-# files: maps procnames to source file names
-# paths: maps ctl_path names to paths
-# curpath: the name of the current ctl_path struct
 # curtable: the name of the current ctl_table struct
 # curentry: the name of the current proc entry (procname when parsing
 #           a ctl_table, constructed path when parsing a ctl_path)
@@ -94,44 +90,23 @@ FNR == NR {
 
 # Stage 2: process each file and find all sysctl tables
 BEGINFILE {
-    delete children
     delete entries
-    delete paths
-    curpath = ""
     curtable = ""
     curentry = ""
     if (debug) print "Processing file " FILENAME
 }
 
-/^static struct ctl_path/ {
-    match($0, /static struct ctl_path ([^][]+)/, tables)
-    curpath = tables[1]
-    if (debug) print "Processing path " curpath
-}
-
-/^static struct ctl_table/ {
-    match($0, /static struct ctl_table ([^][]+)/, tables)
-    curtable = tables[1]
+/^static( const)? struct ctl_table/ {
+    match($0, /static( const)? struct ctl_table ([^][]+)/, tables)
+    curtable = tables[2]
     if (debug) print "Processing table " curtable
 }
 
 /^};$/ {
-    curpath = ""
     curtable = ""
     curentry = ""
 }
 
-curpath && /\.procname[\t ]*=[\t ]*".+"/ {
-    match($0, /.procname[\t ]*=[\t ]*"([^"]+)"/, names)
-    if (curentry) {
-	curentry = curentry "/" names[1]
-    } else {
-	curentry = names[1]
-    }
-    if (debug) print "Setting path " curpath " to " curentry
-    paths[curpath] = curentry
-}
-
 curtable && /\.procname[\t ]*=[\t ]*".+"/ {
     match($0, /.procname[\t ]*=[\t ]*"([^"]+)"/, names)
     curentry = names[1]
@@ -140,10 +115,14 @@ curtable && /\.procname[\t ]*=[\t ]*".+"/ {
     file[curentry] = FILENAME
 }
 
-/\.child[\t ]*=/ {
-    child = trimpunct($NF)
-    if (debug) print "Linking child " child " to table " curtable " entry " curentry
-    children[curtable][curentry] = child
+/register_sysctl.*/ {
+    match($0, /register_sysctl(|_init|_sz)\("([^"]+)" *, *([^,)]+)/, tables)
+    if (debug) print "Registering table " tables[3] " at " tables[2]
+    if (tables[2] == table) {
+        for (entry in entries[tables[3]]) {
+            printentry(entry)
+        }
+    }
 }
 
 END {

---
base-commit: de2ee5e9405e12600c81e39837362800cee433a2
change-id: 20231220-sysctl-check-8802651d945d

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


