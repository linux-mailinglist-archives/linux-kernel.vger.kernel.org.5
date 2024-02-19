Return-Path: <linux-kernel+bounces-71964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DFF85AD22
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05DDA2820DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6075A535C6;
	Mon, 19 Feb 2024 20:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZxL5maTc"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339CF524BC
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708374445; cv=none; b=IOokB9Rio2sGD/S2cm4kksz2ryidbWK5LpADMswTokgS+ld3mNeyUHSwzgQV7tDzKCwApxd/7vlokkTcz1LrdCmfNeORiZCkreGIRiRGytiOtpPnJgo34tUftLV8jnxZBOW90kYTz4H26ydExY0PO9wIt6hWbfAN2FbbAVH0Aos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708374445; c=relaxed/simple;
	bh=uNI9A4+TJF5i7pPxyp9+QkZo2T/8fL0GY2fuRb0TubU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ldnkmC9S1gaEKg8hFZ/zz5WjZ0QLb2FZVwMZa2VQn40xW9bIA5Z7/Jz9YyxpUyhloXbmEEnqh+AvetfM0Ul7q/dYylCfOw7CxD+kwkKCV0bAOyFZNkYJn3E6SrGQxZuiHOIB86YwrOz1IQngTpOGaOzE7opV8xmfSXodt/iL+Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZxL5maTc; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1708373975;
	bh=uNI9A4+TJF5i7pPxyp9+QkZo2T/8fL0GY2fuRb0TubU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZxL5maTcxrrgWQKt1rczLFI4gK0avOX0UAcNV9L3twfJBzn/+9imqIwY0+ISrOr2S
	 6B3rVjOlXlH5TOJTv+RvzEhXzqwTPjKjXodVctaHHCvRDOR5aT3Nde0FNpuq1AM+RF
	 /lu2zJl9hzTDIAQcp5dw1DEH1uYQ4E7yUfJaxaOM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 19 Feb 2024 21:19:22 +0100
Subject: [PATCH v3 1/3] scripts: check-sysctl-docs: adapt to new API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240219-sysctl-check-v3-1-6940d5ff747b@weissschuh.net>
References: <20240219-sysctl-check-v3-0-6940d5ff747b@weissschuh.net>
In-Reply-To: <20240219-sysctl-check-v3-0-6940d5ff747b@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708373973; l=3441;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=uNI9A4+TJF5i7pPxyp9+QkZo2T/8fL0GY2fuRb0TubU=;
 b=pkAhhEiUYGBNfr4QbfStCKcV4IhzZw3S2XloiuS1+C2X6eMcatL3JlLcIk2uEmexPuzowZYDt
 LE0H4okIbr3Be3L+JSgBFjgZCW0myUgHP85ppoob5ZqgTxhjixRDvBp
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The script expects the old sysctl_register_paths() API which was removed
some time ago. Adapt it to work with the new
sysctl_register()/sysctl_register_sz()/sysctl_register_init() APIs.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
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

-- 
2.43.2


